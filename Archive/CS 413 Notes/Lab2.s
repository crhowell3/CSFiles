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

.equ READERROR, 0

.global main

main:

@********************
prompt:                     @Displays the welcome message. Contains a label so that some functions can just return to the
@********************       @point where the prompt just asks for shape selection

  LDR r0, =welcome
  BL printf
redo:
  LDR r0, =strPrompt
  BL printf

@********************
select_shape:               @This routine starts by getting a user input. The input is validated using the READERROR method,
@********************       @and if the input passes that check, then it is checked to make sure it is strictly greater than
                            @zero. If not, the routing branches to the invalid_input routine
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]

  CMP r1, #1                @The select_shape routine is structured using if statements. The user's input for the shape
  BNE endif                 @selection is matched using if statements for all 5 possible inputs. If the user's input does
then:                       @not match any of the possible values, the program branches back to the selection to try again.
  LDR r0, =triHeight        @Once a valid input is detected with the if statements, the program then takes inputs for the
  BL printf                 @selected shape's parameters. Once the parameters are validated, the program will BL to the
  LDR r0, =intInputPattern  @respective shape's subroutine for calculation, overflow check, and printing.
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r4, r1
  PUSH {r4}

  LDR r0, =triBase
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r5, r1
  PUSH {r5}
  BL triangle
endif:

  CMP r1, #2                @This if statement is for the rectangle choice. Gets width and length, verifies them, and then pushes them to the stack
  BNE endif_2               @to be accessed once this block branches with link to the rectangle subroutine
then_2:

  LDR r0, =rectLength
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r4, r1
  PUSH {r4}

  LDR r0, =rectWidth
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r5, r1
  PUSH {r5}
  BL rectangle
endif_2:

  CMP r1, #3                @This if statement is for the trapezoid. Gets all three inputs, validates, and then pushes to the stack for the
  BNE endif_3               @trapezoid subroutine to calculate the area
then_3:

  LDR r0, =trap_A
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r4, r1
  PUSH {r4}

  LDR r0, =trap_B
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r5, r1
  PUSH {r5}

  LDR r0, =trap_H
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r6, r1
  PUSH {r6}
  BL trapezoid
endif_3:

  CMP r1, #4                @This if statement is for the square. Gets only one side input, validates, and then pushes to stack. Then, BL to square subroutine
  BNE endif_4
then_4:

  LDR r0, =squareSide
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BLE invalid_input
  MOV r4, r1
  PUSH {r4}
  BL square
endif_4:

  CMP r1, #5                @For option 5, branches to the exit protocol
  BNE endif_5
then_5:
  B myexit
endif_5:

  B redo                    @If none of the if statements are satisfied, branches to the redo label to get a new, valid input for shape selection

@********************
triangle:                   @Pops the values off the stack, "divides" the base by 2, and then multiplies with overflow check the halved-base times
@********************       @the height. The CMP checks that the RdHi reg (r2) is equal to 0; if not, this means there was an overflow. The routine
                            @will branch to the overflow routine if r2 =/= 0. Otherwise, pushes the result in RdLo (r1) to the stack for the print
  POP {r10, r11}            @routine. Branches to print
  MOV r9, r11, LSR #1
  UMULL r1, r2, r10, r9
  CMP r2, #0
  BNE overflowT
  PUSH {r1}
  B print

@********************
rectangle:                  @Pops the values off the stack, multiplies with overflow check, then compares r2 to 0. If r2 =/= 0, branch to the overflow
@********************       @routine. Otherwise, push answer to stack and branch to print routine

  POP {r10, r11}
  UMULL r1, r2, r10, r11
  CMP r2, #0
  BNE overflowR
  PUSH {r1}
  B print

@********************
trapezoid:                  @Pops all three values off the stack (order matters here, so they are popped off in reverse order). Adds a and b, divides
@********************       @the result by 2, and then multiplies with overflow check by the height. Compares r2 to 0; if r2 =/= 0, branch to overflow
                            @routine. Otherwise, push answer to stack and branch to print routine
  POP {r12}
  POP {r11}
  POP {r10}
  ADD r8, r10, r11
  MOV r9, r8, LSR #1
  UMULL r1, r2, r9, r12
  CMP r2, #0
  BNE overflowTr
  PUSH {r1}
  B print

@********************
square:                     @Pops the side length off the stack, then performs a multiplication with overflow check. If r2 =/= 0, overflow method. Otherwise,
@********************       @push r1 (answer) to stack and then branch to print

  POP {r10}
  UMULL r1, r2, r10, r10
  CMP r2, #0
  BNE overflowS
  PUSH {r1}
  B print

@********************
print:                      @Loads r0 with the address of the string to print. Pops r1 from the stack (the answer from whichever calculation took place), then
@********************       @calls printf

  LDR r0, =area_print
  POP {r1}
  BL printf
retry:                      @This label is the retry label, which is if the user inputs an incorrect value for the 'Try again' prompt.
  LDR r0, =tryAgain         @Prompts user to specify whether or not they want to perform another area calculation
  BL printf
  LDR r0, =intInputPattern
  LDR r1, =intInput
  BL scanf
  LDR r1, =intInput
  LDR r1, [r1]
  CMP r1, #0
  BEQ myexit                @If response is 0 (no), branch to exit protocol
  CMP r1, #1
  BEQ redo                  @If response is 1 (yes), branch all the way back to the redo label at the very beginning
  B retry                   @Otherwise, branch to the retry label to enter a valid input

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

  B redo                    @Branch to the redo label at the very beginning of the program

@********************
overflowT:                  @NOTE: ALL THE FOLLOWING OVERFLOW FUNCTIONS DO THE SAME THING: PRINT AN ERROR MESSAGE.
@********************       @The only reason for multiple is because each one branches back to its respective shape.
                            @This is so that the user can just immediately reenter values that won't produce overflow.
  LDR r0, =overflowError
  BL printf
  B then

@********************
overflowR:                  @SEE ABOVE
@********************

  LDR r0, =overflowError
  BL printf
  B then_2

@********************
overflowTr:                 @SEE ABOVE
@********************

  LDR r0, =overflowError
  BL printf
  B then_3

@********************
overflowS:                  @SEE ABOVE
@********************

  LDR r0, =overflowError
  BL printf
  B then_4

@********************
invalid_input:              @Prints error message if parameter entered for a shape is negative or 0. Branches back to the beginning of the program
@********************

  LDR r0, =invalid
  BL printf
  B redo

@********************
myexit:                     @Makes system call, exits program, returns control to OS
@********************
  MOV r7, #0x01
  SVC 0

.data

.balign 4
welcome: .asciz "Welcome! This program performs area calculations for four different shapes:\nTriangles, Rectangles, Trapezoids, and Squares.\n"

.balign 4
strPrompt: .asciz "Please enter 1 for triangle, 2 for rectangle, 3 for trapezoid, 4 for square, or 5 to quit:\n"

.balign 4
triHeight: .asciz "Please enter a value for the height:\n"

.balign 4
triBase: .asciz "Please enter a value for the base:\n"

.balign 4
rectLength: .asciz "Please enter a value for the length:\n"

.balign 4
rectWidth: .asciz "Please enter a value for the width:\n"

.balign 4
squareSide: .asciz "Please enter a value for the side length:\n"

.balign 4
trap_A: .asciz "Please enter a value for the first base:\n"

.balign 4
trap_B: .asciz "Please enter a value for the second base:\n"

.balign 4
trap_H: .asciz "Please enter a value for the height:\n"

.balign 4
tryAgain: .asciz "Calculate another area? Yes: 1, No: 0\n"

.balign 4
area_print: .asciz "The area is %d square units.\n"

.balign 4
overflowError: .asciz "Overflow error! Try again.\n"

.balign 4
invalid: .asciz "Must enter a positive, non-zero integer! Please retry.\n"

.balign 4
intInputPattern: .asciz "%d"

.balign 4
intInput: .word 0

.balign 4
strInputPattern: .asciz "%[^\n]" @ Used to clear the input buffer for invalid input.

.balign 4
strInputError: .skip 100*4  @ User to clear the input buffer for invalid input.

.global printf
.global scanf
@End of code file
