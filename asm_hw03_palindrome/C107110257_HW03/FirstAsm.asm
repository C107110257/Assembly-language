TITLE Add and Subtract, Version 2            (AddSub2.asm)
; This program adds and subtracts 32-bit unsigned
; integers and stores the sum in a variable.
INCLUDE Irvine32.inc

.data
	input_str byte "C107110257_gg_752011701C"
	StringSize=($ - input_str)
	jtimes=($ - input_str+1)/2
	answer_yes DB "Yes", 0
	answer_no DB "No", 0
	
.code
main	PROC

	mov ecx, jtimes
	mov esi, StringSize
	mov edi, 00h
	sub esi, 01h
	Looper:
		
		mov al,[input_str + esi]
		mov bl,[input_str + edi]

		sub al,bl
		JNZ OHNO

		sub esi,01h
		add edi,01h

		loop Looper

	mov  edx,OFFSET answer_yes
	call WriteString
	exit

	OHNO:
		mov  edx,OFFSET answer_no
		call WriteString
		exit

main	ENDP
END main
