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
prompt:                     @Displays the welcome message.
@********************

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

reenter:
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
  CMP r2, #'G'
  BNE p
  LDREQ r3, =numGum
  LDREQ r3, [r3]
  CMPEQ r3, #0
  LDRGE r1, =gum
  LDRGT r6, =gum
  MOVGT r5, #50
  BGT ver
  LDREQ r0, =outOfStock
  BLEQ printf
  B reenter

p:
  CMP r2, #'P'
  BNE c
  LDREQ r3, =numPeanuts
  LDREQ r3, [r3]
  CMPEQ r3, #0
  LDRGE r1, =peanuts
  LDRGT r6, =peanuts
  MOVGT r5, #55
  BGT ver
  LDREQ r0, =outOfStock
  BLEQ printf
  B reenter

c:
  CMP r2, #'C'
  BNE m
  LDREQ r3, =numCrackers
  LDREQ r3, [r3]
  CMPEQ r3, #0
  LDRGE r1, =cracker
  LDRGT r6, =cracker
  MOVGT r5, #65
  BGT ver
  LDREQ r0, =outOfStock
  BLEQ printf
  B reenter

m:
  CMP r2, #'M'
  BNE a
  LDREQ r3, =numMMs
  LDREQ r3, [r3]
  CMPEQ r3, #0
  LDRGE r1, =mandms
  LDRGT r6, =mandms
  MOVGT r5, #100
  BGT ver
  LDREQ r0, =outOfStock
  BLEQ printf
  B reenter

a:
  CMP r2, #'A'
  BEQ secret

  LDR r0, =invalidChoice
  BL printf
  B  reenter

ver:
  LDR r0, =verifyInput
  BL printf

  LDR r0, =charInputPattern
  LDR r1, =correctInput
  BL scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =correctInput
  LDRB r1, [r1]

  CMP r1, #'Y'
  BEQ get_payment
  CMP r1, #'N'
  BEQ get_input

@********************
get_payment:
@********************
  MOV r7, #0
  CMP r5, #100
  LDREQ r0, =enterAmountDollar
  LDRLT r0, =enterAmount
  MOVLT r1, r5
  BL printf

  LDR r0, =moneyType
  BL printf
  B  cont

payloop:
  LDR r0, =notEnoughEntered
  BL printf

cont:
  LDR r0, =charInputPattern
  LDR r1, =moneyInput
  BL  scanf
  CMP r0, #READERROR
  BEQ readerror
  LDR r1, =moneyInput
  LDRB r1, [r1]

dime:
  CMP r1, #'D'
  BNE quarter
  ADDEQ r7, r7, #10
  CMPEQ r5, r7
  BLE change_dispense
  BGT payloop

quarter:
  CMP r1, #'Q'
  BNE dollarbill
  ADDEQ r7, r7, #25
  CMPEQ r5, r7
  BLE change_dispense
  BGT payloop

dollarbill:
  CMP r1, #'B'
  ADDEQ r7, r7, #100
  CMPEQ r5, r7
  BLE change_dispense
  BGT payloop

@********************
change_dispense:
@********************
  LDR r0, =enoughEntered
  BL printf

  LDR r0, =dispensed
  MOV r1, r6
  BL printf

  LDR r2, =gum
  CMP r6, r2
  LDREQ r1, =numGum
  LDREQ r1, [r1]
  SUBEQ r3, r1, #1
  LDREQ r1, =numGum
  STREQ r3, [r1, #0]

  LDR r2, =cracker
  CMP r6, r2
  LDREQ r1, =numCrackers
  LDREQ r1, [r1]
  SUBEQ r3, r1, #1
  LDREQ r1, =numCrackers
  STREQ r3, [r1, #0]

  LDR r2, =peanuts
  CMP r6, r2
  LDREQ r1, =numPeanuts
  LDREQ r1, [r1]
  SUBEQ r3, r1, #1
  LDREQ r1, =numPeanuts
  STREQ r3, [r1, #0]

  LDR r2, =mandms
  CMP r6, r2
  LDREQ r1, =numMMs
  LDREQ r1, [r1]
  SUBEQ r3, r1, #1
  LDREQ r1, =numMMs
  STREQ r3, [r1, #0]

  SUB r1, r7, r5
  LDR r0, =changeReturn
  BL printf

@********************
check_if_continue:
@********************
  LDR r0, =numGum
  LDR r0, [r0]
  LDR r1, =numMMs
  LDR r1, [r1]
  LDR r2, =numPeanuts
  LDR r2, [r2]
  LDR r3, =numCrackers
  LDR r3, [r3]

  ADD r4, r1, r0
  ADD r4, r4, r2
  ADDS r4, r4, r3
  CMP r4, #0
  BGT get_input
  LDREQ r0, =emptyMachine
  BL printf
  B myexit

@********************
secret:
@********************
  LDR r0, =mmStock
  LDR r1, =numMMs
  LDR r1, [r1]
  BL printf

  LDR r0, =cStock
  LDR r1, =numCrackers
  LDR r1, [r1]
  BL printf

  LDR r0, =pStock
  LDR r1, =numPeanuts
  LDR r1, [r1]
  BL printf

  LDR r0, =gStock
  LDR r1, =numGum
  LDR r1, [r1]
  BL printf
  B get_input

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
invalidChoice: .asciz "Invalid option. Enter a proper option:\n"

.balign 4
verifyInput: .asciz "You selected %s. Is this correct? (Y/N): \n"

@********************
@Input Money Prompts
@********************
.balign 4
enterAmount: .asciz "Enter at least %d cents for selection.\n"

.balign 4
enterAmountDollar: .asciz "Enter a dollar for this selection.\n"

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
@Secret Menu Messages
@********************
.balign 4
mmStock: .asciz "M&Ms - %d\n"

.balign 4
cStock: .asciz "Cheese Crackers - %d\n"

.balign 4
pStock: .asciz "Peanuts - %d\n"

.balign 4
gStock: .asciz "Gum - %d\n"

@********************
@All Variables and Input Formats
@********************
.balign 4
strInputPattern: .asciz "%[^\n]" @ Used to clear the input buffer for invalid input.

.balign 4
strInputError: .skip 100*4  @ User to clear the input buffer for invalid input.

.balign 4
charInputPattern: .asciz "%s"

.balign 4
charInput: .byte 0

.balign 4
correctInput: .byte 0

.balign 4
moneyInput: .byte 0

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
