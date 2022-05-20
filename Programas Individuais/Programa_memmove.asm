@Data Section
.data
.balign 4
    insertStringToMoveMemMove: .fill 100, 1, 0
.balign 4
    insertStringToReplaceMemMove: .fill 100, 1, 0
.balign 4
    messageStringToMoveMemMove: .asciz "Insira uma string para ser movida: "
.balign 4
    messageStringToReplaceMemMove: .asciz "Insira uma string para ser modificada: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4


@External C functions
.global printf
.global scanf

@Code Section
.Section .text
.global main
.arm

main:
PUSH {LR}
    LDR R0, =messageStringToMoveMemMove
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringToMoveMemMove
    BL scanf

    LDR R0, =messageStringToReplaceMemMove
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringToReplaceMemMove
    BL scanf

    LDR R1, =insertStringToMoveMemMove
    BL _strlen
    LDR R1, =insertStringToReplaceMemMove
    LDR R3, =insertStringToMoveMemMove
    BL _memmove
    MOV R1, R0
    BL _printString
    POP {LR}


_exit:
    MOV R7, #1
    SVC #0 @InvoqueSyscall

_strlen:
    MOV R4, #0//Iterador
        
        strlen_loop:
            LDRB R3, [R1, R4]//Ler array bit a bit R1 string e R4 o iterador
            ADD R4, R4, #1//incrementar iterador
            CMP R3, #0//quando r3 = 0 acabou de ler a string
            BNE strlen_loop

        SUB R2, R4, #1//guarda o tamanho da string em r2
        BX LR

/*  MEMMOVE - Mover str1 para str2  

    Parametros: 
    R1 - string que vai ser substituida
    R5 - string que vai ser movida
    Return:
    R0 - string movida
*/

_memmove:
    MOV R4, #0//Iterador
    memmove_loop:
        LDRB R5, [R3, R4]
        STRB R5, [R1, R4]
        ADD R4, #1
        CMP R4, R2
        BNE memmove_loop
        MOV R0, R1
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
