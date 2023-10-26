printBig:      # By gali ofc     input: nr 0 -8 in rdi, which square to blink
    # prologue
    push %rbp
    mov %rsp, %rbp

    # push registers
    push %rbx
    push %r12
    push %r13
    push %r14
    push %r15

    
    push %rdi  # push the matrix to blink on the stack

    mov (%rsp),%rdi
    mov $0,%rsi
    call getVal
    mov %rax, %r14              # r14 is start, r15 is stop
    mov %r14,%rdi
    call smallIndexToBigIndex
    mov %rax,%r14
    dec %r14
    mov (%rsp),%rdi
    mov $2,%rsi
    call getVal
    mov %rax,%r15
    mov %r15,%rdi
    call smallIndexToBigIndex
    mov %rax,%r15
    inc %r15
    inc %r15
    mov $bigMessage,%r12
    mov $0,%r13  # r13 is index
    push $5
    push $5 # no of times we startblink
    loopy:

    mov (%r12,%r13,1),%rsi  #rdi is current character

    cmp $0,%rsi
    je end_loopy

    cmpb $0,(%rsp)
    je printnormal

    cmp %r14,%r13
    jne checknext
    add $45,%r14
    mov $start,%rdi
    jmp print
    checknext:
    cmp %r15,%r13
    jne printnormal
    add $45,%r15
    mov $stop,%rdi
    decb (%rsp)

    jmp print

    printnormal:

    mov $normal,%rdi 

    print:

    call printf
    inc %r13
    jmp loopy
    
    end_loopy:

    # pop registers
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %rbx

    #epilogue
    mov %rbp, %rsp
    pop %rbp
    ret
    