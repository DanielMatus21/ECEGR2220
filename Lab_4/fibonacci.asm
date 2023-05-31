	.data
A:	.word 3
B:	.word 10
C:	.word 20
temp:	.word 0
	.text
main:
	lw s4, A
	lw s5, B
	lw s6, C
	lw s7, temp
Fibonacci:
	


Exit:

	li	a7,1
	mv	a0, s7
	ecall
	li  a7,10 
	ecall