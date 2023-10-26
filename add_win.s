# Writes O or X in the smallMatrix
# Input: char ('X'/'O'); nr [0, 8] of the smallMatrix
# TODO: implement draw
add_win:      # By Teo
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

    // # print outputThisIsMatrix81
    // mov $outputThisIsMatrix81, %rdi
    // xor %r8, %r8
    // call printf

    # save indexes of the smallMatrix
    mov %rsi, %r12          # r12 = nr = index of the smallMatrix


    cmpb $'O', %dil
    jne print_X_add_win

    # if %rdi == 'O'
    print_O_add_win:
    # O O O
    # O   O
    # O O O
    # 0
    mov %r12, %rdi
    mov $0, %rsi
    call getVal
    
    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 1
    mov %r12, %rdi
    mov $1, %rsi
    call getVal

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 2
    mov %r12, %rdi
    mov $2, %rsi
    call getVal

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 3
    mov %r12, %rdi
    mov $3, %rsi
    call getVal

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 4
    mov %r12, %rdi
    mov $4, %rsi
    call getVal

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 5
    mov %r12, %rdi
    mov $5, %rsi
    call getVal

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 6
    mov %r12, %rdi
    mov $6, %rsi
    call getVal

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 7
    mov %r12, %rdi
    mov $7, %rsi
    call getVal

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 8
    mov %r12, %rdi
    mov $8, %rsi
    call getVal

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index



    # if %rdi == 'X'
    print_X_add_win:
    # X   X
    #   X
    # X   X
    
    # 0
    mov %r12, %rdi
    mov $0, %rsi
    call getVal

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 1
    mov %r12, %rdi
    mov $1, %rsi
    call getVal

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 2
    mov %r12, %rdi
    mov $2, %rsi
    call getVal

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 3
    mov %r12, %rdi
    mov $3, %rsi
    call getVal

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 4
    mov %r12, %rdi
    mov $4, %rsi
    call getVal

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 5
    mov %r12, %rdi
    mov $5, %rsi
    call getVal

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 6
    mov %r12, %rdi
    mov $6, %rsi
    call getVal

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 7
    mov %r12, %rdi
    mov $7, %rsi
    call getVal

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 8
    mov %r12, %rdi
    mov $8, %rsi
    call getVal

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    
    



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
    