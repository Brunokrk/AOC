	.data
n: .asciiz "n: "
temos: .asciiz "Temos "   " digitos sem 1 ’s consecutivos \n "
binarios_com: .asciiz " binarios com"
fim_str: .asciiz " digitos sem 1 ’s consecutivos \n "

	.text
	
	#Equipe: Bruno Marchi Pires
	
	.globl main
main:
	li $v0, 4
	la $a0, n
	syscall

	ori $v0, $zero, 5
	syscall
	
	ori $a0, $v0, 0 # n = %v0 -> argumento para função
	
	li $a1, 0  # a1 = 0 -> argumento para função (ultimo_digito)
	
	jal contar
	
	#ajudar no print
 	move $t0, $v0 #x = ...
 	move $t1, $a0  
 	
 	la $a0, temos
	li $v0, 4 #syscall para imprimir string
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	la $a0, binarios_com
	li $v0, 4 #syscall para imprimir string
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	la $a0, fim_str
	li $v0, 4 #syscall para imprimir string
	syscall
	
	j end

contar:	
	beq $a0, 0, if_linha_cinco  #if (n==0)
	
	beq $a0, 1, if_linha_oito #if (n==1)
	
	#salvando contexto
	addi $sp, $sp, -12
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	
	beq $a1, 0, if_linha_quinze #if (ultimo_digito == 0)
	
	addi $a0, $a0, -1 #n-1
	ori $a1, $zero, 0 #ultimo_digito = 0
	jal contar
	
	
	#restaurando
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	
	jr $ra
	
if_linha_cinco:
	#return 0
	ori $v0, $zero, 0
	jr $ra

if_linha_oito:
	beq $a1, 0, if_linha_nove
	#else
		#return 1
	ori $v0, $zero, 1
	jr $ra
	
if_linha_nove:
	#return 2
	ori $v0, $zero, 2
	jr $ra

if_linha_quinze:
	addi $a0, $a0, -1 #n-1
	
	#Aqui teriamos duas chamadas recursivas com (n-1), porém não estamos conseguindo fazer ambas começando no
	#mesmo valor, visto que após uma terminar, não conseguimos voltar o valor inicial de n
	
	jal contar #contar(n-1, 0)
	move $s0, $v0 #move para s0 o resultado da chamada "contar(n-1, 0)"
	
	ori $a1, $zero, 1 #ultimo_digito = 1
	jal contar #contar(n-1, 1)
	move $s1, $v0 #move para s1 o resultado da chamada "contar(n-1, 1)"
	
	add $v0, $s0, $s1 #contar(n-1, 0) + contar(n-1, 1)
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

end:
	li $v0, 10
	syscall