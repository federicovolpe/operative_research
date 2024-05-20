#	DATI -----------------------------------------------------------
# dimensioni del terreno
param b := 100;
param h := 50;
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

#	VARIABILI -----------------------------------------------------------
var p {T} >= bmin; # base della striscia di tulipano coltivata
var e {T}; # altezza del rettangolo destinato all'esportazione

#	VICNOLI -----------------------------------------------------------
# l'area totale coltivabile è limitata
subject to areaTot :
	sum {t in T} p[t] <= b;

# le esportazioni di ciascun tulipano devono risultare nelle percentuali
subject to percentuali_esportazione_max {t in T} :
	e[t] / h <= espmax[t];
subject to percentuali_esportazione_min {t in T} :
	e[t] / h >= espmin[t];

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
	sum {t in T} ((e[t] * h * esp[t]) + # dall'esportazione
				(p[t] * (h - e[t]) * naz[t]));# dal m. nazionale
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
