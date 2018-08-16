-- Os exercícios foram executados através do ambiente virtual repl.it

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

-- 4-) Soma dos elementos nas posições pares de uma lista - versão 1 (usando tam)
somaIndicesPares1 [] = 0
somaIndicesPares1 (x:xs)
  | mod (tam xs) 2 == 0 = x + somaIndicesPares1 xs 
  | otherwise = somaIndicesPares1 xs

-- 4-) Soma dos elementos nas posições pares de uma lista - versão 2 (sem usar tam)
somaIndicesPares2 [] i = 0
somaIndicesPares2 (x:xs) i
  | mod i 2 == 0 = x + somaIndicesPares2 xs (i+1)
  | otherwise = somaIndicesPares2 xs (i+1)

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

-- 7-) Contar quantas vezes item aparece na lista - versão 1 (com acumuladora)
ocorrenciasItem1 [] it res = res
ocorrenciasItem1 (x:xs) it res
  | x == it = ocorrenciasItem1 xs it (res+1)
  | otherwise = ocorrenciasItem1 xs it res

-- 7-) Contar quantas vezes item aparece na lista - versão 2 (sem acumuladora)
ocorrenciasItem2 [] it = 0
ocorrenciasItem2 (x:xs) it
  | x == it = 1 + ocorrenciasItem2 xs it
  | otherwise = ocorrenciasItem2 xs it

-- *8-) Maior elemento de uma lista - versão 1 (com acumuladora)
-- Chamada: maiorElemento (tail l) (head l), l é a lista
maiorElemento1 [] res = res
maiorElemento1 (x:xs) res
  | x > res = maiorElemento1 xs x
  | otherwise = maiorElemento1 xs res

-- *8-) Maior elemento de uma lista - versão 2 (sem acumuladora)
maiorElemento2 [] = []
maiorElemento2 [x] = x
maiorElemento2 (x:xs)
  | maiorElemento2 xs > x = maiorElemento2 xs
  | otherwise = x

-- *9-) Reverte uma lista
reverte [] = []
reverte (x:xs) = (reverte xs) ++ [x]

-- 10-) Intercala 2 listas
intercala1 [] l = []
intercala1 l [] = []
intercala1 (x:xs) (y:ys) = [x] ++ [y] ++ intercala1 xs ys

intercala2 [] l = l
intercala2 l [] = l
intercala2 (x:xs) (y:ys) = [x] ++ [y] ++ intercala2 xs ys