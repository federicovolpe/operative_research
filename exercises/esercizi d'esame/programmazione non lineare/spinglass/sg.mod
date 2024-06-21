reset;

#		DATI
param np := 10; 		# numero di particelle
set P := 1..np;		# set di particelle
param int {P,P};	# energia interazione per ogni coppia di particelle

#		VARIABILI
var conf {P} binary; # configurazione di ogni particella 0 up 1 down

#		OBIETTIVO
minimize Energia: 
  sum {i in P, j in P: i<j} - int[i,j] * 
  (2*x[i]-1) * 		# configurazione di i  
  (2*x[j]-1);		# configurazione di j


data;

param int : 1	2	3	4	5	6	7	8	9	10 :=
1 	 		. 	3 	-1 	-4  5 	-8  4 	-2 	-3 	-1
2 	 		.	. 	-2  2 	-4  7 	-1  2 	-2  2
3 			.	.	. 	-3 	-3 	-3  5 	-2 	-1 	-3
4  	 		.	.	.	. 	2 	-1 	-2 	-2 	-2 	-7
5 	  		.	.	.	.	.   3 	-7  7 	-2  8
6  	 		.	.	.	.	.	.  	-5  3 	-3 	-1
7 	  		.	.	.	.	.	.	.  	-1  9 	-5
8 	 		.	.	.	.	.	.	.	.   1  	9
9 	 		.	.	.	.	.	.	.	.	.  -6
10			.	.	.	.	.	.	.	.	.	.;

end;
