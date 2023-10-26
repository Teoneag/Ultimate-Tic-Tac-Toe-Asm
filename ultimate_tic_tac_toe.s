.include "init_game.s"
.include "get_input.s"
.include "check_win.s"
.include "display_data.s"
.include "smallIndexToBigIndex.s"
.include "addSmthnToBigString.s"
.include "clear.s"

.data
matrix81: .skip 81              # 9x9 matrix: - for nothing, O for O, X for X
currentPlayer: .byte 'X'        # O for O, X for X
currentSmallMatrix: .int 4      # from 0 to 8, 9 for chose any
currentInput: .int 0            # from 0 to 8, 9 for chose any
matrix9: .skip 9                # 3x3 big matrix: - for nothing, O for O, X for X, D for draw
index81: .int 0                 # from 0 to 80
bigMessage: .skip 800           # big matrix
clear_screen: .string "\x1b[2J"   # ANSI escape code to clear the screen

// nrWinsX: .int 0
// nrWinsO: .int 0

// hasWon:  .int 0

.text
wonResult: .asciz "Result of the check_win: %c\n"
outputCharAndSpace: .asciz "%c "
outputCharAndNewLine: .asciz "%c\n"
outputNr: .asciz "%ld\n"
outputThisIsMatrix81: .asciz "This is the matrix81: \n"
outputThisIsMatrix9: .asciz "This is the matrix9: \n"
outputYouCanChose: .asciz "You can chose the matrix. Please enter the desired column, row (1, 2 or 3) separated by 1 space, like this: 3 1 \n"
outputEnterColRow: .asciz "Please enter the column, row where you want to place your %c, separated by 1 space, like this: 3 1 \n"
newLine: .asciz "\n"
input2Nr: .asciz "%ld %ld"
defaultBigMessage: .asciz  "   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n                                            \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n                                            \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n---|---|---    ---|---|---    ---|---|---   \n   |   |          |   |          |   |      \n"


.global main

main:
    # prologue
    push %rbp
    mov %rsp, %rbp

    initialize_game:
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

        call get_input  # should also clarify where you are about to play

        // call check_win

        movl index81, %edi 
        call smallIndexToBigIndex
        
        mov currentPlayer, %rdi
        mov %rax, %rsi
        mov $bigMessage, %rdx
        call addSmthnToBigString    # (character "X", big index, the big message) -> the big string with "X" in the n'th position
        
        jmp loop_main
    
    // call printOutro


    #epilogue
    mov %rbp, %rsp
    pop %rbp
end:
    mov $0, %rdi
    call exit
    