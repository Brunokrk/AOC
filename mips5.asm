	.data
vector:
	.word 0 #vet[0]
	.word 3
	.word 5
	.word 10 #vet[3]
	
	.text
	.globl main
#exercício 4 slide 30 - aula 7
main:
	#li $t0, 0x100080AA
	la $t0, vector
	
	lw $t1, 4($t0)
	
	lw $t2, 8($t0)
	add $t1, $t1, $t2 #$t1 = vet[1] + vet[2]
	
	lw $t2, 12($t0)
	add $t1, $t1, $t2 #$t1 += vet[3]
	
	addi $t1, $t1, 65
	
	sw $t1, 28($t0)	
