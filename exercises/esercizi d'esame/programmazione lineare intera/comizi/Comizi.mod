#DATI
set C; #Insieme di città visitabili
param Dist{C}; #Distanze a partire dalla città A di ogni altra città [km]
param Spett1 {C}; #Spettatori di comizio 1 per la c-esima città
param Spett2 {C}; #Spettatori di comizio 2 per la c-esima città

param vel; #Velocità di spostamento [km/h]
param t_sosta;#Tempo di ogni sosta [h]
param t_c1; #Tempo comizio 1 [h]
param t_c2; #Tempo comizio 2 [h]
param t_tot; #Tempo totale [h]


#VARIABILI
var x{C} binary >= 0; #indica se fare il comizio di tipo 1 nella città c
var y{C} binary >= 0; #indica se fare il comizio di tipo 2 nella città c
var spost >= 0; #Ore necessarie per passare da una città ad un altra

#OBIETTIVO
#Massimizzare il numero di spettatori totali
maximize z : sum{c in C} (x[c] * Spett1[c] + y[c] * Spett2[c]);

#VINCOLI
subject to maxTempo:
     sum{c in C} (x[c]*(t_c1+t_sosta) + y[c]*(t_c2 + t_sosta)) <= t_tot - spost;

subject to Assegnamento:
     sum {c in C} (x[c] + y[c]) <= 1;

subject to Spostamento {c in C}:
     spost*vel >= (x[c] + y[c])*Dist[c];


############################
data;

set C := a b c d e f g h i j k l m n o p q r s t u v w x y;
param Dist :=
a         0 
  b        12          
  c        25         
  d        31             
  e        46        
  f        60             
  g        72            
  h        89            
  i       110            
  j       127            
  k       142             
  l       160             
  m       166            
  n       170            
  o       180            
  p       193            
  q       211            
  r       218            
  s       230            
  t       244            
  u       263            
  v       280            
  w       285            
  x       292            
  y       298;            
  
param Spett1 :=
a          120           
  b         80           
  c         200  
  d         400
  e         200
  f         10    
  g        500           
  h        90           
  i       50            
  j       300           
  k       10            
  l       60            
  m       230           
  n       190           
  o       100           
  p       100           
  q       100       
  r       200       
  s       80       
  t       10        
  u       80       
  v       90       
  w       120          
  x       500          
  y       400;

param Spett2:=
a                 140    
  b                200    
  c                250    
  f                 30 
  d                 450
  e                 250  
  g               550    
  h             110    
  i               80    
  j              330    
  k               50    
  l               90    
  m              280    
  n              240    
  o              150    
  p              110    
  q              180    
  r              300    
  s             180    
  t               20    
  u              150    
  v              100    
  w              130   
  x              650   
  y              490;
  

param vel := 100;
param t_sosta := 0.5;
param t_c1 := 1;
param t_c2 := 1.5;
param t_tot := 16;



end;


