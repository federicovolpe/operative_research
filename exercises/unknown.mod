reset;

#	DATI
param nc := 7;
set N := 1..7;

# costo di ciascun percorso punto punto tranne x - x
param C {i in N, j in N : i <> j}; 
 
set SS := 0..2^(nc) -1; # insieme di tutti i sottoinsiemi

# insieme caratteristico 1 quando il nodo fa parte del sottoinsieme 0 altrimenti
set S {k in SS} := {i in N: (k div 2^i) mod 2 = 1} ; 

# k div 2^i  è dispari (codifica tramite bit)

#	VARIABILI
var x {i in N, j in N : i <> j} binary;

#	VINCOLI
# vincoli sui gradi di uscita e entrata
subject to entrante {j in N}:
	sum {i in N : i <> j} x[i, j] = 1;

subject to uscente {i in N}:
	sum {j in N : i <> j} x[i, j] = 1;

# subtour elimination constraint
subject to  sec {k in SS diff {0,2^nc -1}}: # l'insieme ss meno l'insieme....
	sum {i in S[k], j in S[k]: i <> j} x[i, j] <= card(S[k]) - 1; 
	#120+ vincoli per ogni insieme (archi i-j tali che fanno parte dell'insieme k-esimo)

#riscrittura
subject to  sec2 {k in SS diff {0,2^nc -1}}:
	sum {i in S[k], j in N diff S[k]} x[i, j] >= 1;


#	OBIETTIVO
minimize percorso: 
	sum {i in N , j in N: i <> j} 
	C[i,j] * x[i,j];

data;

param C :	
		1	2	3	4	5	6	7 :=
1		.	2	1	1	1	1	1
2		2	.	3	1	1	1	1		
3		1	3	.	4	1	1	1
4		1	1	4	.	5	1	1
5		1	1	1	5	.	6	7
6		1	1	1	1	7	.	8
7		1	1	1	1	1	7	.		
;

end;
