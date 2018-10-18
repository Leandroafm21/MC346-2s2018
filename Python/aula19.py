# 1-) Dado um iterator, retorna um iterator com os elementos nas posições pares (0, 2)
def pares(it):
  it = iter(it)

  while True:
    yield next(it)
    next(it)

# 2-) Dado um iterator, reverte ele
def reverte(it):
  it = iter(reversed(it))
  
  while True:
    yield next(it)

# 3-) Dado 2 iterators, retorna um iterator que retorna os elementos intercalados
def customZip(it1, it2):
  it = []

  k = 0
  while (k < len(it1) and k < len(it2)):
    it.append(it1[k])
    it.append(it2[k])
    k += 1

  if (k == len(it1)):
    while (k < len(it2)):
      it.append(it2[k])
      k += 1
  if (k == len(it2)):
    while (k < len(it1)):
      it.append(it1[k])
      k += 1
  
  it = iter(it)

  while True:
    yield next(it)

# 4-) Dado 2 iterators, retorna um iterator com o produto cartesiano dos elementos
def cart(it1, it2):
  it = []

  for i in it1:
    for j in it2:
      it.append((i, j))
  
  it = iter(it)

  while True:
    yield next(it)

# 5-) Dado um iterator, retorna os elementos num ciclo infinito
def ciclo(l):
    it = iter(l)

    k = 0
    while True:
        yield next(it)
        k += 1
        if (k == len(l)):
            it = iter(l)
            k = 0

# 6-) Retorna um iterator que gera numeros de init ate infinito, com passo
def rangeInf(init, step):
  it = iter([init])

  while True:
    x = next(it)
    yield x
    it = iter([x + step])

# 7-) Take do Haskell
def take(it, n):
  it = iter(it)

  k = 0
  while True:
    yield next(it)
    k += 1

    if (k == n):
      raise StopIteration

# 8-) Drop do Haskell
def drop(it, n):
  it = iter(it)

  for k in range(0, n):
    next(it)
  
  while True:
    yield next(it)