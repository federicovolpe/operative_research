reset;

#	DATI
param np := 10; # numero di punti dello scenario
set P := 1..np;	# punti dello scenario
param x {P};	# coordinate dei punti
param y	{P};
param Peso {P};

#	VARIABILI
var xc;
var yc ;
var r >= 0 ;		# raggio della circonferenza

var dcent {P};
# distanza di un punto dalla circonferenza
# non è altro che la distanza dal centro meno il raggio della circonferenza
var dcirc {p in P} = abs(r - dcent[p]);
var massimo;

#	VINCOLI
# distanza dal centro del cerchio per ogni punto
subject to distanza_dal_centro {p in P}:
	dcent[p]^2 = (xc - x[p])^2+ (yc - y[p])^2
;

#	OBIETTIVO
# minimizzare una funzione della distanza pesata di ogni punto dalla circonferenza.
# minimizzare il valor medio delle distanze pesate dei punti dalla circonferenza,
#minimize a :
#	sum {p in P} (dcirc[p] * Peso[p]) / np;
	

# minimizzare la massima tra le distanze pesate dei punti dalla circonferenza,
#minimize b :
#	massimo;

#subject to massimo1 {p in P}:
#	massimo >= dcirc[p] * Peso[p];
	

# minimizzare l’errore quadratico medio, cioè il valor medio pesato dei quadrati delle distanze.
minimize c :
	sum {p in P} (dcirc[p]^2 * Peso[p]) / np ;

data;

#Scenario A

param :  x    y  Peso :=
  1   51   13   3
  2   48   75   5
  3   16   57   4
  4   33   70   2
  5   95   52   3
  6   59   10   3
  7   23   61   4
  8   32   70   4
  9   87   50   2
 10   46   98   1;



# Scenario B

#Punto  X    Y  Peso
#  1  -20  -10   1
#  2  -10    0   1
#  3  -10  -20   1
#  4    0  -10   1
#  5  -10    1   1
#  6  -10   -1   1

end;

soluzione al primo :
MINOS 5.51: optimal solution found.
323 iterations, objective 91.90659305
Nonlin evals: obj = 941, grad = 940, constrs = 941, Jac = 940.
ampl: display xc, yc, r;
xc = 35.9971
yc = 64.4844
r = 0

soluzione al secondo : ( ottimo locale) 
Artelys Knitro 13.2.0:                        Knitro 13.2.0: Locally optimal or satisfactory solution.
objective 135.713494; feasibility error 5.94e-06
22 iterations; 24 function evaluations
ampl: display xc, yc, r;
xc = 49.8205
yc = 54.2967
r = 8.17479e-10

soluzione al terzo:
Artelys Knitro 13.2.0:                        Knitro 13.2.0: Locally optimal or satisfactory solution.
objective 70.2424954; feasibility error 9.9e-08
8 iterations; 11 function evaluations
ampl: display xc, yc, r;
xc = 55.0792
yc = 45.3618
r = 35.5916