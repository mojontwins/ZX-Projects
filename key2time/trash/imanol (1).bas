' Imanol v0.1 [MK2 0.90+]
' Copyleft 2015 by The Mojon Twins

' Compile with fbc imanol.bas cmdlineparser.bas

#include "cmdlineparser.bi"

Sub usage
	Print "usage:"
	Print 
	Print "$ imanol.exe in=infile.txt out=outfile.txt key=value ... "
	Print
	Print "Parameters to imanol.exe are specified as key=value, where keys are "
	Print "as follow:"
	Print ""
	Print "in             Input filename with %%%find%%% parameters."
	Print "out            Output filename."
	Print "key            %%%find%%% parameter to search for and be replaced by value"
	Print ""
	Print "If key starts with '?', the actual text which is written is the length of"
	Print "the file name specified after '?'. If after the filename you include +NNN,"
	Print "NNN will be added..."
	Print 
	Print "If you don't know what's this for, you don't need it."
End Sub

Function myFileLen (fileName As String) As Integer
	Dim As Integer fTemp, length
	fTemp = FreeFile
	Open fileName For Binary As fTemp
	length = Lof (fTemp)
	Close fTemp
	myFileLen = length
End Function

' Variables

Dim As Integer fIn, fOut, cpos, from, cto, offset, filel
Dim As String linea
Dim As String leftTrim, rightTrim, find, replace

' GO!

Print "imanol v0.1"
Print "Pattern Find And Replace Preprocessor for MK2 0.90+"
Print ""

' Get command line parameters parsed.
sclpParseAttrs

If sclpGetValue ("in") = "" Or sclpGetValue ("out") = "" Then
	usage
	End
End If

Print "Reading " & sclpGetValue ("in")
Print "Writing " & sclpGetValue ("out")

fIn = FreeFile
Open sclpGetValue ("in") For Input As #fIn
fOut = FreeFile
Open sclpGetValue ("out") For Output As #fOut

While Not Eof (fIn)
	Line Input #fIn, linea

	' Find pattern
	cpos = 1
	
	While cpos > 0
		from = Instr (cpos, linea, "%%%")
		If from = 0 Then Exit While
		
		cto = Instr (from + 3, linea, "%%%")
		If cto = 0 Then Exit While
		
		If from > 1 Then
			leftTrim = left (linea, from - 1)
		Else
			leftTrim = ""
		End If
		
		If Len (linea) >= cto + 3 Then
			rightTrim = right (linea, len (linea) - cto - 2)
		Else
			rightTrim = ""
		End If
		
		find = Mid (Linea, from + 3, cto - from - 3)
		
		Print "    Found %%% pattern " & find
		
		replace = sclpGetValue (find)
		If replace = "" Then
			Print "    Replacing for nothing, undefined!"
		Else
			If Left (replace, 1) = "?" Then
				replace = Right (replace, Len (replace) - 1)
				If Instr (replace, "+") Then
					offset = val (Right (replace, Len (replace) - Instr (replace, "+")))
					replace = left (replace, Instr (replace, "+") - 1)
				Else
					offset = 0
				End If
				filel = myFileLen (replace)
				Print "    Replacing with length of """ & replace & """ (" & filel & ") offsetting by " & offset & " (" & (filel + offset) & ")."
				replace = Str (filel + offset)				
			Else
				Print "    Replacing with  " & replace
			End If
		End If
		
		linea = leftTrim + replace + rightTrim
		
		cpos = from
	Wend
	
	Print #fOut, linea
Wend

Close fIn, fOut
