@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringPrimaryToCompare: .fill 100, 1, 0
.balign 4
    insertStringSecundaryToCompare: .fill 100, 1, 0
.balign 4
    messageEqualsStrings: .asciz "As strings são iguais!"
.balign 4
    messageDiferentStrings: .asciz "As strings são diferentes!"
.balign 4
    messageDifLengthStrings: .asciz "As strings têm tamanhos diferentes logo são diferentes!"    
.balign 4
    resultStrcmp: .asciz "Resultado: %d \n(3) - tamanhos diferentes, (2) - diferentes, (1) - iguais\n"

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
    LDR R1, =insertStringPrimaryToCompare
    BL scanf

    LDR R0, =insertString
    BL printf
    LDR R0, =scanInputString
    LDR R1, =insertStringSecundaryToCompare
    BL scanf

    LDR R1, =insertStringPrimaryToCompare
    LDR R5, =insertStringSecundaryToCompare
    MOV R0, #0
    BL _strcmp
    //MOV R1, R0
    LDR R0, =resultStrcmp
    BL printf

    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*  STRCMP - Compara str1 a str2 e devolve 1 para igausi 2 para diferentes 3 para strings de diferentes maneiras

    Parametros: 
    R1 - primeira string
    R5 - sergunda string

    Return
    R1 - inteiro (codigo)
 */
 
_strcmp: 
    PUSH {LR}
    LDR R1, =insertStringSecundaryToCompare
    BL _strlen
    MOV R6, R2//STR2
    LDR R1, =insertStringPrimaryToCompare
    BL _strlen
    MOV R3, R2//STR1
    CMP R3, R6
    MOVNE R1, #3//STRINGS TAMANHOS DIFERENTES
    //MOV R0, R6
    POP {LR}
    BXNE LR
    PUSH {LR}
    MOV R4, #0
    LDR R1, =insertStringPrimaryToCompare
    LDR R5, =insertStringSecundaryToCompare
    iterate_cmp_loop:
        CMP R2, R4
        MOVEQ R1, #1
        POP {LR}
        BXEQ LR
        PUSH {LR}
        LDRB R6, [R1, R4]
        LDRB R3, [R5, R4]
        CMP R6, R3 
        ADDEQ R4, R4, #1
        BEQ iterate_cmp_loop
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

        