#Lab 2.2

	.data
	
A:	.word 10
B:	.word 15
C:	.word 6
Z:	.word 0

main:
	li x28, 1
	li x29, 2
	li x30, 3
	li Z, 3
	
	slt x10, B, A
	addi C, C, 1
	addi C, C, -7
	sltz x11, C
	or x12, x10, x11
	beq x12, x28, setz2
	
	slt x10, B, A
	slti x11, C, 5
	beq x10, x11, setz1

	li Z, 0
	beq Z, x28, setzn1
	beq Z, x29, setzn2
	beq Z, x30, setzn3
	
setz1:
	li Z, 1
	jalr zero, ra, 0x0

setz2: 	
	li Z, 2
	jalr zero, ra, 0x0

setzn1:
	li Z, -1
	jalr zero, ra, 0x0

setzn2: 	
	li Z, -2
	jalr zero, ra, 0x0
	
setzn3:
	li Z, -3
	jalr zero, ra, 0x0

setz0: 	
	li Z, 0
	jalr zero, ra, 0x0
