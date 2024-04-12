# tutti gli oggetti sono in unità indivisibili ! (confezioni)

#	DATI
param n := 12;				# numero di oggetti
set N := 1..n;				# set degli oggetti
param volume {N};			# volume di ogni oggetto 		[l/confezione]
param valore {N};			# valore di ogni confezione 	[€/confezione]
param cap;

#	VARIABILI
var x {N} integer >= 0; # quantità scelte [confezioni]

#	VINCOLI
subject to capacity : # vincolo della capacità dello zaino
	sum {i in N} volume[i] * x[i] <= cap; 

#	OBIETTIVO
# massimizzare il valore totale [€]
maximize z : 
	sum {i in N} valore[i] * x[i];

data;

#param n := 12;
param cap := 300;

param : volume valore :=
1 41 16
2 39 19
3 45 19
4 28 12
5 56 22
6 58 29
7 37 18
8 63 26
9 49 22
10 33 14
11 42 19
12 52 25;

end;
