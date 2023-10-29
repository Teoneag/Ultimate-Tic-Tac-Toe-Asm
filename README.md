# Assembly Game
# - Ultimate Tic Tac Toe -
## Teodor Neagoe, Horia Galitianu

## 0. Prolog :))
Remember those days when Tic Tac Toe felt a tad too small? Introducing the solution: Ultimate Tic Tac Toe! Now, instead of just 9 squares, you've got... 9 squares. But wait for it, each of those squares is made up of another 9 squares! That's right, it's not just 9 times the fun, it's 81 times the confusion! Tic Tac Toe, now in Super Mega Ultra HD.

## 1. Team
I’m going to be working on this game with Horia Galitianu.
## 2. OS
The game will be targeted for Linux (Ubuntu).
## 3. Libraries
We’ll take on the challenge to make the game without using any libraries.
## 4. Graphics
The game will have an old school vibe, so it will be rendered on the terminal, using the ASCII characters. 
## 5. Rules
- Players: The game is played by two players, X and O, taking alternate turns.
- Initial Move: Player X begins by placing a symbol anywhere on the 9x9 grid.
- Relative Moves: The opponent (Player O) is then compelled to play within the corresponding 3x3 grid. The location of Player X's move dictates the smaller grid where Player O must play.
- Winning a Grid: If a move in a smaller grid results in a win by traditional Tic-Tac-Toe rules (three in a row, vertically, horizontally, or diagonally), the entire smaller grid is awarded to the player in the larger 9x9 grid. Subsequent moves cannot be made within a fully won or fully occupied smaller grid.
- Alternative Play: If a player is directed to a smaller grid that is already won or completely occupied, they have the liberty to choose any available smaller grid for their next move.
- Game Conclusion: The game concludes when a player wins the larger 9x9 grid by securing three smaller grids in a row (vertically, horizontally, or diagonally), or when no further legal moves are available, resulting in a draw.

## 6. Running guide
### a. Open ubuntu
### b. Save folder
### c. Go to folder and run
- gcc -no-pie -o ultimate_tic_tac_toe ultimate_tic_tac_toe.s; ./ultimate_tic_tac_toe
### d. Enjoy

## 7. Testing
### a. Win X
- this input should win the game for X:
2 2
1 1
2 2
1 2
2 2
1 3
2 1
1 1
2 1
1 2
2 1
1 3
2 3
3 1
2 3
3 2
2 3
3 3

### b. Win O
- this input should win the game for O:
1 1
2 2
3 3
2 2
3 2
2 2
3 1
2 1
1 1
2 1
1 2
2 1
1 3
2 3
3 1
2 3
3 2
2 3
3 3

### c. Draw
- this input should end in a draw:
2 2
2 2
1 1
2 2
2 1
2 2
1 3
2 2
2 3
2 2
3 2
1 1
3 3
3 3
2 2
1 2
2 2
3 1
2 2
3 3
1 1
1 1
1 2
3 3
1 2
1 1
2 1
1 1
1 3
1 1
3 2
2 2
3 2
3 3
1 3
3 3
3 2
1 3
1 2
2 1
3 3
1 3
1 3
1 1
2 3
1 3
3 1
1 1
1 2
1 3
1 3
3 1
3 3
3 1
2 3
3 1
1 2
2 3
1 1
2 3
1 2
2 3
2 1
3 2
3 1
3 2
2 3
2 3
3 1
2 1
3 1
2 3
1 3
1 3
3 3
2 1
3 2
3 3
2 1
1 3
2 3

## Implementation
The game will store the following data
### General data
- Wins X
- Wins O
### Current game state
- current turn
0 value: no value
-1: O
1: X
- the matrix of the “big” table: 3x3 (an array in memory)
- a matrix for the smaller squares: 9x9
    * coords_to_index(x, y) = 9 * (x - 1) + y
### Current game display
- String: for all characters on the screen
    3 * 5 * 11 * 

The table will be displayed at all time, bellow who’s player’s turn it is, and bellow you can enter the desired position where you want to place your X/O

The game will wait for user input, when typed it will check whether somebody won.

## Done
- Teon
    * check_win
    * display_data
    * get_index_from_nr_x_y
    * get_input
    * print_char_at_small_index
    * print_small_win
    * reset_game
    * win_screen
    * main.s
- Gali
    * add_smth_to_big_string
    * clear
    * get_val
    * print_big
    * print_win
    * small_to_big_index
    * welcome_screen

## TODO
- Teon
    * shower
- Gali
    * Art
    * get some bitches

## Bugs solved
- Rares bug: the print_big function was trashing the value in %r12, so when having a specific input, the program would crash

## Learned
- .fill 81 1 '-' can get seg fault?
- to write conventions before starting
- women don't like when you talk about programming!!!

## Special thanks
Rares Popa - tester