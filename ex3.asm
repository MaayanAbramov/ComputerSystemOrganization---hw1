.global _start

.section .text
_start:
leaq (source_array), %r8
leaq (up_array), %r9
leaq (down_array), %r10

#initializing params for the first loop
movl $0x0, %eax #  int i = 0;
movq $0x0, %r14 #index_down
movq $0x0, %r15 #index_up

xorq %rsp, %rsp #flag = 0
movl $-1, %ebx #ebx = 0 times 32: 1 times 32 
shrl $1, %ebx #ebx = 0, #dec times 33: 1 times 31 (now max int) 
movl %ebx,%ecx
xorl $-1, %ecx #ecx = 0, #inc times 32 : 1 time 1 : 31 times 0 (now min int)


Loop:
cmpl %eax, (size) 
jle end
movl (%r8, %rax, 4), %edx #edx = arr[i]
cmpl %edx, %ecx #if (inc < arr[i]) && (arr[i] < dec)
jge L4
cmpl %edx, %ebx 
jle L4
movl %eax, %r11d #r11d = i
incl %r11d
movl (%r8, %r11, 4), %r12d #r12 = arr[i+1]
incl %eax
cmpl %edx, %r12d #if (arr[i] < arr[i+1])
jle L3
movl %edx, %ecx # inc = arr[i]
movl %edx, (%r9, %r15, 4) #up_array[up_index] = arr[i]
incl %r15d #up_index++
incl %eax
jmp Loop

L3: #else
movl %edx, %ebx #dec = arr[i]
movl %edx, (%r8, %r14, 4) #down_array[i] = arr[i]
incl %r14d
incl %eax
jmp Loop

L4: #else if
cmpl %ecx, %edx #if (arr[i] > inc)
jle L5
movl %edx, %ecx #inc = arr[i]
movl %edx, (%r9, %r15, 4) #up_array[i] = arr[i]
incl %r15d
incl %eax
jmp Loop

L5: #else if
cmpl %ebx, %edx #if(dec > arr[i])
jge L6
movl %edx, %ebx #dec = arr[i]
movl %edx, (%r8, %r14, 4) #down_array[i] = arr[i]
incl %r14d
incl %eax
jmp Loop

L6:
movl $1 ,%esp #flag = 1
jmp falseCase

end:
cmpl $0, %esp #if (flag == 0)
je trueCase
jmp finito

trueCase:
movb $1, (bool)
jmp finito

falseCase:
movb $0, (bool)
jmp finito


finito:



