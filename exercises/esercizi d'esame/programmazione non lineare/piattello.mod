reset;

#	DATI	
param g := -9.81;		# accelerazione di gravità
param alfa := 0.05;		# inverso di ymax
param beta := .8;		# coefficiente
param tmin := .5;		# tempo di reazione per lo sparo (vincolo)

#	VARIABILI
var v0 >= 0;	# velocità iniziale del proiettile
var tmax >= 0;		# tempo per raggiungere l'altezza ymax

#	VINCOLI
# la parabola deve raggiungere il punto ymax
subject to parabola :
	g * tmax^2 / 2 + v0 * tmax = 1/ alfa;

# 	OBIETTIVO
# la velocità minima per il quale sono soddisfatti i vincoli della parabola
minimize z := v0;

data;

param :	x	y :=
1  		10 	18 
2  		20 	26 	
3		30	31
4		40	29;

end;
