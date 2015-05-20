        global          _tmain

        extern          ExitProcess
        extern          MessageBoxA

        segment         .data
msgb    db              "'pusheax.com!'",0x0 
title   db              "'Security Research!'",0x0

        segment         .text

_tmain:

        mov             rbp, rsp
        sub             rsp, 8
        
        mov             rcx, 0x0
        mov             rdx, qword msgb
        mov             r8, qword title
        xor             r9, r9
        call            MessageBoxA
        
        mov             rcx, rax
        call            ExitProcess

