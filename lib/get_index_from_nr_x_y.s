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



	# call get_index_from_nr_nr
	mov %r12, %rsi
	call get_index_from_nr_nr

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
  