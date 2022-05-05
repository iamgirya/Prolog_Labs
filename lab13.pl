%consult("C:/users/danek/Documents/GitHub/Prolog_Labs/lab13.pl").
%1 Дан целочисленный массив и отрезок a..b. Необходимо найти количество элементов, значение которых принадлежит этому отрезку.
append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

readList(X,Y):-readList([],X,0,Y).
readList(A,A,G,G):-!.
readList(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readList(A1,B,C1,D).

writeList([]):-!.
writeList([H]):-write(H).
writeList([H|T]):- write(H),write(' '),writeList(T).

countElemInAB([],A,B,Count):-Count is 0,!.
countElemInAB([H|T],A,B,Count):-
    (
        B >= H,
        H >= A,
        countElemInAB(T,A,B,Count1),
        Count is Count1+1;
        countElemInAB(T,A,B,Count)
    ).

task1:- read(N),readList(List,N),read(A),read(B),countElemInAB(List,A,B,Count),write(Count),!.
%2
%3
%4
%5
%6
%7	
%8
%9
%10
