	.data
n: .asciiz "n: "
	
	.text
	#Bruno Marchi Pires
	.globl main
main:
	li $v0, 4
	la $a0, n
	syscall

	ori $v0, $zero, 5
	syscall
	
	ori $a0, $v0, 0 # a0 = n
	jal soma
	
	ori $a0, $v0, 0
	ori $v0, $zero, 1
	syscall
	j end

end:
	li $v0, 10
	syscall


soma:
	beq $a0, $zero, sum_0 #a0==0
	addi $sp, $sp, -8
	
	sw $a0, 0($sp)
	sw $ra, 4($sp) 
	
	addi $a0, $a0, -1 #n-1
	jal soma

	lw $a0, 0($sp)
	lw $ra, 4($sp)
	
	addi $sp, $sp, 8
	
	add $v0, $a0, $v0 #valor anterior + atual
	jr $ra
	
sum_0:
	ori $v0, $zero, 0
	jr $ra
	
		
		
#int sum(int x) {
#    if (x == 0)
#        return 0;
#    return x + sum(x-1);
#}

#int main() {
#    int a;
#    scanf("%i", &a);
#    a = sum(a);
#    printf("%i\n", a);
#    return 0;
#}