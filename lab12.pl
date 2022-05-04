%consult("C:/users/danek/Documents/GitHub/Prolog_Labs/lab12.pl").

%1 Найти количество чисел, взаимно простых с заданным.
nod(N,0,N):-!.
nod(N,M,R):-M1 is N mod M,N1 is M,nod(N1,M1,R).

countOfCrossSimpleD(A,X):- cocsD(A,X,A,0).
cocsD(A,R,0,R):-!.
cocsD(A,X,I,R):- I1 is I-1,(nod(A,I1,D),D is 1,R1 is R+1,cocsD(A,X,I1,R1);cocsD(A,X,I1,R)),!.

countOfCrossSimpleU(A,X):- cocsU(A,X,A).
cocsU(A,X,0):-X is 0,!.
cocsU(A,X,I):- I1 is I-1, cocsU(A,X1,I1),(nod(A,I1,D),D is 1,X is X1+1;X is X1),!.
%2 Найти делитель числа, являющийся взаимно простым с наибольшим количеством цифр данного числа.
delNum(A,X):- dwmcs(X,A,A,0,0).

dwmcs(X,A,1,CMD,MD):-X is MD,!. %как бы тут всегда ответ должен быть 1, но сейчас работает исключая единицу.
dwmcs(X,A,I,CMD,MD):- 
    I1 is I-1,
    (
        0 is (A mod I),
        codwsc(COUNT_CROSS_SIMPLE,A,I),
        (
            COUNT_CROSS_SIMPLE >= CMD,
            dwmcs(X,A,I1,COUNT_CROSS_SIMPLE,I);
            dwmcs(X,A,I1,CMD,MD)
        );
        dwmcs(X,A,I1,CMD,MD)
    ),
    !.

codwsc(COUNT_CROSS_SIMPLE,0,DEL):- COUNT_CROSS_SIMPLE is 0,!.
codwsc(COUNT_CROSS_SIMPLE,NUM,DEL):-
    NUM1 is NUM div 10,
    (
        nod(NUM mod 10,DEL,D),
        D is 1,
        codwsc(COUNT_CROSS_SIMPLE1,NUM1,DEL),
        COUNT_CROSS_SIMPLE is COUNT_CROSS_SIMPLE1+1;
        codwsc(COUNT_CROSS_SIMPLE,NUM1,DEL)
    ),
    !.
%3 Число называется совершенным, если равно сумме своих делителей, назовем число избыточным, если сумма его делителей больше самого числа. Мини-
%мальное число с избытком – это 12 Найдите количество чисел, меньшее 20000, которые нельзя представить в виде суммы двух чисел с избытком.
countOfNumWhatCanBeSumOfTwoOver(X):- conwcb(X, 19999,0).

conwcb(COUNT, 23,R):-COUNT is R,!.
conwcb(COUNT, A,R):-
    A1 is A-1,
    write(A), nl,
    (
        testSum(A,FLAG),
        FLAG is 0,
        R1 is R+1,
        conwcb(COUNT, A1,R1);
        conwcb(COUNT, A1,R)
    ),
    !.

testSum(NUM, FLAG):- tswo(FLAG,NUM,0).

tswo(F,A,B):-
    A>=B,
    A1 is A-1,
    B1 is B+1,
    (
        isOverNum(A,FLAG1),
        1 is FLAG1,
        isOverNum(B,FLAG2),
        1 is FLAG2,
        F is 1;
        tswo(F,A1,B1)
    ),
    !;
    F is 0,
    !.

isOverNum(A,FLAG):- 
    A>=12,
    sumOfDel(A,S),
    S>A,
    FLAG is 1;
    FLAG is 0.

sumOfDel(A,SUM):- A1 is A-1,sod(SUM,A,A1,0).

sod(SUM,A,0,S):-SUM is S,!.
sod(SUM,A,1,S):-SUM is S,!.
sod(SUM,A,I,S):-
    I1 is I-1,
    (
        0 is A mod I,
        S1 is S+I,
        sod(SUM,A,I1,S1);
        sod(SUM,A,I1,S)
    ),
    !.
%4
listleng([],0).
listleng([_|T],I):-listleng(T,I1),I is I1 + 1.
%5


%6

%7	

%8

%9

%10
