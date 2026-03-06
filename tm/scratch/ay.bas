
Dim sonidos (4, 13) As Byte => {_
	{1,4,0,16,36,67,8,4,31,245,1,6,30,2}, _
    {100,50,0,0,0,0,4,216,31,0,0,10,10,0}, _
    {250,250,0,0,0,0,15,248,31,0,0,10,10,0}, _
    {10,10,0,0,0,0,29,216,31,0,0,4,4,0}, _
    {10,100,0,0,0,0,15,248,31,0,0,50,50,0} _
}
Dim n As Byte

Cls
For n = 0 To 4                          ' Vamos a tocar 4 pitos
    Print "SFX #"; n                    ' Imprimimos cu l
    ayPlaySound (n)                     ' Tocamos el sonido i
    Pause 100                           ' Esperamos dos segundos
Next n

Sub ayPlaySound (sonido As Byte)
    ' Este Sub toca el sonido que se le indica como par metro
    ' Los sonidos se definen en la tabla "sonidos", definida
    ' globalmente.

    Dim i As Byte
   
    For i = 0 To 13
        Out 65533, i                    ' Seleccionamos registro AY
        Out 49149, sonidos (sonido, i)  ' Escribimos un valor en ‚l
    Next i
End Sub

