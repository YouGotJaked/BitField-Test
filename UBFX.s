                .syntax     unified
                .cpu        cortex-m4
                .text
                .thumb_func
                .align      2

// uint32_t UBFX(uint32_t word, uint32_t lsb, uint32_t width) ;

                .global     UBFX            // R0 = word, R1 = lsb, R2 = width
UBFX:           LDR         R3,=1           // R3 <- 1
                LSL         R3,R3,R2        // R3 <- R3 << R2
                SUB         R3,R3,1         // R3 <- R3 - 1
                LSR         R0,R0,R1        // R0 <- R0 << R1
                AND         R0,R0,R3        // R0 <- R0 && R3
                BX          LR              // return
                .end
