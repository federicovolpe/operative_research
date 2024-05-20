reset;

# 	DATI
param vmaxc := 24 ; # velocità massima a cui può correre il bagnino
param vmaxn := 6; 	# velocità massima di nuoto

param xp := -10;  #coordinate di partenza
param yp := 0;
param xa := 20;	#coordinate di arrivo
param ya := 17;	

param r := 3;
param xr := -6;
param yr := 5;

#	VARIABILI
	# coordinate del punto di attraversamento della spiaggia al mare x = 0
var yc ;
var distc1 = sqrt(xp^2 + (yp - yc)^2);
var distn = sqrt(xa^2 + (ya - yc)^2);

var alfa1 <= 6.28;
var alfa2 <= 6.28;
var alfa  = alfa1 - alfa2;

var xt1 = xr +r * cos(alfa1);
var yt1 = yr +r * sin(alfa1);
var xt2 = xr +r * cos(alfa2);
var yt2 = yr +r * sin(alfa2);

var arco = r * alfa;
var distc2 = sqrt((xt2)^2 + (yt2 - yc)^2);

subject to arcopositivo :
	arco >= 0;
	
#	OBIETTIVO
minimize tempo:
	((distc1 + arco + distc2) / vmaxc)  +
	(distn / vmaxn)  ;
	
end;
