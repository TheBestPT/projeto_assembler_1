/*


                    AVISO CÓDIGO ESTÁTICO DE TESTES
                    PRINTF NAO FUNCIONA ENTAO USEI O METODO COM SVC 
                    O METODOS ESTÃO DIFERENTES MAS FAZEM O MESMO QUE OS DO MENU
                    DESCOMENTAR CADA SEÇÃO PARA TESTAR
                    AQUELES QUE NAO TEM PRINTLN E PRECISO FAZER ECHO $?
                    ESTE E BASICAMENTE O CODIGO RASCUNHO PARA ELABORAÇÃO DO TRABALHO


 */
@Data Section
.data
.balign 4
    str: .asciz "Hello World"
.balign 4
    stringOut: .fill 50, 1, 0
.balign 4
    charToSearch: .asciz "l"
.balign 4
    intToPrint: .asciz "%i"
.balign 4 
    stringToCompare : .asciz "Hello World"
.balign 4
    stringMemChrFill: .fill 50, 1, 0
.balign 4
    stringMemMove: .asciz "O francisco"
.balign 4
    stringWithLength : .asciz "Ola"
.balign 4
    stringStrCat: .asciz "tudo bem?"
.balign 4
    empetyStr: .asciz "" 
.balign 4
    fillString: .space 50
.balign 4
    lowercasestr: .asciz "hello world"
.balign 4
    uppercasestr: .asciz "HELLO WORLD"
.balign 4
    stringToSaveUpperCase: .fill 50, 1, 0
.balign 4
    stringCatWithFill: .fill 50, 1, 0
.balign 4
    bigStr: .asciz "Ola tudo bem isto é uma string de testes"
.balign 4
    indexNotFoundCharAt: .asciz "carater não encontrado"


.global printf
.global scanf

@Code Section
.Section .text
.global main
.arm

main:
    //---------------------- STRLEN
    /*LDR R1, =str
    BL _strlen*/

    //---------------------- INVERT STRING
    /*LDR R0, =str
    LDR R1, =stringOut

    MOV R1, R0
    BL _strlen
    BL _invertString
    BL _printString*/
    
    
    //PUSH {R0, R1}
    //----------------- STRCHR
    /*LDR R1, =str
    LDR R2, =charToSearch
    BL _strchr*/
    //POP {R0, R1}

    //BL _printString

    //-------------- STRCMP
    /*LDR R1, =str
    LDR R5, =stringToCompare
    MOV R0, #0
    //BL _printString
    BL _strcmp*/
    
    //--------------- MEMCHR
    /*LDR R1, =str
    LDR R2, =charToSearch
    BL _strchr// Return R0

    BL _strlen
    LDR R3, =stringMemChrFill
    BL _memchr
    LDR R0, =stringMemChrFill
    BL _printString*/

    //--------------------- MEMMOVE
    
    /*LDR R1, =stringMemMove
    BL _strlen
    MOV R3, R1
    LDR R1, =str
    BL _memmove//R1 str R5 stringMemMove
    //LDR R0, =str
    BL _printString*/

    //-------------------- MEMSET
    /*LDR R1, =charToSearch
    LDR R3, =str
    MOV R2, #5
    BL _memset
    BL _printString*/

    //----------------------- STRCAT

    /*LDR R1, =stringMemMove
    BL _strlen
    MOV R5, R1
    LDR R1, =stringCatWithFill
    BL _memmove
    //LDR R0, =str
    //BL _printString

    //LDR R1, =stringStrCat
    MOV R1, R0
    BL _strlen
    MOV R5, R1
    LDR R1, =stringStrCat
    //MOV R6, R2
    BL _strcat
    BL _printString*/

    //------------------ STRCPY


    /*LDR R1, =str
    LDR R3, =stringMemMove
    MOV R6, #4
    BL _strcpy
    LDR R0, =str
    BL _printString*/


    //----------------- STRRCHR
    /*LDR R1, =str
    LDR R2, =charToSearch
    BL _strrchr*/


    //------------------- strxfrm

    //LDR R1, =stringMemMove
    /*LDR R1, =stringCatWithFill
    LDR R3, =str
    MOV R0, #3
    BL _strxfrm
    //LDR R0, =str
    BL _printString*/


    //-------------------- UPPERCASE

    //LDR R1, =lowercasestr
    /*LDR R1, =lowercasestr
    BL _strlen
    LDR R3, =stringToSaveUpperCase
    BL _uppercase
    MOV R1, R0
    BL _printString*/

    //-------------------- LOWERCASE

    /*LDR R1, =uppercasestr
    BL _strlen
    LDR R3, =stringToSaveUpperCase
    BL _lowercase
    MOV R1, R0
    BL _printString*/


    //----------------- STRSET

    //LDR R1, =charToSearch
    /*LDR R1, =str
    BL _strlen
    LDR R1, =charToSearch
    LDR R3, =str
    BL _strset
    BL _printString*/

    //----------------- MEMCMP
    /*LDR R1, =str
    LDR R5, =stringToCompare
    //MOV R0, #0
    MOV R7, #4
    //BL _printString
    BL _memcmp
    MOV R7, #0*/

    //--------------- CHARAT 
    /*LDR R1, =str
    LDR R2, =empetyStr
    MOV R3, #4
    BL _charat*/

    //-------------- CAPITALIZE
    /*LDR R1, =str
    BL _strlen
    LDR R3, =empetyStr
    BL _capitalize
    MOV R1, R0
    BL _printString*/


    
    



    B _exit
    
    






_exit: 
    MOV R7, #1
    SVC #0 @Invoke Syscall

/*  STRCHR - Damos uma string e pesquisa na string a primeira ocorrencia desse carater

    Parametros:
    R1 - string onde vai ser pesquisado o carater
    R3 - carater 
    Retun
    R0 - a ocorrencia do carater
 */
_strchr:
    MOV R4, #0//iterador

    iterate_loop:
        LDRB R3, [R1, R4]//ler a string onde vai ser pesquisado o charter
        LDRB R6, [R2, #0]//o carater
        ADD R4, R4, #1//incrementar
        CMP R3, R6//comparar ate encontrar igual
        BNE iterate_loop
        SUB R4, R4, #1
        MOV R0, R4//retornar a posicao
    BX LR



/*  STRCMP - Compara str1 a str2 e devolve 1 para igausi 2 para diferentes 3 para strings de diferentes maneiras

    Parametros: 
    R1 - primeira string
    R5 - sergunda string

    Return
    R0 - inteiro (codigo)
 */
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
    LDR R5, =stringToCompare
    iterate_cmp_loop:
        CMP R2, R4
        MOVEQ R0, #1
        POP {LR}
        BXEQ LR
        PUSH {LR}
        LDRB R6, [R1, R4]
        LDRB R3, [R5, R4]
        CMP R6, R3 
        ADDEQ R4, R4, #1
        BEQ iterate_cmp_loop
        MOV R0, #2
    POP {LR}
    BX LR



/*  MEMCHR - basicamente um substring sem limite final
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
        MOV R0, R5
    POP {LR}
    BX LR

/*  InvertString - Inverte a string

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
        
        BX LR
    
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

/*  MEMMOVE - Mover str1 para str2  

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

/*  MEMSET - substitui na str1 com a str2 ate um certo limite dado

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
    MOV R1, R5
    mov R6, R4
    BL _strlen
    MOV R4, R6
    LDR R1, =stringStrCat
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

_strcpy:
    MOV R4, #0//Iterador

    strpy_loop:
        LDRB R5, [R3, R4]
        STRB R5, [R1, R4]
        ADD R4, #1
        CMP R4, R6
        BNE strpy_loop
    MOV R4, R6
    BX LR



/*  STRRCHR - Damos uma string e pesquisa na string a última ocorrencia desse carater

    Parametros:
    R1 - string onde vai ser pesquisado o carater
    R2 - o carater
    Return
    R0 - posição da ultima vez que encontrou o carater
 */
_strrchr:
    MOV R4, #0//iterador

    lastcharat_loop:
        LDRB R3, [R1, R4]//ler a string onde vai ser pesquisado o charter
        LDRB R6, [R2, #0]//o carater
        ADD R4, R4, #1//incrementar
        CMP R3, R6//comparar ate encontrar igual
        MOVEQ R5, R4
        CMP R3, #0
        BNE lastcharat_loop
        SUB R5, #1
        MOV R0, R5//retornar a posicao
    BX LR


/*  STRXFRM - Copia a str1 para str2 ate um certo limite e ainda devolve o tamanho da segunda str2

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
        CMP R4, R0
        BNE strxfrm_loop
        MOV R0, R1
        MOV R1, R3
        BL _strlen
        MOV R3, R2
    POP {LR}
    BX LR


/*  UPPERCASE - Metodo para converter string em lowercase para uppercase

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

/*  STRSET - Substitui todos os carateres da str1 por um carater a esolha

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

/*  MEMCMP - O mesmo que strcmp mas em vez de comparar toda a string da se um limite ate onde comparar

    Parametros: 
    R1 - primeira string
    R5 - sergunda string

    Return
    R0 - inteiro (codigo)
 */
_memcmp: 
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
    LDR R5, =stringToCompare
    memcmp_loop:
        CMP R7, R4
        MOVEQ R0, #1
        POP {LR}
        BXEQ LR
        PUSH {LR}
        LDRB R6, [R1, R4]
        LDRB R3, [R5, R4]
        CMP R6, R3 
        ADDEQ R4, R4, #1
        BEQ memcmp_loop
        MOV R0, #2
    POP {LR}
    BX LR

/* CHARAT - com o charat e possivel retornar um carater a partir de um indice numa string

    Parametros:
    R1 - string
    R3 - indice

    Return:
    R0 - carater 

 */
_charat:
    LDRB R5, [R1, R3]
    CMP R5, #0
    LDR R0, =indexNotFoundCharAt
    BXEQ LR
    STRB R5, [R2, #0]
    MOV R0, R2
BX LR


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
        ADDLT R5, #32
        STRB R5, [R3, R4]
        ADD R4, #1
        CMP R4, R2
        BNE capitalize_loop
        MOV R0, R3
BX LR
