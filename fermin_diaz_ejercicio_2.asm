title plantilla
 
include 'emu8086.inc' 
 
datos segment
    ;inicio declaracion de variables
    ;byte
    varbyte db 255 
    
    ;word
    varword dw 65535
    
    numero   db 0, 255
    cambios  db 0, 255
    for1     db 0, 255
    for2     db 0, 255
    saltempo db 0, 255
    aux      db 0, 255
    
    numero_1 db 0, 255
    numero_2 db 0, 255 
    
    numero_inicial db 1,2,3,4,5,6,7,8
    numero_destino db 8 dup(0)

    ;fin declaracion de variables
datos ends

pila segment

    db 64 dup(0)

pila ends

codigo segment
    
    inicio proc far
        assume ds:datos, cs:codigo, ss:pila
        push ds
        mov ax,0
        push ax
        
        mov ax,datos
        mov ds,ax
        mov es, ax
        ;codigo del programa -----------------------------------------
            
            
            ;;No funcionaba este ciclo, que era para que el usuario pudiera meter
            ;;los numeros que quiera, asi que el array solo puede ser de 6 numeros        
            ;GOTOXY 10, 5
            ;print 'Ingrese cantidad de numeros a ordenar:'
            ;call scan_num
            ;mov canti[0],cl ; Para saber cuantos numeros se necesitan ordenar
            ;mov canti[1],6  ; Se usa para el GOTOXY
            ;mov canti[2],0  ; Se usa en el loop
            
            ;ciclo:  
            ;GOTOXY 10, canti[1]
            ;print 'Ingrese numero:'
            ;GOTOXY 25, canti[1]
            ;mov ax,0
            ;mov al, canti[2]
            ;call print_num
            ;call scan_num
            ;mov numero[canti[2]],cl
            ;cmp canti[2],canti[0]     ;Compara el numero actual del ciclo con el total 
            ;jle ciclo 
            
            
            ;Introduccion de datos muy feo y sin ciclo
            
            
            GOTOXY 10, 5
            print 'Ingrese numero_0:'
            call scan_num
            mov numero[0],cl
            mov ax,0
            mov al,cl
            call print_num
            
            
            GOTOXY 10, 6
            print 'Ingrese numero_1:'
            call scan_num
            mov numero[1],cl
            GOTOXY 10, 7
            print 'Ingrese numero_2:'
            call scan_num
            mov numero[2],cl
            GOTOXY 10, 8
            print 'Ingrese numero_3:'
            call scan_num
            mov numero[3],cl
            GOTOXY 10, 9
            print 'Ingrese numero_4:'
            call scan_num
            mov numero[4],cl
            GOTOXY 10, 10
            print 'Ingrese numero_5:'
            call scan_num
            mov numero[5],cl
                     
            
            ;;Inicia el for1
            mov for1,3       ; Setea for1 a 3
    loop1:   
            mov cambios,1    ; Aqui empieza el contenido del for1 
            
            ;;Inicia el While (Cambios)
            jmp loop2        ; Salta a loop2
    cloop1:  
            mov cambios,0    ; Aqui empieza el contendio del while
            
            
            mov ax,0
            mov al,for1
            mov for2,al      ; Setea for2 a "salto"
    loop3:   
            ; Aqui empieza el contendio for2
            ;;empieza el If
            mov ax,0
            mov al,for2            
            mov saltempo,al ;;saltempo representa i-salto en el codigo de Java
            
            mov ax,0
            mov al,for1
            sub saltempo,al
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;;Esta es la parte que falla, no puedo comparar datos dentro de numero y no se   ;;
            ;;porque, intente buscar en internet y en help pero no encontre nada al respecto ;;
            ;;la logica del resto del programa deberia estar bien segun yo                   ;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            cmp numero[saltempo],numero[for2]
            ;;;;;help meeee aaaaaaaaaaaaaaaaa;;;;;
            jl  ifverdadero
            
            jl  iffalso
            
    ifverdadero:
            mov ax,0
            mov al,numero[for2]
            mov aux,al
            
            mov ax,0
            mov al,numero[saltempo]
            mov numero[for2],al
            
            mov ax,0
            mov al,aux
            mov numero[saltempo],al
            
            mov cambios,1
            
    iffalso:                         
            
            ;;Final del for2
            inc for2         ; Incremento
            cmp for2,6       ; Compara for2 al limite (6)
            jle loop3        ; Loop while less or equal
            
    loop2:   
            cmp cambios,1    ; Revisa el "boolean" cambio
            je  cloop1       ; Vuelve a cloop si boolean a 1   
    
            ;;Final del for1
            mov ax,0
            mov al,for1
            mov bl,2
            div bl           ; Division
            mov for1,al
            cmp for1,0       ; Compara cx al limite (0)
            jle loop1        ; Loop ocurre si cx =!0
            
            
            
            ;Impresion de datos muy feo
            mov ax,0
            mov al, numero[0]   
            GOTOXY 10, 11
            call print_num ;Imprime lo que esta en AX
            mov ax,0
            mov al, numero[1]   
            GOTOXY 10, 12
            call print_num ;Imprime lo que esta en AX   
            mov ax,0
            mov al, numero[2]   
            GOTOXY 10, 13
            call print_num ;Imprime lo que esta en AX            
            mov ax,0
            mov al, numero[3]   
            GOTOXY 10, 14
            call print_num ;Imprime lo que esta en AX            
            mov ax,0
            mov al, numero[4]   
            GOTOXY 10, 15
            call print_num ;Imprime lo que esta en AX           
            mov ax,0
            mov al, numero[5]   
            GOTOXY 10, 16
            call print_num ;Imprime lo que esta en AX
              
          
        ;fin codigo del programa -------------------------------------   
        
        
        
        
        
        ret
    inicio endp 
    
    
codigo ends

    DEFINE_PRINT_STRING  
    DEFINE_GET_STRING  
    DEFINE_SCAN_NUM
    DEFINE_PRINT_NUM 
    DEFINE_PRINT_NUM_UNS
    end inicio
