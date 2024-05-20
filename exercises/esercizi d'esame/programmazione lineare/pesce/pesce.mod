# esercizio da terminare

#	DATI
set pesci;
param cap ;					# La capacità della cella (cc)
param tmax;					# tempo disponibile ogni giorno per la pulizia ed il confezionamento (min)
param prezzi {pesci};		# Prezzi di vendita dei prodotti ittici (Euro/Kg)
param vol {pesci};			# Volume occupato nella cella frigorifera (cc/Kg)
param tprep {pesci};		# Tempo di preparazione e confezionamento (min/Kg)
param maxacq {pesci};		# Limiti di acquisto giornaliero (Kg/giorno)

#	VARIABILI
var pp {pesci};			#  pesci prodotti

#	VINCOLI
# il tempo utilizzato per la preparazione non deve eccedere quello massimo
subject to tempo_massimo_preparazione :
	sum{p in pesci} (pp[p] * tprep[p]) <= tmax;

#	OBIETTIVO
# massimizzazione del guadagno
maximize guadagno :
	sum {p in pesci} (pp[p] * prezzi[p]);

data;
set pesci := Pesce_azzurro Pesci_per_frittura Frutti_di_mare;

param prezzi :=
Pesce_azzurro			10
Pesci_per_frittura		7.50
Frutti_di_mare			20;

param vol := 
Pesce_azzurro       10000
Pesci_per_frittura   7500
Frutti_di_mare      12500;

param cap := 50000;

param tprep :=
Pesce_azzurro        11
Pesci_per_frittura    8
Frutti_di_mare       10;

param tmax := 45;

param maxacq :=
Pesce_azzurro            40
Pesci_per_frittura       60
Frutti_di_mare           60;

I limiti si riferiscono alle quantità massime per ogni prodotto se il prodotto fosse l''unico acquistato.

end;

1)	Quali tipi di prodotto ittico è conveniente vendere e quali no?

2)	Per ogni prodotto non conveniente, quale è il minimo aumento di prezzo che lo renderebbe conveniente?

3)	Quali tra i vincoli sono stringenti?

4)	In seguito al diffondersi di allarmanti notizie sull’inquinamento delle cozze, il prezzo di vendita dei frutti di mare può scendere fino a zero. 
	Dire qual è la variazione nei ricavi ottimi giornalieri del sig. Occhioditriglia a seconda del prezzo dei frutti di mare.

5)	Qual è il ricavo giornaliero ottimo nel caso in cui il prezzo dei frutti di mare scenda fino a zero? 

6)	Dire anche quali tra i vincoli sono stringenti a seconda del prezzo dei frutti di mare.
