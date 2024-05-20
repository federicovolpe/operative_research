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

var aeree {c in cent} = sqrt((xc[prec[c]] - xc[c])^2 + (yc[prec[c]] - yc[c])^2);		# distanze aeree fra la cabina e la precedente

#	VINCOLI ------------------------------------------------------------------------------------------------------------
# le cabine devono trovarsi nel raggio di 2km dalle corrispettive centraline
subject to distances {c in cent} :
	((xc[c] - x[c])^2 + (yc[c] - y[c])^2) <= maxdistance^2;
	

#	OBIETTIVO ------------------------------------------------------------------------------------------------------------

# Caio sostiene che sia necessario minimizzare la lunghezza complessiva dei cavi ad alta tensione
minimize caio:
	sum {c in cent} aeree[c];

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

caio:
ampl: display xc, yc;
:       xc         yc       :=
1     1.26893    1.5459
2     5.37278    6.54554
3    10.784     10.1601
4    16.3058    13.5149
5    22.6358    26.1037
6    32.3689    28.5419
7    38.5496    35.3771
8    42.7101    44.1303
9    48.4422    48.7457
10   23.55      13.6225
11   30.6137    13.5584
12   35.2529    10.9735
13   44.8492    14.6357
14   32.2221    36.4168
15   29.9831    44.7409
16   34.0472    52.2415
;