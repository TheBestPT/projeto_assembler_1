@Data Section
.data
.balign 4
    insertChar: .asciz "Insira um char: "
.balign 4
    scanInputChar: .asciz "%s"
.balign 4
    charToSearchStrchr: .fill 1, 1, 0
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    stringToSearchStrchr: .fill 100, 1, 0
.balign 4
    resultStrchr: .asciz "O carater foi encontrado na posição: %d \n"

@External C fuctions
.global printf
.global scanf

@Code Section
.Section .text
.global main
.arm

main:
PUSH {LR}
    LDR  R0, =insertChar
    BL printf

    LDR R0, =scanInputChar
    LDR R1, =charToSearchStrchr
    BL scanf

    LDR  R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =stringToSearchStrchr
    BL scanf
    
    LDR R1, =stringToSearchStrchr
    LDR R3, =charToSearchStrchr
    BL _strchr
    MOV R1, R0
    LDR R0, =resultStrchr
    BL printf
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @InvoqueSyscall

/*  STRCHR - Damos uma string e pesquisa na string a primeira ocorrencia desse carater

    Parametros:
    R1 - string onde vai ser pesquisado o carater
    R3 - carater 
    Retun
    R0 - a ocorrencia do carater
 */
 
_strchr:
    MOV R4, #0//iterador

    iterate_loop:
        LDRB R5, [R1, R4]//ler a string onde vai ser pesquisado o charter
        LDRB R6, [R3, #0]//o carater
        ADD R4, R4, #1//incrementar
        CMP R5, R6//comparar ate encontrar igual
        BNE iterate_loop
        SUB R4, R4, #1
        MOV R0, R4//retornar a posicao
    BX LR

