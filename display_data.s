# Displays the matrix81 and matrix9
display_data:                       # By Teo
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

    # print outputThisIsMatrix81
    mov $outputThisIsMatrix81, %rdi
    xor %rax, %rax
    call printf

    # print the matrix81
    mov $0, %r12        # i = 0
    start_loop_display_data:
        # print the char at i
        mov $outputCharAndSpace, %rdi
        mov $0, %rsi
        movb matrix81(%r12), %sil
        xor %rax, %rax
        call printf

        inc %r12            # i++

        # if i % 9 == 0 print newLine
        mov %r12, %rax
        xor %rdx, %rdx
        mov $9, %rcx
        div %rcx
        cmp $0, %rdx
        jne end_loop_display_data

        # print newLine
        mov $newLine, %rdi
        xor %rax, %rax
        call printf

        end_loop_display_data:
        cmp $81, %r12
        jne start_loop_display_data

    # print newLine
    mov $newLine, %rdi
    xor %rax, %rax
    call printf

    # print outputThisIsMatrix9
    mov $outputThisIsMatrix9, %rdi
    xor %rax, %rax
    call printf

    # print the matrix9
    mov $0, %r12        # i = 0
    start_loop_2_display_data:
        # print the char at i
        mov $outputCharAndSpace, %rdi
        mov $0, %rsi
        movb matrix9(%r12), %sil
        xor %rax, %rax
        call printf

        inc %r12            # i++

        # if i % 3 == 0 print newLine
        mov %r12, %rax
        xor %rdx, %rdx
        mov $3, %rcx
        div %rcx
        cmp $0, %rdx
        jne end_loop_2_display_data

        # print newLine
        mov $newLine, %rdi
        xor %rax, %rax
        call printf

        end_loop_2_display_data:
        cmp $9, %r12
        jne start_loop_2_display_data

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
