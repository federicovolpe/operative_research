reset;

#	DATI
param nv := 8; 		# numero dei vertici
set V := 1..nv;		# set dei vertici
param x {V};		# coordinate cartesiane dei vertici
param y	{V};

#	VARIABILI
var xc;		# coordinate del centro dello zampillo
var yc;
var r >= 0;	# raggio dello zampillo
var distcent {V} >= 0; 
var distcirc {v in V} = distcent[v] - r;

#	VINCOLI
# definizione di distanza dal centro
subject to distanza_centro {v in V} :
	distcent[v]^2 = (xc - x[v])^2 + (yc - y[v])^2;
;

# i punti devono trovarsi all'esterno del cerchio dello zampillo
subject to esterno {v in V} :
	distcirc[v] >= 0
;
 
#	OBIETTIVO
# progettare un cerchio che sia incluso fra tutti i punti e minimizzi la distanza
# della propria circonferenza con essi
minimize distcirconf :
	sum {v in V} abs(distcirc[v]);
	
data;

param : x   y :=
1 -2  -2
2 -3  10
3  0  10
4  9  10
5  7   2
6  6   0
7  4  -1
8  0  -2;

end;

objective 7.080677536
ampl: display xc, yc, r;
xc = 0.625
yc = 4
r = 6.03246