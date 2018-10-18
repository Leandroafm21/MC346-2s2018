# 1-) Criar uma lista com apenas os valores pares de outra lista
def criaValoresPares(lista):
    lista2 = [x for x in lista if x % 2 == 0]
    print(lista2)

# 2-) Criar uma lista com os valores nas posições pares de outra lista
def criaIndicesPares(lista):
    lista2 = [lista[i] for i in range(0, len(lista)) if i % 2 == 1]
    print(lista2)

# 3-) Criar um dicionário com a contagem de cada elemento de uma lista
def criarDicionarioContagem(lista):
    dicionario = {}
    for x in lista:
        if x in dicionario.keys():
            dicionario[x] += 1
        else:
            dicionario[x] = 1
    print(dicionario)

# 4-) Qual é a chave associada ao maior valor em um dicionário
def obtemChaveMaiorValorDicionario():
    print("Entre com o número de chaves: ", end="")
    n = int(input())

    dicionario = {}
    print("Entre com os " + str(n) + " pares chave/valor separados por espaço, um por linha:")
    for i in range(0, n):
        (chave, valor) = input().split()
        dicionario[chave] = int(valor)
    
    maior = max(dicionario.values())
    for i in dicionario.keys():
        if (dicionario[i] == maior):
            print("Chave do maior valor: " + str(i))
            break

# 5-) Qual é o elemento mais comum em uma lista
def elementoMaisComum(lista):
    dicionario = {}
    for x in lista:
        if x in dicionario.keys():
            dicionario[x] += 1
        else:
            dicionario[x] = 1

    maiorFrequencia = max(dicionario.values())
    for i in dicionario.keys():
        if (dicionario[i] == maiorFrequencia):
            print("Elemento mais comum: " + str(i) + " (" + str(maiorFrequencia) + " vezes)")
            break

# 6-) Uma lista é sublista de outra? [tricky]
def sublista1(lista1, lista2):
    lista1string = "".join(lista1)
    lista2string = "".join(lista2)
    if (lista2string in lista1string) or (lista2string in lista1string):
        print("Sim")
    else:
        print("Não")

# 6-) Uma lista é sublista de outra? [normal]
def sublista2(lista1, lista2):
    if (len(lista2) > len(lista1)):
      lista1, lista2 = lista2, lista1

    for i in range(0, len(lista1)):
        if (lista1[i] == lista2[0]):
            print("ok")
            if (i + len(lista2) - 1 < len(lista1)):
                print(lista1[i:(i + len(lista2))])
                if (lista1[i:(i + len(lista2))] == lista2):
                    print("Sim")
                    return
    print("Não")

# 7-) Dado 2 strings, o fim de uma é igual ao começo de outra?
def fimDeUmaStringIgualAoComecoDeOutra(string1, string2):
    for i in range(0, len(string1)):
        fim = string1[i:]
        if (len(fim)+1 < len(string2)):
            comeco = string2[:len(fim)]
            if (fim == comeco):
                print("Match de tamanho " + str(len(fim)) + ": " + comeco)
                return
    print("Não")