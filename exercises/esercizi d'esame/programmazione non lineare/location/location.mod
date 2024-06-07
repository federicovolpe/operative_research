# problema con l'obiettivo
reset;

#		DATI #######################################################################################
param nf := 4; 		# numero di facilities
set F := 1..nf;		# set delle facilities
param cap {F};		# capacità massima di ogni facilities
param costi {F};	# costo per ogni facilities

param nu := 10;		# numero di utenti
set U := 1..nu; 	# set degli utenti
param xu {U};		# coordinate di ogni utente
param yu {U};
param dom {U};		# domanda associata ad ogni utente

#		VARIABILI #######################################################################################
# coordinate delle facility
var xf {F};
var yf {F};

var utilizzo {F} binary;

# assegnamento di ogni user ad una facility
var assign {U, F} binary;
# distanza di ogni utente con ogni facility
var distance {u in U, f in F} = ((xf[f] - xu[u])^2 + (yf[f] - yu[u])^2)^.5; 


#		VINCOLI #######################################################################################
# a somma delle domande degli utenti assegnati alla stessa facility non può eccedere la capacità della facility stessa.
subject to sommaDomande {f in F} :
	sum {u in U} (dom[u] * assign[u, f]) <= cap[f] * utilizzo[f]
;

# ogni utente deve essere assegnato ad una sola facility
subject to utente_facility {u in U} :
	sum{f in F} assign[u, f] = 1
;

#		OBIETTIVO #######################################################################################
# minimizzare i costi totali, dati dalla somma tra i costi di utilizzo delle facilities 
# e i costi di assegnamento dei punti alle facilities.
minimize costi_tot :
	sum {f in F} (costi[f] * utilizzo[f]) + # costi di utilizzo delle facilities
	sum {f in F, u in U} (#assign[u,f] * 
	distance[u,f]
	)
;


data;
# Tabella 1: Posizione dei punti e domande
param : xu yu dom :=
1 	-20   45   30
2  	-30   56   35
3  	-10  -29   40
4    0  -18   15
5  40    3   20
6   30   40   20
7   15   12   25
8   18   -6   40
9   23   24   10
10   -2  -30   25
;

# Tabella 2: Capacità e costi delle facilities
param : cap costi :=
1		130	800
2		80	500
3		100	750
4		60	400
;
var : xf yf :=
1	1	1
2	1	1
3	1	1
4	1	1
;

end;
