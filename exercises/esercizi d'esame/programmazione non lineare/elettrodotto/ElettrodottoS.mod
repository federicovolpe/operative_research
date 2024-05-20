reset;

#	DATI ------------------------------------------------------------------------------------------------------------
set cent := 1..16; # numero di paesini / centraline / cabine
param x {cent} ; # coordinate di ciascuna centralina
param y {cent} ;
param maxdistance := 2; # km di massima distanza fra la cabina e la centralina

param prec {cent};

#	VARIABILI ------------------------------------------------------------------------------------------------------------
var xc {c in cent} := x[c];	# coordinate delle cabine
var yc {c in cent} := y[c];

var aeree {cent} >= 0;		# distanze aeree fra la cabina e la precedente

#	VINCOLI ------------------------------------------------------------------------------------------------------------
# le cabine devono trovarsi nel raggio di 2km dalle corrispettive centraline
subject to distances {c in cent} :
	((xc[c] - x[c])^2 + (yc[c] - y[c])^2) <= maxdistance^2;
	

subject to line_aeree {c in cent} :
	aeree[c]^2 = (xc[prec[c]] - xc[c])^2 + (yc[prec[c]] - yc[c])^2; 

#	OBIETTIVO ------------------------------------------------------------------------------------------------------------

# Sempronio debba essere costruito in modo da minimizzare i costi complessivi. 
# Sapendo che ogni chilometro di scavo costa una volta e mezzo un chilometro di elettrodotto
minimize Sempronio :
	sum {c in cent}

data; # ------------------------------------------------------------------------------------------------------------

# considerando un albero, dove ogni nodo conosce il padre
param  prec :=
1		1
2		1
3		2
4		3
5		4
6		5
7		6
8		7
9		8
10		4
11		10
12		11
13		6
14		13
15		14
16		15;

param : x	y :=
1		0	0
2		4	8
3		10	12
4		15	12
5		22	28
6		31	30
7		40	34
8		42	46
9		50	50
10		25	15
11		32	15
12		37	10
13		46	13
14		31	38
15		28	45
16		35	54;

end;