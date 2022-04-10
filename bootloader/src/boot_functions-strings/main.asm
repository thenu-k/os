mov ah, 0x0e

;A string is declared as follows:
mystring:   
    db 'Hello World', 0     ;Ending the string with a 0 helps to find the end of the string
;If we print this string, only the first character will be printed as the pointer only points to the first
;Increase the pointer by 1 to get the next charachter


;Control structures
mov ax, '4'
cmp ax, '4'     ;if ax = 4
je ax_is_four   ;perform the ax_is_four function
jmp else        ;else, do 'else'
jmp endif       ;endif

ax_is_four:
    mov al, 'X'
    int 0x10
    jmp endif   ;Otherwise it'll move to the else statement
else:
    mov al, 'Y'
    int 0x10
    jmp endif
endif:

;Functions
mov al, 'X'
jmp do_stuff

do_stuff:
    int 0x10
    jmp end_stuff    ;we can name this anything we want
end_stuff:

;Function calls
print:
    int 0x10
    jmp end_print

mov al, "X"         ;We effectively added a parameter to the function
end_print:          ;As you can see, we can only include one end_print and thus only one instance of this function

;Call and ret.
;When you make a call, the current address is sent to the stack. When you call ret afterwards, the original position is retrieved
mov al, "H"
call better_print

mov al, "I"
call better_print

better_print:
    int 0x10
    ret

;There is an unseen problem here. To perform these functions, random registers values will be changed.
;This means that any processes that were using those registers will have their data corrupted.
;To avoid this, we can move all the data in the registers to the stack and call them back again when the function is over.
;This is done with pusha and popa
stack_push:
    pusha
    ;Do stuff
    popa
    ret


;Start inf loop

jmp $
times 510-($-$$) db 0
dw 0xaa55


;Now jmp $ can be understood
;loop:
;   jmp loop  
;This is an infinite loop that calls itself.