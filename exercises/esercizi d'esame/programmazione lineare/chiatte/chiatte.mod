#		DATI
set C := 1..2;    # set dei canali disponibili
set D := 1..2;       # direzioni possibili per ciascun canale 1 = salita 2 = discesa
param l{C};         # lunghezza della strettoia km
param v{C};	        # velocità  della corrente km / h

param V := 10;     # velocità delle chiatte rispetto all'acqua
param cap := 1500;  # capacità delle chiatte

#		VARIABILI
var flussi {C,D} >= 0; # flussi in termini di [chiatte/h]

# 		VINCOLI
# vincolo di conservazione del flusso
subject to Conservazione_flusso: # per ogni canale la somma dei flussi in salita deve essere pari
  sum {c in C} flussi[c,1] = sum {c in C} flussi[c,2]; # ai flussi in discesa

# siccome il numero di chiatte è limitato, il numero di chiatte che sale sarà
# uguale al numero di chiatte che scende
subject to Strettoie {c in C}:
  flussi[c,1] * l[c]/(V - v[c]) # numero di chiatte che attraversano la strettoia in salita 
  + flussi[c,2] * l[c]/(V+v[c]) <= 1; # che attraversano in discesa


#		OBIETTIVO
# massima quantità di merce per unità di tempo che si può trasportare da valle a monte 
# e da monte a valle in questo modo
maximize flux :
  sum{c in C, d in D} flussi[c,d]
;

data;

# Canale   Lunghezza della strettoia   Velocità della corrente
param :             l                      v :=
  1                0.5                     2
  2                0.75                    1 
;

end;
