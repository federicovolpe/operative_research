# secodno problema che provo a risolvere NON RIUSCITO

# Identificare le attività critiche
# Le attività critiche sono le attività che hanno la variabile tempo fuori base
# questo significa che cambiando la sua durata, viene influenzata anche l'obiettivo quindi la durata totale

# Di quanto potrebbe aumentare la durata di ciascuna attività non-critica ?
# bisogna guardare i coefficienti della activity range delle attività in base

# Di quanto dovrebbe diminuire la durata di ciascuna attività critica affinchél’attività cessi di essere critica
# bisogna guardare Object coefficient marginal ovvero la variazione del coefficiente della variabile
# che farebbe tornare l'utilizzo della variabile vantaggioso


#       DATI        ############################################
set Att;         # set delle attività
param Dx {Att};           # durata della attività a usando solo x
param Dy {Att};           # 
param prec{Att, Att};		# precedenze, 1 = X è preceduto da Y

param xtot := 100;		# percentuale totale da suddividere nelle diverse attività
param ytot := 100;

#       VARIABILI   ##########################################
var qx {Att} >= 0;			# quantità di materia prima x per la attività a (in percentuale)
var qy {Att} >= 0;
var tempo {Att};			# tempo per svolgere una attività 

var start_time {Att} >= 0;  # tempo di inizio dell'attività
var end_time {Att} >= 0;    # tempo di fine dell'attività

#       VINCOLI     #######################################
# la somma di tutte le percentuali di quantità di x utilizzate nella attività deve essere il totale di x
subject to totale_x :
	sum{a in Att} qx[a] = xtot;
subject to totale_y :
	sum{a in Att} qy[a] = ytot;

# definizione del tempo impiegato per ogni attività
# pari alla quantità di x + la quantità di y utilizzate per la attività, sul totale
subject to def_tempo {a in Att} :
	tempo[a] = (qx[a] * Dx[a]) + (qy[a] * Dy[a]);

# vincoli di precedenza
subject to precedence {a in Att, b in Att: prec[b, a] == "1"}:
    start_time[a] >= end_time[b];

#       OBIETTIVO   ######################################
# minimo tempo necessario per poter completare l'intero progetto
minimize z :
	sum{a in Att} tempo[a];

data;
set Att := A B C D E F G H;

# Attività	Durata con solo X [min]	Durata con solo Y [min]	Attività precedenti
param : Dx          Dy          prec :=
A		30			20			.
B		15			45			.
C		25			 5			.
D		32			12			A
E		14			12			A,B
F		19			49			B,C
G		20			10			D,E
H		10			18			D,E;

param prec :A	B	C	D	E	F	G	H:=
A			0	0	0	0	0	0	0	0
B			0	0	0	0	0	0	0	0
C			0	0	0	0	0	0	0	0
D			1	0	0	0	0	0	0	0
E			1	1	0	0	0	0	0	0
F			0	1	1	0	0	0	0	0
G			0	0	0	1	1	0	0	0
H			0	0	0	1	1	0	0	0;

end;
