'' Mapflip.bas
'' Remedio barato para transformar un mapa en otro.

Dim As Byte mapa (63, 39)
Dim As Byte res1 (63, 39)
Dim As Integer f1
Dim As String inputFile
Dim As String outputFile
Dim As Byte d
Dim As Integer x, y, i


Print "In?";
Input inputFile

f1 = FreeFile

Open inputFile For Binary As f1

For y = 39 To 0 Step -1
	For x = 63 To 0 Step -1
		Get #f1, , d
		mapa (x, y) = d
	Next x
Next y

Close f1

Print "Out?";
Input outputFile

f1 = FreeFile

Open outputFile For Binary As f1

For y = 0 To 39
	For x = 0 To 63
		d = mapa (x, y)
		Put #f1, , d
	Next x
Next y

Close f1

Print "Cool!"
