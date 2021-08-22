	.data
n: .asciiz "n: "
temos: .asciiz "Temos "   " digitos sem 1 ’s consecutivos \n "
binarios_com: .asciiz " binarios com"
fim_str: .asciiz " digitos sem 1 ’s consecutivos \n "

	.text
	
	#Aluno: Bruno Marchi Pires
	
	.globl main
main:
	li $v0, 4
	la $a0, n
	syscall

	ori $v0, $zero, 5
	syscall
	
	ori $a0, $v0, 0 # n = $v0 -> argumento para função
	li $a1, 0  # a1 = 0 -> argumento para função (ultimo_digito)
	ori $a2, $v0, 0 #não existe no cod C, mas necessário para ajudar na recursão, inicialmente $a0 == $a2
	
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
	addi $sp, $sp, -16
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a3, 8($sp)
	sw $ra, 12($sp)
	
	beq $a1, 0, if_linha_quinze #if (ultimo_digito == 0)
	
	addi $a0, $a0, -1 #n-1
	ori $a1, $zero, 0 #ultimo_digito = 0
	jal contar
	
	
	#restaurando
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a3, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
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
	jal contar #contar(n-1, 0)
	move $s0, $v0 #move para s0 o resultado da chamada "contar(n-1, 0)"
	
	ori $a1, $zero, 1 #ultimo_digito = 1
	addi $a2, $a2, -1
	move $a0, $a2
	jal contar #contar(n-1, 1)
	move $s1, $v0 #move para s1 o resultado da chamada "contar(n-1, 1)"
	
	add $v0, $s0, $s1 #contar(n-1, 0) + contar(n-1, 1)
	
	#restaurando
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a3, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra

end:
	li $v0, 10
	syscall

#Observações Gerais: O argumento A3, existe apenas para auxiliar quando entramos no if_linha_quinze
#servindo como uma "ancora" para o valor inicial de a0 (o valor que entra no if).
#Essa ancora é necessária dentro da lógica desenvolvida, pois a cada iteração decrementamos o valor de a0 em 1, e possuímos duas
#chamadas recursivas, que devem iniciar com o mesmo valor de a0. então quando partimos para a segunda chamada recursiva, transferimos o valor da
#ancora para a0, restaurando assim seu valor inicial. Dessa forma eu consegui chegar mais próximo do resultado esperado. 
