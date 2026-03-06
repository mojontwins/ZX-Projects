Dim As String manoli
Dim As Integer a

manoli = "Esta %%%es%%% mi cadena preferida"
a = Instr (manoli, "%%%")
Print Instr (a+3, manoli, "%%%")
