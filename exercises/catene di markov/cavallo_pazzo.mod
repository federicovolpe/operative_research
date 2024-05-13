reset;

#	DATI
# problema caratteristico che sfrutta le catene di markov [LINEARE]

set T; # tipi di caselle
param movimenti {T, T};

#	VARIABILI
# probabilità associata ad ogni casella
var prob {T} >= 0;

#	VINCOLI

# vincoli di bilanciamento del flusso (copiati dall'esercizio prigioniero)

subject to flow_balance {t1 in T}:
	prob[t1] = sum {t2 in T} movimenti[t2, t1] * prob[t2]; # somma dei predecessori

#la somma delle probabilità deve essere uno
subject to normalize :
	sum {t in T} prob[t] = 1;
	 
#	OBIETTIVO

# nessun obiettivo, solo assegnare le probabilità

data;

set T := Angolo Laterale Centrale;

param movimenti : Angolo Centrale Laterale :=
Angolo				0		1		0
Centrale			.5		0		.5
Laterale			0		.33		.67 ;

end;

CPLEX 22.1.1.0: optimal solution; objective 0
0 dual simplex iterations (0 in phase I)
Objective = find a feasible point.
ampl: display prob;
prob [*] :=
  Angolo  0.165829
Centrale  0.331658
Laterale  0.502513

prob dell'angolo a sinistra = 1/4 della probabilità di trovarsi nell'angolo
0.165829 /4