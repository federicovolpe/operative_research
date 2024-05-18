reset;

#	DATI

#param nLanci := 2;

param g := -9.81 ;
param alfa := 0.05 ;
param beta := 0.8 ;
param ymax := 20 ;

param v0 := 19.80908891 ; # velocità iniziale
param riflessi := 0.5 ;

#	VARIABILI
var t >= riflessi; # tempo di sparo
var y = (g*t^2)/2+ v0 * t;	# altezza del piattello nell'istante t
	
var vis = alfa * y; 	# indice di visibilità 
var stab = exp(-t / beta); 	# indice di stabilità
var p = vis * stab; 	# probabilità di colpire il piattello

#	VINCOLI

#	OBIETTIVO
# massimizzare la probabilità di colpire il bersaglio
maximize probabilita : p ;

end;

# 2) quale è l'istante ideale per sparare?
MINOS 5.51: optimal solution found.
2 iterations, objective 0.2397043622
Nonlin evals: obj = 7, grad = 6.

# 3) tempo di intervallo dei due colpi = 0.25, massimizzare la p di colpire il piattello
	nel peggiore dei due casi, quando sparare i colpi?
vedi piattello3.mod	

# 4) quale è la probabilità di colpire il piattello in ciascuno dei due casi?
