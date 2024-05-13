reset;

#	DATI
# problema caratteristico che sfrutta le catene di markov [LINEARE]

set stati;
param movimenti {stati, stati};

#	VARIABILI

var prob {stati} >= 0;

#	VINCOLI

# vincoli di bilanciamento del flusso
# la frequenza media di uscita è la somma de
subject to flow_balance {s1 in stati}:
	prob[s1] = sum {s2 in stati} movimenti[s2, s1] * prob[s2]; # somma dei predecessori

#la somma delle probabilità deve essere uno
subject to normalize :
	sum {s in stati} prob[s] = 1;
	 
#	OBIETTIVO

# semplicemente assegnare le probabilità

data;

set stati := Nord Est Sud Ovest;

param movimenti : Nord Est Sud Ovest :=
Nord				0	.4	0	.6
Est					.2	0	.8	0
Sud 				0	.5	0	.5
Ovest				.75	0	.25	0 ;

end;

la difezione migliore da cui scappare è est perchè ha la probabilità minore 0.22