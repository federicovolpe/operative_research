# copiare da quello che ha caricato il prof
#	DATI
set robot := 1..6;
param raggi {robot};	# ragggi [mm]

#	VARIABILI
var x {robot};	# coordinata del centro per ogni robot
var y {robot};	# coordinata del centro di raggio per ogni robot

var distanza {robot, robot}; # distanza fra i centri dei robot

var d2 {robot, robot};
#	VINCOLI
# la distanza dei due centri deve essere maggiore della somma dei due raggi
subject to sovrapposizioni {i in robot, j in robot : i < j }:
	distanza[i,j] >= raggi[i] + raggi[j];

# vincolo per la inizializzazione della variabile distanza
subject to distanze {i in robot, j in robot}:
	distanza[i, j] = sqrt((x[i] - x[j])^2 - (y[i]- y[j])^2);

#	OBIETTIVO
# minimizzazione delle distanze
minimize z : 
	sum {i in robot, j in robot: i < j} distanza[i,j];

data;

param raggi :=
  1      120
  2       80
  3      100
  4       70
  5       45
  6      120;

# inizializzazione delle variabili x, y poichè con tutti 0 non funziona
#var: x y :=
#1 	0 	0
#2 	10 	10
#3 	-10 -10
#4	20 	20
#5 	-20 -10
#6 	10 	0
# partenza inammissibile dato che il primo ha raggio 120

var: x y :=
1 	0 	0
2 	1000 	1000
3 	-1000 -1000
4	2000 	2000
5 	-2000 -1000
6 	1000 	0;

end;