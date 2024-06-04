reset;

#		Dati

param nM := 5 ;
set M := 1..nM; 	# set dei mangimi

set I ;		# set degli ingredienti

param nl := 3;		
set L := 1..nl;			# set di linee di mangime

param mix {I, M};		# composizione percentuale delle miscele
param tempi {L, M};		# Tempi di produzione dei mangimi (minuti / quintale) per ogni linea di miscelazione
param disp {I};			# Ingredienti disponibili (quintali / giorno)
param price {M};		# Prezzi di vendita per ogni tipo di mangime (euro / quintale)

param t_start {M};		# istante di inizio produzione di ogni mangime
param t_end {M};		# istante di fine produzione ottimo da esprimere in minuti

# 		VARIABILI ####################################################################################
# quato produco di ogni (segnato con inizio e fine produzione di ogni linea) misurati in minuti
var s {m in M, L} >= t_start[m];		
var e {m in M, L} <= t_end[m] ;

# variabile che calcola la produzione facendo la differenza fra inizio e fine
var x {M, L} >= 0; # in quintali !

#		VINCOLI ####################################################################################
# vincoli sui consumi
subject to consumi {i in I} :
	sum{m in M, l in L} (mix[i, m] /100)  * x[m, l] <= disp[i]
;

# definizione della variable x come la quantità prodotte
subject to xdefine {m in M , l in L} :
	x[m,l] = (e[m ,l] - s[m, l]) / tempi[l,m] # divisione per la conversione in quintali
;

# sulla stessa linea non si possono sovrapporre produzioni di mangimi diverse
subject to precedenza {l in L, m in M : m > 1 } :
	s[m, l] >= e[m-1, l];
;


#		OVIETTIVO ####################################################################################
# massimizzazione dei ricavi
maximize ricavi :
	sum{m in M, l in L} price[m] * x[m,l] # quantità prodotta
; 

data;

set I := A B C D;

param mix(tr) :   A    B    C    D :=
   1               30   20   20   30
   2               40    5   10   45
   3               40   35   10   15
   4               50   20   20   10
   5               50   30    5   15
;

param tempi(tr) :    1      2      3 :=
   1             5      4      2
   2             8      5      2
   3            10     10      2
   4            10      5      5
   5             3      5      5 
;



param disp :=
    A           150
    B           135
    C            90
    D            75
;

param price :=
   1       40
   2       50
   3       35
   4       55 
   5       30
;

# calcolo i minuti a partire dal tempo iniziale 6:00  = 0
param : t_start t_end:=   
	1       0         120
   2       30         180
   3       120        270
   4       225        300
   5      255        360
;

# fine prima parte
end;


Attualmente la produzione avviene con lo scheduling seguente:

  Mangime (Quintali) 1      2      3      4      5
Linea
  1                 27      0     12      0     50
  2                 33.75  13      2.5    6     30
  3                 60      0     90      0     21

=================================================

                MUCCA PAZZA

In seguito al fenomeno della mucca pazza i nuovi prezzi dei mangimi sono i seguenti:

Mangime    Nome     Nuovo prezzo 
                  (Klire/quintale)
   1    Prionello        10
   2       BSE           10
   3    Buonfieno        55
   4     Erbetta         65
   5    Muccasana        40

end;

#		prima parte:
CPLEX 22.1.1.0: optimal solution; objective 12086.25
28 dual simplex iterations (11 in phase I)
ampl: display s, e;
:       s       e      :=
1 1     0     120
1 2     0     120
1 3     0      30
2 1   120     180
2 2   120     180
2 3    30     129.5
3 1   180     225
3 2   180     225
3 3   129.5   270
4 1   225     255
4 2   225     300
4 3   270     300
5 1   255     360
5 2   300     360
5 3   300     360
;

seconda parte:
siccome il problema è infeasible significa che stanno violando qualche vincolo

terza parte:

