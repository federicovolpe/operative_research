# quadrati - 41.2

# DATI
param n;
set Q := 1..n;

param lato{Q};

param b;
param h;

param M;

# VARIABILI
var x{Q};   # ascissa del centro del quadrato
var y{Q};   # ordinata del centro del quadrato

var dist{q in Q} = (x[q] - b/2)^2 + (y[q] - h/2)^2;

var activity{q in Q, other in Q, 1..4 : q < other} binary;

s.t. Simultaneita {q in Q, other in Q : q < other} :
    sum {i in 1..4} activity[q,other,i] <= 3
;

# VINCOLI
# inizio dopo che lui ha finito (x)
s.t. NonSovrapposizione_x_1 {q in Q, other in Q : q < other} :
    x[q] - lato[q]/2 >= x[other] + lato[other]/2 - M * activity[q,other,1]
;

# oppure finisco prima che lui inizi (x)
s.t. NonSovrapposizione_x_2 {q in Q, other in Q : q < other} :
    x[q] + lato[q]/2 <= x[other] - lato[other]/2 + M * activity[q,other,2]
;

# inizio dopo che lui ha finito (y)
s.t. NonSovrapposizione_y_1 {q in Q, other in Q : q < other} :
    y[q] - lato[q]/2 >= y[other] + lato[other]/2 - M * activity[q,other,3]
;

# oppure finire prima che lui inizi (y)
s.t. NonSovrapposizione_y_2 {q in Q, other in Q : q < other} :
    y[q] + lato[q]/2 <= y[other] - lato[other]/2 + M * activity[q,other,4]
;


s.t. Contenimento_x_right {q in Q} :
    x[q] + lato[q]/2 <= b
;
s.t. Contenimento_x_left {q in Q} :
    x[q] - lato[q]/2 >= 0
;
s.t. Contenimento_y_up {q in Q} :
    y[q] + lato[q]/2 <= h
;
s.t. Contenimento_y_down {q in Q} :
    y[q] - lato[q]/2 >= 0
;

# OBIETTIVO
minimize z : sum {q in Q} dist[q];

####################
data;
param n := 5;

param lato :=
    1      4
    2      6
    3      7
    4      3
    5      9
;

param b := 20;
param h := 30;


param M := 30; # max(b,h)

end;
