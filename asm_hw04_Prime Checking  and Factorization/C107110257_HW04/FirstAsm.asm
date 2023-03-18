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
	.IF (primeArray+0 < 2) || (primeArray+1 != 0)	;0,1���O��ơAmyValu+1����00h
		mov eax, 0										;���O���
	.ELSEIF primeArray+1 == 0						;�p�G +0 ��myValue�A +1����00h
		mov eax, 1										;�O���
	.ENDIF
	ret
IsPrime	ENDP
;-------------------------------------------------------------------------Factorization
Factorization PROC
	mov esi, offset primeArray			;����primearray
	.IF (eax < 2)
		mov	[esi], al
		ret
	.ENDIF
	mov ebx, 2
	while1:
		mov temp, eax						;�s�n���Ѫ���
		cdq
		div ebx
		.IF (eax == 1) && (edx == 0)		;���J����ƩάO�̫�@�Ӧ]��
			mov [esi], bl
			ret
		.ELSEIF (eax != 1) && (edx == 0)	;���G�O�]�ơA���i���٥i�H����
			mov [esi], bl
			INC esi							;��U�Ӧ�m
		.ELSE
			mov eax, temp					;�^�_�n���Ѫ���
			INC ebx							;���O�]�ơA���W�վ�
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
