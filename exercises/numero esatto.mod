#	DATI


set cifre := 0..9;		#insieme indicizzato delle cifre
set posizioni := 0..9;  # insieme indicizzato delle posizioni
param A {posizioni, cifre} binary, default = 0;
param B {posizioni, cifre} binary, default = 0;
param C {posizioni, cifre} binary, default = 0;

#	VARIABILI
var x{posizioni, cifre} binary; # se per determinate esiste l'assegnamento (è possibile)

#	VINCOLI
# in A ci sono due cifre in posizione errata; 
subject to va:
	sum {p in posizioni, k in numeri} x[p,k] * A[p,k] <= 8;

# in B ce ne sono due in posizione esatta; 
subject to vb:
	sum {p in posizioni, k in numeri} x[p,k] * B[p,k] >= 2;

# in C un’unica cifra è in posizione esatta; 
subject to vc:
	sum {p in posizioni, k in numeri} x[p,k] * C[p,k] = 1;

# in D sei sono in posizione errata.
subject to vd:
	sum {p in posizioni, k in numeri} x[p,k] * D[p,k] <= 4;

# vincoli di assegnamento
subject to unacifra {p in posizioni} : 
	sum {k in numeri} x[p,k] = 1;

subject to unaposizione {k in numeri} : 
	sum {p in posizioni} x[p,k] = 1;


data;
param A := 
[0, 2]
[1, 4]
[2, 5]
[3, 3]
[4, 1]
[5, 6]
[6, 9]
[7, 0]
[8, 8]
[9, 7];

param B := 
[0, 6]
[1, 8]
[2, 7]
[3, 1]
[4, 2]
[5, 0]
[6, 9]
[7, 4]
[8, 3]
[9, 5];

param C := 
[0, 3]
[1, 0]
[2, 9]
[3, ]2
[4, 1]
[5, 8]
[6, 4]
[7, 5]
[8, 7]
[9, 6];

param D := 
[0, 2]
[1, 4]
[2, 1]
[3, 3]
[4, 0]
[5, 8]
[6, 9]
[7, 5]
[8, 7]
[9, 6];

end;
# in A ci sono due cifre in posizione errata; 
# in B ce ne sono due in posizione esatta; 
# in C un’unica cifra è in posizione esatta; 
# in D sei sono in posizione errata.
# 24, 11, 21, 49, localizzazione di depositi, segherie
