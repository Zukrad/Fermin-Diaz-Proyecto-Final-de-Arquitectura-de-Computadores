title plantilla
 
include 'emu8086.inc' 
 
datos segment
    ;inicio declaracion de variables
   
    
    entero_1 dw 65535
    entero_2 dw 65535
    fibo_1   dw 65535
    fibo_2   dw 65535
    fibo_t   dw 65535

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
        
            print 'Ingrese un numero: '
            call scan_num      ;Ingresa un numero por pantalla y lo guarda en CX  
            GOTOXY 10, 6       ;Posiciona el cursor en una determinada coordenada
            mov entero_1,cx    ;Mueve el numero en CX en una variable
            mov entero_2,0     ;Setear variable con 1
            ;; el codigo de arriba sera para llevar la cuenta
            mov fibo_1,0
            mov fibo_2,1       ;Setear las dos variables de fibonacci
            ;mov ax, fibo_1     ;Mover variable al acumulador
            ;mov ax, entero_2   ;Mover variable al acumulador  
           
      ciclo:  
            mov ax, fibo_1     ;Mover variable al acumulador
            call print_num     ;Imprimir Numero del acumulador (AX)
            mov dl, ' '        ;todo esto es para imprimimir un espacio
            mov ah, 2          ;
            int 21h            ;hasta aca
            
            mov cx,fibo_1      ;Copia fibo_1 en una variable temporal
            mov fibo_t,cx
            
            mov cx, fibo_2     ;Copia el fibo_2 en fibo_1
            mov fibo_1, cx     ;lo de arriba             
            
            mov cx,fibo_t      ;copia fibo_t (con el valor de fibo_1 al principio del ciclo) a cx
            mov ax, fibo_2     ;Mueve variable al acumulador
            add ax,cx          ;Suma fibo_t y fibo_2, guardandolo en fibo_2
            mov fibo_2,ax
            
            mov ax,entero_2    ;Mover variable al acumulador
            add entero_2, 1    ;Sumar 1 a la variable entero_2 
            mov ax,entero_2    ;Mover al acumulador 
            cmp ax,entero_1    ;Comparar el acumulador con variable de pantalla 
            jle ciclo          ;Saltar a ciclo si el valor AX es menor o igual a entero_1.
          
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
