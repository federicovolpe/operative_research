# non si capisce una sega della consegna

#       DATI
param l := 100;          # lato del quadrato misurata        [km]
param nr := 15;          # numero dei punti di raccolta 
set R := 1..nr;          # set dei punti di raccolta

param xr {R};           # coordinate dei punti di raccolta  [km]
param yr {R};           # y raccolta                                [km]
param Q {R};            # quantità di legname fornito da ciascun punto di raccolta (quintali giornalieri)

param ct := 10000;      # lire /km/quintale costo in lire per il trasporto

param ns := 5;          # numero di segherie
set S := 1..ns;         # set delle segherie
param xs {S};           # coordinate delle segherie
param ys {S};
param cm {S};           # costi di manutenzione per ciascuna segheria [lire]
param cap{S};           # capacità per ogni segheria [quintali / giorno]

#       VARIABILI
# distanze da una segheria a ciascun punto di raccolta
var dist {s in S, r in R} = 
         sqrt((xr[r] - xs[s])^2 + (yr[r] - ys[s])^2) ;
         
# assegnamento di ciascun punto di raccolta con una segheria
var assign {R, S} binary;

#       VINCOLI
# ogni punto di raccolta deve essere assegnata ad almeno una segheria
subject to assegnamento {r in R} :
   sum {s in S} assign[r,s] >= 1
;

# la capacità massima delle segherie non deve essere ecceduta
subject to maxcap {s in S} :
   sum{r in R} (Q[r] * assign[r,s]) <= cap[s]
;

#       OBIETTIVO
# minimizzare le distanze perccorse per il trasporto dei tronchi
minimize costi :
   sum{s in S, r in R} 
      (dist[r,s] * ct * assign[r,s]) # costi di trasporto, distanze per costi
;

data;

param : xr  yr      Q :=
1       40  66     58
2       76  17     35
3       11  47     27
4       65  58     42
5       18  88     60
6       19  02     31
7       62  62     18
8       90  17     24
9       66  95     36
10      42  00     37
11      95  12     48
12      16  26     39
13      07  71     53
14      75  43     61
15      30  76     29
;

param : xs      ys      cm      cap :=
1       25      20      3000    190 
2       55      25      4500    240
3       90      15      3000    200
4       15      45      4400    220
5       85      55      4600    190
;

end;
