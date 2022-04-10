; This programme will create an infinite loop in the boot sector
; A boot sector is located in the very first part of the hard disk and consists of 512 bytes.

;This is a simple boot sector:
; e9 fd ff 00 00 00 00 00 00 00 00 00 00 00 00 00
; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
; [ 29 more lines with sixteen zero-bytes each ]
; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa

;It is essential that the last two bytes are 0xAA55. The first three bytes perform an infinite jump
; Is the above block wrong? The last one is AA  -- this might have to do something with little endianness : https://www.tutorialspoint.com/big-endian-and-little-endian 

;Infinite loop
loop: 
    jmp loop
;Filling the 0s the boot
times 510-($-$$) db 0   ;db means databyte; this command creates the 0s?
;The last two bytes
dw 0xaa55


;The bios doesn't know how to load the OS. THe boot sector does that. 