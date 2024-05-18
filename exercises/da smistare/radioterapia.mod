#	DATI
set organi := 1..8;						# set degli organi (il primo è il tumore)
set posizioni := 1..5;					# postazioni da cui emettere le radiazioni
param lim_rad := 60;					# radiazioni totali [Gray]
param radiazioni {organi, posizioni};	# percentuali di radiaizoni subite [%]
param lim_pos {posizioni};				# limite di radiazioni emanabili per pos [Gray]
param lim_org {organi};					# limite di radiazioni ricevibili per org [Gray]

#	VARIABILI
# radiazioni che vengono emanate per ogni posizione
var emanate {posizioni} >= 0;

#	VINCOLI
# il totale delle radiazioni emanate non può essere superiore al limite
subject to limite_emanate :
	sum {p in posizioni} emanate[p] <= lim_rad;

# limite delle radiazioni emanate per ogni posizione
subject to limite_posizioni {p in posizioni}:
	 emanate[p] <= lim_pos[p];

# le radiazioni subite da ogni organo devono essere inferiori al limite
# radiazioni subite = somma delle emanate da ogni posizione
subject to limite_subite_organi {o in organi}:
	sum {p in posizioni} (emanate[p] * radiazioni[o, p]) <= lim_org[o];

#	OBIETTIVO
# massimizzazione delle radiazioni subite dal tumore
# ovvero la somma delle radiazioni ricevute dal tumore considerado
# quante ne sono state emanate per ogni posizione
maximize z : 
	sum {p in posizioni} (emanate[p] * radiazioni[1, p]);

data;
param lim_pos :=
1 	12
2 	13
3 	10
4 	15
5 	15;

param lim_org :=
1	670
2	5.5
3	9.0
4 	6.0
5 	2.4
6 	7.0
7 	5.5
8 	9.5;

param radiazioni:1	2	3	4	5 :=
1				.4	.3	.25	.7	.5
2				.1	0	0	.1	.2
3				.1	0	.15	0	.1
4				0	.1	0	0	0
5				0	.2	.1	.1	0
6				.1	0	.2	0	.1
7				.1	.3	.15	.1	.1
8				.2	.1	.15	0	0;

end;