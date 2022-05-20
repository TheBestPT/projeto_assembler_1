@Data Section
.data
.balign 4
    insertStringToLength: .asciz "Insira uma string para apresentar o tamanho: "
.balign 4
    stringToLength: .fill 100, 1, 0
.balign 4
    resultToLength: .asciz "O tamanho da sua string é de: %d\n"
.balign 4
    inputType: .asciz "%s"

@External C fuctions
.global printf
.global scanf

@Code Section
.Section .text
.global main
.arm

main:
    PUSH {LR}

    LDR R0, =insertStringToLength
    BL printf

    LDR R0, = resultToLength
    LDR R1, = stringToLength
    BL scanf

    BL _strlen

    LDR R0, =resultToLength
    MOV R1, R2
    BL printf
    
    POP {LR}
    BX LR

_exit:
    MOV R7, #1
    SVC #0 @Invoke Syscall

/*  Strlen - Diz o tamanho da string

    Parametros:
    R1 - string 
    Return 
    R2 - tamanho da string
 */
 
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
        