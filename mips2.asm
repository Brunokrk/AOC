	.text
	.globl main
#exercício 1B slide 30
#carregar 987342343 para $t0 sem usar li
#987342343 --> 0x 3AD9 A607
main:
	lui $t0, 0x3AD9
	ori $t0, $t0, 0xA607