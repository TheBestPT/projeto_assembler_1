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
.balign 4
    insertInt: .asciz "Insira um inteiro: "
.balign 4
    testInt: .asciz "%d"
.balign
    mainMenu: .asciz "Menu\n1 - string length\n2 - invert string\n3 - strchr\n4 - memchr\n5 - memmove\n6 - strcmp\n7 - memset\n8 - strconcat\n9 - strcpy\n10 - strrchr\n11 - strxfrm\n12 - uppercase\n13 - lowercase\n14 - strset\n15 - memcmp\n\nEscolha uma opção: "

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
STRCHR VARIABLES
 */
.balign 4
    charToSearchStrChr: .fill 1, 1, 0
.balign 4
    stringToSearchStrChr: .fill 100, 1, 0
.balign 4
    insertCharStrChr: .asciz "Insira um carater para ser pesquisado na string: "
.balign 4
    insertStringStrChr: .asciz "Insira uma string: "
.balign 4
    resultStrChr: .asciz "O carater foi encontrado na posição: %d \n"

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
.balign 4
    messageEqualsStrings: .asciz "As strings são iguais!"
.balign 4
    messageDiferentStrings: .asciz "As strings são diferentes!"
.balign 4
    messageDifLengthStrings: .asciz "As strings têm tamanhos diferentes logo são diferentes!"    
.balign 4
    resultStrcmp: .asciz "Resultado: %d (3) - tamanhos diferentes, (2) - diferentes, (1) - iguais.\n" 

/*
MEMSET VARIABLES
 */
.balign 4
    insertStringMemSet: .fill 100, 1, 0
.balign 4
    insertCharMemSet: .fill 100, 1, 0
.balign 4
    insertIntMemSet: .fill 50, 1, 0

/*
STRCAT VARIABLES
 */
.balign 4
    insertStringFirstStrCat: .fill 100, 1, 0
.balign 4
    insertStringSecondeStrCat: .fill 100, 1, 0
.balign 4
    empetyStringStrCat: .fill 100, 1, 0

/*
STRCPY VARIABLES
 */
.balign 4
    insertStringFirstStrCpy: .fill 100, 1, 0
.balign 4
    insertStringSecondStrCpy: .fill 100, 1, 0
.balign 4
    insertIntLimiterStrCpy: .fill 50, 1, 0

/*
STRXFRM VARIABLES
 */
.balign 4
    insertStringFirstStrXfrm: .fill 100, 1, 0
.balign 4
    insertStringSecondStrXfrm: .fill 100, 1, 0
.balign 4
    insertIntLimiterStrXfrm: .fill 50, 1, 0
.balign 4
    resultStrXfrm: .asciz "Resultado: '%s', e o tamanho da segunda string enviada é de: %d\n"

/*
STRRCHR VARIABLES
 */
.balign 4
    insertStringSearchStrrChr: .fill 100, 1, 0
.balign 4
    insertCharStrrChr: .fill 1, 1, 0
.balign 4
    resultStrrChr: .asciz "O carater foi encontrado pela última vez na posição: %d \n"

/*
UPPERCASE VARIABLES
 */
.balign 4
    insertStringUpperCase: .fill 100, 1, 0
.balign 4
    stringToSaveUpperCase: .fill 100, 1, 0
.balign 4
    resultUpperCase: .asciz "String em maiúscula: %s\n"

/*
LOWERCASE VARIABLES
 */
.balign 4
    insertStringLowerCase: .fill 100, 1, 0
.balign 4
    stringToSaveLowerCase: .fill 100, 1, 0
.balign 4
    resultLowerCase: .asciz "String em minúscula: %s\n"

/*
STRSET VARIABLES
 */
.balign 4
    insertCharStrSet: .fill 1, 1, 0
.balign 4
    insertStringStrSet: .fill 100, 1, 0
.balign 4
    resultStrSet: .asciz "Resultado: %s\n"

/*
MEMSET VARIABLES
 */
.balign 4
    insertStringFirstMemCmp: .fill 100, 1, 0
.balign 4
    insertStringSecondMemCmp: .fill 100, 1, 0
.balign 4
    insertIntLimiterMemCmp: .fill 50, 1, 0
.balign 4
    resultMemCmp: .asciz "Resultado: %d (3) - tamanhos diferentes, (2) - diferentes, (1) - iguais\n"


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
    BLEQ _callStrChr

    //------------ CALL MEMCHR

    CMP R0, #4
    BLEQ _callMemChr

    //---------- CALL MEMMOVE

    CMP R0, #5
    BLEQ _callMemMove

    //---------- STRCMP

    CMP R0, #6
    BLEQ _callStrCmp
    //MOVEQ R0, #6//NAO POSSO GUARDAR NA STACK DEVIDO A TER CONFLITO NO METODO STRCMP

    //-------- MEMSET

    CMP R0, #7
    BLEQ _callMemSet

    //------- STRCAT

    CMP R0, #8
    BLEQ _callStrCat

    //-------- STRCPY
    CMP R0, #9
    BLEQ _callStrCpy



    //---------- STRRCHR
    CMP R0, #10
    BLEQ _callStrrChr


    //---------- STRXFRM
    CMP R0, #11
    BLEQ _callStrXfrm


    //-------- UPPERCASE
    CMP R0, #12
    BLEQ _callUpperCase


    //-------- LOWERCASE
    CMP R0, #13
    BLEQ _callLowerCase

    //-------- STRSET
    CMP R0, #14
    BLEQ _callStrSet


    //------- MEMCMP
    CMP R0, #15
    BLEQ _callMemCmp


    POP {LR}
    



    BX LR
_exit: 
    MOV R7, #1
    SVC #0 @Invoke Syscall

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
    LDR R2, =newLine
    BL printf
    POP {R0, LR}
BX LR


_callStrChr:
    PUSH {R0, LR}
    LDR  R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =charToSearchStrChr
    BL scanf

    LDR  R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =stringToSearchStrChr
    BL scanf
    
    LDR R1, =stringToSearchStrChr
    LDR R3, =charToSearchStrChr
    BL _strchr
    MOV R1, R0
    LDR R0, =resultStrChr
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
    
    BL _strchr
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
    POP {R0, LR}
BX LR

_callStrCmp:
    PUSH {R0, LR}
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
    BL _strcmp
    LDR R0, =resultStrcmp
    BL printf

    POP {R0, LR}
BX LR 

_callMemSet:
    PUSH {R0, LR}
    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringMemSet
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertCharMemSet
    BL scanf

    LDR R0, =insertInt
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =insertIntMemSet
    BL scanf

    LDR R1, =insertCharMemSet
    LDR R2, =insertIntMemSet
    LDRB R2, [R2, #0]
    LDR R3, =insertStringMemChr
    BL _memset
    BL printf
    POP {R0, LR}
BX LR


_callStrCat:
    PUSH {R0, LR}

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
    LDR R1, =empetyStringStrCat
    LDR R3, =insertStringFirstStrCat
    BL _memmove
    
    MOV R1, R0
    //LDR R1, =insertStringSecondeStrCat
    BL _strlen
    MOV R5, R1
    LDR R1, =insertStringSecondeStrCat
    BL _strcat
    BL printf
    POP {R0, LR}
BX LR


_callStrCpy:
    PUSH {R0, LR}

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
    POP {R0, LR}
BX LR


_callStrXfrm:
    PUSH {R0, LR}   
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
    
    POP {R0, LR}
BX LR


_callStrrChr:
    PUSH {R0, LR}
    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringSearchStrrChr
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertCharStrrChr
    BL scanf

    LDR R1, =insertStringSearchStrrChr
    LDR R2, =insertCharStrrChr
    BL _strrchr
    MOV R1, R0
    LDR R0, =resultStrrChr
    BL printf
    POP {R0, LR}
BX LR

_callUpperCase:
    PUSH {R0, LR}
    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringUpperCase
    BL scanf

    LDR R1, =insertStringUpperCase
    BL _strlen
    LDR R3, =stringToSaveUpperCase
    BL _uppercase
    MOV R1, R0
    LDR R0, =resultUpperCase
    BL printf
    POP {R0, LR}
BX LR 

_callLowerCase:
    PUSH {R0, LR}
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
    POP {R0, LR}
BX LR 


_callStrSet:
    PUSH {R0, LR}
    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringStrSet
    BL scanf

    LDR R0, =insertChar
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertCharStrSet
    BL scanf

    //LDR R1, =insertCharStrSet
    LDR R1, =insertStringStrSet
    BL _strlen
    LDR R1, =insertCharStrSet
    LDR R3, =insertStringStrSet
    BL _strset
    MOV R1, R0
    LDR R0, =resultStrSet
    BL printf
    POP {R0, LR}
BX LR


_callMemCmp:
    PUSH {R0, LR}
    LDR R0, =insertString
    BL printf 
    LDR R0, =scanInputString
    LDR R1, =insertStringFirstMemCmp
    BL scanf

    LDR R0, =insertString
    BL printf

    LDR R0, =scanInputString
    LDR R1, =insertStringSecondMemCmp
    BL scanf

    LDR R0, =insertInt
    BL printf

    LDR R0, =scanInputInt
    LDR R1, =insertIntLimiterMemCmp
    BL scanf


    LDR R1, =insertStringFirstMemCmp
    LDR R5, =insertStringSecondMemCmp
    LDR R7, =insertIntLimiterMemCmp
    LDRB R7, [R7, #0]
    BL _memcmp
    LDR R0, =resultMemCmp
    BL printf
    MOV R7, #0
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
_strchr:
    MOV R4, #0//iterador

    strchr_loop:
        LDRB R5, [R1, R4]//ler a string onde vai ser pesquisado o charter
        LDRB R6, [R3, #0]//o carater
        ADD R4, R4, #1//incrementar
        CMP R5, R6//comparar ate encontrar igual
        BNE strchr_loop
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

/*
    Parametros: 
    R1 - primeira string
    R5 - sergunda string

    Return
    R1 - inteiro (codigo)
 */
_strcmp: 
    PUSH {R0, LR}
    LDR R1, =insertStringSecundaryToCompare
    BL _strlen
    MOV R6, R2//STR2
    LDR R1, =insertStringPrimaryToCompare
    BL _strlen
    MOV R3, R2//STR1
    CMP R3, R6
    MOVNE R1, #3//STRINGS TAMANHOS DIFERENTES
    //MOV R0, R6
    POP {R0, LR}
    BXNE LR
    PUSH {R0, LR}
    MOV R4, #0
    LDR R1, =insertStringPrimaryToCompare
    LDR R5, =insertStringSecundaryToCompare
    iterate_cmp_loop:
        CMP R2, R4
        MOVEQ R1, #1
        POP {R0, LR}
        BXEQ LR
        PUSH {R0, LR}
        LDRB R6, [R1, R4]
        LDRB R3, [R5, R4]
        CMP R6, R3 
        ADDEQ R4, R4, #1
        BEQ iterate_cmp_loop
        MOV R1, #2
    POP {R0, LR}
    BX LR


/*
    Parametros:
    R1 - carater
    R3 - string que vai ser modificada
    Return:
    RO - string modificada
 */
_memset:
    MOV R4, #0//Iterador
    memset_loop:
        LDRB R5, [R1, #0]
        STRB R5, [R3, R4]
        ADD R4, #1
        CMP R4, R2//R2 ate onde substituir
        BNE memset_loop
        MOV R0, R3
BX LR

/*
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
    MOV R6, R4
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

/*
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

/*
    Parametros:
    R1 - string onde vai ser pesquisado o carater
    R2 - o carater
    Return
    R0 - posição da ultima vez que encontrou o carater
 */
_strrchr:
    MOV R4, #0//iterador

    strrchr_loop:
        LDRB R3, [R1, R4]//ler a string onde vai ser pesquisado o charter
        LDRB R6, [R2, #0]//o carater
        ADD R4, R4, #1//incrementar
        CMP R3, R6//comparar ate encontrar igual
        MOVEQ R5, R4
        CMP R3, #0
        BNE strrchr_loop
        SUB R5, #1
        MOV R0, R5//retornar a posicao
    BX LR

/*
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

/*
    Parametros:
    R1 - string em lowercase
    R3 - string vazia para guardar a conversao
    Return 
    R0 - string em uppercase
 */
_uppercase:
    MOV R4, #0
    SUB R2, #1
    uppercase_loop:
        LDRB R5, [R3, R4]
        LDRB R6, [R1, R4] 
        CMP R6, #32//ESPAÇO
        SUBNE R6, #32//TRANSFORMAR EM UPPERCASE
        CMP R6, #64
        ADDLT R6, #32
        STRB R6, [R3, R4]
        CMP R4, R2
        ADDNE R4, #1
        BNE uppercase_loop
        MOV R0, R3
BX LR

/*
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


/*
    Parametros:
    R1 - carater para substituir
    R3 - string 

    Return 
    R0 - string substituida

 */
_strset:
    MOV R4, #0//Iterador

    strset_loop:
        LDRB R5, [R1, #0]
        STRB R5, [R3, R4]
        ADD R4, #1
        CMP R4, R2//R2 ate onde substituir
        BNE strset_loop
        MOV R0, R3
    BX LR

/*
    Parametros: 
    R1 - primeira string
    R5 - sergunda string

    Return
    R1 - inteiro (codigo)
 */
_memcmp: 
    PUSH {R0, LR}
    
    LDR R1, =insertStringSecondMemCmp
    BL _strlen
    MOV R6, R2//STR2
    LDR R1, =insertStringFirstMemCmp
    BL _strlen
    MOV R3, R2//STR1
    CMP R3, R6
    MOVNE R1, #3//STRINGS TAMANHOS DIFERENTES
    //MOV R0, R6
    POP {R0, LR}
    BXNE LR
    PUSH {R0, LR}
    MOV R4, #0
    LDR R1, =insertStringFirstMemCmp
    LDR R5, =insertStringSecondMemCmp
    memcmp_loop:
        CMP R7, R4
        MOVEQ R1, #1
        POP {R0, LR}
        BXEQ LR
        PUSH {R0, LR}
        LDRB R6, [R1, R4]
        LDRB R3, [R5, R4]
        CMP R6, R3 
        ADDEQ R4, R4, #1
        BEQ memcmp_loop
        MOV R1, #2
    POP {R0, LR}
    BX LR
