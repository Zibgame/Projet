Function DechiffrerMotDePasse(motDePasseChiffre)
    cleChiffrement = 42
    motDePasse = ""
    For i = 1 To Len(motDePasseChiffre)
        caractereChiffre = Mid(motDePasseChiffre, i, 1)
        caractere = Chr(Asc(caractereChiffre) Xor cleChiffrement)
        motDePasse = motDePasse & caractere
    Next
    DechiffrerMotDePasse = motDePasse
End Function

cheminFichier = "C:\Users\faniz\Downloads\yo\VARTXT\Commande.txt"

Set fso = CreateObject("Scripting.FileSystemObject")

If fso.FileExists(cheminFichier) Then
    Set fichier = fso.OpenTextFile(cheminFichier, 1, False)
    tousLesMotsDePasse = ""
    Do Until fichier.AtEndOfStream
        ligne = fichier.ReadLine
        If InStr(ligne, "Nom de la session:") > 0 Then
            nomSession = Trim(Mid(ligne, InStr(ligne, ":") + 1))
        End If
        If InStr(ligne, "Nom du PC:") > 0 Then
            nomPC = Trim(Mid(ligne, InStr(ligne, ":") + 1))
        End If
        If InStr(ligne, "Mot de passe enregistré:") > 0 Then
            motDePasseChiffre = Trim(Mid(ligne, InStr(ligne, ":") + 1))
            motDePasseDechiffre = DechiffrerMotDePasse(motDePasseChiffre)
            tousLesMotsDePasse = tousLesMotsDePasse & vbCrLf & "Nom de la session: " & nomSession & vbCrLf & "Nom du PC: " & nomPC & vbCrLf & "Mot de passe : " & motDePasseDechiffre & vbCrLf & vbCrLf
        End If
    Loop
    fichier.Close
    WScript.Echo tousLesMotsDePasse
Else
    WScript.Echo "Le fichier n'existe pas."
End If
