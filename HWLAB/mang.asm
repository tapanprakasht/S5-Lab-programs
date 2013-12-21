;A file manager in ALP that perform functions such as create directory,
;delete directory,change directory,print present working directory,
;create file,delete file.
display macro arg
	lea dx,arg
	mov ah,09h
	int 21h
endm
read macro arg
	local l1,l2
	lea bx,arg
	add bx,2
l1:	mov ah,01h	
	int 21h
	cmp al,13
	je l2
	mov [bx],al
	inc bx
	jmp l1
l2:	mov al,0
	mov [bx],al
endm
data segment
	msg1 db 0ah,0dh,"Enter the name:$"
	msg2 db 0ah,0dh,"Directory created!!$"
	msg3 db 0ah,0dh,"Directory deleted!!$"
	msg4 db 0ah,0dh,"Directory changed!!$"
	msg5 db 0ah,0dh,"Present working directory:$"
	msg6 db 0ah,0dh,"File created$"
	msg7 db 0ah,0dh,"File deleted$"
	msg8 db 0ah,0dh,"Error encountered!!$"
	msg9 db 0ah,0dh,"Enter choice:$"
	men1 db 0ah,0dh,"1.create directory$"
	men2 db 0ah,0dh,"2.delete directory$"
	men3 db 0ah,0dh,"3.change directory$"
	men4 db 0ah,0dh,"4.display current directory$"
	men5 db 0ah,0dh,"5.create file$"
	men6 db 0ah,0dh,"6.Delete file$"
	men7 db 0ah,0dh,"7.Exit$"
	str1 db 40 dup("$")
	str2 db 40 dup("$")
	choice db 0
data ends
code segment
assume cs:code,ds:data
start:	mov ax,data
	mov ds,ax
	display men1
	display men2
	display men3
	display men4
	display men5
	display men6
	display men7
main:	display msg9
	mov ah,01h
	int 21h
	sub al,30h
	cmp al,1
	jnz rmdir
	display msg1
	read str1
	lea dx,str1
	add dx,2
	mov ah,39h
	int 21h
	jnc l3
	display msg8
	jmp main
l3:	display msg2
	jmp main
rmdir:	cmp al,2
	jnz chdir
	display msg1
	read str1
	lea dx,str1
	add dx,02
	mov ah,3ah
	int  21h
	jnc l4
	display msg8
	jmp main
l4:	display msg3
	jmp main
chdir:	cmp al,3
	jnz pwd
	display msg1
	read str1
	lea dx,str1
	add dx,02
	mov ah,3bh
	int 21h
	jnc l5
	display msg8
	jmp main
l5: 	display msg4
	jmp main
pwd:	cmp al,4
	jnz cfile
	lea si,str2
	mov dl,0
	mov ah,47h
	int 21h
	jnc l6
	display msg8
	jmp main
l6:	display msg5
	display str2
	jmp main
cfile:	cmp al,5
	jnz dfile
	display msg1
	read str1
	lea dx,str1
	add dx,02
	mov cx,0
	mov ah,3ch
	int 21h
	jnc l7
	display msg8
	jmp main
l7:	display msg6
	jmp main
dfile:	cmp al,6
	jnz exit
	display msg1
	read str1
	lea dx,str1
	add dx,02
	mov ah,41h
	int 21h
	jnc l8
	display msg8
	jmp main
l8:	display msg7
	jmp main
exit:	mov ah,4ch
	int 21h
code ends
end start

	
