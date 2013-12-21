;ALP to display System date and time
display macro arg
 	mov dx,offset arg
	mov ah,09h
	int 21h
endm
print macro arg1
	local l1,l2
	mov cx,0000h
	mov ax,arg1
	mov bx,0ah
	l1:mov dx,0000h
	   div bx
	   push dx
	   inc cx
	   cmp ax,0000h
	   jnz l1
	l2:pop dx
	   add dx,30h
	   mov ah,02h
	   int 21h
	   loop l2
endm
assume cs:code,ds:data

data segment
 	str db 0ah,0dh,"Date=$"
	str1 db "-$"
	str2 db 0ah,0dh,"Time=$"
	year dw ?
 	month db ?
 	day db ?
	princ dw ?
	hour db ?
	minute db ?
	second db ?
data ends

code segment
start:	mov ax,data
	mov ds,ax
	mov ah,2ah
	int 21h
	mov year,cx
	mov month,dh
	mov day,dl
	display str
	mov bl,day
	mov bh,00h
	print bx
	display str1
	mov bl,month
	mov bh,00h
	print bx
	display str1
	mov bx,year
	print bx
	
	mov ah,2ch
	int 21h
	mov hour,ch
	mov minute,cl
	mov second,dh
	display str2
	mov bl,hour
	mov bh,00h
	print bx
	display str1
	mov bl,minute
	mov bh,00h
	print bx
	display str1
	mov bl,second
	mov bh,00h
	print bx
	mov ah,4ch
	int 21h
code ends
end start
