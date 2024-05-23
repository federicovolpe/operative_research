reset;

#	DATI
set punti := 1..10;
param x{punti};
param y{punti};
set lati := 0..3;

#	VARIABILI
# definizione delle 4 segmenti del rettangolo
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

subject to perp1 :
	a[0] = -a[2];
subject to perp2 :
	b[0] = -b[2];
subject to perp3 :
	a[1] = -a[3];
subject to perp4 :
	b[1] = -b[3];
	
# tutti i punti devono trovarsi da un lato della retta (per due rette)
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
 
Dato un insieme di N punti nel piano cartesiano, 
si vuole trovare il rettangolo di minima area che li copre tutti.
	
N.B. Non è obbligatorio che il rettangolo abbia i lati 
paralleli agli assi cartesiani.