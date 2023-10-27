# Input: index: 0 - 8, 9 for matrix9 (%rdi)
# Output: X, O, D, -
check_win:                      # By Teo
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

    # if (rdi == 9) coppy matrix9 to registers
    cmp $9, %rdi
    jne copy_values_check_win
    mov $0, %r9
    movb matrix9(%r9), %r10b
    mov $1, %r9
    movb matrix9(%r9), %r11b
    mov $2, %r9
    movb matrix9(%r9), %r12b
    mov $3, %r9
    movb matrix9(%r9), %r13b
    mov $4, %r9
    movb matrix9(%r9), %r14b
    mov $5, %r9
    movb matrix9(%r9), %r15b
    mov $6, %r9
    movb matrix9(%r9), %al
    mov $7, %r9
    movb matrix9(%r9), %bl
    mov $8, %r9
    movb matrix9(%r9), %cl
    jmp end_copy_values_check_win
    
    # if (rdi != 9) copy matrix to registers
    copy_values_check_win: 
        mov %rdi, %r9

        mov %r9, %rdi
        mov $0, %rsi
        call getVal
        movb matrix81(%rax), %r10b

        mov %r9, %rdi
        mov $1, %rsi
        call getVal
        movb matrix81(%rax), %r11b

        mov %r9, %rdi
        mov $2, %rsi
        call getVal
        movb matrix81(%rax), %r12b

        mov %r9, %rdi
        mov $3, %rsi
        call getVal
        movb matrix81(%rax), %r13b

        mov %r9, %rdi
        mov $4, %rsi
        call getVal
        movb matrix81(%rax), %r14b

        mov %r9, %rdi
        mov $5, %rsi
        call getVal
        movb matrix81(%rax), %r15b

        mov %r9, %rdi
        mov $6, %rsi
        call getVal
        movb matrix81(%rax), %al

        mov %r9, %rdi
        mov $7, %rsi
        call getVal
        movb matrix81(%rax), %bl

        mov %r9, %rdi
        mov $8, %rsi
        call getVal
        movb matrix81(%rax), %cl
    end_copy_values_check_win:



    case_0_check_win:   # 0 1 2
        cmpb $'-', %r10b
        je case_1_check_win
        mov %r10b, %r8b
        cmp %r10b, %r11b
        jne case_1_check_win
        cmp %r10b, %r12b
        je win_check_win

    case_1_check_win:   # 3 4 5
        cmpb $'-', %r13b
        je case_2_check_win
        mov %r13b, %r8b
        cmp %r13b, %r14b
        jne case_2_check_win
        cmp %r13b, %r15b
        je win_check_win

    case_2_check_win:   # 6 7 8
        cmpb $'-', %al
        je case_3_check_win
        mov %al, %r8b
        cmp %al, %bl
        jne case_3_check_win
        cmp %al, %cl
        je win_check_win

    case_3_check_win:    # 0 3 6
        cmpb $'-', %r10b
        je case_4_check_win
        mov %r10b, %r8b
        cmp %r10b, %r13b
        jne case_4_check_win
        cmp %r10b, %al
        je win_check_win

    case_4_check_win:    # 1 4 7
        cmpb $'-', %r11b
        je case_5_check_win
        mov %r11b, %r8b
        cmp %r11b, %r14b
        jne case_5_check_win
        cmp %r11b, %bl
        je win_check_win

    case_5_check_win:    # 2 5 8
        cmpb $'-', %r12b
        je case_6_check_win
        mov %r12b, %r8b
        cmp %r12b, %r15b
        jne case_6_check_win
        cmp %r12b, %cl
        je win_check_win

    case_6_check_win:    # 0 4 8
        cmpb $'-', %r10b
        je case_7_check_win
        mov %r10b, %r8b
        cmp %r10b, %r14b
        jne case_7_check_win
        cmp %r10b, %cl
        je win_check_win

    case_7_check_win:    # 2 4 6
        cmpb $'-', %r12b
        je case_8_check_win
        mov %r12b, %r8b
        cmp %r12b, %r14b
        jne case_8_check_win
        cmp %r12b, %al
        je win_check_win

    case_8_check_win:    # draw
        cmp $'-', %r10b
        je no_win_check_win
        cmp $'-', %r11b
        je no_win_check_win
        cmp $'-', %r12b
        je no_win_check_win
        cmp $'-', %r13b
        je no_win_check_win
        cmp $'-', %r14b
        je no_win_check_win
        cmp $'-', %r15b
        je no_win_check_win
        cmp $'-', %al
        je no_win_check_win
        cmp $'-', %bl
        je no_win_check_win
        cmp $'-', %cl
        je no_win_check_win
    
    jmp draw_check_win

    
    
    win_check_win:
        movb %r8b, %al
        jmp epilogue_check_win

    draw_check_win:
        movb $'D', %al
        jmp epilogue_check_win

    no_win_check_win:
        movb $'-', %al
        jmp end_check_win



    epilogue_check_win:

    cmp $9, %rdi
    jne modify_matrix9_check_win
    # if (rdi == 9) printf ai bucile faine + rax
    mov $outputWonResult, %rdi
    mov %rax, %rsi
    xor %rax, %rax
    call printf
    jmp end_check_win

    # else mattrix9(rdi) = rax
    modify_matrix9_check_win:
    # check win for matrix9
    mov $9, %rdi
    call check_win
    # if (rax == 'X' || rax == 'O') call winScreen
    cmpb $'X', %al
    je win_screen_check_win
    cmpb $'O', %al
    je win_screen_check_win
    jmp end_win_screen_check_win
    win_screen_check_win:
    call winScreen
    end_win_screen_check_win:

    movb %al, matrix9(%rdi)     # matrix9(rdi) = rax

    # colour the values in matrix81
    mov %rdi, %rsi
    movb %al, %dil
    call add_win

    end_check_win:
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
    