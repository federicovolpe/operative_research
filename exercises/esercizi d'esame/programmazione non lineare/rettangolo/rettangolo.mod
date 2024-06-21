reset;

#	DATI
set punti := 1..10;
param x{punti};
param y{punti};
set lati := 0..3;

#	VARIABILI
# variabili per la definizione delle 4 rette del rettangolo
var a{lati};
var b{lati};
var c{lati};

#	VINCOLI
# normalizzazione
subject to normalize {l in lati} :
	a[l]^2 + b[l]^2 = 1;
	
# vincoli di perpendicolarita' delle rette
subject to perp0 {l1 in lati, l2 in lati : l2 = (l1 + 1) mod 4} :
	a[l1]*a[l2] + b[l1]*b[l2] = 0;

# vincoli per la direzione delle rette dato che i punti si dovranno trovare
# versione breve (una volta per la a e una volta per la b)
subject to verso_a {r1 in lati, r2 in lati: r1 = (r2+2) mod 4}:
	a[r1] = -a[r2];
subject to verso_a {r1 in lati, r2 in lati: r1 = (r2+2) mod 4}:
	b[r1] = -b[r2];
# versione estesa
subject to dir1 :
	a[0] = -a[2];
subject to dir2 :
	b[0] = -b[2];
subject to dir3 :
	a[1] = -a[3];
subject to dir4 :
	b[1] = -b[3];
	
# tutti i punti devono trovarsi da un lato di ogni retta (dato il suo verso)
subject to up {p in punti, l in lati}:
	a[l]*x[p] + b[l]*y[p] + c[l] >= 0;

#	OBIETTIVO
# rettangolo di minima area che ricopra tutti i punti
minimize area :
	(c[0] + c[2])*(c[1] + c[3]);

data;

param :	x	y	:=
1     	-7  -2 
2	   	-3   5
3  		-4	5
4  		10	5
5  		11	2
6  		6	9
7  		0	-6
8  		-6	2
9  		9	0
10 		-7	0;

var :	a	b	c :=
0		.5	.5	10
1		.5	-.5	10
2		-.5	-.5	20
3		-.5	.5	10;

end;
 
 
MINOS 5.51: optimal solution found.
10 iterations, objective 205
Nonlin evals: obj = 15, grad = 14, constrs = 15, Jac = 14.
ampl: display a, b, c;
:      a          b          c        :=
0    0.83205    0.5547     6.93375
1    0.5547    -0.83205    6.37905
2   -0.83205   -0.5547    11.094
3   -0.5547     0.83205    4.9923
;
Discussione:
la soluzione trovata potrebbe non essere l'unica poiche'
anche solo semplicemente applicando una rotazione al quadrato si potrebbero
scoprire nuovi minimi locali.
non e' quindi detto che si tratti di un minimo globale