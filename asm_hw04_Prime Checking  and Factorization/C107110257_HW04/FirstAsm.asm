TITLE Add and Subtract, Version 2            (AddSub2.asm)
; This program adds and subtracts 32-bit unsigned
; integers and stores the sum in a variable.
INCLUDE Irvine32.inc

.data
	myValue DWORD 28
	primeArray DB 50 DUP(0)
	temp DWORD ?
	commend DB '(The output value is hexadecimal !)'
.code
;-------------------------------------------------------------------------IsPrime
IsPrime	PROC
	.IF (primeArray+0 < 2) || (primeArray+1 != 0)	;0,1不是質數，myValu+1不為00h
		mov eax, 0										;不是質數
	.ELSEIF primeArray+1 == 0						;如果 +0 為myValue， +1必為00h
		mov eax, 1										;是質數
	.ENDIF
	ret
IsPrime	ENDP
;-------------------------------------------------------------------------Factorization
Factorization PROC
	mov esi, offset primeArray			;指到primearray
	.IF (eax < 2)
		mov	[esi], al
		ret
	.ENDIF
	mov ebx, 2
	while1:
		mov temp, eax						;存要分解的數
		cdq
		div ebx
		.IF (eax == 1) && (edx == 0)		;當輸入為質數或是最後一個因數
			mov [esi], bl
			ret
		.ELSEIF (eax != 1) && (edx == 0)	;結果是因數，但可能還可以分解
			mov [esi], bl
			INC esi							;到下個位置
		.ELSE
			mov eax, temp					;回復要分解的數
			INC ebx							;不是因數，往上調整
		.ENDIF
	jmp while1
Factorization ENDP
;-------------------------------------------------------------------------main
main	PROC
	
	mov eax, myValue
	call	Factorization
	call IsPrime
	mov esi,OFFSET PrimeArray
	mov ecx,LENGTHOF PrimeArray
	mov ebx,TYPE PrimeArray
	call DumpMem
	mov edx, OFFSET commend
	call WriteString
	call DumpRegs
	exit					  
main	ENDP

END main
