# dati iniziali


set Cavalli := {"Fulmine", "Freccia", "Dardo", "Lampo"};
param quotazione{Cavalli};
param budget;

# variabili
var x {Cavalli} >= 0; # puntata su ogni cavallo
var aux; # vincita minima

# vincoli
subject to Max_puntate :
	sum {i in Cavalli} x[i] <= budget;

# obiettivi
maximize z: aux;
	subject to maxmin {i in Cavalli} :
	aux <= (quotazione[i] * x[i]);

data;

param quotazione :=
Fulmine	3
Freccia	4
Dardo	5
Lampo	6;

param budget := 57;

end;