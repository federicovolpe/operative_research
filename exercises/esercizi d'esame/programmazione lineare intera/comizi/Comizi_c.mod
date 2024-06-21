# Comizi elettorali
# DATI
set Cities;				# Insieme di città
param s {Cities};		# Distanza da A [km]
param nT;				# Numero di tipi di comizio
set Tipi := 1..nT;		# Insieme indicizzato dei tipi di comizio
param d {Tipi};			# Durata di ogni tipo di comizio [min]
var v;				# Velocità [km/h]
param F;				# Tempo fisso [min]
param Tmax;				# Tempo disponibile [min]
param a {Cities,Tipi};	# Numero di elettori in ogni città per tipo di comizio

# VARIABILI
#  Scelte delle città in cui fermarsi e dei tipi di comizio
var x {c in Cities,Tipi} binary;
var y {c in Cities,Tipi} binary;
# Tempi fissi
var Tfx;
var Tfy;
# Durate dei comizi
var Tcx;
var Tcy;
# Tempi di viaggio
var Tvx;
var Tvy;
# Elettori arringati
var zX;
var zY;

# VINCOLI
# Non più di un comizio per ogni città
subject to UnComizioX {c in Cities}: sum {t in Tipi} x[c,t] <= 1;
subject to UnComizioY {c in Cities}: sum {t in Tipi} y[c,t] <= 1;
  
# Durata totale dei comizi
subject to TempoComiziX: Tcx = sum {c in Cities, t in Tipi} d[t] * x[c,t];
subject to TempoComiziY: Tcy = sum {c in Cities, t in Tipi} d[t] * y[c,t];

# Tempi fissi
subject to TempoFissoX: Tfx = F * sum {c in Cities, t in Tipi} x[c,t];
subject to TempoFissoY: Tfy = F * sum {c in Cities, t in Tipi} y[c,t];

# Tempi di viaggio
subject to TempoViaggioX {c in Cities}: v/60 * Tvx >=  s[c] * sum {t in Tipi} x[c,t];
subject to TempoViaggioY {c in Cities}: v/60 * Tvy >=  (s['Y']-s[c]) * sum {t in Tipi} y[c,t];

# Tempo totale disponibile
subject to TempoTotaleX: Tcx + Tfx + Tvx <= Tmax;
subject to TempoTotaleY: Tcy + Tfy + Tvy <= Tmax;

# Elettori arrigati
subject to ElettoriX: zX = sum {c in Cities, t in Tipi} a[c,t] * x[c,t];
subject to ElettoriY: zY = sum {c in Cities, t in Tipi} a[c,t] * y[c,t];

# Più elettori X
param zopt := 2980;
subject to ElX: zY >= zopt + 1;

# OBIETTIVO
# Minima velocità che consente di arringare più elettori
minimize z: v;

############################
data;
param nT   :=   2;
#param v    := 100;
param F    :=  30;
param Tmax := 960;

param d :=
1	60
2	90;

set Cities := A B C D E F G H I J K L M N O P Q R S T U V W X Y;

param s :=
A         0
B        12
C        25
D        31
E        46
F        60
G        72
H        89
I       110
J       127
K       142
L       160
M       166
N       170
O       180
P       193
Q       211
R       218
S       230
T       244
U       263
V       280
W       285
X       292
Y       298;

param a:  1       2 :=
A       120     140   
B        80     200  
C        60     100 
D       400     450
E       200     250
F        10      30   
G       500     550   
H        90     110   
I        50      80   
J       300     330   
K        10      50   
L        60      90   
M       230     280   
N       190     240   
O       100     150   
P       100     110   
Q       100     180   
R       200     300   
S        80     180   
T        10      20   
U        80     150   
V        90     100   
W       120     130  
X       500     650  
Y       400     490;

end;
