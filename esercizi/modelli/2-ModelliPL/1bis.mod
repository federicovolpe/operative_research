set posizioni:= 1..5;
set organi:= 1..7;

param a {organi,posizioni};  # Frazione assorbita dagli organi adiacenti
param t {posizioni};         # Frazione assorbita dal tumore
param limite {organi};       # Limite massimo assorbimento consentito per ogni organo
param intens {posizioni};    # Limite massimo radiazione erogabile da ogni posizione
param u := 600;              # Limite massimo complessivo per le radiazioni

var x {posizioni} >= 0;      # Intensit� radiazione da ciascuna posizione

#####################

maximize Radiazione_tumore:
  sum {p in posizioni} t[p] * x[p];

subject to Limite_max_posizione {p in posizioni}:
  x[p] <= intens[p];

subject to Limite_max_totale:
  sum {p in posizioni} x[p] <= u;

subject to Radiazione_organi {o in organi}:
  sum {p in posizioni} a[o,p] * x[p] <= limite[o];

#####################

data;

param a: 1 2 3 4 5 :=
 1   0.1      0.0      0.0       0.1      0.2
 2   0.1      0.0      0.15      0.0      0.1
 3   0.0      0.1      0.0       0.0      0.0
 4   0.0      0.2      0.1       0.1      0.0
 5   0.1      0.0      0.2       0.0      0.1
 6   0.1      0.3      0.15      0.1      0.1
 7   0.2      0.1      0.15      0.0      0.0
;

param t := 
1  0.40
2  0.30
3  0.25
4  0.70
5  0.50
;

param limite :=
 1     55
 2     90
 3     60
 4     24
 5     70
 6     55
 7     95
;

param intens :=
  1        120
  2        130
  3        100
  4        150
  5        150
;

end;
