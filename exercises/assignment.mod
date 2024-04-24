#	DATI
set macchine := 1..3;				# insieme delle macchine
set jobs := 1..9;					# insieme dei job da completare
param tempimax 	{macchine};			# tempi massimi per cui ciascuna machina può operare
param tempijob 	{jobs, macchine};	# tempo di completamento di ciascun job per ogni macchina
param costi 	{jobs, macchine};	# costi di ciascun job per ciascuna macchina

#	VARIABILI
# ogni assegnamento di ciascun job ad ogni macchina
var assegnamenti {jobs, macchine} binary; 

#	VINCOLI
# ogni job deve essere assegnato ad almeno una macchina
subject to assegnamento {j in jobs}:
	sum {m in macchine} assegnamenti[j, m] = 1;

# ciascuna macchina non può rimanere operativa più del suo tempo limite
subject to limitetempi {m in macchine} :
	sum {j in jobs} assegnamenti[j, m] * tempijob[j, m] <= tempimax[m];

#	OBIETTIVO
# minimizzazione di costi complessivi di esecuzione
minimize z : 
	sum {j in jobs, m in macchine} assegnamenti[j, m] * costi[j, m];
data;

param tempimax :=
1 380
2 360
3 350;

param tempijob :1	2	3 :=
			1 	100 102 97
			2 	111 110 113
			3 	98 	103 96
			4 	132 130 135
			5 	120 123 117
			6 	115 112 118
			7 	142 145 140
			8 	123 120 125
			9 	90 	93 	88;

param costi :	1 	2 	3 :=
			1 	24 	42 	23
			2 	30 	45 	23
			3 	33 	54 	16
			4 	37 	45 	18
			5 	34 	47 	22
			6 	31 	42 	25
			7 	30 	41 	19
			8 	28 	47 	15
			9 	25 	50 	20;

end;
