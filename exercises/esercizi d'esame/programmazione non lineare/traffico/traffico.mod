reset;

#   DATI  ##############################################################################
param nn := 5;  					# numero di nodi
set N := 1..5;						# set dei nodi del grafo
 
set A within N cross N ;			# archi che connettono i nodi
param tb {A} default 0 ;			# il tempo di percorrenza quando non ci sono altri veicoli. 
param k {A} default 0;				# il coefficiente moltiplicativo del termine quadratico.

set C within N cross N;				# insieme delle coppie
param traffico {C};					# traffico per ogni coppia di nodi

#   VARIABILI  ##############################################################################

# per ogni coppia origine destinazione
var x {A, C} >= 0; # variabile di flusso sull'arco in Ain commodity (o,d ) in C
# misurato in veicoli all'ora che passano per di li

var flusso{(i,j) in A} = sum {(o,d) in C } x[i,j, o, d] ;
var tempo {(i, j) in A} = tb[i,j] + k[i,j] * (flusso[i,j]^2); # tempo base dell'arco..  (formulina del testo)

#   VINCOLI  ##############################################################################

# vincolo di conservazione del flusso per ogni nodo
subject to fc {(o, d) in C, i in N : i <> o and i <> d} : # fissata una coppia origine destinazione e preso un generico nodo 
	sum {(j,i) in A} x[j, i, o , d] # flusso entrante
	- sum {(i,j) in A} x[i, j, o , d] # flusso uscente
	 = 0
;

# per il primo nodo
subject to fcinit {(o, d) in C} : # fissata una coppia origine destinazione e preso un generico nodo 
	sum {(j,o) in A} x[j, o, o , d] # flusso entrante
	- sum {(o,j) in A} x[o, j, o , d] # flusso uscente
	 = - traffico[o, d]
;

# per il nodo finale
subject to fcend {(o, d) in C} : # fissata una coppia origine destinazione e preso un generico nodo 
	sum {(j,d) in A} x[j, d, o , d] # flusso entrante
	- sum {(d,j) in A} x[d, j, o , d] # flusso uscente
	 = traffico[o, d]
;

#   OBIETTIVO  ##############################################################################

# minimo tempo complessivo speso dai veicoli
minimize z :
	sum {(i, j) in A, (o, d) in C} 
	(x[i,j,o,d]# quanti automobilisti hanno quel tempo di attraversamento
	* tempo[i, j])# il tempo di attraversamento    
;


data;   ##############################################################################

param : A : tb 			k :=
1 2      20         0.1
1 4      14         0.1
1 5       7         0.2
2 1      20         0.1
2 3      22         0.1
2 5      15         0.2
3 2      22         0.1
3 4      15         0.1
3 5      10         0.2
4 1      14         0.1
4 3      15         0.1
4 5      10         0.2
5 1       7         0.2
5 2      15         0.2
5 3      10         0.2
5 4      10         0.2;

param :C : traffico :=
   1            3           60
   2            4           80
   3            1          120
   4            2           50;

end;


SNOPT 7.5-1.2 : Optimal solution found.
86 iterations, objective 159492.3809
Nonlin evals: obj = 24, grad = 23.
ampl: display x;
x [*,*,1,3]
:   1      2         3          4         5       :=
1   .   28.0709     .        7.39197   24.5372
2   0     .       28.0709     .         0
3   .    0          .        0          0
4   0     .        7.39197    .         0
5   0    0        24.5372    0           .

 [*,*,2,4]
:     1      2      3         4         5       :=
1     .      0     .       32.173     0
2   32.173   .   11.1327     .       36.6942
3     .      0     .       11.1327    0
4    0       .    0          .        0
5    0       0    0        36.6942     .

 [*,*,3,1]
:      1         2      3      4         5       :=
1     .        0        .    0         0
2   29.3934     .       0     .        0
3     .       29.3934   .   50.5829   40.0237
4   50.5829     .       0     .        0
5   40.0237    0        0    0          .

 [*,*,4,2]
:       1             2           3      4      5       :=
1    .            0.00099305     .       0    0
2   0              .            0        .    0
3    .           20.9442         .       0    0
4   0.00099305     .           20.9442   .   29.0548
5   0            29.0548        0        0     .
;
