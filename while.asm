        segment .data
data    dq      0xfedcba9876543210
sum     dq      0

        segment .text
        global  _tmain
_tmain:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16

        mov     rax, [qword data]
        xor     ebx, ebx
        xor     ecx, ecx
        xor     edx, edx
while:
        cmp     ecx, 64
        jnl     end_while
        bt      rax, 0
        setc    bl
        add     edx, ebx
        shr     rax, 1
        inc     rcx
        jmp     while
end_while:
        mov     qword [rel sum], rdx
        xor     eax, eax
        leave
        ret
