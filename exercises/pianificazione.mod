#   DATI
set mesi := {"Giugno", "Luglio", "Agosto", "Settembre"}
param domanda {mesi};
param capacita {mesi};
param prezzo {mesi};
param costo {mesi};

#   VARIABILI
#   VINCOLI
#   OBIETTIVO

data;
					
param domanda	:= 
1   200	    
2   300	    
3   500	    
4   400;

param capacita	:= 
1   400	    
2   500	    
3   300	    
4   500;

param prezzo    := 
1   34	    
2   36	    
3   32	    
4   38;

param costo		:= 
1   2000	    
2   3000	    
3   2000	    
4   3000;
end;