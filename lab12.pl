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
%4 получить длину списка
listleng([],0).
listleng([_|T],I):-listleng(T,I1),I is I1 + 1.
%5 Дан целочисленный массив. Необходимо найти количество элементов, расположенных после последнего максимального.
append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

readList(X,Y):-readList([],X,0,Y).
readList(A,A,G,G):-!.
readList(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readList(A1,B,C1,D).

writeList([]):-!.
writeList([H]):-write(H).
writeList([H|T]):- write(H),write(' '),writeList(T).

maxIndexInList([H|T],Max,IndexMax):- maxIndexInList([H|T],H,Max,0,IndexMax,0).
maxIndexInList([],NowMax,Max,NowIndex,IndexMax,Index):-Max is NowMax,IndexMax is NowIndex,!.
maxIndexInList([H|T],NowMax,Max,NowIndex,IndexMax,Index):-
    Index1 is Index+1,
    (
        H >= NowMax,
        maxIndexInList(T,H,Max,Index,IndexMax,Index1);
        maxIndexInList(T,NowMax,Max,NowIndex,IndexMax,Index1)
    ),!.

countAfterMax([Head|Tail],COUNT):- maxIndexInList([Head|Tail],Max,IndexMax), listleng([Head|Tail],Length), COUNT is (Length-1-IndexMax).

task5:- read(N),readlist(List,N),countAfterMax(List,Count),write(Count),!.
%6 Дан целочисленный массив. Необходимо переставить в обратном порядке элементы массива, расположенные между его минимальным и максимальным элементами.
minIndexInList([H|T],Min,IndexMin):- minIndexInList([H|T],H,Min,0,IndexMin,0).
minIndexInList([],NowMin,Min,NowIndex,IndexMin,Index):-Min is NowMin,IndexMin is NowIndex,!.
minIndexInList([H|T],NowMin,Min,NowIndex,IndexMin,Index):-
    Index1 is Index+1,
    (
        NowMin >= H,
        minIndexInList(T,H,Min,Index,IndexMin,Index1);
        minIndexInList(T,NowMin,Min,NowIndex,IndexMin,Index1)
    ),!.

makeEmptyList([]).

cutList(List,From,To,NewList):-cutList(List,From,To,NewList,0).
cutList([],From,To,NewList,I):-makeEmptyList(NewList),!.
cutList([H|T],From,To,NewList,I):-
    I1 is I+1,
    (
        I>=From,
        (
            I<To,
            cutList(T,From,To,NewList1,I1),
            append([H],NewList1,NewList);
            makeEmptyList(NewList)
        );
        cutList(T,From,To,NewList,I1)
    ),
    !.

takeOnIndex(List,Index,Elem):-takeOnIndex(List,Index,Elem,0).
takeOnIndex([H|T],Index,Elem,I):-
    I1 is I+1,
    (
        I is Index,
        Elem is H;
        takeOnIndex(T,Index,Elem,I1)
    ),
    !.

swapList(List,NewList):-listleng(List,Length),Length1 is Length-1,swapList(List,NewList,Length1).
swapList(List,NewList,-1):-makeEmptyList(NewList),!.
swapList(List,NewList,I):-
    takeOnIndex(List,I,Elem),
    I1 is I-1,
    swapList(List,NewList1,I1),
    append([Elem],NewList1,NewList),
    !.

swapBetweenMinAndMax(List,NewList):-
    listleng(List,Length),
    maxIndexInList(List,Max,IndexMax),
    minIndexInList(List,Min,IndexMin),
    (
        IndexMax < IndexMin,

        IndexMax1 is IndexMax+1,
        cutList(List,0,IndexMax1,FirstPart),
        cutList(List,IndexMax1,IndexMin,SecondPart),
        cutList(List,IndexMin,Length,ThirdPart);
        
        IndexMin1 is IndexMin+1,
        cutList(List,0,IndexMin1,FirstPart),
        cutList(List,IndexMin1,IndexMax,SecondPart),
        cutList(List,IndexMax,Length,ThirdPart)
    ),
    swapList(SecondPart,SwapedSecondPart),
    append(FirstPart,SwapedSecondPart,FSPart),
    append(FSPart,ThirdPart,NewList).

task6:- read(N),readList(List,N),swapBetweenMinAndMax(List,NewList),writeList(NewList),!.
%7 Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.
countElemBetweenAB([],A,B,Count):-Count is 0,!.
countElemBetweenAB([H|T],A,B,Count):-
    (
        H<B,
        H>A,
        countElemBetweenAB(T,A,B,Count1),
        Count is Count1+1;
        countElemBetweenAB(T,A,B,Count)
    ).

task7:- read(N),readList(List,N),read(A),read(B),countElemBetweenAB(List,A,B,Count),write(Count),!.
%8 Дан целочисленный массив. Необходимо найти элементы, расположенные между первым и вторым максимальным.
listBetweenMaxs(List,NewList):-
    maxIndexInList(List,Max,IndexMax),
    secondMaxIndexInList(List,SecondMax,SecondIndexMax,IndexMax),
    (
        IndexMax < SecondIndexMax,

        IndexMax1 is IndexMax+1,
        cutList(List,IndexMax1,SecondIndexMax,NewList);

        SecondIndexMax1 is SecondIndexMax+1,
        cutList(List,SecondIndexMax1,IndexMax,NewList)
    ).

secondMaxIndexInList([H|T],Max,IndexMax,FIndexMax):- secondMaxIndexInList([H|T],H,Max,0,IndexMax,0,FIndexMax).
secondMaxIndexInList([],NowMax,Max,NowIndex,IndexMax,Index,FIndexMax):-Max is NowMax,IndexMax is NowIndex,!.
secondMaxIndexInList([H|T],NowMax,Max,NowIndex,IndexMax,Index,FIndexMax):-
    Index1 is Index+1,
    (
        H >= NowMax,
        not(Index = FIndexMax),

        secondMaxIndexInList(T,H,Max,Index,IndexMax,Index1,FIndexMax);

        secondMaxIndexInList(T,NowMax,Max,NowIndex,IndexMax,Index1,FIndexMax)
    ),!.

task8:- read(N),readList(List,N),listBetweenMaxs(List,NewList),writeList(NewList),!.
%9 Дан целочисленный массив. Необходимо найти количество элементов между первым и последним минимальным.
listBetweenMins(List,NewList):-
    minIndexInList(List,Min,IndexMin),
    secondMinIndexInList(List,SecondMin,SecondIndexMin,IndexMin),
    (
        IndexMin < SecondIndexMin,

        IndexMin1 is IndexMin+1,
        cutList(List,IndexMin1,SecondIndexMin,NewList);

        SecondIndexMin1 is SecondIndexMin+1,
        cutList(List,SecondIndexMin1,IndexMin,NewList)
    ).

secondMinIndexInList([H|T],Min,IndexMin,FIndexMin):- secondMinIndexInList([H|T],H,Min,0,IndexMin,0,FIndexMin).
secondMinIndexInList([],NowMin,Min,NowIndex,IndexMin,Index,FIndexMin):-Min is NowMin,IndexMin is NowIndex,!.
secondMinIndexInList([H|T],NowMin,Min,NowIndex,IndexMin,Index,FIndexMin):-
    Index1 is Index+1,
    (
        NowMin >= H,
        not(Index = FIndexMin),
        secondMinIndexInList(T,H,Min,Index,IndexMin,Index1,FIndexMin);
        secondMinIndexInList(T,NowMin,Min,NowIndex,IndexMin,Index1,FIndexMin)
    ),!.

task9:- read(N),readList(List,N),listBetweenMins(List,NewList),listleng(NewList,Length),write(Length),!.
%10 Дан целочисленный массив и интервал a..b. Необходимо проверить наличие максимального элемента массива в этом интервале.
ifMaxBetweenAB(List,A,B,Flag):-
    maxIndexInList(List,Max,IndexMax),
    (
        A<Max,
        B>Max,

        Flag is 1;

        Flas is 0
    ).

task10:- read(N),readList(List,N),read(A),read(B),ifMaxBetweenAB(List,A,B,Flag),write(Flag),!.
