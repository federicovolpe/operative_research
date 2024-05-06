#	DATI
param c_acq := 1000.00; 		# Costi fissi di acquisto delle macchine		[Euro]
param c_prod := 10.00; 			# Costi variabili di produzione					[Euro/Kg]
param k := 80;	 				# Coefficiente di proporzionalità				[]
param abs := 70;				# Quantità massima che il mercato puÚ assorbire	[Kg/mese]
param maxp := 20.00;			# Prezzo massimo di vendita 					[Euro/Kg]

#	VARIABILI
var produzione >=0, # radice quadrata della quantità da produrre [Kg/mese]
<= abs, 	# vincolo: non si può superare la quantità massima da produrre
:= abs ;											


#	OBIETTIVO
# massimizzare il guadagno (ricavi - costi)
maximize z: 
	maxp * produzione - c_prod * produzione - k * sqrt(produzione);
	
# la radice quadrata rende il problema non lineare !

end;

# conviene entrare sul mercato?
obiettivo trovato : 30.67.. si

# con quale valore di produzione?
con il massimo valore di produzione, 70
 
# quanto tempo sarà necessario per ammortizzare i costi iniziali di acquisto delle macchine?
1000 / obiettivo trovato

# fino a che livello sarebbe tollerabile l'eventuale diminuzione del prezzo di vendita della farina?
guardare il file baobab2.mod
19.5618