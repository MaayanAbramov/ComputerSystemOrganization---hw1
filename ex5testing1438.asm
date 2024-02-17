.global _start

.section .text



_start:
leaq (command), %r8 #r8 = &word[0]

movl $0, %eax #i = 0
movl $0, %r9d #j = 0
Loop1_HW1:
cmpb $0, (%r8, %rax, 1) #while (word[i] == '/0') && (word[i] != '$')
je endOfLoop1_HW1
cmpb $36, (%r8, %rax, 1)
je endOfLoop1_HW1
incl %eax
jmp Loop1_HW1

endOfLoop1_HW1:
cmpb $0, (%r8, %rax, 1) #if (word[i] == '/0') (meaning no $ in command)
je falseCase_HW1
addl $1, %eax #i+=1 to pass the dollar sign ------changed here from 2 to 1
movl $0, %ecx #shifts_of_base = 0
movl $0, %r14d #counter = 0
movl $0, %edx #sum = 0
movl %eax, %edi #k = i
movb $1, %bpl #isFirstTime = true
movl $0, %esi #Type = 0
movl $0, %r13d #mult = 0
movq $0,%r12
Loop_HW1:
cmpb $44, (%r8, %rdi, 1) #while (word[k] != ',')
je contin_HW1
jmp *.L8_HW1(, %rsi, 8)
.L8_HW1:
.quad .L2_HW1
.quad .L3_HW1
.quad .L4_HW1
.quad .L5_HW1
backToLoop_HW1:
incl %edi #k++
#movl %r14d, %r9d #j = counter
#decl %r9d # maybe will do this alot of times, but when it jumps it will be the right value
cmpb $44, (%r8, %rdi, 1)
je contin_HW1
incl %r14d
jmp Loop_HW1
contin_HW1:
cmpl $0, %r14d
je falseCase_HW1
cmpl $3, %r14d #right after the end of Loop_HW1 #if (counter == 0 || counter >3)
jg falseCase_HW1
#movl %r14d, %r9d #j = counter - 1
#decl %r9d #j++
cmpl $0, %esi #if(type == 0) which is hexa
jne type2_HW1
movl $4, %ecx #shifts = 4
jmp LoopX_HW1
type2_HW1:
cmpl $1, %esi #if (type == 1) which is binary
jne type3_HW1
movl $1, %ecx #shifts = 1
jmp LoopX_HW1
type3_HW1:
cmpl $2, %esi #if (type == 3) which is octal
jne type4_HW1
movl $3, %ecx
jmp LoopX_HW1
type4_HW1: #Must be type 3 decimal
jmp LoopX_HW1

LoopX_HW1:
cmpl %r14d, %r9d #ziv: I think should be -1#for (int j = counter-1 ; j >=0 ; j--)
jge trueCase_HW1
movl %eax, %r11d #r11 = i
addl %r9d, %r11d #r11 = i+j
movb (%r8, %r11, 1), %r12b #r12 = word[i+j]
cmpb $65, %r12b
jge convertingAF_HW1
subb $48, %r12b #r12 = digit //-------shouldnt be b suffix?
jmp continue_calc_HW1
convertingAF_HW1:
subb $55,%r12b
continue_calc_HW1:
cmpl $3, %esi #if (type == 3, meaning decimal)
jne power2_HW1
cmpl $0, %r9d #if (j == 0)
jne j1_HW1
movl %r12d, %r13d #mult = digit
jmp summing_HW1
j1_HW1:
cmpl $1, %r9d #if (j==1)
jne j2_HW1
imull $10, %edx, %edx #mult += 10*digit
movl %r12d, %r13d #mult = digit
jmp summing_HW1
j2_HW1:
cmpl $2, %r9d #if (j == 2)
jne LoopX_HW1
imull $10, %edx, %edx
movl %r12d, %r13d #mult = digit
jmp summing_HW1

power2_HW1:
cmpl $0, %r9d #if (j == 0)
jne jj1_HW1
movl %r12d, %r13d
jmp summing_HW1

jj1_HW1:
cmpl $1, %r9d 
jne jj2_HW1
shll %cl, %edx
movl %r12d, %r13d
jmp summing_HW1

jj2_HW1:
cmpl $2, %r9d
jne LoopX_HW1
 #ebx = 2*numOfShifts #you did nothign here.
#movw %bx,%cx 
shll %cl ,%edx #r12 = r12*2^ebx
movl %r12d, %r13d
jmp summing_HW1


summing_HW1:
addl %r13d, %edx #sum += mult
incl %r9d
jmp LoopX_HW1

.L2_HW1:
cmpb $1, %bpl #if (firstTime == true)
jne L22_HW1
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jne .L3_HW1
cmpb $120, 1(%r8, %rax, 1) #if (Word[i+1] == 'x')
jne .L3_HW1
addl $2, %eax #i+=2
movl %eax, %edi #k = i
incl %r14d #counter++
movl $0, %esi #type = 0, hexa
movb $0, %bpl #isFirstTime = false
L22_HW1: #supposed to get in directly afterwards
cmpb $65, (%r8, %rdi, 1) #if (!((word[k] >= 'A' && word[k] <= 'F') || (word[k] >= '0' && word[k] <= '9')))
jl otherValidCheck_HW1
cmpb $70, (%r8, %rdi, 1)
jg otherValidCheck_HW1
jmp backToLoop_HW1

otherValidCheck_HW1:
cmpb $48, (%r8, %rdi, 1)
jl falseCase_HW1
cmpb $57, (%r8, %rdi, 1)
jg falseCase_HW1
jmp backToLoop_HW1

.L3_HW1:
cmpb $1, %bpl #if (firstTime == true)
jne L33_HW1
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jne L7_HW1
cmpb $98, 1(%r8, %rax, 1) #if (Word[i+1] == 'b')
jne L7_HW1
addl $2, %eax #i+=2
movl %eax, %edi #k = i
incl %r14d #counter++
movl $1, %esi #type = 1, binary
movb $0, %bpl #isFirstTime = false
L33_HW1: #supposed to get in directly afterwards
cmpb $48, (%r8, %rdi, 1) #if ((word[k] == '0' || 1)
jne checkIfOne_HW1
je backToLoop_HW1
checkIfOne_HW1:
cmpb $49, (%r8, %rdi, 1)
jne falseCase_HW1
jmp backToLoop_HW1

L7_HW1:
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0' && word[i+1] == ',')
jne .L4_HW1
cmpb $44, 1(%r8, %rax, 1) #if (word[i] == '0' && word[i+1] == ',')
jne .L4_HW1
movl $0, %edx
jmp trueCase_HW1

.L4_HW1:
cmpb $1, %bpl #if (firstTime == true)
jne L44_HW1
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jne .L5_HW1
cmpb $48, 1(%r8, %rax, 1) #if (Word[i+1] == '0'-'7')
jl falseCase_HW1
cmpb $55, 1(%r8, %rax, 1) 
jg falseCase_HW1
addl $1, %eax #i+=1 
movl %eax, %edi #k = i
incl %r14d #counter++
movl $2, %esi #type = 2, octal
movb $0, %bpl #isFirstTime = false
L44_HW1: #supposed to get in directly afterwards
cmpb $48, (%r8, %rdi, 1) #if (Word[k] == '0'-'7')
jl falseCase_HW1
cmpb $55, (%r8, %rdi, 1) 
jg falseCase_HW1
jmp backToLoop_HW1

.L5_HW1:
cmpb $1, %bpl #if (firstTime == true)
jne L55_HW1
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jl falseCase_HW1
cmpb $57, (%r8, %rax, 1) #if (word[i] == '0')
jg falseCase_HW1
movl %eax, %edi #k = i
incl %r14d #counter++
movl $3, %esi #type = 3, decimal
movb $0, %bpl #isFirstTime = false
L55_HW1: #supposed to get in directly afterwards
cmpb $48, (%r8, %rdi, 1) #if (Word[k+1] == '0'-'9')
jl falseCase_HW1
cmpb $57, (%r8, %rdi, 1) 
jg falseCase_HW1
jmp backToLoop_HW1



falseCase_HW1:
movb $0, (legal)
movl $0, (integer)
jmp finito_HW1

trueCase_HW1:
movb $1, (legal)
movl %edx, (integer)
jmp finito_HW1

finito_HW1:



	
	
