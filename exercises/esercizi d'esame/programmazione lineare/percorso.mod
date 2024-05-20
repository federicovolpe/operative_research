reset;

#	DATI -----------------------------------------------------------
param M := 999 ;
param n := 16;
set N ;		# set di nodi del grafo

# insieme di lati (sottoinsieme del prodotto cartesiando dei nodi)
set A := N cross N;

# rischio per ogni arco (di default è un costo molto grande per gli archi che non esistono)
param r {A} default M; 

#	VARIABILI -----------------------------------------------------------
var X {A} binary;

#	VICNOLI -----------------------------------------------------------
# definizione del cammino (il grado entrante e il grado uscente devono essere uguali)
subject to Cammino {j in N diff {'0', 'f'}} :
	sum {(i, j) in A} X[i, j] = 		# la somma degli archi entranti
		sum {(j, i) in A} X[j, i];		# somma degli archi uscenti 
# 	la conservazione del flusso non vale per 0 e f che sono i nodi iniziali e finali

subject to Uscente0 :
	sum {(i, j) in A : i = 0} X[i, j] = 1;
		
subject to Uscentef :
	sum {(i, j) in A : i = 'f'} X[i, j] = 0;
	
subject to Entrante0 :
	sum {(i, j) in A : j = 'f'} X[i, j] = 1;
		
subject to Entrantef :
	sum {(i, j) in A : j = 0} X[i, j] = 0;
	
	

# 	OBIETTIVO -----------------------------------------------------------
minimize rischio :
		sum {(i,j) in A } r[i, j] * X[i,j];

data;

set N := 0 1 2 3 4 5 6 7 8 9 a b c d e f;

param r :=
         [0, 1]	2
         [0, 3]	1
         [1, 2]	2
         [2, 3]	2
         [2, 4]	3
         [3, 5]	2
         [3, 6]	2
         [4, 5]	3
         [4, 9]	2
         [4, a]	4
         [5, 7]	3
         [6, 7]	2
         [7, 8]	2
         [8, 9]	2
         [8, b]	1
         [9, d]	5	
         [a, d]	3	
         [b, c]	1
         [b, e]	2
         [c, d]	2
         [d, e]	3
         [d, f]	3
         [e, f] 4;

# Il convoglio si trova nel nodo '0' e deve arrivare nel nodo 'f'.

end;
