reset;

#	DATI

param nq := 5;
set Q := 1..nq;		# set dei quadrati
param lati {Q};		# lati dei rispettivi quadrati

# dimensioni del rettangolo
param b := 20;
param h := 30;

#	VARIABILI
# coordinate delle posizioni dei quadrati
var x {Q} >= 0;
var y {Q} >= 0;

#	VICNOLI
# i quadrati non possono superare le dimensioni del rettangolo
#subject to base {q in Q} :
#	x[q] + lati[q] <= b;
subject to altezza {q in Q} :
	y[q] + lati[q] <= h;

# i quadrati non possono sovrapporsi
subject to sovrapposizionex {q1 in Q, q2 in Q : q1 > q2} :
	abs(x[q2] - x[q1]) >= lati[q1]; 
subject to sovrapposizioney {q1 in Q, q2 in Q : q1 > q2} :
	abs(y[q2] - y[q1]) >= lati[q1]; 

#	OBIETTIVO


data;

param lati :=
    1      4
    2      6
    3      7
    4      3
    5      9;
var :   x   y:=
1    0          0
2    6.49726    0
3    0          7.41697
4   	0	   14
5   	7      7
;
end;
