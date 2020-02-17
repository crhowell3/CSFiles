@ Filename: Lab3.s
@ Author:   Cameron Howell
@ Email:    crh0043@uah.edu
@ Class:    CS413-02 Spring 2020
@ Purpose:  Calculates the area of various shapes based on user choice and parameters
@ History:
@    Date       Purpose of change
@    ----       -----------------
@   16-Feb-2020  Created the file
@   18-Feb-2020  Finalized code
@
@ Use these command to assemble, link, run and debug this program:
@    as -o Lab3.o Lab3.s
@    gcc -o Lab3 Lab3.o
@    ./Lab3 ;echo $?
@    gdb --args ./Lab3

.equ READERROR, 0

.global main

main:

@********************
readerror:
@********************
@ Got a read error from the scanf routine. Clear out the input buffer and ask
@ for the user to enter a value.
@ An invalid entry was made we now have to clear out the input buffer by
@ reading with this format %[^\n] which will read the buffer until the user
@ presses the CR.

  LDR r0, =strInputPattern
  LDR r1, =strInputError   @ Put address into r1 for read.
  BL scanf                 @ scan the keyboard.
@ Not going to do anything with the input. This just cleans up the input buffer.
@ The input buffer should now be clear so get another input.

  B @main                    @Branch to the redo label at the very beginning of the program

@********************
myexit:                     @Makes system call, exits program, returns control to OS
@********************
  MOV r7, #0x01
  SVC 0

.data

.global printf
.global scanf
@End of code file
