#	DATI	##########################################
param nr := 40;
set R := 1..nr;			# set delle richieste
param I {R};			# istante iniziale di ciascuna richiesta
param F {R}; 			# istante finale di ogni richiesta
param T := 300; 				# tempo per poter trasmettere le immagini alla terra

param V {R};			# valore di ogni richiesta
param TT {R}; 			# tempo di ogni trasmissione
set Ifor ; # immagini che devono per forza essere scattate

#	VARIABILI	##########################################
var scelta {R} binary; # 1 se la richiesta viene scelta 0 altrimenti

#	VINCOLI	##########################################
# vincolo sul tempo totale di trasmissione
subject to tempo_totale :
	T >= sum{r in R} TT[r] * scelta[r]
;
# vincolo sulla sovrapposizione delle immagini
# si sovrappongono quando l'inizio di una è prima della fine dell'altra
subject to sovrapposizione {r1 in R, r2 in R: (r1 < r2) and (I[r1] < F[r2]) and (I[r2] < F[r1])} :
	scelta[r1] + scelta[r2] <= 1
;

# vincolo sulle immagini forzate
subject to immagini_forzate {f in Ifor} :
	scelta[f] = 1
;

#	OBIETTIVO	###########################################
#massimizzazione dei ricavi
maximize ricavi :
	sum{r in R} V[r] * scelta[r] 
;

data;

set Ifor := 2 3 6 13 16 24 37;

param : I	F	TT	V:=
1   0   6   10  400
2   4   8   12  280
3   8   10  18  186
4   12  14  17  325
5   16  18  15  315
6   20  21  21  290
7   20  22  10  281
8   22  24  28  256
9   24  28  24  289
10   28  30  15  333
11   32  35  16  401
12   36  40  18  286
13   40  42  24  245
14   40  44  17  197
15   40  48  25  245
16   42  50  12  233
17   44  48  11  168
18   45  48  16  312
19   46  52  16  176
20   47  50  17  348
21   48  56  15  194
22   50  54  12  396
23   54  56  15  296
24   58  70  11  267
25   60  62  15  339
26   61  66  19  229
27   62  64  18  201
28   63  64  20  300
29   64  68  12  360
30   65  70  28  411
31   66  68  13  284
32   66  70  16  293
33   66  72  17  330
34   68  72  13  209
35   70  72  14  248
36   72  78  14  190
37   74  76  19  184
38   75  80  10  294
39   75  84  10  299
40   78  82  11  310;

end;

il meglio che posso fare è mettere i secondi di trasmissione a 302, dopo questo
valore il risultato non può migliorare per i vincoli di sovrapposizione