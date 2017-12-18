;D:	main
;D:	{
;D:	int
;R10:	<tipo> ::= int
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	z
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	function
;R2:	<declaraciones> ::= <declaracion>
segment .data
	msg_error_division db "error: divison by zero", 0
	msg_error_range db "error: index out of range", 0
segment .bss
	__esp resd 1
	_z resd 1
segment .text
	global main
	extern scan_int, print_int, scan_float, print_float, scan_boolean, print_boolean
	extern print_endofline, print_blank, print_string
	extern alfa_malloc, alfa_free, ld_float
;Rescritura1:	 <escritura1> ::= 
;D:	int
;R10:	<tipo> ::= int
;D:	doble
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	arg
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	int
;R10:	<tipo> ::= int
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	auxArg
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	printf
;R2:	<declaraciones> ::= <declaracion>
;R28:	<declaraciones_funcion> ::= <declaraciones>
_doble:
	push ebp
	mov ebp, esp
	sub esp, 4
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	auxArg
;D:	=
;D:	arg
;D:	;
	push dword [ebp + 8]
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov eax, dword [eax]
	mov dword [ebp - 4], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	return
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	*
;D:	arg
;D:	;
	push dword [ebp + 8]
;R80:	<exp> ::= <identificador>
	pop dword ebx
	pop dword eax
	mov ebx, dword [ebx]
	imul ebx
	push dword eax
;R75:	<exp> ::= <exp> * <exp>
;R61:	<retorno_funcion> ::= return <exp>
	mov esp, ebp
	pop ebp
	ret
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	3
	push dword  3 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	scanf
;R21:	<funciones> ::= 
;R:20	<funciones> ::= <funcion> <funciones>

main:
	mov dword [__esp], esp
;D:	z
	push dword _z
	call scan_int
	add esp, 4
;R54:	<lectura> ::= scanf <identificador>
;R35:	<sentencia_simple> ::= <lectura>
;D:	;
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	z
;D:	;
	push dword  _z 
;R80:	<exp> ::= <identificador>
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	doble
;D:	(
;D:	z
;D:	)
	push dword  _z 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;R92:	<resto_lista_expresiones> ::=
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _doble
	add esp, 4
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
	mov dword esp, [__esp]
	ret
gestion_error_div_cero:
	push dword msg_error_division
	call print_string
	add esp, 4
	call print_endofline
	mov dword esp, [__esp]
	ret
gestion_error_range:
	push dword msg_error_range
	call print_string
	add esp, 4
	call print_endofline
	mov dword esp, [__esp]
	ret
;R1:	<programa> ::= main { <declaraciones> <funciones> <sentencias> }
