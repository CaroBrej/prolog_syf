%Zad1********************************
parent(janina, anna).
parent(edward, anna).
parent(marian, andrzej).
parent(wilhemina, andrzej).
parent(andrzej, magdalena).
parent(tomasz, magdalena).
parent(andrzej, tomasz).
parent(anna, tomasz).
parent(tomasz, zuzanna).
parent(karolina, zuzanna).

male(edward).
male(marian).
male(andrzej).
male(tomasz).

female(janina).
female(anna).
female(magdalena).
female(wilhemina).
female(karolina).
female(zuzanna).
son(X, Y) :- parent(Y, X), male(X).   
granddaughter(X, Y) :- parent(Y, Z), parent(Z, X), female(X). 
partner(X, Y) :- parent(X, Z), parent(Y, Z), not(X=Y).
aunt(A,B) :- parent(C,B), parent(D,C), parent(D,A), female(A),not(A=B),not(A=C) .

%Zad2**************************************
isnumber(zero).
isnumber(s(X)) :- isnumber(X).
isequal(X,X) :- isnumber(X).
isequal(s(X),s(Y)) :- isequal(X,Y).
lessthanequal(zero,X) :- isnumber(X).
lessthanequal(s(X),s(Y)) :- lessthanequal(X,Y).
add(zero,X,X) :- isnumber(X).
add(s(X),Y,s(Z)) :- add(X,Y,Z).
%odd(X) to be true if X is odd 
odd(X) :- isequal(X,s(zero)).
odd(s(X)) :- not(odd(X)).
%even(X) to be true of X is even 
even(X) :- isequal(X,zero).
even(s(X)) :- not(even(X)).
%odd2(X) :- not(even(X)).
%times(X,Y,Z) to be true if X × Y = Z 
times(zero,_,X) :- isequal(X,zero).
times(s(zero),X,Y) :- isequal(X,Y).
times(s(X),Y,Z) :- add(Y,A,Z), times(X,Y,A).
%quotient(X,Y,Q) to be true if X/Y = Q (in integer arithmetic)
%quotient(X,Y,Q) :- add(X,Y,Z), quotient(Z,Y,s(Q)).
sub(X,zero,X) :- isnumber(X).%pomocnicze substract
sub(s(X),s(Y),Z) :- sub(X,Y,Z). %pomocnicze
%quotient(_,zero,_) :- not(isequal(zero,zero)).
quotient(zero,_,Q) :- isequal(Q,zero).
quotient(X,Y,s(Q)) :- sub(X,Y,A), quotient(A,Y,Q), not(isequal(Y,zero)).
%remainder(X,Y,R) to be true if X divided by Y leaves a remainder of R
%remainder(_,zero,_) :- not(isequal(zero,zero)).
%remainder(zero,_,R) :- isequal(R,zero).
remainder(X,Y,R) :- isequal(X,Y), isequal(R,zero).
remainder(X,Y,R) :- isequal(X,R),lessthanequal(X,Y),not(isequal(X,Y)).
remainder(X,Y,R) :- sub(X,Y,A), remainder(A,Y,R).
%fact(N,X) to be true if X=N! 
fact(zero,X) :- isequal(s(zero),X).
fact(s(zero),X) :- isequal(s(zero),X).
fact(s(N),X) :- times(A,s(N),X), fact(N,A).
%fibonacci(N,X) to be true if X is the N'th Fibonacci number 
fibonacci(zero,X) :- isequal(zero,X).
fibonacci(s(zero),X) :- isequal(s(zero),X).
fibonacci(s(s(N)),X) :- sub(X,A,B), fibonacci(s(N),A), fibonacci(N,B).
%shownum
shownum(zero,0).
shownum(s(X),N):- shownum(X,M),N is M+1.
%Zad3***************************************
member1(H,[H|_]).
member1(H,[_|T]):- member1(H,T).
append1([],L2,L2).
append1([H|T],X,[H|Y]):- append1(T,X,Y).
%count
count(_,[],0).
count(X,[X|T],N):- count(X,T,M),N is M+1.
count(X,[_|T],N):-count(X,T,N).
%len(X,N) to be true when N is the length of the list X. 
len([],0).
len([_|T],N):-len(T,M),N is M+1.
%len([a,[a,b],c],X) zwraca 3 bo [a,b] to jeden obiekt w liście (lista w liście)
%rlen(X,N) to be true when N counts the total number of occurrences of atoms in the list X
rlen([],0).
rlen([X|T],N):-len(X,L),rlen(T,M),N is M+L.
rlen([_|T],N):-rlen(T,M),!,N is M+1.
%suma
suma([],0).
suma([H|T],N):-suma(T,M),N is M+H.
%avg
avg1([],0).
avg1(X,N):-suma(X,A),len(X,B),N is A/B.
%double(X,Y) 
double([],[]).
double([I|R],[I,I|RD]) :- double(R,RD).
double2(X,Y):- reapeat(X,Y,2).
%reapeat
reapeat([], [], _) :-!.
reapeat([X], [X], 1) :-!.
reapeat([X], [X|L], M) :- N is M - 1, reapeat([X], L, N), !.
reapeat([H|T], L1, M) :- reapeat([H], H1, M), reapeat(T, T1, M), append1(H1, T1, L1), !.