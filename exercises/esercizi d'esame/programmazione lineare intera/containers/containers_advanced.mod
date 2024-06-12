# obiettivo : versione dove si vuole calcolare la dimensione minima di container da usare
# l'esercizio ha un numero elevato di nodi quindi il solutore ci impiega tatnissimo a risolverlo
# al prof interessa che il modello sia corretto

#		DATI	#########################################
param nt := 10;			# numero di tipi di oggetti
set Togg := 1..nt;		# set dei tipi di oggetti
param n {Togg};			# numero di oggetti per ogni tipo
param v {Togg};			# volume di ogni tipo di oggetto

param tcont := 3 ; 	# numero di tipi di container
set Tc := 1..tcont;		# set dei tipi di container 
param cap {Tc}; 	# capacità dei container
param nc := 6; 		# numero di containers necessari (fissato dall'esercizio precedente)
set C := 1..nc;		# set dei di containers per ogni tipo


# 		VARIABILI	#######################################
# assegnamento di ogni prodotto ad un determinato container
var x {Togg,Tc,C} integer, >= 0;      # n. di oggetti per ogni container di ciascun tipo
var uso {Tc,C} binary;     # utilizzo di ogni container per ogni tipo
var slack {Tc, C} >= 0;			# capacità di un container che non viene utilizzata

#		VINCOLI	########################################
# per ogni tipo di oggetto devono essere assegnati un numero pari a quanti ce ne sono
subject to assignment {t in Togg} :
  sum {tc in Tc, c in C} x[t,tc,c] = n[t]
; 

# il volume totale degli oggetti contenuti in un container non deve eccedere la sua capacità
# trasformato in uguaglianza con la variabile di slack !
subject to cap_max {tc in Tc, c in C} : 
	sum {t in Togg} v[t] * x[t,tc, c] + slack[tc,c] = cap[tc] * uso[tc,c]
;

# il problema è simmetrico (non vengono riempiti i containers con ordine)
subject to rottura_simmetria {tc in Tc, c in C: c>1} :
	sum {t in Togg} v[t] * x[t,tc,c] <= sum {t2 in Togg} v[t2] * x[t,tc,c-1]
;

#		OBIETTIVO	######################################
# minimizzazione della capacità residua per ogni container impegnato
minimize containers :
	sum{tc in Tc, c in C} slack[tc, c]
;

data;

param cap :=
1		5000
2		3000
3		4000;

param : 	 n 				  v :=
  1          68               30
  2          90               25
  3          10              200 
  4          48               40
  5          28              105
  6          70              150
  7          56               18
  8          10              250
  9          45               54
 10          12               67;

end;
