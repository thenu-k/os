To run a asm file, first compile it to binary using:
nasm -f <file_name>.asm -o <file_name>.bin

To run this on qemu:
qemu-system-x86_64 <file_name>.bin


Important!     

-mov al, [bx]  //This means that the contents of the ADDRESS LOCATED INSIDE BX will be loaded into al. 
                For an example, if bx = 0x8000, the contents of 0x8000 will be loaded into al.
                This is effectively a pointer.

-Strings are not stored inside registers. They are too large. 
 Suppose we initialize a string
 data: db, "Hello", 0
 'data' is the pointer for the fist charachter in the string of hello.
 So if we load data to a register: mov bx, data : we store the ADDRESS OF "H" in bx. 
 We can load the actual charachter to a different register.

-Video memory in VGA starts at 0xb8000!
