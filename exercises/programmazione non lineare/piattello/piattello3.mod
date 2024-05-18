reset;

#	DATI

#param nLanci := 2;

param g := -9.81 ;
param alfa := 0.05 ;
param beta := 0.8 ;

param v0 := 19.80908891 ; # velocità iniziale
param riflessi := 0.5 ;

#	VARIABILI
var t1 >= riflessi;	# tempi di sparo
var t2;

var y1 = (g*t1^2)/2 + v0 * t1;	# altezza del piattello nell'istante t
var y2 = (g*t2^2)/2 + v0 * t2;	# altezza del piattello nell'istante t

var vis1 = alfa * y1; 	# indice di visibilità 
var vis2 = alfa * y2; 	# indice di visibilità

var stab1 = exp(-t1 / beta); 	# indice di stabilità
var stab2 = exp(-t2 / beta); 	# indice di stabilità

var p1 = vis1 * stab1; 	# probabilità di colpire il piattello
var p2 = vis2 * stab2; 	# probabilità di colpire il piattello

var sfigato;

#	VINCOLI

subject to reload:
	t2 - t1 >= 0.25;

#	OBIETTIVO
# massimizzare la probabilità di colpire il bersaglio nel peggiore dei due casi
maximize probabilita : sfigato ;

subject to s1 : sfigato <= p1;
subject to s2 : sfigato <= p2;

end;

# 3) tempo di intervallo dei due colpi = 0.25, massimizzare la p di colpire il piattello
MINOS 5.51: optimal solution found.
1 iterations, objective 0.2351211021
Nonlin evals: constrs = 6, Jac = 5.


# 4) quale è la probabilità di colpire il piattello in ciascuno dei due casi?
ampl: display t1, p1, t1, p2;
t1 = 0.529994
p1 = 0.235121
t1 = 0.529994
p2 = 0.235121
