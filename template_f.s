.global main
main:
    # prologue
    push %rbp
    mov %rsp, %rbp

    call name_function

    #epilogue
    mov %rbp, %rsp
    pop %rbp
end:
    mov $0, %rdi
    call exit
    
# 
# Input: 
# Output: 
name_function:      # By 
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

    # body

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
    