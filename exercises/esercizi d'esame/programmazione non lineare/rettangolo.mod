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

var xc;
var yc;
var vert;
var oriz;

#	VINCOLI
# tutti i punti si devono trovare sopra yc - vert , sotto yc + vert
subject to up {p in punti}:
	y[p] >= yc - vert;
subject to down {p in punti}:
	y[p] <= yc + vert;
	
# tutti i punti si devono trovare a destra di xc - oriz ,a sinistra di xc + oriz
subject to right {p in punti}:
	x[p] >= xc - oriz;
subject to left {p in punti}:
	x[p] <= xc + oriz;


#	OBIETTIVO
minimize area :
	2 * vert * 2 * oriz;

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
  
end;
 
Dato un insieme di N punti nel piano cartesiano, 
si vuole trovare il rettangolo di minima area che li copre tutti.
	
N.B. Non è obbligatorio che il rettangolo abbia i lati 
paralleli agli assi cartesiani.