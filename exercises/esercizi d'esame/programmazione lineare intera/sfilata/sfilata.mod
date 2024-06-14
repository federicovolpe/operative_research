#       DATI        ################################
param nn := 10;     # numero di nodi
set N := 0..nn-1;     # set dei nodi
set A within N cross N;     # set di archi del grafico

param cap{A} ;       # capienza delle vie [carri/h]
param costi {A} ;    # costo di ciascun lavoro per ogni via

param nc := 10; # il numero massimo di carri � facilmente deducibile dal grafico

#       VARIABILI        ################################
var scelta {A} binary ;  # scleta di un particolare arco del grafo 

#       VINCOLI        ################################
# vincoli di flusso su ogni nodo
subject to flussi {n in N : n <> 0 and n <> 9}:
     sum{(n2,n) in A} scelta[n2, n] = sum{(n,n2) in A} scelta[n, n2]
;

# vincolo punti di partenza e di arrivo
subject to partenza :
     sum{(0, n) in A} scelta[0, n] = 1;
subject to arrivo :
     sum{(n,9) in A} scelta[n, 9] = 1;

#       DATI        ################################
# minimizzazione dei costi totali
minimize costi_totali :
     sum{(n1,n2) in A} scelta[n1, n2] * cap[n1, n2]
;


data;

param: A:    cap  costi :=
0 1      15       30
0 2      15       60
0 3      20      500
1 3      15       10
1 4      28      180
2 3      20      250
2 5      18       40
3 6      20      200
4 5       9       10
4 7       8       50
5 4       9       50
5 8       8       10
6 7       7      340
6 8       7      410
6 9      10      200
7 9      10      270
8 9      10      290;


end;
