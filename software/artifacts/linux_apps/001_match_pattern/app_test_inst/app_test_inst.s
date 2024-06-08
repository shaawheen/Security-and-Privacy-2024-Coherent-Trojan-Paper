
app_test_inst:     file format elf64-littleaarch64


Disassembly of section .interp:

0000000000000238 <.interp>:
 238:	62696c2f 	.inst	0x62696c2f ; undefined
 23c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
 240:	756e696c 	.inst	0x756e696c ; undefined
 244:	61612d78 	.inst	0x61612d78 ; undefined
 248:	36686372 	tbz	w18, #13, eb4 <__FRAME_END__+0x54>
 24c:	6f732e34 	.inst	0x6f732e34 ; undefined
 250:	Address 0x0000000000000250 is out of bounds.


Disassembly of section .note.ABI-tag:

0000000000000254 <__abi_tag>:
 254:	00000004 	udf	#4
 258:	00000010 	udf	#16
 25c:	00000001 	udf	#1
 260:	00554e47 	.inst	0x00554e47 ; undefined
 264:	00000000 	udf	#0
 268:	00000006 	udf	#6
	...

Disassembly of section .hash:

0000000000000278 <.hash>:
 278:	00000003 	udf	#3
 27c:	00000011 	udf	#17
 280:	0000000a 	udf	#10
 284:	0000000f 	udf	#15
 288:	00000010 	udf	#16
	...
 2a0:	00000003 	udf	#3
 2a4:	00000000 	udf	#0
 2a8:	00000006 	udf	#6
 2ac:	00000004 	udf	#4
 2b0:	00000008 	udf	#8
 2b4:	00000009 	udf	#9
 2b8:	00000005 	udf	#5
 2bc:	00000007 	udf	#7
 2c0:	0000000b 	udf	#11
 2c4:	0000000c 	udf	#12
 2c8:	0000000d 	udf	#13
 2cc:	0000000e 	udf	#14

Disassembly of section .gnu.hash:

00000000000002d0 <.gnu.hash>:
 2d0:	00000001 	udf	#1
 2d4:	00000001 	udf	#1
 2d8:	00000001 	udf	#1
	...

Disassembly of section .dynsym:

00000000000002f0 <.dynsym>:
	...
 30c:	000b0003 	.inst	0x000b0003 ; undefined
 310:	000007c8 	udf	#1992
	...
 324:	00160003 	.inst	0x00160003 ; undefined
 328:	00003000 	udf	#12288
	...
 338:	00000023 	udf	#35
 33c:	00000012 	udf	#18
	...
 350:	00000006 	udf	#6
 354:	00000012 	udf	#18
	...
 368:	000000a5 	udf	#165
 36c:	00000020 	udf	#32
	...
 380:	0000003b 	udf	#59
 384:	00000022 	udf	#34
	...
 398:	0000001e 	udf	#30
 39c:	00000012 	udf	#18
	...
 3b0:	0000000d 	udf	#13
 3b4:	00000012 	udf	#18
	...
 3c8:	0000004a 	udf	#74
 3cc:	00000012 	udf	#18
	...
 3e0:	000000c1 	udf	#193
 3e4:	00000020 	udf	#32
	...
 3f8:	0000005d 	udf	#93
 3fc:	00000011 	udf	#17
	...
 410:	00000057 	udf	#87
 414:	00000012 	udf	#18
	...
 428:	00000001 	udf	#1
 42c:	00000012 	udf	#18
	...
 440:	00000035 	udf	#53
 444:	00000012 	udf	#18
	...
 458:	000000d0 	udf	#208
 45c:	00000020 	udf	#32
	...
 470:	00000050 	udf	#80
 474:	00000012 	udf	#18
	...

Disassembly of section .dynstr:

0000000000000488 <.dynstr>:
 488:	74757000 	.inst	0x74757000 ; undefined
 48c:	65700073 	fmla	z19.h, p0/m, z3.h, z16.h
 490:	726f7272 	.inst	0x726f7272 ; undefined
 494:	735f5f00 	.inst	0x735f5f00 ; undefined
 498:	6b636174 	.inst	0x6b636174 ; undefined
 49c:	6b68635f 	.inst	0x6b68635f ; undefined
 4a0:	6961665f 	ldpsw	xzr, x25, [x18, #-248]
 4a4:	706f006c 	adr	x12, de4b3 <__bss_end__+0xdb49b>
 4a8:	5f006e65 	.inst	0x5f006e65 ; undefined
 4ac:	62696c5f 	.inst	0x62696c5f ; undefined
 4b0:	74735f63 	.inst	0x74735f63 ; undefined
 4b4:	5f747261 	sqdmlsl	s1, h19, v4.h[3]
 4b8:	6e69616d 	rsubhn2	v13.8h, v11.4s, v9.4s
 4bc:	65727000 	fnmls	z0.h, p4/m, z0.h, z18.h
 4c0:	5f006461 	.inst	0x5f006461 ; undefined
 4c4:	6178635f 	.inst	0x6178635f ; undefined
 4c8:	6e69665f 	umax	v31.8h, v18.8h, v9.8h
 4cc:	7a696c61 	.inst	0x7a696c61 ; undefined
 4d0:	6c630065 	ldnp	d5, d0, [x3, #-464]
 4d4:	0065736f 	.inst	0x0065736f ; undefined
 4d8:	6e697270 	uabdl2	v16.4s, v19.8h, v9.8h
 4dc:	61006674 	.inst	0x61006674 ; undefined
 4e0:	74726f62 	.inst	0x74726f62 ; undefined
 4e4:	735f5f00 	.inst	0x735f5f00 ; undefined
 4e8:	6b636174 	.inst	0x6b636174 ; undefined
 4ec:	6b68635f 	.inst	0x6b68635f ; undefined
 4f0:	6175675f 	.inst	0x6175675f ; undefined
 4f4:	6c006472 	stnp	d18, d25, [x3]
 4f8:	2e636269 	rsubhn	v9.4h, v19.4s, v3.4s
 4fc:	362e6f73 	tbz	w19, #5, ffffffffffffd2e8 <__bss_end__+0xffffffffffffa2d0>
 500:	2d646c00 	ldp	s0, s27, [x0, #-224]
 504:	756e696c 	.inst	0x756e696c ; undefined
 508:	61612d78 	.inst	0x61612d78 ; undefined
 50c:	36686372 	tbz	w18, #13, 1178 <__FRAME_END__+0x318>
 510:	6f732e34 	.inst	0x6f732e34 ; undefined
 514:	4700312e 	.inst	0x4700312e ; undefined
 518:	4342494c 	.inst	0x4342494c ; undefined
 51c:	312e325f 	cmn	w18, #0xb8c
 520:	4c470037 	.inst	0x4c470037 ; undefined
 524:	5f434249 	.inst	0x5f434249 ; undefined
 528:	34332e32 	cbz	w18, 66aec <__bss_end__+0x63ad4>
 52c:	54495f00 	b.eq	9310c <__bss_end__+0x900f4>  // b.none
 530:	65645f4d 	fnmla	z13.h, p7/m, z26.h, z4.h
 534:	69676572 	ldpsw	x18, x25, [x11, #-200]
 538:	72657473 	.inst	0x72657473 ; undefined
 53c:	6c434d54 	ldnp	d20, d19, [x10, #48]
 540:	54656e6f 	b.nv	cb30c <__bss_end__+0xc82f4>
 544:	656c6261 	fnmls	z1.h, p0/m, z19.h, z12.h
 548:	675f5f00 	.inst	0x675f5f00 ; undefined
 54c:	5f6e6f6d 	.inst	0x5f6e6f6d ; undefined
 550:	72617473 	.inst	0x72617473 ; undefined
 554:	005f5f74 	.inst	0x005f5f74 ; undefined
 558:	4d54495f 	.inst	0x4d54495f ; undefined
 55c:	6765725f 	.inst	0x6765725f ; undefined
 560:	65747369 	fnmls	z9.h, p4/m, z27.h, z20.h
 564:	434d5472 	.inst	0x434d5472 ; undefined
 568:	656e6f6c 	fnmls	z12.h, p3/m, z27.h, z14.h
 56c:	6c626154 	ldnp	d20, d24, [x10, #-480]
 570:	Address 0x0000000000000570 is out of bounds.


Disassembly of section .gnu.version:

0000000000000572 <.gnu.version>:
 572:	00000000 	udf	#0
 576:	00020000 	.inst	0x00020000 ; undefined
 57a:	00010003 	.inst	0x00010003 ; undefined
 57e:	00030003 	.inst	0x00030003 ; undefined
 582:	00030003 	.inst	0x00030003 ; undefined
 586:	00040001 	.inst	0x00040001 ; undefined
 58a:	00030003 	.inst	0x00030003 ; undefined
 58e:	00010003 	.inst	0x00010003 ; undefined
 592:	Address 0x0000000000000592 is out of bounds.


Disassembly of section .gnu.version_r:

0000000000000598 <.gnu.version_r>:
 598:	00010001 	.inst	0x00010001 ; undefined
 59c:	00000079 	udf	#121
 5a0:	00000010 	udf	#16
 5a4:	00000020 	udf	#32
 5a8:	06969197 	.inst	0x06969197 ; undefined
 5ac:	00040000 	.inst	0x00040000 ; undefined
 5b0:	0000008f 	udf	#143
 5b4:	00000000 	udf	#0
 5b8:	00020001 	.inst	0x00020001 ; undefined
 5bc:	0000006f 	udf	#111
 5c0:	00000010 	udf	#16
 5c4:	00000000 	udf	#0
 5c8:	06969197 	.inst	0x06969197 ; undefined
 5cc:	00030000 	.inst	0x00030000 ; undefined
 5d0:	0000008f 	udf	#143
 5d4:	00000010 	udf	#16
 5d8:	069691b4 	.inst	0x069691b4 ; undefined
 5dc:	00020000 	.inst	0x00020000 ; undefined
 5e0:	0000009a 	udf	#154
 5e4:	00000000 	udf	#0

Disassembly of section .rela.dyn:

00000000000005e8 <.rela.dyn>:
 5e8:	00002d38 	udf	#11576
 5ec:	00000000 	udf	#0
 5f0:	00000403 	udf	#1027
 5f4:	00000000 	udf	#0
 5f8:	000009bc 	udf	#2492
 5fc:	00000000 	udf	#0
 600:	00002d40 	udf	#11584
 604:	00000000 	udf	#0
 608:	00000403 	udf	#1027
 60c:	00000000 	udf	#0
 610:	00000974 	udf	#2420
 614:	00000000 	udf	#0
 618:	00002ff0 	udf	#12272
 61c:	00000000 	udf	#0
 620:	00000403 	udf	#1027
 624:	00000000 	udf	#0
 628:	00000af8 	udf	#2808
 62c:	00000000 	udf	#0
 630:	00003008 	udf	#12296
 634:	00000000 	udf	#0
 638:	00000403 	udf	#1027
 63c:	00000000 	udf	#0
 640:	00003008 	udf	#12296
 644:	00000000 	udf	#0
 648:	00002fd0 	udf	#12240
 64c:	00000000 	udf	#0
 650:	00000401 	udf	#1025
 654:	00000005 	udf	#5
	...
 660:	00002fd8 	udf	#12248
 664:	00000000 	udf	#0
 668:	00000401 	udf	#1025
 66c:	00000006 	udf	#6
	...
 678:	00002fe0 	udf	#12256
 67c:	00000000 	udf	#0
 680:	00000401 	udf	#1025
 684:	0000000a 	udf	#10
	...
 690:	00002fe8 	udf	#12264
 694:	00000000 	udf	#0
 698:	00000401 	udf	#1025
 69c:	0000000b 	udf	#11
	...
 6a8:	00002ff8 	udf	#12280
 6ac:	00000000 	udf	#0
 6b0:	00000401 	udf	#1025
 6b4:	0000000f 	udf	#15
	...

Disassembly of section .rela.plt:

00000000000006c0 <.rela.plt>:
 6c0:	00002f70 	udf	#12144
 6c4:	00000000 	udf	#0
 6c8:	00000402 	udf	#1026
 6cc:	00000003 	udf	#3
	...
 6d8:	00002f78 	udf	#12152
 6dc:	00000000 	udf	#0
 6e0:	00000402 	udf	#1026
 6e4:	00000004 	udf	#4
	...
 6f0:	00002f80 	udf	#12160
 6f4:	00000000 	udf	#0
 6f8:	00000402 	udf	#1026
 6fc:	00000006 	udf	#6
	...
 708:	00002f88 	udf	#12168
 70c:	00000000 	udf	#0
 710:	00000402 	udf	#1026
 714:	00000007 	udf	#7
	...
 720:	00002f90 	udf	#12176
 724:	00000000 	udf	#0
 728:	00000402 	udf	#1026
 72c:	00000008 	udf	#8
	...
 738:	00002f98 	udf	#12184
 73c:	00000000 	udf	#0
 740:	00000402 	udf	#1026
 744:	00000009 	udf	#9
	...
 750:	00002fa0 	udf	#12192
 754:	00000000 	udf	#0
 758:	00000402 	udf	#1026
 75c:	0000000a 	udf	#10
	...
 768:	00002fa8 	udf	#12200
 76c:	00000000 	udf	#0
 770:	00000402 	udf	#1026
 774:	0000000c 	udf	#12
	...
 780:	00002fb0 	udf	#12208
 784:	00000000 	udf	#0
 788:	00000402 	udf	#1026
 78c:	0000000d 	udf	#13
	...
 798:	00002fb8 	udf	#12216
 79c:	00000000 	udf	#0
 7a0:	00000402 	udf	#1026
 7a4:	0000000e 	udf	#14
	...
 7b0:	00002fc0 	udf	#12224
 7b4:	00000000 	udf	#0
 7b8:	00000402 	udf	#1026
 7bc:	00000010 	udf	#16
	...

Disassembly of section .init:

00000000000007c8 <_init>:
_init():
 7c8:	d503201f 	nop
 7cc:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
 7d0:	910003fd 	mov	x29, sp
 7d4:	94000048 	bl	8f4 <call_weak_fn>
 7d8:	a8c17bfd 	ldp	x29, x30, [sp], #16
 7dc:	d65f03c0 	ret

Disassembly of section .plt:

00000000000007e0 <.plt>:
 7e0:	a9bf7bf0 	stp	x16, x30, [sp, #-16]!
 7e4:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 7e8:	f947b611 	ldr	x17, [x16, #3944]
 7ec:	913da210 	add	x16, x16, #0xf68
 7f0:	d61f0220 	br	x17
 7f4:	d503201f 	nop
 7f8:	d503201f 	nop
 7fc:	d503201f 	nop

0000000000000800 <__libc_start_main@plt>:
 800:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 804:	f947ba11 	ldr	x17, [x16, #3952]
 808:	913dc210 	add	x16, x16, #0xf70
 80c:	d61f0220 	br	x17

0000000000000810 <perror@plt>:
 810:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 814:	f947be11 	ldr	x17, [x16, #3960]
 818:	913de210 	add	x16, x16, #0xf78
 81c:	d61f0220 	br	x17

0000000000000820 <__cxa_finalize@plt>:
 820:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 824:	f947c211 	ldr	x17, [x16, #3968]
 828:	913e0210 	add	x16, x16, #0xf80
 82c:	d61f0220 	br	x17

0000000000000830 <open@plt>:
 830:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 834:	f947c611 	ldr	x17, [x16, #3976]
 838:	913e2210 	add	x16, x16, #0xf88
 83c:	d61f0220 	br	x17

0000000000000840 <__stack_chk_fail@plt>:
 840:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 844:	f947ca11 	ldr	x17, [x16, #3984]
 848:	913e4210 	add	x16, x16, #0xf90
 84c:	d61f0220 	br	x17

0000000000000850 <close@plt>:
 850:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 854:	f947ce11 	ldr	x17, [x16, #3992]
 858:	913e6210 	add	x16, x16, #0xf98
 85c:	d61f0220 	br	x17

0000000000000860 <__gmon_start__@plt>:
 860:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 864:	f947d211 	ldr	x17, [x16, #4000]
 868:	913e8210 	add	x16, x16, #0xfa0
 86c:	d61f0220 	br	x17

0000000000000870 <abort@plt>:
 870:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 874:	f947d611 	ldr	x17, [x16, #4008]
 878:	913ea210 	add	x16, x16, #0xfa8
 87c:	d61f0220 	br	x17

0000000000000880 <puts@plt>:
 880:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 884:	f947da11 	ldr	x17, [x16, #4016]
 888:	913ec210 	add	x16, x16, #0xfb0
 88c:	d61f0220 	br	x17

0000000000000890 <pread@plt>:
 890:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 894:	f947de11 	ldr	x17, [x16, #4024]
 898:	913ee210 	add	x16, x16, #0xfb8
 89c:	d61f0220 	br	x17

00000000000008a0 <printf@plt>:
 8a0:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11a0>
 8a4:	f947e211 	ldr	x17, [x16, #4032]
 8a8:	913f0210 	add	x16, x16, #0xfc0
 8ac:	d61f0220 	br	x17

Disassembly of section .text:

00000000000008c0 <_start>:
_start():
 8c0:	d503201f 	nop
 8c4:	d280001d 	mov	x29, #0x0                   	// #0
 8c8:	d280001e 	mov	x30, #0x0                   	// #0
 8cc:	aa0003e5 	mov	x5, x0
 8d0:	f94003e1 	ldr	x1, [sp]
 8d4:	910023e2 	add	x2, sp, #0x8
 8d8:	910003e6 	mov	x6, sp
 8dc:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11a0>
 8e0:	f947f800 	ldr	x0, [x0, #4080]
 8e4:	d2800003 	mov	x3, #0x0                   	// #0
 8e8:	d2800004 	mov	x4, #0x0                   	// #0
 8ec:	97ffffc5 	bl	800 <__libc_start_main@plt>
 8f0:	97ffffe0 	bl	870 <abort@plt>

00000000000008f4 <call_weak_fn>:
call_weak_fn():
 8f4:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11a0>
 8f8:	f947f000 	ldr	x0, [x0, #4064]
 8fc:	b4000040 	cbz	x0, 904 <call_weak_fn+0x10>
 900:	17ffffd8 	b	860 <__gmon_start__@plt>
 904:	d65f03c0 	ret

0000000000000908 <deregister_tm_clones>:
deregister_tm_clones():
 908:	f0000000 	adrp	x0, 3000 <__data_start>
 90c:	91004000 	add	x0, x0, #0x10
 910:	f0000001 	adrp	x1, 3000 <__data_start>
 914:	91004021 	add	x1, x1, #0x10
 918:	eb00003f 	cmp	x1, x0
 91c:	540000c0 	b.eq	934 <deregister_tm_clones+0x2c>  // b.none
 920:	d0000001 	adrp	x1, 2000 <__FRAME_END__+0x11a0>
 924:	f947e821 	ldr	x1, [x1, #4048]
 928:	b4000061 	cbz	x1, 934 <deregister_tm_clones+0x2c>
 92c:	aa0103f0 	mov	x16, x1
 930:	d61f0200 	br	x16
 934:	d65f03c0 	ret

0000000000000938 <register_tm_clones>:
register_tm_clones():
 938:	f0000000 	adrp	x0, 3000 <__data_start>
 93c:	91004000 	add	x0, x0, #0x10
 940:	f0000001 	adrp	x1, 3000 <__data_start>
 944:	91004021 	add	x1, x1, #0x10
 948:	cb000021 	sub	x1, x1, x0
 94c:	d2800042 	mov	x2, #0x2                   	// #2
 950:	9343fc21 	asr	x1, x1, #3
 954:	9ac20c21 	sdiv	x1, x1, x2
 958:	b40000c1 	cbz	x1, 970 <register_tm_clones+0x38>
 95c:	d0000002 	adrp	x2, 2000 <__FRAME_END__+0x11a0>
 960:	f947fc42 	ldr	x2, [x2, #4088]
 964:	b4000062 	cbz	x2, 970 <register_tm_clones+0x38>
 968:	aa0203f0 	mov	x16, x2
 96c:	d61f0200 	br	x16
 970:	d65f03c0 	ret

0000000000000974 <__do_global_dtors_aux>:
__do_global_dtors_aux():
 974:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 978:	910003fd 	mov	x29, sp
 97c:	f9000bf3 	str	x19, [sp, #16]
 980:	f0000013 	adrp	x19, 3000 <__data_start>
 984:	39404260 	ldrb	w0, [x19, #16]
 988:	35000140 	cbnz	w0, 9b0 <__do_global_dtors_aux+0x3c>
 98c:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11a0>
 990:	f947ec00 	ldr	x0, [x0, #4056]
 994:	b4000080 	cbz	x0, 9a4 <__do_global_dtors_aux+0x30>
 998:	f0000000 	adrp	x0, 3000 <__data_start>
 99c:	f9400400 	ldr	x0, [x0, #8]
 9a0:	97ffffa0 	bl	820 <__cxa_finalize@plt>
 9a4:	97ffffd9 	bl	908 <deregister_tm_clones>
 9a8:	52800020 	mov	w0, #0x1                   	// #1
 9ac:	39004260 	strb	w0, [x19, #16]
 9b0:	f9400bf3 	ldr	x19, [sp, #16]
 9b4:	a8c27bfd 	ldp	x29, x30, [sp], #32
 9b8:	d65f03c0 	ret

00000000000009bc <frame_dummy>:
frame_dummy():
 9bc:	17ffffdf 	b	938 <register_tm_clones>

00000000000009c0 <dummyFunction>:
dummyFunction():
 9c0:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
 9c4:	910003fd 	mov	x29, sp
 9c8:	528000a0 	mov	w0, #0x5                   	// #5
 9cc:	b9001be0 	str	w0, [sp, #24]
 9d0:	52800140 	mov	w0, #0xa                   	// #10
 9d4:	b9001fe0 	str	w0, [sp, #28]
 9d8:	b9401be1 	ldr	w1, [sp, #24]
 9dc:	b9401fe0 	ldr	w0, [sp, #28]
 9e0:	0b000020 	add	w0, w1, w0
 9e4:	b90023e0 	str	w0, [sp, #32]
 9e8:	b9401be1 	ldr	w1, [sp, #24]
 9ec:	b9401fe0 	ldr	w0, [sp, #28]
 9f0:	1b007c20 	mul	w0, w1, w0
 9f4:	b90027e0 	str	w0, [sp, #36]
 9f8:	b9401fe1 	ldr	w1, [sp, #28]
 9fc:	b9401be0 	ldr	w0, [sp, #24]
 a00:	1ac00c20 	sdiv	w0, w1, w0
 a04:	b9002be0 	str	w0, [sp, #40]
 a08:	b9401fe0 	ldr	w0, [sp, #28]
 a0c:	b9401be1 	ldr	w1, [sp, #24]
 a10:	1ac10c02 	sdiv	w2, w0, w1
 a14:	b9401be1 	ldr	w1, [sp, #24]
 a18:	1b017c41 	mul	w1, w2, w1
 a1c:	4b010000 	sub	w0, w0, w1
 a20:	b9002fe0 	str	w0, [sp, #44]
 a24:	b94023e0 	ldr	w0, [sp, #32]
 a28:	4b0003e0 	neg	w0, w0
 a2c:	b90033e0 	str	w0, [sp, #48]
 a30:	b9401be1 	ldr	w1, [sp, #24]
 a34:	b9401fe0 	ldr	w0, [sp, #28]
 a38:	0a000020 	and	w0, w1, w0
 a3c:	b90037e0 	str	w0, [sp, #52]
 a40:	b9401be1 	ldr	w1, [sp, #24]
 a44:	b9401fe0 	ldr	w0, [sp, #28]
 a48:	2a000020 	orr	w0, w1, w0
 a4c:	b9003be0 	str	w0, [sp, #56]
 a50:	b9401be1 	ldr	w1, [sp, #24]
 a54:	b9401fe0 	ldr	w0, [sp, #28]
 a58:	4a000020 	eor	w0, w1, w0
 a5c:	b9003fe0 	str	w0, [sp, #60]
 a60:	b9401be0 	ldr	w0, [sp, #24]
 a64:	531e7400 	lsl	w0, w0, #2
 a68:	b90043e0 	str	w0, [sp, #64]
 a6c:	b9401fe0 	ldr	w0, [sp, #28]
 a70:	13017c00 	asr	w0, w0, #1
 a74:	b90047e0 	str	w0, [sp, #68]
 a78:	b9401be0 	ldr	w0, [sp, #24]
 a7c:	2a2003e0 	mvn	w0, w0
 a80:	b9004be0 	str	w0, [sp, #72]
 a84:	b94023e1 	ldr	w1, [sp, #32]
 a88:	b94027e0 	ldr	w0, [sp, #36]
 a8c:	0b000021 	add	w1, w1, w0
 a90:	b9402be0 	ldr	w0, [sp, #40]
 a94:	0b000021 	add	w1, w1, w0
 a98:	b9402fe0 	ldr	w0, [sp, #44]
 a9c:	0b000021 	add	w1, w1, w0
 aa0:	b94033e0 	ldr	w0, [sp, #48]
 aa4:	0b000021 	add	w1, w1, w0
 aa8:	b94037e0 	ldr	w0, [sp, #52]
 aac:	0b000021 	add	w1, w1, w0
 ab0:	b9403be0 	ldr	w0, [sp, #56]
 ab4:	0b000021 	add	w1, w1, w0
 ab8:	b9403fe0 	ldr	w0, [sp, #60]
 abc:	0b000021 	add	w1, w1, w0
 ac0:	b94043e0 	ldr	w0, [sp, #64]
 ac4:	0b000021 	add	w1, w1, w0
 ac8:	b94047e0 	ldr	w0, [sp, #68]
 acc:	0b000020 	add	w0, w1, w0
 ad0:	b9404be1 	ldr	w1, [sp, #72]
 ad4:	0b000020 	add	w0, w1, w0
 ad8:	b9004fe0 	str	w0, [sp, #76]
 adc:	b9404fe1 	ldr	w1, [sp, #76]
 ae0:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 ae4:	91322000 	add	x0, x0, #0xc88
 ae8:	97ffff6e 	bl	8a0 <printf@plt>
 aec:	d503201f 	nop
 af0:	a8c57bfd 	ldp	x29, x30, [sp], #80
 af4:	d65f03c0 	ret

0000000000000af8 <main>:
main():
 af8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 afc:	910003fd 	mov	x29, sp
 b00:	b9001fe0 	str	w0, [sp, #28]
 b04:	f9000be1 	str	x1, [sp, #16]
 b08:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 b0c:	91326000 	add	x0, x0, #0xc98
 b10:	97ffff5c 	bl	880 <puts@plt>
 b14:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 b18:	91280000 	add	x0, x0, #0xa00
 b1c:	94000040 	bl	c1c <getPhysicalAddress>
 b20:	97ffffa8 	bl	9c0 <dummyFunction>
 b24:	52800000 	mov	w0, #0x0                   	// #0
 b28:	a8c27bfd 	ldp	x29, x30, [sp], #32
 b2c:	d65f03c0 	ret

0000000000000b30 <virtual_to_physical>:
virtual_to_physical():
 b30:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 b34:	910003fd 	mov	x29, sp
 b38:	f9000fe0 	str	x0, [sp, #24]
 b3c:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11a0>
 b40:	f947f400 	ldr	x0, [x0, #4072]
 b44:	f9400001 	ldr	x1, [x0]
 b48:	f9001fe1 	str	x1, [sp, #56]
 b4c:	d2800001 	mov	x1, #0x0                   	// #0
 b50:	52800001 	mov	w1, #0x0                   	// #0
 b54:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 b58:	9132a000 	add	x0, x0, #0xca8
 b5c:	97ffff35 	bl	830 <open@plt>
 b60:	b90027e0 	str	w0, [sp, #36]
 b64:	b94027e0 	ldr	w0, [sp, #36]
 b68:	3100041f 	cmn	w0, #0x1
 b6c:	540000c1 	b.ne	b84 <virtual_to_physical+0x54>  // b.any
 b70:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 b74:	91330000 	add	x0, x0, #0xcc0
 b78:	97ffff26 	bl	810 <perror@plt>
 b7c:	d2800000 	mov	x0, #0x0                   	// #0
 b80:	1400001b 	b	bec <virtual_to_physical+0xbc>
 b84:	f9400fe0 	ldr	x0, [sp, #24]
 b88:	d34cfc00 	lsr	x0, x0, #12
 b8c:	d37df000 	lsl	x0, x0, #3
 b90:	f9001be0 	str	x0, [sp, #48]
 b94:	9100a3e0 	add	x0, sp, #0x28
 b98:	f9401be3 	ldr	x3, [sp, #48]
 b9c:	d2800102 	mov	x2, #0x8                   	// #8
 ba0:	aa0003e1 	mov	x1, x0
 ba4:	b94027e0 	ldr	w0, [sp, #36]
 ba8:	97ffff3a 	bl	890 <pread@plt>
 bac:	f100201f 	cmp	x0, #0x8
 bb0:	54000100 	b.eq	bd0 <virtual_to_physical+0xa0>  // b.none
 bb4:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 bb8:	91332000 	add	x0, x0, #0xcc8
 bbc:	97ffff15 	bl	810 <perror@plt>
 bc0:	b94027e0 	ldr	w0, [sp, #36]
 bc4:	97ffff23 	bl	850 <close@plt>
 bc8:	d2800000 	mov	x0, #0x0                   	// #0
 bcc:	14000008 	b	bec <virtual_to_physical+0xbc>
 bd0:	b94027e0 	ldr	w0, [sp, #36]
 bd4:	97ffff1f 	bl	850 <close@plt>
 bd8:	f94017e0 	ldr	x0, [sp, #40]
 bdc:	d374cc01 	lsl	x1, x0, #12
 be0:	f9400fe0 	ldr	x0, [sp, #24]
 be4:	92402c00 	and	x0, x0, #0xfff
 be8:	aa000020 	orr	x0, x1, x0
 bec:	aa0003e1 	mov	x1, x0
 bf0:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11a0>
 bf4:	f947f400 	ldr	x0, [x0, #4072]
 bf8:	f9401fe3 	ldr	x3, [sp, #56]
 bfc:	f9400002 	ldr	x2, [x0]
 c00:	eb020063 	subs	x3, x3, x2
 c04:	d2800002 	mov	x2, #0x0                   	// #0
 c08:	54000040 	b.eq	c10 <virtual_to_physical+0xe0>  // b.none
 c0c:	97ffff0d 	bl	840 <__stack_chk_fail@plt>
 c10:	aa0103e0 	mov	x0, x1
 c14:	a8c47bfd 	ldp	x29, x30, [sp], #64
 c18:	d65f03c0 	ret

0000000000000c1c <getPhysicalAddress>:
getPhysicalAddress():
 c1c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 c20:	910003fd 	mov	x29, sp
 c24:	f9000fe0 	str	x0, [sp, #24]
 c28:	f9400fe0 	ldr	x0, [sp, #24]
 c2c:	f90013e0 	str	x0, [sp, #32]
 c30:	f94013e1 	ldr	x1, [sp, #32]
 c34:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 c38:	91334000 	add	x0, x0, #0xcd0
 c3c:	97ffff19 	bl	8a0 <printf@plt>
 c40:	f94013e0 	ldr	x0, [sp, #32]
 c44:	97ffffbb 	bl	b30 <virtual_to_physical>
 c48:	f90017e0 	str	x0, [sp, #40]
 c4c:	f94017e1 	ldr	x1, [sp, #40]
 c50:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 c54:	9133a000 	add	x0, x0, #0xce8
 c58:	97ffff12 	bl	8a0 <printf@plt>
 c5c:	d503201f 	nop
 c60:	a8c37bfd 	ldp	x29, x30, [sp], #48
 c64:	d65f03c0 	ret

Disassembly of section .fini:

0000000000000c68 <_fini>:
_fini():
 c68:	d503201f 	nop
 c6c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
 c70:	910003fd 	mov	x29, sp
 c74:	a8c17bfd 	ldp	x29, x30, [sp], #16
 c78:	d65f03c0 	ret

Disassembly of section .rodata:

0000000000000c80 <_IO_stdin_used>:
 c80:	00020001 	.inst	0x00020001 ; undefined
 c84:	00000000 	udf	#0
 c88:	75736552 	.inst	0x75736552 ; undefined
 c8c:	203a746c 	.inst	0x203a746c ; undefined
 c90:	000a6425 	.inst	0x000a6425 ; undefined
 c94:	00000000 	udf	#0
 c98:	6c6c6548 	ldnp	d8, d25, [x10, #-320]
 c9c:	57202c6f 	.inst	0x57202c6f ; undefined
 ca0:	646c726f 	.inst	0x646c726f ; undefined
 ca4:	00000021 	udf	#33
 ca8:	6f72702f 	fcmla	v15.8h, v1.8h, v18.h[1], #270
 cac:	65732f63 	fmls	z3.h, p3/m, z27.h, z19.h
 cb0:	702f666c 	adr	x12, 5f97f <__bss_end__+0x5c967>
 cb4:	6d656761 	ldp	d1, d25, [x27, #-432]
 cb8:	00007061 	udf	#28769
 cbc:	00000000 	udf	#0
 cc0:	6e65706f 	uabdl2	v15.4s, v3.8h, v5.8h
 cc4:	00000000 	udf	#0
 cc8:	61657270 	.inst	0x61657270 ; undefined
 ccc:	00000064 	udf	#100
 cd0:	74726956 	.inst	0x74726956 ; undefined
 cd4:	206c6175 	.inst	0x206c6175 ; undefined
 cd8:	72646441 	.inst	0x72646441 ; undefined
 cdc:	7830203a 	ldeorh	w16, w26, [x1]
 ce0:	78383025 	ldseth	w24, w5, [x1]
 ce4:	0000000a 	udf	#10
 ce8:	73796850 	.inst	0x73796850 ; undefined
 cec:	6c616369 	ldnp	d9, d24, [x27, #-496]
 cf0:	64644120 	bfdot	z0.s, z9.h, z4.h[0]
 cf4:	30203a72 	adr	x18, 41441 <__bss_end__+0x3e429>
 cf8:	38302578 	.inst	0x38302578 ; undefined
 cfc:	Address 0x0000000000000cfc is out of bounds.


Disassembly of section .eh_frame_hdr:

0000000000000d00 <__GNU_EH_FRAME_HDR>:
__GNU_EH_FRAME_HDR():
 d00:	3b031b01 	.inst	0x3b031b01 ; undefined
 d04:	00000054 	udf	#84
 d08:	00000009 	udf	#9
 d0c:	fffffbc0 	.inst	0xfffffbc0 ; undefined
 d10:	0000006c 	udf	#108
 d14:	fffffc08 	.inst	0xfffffc08 ; undefined
 d18:	00000080 	udf	#128
 d1c:	fffffc38 	.inst	0xfffffc38 ; undefined
 d20:	00000094 	udf	#148
 d24:	fffffc74 	.inst	0xfffffc74 ; undefined
 d28:	000000a8 	udf	#168
 d2c:	fffffcbc 	.inst	0xfffffcbc ; undefined
 d30:	000000cc 	udf	#204
 d34:	fffffcc0 	.inst	0xfffffcc0 ; undefined
 d38:	000000e0 	udf	#224
 d3c:	fffffdf8 	.inst	0xfffffdf8 ; undefined
 d40:	00000100 	udf	#256
 d44:	fffffe30 	.inst	0xfffffe30 ; undefined
 d48:	00000120 	udf	#288
 d4c:	ffffff1c 	.inst	0xffffff1c ; undefined
 d50:	00000140 	udf	#320

Disassembly of section .eh_frame:

0000000000000d58 <__FRAME_END__-0x108>:
 d58:	00000010 	udf	#16
 d5c:	00000000 	udf	#0
 d60:	00527a01 	.inst	0x00527a01 ; undefined
 d64:	011e7804 	.inst	0x011e7804 ; undefined
 d68:	001f0c1b 	.inst	0x001f0c1b ; undefined
 d6c:	00000010 	udf	#16
 d70:	00000018 	udf	#24
 d74:	fffffb4c 	.inst	0xfffffb4c ; undefined
 d78:	00000034 	udf	#52
 d7c:	1e074100 	.inst	0x1e074100 ; undefined
 d80:	00000010 	udf	#16
 d84:	0000002c 	udf	#44
 d88:	fffffb80 	.inst	0xfffffb80 ; undefined
 d8c:	00000030 	udf	#48
 d90:	00000000 	udf	#0
 d94:	00000010 	udf	#16
 d98:	00000040 	udf	#64
 d9c:	fffffb9c 	.inst	0xfffffb9c ; undefined
 da0:	0000003c 	udf	#60
 da4:	00000000 	udf	#0
 da8:	00000020 	udf	#32
 dac:	00000054 	udf	#84
 db0:	fffffbc4 	.inst	0xfffffbc4 ; undefined
 db4:	00000048 	udf	#72
 db8:	200e4100 	.inst	0x200e4100 ; undefined
 dbc:	039e049d 	.inst	0x039e049d ; undefined
 dc0:	4e029342 	.inst	0x4e029342 ; undefined
 dc4:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
 dc8:	00000000 	udf	#0
 dcc:	00000010 	udf	#16
 dd0:	00000078 	udf	#120
 dd4:	fffffbe8 	.inst	0xfffffbe8 ; undefined
 dd8:	00000004 	udf	#4
 ddc:	00000000 	udf	#0
 de0:	0000001c 	udf	#28
 de4:	0000008c 	udf	#140
 de8:	fffffbd8 	.inst	0xfffffbd8 ; undefined
 dec:	00000138 	udf	#312
 df0:	500e4100 	adr	x0, 1d612 <__bss_end__+0x1a5fa>
 df4:	099e0a9d 	.inst	0x099e0a9d ; undefined
 df8:	ddde4c02 	.inst	0xddde4c02 ; undefined
 dfc:	0000000e 	udf	#14
 e00:	0000001c 	udf	#28
 e04:	000000ac 	udf	#172
 e08:	fffffcf0 	.inst	0xfffffcf0 ; undefined
 e0c:	00000038 	udf	#56
 e10:	200e4100 	.inst	0x200e4100 ; undefined
 e14:	039e049d 	.inst	0x039e049d ; undefined
 e18:	0eddde4c 	.inst	0x0eddde4c ; undefined
 e1c:	00000000 	udf	#0
 e20:	0000001c 	udf	#28
 e24:	000000cc 	udf	#204
 e28:	fffffd08 	.inst	0xfffffd08 ; undefined
 e2c:	000000ec 	udf	#236
 e30:	400e4100 	.inst	0x400e4100 ; undefined
 e34:	079e089d 	.inst	0x079e089d ; undefined
 e38:	0eddde79 	.inst	0x0eddde79 ; undefined
 e3c:	00000000 	udf	#0
 e40:	0000001c 	udf	#28
 e44:	000000ec 	udf	#236
 e48:	fffffdd4 	.inst	0xfffffdd4 ; undefined
 e4c:	0000004c 	udf	#76
 e50:	300e4100 	adr	x0, 1d671 <__bss_end__+0x1a659>
 e54:	059e069d 	mov	z29.s, p14/z, #52
 e58:	0eddde51 	.inst	0x0eddde51 ; undefined
 e5c:	00000000 	udf	#0

0000000000000e60 <__FRAME_END__>:
 e60:	00000000 	udf	#0

Disassembly of section .init_array:

0000000000002d38 <__frame_dummy_init_array_entry>:
    2d38:	000009bc 	udf	#2492
    2d3c:	00000000 	udf	#0

Disassembly of section .fini_array:

0000000000002d40 <__do_global_dtors_aux_fini_array_entry>:
    2d40:	00000974 	udf	#2420
    2d44:	00000000 	udf	#0

Disassembly of section .dynamic:

0000000000002d48 <.dynamic>:
    2d48:	00000001 	udf	#1
    2d4c:	00000000 	udf	#0
    2d50:	0000006f 	udf	#111
    2d54:	00000000 	udf	#0
    2d58:	00000001 	udf	#1
    2d5c:	00000000 	udf	#0
    2d60:	00000079 	udf	#121
    2d64:	00000000 	udf	#0
    2d68:	0000000c 	udf	#12
    2d6c:	00000000 	udf	#0
    2d70:	000007c8 	udf	#1992
    2d74:	00000000 	udf	#0
    2d78:	0000000d 	udf	#13
    2d7c:	00000000 	udf	#0
    2d80:	00000c68 	udf	#3176
    2d84:	00000000 	udf	#0
    2d88:	00000019 	udf	#25
    2d8c:	00000000 	udf	#0
    2d90:	00002d38 	udf	#11576
    2d94:	00000000 	udf	#0
    2d98:	0000001b 	udf	#27
    2d9c:	00000000 	udf	#0
    2da0:	00000008 	udf	#8
    2da4:	00000000 	udf	#0
    2da8:	0000001a 	udf	#26
    2dac:	00000000 	udf	#0
    2db0:	00002d40 	udf	#11584
    2db4:	00000000 	udf	#0
    2db8:	0000001c 	udf	#28
    2dbc:	00000000 	udf	#0
    2dc0:	00000008 	udf	#8
    2dc4:	00000000 	udf	#0
    2dc8:	00000004 	udf	#4
    2dcc:	00000000 	udf	#0
    2dd0:	00000278 	udf	#632
    2dd4:	00000000 	udf	#0
    2dd8:	6ffffef5 	.inst	0x6ffffef5 ; undefined
    2ddc:	00000000 	udf	#0
    2de0:	000002d0 	udf	#720
    2de4:	00000000 	udf	#0
    2de8:	00000005 	udf	#5
    2dec:	00000000 	udf	#0
    2df0:	00000488 	udf	#1160
    2df4:	00000000 	udf	#0
    2df8:	00000006 	udf	#6
    2dfc:	00000000 	udf	#0
    2e00:	000002f0 	udf	#752
    2e04:	00000000 	udf	#0
    2e08:	0000000a 	udf	#10
    2e0c:	00000000 	udf	#0
    2e10:	000000ea 	udf	#234
    2e14:	00000000 	udf	#0
    2e18:	0000000b 	udf	#11
    2e1c:	00000000 	udf	#0
    2e20:	00000018 	udf	#24
    2e24:	00000000 	udf	#0
    2e28:	00000015 	udf	#21
	...
    2e38:	00000003 	udf	#3
    2e3c:	00000000 	udf	#0
    2e40:	00002f58 	udf	#12120
    2e44:	00000000 	udf	#0
    2e48:	00000002 	udf	#2
    2e4c:	00000000 	udf	#0
    2e50:	00000108 	udf	#264
    2e54:	00000000 	udf	#0
    2e58:	00000014 	udf	#20
    2e5c:	00000000 	udf	#0
    2e60:	00000007 	udf	#7
    2e64:	00000000 	udf	#0
    2e68:	00000017 	udf	#23
    2e6c:	00000000 	udf	#0
    2e70:	000006c0 	udf	#1728
    2e74:	00000000 	udf	#0
    2e78:	00000007 	udf	#7
    2e7c:	00000000 	udf	#0
    2e80:	000005e8 	udf	#1512
    2e84:	00000000 	udf	#0
    2e88:	00000008 	udf	#8
    2e8c:	00000000 	udf	#0
    2e90:	000000d8 	udf	#216
    2e94:	00000000 	udf	#0
    2e98:	00000009 	udf	#9
    2e9c:	00000000 	udf	#0
    2ea0:	00000018 	udf	#24
    2ea4:	00000000 	udf	#0
    2ea8:	00000018 	udf	#24
	...
    2eb8:	6ffffffb 	.inst	0x6ffffffb ; undefined
    2ebc:	00000000 	udf	#0
    2ec0:	08000001 	stxrb	w0, w1, [x0]
    2ec4:	00000000 	udf	#0
    2ec8:	6ffffffe 	.inst	0x6ffffffe ; undefined
    2ecc:	00000000 	udf	#0
    2ed0:	00000598 	udf	#1432
    2ed4:	00000000 	udf	#0
    2ed8:	6fffffff 	.inst	0x6fffffff ; undefined
    2edc:	00000000 	udf	#0
    2ee0:	00000002 	udf	#2
    2ee4:	00000000 	udf	#0
    2ee8:	6ffffff0 	.inst	0x6ffffff0 ; undefined
    2eec:	00000000 	udf	#0
    2ef0:	00000572 	udf	#1394
    2ef4:	00000000 	udf	#0
    2ef8:	6ffffff9 	.inst	0x6ffffff9 ; undefined
    2efc:	00000000 	udf	#0
    2f00:	00000004 	udf	#4
	...

Disassembly of section .got:

0000000000002f58 <.got>:
	...
    2f70:	000007e0 	udf	#2016
    2f74:	00000000 	udf	#0
    2f78:	000007e0 	udf	#2016
    2f7c:	00000000 	udf	#0
    2f80:	000007e0 	udf	#2016
    2f84:	00000000 	udf	#0
    2f88:	000007e0 	udf	#2016
    2f8c:	00000000 	udf	#0
    2f90:	000007e0 	udf	#2016
    2f94:	00000000 	udf	#0
    2f98:	000007e0 	udf	#2016
    2f9c:	00000000 	udf	#0
    2fa0:	000007e0 	udf	#2016
    2fa4:	00000000 	udf	#0
    2fa8:	000007e0 	udf	#2016
    2fac:	00000000 	udf	#0
    2fb0:	000007e0 	udf	#2016
    2fb4:	00000000 	udf	#0
    2fb8:	000007e0 	udf	#2016
    2fbc:	00000000 	udf	#0
    2fc0:	000007e0 	udf	#2016
    2fc4:	00000000 	udf	#0
    2fc8:	00002d48 	udf	#11592
	...
    2ff0:	00000af8 	udf	#2808
	...

Disassembly of section .data:

0000000000003000 <__data_start>:
	...

0000000000003008 <__dso_handle>:
data_start():
    3008:	00003008 	udf	#12296
    300c:	00000000 	udf	#0

Disassembly of section .bss:

0000000000003010 <completed.0>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi  // mi = first
   4:	75422820 	.inst	0x75422820 ; undefined
   8:	72646c69 	.inst	0x72646c69 ; undefined
   c:	20746f6f 	.inst	0x20746f6f ; undefined
  10:	32323032 	orr	w18, w1, #0x7ffc000
  14:	2931312e 	stp	w14, w12, [x9, #-120]
  18:	2e313120 	usubw	v0.8h, v9.8h, v17.8b
  1c:	00302e33 	.inst	0x00302e33 ; NYI
