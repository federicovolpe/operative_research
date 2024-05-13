reset;

#	DATI

set robots := 1..6;
param raggi {robots};

#	VARIABILI
var x {robots};
var y {robots};

var distanze {r1 in robots, r2 in robots} =	
		sqrt((x[r1] - x[r2]) ^ 2 
		+ (y[r1] - y[r2]) ^2);

#	VINCOLI
# le distanze fra due robots non possono essere minori dei raggi
subject to distances {r1 in robots, r2 in robots : r1 > r2} :
	distanze[r1, r2] >= raggi[r1] + raggi[r2];
	
#	OBIETTIVO
minimize dist :
	sum {r1 in robots, r2 in robots : r1 > r2} 
	sqrt((x[r1] - x[r2]) ^ 2 
		+ (y[r1] - y[r2]) ^2);

data;

param raggi :=
1	120
2	80
3	100
4	70
5	45
6	120;

var :	x	y :=
1	1	2
2	3	4
3	5	6
4	7	8
5	9	0
6	0	9;

end;

distanze di MINOS:
MINOS 5.51: optimal solution found.
156 iterations, objective 3665.214846
Nonlin evals: obj = 325, grad = 324, constrs = 325, Jac = 324.
ampl: display distanze;
distanze [*,*]
:      1         2         3         4         5         6       :=
1     0       200       361.728   417.332   321.461   240
2   200         0       180       296.167   125       200
3   361.728   180         0       170       145       220
4   417.332   296.167   170         0       309.845   190
5   321.461   125       145       309.845     0       288.682
6   240       200       220       190       288.682     0
;