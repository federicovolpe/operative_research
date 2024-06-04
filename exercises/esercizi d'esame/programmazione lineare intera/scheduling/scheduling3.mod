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
# posso rinunciare ai cicli da 3 perchè l'ultimo vincolo impone la consecuzione temporale dei job

# se i precede j no può essere vero il contrario
subject to coppie {i in job, j in job : i <> j} :
	x[i,j] + x[j,i] = 1
;

param M := 999; # la massima distanza di job

#siccome il job 5 e 2 sembrano andare in conflitto aggiungo un vincolo lineare
# rendo i valori di t vengono resi crescenti !
subject to disgiuntivi {i in job, j in job : i <> j} :
	t[j] >= (t[i] + p[i]) - M * x[j, i]
;

#		OVIETTIVO ####################################################################################
# massimizzare l'anticipo totale
maximize z :
	sum{j in job} (D[j] - (t[j] + p[j]))
;


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
objective 180; optimality gap 0
355 nodes; 0 subproblem solves
