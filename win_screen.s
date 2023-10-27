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

    // call clear

    // call printBig

    cmpb $'X', %dil
    je X_win_screen

    cmpb $'O', %dil
    je O_win_screen

    cmpb $'D', %dil
    je D_win_screen

    # print error message
    mov $outputWrongInputForWinScreen, %rdi
    xor %rax, %rax
    call printf

    X_win_screen:
    mov $outputXWon, %rdi
    jmp end_win_screen

    O_win_screen:
    mov $outputOWon, %rdi
    jmp end_win_screen

    D_win_screen:
    mov $outputDraw, %rdi
    
    end_win_screen:
    xor %rax, %rax
    call printf

    jmp end_main

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
    