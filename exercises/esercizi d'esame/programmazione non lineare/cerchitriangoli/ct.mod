reset;
## esercizio non terminato

#	DATI
param nk := 8;
set K := 1..nk;	 # set di cerchi di raggio unitario
set rette := 1..3;	#rette che definiscono il triangolo

#	VARIABILI
var x {K};		# coordinate dei centri dei piccoli cerchi
var y {K};

var a {rette};			# info sulla retta
var b {rette};
var c {rette};

var xg;			# info del cerchio piu grande
var yg;
var rg >= 0;

#	VINCOLI
# normalizzazione delle rette
subject to normalize{re in rette}:
	a[re]^2 + b[re]^2 = 1
;

# i cerchi non devono essere sovrapposti
subject to sovrapposizione {c1 in K, c2 in K : c1 <> c2} :
	(x[c1] - x[c2])^2 + (y[c1] - y[c2])^2 >= 4 # il quadrato di due raggi unitari
; 

# i centri dei cerchi devono trovarsi all-interno delle rette
subject to inclusioneCentri {ce in K, re in rette} :
	a[re] * x[ce] + b[re] * y[ce] + c[re] >= 0
;

# la distanza punto retta fra centro del cerchio e retta deve essere maggiore del raggio
subject to inclusioneCerchi {ce in K, re in rette} :
	a[re] * x[ce] + b[re] * y[ce] + c[re] >= 1 #duplicazione del vincolo precedente
;	

# il cerchio grande deve comprendere i vertici del triangolo
subject to inclusioneVerticiX {r1 in rette, r2 in rette : r1 <> r2} :
	(xg - (b[r1] * c[r2] - b[r2] * c[r1]) / (a[r1] * b[r2] - a[r2] * b[r1]))^2 +
	(yg - (c[r1] * a[r2] - c[r2] * a[r1]) / (a[r1] * b[r2] - a[r2] * b[r1]))^2 
	<= rg^2;
;

#	OBIETTIVO
minimize raggioGrande :
	sum {c1 in K , c2 in K} ((x[c1] - x[c2])^2 + (y[c1]-y[c2])^2);

end;

	K cerchi di raggio unitario e non sovrapposti 
devono essere circoscritti da un triangolo, che a sua volta 
deve essere inscritto in un altro cerchio di raggio minimo. 
Risolvere il problema per i valori di K da 4 a 8.

	Classificare il problema e risolverlo. Discutere unicità e ottimalità delle soluzioni trovate.
