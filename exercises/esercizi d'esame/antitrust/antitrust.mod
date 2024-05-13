# DATA

param nFiliali := 10;

set filiali := 1..nFiliali;

param nProd := 5;

set prodotti := 1..nProd;

param fatturato {filiali, prodotti}; 

# VARIABILI

var ass {filiali} binary; # 0 assegnato alla prima azienda, 1 viceversa

var delta >= 0; # minmax: rappresenta la maggiore distanza di fatturato per due prodotti

# VINCOLI
# il delta deve essere maggiore della massima differenza di fatturato per prodotto
subject to delta1 {f in filiali, p in prodotti}:
	delta >= fatturato[f,p] * (1 - ass[f]) - fatturato[f,p] * ass[f];
	
subject to delta2 {f in filiali, p in prodotti}:
	delta >= fatturato[f,p] * ass[f] - fatturato[f,p] * (1 - ass[f]);

# OBIETTIVO

minimize differenza : delta; # l'obiettivo è un minmax, viene introdotta la variabile delta
	
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

Come cambierebbe il problema e come cambierebbe la soluzione ottima 
se si volesse minimizzare la differenza di fatturato complessivo tra le due aziende-figlie? 
Che relazione esiste tra i due problemi?

guardare il file antritrust_domanda.mod






