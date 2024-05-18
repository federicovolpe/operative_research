reset;

#	DATI
# problema caratteristico che sfrutta le catene di markov [LINEARE]

set stati := 0..3 ; # stati possibili
param movimenti {stati, stati};

#	VARIABILI
# probabilità associata ad ogni casella
var prob {stati} >= 0;
var k  ; # tempo medio di rifornimento

#	VINCOLI

# vincoli di bilanciamento del flusso (copiati dall'esercizio prigioniero)

subject to flow_balance {s1 in stati}:
	sum{s2 in stati} movimenti[s1, s2] * prob[s1] = sum {s2 in stati} movimenti[s2, s1] * prob[s2]; # somma dei predecessori

#la somma delle probabilità deve essere uno
subject to normalize :
	sum {s in stati} prob[s] = 1;
	 
#	OBIETTIVO

# soluzione: assegnazione delle probabilità

data;


param movimenti : 	0	1	2	3 :=
0					0	1	0	0
1					.2	0	.67	0	
2					0	.2	0	.33
3					0	0	.2	0 ;

end;

CPLEX 22.1.1.0: optimal solution; objective 0
0 dual simplex iterations (0 in phase I)
Objective = find a feasible point.
ampl: display prob;
prob [*] :=
0  0.0198462
1  0.099231
2  0.332424
3  0.548499;

1) mediamente ci sono:
basta fare la media fra 
0	0.0198462
1  0.099231
2  0.332424
3  0.548499

2) guardare d_benzina2.mod