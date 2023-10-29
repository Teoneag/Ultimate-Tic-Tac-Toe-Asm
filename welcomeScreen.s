
welcomeScreen:      # By Gali ofc
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

    call clear

    mov $outputWelcome,%rdi
    call printf

    call scanf

    call clear

    mov $outputHighscores,%rdi
    movl nrWinsX, %esi
    movl nrWinsO, %edx
    movl nrDraws, %ecx
    call printf

    call printBig

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
    