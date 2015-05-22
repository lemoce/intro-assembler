        segment .data
ptrWSAD dq      0
        struc   WSAData
wVer    resw    1
wHVer   resw    1
szDesc  resb    257
szSySts resb    129
maxSock resw    1        
maxUdp  resw    1
vendor  resq    1
        endstruc
heap    dq      0


        segment .text
        global _tmain
        extern  GetProcessHeap
        extern  HeapAlloc
        extern  HeapFree
        extern  WSAStartup
        extern  WSACleanup

_tmain:
        sub     rsp, 72
        call    GetProcessHeap
        mov     [rel heap], rax
        mov     rcx, [rel heap]
        mov     rdx, 0x8
        mov     r8, WSAData_size
        call    HeapAlloc
        mov     [rel ptrWSAD], rax
        mov     rcx, 2
        shl     rcx, 32
        add     rcx, 2
        mov     rdx, rax
        call    WSAStartup
        cmp     eax, 0
        jne     end
        mov     rcx, [rel heap]
        mov     rdx, 0
        mov     r8, [rel ptrWSAD]
        call    HeapFree
        call    WSACleanup
end:
        xor     rax, rax
        add     rsp, 72
        ret
