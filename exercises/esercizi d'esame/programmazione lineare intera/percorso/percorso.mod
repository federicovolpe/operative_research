#		DATI	###################################
param nn := 16; 	# numero di nodi
set N := 0..nn-1;	# set dei nodi
param R {N,N};		# rischio legato a ciascuna coppia di nodi

param P := 0;		# nodo di partenza
param A := 15;		# nodo di arrivo

#		VARIABILI	###################################
var scelta {};

#		VINCOLI 	###################################
# per ongi nodo il grado entrante deve essere uguale a quello uscente
subject to 
subject to :
!Vincoli di flusso (inizializzazione) sui nodi 0 (uscente) ed f (entrante)
nodo0) arco01 + arco03 = 1
nodoF) arcodf + arcoef = 1
#		OBIETTIVO	###################################


data;

Rischio  Strada
   2      0 1
   1      0 3
   2      1 2
   2      2 3
   3      2 4
   2      3 5
   2      3 6
   3      4 5
   2      4 9
   4      4 10
   3      5 7
   2      6 7
   2      7 8
   2      8 9
   1      8 11
   5      9 13
   3      10 13
   1      11 12
   2      11 14
   2      12 13
   3      13 14
   3      13 15
   4      14 15; 

end;
