TITLE Add and Subtract, Version 2            (AddSub2.asm)
; This program adds and subtracts 32-bit unsigned
; integers and stores the sum in a variable.
INCLUDE Irvine32.inc

.data
	d_array DWORD 888h,9,5,2,7,4,3,1,6,8,0,10h,40h,24h,11h,65h,12h,777h
	d_size DWORD LENGTHOF d_array
	pivot DWORD ?
.code

quick_sort PROC
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]		;esi l_index ¤£°Êesi,edi
	mov ebx, [ebp+12]		;edi h_index 
	cmp eax, ebx
	jge out_q
		mov edx, [d_array+4*eax]
		.while eax<ebx
			.while ([d_array+4*eax]<=edx) && eax<edi
				inc eax
			.endw
			.while ([d_array+4*ebx]>edx)
				dec ebx
			.endw
			.if eax<ebx
				push [d_array+4*eax]		;swap(a[i],a[j])
				push [d_array+4*ebx]
				pop [d_array+4*eax]
				pop [d_array+4*ebx]
			.endif
		.endw
		push edx				; number[pivot]
		push [d_array+4*ebx]	; number[j]
		pop [d_array+4*esi]		; number[pivot]
		pop [d_array+4*ebx]		; number[j]

		push ebx	;j 
		push edi	;h_index

		dec ebx				
		mov edi, ebx
		push edi			;j-1
		push esi			;l_index
		call quick_sort 	;quicksort(number,l_index,j-1)


		pop edi		;h_index
		pop esi		;j
		inc esi		

		
		push edi			;h_index
		push esi			;j+1
		call quick_sort		;quicksort(number,j+1,h_index)

	out_q:
		pop ebp
		ret 8
quick_sort ENDP

main	PROC
	mov esi, 0
	mov edi, d_size
	DEC edi
	push edi
	push esi
	call quick_sort 

	mov esi, OFFSET d_array
	mov ebx, TYPE d_array
	mov ecx, LENGTHOF d_array
	call DumpMem

	exit
main	ENDP

END main
