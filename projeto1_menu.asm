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
.balign 4
    insertString: .asciz "Insira uma string: "
.balign 4
    insertChar: .asciz "Insira um char: "
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
.balign 4
    resultCharAt: .asciz "O carater foi encontrado na posição: %d \n"

/*
MEMCHR VARIABLES
 */

.balign 4
    insertCharMemChr: .fill 1, 1, 0
.balign 4
    insertStringMemChr: .fill 100, 1, 0
.balign 4
    empetyStrMemChr: .fill 100, 1, 0


/*
MEMMOVE VARIABLES
 */
.balign 4
    insertStringToMoveMemMove: .fill 100, 1, 0
.balign 4
    insertStringToReplaceMemMove: .fill 100, 1, 0
.balign 4
    messageStringToMoveMemMove: .asciz "Insira uma string para ser movida: "
.balign 4
    messageStringToReplaceMemMove: .asciz "Insira uma string para ser modificada: "

/*
STRCMP VARIABLES
 */
.balign 4
    insertStringPrimaryToCompare: .fill 100, 1, 0
.balign 4
    insertStringSecundaryToCompare: .fill 100, 1, 0



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

    //------------ CALL MEMCHR

    CMP R0, #4
    BLEQ _callMemChr

    //---------- CALL MEMMOVE

    CMP R0, #5
    BLEQ _callMemMove



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
    PUSH {R0, LR}
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
    POP {R0, LR}
BX LR





_callStringLength:
    PUSH {R0, LR}
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
    POP {R0, LR}
BX LR


_callCharAt:
    PUSH {R0, LR}
    LDR  R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =charToSearchCharAt
    BL scanf

    LDR  R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =stringToSearchCharAt
    BL scanf
    
    LDR R1, =stringToSearchCharAt
    LDR R3, =charToSearchCharAt
    BL _charat
    MOV R1, R0
    LDR R0, =resultCharAt
    BL printf
    POP {R0, LR}
BX LR

_callMemChr:
    PUSH {R0, LR}
    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringMemChr
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertCharMemChr
    BL scanf

    LDR R1, =insertStringMemChr
    LDR R3, =insertCharMemChr
    
    BL _charat
    BL _strlen

    LDR R1, =insertStringMemChr
    LDR R3, =empetyStrMemChr
    
    BL _memchr
    LDR R0, =empetyStrMemChr
    BL printf
    POP {R0, LR}
BX LR

_callMemMove:
    PUSH {R0, LR}
    LDR R0, =messageStringToMoveMemMove
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringToMoveMemMove
    BL scanf

    LDR R0, =messageStringToReplaceMemMove
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringToReplaceMemMove
    BL scanf

    LDR R1, =insertStringToMoveMemMove
    BL _strlen
    LDR R1, =insertStringToReplaceMemMove
    LDR R3, =insertStringToMoveMemMove
    BL _memmove
    BL printf

    /*LDR R1, =stringMemMove//String a ser movida
    BL _strlen
    MOV R5, R1
    LDR R1, =str//String que vai ser replaced
    BL _memmove//R1 str R5 stringMemMove
    //LDR R0, =str
    BL _printString*/
    POP {R0, LR}
BX LR

_callStrCmp:
    PUSH {R0, LR}

    LDR R1, =str
    LDR R5, =stringToCompare
    MOV R0, #0
    //BL _printString
    BL _strcmp

    POP {R0, LR}
BX LR 

//---------------------------------------------------------------------------------------------

//METHODS

//---------------------------------------------------------------------------------------------

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

/*
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

/*
    Parametros: 
    R1 - string que vai ser substituida
    R5 - string que vai ser movida
    Return:
    R0 - string movida
*/
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


_strcmp: 
    PUSH {LR}
    LDR R1, =stringToCompare
    BL _strlen
    MOV R6, R2//STR2
    LDR R1, =str
    BL _strlen
    MOV R3, R2//STR1
    CMP R3, R6
    MOVNE R0, #3//STRINGS TAMANHOS DIFERENTES
    //MOV R0, R6
    POP {LR}
    BXNE LR
    PUSH {LR}
    MOV R4, #0
    LDR R1, =str
    LDR R3, =stringToCompare
    iterate_cmp_loop:
        CMP R2, R4
        BEQ _end_strcmp
        POP {LR}
        BXEQ LR
        PUSH {LR}
        LDRB R6, [R1, R4]
        LDRB R5, [R3, R4]
        CMP R6, R5
        ADDEQ R4, R4, #1
        BEQ iterate_cmp_loop
        MOV R0, #2
    POP {LR}
    BX LR