@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringFirstStrXfrm: .fill 100, 1, 0
.balign 4
    insertStringSecondStrXfrm: .fill 100, 1, 0
.balign 4
    insertInt: .asciz "Insira um número: "
.balign 4
    scanInputInt: .asciz "%d"
.balign 4
    insertIntLimiterStrXfrm: .fill 50, 1, 0
.balign 4
    resultStrXfrm: .asciz "Resultado: '%s', e o tamanho da segunda string enviada é de: %d\n"

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
    LDR R1, =insertStringFirstStrXfrm
    BL scanf

    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringSecondStrXfrm
    BL scanf

    LDR R0, =insertInt
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =insertIntLimiterStrXfrm
    BL scanf

    LDR R1, =insertStringFirstStrXfrm
    LDR R3, =insertStringSecondStrXfrm
    LDR R2, =insertIntLimiterStrXfrm
    LDRB R2, [R2, #0]
    BL _strxfrm
    MOV R1, R0
    LDR R0, =resultStrXfrm
    MOV R2, R3
    BL printf
    
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*  STRXFRM - Copia a str1 para str2 ate um certo limite e ainda devolve o tamanho da segunda str2

    Parametros:
    R1 - string a ser replaced
    R3 - string que vai ser replaced R0 limite de replace
    Return:
    R0 - limite de replace
    R3 - tamanho da string R5
 */
 
_strxfrm://R1 string a ser replaced R5 string que vai ser replaced R0 limite de replace
    PUSH {LR}
    MOV R4, #0//Iterador

    strxfrm_loop:
        LDRB R5, [R3, R4]
        STRB R5, [R1, R4]
        ADD R4, #1
        CMP R4, R2
        BNE strxfrm_loop
        MOV R0, R1
        MOV R1, R3
        BL _strlen
        MOV R3, R2
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
    