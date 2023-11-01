.include "lib/add_smthn_to_big_screen.s"
.include "lib/check_win.s"
.include "lib/clear.s"
// .include "display_data.s"
.include "lib/get_index_from_nr_x_y.s"
.include "lib/get_input.s"
.include "lib/get_val.s"
.include "lib/print_big.s"
.include "lib/print_char_at_small_index.s"
.include "lib/print_small_win.s"
.include "lib/print_win.s"
.include "lib/reset_game.s"
.include "lib/small_to_big_index.s"
.include "lib/welcome_screen.s"
.include "lib/win_screen.s"

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
    