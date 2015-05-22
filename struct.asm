        segment .data
name    db      "Calvin",0
address db      "12 Mockinbird Lane",0
balance dd      12500
        struc   Customer
c_id      resd  1
c_name    resb  64
c_address resb  64
c_balance resd  1
        endstruc
c       dq      0

        segment .text
        global  _tmain
        extern  malloc, strcpy

_tmain:
        sub     rsp, 72

        mov     rcx, Customer_size
        call    malloc
        mov     [rel c], rax
        mov     [rax+c_id], dword 7
        lea     rcx, [rax+c_name]
        lea     rdx, [rel name]
        call    strcpy
        mov     rax, [rel c]
        lea     rcx, [rax+c_address]
        lea     rdx, [rel address]
        call    strcpy
        mov     rax, [rel c]
        mov     edx, [rel balance]
        mov     [rax+c_balance], edx
        xor     rax, rax
        add     rsp, 72
        ret
