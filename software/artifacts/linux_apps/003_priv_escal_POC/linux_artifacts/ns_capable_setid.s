ffff800008096250 <ns_capable_setid>:
ffff800008096250:	d503233f 	paciasp
ffff800008096254:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffff800008096258:	7100a03f 	cmp	w1, #0x28
ffff80000809625c:	910003fd 	mov	x29, sp
ffff800008096260:	f9000bf3 	str	x19, [sp, #16]
ffff800008096264:	54000248 	b.hi	ffff8000080962ac <ns_capable_setid+0x5c>  // b.pmore
ffff800008096268:	2a0103e2 	mov	w2, w1
ffff80000809626c:	aa0003e1 	mov	x1, x0
ffff800008096270:	d5384113 	mrs	x19, sp_el0
ffff800008096274:	f9432a60 	ldr	x0, [x19, #1616]
ffff800008096278:	52800083 	mov	w3, #0x4                   	// #4
ffff80000809627c:	940ff89d 	bl	ffff8000084944f0 <security_capable>
ffff800008096280:	52800001 	mov	w1, #0x0                   	// #0
ffff800008096284:	350000a0 	cbnz	w0, ffff800008096298 <ns_capable_setid+0x48>
ffff800008096288:	b9402e60 	ldr	w0, [x19, #44]
ffff80000809628c:	52800021 	mov	w1, #0x1                   	// #1
ffff800008096290:	32180000 	orr	w0, w0, #0x100
ffff800008096294:	b9002e60 	str	w0, [x19, #44]
ffff800008096298:	2a0103e0 	mov	w0, w1
ffff80000809629c:	f9400bf3 	ldr	x19, [sp, #16]
ffff8000080962a0:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffff8000080962a4:	d50323bf 	autiasp
ffff8000080962a8:	d65f03c0 	ret
ffff8000080962ac:	d000af60 	adrp	x0, ffff800009684000 <kallsyms_token_index+0xe080>
ffff8000080962b0:	910cc000 	add	x0, x0, #0x330
ffff8000080962b4:	943c7ca3 	bl	ffff800008fb5540 <_printk>
ffff8000080962b8:	d4210000 	brk	#0x800
ffff8000080962bc:	d503201f 	nop

ffff8000080962c0 <cap_validate_magic>:
