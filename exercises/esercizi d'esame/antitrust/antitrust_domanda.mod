# DATA

param nFiliali := 10;

set filiali := 1..nFiliali;

param nProd := 5;

set prodotti := 1..nProd;

param fatturato {filiali, prodotti}; 

# VARIABILI

var ass {filiali} binary; # 0 assegnato alla prima azienda, 1 viceversa

var delta >= 0; # minmax: rappresenta la maggiore distanza di fatturato 

# VINCOLI
# delta maggiore della massima differenza della somma dei fatturati
subject to deltaC1 :
	delta >= sum {p in prodotti, f in filiali} (fatturato[f,p] * ass[f]) - 
			sum {p in prodotti, f in filiali} (fatturato[f,p] * (1 - ass[f]));
	
subject to deltaC2 :
	delta >= sum {p in prodotti, f in filiali} (fatturato[f,p] * (1 - ass[f])) -
			sum {p in prodotti, f in filiali} (fatturato[f,p] * ass[f]) ;

# OBIETTIVO

# domanda: minimizzzazione della differenza di fatturato complessivo
minimize complessivi : delta;
	
data;

param fatturato : 1 2 3 4 5 :=

1 15000 20000 18000 58000 2400

2 20000 10000 20000 57000 1900

3 18000 23000 17500 55500 9820

4 21000 12000 16800 48000 6000

5 12500 10000 10950 62000 7800

6 13750 22000 14400 60000 2500

7 20500 21000 21000 59800 1980

8 14250 23800 21500 55500 3450

9 10800 14180 25400 53250 6500

10 13700 13980 20100 57500 4000;

end;
