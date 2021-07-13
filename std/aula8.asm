	.text
	.globl main
	
main:
	li $s1, 8
	li $s0, 4
	slt $t0,$s1,$s0 #$t0 recebe 1 se b < a, ou 0 caso contrário
	beq $t0, $zero, b_maior_igual
	addi $s0,$s0,30
b_maior_igual:
	addi $s1,$s1,10	