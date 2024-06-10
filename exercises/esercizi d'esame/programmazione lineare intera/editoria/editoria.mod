#		DATI	############################################################
param na := 12 ;	# numero di articoli
set A := 1..na;		# set di articoli
param pg {A};		# numero di pagine per ciascun articolo
param U {A}; 		# grado di urgenza per l'articolo

param nf := 3 ; 		# numero di fascicoli
set F := 1..nf;	# set dei fascicoli
param pgf := 44; 	# numero di pagine per ogni fascicolo

#		VARIABILI	############################################################
# per stabillire se un articolo viene o meno incluso e in quale fascicolo
var assign {A, F} binary;
 
#		VINCOLI	############################################################
# ogni articolo può solo essere assegnato ad un solo fascicolo
subject to assegnamento {a in A}:
	sum{f in F} assign[a, f] <= 1
;
# per ogni fascicolo il numero di pagine degli articoli contenuti non deve superare le pagine del fascicolo
subject to paginemax {f in F} :
	sum{a in A} pg[a] * assign[a, f] <= pgf
;

#		OBIETTIVO	############################################################
# massimizzare il numero di articoli nella publicazione
maximize narticoli : 
	sum{f in F, a in A} assign[a, f] 
;

data;

param : 	pg			U :=
   1          5         2
   2         11			0
   3         17         2
   4         10			0
   5         18         3 
   6          8			0
   7         14			0
   8          9         1
   9         16         1
   10         12		0
   11         14		0
   12         13		0
;
#Gli articoli indicati dagli asterischi sono i più urgenti: 
#3 asterischi => non dopo il primo fascicolo
#2 asterischi => non dopo il secondo fascicolo
#1 asterisco  => non dopo il terzo fascicolo

end;
