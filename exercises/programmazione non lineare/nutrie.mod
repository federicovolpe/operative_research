reset;

#	DATI

param nCacciatori := 5;
set C := 1..nCacciatori;
param nPaesi := 10;
set P := 1..nPaesi;

param pop {P}; 									# popolazione di nutrie in ciascun paese
param PC := 3;									# numero di paesi concessi a ciascun cacciatore

#	VARIABILI

var assign {C, P} binary;
var CxP {p in P} = sum {c in C} assign[c, p];	# numero di cacciatori per ciascun paese
var n_cad {c in C} = sum {p in P} (pop[p] * assign[c, p] / CxP[p]);									# nutrie che spettano a ciascun cacciatore
var massimo;

#	VINCOLI
# ad ogni cacciatore vengono attribuite 3 paesi
subject to assegnament_paesi {c in C} :
	sum {p in P} assign[c, p] <= PC;
	
# almeno un cacciatore per ogni paese
subject to almuno {p in P} :
	CxP[p] >=1 ;
	
#	OBIETTIVO
# minimizzare il massimo dei valori targ (ovvero il minimo numero di nutrie spettante ad un cacciatore)
minimize z : massimo;

subject to mas {c in C} : massimo >= n_cad[c];

data;

param pop :=
1		20
2		30
3		24
4		36
5		80
6		72
7		54
8		37
9		25
10		47;

end;
