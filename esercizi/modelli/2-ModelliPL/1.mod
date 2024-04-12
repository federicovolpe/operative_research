# [1] Mix produttivo ottimale

# Insiemi
set Reparti;
set Prodotti;
set Combinazioni within {Reparti,Prodotti};

# Dati
param Capacita {Reparti};
param Profitti {Prodotti};
param Tempi {Combinazioni};

# Variabili
var x {Prodotti} >= 0;

# Funzione obiettivo
maximize z : sum{j in Prodotti} Profitti[j] * x[j];

# Vincoli
subject to VincoloTempi {i in Reparti} :
    sum{j in Prodotti: (i,j) in Combinazioni} Tempi[i,j] * x[j] <= Capacita[i];

########################################################################################
data;

# Insiemi
set Reparti := Motori Carrozzeria FinituraA FinituraB FinituraC;
set Prodotti := A B C;
set Combinazioni :=
    (Motori,A)          (Motori,B)          (Motori,C)
    (Carrozzeria,A)     (Carrozzeria,B)     (Carrozzeria,C)
    (FinituraA,A)       (FinituraB,B)       (FinituraC,C);

# Dati
param Capacita :=
    Motori      120
    Carrozzeria 80
    FinituraA   96
    FinituraB   102
    FinituraC   40;

param Profitti :=
    A   840
    B   1120
    C   1200;

param Tempi :=
    [Motori,A]      3   [Motori,B]      2   [Motori,C]      1
    [Carrozzeria,A] 1   [Carrozzeria,B] 2   [Carrozzeria,C] 3
    [FinituraA,A]   2
                        [FinituraB,B]   3 
                                            [FinituraC,C]   2;
end;
