.include "m128def.inc"

.def carry = r15
.def innerCount = r16
.def outerCount = r17
.def I = r18
.def J = r19
.equ srcA = 0x100
.equ srcB = 0x104
.equ ptrA = 0x108
.equ ptrB = 0x109
.equ dest = 0x10a

mul24:
	push	carry
	push	innerCount
	push	outerCount
	push	I
	push	J
	push	XL
	push	XH
	push	YL
	push	YH
	push	ZL
	push	ZH
	clr 	carry
	ldi 	outerCount, 3
	clc

	ldi 	YL,	low(srcB)
	ldi 	YH,	high(srcB)
	ldi 	ZL,	low(dest)
	ldi 	ZH,	high(dest)

	outer:
		ldi 	XL,	low(srcA)
		ldi 	XH,	high(srcA)
		ld  	I, X+
		ldi 	innerCount, 3

	inner:
		ld  	J,	Y+
		mul 	I,	J
		adc 	r0,	carry
		mov 	carry,	r1
		st  	Z+,	r0
		dec 	innerCount
		brne	inner
		
		dec 	outerCount
		brne	outer


	pop 	ZH
	pop 	ZL
	pop 	YH
	pop 	YL
	pop 	XH
	pop 	XL
	pop 	J
	pop 	I
	pop 	outerCount
	pop 	innerCount
	pop 	carry
