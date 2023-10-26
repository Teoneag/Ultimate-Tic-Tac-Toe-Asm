
    smallIndexToBigIndex:   # By Gali
                            # has one parameter in rdi, the index of the small matrix  and returns the index of the corresponding
                            # number but in the big output string thingie
    # prologue
    push %rbp
    mov %rsp, %rbp
    push %r11
    push %r12
    # SRC %RDX:%RAX = %RAX * SRC
    # div. SRC %RAX = %RDX:%RAX / SRC Unsigned division.
    #           %RDX = %RDX:%RAX % SRC


    mov %rdi,%r12   # the index gets saved in r12
                    # FORMULA:   Y = i/9*90+i%9/3*3+i%9*4+1     

    # i/9 *2 :
    mov %rdi, %rax     # Copy the value of i to rax
    mov $9, %rcx       # Set the divisor to 9
    xor %rdx,%rdx
    div %rcx           # Divide rax by 9, quotient in rax, remainder in rdx

    mov $90, %rcx       # Set the multiplier to 84
    xor %rdx,%rdx
    mul %rcx           # Multiply rax by 2
    mov %rax,%r11   # r11 = i/9 *90

    # i%9/3*3:
    xor %rdx, %rdx     # Clear rdx to ensure it's zero
    mov %rdi, %rax     # Copy the value of i to rax
    mov $9, %rcx       # Set the divisor to 9
    xor %rdx, %rdx     # Clear rdx to ensure it's zero

    div %rcx           # Divide rax by 9, quotient in rax, remainder in rdx

    mov %rdx, %rdi     # Store the remainder (i%9) in rdi

    mov $3, %rcx       # Set the divisor to 3
    xor %rdx, %rdx     # Clear rdx again
    mov %rdi,%rax
    div %rcx           # Divide rdi by 3, quotient in rax, remainder in rdx
                       # rax = i%9/3
    xor %rdx, %rdx     # Clear rdx again

    mov $3, %rcx       # Set the multiplier to 3
    mul %rcx           # Multiply rax by 3

    mov %rax, %r12     # Store the result (i%9/3*3) in r12

    mov %rdi,%rax
    xor %rdx, %rdx     # Clear rdx again
    mov $4,%rcx
    mul %rcx        # rax = i%9*4
    
    add %r11,%r12   # r12 = i/9 *90 + i%9/3*3
    add %rax,%r12   #r12 = i/9 *90 + i%9/3*3 + i%9*4
    add $1,%r12     #r12 =  i/9 *90 + i%9/3*3 + i%9*4+1
    mov %r12,%rax



     # Store the result in rdi


    pop %r12
    pop %r11
    

    
    #epilogue
    mov %rbp, %rsp
    pop %rbp
    ret

    

  
