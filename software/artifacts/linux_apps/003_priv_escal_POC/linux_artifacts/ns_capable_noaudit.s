ffff8000080961e0 <ns_capable_noaudit>:
ffff8000080961e0:	d503233f 	paciasp
ffff8000080961e4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffff8000080961e8:	7100a03f 	cmp	w1, #0x28
ffff8000080961ec:	910003fd 	mov	x29, sp
ffff8000080961f0:	f9000bf3 	str	x19, [sp, #16]
ffff8000080961f4:	54000248 	b.hi	ffff80000809623c <ns_capable_noaudit+0x5c>  // b.pmore
ffff8000080961f8:	2a0103e2 	mov	w2, w1
ffff8000080961fc:	aa0003e1 	mov	x1, x0
ffff800008096200:	d5384113 	mrs	x19, sp_el0
ffff800008096204:	f9432a60 	ldr	x0, [x19, #1616]
ffff800008096208:	52800043 	mov	w3, #0x2                   	// #2
ffff80000809620c:	940ff8b9 	bl	ffff8000084944f0 <security_capable>
ffff800008096210:	52800001 	mov	w1, #0x0                   	// #0
ffff800008096214:	350000a0 	cbnz	w0, ffff800008096228 <ns_capable_noaudit+0x48>
ffff800008096218:	b9402e60 	ldr	w0, [x19, #44]
ffff80000809621c:	52800021 	mov	w1, #0x1                   	// #1
ffff800008096220:	32180000 	orr	w0, w0, #0x100
ffff800008096224:	b9002e60 	str	w0, [x19, #44]
ffff800008096228:	2a0103e0 	mov	w0, w1
ffff80000809622c:	f9400bf3 	ldr	x19, [sp, #16]
ffff800008096230:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffff800008096234:	d50323bf 	autiasp
ffff800008096238:	d65f03c0 	ret
ffff80000809623c:	d000af60 	adrp	x0, ffff800009684000 <kallsyms_token_index+0xe080>
ffff800008096240:	910cc000 	add	x0, x0, #0x330
ffff800008096244:	943c7cbf 	bl	ffff800008fb5540 <_printk>
ffff800008096248:	d4210000 	brk	#0x800
ffff80000809624c:	d503201f 	nop

ffff800008096250 <ns_capable_setid>:
