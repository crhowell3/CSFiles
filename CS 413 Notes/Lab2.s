@ Filename: Lab2.s
@ Author:   Cameron Howell
@ Email:    crh0043@uah.edu
@ Class:    CS413-02 Spring 2020
@ Purpose:  Calculates the area of various shapes based on user choice and parameters
@ History:
@    Date       Purpose of change
@    ----       -----------------
@   5-Feb-2020  Created the file
@   6-Feb-2020  Finalized code
@
@ Use these command to assemble, link, run and debug this program:
@    as -o Lab2.o Lab2.s
@    gcc -o Lab2 Lab2.o
@    ./Lab2 ;echo $?
@    gdb --args ./Lab2

.global main

main:

@********************
prompt:
@********************

  LDR r0, =welcome
  BL printf
  LDR r0 =strPrompt
  BL printf

@********************
select_shape:
@********************
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf


@********************
myexit:
@********************
  MOV r7, #0x01
  SVC 0

.data

.balign 4
welcome: .asciz "Welcome! This program performs area calculations for four different shapes:\nTriangles, Rectangles, Trapezoids, and Squares.\n"

.balign 4
strPrompt: .asciz "Please enter 1 for triangle, 2 for rectangle, 3 for trapezoid, 4 for square, or 5 to quit:\n"

.balign 4
intInputPattern: .asciz "%d"

.balign 4
intInput: .word 0

.global printf
.global scanf
@End of code file
