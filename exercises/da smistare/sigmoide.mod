# Il modello risulta essere di programmazione non lineare intera
# Per studiare la convessità, in modo da determinare SE l'ottimo trovato sia globale e di conseguenza unico, fissiamo le variabili binarie
# Dobbiamo analizzare se la derivata seconda dell'obiettivo sia sempre positiva per ogni x
# la derivata prima è 1/(pi * (1+x^2)) - c che è sempre positiva (considerando c la costante derivata dalla sommatoria che nella derivata seconda scompare)
# la derivata seconda invece è -2x/(pi * (1+x^2))^2 che non è sempre positiva (lo è per x<=0)
# QUINDI il problema è non convesso perche la funzione obiettivo non è convessa
# QUINDI il l'ottimo non so se è globale e non so se è unico
reset;
# DATI
param nRette; # Numero di rette che formano la funzione a tratti
set Rette := 0..nRette - 1; # Insieme delle rette
set Punti := 1..nRette - 1; # Insieme dei punti
set Test := -100..100; # Discretizzazione dell'intervallo [-infinito, +infinito] su cui valutare la distanza tra le funzioni
param pi := 3.14159265359;
param M := 2000;
# VARIABILI
var m{Rette}; # Coefficiente della retta
var c{Rette}; # Termine noto della retta
var x{Punti}; # Coordinate x dei punti di discontinuita

var enable{Test, Rette} binary; # 1 SE la x viene valutata con la retta fissata 0 ALTRIMENTI
var y{p in Punti} = m[p] * x[p] + c[p];
var delta{p in Test} = (0.5 + atan(p)/pi) - sum{r in Rette}(enable[p, r] * (m[r] * p + c[r]));
var maxDiff;
# VINCOLI
subject to intersezione{p in Punti} : m[p-1] * x[p] + c[p-1] = m[p] * x[p] + c[p];

subject to LinearizzazioneModulo1 {p in Test} :
 maxDiff >= + delta[p];
subject to LinearizzazioneModulo2 {p in Test} :
 maxDiff >= - delta[p];
# Vincoli per la variabile binaria
subject to retta0 {p in Test} :
    p - x[1] <= (1 - enable[p, 0]) * M;
subject to retta2 {p in Test} :
    x[2] - p <= (1 - enable[p, 2]) * M;
subject to retta1v1 {p in Test} :
    p - x[1] >= enable[p, 1] * (x[1] - p + M);
subject to retta1v2 {p in Test} :
    x[2] - p >= enable[p, 1] * (p - x[2] + M);

subject to unico_enable {p in Test} :
  sum{r in Rette} enable[p, r] = 1;
# FUNZIONE OBIETTIVO
minimize z : maxDiff;
#############
data;
param nRette := 3;
var x :=
1 -2
2 5
;
end;