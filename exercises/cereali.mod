# DATI
param nTerreni;
param nCereali;
set terreni := 1..nTerreni;					# terreni in cui poter coltivare
param aree {terreni};						# aree dei rispettivi terreni [a]
set cereali := 1..nCereali;					# tipi di cereali
param profitti {cereali};					# profitti per ogni cereale [€/q]
param necessita_acqua {cereali};			# acqua necessitata per ogni cereale [mc]
param necessita_terreno {terreni, cereali};	# necessità di terreno per cereale [a]
param max_acqua;							# totale di acqua disponibile [mc]

# VARIABILI
var produzione {terreni, cereali} >= 0;

# VINCOLI
subject to area_necessaria {t in terreni}:
	sum {c in cereali} produzione[t, c] * necessita_terreno[t, c] <= aree[t];

subject to acqua_necessaria :
	sum{c in cereali, t in terreni} produzione[t, c] * necessita_acqua[c] <= max_acqua;

# OBIETTIVO
maximize z: 
	sum{c in cereali, t in terreni} produzione[t, c] * profitti[c];

data;

param nTerreni := 2;
param aree := 	1 200 
				2 400;
param nCereali := 6;
param profitti := 1 48 
				2 62 
				3 28 
				4 36 
				5 122 
				6 94 ;
param necessita_acqua := 1 120 
						2 160 
						3 100 
						4 140 
						5 215 
						6 180 ;

param necessita_terreno :	1		2		3		4		5		6 :=
						1	0.02 	0.03 	0.02 	0.016 	0.05 	0.04
						2	0.02 	0.034 	0.024 	0.02 	0.06 	0.034;

param max_acqua :=  400000 ;

end;

# risultato:  OPTIMAL : 226976.7441860465