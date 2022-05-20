@Data Section
.data
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    scanInputString: .asciz "%s"
.balign 4
    insertStringCapitalize: .fill 100, 1, 0
.balign 4
    emptyStrCapitalize: .fill 100, 1, 0
.balign 4
    resultCapitalize: .asciz "Resultado: %s\n"

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
    LDR R1, =insertStringCapitalize
    BL scanf

    LDR R1, =insertStringCapitalize
    BL _strlen
    LDR R3, =emptyStrCapitalize

    BL _capitalize
    MOV R1, R0
    LDR R0, =resultCapitalize
    BL printf
    POP {LR}
BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

/* CAPITALIZE - basicamente um metodo simples que formata a string para que o primeiro carater esteja em uppercase

    Parametros:
    R1 - string 
    R3 - string vazia

    Return
    R0 - string formatada

 */
_capitalize:
    MOV R4, #0
       

    capitalize_loop:
        LDRB R5, [R1, R4]
        CMP R4, #0
        SUBEQ R5, #32
        CMP R5, #64
        ADDEQ R5, #32
        STRB R5, [R3, R4]
        ADD R4, #1
        CMP R4, R2
        BNE capitalize_loop
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
        