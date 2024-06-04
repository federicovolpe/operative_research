reset;

#		DATI
set Cont := 1..4;
param cy {Cont};
param ch {Cont};
param q := 0;


#		VARIABILI
var domanda >= 0;
var delta >= 0;


#		VINCOLI

subject to Linearizzazione {c in Cont}:
	delta <= cy[c] + ch[c] * domanda
;

subject to fissoLaDomanda :
	domanda = q
;

#		OBIETTIVO

# l'output dell'esercizio è una funzione
# bisogna analizzare la curva della funzione 
# ogni segmento (offerta) sarà l'ottimo per una certa quantità di domanda
 

data;

# primo q
#param q := 0.1;

# secondo q poco più del precedente valore di fissoLaDomanda
# param q = 1700;

# terzo q poco più del precedente valore di fissoLaDomanda
 param q = 5500;

param : cy ch :=
1 $1560   0.128
2 $1280   0.192
3  552   $0.312/ora
4      0 $0.640 ;


end;

il quarto contratto è quello più conveniente per un q basso perchè non ha slack(marginalità)
il valore di FissoLaDomanda 1600 è il punto di discontinuità (da 0 a 16..) vale il contratto 4

con il secondo q il terzo contratto è quello più conveniente da (16.. a 5000..)

con il terzo q il primo contratto diventa quello più conveniente (5000+ a inf)

IL CONTRATTO 2 SEMBRA ESSERE QUELLO MAI CONVENIENTE !!!