reset;

#	DATI
param nvicoli := 10; # numero dei vicoli
param npiat := 3; # numero di piattaforme

set piat := 1..npiat; # set delle piattaforme 
set vicoli := 1..nvicoli;

param x {vicoli};
param y {vicoli};

#	VARIABILI
var xpiat {piat};	# coordinate delle piattaforme
var ypiat {piat};

# collegamento per ogni vicolo-piattaforma
var assign {vicoli, piat} binary; 

# distanza per ogni vicolo - piattaforma
var distanze {v in vicoli, p in piat} = 
	sqrt((x[v] - xpiat[p])^2 + (y[v] - ypiat[p])^2);
	
# distanza fra ogni piattaforma e la precedente
var distp {p in piat : p > 1} = 
	sqrt((xpiat[p] - xpiat[p-1])^2 + (ypiat[p] - ypiat[p-1])^2);

#	VINCOLI

# deve esserci almeno un collegamento da un vicolo ad una piattaforma
subject to assegnamento {v in vicoli}:
	sum {p in piat} assign[v, p] = 1;

#	OBIETTIVO
minimize dist :
	sum {v in vicoli, pi in piat} distanze[v, pi] * assign[v, pi]+
	sum {p in piat : p>1} distp[p] ;

data;

param: x y :=
1	0 1
2	0 3
3	3 7
4	5 9
5	9 9
6	11 8
7	11 7
8	11 4
9	8 6
10	6 1;

var :  xpiat ypiat :=
1		3		5
2		6		5
3		9		5;

end;

knitro;
ampl: display xpiat, ypiat;
:    xpiat      ypiat     :=
1    3.73572   4.95445
2    8         6
3   10.3117    7.18213
;
