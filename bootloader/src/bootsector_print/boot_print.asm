;Registers are small data stores located in the CPU!
;The data register consists of 4, 32 bit smaller registers. 
;One of these smaller registers is called EAX. From EAX we can INFER(!!!) AX, AH etc
;eg: if EAX is 1001 0001 1110 1110. AX is the lower half, 1110 11110 and so on.

;To write something on the screen, we will write the letters into al. We will also write
;0x0e into ah and then use 0x10 to make an interrupt
;0x0e inside ah tells the video interrupt that we want to write the contents of al in tty mode

mov ah, 0x0e ;tty mode
mov al, 'H'
int 0x10      ;interrupt
mov al, 'E'
int 0x10
mov al, 'L'
int 0x10
;move al, 'L' We don't need to move it twice because it is already there. Usually we would garbage collect
int 0x10
mov al, 'O'
int 0x10

jmp $ ; Jumps to current address// probably a short hand of the loop; jpm loop method

;Magic number
times 510 - ($-$$) db 0
dw 0xaa55 