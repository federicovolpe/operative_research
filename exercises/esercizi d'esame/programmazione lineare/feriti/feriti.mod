#		DATI	#######################################
param nt := 6;			# numero punti di triage
set T := 1..nt;			# set dei punti di triage

param no := 8;			# numero di ospedali
set O := 1..no;			# set degli ospedali

param ntp := 3;			# numero di tipi di pazienti
set Tp := 1..ntp;		# set dei tipi di pazienti

param tempi {T,O};			# Tempi di percorrenza [minuti]
param capO {Tp, O};		# capienza per ogni tipo di paziente in ogni ospedale
param capT {T, Tp}		# capienza per ogni punto di triage

#		VARIABILI	#######################################
var tr_os {}
var rr {};		# ritardo relativo def : tempo di percor. dal triage all'ospedale / minimo tempo di percorrenza dal triage ad un ospedale che può accogliere il ferito

#		VINCOLI	#######################################


#		OBIETTIVO	#######################################
# minimizzazione del ritardo relativo medio
minimize ritardo_r_m :
	sum{}/ sum{}
;

data;

param Tempi : 1   2   3   4   5   6   7   8 :=
1      10  12  15  20  32  36  40  50
2      14   8   5  10  30  38  40  48
3      21  22  10  10  32  25  25  40
4      24  22  15  15  20  15  25  45
5      30  30  25  28  27  22  20  30
6      32  35  30  30  28  25  20  20;

param capO: 1   2   3   4   5   6   7   8 :=
1      12  10   8  10  15  20  20  20
2       5   0   2   0   8   0   0  10
3      15   8  11   5  20  18  13   0;

param cap: 1   2   3
  1       3   0   5
  2      11   1   6
  3      23   9   0
  4      12   5  12
  5      19   2  19
  6      22   3  28;

#Totale   90  20  70
end;
