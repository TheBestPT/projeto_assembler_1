@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s" 
.balign 4
    insertStringMemSet: .fill 100, 1, 0
.balign 4
    insertChar: .asciz "Insira um carater: "
.balign 4
    insertCharMemSet: .fill 100, 1, 0
.balign 4
    insertInt: .asciz "Insira um número: "
.balign 4
    scanInputInt: .asciz "%d"
.balign 4
    insertIntMemSet: .fill 50, 1, 0

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
    LDR R1, =insertStringMemSet
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertCharMemSet
    BL scanf

    LDR R0, =insertInt
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =insertIntMemSet
    BL scanf

    LDR R1, =insertCharMemSet
    LDR R2, =insertIntMemSet
    LDRB R2, [R2, #0]
    LDR R3, =insertStringMemSet
    BL _memset
    MOV R1, R0
    BL _printString
    POP {LR}

BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*  MEMSET - substitui na str1 com a str2 ate um certo limite dado

    Parametros:
    R1 - carater
    R3 - string que vai ser modificada
    Return:
    RO - string modificada
 */
 
_memset:
    MOV R4, #0//Iterador
    memset_loop:
        LDRB R5, [R1, #0]
        STRB R5, [R3, R4]
        ADD R4, #1
        CMP R4, R2//R2 ate onde substituir
        BNE memset_loop
        MOV R0, R3
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

_strlen:
    MOV R4, #0//Iterador
        
        strlen_loop:
            LDRB R3, [R1, R4]//Ler array bit a bit R1 string e R4 o iterador
            ADD R4, R4, #1//incrementar iterador
            CMP R3, #0//quando r3 = 0 acabou de ler a string
            BNE strlen_loop

        SUB R2, R4, #1//guarda o tamanho da string em r2
        BX LR
        