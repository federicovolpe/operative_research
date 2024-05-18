# modificati i parametri per rispettare quelli dei nuovi sali

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
S   2
C   1
L   1.5 
V   3.6;

param fab :         A     S   C      L    V :=
A                    0.5       40      10        100       1.5
B                    0.8        6      12          3       0.5
C                    0.1        10       5          5       2.4
D                    0.2       180      50        450         3
E                    0.3      60       0         50         0
F                    0.8       120      20         40       1.5
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
