.model small

.data
msg0 db 10,13,"type e for encryption or d for decryption : $"
msg1 db 10,13,"enter 5 chars: $"  
msg2 db 10,13,"the result: $"
                      
arr1 db 5 dup (00)           
arr2 db 5 dup(00),'$'

.code

check_enc macro 
   cmp al,'z' 
   ja ok    
   cmp al,'A'  
   jb ok    
   CMP AL,'Z' 
   je no   
   cmp al,'z' 
   je no   
   cmp al,'Y' 
   je no   
   cmp al,'y' 
   je no   
   cmp al,'X' 
   je no   
   cmp al,'x' 
   je no   
   
   add al,3   
   jmp ok
   no:
   sub al,23 
   jmp ok
   ok:
endm
    
   
check_dec macro 
   cmp al,'z' 
   ja ok_dec    
   cmp al,'A'  
   jb ok_dec    
   CMP AL,'A' 
   je no_dec   
   cmp al,'a' 
   je no_dec   
   cmp al,'B' 
   je no_dec   
   cmp al,'b' 
   je no_dec   
   cmp al,'C' 
   je no_dec   
   cmp al,'c' 
   je no_dec   
   
   sub al,3   
   jmp ok_dec
   no_dec:
   add al,23 
   jmp ok_dec
   ok_dec:
endm 


start:
   
   mov ax,@data  
   mov ds,ax      
   lea si,arr1   
   lea di,arr2   

   mov ah,09h
   lea dx,msg0
   int 21h
   
   
   
   mov ah,01h   
   int 21h
   
   cmp al , 'd'
   je decryption
   cmp al ,'e'
   je encryption
   jmp start
   
   
   encryption:
   mov ah,09h
   lea dx,msg1
   int 21h

   
   mov cx,0005  

   input: 
   mov ah,01h
   int 21h                                                                                                                                                         
   mov [si], al       
   inc si 
   loop input                      
   
   
   
   mov dx,0000
   mov cx,0005  
   lea si,arr1
   
   encryption_loop: 
   mov al, [si] 
   check_enc       
   mov [di],al
   inc si  
   inc di
   
   loop encryption_loop     
   
   jmp end_of_program 
   
   
   
   
   decryption:
   
   mov ah,09h
   lea dx,msg1
   int 21h

   
   mov cx,0005  

   input_d: 
   mov ah,01h
   int 21h                                                                                                                                                         
   mov [si], al       
   inc si 
   loop input_d                      
   
   
   
   mov dx,0000
   mov cx,0005  
   lea si,arr1
   
   decryption_loop: 
   mov al, [si] 
   check_dec al      
   mov [di],al
   inc si  
   inc di
   loop decryption_loop
   
   end_of_program:
   mov ah,09h  
   lea dx,msg2 
   
   int 21h 
    

   mov ah,09h
   lea dx,arr2
   int 21h   

   end
   
   