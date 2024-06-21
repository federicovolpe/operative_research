# Esercizio PLI 64: Numero esatto

# DATI
param n;                        # Numero di simboli e posizioni
set P := 0..n-1;                # Insieme delle posizioni
set C := 0..n-1;                # Insieme dei simboli
param nS;                       # Numero di sequenze
set S := 1..nS;                 # Insieme delle sequenze
param M {S,P,C} default 0;      # Assegnamenti simbolo-posizione nelle sequenze date
param e {S};                    # Numero di simboli coincidenti per ogni sequenza data

# VARIABILI
var x {P,C} binary;             # Assegnamento simbolo-posizione nella sequenza da trovare

# VINCOLI
# Assegnamento: una posizione per ogni cifra
subject to Assign1 {c in C}:
  sum {p in P} x[p,c] = 1;
# Assegnamento: una cifra per ogni posizione
subject to Assign2 {p in P}:
  sum {c in C} x[p,c] = 1;

# Numero di coincidenze richieste rispetto ad ogni sequenza data
# I vincoli descritti nel testo vengono intesi come vincoli di uguaglianza
subject to Coincidenze {s in S}:
  sum {p in P, c in C} M[s,p,c] * x[p,c] = e[s];

###############################
data;

param n := 10;
param nS := 4;

param M :=
[1,0,2] 1
[1,1,4] 1
[1,2,5] 1
[1,3,3] 1
[1,4,1] 1
[1,5,6] 1
[1,6,9] 1
[1,7,0] 1
[1,8,8] 1
[1,9,7] 1

[2,0,6] 1
[2,1,8] 1
[2,2,7] 1
[2,3,1] 1
[2,4,2] 1
[2,5,0] 1
[2,6,9] 1
[2,7,4] 1
[2,8,3] 1
[2,9,5] 1

[3,0,3] 1
[3,1,0] 1
[3,2,9] 1
[3,3,2] 1
[3,4,1] 1
[3,5,8] 1
[3,6,4] 1
[3,7,5] 1
[3,8,7] 1
[3,9,6] 1

[4,0,2] 1
[4,1,4] 1
[4,2,1] 1
[4,3,3] 1
[4,4,0] 1
[4,5,8] 1
[4,6,9] 1
[4,7,5] 1
[4,8,7] 1
[4,9,6] 1;

# In A ci sono due cifre in posizione errata: e[1] = 8
# In B ce ne sono due in posizione esatta; e[2] = 2
# In C un’unica cifra è in posizione esatta: e[3] = 1
# In D sei sono in posizione errata: e[4] = 4

param:   e :=
1        8
2        2
3        1
4        4;

end;

