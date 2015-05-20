        segment .data
s       db      "Hello World!",0

        segment .text
        global  _tmain
        global  strlen
strlen:
        cld
        mov     rcx, -1
        xor     al, al
        repne   scasb
        mov     rax, -2
        sub     rax, rcx
        ret

_tmain:
        push    rbp
        mov     rbp, rsp
        lea     rdi, [rel s]
        call    strlen
        xor     eax, eax
        leave
        ret
        
