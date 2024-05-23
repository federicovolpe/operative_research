reset;

#	DATI
set oss := 1..4;	# osservazioni

param x {oss};		
param y {oss};

#	VARIABILI
# l'equazione della parabola è definita dai suoi tre coefficienti a b c
var a <= 0;
var b	;
var c	;

# errore fra la parabola e il punto calcolato
var e {o in oss} = a * x[o]^2 + b * x[o] + c - y[o]; 

var x0;

#	VINCOLI

# vincoli della partenza (parte due del problema)
subject to partenza :
	a * x0^2 + b * x0 + c = 0;

# voglio prendere il punto x0 a sinistra 
subject to sinistra: 
	2 * a * x0 >= -b;

# 	OBIETTIVO
minimize z :
	sum {o in oss} e[o]^2; # minimizzazione dell'errore


data;

param :	x	y :=
1  		10 	18 
2  		20 	26 	
3		30	31
4		40	29;

end;

identificare il punto da cui parte il proietto:
