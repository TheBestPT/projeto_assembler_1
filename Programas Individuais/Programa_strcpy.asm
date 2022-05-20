@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringFirstStrCpy: .fill 100, 1, 0
.balign 4
    insertStringSecondStrCpy: .fill 100, 1, 0
.balign 4
    insertInt: .asciz "Insira um número: "
.balign 4
    scanInputInt: .asciz "%d"
.balign 4
    insertIntLimiterStrCpy: .fill 50, 1, 0

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
    LDR R1, =insertStringFirstStrCpy
    BL scanf 

    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringSecondStrCpy
    BL scanf 
    
    LDR R0, =insertInt
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =insertIntLimiterStrCpy
    BL scanf
    
    LDR R1, =insertStringSecondStrCpy
    LDR R3, =insertStringFirstStrCpy
    LDR R2, =insertIntLimiterStrCpy
    LDRB R2, [R2, #0]
    BL _strcpy
    //LDR R0, =insertStringSecondStrCpy
    BL printf
    POP {LR}
BX LR

BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/*  STRCPY - copia str1 para str2

    Parametros:
    R3 - primeira string
    R1 - segunda string
    Return:
    R0 - string copiada
 */
 
_strcpy:
    MOV R4, #0//Iterador

    strpy_loop:
        LDRB R5, [R3, R4]
        STRB R5, [R1, R4]
        ADD R4, #1
        CMP R4, R2
        BNE strpy_loop
        MOV R0, R1
BX LR
