# input: 0 - 8  what matrix to look at    0 - 8 what square to look at
# output: the index (rax)
getVal:         # By Gali
    # prologue
    push %rbp
    mov %rsp, %rbp

    # push registers
    push %rbx  #SRC %RAX = %RDX:%RAX / SRC Unsigned division.
    push %rbx  #    %RDX = %RDX:%RAX % SRC
    push %r12
    push %r13
    push %r14
    push %r15

    mov %rdi,%r12  # what matrix to look at
    mov %rsi,%r14  # what square to look at
    xor %rdx,%rdx
    mov %r12,%rax
    mov $3,%rcx
    div %rcx       # X/3 in rax,  x%3 in rdx
    mov %rdx,%r13
    mov $27,%rcx
    xor %rdx,%rdx
    mul %rcx  # X/3*27 in rax
    mov %rax,%r12   # X/3*27 in r12
    mov %r13,%rax
    mov $3,%rcx
    xor %rdx,%rdx
    mul %rcx       # x%3*3 in r13
    mov %rax,%r13
    add %r13,%r12  # r12 is X/3*27 + x%3*3
    mov %r12,%r15

    mov %r14,%r12
    xor %rdx,%rdx
    mov %r12,%rax
    mov $3,%rcx
    div %rcx       # y/3 in rax,  y%3 in r13
    mov %rdx,%r13
    mov $9,%rcx
    xor %rdx,%rdx
    mul %rcx  # y/3*9 in rax
    mov %rax,%r12   # y/3*9 in r12
    add %r13,%r12  # r12 is y/3*9 + y%3   BUN
    add %r12,%r15 # X/3*27 + x%3*3 + y/3*9 + y%3  in r15
    mov %r15,%rax # output


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
    