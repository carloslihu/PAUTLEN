#!/bin/bash
F=ficheros_profe
make

make asm prg=$F/aritmeticas1
make asm prg=$F/aritmeticas2
make asm prg=$F/comparaciones
make asm prg=$F/funciones1
make asm prg=$F/funciones2
make asm prg=$F/funciones3
make asm prg=$F/funciones4
make asm prg=$F/if1
make asm prg=$F/if2
make asm prg=$F/if3
make asm prg=$F/logicas1
make asm prg=$F/logicas2
make asm prg=$F/vectores1
make asm prg=$F/vectores2
make asm prg=$F/vectores3
make asm prg=$F/vectores4
make asm prg=$F/while




#./$F/aritmeticas2 < $F/aritmeticas2_1.input > $F/miaritmeticas2_1.output

##./$F/aritmeticas1 < $F/aritmeticas1_1.input > $F/miaritmeticas1_1.output
#./$F/aritmeticas1 < $F/aritmeticas1_2.input > $F/miaritmeticas1_2.output
#./$F/aritmeticas1 < $F/aritmeticas1_3.input > $F/miaritmeticas1_3.output
#
#diff -bB $F/aritmeticas1_1.output $F/miaritmeticas1_1.output
#diff -bB $F/aritmeticas1_2.output $F/miaritmeticas1_2.output
#diff -bB $F/aritmeticas1_3.output $F/miaritmeticas1_3.output