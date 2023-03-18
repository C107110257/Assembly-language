TITLE Add and Subtract, Version 2            (AddSub2.asm)
; This program adds and subtracts 32-bit unsigned
; integers and stores the sum in a variable.
INCLUDE Irvine32.inc

.data
	d_array DWORD 30, 125, 59, 20, 6, 5, 1, 2, 15
	d_size DWORD  LENGTHOF d_array
	commend DB '(The output value is hexadecimal !)'
.code

Rank PROC
	mov esi, OFFSET d_array
	mov ecx, d_size
	DEC ecx
	L1:
		mov edi, esi
		push ecx
		L2:
			push ecx
			add edi, 04h
			mov eax, [esi]
			mov ebx, [edi]
			cmp eax, ebx
			jbe outL2
			mov [edi], eax
			mov [esi], ebx
			outL2:
			pop ecx
			loop L2
		add esi, 04h
		pop ecx
		loop L1
	ret
Rank ENDP

main PROC
	call Rank
	mov esi, OFFSET d_array
	mov ebx, TYPE d_array
	mov ecx, LENGTHOF d_array
	call DumpMem
	mov edx, OFFSET commend
	call WriteString
	exit
main ENDP

END main
