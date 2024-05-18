#	DATI
set memorie := 1..5;
set orbite := 1..10;

param ingresso {orbite, memorie};	# ingresso di dati previsto				[Mbit] 
param finestre {orbite} ;			# finestra di minuti per ogni orbita 	[min]
param cap {memorie} ;				# capacita di ogni memoria 				[Mbit]
param initial_cont {memorie} ;		# contenuto iniziale di ogni memoria 	[Mbit]
param speed := 9;					# velocita di trasferimento dati 		[Mbit/min]

#	VARIABILI
var immagazzinati {m in memorie} >= 0, <= cap[m]; 	# dati immagazzinati per ogni orbita 	[Mbit]

# non si deve superare il limite di trasmissione di dati
var inviati {o in orbite} >= 0, <= speed * finestre[o];			# dati inviati per ogni orbita			[Mbit]

var aux;

#	VINCOLI
# vincolo di conservazione
# per ogni memoria la somma dei dati in ingresso e quelli contenuti deve rimanere al di sotto della capacita
subject to conservazione {o in orbite, m in memorie}:		
	immagazzinati[m] - inviati[o] + ingresso[o, m] <= cap[m];

# come mettere i dati iniziali nelle memorie?

#	OBIETTIVO
# bisogna scegliere da quale dispositivo di memoria scaricare i dati
# minimizzare il massimo livello di riempimento raggiunto dai dispositivi di memoria durante il periodo considerato
minimize z : aux;

subject to minMax {m in memorie}:
	aux <= cap[m];

data;

param ingresso :1 	2 	3 	4 	5 :=
1 				35 	0 	80 	25 	50
2 				200 70 	100 25 	0
3 				0 	150 0 	25 	100
4 				600 300 0 	25 	75
5 				200 0 	210 25 	200
6 				50 	0 	85 	0 	45
7 				40 	60 	50 	0 	300
8 				300 90 	20 	60 	0
9 				0 	100 100 60 	20
10 				0 	20 	100 60 	250;

param finestre := 1 45
                  2 47
                  3 55
                  4 45
                  5 35
                  6 42
                  7 30
                  8 35
                  9 44
                  10 40;

param : cap 	initial_cont :=
1 		1000 	500
2 		1200 	600
3 		1000 	500
4 		500 	250
5 		700 	350;

end;