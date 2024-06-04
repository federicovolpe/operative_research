reset;

#		DATI
param np := 30;
set Paesi := 1..np;		# set dei paesi
param d {Paesi, Paesi}; # distanze tra paese e paese
param nv := 20; 		# numero delle tratte di ogni veicoli
set V := 1..nv;			# insieme di veicoli
set Tappe {V} within Paesi ordered; 		# set di tappe per ogni veicolo (sottoinsieme dell'insieme paesi!) 
# (ordinato) consente di stabilire il <first> e il <last> <ord> l'ordinalità di un elemento <prev> e <succ>...
# 	è IL MOTIVO PER CUI DOBBIAMO USARE AMPL

# non fa parte delle variabili ma è un preprocessing sui dati
# calcolo delle lunghezze dei percorsi
param lungh {v in V} = sum {t in Tappe[v] : ord(t) > 1} d[prev(t), t]; # distanza da una tappa e la successiva (escludere la prima !)


#		VARIABILI
var x {V} binary;			# scelte dei veicoli

#		VINCOLI
# ogni veicolo deve coprire il proprio percorso ?
subject to covering {p in Paesi} :
	sum{v in V : p in Tappe[v]} x[v] >= 1
;	

#		OBIETTIVO
# minimizzare il numero di ore uomo utilizzate
minimize z :
	sum{v in V} x[v] * lungh[v];
;

data;

param d : 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 :=
1  0   5   7   4   9  13  18  13  16  17  21  16  13  16  17  13  22  20  23  28  34  37  24  11  12  18  18  22  30   7 
2  3   0  10   7  12  16  21  16  19  20  24  19  16  19  20  16  25  23  26  31  37  40  27  14  15  21  21  25  33   2 
3  5  10   0   9   8  12  14   8  11  12  16   9   6   9  10   6  15  13  16  21  27  30  19  16  17  23  13  15  25  12 
4  6  11  13   0   5   9  14   9  12  13  17  12   9  12  17  19  22  16  19  24  30  33  20   7   8  14  14  18  26  13 
5  9  14   8   3   0   4   9   4   7   8  12   7   4   7  12  14  17  11  14  19  25  28  15  10  11  17   9  13  21  16 
6 15  20  14   9   6   0   5  10  10  11  15  13  10  13  18  20  23  17  20  25  31  34  18  16  17  23  12  19  24  22 
7 18  23  17  12   9   3   0  10   5   6  10  13  13  16  21  23  26  17  20  25  31  34  13  19  20  26   7  19  19  25 
8 11  16   8   5   2   6   6   0   3   4   8   4   4   7  12  14  17   8  11  16  22  25  11  12  13  19   5  10  17  18 
9 16  21  13  10   7   6   3   5   0   1   5   8   9  12  17  19  22  12  15  20  26  29   8  17  18  24   2  14  14  23 
10 19  24  16  13  10   7   4   8   3   0   4  11  12  15  20  22  25  15  18  23  29  32   7  20  21  27   5  17  13  26 
11 21  26  18  15  12   9   6  10   5   2   0  13  14  17  22  24  27  17  20  20  26  29   3  22  23  29   7  19   9  28 
12 10  15   5   6   3   7   8   2   5   6  10   0   1   4   9  11  14   4   7  12  18  21  13  13  14  20   4   6  19  17 
13  9  14   4   5   2   6   8   2   5   6  10   3   0   3   8  10  13   7  10  15  21  24  13  12  13  19   7   9  19  16 
14 10  15   5   6   3   7   9   3   6   7  11   4   1   0   5   7  10   4   7  12  18  21  14  13  14  20   8   6  20  17 
15 11  16   6   9   6  10  12   6   9  10  14   7   4   3   0   2   5   7  10  15  21  24  17  16  17  23  11   9  23  18 
16  9  14   4  13  10  14  16  10  13  14  18  11   8   7   4   0   9  11  14  19  25  28  21  20  21  27  15  13  27  16 
17 14  19   9  12   9  13  15   9  12  13  17  10   7   6   3   5   0  10  13  18  24  27  20  19  20  26  14  12  26  21 
18 12  17   7   8   5   9  10   4   7   8  12   2   3   2   7   9  12   0   3   8  14  17  15  15  16  22   6   2  17  19 
19 15  20  10  11   8  12  13   7  10  11  15   5   6   5  10  12  15   3   0   5  11  14  18  18  19  25   9   4  14  22 
20 18  23  13  14  11  15  16  10  13  14  16   8   9   8  13  15  18   6   3   0   6   9  19  21  22  28  12   7   9  25 
21 22  27  17  18  15  19  20  14  17  18  20  12  13  12  17  19  22  10   7   4   0  13  23  25  26  32  16  11  13  29 
22 25  30  20  21  18  22  23  17  20  21  23  15  16  15  20  22  25  13  10   7  13   0  26  28  29  35  19  14  16  32 
23 24  29  21  18  15  12   9  13   8   5   3  16  17  20  25  27  30  20  23  23  29  32   0  25  26  32  10  22  12  31 
24 15  20  22   9  14  18  23  18  21  22  26  21  18  21  26  28  31  25  28  33  39  42  29   0   1   7  23  27  35  22 
25 18  23  25  12  17  21  26  21  24  25  29  24  21  24  29  31  34  28  31  36  42  45  32   3   0  10  26  30  38  25 
26 22  27  29  16  21  25  30  25  28  29  33  28  25  28  33  35  38  32  35  40  46  49  36   7   8   0  30  34  42  29 
27 14  19  11   8   5   7   4   3   1   2   6   6   7  10  15  17  20  10  13  18  24  27   9  15  16  22   0  12  15  21 
28 13  18   8   9   6  10  11   5   8   9  13   3   4   3   8  10  13   1   2   7  13  16  16  16  17  23   7   0  16  20 
29 28  33  24  22  19  16  13  17  12   9   7  19  20  19  24  26  29  17  14  11  17  20  10  29  30  36  14  18   0  35 
30  4   1  11   8  13  17  22  17  20  21  25  20  17  20  21  17  26  24  27  32  38  41  28  15  16  22  22  26  34   0; 



#I pulmini sono 20 ed i loro percorsi, tutti con 6 tappe, 
#sono i seguenti:

set Tappe[1] := 30 13 19 22 23  7;
set Tappe[2] := 17 14  5 24 25 26;
set Tappe[3] := 4 11 23 20 22 21;
set Tappe[4] := 8 12 13  5  6  9;
set Tappe[5] := 1  6 10 29 19 15;
set Tappe[6] := 1  4  6  5 13  3;
set Tappe[7] := 3 16 15 17 14 13;
set Tappe[8] := 28 19 12 13 14 18;
set Tappe[9] := 27 29 23  7  6  5;
set Tappe[10] := 9  8  5  4  6  7;
set Tappe[11] :=17 12  9 23 20 22;
set Tappe[12] :=26  4  8 10 11 23;
set Tappe[13] :=30  2  1 20 21 22;
set Tappe[14] :=25 24  4 13 20 22;
set Tappe[15] :=26 24  4 12 20 21;
set Tappe[16] :=23 11  8 14 15 16;
set Tappe[17] :=23 11 10  1  2 30;
set Tappe[18] :=23 11 29  3  2 30;
set Tappe[19] :=28 18 16  3 27  9;
set Tappe[20] := 9 27 13 18 28 29;

end;

CPLEX 22.1.1.0: optimal integer solution; objective 207
18 MIP simplex iterations
0 branch-and-bound nodes
ampl: 