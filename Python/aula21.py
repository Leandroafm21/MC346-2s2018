import numpy as np

# 1-) Dado uma matriz, normalize as linhas de forma que suas normas sejam 1
def normalizarLinhasMatriz(m):
    m = np.array(m, dtype=np.float)

    for row in m:
        norm = np.linalg.norm(row)
        for cell in np.nditer(row, op_flags=["readwrite"]):
            cell[...] = float(cell[...])/norm
    
    print(m)

# 2-) Dado uma matriz, normalize as colunas
def normalizarColunasMatriz(m):
    m = np.array(m, dtype=np.float)

    for column in m.T:
        norm = np.linalg.norm(column)
        for cell in np.nditer(column, op_flags=["readwrite"]):
            cell[...] = float(cell[...])/norm
    
    print(m)

# 3-) Dado uma matriz, calcule a soma dos elementos das linhas cujos primeiros valores são maiores que 0
def somaElementosLinhasPositivas(m):
    m = np.array(m)

    result = 0
    for row in m:
        if row[0] > 0:
            result = result + np.sum(row)
    
    print(result)

# 5-) Dado um vetor, troque todos os valores > 0 para 1 e < 0 para -1
def digitalizarVetor(v):
    v = np.array(v)

    for cell in np.nditer(v, op_flags=["readwrite"]):
        cell[...] = 1 if cell[...] > 0 else 0
    
    print(v)

# Testes
def rodarTestes():
    print("Exercício 1:")
    normalizarLinhasMatriz([[1, 2, 3], [4, 5, 6]])

    print("Exercício 2:")
    normalizarColunasMatriz([[1, 2, 3], [4, 5, 6]])

    print("Exercício 3:")
    somaElementosLinhasPositivas([[1, 2, 3, 4], [-5, 6, 7, 8], [9, 10, 11, 12]])

    print("Exercício 5:")
    digitalizarVetor([1, -2, 3, 4, -5, 6, -7, -8, -9, 10])

if __name__ == "__main__":
    rodarTestes()