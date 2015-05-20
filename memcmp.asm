        segment .data
a       db      "This is fun"
b       db      "This is not"

        segment .text
        global  _tmain
        global  memcmp
memcmp:
        mov     rcx, rdx
        repe    cmpsb
        cmp     rcx, 0
        jz      equal
        movzx   eax, byte [rdi-1]
        movzx   ecx, byte [rsi-1]
        sub     rax, rcx
        ret
equal:  xor     eax, eax
        ret

_tmain:
        push    rbp
        mov     rbp, rsp
        lea     rdi, [rel a]
        lea     rsi, [rel b]
        mov     edx, 11
        call    memcmp
        xor     eax, eax
        leave
        ret
        
