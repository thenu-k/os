;Dealing with strings
;An entire string cannot be stored within a register. What we do is we store the address of the first charachter of the string in a regitser. This is a pointer.
;To get the next charachter, we increment the register address by one.

[org 0x7c00]
mov ah, 0x0e

mov bx, hello_message
call print_string

mov bx, goodbye_message
call print_string

hello_message:
    db 'Hello', 0
goodbye_message:
    db 'Adios', 0

;Function
print_string:       ;This loop ends when the function finds a 0 in the string
    pusha
    ;We need to create a loop that will print all the charachters
    start:
        mov al, [bx]        ;Contents of bx
        cmp al, 0
        je end_loop
        ;else
        int 0x10
        ;Increasing the pointer by 1
        add bx, 1
        jmp start

        end_loop:
            popa
            ret



jmp $
times 510-($-$$) db 0
dw 0xaa55
