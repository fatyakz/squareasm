        ; faster 'basic' 64 bit prime sieve
       
        include \masm32\include64\masm64rt.inc

        .data

        pTbl        dq 0
        arrsize     dq 10000         ; must be divisible by 8
        curnumber   dq 0
        hPrimes     dq 0
        fName       db "Primes.txt", 0
        pfname      dq 0
        .code
        start proc

        invoke GlobalAlloc, GPTR, arrsize
        cmp rax, 0
        jz noarray

        mov pTbl, rax

        mov rsi, pTbl
        xor rax, rax
        mov rdi, rsi
        add rdi, arrsize
       
       
        mov rcx, 0100010001000100h      ; 8 bytes at a time  :)
        align 16
       
        @@:
        mov qword ptr [rsi], rcx
        add rsi, 8
        cmp rsi, rdi
        jge @f
        jmp @b
        @@:

        mov rsi, pTbl
        xor rax, rax
       
        mov byte ptr [rsi+rax+2], 1     ; mark '2' as prime
       
        mov rcx, 3                ; skip '1' and '2' (already marked)
        add rax, rcx



        @@:
        add rax, rcx
        cmp rax, arrsize
        jae done1
        cmp byte ptr [rsi+rax], 0
        jz @b
        mov byte ptr [rsi+rax], 0
        jmp @b
       
        done1:
        inc rcx             ; increment counter twice
        inc rcx             ; effectively skipping even numbers
        cmp rcx, arrsize
        jae done2
        xor rax, rax
        add rax, rcx
        jmp @b
       

       
       
        done2:
        mov hPrimes, flcreate("Primes.txt")
       
        mov rdi, 2       
        flprint hPrimes, str$(rdi),lf
       
        mov rdi, 3          ; first odd number afert '2'
        @@:
        cmp byte ptr [rsi+rdi], 1
        jnz noprint
        nop
        flprint hPrimes, str$(rdi),lf

        noprint:
       
        inc rdi             ; inc rdi twice, effectively skipping over
        inc rdi             ; even numbers which are not prime except '2'
        cmp rdi, arrsize
        jge outtahere

        jmp @b
       
        outtahere:
         
        flclose hPrimes
        invoke GlobalFree, pTbl

        noarray:
        invoke ExitProcess, 0
        start endp
        end