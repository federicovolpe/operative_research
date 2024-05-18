reset;

#	DATI

param g := -9.81;
param alfa := 0.05 ;
param beta := 0.8 ;
param ymax := 20;

#	VARIABILI
var t >= 0; # variabile del tempo
var v0 >= 0 ; # velocità iniziale

#	VINCOLI
# altezza massima
subject to parabola :
	g * (t^2) /2 + (v0 * t) = 1/alfa;

#	OBIETTIVO
# la minima velocità che rispetta l'equazione della parabola
minimize velocity : v0;

end;

# 1) quale è il tempo impiegato dal piattello per raggiungere l'apice?
Artelys Knitro 13.2.0:                        Knitro 13.2.0: Locally optimal or satisfactory solution.
objective 19.80908891; feasibility error 1.82e-07
24 iterations; 0 function evaluations

suffix feaserror OUT;
suffix opterror OUT;
suffix numfcevals OUT;
suffix numiters OUT;

# 2) quale è l'istante ideale per sparare?
guardare piattello.2.mod

# 3) tempo di intervallo dei due colpi = 0.25, massimizzare la p di colpire il piattello
	nel peggiore dei due casi, quando sparare i colpi?
# 4) quale è la probabilità di colpire il piattello in ciascuno dei due casi?

