#	DATI
set bisc;               	# tipologie di biscotto
set ing ;               	# insieme degli ingredienti
param tempi {bisc};			# quantita' di produzione massima giornaliera (Kg / giorno) se l'azienda producesse solo il biscotto b
param perc {ing, bisc};      # percentuali di ingredienti per ciascun biscotto
param prezzi {bisc} ;       # prezzi di vendita per ciascun tipo di biscotto (Euro/ Kg)
param costi {ing};          # costi per ciascun ingrediente (Euro/ Kg)
param minq {ing};           # Quantita' minime di ingredienti da acquistare (Kg / settimana)
param pmin {bisc};          # Quantita' minime da produrre (Kg / settimana)
param pmax {bisc};          # Quantita'  massime da produrre (Kg / settimana)
param budget ;              # Budget disponibile per il trimestre (Euro)  
param tempo := 5 * 12;

#	VARIABILI
var q {b in bisc} <= pmax[b], >= pmin[b];    # quantità di biscotti prodotta per ogni tipo
var prestito >= 0;								# ipotetico prestito chiesto alla banca
var rest;									# quantità di denaro da restituire con il prestito

#	VINCOLI
# il tempo di produzione è limitato
subject to tempoLim :
  sum {b in bisc} (q[b] / tempi[b]) <= tempo;

# il valore dell'investimento non può superare il budget
subject to limBudget :
  sum {b in bisc, i in ing} (perc[i, b] * q[b] * costi[i]) <= budget + prestito; # aggiunta la quantità prestata

# totale da restituire alla banca
subject to allaBanca :
	rest = (prestito * 6 / 100) + prestito;

#	OBIETTIVO
maximize guadagni : 
  sum {b in bisc} (q[b] * prezzi[b]) - 
  sum {b in bisc, i in ing} (perc[i, b] * q[b] * costi[i]) - rest;

data;
set bisc := Svegliallegra   Frollino       Alba      ProntiVia;
set ing := Farina Uova Zucchero Burro Latte Additivi Nocciole Acqua;

param perc:         Svegliallegra   Frollino       Alba      ProntiVia :=
Farina          .20           .25           .30           .20
Uova            .15            0           .10           .20
Zucchero        .20           .15           .25           .10
Burro            0            0           .10           .10
Latte           .10           .20           .20           .15
Additivi        .15           .20            0            .15
Nocciole        .10            0            0            0
Acqua           .10           .20           .5            .10;

param tempi :=
Svegliallegra    165
Frollino  250
Alba     500
ProntiVia       250;

param prezzi :=
Svegliallegra    1.75
Frollino  1.00
Alba     1.25
ProntiVia       1.50;

param costi :=
Farina    0.5
Uova      2
Zucchero  0.5
Burro     1
Latte     1.5
Additivi  1
Nocciole  5
Acqua 0;

param minq :=
Farina    450
Uova      200
Zucchero  320
Burro     140
Latte     320
Additivi  100
Nocciole   50;

param :             pmin    pmax :=
Svegliallegra       50     300
Frollino            100     500
Alba                500    1000
ProntiVia           300     500;

param budget := 21600 ;

end;

1.	Una multinazionale straniera vuole valutare la possibilità di acquistare 
  l’azienda e vuole sapere quanto rende il capitale investito in essa. 
  Dare una risposta quantitativa e motivata.
  
  suppongo che per rendita si intenda il guadagno possibile nell'arco analizzato
  Objective:  guadagni = 897.5 (MAXimum)

2.	Chiedendo un prestito bancario per il trimestre in questione, 
  il budget potrebbe essere incrementato. 
  Conoscendo l’interesse praticato dalla banca (pari al 6%), 
  decidere se sia conveniente chiedere il prestito e, in caso affermativo, 
  per quale somma e con quale convenienza.
  
  guardare biscotti2.mod

3.	Un’azienda specializzata in pubblicità di prodotti alimentari fa pervenire la seguente proposta: 
  con una campagna pubblicitaria adeguata, centrata su un particolare tipo di biscotto, 
  gli esperti di mercato stimano che sarebbe possibile raddoppiare la quantità vendibile 
  (solo per il biscotto reclamizzato). 
  Poiché la campagna avrebbe lo stesso costo indipendentemente dal tipo di biscotto, 
  l’amministratore propone di farla e di concentrarla sul biscotto di prezzo massimo. 
  Valutare la sua proposta.

4.	Alcuni fornitori, alle prese con difficili problemi logistici di distribuzione dei prodotti, 
  intendono alzare del 5% le quantità minime per le ordinazioni, 
  per ricevere dai loro clienti ordinazioni trimestrali più consistenti. 
  L'addetto agli acquisti è molto allarmato dall’alternativa tra dover accettare un aumento 
  del prezzo degli ingredienti (non potendo più usufruire degli sconti per ordinazioni 
  superiori al limite fissato) e dover accettare di fare ordinazioni maggiori 
  col rischio di comprare più ingredienti di quanto occorra. 
  Per quali ingredienti le sue preoccupazioni sono fondate?
