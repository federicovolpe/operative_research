reset;

#	DATI
set sottins := 0..2;	# sottoinsiemi di punti
	
param npunti {sottins};	# numero di punti presenti in ogni sottoinsieme

set punti {s in sottins} := 1..npunti[s];	# set di punti per ogniuno dei sottoinsiemi

param x{s in sottins, punti[s]};
param y{s in sottins, punti[s]};

#	VARIABILI

# punto di origine
var xo ;
var	yo ;

# parametri di definizione di una retta
var a {sottins};
var b {sottins};
var c {sottins};

#	VINOLI
#	TUTTE LE VOLTE CHE SI TRATTA CON LE LETTERE, RICORDARSI DI NORMALIZZARE A B
subject to normalize {s in sottins} :
	a[s]^2 + b[s]^2 = 1;

# per ogni insieme tutti i punti devono trovarsi o a destra o a sinistra
subject to dx {s in sottins, p in punti[(s+1) mod 3]} :
	(a[s] * x[(s+1) mod 3, p]) + (b[s] * y[(s+1) mod 3, p]) + c[s] >= 0;

subject to sx {s in sottins, p in punti[s]} :
	(a[s] * x[s, p]) + (b[s] * y[s, p]) + c[s] <= 0;
	
# le tre semirette devono avere un punto in comune
subject to origine {s in sottins} :
	(a[s] * xo) + (b[s] * yo) + c[s] = 0;

#	OBIETTIVO
# minimizzazione della distanza del punto origine dall-origine degli assi
minimize distance :
	xo^2 + yo^2;
	
# massimizzazione della distanza...
#maximize distance:
#	xo^2 + yo^2;

data;

param npunti :=
0	8
1	6
2	12;

param x (tr) :   0   1       2 :=
  	1   	-5  -10     -3 	
  	2   	10  -4      -1 	
  	3    	5   -19     1 	
  	4    	3   -11     -2 	
  	5   	-1  -7      11 	
  	6   	-2  -12     2 	
  	7    	2 	.       3  	
  	8   	10  .       0 	
    9       .   .       1 	
    10      .   .       2 	
    11      .   .       -3 	
    12      .   .       -4 	;

param y (tr) :    0       1       2 :=
    1       12      2       -6
    2       8       3       -8
    3       5       15      -5
    4       0       0       -9
    5       3       -3      -1 
    6       9       -9      -9 
    7       10      .       0   
    8       6       .       -2   
    9       .       .       -8   
    10      .       .       -2   
    11      .       .       -6   
    12      .       .       -9   ;

# inizializzazione di a b c, se fossero 0 sarebbero rette degeneri
var:	a	b	c :=
0		1	1	1
1		1	1	1	
2		1	1	1	;

end;
 
E’ dato un insieme di punti nel piano Cartesiano, divisi in tre sottinsiemi. Si vuole trovare un modo di separare i tre sottinsiemi con tre semirette aventi l’origine in comune. Tra i vari modi in cui è possibile ottenere la partizione si vuole scegliere quello per cui l’origine risulta:
il più possibile vicino all’origine degli assi Cartesiani
il più lontano possibile dall’origine degli assi Cartesiani
all’interno di un quadrato di lato 2 con lati paralleli agli assi e centrato nell’origine degli assi
all’esterno del quadrato suddetto.


