reset;

#	DATI ------------------------------------------------------------------------------------
param npunti := 20;
set punti := 1..npunti;

param x {punti};			# coordinate dei punti
param y	{punti};			
param bool {punti};			# valori di verità

param M := 1000;

#	VARIABILI ------------------------------------------------------------------------------------
var a;
var b;
var c;

var err {punti} binary ;
var delta >= 0;

#	VINCOLI ------------------------------------------------------------------------------------
# nessuna retta degenere ammissibile
subject to normalize :
	a^2 + b^2 = 1;
	
# tutti i falsi stanno da un lato
subject to false {p in punti : bool[p] = 0}:
	(a * x[p]) + (b * y[p]) + c >= delta - M * err[p]; # per  rilevare la disattivazione del vincolo
	
subject to true {p in punti : bool[p] = 1}:
	(a * x[p]) + (b * y[p]) + c <= - delta + M * err[p];

#	OBIETTIVO ------------------------------------------------------------------------------------
# minimizzazione dei punti fuori posto 
minimize error:
	sum {p in punti} err[p];


# massimizzazione dell'errore minimo
subject to outliers : 		# sostituzione del'obiettivo precedente con un vincolo
	sum {p in punti} err[p] <= 5;
	
maximize d: delta;

data;

param : x	 y     bool :=
  1    12   29     1
  2    16   26     1
  3    24   25     1
  4     8    7     1
  5    30   50     1
  6    11   41     1
  7     5    2     1
  8     6   11     1
  9    40   12     1
 10    23   27     1
 11    21   43     1
 12    51   18     1
 13     2   36     0
 14     2   33     0
 15    11    6     0
 16    33    7     0
 17    28   45     0
 18    25   42     0
 19    20   50     0
 20    20   18     0;

# inizializzazione della retta
var a = 1;
var b = 1;
var c = 1;

end;

1)
ampl: display err;
err [*] :=
 1  0
 2  0
 3  0
 4  0
 5  0
 6  0
 7  0
 8  0
 9  0
10  0
11  0
12  0
13  0
14  0
15  1
16  1
17  1
18  1
19  0
20  1
;

ampl: display a, b, c;
a = -0.691192
b = 0.722671
c = -22.0959

ampl: display delta;
delta = 0.0355629

2) 
ampl: display delta;
delta = 0.0260291

ampl: display err;
err [*] :=
 1  0
 2  0
 3  0
 4  0
 5  0
 6  0
 7  0
 8  0
 9  0
10  0
11  0
12  0
13  0
14  0
15  1
16  1
17  1
18  1
19  0
20  1
;

ampl: display a, b , c;
a = -0.691835
b = 0.722055
c = -22.2264
