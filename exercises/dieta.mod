#	DATI
set sostanze := {"proteine", "grassi", "carboidrati"};
set alimenti := {"pasta", "latte", "formaggio", "pesce", "verdura", "pane", "polenta"};

param valori_nut {sostanze, alimenti};
param lim_inf {sostanze};
param lim_sup {sostanze};
param costi {alimenti};

#	VARIABILI
# quantità consumata di ogni cibo
var quantita {alimenti} >= 0;

#	VINCOLI
# rispettare i vincoli di limite e di massimo per ogni sostanza
subject to limiti_massimi {s in sostanze} :
	sum {a in alimenti}	(quantita[a] * valori_nut[s, a]) <= lim_sup[s];

subject to limiti_minimi {s in sostanze} :
	sum {a in alimenti}	(quantita[a] * valori_nut[s, a]) >= lim_inf[s];

#	OBIETTIVO
# minimizzare i costi 
minimize z : 
	sum {a in alimenti} (quantita[a] * costi[a]);

data;

param valori_nut :	pasta 	latte 	formaggio 	pesce 	verdura pane 	polenta :=
proteine 			11.5 	3.15 	8 			18.5 	2.1 	12.0	9
carboidrati 		72.7 	4.85 	3.8 		0.5 	0 		68 		74
grassi 				1.5 	1.55 	11 			19 		0.1 	6 		1;

param :		lim_inf lim_sup := 
proteine 	25 		35
carboidrati 15 		25
grassi 		10 		20;

param costi :=
pasta		4 
latte		4 
formaggio	15 
pesce		22.5 
verdura		3 
pane		1 
polenta		5;

end;