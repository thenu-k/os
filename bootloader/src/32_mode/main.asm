;We can enter 32 bit mode by using [32 bits].
;With 32 bit mode, we do not have access to the bios and thus cannot print out
;characters the same way. We must access the memory directly;
;The following code will not run because we did not set up the GDT get.

;Once we enter 32 bit mode, we have to reference the 32 bit registers with an 'e' prefix.
;We will aslo be provided with two extra general purpose registers called fs and gs.

;The VGA has two modes, text and graphics. With text mode,we can supply two bytes per charachter to display it on the screen.
;The video memory address starts at 0xb8000.
;To calculate the memory point we need to access: 0xb8000 + 2*(row*80 +col)

;When we add a charachter to the memory, we dont' need an interrupt.

[bits 32]
;Defining constants
video_memory equ 0xb8000
white_on_black equ 0x0f ;color of the charachter

;mov ebx, data                   ;We initialize the pointer of data into ebx
mov ebx, data
print_string:   
    pusha
    mov edx, video_memory

print_string_loop:
    mov al, [ebx]               ;We store our string inside ebx
    mov ah, white_on_black      ;storing background color

    cmp al, 0       ;Final charachter must be 0 in a string
    je done

    mov [edx], ax   ;Remember, ax= al+ah so this stores the charachter and its attributes

    ;Important!! Consider mov edx, ax. This means we move the contents of the register ax to the register edx.
    ;mov [edx], ax means copy the contents of register ax to the ADDRESS LOCATED INSIDE edx. It is a pointer!

    add ebx, 1      ;We do NOT store our string in ebx, but the address of the memory where the first charachter is stored.
    add edx, 2      ;Move to the next charachter cell on the screen

    jmp print_string_loop

done:
    popa
    ret


data:
    db "Hello", 0
