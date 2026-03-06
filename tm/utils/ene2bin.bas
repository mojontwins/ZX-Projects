' Enems to bin
#include "file.bi"
#include once "crt.bi"


Sub usage	
	Print "usage"
	Print ""
	Print "$ ene2bin enems.ene enems.bin hotspots.bin [byte_values] [life] [yx] [2bytes]"
	Print ""
	Print "where:"
	Print "   * enems.ene enems/hotspots directly from `ponedor.exe"
	Print "   * enems.bin output binary file"
	Print "   * hotspots.bin output binary file"
	Print "   * byte_values to use 8 bit coordinates"
	Print "   * life to add a byte to store life gauge as per enemy"
	Print "   * YX uses (y << 4 | x) rather than (x << 4 | y) for hotspots"
	Print "   * 2bytes if the .ene is in the old '2 byte per hotspot' format"
	Print
	Print "enems.bin    chunks - x y x1 y1 x2 y2 mx my t [life]"
	Print "hotspots.bin chunks - xy|yx t a"
	Print 
	Print "Copyleft 2011, 2019 by The Mojon Twins"
End Sub

Type EnemyIn
	t As uByte
	x As uByte
	y As uByte
	xx As uByte
	yy As uByte
	n As uByte
	s1 As uByte
	s2 As uByte
End Type

Function inCommand (a As String) As Integer
	Dim As Integer i
	i = 1
	While (Command (i) <> "")
		If Command (i) = a Then Return -1
		i = i + 1
	Wend
	Return 0
End Function

Dim As Byte flag, is_packed
Dim As integer i, j, x, y, xx, yy, f, fout, idx, byteswritten, totalsize
Dim As uByte d, life, numlocks, nEnems
Dim As Byte sd
Dim As integer map_w, map_h, tile_lock, max
Dim As String dummy
Dim As EnemyIn e
Dim As Integer optionByteValues, optionLife, optionYX, fIn, legacy

Print "ene2bin v1.0 20191113 ~ ";

' DO

If Len (Command (3)) = 0 Then usage: End

optionByteValues = inCommand ("byte_values")
optionLife = inCommand ("life")
optionYX = inCommand ("yx")
legacy = inCommand ("2bytes")

'' ********************
'' ** ENEMS/HOTSPOTS **
'' ********************

fout = FreeFile
Open Command (2) for Binary as #fout

byteswritten = 0
Print " reading header ~ ";
f = freefile
Open Command (1) For Binary as #f
If Lof (f) = 0 Then 
	Close #f
	Kill Command (1)
	Print "File " & command (1) & " does not exist."
	End
End If

' Skip header
dummy = Input (256, f)
Get #f, , d: map_w = d
Get #f, , d: map_h = d
Get #f, , d: Get #f, , d
Get #f, , d: nEnems = d
' Read enems
max = map_w * map_h * nEnems
Print " enems: " & max & " ~ ";
For idx = 1 To max
	' Read
	Get #f, , e.t
	Get #f, , e.x
	Get #f, , e.y
	Get #f, , e.xx
	Get #f, , e.yy
	Get #f, , e.n
	Get #f, , e.s1
	Get #f, , e.s2
	
	' Write		
	' int16 x, y; lsb msb
	If optionByteValues Then
		d = 16 * e.x: Put #fOut, , d
		d = 16 * e.y: Put #fOut, , d
		byteswritten = byteswritten + 2
	Else
		x = e.x * 16
		d = x And &hff: Put #fout, , d
		d = (x Shr 8) And &hff: Put #fout, , d
		
		y = e.y * 16
		d = y And &hff: Put #fout, , d
		d = (y Shr 8) And &hff: Put #fout, , d
		byteswritten = byteswritten + 4
	End If
	
	' ubyte x1, y1, x2, y2
	d = 16 * e.x: Put #fout, , d
	d = 16 * e.y: Put #fout, , d
	d = 16 * e.xx: Put #fout, , d
	d = 16 * e.yy: Put #fout, , d
	
	' ubyte mx, my
	sd = e.n * sgn (e.xx - e.x): Put #fout, , sd
	sd = e.n * sgn (e.yy - e.y): Put #fout, , sd
	
	' ubyte t
	d = e.t: Put #fout, , d
	byteswritten = byteswritten + 7
	
	' ubyte life
	If optionLife Then
		d = life: Put #fout, , d
		byteswritten = byteswritten + 1
	End If		
Next idx
Print " " & byteswritten & " bytes ~ ";
totalsize = totalsize + byteswritten
byteswritten = 0
Close #fout
fout = FreeFile
Open Command (3) for Binary as #fout

max = map_w * map_h
Print " hotspots: " & max & " ~ ";
For idx = 1 To max
	' Read
	If legacy Then
		Get #f, , e.x
		
		' Write
		' unsigned char xy
		If optionYX Then
			x = e.x Shr 4
			y = e.x And 15
			d = x Or (y Shl 4): put #fout, , d
		Else
			d = e.x: put #fout, , d
		End If
	Else
		Get #f, , e.x 
		Get #f, , e.y 
		
		' Write
		' unsigned char xy
		If optionYX Then
			d = e.x Or (e.y Shl 4): put #fout, , d
		Else
			d = e.y Or (e.x Shl 4): put #fout, , d
		End If
	End If

	Get #f, , e. t

	' unsigned char t
	d = e.t: put #fout, , d
	' unsigned char act
	d = 1: put #fout, , d
	
	byteswritten = byteswritten + 3
Next idx
Close #f
Print " " & byteswritten & " bytes ~ ";
Print "DONE"
