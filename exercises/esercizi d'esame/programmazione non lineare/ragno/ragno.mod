# 	DATI

set appigli := 0..2;
param cx {appigli};
param cy {appigli};
param cz {appigli};

param areamin := 100;

#	VARIABILI
var vx {a in appigli} := cx[a] /2;		# coordinate x dei vertici del triangolo
var vy {a in appigli} := cy[a] /2;		# coordinate x dei vertici del triangolo
var vz {a in appigli} := cz[a] /2;		# coordinate x dei vertici del triangolo

var lati {a in appigli} =  
		  sqrt((vx[(a+1)mod 3]- cx[(a+2)mod 3])^2 #	differenza delle x... il punto a e i vertici opposti
			+ (vy[(a+1)mod 3]- cy[(a+2)mod 3])^2 
			+ (vz[(a+1)mod 3]- cz[(a+2)mod 3])^2);
			
var semip = sum {a in appigli} lati[a] / 2; # semiperimetro del triangolo

var links {a in appigli} = 
	 sqrt((vx[a]- cx[a])^2 
		+ (vy[a]- cy[a])^2
		+ (vz[a]- cz[a])^2);	# links fra ogni vertice del triangolo e ciascuno degli appigli

#	VINCOLI

	
# Il triangolo portante deve avere area non inferiore ad un certa soglia minima
subject to area :
	semip * (semip-lati[0]) * (semip-lati[1]) * (semip-lati[2]) = areamin ^2;
	
#	OBIETTIVO
# minimizzazione del perimetro del triangolo
minimize z:
	sum {a in appigli} (lati[a] + links[a]);

data;

param: 	cx	cy	cz:=
0		30  50  50
1		60  10  45
2		40  30  10;

end;

il problema e' di tipo convesso per la funzione obiettivo