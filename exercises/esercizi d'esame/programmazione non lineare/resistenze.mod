reset;

#	DATI
param goal := 65;
set resistori := 1..6;

set posizioni := 1..4;

param N {resistori};
param R {resistori};

#	VARIABILI
 
var assign {resistori, posizioni} binary;
var a {p in posizioni} = sum{r in resistori} (R[r] * assign[r, p]);
var Rtot = (a[1] * a[2])/(a[1] + a[2]) + (a[3] * a[4])/(a[3] + a[4]);
var delta;
 
#	VINCOLI

subject to assegnamento {p in posizioni} :
	sum {r in resistori} assign[r, p] = 1;
	
subject to limite_quantita_resistori {r in resistori} :
	sum {p in posizioni} assign[r, p] <= N[r];
	
subject to delta1:
	delta >= Rtot - goal;
subject to delta2:
	delta >= goal - Rtot;


#	OBIETTIVO
maximize difference : 
	delta;



data;

param:  N			R :=
 1      1         12
 2      1         15
 3      2         20
 4      2         22
 5      1         30
 6      1         40;

end;
