#	DATII

set componenti := 1..3;
set motocicli := 1..3;

param ricavi {motocicli};				# Ricavi dalle vendite 			 [KEuro/motociclo]
param tempi {motocicli};				# Tempi di assemblaggio 		 [giorni-uomo/motociclo]
param coef_tec {componenti, motocicli};	# Coefficienti tecnologici 		 [pezzi/motociclo]
param disp_comp {componenti};			# Disponibilità di materia prima [pezzi/mese]
 
#	VARIABILI
var prodotti {motocicli} >=0;
var ore_lavorate;

#	VINCOLI
# necessità dei componenti per l'assemblaggio
subject to necessita_componenti {c in componenti} :
	sum {m in motocicli} coef_tec[c, m] * prodotti[m] <= disp_comp[c];

# il consumo di manodopera per ogni motociclo
subject to tempi_montaggio :
	sum {m in motocicli} prodotti[m] * tempi[m] <= ore_lavorate;
	
#	OBIETTIVO

# massimizzare i guadagni
# maximize z:
#	sum {m in motocicli} ricavi[m] * prodotti[m];
	
# 	RICERCA DELLA CURVA PARETIANA
var ricavi_tot;

# param parametro = 7848; 		# ore uomo al mese disponibili

subject to zprec : # obiettivo precedente trasformato in vincolo
	ricavi_tot = sum {m in motocicli} ricavi[m] * prodotti[m];

# minimize z: ore_lavorate;
# subject to limite_manodopera : # vincolo che limita la quantità di manodopera disponibile
#	ricavi_tot >= parametro;	
	
# 	domanda 6
maximize z: ricavi_tot - 1000 * ore_lavorate;

data;

param ricavi :=
1	1200
2	1300
3	1200;

param tempi :=
   1        1
   2        1
   3        1;

param coef_tec :
	1	2	3	:=
1	10	12	14
2	5	7	6
3	10	15	9;

param disp_comp :=
   1       91
   2       40
   3       59;
   
end;
1) quali tipi di motocicli sarebbe più conveniente produrre se la manodopera non avesse limiti?
- ampl: display prodotti;
prodotti [*] :=
1  0.14
2  0
3  6.4;
i prodotti da produrre convenienti sono 1 e 3 poichè hanno valori non 0
	
2) in tal caso quale dovrebbe essere il prezzo di vendita dei motocicli non 
	convenienti per renderli convenienti?
(significa stabilire il costo ridotto della variabile)
ampl: display prodotti.rc;
prodotti.rc [*] :=
1    -1.13687e-13
2  -428
3     0;
il prezzo di 2 dovrebbe aumentare di 428

3) Sempre nella stessa ipotesi, i componenti verrebbero smaltiti allo stesso ritmo o
	l’assemblaggio potrebbe provocare rimanenze di pezzi non assemblati? Quanto grandi?
bisogna vedere se è presente uno slack nel vincolo:
ampl: display necessita_componenti.slack;
necessita_componenti.slack [*] :=
1  -1.42109e-14
2   0.872549
3  -7.10543e-15;
per il pezzo 2 è presente un avanzo di 0.9 pezzi che non vengono utilizzati

4) Per quali valori della manodopera non sarebbe conveniente la produzione supplementare?
trovo l'ultimo segmento della curva paretiana: parametro = 7848
ampl: display limite_manodopera;
limite_manodopera = 0.00102804
per ogni unità in meno, il vincolo nel grafico si sposta a sinistra di 0.0010...
facendo l'inverso calcoliamo il coefficiente di pendenza
972.72

5) Per quali valori invece sarebbe conveniente dedicare alla produzione supplementare 
	tutta la manodopera necessaria a massimizzarne il ricavo e qual è tale valore? 

6) Qual è la soluzione ottima se il costo della manodopera è di 1000 Keuro/giorno-uomo?

CPLEX 22.1.1.0: optimal solution; objective 1308.823529
2 dual simplex iterations (1 in phase I)
ampl: display ricavi_tot, ore_lavorate, ricavi;
ricavi_tot = 7818.63
ore_lavorate = 6.5098

ricavi [*] :=
1  1200
2  1300
3  1200;























