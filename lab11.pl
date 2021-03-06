%consult("C:/users/danek/Documents/GitHub/Prolog_Labs/lab11.pl").
man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

manw:-man(X),write(X),nl,fail.
womanw:-woman(X),write(X),nl,fail.
%1
son(X):- parent(X,Y),man(Y),write(Y),nl,fail.
son(X,Y):-parent(Y,X),man(X).
%2
sister(X):-woman(X),parent(Z,X),parent(Z,Y),man(Z),woman(Y),X \= Y,write(X),write(' '),write(Y),nl,fail.
sister(X,Y):-woman(X),woman(Y),parent(Z,X),parent(Z,Y),man(Z).
%3
grand_ma(X,Y):-parent(X,Z),parent(Z,Y),woman(X),!.
grand_mas(X):-parent(Z,X),parent(Y,Z),woman(Y),write(Y),nl.
%4
grand_pa_and_da(X,Y):- parent(X,Z),parent(Z,Y),woman(Y),man(X);parent(Y,Z),parent(Z,X),woman(X),man(Y).
%5
maxDigitU(0,0):-!.
maxDigitU(X,M):- X1 is X div 10,maxDigitU(X1,M1),M2 is X mod 10,(M2>M1, M is M2;M is M1),!. 
%6
maxDigitD(X,M):- maxDigitD(X,0,M).
maxDigitD(0,M,M):-!.
maxDigitD(X,Y,M):-M1 is X mod 10, X1 is X div 10,M1 > Y,!,maxDigitD(X1,M1,M); X2 is X div 10, maxDigitD(X2,Y,M).
%7	
sumOfDigWhatDivOn3U(0,0):-!.
sumOfDigWhatDivOn3U(X,M):-X1 is X div 10,sumOfDigWhatDivOn3U(X1,M1),M2 is X mod 10,(0 is M2 mod 3, M is M2+M1; M is M1),!.
%8
sumOfDigWhatDivOn3D(X,R):-sumOfDigWhatDivOn3D(X,0,R).
sumOfDigWhatDivOn3D(0,T,T):-!.
sumOfDigWhatDivOn3D(X,P,R):-D is X mod 10,0 is D mod 3, P1 is (P + D),X1 is X div 10,sumOfDigWhatDivOn3D(X1,P1,R),!
    ;X2 is X div 10,sumOfDigWhatDivOn3D(X2,P,R). 
%9
fibU(1,1):-!.
fibU(2,1):-!.
fibU(N, X):- N1 is N - 1, N2 is N - 2, fibU(N1, X1), fibU(N2, X2), X is X1 + X2.
%10
fibD(N,X):-fibD(1,1,2,N,X).
fibD(_,F,N,N,F):-!.
fibD(A,B,K,N,X):- C is A+B, K1 is K+1,fibD(B,C,K1,N,X).
