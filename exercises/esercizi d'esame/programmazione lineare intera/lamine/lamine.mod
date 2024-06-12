#       DATI    ########################################
param L = 100;      # lunghezza di ogni lamina madre      [m]
param W := 4;       # larghezza di ogni lamina madre      [m]

param nc := 9;      # numero di clienti
set C := 1..nc;     # set dei clienti
param n {C};        # numero di lamine richieste da ciascun cliente   
param w {C};        # larghezza delle lamine richieste per ogni cliente [m]

param nl := ceil(sum{c in C} (w[c] * n[c]) / W);
set LM := 1..nl;  # set di lastre madre

#       VARIABILI    ########################################
var assign {LM, C} integer, >= 0;   # assegnamento di n lamine di ogni lastra a uno cliente
var use {LM} binary;

#       VINCOLI    ########################################
# la somma delle larghezze per il numero di lamine richieste da ogni LM deve essere inferiore al suo spessore
subject to assegnamento_larghezza {l in LM} :
     sum{c in C} (assign[l,c] * w[c]) <= W * use[l]
;

# per ogni cliente devono essere assegnate il numero di lastre richieste
subject to lamine_richieste {c in C} :
     sum{l in LM} assign[l, c] = n[c]
;

# vincolo di simmetria per riempire le lastre dalla prima all'ultima
 subject to symm {l in LM : l > 1} :
    sum{c in C} assign[l,c] <= sum{c in C} assign[l-1, c]
;

#       OBIETTIVO    ########################################
# minimizzazione del numero di lastre madri utilizzate
minimize z :
     sum{l in LM} use[l]
;

data;

param :        n             w :=
   1           3             0.40
   2           2             1.30
   3           1             2.50
   4           2             1.25
   5           3             0.50
   6           1             1.75
   7           2             1.20
   8           1             1.10
   9           1             0.45
;

end;
