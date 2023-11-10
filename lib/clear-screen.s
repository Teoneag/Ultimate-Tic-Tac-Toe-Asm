clear_screen:                      # By Gali
    # Write the escape code to clear the screen
    mov $1, %rdi          # File descriptor 1 (stdout)
    mov $1, %rax          # System call number for write
    mov $EffectClearScreen, %rsi  # Pointer to the clearScreen string
    mov $4, %rdx           # Length of the string
    syscall

    ret
