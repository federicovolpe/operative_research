#	DATI 	######################################
set I ;	# set degli ingredienti
set P ;	# set dei prodotti 

param prezzi {P};		# prezzo di ciascun prodotto [Euro/Kg]
param comp {I,P};		# composizione percentuale dei prodotti [%]
param disp {I};			# disponibilità di ciascun ingrediente [Kg/g]

set conf ;				# set dei tipi di confezioni

#	VARIABILI 	######################################
var x {P} >= 0 ; 		# quantità prodotta per ciascun prodotto
var avanzi {I};		# quantità di avanzi per ogni ingrediente

#	VINCOLI	######################################
# la somma dell'utilizzo di ogni ingrediente non deve eccedere la disponibilità di questo
#subject to ingredienti {i in I} :
#	sum{p in P} (x[p] * comp[i,p]) <= disp[i]
#;
#La produzione di biscotti speciali deve essere compresa tra il 10% e il 25% della produzione di biscotti normali.
subject to biscottiNS :
	x['biscottiS'] <= .25 * x['biscottiN'] ;
subject to biscottiNS2 :
	x['biscottiS'] >= .10 * x['biscottiN'] ;

# definizione avanzi
subject to avanzi_def {i in I} :
	avanzi[i] = (disp[i] - sum{p in P}(x[p] * comp[i,p]))/ disp[i];

#Gli avanzi di zucchero, marmellata e cioccolato non devono eccedere il 10% delle quantità disponibili.
subject to avanziz : avanzi['zucchero'] <= .1 * disp['zucchero'] ;
subject to avanzim : avanzi['marmellata'] <= .1 * disp['marmellata'] ;
subject to avanzic : avanzi['cioccolato'] <= .1 * disp['cioccolato'] ;

#Il totale di prodotti venduti in confezioni grandi deve essere compreso tra il 40% e il 60% del totale.
#Il vincolo deve essere rispettato sia per ogni tipo di prodotto sia complessivamente.
subject to conf_grandi {c in conf}:
	sum{p in P} 
;

#	OBIETTIVO 	######################################
# massimizzazione dei guadagni
maximize z:
	sum{p in P} x[p] * prezzi[p]
;

data;

set P := merendine brioches biscottiN biscottiS tortine;
set I := pasta zucchero marmellata cioccolato acqua;
set conf := conf_g conf_p;

param prezzi :=
merendine      8
brioches       6
biscottiN     12
biscottiS    14
tortine       10
;
param comp : merendine brioches biscottiN biscottiS tortine := 
pasta            .20      .40      .70      .25      .20
zucchero         .25      .15      .10      .20      .30 
marmellata       .40      .30       .0      .10      .10  
cioccolato       .10       .0      .15      .40      .30  
acqua             .5      .15       .5       .5      .10
;

param disp :=
pasta      10000000
zucchero   300
marmellata 320
cioccolato 240
acqua      10000000;

#Ciascun tipo di prodotto deve costituire almeno il 10% della produzione totale.

#La produzione attuale è la seguente:

#    Prodotto  merendine brioches biscottiN biscottiS tortine
#Conf. piccola   250     60      180      60      70
#Conf. grande    350     90      250      90      90



end;
