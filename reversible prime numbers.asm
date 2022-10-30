.data
	#newline
	newline: .asciiz "\n"
.text
	#main function
	main:
		#int count = 0;
		addi $t0, $zero, 0
		#int x = 0;
		addi $t1, $zero, 0
		while:
			#while(count < 10)
			beq  $t0, 10, exit
			#print if not a palindrome
			jal notpalindrome
				print:
				#if it is the square of a prime
				jal sqrt
					jal Isprime
						#print if reverse is the square of a prime
						jal revissqrofaprime
							pt:
							li $v0, 1
							move $a0, $t1
							syscall
							#print a newline
							li $v0, 4
							la $a0, newline
							syscall
							#count++ if and only if criteria is met
							addi $t0, $t0, 1
			inc:
			#x++ chech the next number
			addi $t1, $t1, 1
			# back to while if count is != 10
			j while
		#end of while loop	
		exit:
		li $v0, 10
		syscall 
	#end of main function		
	li $v0, 10
	syscall
	# prime	
	Isprime:
		#int i = 2
		add $t4, $zero,2
		#move num to t3
		add $t3, $zero,$v1
		#if num = 0 => jump to inc
		beq $t3, $zero,inc
		#if num = 1 => jump to inc
		beq $t3, 1,inc
		#if num = 2 => prime
		beq $t3, 2,isaprime
		
		Loop:
			#if num = 2 => isaprime
			beq $t3, $t4,isaprime
			#num/2
			div $t3, $t4
			#store remainder in rem
			mfhi $t5
			#if rem = 0 jump to num++
			beq $t5, 0, inc
			#i++
			add $t4, $t4, 1
			b Loop
		
		isaprime:
			add $v1, $zero, $t3
			jr $ra
			
	#reverse function		
	rev:
		#rev = 0
		addi $a2, $zero, 0
		#store input to $11
		addi $11,$v1,0
		#int i = 10
		addi $12, $zero, 10
		beqz $11, inc
		revLoop:
			divu  $11, $12 #num/10
			mflo $11 #quotient
			mfhi $13 #remainder
			mul $a2, $a2, $12 #rev = rev*10
			addu $a2, $a2, $13#rev = rev+rem
			bgtz $11, revLoop
		#end of reverse fcn		
		revexit:
			move $v1, $a2
			jr $ra
	notpalindrome:
		#move num to $a1
		add $v1, $t1, $zero
		#reverses num
		jal rev
			#if rev != num => nonpalindrome
			bne $t1, $v1,nonpalindrome
			#if rev == num => palindrome
			beq $t1, $v1,inc
	nonpalindrome:
		add $v1, $zero, $t1
		#if not a palindrome back to print
		b print
	#square root function
	sqrt:
	move $20, $zero	
	move $a0, $v1		#Move variables to t registers
	move $21, $a0
	
	addi $22, $zero, 1		#Set $22 to 1
	sll $22, $22, 30		#Bit Shift $22 left by 30
	
	#For loop
	loop1:
		slt $t2, $21, $22
		beq $t2, $zero, loop2	
		nop
		
		srl $22, $22, 2			#Shift $22 right by 2
		j loop1
		
	loop2:
		beq $22, $zero, return	
		nop
		
		add $t3, $20, $22		#if $22 != zero add t0 and t4 into t3
		slt $t2, $21, $t3		
		beq $t2, $zero, else1	
		nop
		
		srl $20, $20, 1			#shift $20 right by 1
		j loopEnd
		
	else1:
		sub $21, $21, $t3		#Decrement $21 by $t3
		srl $20, $20, 1			#Shift $20 right by 1
		add $20, $20, $22		#then add $22 to that
		
	loopEnd:
		srl $22, $22, 2			#shift $22 to the right
		j loop2
		
	return:
		mult $20, $20
		mflo $t8
		beq $t8, $a0, out
		bne $t8, $a0, inc
		out:
			move $v1, $20
			jr $ra
			
	#sqrofaprime fcn
	sqrofaprime:
		add $v1, $zero, $t1
		jal sqrt
		jal Isprime
		jr $ra		
  	#revissqrofaprime fcn
  	revissqrofaprime:
  		#move $t1 to $v1 
  		add $v1, $zero, $t1
  		#reverse v1
  		jal rev
  		#squareroot of the reverse
  		jal sqrt
  		#check if the reverse is a prime numer
  		jal Isprime
  		#print the result
  		b pt
