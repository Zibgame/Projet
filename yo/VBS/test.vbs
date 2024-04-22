Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")

url = "https://example.com/api"
objXMLHTTP.open "GET", url, True

objXMLHTTP.onreadystatechange = GetRef("HandleResponse")

objXMLHTTP.send

Sub HandleResponse
    If objXMLHTTP.readyState = 4 Then
        WScript.Echo "Statut de la requête : " & objXMLHTTP.Status
        WScript.Echo "Réponse : " & objXMLHTTP.responseText
    End If
End Sub

WScript.Sleep 5000
