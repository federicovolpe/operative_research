reset;

#		DATI

set P := 1..3;			# set di prodotti
param costi {P};		# costi di stoccaggio [Euro/(Kg*anno)]
param dom {P};			# domanda annuale [Kg/Anno]

param cv := 10000;		# costo di un viaggio [Euro]

param cm := 350;		# capacita' del mezzo
param cs := 5;			# capacita' di un sacco

#		VARIABILI
var scorta {P} >= 0;
var qacq {P} >= 0;				# quantita' di prodotti da acquistare ogni volta


#		VINCOLI

# la quantita' acquistata in una volta non deve eccedere la capacita' del mezzo
subject to quantita_massima :
	sum{p in P} qacq[p] <= cm
;

# la quantita' acquistata deve poter soddisfare la domanda
subject to minimo_indispensabile {p in P} :
		
;

#		OBIETTIVO
# quantita' ottimale di prodotti da acquistare ogni volta
minimize q :
	sum{p in P} qacq[p]
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

end;
