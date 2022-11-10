% Final state
objetivo((2,_)).

% Actions
% Fill
acao((J1,J2),encher1,(4,J2)) :- J1 < 4.
acao((J1,J2),encher2,(J1,3)) :- J2 < 3.
% Empty
acao((J1,J2),esvaziar1,(0,J2)) :- J1 > 0.
acao((J1,J2),esvaziar2,(J1,0)) :- J2 > 0.
% Transfer
acao((J1,J2),passar12,(X,Y)) :-
    J1 > 0, J2 < 3,
    X is max(0,J1-(3-J2)),
    Y is min(3,J1+J2).
acao((J1,J2),passar21,(X,Y)) :-
    J1 < 4, J2 > 0,
    X is min(4,J1+J2),
    Y is max(0,J2-(4-J1)).

% Neighbors
vizinhos(N,FilhosN) :- findall(Filho,acao(N,_,Filho),FilhosN).

% List difference
difference([],_,[]).
difference([H|L1],L2,L3) :-
    member(H,L2),!,
    difference(L1,L2,L3).
difference([H|L1],L2,[H|L3]) :-
    difference(L1,L2,L3).

% Add to frontier
adicionar_fronteira_BFS(Fronteira,Novos,NovoFronteira) :-
    append(Fronteira,Novos,NovoFronteira).
adicionar_fronteira_DFS(Fronteira,Novos,NovoFronteira) :-
    append(Novos,Fronteira,NovoFronteira).

% BFS search with repeated states
% A busca fica em loop infinito pois não há verificação de estados repetidos, podendo ficar em um ciclo
bfs_v1([Jarra|_]) :- objetivo(Jarra).
bfs_v1([Jarra|Jarras]) :-
    vizinhos(Jarra,Filhos),
    adicionar_fronteira_BFS(Jarras,Filhos,NovoJarras),
    bfs_v1(NovoJarras).

% BFS search without repeated states
bfs(L) :- bfs([(0,0)],[(0,0)],L). % Easy call
bfs([Jarra|_],_,[Jarra]) :- objetivo(Jarra).
bfs([Jarra|Jarras],Visitados,[Jarra|Caminho]) :-
    vizinhos(Jarra,Filhos),
    difference(Filhos,Visitados,NovoFilhos),
    adicionar_fronteira_BFS(Jarras,NovoFilhos,NovoJarras),
    adicionar_fronteira_BFS(Visitados,NovoFilhos,NovoVisitados),
    bfs(NovoJarras,NovoVisitados,Caminho).

% DFS search with repeated states
dfs_v1([Jarra|_]) :- objetivo(Jarra).
dfs_v1([Jarra|Jarras]) :-
    vizinhos(Jarra,Filhos),
    reverse(Filhos,FilhosInvertidos),
    adicionar_fronteira_DFS(Jarras,FilhosInvertidos,NovoJarras),
    dfs_v1(NovoJarras).

% DFS search without repeated states
dfs(L) :- dfs([(0,0)],[(0,0)],L). % Easy call
dfs([Jarra|_],_,[Jarra]) :- objetivo(Jarra).
dfs([Jarra|Jarras],Visitados,[Jarra|Caminho]) :-
    vizinhos(Jarra,Filhos),
    difference(Filhos,Visitados,NovoFilhos),
    reverse(NovoFilhos,NovoFilhosInvertidos),
    adicionar_fronteira_DFS(Jarras,NovoFilhosInvertidos,NovoJarras),
    adicionar_fronteira_DFS(Visitados,NovoFilhosInvertidos,NovoVisitados),
    dfs(NovoJarras,NovoVisitados,Caminho).
