@Data Section
.data
.balign 4
    str: .asciz "Hello World"
.balign 4
    stringOut: .fill 50, 1, 0
.balign 4
    charToSearch: .asciz "d"
.balign 4
    intToPrint: .asciz "%i"
.balign 4 
    stringToCompare : .asciz "Hello World"

.balign 4
    stringMemChrFill: .fill 50, 1, 0
.balign 4
    stringMemMove: .asciz "O francisco"
.balign 4
    stringWithLength : .asciz "Ola                     "
.balign 4
    stringStrCat: .asciz "tudo bem?"
.balign 4
    empetyStr: .asciz ""    


.global printf
.global scanf

@Code Section
.Section .text
.global main
.arm

main:
    //LDR R0, =str@Ler a string
    //LDR R1, =stringOut@Ler a string vazia

    //MOV R1, R0//Colocar a string a ser contata em R1
    //BL _strlen
    
    @ R0 -> str1 Address
    @ R1 -> strout Address
    @ R2 -> String length
    //---------------------- INVERT STRING
    //BL _invertString
    
    //MOV R0, R1
    //BL _printString
    
    
    //PUSH {R0, R1}
    //----------------- CHAR AT
    /*LDR R1, =str
    LDR R2, =charToSearch
    BL _charat*/
    //POP {R0, R1}

    //BL _printString

    //--------------STRCMP
    LDR R1, =str
    LDR R5, =charToSearch
    MOV R0, #0
    BL _strcmp

    //--------------- MEMCHR
    /*LDR R1, =str
    LDR R5, =stringMemChrFill
    LDR R2, =charToSearch
    BL _charat// Return R0

    BL _strlen
    BL _memchr
    LDR R0, =stringMemChrFill
    BL _printString*/

    //--------------------- MEMMOVE
    /*LDR R1, =str
    LDR R5, =stringMemMove
    BL _strlen
    BL _memmove
    //LDR R0, =str
    BL _printString*/

    //-------------------- MEMSET
    /*LDR R1, =charToSearch
    LDR R5, =str
    MOV R2, #5
    BL _memset
    BL _printString*/

    //----------------------- STRCAT

    
    /*LDR R1, =stringStrCat
    LDR R5, =stringWithLength
    BL _strlen
    //MOV R6, R2
    BL _strcat
    BL _printString*/

    //------------------ STRCPY


    /*LDR R1, =str
    LDR R5, =stringMemMove
    MOV R6, #4
    BL _strcpy
    //LDR R0, =str
    BL _printString*/
    

    B _exit
    
    






_exit: 
    MOV R7, #1
    SVC #0 @Invoke Syscall


_charat:
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

/*_strcmp: 
    PUSH {LR}
    MOV R4, #0
    BL _strlen
    iterate_cmp_loop:
        LDRB R3, [R1, R4]
        LDRB R6, [R5, R4]
        MOV R0, R4
        SUB R0, R0, #1
        CMP R2, R0
        //BEQ _end_cmp_loop
        MOVEQ R0, #1
        BXEQ LR
        ADD R4, R4, #1
        CMP R3, R6
        BEQ iterate_cmp_loop
        //MOV R0, #2
    POP {LR}
    BX LR*/

_strcmp: 
    PUSH {LR}
    MOV R4, #0
    BL _strlen
    iterate_cmp_loop:
        LDRB R3, [R1, R4]
        LDRB R6, [R5, R4]
        ADD R4, R4, #1
        CMP R3, R6 
        BEQ iterate_cmp_loop
        //CMP R3, R6
        //MOVNE R0, #2
        MOV R0, R2
    POP {LR}
    BX LR


_memchr:
    PUSH {LR}
    //SUB R0, #2
    MOV R4, R0//posicao do carater encontrado
    MOV R6, #0
    iterate_memchr:
        LDRB R3, [R1, R4]
        STRB R3, [R5, R6]
        ADD R4, #1
        ADD R6, #1
        CMP R4, R2
        BNE iterate_memchr
        MOV R0, R5
    POP {LR}
    BX LR

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


_memmove:
    MOV R4, #0//Iterador

    memmove_loop:
        LDRB R3, [R5, R4]
        STRB R3, [R1, R4]
        ADD R4, #1
        CMP R4, R2
        BNE memmove_loop
        MOV R0, R5
    BX LR


_memset:
    MOV R4, #0//Iterador

    memset_loop:
        LDRB R3, [R1, #0]
        STRB R3, [R5, R4]
        ADD R4, #1
        CMP R4, R2//R2 ate onde substituir
        BNE memset_loop
        MOV R0, R5
    BX LR


_strcat:
    PUSH {LR}
    MOV R4, R2//Iterador
    MOV R4, #4    
    MOV R0, #0
    BL _strlen
    MOV R6, R2
    strcat_loop:
        LDRB R3, [R1, R0]//tudo bem?
        STRB R3, [R5, R4]//ola
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
        LDRB R3, [R5, R4]
        STRB R3, [R1, R4]
        ADD R4, #1
        CMP R4, R6
        BNE strpy_loop
    MOV R4, R6
    /*LDR R0, =empetyStr
    strpy_loop_todeleterest:
        LDRB R3, [R0, #0]
        STRB R3, [R1, R4]
        ADD R4, #1
        CMP R4, R3
        BNE strpy_loop_todeleterest    
        MOV R0, R1*/
    BX LR

_strcspn:

    BX LR