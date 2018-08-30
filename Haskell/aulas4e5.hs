-- Assuntos das aulas: lazy evaluation, tipos customizados

-- Abb's exemplo:
-- (No 8 (No 3 (No 1 Vazia Vazia) (No 6 (No 4 Vazia Vazia) (No 7 Vazia Vazia))) (No 10 Vazia (No 14 (No 13 Vazia Vazia) Vazia)))
-- (No 50 (No 30 (No 20 Vazia Vazia) (No 40 (No 35 Vazia (No 37 Vazia Vazia)) (No 45 Vazia Vazia))) (No 100 Vazia Vazia))

data Tree a = Vazia | No a (Tree a) (Tree a) deriving (Eq, Show, Read)

-- 1-) Acha um item em uma Árvore de Binária de Busca
encontraItemAbb :: Ord a => Tree a -> a -> Bool
encontraItemAbb Vazia it = False
encontraItemAbb (No x ae ad) it
  | it < x = encontraItemAbb ae it
  | it > x = encontraItemAbb ad it
  | it == x = True

-- 3-) Insere um item em uma Árvore Binária de Busca
insereItemAbb :: Ord a => Tree a -> a -> Tree a
insereItemAbb Vazia it = (No it Vazia Vazia)
insereItemAbb (No x Vazia Vazia) it
  | it < x = (No x (No it Vazia Vazia) Vazia)
  | it > x = (No x Vazia (No it Vazia Vazia))
insereItemAbb (No x ae ad) it
  | it < x = (No x (insereItemAbb ae it) ad)
  | it > x = (No x ae (insereItemAbb ad it))

-- 4-) Remove um item de uma Árvore Binária de Busca

-- 4.1-) Obtém o nó mais a esquerda de uma subárvore
retornaSubstituto (No x Vazia _) = x
retornaSubstituto (No x ae ad) = retornaSubstituto ae

-- 4.2-) "Rebalanceia" a árvore
rebalancearArvore (No x ae ad) it
  | it == x = ad
  | otherwise = (No x (rebalancearArvore ae it) ad)

-- 4.3-) Remove o item
removeItemAbb :: Ord a => Tree a -> a -> Tree a
removeItemAbb (No x Vazia Vazia) it
  | it == x = Vazia
  | otherwise = (No x Vazia Vazia)
removeItemAbb (No x ae ad) it
  | it < x = (No x (removeItemAbb ae it) ad)
  | it > x = (No x ae (removeItemAbb ad it))
  | it == x = (No substituto ae (rebalancearArvore ad substituto))
  where substituto = retornaSubstituto ad

-- 5-) Calcula a profundidade máxima de uma Árvore Binária de Busca
profundidadeMaxima :: (Ord b, Num b) => Tree a -> b
profundidadeMaxima Vazia = 0
profundidadeMaxima (No x ae ad) = if pae > pad then pae else pad
  where pae = 1 + (profundidadeMaxima ae)
        pad = 1 + (profundidadeMaxima ad)

-- 6-) Converte uma Árvore Binária de Busca em uma lista em ordem Infixa
ttolInfixa :: Tree a -> [a]
ttolInfixa Vazia = []
ttolInfixa (No x ae ad) = (ttolInfixa ae) ++ [x] ++ (ttolInfixa ad)

-- 7-) Converte uma Árvore Binária de Busca em uma lista em ordem Prefixa
ttolPrefixa :: Tree a -> [a]
ttolPrefixa Vazia = []
ttolPrefixa (No x ae ad) = [x] ++ (ttolPrefixa ae) ++ (ttolPrefixa ad)

-- 8-) Converte uma Lista em uma Árvore Binária de Busca
ltot :: Ord a => [a] -> Tree a
ltot l = ltot' l Vazia
  where ltot' [] abb = abb
        ltot' (x:xs) abb = ltot' xs (insereItemAbb abb x)