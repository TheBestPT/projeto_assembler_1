@Data Section
.data
/*
"Global" Variables
 */

.balign 4
    newLine: .asciz " \n"
.balign 4
    scanInputInt: .asciz "%d"
.balign 4
    inputOption: .fill 50, 1, 0
.balign 4
    scanInputString: .asciz "%s"
.balign
    mainMenu: .asciz "Menu\n1 - string length\n2 - invert string\n3 - char at\n4 - memchr\n5 - memmove\n6 - strcmp\n7 - memset\n8 - strconcat\n9 - strcpy\n10 - lastcharat\n11 - strxfrm\n12 - uppercase\n13 - lowercase\n14 - strset\n15 - memcmp\n\nEscolha uma opção: "

/*
INVERT STRING VARIABLES
 */
.balign 4
    stringInvert: .fill 100, 1, 0
.balign 4
    emptyStrInvert: .fill 50, 1, 0
.balign 4
    insertStringInvert: .asciz "Insira uma string para ser invertida: "

/*
STRING LENGTH VARIABLES
 */    
.balign 4
    insertStringToLength: .asciz "Insira uma string para e direi o tamanho: "
.balign 4
    stringToLength: .fill 100, 1, 0
.balign 4
    resultToLength: .asciz "O tamanho da sua string é de: %d%s"
.balign 4
    outLength: .fill 50, 1, 0

/*
CHAR AT VARIABLES
 */
.balign 4
    charToSearchCharAt: .fill 1, 1, 0
.balign 4
    stringToSearchCharAt: .fill 100, 1, 0
.balign 4
    insertCharCharAt: .asciz "Insira um carater para ser pesquisado na string: "
.balign 4
    insertStringCharAt: .asciz "Insira uma string: "

@External C functions

.global scanf
.global printf

@Code Section
.Section .text
.global main
.arm


main:

    PUSH {LR}
    LDR R0, =mainMenu
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =inputOption
    BL scanf

    LDR R0, =inputOption
    LDRB R2, [R0, #0]
    MOV R0, R2




    //---------------- CALL STRING LENGTH
    
    CMP R0, #1
    BLEQ _callStringLength

    //-------------- CALL INVERT STRING
    CMP R0, #2
    BLEQ _callInvertString

    //-------------- CALL CHAR AT

    CMP R0, #3
    BLEQ _callCharAt





    POP {LR}

    /*PUSH {LR}
    LDR R0, =scanMenuInput
    LDR R1, =inputOption
    BL scanf

    LDR R0, =inputOption
    BL printf
    POP {LR}*/
    



    BX LR
_exit: 
    MOV R7, #1
    SVC #0 @Invoke Syscall

/*_callInvertString:
    PUSH {LR}
    LDR R0, =stringInvert@Ler a string
    MOV R1, R0
    BL _strlen//CALCULAR TAMANHO DA STRING EM R00
    LDR R1, =emptyStrInvert//Ler string vaiza*/
    /*
        Parametros:
        R0 - String a ser invertida
        R1 - String vazia    
        RETURN 
        R1 - string invertida
     */
    /*
    BL _invertString
    MOV R0, R1
    BL printf
    POP {LR}
    BX LR*/

_callInvertString:
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
    MOV R0, R1
    BL printf
    POP {LR}
BX LR





_callStringLength:
    PUSH {LR}
    LDR R0, =insertStringToLength
    BL printf
    LDR R0, =scanInputString
    LDR R1, =insertStringToLength
    BL scanf
    LDR R1, =insertStringToLength
    BL _strlen
    LDR R0, =resultToLength
    MOV R1, R2
    //LDR R0, =inputOption
    /*LDRB R3, [R1, #0]
    MOV R1, R3*/
    //MOV R0, R1
    LDR R2, =newLine
    BL printf
    POP {LR}
BX LR


_callCharAt:
    PUSH {LR}
    LDR R1, =stringToSearchCharAt
    LDR R3, =charToSearchCharAt
    BL _charat
    POP {LR}
BX LR

//---------------------------------------------------------------------------------------------

//METHODS

//---------------------------------------------------------------------------------------------

/*
        Parametros:
        R0 - String a ser invertida
        R1 - String vazia    
        RETURN 
        R1 - string invertida
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

/*
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

/*
    Parametros:
    R1 - string onde vai ser pesquisado o carater
    R3 - carater 
    Retun
    R0 - a ocorrencia do carater
 */
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