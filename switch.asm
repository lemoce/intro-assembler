        [bits 64]
        global  _tmain

segment .data
switch: dq      _tmain.case0
        dq      _tmain.case1
        dq      _tmain.case2

i:      dq      2

segment .text

_tmain:
      
        mov     rax, [qword i]
        lea     rbx, [rel switch]
        jmp     [rbx + rax * 8]

.case0:
        mov     rbx, 100
        jmp     .end

.case1:
        mov     rbx, 101
        jmp     .end

.case2:
        mov     rbx, 102
        
.end:
        xor     rax, rax
        ret
        
