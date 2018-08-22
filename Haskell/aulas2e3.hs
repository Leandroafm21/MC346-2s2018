-- Assuntos das aulas: variáveis locais, recursão com acumuladores, tuplas, list comprehension e tipos

-- Exercícios da Aula 1 usando variáveis locais, recursão com acumuladores, tuplas, list comprehension e combinação de outras funções

-- 4-) Soma dos elementos nas posições pares da lista (variáveis locais e recursão com acumuladores)
somaIndicesPares l = somaIndicesPares' l 1
  where somaIndicesPares' [] _ = 0
        somaIndicesPares' (x:xs) i
          | mod i 2 == 0 = x + somaIndicesPares' xs (i+1)
          | otherwise = somaIndicesPares' xs (i+1)

-- 6-) Posição do item na lista (começando em 1) (variáveis locais e recursão com acumuladores)
posicaoItem l it = posicaoItem' l it 1
  where posicaoItem' [] _ _ = 0
        posicaoItem' (x:xs) it i
          | x == it = i
          | otherwise = posicaoItem' xs it (i+1)

-- 7-) Conta quantas vezes item aparece na lista (variáveis locais e recursão com acumuladores)
ocorrenciasItem l it = ocorrenciasItem' l it 0
  where ocorrenciasItem' [] _ res = res
        ocorrenciasItem' (x:xs) it res
          | x == it = ocorrenciasItem' xs it (res+1)
          | otherwise = ocorrenciasItem' xs it res

-- 8-) Maior elemento de uma lista (variáveis locais)
-- observação: lista não pode estar vazia, ocorre conflito de tipo
maiorElemento [x] = x
maiorElemento (x:xs) = if x > res then x else res
  where res = maiorElemento xs

-- 9-) Reverte uma lista (variáveis locais e recursão com acumuladores)
reverte l = reverte' l []
  where reverte' [] l = l
        reverte' (x:xs) l = reverte' xs (x:l)

-- 12-) Dado n gera lista de 1 a n (list comprehension)
geraLista n = [x | x <- [1..n]]

-- 13-) Retorna o último elemento de uma lista (combinação de outras funções)
ultimoElemento l = head (reverte l)

-- 14-) Retorna a lista sem o último elemento (combinação de outras funções)
removeUltimoElemento l = reverte (tail (reverte l))

-- 15-) Shift Right (combinação de outras funções)
shiftR l = (ultimoElemento l):(removeUltimoElemento l)

-- 20-) Remove item da lista todas as vezes (list comprehension)
removeTodosItens l it = [x | x <- l, x /= it]

-- 24-) Troca velho por novo todas as vezes (list comprehension)
trocaTodosItens l velho novo = [if x == velho then novo else x | x <- l]

-- Exercícios da Aula 2

-- 1-) Dado um item e uma lista retorna uma lista com todas as posições (primeiro elemento está na posição 1) do item na lista
obtemPosicoes l it = obtemPosicoes' l it 1 []
  where obtemPosicoes' [] _ _ _ = []
        obtemPosicoes' (x:xs) it pos l
          | x == it = pos:(obtemPosicoes' xs it (pos+1) l)
          | otherwise = obtemPosicoes' xs it (pos+1) l

-- 2-) Dado um item e uma lista retorna uma lista de listas, todos os elementos antes do item (a primeira vez que ele aparece) e todos depois
-- Problema: retorna listas vazias quando o pivô estiver na primeira ou última posição
split [] _ = [[]]
split (x:xs) it
  | x == it = [[], xs]
  | otherwise = [x:(head res)] ++ tail res
  where res = split xs it

-- 3-) Mesma coisa que o Split, mas retornando todas as sublistas
-- Problema: retorna listas vazias quando o pivô estiver na primeira ou última posição
splitAll [] _ = [[]]
splitAll (x:xs) it
  | x == it = []:res
  | otherwise = [x:(head res)] ++ tail res
  where res = splitAll xs it

-- 4-) Retorna a lista sem os n primeiros elementos
dropN l n = dropN' l n 0
  where dropN' [] _ _ = []
        dropN' (x:xs) n pos
          | pos == n = x:xs
          | otherwise = dropN' xs n (pos+1)

-- 5-) Retorna os n primeiros elementos da lista
takeN l n = takeN' l n 0 []
  where takeN' [] _ _ l = l
        takeN' (x:xs) n pos l
          | pos == n = l
          | otherwise = takeN' xs n (pos+1) (l ++ [x])