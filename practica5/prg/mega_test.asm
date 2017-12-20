;D:	main
;D:	{
;D:	array
;D:	int
;R10:	<tipo> ::= int
;D:	[
;D:	5
	push dword  5 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;D:	]
;R15:	<clase_vector> ::= array <tipo> [ <constante_entera> ]
;R7:	<clase> ::= <clase_vector>
;D:	vector1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	,
;D:	vector2
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	,
;D:	vector3
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R19:	<identificadores> ::= <identificador> , <identificadores>
;R19:	<identificadores> ::= <identificador> , <identificadores>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	int
;R10:	<tipo> ::= int
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	i
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	,
;D:	x
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	,
;D:	y
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R19:	<identificadores> ::= <identificador> , <identificadores>
;R19:	<identificadores> ::= <identificador> , <identificadores>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	function
;R2:	<declaraciones> ::= <declaracion>
;R3:	<declaraciones> ::= <declaracion> <declaraciones>
segment .data
	msg_error_division db "****Error de ejecucion: Division por cero.", 0
	msg_error_range db "****Error de ejecucion: Indice fuera de rango.", 0
segment .bss
	__esp resd 1
	_i resd 1
	_x resd 1
	_y resd 1
	_vector1 resd 5
	_vector2 resd 5
	_vector3 resd 5
segment .text
	global main
	extern scan_int, print_int, scan_float, print_float, scan_boolean, print_boolean
	extern print_endofline, print_blank, print_string
	extern alfa_malloc, alfa_free, ld_float
;Rescritura1:	 <escritura1> ::= 
;D:	int
;R10:	<tipo> ::= int
;D:	exp
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	numero
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	exponente
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	if
;R29:	<declaraciones_funcion> ::= 
_exp:
	push ebp
	mov ebp, esp
	sub esp, 0
;D:	(
;D:	(
;D:	exponente
;D:	<
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	jl _menor_0
	push dword 0
	jmp _fin_menor_0
_menor_0:   push dword 1
_fin_menor_0:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_1
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
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
end_if_1:
;	<condicional> ::= <if_exp> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	exponente
;D:	==
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	je _igual_2
	push dword 0
	jmp _fin_igual_2
_igual_2:   push dword 1
_fin_igual_2:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_3
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
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
end_if_3:
;	<condicional> ::= <if_exp> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	exponente
;D:	==
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	je _igual_4
	push dword 0
	jmp _fin_igual_4
_igual_4:   push dword 1
_fin_igual_4:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_5
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	numero
;D:	;
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
;R61:	<retorno_funcion> ::= return <exp>
	pop eax
	push dword [eax]
	pop eax
	mov esp, ebp
	pop ebp
	ret
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	else
	jmp near end_else_5
end_if_5:
;R50:	<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>
;D:	{
;D:	return
;D:	numero
;D:	*
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	exp
;D:	(
;D:	numero
;D:	,
	lea eax, [ebp+12]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	exponente
;D:	-
	lea eax, [ebp+8]
	push dword eax
	pop eax
	push dword [eax]
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
	call _exp
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
	pop dword ebx
	pop dword eax
	mov eax, dword [eax]
	imul ebx
	push dword eax
;R75:	<exp> ::= <exp> * <exp>
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
end_else_5:
;	<condicional> ::= <if_exp_sentencias> else { <sentencias> } ;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	function
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	assert_equal
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	numero1
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	numero2
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	return
;R29:	<declaraciones_funcion> ::= 
_assert_equal:
	push ebp
	mov ebp, esp
	sub esp, 0
;D:	(
;D:	numero1
;D:	==
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	numero2
;D:	)
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	cmp eax, edx
	je _igual_6
	push dword 0
	jmp _fin_igual_6
_igual_6:   push dword 1
_fin_igual_6:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
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
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	function
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	assert_not_equal
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	numero1
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	numero2
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	return
;R29:	<declaraciones_funcion> ::= 
_assert_not_equal:
	push ebp
	mov ebp, esp
	sub esp, 0
;D:	!
;D:	(
;D:	(
;D:	numero1
;D:	<=
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	numero2
;D:	)
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	cmp eax, edx
	jg _no_menor_igual_7
	push dword 1
	jmp _fin_menor_igual_7
_no_menor_igual_7:   push dword 0
_fin_menor_igual_7:
;R95:	<comparacion> ::= <exp> <= <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	numero1
;D:	>=
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	numero2
;D:	)
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	cmp eax, edx
	jl _no_mayor_igual_8
	push dword 1
	jmp _fin_mayor_igual_8
_no_mayor_igual_8:   push dword 0
_fin_mayor_igual_8:
;R96:	<comparacion> ::= <exp> >= <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
	pop dword edx
	pop dword eax
	and eax, edx
	push dword eax
;R77:	<exp> ::= <exp> && <exp>
;R82:	<exp> ::= ( <exp> )
	pop eax
	cmp eax, 0
	je _uno_9
	push dword 0
	jmp _fin_negar_9
_uno_9:   push dword 1
_fin_negar_9:
;R79:	<exp> ::= ! <exp>
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
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	function
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	is_multiple_of_rec
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	num
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	multiple
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	iter
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	int
;R10:	<tipo> ::= int
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	m
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	m
;R2:	<declaraciones> ::= <declaracion>
;R28:	<declaraciones_funcion> ::= <declaraciones>
_is_multiple_of_rec:
	push ebp
	mov ebp, esp
	sub esp, 4
;D:	=
;D:	multiple
;D:	;
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov eax, dword [eax]
	mov dword [ebp - 4], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	if
;D:	(
;D:	(
;D:	iter
;D:	>=
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	num
;D:	)
	lea eax, [ebp+16]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	mov edx, dword [edx]
	cmp eax, edx
	jl _no_mayor_igual_10
	push dword 1
	jmp _fin_mayor_igual_10
_no_mayor_igual_10:   push dword 0
_fin_mayor_igual_10:
;R96:	<comparacion> ::= <exp> >= <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_11
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	false
	push dword  0 
;R103:	<constante_logica> ::= false
;R99:	<constante> ::= <constante_logica>
;R81:	<exp> ::= <constante>
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
;D:	else
	jmp near end_else_11
end_if_11:
;R50:	<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>
;D:	{
;D:	if
;D:	(
;D:	(
;D:	iter
;D:	*
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	m
;D:	==
	lea eax, [ebp-4]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword ebx
	pop dword eax
	mov eax, dword [eax]
	mov ebx, dword [ebx]
	imul ebx
	push dword eax
;R75:	<exp> ::= <exp> * <exp>
;D:	num
;D:	)
	lea eax, [ebp+16]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword edx
	pop dword eax
	mov edx, dword [edx]
	cmp eax, edx
	je _igual_12
	push dword 0
	jmp _fin_igual_12
_igual_12:   push dword 1
_fin_igual_12:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_13
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	true
	push dword  1 
;R102:	<constante_logica> ::= true
;R99:	<constante> ::= <constante_logica>
;R81:	<exp> ::= <constante>
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
;D:	else
	jmp near end_else_13
end_if_13:
;R50:	<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>
;D:	{
;D:	return
;D:	is_multiple_of_rec
;D:	(
;D:	num
;D:	,
	lea eax, [ebp+16]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	m
;D:	,
	lea eax, [ebp-4]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	iter
;D:	+
	lea eax, [ebp+8]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	add eax, edx
	push dword eax
;R72:	<exp> ::= <exp> + <exp>
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _is_multiple_of_rec
	add esp, 12
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
end_else_13:
;	<condicional> ::= <if_exp_sentencias> else { <sentencias> } ;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
end_else_11:
;	<condicional> ::= <if_exp_sentencias> else { <sentencias> } ;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	function
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	is_multiple_of
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	num
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	multiple
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	return
;R29:	<declaraciones_funcion> ::= 
_is_multiple_of:
	push ebp
	mov ebp, esp
	sub esp, 0
;D:	is_multiple_of_rec
;D:	(
;D:	num
;D:	,
	lea eax, [ebp+12]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	multiple
;D:	,
	lea eax, [ebp+8]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _is_multiple_of_rec
	add esp, 12
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
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	function
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	is_prime_rec
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	num
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	iter
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	if
;R29:	<declaraciones_funcion> ::= 
_is_prime_rec:
	push ebp
	mov ebp, esp
	sub esp, 0
;D:	(
;D:	(
;D:	num
;D:	<=
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	jg _no_menor_igual_14
	push dword 1
	jmp _fin_menor_igual_14
_no_menor_igual_14:   push dword 0
_fin_menor_igual_14:
;R95:	<comparacion> ::= <exp> <= <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_15
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	false
	push dword  0 
;R103:	<constante_logica> ::= false
;R99:	<constante> ::= <constante_logica>
;R81:	<exp> ::= <constante>
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
end_if_15:
;	<condicional> ::= <if_exp> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	iter
;D:	*
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
;D:	iter
;D:	>=
	lea eax, [ebp+8]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword ebx
	pop dword eax
	mov eax, dword [eax]
	mov ebx, dword [ebx]
	imul ebx
	push dword eax
;R75:	<exp> ::= <exp> * <exp>
;D:	num
;D:	)
	lea eax, [ebp+12]
	push dword eax
;R80:	<exp> ::= <identificador>
	pop dword edx
	pop dword eax
	mov edx, dword [edx]
	cmp eax, edx
	jl _no_mayor_igual_16
	push dword 1
	jmp _fin_mayor_igual_16
_no_mayor_igual_16:   push dword 0
_fin_mayor_igual_16:
;R96:	<comparacion> ::= <exp> >= <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_17
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	true
	push dword  1 
;R102:	<constante_logica> ::= true
;R99:	<constante> ::= <constante_logica>
;R81:	<exp> ::= <constante>
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
;D:	else
	jmp near end_else_17
end_if_17:
;R50:	<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>
;D:	{
;D:	if
;D:	(
;D:	(
;D:	is_multiple_of
;D:	(
;D:	num
;D:	,
	lea eax, [ebp+12]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	iter
;D:	)
	lea eax, [ebp+8]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _is_multiple_of
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	)
;R82:	<exp> ::= ( <exp> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_18
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	return
;D:	false
	push dword  0 
;R103:	<constante_logica> ::= false
;R99:	<constante> ::= <constante_logica>
;R81:	<exp> ::= <constante>
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
;D:	else
	jmp near end_else_18
end_if_18:
;R50:	<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>
;D:	{
;D:	return
;D:	is_prime_rec
;D:	(
;D:	num
;D:	,
	lea eax, [ebp+12]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	iter
;D:	+
	lea eax, [ebp+8]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	add eax, edx
	push dword eax
;R72:	<exp> ::= <exp> + <exp>
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _is_prime_rec
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
end_else_18:
;	<condicional> ::= <if_exp_sentencias> else { <sentencias> } ;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
end_else_17:
;	<condicional> ::= <if_exp_sentencias> else { <sentencias> } ;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	function
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	is_prime
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	num
;R:27	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::= 
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	return
;R29:	<declaraciones_funcion> ::= 
_is_prime:
	push ebp
	mov ebp, esp
	sub esp, 0
;D:	is_prime_rec
;D:	(
;D:	num
;D:	,
	lea eax, [ebp+8]
	push dword eax
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _is_prime_rec
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
;R22:	<funcion> ::= funcion <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion sentencias }
;D:	i
;R21:	<funciones> ::= 
;R:20	<funciones> ::= <funcion> <funciones>
;R:20	<funciones> ::= <funcion> <funciones>
;R:20	<funciones> ::= <funcion> <funciones>
;R:20	<funciones> ::= <funcion> <funciones>
;R:20	<funciones> ::= <funcion> <funciones>
;R:20	<funciones> ::= <funcion> <funciones>
;R:20	<funciones> ::= <funcion> <funciones>

main:
	mov dword [__esp], esp
;D:	=
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	while
;D:	(
start_while_19:
;D:	(
;D:	i
;D:	<
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	5
	push dword  5 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	jl _menor_20
	push dword 0
	jmp _fin_menor_20
_menor_20:   push dword 1
_fin_menor_20:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_while_19
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;D:	=
;D:	exp
;D:	(
;D:	i
;D:	,
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
;D:	3
	push dword  3 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	pop dword eax
	pop edx
	mov dword [edx], eax
;R43.2:	<asignacion> ::= <elemento_vector> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	vector3
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector3
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;D:	=
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop dword eax
	mov dword eax, [eax]
	pop edx
	mov dword [edx], eax
;R43.2:	<asignacion> ::= <elemento_vector> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	i
;D:	=
;D:	i
;D:	+
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	add eax, edx
	push dword eax
;R72:	<exp> ::= <exp> + <exp>
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
	jmp near start_while_19
end_while_19:
;R52:	<bucle> ::= while ( <exp> ) { <sentencias> }
;R41:	<bloque> ::= <bucle>
;R33:	<sentencia> ::= <bloque>
;D:	printf
;D:	1111
	push dword  1111 
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
;D:	i
;D:	=
;D:	4
	push dword  4 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	while
;D:	(
start_while_21:
;D:	(
;D:	i
;D:	>=
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	jl _no_mayor_igual_22
	push dword 1
	jmp _fin_mayor_igual_22
_no_mayor_igual_22:   push dword 0
_fin_mayor_igual_22:
;R96:	<comparacion> ::= <exp> >= <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_while_21
;D:	if
;D:	(
;D:	(
;D:	i
;D:	==
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	je _igual_23
	push dword 0
	jmp _fin_igual_23
_igual_23:   push dword 1
_fin_igual_23:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_if_24
;R50:	<if_exp> ::= if ( <exp> ) { 
;D:	vector2
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector2
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;D:	=
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword eax
	pop edx
	mov dword [edx], eax
;R43.2:	<asignacion> ::= <elemento_vector> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	else
	jmp near end_else_24
end_if_24:
;R50:	<if_exp_sentencias> ::= <if_exp_sentencias> <sentencias>
;D:	{
;D:	vector2
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector2
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;D:	=
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	/
;D:	i
;D:	;
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword ebx
	pop dword eax
	mov eax, [eax]
	cdq
	cmp dword [ebx], 0
	je gestion_error_div_cero
	idiv dword [ebx]
	push dword eax
;R74:	<exp> ::= <exp> / <exp>
	pop dword eax
	pop edx
	mov dword [edx], eax
;R43.2:	<asignacion> ::= <elemento_vector> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
end_else_24:
;	<condicional> ::= <if_exp_sentencias> else { <sentencias> } ;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	i
;D:	=
;D:	i
;D:	-
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	sub eax, edx
	push dword eax
;R73:	<exp> ::= <exp> - <exp>
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
	jmp near start_while_21
end_while_21:
;R52:	<bucle> ::= while ( <exp> ) { <sentencias> }
;R41:	<bloque> ::= <bucle>
;R33:	<sentencia> ::= <bloque>
;D:	printf
;D:	2222
	push dword  2222 
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
;D:	i
;D:	=
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	while
;D:	(
start_while_25:
;D:	(
;D:	i
;D:	<
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	5
	push dword  5 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	jl _menor_26
	push dword 0
	jmp _fin_menor_26
_menor_26:   push dword 1
_fin_menor_26:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_while_25
;D:	printf
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	vector2
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector2
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	assert_equal
;D:	(
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	,
;D:	vector2
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector2
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _assert_equal
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	call print_boolean
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	vector3
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector3
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	assert_equal
;D:	(
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	,
;D:	vector3
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector3
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _assert_equal
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	call print_boolean
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	i
;D:	=
;D:	i
;D:	+
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	add eax, edx
	push dword eax
;R72:	<exp> ::= <exp> + <exp>
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
	jmp near start_while_25
end_while_25:
;R52:	<bucle> ::= while ( <exp> ) { <sentencias> }
;R41:	<bloque> ::= <bucle>
;R33:	<sentencia> ::= <bloque>
;D:	printf
;D:	9999
	push dword  9999 
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
;D:	i
;D:	=
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	while
;D:	(
start_while_27:
;D:	(
;D:	i
;D:	<
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	5
	push dword  5 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	jl _menor_28
	push dword 0
	jmp _fin_menor_28
_menor_28:   push dword 1
_fin_menor_28:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_while_27
;D:	printf
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	vector2
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector2
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	assert_not_equal
;D:	(
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	,
;D:	vector2
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector2
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _assert_not_equal
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	call print_boolean
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	vector3
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector3
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	assert_not_equal
;D:	(
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	,
;D:	vector3
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector3
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _assert_not_equal
	add esp, 8
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	call print_boolean
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	i
;D:	=
;D:	i
;D:	+
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	add eax, edx
	push dword eax
;R72:	<exp> ::= <exp> + <exp>
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
	jmp near start_while_27
end_while_27:
;R52:	<bucle> ::= while ( <exp> ) { <sentencias> }
;R41:	<bloque> ::= <bucle>
;R33:	<sentencia> ::= <bloque>
;D:	printf
;D:	99999
	push dword  99999 
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	3
	push dword  3 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	4
	push dword  4 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	5
	push dword  5 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	6
	push dword  6 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	7
	push dword  7 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	8
	push dword  8 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	9
	push dword  9 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	10
	push dword  10 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	i
;D:	=
;D:	0
	push dword  0 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	while
;D:	(
start_while_29:
;D:	(
;D:	i
;D:	<
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	4
	push dword  4 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	cmp eax, edx
	jl _menor_30
	push dword 0
	jmp _fin_menor_30
_menor_30:   push dword 1
_fin_menor_30:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
;D:	{
	pop eax
	cmp eax, 0
	je near end_while_29
;D:	printf
;D:	11111
	push dword  11111 
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
;D:	printf
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
;R80:	<exp> ::= <identificador>
	pop dword eax
	mov dword eax, [eax]
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;R85:	<exp> ::= <elemento_vector>
;D:	;
	pop eax
	push dword [eax]
	call print_int
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	exp
;D:	(
;D:	2
	push dword  2 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	vector1
;D:	[
;D:	i
;D:	]
	push dword  _i 
	pop eax
	push dword [eax]
;R80:	<exp> ::= <identificador>
	pop dword eax
	cmp eax, 0
	jl near gestion_error_range
	cmp eax, 4
	jg near gestion_error_range
	mov dword edx, _vector1
	lea eax, [edx + eax*4]
	push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
	pop eax
	push dword [eax]
;R85:	<exp> ::= <elemento_vector>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R91:	<resto_lista_expresiones> ::= ,<exp> <resto_lista_expresiones>
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _exp
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
;D:	i
;D:	=
;D:	i
;D:	+
	push dword  _i 
;R80:	<exp> ::= <identificador>
;D:	1
	push dword  1 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
	pop dword edx
	pop dword eax
	mov eax, dword [eax]
	add eax, edx
	push dword eax
;R72:	<exp> ::= <exp> + <exp>
	pop dword eax
	mov dword [_i], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
	jmp near start_while_29
end_while_29:
;R52:	<bucle> ::= while ( <exp> ) { <sentencias> }
;R41:	<bloque> ::= <bucle>
;R33:	<sentencia> ::= <bloque>
;D:	printf
;D:	33333
	push dword  33333 
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
;D:	printf
;D:	is_prime
;D:	(
;D:	100
	push dword  100 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _is_prime
	add esp, 4
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	call print_boolean
	add esp, 4
	call print_endofline
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	is_prime
;D:	(
;D:	113
	push dword  113 
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::=
;R89:	<lista_expresiones> ::= <exp> <resto_lista_expresiones>
	call _is_prime
	add esp, 4
	push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> )
;D:	;
	call print_boolean
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
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
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
