reset;

#	DATI
param nv := 8; 		# numero dei vertici
set V := 1..nv;		# set dei vertici
param x {V};		# coordinate cartesiane dei vertici
param y	{V};

#	VARIABILI
var xc;		# coordinate del centro della fontana
var yc;

var rBas >= 0;	# raggio del basamento
var rZamp >= 0;	# raggio dello zampillo

var distcent {V} >= 0; 
var distcircBas {v in V} = distcent[v] - rBas;
var distcircZamp {v in V} = distcent[v] - rZamp;

#	VINCOLI
# definizione di distanza dal centro
subject to distanza_centro {v in V} :
	distcent[v]^2 = (xc - x[v])^2 + (yc - y[v])^2;
;

# i punti devono trovarsi all'interno del cerchio
subject to interni {v in V} :
	distcircBas[v] <= 0
;

subject to esterni {v in V} :
	distcircZamp[v] >= 0
;

 
#	OBIETTIVO
#  trovare il punto che rende massimo il rapporto tra 
# il raggio del cerchio dello zampillo e 
# il raggio del cerchio del basamento quando i due centri coincidono in esso
maximize rapporto :
	rZamp / rBas ;

	
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

objective 0.666519208
ampl: display xc, yc, rBas, rZamp;
xc = 2.38372
yc = 5.02326
rBas = 8.27908
rZamp = 5.51816