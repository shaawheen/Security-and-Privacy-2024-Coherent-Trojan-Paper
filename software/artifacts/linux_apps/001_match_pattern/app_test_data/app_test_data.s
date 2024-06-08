
app_test_data:     file format elf64-littleaarch64


Disassembly of section .interp:

0000000000000238 <.interp>:
 238:	62696c2f 	.inst	0x62696c2f ; undefined
 23c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
 240:	756e696c 	.inst	0x756e696c ; undefined
 244:	61612d78 	.inst	0x61612d78 ; undefined
 248:	36686372 	tbz	w18, #13, eb4 <__FRAME_END__+0x7c>
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
 27c:	00000012 	udf	#18
 280:	0000000b 	udf	#11
 284:	00000010 	udf	#16
 288:	00000011 	udf	#17
	...
 2a0:	00000003 	udf	#3
 2a4:	00000000 	udf	#0
 2a8:	00000006 	udf	#6
 2ac:	00000005 	udf	#5
 2b0:	00000004 	udf	#4
 2b4:	00000009 	udf	#9
 2b8:	0000000a 	udf	#10
 2bc:	00000008 	udf	#8
 2c0:	00000007 	udf	#7
 2c4:	0000000c 	udf	#12
 2c8:	0000000d 	udf	#13
 2cc:	0000000e 	udf	#14
 2d0:	0000000f 	udf	#15

Disassembly of section .gnu.hash:

00000000000002d8 <.gnu.hash>:
 2d8:	00000001 	udf	#1
 2dc:	00000001 	udf	#1
 2e0:	00000001 	udf	#1
	...

Disassembly of section .dynsym:

00000000000002f8 <.dynsym>:
	...
 314:	000b0003 	.inst	0x000b0003 ; undefined
 318:	00000810 	udf	#2064
	...
 32c:	00160003 	.inst	0x00160003 ; undefined
 330:	00003000 	udf	#12288
	...
 340:	00000023 	udf	#35
 344:	00000012 	udf	#18
	...
 358:	00000001 	udf	#1
 35c:	00000012 	udf	#18
	...
 370:	000000b3 	udf	#179
 374:	00000020 	udf	#32
	...
 388:	00000049 	udf	#73
 38c:	00000022 	udf	#34
	...
 3a0:	0000001e 	udf	#30
 3a4:	00000012 	udf	#18
	...
 3b8:	0000003b 	udf	#59
 3bc:	00000012 	udf	#18
	...
 3d0:	00000008 	udf	#8
 3d4:	00000012 	udf	#18
	...
 3e8:	00000058 	udf	#88
 3ec:	00000012 	udf	#18
	...
 400:	000000cf 	udf	#207
 404:	00000020 	udf	#32
	...
 418:	0000006b 	udf	#107
 41c:	00000011 	udf	#17
	...
 430:	00000065 	udf	#101
 434:	00000012 	udf	#18
	...
 448:	00000019 	udf	#25
 44c:	00000012 	udf	#18
	...
 460:	00000035 	udf	#53
 464:	00000012 	udf	#18
	...
 478:	000000de 	udf	#222
 47c:	00000020 	udf	#32
	...
 490:	0000005e 	udf	#94
 494:	00000012 	udf	#18
	...

Disassembly of section .dynstr:

00000000000004a8 <.dynstr>:
 4a8:	72657000 	.inst	0x72657000 ; undefined
 4ac:	00726f72 	.inst	0x00726f72 ; undefined
 4b0:	74735f5f 	.inst	0x74735f5f ; undefined
 4b4:	5f6b6361 	.inst	0x5f6b6361 ; undefined
 4b8:	5f6b6863 	.inst	0x5f6b6863 ; undefined
 4bc:	6c696166 	ldnp	d6, d24, [x11, #-368]
 4c0:	65726600 	fnmls	z0.h, p1/m, z16.h, z18.h
 4c4:	706f0065 	adr	x5, de4d3 <__bss_end__+0xdb4b3>
 4c8:	5f006e65 	.inst	0x5f006e65 ; undefined
 4cc:	62696c5f 	.inst	0x62696c5f ; undefined
 4d0:	74735f63 	.inst	0x74735f63 ; undefined
 4d4:	5f747261 	sqdmlsl	s1, h19, v4.h[3]
 4d8:	6e69616d 	rsubhn2	v13.8h, v11.4s, v9.4s
 4dc:	65727000 	fnmls	z0.h, p4/m, z0.h, z18.h
 4e0:	61006461 	.inst	0x61006461 ; undefined
 4e4:	6e67696c 	.inst	0x6e67696c ; undefined
 4e8:	615f6465 	.inst	0x615f6465 ; undefined
 4ec:	636f6c6c 	.inst	0x636f6c6c ; undefined
 4f0:	635f5f00 	.inst	0x635f5f00 ; undefined
 4f4:	665f6178 	.inst	0x665f6178 ; undefined
 4f8:	6c616e69 	ldnp	d9, d27, [x19, #-496]
 4fc:	00657a69 	.inst	0x00657a69 ; undefined
 500:	736f6c63 	.inst	0x736f6c63 ; undefined
 504:	72700065 	.inst	0x72700065 ; undefined
 508:	66746e69 	.inst	0x66746e69 ; undefined
 50c:	6f626100 	umlsl2	v0.4s, v8.8h, v2.h[2]
 510:	5f007472 	.inst	0x5f007472 ; undefined
 514:	6174735f 	.inst	0x6174735f ; undefined
 518:	635f6b63 	.inst	0x635f6b63 ; undefined
 51c:	675f6b68 	.inst	0x675f6b68 ; undefined
 520:	64726175 	.inst	0x64726175 ; undefined
 524:	62696c00 	.inst	0x62696c00 ; undefined
 528:	6f732e63 	.inst	0x6f732e63 ; undefined
 52c:	6c00362e 	stnp	d14, d13, [x17]
 530:	696c2d64 	ldpsw	x4, x11, [x11, #-160]
 534:	2d78756e 	ldp	s14, s29, [x11, #-64]
 538:	63726161 	.inst	0x63726161 ; undefined
 53c:	2e343668 	cmhi	v8.8b, v19.8b, v20.8b
 540:	312e6f73 	adds	w19, w27, #0xb9b
 544:	494c4700 	.inst	0x494c4700 ; undefined
 548:	325f4342 	.inst	0x325f4342 ; undefined
 54c:	0037312e 	.inst	0x0037312e ; NYI
 550:	42494c47 	.inst	0x42494c47 ; undefined
 554:	2e325f43 	uqrshl	v3.8b, v26.8b, v18.8b
 558:	5f003433 	.inst	0x5f003433 ; undefined
 55c:	5f4d5449 	shl	d9, d2, #13
 560:	65726564 	fnmls	z4.h, p1/m, z11.h, z18.h
 564:	74736967 	.inst	0x74736967 ; undefined
 568:	4d547265 	.inst	0x4d547265 ; undefined
 56c:	6e6f6c43 	umin	v3.8h, v2.8h, v15.8h
 570:	62615465 	.inst	0x62615465 ; undefined
 574:	5f00656c 	.inst	0x5f00656c ; undefined
 578:	6f6d675f 	sqshlu	v31.2d, v26.2d, #45
 57c:	74735f6e 	.inst	0x74735f6e ; undefined
 580:	5f747261 	sqdmlsl	s1, h19, v4.h[3]
 584:	495f005f 	.inst	0x495f005f ; undefined
 588:	725f4d54 	.inst	0x725f4d54 ; undefined
 58c:	73696765 	.inst	0x73696765 ; undefined
 590:	54726574 	bc.mi	e523c <__bss_end__+0xe221c>  // bc.first
 594:	6f6c434d 	mls	v13.8h, v26.8h, v12.h[2]
 598:	6154656e 	.inst	0x6154656e ; undefined
 59c:	00656c62 	.inst	0x00656c62 ; undefined

Disassembly of section .gnu.version:

00000000000005a0 <.gnu.version>:
 5a0:	00000000 	udf	#0
 5a4:	00020000 	.inst	0x00020000 ; undefined
 5a8:	00010003 	.inst	0x00010003 ; undefined
 5ac:	00030003 	.inst	0x00030003 ; undefined
 5b0:	00030003 	.inst	0x00030003 ; undefined
 5b4:	00010003 	.inst	0x00010003 ; undefined
 5b8:	00030004 	.inst	0x00030004 ; undefined
 5bc:	00030003 	.inst	0x00030003 ; undefined
 5c0:	00030001 	.inst	0x00030001 ; undefined

Disassembly of section .gnu.version_r:

00000000000005c8 <.gnu.version_r>:
 5c8:	00010001 	.inst	0x00010001 ; undefined
 5cc:	00000087 	udf	#135
 5d0:	00000010 	udf	#16
 5d4:	00000020 	udf	#32
 5d8:	06969197 	.inst	0x06969197 ; undefined
 5dc:	00040000 	.inst	0x00040000 ; undefined
 5e0:	0000009d 	udf	#157
 5e4:	00000000 	udf	#0
 5e8:	00020001 	.inst	0x00020001 ; undefined
 5ec:	0000007d 	udf	#125
 5f0:	00000010 	udf	#16
 5f4:	00000000 	udf	#0
 5f8:	06969197 	.inst	0x06969197 ; undefined
 5fc:	00030000 	.inst	0x00030000 ; undefined
 600:	0000009d 	udf	#157
 604:	00000010 	udf	#16
 608:	069691b4 	.inst	0x069691b4 ; undefined
 60c:	00020000 	.inst	0x00020000 ; undefined
 610:	000000a8 	udf	#168
 614:	00000000 	udf	#0

Disassembly of section .rela.dyn:

0000000000000618 <.rela.dyn>:
 618:	00002d30 	udf	#11568
 61c:	00000000 	udf	#0
 620:	00000403 	udf	#1027
 624:	00000000 	udf	#0
 628:	00000a3c 	udf	#2620
 62c:	00000000 	udf	#0
 630:	00002d38 	udf	#11576
 634:	00000000 	udf	#0
 638:	00000403 	udf	#1027
 63c:	00000000 	udf	#0
 640:	000009f4 	udf	#2548
 644:	00000000 	udf	#0
 648:	00002ff0 	udf	#12272
 64c:	00000000 	udf	#0
 650:	00000403 	udf	#1027
 654:	00000000 	udf	#0
 658:	00000a40 	udf	#2624
 65c:	00000000 	udf	#0
 660:	00003008 	udf	#12296
 664:	00000000 	udf	#0
 668:	00000403 	udf	#1027
 66c:	00000000 	udf	#0
 670:	00003008 	udf	#12296
 674:	00000000 	udf	#0
 678:	00002fd0 	udf	#12240
 67c:	00000000 	udf	#0
 680:	00000401 	udf	#1025
 684:	00000005 	udf	#5
	...
 690:	00002fd8 	udf	#12248
 694:	00000000 	udf	#0
 698:	00000401 	udf	#1025
 69c:	00000006 	udf	#6
	...
 6a8:	00002fe0 	udf	#12256
 6ac:	00000000 	udf	#0
 6b0:	00000401 	udf	#1025
 6b4:	0000000b 	udf	#11
	...
 6c0:	00002fe8 	udf	#12264
 6c4:	00000000 	udf	#0
 6c8:	00000401 	udf	#1025
 6cc:	0000000c 	udf	#12
	...
 6d8:	00002ff8 	udf	#12280
 6dc:	00000000 	udf	#0
 6e0:	00000401 	udf	#1025
 6e4:	00000010 	udf	#16
	...

Disassembly of section .rela.plt:

00000000000006f0 <.rela.plt>:
 6f0:	00002f68 	udf	#12136
 6f4:	00000000 	udf	#0
 6f8:	00000402 	udf	#1026
 6fc:	00000003 	udf	#3
	...
 708:	00002f70 	udf	#12144
 70c:	00000000 	udf	#0
 710:	00000402 	udf	#1026
 714:	00000004 	udf	#4
	...
 720:	00002f78 	udf	#12152
 724:	00000000 	udf	#0
 728:	00000402 	udf	#1026
 72c:	00000006 	udf	#6
	...
 738:	00002f80 	udf	#12160
 73c:	00000000 	udf	#0
 740:	00000402 	udf	#1026
 744:	00000007 	udf	#7
	...
 750:	00002f88 	udf	#12168
 754:	00000000 	udf	#0
 758:	00000402 	udf	#1026
 75c:	00000008 	udf	#8
	...
 768:	00002f90 	udf	#12176
 76c:	00000000 	udf	#0
 770:	00000402 	udf	#1026
 774:	00000009 	udf	#9
	...
 780:	00002f98 	udf	#12184
 784:	00000000 	udf	#0
 788:	00000402 	udf	#1026
 78c:	0000000a 	udf	#10
	...
 798:	00002fa0 	udf	#12192
 79c:	00000000 	udf	#0
 7a0:	00000402 	udf	#1026
 7a4:	0000000b 	udf	#11
	...
 7b0:	00002fa8 	udf	#12200
 7b4:	00000000 	udf	#0
 7b8:	00000402 	udf	#1026
 7bc:	0000000d 	udf	#13
	...
 7c8:	00002fb0 	udf	#12208
 7cc:	00000000 	udf	#0
 7d0:	00000402 	udf	#1026
 7d4:	0000000e 	udf	#14
	...
 7e0:	00002fb8 	udf	#12216
 7e4:	00000000 	udf	#0
 7e8:	00000402 	udf	#1026
 7ec:	0000000f 	udf	#15
	...
 7f8:	00002fc0 	udf	#12224
 7fc:	00000000 	udf	#0
 800:	00000402 	udf	#1026
 804:	00000011 	udf	#17
	...

Disassembly of section .init:

0000000000000810 <_init>:
_init():
 810:	d503201f 	nop
 814:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
 818:	910003fd 	mov	x29, sp
 81c:	94000056 	bl	974 <call_weak_fn>
 820:	a8c17bfd 	ldp	x29, x30, [sp], #16
 824:	d65f03c0 	ret

Disassembly of section .plt:

0000000000000830 <.plt>:
 830:	a9bf7bf0 	stp	x16, x30, [sp, #-16]!
 834:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 838:	f947b211 	ldr	x17, [x16, #3936]
 83c:	913d8210 	add	x16, x16, #0xf60
 840:	d61f0220 	br	x17
 844:	d503201f 	nop
 848:	d503201f 	nop
 84c:	d503201f 	nop

0000000000000850 <__libc_start_main@plt>:
 850:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 854:	f947b611 	ldr	x17, [x16, #3944]
 858:	913da210 	add	x16, x16, #0xf68
 85c:	d61f0220 	br	x17

0000000000000860 <perror@plt>:
 860:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 864:	f947ba11 	ldr	x17, [x16, #3952]
 868:	913dc210 	add	x16, x16, #0xf70
 86c:	d61f0220 	br	x17

0000000000000870 <__cxa_finalize@plt>:
 870:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 874:	f947be11 	ldr	x17, [x16, #3960]
 878:	913de210 	add	x16, x16, #0xf78
 87c:	d61f0220 	br	x17

0000000000000880 <open@plt>:
 880:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 884:	f947c211 	ldr	x17, [x16, #3968]
 888:	913e0210 	add	x16, x16, #0xf80
 88c:	d61f0220 	br	x17

0000000000000890 <aligned_alloc@plt>:
 890:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 894:	f947c611 	ldr	x17, [x16, #3976]
 898:	913e2210 	add	x16, x16, #0xf88
 89c:	d61f0220 	br	x17

00000000000008a0 <__stack_chk_fail@plt>:
 8a0:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 8a4:	f947ca11 	ldr	x17, [x16, #3984]
 8a8:	913e4210 	add	x16, x16, #0xf90
 8ac:	d61f0220 	br	x17

00000000000008b0 <close@plt>:
 8b0:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 8b4:	f947ce11 	ldr	x17, [x16, #3992]
 8b8:	913e6210 	add	x16, x16, #0xf98
 8bc:	d61f0220 	br	x17

00000000000008c0 <__gmon_start__@plt>:
 8c0:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 8c4:	f947d211 	ldr	x17, [x16, #4000]
 8c8:	913e8210 	add	x16, x16, #0xfa0
 8cc:	d61f0220 	br	x17

00000000000008d0 <abort@plt>:
 8d0:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 8d4:	f947d611 	ldr	x17, [x16, #4008]
 8d8:	913ea210 	add	x16, x16, #0xfa8
 8dc:	d61f0220 	br	x17

00000000000008e0 <free@plt>:
 8e0:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 8e4:	f947da11 	ldr	x17, [x16, #4016]
 8e8:	913ec210 	add	x16, x16, #0xfb0
 8ec:	d61f0220 	br	x17

00000000000008f0 <pread@plt>:
 8f0:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 8f4:	f947de11 	ldr	x17, [x16, #4024]
 8f8:	913ee210 	add	x16, x16, #0xfb8
 8fc:	d61f0220 	br	x17

0000000000000900 <printf@plt>:
 900:	d0000010 	adrp	x16, 2000 <__FRAME_END__+0x11c8>
 904:	f947e211 	ldr	x17, [x16, #4032]
 908:	913f0210 	add	x16, x16, #0xfc0
 90c:	d61f0220 	br	x17

Disassembly of section .text:

0000000000000940 <_start>:
_start():
 940:	d503201f 	nop
 944:	d280001d 	mov	x29, #0x0                   	// #0
 948:	d280001e 	mov	x30, #0x0                   	// #0
 94c:	aa0003e5 	mov	x5, x0
 950:	f94003e1 	ldr	x1, [sp]
 954:	910023e2 	add	x2, sp, #0x8
 958:	910003e6 	mov	x6, sp
 95c:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11c8>
 960:	f947f800 	ldr	x0, [x0, #4080]
 964:	d2800003 	mov	x3, #0x0                   	// #0
 968:	d2800004 	mov	x4, #0x0                   	// #0
 96c:	97ffffb9 	bl	850 <__libc_start_main@plt>
 970:	97ffffd8 	bl	8d0 <abort@plt>

0000000000000974 <call_weak_fn>:
call_weak_fn():
 974:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11c8>
 978:	f947f000 	ldr	x0, [x0, #4064]
 97c:	b4000040 	cbz	x0, 984 <call_weak_fn+0x10>
 980:	17ffffd0 	b	8c0 <__gmon_start__@plt>
 984:	d65f03c0 	ret

0000000000000988 <deregister_tm_clones>:
deregister_tm_clones():
 988:	f0000000 	adrp	x0, 3000 <__data_start>
 98c:	91004000 	add	x0, x0, #0x10
 990:	f0000001 	adrp	x1, 3000 <__data_start>
 994:	91004021 	add	x1, x1, #0x10
 998:	eb00003f 	cmp	x1, x0
 99c:	540000c0 	b.eq	9b4 <deregister_tm_clones+0x2c>  // b.none
 9a0:	d0000001 	adrp	x1, 2000 <__FRAME_END__+0x11c8>
 9a4:	f947e821 	ldr	x1, [x1, #4048]
 9a8:	b4000061 	cbz	x1, 9b4 <deregister_tm_clones+0x2c>
 9ac:	aa0103f0 	mov	x16, x1
 9b0:	d61f0200 	br	x16
 9b4:	d65f03c0 	ret

00000000000009b8 <register_tm_clones>:
register_tm_clones():
 9b8:	f0000000 	adrp	x0, 3000 <__data_start>
 9bc:	91004000 	add	x0, x0, #0x10
 9c0:	f0000001 	adrp	x1, 3000 <__data_start>
 9c4:	91004021 	add	x1, x1, #0x10
 9c8:	cb000021 	sub	x1, x1, x0
 9cc:	d2800042 	mov	x2, #0x2                   	// #2
 9d0:	9343fc21 	asr	x1, x1, #3
 9d4:	9ac20c21 	sdiv	x1, x1, x2
 9d8:	b40000c1 	cbz	x1, 9f0 <register_tm_clones+0x38>
 9dc:	d0000002 	adrp	x2, 2000 <__FRAME_END__+0x11c8>
 9e0:	f947fc42 	ldr	x2, [x2, #4088]
 9e4:	b4000062 	cbz	x2, 9f0 <register_tm_clones+0x38>
 9e8:	aa0203f0 	mov	x16, x2
 9ec:	d61f0200 	br	x16
 9f0:	d65f03c0 	ret

00000000000009f4 <__do_global_dtors_aux>:
__do_global_dtors_aux():
 9f4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 9f8:	910003fd 	mov	x29, sp
 9fc:	f9000bf3 	str	x19, [sp, #16]
 a00:	f0000013 	adrp	x19, 3000 <__data_start>
 a04:	39404260 	ldrb	w0, [x19, #16]
 a08:	35000140 	cbnz	w0, a30 <__do_global_dtors_aux+0x3c>
 a0c:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11c8>
 a10:	f947ec00 	ldr	x0, [x0, #4056]
 a14:	b4000080 	cbz	x0, a24 <__do_global_dtors_aux+0x30>
 a18:	f0000000 	adrp	x0, 3000 <__data_start>
 a1c:	f9400400 	ldr	x0, [x0, #8]
 a20:	97ffff94 	bl	870 <__cxa_finalize@plt>
 a24:	97ffffd9 	bl	988 <deregister_tm_clones>
 a28:	52800020 	mov	w0, #0x1                   	// #1
 a2c:	39004260 	strb	w0, [x19, #16]
 a30:	f9400bf3 	ldr	x19, [sp, #16]
 a34:	a8c27bfd 	ldp	x29, x30, [sp], #32
 a38:	d65f03c0 	ret

0000000000000a3c <frame_dummy>:
frame_dummy():
 a3c:	17ffffdf 	b	9b8 <register_tm_clones>

0000000000000a40 <main>:
main():
 a40:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 a44:	910003fd 	mov	x29, sp
 a48:	b9001fe0 	str	w0, [sp, #28]
 a4c:	f9000be1 	str	x1, [sp, #16]
 a50:	d2a00041 	mov	x1, #0x20000               	// #131072
 a54:	d2800800 	mov	x0, #0x40                  	// #64
 a58:	97ffff8e 	bl	890 <aligned_alloc@plt>
 a5c:	aa0003e1 	mov	x1, x0
 a60:	f0000000 	adrp	x0, 3000 <__data_start>
 a64:	91006000 	add	x0, x0, #0x18
 a68:	f9000001 	str	x1, [x0]
 a6c:	b9002fff 	str	wzr, [sp, #44]
 a70:	14000022 	b	af8 <main+0xb8>
 a74:	b9402fe1 	ldr	w1, [sp, #44]
 a78:	529fe020 	mov	w0, #0xff01                	// #65281
 a7c:	72bfe000 	movk	w0, #0xff00, lsl #16
 a80:	0b000022 	add	w2, w1, w0
 a84:	f0000000 	adrp	x0, 3000 <__data_start>
 a88:	91006000 	add	x0, x0, #0x18
 a8c:	f9400001 	ldr	x1, [x0]
 a90:	b9802fe0 	ldrsw	x0, [sp, #44]
 a94:	d37ef400 	lsl	x0, x0, #2
 a98:	8b000020 	add	x0, x1, x0
 a9c:	2a0203e1 	mov	w1, w2
 aa0:	b9000001 	str	w1, [x0]
 aa4:	f0000000 	adrp	x0, 3000 <__data_start>
 aa8:	91006000 	add	x0, x0, #0x18
 aac:	f9400001 	ldr	x1, [x0]
 ab0:	b9802fe0 	ldrsw	x0, [sp, #44]
 ab4:	d37ef400 	lsl	x0, x0, #2
 ab8:	8b000022 	add	x2, x1, x0
 abc:	f0000000 	adrp	x0, 3000 <__data_start>
 ac0:	91006000 	add	x0, x0, #0x18
 ac4:	f9400001 	ldr	x1, [x0]
 ac8:	b9802fe0 	ldrsw	x0, [sp, #44]
 acc:	d37ef400 	lsl	x0, x0, #2
 ad0:	8b000020 	add	x0, x1, x0
 ad4:	b9400000 	ldr	w0, [x0]
 ad8:	2a0003e3 	mov	w3, w0
 adc:	b9402fe1 	ldr	w1, [sp, #44]
 ae0:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 ae4:	91322000 	add	x0, x0, #0xc88
 ae8:	97ffff86 	bl	900 <printf@plt>
 aec:	b9402fe0 	ldr	w0, [sp, #44]
 af0:	11000400 	add	w0, w0, #0x1
 af4:	b9002fe0 	str	w0, [sp, #44]
 af8:	b9402fe1 	ldr	w1, [sp, #44]
 afc:	528fffe0 	mov	w0, #0x7fff                	// #32767
 b00:	6b00003f 	cmp	w1, w0
 b04:	54fffb8d 	b.le	a74 <main+0x34>
 b08:	f0000000 	adrp	x0, 3000 <__data_start>
 b0c:	91006000 	add	x0, x0, #0x18
 b10:	f9400000 	ldr	x0, [x0]
 b14:	94000043 	bl	c20 <getPhysicalAddress>
 b18:	f0000000 	adrp	x0, 3000 <__data_start>
 b1c:	91006000 	add	x0, x0, #0x18
 b20:	f9400000 	ldr	x0, [x0]
 b24:	97ffff6f 	bl	8e0 <free@plt>
 b28:	52800000 	mov	w0, #0x0                   	// #0
 b2c:	a8c37bfd 	ldp	x29, x30, [sp], #48
 b30:	d65f03c0 	ret

0000000000000b34 <virtual_to_physical>:
virtual_to_physical():
 b34:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 b38:	910003fd 	mov	x29, sp
 b3c:	f9000fe0 	str	x0, [sp, #24]
 b40:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11c8>
 b44:	f947f400 	ldr	x0, [x0, #4072]
 b48:	f9400001 	ldr	x1, [x0]
 b4c:	f9001fe1 	str	x1, [sp, #56]
 b50:	d2800001 	mov	x1, #0x0                   	// #0
 b54:	52800001 	mov	w1, #0x0                   	// #0
 b58:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 b5c:	9132a000 	add	x0, x0, #0xca8
 b60:	97ffff48 	bl	880 <open@plt>
 b64:	b90027e0 	str	w0, [sp, #36]
 b68:	b94027e0 	ldr	w0, [sp, #36]
 b6c:	3100041f 	cmn	w0, #0x1
 b70:	540000c1 	b.ne	b88 <virtual_to_physical+0x54>  // b.any
 b74:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 b78:	91330000 	add	x0, x0, #0xcc0
 b7c:	97ffff39 	bl	860 <perror@plt>
 b80:	d2800000 	mov	x0, #0x0                   	// #0
 b84:	1400001b 	b	bf0 <virtual_to_physical+0xbc>
 b88:	f9400fe0 	ldr	x0, [sp, #24]
 b8c:	d34cfc00 	lsr	x0, x0, #12
 b90:	d37df000 	lsl	x0, x0, #3
 b94:	f9001be0 	str	x0, [sp, #48]
 b98:	9100a3e0 	add	x0, sp, #0x28
 b9c:	f9401be3 	ldr	x3, [sp, #48]
 ba0:	d2800102 	mov	x2, #0x8                   	// #8
 ba4:	aa0003e1 	mov	x1, x0
 ba8:	b94027e0 	ldr	w0, [sp, #36]
 bac:	97ffff51 	bl	8f0 <pread@plt>
 bb0:	f100201f 	cmp	x0, #0x8
 bb4:	54000100 	b.eq	bd4 <virtual_to_physical+0xa0>  // b.none
 bb8:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 bbc:	91332000 	add	x0, x0, #0xcc8
 bc0:	97ffff28 	bl	860 <perror@plt>
 bc4:	b94027e0 	ldr	w0, [sp, #36]
 bc8:	97ffff3a 	bl	8b0 <close@plt>
 bcc:	d2800000 	mov	x0, #0x0                   	// #0
 bd0:	14000008 	b	bf0 <virtual_to_physical+0xbc>
 bd4:	b94027e0 	ldr	w0, [sp, #36]
 bd8:	97ffff36 	bl	8b0 <close@plt>
 bdc:	f94017e0 	ldr	x0, [sp, #40]
 be0:	d374cc01 	lsl	x1, x0, #12
 be4:	f9400fe0 	ldr	x0, [sp, #24]
 be8:	92402c00 	and	x0, x0, #0xfff
 bec:	aa000020 	orr	x0, x1, x0
 bf0:	aa0003e1 	mov	x1, x0
 bf4:	d0000000 	adrp	x0, 2000 <__FRAME_END__+0x11c8>
 bf8:	f947f400 	ldr	x0, [x0, #4072]
 bfc:	f9401fe3 	ldr	x3, [sp, #56]
 c00:	f9400002 	ldr	x2, [x0]
 c04:	eb020063 	subs	x3, x3, x2
 c08:	d2800002 	mov	x2, #0x0                   	// #0
 c0c:	54000040 	b.eq	c14 <virtual_to_physical+0xe0>  // b.none
 c10:	97ffff24 	bl	8a0 <__stack_chk_fail@plt>
 c14:	aa0103e0 	mov	x0, x1
 c18:	a8c47bfd 	ldp	x29, x30, [sp], #64
 c1c:	d65f03c0 	ret

0000000000000c20 <getPhysicalAddress>:
getPhysicalAddress():
 c20:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 c24:	910003fd 	mov	x29, sp
 c28:	f9000fe0 	str	x0, [sp, #24]
 c2c:	f9400fe0 	ldr	x0, [sp, #24]
 c30:	f90013e0 	str	x0, [sp, #32]
 c34:	f94013e1 	ldr	x1, [sp, #32]
 c38:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 c3c:	91334000 	add	x0, x0, #0xcd0
 c40:	97ffff30 	bl	900 <printf@plt>
 c44:	f94013e0 	ldr	x0, [sp, #32]
 c48:	97ffffbb 	bl	b34 <virtual_to_physical>
 c4c:	f90017e0 	str	x0, [sp, #40]
 c50:	f94017e1 	ldr	x1, [sp, #40]
 c54:	90000000 	adrp	x0, 0 <__abi_tag-0x254>
 c58:	9133a000 	add	x0, x0, #0xce8
 c5c:	97ffff29 	bl	900 <printf@plt>
 c60:	d503201f 	nop
 c64:	a8c37bfd 	ldp	x29, x30, [sp], #48
 c68:	d65f03c0 	ret

Disassembly of section .fini:

0000000000000c6c <_fini>:
_fini():
 c6c:	d503201f 	nop
 c70:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
 c74:	910003fd 	mov	x29, sp
 c78:	a8c17bfd 	ldp	x29, x30, [sp], #16
 c7c:	d65f03c0 	ret

Disassembly of section .rodata:

0000000000000c80 <_IO_stdin_used>:
 c80:	00020001 	.inst	0x00020001 ; undefined
 c84:	00000000 	udf	#0
 c88:	74636576 	.inst	0x74636576 ; undefined
 c8c:	255b726f 	.inst	0x255b726f ; undefined
 c90:	28205d64 	stnp	w4, w23, [x11, #-256]
 c94:	30257830 	adr	x16, 4bb99 <__bss_end__+0x48b79>
 c98:	20297838 	.inst	0x20297838 ; undefined
 c9c:	7830203d 	ldeorh	w16, w29, [x1]
 ca0:	78383025 	ldseth	w24, w5, [x1]
 ca4:	0000000a 	udf	#10
 ca8:	6f72702f 	fcmla	v15.8h, v1.8h, v18.h[1], #270
 cac:	65732f63 	fmls	z3.h, p3/m, z27.h, z19.h
 cb0:	702f666c 	adr	x12, 5f97f <__bss_end__+0x5c95f>
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
 cf4:	30203a72 	adr	x18, 41441 <__bss_end__+0x3e421>
 cf8:	38302578 	.inst	0x38302578 ; undefined
 cfc:	Address 0x0000000000000cfc is out of bounds.


Disassembly of section .eh_frame_hdr:

0000000000000d00 <__GNU_EH_FRAME_HDR>:
__GNU_EH_FRAME_HDR():
 d00:	3b031b01 	.inst	0x3b031b01 ; undefined
 d04:	0000004c 	udf	#76
 d08:	00000008 	udf	#8
 d0c:	fffffc40 	.inst	0xfffffc40 ; undefined
 d10:	00000064 	udf	#100
 d14:	fffffc88 	.inst	0xfffffc88 ; undefined
 d18:	00000078 	udf	#120
 d1c:	fffffcb8 	.inst	0xfffffcb8 ; undefined
 d20:	0000008c 	udf	#140
 d24:	fffffcf4 	.inst	0xfffffcf4 ; undefined
 d28:	000000a0 	udf	#160
 d2c:	fffffd3c 	.inst	0xfffffd3c ; undefined
 d30:	000000c4 	udf	#196
 d34:	fffffd40 	.inst	0xfffffd40 ; undefined
 d38:	000000d8 	udf	#216
 d3c:	fffffe34 	.inst	0xfffffe34 ; undefined
 d40:	000000f8 	udf	#248
 d44:	ffffff20 	.inst	0xffffff20 ; undefined
 d48:	00000118 	udf	#280

Disassembly of section .eh_frame:

0000000000000d50 <__FRAME_END__-0xe8>:
 d50:	00000010 	udf	#16
 d54:	00000000 	udf	#0
 d58:	00527a01 	.inst	0x00527a01 ; undefined
 d5c:	011e7804 	.inst	0x011e7804 ; undefined
 d60:	001f0c1b 	.inst	0x001f0c1b ; undefined
 d64:	00000010 	udf	#16
 d68:	00000018 	udf	#24
 d6c:	fffffbd4 	.inst	0xfffffbd4 ; undefined
 d70:	00000034 	udf	#52
 d74:	1e074100 	.inst	0x1e074100 ; undefined
 d78:	00000010 	udf	#16
 d7c:	0000002c 	udf	#44
 d80:	fffffc08 	.inst	0xfffffc08 ; undefined
 d84:	00000030 	udf	#48
 d88:	00000000 	udf	#0
 d8c:	00000010 	udf	#16
 d90:	00000040 	udf	#64
 d94:	fffffc24 	.inst	0xfffffc24 ; undefined
 d98:	0000003c 	udf	#60
 d9c:	00000000 	udf	#0
 da0:	00000020 	udf	#32
 da4:	00000054 	udf	#84
 da8:	fffffc4c 	.inst	0xfffffc4c ; undefined
 dac:	00000048 	udf	#72
 db0:	200e4100 	.inst	0x200e4100 ; undefined
 db4:	039e049d 	.inst	0x039e049d ; undefined
 db8:	4e029342 	.inst	0x4e029342 ; undefined
 dbc:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
 dc0:	00000000 	udf	#0
 dc4:	00000010 	udf	#16
 dc8:	00000078 	udf	#120
 dcc:	fffffc70 	.inst	0xfffffc70 ; undefined
 dd0:	00000004 	udf	#4
 dd4:	00000000 	udf	#0
 dd8:	0000001c 	udf	#28
 ddc:	0000008c 	udf	#140
 de0:	fffffc60 	.inst	0xfffffc60 ; undefined
 de4:	000000f4 	udf	#244
 de8:	300e4100 	adr	x0, 1d609 <__bss_end__+0x1a5e9>
 dec:	059e069d 	mov	z29.s, p14/z, #52
 df0:	0eddde7b 	.inst	0x0eddde7b ; undefined
 df4:	00000000 	udf	#0
 df8:	0000001c 	udf	#28
 dfc:	000000ac 	udf	#172
 e00:	fffffd34 	.inst	0xfffffd34 ; undefined
 e04:	000000ec 	udf	#236
 e08:	400e4100 	.inst	0x400e4100 ; undefined
 e0c:	079e089d 	.inst	0x079e089d ; undefined
 e10:	0eddde79 	.inst	0x0eddde79 ; undefined
 e14:	00000000 	udf	#0
 e18:	0000001c 	udf	#28
 e1c:	000000cc 	udf	#204
 e20:	fffffe00 	.inst	0xfffffe00 ; undefined
 e24:	0000004c 	udf	#76
 e28:	300e4100 	adr	x0, 1d649 <__bss_end__+0x1a629>
 e2c:	059e069d 	mov	z29.s, p14/z, #52
 e30:	0eddde51 	.inst	0x0eddde51 ; undefined
 e34:	00000000 	udf	#0

0000000000000e38 <__FRAME_END__>:
 e38:	00000000 	udf	#0

Disassembly of section .init_array:

0000000000002d30 <__frame_dummy_init_array_entry>:
    2d30:	00000a3c 	udf	#2620
    2d34:	00000000 	udf	#0

Disassembly of section .fini_array:

0000000000002d38 <__do_global_dtors_aux_fini_array_entry>:
    2d38:	000009f4 	udf	#2548
    2d3c:	00000000 	udf	#0

Disassembly of section .dynamic:

0000000000002d40 <.dynamic>:
    2d40:	00000001 	udf	#1
    2d44:	00000000 	udf	#0
    2d48:	0000007d 	udf	#125
    2d4c:	00000000 	udf	#0
    2d50:	00000001 	udf	#1
    2d54:	00000000 	udf	#0
    2d58:	00000087 	udf	#135
    2d5c:	00000000 	udf	#0
    2d60:	0000000c 	udf	#12
    2d64:	00000000 	udf	#0
    2d68:	00000810 	udf	#2064
    2d6c:	00000000 	udf	#0
    2d70:	0000000d 	udf	#13
    2d74:	00000000 	udf	#0
    2d78:	00000c6c 	udf	#3180
    2d7c:	00000000 	udf	#0
    2d80:	00000019 	udf	#25
    2d84:	00000000 	udf	#0
    2d88:	00002d30 	udf	#11568
    2d8c:	00000000 	udf	#0
    2d90:	0000001b 	udf	#27
    2d94:	00000000 	udf	#0
    2d98:	00000008 	udf	#8
    2d9c:	00000000 	udf	#0
    2da0:	0000001a 	udf	#26
    2da4:	00000000 	udf	#0
    2da8:	00002d38 	udf	#11576
    2dac:	00000000 	udf	#0
    2db0:	0000001c 	udf	#28
    2db4:	00000000 	udf	#0
    2db8:	00000008 	udf	#8
    2dbc:	00000000 	udf	#0
    2dc0:	00000004 	udf	#4
    2dc4:	00000000 	udf	#0
    2dc8:	00000278 	udf	#632
    2dcc:	00000000 	udf	#0
    2dd0:	6ffffef5 	.inst	0x6ffffef5 ; undefined
    2dd4:	00000000 	udf	#0
    2dd8:	000002d8 	udf	#728
    2ddc:	00000000 	udf	#0
    2de0:	00000005 	udf	#5
    2de4:	00000000 	udf	#0
    2de8:	000004a8 	udf	#1192
    2dec:	00000000 	udf	#0
    2df0:	00000006 	udf	#6
    2df4:	00000000 	udf	#0
    2df8:	000002f8 	udf	#760
    2dfc:	00000000 	udf	#0
    2e00:	0000000a 	udf	#10
    2e04:	00000000 	udf	#0
    2e08:	000000f8 	udf	#248
    2e0c:	00000000 	udf	#0
    2e10:	0000000b 	udf	#11
    2e14:	00000000 	udf	#0
    2e18:	00000018 	udf	#24
    2e1c:	00000000 	udf	#0
    2e20:	00000015 	udf	#21
	...
    2e30:	00000003 	udf	#3
    2e34:	00000000 	udf	#0
    2e38:	00002f50 	udf	#12112
    2e3c:	00000000 	udf	#0
    2e40:	00000002 	udf	#2
    2e44:	00000000 	udf	#0
    2e48:	00000120 	udf	#288
    2e4c:	00000000 	udf	#0
    2e50:	00000014 	udf	#20
    2e54:	00000000 	udf	#0
    2e58:	00000007 	udf	#7
    2e5c:	00000000 	udf	#0
    2e60:	00000017 	udf	#23
    2e64:	00000000 	udf	#0
    2e68:	000006f0 	udf	#1776
    2e6c:	00000000 	udf	#0
    2e70:	00000007 	udf	#7
    2e74:	00000000 	udf	#0
    2e78:	00000618 	udf	#1560
    2e7c:	00000000 	udf	#0
    2e80:	00000008 	udf	#8
    2e84:	00000000 	udf	#0
    2e88:	000000d8 	udf	#216
    2e8c:	00000000 	udf	#0
    2e90:	00000009 	udf	#9
    2e94:	00000000 	udf	#0
    2e98:	00000018 	udf	#24
    2e9c:	00000000 	udf	#0
    2ea0:	00000018 	udf	#24
	...
    2eb0:	6ffffffb 	.inst	0x6ffffffb ; undefined
    2eb4:	00000000 	udf	#0
    2eb8:	08000001 	stxrb	w0, w1, [x0]
    2ebc:	00000000 	udf	#0
    2ec0:	6ffffffe 	.inst	0x6ffffffe ; undefined
    2ec4:	00000000 	udf	#0
    2ec8:	000005c8 	udf	#1480
    2ecc:	00000000 	udf	#0
    2ed0:	6fffffff 	.inst	0x6fffffff ; undefined
    2ed4:	00000000 	udf	#0
    2ed8:	00000002 	udf	#2
    2edc:	00000000 	udf	#0
    2ee0:	6ffffff0 	.inst	0x6ffffff0 ; undefined
    2ee4:	00000000 	udf	#0
    2ee8:	000005a0 	udf	#1440
    2eec:	00000000 	udf	#0
    2ef0:	6ffffff9 	.inst	0x6ffffff9 ; undefined
    2ef4:	00000000 	udf	#0
    2ef8:	00000004 	udf	#4
	...

Disassembly of section .got:

0000000000002f50 <.got>:
	...
    2f68:	00000830 	udf	#2096
    2f6c:	00000000 	udf	#0
    2f70:	00000830 	udf	#2096
    2f74:	00000000 	udf	#0
    2f78:	00000830 	udf	#2096
    2f7c:	00000000 	udf	#0
    2f80:	00000830 	udf	#2096
    2f84:	00000000 	udf	#0
    2f88:	00000830 	udf	#2096
    2f8c:	00000000 	udf	#0
    2f90:	00000830 	udf	#2096
    2f94:	00000000 	udf	#0
    2f98:	00000830 	udf	#2096
    2f9c:	00000000 	udf	#0
    2fa0:	00000830 	udf	#2096
    2fa4:	00000000 	udf	#0
    2fa8:	00000830 	udf	#2096
    2fac:	00000000 	udf	#0
    2fb0:	00000830 	udf	#2096
    2fb4:	00000000 	udf	#0
    2fb8:	00000830 	udf	#2096
    2fbc:	00000000 	udf	#0
    2fc0:	00000830 	udf	#2096
    2fc4:	00000000 	udf	#0
    2fc8:	00002d40 	udf	#11584
	...
    2ff0:	00000a40 	udf	#2624
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

0000000000003018 <vector>:
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
