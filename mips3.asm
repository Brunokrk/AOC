	.text
	.globl main
#exercício 1C slide 30
#carregar -987342343 para $t0 sem usar li
#-987342343 --> 0x C526 59F9

#
main:
	lui $t0, 0xC526
	ori $t0, $t0, 0x59F9