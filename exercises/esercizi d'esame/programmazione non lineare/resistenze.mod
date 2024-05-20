reset;

#	DATI
param goal := 65;
set resistori := 1..6;

set posizioni := 1..4;

param N {resistori};
param R {resistori};

#	VARIABILI
 
var assign {resistori, posizioni} binary;			# assegnamento per ogni posizione al suo resistore
var a {p in posizioni} = 							# valore di resistenza per ogni posizione
	sum {r in resistori} (R[r] * assign[r, p]);
	
var Rtot = (a[1] * a[2])/(a[1] + a[2]) + (a[3] * a[4])/(a[3] + a[4]);

var delta >= 0;
 
#	VINCOLI

subject to assegnamento {p in posizioni} :
	sum {r in resistori} assign[r, p] = 1;
	
subject to limite_quantita_resistori {r in resistori} :
	sum {p in posizioni} assign[r, p] <= N[r];
	

#	OBIETTIVO
maximize difference : 
	delta;
	
subject to delta1:
	delta >= Rtot - goal;
	
subject to delta2:
	delta >= goal - Rtot;
	
data;

param:  N		R :=
 1      1       12
 2      1       15
 3      2       20
 4      2       22
 5      1       30
 6      1       40;

end;

la soluzione trovata non è unica anche perchè solo scambiando i valori delle
resistenze si trovano delle soluzioni ugualmente ottime

l'ottimalità :
