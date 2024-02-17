.global _start

.section .text
_start:
movq (character) ,%r8
cmp $97, %r8
jl false_HW1
cmp $122, %r8
jg false_HW1
#if true
subb $32, %r8b
movb %r8b, (shifted)
jmp finito_HW1 

false_HW1:
cmp $49, %r8
jne sign2_HW1
movb $33, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign2_HW1:
cmp $50, %r8
jne sign3_HW1
movb $64, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign3_HW1:
cmp $51, %r8
jne sign4_HW1
movb $35, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign4_HW1:
cmp $52, %r8
jne sign5_HW1
movb $36, %r8b
movb %r8b, (shifted)
jmp finito_HW1


sign5_HW1:
cmp $53, %r8
jne sign6_HW1
movb $37, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign6_HW1:
cmp $54, %r8
jne sign7_HW1
movb $94, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign7_HW1:
cmp $55, %r8
jne sign8_HW1
movb $38, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign8_HW1:
cmp $56, %r8
jne sign9_HW1
movb $42, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign9_HW1:
cmp $57, %r8
jne sign0_HW1
movb $40, %r8b
movb %r8b, (shifted)
jmp finito_HW1

sign0_HW1:
cmp $48, %r8
jne char1_HW1
movb $41, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char1_HW1:
cmp $96, %r8
jne char2_HW1
movb $126, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char2_HW1:
cmp $45, %r8
jne char3_HW1
movb $95, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char3_HW1:
cmp $61, %r8
jne char4_HW1
movb $43, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char4_HW1:
cmp $91, %r8
jne char5_HW1
movb $123, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char5_HW1:
cmp $93, %r8
jne char6_HW1
movb $125, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char6_HW1:
cmp $59, %r8
jne char7_HW1
movb $58, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char7_HW1:
cmp $39, %r8
jne char8_HW1
movb $34, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char8_HW1:
cmp $92, %r8
jne char9_HW1
movb $124, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char9_HW1:
cmp $44, %r8
jne char10_HW1
movb $60, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char10_HW1:
cmp $46, %r8
jne char11_HW1
movb $62, %r8b
movb %r8b, (shifted)
jmp finito_HW1

char11_HW1:
cmp $47, %r8
jne endOfShifting_HW1
movb $63, %r8b
movb %r8b, (shifted)
jmp finito_HW1

endOfShifting_HW1:
cmp $33, %r8
je shiftedAlready_HW1
cmp $64, %r8
je shiftedAlready_HW1
cmp $35, %r8
je shiftedAlready_HW1
cmp $36, %r8
je shiftedAlready_HW1
cmp $37, %r8
je shiftedAlready_HW1
cmp $94, %r8
je shiftedAlready_HW1
cmp $38, %r8
je shiftedAlready_HW1
cmp $42, %r8
je shiftedAlready_HW1
cmp $40, %r8
je shiftedAlready_HW1
cmp $41, %r8
je shiftedAlready_HW1
cmp $126, %r8
je shiftedAlready_HW1
cmp $95, %r8
je shiftedAlready_HW1
cmp $43, %r8
je shiftedAlready_HW1
cmp $123, %r8
je shiftedAlready_HW1
cmp $125, %r8
je shiftedAlready_HW1
cmp $58, %r8
je shiftedAlready_HW1
cmp $34, %r8
je shiftedAlready_HW1
cmp $124, %r8
je shiftedAlready_HW1
cmp $60, %r8
je shiftedAlready_HW1
cmp $62, %r8
je shiftedAlready_HW1
cmp $63, %r8
je shiftedAlready_HW1
cmp $65, %r8
jl notExists_HW1
cmp $90, %r8
jg notExists_HW1
jmp shiftedAlready_HW1 #if true(if is a capital letter)


shiftedAlready_HW1:
movb %r8b, (shifted)
jmp finito_HW1

notExists_HW1: #the case where the keyboard doesnt contain the key
movb $0xff, %r8b
movb %r8b, (shifted)

finito_HW1:



