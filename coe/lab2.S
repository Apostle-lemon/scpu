test1:
    addi x1, x0, 1          // pc = 0x 0000 , x1 <- 1
    addi x2, x0, 1          // pc = 0x 0004 , x2 <- 1
    addi x4, x0, 5          // pc = 0x 0008 , x4 <- 5
fibonacci:
    add x3, x1, x2          // pc = 0x 000C , x3 <- x1 + x2 = 2 , x3 <- 8 , x3 <- 34 , x3 <- 144 , x3 <- 610 
    add x1, x2, x3          // pc = 0x 0010 , x1 <- x2 + x3 = 3 , x1 <- 13 , x1 <- 55 , x1 <- 233 , x1 <- 987
    add x2, x1, x3          // pc = 0x 0014 , x2 <- x1 + x3 = 5 , x2 <- 21 , x2 <- 89 , x2 <- 377 , x2 <- 1597
    addi x4, x4, -1         // pc = 0x 0018 , x4 <- x4 - 1 = 4 , x4 <- 3 , x4 <- 2 , x4 <- 1 , x4 <- 0
    bne x0, x4, fibonacci   // pc = 0x 001C , if x4 != 0 then pc <- 0x 000c
    addi x5, x0, 0x63D      // pc = 0x 0020 , x5 <- 0x 63D 
    bne x2, x5, fail        // pc = 0x 0024 , if x2 != 0x 63D then pc <- 0x 0028

test2:
    addi x1, x0, 5          // pc = 0x 0028 , x1 <- 5
    addi x2, x0, 0          // pc = 0x 002C , x2 <- 0
    addi x3, x0, 0x100      // pc = 0x 0030 , x3 <- 0x 100
    addi x5, x0, 4          // pc = 0x 0034 , x5 <- 4
memcpy:
    beq x1, x0, exit1       // pc = 0x 0038 , if x1 == 0 then pc <- 0x 0040
    lw x4, 0(x2)            // pc = 0x 003C , x4 <- mem[0] = 0x12345678 , x4 <- mem[4] = 0x87654321
    sub x4, x4, x3          // pc = 0x 0040 , x4 <- 0x12345578 , x4 <- 0x8765421d
    sw x4, 0(x3)            // pc = 0x 0044 , mem[0x100]<- 0x12345578 , mem[0x104]<- 0x8765421d
    add x2, x2, x5          // pc = 0x 0048 , x2 <- 4 , x2 <- 8
    add x3, x3, x5          // pc = 0x 004C , x3 <- 0x104 , x3 <- 0x108
    addi x1, x1, -1         // pc = 0x 0050 , x1 <- 4 , x1 <- 3
    bne x1, x0, memcpy      // pc = 0x 0054 , if x1 != 0 then pc <- 0x0038
exit1:
    addi x1, x0, 5          // pc = 0x 0058 , x1 <- 5
    addi x2, x0, 0          // pc = 0x 005C , x2 <- 0
    addi x3, x0, 0x100      // pc = 0x 0060 , x3 <- 0x100
    addi x5, x0, 4          // pc = 0x 0064 , x5 <- 4
memcmp:
    beq x1, x0, test3       // pc = 0x 0068 , if x1 == 0 then pc <- 0x
    lw x4, 0(x2)            // pc = 0x 006C , x4 <- mem[0] = 0x12345678 
    sub x4, x4, x3          // pc = 0x 0070 , x4 <- 0x12345578
    lw x6, 0(x3)            // pc = 0x 0074 , x6 <- mem[0x100] = 0x12345578
    add x2, x2, x5          // pc = 0x 0078 , x2 <- 4
    add x3, x3, x5          // pc = 0x 007C , x3 <- 0x104
    addi x1, x1, -1         // pc = 0x 0080 , x1 <- 4
    bne x4, x6, fail        // pc = 0x 0084 , if x4 != x6 then pc <- 0x
    j memcmp                // pc = 0x 0088 , pc <- 0x 0068
    

test3:
    lui x1, 0xDEADB     # 0xDEADB000 // pc = 0x 008C , x1 <- 0xDEADB000
    ori x2, x0, 0xEF    # 0x000000EF // pc = 0x 0090 , x2 <- 0x000000EF
    add x3, x1, x2      # 0xDEADB0EF // pc = 0x 0094 , x3 <- 0xDEADB0EF
    sub x1, x2, x1      # 0x215250EF // pc = 0x 0098 , x1 <- 0x215250EF
    addi x2, x0, 1      # 0x00000001 // pc = 0x 009C , x2 <- 0x00000001
    srl x4, x3, x2      # 0x6F56D877 // pc = 0x 00A0 , x4 <- 0x6F56D877
    and x2, x1, x4      # 0x21525067 // pc = 0x 00A4 , x2 <- 0x21525067
    lui x1, 0x21525     # 0x21525000 // pc = 0x 00A8 , x1 <- 0x21525000
    addi x1, x1, 0x67   # 0x21525067 // pc = 0x 00AC , x1 <- 0x21525067
    bne x2, x1, fail    // pc = 0x 00B0 , if x2 != x1 then pc <- 0x 00B4
    addi x1, x0, 0xbc   // pc = 0x 00B4 , x1 <- 0xbc
    jalr x1, x1, 0      // pc = 0x 00B8 , x1 <- 0x 00BC , pc <- 0x 00BC
    addi x2, x0, 0xbc   // pc = 0x 00BC , x2 <- 0xbc
    bne x1, x2, fail    // pc = 0x 00C0 , if x1 != x2 then pc <- 0x 00C4

pass:
    j pass              // pc = 0x 00C4 , pc <- 0x 00C4


fail:
    j fail
