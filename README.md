<div align = "center">
<pre>
 ___  ___  ___   _________  ___  _____ ______   ________  _________  _______      
|\  \|\  \|\  \ |\___   ___\\  \|\   _ \  _   \|\   __  \|\___   ___\\  ___ \     
\ \  \\\  \ \  \\|___ \  \_\ \  \ \  \\\__\ \  \ \  \|\  \|___ \  \_\ \   __/|    
 \ \  \\\  \ \  \    \ \  \ \ \  \ \  \\|__| \  \ \   __  \   \ \  \ \ \  \_|/__  
  \ \  \\\  \ \  \____\ \  \ \ \  \ \  \    \ \  \ \  \ \  \   \ \  \ \ \  \_|\ \ 
   \ \_______\ \_______\ \__\ \ \__\ \__\    \ \__\ \__\ \__\   \ \__\ \ \_______\
    \|_______|\|_______|\|__|  \|__|\|__|     \|__|\|__|\|__|    \|__|  \|_______|
 _________  ___  ________          _________  ________  ________          _________  ________  _______      
|\___   ___\\  \|\   ____\        |\___   ___\\   __  \|\   ____\        |\___   ___\\   __  \|\  ___ \     
\|___ \  \_\ \  \ \  \___|        \|___ \  \_\ \  \|\  \ \  \___|        \|___ \  \_\ \  \|\  \ \   __/|    
     \ \  \ \ \  \ \  \                \ \  \ \ \   __  \ \  \                \ \  \ \ \  \\\  \ \  \_|/__  
      \ \  \ \ \  \ \  \____            \ \  \ \ \  \ \  \ \  \____            \ \  \ \ \  \\\  \ \  \_|\ \ 
       \ \__\ \ \__\ \_______\           \ \__\ \ \__\ \__\ \_______\           \ \__\ \ \_______\ \_______\
        \|__|  \|__|\|_______|            \|__|  \|__|\|__|\|_______|            \|__|  \|_______|\|_______|
</pre>
<div align = "right">

By [Teodor Neagoe](https://github.com/Teoneag), [Horia Galitianu](https://github.com/horiagali)
</div>
</div>

## 0. Prolog :))
Remember those days when Tic Tac Toe felt a tad too small? Introducing the solution: Ultimate Tic Tac Toe! Now, instead of just 9 squares, you've got... 9 squares. But wait for it, each of those squares is made up of another 9 squares! That's right, it's not just 9 times the fun, it's 81 times the confusion! Tic Tac Toe, now in Super Mega Ultra HD.

## 1. Using example

### a) OS
The game is targeted for Linux (Ubuntu).
- It can be run on Windows using WSL (Windows Subsystem for Linux) - [click here for official instalation guide](https://learn.microsoft.com/en-us/windows/wsl/install).

### b) Terminal
Open the Ubuntu terminal.
* If you use WSL, for the blinking animation to work, we reccomand the Windows terminal application, so run the ubuntu terminal from there using the following command:
```sh
ubuntu
```
* If the folder is on windows, you can use the following command:
```sh
cd /mnt/path/to/folder
```

### c) Compiling
As the compiled file is system specific, you need to complile it yourself. For this you need gcc. If you don't have it, install it by running the following command from the ubuntu terminal, as administrator, or using sudo:
```sh
apt update && apt upgrade -y && apt install build-essential gdb -y
```
Open the ubuntu terminal in the folder where you saved the game, or clone it from Github (for this you need [Git](https://git-scm.com/) installed) using the following command:
```sh
git clone https://github.com/Teoneag/Ultimate_Tic_Tac_Toe_asm.git
```
Compile it using the following commnad:
```sh
gcc -no-pie -o ultimate_tic_tac_toe ultimate_tic_tac_toe.s
```

### d) Running
Run the following command:
```sh
./ultimate_tic_tac_toe
```

### e) Read the rules
### f) Enjoy!

## 2. Rules
- Players: The game is played by two players, X and O, taking alternate turns.
- Initial Move: Player X begins by placing a symbol anywhere on the 9x9 grid.
- Relative Moves: The opponent (Player O) is then compelled to play within the corresponding 3x3 grid. The location of Player X's move dictates the smaller grid where Player O must play.
- Winning a Grid: If a move in a smaller grid results in a win by traditional Tic-Tac-Toe rules (three in a row, vertically, horizontally, or diagonally), the entire smaller grid is awarded to the player in the larger 9x9 grid. Subsequent moves cannot be made within a fully won or fully occupied smaller grid.
- Alternative Play: If a player is directed to a smaller grid that is already won or completely occupied, they have the liberty to choose any available smaller grid for their next move.
- Game Conclusion: The game concludes when a player wins the larger 9x9 grid by securing three smaller grids in a row (vertically, horizontally, or diagonally), or when no further legal moves are available, resulting in a draw.

## 3. Snapshots
<img src="ss\won_screen.png" width="500"/> 

## 4. Testing
### a. Win X
This input should win the game for X:
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
This input should win the game for O:
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
This input should end in a draw:
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

## 5. Implementation
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

## 6. Done
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

## 7. TODO
- Critical
    * make
    * bag get draw when it should be win (Ta + Andrei Ion)
    * add game rules
- Teon
    * reset button
    * shower
    * move ugly strings from main to file
- Gali
    * Art
        - loading screen art - add it to github as well
    * get some b*itches

## 8. Bugs solved
- Rares bug: the print_big function was trashing the value in %r12, so when having a specific input, the program would crash

## 9. Learned
- .fill 81 1 '-' can get seg fault?
- to write conventions before starting
- women don't like when you talk about programming!!!

## 10. Special thanks
- Rares Popa - tester
- Andrei Ion - tester
- TA that signed our project - tester
- Mete - tester
- Gali's mom - "zacusca" provider