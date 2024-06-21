# la difficolt� del problema sta nel dover stimare l'area compresa fra le due funzioni
# (per minimizzarla).
# poich� l'integrale della sigmoide � particolarmente complesso ho scelto di approssimare il calcolo.
# cerco di minimizzare la differenza fra le derivate dei segmenti e del punto medio della sigmoide
# nel range definito dal segmento
# imponendo allo stesso tempo che i punti scelti di inizio e fine dei segmenti debbano
# coincidere con quelli della sigmoide

# il problema � non lineare oltre che per la funzione della sigmoide
# anche per il fatto che si richiedano di dividere variabili come nel caso di m

# il problema non � concavo poich� anche solo facendo variare la x del punto finale del primo 
# segmento si passer� da avere una soluzione non ottima a una soluzione ottima ad una ancora
# non ottimale

# ----------------- soluzione trovata: --------------------------------------------------------
# (knitro implementa le funzioni trigonometriche)
# ampl: model sigmoide.mod;
# ampl: solve;
# Artelys Knitro 14.0.0: outlev=0
# Knitro 14.0.0: Locally optimal or satisfactory solution.
# objective -0.4984674581; feasibility error 6.77e-13
# 9 iterations; 20 function evaluations
# ...

#ampl: display xi, yi, xf, yf, m;
# :     xi        yi       xf        yf          m         :=
# 1   -100     0.002931    -0.5   0.352342   0.00351166
# 2     -0.5   0.352342     0.5   0.647658   0.295317
# 3      0.5   0.647658   100     0.997069   0.00351166
# ;

# come previsto tutti i segmenti hanno pendenza positiva ma quello centrale ha pendenza maggiore di tutti

reset;

#       DATI        ############################################
param nr := 3;		# numero di rette
set R := 1..nr;		# set delle rette disponibili

param Pi := 3.14;	# pi greco

#       VARIABILI   ##########################################
var xi{R} >= -100;			# coordinate di inizio del segmento di retta
var yi{R};
var xf{R} <= 100;			# coordinate della fine dei segmenti
var yf{R};

# coefficienti angolari delle rette (saranno tutti positivi)
var m {r in R} = (yf[r] - yi[r]) / (xf[r] - xi[r]); 

# derivata della funzione per ogni punto medio tra xi e xf
var dx {r in R} = 1 / (1 + ((xi[r] - xf[r])/2)^2) ; 

# differenza fra le pendenze delle due funzioni
var differenza {r in R} = m[r] - dx[r] ;		

#       VINCOLI     #  ##################################################
# i punti devono essere consecutivi, e per evitare che i segmenti siano degeneri
# la lunghezza minima di x deve essere 1
subject to consecutivi {r in R} :
	xf[r] - xi[r] >= 1;
	
# il punto di inizio di un segmento � il punto di fine del precedente
subject to continuita_x {r in R: r > 1}:
	xf[r-1] = xi[r];
subject to continuita_y {r in R: r > 1}:
	yf[r-1] = yi[r];
	
# i punti di inizio e di fine devono coincidere con quelli della sigmoide
subject to inizio_su_sigmoide {r in R}:
	yi[r] = .5 + atan(xi[r]) / Pi;
subject to fine_su_sigmoide {r in R}:
	yf[r] = .5 + atan(xf[r]) / Pi; 

#       OBIETTIVO   ######################################
# minimizzazione dell'errore totale commesso dai tre segmenti
minimize errore :
	sum{r in R} differenza[r];

data;

# inizializzazione di punti di intersezione
var : 	xi 		yi 		xf		yf :=
1		-100	-1		-1		-1
2		-1		-1		1		1	
3		1		1		100		1;
	
end;
