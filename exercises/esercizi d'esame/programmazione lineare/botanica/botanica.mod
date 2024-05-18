#   DATI
set piante ;    # insieme di tutti i tipi di piantina coltivabile
set sost ;      # set di tutti i possibili nutrienti necessari
param Amin := 5;        # metri quadri minimi per la coltivazione
param Amax := 100;      # metri quadri massimi per coltivazione singola
param Atot := 500;      # metri quadri massimi per la coltivazione
param Cstart := 50000;  # costo iniziale del progetto

param costi {sost};     # costi per ciascuna sostanza
param fab {piante, sost}; # fabbisogno di ogni sostanza per ogni pianta
param tempi {piante};   # tempi di crescita per ciascuna piantina in termini di giorni
param ricavi {piante};  # ricavi stimati per ogni piantina per ogni metro quadro coltivato

#   VARIABILI
var qt {piante} >= 0; # quantita' di terreno affidato ad ogni pianta

#   VINCOLI
# la quantita' massima di terreno coltivabile
subject to max_terreno_coltivabile :
    sum {p in piante} qt[p] <= Atot;

# per ogni pianta non posso coltivare piu' del massimo coltivabile
subject to max_per_pianta {p in piante}:
    qt[p] <= Amax;

#   OBIETTIVO
# ottimizzare il rendimento economico
maximize guadagni :
    sum {p in piante, s in sost} (qt[p] * ricavi[p] - fab[p, s] * costi[s]);

data;

set piante := A B C D E F G;
set sost := A S C L V ;

param costi :=
A   1
S   4
C   1
L   1.5 
V   3.6;

param fab :         A     S   C      L    V :=
A                    0.5       20      10        100       1.5
B                    0.8        3      12          3       0.5
C                    0.1        5       5          5       2.4
D                    0.2       90      50        450         3
E                    0.3       30       0         50         0
F                    0.8       60      20         40       1.5
G                    0.7        0      25        150         9;

param tempi :=
A        30 
B        40 
C        10 
D       100 
E         5 
F         5 
G        20;

param ricavi :=
A         6000 
B         4000 
C         2000 
D        18000 
E          100 
F          500 
G         7000 ;

end;

L'esperimento è conveniente dal punto di vista economico?
l'obiettivo risulta essere 18497781.16 quindi si , vi si presenta del guadagno

E' possibile espandere la capacità totale dell'area coltivata da 500 a 600 mq ad un prezzo di 1 Euro per ogni mq in più. Valutare la convenienza di tale opportunità.

Si vuole sapere in vista di esperimenti futuri qual è la pianta più redditizia e qual è la pianta meno redditizia da coltivare al Polo.

Name	Value	Type	LB	UB	Objective Coef	Primal	Dual
qt[A]	100	continuous	0	+inf	30000	100	0
qt[B]	100	continuous	0	+inf	20000	100	0
qt[C]	100	continuous	0	+inf	10000	100	0
qt[D]	100	continuous	0	+inf	90000	100	0
qt[E]	0	continuous	0	+inf	500	0	-2000
qt[F]	0	continuous	0	+inf	2500	0	0
qt[G]	100	continuous	0	+inf	35000	100	0
quella con il coefficietne piu alto risulta essere la pianta D

Un botanico giapponese suggerisce di usare un tipo di sali minerali, estratto dalle alghe marine, 
che rende la metà di quello considerato (nel senso che le piante ne hanno bisogno il doppio), ma costa un quarto. 
Valutare quantitativamente la proposta del botanico giapponese.
    guarda botanica2.mod

Infine si vuole sapere quale valore commerciale dovrebbe avere ogni mq di fragoline di bosco per renderne conveniente la coltivazione in quantità massima (100 mq).
