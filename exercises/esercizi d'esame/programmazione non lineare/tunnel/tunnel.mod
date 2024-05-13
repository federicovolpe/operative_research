reset;

#	DATI
set punti := 1..12; # punti delle uscite già prestabite
param x {punti};	# coordinate dei punti
param y {punti};

#	VARIABILI
var a;
var b;
var c;

var distanze {p in punti} = abs(a * x[p] + b * y[p] + c) / sqrt(a^2 + b^2); 

#	VINCOLI
# esclusione delle rette degeneri
subject to normalize :
	a^2 + b^2 = 1;

#	OBIETTIVO
# minimizzare le distanze dei punti dalla retta scelta
minimize dist :
	sum {p in punti} distanze[p]; 

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
  12    16   5;

var a := 1;
var b := 1;
var c := 1;

end;

