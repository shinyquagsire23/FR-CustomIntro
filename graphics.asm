graphics_load:
ldr r2, offsetyouinsertedthisat
add r0, r2, r0
swi 0x12

.ltorg
quagsire_palette: 	.incbin "img_bins/quagsire_palette.bin"
quagsire_shout:		.incbin "img_bins/shout.bin"
quagsire_walk1:		.incbin "img_bins/walk1.bin"
quagsire_walk2:		.incbin "img_bins/walk2.bin"
quagsire_turn1:		.incbin "img_bins/turn1.bin"
quagsire_turn2:		.incbin "img_bins/turn2.bin"
quagsire_sparkle_pal:	.incbin "img_bins/sparkle_palette.bin"
quagsire_sparkle1:	.incbin "img_bins/sparkle1.bin"
quagsire_sparkle2:	.incbin "img_bins/sparkle2.bin"
quagsire_sparkle3:	.incbin "img_bins/sparkle3.bin"
quagsire_blank:		.incbin "img_bins/blank.bin"
quagsire_logo:		.incbin "img_bins/logo.bin"
quagsire_logo_pal:	.incbin "img_bins/logo_palette.bin"
quagsire_bg:		.incbin "img_bins/quagsirepresents.raw"
