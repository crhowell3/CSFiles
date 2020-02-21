@ Filename: Lab3.s
@ Author:   Cameron Howell
@ Email:    crh0043@uah.edu
@ Class:    CS413-02 Spring 2020
@ Purpose:  Simulates a basic vending machine
@ History:
@    Date       Purpose of change
@    ----       -----------------
@   16-Feb-2020  Created the file
@   20-Feb-2020  Finalized code
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
prompt:                     @Displays the welcome message. Contains a label so that some functions can just return to the
@********************       @point where the prompt just asks for shape selection

  LDR r0, =welcome
  BL printf

cost:
  LDR r0, =prices
  BL printf

@********************
get_input:
@********************
  LDR r0, =selectionPrompt
  BL printf

  LDR r0, =charInputPattern
  LDR r1, =charInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r2, =charInput
  LDRB r2, [r2]

@********************
verify_selection:
@********************
  CMP r2, 'G'
  LDREQ r1, =gum
  CMP r2, 'P'
  LDREQ r1, =peanuts
  CMP r2, 'C'
  LDREQ r1, =cracker
  CMP r2, 'M'
  LDREQ r1, =mandms
  CMP r2, 'A'
  BEQ secret

  LDR r0, =verifyInput
  BL printf
  LDR r0, =charInputPattern
  LDR r1, =correctInput
  BL scanf
  LDR r1, =correctInput
  LDRB r1, [r1]

  CMP r1, 'Y'
  BEQ get_payment
  CMP r1, 'N'
  BEQ get_input

@********************
get_payment:
@********************

B myexit
@********************
secret:
@********************
B myexit
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

  B cost                   @Branch to the redo label at the very beginning of the program

@********************
myexit:                     @Makes system call, exits program, returns control to OS
@********************
  MOV r7, #0x01
  SVC 0

.data
@********************
@Introduction Prompts
@********************
.balign 4
welcome: .asciz "Welcome to Mr. Zippy's Vending Machine!\n"

.balign 4
prices: .asciz "Items: Gum ($0.50), Peanuts ($0.55), Cheese Crackers ($0.65), M&Ms ($1.00)\n"

.balign 4
selectionPrompt: .asciz "Enter item selection: Gum (G), Peanuts (P), Cheese Crackers (C), or M&Ms (M)\n"

@********************
@Selection Verification Prompt
@********************
.balign 4
verifyInput: .asciz "You selected %s. Is this correct? (Y/N):\n"

@********************
@Input Money Prompts
@********************
.balign 4
enterAmount: .asciz "Enter at least %d cents for selection.\n"

.balign 4
moneyType: .asciz "Dimes (D), Quarters (Q), and Dollar Bills (B):\n"

@********************
@Money Input Verification
@********************
.balign 4
enoughEntered: .asciz "Enough money entered.\n"

.balign 4
notEnoughEntered: .asciz "Not enough money! Enter more:\n"

@********************
@Dispensation Messages
@********************
.balign 4
dispensed: .asciz "%s dispensed.\n"

.balign 4
changeReturn: .asciz "Change of %d cents has been returned.\n"

@********************
@Empty Inventory Messages
@********************
.balign 4
outOfStock: .asciz "Sorry, but this machine is out of %s. Please make another selection.\n"

.balign 4
emptyMachine: .asciz "Mr. Zippy's Vending Machine is out of items! Goodbye!\n"

@********************
@All Variables and Input Formats
@********************
.balign 4
strInputPattern: .asciz "%[^\n]" @ Used to clear the input buffer for invalid input.

.balign 4
strInputError: .skip 100*4  @ User to clear the input buffer for invalid input.

.balign 4
charInputPattern: .asciz "%c"

.balign 4
charInput: .byte ""

.balign 4
correctInput: .byte ""

.balign 4
moneyInput: .byte ""

.balign 4
itemSelected: .asciz ""

.balign 4
numGum: .word 2

.balign 4
numPeanuts: .word 2

.balign 4
numCrackers: .word 2

.balign 4
numMMs: .word 2

.balign 4
secretCodePattern: .asciz "%d"

.balign 4
secretCode: .byte 'A'

.balign 4
cracker: .asciz "Cheese Crackers"

.balign 4
gum: .asciz "Gum"

.balign 4
peanuts: .asciz "Peanuts"

.balign 4
mandms: .asciz "M&Ms"
@********************
@printf and scanf declarations
@********************
.global printf
.global scanf
@End of code file
