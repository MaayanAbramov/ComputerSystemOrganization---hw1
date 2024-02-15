.global _start

.section .text
_start:
movq (character) ,%r8
cmp $97, %r8
jl false
cmp $122, %r8
jg false
#if true
subb $32, %r8b
movb %r8b, (shifted)
jmp finito 

false:
cmp $49, %r8
jne sign2
movb $33, %r8b
movb %r8b, (shifted)
jmp finito

sign2:
cmp $50, %r8
jne sign3
movb $64, %r8b
movb %r8b, (shifted)
jmp finito

sign3:
cmp $51, %r8
jne sign4
movb $35, %r8b
movb %r8b, (shifted)
jmp finito

sign4:
cmp $52, %r8
jne sign5
movb $36, %r8b
movb %r8b, (shifted)
jmp finito


sign5:
cmp $53, %r8
jne sign6
movb $37, %r8b
movb %r8b, (shifted)
jmp finito

sign6:
cmp $54, %r8
jne sign7
movb $94, %r8b
movb %r8b, (shifted)
jmp finito

sign7:
cmp $55, %r8
jne sign8
movb $38, %r8b
movb %r8b, (shifted)
jmp finito

sign8:
cmp $56, %r8
jne sign9
movb $42, %r8b
movb %r8b, (shifted)
jmp finito

sign9:
cmp $57, %r8
jne sign0
movb $40, %r8b
movb %r8b, (shifted)
jmp finito

sign0:
cmp $48, %r8
jne char1
movb $41, %r8b
movb %r8b, (shifted)
jmp finito

char1:
cmp $96, %r8
jne char2
movb $126, %r8b
movb %r8b, (shifted)
jmp finito

char2:
cmp $45, %r8
jne char3
movb $95, %r8b
movb %r8b, (shifted)
jmp finito

char3:
cmp $61, %r8
jne char4
movb $43, %r8b
movb %r8b, (shifted)
jmp finito

char4:
cmp $91, %r8
jne char5
movb $123, %r8b
movb %r8b, (shifted)
jmp finito

char5:
cmp $93, %r8
jne char6
movb $125, %r8b
movb %r8b, (shifted)
jmp finito

char6:
cmp $59, %r8
jne char7
movb $58, %r8b
movb %r8b, (shifted)
jmp finito

char7:
cmp $39, %r8
jne char8
movb $34, %r8b
movb %r8b, (shifted)
jmp finito

char8:
cmp $92, %r8
jne char9
movb $124, %r8b
movb %r8b, (shifted)
jmp finito

char9:
cmp $44, %r8
jne char10
movb $60, %r8b
movb %r8b, (shifted)
jmp finito

char10:
cmp $46, %r8
jne char11
movb $62, %r8b
movb %r8b, (shifted)
jmp finito

char11:
cmp $47, %r8
jne endOfShifting
movb $63, %r8b
movb %r8b, (shifted)
jmp finito

endOfShifting:
cmp $33, %r8
je shiftedAlready
cmp $64, %r8
je shiftedAlready
cmp $35, %r8
je shiftedAlready
cmp $36, %r8
je shiftedAlready
cmp $37, %r8
je shiftedAlready
cmp $94, %r8
je shiftedAlready
cmp $38, %r8
je shiftedAlready
cmp $42, %r8
je shiftedAlready
cmp $40, %r8
je shiftedAlready
cmp $41, %r8
je shiftedAlready
cmp $126, %r8
je shiftedAlready
cmp $95, %r8
je shiftedAlready
cmp $43, %r8
je shiftedAlready
cmp $123, %r8
je shiftedAlready
cmp $125, %r8
je shiftedAlready
cmp $58, %r8
je shiftedAlready
cmp $34, %r8
je shiftedAlready
cmp $124, %r8
je shiftedAlready
cmp $60, %r8
je shiftedAlready
cmp $62, %r8
je shiftedAlready
cmp $63, %r8
je shiftedAlready
cmp $65, %r8
jl notExists
cmp $90, %r8
jg notExists
jmp shiftedAlready #if true(if is a capital letter)


shiftedAlready:
movb %r8b, (shifted)
jmp finito

notExists: #the case where the keyboard doesnt contain the key
movb $0xff, %r8b
movb %r8b, (shifted)

finito:



