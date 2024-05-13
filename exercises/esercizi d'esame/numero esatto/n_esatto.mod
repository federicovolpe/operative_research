# numero esatto
#   DATI
set cifre := 0..9;
set posizioni := 0..9;

#   VARIABILI
var assegnamenti{cifre} binary;

#   VINCOLI
# ogni cifra deve essere stata assegnata almeno una volta
subject to assegnamento {c in cifre}:
    assegnamenti[c] = 1;

#   OBIETTIVO
solve;

end;
