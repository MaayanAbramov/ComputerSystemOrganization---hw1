.global _start


.section .text
_start:
leaq (source_array), %r8
leaq (up_array), %r9
leaq (down_array), %r10

#initializing params for the first Loop_HW1
movl $0x0, %eax #  int i = 0;
movq $0x0, %r14 #index_down
movq $0x0, %r15 #index_up

xorq %rsp, %rsp #flag = 0
movl $-1, %ebx #ebx = 0 times 32: 1 times 32 
shrl $1, %ebx #ebx = 0, #dec times 33: 1 times 31 (now max int) 
movl %ebx,%ecx
xorl $-1, %ecx #ecx = 0, #inc times 32 : 1 time 1 : 31 times 0 (now min int)


Loop_HW1:
cmpl %eax, (size) 
jle end_HW1
movl (%r8, %rax, 4), %edx #edx = arr[i]
cmpl %edx, %ecx #if (inc < arr[i]) && (arr[i] < dec)
jge L4_HW1
cmpl %edx, %ebx 
jle L4_HW1
movl %eax, %r11d #r11d = i
incl %r11d
movl (%r8, %r11, 4), %r12d #r12 = arr[i+1]
incl %eax
cmpl %edx, %r12d #if (arr[i] < arr[i+1])
jle L3_HW1
movl %edx, %ecx # inc = arr[i]
movl %edx, (%r9, %r15, 4) #up_array[up_index] = arr[i]
incl %r15d #up_index++
incl %eax
jmp Loop_HW1

L3_HW1: #else
movl %edx, %ebx #dec = arr[i]
movl %edx, (%r8, %r14, 4) #down_array[i] = arr[i]
incl %r14d
incl %eax
jmp Loop_HW1

L4_HW1: #else if
cmpl %ecx, %edx #if (arr[i] > inc)
jle L5_HW1
movl %edx, %ecx #inc = arr[i]
movl %edx, (%r9, %r15, 4) #up_array[i] = arr[i]
incl %r15d
incl %eax
jmp Loop_HW1

L5_HW1: #else if
cmpl %ebx, %edx #if(dec > arr[i])
jge L6_HW1
movl %edx, %ebx #dec = arr[i]
movl %edx, (%r8, %r14, 4) #down_array[i] = arr[i]
incl %r14d
incl %eax
jmp Loop_HW1

L6_HW1:
movl $1 ,%esp #flag = 1
jmp falseCase_HW1

end_HW1:
cmpl $0, %esp #if (flag == 0)
je trueCase_HW1
jmp finito_HW1

trueCase_HW1:
movb $1, (bool)
jmp finito_HW1

falseCase_HW1:
movb $0, (bool)
jmp finito_HW1


finito_HW1:



