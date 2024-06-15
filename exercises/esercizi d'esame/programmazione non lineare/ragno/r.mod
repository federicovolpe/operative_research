reset;

#		DATA	#####################################################
param na := 2;		# numero di appigli
set A := 0..na;		# set degli appigli
param xa {A};		# coordinate degli appigli
param ya {A};
param za {A};

param minarea := 100;	# area minima della ragnatela

#		VARIABILI	#####################################################
var xp {A};		# coordinate dei tre vertici del triangolo
var yp {A};
var zp {A};
var l {a in A} = sqrt((xp[(a+1) mod 3] - xp[a])^2 + 
				 (yp[(a+1) mod 3] - yp[a])^2 + 
				 (zp[(a+1) mod 3] - zp[a])^2);
					 
var p = sum{a in A} (l[a]) / 2;
var area = sqrt(p * (p - l[0]) * (p - l[1]) * (p - l[2]));

#		VINCOLI	#####################################################
subject to area_minima :
	area >= minarea
;

#		OBIETTIVO	#####################################################
# minimizzare la quantità di filo necessaria
minimize filo :
	2 * p + 
	sum{a in A} (abs(xa[a] - xp[a]) + 
					abs(ya[a] - yp[a]) + 
					 abs(za[a] - zp[a])) ;

data;

param :	xa	ya	za :=
0		30  50  50
1		60  10  45
2		40  30  10;

var :	xp	yp	zp :=
0		30  50  50
1		60  10  45
2		40  30  10;
end;	
