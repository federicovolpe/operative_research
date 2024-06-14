#	DATI
param nf := 10;			# numero di filiali
set F := 1..nf;			# set di filiali
set P;
param fat {F,P};

#	VARIABILI
var assign {F} binary; # 1 = assegnata al primo 0 = assegnata al secondo
var fattA {P} >= 0;
var fattB {P} >= 0;
var d;

#	VINCOLI
s.t. fatturato_a {p in P}:
	fattA[p] = sum{f in F} (assign[f] * fat[f,p]);
s.t. fatturato_b {p in P}:
	fattB[p] = sum{f in F} ((1- assign[f]) * fat[f,p]);


#	OBIETTIVO
# minimizzazione del fatturato totale
minimize f :
	d
;
s.t. dmaxdmassima1 :
	d >= sum{p in P} (fattA[p] - fattB[p]);
s.t. dmassima :
	d >= sum{p in P} (fattB[p] - fattA[p]);

data;
set P := A	B	C	D	E;

param fat:  A      B      C      D      E :=
  1       15000  20000  18000  58000   2400
  2       20000  10000  20000  57000   1900
  3       18000  23000  17500  55500   9820
  4       21000  12000  16800  48000   6000
  5       12500  10000  10950  62000   7800
  6       13750  22000  14400  60000   2500
  7       20500  21000  21000  59800   1980
  8       14250  23800  21500  55500   3450
  9       10800  14180  25400  53250   6500
 10       13700  13980  20100  57500   4000;


end;