reset;

#	DATI
set palle := 1..17 ;		# set di tipi di palle presenti in un kit
param colore {palle} ;	# colori delle palle nel kit
param raggio {palle} ;	# raggio di ciascuna pallina nel kit [cm]

#	VARIABILI
# coordinate del centro di ciascuna pallina
var x {palle};	
var y {palle};
var z {palle};

# coordinate dei vertici della scatola
var xmax ;
var ymax ;
var zmax ;

var xmin ;
var ymin ;
var zmin ;

#	VINCOLI
# la scatola deve avere la forma di parallelepipedo

# gli spazi delle palline non possono sovrapporsi
subject to sovrapposizione {p1 in palle, p2 in palle : p2 > p1}:
	((x[p1] - x[p2])^2 + (y[p1] - y[p2])^2 + (z[p1] - z[p2])^2)	# distanza che separa i due centri 
	>= (raggio[p1] + raggio[p2])^2;

# coordinate dei vertici della scatola sono pari a bordi delle palline posti agli estremi
subject to xx {p in palle} : xmax >= x[p] + raggio[p];
subject to yx {p in palle} : ymax >= y[p] + raggio[p];
subject to zx {p in palle} : zmax >= z[p] + raggio[p];

subject to xn {p in palle} : xmin <= x[p] + raggio[p];
subject to yn {p in palle} : ymin <= y[p] + raggio[p];
subject to zn {p in palle} : zmin <= z[p] + raggio[p];

#	OBIETTIVO
# minimizzare il volume della scatola mantenendo la forma parallelepipedo
minimize volume :
	sqrt((xmin - xmax)^2 * 
	(ymin - ymax)^2 *
	(zmin - zmax)^2)
	;

data;

param raggio  :=
1     	2       
2     	2
3     	2
4      	4       
5      	4 
6      	3       
7      	3 
8      	3 
9		4	    
10		4
11		4
12		4
13    	2       
14     	2
15     	2
16     	3       
17     	3;

var : x y z :=
1 	0 	0 	0 
2 	0 	0 	5 
3 	0	5	0 
4 	5	0	0
5 	0 	0 	-5
6 	0	-5	0 
7 	-5	0	0
8 	0	0	10 
9 	0	10	0
10	10	0	0
11	0	0	-10
12	0	-10	0
13	-10	0	0
14	0	0	20
15	0	20	0
16	20	0	0
17	0	0	-20;

end;

SNOPT 7.5-1.2 : Optimal solution found.
1657 iterations, objective 1095.383046
Nonlin evals: obj = 95, grad = 94, constrs = 95, Jac = 94.
ampl: display x, y, z;
:       x           y            z         :=
1     2.48404    5.28596     -0.273107
2     2.60313    1.36653     -5.5944
3     1.77856    5.67558     -8.00707
4     3.97658   -3.24992     -2.01641
5    -8.23796   -3.24992    -10.0071
6    -2.14409   -2.24992     -6.7109
7    -1.04508    4.67558     -4.00369
8    -2.32391   -0.368301    -1.01641
9    -8.62441    3.67558     -6.02109
10    7.98103    3.67558     -2.05911
11    7.07006    3.67558    -10.0071
12   -8.62441   -3.24992     -2.01641
13   -3.08905    2.48579     -8.00707
14   -3.95852    5.664       -0.0622561
15   -6.58797    2.44019     -0.0164128
16    8.98103   -2.24992     -6.8076
17    3.39893   -2.20003     -9.00707
;

ampl: display xmax , ymax, zmax, xmin, ymin, zmin;
xmax = 11.981
ymax = 7.67558
zmax = 1.98359
xmin = -4.62441
ymin = 0.75008
zmin = -6.00707