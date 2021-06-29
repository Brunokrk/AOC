.text
	.globl main
main:
	li $v0, 5
	syscall
	
	#por algum motivo ta dando problema com entrada 0
	add $s5, $zero, $v0
	ori $s0, $zero, 0 # int a = 0
	ori $s1, $zero, 1 # int b = 1
	ori $t0, $zero, 0 # int cont = 0
	
loop:	
	add $s3, $s1, $s0 # aux = a + b
	add $s0, $zero, $s1 # a = b
	add $s1, $zero, $s3 # b = aux
	addi $t0, $t0, 1 # i++
	beq $t0, $s5, end # if i==n end
	j loop

end:
	
	li $v0, 1 
	add $a0, $zero, $s3 
	syscall
	
	li $v0, 10
	syscall
