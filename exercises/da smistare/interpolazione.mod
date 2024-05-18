#	DATI
param n_giorni := 12;
param n_elettrodomestici := 8;
set giorni := 1..n_giorni;
set elettrodomestici := 1..n_elettrodomestici;

param consumo {giorni};					# per ogni giorno il consumo misurato [KWh]
param tempo {giorni, elettrodomestici};	# per ogni giorno il tempo per il quale ogni elettrodomestico viene utilizzato [h]

#	VARIABILI ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# la fuznione di errore [KWh]
# differenza tra il consumo letto sul contatore e la somma dei contributi relativi ai diversi elettrodomestici
# potrebbe essere sia positivo che negativo 
var errore {giorni};

# potenza assorbita per ogni elettrodomestico [KWh]
var assorbita {elettrodomestici} >= 0;

# variabile utilizzata per l'obiettivo
var delta;

var gamma{giorni};

#	VINCOLI ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
subject to limite_errore {g in giorni}:
	errore[g] = consumo[g] - sum {e in elettrodomestici} tempo[g, e] * assorbita[e];

#	OBIETTIVO ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# (a) minimizzare il massimo errore in valore assoluto; 
# linearizzazione della funzione abs()
# minimize z1 : delta; # funzione che deve essere sia all'errore che al negativo dell'errore
# subject to minmax1 {g in giorni}: delta >=   errore[g];
# subject to minmax2 {g in giorni}: delta >= - errore[g];

# (b) minimizzare il valore assoluto del valor medio degli errori;
# minimize z2 :delta;
# subject to min_abs1 : delta >= sum {g in giorni} elettrodomestici[g] / n_giorni;
# subject to min_abs2 : delta >= -sum {g in giorni} elettrodomestici[g] / n_giorni;

# (c) minimizzare il valor medio dei valori assoluti degli errori; 
# minimize z3 : sum {g in giorni} gamma[g] / n_giorni;
# subject to min_abs1 {g in giorni} : gamma[g] >=  errore[g];
# subject to min_abs2 {g in giorni} : gamma[g] >= -errore[g];

# (d) minimizzare l’errore quadratico medio
# minimize z4 : sum {g in giorni} errore[g]^2 / n_giorni;	 da riformulare in maniera lineare
# calcolare la derivata poichè essa sarà lineare rispetto al quadrato
# minimize z4 : sum {g in giorni} errore[g]^2 / n_giorni;
subject to condizione {e in elettrodomestici} : sum {g in giorni} tempo[g, e] * errore[g] = 0;

data;# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

param consumo :=
 1		10
 2		20
 3		10
 4		15
 5		 5
 6		10
 7		10
 8		20
 9		12
10		25
11		 2
12		 5;

param tempo:	1	2	3	4	5	6	7	8 :=
1				0.2	0.4	0.5	0.6	0.6	0.5	0.2	0.2
2				0.1	1.0	0.1	1.2	1.1	1.0	0.6	0.3
3				0.1	0.5	0.5	0.7	0.5	0.5	0.1	0.2
4				0.2	0.6	0.6	0.8	0.6	0.6	0.2	0.3
5				0.1	0.4	0.2	0.3	0.2	0.2	0.0	0.2
6				0.2	0.5	0.4	0.7	0.5	0.4	0.2	0.3
7				0.3	0.4	0.5	0.8	0.4	0.4	0.2	0.2
8				0.6	0.8	1.0	1.5	1.3	0.6	0.5	0.6
9				0.3	0.4	0.5	0.7	0.5	0.5	0.3	0.2
10				0.5	0.9	1.1	1.3	0.9	1.2	0.8	0.5
11				0.0	0.2	0.0	0.0	0.1	0.0	0.0	0.1
12				0.0	0.5	0.2	0.3	0.2	0.1	0.1	0.3;

end;