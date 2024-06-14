reset;

#	DATI	#######################################################
param np := 3;		# numero di prodotti
param nm := 5;		# numero di materie prime
set P := 1..np;		# set di prodotti
set M := 1..nm;		# set di materie prime
set coef;			# set di coefficienti per il calcolo dei prezzi

param comp {M,P};	# composizione dei prodotti (unità di materia per ogni unità di prodotto)
param parametri {P,coef};# parametri per il calcolo dei prezzi
param disp {M};		# disponibilità di materie prime

#	VARIABILI	#######################################################
var qp {P} >= 0; 	# quantità da produrre per ogni prodotto	
var prezzi {P} >= 0;	# prezzi di vendita per ogni prodotto

#	VINCOLI	#######################################################
# relazione prezzo e quantità disponibile
subject to relazione {p in P}:
	prezzi[p] = parametri[p,'Alfa'] + parametri[p,'Beta'] * 2.71 ^ (- parametri[p, 'Gamma'] * qp[p])  
;

# limiti di produzione dovuti alla quantità limitata di materie prime
subject to limiti_disponibilita {m in M}:
	sum{p in P} comp[m,p] <= disp[m]
;

#	OBIETTIVO	#######################################################
# massimizzazione dei guadagni
maximize g :
	sum{p in P} prezzi[p] * qp[p] ;

data;

set coef := Alfa, Beta, Gamma;

param comp : 1    2    3 :=
   1        20   15   30
   2        12   18   40
   3        25   21   30
   4        30   38   18
   5        25   12   33;

param parametri : Alfa   Beta   Gamma :=
   1        50     50     0.8
   2        48     55     0.2
   3        65     45     0.5;

param disp :=
   1      1600
   2      1800
   3      2200
   4      3800
   5      1300;

end;
