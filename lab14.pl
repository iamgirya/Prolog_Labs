%consult("C:/users/danek/Documents/GitHub/Prolog_Labs/lab14.pl").
makeEmptyList([]).

readS(Str,N,IsLast):-get0(Char),readS(Char,Str,[],N,0,IsLast). % чтение строки из файла
readS(-1,Str,Str,N,N,1):-!.
readS(10,Str,Str,N,N,0):-!.
readS(Char,Str,NowStr,N,I,IsLast):-I1 is I+1,append(NowStr,[Char],NowStr1),get0(Char1),readS(Char1,Str,NowStr1,N,I1,IsLast).

readListS(List):-readS(Str,_,IsLast),readListS([Str],List,IsLast). % чтение из файла списка строк
readListS(List,List,1):-!.
readListS(Cur_list,List,0):-
	readS(Str,_,IsLast),append(Cur_list,[Str],C_l),readListS(C_l,List,IsLast).
	
readS(Str,N):-readS(Str,N,0). % чтение строки длины N

writeS([]):-!. %вывод стринга
writeS([H|T]):-put(H),writeS(T).

writeListS([]):-!. %вывод списка стрингов
writeListS([H|T]):-writeS(H),nl,writeListS(T).

append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

listleng([],0).
listleng([_|T],I):-listleng(T,I1),I is I1 + 1.
%1.1 Дана строка. Вывести ее три раза через запятую и показать количество символов в ней.
task11:-readS(Str,N,0),writeS(Str),write(", "),writeS(Str),write(", "),writeS(Str),write(" , "),write(N).
%1.2 Дана строка. Найти количество слов.
countOfWords([],Count):-Count is 1,!.
countOfWords([H|T],Count):-
	(
		H is 32,
		
		countOfWords(T,Count1),
		Count is Count1+1;

		countOfWords(T,Count)
	),!.

task12:-readS(Str,N,0),countOfWords(Str,Count),write(Count).
%1.3 Дана строка, определить самое частое слово
getListOfWordsFromStr(Str,List):-getListOfWordsFromStr(Str,List,[]).
getListOfWordsFromStr([],WordsList,NowWord):-append([NowWord], [],WordsList).
getListOfWordsFromStr([H|T],WordsList,NowWord):-
	(
		not(H is 32),
		
		append(NowWord,[H],NowWord1),
		getListOfWordsFromStr(T,WordsList,NowWord1);

		getListOfWordsFromStr(T,WordsList1,[]),
		append([NowWord],WordsList1,WordsList)
	),!.

mostRatedWordFromList(WordsList,Word):-mostRatedWordFromList(WordsList,Word,[],-1,WordsList).
mostRatedWordFromList([],Word,NowWord,Count,StartList):-append([],NowWord,Word),!.
mostRatedWordFromList([WordsListH|WordsListT],Word,NowWord,Count,StartList):-
	countOfThisWordInList(StartList,WordsListH,NowCount),
	(
		NowCount>Count,

		mostRatedWordFromList(WordsListT,Word,WordsListH,NowCount,StartList);

		mostRatedWordFromList(WordsListT,Word,NowWord,Count,StartList)
	),!.
countOfThisWordInList([],Word,NowCount):- NowCount is 0,!.
countOfThisWordInList([StartListH|StartListT],Word,NowCount):-
	StartListH = Word,

	countOfThisWordInList(StartListT,Word,NowCount1),
	NowCount is NowCount1+1,!;

	countOfThisWordInList(StartListT,Word,NowCount),!.

mostRatedWordFromStr(Str,Word):-
	getListOfWordsFromStr(Str,WordsList),
	mostRatedWordFromList(WordsList,Word).

task13:-readS(Str,N,0),mostRatedWordFromStr(Str,Word),writeS(Word).
%1.4 Дана строка. Вывести первые три символа и последний три символа, если длина строки больше 5, иначе вывести первый символ столько раз, какова длина строки.
writeFirstAndLastThree([Fchar|StrT]):- writeFirstAndLastThree([Fchar|StrT],3),!.
writeFirstAndLastThree([Fchar|StrT],N):-
	N>0,
	cutLastChar(StrT,NewStr,Lchar),
	write(Fchar),
	N1 is N-1,
	writeFirstAndLastThree(NewStr, N1),
	write(Lchar),!;
	1 is 1,!.

cutLastChar([Lchar],NewStr,Lchar):-makeEmptyList(NewStr),!.
cutLastChar([StrH|StrT],NewStr,Lchar):-
	cutLastChar(StrT,NewStr1,Lchar),
	append([StrH],NewStr1,NewStr),!.

writeNTimesFirst([StrH|StrT],N):-
	N>0,
	write(StrH),
	N1 is N-1,
	writeNTimesFirst([StrH|StrT],N1),!;
	1 is 1,!.

task14:-
	readS(Str,N,0),
	(
		N>5,

		writeFirstAndLastThree(Str),!;
		writeNTimesFirst(Str,N)
	),!.
%1.5 Дана строка. Показать номера символов, совпадающих с последним символом строки.
%2.1 Дан файл. Прочитать из файла строки и вывести длину наибольшей строки.
%2.2 Дан файл. Определить, сколько в файле строк, не содержащих пробелы.
%2.3 Дан файл, найти и вывести на экран только те строки, в которых букв А больше, чем в среднем на строку.
%2.4 Дан файл, вывести самое частое слово.
%2.5 Дан файл, вывести в отдельный файл строки, состоящие из слов, не повторяющихся в исходном файле.
%3 Дана строка, состоящая из символов латиницы. Необходимо проверить, упорядочены ли строчные символы этой строки по возрастанию.
%4 Дана строка. Необходимо подсчитать количество букв "А" в этой строке.
%5 Дана строка в которой записан путь к файлу. Необходимо найти имя файла без расширения.
%6 Результат записывать в файл.
%6.1 Дано множество. Построить все размещения с повторениями по k элементов.
%6.2 Дано множество. Построить все перестановки.
%6.3 Дано множество. Построить все размещения по k элементов.
%6.4 Дано множество. Построить все подмножества.
%6.5 Дано множество. Построить все сочетания по k элементов.
%6.6 Дано множество. Построить все сочетания с повторениями.
%7 Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в которых ровно две буквы a. Вывод в файл.
%8 Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в которых ровно 2 буквы a, остальные буквы не повторяются. Вывод в файл.
%9 Дано множество {a,b,c,d,e,f}. Построить все слова длины 5, в которых ровно одна буква повторяется 2 раза, остальные буквы не повторяются. Вывод в файл.
%10 Дано множество {a,b,c,d,e,f}. Построить все слова длины 6, в которых ровно 2 буквы повторяются 2 раза, остальные буквы не повторяются. Вывод в файл.