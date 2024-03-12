# 	dati
param num_lotti;
param num_cereali;

set lotti := 1..num_lotti;
set cereali := 1..num_cereali;

param necessita_terreno {lotti, cereali};
param prezzo {cereali};
param necessita_acqua {cereali}; 

param aree_lotti {lotti};
param acqua_tot;

#	variabili
var quantita_prodota {cereali} >=0; # la produzione di ogni cereale non puo essere negativa

#	vincoli

# 	obiettivo
# massimizzare la somma del profitto di ongni cereale per il quanto ne e' stato coltivato
maximize z : 
	sum (i in cereali) prezzo[i] * quantita_prodotta[i];

data;

param num_lotti := 2;
param num_cereali := 6;

param necessita_acqua := 120  160   100   140   215   180;
param prezzo :=	48 	 62	   28 	 36    122 	 94;

param necessita_terreno : 	1	 2	   3	   4 	 5 	  6   :=
1	0.02 0.03  0.02  0.016 0.05  0.04
2	0.02 0.034 0.024 0.02  0.03  0.034;
param aree_lotti := 200 400;

param acqua_tot := 400000;

end;
