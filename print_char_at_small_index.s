# Puts the char in the bigString giving the smallIndex
# Input: char ('X', 'O', ' '), index [0, 80]
print_char_at_small_index:      # By Teon     coaie ai implementat codu meu + 4 linii originale si ai zis ca made by teon :/
    # prologue
    push %rbp
    mov %rsp, %rbp

    # push registers
    push %rbx
    push %rbx
    push %r12
    push %r13
    push %r14
    push %r15

    movb %dil, %r12b
    
    mov %rsi, %rdi
    call smallIndexToBigIndex

    movb %r12b, %dil
    mov %rax, %rsi
    mov $bigMessage, %rdx
    call addSmthnToBigString 

    # pop registers
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %rbx
    pop %rbx

    #epilogue
    mov %rbp, %rsp
    pop %rbp
    ret
    