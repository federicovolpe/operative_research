# Esercizio Cereali

# DATI

param nC;		# Numero di cereali
param nT;		# Numero di terreni
set C := 1..nC;	# Insieme dei cereali
set T:= 1..nT;	# Insieme dei terreni
param a {T,C};	# Consumo di superficie [acri/q]
param p {C};	# Prezzo di ogni cereale [�/q]
param h {C};	# Consumo di acqua [mc/q]
param s {T};	# Area disponibile in ogni terreno [acri]
param H;		# Acqua disponibile [mc]

# VARIABILI
var x {T,C} >=0;	# Produzione di ogni cereale su ogni terreno [q]

# VINCOLI
# Massima area disponibile su ogni terreno [acri]
subject to Area {i in T}: 					### Per ogni i in T avremo un vincolo
	sum {j in C} a[i,j] * x[i,j] <= s[i];	### x[i] fa riferimento al terreno, x[j] fa riferimento al cereale

# Massimo consumo di acqua [mc]
subject to Acqua:
  sum {i in T, j in C} h[j] * x[i,j] <= H;
  
#OBIETTIVO
#Massimizzare profitto totale [�]
maximize z : 
  sum {i in T, j in C} p[j] * x[i,j];

#########
data;
#########
param nC := 6;
param nT := 2;

param a:        1       2       3       4       5       6 :=
1	           0.02    0.03    0.02    0.016   0.05    0.04
2	           0.02    0.034   0.024   0.02    0.06    0.034;

param:    p          h    :=
1	     48		     0.120
2	     62		     0.160
3	     28		     0.100
4	     36		     0.140
5	    122		     0.215
6	     94		     0.180;

param s:=
1	200
2	400;

param H := 400000;

end;

