;ALP to count vowels and consonants in a given string
print macro arg
       lea dx,arg
       mov ah,09h
       int 21h
endm

data segment
       str1 db 0ah,0dh,"Enter the string:$"
       str2 db 30 dup(?)
       char db 'a','e','i','o','u','$'
       str4 db 0ah,0dh,"Number of vowels=$"
       str5 db 0ah,0dh,"Number of consonants=$"
       len dw ?
       no dw ?
data ends

assume cs:code,ds:data
code segment
start:	mov ax,data
      	mov ds,ax
       	print str1
       	lea si,str2
	mov cx,00
	mov dx,00
a1:	mov ah,01h
	int 21h
	cmp al,13
	jz a2
	mov [si],al
	inc si
	inc cx
	mov len,cx
	jmp a1
a2:	lea si,str2
a3:	lea di,char
	mov al,[si]
	l1:mov bl,[di]
	   mov bh,00h
	   mov ah,00h
	   cmp ax,bx
	   jz true
	   inc di
	   mov bl,'$'
	   cmp [di],bl
	   jnz l1
	   mov bl,' '
	   cmp [si],bl
	   jz m
m1:	inc si
	loop a3
	mov no,dx
	print str4
	
		mov cx,00h
		mov ax,no
		mov bx,0ah
		  k1:mov dx,0000h
		      div bx
		     push dx
		     inc cx
		     cmp ax,0000h
		     jnz k1
		 k2:pop dx
		      add dx,30h
		      mov ah,02h
		      int 21h
		      loop k2
	print str5
	mov ax,len
	mov bx,no
	sub ax,bx
	mov no,ax
		mov cx,00h
		mov ax,no
		mov bx,0ah
		  k3:mov dx,0000h
		      div bx
		     push dx
		     inc cx
		     cmp ax,0000h
		     jnz k1
		 k4:pop dx
		      add dx,30h
		      mov ah,02h
		      int 21h
		      loop k2
	jmp exit
m:	mov bx,len
	dec bx
	mov len,bx
	jmp m1
true:	inc dl
	inc si
	jmp a3
exit:	mov ah,4ch
	int 21h

code ends
end start
