                .syntax     unified
                .cpu        cortex-m4
                .text
                .thumb_func
                .align      2

// uint32_t BFI(uint32_t word, uint32_t value, uint32_t lsb, uint32_t width) ;

                .global     BFI             // R0 = word, R1 = value, R2 = lsb, R3 = width
BFI:            PUSH        {R4,R5,R6}
                LDR         R4,=1           // R4 <- 1 [mask]
                LDR         R5,=1           // R5 <- 1 [mask]
                ADD         R6,R2,R3        // R6 <- R2 + R3 [lsb + width]
                LSL         R4,R4,R6        // R4 <- R4 << R6 [1 << (lsb + width)]
                LSL         R5,R5,R2        // R5 <- R5 << R2 [1 << lsb]
                SUB         R4,R4,R5        // R4 <- R4 - R5 [(1 << (lsb + width)) - (1 << lsb)]
                MVN         R4,R4           // R4 <- ~R4
                AND         R0,R0,R4        // R0 <- R0 && R1
                LDR         R5,=1           // R5 <- 1 [mask]
                LSL         R5,R5,R3        // R5 <- R5 << R3 [1 << width]
                SUB         R4,R5,1         // R4 <- R5 - 1 [(1 << width) - 1]
                AND         R1,R1,R4        // R1 <- R1 && R4 [value && mask]
                LSL         R1,R1,R2        // R1 <- R1 << R2 [value << lsb]
                ORR         R0,R0,R1        // R0 <- R0 || R1 [R0 = word]
                POP         {R4,R5,R6}
                BX          LR              // return
                .end

