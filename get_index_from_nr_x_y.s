# Returns the index in the matrix81 from the nr of small matrix, x_small and y_small
# Input: %rdi = nr [0, 8], %rsi = x_small [0, 2], %rdx y_small [0, 2]
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
    
    mov %rsi, %r10       # r10 = x_small
    mov %rdx, %r11       # r11 = y_small

    // %RAX = %RDX : %RAX  / SRC
    // %RDX = %RDX : %RAX % SRC
    # divide nr (rdi) by 3
    mov %rdi, %rax
    xor %rdx, %rdx
    mov $3, %rcx
    div %rcx
    mov %rax, %r8        # r8 = x_big
    mov %rdx, %r9        # r9 = y_big

    # %r10 += %r8 * 3
    add %r8, %r10
    add %r8, %r10
    add %r8, %r10

    # %r11 += %r9 * 3
    add %r9, %r11
    add %r9, %r11
    add %r9, %r11

    # %rax = %r11 * 9
    mov %r11, %rax
    mov $9, %rcx
    xor %rdx, %rdx
    mul %rcx

    # %rax += %r10
    add %r10, %rax

  #epilogue
    mov %rbp, %rsp
    pop %rbp
    ret
