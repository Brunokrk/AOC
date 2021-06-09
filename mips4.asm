	.text
	.globl main
#exercício 2 slide 30
main:
	li $s0, 1     #a
	li $s1, 20    #b
	li $s2, 300   #c
	li $s3, 5000  #d
	
	add $s4, $s0, $s1 #x = a+b
	add $s4, $s4, $s2 #x+= c
	sub $s4, $s4, $s3 #x-= d
	subi $s4, $s4, 747 #x-=747
	
	