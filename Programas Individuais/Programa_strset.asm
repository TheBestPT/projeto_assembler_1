@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringStrSet: .fill 100, 1, 0
.balign 4
    insertChar: .asciz "Insira um caracter: "
.balign 4
    scanInputChar: .asciz "%s"
.balign 4
    insertCharStrSet: .fill 1, 1, 0
.balign 4
    resultStrSet: .asciz "Resultado: %s"

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
    LDR R1, =insertStringStrSet
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputChar
    LDR R1, =insertCharStrSet
    BL scanf

    //LDR R1, =insertCharStrSet
    LDR R1, =insertStringStrSet
    BL _strlen
    LDR R1, =insertCharStrSet
    LDR R3, =insertStringStrSet
    BL _strset
    MOV R1, R0
    LDR R0, =resultStrSet
    MOV R0, R1
    BL _printString
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/* STRSET - Substitui todos os carateres da str1 por um carater a escolha
    Parametros:
    R1 - carater para substituir
    R3 - string 

    Return 
    R0 - string substituida

 */
_strset:
    MOV R4, #0//Iterador

    strset_loop:
        LDRB R5, [R1, #0]
        STRB R5, [R3, R4]
        ADD R4, #1
        CMP R4, R2//R2 ate onde substituir
        BNE strset_loop
        MOV R0, R3
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
