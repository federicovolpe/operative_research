# Linear Ordering Problem
# DATI
param n;            # Numeri di nodi
set N := 1..n;      # Set dei nodi e delle posizioni
param c {N,N};      # Costi degli archi

# VARIABILI
var x {N,N} binary; # Assegnamento nodo a posizione
var y {N,p in N,N,q in N: p < q} >=0, <=1;

# VINCOLI
# Assegnamento tra nodi e posizioni
subject to UnNodoPerPosiz {p in N}:
  sum {i in N} x[i,p] = 1;
subject to UnaPosizPerNodo {i in N}:
  sum {p in N} x[i,p] = 1;

# OBIETTIVO
# Minimizzare i costi degli archi (i,j) tali che i precede j nella sequenza
# Variante quadratica
#minimize z: sum {i in N, j in N, p in N, q in N: p<q} c[i,j] * x[i,p] * x[j,q];
# Variante linearizzata
minimize z: sum {i in N, j in N, p in N, q in N: p < q} c[i,j] * y[i,p,j,q];
subject to Forzareya1 {i in N, j in N, p in N, q in N: p < q}:
  x[i,p] + x[j,q] <= y[i,p,j,q] + 1;
subject to Forzareya0a {i in N, j in N, p in N, q in N: p < q}:
  x[i,p] >= y[i,p,j,q];
subject to Forzareya0b {i in N, j in N, p in N, q in N: p < q}:
  x[j,q] >= y[i,p,j,q];

#############################
data;

param n := 7;

param c :    1   2   3   4   5   6   7 :=
1            0  68  81  23  45  20  37
2           12   0  25  51  57  89  78
3           34  27   0  12   9  71  20
4           95  55  42   0   8  23  44
5           60  60  51  34   0   2  40
6           93  22  48  45  24   0  77
7           75  64  36  25  16  21   0;

end;
