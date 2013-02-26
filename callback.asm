.text
.global callback

.thumb
.thumb_func
.align 2

main:
push {r0-r7, lr}
bl main_func
bl call_back3
@bl call_back_oam
@bl write_oam_something
bl sub_080704D0
pop {r0-r7, pc}

call_back3:
ldr r4, callback3_address
bx r4

call_back_oam:
ldr r4, callbackoam_address
bx r4

write_oam_something:
ldr r4, writeoamsomething_address
bx r4

sub_080704D0:
ldr r4, loc_080704D0
bx r4

main_func:
push {lr}
bl increment_timer
bl getcurrentfunc

returnmain:
ldr r1, vram
add r1, #0x4
pop {pc}

increment_timer:
ldr r0, vram
ldrh r0, [r0]
ldr r1, vram
add r0, #0x1
strh r0, [r1]
bx lr

getcurrentfunc:
ldr r1, companyname
cmp r0, r1
ble shinyquagsire

ldr r1, companyname2
cmp r0, r1
ble shinyquagsire_2

ldr r1, companyname3
cmp r0, r1
ble shinyquagsire_3

ldr r1, a_flash
cmp r0, r1
ble update_a

bgt titlescreen
bx lr

titlescreen:
bl goto_titlescreen
pop {r0-r7,pc}

goto_titlescreen:
push {lr}
ldr r0, sub_0800CC7A
bx r0

update_a:
push {lr}
ldr r0, vram
ldrb r1, [r0, #0x7]
cmp r1, #0x1
beq skipfades
add r1, #0x1
strb r1, [r0, #0x7]
bl songfade
mov r0, #0x1
mov r1, #0x4
bl fadescreen
skipfades:
bl shinyquagsire_loadgraphics

ldr r0, =quagsire_blank
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
ldr r2, =0x200
add r1, r2, r1
swi 0x12
ldr r0, vram
mov r1, #0x26
strb r1, [r0, #0x6]

b shinyquagsire_animturn2
b returnmain

fadescreen:
push {lr}
ldr r2, fade_screen
bx r2

.include "quagsireintro.asm"

.include "constants.asm"
.include "graphics.asm"
