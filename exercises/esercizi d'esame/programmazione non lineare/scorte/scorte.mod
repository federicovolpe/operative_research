# il problema mi sembra incomprensibile, non si capisce che cosa si deve trovare
reset;

#		DATI

set P := 1..3;			# set di prodotti
param costi {P};		# costi di stoccaggio per ogni prodotto [Euro/(Kg*anno)]
param dom {P};			# domanda annuale di ogni prodotto [Kg/Anno]

param ct := 10000;		# costo di un trasporto [Euro]

param cm := 350;		# capacita' del mezzo
param cs := 5;			# capacita' di un sacco

#		VARIABILI

var T {P} ; 					# periodo di tempo per ogni rifornimento (che è da stabilire)
var qacq {p in P} = dom[p] * T[p];				# quantita' di prodotti da acquistare ogni volta

#		VINCOLI

# la quantita' acquistata in una volta non deve eccedere la capacita' del mezzo
#subject to quantita_massima :
#	sum{p in P} qacq[p] <= cm
#;

# la quantita' acquistata deve poter soddisfare la domanda
#subject to minimo_indispensabile {p in P} :
#	qacq[p] >= dom[p]
#;

#		OBIETTIVO
# determinare in modo scientifico quale sia la quantità ottimale di prodotti agricoli
# da ricevere ad ogni rifornimento e di conseguenza la frequenza ottimale per i rifornimenti.
minimize q : # quantità acquistata - costo di stoccaggio
	sum {p in P} ((qacq[p]/2) * costi[p] + # costo di stoccaggio per la merce acquistata
	ct / T[p])							# costo del viaggio suddiviso per il periodo di rifornimento di un prodotto
;	

data;

param dom :=
   1        1300
   2        1500
   3        2600;


param costi :=
   1        250
   2        500
   3        750;
   
var T :=
1	1
2	1
3	1
;

end;
