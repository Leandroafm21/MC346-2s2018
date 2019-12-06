% MC346 - Projeto 2
% http://www.ic.unicamp.br/~wainer/cursos/2s2018/proj-prolog.html

% Flávia Bertoletti Silvério             | RA 167605
% Leandro Augusto Fernandes de Magalhães | RA 171836

:- initialization(main, main).

main :-
    leEntrada(Trechos, []),
    nl,
    encontraIntersecoes(Trechos, Trechos).

% Lê as linhas da entrada guardando em uma lista de atoms
leEntrada(Resultado, Lista) :-
    read_line_to_codes(user_input, Input),
    string_to_atom(Input, Trecho),
    (
    Trecho == end_of_file
    -> reverse(Resultado, Lista)
    ; leEntrada(Resultado, [Trecho|Lista])
    ).

% Imprime os trechos encontrados, um por linha
imprimeSaida([]).
imprimeSaida([H|T]) :-
    write(H),
    nl,
    imprimeSaida(T).

% Calcula as interseções de trechos
encontraIntersecoes([], Trechos) :-
    imprimeSaida(Trechos).
encontraIntersecoes([Trecho|T], Trechos) :-
    % Remove o trecho a ser verificado da lista de trechos
    delete(Trechos, Trecho, Others),
    % Procura uma interseção
    procuraIntersecoes(Trecho, Others, TamInter, Trecho2),
    (
    TamInter >= 4
    -> string_chars(Trecho2, Trecho2Char),
       drop(Trecho2Char, TamInter, 0, Trecho2Dropped),
       string_chars(Trecho, TrechoChar),
       append(TrechoChar, Trecho2Dropped, TrechoMaior),
       delete(Others, Trecho2, Others2),
       string_chars(TrechoMaiorString, TrechoMaior),
       myAppend(Others2, TrechoMaiorString, Others3),
       encontraIntersecoes(Others3, Others3)
    ; encontraIntersecoes(T, Trechos)
    ).

% Verifica se há alguma interseção para o trecho desejado, "retornando" seu
% tamanho em TamInter e o trecho em Trecho2
procuraIntersecoes(_, [], TamInter, _) :-
    TamInter = 0.
procuraIntersecoes(Trecho, [H|T], TamInter, Trecho2) :-
    % Converte os textos em string para listas de caracteres
    string_chars(Trecho, TrechoChar),
    string_chars(H, TrechoVerificado),
    % Calcula o tamanho máximo da interseção
    length(TrechoChar, Tam),
    Max is Tam-1,
    % Verifica se há interseção entre 2 trechos separadamente
    verificaIntersecao(TrechoChar, TrechoVerificado, Max, TamCalculado, 0),
    (
    % Sempre a maior interseção é a primeira encontrada, neste caso, a "retorna";
    % do contrário continua procurando
    TamCalculado >= 4
    -> TamInter = TamCalculado,
       Trecho2 = H,
       !
    ; procuraIntersecoes(Trecho, T, TamInter, Trecho2)
    ).

% Verifica se há interseção entre 2 trechos da seguinte forma: primeiro,
% verifica se todos os elementos de Trecho1 estão no começo de Trecho2. Depois,
% verifica se os N-1 últimos elementos de Trecho1 estão no começo de Trecho2.
% Depois, faz o mesmo com os N-2 últimos, e assim por diante.
verificaIntersecao(Trecho1, Trecho2, Max, Tam, Acc) :-
    (
    Acc > Max
    -> 
       Tam = 0,
       true
    % Obtem os últimos elementos, jogando fora os K primeiros em ordem crescente
    % de K, a partir de 0
    ; drop(Trecho1, Acc, 0, Trecho1Dropped),
      (
      % Verifica efetivamente se há interseção entre os trechos desejados,
      % "retornando-o" se houver
      verificaIntersecao(Trecho1Dropped, Trecho2)
      -> Result is Max-Acc+1,
         Tam = Result,
         true
      ; Acc2 is Acc+1,
        verificaIntersecao(Trecho1, Trecho2, Max, Tam, Acc2)
      )
    ).

% Verifica efetivamente se há interseção entre 2 trechos
verificaIntersecao([], _) :-
    true.
verificaIntersecao([H|T1], [H|T2]) :-
    verificaIntersecao(T1, T2).
verificaIntersecao(_, _) :-
    fail.

% Insere um elemento em uma lista - as funções pre-built de Prolog não estavam
% funcionando para alguns casos
myAppend([], X, [X]) :-
    true.
myAppend([H|T1], X, [H|T2]) :-
    myAppend(T1, X, T2).

% Retorna a lista sem os N primeiros elementos
drop(List, Number, Number, Result) :-
    Result = List.
drop([_|T], Number, Acc, Result) :-
    Acc2 is Acc+1, drop(T, Number, Acc2, Result).