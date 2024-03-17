#   DATI
set mesi := 1..4;

param domanda 	{mesi};
param capacita 	{mesi};
param prezzo 	{mesi};
param costo 	{mesi};
param iniziale := 0; 	# scorte presenti già al mese iniziale

#   VARIABILI
#	gelato prodotto per ogni mese
var prodotto {m in mesi} >= 0, <= capacita[m];

# 	stock di gelato alla fine di ogni mese
var stock {mesi} >=0; 

#   VINCOLI
#	quello che è stato prodotto nel mese prima sommato a quello che ho prodotto in questo mese
#	deve essere uguale a quello che mi serve
subject to conservazione {m in mesi : m > 1}:
	stock[m-1] + prodotto[m] = domanda[m] + stock[m];
	
#	all'inizio la domanda deve coincidere con la produzione del primo mese
subject to inizio :
	iniziale + prodotto[1] = domanda[1] + stock[1];

#   OBIETTIVO
# minimizzazione dei costi mantenendo soddisfatta la domanda
# considerando anche il costo di mantenere il gelato in magazzino
minimize z: sum {m in mesi} ( prodotto[m] * costo[m] + costo[m] * stock[m] );
	
data;

param domanda:= 
1   200
2   300
3   500
4   400;

param capacita:= 
1   400
2   500
3   300
4   500;

param prezzo:= 
1   34
2   36
3   32
4   38;

param costo:= 
1   2000
2   3000
3   2000
4   3000;

end;