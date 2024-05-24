reset;

#	DATA

param alfa := 89.3;# angolo alla base del cono
param vol := 310;	# volume del cono 

#	VARIABILI
var h; # altezza del cono con l'acqua
var b = h: 89 = x : 0.7; # base del cono creato con l'acqua
var vv = h + 24;					# volume di acqua versato
var perc = vv / vol; 		# quantità di acqua nel bicchiere espresso in percentuale
var p = if perc < 50 then 0 else (perc - 50) * 2;			# probabilità di rovesciare l'acqua

#	VINCOLI


#	OBIETTIVO
maximize utilita :
	perc * (1 - p);

end;32,25

data la base del cono e l'altezza del tronco posso calcolare il volume del 
piccolo cono rimanente calcolandomi l'altezza usando le proporzioni
8 : 1 = x : 4
x = 32 (altezza totale del cono)

r^2 * pi
(4^2 * pi) * 32 /3 = 536.16 (volume totale del cono)
h 8-32 = 24(altezza del cono piccolo)
(3^2 * pi) * 24/3 = 226.19
