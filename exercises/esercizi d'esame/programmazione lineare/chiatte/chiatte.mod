reset;

#		DATI
param C := 1..2;
set D = 1..2; # direzioni possibili
param l{C}; # lunghezza della strettoia km
param v{C};	# velocità della corrente km / h

param vc := 10;
param cap := 1500;

#		VARIABILI
var 

# 		VINCOLI

# il flusso deve essere conservato 
# la somma del flusso in salita sui due canali = al flusso di quelli in discesa

# in ciascuno dei due canali viene percorso solo da 1

#		OBIETTIVO
# massimizzare i flussi
maximize flussi :

;

data;


param : l	v :=
  1                0.5                     2
  2                0.75                     1 
;

end;
