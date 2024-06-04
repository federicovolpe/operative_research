reset;

# la sequenza è da scegliere quindi il problema è combinatorio e molto complicato

#		DATI ####################################################################################

param nj := 7;
set job := 1..nj;
set P := 1..nj;
param p {job};			# processing time di ogni processo

param r {job};			# inizio e fine della finestra temporale di un job (release date)
param D {job};			# DEADLINE DI FINE

# 		VARIABILI ####################################################################################

var x {job, P} binary ;	# 
var t {P}; # 
var delta ;

#		VINCOLI ####################################################################################

# vincoli di assegnamento
subject to assignjob {j in P} :
	sum{i in job} x[i,j] = 1
;

subject to assignposizione {i in job} :
	sum{j in P} x[i,j] = 1
;

# tempo di inizio di ogni job in ogni posizione
subject to tempoiniz {j in P : j > 1} :
	t[j]  >= t[j-1] + sum{i in job} (p[i] * x[i, j-1])
;

subject to release {i in job}:
	sum{j in P} t[j] * x[i,j] >= r[i];
;	
subject to deadline {i in job}:
	sum{j in P} t[j] * x[i,j] <= D[i];
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
