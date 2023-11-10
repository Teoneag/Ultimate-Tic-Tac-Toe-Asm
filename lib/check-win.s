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

    push %rdi
    push %rdi

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
        call get_index_from_nr_nr
        movb matrix81(%rax), %r10b
        push %r10                   # save r10

        mov %r9, %rdi
        mov $1, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %r11b
        push %r11                   # save r11

        mov %r9, %rdi
        mov $2, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %r12b

        mov %r9, %rdi
        mov $3, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %r13b

        mov %r9, %rdi
        mov $4, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %r14b

        mov %r9, %rdi
        mov $5, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %r15b

        mov %r9, %rdi
        mov $6, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %al
        push %rax               # save rax

        mov %r9, %rdi
        mov $7, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %bl

        mov %r9, %rdi
        mov $8, %rsi
        call get_index_from_nr_nr
        movb matrix81(%rax), %cl
        push %rcx               # save rcx
        // pop
        pop %rcx
        pop %rax
        pop %r11
        pop %r10
    end_copy_values_check_win:


    case_0_check_win:   # 0 1 2
        mov %r10b, %r8b
        cmpb $'-', %r10b
        je case_1_check_win
        cmp %r10b, %r11b
        jne case_1_check_win
        cmp %r10b, %r12b
        je win_check_win

    case_1_check_win:   # 3 4 5
        mov %r13b, %r8b
        cmpb $'-', %r13b
        je case_2_check_win
        cmp %r13b, %r14b
        jne case_2_check_win
        cmp %r13b, %r15b
        je win_check_win

    case_2_check_win:   # 6 7 8
        mov %al, %r8b
        cmpb $'-', %al
        je case_3_check_win
        cmp %al, %bl
        jne case_3_check_win
        cmp %al, %cl
        je win_check_win

    case_3_check_win:    # 0 3 6
        mov %r10b, %r8b
        cmpb $'-', %r10b
        je case_4_check_win
        cmp %r10b, %r13b
        jne case_4_check_win
        cmp %r10b, %al
        je win_check_win

    case_4_check_win:    # 1 4 7
        mov %r11b, %r8b
        cmpb $'-', %r11b
        je case_5_check_win
        cmp %r11b, %r14b
        jne case_5_check_win
        cmp %r11b, %bl
        je win_check_win

    case_5_check_win:    # 2 5 8
        mov %r12b, %r8b
        cmpb $'-', %r12b
        je case_6_check_win
        cmp %r12b, %r15b
        jne case_6_check_win
        cmp %r12b, %cl
        je win_check_win

    case_6_check_win:    # 0 4 8
        mov %r10b, %r8b
        cmpb $'-', %r10b
        je case_7_check_win
        cmp %r10b, %r14b
        jne case_7_check_win
        cmp %r10b, %cl
        je win_check_win

    case_7_check_win:    # 2 4 6
        mov %r12b, %r8b
        cmpb $'-', %r12b
        je case_8_check_win
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
        movb %r8b, %r12b
        jmp final_check_win

    draw_check_win:
        movb $'D', %r12b
        jmp final_check_win

    no_win_check_win:
        movb $'-', %al
        jmp epilogue_check_win



    final_check_win:

    cmp $9, %rdi
    jne modify_matrix9_check_win
    # if (rdi == 9) return 'X' or 'O or 'D' to %rax
    mov %r12b, %al
    jmp epilogue_check_win

    # else mattrix9(rdi) = rar12b
    modify_matrix9_check_win:
    mov (%rsp), %rdi
    movb %r12b, matrix9(%rdi)     # matrix9(rdi) = rax

    # colour the values in matrix81
    movb %r12b, %dil        # rdi = character that won
    movb (%rsp), %sil       # rsi = 0 - 8 unde dai add_to_output_small_win 
    call add_to_output_small_win

    # check win for matrix9
    mov $9, %rdi
    call check_win
    mov %rax, %r13


    # if (al == 'X' || al == 'O') call win_screen
    mov %r13, %rax
    cmpb $'X', %al
    je win_screen_check_win
    cmpb $'O', %al
    je win_screen_check_win
    cmpb $'D', %al
    je win_screen_check_win
    jmp end_win_screen_check_win
    win_screen_check_win:
    mov %rax, %rdi
    call win_screen
    jmp epilogue_check_win
    end_win_screen_check_win:

    epilogue_check_win:
    # pop registers
    pop %rdi
    pop %rdi
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
    