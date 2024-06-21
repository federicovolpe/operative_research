#		DATI	######################################
set P ;				# set dei prodotti disponibili
set S ;				# set delle sostanze utilizzate
param minsos {P,S};	# minimi e massimi per ogini sostanza in percentuale
param maxsos {P,S};
param disp {S};		# Tabella 2: Quantità massime disponibili (litri/giorno)
param prezzi {P};	# prezzi di mercato dei prodotti (Euro/litro)

#		VARIABILI	######################################
var x {S, P} >= 0;			# per ogni sostanza quanto ne viene utilizzata per la produzione di un detersivo
var q {P} >= 0;				# quantità di prodotto prodotta

#		VINCOLI	######################################
# relazione fra x e q
s.t. relazione {p in P}:
	sum{s in S} x[s,p] = q[p]
;

# vincoli dati dalla disponibilità di sostanze
subject to disponibilita {s in S}:
	sum{p in P} x[s, p] <= disp[s]
;

# limitazioni di minimo e massimo delle percentuali di sostanza utilizzata
subject to minimo_utilizzo {p in P, s in S}:
	x[s, p] >= minsos[p, s] * q[p];
subject to massimo_utilizzo {p in P, s in S}:
	x[s, p] <= maxsos[p, s] * q[p];

#		OBIETTIVO	######################################
maximize guadagni :
	sum{p in P} q[p] * prezzi[p];

data; 
set P := B S T;
set S := a v p;

param minsos : a           v           p :=
   B          .80       	  .05     	  .10  
   S          .70       	 .10       	   .05  
   T          .65       	 .20      	  .15; 

param maxsos : a           v           p :=
   B            .90       .10       .20
   S            .85       .20       .15
   T            .70       .50       .35;

param disp :=
   a          700
   v          150
   p          200;

param prezzi :=
   B        2.5
   S        2.0
   T        3.0;


#VARIABILI

#- per ognuno dei 3 prodotti ho 3 ingredienti, quindi 9 variabili che rappresentano le possibili combinazioni tra sostanze e detersivi
#- xij quantità sostanza i per detersivo j, con i=(a,v,p) e j=(B,S,T)
#- qj quantità massime disponibili per la vendita ogni giorno, con j=(B,S,T)
#- funz obiettivo è massimizzaz dei ricavi per i prodotti disponibili ogni giorno

end;
