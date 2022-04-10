
;Within the lower memory(?) the bootsector is located at the 0x7c00 position.
;Refer: https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf pg 14

;We will try to store an object in the memory. 
;To store a piece of data, it needs an offset position. The offset position is the distance between 2 bytes of data.
;For example, the offset position of the boot loader is 0x7c00 compared to the 0 position.

;We can declare a piece of data like:
; DATA: 
;     db 'D'
;Each variable has a pointer. The pointer is denoted by DATA. The content, [DATA].
;[org 0x7c00]
mov ah, 0x0e


;The pointer
mov al, "1"
int 0x10
mov al, data    ;'data' is only the address where the contents of data is located, not the actual content itself
int 0x10

;The contents. But this won't work
mov al, "2"
int 0x10
mov al, [data]    ;There already is data inside 0x7x00 (the boot loader itself). Therefore we must apply padding to the new piece of data.
int 0x10

;Adding offsets.
mov al, "3"
int 0x10
mov bx, data   ;this is the pointer; so bx becomes the address of the POINTER
add bx, 0x7c00    ;this adds together bx and 0x7c00. Remember the current value of bx is the pointer of data. Equivalent to bx = bx + 0x7c00
mov al, [bx]   ;mov the contents of address denoted by (bx+0x7c00) to al
int 0x10

mov al, "|"
int 0x10

;It is hard to account for this error all the time, so include [org 0x7c00] to the top of the code
; mov bx, new_data
; mov ax, [bx]
; int 0x10

jmp $ ; Jumps to current address// probably a short hand of the loop; jpm loop method

data:
    db "X"
new_data:
    db "HELLO",0

;Magic number
times 510 - ($-$$) db 0
dw 0xaa55 



;data is the address of "x" from the start of the boot loader memory 0x7c00. Not from the bottom of the entire memory.
; So we must add an offset of 0x7c00 to the pointer of data.

