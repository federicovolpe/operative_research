reset;
# sfrutta le catene di markov

#	DATI
# frequenza di arrivo degli urgenti
# frequenza di arrivo dei non urgenti
# frequenza di completamento

set stati := 0..4 ; # stati possibili
param movimenti {stati, stati};

#	VARIABILI
# probabilità associata ad ogni casella
var prob {stati} >= 0;

#	VINCOLI

# vincoli di bilanciamento del flusso (copiati dall'esercizio prigioniero)

subject to flow_balance {s1 in stati}:
	(sum{s2 in stati} movimenti[s1, s2] * prob[s1]) =
	(sum {s2 in stati} movimenti[s2, s1] * prob[s2]);

#la somma delle probabilità deve essere uno
subject to normalize :
	sum {s in stati} prob[s] = 1;
	 

#	OBIETTIVO

# soluzione: assegnazione delle probabilità

data;


param movimenti : 	0		1		2		3 		4  :=
0					0		5.33	0		0		0
1					3		0		1.33	4		0	
2					0		6		0		0		4
3					0		3		0		0		1.33	 
4					0		0		0		6		0	;

end;

SNOPT 7.5-1.2 : Optimal solution found.
2 iterations, objective 0
Objective = find a feasible point.
ampl: display prob;
prob [*] :=
0  0.155053
1  0.275478
2  0.0366386
3  0.416156
4  0.116674;

1) cioè quando ne ho già due urgenti
prob(c) + prob(e)

2) prob(d) + prob(e)

3) 1 * prob() * p(e)

4) prob(d) + prob(e)

5) se servissero subito cambierebbe il grafo

6) se i medici fossero tre
bisogna fare un altro grafo...