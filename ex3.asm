.global _start

.section .text
_start:
leaq (source_array), %r8
leaq (up_array), %r9
leaq (down_array), %r10

mov $0x1, %rcx #counter = 1
#initializing params for the first loop
mov $0x1, %rax #  int i = 1;
movl (%r8), %esi
cmpl %esi, 4(%r8)
jl starting_from_the_upper
#jmp starting_from_the_lower
	
starting_from_the_upper: 
movl (%r8), %esi #rsi = array[0]
movl %esi, (%r9) #up_array[0] = array[0]
mov $0x1, %r11 #index_up = 1
mov $0x0, %r12 #index_down = 0
jmp Loop1

Loop1:
cmpl (size), %eax # for (int i = 1; i < size; i++)
jge endOfLoop1
movl (%r8, %rax, 4), %r13d #r13 = array[i]
decq %r11
movl (%r9, %r11, 4), %r14d #r14 = up_array[index_up]
inc %r11
cmpl %r14d, %r13d  #if ( up_array[index_up-1] < array[i] )
jg first_if_scope_in_Loop1

cmpl $0x0, %r12d
jne ifNotEmpty
movl %r13d,(%r10) #down_array[down_index] = array[i]
jmp before_inc
ifNotEmpty:
dec %r12
movl (%r10, %r12, 4), %r15d #r15 = down_array[index_down-1]
inc %r12
cmpl %r13d, %r15d #else if (array[i] < down_array[index_down-1[]
jle ifFalse
movl %r13d, (%r10, %r12, 4) #down_array[down_index] = array[i]
inc %r12
inc %eax
inc %rcx #counter++
jmp Loop1
movq %r13, 4(%r15) 
before_inc:
inc %r12 #index_down++
inc %rcx #counter++
inc %eax
jmp Loop1

ifFalse:
inc %eax
jmp Loop1

first_if_scope_in_Loop1:
movl %r13d, (%r9, %r11, 4) # up_array[index_up] = array[i] 
inc %r11 #index_up++
inc %rcx #counter++
inc %eax
jmp Loop1

endOfLoop1:
cmpl (size), %ecx #if (counter == 4)
je trueCase
movl $0, (bool) #bool = false
jmp finito

trueCase:
movl $1, (bool) #bool = true
jmp finito

finito:




