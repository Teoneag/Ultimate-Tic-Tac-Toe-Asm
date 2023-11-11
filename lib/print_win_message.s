print_win_message:   # input:  a chard in rdi   O - O won  X - X won   - - Draw  
    # prologue    by Gali ofc
    push %rbp
    mov %rsp, %rbp

    # push registers
    push %rbx
    push %rbx
    push %r12
    push %r13
    push %r14
    push %r15

    mov %rdi,%r12   # r12 = our character


    cmpb $'X',%r12b
    jne checkO
    movq $MessageXWon,%r13
    movl nrWinsX, %ecx
    incl %ecx
    movl %ecx, nrWinsX 
    jmp gotoloop
    checkO:
    cmpb $'O',%r12b
    jne draw
    movq $MessageOWon,%r13
    movl nrWinsO, %ecx
    incl %ecx
    movl %ecx, nrWinsO
    jmp gotoloop
    draw:
    movl nrDraws, %ecx
    incl %ecx
    movl %ecx, nrDraws
    movq $MessageDraw,%r13

    gotoloop:
    mov $0,%rbx

    mov $EffectStartBlinking,%rdi
    mov $'_',%rsi
    call printf

    loop1:
  
    movb (%r13, %rbx,1),%r15b  # r15 character being printed
    cmpb $0,%r15b
    je terminaFA

    mov $OutputChar,%rdi
    mov %r15,%rsi

    call printf

    inc %rbx
    jmp loop1
    terminaFA:

     mov $EffectStopBlinking,%rdi
    mov $'_',%rsi
    call printf

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
    