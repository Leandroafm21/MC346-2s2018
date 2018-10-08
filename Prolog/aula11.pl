% 1-) Tamanho de uma lista
tam(L, T) :- tamx(L, T, 0).

tamx([], T, T).
tamx([X|R], T, Acc) :-
    Acc2 is Acc+1, tamx(R, T, Acc2).

% 2-) Soma dos elementos de uma lista
soma(L, S) :- somax(L, S, 0).

somax([], S, S).
somax([X|R], S, Acc) :-
    Acc2 is Acc+X, somax(R, S, Acc2).

% 3-) Soma dos elementos pares de uma lista
somap(L, S) :- somapx(L, S, 0).

somapx([], S, S).
somapx([X|R], S, Acc) :-
    0 is mod(X, 2), Acc2 is Acc+X, somapx(R, S, Acc2).
somapx([X|R], S, Acc) :-
    1 is mod(X, 2), somapx(R, S, Acc).

% 4-) Soma dos elementos nas posições pares da lista (o primeiro elemento está na posição 1)
somaip(L, S) :- somaipx(L, S, 0, 1).

somaipx([], S, Acc, I) :-
    Acc = S.
somaipx([X|R], S, Acc, I) :-
    0 is mod(I, 2), Acc2 is Acc+X, I2 is I+1, somaipx(R, S, Acc2, I2).
somaipx([X|R], S, Acc, I) :-
    1 is mod(I, 2), I2 is I+1, somaipx(R, S, Acc, I2).

% 5-) Existe item na lista (query encontra todos os itens)
elem([], I) :- false.
elem([X|R], X) :- true.
elem([X|R], I) :- elem(R, I).

% 6-) Posição do item na lista
pos(L, I, P) :- posx(L, I, P, 1).

posx([I|R], I, P, P).
posx([X|R], I, P, Acc) :-
    Acc2 is Acc+1, posx(R, I, P, Acc2).

% 7-) Conta quantas vezes o item aparece na lista
conta(L, I, C) :- contax(L, I, C, 0).

contax([], I, C, C).
contax([I|R], I, C, Acc) :-
    Acc2 is Acc+1, contax(R, I, C, Acc2).
contax([X|R], I, C, Acc) :-
    contax(R, I, C, Acc).

% 8-) Maior elemento de uma lista
maior([X|R], M) :- maiorx(R, M, X).

maiorx([], M, M).
maiorx([X|R], M, ML) :-
    X > ML, maiorx(R, M, X).
maiorx([X|R], M, ML) :-
    X < ML, maiorx(R, M, ML).

% 9-) Reverte uma lista
reverte(L, LR) :- revertex(L, LR, []).

revertex([], LR, LR).
revertex([H|R], LR, Acc) :-
    revertex(R, LR, [H|Acc]).

% 11-) A lista já está ordenada?
estaOrdenada([]).
estaOrdenada([X]).
estaOrdenada([H1,H2|R]) :-
    H1 =< H2, estaOrdenada([H2|R]).

% 12-) Dado N gera lista de 1 a N (stack overflow para comparações erradas)
geraLista(N, L) :- geraListax(N, L, []).

geraListax(0, L, L).
geraListax(N, L, Acc) :-
    N2 is N-1, geraListax(N2, L, [N|Acc]).

% 13-) Retorna o último elemento de uma lista
retornaUltimo([], []).
retornaUltimo([I], I).
retornaUltimo([H|T], R) :-
    retornaUltimo(T, R).

% 14-) Retorna uma lista sem o último elemento
retornaSemUltimo([H], []).
retornaSemUltimo([H|T], [H|LR]) :-
    retornaSemUltimo(T, LR).

% 19-) Remove item da lista a 1ª vez que ele aparece
removeListaUmaVez([I|T], I, T).
removeListaUmaVez([H|T], I, [H2|T2]) :-
    removeListaUmaVez(T, I, T2).

% 20-) Remove item da lista todas as vezes
removeListaTodasVezes([], I, []).
removeListaTodasVezes([I|R], I, LR) :-
    removeListaTodasVezes(R, I, LR).
removeListaTodasVezes([H|R], I, [H|R2]) :-
    removeListaTodasVezes(R, I, R2).

% 21-) Remove item da lista as primeiras n vezes
removeListaNVezes([], I, N, []).
removeListaNVezes(L, I, 0, L).
removeListaNVezes([I|R], I, N, LR) :-
    N2 is N-1, removeListaNVezes(R, I, N2, LR).
removeListaNVezes([H|R], I, N, [H|R2]) :-
    removeListaNVezes(R, I, N, R2).

% 23-) Troca velho por novo na lista a 1ª vez que ele aparece
trocaUmaVez([IV|R], IV, IN, [IN|R]).
trocaUmaVez([H|R], IV, IN, [H2|R2]) :-
    trocaUmaVez(R, IV, IN, R2).

% 24-) Troca velho por novo na lista todas as vezes
trocaTodasVezes([], IV, IN, []).
trocaTodasVezes([IV|R], IV, IN, [IN|R2]) :-
    trocaTodasVezes(R, IV, IN, R2).
trocaTodasVezes([H|R], IV, IN, [H|R2]) :-
    trocaTodasVezes(R, IV, IN, R2).

% 25-) Troca velho por novo na lista as primeiras n vezes
trocaNVezes([], IV, IN, N, []).
trocaNVezes(L, IV, IN, 0, L).
trocaNVezes([IV|R], IV, IN, N, [IN|R2]) :-
    N2 is N-1, trocaNVezes(R, IV, IN, N2, R2).
trocaNVezes([H|R], IV, IN, N, [H|R2]) :-
    trocaNVezes(R, IV, IN, N, R2).