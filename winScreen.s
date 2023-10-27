winScreen:   # input:  a chard in rdi   O - O won  X - X won   - - Draw
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

    // mov $0,%r12
    movb %dil, %r12b   # r12 = our character

    # print %r12
    mov $outputCharAndNewLine, %rdi
    mov %r12, %rsi
    xor %rax, %rax
    call printf

    cmp $'X',%r12
    jne checkO
    movq $outputXWon,%r13
    jmp fa
    checkO:
    cmp $'O',%r12
    jne draw
    movq $outputOWon,%r13
    jmp fa
    draw:
    movq $outputDraw,%r13

    fa:
    mov $0,%rbx
    loop1:
  
    movb (%r13, %rbx,1),%r15b  # r15 character being printed
    cmpb $0,%r15b
    je terminaFA

    mov $outputEffect,%rdi

    mov %r15,%rsi
    xor %rax,%rax
    call printf

    inc %rbx
    jmp loop1
    terminaFA:



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
    