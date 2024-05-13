reset;

#	DATI
param npunti := 20;
set punti := 1..npunti;
param x {punti};
param y	{punti};
param bool {punti};

param M := 1000;

#	VARIABILI
var a;
var b;
var c;
var err {punti} binary ;

#	VINCOLI
# nessuna retta degenere ammissibile
subject to normalize :
	a^2 + b^2 = 1;
	
# tutti i falsi stanno da un lato
subject to false {p in punti : bool[p] = 0}:
	(a * x[p]) + (b * y[p]) + c >= M * err[p];
	
subject to true {p in punti : bool[p] = 1}:
	(a * x[p]) + (b * y[p]) + c <= M * err[p];

#	OBIETTIVO
minimize error:
	sum {p in punti} err[p];

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
Sono dati N oggetti. Ogni oggetto ha un insieme di tre attributi: 
i primi due sono le coordinate in uno spazio Euclideo bidimensionale; 
il terzo è un attributo di tipo logico, “vero” o “falso”. 
Si vuole trovare la retta che separa i punti in due sottoinsiemi 
in modo che tutti i punti “veri” giacciano da un lato e tutti i punti “falsi” 
dall’altro rispetto alla retta. Se ciò non è possibile, si vuole comunque minimizzare 
il numero di punti che cadono dalla parte sbagliata rispetto alla retta.