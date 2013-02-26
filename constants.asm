.equ second, 0x35
.equ quagsire, 195

.align 2
offsetyouinsertedthisat:	.word 0x08790000
callback3_address:		.word 0x08077578+1
callbackoam_address:		.word 0x08006B5C+1
writeoamsomething_address:	.word 0x08006BA8+1
loc_080704D0:			.word 0x080704D0+1
sub_0800CC7A:			.word 0x0800CC7A+1
sub_0807A880:			.word 0x0807A880+1
play_cry:			.word 0x08071dF0+1
play_sound:			.word 0x080722CC+1
play_song:			.word 0x081DD0F4+1
fade_song:			.word 0x0806b154+1
fade_screen:			.word 0x0807A818+1

bgpal:				.word 0x020371F8 		@Fire Red palette buffer 020375F8
bgdata:				.word 0x06000000
bgtiles:			.word 0x06003800
vram:				.word 0x020370B8 		@Variable RAM
objpal:				.word 0x020371F8 + (0x200) 	@Fire Red palette buffer
objdata:			.word 0x06010000		@OBJ tile data
oam:				.word 0x03003128		@Fire Red OAM buffer
dispcnt:			.word 0x04000000

companyname:			.word (second * 4) + (second / 4) + (second / 16)
companyname2:			.word (second * 5) + (second / 4) + (second / 16)
companyname3:			.word (second * 6) + (second / 2)
a_flash:			.word (second * 6) + (second / 2) + (second * 2) 
grass_pan:			.word (second * 6) + (second * 2) + (second * 2)
two_unknowns:			.word (second * 6) + (second * 2) + (second * 2) + (second * 3)
