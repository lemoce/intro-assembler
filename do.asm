        segment .data
data    db      "Hello world", 0
n       dq      0
needle  db      'w'

        segment .text
        global _tmain
_tmain:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     bl, byte [rel needle]
        xor     ecx, ecx
        lea     rdx, [rel data]
        mov     al, byte [rdx+rcx]
        cmp     al, 0
        jz      end_while
while:
        cmp     al, bl
        je      found
        inc     rcx 
        lea     rdx, [rel data]
        mov     al, byte [rdx+rcx]
        cmp     al, 0
        jnz     while
end_while:
        mov     rcx, -1
found:
        mov     [rel n], rcx
        xor     eax, eax
        leave
        ret
