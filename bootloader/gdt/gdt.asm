;The GDT will load define the memory segmentation and will bootstrap the kernel from the disk.
;When the CPU switches to 32 bit mode, each logical (written) address maps to physical addresses in a different way.

;Each memory segment is defined by a segment descriptor(8Bytes):
;32bits: Base address - Where the physical segment of the memory begins
;20bits: Segment Limtit - Segment size
;Flags that describe things like priviledge level

;Memory must be segmented in 32 bit mode. The simplest segmentation is called the basic flat model. 
;In this two overlapping segments are present. One contains code, and the other data. There is no protection in this model as there is memeory overlap.

;The first entry in the GDT must be a null descriptor (8, 0 bytes)

;We will define the code segment as:
;Base - 0x0
;Limit - 0xffff (4gb)
;Present - 1
;Priviledge  - 0 (highest)
;Types: Code:1 , Conforming: 0; Readable: 1 (true); Accessed: 0
;Flags: Granularity: 1, 32-bit default: 1, 62-bit segment: 0, AVL: 0
;(Conforming that the less priviledged code cannot access this code.)

;The data segment will contain the above plus:
;Code: 0
;Expand down: 0
;Writable: 1
;Accessed: 0

;We also need to provide GDT Descriptor, a 6 byte structure that contians the GDT size and address

;GDT
gdt_start:

gdt_null:   ;The null descriptor
    dd 0x0  ;dd means double word, 4 bytes
    dd 0x0

gdt_code:       ;This is simply a data structre not a command
    dw 0xffff   ;The upper limit
    dw 0x0      ;Base
    db 0x0      ;base
    db 10011010b    ;1st Flag + Type flag | (code)1(conforming)0(descriptor)1(code)1(conforming)0(readable)1(accessed)0+b
    db 11001111b    ;2nd Flag + Limit flag| (granularity)1(32 bit)1(65 bit)0(AVL)0
    db 0x0      ;Base

gdt_data:       ;Data segment of the memory. Think of this as a giant variable
    dw 0xffff   ;The upper limit
    dw 0x0      ;Base
    db 0x0      ;base
    db 10010010b    ;Type flag |Different from the above one
    db 11001111b    ;Limit flag
    db 0x0      ;Base

gdt_end:        ;We put this to calculate the size of the gdt

gdt_descriptor:
    dw  gdt_end - gdt_start - 1  ;Pointer of gdt_end - pointer of gdt_start - 1
    dd  gdt_start                ;Pointer to the gdt_start


;Defining constants. These are teh gdt segment descriptor offsests. 
;Here we are definig were the code segment and data segments start
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

;We must also stop all interrupts in the switch.

;We can switch over by changing the FIRST BIT of a register called cr0.
;cr0 cannot be accessed directly so we must use an auxillary register
;We will use an OR operation here. Consider the following:

;Auxillary: 1
;cr0      : 0 1 0 1 1 0
;-------------------------OR
;Result   : 1 1 0 1 1 0

;There is another issue we must account for: CPU pipelining (something like multithreading?)
;There is a risk of some commands occuring in 16 mode while some in 32 mode
;We can overcome this using a FAR jmp statement. When a far jmp occurs, the CPU does not pipeline.


;Far jump - Jumps between segments.
;jmp <segment>:<adress offset>

;We can jump to where we want

