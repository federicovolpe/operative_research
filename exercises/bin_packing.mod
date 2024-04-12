#	DATI
set oggetti := 1..20; 		# set di oggetti
set contenitori := 1..5; 	# set di contenitori
param cap;					# capacità			[kg]
param peso {oggetti}; 		# peso di ciascun oggetto [kg]

#	VARIABILI
# variabili di assegnamento
var x {oggetti, contenitori} binary; 	# assegnamento di ogni oggetto ad ogni contenitore
var y {contenitori} binary; 			# se il contenitore c è usato o no

#	VINCOLI
subject to capacity {c in contenitori}: # vincolo di capacità analogo a quello dello zaino
	sum {o in oggetti} peso[o] * x[o, c] <= cap * y[c]; # per il vincolo successivo

# vincoli di assegnamento
subject to assegnamenti {o in oggetti} : # tutti gli oggetti devono essere assegnati ad un contenitore
	sum {c in contenitori} x[o, c] >= 1;

# vincolo obsoleto
# impedire che un oggetto venga messo in un contenitore non utilizzato
#subject to relazionexy {o in oggetti, c in contenitori} :
#	x[o,c] <= y[j];


	# domanda utile da porsi: 
	# c'è un vincolo sul totale per riga o per colonna ??

# per evitare che il contenitore 5 venga usato prima di aver utilizzato il 4 
# (chiamato symmetry braking constraint)
subject to sbc {c in contenitori: c >1}:
	y[c] <= y[c-1];

#	OBIETTIVO
minimize z : # minimizzare il numero di contenitori utilizzati
	sum {c in contenitori} y[c]; 

data;

param cap := 700;

param : peso :=
1 144
2 172
3 153
4 131
5 126
6 109
7 165
8 149
9 108
10 84
11 199
12 160
13 182
14 129
15 107
16 161
17 130
18 167
19 128
20 94;

end;
