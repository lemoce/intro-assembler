        segment .data
port    dd      80
url     db      "23.216.170.96",0x0
ptrWSAD dq      0
ptrSkAI dq      0
sock    dq      0        
        struc   WSAData
wVer    resw    1
wHVer   resw    1
szDesc  resb    257
szSySts resb    129
maxSock resw    1        
maxUdp  resw    1
vendor  resq    1
        endstruc
        struc   sockaddr_in
sin_fam resw    1
sin_por resw    1        
s_in_ad resd    1
sin_zer resb    8
        endstruc
heap    dq      0

        segment .text
        global _tmain
        extern  GetProcessHeap
        extern  HeapAlloc
        extern  HeapFree
        extern  WSAStartup
        extern  WSACleanup
        extern  htons
        extern  inet_addr
        extern  socket
        extern  connect
        extern  closesocket

_tmain:
        sub     rsp, 72
        call    GetProcessHeap          
        mov     [rel heap], rax         
        mov     rcx, [rel heap]         
        mov     rdx, 0x8
        mov     r8, WSAData_size
        call    HeapAlloc
        mov     [rel ptrWSAD], rax
        mov     rcx, 0x0202
        mov     rdx, rax
        call    WSAStartup
        cmp     eax, 0
        jne     end

        mov     rcx, [rel heap]
        mov     rdx, 0x8
        mov     r8, sockaddr_in_size
        call    HeapAlloc
        mov     [rel ptrSkAI], rax

        
        mov     word [rax], 0x2

        mov     ecx, [rel port]
        call    htons
        mov     rbx, [rel ptrSkAI]
        mov     [rbx+sin_por], ax

        lea     rcx, [rel url]
        call    inet_addr
        mov     [rbx+s_in_ad], eax

        mov     rcx, 0x2
        mov     rdx, 0x1
        mov     r8, 0x6
        call    socket
        mov     qword [rel sock], rax

        mov     rcx, [rel sock]
        mov     rdx, [rel ptrSkAI]
        mov     r8, sockaddr_in_size
        call    connect

        mov     rcx, [rel sock]
        call    closesocket

        mov     rcx, [rel heap]
        mov     rdx, 0
        mov     r8, [rel ptrSkAI]
        call    HeapFree
        
        mov     rcx, [rel heap]
        mov     rdx, 0
        mov     r8, [rel ptrWSAD]
        call    HeapFree
        call    WSACleanup
end:
        xor     rax, rax
        add     rsp, 72
        ret
        
