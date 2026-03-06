' Keygen!

Dim As Integer world
Dim As Integer level
Dim As Integer score
Dim As Integer energy
DIm as integer i

Dim As Integer password (10)

score = 0
energy = 200

Print "Maritrini Keygen!"
Print "World";
input world
Print "Level";
input level

password (0) = (score And 255)
password (1) = ((score Shr 16) And 255)

password (2) = ((score Shr 24) And 255)
password (3) = world + level

password (4) = (energy Shr 8) And 255
password (5) = 69 + level

password (6) = (energy And 255)
password (7) = (score Shr 8) And 255

password (8) = (level + password (4) + password (0) + world) And 255
password (9) = (password (6) + password (7) + password (2) + level) And 255

for i = 0 to 9
	print hex (password(i), 2);
	if (i and 1) = 1 Then
		print " ";
	End If

next i
print