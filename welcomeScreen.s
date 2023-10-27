
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

    mov $welcome,%rdi
    call printf

    call scanf

    call clear

    mov $highscores,%rdi
    movl $nrWinsX,%esi
    movl $nrWinsO,%edx

    call printf

    call scanf

    // call clear

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
    