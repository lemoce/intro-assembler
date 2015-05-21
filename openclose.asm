        segment .data
name    db      "teste.txt",0
file    dq      0
access  dd      0xC0000000
open    dd      0x4        
normal  dd      0x80

        segment .text
        global  _tmain
        extern  CreateFileA
        extern  CloseHandle

_tmain:
        sub     rsp, 0x48

        mov     qword [rsp+48], 0
        mov     eax, [rel normal]
        mov     dword [rsp+40], eax
        mov     eax, [rel open]
        mov     dword [rsp+32], eax
        mov     r9, 0x0
        mov     r8, 0x0
        mov     rdx, [rel access]
        lea     rcx, [rel name]
        call    CreateFileA
        mov     [rel file], rax
        
        mov     rcx, [rel file]
        call    CloseHandle

        xor     rax, rax
        add     rsp, 0x48
        ret
