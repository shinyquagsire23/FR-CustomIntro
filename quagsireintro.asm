shinyquagsire:
ldr r0, vram
ldrb r0, [r0, #0x2]
cmp r0, #0x0
beq shinyquagsire_loadoam
bl shinyquagsire_loadgraphics
push {lr}
bl shinyquagsire_update
b returnmain

shinyquagsire_2:
push {lr}
bl shinyquagsire_loadgraphics
bl shinyquagsire_update2
b returnmain

shinyquagsire_3:
push {lr}
bl shinyquagsire_loadgraphics
bl shinyquagsire_animcry
b returnmain

shinyquagsire_loadgraphics:
@Modify IO registers
ldrh r0, =0x1140
ldr r1, dispcnt
strh r0, [r1]
ldrh r0, =0x0702
add r1, #0x8
strh r0, [r1]

@Load our OBJ palette(s)
ldr r0, =quagsire_palette
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
mov r2, #0x8
ldr r1, objpal
swi 0xC
ldr r0, =quagsire_sparkle_pal
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objpal
add r1, #0x20
swi 0xC

@Load our graphics
ldr r0, =quagsire_walk1
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
swi 0x12


bx lr

shinyquagsire_loadoam:
bl playsong
mov r0, #0x0
mov r1, #0x0
bl fadescreen

@Load our tilemap
ldr r0, =quagsire_logo
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, bgdata
swi 0x12

ldr r0, =quagsire_bg
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, bgtiles
swi 0x12

ldr r0, =quagsire_logo_pal
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, bgpal
add r1, #0x20
mov r2, #0x8
swi 0xC

@Load our OAM stuff
ldr r0, oam
ldrh r1, =0x2f @
strh r1, [r0]
add r0, #0x2
ldrh r1, =0x80EB @ + (240 - 32) 71 61
strh r1, [r0]	
add r0, #0x2
ldrh r1, =0x0400
strh r1, [r0]
add r0, #0x4

ldrh r1, =0x3D @
strh r1, [r0]
add r0, #0x2
ldrh r1, =0x8033 @ + (240 - 32) 71 61
strh r1, [r0]	
add r0, #0x2
ldrh r1, =0x1010
strh r1, [r0]
add r0, #0x4

@Make sure we don't waste time loading the graphics *again*.
ldr r0, vram
mov r1, #0x1
strb r1, [r0, #0x2]
b returnmain

shinyquagsire_update2:
ldr r0, vram
ldrh r0, [r0, #0x2]
ldr r1, vram
add r0, #0x1
cmp r0, #(second * 2) - (second / 2)
bge shinyquagsire_resetanimtimer
resetreturn: strh r0, [r1, #0x2]
cmp r0, #(second) - (second / 4)
bls shinyquagsire_animturn1
cmp r0, #(second) - (second / 4)
bge shinyquagsire_animturn2

shinyquagsire_resetanimtimer:
mov r0, #0x0
b resetreturn

shinyquagsire_resetanimtimer2:
mov r0, #0x0
b resetreturn2

return:
b returnmain

shinyquagsire_update:
ldr r0, vram
ldrh r0, [r0, #0x2]
ldr r1, vram
add r0, #0x1
cmp r0, #(second * 2) - (second / 2)
bge shinyquagsire_resetanimtimer2
resetreturn2: strh r0, [r1, #0x2]
cmp r0, #(second) - (second / 4)
bls shinyquagsire_firstanim
cmp r0, #(second) - (second / 4)
bge shinyquagsire_secondanim

animreturn:
ldr r0, vram
ldrb r0, [r0, #0x2]
mov r1, #0xf
and r0, r1
cmp r0, #0x0
beq shinyquagsire_movequagsire
cmp r0, #0x5
beq shinyquagsire_movequagsire
cmp r0, #0xA
beq shinyquagsire_movequagsire
movereturn:
bx lr

shinyquagsire_movequagsire:
ldr r0, oam
ldrb r1, [r0, #0x2]
sub r1, #0x2
@cmp r1, #0x67
@ble movereturn
strb r1, [r0, #0x2]
b movereturn

shinyquagsire_movequagsire2:
ldr r0, oam
ldrb r1, [r0, #0x2]
sub r1, #0x2
strb r1, [r0, #0x2]
ldrb r1, [r0]
add r1, #0x2
strb r1, [r0]
b movereturn

shinyquagsire_firstanim:
ldr r0, =quagsire_walk1
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
swi 0x12
b animreturn

shinyquagsire_secondanim:
ldr r0, =quagsire_walk2
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
swi 0x12
b animreturn

shinyquagsire_animturn1:
ldr r0, =quagsire_turn1
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
swi 0x12

ldr r0, vram
ldrb r0, [r0, #0x2]
mov r1, #0xf
and r0, r1
cmp r0, #0x0
beq shinyquagsire_movequagsire2
cmp r0, #0x5
beq shinyquagsire_movequagsire2
cmp r0, #0xA
beq shinyquagsire_movequagsire2
b returnmain

shinyquagsire_animturn2:
ldr r0, =quagsire_turn2
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
swi 0x12
b return

shinyquagsire_animcry:
ldr r0, =quagsire_shout
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
swi 0x12

ldr r0, vram
ldrb r1, [r0, #0x5]
cmp r1, #0x1
bgt skipcry
bl playcry
skipcry:
ldr r0, vram
ldrb r1, [r0, #0x5]
cmp r1, #0xFF
beq skipcry2
add r1, #0x1
strb r1, [r0, #0x5]

ldr r0, vram
ldrb r1, [r0, #0x5]
cmp r1, #0x30
bls closemouth
cmp r1, #0xFF
beq skipcry2
bl sparkle
skipcry2:
mov r1, #0xFF
ldr r0, vram
strb r1, [r0, #0x5]
b closemouth

closemouth:
cmp r1, #0x20
bls return
ldrb r1, [r0, #0x6]
cmp r1, #0x3
beq sparkle2
cmp r1, #0xe
beq sparkle1
cmp r1, #0x16
beq sparkle2
cmp r1, #0x1e
beq sparkle3
cmp r1, #0x26
beq wipesparkle
cmp r1, #0x26
bgt wipesparklecont

returnsparkle:
ldr r0, vram
ldrb r1, [r0, #0x6]
add r1, #0x1
strb r1, [r0, #0x6]
ldr r0, =quagsire_turn2
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
swi 0x12
b return

sparkle1:
ldr r0, =quagsire_sparkle1
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
ldr r2, =0x200
add r1, r2, r1
swi 0x12
b returnsparkle

sparkle2:
ldr r0, =quagsire_sparkle2
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
ldr r2, =0x200
add r1, r2, r1
swi 0x12
b returnsparkle

sparkle3:
ldr r0, =quagsire_sparkle3
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
ldr r2, =0x200
add r1, r2, r1
swi 0x12
b returnsparkle

wipesparkle:
bl somefunction
wipesparklecont:
ldr r0, =quagsire_blank
ldr r1, offsetyouinsertedthisat
add r0, r1, r0
ldr r1, objdata
ldr r2, =0x200
add r1, r2, r1
swi 0x12
ldr r0, vram
mov r1, #0x27
strb r1, [r0, #0x6]
b returnsparkle

playsong:
push {lr}
ldr r3, play_song
ldr r0, =315
bx r3

playcry:
push {lr}
ldr r3, play_cry
mov r0, #195 @Quagsire's cry
mov r1, #0x0
bx r3

sparkle:
push {lr}
ldr r1, play_sound
mov r0, #0x5F @Shiny Sparkle thingy sound
bx r1

songfade:
push {lr}
ldr r3, fade_song
mov r0, #0x4
bx r3

