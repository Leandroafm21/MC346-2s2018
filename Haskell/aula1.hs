-- Assuntos da aula: tipos simples, operadores lógicos e aritméticos, listas, funções, append (:), concatenação (++), head e tail

-- 1-) Tamanho de uma lista
tam [] = 0
tam (x:xs) = 1 + tam xs

-- 2-) Soma dos elementos de uma lista
soma [] = 0
soma (x:xs) = x + soma xs

-- 3-) Soma dos números pares de uma lista
somaPares [] = 0
somaPares (x:xs)
  | (mod x 2 == 0) = x + somaPares xs
  | otherwise = somaPares xs

-- 4-) Soma dos elementos nas posições pares da lista
somaIndicesPares [] = 0
somaIndicesPares (x:xs)
  | mod (tam xs) 2 == 0 = x + somaIndicesPares xs 
  | otherwise = somaIndicesPares xs

-- 5-) Existe item na lista (True/False)
existeItem [] it = False
existeItem (x:xs) it
  | x == it = True
  | otherwise = existeItem xs it

-- 6-) Posição do item na lista (começando em 1)
posicaoItem [] it i = 0
posicaoItem (x:xs) it i
  | x == it = i
  | otherwise = posicaoItem xs it (i+1)

-- 7-) Conta quantas vezes item aparece na lista
ocorrenciasItem [] it = 0
ocorrenciasItem (x:xs) it
  | x == it = 1 + ocorrenciasItem xs it
  | otherwise = ocorrenciasItem xs it

-- 8-) Maior elemento de uma lista
maiorElemento [] = []
maiorElemento [x] = x
maiorElemento (x:xs)
  | maiorElemento xs > x = maiorElemento xs
  | otherwise = x

-- 9-) Reverte uma lista
reverte [] = []
reverte (x:xs) = (reverte xs) ++ [x]

-- 10-) Intercala 2 listas
intercala1 [] l = []
intercala1 l [] = []
intercala1 (x:xs) (y:ys) = [x] ++ [y] ++ intercala1 xs ys

intercala2 [] l = l
intercala2 l [] = l
intercala2 (x:xs) (y:ys) = [x] ++ [y] ++ intercala2 xs ys

-- 11-) A lista já está ordenada?
estaOrdenada [] = True
estaOrdenada [x] = True
estaOrdenada [x1, x2]
  | x1 < x2 = True
  | otherwise = False
estaOrdenada (x1:x2:xs)
  | x1 < x2 = estaOrdenada (x2:xs)
  | otherwise = False

-- 12-) Dado n gera lista de 1 a n
geraLista 0 = []
geraLista n = (geraLista (n-1)) ++ [n]

-- 13-) Retorna último elemento de uma lista
-- Para evitar conflito de tipo, retorna o elemento em uma lista unitária
ultimoElemento [] = []
ultimoElemento [x] = [x]
ultimoElemento (x:xs) = ultimoElemento xs

-- 14-) Retorna a lista sem o último elemento
removeUltimoElemento [] = []
removeUltimoElemento [x] = []
removeUltimoElemento (x:xs) = x:(removeUltimoElemento xs)

-- 15-) Shift Right
shiftR [] = []
shiftR [x] = [x]
shiftR (x:xs) = [head (shiftR xs)] ++ [x] ++ tail (shiftR xs)

-- 16-) Shift Right n vezes - versão preguiçosa (existe outro jeito de fazer?)
shiftRN1 l 0 = l
shiftRN1 l n = shiftRN1 (shiftR l) (n-1)

-- 17-) Shift Left
shiftL [] = []
shiftL (x:xs) = xs ++ [x]

-- 18-) Shift Left n vezes - versão preguiçosa (existe outro jeito de fazer?)
shiftLN1 l 0 = l
shiftLN1 l n = shiftLN1 (shiftL l) (n-1)

-- 19-) Remove item da lista 1 vez
removeItemUmaVez [] it = []
removeItemUmaVez (x:xs) it
  | x == it = xs
  | otherwise = [x] ++ (removeItemUmaVez xs it)

-- 20-) Remove item da lista todas as vezes
removeTodosItens [] it = []
removeTodosItens (x:xs) it
  | x == it = removeTodosItens xs it
  | otherwise = [x] ++ (removeTodosItens xs it)

-- 21-) Remove item da lista as n primeiras vezes
removeItemN [] it n = []
removeItemN l it 0 = l
removeItemN (x:xs) it n
  | x == it = removeItemN xs it (n-1)
  | otherwise = [x] ++ (removeItemN xs it n)

-- 22-) Remove item da lista a última vez que ele aparece
-- nota: desenhando a saída esperada da recursão na mão, percebe-se que, na chamada na
--       qual o item deve ser removido (última vez que ele aparece), o retorno da
--       próxima chamada recursiva é igual a xs - em todos os outros casos é diferente
removeItemUltimaVez [] it = []
removeItemUltimaVez [x] it
  | (x == it) = []
  | otherwise = [x]
removeItemUltimaVez (x:xs) it
  | (x == it) && (removeItemUltimaVez xs it == xs) = xs
  | otherwise = [x] ++ (removeItemUltimaVez xs it)

-- 23-) Troca velho por novo 1 vez
trocaUmaVez [] velho novo = []
trocaUmaVez (x:xs) velho novo
  | x == velho = [novo] ++ xs
  | otherwise = [x] ++ (trocaUmaVez xs velho novo)

-- 24-) Troca velho por novo todas as vezes
trocaTodosItens [] velho novo = []
trocaTodosItens (x:xs) velho novo
  | x == velho = [novo] ++ (trocaTodosItens xs velho novo)
  | otherwise = [x] ++ (trocaTodosItens xs velho novo)

-- 25-) Troca velho por novo as n primeiras vezes
trocaN [] velho novo n = []
trocaN l velho novo 0 = l
trocaN (x:xs) velho novo n
  | x == velho = [novo] ++ (trocaN xs velho novo (n-1))
  | otherwise = [x] ++ (trocaN xs velho novo n)