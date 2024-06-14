# esercizio dimostrazione per il calcolo di un percorso ottimale

#	DATI
param nv := 7;		# numero di vertici del grafo
set V := 1..7;		# set dei vertici del grafo

# costo di ciascun percorso punto punto tranne x - x
param costi {v1 in V, v2 in V : v1 <> v2}; # a tutti gli effetti la matrice dei costi
 
# set di tutti i possibili sottoinsiemi di vertici, vengono indicati con il codice binario
# es : 0000001 : insieme con solo il nodo 1; 1000001 : insieme con il nodo 8 e il nodo 1
set SS := 0..2^(nv) -1; 

# insieme caratteristico 1 quando il nodo fa parte del sottoinsieme 0 altrimenti
# selezione del percorso (ovvero degli archi)
# es : posto un numero di vertici pari a 3
# SS = 0 1 2 3 4 5 6 7 , k = 3 ovvero 011, si selezionano tutti quei numeri che hanno 1 in posizione 1 e 2
# S = 1 2 perchè sono posti a 1 i bit 1 e 2 di k
set S {k in SS} := {v1 in V: (k div 2^v1) mod 2 = 1} ; 

#	VARIABILI
# per ogni coppia di nodi se quel tragitto è abilitato o meno
var scelta {v1 in V, v2 in V : v1 <> v2} binary;

#	VINCOLI
# vincoli sui gradi di uscita e entrata
# per ogni nodo che arriva al v1 deve esserne scelto uno
subject to entrante {v1 in V}: 
	sum {v2 in V : v2 <> v1} scelta[v2, v1] = 1;
subject to uscente {v1 in V}:
	sum {v2 in V : v1 <> v2} scelta[v1, v2] = 1;

# subtour elimination constraint
# Per ogni sottoinsieme k (esclusi l'insieme vuoto e l'insieme completo), 
# il numero di archi all'interno del sottoinsieme non può essere pari al numero di vertici del sottoinsieme
# subject to  sec {k in SS diff {0,2^nv -1}}:
#	sum {s1 in S[k], s2 in S[k]: s1 <> s2} scelta[s1, s2] <= card(S[k]) - 1; 

#riscrittura
subject to  sec2 {k in SS diff {0,2^nv -1}}:
	sum {s in S[k], v in V diff S[k]} scelta[s, v] >= 1;


#	OBIETTIVO
# minimizza il costo totale del percorso
minimize percorso: 
	sum {v1 in V , v2 in V: v1 <> v2} 
	costi[v1,v2] * scelta[v1,v2];

data;

# righe : vertici di partenza
# colonne : vertici di arrivo
param costi :1	2	3	4	5	6	7 :=
1			.	2	8	1	1	3	1
2			2	.	3	1	4	1	7
3			1	3	.	4	1	2	1
4			1	1	4	.	5	1	1
5			1	1	1	5	.	6	7
6			1	1	1	1	7	.	8
7			1	1	1	1	1	7	.
;

end;
