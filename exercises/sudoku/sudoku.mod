#	DATI
set righe := 1..9;
set colonne := 1..9;
set numeri := 1..9;

set macroRighe := 1..3;
set macroColonne := 1..3;

param dati {righe, colonne, numeri};

#	VARIABILI
# valori assegnati
var assegnamenti {righe, colonne, numeri} binary;

#	VINCOLI
# ad ogni riga e colonna deve essere stato assegnato un numero
subject to assignment {r in righe, c in colonne}:
	sum {n in numeri} assegnamenti[r,c,n] = 1;

# tenendo fissa una riga e un numero, scorrendo la riga devo trovare quel numero una volta
subject to valoriPerRiga {r in righe, n in numeri} :
	sum {c in colonne} assegnamenti[r,c,n] = 1;

# tenendo fissa una colonna e un numero, scorrendo la colonna devo trovare quel numero una volta
subject to valoriPerColonna {c in colonne, n in numeri} :
	sum {r in righe} assegnamenti[r,c,n] = 1;

# per ogni macro riga e macro colonna (riquadri grandi) devo avere ogni numero una sola volta
subject to macroAree {mr in macroRighe, mc in macroColonne, n in numeri} :
	sum {r in righe, c in colonne :
		r <= (mr *3) and # solo le righe interessate
		r >= (mr-1)*3+1 
		and
		c <= (mc *3) and # solo le colonne interessate
		c >= (mc-1)*3+1} 
		assegnamenti[r,c,n]= 1; # per ogni macroarea il numero deve comparire 1 volte

#	OBIETTIVO
# l'obiettivo dell'esercizio non è di massimizzazione o minimizzazione ma di semplice risoluzione
solve;

printf '  *** Soluzione Sudoku *** \n\n' > "Sudoku2.sol"; # operatore per creare file
for {i in righe}{
	for {j in colonne}{
		printf ' %d ', sum {k in numeri} k * assegnamenti[i,j,k] >> "Sudoku2.sol";
	}
	printf '\n' >> "Sudoku2.sol"; # operatore per appendere al file
}

end;
