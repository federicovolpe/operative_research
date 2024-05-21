#	DATI -----------------------------------------------------------
# dimensioni del terreno
param b := 100;
#		param h := 50; l'altezza del canale diventa una variabilie
set T := 1..5; # tipi di tulipani
param bmin := 5; # metri di larghezza minimi

param espmin {T};	# percentuali di esportazione 
param espmax {T};

# necessità :
param Nacqua {T};	# metri cubi di acqua necessari per ogni mq di tulipano
param NCA {T}; # kg di concimi necessari per ogni mq di tulipano
param NCB {T};

#disponibilità :
param acqua := 30000;
param CA := 3000;
param CB := 5000;

# prezzi
param naz {T};	# prezzo nazionale
param esp {T};	# prezzo esportazione

param CC := 50; # costo dei concimi (�/kg)

#	VARIABILI -----------------------------------------------------------
var p {T} >= bmin; # area della striscia coltivata
var Ae {T}; # area da esportare
var r {T};      # ricavi totali per ciascun tulipano
var c {T};      # costi totali per ciascun tulipano

#	VICNOLI -----------------------------------------------------------
subject to guadagni_per_tulipano {t in T}:
    r[t] = (Ae[t] * esp[t]) + ((p[t]-Ae[t]) * naz[t]);
    
subject to costi_per_tulipano {t in T}:
   c[t] = p[t] * CC * (NCA[t] + NCB[t]);

# l'area totale coltivabile è limitata
subject to areaTot :
	sum {t in T} p[t] / h <= b;

# le esportazioni di ciascun tulipano devono risultare nelle percentuali
subject to percentuali_esportazione_max {t in T} :
	Ae[t] <= espmax[t] * p[t];
subject to percentuali_esportazione_min {t in T} :
	Ae[t] >= espmin[t] * p[t];

# limiti di scorte utilizzabili
subject to limiteAcqua :
	sum {t in T} (Nacqua[t] * (p[t] * h)) <= acqua;
subject to limiteCA :
	sum {t in T} (NCA[t] * (p[t] * h)) <= CA;
subject to limiteCB :
	sum {t in T} (NCB[t] * (p[t] * h)) <= CB;

# 	OBIETTIVO -----------------------------------------------------------
# massimizzazione dei profitti
maximize guadagni :
	sum {t in T} (r[t] - c[t]); # dal m. nazionale
    
data;
param : espmin  espmax :=
   1       .1   .4
   2       .15  .6
   3       .05  .75
   4       .5  	1
   5       0   	.5;

param :		Nacqua   NCA	NCB :=
   1         4.0    1.2     0.5
   2         3.0    1.5     0.4
   3         8.5    0.3     1.3
   4         1.0    2.8     1.0
   5         2.5   	1.9     0.8;

param :     naz  	esp :=
   1         60     90
   2         80     110
   3        120     155
   4         75     100
   5         80     85;

end;
