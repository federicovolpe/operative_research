#	DATI

set fasce := 1..24;
set medicine;
set precedenti := 0..11;

param minimo {fasce};			    # Livello minimo di proteina Y da garantire in ogni ora del giorno 	[mg/cc]
param tassi {precedenti, medicine};	# Tasso di proteina Y prodotta per ogni grammo di farmaco assunto 	[mg/cc]
param costi {medicine};			    # Costo di ciascun farmaco 											[€/g]
param massimo := 45;				# Massimo livello consentito di proteina Y 							[mg/cc]

#	VARIABILI

# quantità di medicina assunta in ogni fascia oraria [g]
var quantita {fasce, medicine} >= 0;

# livello di proteina Y in ogni fascia oraria [mg/cc]
var liv {f in fasce} >= minimo[f], <= massimo;

#	VINCOLI
# la proteina presente in una determinata fascia è data da quella assunta + quella assunta precedentemente
subject to conservazione {f in fasce} :
	liv[f] = sum {prec in precedenti, f1 in fasce, m in medicine # tale che la fascia analiz. appartenga alle 12 ore precedenti 
      			: (f1 = f-prec) or (f1 = f-prec+24)}
		tassi[prec, m] * quantita[f1, m];


#	OBIETTIVO
# a) minimizzare la quantità di sostanza complessiva da assumere
# minimize z:
#	sum {f in fasce, m in medicine} quantita[f, m] ;

# b) minimizzare il costo della cura
minimize z :
	sum {f in fasce, m in medicine} costi[m] * quantita[f, m];

data;
set medicine := Prismil Cilindren;

param minimo :=
1 5.0  	2 1.0	3 0.0  	4 0.0  
5 0.0  	6 0.0  	7 4.0  	8 15.0 
9 12.0 	10 5.0 	11 4.0 	12 3.0 
13 25.0 14 30.0 15 25.0	16 15.0
17 5.0 	18 4.0 	19 3.0 	20 25.0
21 30.0 22 25.0 23 20.0 24 10.0;

param tassi :	Prismil Cilindren :=
0 				1.5 	2.5
1 				3.0 	4.0
2 				4.0 	5.5
3 				2.5 	4.0
4 				1.9 	3.0
5 				1.4 	1.5
6 				1.0 	0.7
7 				0.7 	0.4
8 				0.5 	0.2
9 				0.3 	0.0
10 				0.2 	0.0
11 				0.1 	0.0;

param costi :=
Prismil	.70
Cilindren .95;

end;