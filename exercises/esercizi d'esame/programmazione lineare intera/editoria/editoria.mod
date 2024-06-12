# esercizio terminato
#		DATI	#############################################
param nf := 4;		# numero di fascicoli per un volume (il quarto fascicolo conterrà gli articoli scartati)
param np := 44;		# numero di pagine per ogni fascicolo
param na := 12;		# numero di articoli disponibili

set F := 1..nf;		# set dei fascicoli
set A := 1..na;		# set degli articoli
param len {A};		# lunghezza in pagine di ogni articolo
param urg {A};		# parametro di urgenza per gli articoli

#		VARIABILI	#############################################
# assegnamento di ogni articolo ad un fascicolo
var assign {A,F} binary;		# assegnamento di pagine di un articolo ad un fascicolo 

#		VINCOLI	#############################################
# il numero totale delle pagine usate in un fascicolo non deve eccedere le disponibili
subject to paginemax {f in F : f <= 3} :
	sum {a in A} len[a] * assign [a,f] <= np
;
# ogni articolo può solo essere assegnato ad un fascicolo
subject to assegnazione_unica {a in A} :
	sum{f in F} assign[a,f] <= 1
;
# vincolo di urgenza degli articoli
subject to utgenze {a in A} :
	sum {f in F : f <= 4 - urg[a]} assign[a, f] = 1
;

#		OBIETTIVO	#############################################
# minimizzare il numero di articoli che non vengono assegnati -> massimizzare gli articoli assegnati
maximize z:
	sum{f in F, a in A} assign[a,f] 
;
data;

param : 	len			urg :=
    1        5          2
    2        11			0
    3        17         2
    4        10			0
    5        18         3 
    6         8			0
    7        14			0
    8         9         1
    9        16         1
    10       12			0
    11       14			0
    12       13			0
;

# Gli articoli indicati dagli asterischi sono i più urgenti: 
# 3 asterischi => non dopo il primo fascicolo
# 2 asterischi => non dopo il secondo fascicolo
# 1 asterisco  => non dopo il terzo fascicolo

end;
