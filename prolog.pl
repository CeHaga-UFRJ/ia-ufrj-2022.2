%3.1
removeLast3(L1,L2) :- append(L2,[_,_,_],L1).
removeFirst3(L1,L2) :- append([_,_,_],L2,L1).
removeFirstAndLast3(L1,L2) :-
    removeLast3(L1,L3),
    removeFirst3(L3,L2).

%3.2
last_A(Item,List) :- append(_,[Item],List).

last_B(X,[X]).
last_B(X,[_|T]) :- last_B(X,T).

%3.3
evenlength([]).
evenlength([_,_|T]) :- evenlength(T).

oddlength([_]).
oddlength([_,_|T]) :- oddlength(T).

%3.4
reverse2([],[]).
reverse2([H|T1],L2) :-
    reverse2(T1,L3),
    append(L3,[H],L2).

%3.5
palindrome(L) :-
    reverse2(L,LR),
    L = LR.

%3.6
shift([H|T1],L2) :- append(T1,[H],L2).

%3.7
means(0,zero).
means(1,one).
means(2,two).
means(3,three).
means(4,four).
means(5,five).
means(6,six).
means(7,seven).
means(8,eight).
means(9,nine).

translate([],[]).
translate([H|T],[H2|T2]) :-
    translate(T,T2),
    means(H,H2).

%3.8
% Nao cai subset


%3.9
dividelist([],[],[]).
dividelist([H|T1],[H|T2],L3) :-
    dividelist2(T1,T2,L3).

dividelist2([],[],[]).
dividelist2([H|T1],L2,[H|T3]) :-
    dividelist(T1,L2,T3).

%3.11
flatten2([],[]).
flatten2([H|T],FL) :-
    flatten2(H,FH),
    flatten2(T,FT),
    append(FH,FT,FL).
flatten2(H,[H]) :-
    not(H = [_|_]).

%3.16
max(X,Y,X) :- X > Y, !.
max(_,Y,Y).

%3.17
maxlist([X],X).
maxlist([H|T],M) :-
    maxlist(T,M2),
    max(H,M2,M).

%3.18
sumlist2([X],X).
sumlist2([H|T],S) :-
    sumlist2(T,S2),
    S is H + S2.

%3.19
ordered([_]).
ordered([H|[HT|TT]]):-
    H =< HT,
    ordered([HT|TT]).


%3.20
%Nao cai subset


%3.21
between2(N1,N2,N1) :- N1 =< N2.
between2(N1,N2,X) :-
    N1 =< N2,
    N12 is N1+1,
    between2(N12,N2,X).

%5.3
split([],[],[]).
split([H|T],[H|TP],TN) :-
    H >= 0,!,
    split(T,TP,TN).
split([H|T],TP,[H|TN]) :-
    split(T,TP,TN).

%5.4
difference([H|_],L2,H) :-
    not(member(H,L2)).
difference([_|T],L2,X) :-
    difference(T,L2,X).

%5.5 - Nao cai subset mas fazer com sublista
differencelist([],_,[]).
differencelist([H|T],T2,T3) :-
    member(H,T2),!,
    differencelist(T,T2,T3).
differencelist([H|T],T2,[H|T3]) :-
    differencelist(T,T2,T3).

%5.6
unifiable2([],_,[]).
unifiable2([H|T],P,T2) :-
    not(H=P),!,
    unifiable2(T,P,T2).
unifiable2([H|T],P,[H|T2]) :-
    unifiable2(T,P,T2).

uniaoordenada(L,[],L).
uniaoordenada([H1|T1],[H2|T2],[H1|T3]) :-
    H1 < H2,!,
    uniaoordenada(T1,[H2|T2],T3).
uniaoordenada(T1,[H2|T2],[H2|T3]) :-
    uniaoordenada(T1,T2,T3).


menorsoma([],_,_,[]).
menorsoma([H1|T1],T2,N,LR) :-
    menorsomaitem(H1,T2,N,LR1),
    menorsoma(T1,T2,N,LR2),!,
    append(LR1,LR2,LR).

menorsomaitem(_,[],_,[]).
menorsomaitem(X,[H2|T2],N,[H3|T3]) :-
    X+H2 < N,!,
    H3 is X+H2,
    menorsomaitem(X,T2,N,T3).
menorsomaitem(X,[_|T2],N,T3) :-
    menorsomaitem(X,T2,N,T3).
