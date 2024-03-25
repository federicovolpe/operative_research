#	DATI
set prodotti ;
set materie ;
param disponibili {materie};
param necessarie {materie, prodotti};
# param beta := 27.13; 
# param beta := 29.61;
# param beta := 34.558;
# var beta;
param c1{prodotti};
param c2{prodotti};

#	VARIABILI
var produzione {prodotti} >= 0;
var beta1;
var beta2;
var delta;

#	VINCOLI
subject to consumi {m in materie} :
	sum {p in prodotti} necessarie[m, p] * produzione[p] <= disponibili[m];

#	OBIETTIVI
# 		CONSIGLIERE A:	massimizzare f2 trascurando f1
# funzione obiettivo z1 trasformata in un vincolo
# subject to ob_f1 :
#	sum {p in prodotti} c1[p] * produzione[p] >= beta;
# maximize z2: sum {p in prodotti} c2[p] * produzione[p];

# 		CONSIGLIERE B:	massimizare f1 trascurando f2
# maximize z1: sum {p in prodotti} c1[p] * produzione[p];
# subject to ob_f2 :
#	sum {p in prodotti} c2[p] * produzione[p] >= beta;

#		CONSIGLIERE C:	pesando al 30% f2
# maximize z: sum {p in prodotti} ((.7 * c1[p]) + (.3 * c2[p])) * produzione[p];
# subject to ob_f1 :
#	sum {p in prodotti} c1[p] * produzione[p] = beta1;
# subject to ob_f2 :
#	sum {p in prodotti} c2[p] * produzione[p] = beta2;

#		CONSIGLIERE D:	pesando al 25% f1
#maximize z: sum {p in prodotti} ((.25 * c1[p]) + (.75 * c2[p])) * produzione[p];
# subject to ob_f1 :
#	sum {p in prodotti} c1[p] * produzione[p] = beta1;
# subject to ob_f2 :
#	sum {p in prodotti} c2[p] * produzione[p] = beta2;

#		CONSIGLIERE E: 

#		CONSIGLIERE F: massimizzare il caso peggiore(il minimo dei due obiettivi)
# maximize z: delta;
# subject to Maxmin1: delta <= beta1;
# subject to Maxmin2: delta <= beta2;

# subject to ob_f1 :
#	sum {p in prodotti} c1[p] * produzione[p] = beta1;
# subject to ob_f2 :
#	sum {p in prodotti} c2[p] * produzione[p] = beta2;
	# le curve di livello sono come dei quadrati aperti sopra e a destra, punto F nelle slide
	# non sa augurarsi se la legge passa o no ma non ha importanza

#		CONSIGLIERE G: non si può linearizzare (fare max max)
#	si immagina come possa essere posizionato il punto nelle slide
#	sul solutore : si confrontano gli ottimi precedenti (il prof non lo spiega)

#		CONSIGLIERE H: non ha frequentato il corso di ricerca operativa (whatever that means) 

data;

set prodotti := X Y Z W;

set materie := A B C D;

param disponibili := 
A	100
B	120
C	90
D	110;

param necessarie : 	X 	Y 	Z 	W :=
A 					3 	2 	5 	4
B 					8 	10	1 	1
C 					1 	3 	6 	9
D 					2	0 	8 	11;

param : c1 	c2 :=
X		1.0	1.7
Y		1.5	0.4
Z		1.3	2.0
W		2.5	0.7;

end;