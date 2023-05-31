#Lab 2.1

	.data
	
Z:	.word 0

main:
	li x10, 15
	li x11, 10
	li x28, 5
	li x29, 2
	li x30, 18
	li x31, -3
	
	sub x30, x30, x31	# E = E-F first
	sub x11, x10, x11	# B = A-B
	mul x29, x28, x29	# D = C*D
	div x10, x10, x28	# A = A/C
	add x11, x11, x29	# B = B+D
	add x11, x11, x30	# B = B+E
	sub Z, x11, x10		# Z = B-A
