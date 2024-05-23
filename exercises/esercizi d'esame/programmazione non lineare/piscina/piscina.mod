reset;

#	DATI

# coordinate del punto di minimo e di massimo del parco
param xmin := 0 ;
param xmax := 100 ;
param ymin := 0 ;
param ymax := 100 ;

set alberi := 1..9;
param xa {alberi} ;
param ya {alberi} ;

param rateo := 2/5;

set vertici := 0..3;

#	VARIABILI

# vertici di intersezione delle rette
var x {vertici} <= xmax, >= xmin ;
var y {vertici} <= ymax, >= ymin ;

var a {vertici} ;
var b {vertici} ;
var c {vertici} ;
	
#	VINCOLI
	
# vincolo soddisfacimento delle rette
subject to norm {v in vertici} :
	a[v]^2 + b[v]^2 = 1;

# le rette devono essere perpendicolari fra di loro
subject to perp0 {v1 in vertici, v2 in vertici : v2 = (v1 + 1) mod 4} :
	(a[v1] * a[v2]) + (b[v1] * b[v2]) = 0;
	
# vincolo sulle proporzioni
subject to proporzioni :
	(c[0]+c[2]) = 2/5 * (c[1]+c[3]);
	
# definizione dei punti di intersezione
subject to intersezionix {v1 in vertici, v2 in vertici : v2 = (v1+1) mod 4} :
	x[v1] = (c[v2] * b[v1] - c[v1] * b[v2])
			/(a[v1] * b[v2] - a[v2] * b[v1]);
subject to intersezioniy {v1 in vertici, v2 in vertici : v2 = (v1+1) mod 4} :
	y[v1] = (a[v2] * c[v1] - a[v1] * c[v2])
			/(a[v1] * b[v2] - a[v2] * b[v1]);	

# tutti gli alberi devono trovarsi al di fuori della piscina
#subject to fuori {al in alberi} :
#	 sum {v in vertici} .5 * abs(x[v] * (y[(v+1) mod 4] - ya[al]) +
#	 							x[(v+1) mod 4] * (ya[al] - y[v]) +
#	 							xa[al] * (y[v] - y[(v+1) mod 4]))  # la somma delle aree triangoli formati con il punto
#	 <= area;
	 

#	OBIETTIVO
maximize piscina: (c[0]+c[2]) * (c[1]+c[3]);

data;

param : xa   ya :=
   1     5   90
   2    85   10
   3    92   86
   4     7   12
   5    50   48
   6    52   25
   7    28   51
   8    73   50
   9    54   75;
   
var: 	a  	b	c:=
0		.5	.5	1
1		.5	-.5	1
2		-.5	-.5	2
3		-.5	.5	1;

end;


MINOS 5.51: optimal solution found.
14 iterations, objective 4081.632653
Nonlin evals: obj = 30, grad = 29, constrs = 30, Jac = 29.
ampl: display a, b, c;
:       a           b          c        :=
0    0.707107    0.707107   -50.5076
1    0.707107   -0.707107    50.5076
2   -0.707107   -0.707107    90.9137
3   -0.707107    0.707107    50.5076
;

ampl: display x, y;
:      x          y        :=
0     0         71.4286
1    28.5714   100
2   100         28.5714
3    71.4286     0
;