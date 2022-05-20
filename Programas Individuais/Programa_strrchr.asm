@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringSearchStrrchr: .fill 100, 1, 0
.balign 4
    insertChar: .asciz "Insira um carater: "
.balign 4
    insertCharStrrchr: .fill 1, 1, 0
.balign 4
    resultStrrchr: .asciz "O carater foi encontrado pela última vez na posição: %d \n"

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
    LDR R1, =insertStringSearchStrrchr
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertCharStrrchr
    BL scanf

    LDR R1, =insertStringSearchStrrchr
    LDR R2, =insertCharStrrchr
    BL _strrchr
    MOV R1, R0
    LDR R0, =resultStrrchr
    BL printf
    POP {LR}
BX LR
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*  STRRCHR - Damos uma string e pesquisa na string a última ocorrencia desse carater

    Parametros:
    R1 - string onde vai ser pesquisado o carater
    R2 - o carater
    Return
    R0 - posição da ultima vez que encontrou o carater
 */
 
_strrchr:
    MOV R4, #0//iterador

    strrchr_loop:
        LDRB R3, [R1, R4]//ler a string onde vai ser pesquisado o charter
        LDRB R6, [R2, #0]//o carater
        ADD R4, R4, #1//incrementar
        CMP R3, R6//comparar ate encontrar igual
        MOVEQ R5, R4
        CMP R3, #0
        BNE strrchr_loop
        SUB R5, #1
        MOV R0, R5//retornar a posicao
    BX LR
    