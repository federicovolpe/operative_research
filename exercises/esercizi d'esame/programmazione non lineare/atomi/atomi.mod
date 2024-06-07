reset;

#		DATI ###################################################################
param nat := 10;		# numero di atomi
set At := 1..nat;		# set di atomi
param x {At};		# coordinate tridimensionali degli atomi
param y {At};
param z {At};
param A {At};
param B {At};

#		VARIABILI ###################################################################
var xs;			# coordinate della sonda	
var ys;
var zs;
var dist {a in At} = abs(x[a] - xs)+ abs(y[a] - ys)+ abs(z[a] - zs);		# distanza di ogni atomo con la sonda
var energia {a in At} = (A[a] / dist[a]^12) - (B[a] / dist[a]^6);		# energia di ogni atomo rispetto alla sonda

#		VINCOLI ###################################################################


#		OBIETTIVO ###################################################################
# trovare la posizione di equilibrio della sonda
minimize e :
	sum{a in At} energia[a]
;

data;

param : x   y   z :=
  1    3.2 2.5 4.8
  2    2.1 3.7 8.4
  3    7.5 2.5 5.0
  4    6.6 1.2 4.5
  5    0.8 5.1 5.6
  6    6.3 8.8 3.5
  7    2.4 1.0 3.1
  8    1.2 4.6 9.0
  9    8.5 7.8 1.5
 10    4.1 9.3 0.9;
 
param:   A      B :=
  1    1.0    200
  2    1.1    400
  3    2.1    320
  4    3.0    250
  5    0.5    400
  6    0.2    200
  7    0.8    120
  8    1.1    300
  9    1.5    100
  10   1.7    500;
  
end;

Artelys Knitro 13.2.0:                        Knitro 13.2.0: Relative change in feasible objective < ftol for ftol_iters.
objective -4500.122879; feasibility error 0
245 iterations; 1521 function evaluations

suffix feaserror OUT;
suffix opterror OUT;
suffix numfcevals OUT;
suffix numiters OUT;
ampl: display xs, ys, zs;
xs = 2.4
ys = 1.19982
zs = 3.38714