;We can use bios routines to access hard disks(or floppy disks).
;To acccess a certain piece of data, the disk, platter, sector, etc must be specified.

;We can enter disk read mode by setting ah to 0x02

mov ah, 0x02

mov dl, 0       ;Drive 0
mov ch, 1       ;Cylinder 1
mov dh, 0       ;Read the first side of the disk. The other value is 1
mov cl, 4       ;Track 4
mov al, 5       ;Read 5 sectors starting from 1

;Setting which address the routine will copy the data into
mov bx, 0xa000
mov es, bx      ;When we set a register to another, we copy the actual data
mov bx, 0x1234  ;There will be an offset of es

;Issuing the interrupt so that the routine will occur
int 0x13

;Error handling!
;When there is an error, the BIOS updates certain registers. The carry flag will eb
;The bios will set al to the number of sectors that were actually read.

js call disk_error   ;jc only occurs if the carry flag was set

cmp al, 5       ;We requested 5 sectors; This is a double check!
je disk_error   ;

jmp $
disk_error:
    ;Do stuff

times 510-($-$$) db 0
dw 0xaa55
