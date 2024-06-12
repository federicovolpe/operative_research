# esercizio terminato
#       DATI    ########################################
param nu := 13; 		# numero di uomini
param nd := 8;			# numero di donne
set U := 1..nu;			# set di uomini
set D := 1..nd;			# set di donne

param gud {U,D};
param gdu {U,D};
param G {u in U , d in D} := min(gud[u,d], gdu[u,d]);

param k := 2; 			# numero di nominativi proposti dall'azienda

#       VARIABILI    ########################################
var prop {U,D} >= 0 , <= 1;		# set di proposte fatte a un lui

#       VINCOLI    ########################################
# vincolo di simmetria, se la donna A è proposta a B allora ad a viene proposto B
subject to simmetriaU {u in U} :
	sum{d in D} prop[u,d] <= k
;

subject to simmetriad {d in D} :
	sum{u	in U} prop[u,d] <= k
;
#       OBIETTIVO    ########################################
# massimizzare l'affiatamento totale fra le coppie
# Si vuole risolvere il problema con K=1, con K=2 e con K=3.
maximize z:
	sum{u in U, d in D} G[u,d] * prop[u,d] 
;

data;

param gdu :
		1    2    3    4    5    6    7    8 :=   
  1     13   18   23   36   25   24   22    4
  2     15   14   30    4   24   25   22    5
  3     19   15   31    6   22   28   21   12
  4     21   16   28   12   21   21   13   15
  5     23   16   36    9   20   20   16    7
  6     25   15   38   21   17   17   17   13
  7     24   14   39   16   24   15   19   14
  8     24   10   31   16   27   18   20   10
  9     22   12   29   17   28   28   10   20
  10    18    5   27   14   10   29   14   18
  11    16    5   27   13   15   22   20   15
  12    16    8   30    9   18   33   21   13
  13    30   10   31   10   19   11   21   16;
  
param gud :
		1    2    3    4    5    6    7    8 :=   
  1    31   15   27   24   24   21   22   12 
  2    16   19   20   23   27   35   37    8 
  3    25   30   31    5    8    9   20   15 
  4    36   34   29   37   38   26   12   17 
  5    23   23   23   25   26   23   22   21 
  6    12   14   17   15   16   19   11    5 
  7     3    2    6   18   20   22   21   28 
  8    34   36   28   27   26   25   30   30 
  9    20   18   17   19   19   18   21   20 
  10    4    5    7   32    9   30   25   29 
  11    5    6    7    6   10    9    9    9 
  12   38   37   35   34   33   35   28   27 
  13   25   26   28   21   20   16   17   16; 



end;
