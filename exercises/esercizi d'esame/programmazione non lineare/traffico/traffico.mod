reset;

#   DATI
archi

#   VARIABILI


#   VINCOLI


#   OBIETTIVO
# minimo tempo complessivo speso dai veicoli
minimize z :
    ;

data;

Il grafo ha cinque nodi numerati da 1 a 5 e gli archi seguenti:

Arco    Tempo-base   Coeff.
(1,2)      20         0.1
(1,4)      14         0.1
(1,5)       7         0.2
(2,1)      20         0.1
(2,3)      22         0.1
(2,5)      15         0.2
(3,2)      22         0.1
(3,4)      15         0.1
(3,5)      10         0.2
(4,1)      14         0.1
(4,3)      15         0.1
(4,5)      10         0.2
(5,1)       7         0.2
(5,2)      15         0.2
(5,3)      10         0.2
(5,4)      10         0.2

Per "tempo-base" si intende il tempo di percorrenza quando non ci sono altri veicoli.
Per "coeff." si intende il coefficiente moltiplicativo del termine quadratico.

==========================

Le coppie O/D sono le seguenti:

Origine   Destinazione   Traffico
   1            3           60
   2            4           80
   3            1          120
   4            2           50

end;