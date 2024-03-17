#	DATI
set prodotti := {"Super", "Normale", "Verde"};# set di prodotti possibili
set sostanze := {"A", "B", "C", "D"};# tipi di sostanze 

param risorse {sostanze};			# barili di materie prime disponibili [barili]
param prezzi {sostanze};			# prezzo al barile per materia [$/barile]
param ricavi {prodotti};			# ricavo al barile per prodotto [$/barile]
param min_perc {prodotti, sostanze};# percentuali di minimo
param max_perc {prodotti, sostanze};# percentuali di massimo

#	VARIABILI
# quantità di sostanza messa in ciascuna benzina [barili]
var qSostanze {s in sostanze, p in prodotti} >= 0;

#	VINCOLI
# massimo consumo di sostanze non deve eccedere
subject to consumo {s in sostanze} :
	sum {p in prodotti} qSostanze[s, p] <= risorse[s];

# vincolo sulla percentuale minima
subject to percmin {s in sostanze, p in prodotti} :
	qSostanze[s, p] >= 
		min_perc[s, p] * (sum {s2 in sostanze} qSostanze[s2, p]);

##      TODO RISCRIVERE I VINCOLI E L'OBIETTIVO
#	OBIETTIVO
maximize z : 

data;


param risorse :=A	3000
				B	2000
				C	4000
				D	1000;	

param prezzi :=	A	3
				B	6
				C	4
				D	5;
	
param ricavi :=	Super	5.5
				Normale	4.5
				Verde	3.5;

param min_perc :	Super	Normale 	Verde := 
				A	0		0			0
				B	.4		.1			0
				C	0		0			0	
				D	0		0			0;

param max_perc :	Super	Normale 	Verde := 
				A	.3		.5			.7
				B	1		1			1	
				C	.5		1			1
				D	1		1			1;

end;