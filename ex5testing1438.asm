.global _start

.section .text



_start:
leaq (command), %r8 #r8 = &word[0]

movl $0, %eax #i = 0
movl $0, %r9d #j = 0
Loop1:
cmpb $0, (%r8, %rax, 1) #while (word[i] == '/0') && (word[i] != '$')
je endOfLoop1
cmpb $36, (%r8, %rax, 1)
je endOfLoop1
incl %eax
jmp Loop1

endOfLoop1:
cmpb $0, (%r8, %rax, 1) #if (word[i] == '/0') (meaning no $ in command)
je falseCase
addl $1, %eax #i+=1 to pass the dollar sign ------changed here from 2 to 1
movl $0, %ecx #shifts_of_base = 0
movl $0, %r14d #counter = 0
movl $0, %edx #sum = 0
movl %eax, %edi #k = i
movb $1, %bpl #isFirstTime = true
movl $0, %esi #Type = 0
movl $0, %r13d #mult = 0
movq $0,%r12
Loop:
cmpb $44, (%r8, %rdi, 1) #while (word[k] != ',')
je contin
jmp *.L8(, %rsi, 8)
.L8:
.quad .L2
.quad .L3
.quad .L4
.quad .L5
backToLoop:
incl %edi #k++
#movl %r14d, %r9d #j = counter
#decl %r9d # maybe will do this alot of times, but when it jumps it will be the right value
cmpb $44, (%r8, %rdi, 1)
je contin
incl %r14d
jmp Loop
contin:
cmpl $0, %r14d
je falseCase
cmpl $3, %r14d #right after the end of loop #if (counter == 0 || counter >3)
jg falseCase
#movl %r14d, %r9d #j = counter - 1
#decl %r9d #j++
cmpl $0, %esi #if(type == 0) which is hexa
jne type2
movl $4, %ecx #shifts = 4
jmp LoopX
type2:
cmpl $1, %esi #if (type == 1) which is binary
jne type3
movl $1, %ecx #shifts = 1
jmp LoopX
type3:
cmpl $2, %esi #if (type == 3) which is octal
jne type4
movl $3, %ecx
jmp LoopX
type4: #Must be type 3 decimal
jmp LoopX

LoopX:
cmpl %r14d, %r9d #ziv: I think should be -1#for (int j = counter-1 ; j >=0 ; j--)
jge trueCase
movl %eax, %r11d #r11 = i
addl %r9d, %r11d #r11 = i+j
movb (%r8, %r11, 1), %r12b #r12 = word[i+j]
cmpb $65, %r12b
jge convertingAF
subb $48, %r12b #r12 = digit //-------shouldnt be b suffix?
jmp continue_calc
convertingAF:
subb $55,%r12b
continue_calc:
cmpl $3, %esi #if (type == 3, meaning decimal)
jne power2
cmpl $0, %r9d #if (j == 0)
jne j1
movl %r12d, %r13d #mult = digit
jmp summing
j1:
cmpl $1, %r9d #if (j==1)
jne j2
imull $10, %edx, %edx #mult += 10*digit
movl %r12d, %r13d #mult = digit
jmp summing
j2:
cmpl $2, %r9d #if (j == 2)
jne LoopX
imull $10, %edx, %edx
movl %r12d, %r13d #mult = digit
jmp summing

power2:
cmpl $0, %r9d #if (j == 0)
jne jj1
movl %r12d, %r13d
jmp summing

jj1:
cmpl $1, %r9d 
jne jj2
shll %cl, %edx
movl %r12d, %r13d
jmp summing

jj2:
cmpl $2, %r9d
jne LoopX
 #ebx = 2*numOfShifts #you did nothign here.
#movw %bx,%cx 
shll %cl ,%edx #r12 = r12*2^ebx
movl %r12d, %r13d
jmp summing


summing:
addl %r13d, %edx #sum += mult
incl %r9d
jmp LoopX

.L2:
cmpb $1, %bpl #if (firstTime == true)
jne L22
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jne .L3
cmpb $120, 1(%r8, %rax, 1) #if (Word[i+1] == 'x')
jne .L3
addl $2, %eax #i+=2
movl %eax, %edi #k = i
incl %r14d #counter++
movl $0, %esi #type = 0, hexa
movb $0, %bpl #isFirstTime = false
L22: #supposed to get in directly afterwards
cmpb $65, (%r8, %rdi, 1) #if (!((word[k] >= 'A' && word[k] <= 'F') || (word[k] >= '0' && word[k] <= '9')))
jl otherValidCheck
cmpb $70, (%r8, %rdi, 1)
jg otherValidCheck
jmp backToLoop

otherValidCheck:
cmpb $48, (%r8, %rdi, 1)
jl falseCase
cmpb $57, (%r8, %rdi, 1)
jg falseCase
jmp backToLoop

.L3:
cmpb $1, %bpl #if (firstTime == true)
jne L33
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jne L7
cmpb $98, 1(%r8, %rax, 1) #if (Word[i+1] == 'b')
jne L7
addl $2, %eax #i+=2
movl %eax, %edi #k = i
incl %r14d #counter++
movl $1, %esi #type = 1, binary
movb $0, %bpl #isFirstTime = false
L33: #supposed to get in directly afterwards
cmpb $48, (%r8, %rdi, 1) #if ((word[k] == '0' || 1)
jne checkIfOne
je backToLoop
checkIfOne:
cmpb $49, (%r8, %rdi, 1)
jne falseCase
jmp backToLoop

L7:
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0' && word[i+1] == ',')
jne .L4
cmpb $44, 1(%r8, %rax, 1) #if (word[i] == '0' && word[i+1] == ',')
jne .L4
movl $0, %edx
jmp trueCase

.L4:
cmpb $1, %bpl #if (firstTime == true)
jne L44
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jne .L5
cmpb $48, 1(%r8, %rax, 1) #if (Word[i+1] == '0'-'7')
jl falseCase
cmpb $55, 1(%r8, %rax, 1) 
jg falseCase
addl $1, %eax #i+=1 
movl %eax, %edi #k = i
incl %r14d #counter++
movl $2, %esi #type = 2, octal
movb $0, %bpl #isFirstTime = false
L44: #supposed to get in directly afterwards
cmpb $48, (%r8, %rdi, 1) #if (Word[k] == '0'-'7')
jl falseCase
cmpb $55, (%r8, %rdi, 1) 
jg falseCase
jmp backToLoop

.L5:
cmpb $1, %bpl #if (firstTime == true)
jne L55
cmpb $48, (%r8, %rax, 1) #if (word[i] == '0')
jl falseCase
cmpb $57, (%r8, %rax, 1) #if (word[i] == '0')
jg falseCase
movl %eax, %edi #k = i
incl %r14d #counter++
movl $3, %esi #type = 3, decimal
movb $0, %bpl #isFirstTime = false
L55: #supposed to get in directly afterwards
cmpb $48, (%r8, %rdi, 1) #if (Word[k+1] == '0'-'9')
jl falseCase
cmpb $57, (%r8, %rdi, 1) 
jg falseCase
jmp backToLoop



falseCase:
movb $0, (legal)
movl $0, (integer)
jmp finito

trueCase:
movb $1, (legal)
movl %edx, (integer)
jmp finito

finito:



	
	