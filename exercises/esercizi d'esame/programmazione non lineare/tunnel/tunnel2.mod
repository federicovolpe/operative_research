reset;

# versione del problema con più linearizzazioni possibili

#	DATI
set punti := 1..12; # punti delle uscite già prestabite
param x {punti};	# coordinate dei punti
param y {punti};

#	VARIABILI
var a;
var b;
var c;

var distanze {punti}; 

#	VINCOLI
# esclusione delle rette degeneri
subject to normalize :
	a^2 + b^2 = 1;
	
# vincoli relativi al valore assoluto
subject to abs1 {p in punti}:
	distanze[p]  >= a*x[p] + b*y[p] +c;
	
subject to abs2 {p in punti}:
	distanze[p]  >= -a*x[p] - b*y[p] -c;

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

ampl: model tunnel2.mod;
ampl: solve;
SNOPT 7.5-1.2 : Optimal solution found.
18 iterations, objective 10.91411044
Nonlin evals: constrs = 6, Jac = 5.
ampl: display distanze, a, b, c;
distanze [*] :=
 1   2.42536
 2   3.88057
 3   0.242536
 4   0.242536
 5  -1.70398e-15
 6   0.485072
 7   0.242536
 8  -4.28049e-17
 9   1.69775
10   0.242536
11   1.45521
12  -2.89005e-26
;

a = 0.242536
b = 0.970143
c = -8.73129

# se presente un vincolo di uguaglianza non lineare 
	allora il problema non può essere linearizzato !!!