reset;

#	DATI

param nq := 5;
set Q := 1..nq;		# set dei quadrati
param lati {Q};		# lati dei rispettivi quadrati

# dimensioni del rettangolo
param b := 20;
param h := 30;

param M := 200;

#	VARIABILI
# coordinate dei centri dei quadrati
var xc {q in Q} >= lati[q] / 2;
var yc {q in Q} >= lati[q] / 2;

var dist{q in Q} = (xc[q] - b/2)^2 + (yc[q] - h/2)^2;

var activity{q1 in Q, q2 in Q, 1..2} binary;

s.t. Simultaneita {q1 in Q, q2 in Q} :
    sum {i in 1..2} activity[q1, q2, i] <= 1
;

#	VICNOLI
# i quadrati non possono superare le dimensioni del rettangolo
subject to base {q in Q} :
	xc[q] + lati[q]/2 <= 25;
subject to altezza {q in Q} :
	yc[q] + lati[q]/2 <= h;

# i quadrati non possono sovrapporsi
subject to sovrapposizionex {q1 in Q, q2 in Q : q1 <> q2} :
	abs(xc[q2] - xc[q1]) >= (lati[q1] + lati[q2])/2  - M * activity[q1, q2, 1]
;
	 
subject to sovrapposizioney {q1 in Q, q2 in Q : q1 <> q2} :
	abs(yc[q2] - yc[q1]) >= (lati[q1] + lati[q2])/2  - M * activity[q1, q2, 2]
; 


#	OBIETTIVO
# OBIETTIVO
minimize z : sum {q in Q} dist[q];

data;

param lati :=
    1      4
    2      6
    3      7
    4      3
    5      9;

end;
