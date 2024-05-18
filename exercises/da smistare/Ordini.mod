
#	DATI
set ordini := 1..10;
param tempi {ordini};
param scadenze {ordini};

#	VARIABILI
var precedenze {ordini, ordini} binary; # un ordine precede un altro solo se ha 1
var completamento {ordini};				# tempo di completamento per ogni ordine
var ritardi {ordini} >= 0; 				# ritardi per ogni ordine

# per il punto b
var ritmax >= 0;						# ritardo massimo

#	VINCOLI
# non devono essere presenti cicli nella matrice
subject to noloop {i in ordini, j in ordini , k in ordini : i <> j and j <> k}:
	precedenze[i, j] + precedenze[j, k] + precedenze[k, i] <= 2;

# un ordine non può precedere se stesso
subject to self {o in ordini} :
	precedenze[o, o] = 0;
	
# data una coppia di ordini deve sempre esserci una che viene prima dell'altro
subject to mustPrecede {o1 in ordini, o2 in ordini : o1 <> o2} :
	precedenze[o1,o2] + precedenze[o2, o1] = 1;

# ogni ordine deve essere completato entro la sua scadenza
subject to completion {o in ordini}:
	completamento[o] = sum {o2 in ordini} (tempi[o2] * precedenze[o2, o] + tempi[o]);

# gli ordini devono essere completati entro la loro scadenza
subject to vincoloRitardi {o in ordini}:
	ritardi[o] >= completamento[o] - scadenze[o];

#	OBIETTIVO
# (a) minimizzare il ritardo complessivo (la somma di tutti i ritardi rispetto alle scadenze)
minimize z: 
	sum {o in ordini} ritardi[o];

# minimizzare il ritardo massimo
#minimize z: ritmax;
subject to ritm {o in ordini} :
	ritmax >= ritardi[o];

data ;

param : tempi scadenze :=
1	24	50
2	12	50
3	30	90
4	15	70
5	18	50
6	7	80
7	8	10
8	15	90
9	14	120
10	22	150;

end;
