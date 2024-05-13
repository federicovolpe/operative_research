reset;

#	DATI
param xp := 10000;
param yp := 350;

param quota := 200; # quota dell'altopiano
param xa := 11000;  # x di inizio dell'altopiano
param vel := 100;  # velocità del proiettile [m/sec]
param g := 9.8; 	# accelerazione di gravità [m/sec^2]	
param xmax := 9500;	# massima ascissa consentita

#	VARIABILI

var ascisse <= 8500; 	# ascisse dove ci si vuole posizionare
var x0 <= xmax;			# punto di posizionamento
var x1	>= xa;			# punto colpito dalla prima parabola(nell'altopiano)
var x2	>= xa;			# punto colpito dalla seconda parabola
var alfa1 >= 0, <= 3.14/2	;		# angolo di tiro della prima parabola
var alfa2 >= 0, <= 3.14/2	; 		# angolo di tiro della seconda parabola

#	VINCOLI

# la traiettoria deve passare sopra la montagna 
subject to par1:
	tan(alfa1) * (xp-x0) + 1/2 * g *(xp-x0)^2/(vel^2 * cos(alfa1)^2) >= yp;
subject to par2:
	tan(alfa2) * (xp-x0) + 1/2 * g *(xp-x0)^2/(vel^2 * cos(alfa2)^2) >= yp;

# calcolo dei punti di caduta
subject to punto1:
	tan(alfa1) * (x1-x0) + 1/2 * g *(x1-x0)^2/(vel^2 * cos(alfa1)^2) = quota;
subject to punto2:
	tan(alfa2) * (x2-x0) + 1/2 * g *(x2-x0)^2/(vel^2 * cos(alfa2)^2) = quota;
	
subject to dif :
	x2 >= x1+1;
	
# 	OBIETTIVO

# trovare la localizzazione ottimale per poter battere 
# la maggior area possibile data dalla differenza dei punti.
maximize z :
	x1 - x2;

end;


con i dati originali non è possibile scavalcare la cresta