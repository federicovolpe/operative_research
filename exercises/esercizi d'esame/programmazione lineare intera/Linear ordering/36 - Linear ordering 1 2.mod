# Linear Ordering Problem
# DATI
param n;            # Numeri di nodi
set N := 1..n;      # Set dei nodi
param c {N,N};      # Costi degli archi

# VARIABILI
var x {N,N} binary; #  x(i,j)=1 sse arco da i a j è selezionato, cioè i precede j nella sequenza
var posiz {N};      # Variabile ausiliaria per ricavare facilmente la posizione di ogni nodo nella sequenza

# VINCOLI
subject to OrientaCoppia {i in N, j in N: i<j}:
  x[i,j] + x[j,i] = 1;

# Formulazione 1
#subject to NoCicliTre {i in N, j in N, k in N: i<j and j<>k and i<k}:
#  x[i,j] + x[j,k] + x[k,i] <= 2;

# Formulazione 2
subject to Transitivity {i in N, j in N, k in N: i<>j and i<>k and j<>k}:
  x[i,j] + x[j,k] <= x[i,k] + 1;
  
# OBIETTIVO
minimize z: sum {i in N, j in N} c[i,j] * x[i,j];

subject to Posizione {i in N}:
  posiz[i] = 1 + sum {j in N: j<>i} x[j,i];  

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
