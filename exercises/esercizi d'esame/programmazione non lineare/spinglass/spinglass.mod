#	DATI
set particelle := 1..10;
param interazioni {i in particelle, j in particelle : i < j};

#	VARIABILI
var orient{particelle} binary ;			# orientamento di ogni particella

#	VINCOLI
# Ogni particella interagisce solo con le altre, non con sË stessa. -> data dal fatto che ce ne sono 9

# non esistono vincoli ma solo un obiettivo

#	OBIETTIVO
# minimizzazione dell'energia del sistema
# negata se hanno lo stesso spin , positiva altrimenti
minimize Energia:
	sum {i in particelle, j in particelle : i < j} 
	interazioni[i,j] * (2* orient[i]-1) * (2* orient[j]-1); 
# da notare la trasformazione da variabile binaria 0-1 a variabile
# binaria 1 -1

data;

param interazioni : 1 2 3 4 5 6 7 8 9 10:=
1  .  3 -1 -4  5 -8  4 -2 -3 -1
2  .  . -2  2 -4  7 -1  2 -2  2
3  .  .  . -3 -3 -3  5 -2 -1 -3
4  .  .  .  .  2 -1 -2 -2 -2 -7
5  .  .  .  .  .  3 -7  7 -2  8
6  .  .  .  .  .  . -5  3 -3 -1
7  .  .  .  .  .  .  . -1  9 -5
8  .  .  .  .  .  .  .  .  1  9
9  .  .  .  .  .  .  .  .  . -6
10 .  .  .  .  .  .  .  .  .  .;


#1 8 2 9 1 9 1 8 2 7

end;
