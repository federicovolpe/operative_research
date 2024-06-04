reset;

#	DATI
set alberi;				# tipi di alberi presenti
set manod;				# tipi di mandodopera disponibili
param costi {manod};	# costi per ogni tipo di manodopera [Euro/ora]
param orel {alberi, manod};	# costi in termini di tempo per la potatura di ogni albero [ore/albero]

param minPot {alberi};	# numero minimo di alberi da potare per ogni tipo
param bore {manod};		# budget di ore di lavoro disponibili per ogni tipo di lavoro
param eff {alberi};		# effetto della potatura su ogni tipo di albero

#	VARIABILI
var potatura {alberi, manod} >= 0;	# numero di alberi potati per ciascun tipo e manodopera

#	VINCOLI
# il lavoro complessivo messo in un albero deve essere considerato potatura completa
subject to complessivo {a in alb};
	
;

# il totale delle ore lavorate non deve superare il budget
subject to monteOre {m in manod}:
	sum{a in alberi} potatura[a, m] <= bore[m]
;

# il numero di albero da tagliare deve essere maggiore del primo
subject to minimoPotatura {m in manod}:
	

#	OBIETTIVO
# massimizzazione dell'efficacia della potatura
maximize effetti:
	sum{a in alberi} potatura{a} * eff{a};
	
# minimizzare i costi della manodopera
#minimize spese :
#	sum{a in alberi, m in manod} potatura[a] * ore[a, m] * costi{m};

data;

set alberi := Pioppi Platani Betulle Olmi;
set manod := Manuale Meccanico;

# Tab.1: Costi manodopera [Euro/ora]
param costi :=
Manuale    20
Meccanico  60;

# Tab.2: Effetto della potatura
param eff :=
Pioppi   5
Platani  7
Betulle  8
Olmi    15;

# Tab.3: Manodopera necessaria per tipo di albero [ore-uomo/albero]
param ore : Manuale Meccanico :=
pioppi    5      0.8333
platani  10      2.0000
betulle   2.5    1.6667
olmi      1      0.6667;

# Tab.4: Limiti sulla manodopera disponibile [ore-uomo]
param bore :=
Manuale   100
Meccanico  75;

# Tab.5: Limiti minimi sul numero di alberi potati [numero alberi]
param minPot :=
Pioppi  35
Platani 20
Betulle 10
Olmi     5;

end;
