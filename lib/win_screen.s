# Prints the win screen
# Input: 1 char: 'X' / 'O' / 'D' (%rdi) 
win_screen:      # By Teo
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

    # save input in %r12
    mov %rdi, %r12

    call clear_screen

    movl $10, index9

    call print_matrix

    mov %r12, %rdi
    call print_win_message
    
    // call scanf              # wait for input
    # TODO wait for user input to display next things

    # ask the player if you want to play again
    mov $MessageAskPlayAgain, %rdi
    xor %rax, %rax
    call printf

    take_player_input_win_screen:
    # take the player's input
    mov $InputChar, %rdi
    sub $16, %rsp
    lea -8(%rbp), %rsi
    xor %rax, %rax
    call scanf

    # if the player input is y play again
    movb -8(%rbp), %dil
    cmpb $'y', %dil
    je initialize_game

    # if the player input is n exit
    movb -8(%rbp), %dil
    cmpb $'n', %dil
    je end_main

    # if the player input is not y or n ask again
    # TODO ask only once if the player input is invalid
    // mov $outputInvalidInput, %rdi
    // xor %rax, %rax
    // call printf
    jmp take_player_input_win_screen

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
    