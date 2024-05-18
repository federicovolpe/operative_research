reset;

#	DATI
# problema caratteristico che sfrutta le catene di markov [LINEARE]

set stati := 0..3 ; # stati possibili
param movimenti {stati, stati};

param mediaDesiderata := 2;

#	VARIABILI
# probabilità associata ad ogni casella
var prob {stati} >= 0;
var k  >= 0 , := 5; # tempo medio di rifornimento

#	VINCOLI

# vincoli di bilanciamento del flusso (copiati dall'esercizio prigioniero)

subject to flow_balance {s1 in stati}:
# archi uscenti da i verso destra
	(sum{s2 in stati} movimenti[s1, s2] * prob[s1]) + (sum{j in stati: j = s1-1} 1/k * prob[s1]) =
# archi uscenti da i verso sinistra
	(sum {s2 in stati} movimenti[s2, s1] * prob[s2]) + (sum{j in stati: j = s1+1} 1/k * prob[j]); # somma dei predecessori

#la somma delle probabilità deve essere uno
subject to normalize :
	sum {s in stati} prob[s] = 1;
	 
	 
# il numero medio di automobilisti deve essre minore di un certo termine
subject to media :
	sum{s in stati} s * prob[s] <= mediaDesiderata;

#	OBIETTIVO

# soluzione: assegnazione delle probabilità

data;


param movimenti : 	0	1	2	3 :=
0					0	1	0	0
1					0	0	.67	0	
2					0	0	0	.33
3					0	0	0	0 ;

end;

2)SNOPT 7.5-1.2 : Feasible point found.
9 iterations, objective 0
Nonlin evals: constrs = 18, Jac = 17.
Objective = find a feasible point.
ampl: display prob;
prob [*] :=
0  0.108213
1  0.24466
2  0.370613
3  0.276514
;

ampl: display k;
k = 2.26091