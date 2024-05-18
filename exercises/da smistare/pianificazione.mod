#	DATI
set mesi := 1..4;

param domanda {mesi};	# domanda per ogni mese [ton]
param capacita{mesi};	# capacità produttiva per ogni mese [ton]
param prezzi {mesi};	# costi per la produzione per ogni mese [€/ton]
param costi {mesi};		# costi per l'immagazzinamento al mese [€/kg]
param iniziale := 0;	# stock all'inizio [ton]

#	VARIABILI
# quanto viene prodotto per ogni mese
var produzione {m in mesi} >= 0 , <= capacita[m]; 

# stock per ogni mese
var stock {mesi} >= 0;

#	VINCOLI
# il flusso entrante deve essere pari al flusso uscente
subject to conservazione {m in mesi : m > 1}:
	stock[m-1] + produzione[m] = domanda[m] + stock[m];

# conservazione del mese iniziale
subject to vincolo_iniziale :
	iniziale + produzione[1] = domanda[1] + stock[1];

#	OBIETTIVO
# per ogni mese minimizzare i costi di conservazione e produzione
minimize z : 
	sum {m in mesi} (produzione[m] * prezzi[m] + stock[m] * costi[m]);

data;

param domanda 	:=
					1	200
					2	300
					3	500
					4	400;

param capacita	:=
					1	400
					2	500
					3	300
					4	500;

param prezzi 	:=
					1	34
					2	36
					3	32
					4	38;

param costi 	:=
					1	2000
					2	3000
					3	2000
					4	3000;
end;
