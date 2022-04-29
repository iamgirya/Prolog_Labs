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
%11
son(X):- parent(X,Y),man(Y),write(Y),nl,fail.
son(X,Y):-parent(Y,X),man(X).
%12
sister(X):-woman(X),parent(Z,X),parent(Z,Y),man(Z),woman(Y),X \= Y,write(X),write(' '),write(Y),nl,fail.
sister(X,Y):-woman(X),woman(Y),parent(Z,X),parent(Z,Y),man(Z).
%13
grand_ma(X,Y):-parent(X,Z),parent(Z,Y),woman(X),!.
grand_mas(X):-parent(Z,X),parent(Y,Z),woman(Y),write(Y),nl.
%14
grand_pa_and_da(X,Y):- parent(X,Z),parent(Z,Y),woman(Y),man(X);parent(Y,Z),parent(Z,X),woman(X),man(Y).

in_list([],_):-fail.
in_list([X|_],X).
in_list([_|T],X):-in_list(T,X).