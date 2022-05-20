@Data Section
.data
.balign 4
    stringInvert: .fill 100, 1, 0
.balign 4
    emptyStrInvert: .fill 50, 1, 0
.balign 4
    insertStringInvert: .asciz "Insira uma string para ser invertida: "
.balign 4
    scanInputString: .asciz "%s"


@External C fuctions
.global printf
.global scanf

@Code Section
.Section .text
.global main
.arm

/*  InvertString - Inverte a string

        Parametros:
        R0 - String a ser invertida
        R1 - String vazia    
        RETURN 
        R1 - string invertida
*/

main:
    PUSH {LR}
    LDR R0, =insertStringInvert
    BL printf
    LDR R0, =scanInputString
    LDR R1, =stringInvert@Ler a string
    BL scanf
    LDR R0, =stringInvert
    MOV R1, R0
    BL _strlen//CALCULAR TAMANHO DA STRING EM R00
    LDR R1, =emptyStrInvert//Ler string vaiza*/
    //MOV R0, R2
    BL _invertString
    //MOV R0, R1
    //LDR R0, =emptyStrInvert
    BL _printString

    POP {LR}

    BL _exit

_exit:
    MOV R7, #1
    SVC #0 @Invoque Syscall

_strlen:
    MOV R4, #0//Iterador
        
        strlen_loop:
            LDRB R3, [R1, R4]//Ler array bit a bit R1 string e R4 o iterador
            ADD R4, R4, #1//incrementar iterador
            CMP R3, #0//quando r3 = 0 acabou de ler a string
            BNE strlen_loop

        SUB R2, R4, #1//guarda o tamanho da string em r2
        BX LR

/*
        Parametros:
        R0 - String a ser invertida
        R1 - String vazia    
        RETURN 
        R0 - string invertida
*/
_invertString:
    MOV R4, #0//Iterador

        invertString_loop:
            SUB R2, R2, #1//tirar 1 do length porque e o /0
            LDRB R3, [R0, R2]//ler a string vazia ao contrario com o tamanho de R2
            STRB R3, [R1, R4]//guardar no R1 a string invertida
            ADD R4, R4, #1//Incrementar o iterador de guardar
            CMP R2, #0//enquando nao for 0 continua a fazer
            BNE invertString_loop
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



