reset;

#	DATI

param nCariche := 5;
set C := 1..nCariche;
									# numero di paesi concessi a ciascun cacciatore

#	VARIABILI
# le coordinate del punto di incontro si presume siano 0,0
var x {C};	# coordinate delle punte degli spilli
var y {C}; 
var z {C};
var distanze {c1 in C, c2 in C} = sqrt((x[c1] - x[c2])^2 + (y[c1] - y[c2])^2 + (z[c1] - z[c2])^2);

#	VINCOLI
# la distanza dall-origine deve rimanere la stessa
subject to origine {c in C} :
	sqrt(x[c]^2 + y[c]^2 + z[c]^2) = 1; # viene scelta una distanza unitaria

	
#	OBIETTIVO
# massimizzare la distanza fra le punte degli spilli (le cariche)
maximize distances : 
	sum {c1 in C, c2 in C} ((x[c1] - x[c2])^2 + (y[c1] - y[c2])^2 + (z[c1] - z[c2])^2);
	
data;
var :	x 	y 	z :=
1		1	1	1
2		2	2	2
3		3	3	3
4		4	4	4
5		5	5	5;

end;

MINOS 5.51: optimal solution found.
135 iterations, objective 50
Nonlin evals: obj = 349, grad = 348, constrs = 349, Jac = 348.
ampl: display distanze;
distanze [*,*]
:      1          2         3          4          5        :=
1   0          1.70616   1.89791    1.79349    0.519975
2   1.70616    0         1.52845    1.69087    1.37617
3   1.89791    1.52845   0          0.274218   1.99665
4   1.79349    1.69087   0.274218   0          1.96193
5   0.519975   1.37617   1.99665    1.96193    0
;

ampl: display x, y, z;
:       x            y            z         :=
1    0.655699    -0.749101     0.0943706
2   -0.732192     0.0526909    0.679057
3   -0.233588     0.794177    -0.560999
4   -0.0120247    0.713229    -0.700828
5    0.322106    -0.810996     0.4884
;