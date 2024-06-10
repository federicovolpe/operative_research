#		DATI	#############################################################
param nt := 10;			# numero di tipi di oggetti
set T := 1..nt;			# set dei tipi di oggetti
param n {T};			# numero di oggetti per ogni tipo
param v {T};			# volume di ogni tipo di oggetto

param ccd := 5000;		# capacità dei container disponibili
param cca := 3000;		# capacità dei container alternativi

param nc := 3; 			# numero di tipi di containers
set C := 1..nc;			# set dei tipi di containers
param cap {C}; 			# capacità di ogni tipo di container

# 		VARIABILI	##########################################################
# assegnamento di ogni prodotto ad un determinato container
var 

#		VINCOLI	##########################################################
# il volume totale degli oggetti contenuti in un container non deve eccedere la sua capacità
subject to cap_max :
	sum {t in T} v[t] <= cap[c]
;

#		OBIETTIVO	##########################################################
# minimizzazione del numero di containers utilizzati
minimize containers :
	sum[c in C ]
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
