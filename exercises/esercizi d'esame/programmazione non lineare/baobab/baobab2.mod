# DOMANDA:
# fino a che livello sarebbe tollerabile l'eventuale diminuzione del prezzo di vendita della farina?
# ergo: che cosa succede al prezzo di vendita (maxp) quando il profitto risulta nullo?

#	DATI
param c_acq := 1000.00; 		# Costi fissi di acquisto delle macchine		[Euro]
param c_prod := 10.00; 			# Costi variabili di produzione					[Euro/Kg]
param k := 80;	 				# Coefficiente di proporzionalità				[]
param abs := 70;				# Quantità massima che il mercato puÚ assorbire	[Kg/mese]

# in questa versione del problema il prezzo e' la variabile da ricercare
var maxp := 20.00;			# Prezzo massimo di vendita 					[Euro/Kg]

#	VARIABILI
var produzione >=0, # radice quadrata della quantità da produrre [Kg/mese]
<= abs, 	# vincolo: non si può superare la quantità massima da produrre
:= abs ;											

#	VINCOLI
# si suppone che la quantita prodotta sia il massimo assorbibile dal mercato
subject to fixprod : produzione = abs;

# trasformazione del precedente obiettivo in vincolo
subject to profitto0 :	# ricerco il punto dove il profitto risulta nullo
	maxp * produzione - c_prod * produzione - k * sqrt(produzione) = 0;
	

#	OBIETTIVO

# la radice quadrata rende il problema non lineare !

end;
