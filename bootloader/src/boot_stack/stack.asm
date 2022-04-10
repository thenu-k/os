;The stack is a part of the RAM. It is used when there is not enough space in registers.
; The stack grows donwards. This will be shown subsequently.

;push and pop allow us to store and retrieve data from the TOP OF THE STACK. We don't know where the stack starts and ends.
;push and pop do not work for SINGLE bytes. It is 16 bit. Once you use pop, the value is destroyed!!!
;pop bx means take the last value in the stack and copy it into bx!!!!

;The stack is controlled by the registers bp and sp. They store the addresses of the stack base and top.
;This means that if there is only one piece of data in the stack, bp=sp.
;It is upto us to set the base of the stack far away from any piece of important data.

mov ah, 0x0e ;tty mode

mov bp, 0x8000      ;initializing the base of the stack far away from 0x7c00
mov sp, bp          ;since it is empty, sp=bp

push "A"
push "B"
push "C"

;Showing that the stack grows downwards
mov al, [0x7ffe]    ;0x8000 - 2  ;Move the contents of the adress 0x7ffe into al
int 0x10            ;This should show the ASCII value of C

;You can only access the stack top!
mov al, [0x8000]
int 0x10            ;This won't work

;Retrieving the values. bp and ebx are not in the same register. bl is the lower 8bits of of ebx. bh is the last bits in ebx. bx contains all the first 16 bits, so bl and bh
pop bx              ;Copies the final stack value into bx
mov al, bl          ;bx is 16 bit but we want only the first 8 bytes of bx. this is bl
int 0x10

pop bx              ;'C' was destroyed by pop so now it's B
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55

