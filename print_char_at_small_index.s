# Puts the char in the bigString giving the smallIndex
# Input: char ('X', 'O', ' '), index [0, 80]
print_char_at_small_index:      # By Teon
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
    call small_to_big_index

    movb %r12b, %dil
    mov %rax, %rsi
    mov $bigMessage, %rdx
    call add_smthn_to_big_string 

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
    