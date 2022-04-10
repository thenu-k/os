;==========================================
;Now that we have defined our gdt, we can actually do the bit switch


[bits 16]
switch_to_protected:
    cli                   ;Stops all interrupts

    lgdt[gdt_descriptor]  ;Loads the global descriptor

    mov eax, cr0          ;Auxillary 
    or eax, 0x1           ;Setting the first bit to one 
    mov cr0, eax

    jmp CODE_SEG:init_protected ;Make a far jump

;We have now entered protected mode
[bits 32]
init_protected:
    mov ax, DATA_SEG        ;Since we have segmented our memory, we must provide the offsets
    mov ds, ax
    mov ss, ax
    mov es, ax 
    mov fs, ax 
    mov gs, ax 

    mov ebp, 0x90000        ;Updatin the base pointer of the stack
    mov esp, ebp

    call begin_protected          ;Defined in the main file