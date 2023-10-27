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

    mov %rdi,%r12   # r12 = our character

    cmp $'X',%r12
    jne checkO
    movq $outputXWon,%r13
    jmp loop1
    checkO:
    cmp $'O',%r12
    jne draw
    movq $outputOWon,%r13
    jmp loop1
    draw:
    movq $outputDraw,%r13
    mov $0,%rbx
    loop1:
  
    mov (%r13, %rbx,1),%r15  # r15 character being printed
    cmp $7,%rbx
    je terminaFA
    cmp $' ' ,%r15
    je noeffect
    mov $outputEffect,%rdi
    jmp print1
    noeffect:
    mov $outputSimple,%rdi

    print1:

    mov %r15,%rsi

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
    
    