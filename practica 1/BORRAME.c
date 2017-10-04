	int x;
	int y;
	int z;
	
	x = 6;

	scanf("%d",y);
	printf("probando todos los casos de suma\n");
	z = y + x + x + 1;
	printf("%d\n",z);
	z = x + 1;
	printf("%d\n",z);

	printf("\nprobando todos los casos de resta\n");
	z = y - x - x - 1
	printf("%d\n",z);
	z = x - 1;
	printf("%d\n",z);

	printf("\nprobando todos los casos de cambiar signo\n");
	printf("%d\n",-1);
	printf("%d\n",-z);

	printf("\nprobando todos los casos de no\n");
	printf("%d\n",!1);
	z = 0;
	printf("%d\n",!z);

	printf("\nprobando todos los casos de multiplicar\n");
	z = 2*x*x*y;
	printf("%d\n",z);
	z = x*2;
	printf("%d\n",z);

	printf("\nprobando todos los casos de dividir\n");
	y=3;
	z = 10/x/y;
	printf("%d\n",z);
	z = x/3;
	printf("%d\n",z);
	z = 12/x;
	printf("%d\n",z);

	printf("\nprobando todos los casos de or\n");
	z = 1 || 0
	printf("%d\n",z);
	z = z || 0;
	printf("%d\n",z);
	x = 0;
	z = 0 || x;
	printf("%d\n",z);
	z = z || x
	printf("%d\n",z);

	printf("\nprobando todos los casos de and\n");
	z = 1 && 0
	printf("%d\n",z);
	z = z && 0;
	printf("%d\n",z);
	x = 0;
	z = 0 && x;
	printf("%d\n",z);
	z = z && x
	printf("%d\n",z);