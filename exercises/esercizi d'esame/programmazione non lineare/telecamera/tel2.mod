reset;

# risistemazione dei vincoli sulle variabili a e b

#	DATI
set quadri := 1..3;

param lato := 16;

param xa{quadri};
param xb{quadri};
param ya{quadri};
param yb{quadri};
param c {i in quadri} := sqrt((xa[i]- xb[i])^ 2 + (ya[i] - yb[i])^2); # lunghezza dei quadri
param delta := 1 ;			

#	VARIABILI
# il punto iniziale inizializzato al centro della stanza
var xp >= delta, <= lato - delta := 8; 
var yp >= delta, <= lato - delta := 8;

var a {q in quadri} = sqrt((xp-xa[q])^2 + (yp - ya[q])^2);
var b {q in quadri} = sqrt((xp-xb[q])^2 + (yp - yb[q])^2);

var alfa {quadri} >= 0, <= 3.14; 

var alfamin;

#	VINCOLI
	
subject to carnot {q in quadri}:
	c[q]^2 = a[q]^2 + b[q]^2 - 2 * a[q] * b[q] * cos(alfa[q]);
	
#	OBIETTIVO
# Tizio: massimizzare la somma degli angoli
 maximize tizioz :
 	sum {i in quadri} alfa[i];

# COMMENTO:
# va tutto addosso ad un quadro per avere 180 gradi 
	
# Caio: minimizzazione della somma degli angoli
#maximize caioz : alfamin;

#subject to maxmin {q in quadri}:
#	alfamin <= alfa[q];

data;

param :		xa 	ya  xb 	yb :=
1			0	0	0	4
2			0	10	6	16
3			10	0	15	0;

end;
