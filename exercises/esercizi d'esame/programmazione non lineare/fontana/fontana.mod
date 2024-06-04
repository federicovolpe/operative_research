reset;

#	DATI
param nv := 8; 		# numero dei vertici
set V := 1..nv;		# set dei vertici
param x {V};		# coordinate cartesiane dei vertici
param y	{V};

#	VARIABILI
var xc;		# coordinate del centro del basamento
var yc;
var r >= 0;	# raggio del basamento
var distcent {V} >= 0; 
var distcirc {v in V} = distcent[v] - r;

#	VINCOLI
# definizione di distanza dal centro
subject to distanza_centro {v in V} :
	distcent[v]^2 = (xc - x[v])^2 + (yc - y[v])^2;
;

# i punti devono trovarsi all'interno del cerchio
subject to interni {v in V} :
	distcirc[v] <= 0
;
 
#	OBIETTIVO
# progettare un cerchio che includa tutti i punti e minimizzi la distanza
# della propria circonferenza con essi
minimize distcirconf :
	sum {v in V} abs(distcirc[v]);
	
data;

#I vertici del poligono sono 8.
#Qui di seguito sono elencati ordinatamente, seguendo il perimetro del poligono, in un sistema di riferimento cartesiano.

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

objective 11.42895357
ampl: display xc, yc, r;
xc = 2.10791
yc = 5.27609
r = 8.35562
