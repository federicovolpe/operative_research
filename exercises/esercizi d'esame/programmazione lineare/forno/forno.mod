#		DATI	#############################################################
set cibi ;
param tempi {cibi} ;		# tempo di preparazione per ogni cibo [h]
param areaTot := 4;			# area totale del forno disponibile [m]
param spazi {cibi}; 		# area che occupa ogni kg di ogni prodotto [mq/kg]
param minprod {cibi};		# produzione minima di ogni prodotto [kg]
param tempoTot := 6; 		# numero di ore lavorative del forno [h]
param prezzi {cibi};		# prezzo per ciascun prodotto [€/ kg]

# 		VARIABILI	##########################################################
var pro {cibi}; 			# produzione di ciascun cibo [kg]

#		VINCOLI	##########################################################
# nessun prodotto deve essere prodotto in quantità maggiore del doppio di un altro
subject to limit_production {c1 in cibi, c2 in cibi} :
	pro[c1] <= 2 * pro[c2]
;

# fabbisogni minimi di produzione
subject to fabbisogni_minimi {c in cibi} :
	pro[c] >= minprod[c]
;

# il tempospazio massimo a disposizione è limitato !
subject to limit_spacetime :
	sum {c in cibi} (pro[c] * spazi[c] * tempi[c]) <= tempoTot * areaTot
;

#		OBIETTIVO	##########################################################
maximize guadagni :
	sum {c in cibi} (pro[c] * prezzi[c])
;

data;
set cibi := Pane Biscotti Focacce Paste ;

# Tabella 1: Tempi di produzione

param tempi :=
Pane      1
Biscotti    3
Focacce    1.5
Paste      2;

#Tabella 2: Spazio occupato nel forno
param spazi :=
Pane      1
Biscotti   0.2
Focacce    1.5
Paste     1.5;

#Tabella 3: Produzione minima giornaliera
param minprod :=
Pane        5
Biscotti      2
Focacce       3
Paste        2;

#Tabella 4: Prezzi di vendita
param prezzi :=
Pane     2.50
Biscotti   4.00
Focacce    2.00
Paste     5.50;

end;
