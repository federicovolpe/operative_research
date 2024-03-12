# DATI
param numOrgani;
param numPosizioni;
set organi := 1..numOrgani;				# organi coinvolti
set posizioni := 1..numPosizioni;		# posizioni posssibili
param posizione_limite {posizioni};		# limite di radiazioni erogabile per ogni posizione
param organo_limite {organi};			# limite di radiazioni ricevibili per ogni organo
param maxRadiazioni;					# Gray massimo di radiazioni erogabili
param mRadiazioni {posizioni, organi};	# matrice delle radiazioni su ogni organo per ogni posizione

# VARIABILI
# quantità di radiazioni da emanare per ogni posizione >= 0
var emesse {posizioni} >= 0;

# VINCOLI
subject to max_emesse :
	sum{p in posizioni} emesse[p] <= 60;

subject to max_radiazioni_posizione {p in posizioni} :
    emesse[p] <= posizione_limite[p];

subject to max_radiazioni_organo {o in organi} :
	sum{p in posizioni} mRadiazioni[p, o] <= organo_limite[o];

# OBIETTIVO

data;

param numOrgani := 8;
param numPosizioni := 5;

param posizione_limite := 1 12 2 13 3 10 4 15 5 15;

param organo_limite :=  1	5.5
                      2	9.0
                      3	6.0
                      4	2.4
                      5	7.0
                      6	5.5
                      7	9.5;

param maxRadiazioni := 60;

param mRadiazioni :	1	2	3	 	4		5 :=
				0	0.4	0.3	0.25 	0.7		0.5	
				1	0.1	0.0	0.0		0.1		0.2
				2	0.1	0.0	0.15	0.0		0.1
				3	0.0	0.1	0.0		0.0		0.0
				4	0.0	0.2	0.1		0.1		0.0
				5	0.1	0.0	0.2		0.0		0.1
				6	0.1	0.3	0.15	0.1		0.1
				7	0.2	0.1	0.15	0.0		0.0;					

end;
