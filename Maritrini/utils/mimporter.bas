'' Mimporter (Maritrini Importer)
'' Imports a 256x64 pixels image in the new dostercios engine format

#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Type ZXCOLOUR
	Dim As uByte c1
	Dim As uByte c2
	Dim As uByte b
End Type

Dim Shared As uByte outputBin (2303)
Dim Shared As Integer binIndex

Sub usage ()
	Print "Usage:"
	Print "$ mimporter.exe file.png file.bin"
End Sub

Sub writeByte (bb As uByte)
	outputBin (binIndex) = bb
	binIndex = binIndex + 1
End Sub

Function speccyColour (colour As Unsigned Long) As uByte
	Dim res as uByte
	If RGBA_R (colour) >= 128 Then 
		res = res Or 2
		If RGBA_R (colour) >= 240 Then
			res = res Or 128
		End If
	End If
	If RGBA_G (colour) >= 128 Then 
		res = res Or 4
		If RGBA_G (colour) >= 240 Then
			res = res Or 128
		End If
	End If
	If RGBA_B (colour) >= 128 Then 
		res = res Or 1
		If RGBA_B (colour) >= 240 Then
			res = res Or 128
		End If
	End If
	speccyColour = res
End Function

Dim As ZXCOLOUR attrMap (255)
Dim As Any Ptr img
Dim As Integer x, y, xx, yy, i, j, c1, c2, c, b, fOut
Dim As uByte d

Print "mimporter v0.1.20200901 ~ ";
If Command (2) = "" Then usage: End

screenres 640, 480, 32, , -1

'' Load image
img = png_load (Command (1))	
	
'' Precalculate attributes
x = 0: y = 0
For i = 0 To 255
	
	' Find ink, paper
	c1 = speccyColour (Point (x, y, img))
	c2 = c1
	For yy = 0 To 7
		For xx = 0 To 7
			c = speccyColour (Point (xx + x, yy + y, img))
			If c <> c1 Then c2 = c
		Next xx
	Next yy
	
	' Detect bright:
	b = 0
	If c1 And 128 Then b = 64: c1 = c1 And 127
	If c2 And 128 Then b = 64: c2 = c2 And 127
	If c1 = c2 Then  
		If c2 < 4 Then
			c1 = 7
		Else 
			c1 = 0
		End If
	End If
	
	' Darker colour = PAPER (c2)
	If c2 > c1 Then Swap c1, c2

	' And store
	attrMap (i).c1 = c1
	attrMap (i).c2 = c2
	attrMap (i).b = b

	outputBin (2048+i) = c1+8*c2+b

	x = x + 8: If x = 256 Then x = 0: y = y + 8
Next i

'' Convert bitmaps

binIndex = 0
For j = 0 To 7
	x = 0: y = j
	For i = 0 To 255
		d = 0
		For xx = 0 To 7
			c = speccyColour (Point (x + xx, y, img)) And 127
			If c = attrMap (i).c1 Then d = d Or (2^(7-xx))
		Next xx
		writeByte d
		x = x + 8: If x = 256 Then x = 0: y = y + 8
	Next i
Next j

'' Write binary
fOut = FreeFile
Open Command (2) For Binary As #fOut
For i = 0 To 2303
	Put #fOut, , outputBin (i)
Next i
Close #fOut

Puts "DONE"
