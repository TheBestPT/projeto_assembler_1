@Data Section
.data
.balign 4
    insertChar: .asciz "Insira um carater: "
.balign 4
    scanInputChar: .asciz "%s"
.balign 4
    insertCharMemChr: .fill 1, 1, 0
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringMemChr: .fill 100, 1, 0
.balign 4
    emptyStrMemChr: .fill 100, 1, 0

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
    LDR R1, =insertStringMemChr
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputChar
    LDR R1, =insertCharMemChr
    BL scanf

    LDR R1, =insertStringMemChr
    LDR R3, =insertCharMemChr
    
    BL _charat
    BL _strlen

    LDR R1, =insertStringMemChr
    LDR R3, =emptyStrMemChr
    
    BL _memchr
    LDR R0, =emptyStrMemChr
    MOV R1, R0
    BL _printString
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @InvoqueSyscall

/* MEMCHR - basicamente um substring sem limite final

    Parametros:
    R0 - posição do carater encontrado
    R1 - string a ser representada
    R3 - string vazia
    Return:
    R0 - string cortada
 */
_memchr:
    PUSH {LR}
    //SUB R0, #2
    MOV R4, R0//posicao do carater encontrado
    MOV R6, #0
    iterate_memchr:
        LDRB R5, [R1, R4]
        STRB R5, [R3, R6]
        ADD R4, #1
        ADD R6, #1
        CMP R4, R2
        BNE iterate_memchr
        MOV R0, R3
    POP {LR}
    BX LR

_charat:
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
