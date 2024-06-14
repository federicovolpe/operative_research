#		DATI	###################################
param nn := 16; 	# numero di nodi
set N := 0..nn-1;	# set dei nodi
param R {N,N} default 10000;		# rischio legato a ciascuna coppia di nodi

param P := 0;		# nodo di partenza
param A := 15;		# nodo di arrivo

#		VARIABILI	###################################
var scelta {N,N} binary;

#		VINCOLI 	###################################
# per ongi nodo il grado entrante deve essere uguale a quello uscente
subject to conservazione_di_flusso {n1 in N : n1<>0 and n1<> 15}:
   sum{n2 in N} scelta[n2,n1] = sum{n2 in N} scelta[n1, n2] 
;

# vincoli per l'impostazione del primo e ultimo nodo
subject to primo :
   sum{n in N : n <> 0} scelta[0, n] = 1; # deve esserci almeno un arco uscente 
subject to ultimo :
   sum{n in N : n <> 15} scelta[n, 15] = 1;

#		OBIETTIVO	###################################
# minimizzazione del rischio totale del percorso
minimize rischio :
   sum{n1 in N, n2 in N} R[n1, n2] * scelta[n1,n2];

data;
param R :=  
[0, 1]   2      
[0, 3]   1      
[1, 2]   2      
[2, 3]   2      
[2, 4]   3      
[3, 5]   2      
[3, 6]   2      
[4, 5]   3      
[4, 9]   2      
[4, 10]   4      
[5, 7]   3      
[6, 7]   2      
[7, 8]   2      
[8, 9]   2      
[8, 11]   1      
[9, 13]   5      
[10, 13]   3      
[11, 12]   1      
[11, 14]   2      
[12, 13]   2      
[13, 14]   3      
[13, 15]   3      
[14, 15]   4       
;

end;

dalla soluzione del prof:
Dall’analisi di sensitività sui coefficienti della funzione obiettivo si vede che sull’arco (e,f) il valore “allowable” increase è nullo: quindi se il rischio su tale arco fosse anche di poco superiore al valore indicato nei dati, la base ottima cambierebbe, cioè il percorso a minimo rischio cambierebbe. Questo quindi è l’arco da controllare meglio. Viceversa si vede che la massima robustezza della stima si ha sull’arco (8,b), dove il dato vale 1 ma potrebbe aumentare anche di 2 unità (un aumento percentuale del 200%) senza che la base ottima cambi.
