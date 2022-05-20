@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringFirstStrCat: .fill 100, 1, 0
.balign 4
    insertStringSecondeStrCat: .fill 100, 1, 0
.balign 4
    emptyStringStrCat: .fill 100, 1, 0

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
    LDR R1, =insertStringFirstStrCat
    BL scanf

    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringSecondeStrCat
    BL scanf

    LDR R1, =insertStringFirstStrCat
    BL _strlen
    LDR R1, =emptyStringStrCat
    LDR R3, =insertStringFirstStrCat
    BL _memmove
    
    MOV R1, R0
    BL _strlen
    MOV R5, R1
    LDR R1, =insertStringSecondeStrCat
    BL _strcat
    MOV R1, R0
    BL _printString
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*  STRCAT - concatenar duas strings  

    Parametros:
    R1 - primeira string
    R5 - segunda string
    Return
    R0 - strinc concatenda
*/

_strcat:
    PUSH {LR}
    MOV R4, R2//Iterador
    //MOV R4, #4    
    MOV R0, #0
    //MOV R1, R5
    mov R6, R4
    BL _strlen
    MOV R4, R6
    LDR R1, =insertStringSecondeStrCat
    MOV R6, R2
    strcat_loop:
        LDRB R3, [R1, R0]//o Francisco
        STRB R3, [R5, R4]//tudo bem?
        ADD R4, #1
        ADD R0, #1
        CMP R0, R6//R2 ate onde substituir
        BNE strcat_loop
        MOV R0, R5    
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

