# get input from user (simple or complex)
# saves in the matrix81
# updates the currentPlayer
# updates the currentSmallMatrix
get_input:                      # By Teo
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

    # update the currentPlayer
    cmpb $'X', currentPlayer
    je set_O
    movb $'X', currentPlayer
    jmp end_set_O
    set_O:
    movb $'O', currentPlayer
    end_set_O:

    # update the currentSmallMatrix
    movl currentInput, %r12d
    movl %r12d, currentSmallMatrix


    # if (matrix9[currentSmallMatrix] != '-') currentSmallMatrix = 9
    movb matrix9(%r12), %r13b
    cmpb $'-', %r13b
    jne set_9
    jmp end_set_9
    set_9:
    movl $9, currentSmallMatrix
    end_set_9:

    # check if the currentSmallMatrix is 9
    cmpl $9, currentSmallMatrix
    jne get_simple_input

    # get complex input
    get_complex_input:
        call clear_screen
        mov $OutputHighscores,%rdi
        movl nrWinsX, %esi
        movl nrWinsO, %edx
        movl nrDraws, %ecx
        call printf
        
        mov $OutputCurrentPlayerSqare, %rdi
        movb currentPlayer, %sil
        movl currentSmallMatrix, %edx
        incl %edx
        xor %rax, %rax
        call printf
        call print_matrix
        # ask user for the 2 nr
        mov $MessageYouCanChose, %rdi
        xor %rax, %rax
        call printf

        # read 2 nr
        subq $16, %rsp          # make room for 1st, 2nd nr
        lea -8(%rbp), %rsi      # address of 1st nr
        lea -16(%rbp), %rdx     # address of 2nd nr
        mov $Input2Nr, %rdi     # format string
        xor %rax, %rax          # clear_screen rax
        call scanf              # read 1st nr
        mov -8(%rbp), %r12      # save 1st nr in %r12 (row)
        dec %r12                # [1, 3] -> [0, 2]
        mov -16(%rbp), %r13     # save 2nd nr in %r13 (col)
        dec %r13                # [1, 3] -> [0, 2]
        addq $16, %rsp          # restore stack

        # if %r12 < 0 || %r12 > 2 || %r13 < 0 || %r13 > 2 ask again
        cmp $0, %r12
        jl try_again_output
        cmp $2, %r12
        jg try_again_output
        cmp $0, %r13
        jl try_again_output
        cmp $2, %r13
        jg try_again_output

        # update the currentSmallMatrix = %r13 + %r12 * 3
        movl %r13d, currentSmallMatrix
        addl %r12d, currentSmallMatrix
        addl %r12d, currentSmallMatrix
        addl %r12d, currentSmallMatrix




    # if (matrix9[currentSmallMatrix] != '-') ask again
    # calculate index: r12 * 3 + r13
    mov %r13, %r14
    add %r12, %r14
    add %r12, %r14
    add %r12, %r14

    cmpb $'-', matrix9(%r14)
    je get_simple_input
    # print Table already occupied, please chose another one!
    try_again_output:
    mov $MessageTableOccupied, %rdi
    xor %rax, %rax
    call printf
    jmp get_complex_input

    get_simple_input:
        call clear_screen
    get_simple_input_without_clear_screen:
        mov $OutputHighscores,%rdi
        movl nrWinsX, %esi
        movl nrWinsO, %edx
        movl nrDraws, %ecx
        call printf
        # print the current player
        mov $OutputCurrentPlayerSqare, %rdi
        movb currentPlayer, %sil
        movl currentSmallMatrix, %edx
        incl %edx
        xor %rax, %rax
        call printf

        call print_matrix

        # ask user for 2 nr
        mov $OutputEnterCoord, %rdi
        movb currentPlayer, %sil
        xor %rax, %rax
        call printf
        
        # read 2 nr
        subq $16, %rsp          # make room for 1st, 2nd nr
        lea -8(%rbp), %rsi      # address of 1st nr
        lea -16(%rbp), %rdx     # address of 2nd nr
        mov $Input2Nr, %rdi     # format string
        xor %rax, %rax          # clear_screen rax
        call scanf              # read 1st nr
        mov -8(%rbp), %r12      # save 1st nr in %r12 (row)
        dec %r12                # [1, 3] -> [0, 2]
        mov -16(%rbp), %r13     # save 2nd nr in %r13 (col)
        dec %r13                # [1, 3] -> [0, 2]


    # get the index of the matrix81
    movl currentSmallMatrix, %edi   # nr
    mov %r12, %rsi                  # col
    mov %r13, %rdx                  # row
    call get_index_from_nr_x_y      # index is in %rax
    movl %eax, index81
    
    # if %r12 < 0 || %r12 > 2 || %r13 < 0 || %r13 > 2 ask again
    cmp $0, %r12
    jl try_again_output_2
    cmp $2, %r12
    jg try_again_output_2
    cmp $0, %r13
    jl try_again_output_2
    cmp $2, %r13
    jg try_again_output_2

    # if (matrix81[nr][x][y] != '-') ask again
    cmpb $'-', matrix81(%rax)
    je update_get_input
    # print Sqare already occupied, please chose another one
    try_again_output_2:
    call clear_screen
    mov $MessageSqareOccupied, %rdi
    xor %rax, %rax
    call printf
    jmp get_simple_input_without_clear_screen

    update_get_input:
    # update matrix81(%rax) to %r14
    movb currentPlayer, %r14b           # move char to %r14
    movb %r14b, matrix81(%rax)          

    # update the currentInput = %r13 + %r12 * 3
    movl %r13d, currentInput
    addl %r12d, currentInput
    addl %r12d, currentInput
    addl %r12d, currentInput

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
