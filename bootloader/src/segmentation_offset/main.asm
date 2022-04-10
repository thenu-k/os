;ds ss etc are extra registers that can offset the memory by a certain amount.
;For example, if we set ds to be 0x020 and then we initialize :
;mov ax, [0x50]  -> The actual data will not be stored at 0x50 but (0x020*16 + 0x50). 0x020*16  = 0x200
;ss does the same but for the base pointer of the stack

;We cannot directly set ds to be an address so we must use an auxillary register and transfer the value

mov ah, 0x0e

mov al, [data]
int 0x10         ;this will not display the value as we have not offsetted the value by 0x7c00. It will display a random value

mov bx, 0x7c0   ;this is not an addresss, it is the value
mov ds, bx       ;this is the address of bx

mov al, [data]  ;now the offset will occur
int 0x10

jmp $

data:
    db "X"
    
times 510-($-$$) db 0
dw 0xaa55

;What is es? es is also an offset like ds but we have to specify when we actually use it:
;mov bx, 0x7c0
;mov es, bx
;mov ax, [es:data]
;data: db "X"