// input: nr 0 -8 in rdi, which square to blink  9 for blink all 10 for blink none
print_matrix:      # By gali ofc     
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

    movl currentSmallMatrix, %edi
    push %rdi  # push the matrix to blink on the stack
    push %rdi  # push the matrix to blink on the stack
    cmp $10,%rdi
    je noBlinkingMF
    cmp $9,%rdi
    jne doNormalStuff
    mov $bigMessage,%r12
    mov $0,%r13  # r13 is index
    mov $EffectStartBlinking,%rdi
    loopShit:
    movb (%r12,%r13,1),%sil
    cmpb $0,%sil
    je end_loopy
    mov $EffectStartBlinking,%rdi

    call printf
    inc %r13
    jmp loopShit

    doNormalStuff:

    jmp ignoore
    noBlinkingMF:
    mov $bigMessage,%r12
    mov $0,%r13  # r13 is index
    mov $OutputChar,%rdi
    loopShit2:
    movb (%r12,%r13,1),%sil
    cmpb $0,%sil
    je end_loopy
    mov $OutputChar,%rdi

    call printf
    inc %r13
    jmp loopShit2
    ignoore:



    

    mov (%rsp),%rdi
    mov $0,%rsi
    call get_index_from_nr_nr
    mov %rax, %r14              # r14 is start, r15 is stop
    mov %r14,%rdi
    call small_to_big_index
    mov %rax,%r14
    dec %r14
    mov (%rsp),%rdi
    mov $2,%rsi
    call get_index_from_nr_nr
    mov %rax,%r15
    mov %r15,%rdi
    call small_to_big_index
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
    mov $EffectStartBlinking,%rdi
    jmp print
    checknext:
    cmp %r15,%r13
    jne printnormal
    add $45,%r15
    mov $EffectStopBlinking,%rdi
    decb (%rsp)

    jmp print

    printnormal:

    mov $OutputChar,%rdi 

    print:

    call printf
    inc %r13
    jmp loopy
    
    end_loopy:
    mov $EffectStopBlinking,%rdi
    mov $' ',%rsi
    call printf
    pop %r15
    pop %r15
    pop %r15
    pop %r15
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
    