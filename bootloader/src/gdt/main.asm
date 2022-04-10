[org 0x7c00]

    mov bp, 0x9000  
    mov sp, bp

    call switch_to_protected

    jmp $

%include "gdt.asm"
%include "switch_to_protected.asm"
%include "../32_mode/main.asm"

[bits 32]
;Switch to protected leads us here
begin_protected:
    mov ebx, message
    call print_string

    jmp $

message:
    db "Entered 32 bit mode", 0

times 510-($-$$) db 0
dw 0xaa55
