#	DATI
set elementi;
set materiali;

param perc_mat {elementi, materiali};	# composizione chimica dei materiali			[%]
param limite_min {elementi};			# limite percentuale inferiore				[%]
param limite_max {elementi};			# limite percentuale superiore				[%]
param disponibili {materiali};			# quantità di materiali disponibili 				[ton]
param costi {materiali};				# costi dei corrispettivi materiali 			[€/ton]
param obiettivo := 50; 					# obiettivo di tonnellate di alluminio da produrre 	[ton]

#	VARIABILI
# quantità di materiali utilizzati
var utilizzati {elementi} >= 0;


#	VINCOLI
# ogni materiale non può eccedere il suo limite massimo percentuale
subject to limite_massimo {e in elementi}:
	utilizzati{e} / sum {u in utilizzati} u <= limite_max{e};

# ogni materiale non può eccedere il suo limite minimo percentuale
subject to limite_massimo {e in elementi}:
	utilizzati{e} / sum {u in utilizzati} u <= limite_max{e};

#	OBIETTIVO
# minimizzazione del costo di produzione
# minimize 

data;
set elementi := Silicio Magnesio Ferro Rame Manganese Zinco Cromo Titanio Alluminio "Altri elementi" Impurita;
set materiali := Scarti ALMC Scarti KAC Rottami Al Si Mg;

param perc_mat :	ScartiALMC 	ScartiKAC 	Rottami Al	Si	Mg :=
Silicio 			0.50 		0.50 		0.30 	100	0	0
Magnesio 			0.75 		0.70 		0.50 	0	0	100
Ferro 				0.20 		0.20 		0.35	0	0	0
Rame 				0.01 		0.01 		0.05	0	0	0
Manganese 			0.02 		0.02 		0.05	0	0	0
Zinco 				0.02 		0.02 		0.05	0	0	0
Cromo 				0.02 		0.02 		0.05	0	0	0
Titanio 			0.02 		0.02 		0.05	0	0	0
Alluminio 			97.0 		97.0 		90.0 	0	100	0
"Altri elementi"	0.06 		0.06 		0.77	0	0	0
Impurita 			1.40 		1.45 		7.83	0	0	0;

param : 		limite_min 	limite_max :=
Silicio 		0.2 		0.6
Magnesio 		0.45 		0.9
Ferro 			0			0.35
Rame 			0			0.1
Manganese 		0			0.1
Zinco 			0			0.1
Cromo 			0			0.1
Titanio 		0			0.1
Alluminio 		96.9 		100.0
"Altri elementi"0			0.15;

param : 	disponibili costi :=
ScartiALMC 	0.50 		1230
ScartiKAC 	1.20 		1230
Rottami 	2.20 		1230
Al 			inf			2140
Si 			inf		 	1300
Mg 			inf		 	2442;


end;