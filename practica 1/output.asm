segment .data
	msg_error_division db "error: divison by zero", 0
	_suma db "probando todos los casos de suma", 0
	_resta db "probando todos los casos de suma", 0
	_cambiarSigno db "probando todos los casos de cambiar signo", 0
	_no db "probando todos los casos de no", 0
	_multiplicar db "probando todos los casos de multiplicar", 0
	_dividir db "probando todos los casos de dividir", 0
	_or db "probando todos los casos de or", 0
	_and db "probando todos los casos de and", 0
segment .bss
	__esp resd 1
	_x resd 1
	_y resd 1
	_z resd 1
segment .text
	global main
	extern scan_int, print_int, scan_float, print_float, scan_boolean, print_boolean
	extern print_endofline, print_blank, print_string
	extern alfa_malloc, alfa_free, ld_float

main:
	mov dword [__esp], esp
	push dword  6 
	pop dword eax
	mov dword [_x], eax
	push dword _y
	call scan_int
	add esp, 4
	push dword  _y 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  _x 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	push dword  _x 
	push dword  _x 
	push dword  _y 
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	add eax, edx
	push dword eax
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	add eax, edx
	push dword eax
	pop dword edx
	pop dword eax
	add eax, edx
	push dword eax
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	push dword  _x 
	pop dword edx
	pop dword eax
	mov edx, dword [edx]
	add eax, edx
	push dword eax
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	push dword  _x 
	push dword  _x 
	push dword  _y 
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	sub edx, eax
	push dword edx
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	sub edx, eax
	push dword edx
	pop dword edx
	pop dword eax
	sub edx, eax
	push dword edx
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	push dword  _x 
	pop dword edx
	pop dword eax
	mov edx, dword [edx]
	sub edx, eax
	push dword edx
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	pop dword eax
	neg eax
	push dword eax
	call print_int
	add esp, 4
	call print_endofline
	push dword  _z 
	pop dword eax
	mov eax, [eax]
	neg eax
	push dword eax
	call print_int
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	pop eax
	cmp eax, 0
	je _uno_0
	push dword 0
	jmp _fin_negar_0
_uno_0:   push dword 1
_fin_negar_0:
	call print_int
	add esp, 4
	call print_endofline
	push dword  0 
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	pop eax
	cmp dword [eax], 0
	je _uno_1
	push dword 0
	jmp _fin_negar_1
_uno_1:   push dword 1
_fin_negar_1:
	call print_int
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  2 
	push dword  _x 
	push dword  _x 
	push dword  _y 
	pop dword ebx
	pop dword eax
	mov eax, dword [eax]
	mov ebx, dword [ebx]
	imul ebx
	push dword eax
	pop dword ebx
	pop dword eax
	mov eax, dword [eax]
	imul ebx
	push dword eax
	pop dword ebx
	pop dword eax
	imul ebx
	push dword eax
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  2 
	push dword  _x 
	pop dword ebx
	pop dword eax
	mov ebx, dword [ebx]
	imul ebx
	push dword eax
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  3 
	pop dword eax
	mov dword [_y], eax
	push dword  6 
	pop dword eax
	mov dword [_x], eax
	push dword  2 
	push dword  _y 
	push dword  _x 
	pop dword eax
	pop dword ebx
	mov eax, [eax]
	cdq
	cmp dword [ebx], 0
	je gestion_error_div_cero
	idiv dword [ebx]
	push dword eax
	call print_int
	add esp, 4
	call print_endofline
	push dword  2 
	pop dword eax
	pop dword ebx
	cdq
	cmp ebx, 0
	je gestion_error_div_cero
	idiv ebx
	push dword eax
	call print_int
	add esp, 4
	call print_endofline
	push dword  3 
	push dword  _x 
	pop dword eax
	pop dword ebx
	mov eax, [eax]
	cdq
	cmp ebx, 0
	je gestion_error_div_cero
	idiv ebx
	push dword eax
	call print_int
	add esp, 4
	call print_endofline
	push dword  _x 
	push dword  12 
	pop dword eax
	pop dword ebx
	cdq
	cmp dword [ebx], 0
	je gestion_error_div_cero
	idiv dword [ebx]
	push dword eax
	call print_int
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	push dword  0 
	pop dword edx
	pop dword eax
	or eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	push dword  0 
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	push dword  1 
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	or eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	push dword  0 
	push dword  _z 
	pop dword edx
	pop dword eax
	mov edx, dword [edx]
	or eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	push dword  0 
	pop dword eax
	mov dword [_x], eax
	push dword  _x 
	push dword  _z 
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	or eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	push dword  1000001 
	call print_int
	add esp, 4
	call print_endofline
	push dword  1 
	push dword  1 
	pop dword edx
	pop dword eax
	and eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	push dword  0 
	pop dword eax
	mov dword [_z], eax
	push dword  _z 
	push dword  1 
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	and eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	push dword  0 
	push dword  _z 
	pop dword edx
	pop dword eax
	mov edx, dword [edx]
	and eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	push dword  1 
	pop dword eax
	mov dword [_x], eax
	push dword  1 
	pop dword eax
	mov dword [_z], eax
	push dword  _x 
	push dword  _z 
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	and eax, edx
	push dword eax
	call print_boolean
	add esp, 4
	call print_endofline
	mov dword esp, [__esp]
	ret
gestion_error_div_cero:
	push dword msg_error_division
	call print_string
	add esp, 4
	call print_endofline
	ret
