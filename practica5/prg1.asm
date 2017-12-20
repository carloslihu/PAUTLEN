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
;D:	int
;R10:	<tipo> ::= int
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	x
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	function
;R2:	<declaraciones> ::= <declaracion>
;R3:	<declaraciones> ::= <declaracion> <declaraciones>
segment .data
	msg_error_division db "error: divison by zero", 0
	msg_error_range db "error: index out of range", 0
segment .bss
	__esp resd 1
	_x resd 1
	_z resd 1
segment .text
	global main
	extern scan_int, print_int, scan_float, print_float, scan_boolean, print_boolean
	extern print_endofline, print_blank, print_string
	extern alfa_malloc, alfa_free, ld_float
;Rescritura1:	 <escritura1> ::= 
;D:	int
;R10:	<tipo> ::= int
;D:	ack
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	m
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	n
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	if
;R29:	<declaraciones_funcion> ::= 
_ack:
	push ebp
	mov ebp, esp
	sub esp, 0
;D:	(
;D:	(
;D:	m
;D:	==
	push dword [ebp + 12]
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	cmp eax, edx
	je _igual_0
	push dword 0
	jmp _fin_igual_0
_igual_0:   push dword 1
_fin_igual_0:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_1
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	n
;D:	+
	push dword [ebp + 8]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword edx
	pop dword eax
	add eax, edx
	push dword eax
;R72:	<exp> ::= <exp> + <exp>
;R61:	<retorno_funcion> ::= return <exp>
	pop eax
	mov esp, ebp
	pop ebp
	ret
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	if
end_if_1:
;	<condicional> ::= <if_exp> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	m
;D:	>
	push dword [ebp + 12]
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	cmp eax, edx
	jg _mayor_2
	push dword 0
	jmp _fin_mayor_2
_mayor_2:   push dword 1
_fin_mayor_2:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	n
;D:	==
	push dword [ebp + 8]
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	cmp eax, edx
	je _igual_3
	push dword 0
	jmp _fin_igual_3
_igual_3:   push dword 1
_fin_igual_3:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
	pop dword edx
	pop dword eax
	and eax, edx
	push dword eax
;R77:	<exp> ::= <exp> && <exp>
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_4
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	ack
;D:	(
;D:	m
;D:	-
	push dword [ebp + 12]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
	pop dword edx
	pop dword eax
	sub eax, edx
	push dword eax
;R73:	<exp> ::= <exp> - <exp>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _ack
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
;R61:	<retorno_funcion> ::= return <exp>
	pop eax
	mov esp, ebp
	pop ebp
	ret
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	if
end_if_4:
;	<condicional> ::= <if_exp> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	m
;D:	>
	push dword [ebp + 12]
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	cmp eax, edx
	jg _mayor_5
	push dword 0
	jmp _fin_mayor_5
_mayor_5:   push dword 1
_fin_mayor_5:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	n
;D:	>
	push dword [ebp + 8]
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	cmp eax, edx
	jg _mayor_6
	push dword 0
	jmp _fin_mayor_6
_mayor_6:   push dword 1
_fin_mayor_6:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
	pop dword edx
	pop dword eax
	and eax, edx
	push dword eax
;R77:	<exp> ::= <exp> && <exp>
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_7
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	ack
;D:	(
;D:	m
;D:	-
	push dword [ebp + 12]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
	pop dword edx
	pop dword eax
	sub eax, edx
	push dword eax
;R73:	<exp> ::= <exp> - <exp>
;D:	ack
;D:	(
;D:	m
;D:	,
	push dword [ebp + 12]
;R80:	<exp> ::= <identificador>
;D:	n
;D:	-
	push dword [ebp + 8]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	sub eax, edx
	push dword eax
;R73:	<exp> ::= <exp> - <exp>
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _ack
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _ack
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
;R61:	<retorno_funcion> ::= return <exp>
	pop eax
	mov esp, ebp
	pop ebp
	ret
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	}
end_if_7:
;	<condicional> ::= <if_exp> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;R30:	<sentencias> ::= <sentencia>
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
;D:	scanf
;D:	x
	push dword _x
	call scan_int
	add esp, 4
;R54:	<lectura> ::= scanf <identificador>
;R35:	<sentencia_simple> ::= <lectura>
;D:	;
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	ack
;D:	(
;D:	z
;D:	,
	push dword  _z 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	x
;D:	)
	push dword  _x 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _ack
	add esp, 8
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