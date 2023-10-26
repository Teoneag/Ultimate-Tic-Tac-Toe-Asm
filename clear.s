clear:                      # By Gali
    # Write the escape code to clear the screen
    mov $1, %rdi          # File descriptor 1 (stdout)
    mov $1, %rax          # System call number for write
    mov $clear_screen, %rsi  # Pointer to the clear_screen string
    mov $4, %rdx           # Length of the string
    syscall

    ret
