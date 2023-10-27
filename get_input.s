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
        # ask user for the 2 nr
        mov $outputYouCanChose, %rdi
        xor %rax, %rax
        call printf

        # read 2 nr
        subq $16, %rsp          # make room for 1st, 2nd nr
        lea -8(%rbp), %rsi      # address of 1st nr
        lea -16(%rbp), %rdx     # address of 2nd nr
        mov $input2Nr, %rdi     # format string
        mov $0, %rax            # clear rax
        call scanf              # read 1st nr
        mov -8(%rbp), %r13      # save 1st nr in %r12
        dec %r13                # [1, 3] -> [0, 2]
        mov -16(%rbp), %r12     # save 2nd nr in %r13
        dec %r12                # [1, 3] -> [0, 2]
        addq $16, %rsp          # restore stack

        # update the currentSmallMatrix = %r13 + %r12 * 3
        movl %r13d, currentSmallMatrix
        addl %r12d, currentSmallMatrix
        addl %r12d, currentSmallMatrix
        addl %r12d, currentSmallMatrix

    # if (matrix9[currentSmallMatrix] != '-') ask again
    # TODO add blinking
    # calculate index: r12 * 3 + r13
    mov %r13, %r14
    add %r12, %r14
    add %r12, %r14
    add %r13, %r14

    cmpb $'-', matrix9(%r14)
    je get_simple_input
    # print Table already occupied, please chose another one!
    mov $outputTableOccupied, %rdi
    xor %rax, %rax
    call printf
    jmp get_complex_input

    get_simple_input:
        call clear
        call printBig

        # print the current player
        mov $outputCurrentPlayerSqare, %rdi
        movb currentPlayer, %sil
        movl currentSmallMatrix, %edx
        xor %rax, %rax
        call printf

        # ask user for 2 nr
        mov $outputEnterCoord, %rdi
        movb currentPlayer, %sil
        xor %rax, %rax
        call printf
        
        # read 2 nr
        subq $16, %rsp          # make room for 1st, 2nd nr
        lea -8(%rbp), %rsi      # address of 1st nr
        lea -16(%rbp), %rdx     # address of 2nd nr
        mov $input2Nr, %rdi     # format string
        xor %rax, %rax          # clear rax
        call scanf              # read 1st nr
        mov -8(%rbp), %r13      # save 1st nr in %r12
        dec %r13                # [1, 3] -> [0, 2]
        mov -16(%rbp), %r12     # save 2nd nr in %r13
        dec %r12                # [1, 3] -> [0, 2]


    # get the index of the matrix81 by calling get_index_from_nr_x_y
    movl currentSmallMatrix, %edi   # nr
    mov %r12, %rsi                  # x
    mov %r13, %rdx                  # y

    call get_index_from_nr_x_y      # index is in %rax
    movl %eax, index81
    
    # if (matrix81[nr][x][y] != '-') ask again
    # TODO add blinking
    cmpb $'-', matrix81(%rax)
    je update_get_input
    # print Sqare already occupied, please chose another one
    mov $outputSqareOccupied, %rdi
    xor %rax, %rax
    call printf
    jmp get_simple_input

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
