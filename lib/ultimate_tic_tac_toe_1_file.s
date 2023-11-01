.data
matrix81: .skip 81              # 9x9 matrix: - for nothing, O for O, X for X
currentPlayer: .byte 'X'        # O for O, X for X
currentSmallMatrix: .int 4      # from 0 to 8, 9 for chose any
currentInput: .int 0            # from 0 to 8, 9 for chose any
matrix9: .skip 9                # 3x3 big matrix: - for nothing, O for O, X for X, D for draw
index81: .int 0                 # from 0 to 80

bigMessage: .skip 800           # big matrix

nrWinsX: .int 0
nrWinsO: .int 0
nrDraws: .int 0


.text
OutputNewLine: .asciz "\n"
OutputNr: .asciz "%ld\n"
OutputChar: .asciz "%c"
OutputCharAndSpace: .asciz "%c "
OutputCharAndNewLine: .asciz "%c\n"
OutputCurrentPlayerSqare: .asciz "Current player: %c\nPlaying on the square: %ld\n\n\n"
OutputHighscores: .asciz "Score:\nX has won: %ld times\nO has won: %ld times\nNr draws: %ld\n\n\n\n"
OutputEnterCoord: .asciz "\nPlease enter the row, col where you want to place your %c, separated by 1 space, like this: 3 1 \n"

EffectStartBlinking: .asciz "\x1b[6m%c"   # 5/6 for blinking - theretically 6 should be fast blinking
EffectStopBlinking: .asciz "\x1b[0m%c"
EffectClearScreen: .asciz "\x1b[2J"
EffectEffect: .asciz "\x1b[5m\x1b[38;5;90m\x1b[48;5;208m%c"
EffectSimple: .asciz "\x1b[5m\x1b[38;5;90m\x1b[48;5;208m%c"

MessageDefaultBig: .asciz  "   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n                                            \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n                                            \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n\n"
MessageXWon: .asciz  "__    ___      ___       __    ________   ________    ___       \n|\\  \\  /  /|    |\\  \\     |\\  \\ |\\   __  \\ |\\   ___  \\ |\\  \\     \n\\ \\  \\/  / /    \\ \\  \\    \\ \\  \\\\ \\  \\|\\  \\\\ \\  \\\\ \\  \\\\ \\  \\     \n \\ \\    / /      \\ \\  \\  __\\ \\  \\\\ \\  \\\\\\  \\\\ \\  \\\\ \\  \\\\ \\  \\    \n  /     \\/        \\ \\  \\|\\__\\_\\  \\\\ \\  \\\\\\  \\\\ \\  \\\\ \\  \\\\ \\__\\   \n /  /\\   \\         \\ \\____________\\\\ \\_______\\\\ \\__\\\\ \\__\\\\|__|   \n/__/ /\\ __\\         \\|____________| \\|_______| \\|__| \\|__|    ___ \n|__|/ \\|__|                                                  |\\__\\\n                                                             \\|__|\n"
MessageOWon: .asciz   "_______          ___       __    ________   ________    ___       \n|\\   __  \\        |\\  \\     |\\  \\ |\\   __  \\ |\\   ___  \\ |\\  \\      \n\\ \\  \\|\\  \\       \\ \\  \\    \\ \\  \\\\ \\  \\|\\  \\\\ \\  \\\\ \\  \\\\ \\  \\     \n \\ \\  \\\\\\  \\       \\ \\  \\  __\\ \\  \\\\ \\  \\\\\\  \\\\ \\  \\\\ \\  \\\\ \\  \\    \n  \\ \\  \\\\\\  \\       \\ \\  \\|\\__\\_\\  \\\\ \\  \\\\\\  \\\\ \\  \\\\ \\  \\\\ \\__\\   \n   \\ \\_______\\       \\ \\____________\\\\ \\_______\\\\ \\__\\\\ \\__\\\\|__|   \n    \\|_______|        \\|____________| \\|_______| \\|__| \\|__|    ___ \n                                                               |\\__\\\n                                                               \\|__|\n"
MessageDraw: .asciz "_______   ________   ________   ___       __    ___       \n|\\   ___ \\ |\\   __  \\ |\\   __  \\ |\\  \\     |\\  \\ |\\  \\      \n\\ \\  \\_|\\ \\\\ \\  \\|\\  \\\\ \\  \\|\\  \\\\ \\  \\    \\ \\  \\\\ \\  \\     \n \\ \\  \\ \\\\ \\\\ \\   _  _\\\\ \\   __  \\\\ \\  \\  __\\ \\  \\\\ \\  \\    \n  \\ \\  \\_\\\\ \\\\ \\  \\\\  \\|\\ \\  \\ \\  \\\\ \\  \\|\\__\\_\\  \\\\ \\__\\   \n   \\ \\_______\\\\ \\__\\\\ _\\ \\ \\__\\ \\__\\\\ \\____________\\\\|__|   \n    \\|_______| \\|__|\\|__| \\|__|\\|__| \\|____________|    ___ \n                                                       |\\__\\\n                                                       \\|__|\n"
MessageWelcome: .asciz "\nRemember those days when Tic Tac Toe felt a tad too small?\nIntroducing the solution: Ultimate Tic Tac Toe! \nNow, instead of just 9 squares, you've got... 9 squares.\nBut wait for it, each of those squares is made up of another 9 squares!\nThat's right, it's not just 9 times the fun, it's 81 times the confusion!\nTic Tac Toe, now in Super Mega Ultra HD.\n\n Press enter to continue ..."
MessageYouCanChose: .asciz "\nYou can chose the matrix. Please enter the desired row, col (1, 2 or 3) separated by 1 space, like this: 3 1 \n"
MessageSqareOccupied: .asciz "This square is not available. Please chose another one!\n"
MessageTableOccupied: .asciz "This table is not availbale. Please chose another one!\n"
MessageAskPlayAgain: .asciz "Do you want to play again? (y/n)\n"
MessageInvalidInput: .asciz "Invalid input. Please try again!\n"
MessageGoodbye: .asciz "\nThank you for playing!\nWe wish you enjoyed the game!\nHere it's the source code of the game: https://github.com/Teoneag/Ultimate_Tic_Tac_Toe_asm \nIf you have any suggestions, please leave them on GitHub!\nGoodbye!\n\n"
// OutputThisIsMatrix81: .asciz "This is the matrix81: \n"
// OutputThisIsMatrix9: .asciz "This is the matrix9: \n"
// OutputDebug: .asciz "Alelulaia: %c\n"

Input2Nr: .asciz "%ld %ld"
InputChar: .asciz "%c"


.global main

main:
    # prologue
    push %rbp
    mov %rsp, %rbp
    
    initialize_game:
    call reset_game
    call welcome_screen

    # Game starts
    loop_main:
        call get_input

        movb currentPlayer, %dil
        movl index81, %esi
        call print_char_at_small_index
        
        movl currentSmallMatrix, %edi
        call check_win
        
        // call display_data

        jmp loop_main

    end_main:
    mov $MessageGoodbye, %rdi
    xor %rax, %rax
    call printf

    #epilogue
    mov %rbp, %rsp
    pop %rbp
end:
    mov $0, %rdi
    call exit
    
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
    

# Input: index: 0 - 8, 9 for matrix9 (%rdi)
# Output: X, O, D, -
check_win:                      # By Teo
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

    push %rdi
    push %rdi

    # if (rdi == 9) coppy matrix9 to registers
    cmp $9, %rdi
    jne copy_values_check_win
    mov $0, %r9
    movb matrix9(%r9), %r10b
    mov $1, %r9
    movb matrix9(%r9), %r11b
    mov $2, %r9
    movb matrix9(%r9), %r12b
    mov $3, %r9
    movb matrix9(%r9), %r13b
    mov $4, %r9
    movb matrix9(%r9), %r14b
    mov $5, %r9
    movb matrix9(%r9), %r15b
    mov $6, %r9
    movb matrix9(%r9), %al
    mov $7, %r9
    movb matrix9(%r9), %bl
    mov $8, %r9
    movb matrix9(%r9), %cl
    jmp end_copy_values_check_win
    
    # if (rdi != 9) copy matrix to registers
    copy_values_check_win: 
        mov %rdi, %r9

        mov %r9, %rdi
        mov $0, %rsi
        call get_val
        movb matrix81(%rax), %r10b
        push %r10                   # save r10

        mov %r9, %rdi
        mov $1, %rsi
        call get_val
        movb matrix81(%rax), %r11b
        push %r11                   # save r11

        mov %r9, %rdi
        mov $2, %rsi
        call get_val
        movb matrix81(%rax), %r12b

        mov %r9, %rdi
        mov $3, %rsi
        call get_val
        movb matrix81(%rax), %r13b

        mov %r9, %rdi
        mov $4, %rsi
        call get_val
        movb matrix81(%rax), %r14b

        mov %r9, %rdi
        mov $5, %rsi
        call get_val
        movb matrix81(%rax), %r15b

        mov %r9, %rdi
        mov $6, %rsi
        call get_val
        movb matrix81(%rax), %al
        push %rax               # save rax

        mov %r9, %rdi
        mov $7, %rsi
        call get_val
        movb matrix81(%rax), %bl

        mov %r9, %rdi
        mov $8, %rsi
        call get_val
        movb matrix81(%rax), %cl
        push %rcx               # save rcx
        // pop
        pop %rcx
        pop %rax
        pop %r11
        pop %r10
    end_copy_values_check_win:


    case_0_check_win:   # 0 1 2
        mov %r10b, %r8b
        cmpb $'-', %r10b
        je case_1_check_win
        cmp %r10b, %r11b
        jne case_1_check_win
        cmp %r10b, %r12b
        je win_check_win

    case_1_check_win:   # 3 4 5
        mov %r13b, %r8b
        cmpb $'-', %r13b
        je case_2_check_win
        cmp %r13b, %r14b
        jne case_2_check_win
        cmp %r13b, %r15b
        je win_check_win

    case_2_check_win:   # 6 7 8
        mov %al, %r8b
        cmpb $'-', %al
        je case_3_check_win
        cmp %al, %bl
        jne case_3_check_win
        cmp %al, %cl
        je win_check_win

    case_3_check_win:    # 0 3 6
        mov %r10b, %r8b
        cmpb $'-', %r10b
        je case_4_check_win
        cmp %r10b, %r13b
        jne case_4_check_win
        cmp %r10b, %al
        je win_check_win

    case_4_check_win:    # 1 4 7
        mov %r11b, %r8b
        cmpb $'-', %r11b
        je case_5_check_win
        cmp %r11b, %r14b
        jne case_5_check_win
        cmp %r11b, %bl
        je win_check_win

    case_5_check_win:    # 2 5 8
        mov %r12b, %r8b
        cmpb $'-', %r12b
        je case_6_check_win
        cmp %r12b, %r15b
        jne case_6_check_win
        cmp %r12b, %cl
        je win_check_win

    case_6_check_win:    # 0 4 8
        mov %r10b, %r8b
        cmpb $'-', %r10b
        je case_7_check_win
        cmp %r10b, %r14b
        jne case_7_check_win
        cmp %r10b, %cl
        je win_check_win

    case_7_check_win:    # 2 4 6
        mov %r12b, %r8b
        cmpb $'-', %r12b
        je case_8_check_win
        cmp %r12b, %r14b
        jne case_8_check_win
        cmp %r12b, %al
        je win_check_win

    case_8_check_win:    # draw
        cmp $'-', %r10b
        je no_win_check_win
        cmp $'-', %r11b
        je no_win_check_win
        cmp $'-', %r12b
        je no_win_check_win
        cmp $'-', %r13b
        je no_win_check_win
        cmp $'-', %r14b
        je no_win_check_win
        cmp $'-', %r15b
        je no_win_check_win
        cmp $'-', %al
        je no_win_check_win
        cmp $'-', %bl
        je no_win_check_win
        cmp $'-', %cl
        je no_win_check_win
    
        jmp draw_check_win

    
    
    win_check_win:
        movb %r8b, %r12b
        jmp final_check_win

    draw_check_win:
        movb $'D', %r12b
        jmp final_check_win

    no_win_check_win:
        movb $'-', %al
        jmp epilogue_check_win



    final_check_win:

    cmp $9, %rdi
    jne modify_matrix9_check_win
    # if (rdi == 9) return 'X' or 'O or 'D' to %rax
    mov %r12b, %al
    jmp epilogue_check_win

    # else mattrix9(rdi) = rar12b
    modify_matrix9_check_win:
    mov (%rsp), %rdi
    movb %r12b, matrix9(%rdi)     # matrix9(rdi) = rax

    # colour the values in matrix81
    movb %r12b, %dil        # rdi = character that won
    movb (%rsp), %sil       # rsi = 0 - 8 unde dai print_small_win 
    call print_small_win

    # check win for matrix9
    mov $9, %rdi
    call check_win
    mov %rax, %r13


    # if (al == 'X' || al == 'O') call win_screen
    mov %r13, %rax
    cmpb $'X', %al
    je win_screen_check_win
    cmpb $'O', %al
    je win_screen_check_win
    cmpb $'D', %al
    je win_screen_check_win
    jmp end_win_screen_check_win
    win_screen_check_win:
    mov %rax, %rdi
    call win_screen
    jmp epilogue_check_win
    end_win_screen_check_win:

    epilogue_check_win:
    # pop registers
    pop %rdi
    pop %rdi
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
    


clear:                      # By Gali
    # Write the escape code to clear the screen
    mov $1, %rdi          # File descriptor 1 (stdout)
    mov $1, %rax          # System call number for write
    mov $EffectClearScreen, %rsi  # Pointer to the clearScreen string
    mov $4, %rdx           # Length of the string
    syscall

    ret


# Returns the index in the matrix81 from the nr of small matrix, row and col
# Input: %rdi = nr [0, 8], %rsi = row [0, 2], %rdx col [0, 2]
# Output: index [0, 80]
//  0  1  2 |  3  4  5 |  6  7  8
//  9 10 11 | 12 13 14 | 15 16 17
// 18 19 20 | 21 22 23 | 24 25 26
// ------------------------------
// 27 28 29 | 30 31 32 | 33 34 35
// 36 37 38 | 39 40 41 | 42 43 44
// 45 46 47 | 48 49 50 | 51 52 53
// ------------------------------
// 54 55 56 | 57 58 59 | 60 61 62
// 63 64 65 | 66 67 68 | 69 70 71
// 72 73 74 | 75 76 77 | 78 79 80

// 0 1 2 -> x
// 0  0 1 2
// 1  3 4 5
// 2  6 7 8
// y

# x_big = nr / 3
# y_big = nr % 3

# x = x_big * 3 + x_small
# y = y_big * 3 + y_small

# index = x + y * 9

get_index_from_nr_x_y:        # By Teo
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

    # calculate value [0, 8] from row, col
	mov %rdx, %r12
	add %rsi, %r12
	add %rsi, %r12
	add %rsi, %r12



	# call get_val
	mov %r12, %rsi
	call get_val

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
  


# get input from user (simple or complex)
# saves in the matrix81
# updates the currentPlayer
# updates the currentSmallMatrix
get_input:                      # By Teo
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

    # update the currentPlayer
    cmpb $'X', currentPlayer
    je set_O
    movb $'X', currentPlayer
    jmp end_set_O
    set_O:
    movb $'O', currentPlayer
    end_set_O:

    # update the currentSmallMatrix
    movl currentInput, %r12d
    movl %r12d, currentSmallMatrix


    # if (matrix9[currentSmallMatrix] != '-') currentSmallMatrix = 9
    movb matrix9(%r12), %r13b
    cmpb $'-', %r13b
    jne set_9
    jmp end_set_9
    set_9:
    movl $9, currentSmallMatrix
    end_set_9:

    # check if the currentSmallMatrix is 9
    cmpl $9, currentSmallMatrix
    jne get_simple_input

    # get complex input
    get_complex_input:
        call clear
        mov $OutputHighscores,%rdi
        movl nrWinsX, %esi
        movl nrWinsO, %edx
        movl nrDraws, %ecx
        call printf
        
        mov $OutputCurrentPlayerSqare, %rdi
        movb currentPlayer, %sil
        movl currentSmallMatrix, %edx
        incl %edx
        xor %rax, %rax
        call printf
        call print_big
        # ask user for the 2 nr
        mov $MessageYouCanChose, %rdi
        xor %rax, %rax
        call printf

        # read 2 nr
        subq $16, %rsp          # make room for 1st, 2nd nr
        lea -8(%rbp), %rsi      # address of 1st nr
        lea -16(%rbp), %rdx     # address of 2nd nr
        mov $Input2Nr, %rdi     # format string
        xor %rax, %rax          # clear rax
        call scanf              # read 1st nr
        mov -8(%rbp), %r12      # save 1st nr in %r12 (row)
        dec %r12                # [1, 3] -> [0, 2]
        mov -16(%rbp), %r13     # save 2nd nr in %r13 (col)
        dec %r13                # [1, 3] -> [0, 2]
        addq $16, %rsp          # restore stack

        # if %r12 < 0 || %r12 > 2 || %r13 < 0 || %r13 > 2 ask again
        cmp $0, %r12
        jl try_again_output
        cmp $2, %r12
        jg try_again_output
        cmp $0, %r13
        jl try_again_output
        cmp $2, %r13
        jg try_again_output

        # update the currentSmallMatrix = %r13 + %r12 * 3
        movl %r13d, currentSmallMatrix
        addl %r12d, currentSmallMatrix
        addl %r12d, currentSmallMatrix
        addl %r12d, currentSmallMatrix




    # if (matrix9[currentSmallMatrix] != '-') ask again
    # calculate index: r12 * 3 + r13
    mov %r13, %r14
    add %r12, %r14
    add %r12, %r14
    add %r12, %r14

    cmpb $'-', matrix9(%r14)
    je get_simple_input
    # print Table already occupied, please chose another one!
    try_again_output:
    mov $MessageTableOccupied, %rdi
    xor %rax, %rax
    call printf
    jmp get_complex_input

    get_simple_input:
        call clear
    get_simple_input_without_clear:
        mov $OutputHighscores,%rdi
        movl nrWinsX, %esi
        movl nrWinsO, %edx
        movl nrDraws, %ecx
        call printf
        # print the current player
        mov $OutputCurrentPlayerSqare, %rdi
        movb currentPlayer, %sil
        movl currentSmallMatrix, %edx
        incl %edx
        xor %rax, %rax
        call printf

        call print_big

        # ask user for 2 nr
        mov $OutputEnterCoord, %rdi
        movb currentPlayer, %sil
        xor %rax, %rax
        call printf
        
        # read 2 nr
        subq $16, %rsp          # make room for 1st, 2nd nr
        lea -8(%rbp), %rsi      # address of 1st nr
        lea -16(%rbp), %rdx     # address of 2nd nr
        mov $Input2Nr, %rdi     # format string
        xor %rax, %rax          # clear rax
        call scanf              # read 1st nr
        mov -8(%rbp), %r12      # save 1st nr in %r12 (row)
        dec %r12                # [1, 3] -> [0, 2]
        mov -16(%rbp), %r13     # save 2nd nr in %r13 (col)
        dec %r13                # [1, 3] -> [0, 2]


    # get the index of the matrix81
    movl currentSmallMatrix, %edi   # nr
    mov %r12, %rsi                  # col
    mov %r13, %rdx                  # row
    call get_index_from_nr_x_y      # index is in %rax
    movl %eax, index81
    
    # if %r12 < 0 || %r12 > 2 || %r13 < 0 || %r13 > 2 ask again
    cmp $0, %r12
    jl try_again_output_2
    cmp $2, %r12
    jg try_again_output_2
    cmp $0, %r13
    jl try_again_output_2
    cmp $2, %r13
    jg try_again_output_2

    # if (matrix81[nr][x][y] != '-') ask again
    cmpb $'-', matrix81(%rax)
    je update_get_input
    # print Sqare already occupied, please chose another one
    try_again_output_2:
    call clear
    mov $MessageSqareOccupied, %rdi
    xor %rax, %rax
    call printf
    jmp get_simple_input_without_clear

    update_get_input:
    # update matrix81(%rax) to %r14
    movb currentPlayer, %r14b           # move char to %r14
    movb %r14b, matrix81(%rax)          

    # update the currentInput = %r13 + %r12 * 3
    movl %r13d, currentInput
    addl %r12d, currentInput
    addl %r12d, currentInput
    addl %r12d, currentInput

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



# input: 0 - 8  what matrix to look at    0 - 8 what square to look at
# output: the small index (rax)
get_val:         # By Gali
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
    

// input: nr 0 -8 in rdi, which square to blink  9 for blink all 10 for blink none
print_big:      # By gali ofc     
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
    call get_val
    mov %rax, %r14              # r14 is start, r15 is stop
    mov %r14,%rdi
    call small_to_big_index
    mov %rax,%r14
    dec %r14
    mov (%rsp),%rdi
    mov $2,%rsi
    call get_val
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
    

# Puts the char in the bigString giving the smallIndex
# Input: char ('X', 'O', ' '), index [0, 80]
print_char_at_small_index:      # By Teon
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

    movb %dil, %r12b
    
    mov %rsi, %rdi
    call small_to_big_index

    movb %r12b, %dil
    mov %rax, %rsi
    mov $bigMessage, %rdx
    call add_smthn_to_big_string 

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
    

# Writes O or X in the smallMatrix
# Input: char ('X'/'O'); nr [0, 8] of the smallMatrix
# TODO: implement draw
print_small_win:      # By Teo
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

    // # print outputThisIsMatrix81
    // mov $outputThisIsMatrix81, %rdi
    // xor %r8, %r8
    // call printf

    # save indexes of the smallMatrix
    mov %rsi, %r12          # r12 = nr = index of the smallMatrix


    cmpb $'O', %dil
    je print_O_add_win
    cmpb $'X', %dil
    je print_X_add_win
    jmp print_D_add_win

    # if %rdi == 'O'
    print_O_add_win:

    # O O O
    # O   O
    # O O O
    # 0
    mov %r12, %rdi
    mov $0, %rsi
    call get_val
    
    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 1
    mov %r12, %rdi
    mov $1, %rsi
    call get_val

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 2
    mov %r12, %rdi
    mov $2, %rsi
    call get_val

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 3
    mov %r12, %rdi
    mov $3, %rsi
    call get_val

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 4
    mov %r12, %rdi
    mov $4, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 5
    mov %r12, %rdi
    mov $5, %rsi
    call get_val

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 6
    mov %r12, %rdi
    mov $6, %rsi
    call get_val

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 7
    mov %r12, %rdi
    mov $7, %rsi
    call get_val

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 8
    mov %r12, %rdi
    mov $8, %rsi
    call get_val

    movb $'O', matrix81(%rax)
    movb $'O', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    jmp end_add_win

    # if %rdi == 'X'
    print_X_add_win:
    # X   X
    #   X
    # X   X
    
    # 0
    mov %r12, %rdi
    mov $0, %rsi
    call get_val

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 1
    mov %r12, %rdi
    mov $1, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 2
    mov %r12, %rdi
    mov $2, %rsi
    call get_val

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 3
    mov %r12, %rdi
    mov $3, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 4
    mov %r12, %rdi
    mov $4, %rsi
    call get_val

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 5
    mov %r12, %rdi
    mov $5, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 6
    mov %r12, %rdi
    mov $6, %rsi
    call get_val

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 7
    mov %r12, %rdi
    mov $7, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 8
    mov %r12, %rdi
    mov $8, %rsi
    call get_val

    movb $'X', matrix81(%rax)
    movb $'X', %dil
    mov %rax, %rsi
    call print_char_at_small_index
    jmp end_add_win
    
    print_D_add_win:
    # D D
    # D   D
    # D D
    # 0
    mov %r12, %rdi
    mov $0, %rsi
    call get_val

    movb $'D', matrix81(%rax)
    movb $'D', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 1
    mov %r12, %rdi
    mov $1, %rsi
    call get_val

    movb $'D', matrix81(%rax)
    movb $'D', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 2
    mov %r12, %rdi
    mov $2, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 3
    mov %r12, %rdi
    mov $3, %rsi
    call get_val

    movb $'D', matrix81(%rax)
    movb $'D', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 4
    mov %r12, %rdi
    mov $4, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 5
    mov %r12, %rdi
    mov $5, %rsi
    call get_val

    movb $'D', matrix81(%rax)
    movb $'D', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 6
    mov %r12, %rdi
    mov $6, %rsi
    call get_val

    movb $'D', matrix81(%rax)
    movb $'D', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 7
    mov %r12, %rdi
    mov $7, %rsi
    call get_val

    movb $'D', matrix81(%rax)
    movb $'D', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    # 8
    mov %r12, %rdi
    mov $8, %rsi
    call get_val

    movb $'-', matrix81(%rax)
    movb $' ', %dil
    mov %rax, %rsi
    call print_char_at_small_index

    end_add_win:



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
    

print_win:   # input:  a chard in rdi   O - O won  X - X won   - - Draw  
    # prologue    by Gali ofc
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


    cmpb $'X',%r12b
    jne checkO
    movq $MessageXWon,%r13
    movl nrWinsX, %ecx
    incl %ecx
    movl %ecx, nrWinsX 
    jmp gotoloop
    checkO:
    cmpb $'O',%r12b
    jne draw
    movq $MessageOWon,%r13
    movl nrWinsO, %ecx
    incl %ecx
    movl %ecx, nrWinsO
    jmp gotoloop
    draw:
    movl nrDraws, %ecx
    incl %ecx
    movl %ecx, nrDraws
    movq $MessageDraw,%r13

    gotoloop:
    mov $0,%rbx

    mov $EffectStartBlinking,%rdi
    mov $'_',%rsi
    call printf

    loop1:
  
    movb (%r13, %rbx,1),%r15b  # r15 character being printed
    cmpb $0,%r15b
    je terminaFA

    mov $OutputChar,%rdi
    mov %r15,%rsi

    call printf

    inc %rbx
    jmp loop1
    terminaFA:

     mov $EffectStopBlinking,%rdi
    mov $'_',%rsi
    call printf

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
    

# Initializes the
    # matrix81 and the matrix9 with '-'
    # currentPlayer with 'X' 
    # currentSmallMatrix with 4
    # move MessageDefaultBig in bigMessage
reset_game:                      # By Teo
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

    # initialize matrix81 wiht '-'
    mov $0, %r12        # i = 0
    start_loop_init_game:
        movb $'-', matrix81(%r12)   # matrix81[i] = '-'
        inc %r12                    # i++
        cmp $81, %r12               # i < 81
        jne start_loop_init_game    # jump if not equal

    # initialize matrix9 with '-'
    mov $0, %r12        # i = 0
    start_loop_2_init_game:
        movb $'-' , matrix9(%r12)    # matrix9[i] = '-'
        inc %r12                    # i++
        cmp $9, %r12                # i < 9
        jne start_loop_2_init_game  # jump if not equal

    # initialize currentPlayer with 'O' (The init switches it)
    movb $'O', currentPlayer

    # initialize currentInput (The init makes the currentSmallMatrix 4)
    movl $9, currentInput

    # initialize currentSmallMatrix with 9
    movl $9, currentSmallMatrix

    # initialize bigMessage with MessageDefaultBig
    mov $MessageDefaultBig, %r12
    mov $0, %r13        # i = 0
    start_loop_3_init_game:
        mov (%r12), %r14                 # r14 = r12
        movb %r14b, bigMessage(%r13)   # bigMessage[i] = MessageDefaultBig[i]
        inc %r12                        # i++
        inc %r13                        # i++
        cmp $765, %r13                   # i < 81
        jne start_loop_3_init_game      # jump if not equal


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
    


    small_to_big_index:   # By Gali
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

    

  

welcome_screen:      # By Gali ofc
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

    call clear

    mov $MessageWelcome,%rdi
    call printf

    call scanf

    call clear

    mov $OutputHighscores,%rdi
    movl nrWinsX, %esi
    movl nrWinsO, %edx
    movl nrDraws, %ecx
    call printf

    call print_big

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
    

# Prints the win screen
# Input: 1 char: 'X' / 'O' / 'D' (%rdi) 
win_screen:      # By Teo
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

    # save input in %r12
    mov %rdi, %r12

    call clear

    movl $10, currentSmallMatrix

    call print_big

    mov %r12, %rdi
    call print_win
    
    // call scanf              # wait for input
    # TODO wait for user input to display next things

    # ask the player if you want to play again
    mov $MessageAskPlayAgain, %rdi
    xor %rax, %rax
    call printf

    take_player_input_win_screen:
    # take the player's input
    mov $InputChar, %rdi
    sub $16, %rsp
    lea -8(%rbp), %rsi
    xor %rax, %rax
    call scanf

    # if the player input is y play again
    movb -8(%rbp), %dil
    cmpb $'y', %dil
    je initialize_game

    # if the player input is n exit
    movb -8(%rbp), %dil
    cmpb $'n', %dil
    je end_main

    # if the player input is not y or n ask again
    # TODO ask only once if the player input is invalid
    // mov $outputInvalidInput, %rdi
    // xor %rax, %rax
    // call printf
    jmp take_player_input_win_screen

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
    