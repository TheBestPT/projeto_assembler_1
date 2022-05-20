@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringCharAt: .fill 100, 1, 0
.balign 4
    insertInt: .asciz "Insira um numero: "
.balign 4
    scanInputInt: .asciz "%d"
.balign 4
    insertIntIndexCharAt: .fill 50, 1, 0
.balign 4
    emptyCharCharAt: .fill 1, 1, 0
.balign 4
    resultCharAt: .asciz "O carater encontrado é: %s\n"
.balign 4
    indexNotFoundCharAt: .asciz "carater não encontrado"

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
    LDR R1, =insertStringCharAt
    BL scanf

    LDR R0, =insertInt
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =insertIntIndexCharAt
    BL scanf

    LDR R1, =insertStringCharAt
    LDR R2, =emptyCharCharAt
    LDR R3, =insertIntIndexCharAt
    LDRB R3, [R3, #0]
    BL _charat
    MOV R1, R0
    LDR R0, =resultCharAt
    BL printf


    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/* CHARAT - com o charat e possivel retornar um carater a partir de um indice numa string

    Parametros:
    R1 - string
    R3 - indice

    Return:
    R0 - carater 

 */
_charat:
    LDRB R5, [R1, R3]
    CMP R5, #0
    LDR R0, =indexNotFoundCharAt
    BXEQ LR
    STRB R5, [R2, #0]
    MOV R0, R2
BX LR
