# input: character "X" in rdi, big index in rsi, the big message in rdx.
# output: the big string with "X" in the n'th position
add_smthn_to_big_string:        # By Gali    
    # prologue
    push %rbp
    mov %rsp, %rbp

    mov $0, %rcx             # rcx is the index of both input and output strings
    mov $bigMessage, %rax    #rax is the output string

    loop:
        cmpb $0, (%rdx, %rcx, 1)
        je exitt

        cmp %rsi, %rcx
        je atIndex
        movb (%rdx, %rcx, 1), %r8b   # r8 - aux
        movb %r8b, (%rax, %rcx, 1)     # move the characters over
    
        continue:

        inc %rcx
        jmp loop

    exitt:
    #epilogue
    mov %rbp, %rsp
    pop %rbp

    ret

    atIndex:

    movb %dil,(%rax,%rcx,1)  # move the "X" in the output string
    jmp continue
    