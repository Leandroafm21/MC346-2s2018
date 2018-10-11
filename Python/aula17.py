# 1-) Criar uma lista com apenas os valores pares de outra lista
def criaValoresPares():
    print("Entre com a lista: ", end="")
    lista1 = [int(x) for x in input().split()]

    lista2 = [x for x in lista1 if x % 2 == 0]
    print(lista2)

# 2-) Criar uma lista com os valores nas posições pares de outra lista
def criaIndicesPares():
    print("Entre com a lista: ", end="")
    lista1 = [int(x) for x in input().split()]

    lista2 = [lista1[i] for i in range(0, len(lista1)) if i % 2 == 1]
    print(lista2)

# 3-) Criar um dicionário com a contagem de cada elemento de uma lista
def criarDicionarioContagem():
    print("Entre com a lista: ", end="")
    lista1 = [int(x) for x in input().split()]

    dicionario = {}
    for x in lista1:
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
def elementoMaisComum():
    print("Entre com a lista: ", end="")
    lista1 = [int(x) for x in input().split()]

    dicionario = {}
    for x in lista1:
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
def sublista1():
    print("Entre com a lista maior: ", end="")
    lista1 = [x for x in input().split()]

    print("Entre com a lista menor: ", end="")
    lista2 = [x for x in input().split()]

    lista1string = "".join(lista1)
    lista2string = "".join(lista2)
    if lista2string in lista1string:
        print("Sim")
    else:
        print("Não")

# 6-) Uma lista é sublista de outra? [normal]
def sublista2():
    print("Entre com a lista maior: ", end="")
    lista1 = [int(x) for x in input().split()]

    print("Entre com a lista menor: ", end="")
    lista2 = [int(x) for x in input().split()]

    for i in range(0, len(lista1)):
        if (lista1[i] == lista2[0]):
            if (i + len(lista2) - 1 < len(lista1)):
                if (lista1[i:(i + len(lista2)+1)] == lista2):
                    print("Sim")
                    return
    print("Não")

# 7-) Dado 2 strings, o fim de uma é igual ao começo de outra?
def fimDeUmaStringIgualAoComecoDeOutra():
    print("Entre com a primeira string: ", end="")
    string1 = input()

    print("Entre com a segunda string: ", end="")
    string2 = input()

    for i in range(0, len(string1)):
        fim = string1[i:]
        if (len(fim)+1 < len(string2)):
            comeco = string2[:len(fim)]
            if (fim == comeco):
                print("Match de tamanho " + str(len(fim)) + ": " + comeco)
                return
    print("Não")

while(True):
    op = input()

    if (op == "e1"):
        criaValoresPares()
    elif (op == "e2"):
        criaIndicesPares()
    elif (op == "e3"):
        criarDicionarioContagem();
    elif (op == "e4"):
        obtemChaveMaiorValorDicionario();
    elif (op == "e5"):
        elementoMaisComum()
    elif (op == "e6a"):
        sublista1()
    elif (op == "e6b"):
        sublista2()
    elif (op == "e7"):
        fimDeUmaStringIgualAoComecoDeOutra();
    elif (op == "q"):
        break
    else:
        print("Operação invalida! Entre 'q' para sair.")