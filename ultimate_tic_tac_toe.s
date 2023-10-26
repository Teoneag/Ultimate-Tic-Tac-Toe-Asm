.include "add_win.s"
.include "addSmthnToBigString.s"
.include "check_win.s"
.include "clear.s"
.include "display_data.s"
.include "get_index_from_nr_x_y.s"
.include "get_input.s"
.include "getVal.s"
.include "init_game.s"
.include "print_char_at_small_index.s"
.include "smallIndexToBigIndex.s"

.data
matrix81: .skip 81              # 9x9 matrix: - for nothing, O for O, X for X
currentPlayer: .byte 'X'        # O for O, X for X
currentSmallMatrix: .int 4      # from 0 to 8, 9 for chose any
currentInput: .int 0            # from 0 to 8, 9 for chose any
matrix9: .skip 9                # 3x3 big matrix: - for nothing, O for O, X for X, D for draw
index81: .int 0                 # from 0 to 80

bigMessage: .skip 800           # big matrix

// nrWinsX: .int 0
// nrWinsO: .int 0

// hasWon:  .int 0

.text
outputEffect: .asciz "\x1b[5m\x1b[38;5;90m\x1b[48;5;208m%c"
outputSimple: .asciz "\x1b[5m\x1b[38;5;90m\x1b[48;5;208m%c"
start: .asciz "\x1b[5m%c"
stop: .asciz "\x1b[0m%c"
normal: .asciz "%c"
newLine: .asciz "\n"
outputNr: .asciz "%ld\n"
outputCharAndSpace: .asciz "%c "
outputCharAndNewLine: .asciz "%c\n"

outputXWon: .asciz "X won!\n\n  "
outputOWon: .asciz "O won!\n\n :)  "
outputDraw: .asciz "Draw. :/\n\n  "
outputWonResult: .asciz "Result of the check_win: %c\n"
outputThisIsMatrix81: .asciz "This is the matrix81: \n"
outputThisIsMatrix9: .asciz "This is the matrix9: \n"
outputYouCanChose: .asciz "You can chose the matrix. Please enter the desired column, row (1, 2 or 3) separated by 1 space, like this: 3 1 \n"
outputEnterColRow: .asciz "Please enter the column, row where you want to place your %c, separated by 1 space, like this: 3 1 \n"
outputCurrentPlayerSqare: .asciz "Current player: %c, square: %ld\n"
outputSqareOccupied: .asciz "This square is already taken. Please chose another one!\n"
outputTableOccupied: .asciz "This table is already taken. Please chose another one!\n"

input2Nr: .asciz "%ld %ld"

defaultBigMessage: .asciz  "   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n                                            \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n                                            \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n"
clearScreen: .string "\x1b[2J"   # ANSI escape code to clear the screen


.global main

main:
    # prologue
    push %rbp
    mov %rsp, %rbp

    initialize_game:
    // call welcome_screen
    // call menu_screen
    call init_game

    # Game starts
    loop_main:
        // call clear
        // call printTitle
        // call printMatrixString
        
        # print board
        mov $bigMessage, %rdi
        xor %rax, %rax
        call printf

        call get_input

        // call display_data 

        movb currentPlayer, %dil
        movl index81, %esi
        call print_char_at_small_index
        
        movl currentSmallMatrix, %edi
        call check_win

        jmp loop_main
    
    // call printOutro


    #epilogue
    mov %rbp, %rsp
    pop %rbp
end:
    mov $0, %rdi
    call exit
    