# DATI
set caramelle := {"Dolce", "Delizia", "Bacetto", "Golosa", "Sfizio", "Slurp", "Sweety"};
set ingredienti := {"Fruttosio", "Saccarosio", "Glucosio", "Destrosio", "Estratti di erbe", "Estratti di frutta", "Coloranti", "Conservanti", "Aromatizzanti"};
param proporzioni {ingredienti, caramelle};
param disponibilita {ingredienti};
param costi {ingredienti};
param prezzi {caramelle};

# VARIABILI
# numero di caramelle prodotte per ogni tipo
var prodotte {caramelle} >= 0;

# VINCOLI
#1 non eccedere gli ingredienti disponibili per la produzione
subject to limite_scorte {i in ingredienti} :
	sum {c in caramelle} proporzioni[i,c]/100 * prodotte[c] <= disponibilita[i];

# OBIETTIVO
# massimizzare i guadagni
maximize z : 
	sum {c in caramelle} prodotte[c] * prezzi[c];

data;

param proporzioni :Dolce Delizia Bacetto Golosa Sfizio Slurp Sweety :=
Fruttosio           30      0       5       5      5    10     10
Saccarosio          20     30       0       5      5     5     10
Glucosio            15     20      30       0      5     5      5
Destrosio           10     15      20      30      0     5      5
"Estratti di erbe"    10     10      15      20     30     0      5
"Estratti di frutta"   5     10      10      15     20    30      0
Coloranti            5      5      10      10     15    20     30
Conservanti          5      5       5      10     10    15     20
Aromatizzanti        0      5       5       5     10    10     15;

# disponibilità degli ingredienti (Kg/giorno)
param disponibilita :=
Fruttosio            9
Saccarosio           5
Glucosio            20
Destrosio           18
"Estratti di erbe"    20
"Estratti di frutta"  17
Coloranti           18.4
Conservanti         12.5
Aromatizzanti       10;

# I prezzi degli ingredienti (Euro/Kg)
param costi :=
Fruttosio           4
Saccarosio          2
Glucosio            1
Destrosio           3.5
"Estratti di erbe"    8
"Estratti di frutta" 10
Coloranti           2
Conservanti         5 
Aromatizzanti       6;

# I prezzi di vendita delle caramelle (Euro/Kg)
param prezzi :=
Dolce   5
Delizia 4
Bacetto 8
Golosa  5
Sfizio  6
Slurp   7.5
Sweety  4.5;

# Tutte le caramelle pesano 10 grammi.
end;