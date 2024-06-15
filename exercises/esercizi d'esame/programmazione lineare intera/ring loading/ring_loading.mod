#		DATI	#######################################
param nc := 10;			# numero di calcolatori
set N := 1..nc;		# set di calcolatori nell'anello
param t {N,N};		# traffico tra un nodo e un altro


#		VARIABILI	#######################################
var dir {N,N} binary;		# 0 = orario, 1 = antiorario
var maxt >= 0;			# Max traffico su un arco

# VINCOLI
subject to traffico {n in N}:
  maxt >= sum {n1 in N, n2 in N: (n1<n2) and (n2<=n)} 
            t[n1,n2] * dir[n1,n2] # per ogni coppia di nodi fino a n
        + sum {n1 in N, n2 in N: (n2<n1) and (n1<=n)} 
            t[n1,n2] * (1-dir[n1,n2]) # per ogni coppia di nodi in n in senso antiorario
        + sum {n1 in N, n2 in N: (n1<=n) and (n2>n)} 
            t[n1,n2] * (1-dir[n1,n2]) # per ogni coppia di nodi dove n1 < n < n2 in senso antiorario
        + sum {n1 in N, n2 in N: (n2<=n) and (n1>n)} 
            t[n1,n2] * dir[n1,n2]     # per ogni coppia di nodi dove n2 < n < n1 in senso orario
        + sum {n1 in N, n2 in N: (n1>n) and (n2>n1)} 
            t[n1,n2] * dir[n1,n2]     # per ogni coppia maggiore di n in senso orario
        + sum {n1 in N, n2 in N: (n2>n) and (n1>n2)} 
            t[n1,n2] * (1-dir[n1,n2]);# per ogni coppia maggiore di n in senso antiorario

# OBIETTIVO
# Minimizzare madir capacit? necessaria
minimize z: maxt;

data;
param t:	1	2	3	4	5	6	7	8	9	10 :=
1   		9   7   7   8   7   9   9   6   6  10
2   		7   7   7   7   7   8   5   7  10   9
3   		7   5   8   8   8  10   6  10   9  10
4   		7  10   7  10   9   8   5  10   7   9
5  			10  5   6  10   5   8   7   9   8   7
6   		6   7   8   7   8  10   9   5   9   7
7   		9   5   8   9   7  10   8   9  10   7
8   		6   5   9   5   6   8  10   6   9   8
9   		7   5   5   8   8   8  10   7   9   7
10   		8   5   5   7   8   9   7   6   5   8;

end;
