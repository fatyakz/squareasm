.data
	; target is n+1
	target8 db 11

.code
squareASM proc
	; cells of square
	mov rax, 1	
	mov rcx, 1	
	mov rdx, 1	
	mov r8, 1	
	mov r9, 1	
	mov r10, 1	
	mov r11, 1
	mov r12, 1
	mov r13, 1

	; sums
	mov r14, 0
	mov r15, 0
	mov rsi, 0

	; target bl
	; CMP against memory 1.79s, CMP against reg 1.9s
	mov bl, target8
	inc bl

	; cycles
	push rbp
	mov rbp, 0

sloop:
	; line 2
	mov r14b, al
	add r14b, cl
	add r14b, dl
	; line 3
	mov r15b, r8b
	add r15b, r9b
	add r15b, r10b
	; compare lines 2 and 3
	cmp r14, r15
	jne notequal
	 
	; line 4
	mov rsi, r11
	add rsi, r12
	add rsi, r13
	; compare lines 2 and 4
	cmp r14, rsi
	jne notequal
	; compare lines 3 and 4
	cmp r15, rsi
	jne notequal

	; line comparison used to be after unique test
	; minor speed boost from doing it earlier

	; already know lines 2=3=4
	; leave line 2 in r14, use r15 for other lines
	; line 1
	mov r15b, dl
	add r15b, r9b
	add r15b, r11b
	; compare lines 2 and 1
	cmp r14, r15
	jne notequal

	; line 5
	mov r15b, al
	add r15b, r8b
	add r15b, r11b
	; compare lines 2 and 5
	cmp r14, r15
	jne notequal

	; line 6
	mov r15b, cl
	add r15b, r9b
	add r15b, r12b
	; compare lines 2 and 6
	cmp r14, r15
	jne notequal

	; line 7
	mov r15b, dl
	add r15b, r10b
	add r15b, r13b
	; compare lines 2 and 7
	cmp r14, r15
	jne notequal

	; line 8
	mov r15b, al
	add r15b, r9b
	add r15b, r13b
	; compare lines 2 and 8
	cmp r14, r15
	jne notequal

	; line matches counter
	; inc rbp

testforuniquecells:
	; compare rax (A) with square
	cmp rcx, rax
	je notequal
	cmp rdx, rax
	je notequal
	cmp r8, rax
	je notequal
	cmp r9, rax
	je notequal
	cmp r10, rax
	je notequal
	cmp r11, rax
	je notequal
	cmp r12, rax
	je notequal
	cmp r13, rax
	je notequal
	; compare rcx (B) with square
	cmp rdx, rcx
	je notequal
	cmp r8, rcx
	je notequal
	cmp r9, rcx
	je notequal
	cmp r10, rcx
	je notequal
	cmp r11, rcx
	je notequal
	cmp r12, rcx
	je notequal
	cmp r13, rcx
	je notequal
	; compare rdx (C) with square
	cmp r8, rdx
	je notequal
	cmp r9, rdx
	je notequal
	cmp r10, rdx
	je notequal
	cmp r11, rdx
	je notequal
	cmp r12, rdx
	je notequal
	cmp r13, rdx
	je notequal
	; compare r8 (D) with square
	cmp r9, r8
	je notequal
	cmp r10, r8
	je notequal
	cmp r11, r8
	je notequal
	cmp r12, r8
	je notequal
	cmp r13, r8
	je notequal
	; compare r9 (E) with square
	cmp r10, r9
	je notequal
	cmp r11, r9
	je notequal
	cmp r12, r9
	je notequal
	cmp r13, r9
	je notequal
	; compare r10 (F) with square
	cmp r11, r10
	je notequal
	cmp r12, r10
	je notequal
	cmp r13, r10
	je notequal
	; compare r11 (G) with square
	cmp r12, r11
	je notequal
	cmp r13, r11
	je notequal
	; compare r12 (H) with square
	cmp r13, r12
	je notequal

	

	; cell matches counter
	inc rbp

notequal:
	; cycles counter
	; inc rbp 

	; add and inc seem to be the same speed
	add al, 1
	cmp al, bl
	jne sloop
	mov al, 1
	
	inc cl
	cmp cl, bl
	jne sloop
	mov cl, 1
	
	inc dl
	cmp dl, bl
	jne sloop
	mov dl, 1

	inc r8b
	cmp r8b, bl
	jne sloop
	mov r8b, 1
	
	inc r9b
	cmp r9b, bl
	jne sloop
	mov r9b, 1

	inc r10b
	cmp r10b, bl
	jne sloop
	mov r10b, 1

	inc r11b
	cmp r11b, bl
	jne sloop
	mov r11b, 1

	inc r12b
	cmp r12b, bl
	jne sloop
	mov r12b, 1

	inc r13b
	cmp r13b, bl
	jne sloop

	mov rax, rbp
	pop rbp
	ret
squareASM endp
end