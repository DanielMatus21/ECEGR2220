	.data
Cels:		.float	0
Kelv:		.float 0
factor1:	.float  32
factor2:	.float  5
factor3:	.float  9
factor4:	.float  0
factor5:	.float 273.15
readCels:	.asciz "Celsius temperature: "
readKelv:	.asciz "Kelvin temperature: "
newln:	.asciz	"\r\n"
	.text
main:

    li	a7,6
    ecall
    
    fmv.s	fs4,fa0	
    
    flw  fs5, Cels, s5
    flw  fs6, factor1, s6
    flw  fs7, factor2, s7
    flw  fs8, factor3, s8
    flw  fs9, factor4, s9
    flw fs10, factor5, s10
    flw fs11, Kelv, s11
    
    fdiv.s fs9, fs7, fs8
    fsub.s fs5, fs4, fs6
    fmul.s fs5, fs5, fs9
    fadd.s fs11, fs5, fs10
    
    li	a7,4			
    la	a0,readCels
    ecall
    
    li	a7,2
    fmv.s  fa0, fs5
    ecall

    li  a7,4
    la  a0,newln
    ecall

    li  a7,4
    la  a0,readKelv
    ecall
    
    li  a7,2
    fmv.s  fa0, fs11
    ecall