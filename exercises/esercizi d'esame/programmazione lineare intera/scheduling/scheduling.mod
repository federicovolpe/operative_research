reset;

# la sequenza è da scegliere quindi il problema è combinatorio e molto complicato

#		DATI ####################################################################################

param nj := 7;
set job := 1..nj;
param p {job};			# processing time di ogni processo

param r {job};			# inizio e fine della finestra temporale di un job (release date)
param D {job};			# DEADLINE DI FINE


# 		VARIABILI ####################################################################################

var x {j1 in job, j2 in job : j1 <> j2} binary ;	# matrice binaria che dice chi viene prima di chi (riga precede colonna)
var t {j in job} >= r[j], <= D[j] - p[j]; # istante di inizio di ogni job (inferiore a tutti i tempi di processing precedenti)
var delta ;

#		VINCOLI ####################################################################################
# vietare i cicli di ordine 3 come nell'esercizio "linear ordering"
subject to cicli3 {i in job,j in job, k in job : i < j and i < k and j <> k} :
	x[i,j] + x[j,k] + x[k,i] <= 2 # le precedenze devono essere massimo 3 
;

# se i precede j no può essere vero il contrario
subject to coppie {i in job, j in job : i <> j} :
	x[i,j] + x[j,i] = 1
;

# sommando le durate dei job precedenti non si arriva a quello di job j
subject to tempo_iniziale {j in job} :
	t[j] >= sum{i in job : i <> j} p[i] * x[i, j]
;

#		OVIETTIVO ####################################################################################
# minimizzare il tempo necessario per completarli tutti 
minimize z1 :
	delta;	# l'ultimo tempo

subject to makespan {j in job}:
	delta >= t[j] + p[j] 
;
# minimizzare il tempo medio di completamento

data; ####################################################################################

param p :=
  1   10  
  2   14  
  3   21  
  4   18  
  5    4  
  6   23  
  7   35
 ;


# Tabella 2: Finestre temporali
param :  r     	D :=
  1     15      50
  2      0      80
  3      0      95
  4     10      75
  5      5      30
  6     13     130
  7     18     120
;

end;
Artelys Knitro 13.2.0:                        Knitro 13.2.0: Locally optimal or satisfactory solution.
objective 125; optimality gap 0
117 nodes; 0 subproblem solves
ampl: display x, t;
x [*,*]
:   1   2   3   4   5   6   7    :=
1   .   0   1   1   1   1   1
2   1   .   1   1   1   1   1
3   0   0   .   0   0   1   1
4   0   0   1   .   0   1   1
5   0   0   1   1   .   1   1
6   0   0   0   0   0   .   0
7   0   0   0   0   0   1   .
;

t [*] :=
1   40
2   66
3   74
4   57
5   26
6  102
7   85
;