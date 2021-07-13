	.data 
	input_text:		.asciiz "\nInsira um valor de n (-1 para sair): "
	 
	.text
	#Bruno Pires
	#.Faça um programa que solicita continuamente valores inteiros ao usuário. O
	#programa termina quando o usuário digita -1. Ao final o programa deve exibir a soma
	#e a média dos valores digitados.
	.globl main
main:
	li $s0, -1
loop:
	li $v0, 4
	la $a0, input_text
	syscall
	
	li $v0, 5
	syscall 
	move $t1, $v0
	
	beq $t1, $s0, print_end #verificando se n == -1	
	j loop
	
print_end:
	li $v0, 10
	syscall