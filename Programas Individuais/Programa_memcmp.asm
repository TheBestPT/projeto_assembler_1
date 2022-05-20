@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringFirstMemCmp: .fill 100, 1, 0
.balign 4
    insertStringSecondMemCmp: .fill 100, 1, 0
.balign 4
    insertInt: .asciz "Insira um numero: "
.balign 4
    scanInputInt: .asciz "%d"
.balign 4
    insertIntLimiterMemCmp: .fill 50, 1, 0
.balign 4
    resultMemCmp: .asciz "Resultado: %d (3) - tamanhos diferentes, (2) - diferentes, (1) - iguais\n"

@External C fuctions
.global printf
.global scanf

@Code Section
.Section .text
.global main
.arm

main:
PUSH {LR}
    LDR R0, =insertString
    BL printf 
    LDR R0, =scanInputString
    LDR R1, =insertStringFirstMemCmp
    BL scanf

    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringSecondMemCmp
    BL scanf

    LDR R0, =insertInt
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =insertIntLimiterMemCmp
    BL scanf


    LDR R1, =insertStringFirstMemCmp
    LDR R5, =insertStringSecondMemCmp
    LDR R7, =insertIntLimiterMemCmp
    LDRB R7, [R7, #0]
    BL _memcmp
    LDR R0, =resultMemCmp
    BL printf
    MOV R7, #0
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*MEMCMP - O mesmo que strcmp mas em vez de comparar toda a string da se um limite ate onde comparar

    Parametros: 
    R1 - primeira string
    R5 - sergunda string

    Return
    R1 - inteiro (codigo)
 */
_memcmp: 
    PUSH {LR}
    
    LDR R1, =insertStringSecondMemCmp
    BL _strlen
    MOV R6, R2//STR2
    LDR R1, =insertStringFirstMemCmp
    BL _strlen
    MOV R3, R2//STR1
    CMP R3, R6
    MOVNE R1, #3//STRINGS TAMANHOS DIFERENTES
    //MOV R0, R6
    POP {LR}
    BXNE LR
    PUSH {LR}
    MOV R4, #0
    LDR R1, =insertStringFirstMemCmp
    LDR R5, =insertStringSecondMemCmp
    memcmp_loop:
        CMP R7, R4
        MOVEQ R1, #1
        POP {LR}
        BXEQ LR
        PUSH {LR}
        LDRB R6, [R1, R4]
        LDRB R3, [R5, R4]
        CMP R6, R3 
        ADDEQ R4, R4, #1
        BEQ memcmp_loop
        MOV R1, #2
    POP {LR}
    BX LR

_strlen:
    MOV R4, #0//Iterador
        
        strlen_loop:
            LDRB R3, [R1, R4]//Ler array bit a bit R1 string e R4 o iterador
            ADD R4, R4, #1//incrementar iterador
            CMP R3, #0//quando r3 = 0 acabou de ler a string
            BNE strlen_loop

        SUB R2, R4, #1//guarda o tamanho da string em r2
        BX LR

_printString:
    PUSH {R0, R1, LR}
    MOV R1, R0 @ Address
    MOV R0, #1 @ Stdout 

    BL _strlen
    @ String length comes in R2

    MOV R7, #4
    SVC #0
    POP {R0, R1, LR}
    BX LR
