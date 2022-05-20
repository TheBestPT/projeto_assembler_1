@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s" 
.balign 4
    insertStringLowerCase: .fill 100, 1, 0
.balign 4
    stringToSaveLowerCase: .fill 100, 1, 0
.balign 4
    resultLowerCase: .asciz "String em minúscula: %s\n"


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
    LDR R1, =insertStringLowerCase
    BL scanf

    LDR R1, =insertStringLowerCase
    BL _strlen
    LDR R3, =stringToSaveLowerCase
    BL _lowercase
    MOV R1, R0
    LDR R0, =resultLowerCase
    BL printf
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*  LOWERCASE - converte uma string em uppercase em lowercase

    Parametros:
    R1 - string em uppercase
    R3 - string vazia para guardar a conversao
    Return 
    R0 - string em lowercase
 */
 
_lowercase:
    MOV R4, #0
    SUB R2, #1
    lowercase_loop:
        LDRB R5, [R3, R4]
        LDRB R6, [R1, R4]
        CMP R6, #32//ESPAÇO
        ADDNE R6, #32//TRANSFORMAR EM UPPERCASE
        CMP R6, #123
        SUBGT R6, #32
        STRB R6, [R3, R4]
        CMP R4, R2
        ADDNE R4, #1
        BNE lowercase_loop
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
        