#	dati
set T := 1..3;

param domanda {T}; 		# domanda per ogni periodo 	[mesi]
param cap ; 			# capacità produttiva 		[u]
param costo;			# costo unitario di produzione	[€/u]
param cap_extra;		# capacità produttiva extra	[u]
param costo_extra;		# costo unitario di produzione	[€/u]
param costo_giacenza; 	# costo di giacenza 			[ €/um]
param giac_iniziale ; 	# giacenza iniziale 			[u]

#	VARIABILI
var x {T} >= 0 <= cap; 					# produzione per ogni mese [U]
var x_extra {T} >= 0 , <= cap_extra; 	#produzione extra per ogni mese
var g {T} >= 0;							 # giacenza alla fine di ogni mese [U]

#	VINCOLI
# vincolo di flusso
subject to Domanda {t in T : t > 1}: # quello che produco deve essere uguale o maggiore alla richiesta
	g[t-1] + x[t] + x_extra[t] = domanda[t] + g[t];
subject to domanda1 :
	giac_iniziale + x[1] + x_extra[1] = domanda[1] + g[1];

# stesso vincolo di flusso diversa formulazione
# subject to domanda {t in T} :
#	giac_iniziale + sum {i in T : i <= t} (x[i] + x_extra[T]) >= sum {i in T: i <= t} domanda[i]; 

# 	OBIETTIVO
# minimizzazione dei costi
minimize z :
	sum {t in T}(costo * x[t] + costo_extra * x_extra[t] + costo_giacenza*g[t]);

data;

param domanda := 
1 100
2 130
3 150;

param cap := 110;
param costo := 300;
param cap_extra := 60;
param costo_extra := 330;
param costo_giacenza := 10;
param giac_iniziale := 0;

end;
