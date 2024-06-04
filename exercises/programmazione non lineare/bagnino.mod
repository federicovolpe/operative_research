reset;

# 		DATI	##################################################################################
param vmaxc := 24 ; # velocità massima a cui può correre il bagnino
param vmaxn := 6; 	# velocità massima di nuoto

param xp := -10;  	#coordinate di partenza
param yp := 0;

param xa := 20;		#coordinate di arrivo
param ya := 17;	

param r := 3;
param xr := -6;
param yr := 5;

#		VARIABILI	##################################################################################
	
var yc := 15; # coordinate del punto di attraversamento della spiaggia al mare x = 0

var distc1 = sqrt(xp^2 + (yp - yc)^2);	# distanza dal piniziale al recinto
var distn = sqrt(xa^2 + (ya - yc)^2);	# distanza percorsa a nuoto

var alfa1 >= 0, <= 6.28 := 3.14; # inizializzata
var alfa2 >= 0, <= 6.28 := 2.00;	#inizializzata
var alfa  = alfa1 - alfa2; 		# ampiezza dell'arco percorso dal bagnino

var xt1 = xr +r * cos(alfa1);	# punti di incontro con il cerchio (recinto delle tartarughe)
var yt1 = yr +r * sin(alfa1);	# i punti sono tangenti al cerchio dato che il bagnino percorrerà la circ.

var xt2 = xr +r * cos(alfa2);
var yt2 = yr +r * sin(alfa2);

var arco = r * alfa;
var distc2 = sqrt((xa)^2 + (ya - yc)^2); # distanza dal recinto al mare

#		VINCOLI	##################################################################################
subject to arcopositivo :
	arco >= 0;
	
	
	
#		OBIETTIVO	##################################################################################
# minimizzazione del tempo impiegato per 
minimize tempo:
	((distc1 + arco + distc2) / vmaxc)  +
	(distn / vmaxn)  ;
	
# costruzione di un punto a partire da un altro sommandogli un cateto ala volta del rispettivo triangolo
subject to vincolo1 : xt1 = xp + distc1 * sin(alfa1);
subject to vincolo2 : yt1 = yp - distc1 * cos(alfa);
subject to vincolo3 : xt2 = 0 - distc2 * sin(alfa1);
subject to vincolo4 : yt2 = yc + distc2 * cos(alfa2);	
	
	
end;


esercizio 71 molto simile costruisco segmenti utilizzando il seno e il coseno