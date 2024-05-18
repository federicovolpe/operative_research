#	dati

param num_fornitori;
param num_tipi_patate;

set tipi_patate := 1..num_tipi_patate;
set fornitori := 1..num_fornitori;

param profitti {fornitori};					# profitto per ogni kg di patate
param limite_acquisto {tipi_patate};

param ricavi {fornitori, tipi_patate}; 	# resa percentuale

#	variabili 

var x {fornitori} >= 0;

#	vincoli 

subject to produzione {j in tipi_patate} :
	sum {i in fornitori} (x[i] * ricavi[i,j]) / 100 <= limite_acquisto[j]*10;

#	obiettivi

maximize z : sum {i in fornitori} profitti[i] * x[i];

data;

param num_fornitori := 2;
param num_tipi_patate := 3;

param profitti := 					# profitto per ogni kg di patate
					1	2
					2	3;

param limite_acquisto :=
						1	6
						2	4
						3	8;


param ricavi: 1 2 3 :=
									1	20 	20	30
									2	30	10	30;	
end;
