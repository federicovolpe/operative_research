reset;

#	DATI
param np := 12; 	# numero delle piazze
set P := 1..np;		# set delle piazze
param x{P};			# coordinate cartesiane delle piazze
param y{P};			

#	VARIABILI
var a;			# parametri della retta
var b;
var c;
var d{p in P} = abs(a*x[p] + b*y[p] + c) / sqrt(a^2 + b^2);

#	VINCOLI
# vincolo di normalizzazione per la retta
subject to norm :
	a^2 + b^2 = 1;

#	OBIETTIVO
minimize distanze :
	sum{p in P} d[p];
	
data;

param:   x   y :=
   1   -10  14
   2    -8   7
   3    -5  10
   4    -3  10
   5     0   9
   6     2   8
   7     5   8
   8     8   7
   9     9   5
  10    11   6
  11    14   7
  12    16   5
;

var a := 1;
var b := 1;

end;