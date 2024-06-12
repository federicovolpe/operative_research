# obiettivo : rilassamento del problema nel continuo 
# per poter stimare il numero di containers e farsi una idea del problema se i containers
# avessero tutti la stessa capacità

#		DATI	#########################################
param nt := 10;			# numero di tipi di oggetti
set Togg := 1..nt;			# set dei tipi di oggetti
param n {Togg};			# numero di oggetti per ogni tipo
param v {Togg};			# volume di ogni tipo di oggetto

param cap := 5000; 		# capacità dei container (in questa versione solo di un tipo)
param nc := ceil(sum {t in Togg}(v[t] * n[t]) /cap); 			# numero di containers necessari
set C := 1..nc;			# set dei di containers


# 		VARIABILI	#######################################
# assegnamento di ogni prodotto ad un determinato container
var x {Togg,C} integer, >= 0;       # n. di oggetti per ogni container
var uso {C} binary;     # utilizzo di ogni container

#		VINCOLI	########################################
# per ogni tipo di oggetto devono essere assegnati un numero pari a quanti ce ne sono
subject to assignment {t in Togg} :
  sum {c in C} x[t,c] = n[t]
; 

# il volume totale degli oggetti contenuti in un container non deve eccedere la sua capacità
subject to cap_max {c in C} : 
	sum {t in Togg} v[t] * x[t, c] <= cap * uso[c]
;

# vincolo di simmetria per riempire per primi i primi containers
subject to symm1 {c in C : c >1}:
  use[c] <= use[c-1];
subject to symm2 {c in C : c >1}:
  sum{t in Togg} v[t] * x[t,c] <= sum{t in Togg} v[t] * x[t,c-1];

#		OBIETTIVO	######################################
# minimizzazione del numero di containers utilizzati
minimize containers :
	sum{c in C} uso[c]
;

data;

#param cap :=
#1		5000
#2		3000
#3		4000;

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
