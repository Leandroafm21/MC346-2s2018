import numpy as np

# Algoritmo de Floyd-Warshall
def floyd_warshall(W, n, baseAdjacencyMatrix):
    D = []

    # Add infinity weights on unconnected nodes
    for i in range(0, n):
        for j in range(0, n):
            if (i != j and W[i][j] == 0):
                W[i][j] = np.inf

    D.append(W)
    for k in range(1, n+1):
        newMatrix = np.array(baseAdjacencyMatrix)
        for i in range(0, n):
            for j in range(0, n):
                newMatrix[i][j] = min(D[k-1][i][j], D[k-1][i][k-1] + D[k-1][k-1][j])
        D.append(newMatrix)
    
    return D[n-1]

# Verifica se uma viagem é possível, ou seja, se existe caminhos entre todos
# os pontos dela
def tripIsPossible(p1, p2, p3, p4, shortestPaths):
    if (shortestPaths[p1][p2] == np.inf or shortestPaths[p2][p3] == np.inf
        or shortestPaths[p3][p4] == np.inf):
        return False
    return True

# Calcula a inconveniência para os passageiros de uma viagem e retorna seus detalhes
# caso ela seja menor que 1.4 para ambos
def calculateInconvenience(i, j, p1, p2, p3, p4, shortestPaths, baseTime1, baseTime2, tripType):
    if (tripType == 0 or tripType == 2):
        time1 = shortestPaths[p1][p2] + shortestPaths[p2][p3] + shortestPaths[p3][p4]
        time2 = shortestPaths[p2][p3]
    else:
        time1 = shortestPaths[p1][p2] + shortestPaths[p2][p3]
        time2 = shortestPaths[p2][p3] + shortestPaths[p3][p4]

    inconvenience1 = time1/baseTime1
    inconvenience2 = time2/baseTime2
    if (inconvenience1 <= 1.4 and inconvenience2 <= 1.4):
        if (tripType == 0 or tripType == 1):
            trip = (
                i,
                j,
                inconvenience1 + inconvenience2,
                [p1, p2, p3, p4]
            )
        else:
            trip = (
                j,
                i,
                inconvenience1 + inconvenience2,
                [p1, p2, p3, p4]
            )

        return True, trip
    else:
        return False, None

# Retorna a viagem compartilhada mais barata (menor inconveniência)
def retriveCheapestTrip(trips):
    cheapest = 0
    for i in range(1, len(trips)):
        if (trips[i][2] < trips[cheapest][2]):
            cheapest = i
    return cheapest

# Main
def main():
    nodes = []
    adjacencies = []

    # Leitura da entrada (grafo)
    adjacency = input().split()
    while (len(adjacency) > 0):
        if (adjacency[0] not in nodes):
            nodes.append(adjacency[0])
        if (adjacency[1] not in nodes):
            nodes.append(adjacency[1])
        adjacencies.append([float(x) for x in adjacency])
        adjacency = input().split()

    # Criação da Matriz de Incidência base
    nodesCount = len(nodes)
    baseAdjacencyMatrix = []
    for i in range(0, nodesCount):
        baseAdjacencyMatrix.append(nodesCount * [0.0])
    adjacencyMatrix = np.array(baseAdjacencyMatrix)

    # Inserção das adjacências
    for adjacency in adjacencies:
        adjacencyMatrix[int(adjacency[0])][int(adjacency[1])] = adjacency[2]

    # Aplicação do Algoritmo de Floyd-Warshall
    shortestPaths = floyd_warshall(adjacencyMatrix, nodesCount, baseAdjacencyMatrix)

    trips = {}
    ongoingTrips = {}

    # Continuação da leitura da entrada (viagens)
    k = 0
    while (True):
        try:
            trip = [int(x) for x in input().split()]
        except EOFError:
            break

        if (len(trip) == 2):
            trips[k] = trip
        else:
            ongoingTrips[k] = trip
        k = k+1

    # Cálculo de todas as viagens possíveis e suas inconveniências.
    #
    # Tupla: (a, b, c, [d])
    #     a: passageiro 1
    #     b: passageiro 2
    #     c: soma das inconveniências para ambos os passageiros
    #     d: percurso
    uberPossibilities = []
    for i in range(0, nodesCount):
        if (i in trips.keys()):
            for j in range(0, nodesCount):
                if (i != j):
                    # Junção com viagens não iniciadas
                    if (j in trips.keys()):
                        baseTime1 = shortestPaths[trips[i][0]][trips[i][1]]
                        baseTime2 = shortestPaths[trips[j][0]][trips[j][1]]

                        # pega 1, pega 2, deixa 2, deixa 1
                        p1 = trips[i][0]
                        p2 = trips[j][0]
                        p3 = trips[j][1]
                        p4 = trips[i][1]
                        if (tripIsPossible(p1, p2, p3, p4, shortestPaths)):
                            isViable, possibility = calculateInconvenience(i, j, p1, p2, p3, p4, shortestPaths,
                                                                           baseTime1, baseTime2, 0)
                            if (isViable):
                                uberPossibilities.append(possibility)

                        # pega 1, pega 2, deixa 1, deixa 2
                        p1 = trips[i][0]
                        p2 = trips[j][0]
                        p3 = trips[i][1]
                        p4 = trips[j][1]
                        if (tripIsPossible(p1, p2, p3, p4, shortestPaths)):
                            isViable, possibility = calculateInconvenience(i, j, p1, p2, p3, p4, shortestPaths,
                                                                           baseTime1, baseTime2, 1)
                            if (isViable):
                                uberPossibilities.append(possibility)
            
                    # Junção com viagens já iniciadas
                    if (j in ongoingTrips.keys()):
                        baseTime1 = shortestPaths[ongoingTrips[j][2]][ongoingTrips[j][1]]
                        baseTime2 = shortestPaths[trips[i][0]][trips[i][1]]

                        # 1 em viagem, pega 2, deixa 2, deixa 1
                        p1 = ongoingTrips[j][2]
                        p2 = trips[i][0]
                        p3 = trips[i][1]
                        p4 = ongoingTrips[j][1]
                        if (tripIsPossible(p1, p2, p3, p4, shortestPaths)):
                            isViable, possibility = calculateInconvenience(i, j, p1, p2, p3, p4, shortestPaths,
                                                                           baseTime1, baseTime2, 2)
                            if (isViable):
                                uberPossibilities.append(possibility)
                        
                        # 1 em viagem, pega 2, deixa 1, deixa 2
                        p1 = ongoingTrips[j][2]
                        p2 = trips[i][0]
                        p3 = ongoingTrips[j][1]
                        p4 = trips[i][1]
                        if (tripIsPossible(p1, p2, p3, p4, shortestPaths)):
                            isViable, possibility = calculateInconvenience(i, j, p1, p2, p3, p4, shortestPaths,
                                                                           baseTime1, baseTime2, 3)
                            if (isViable):
                                uberPossibilities.append(possibility)

    passengers = [i for i in range(0, k)]
    # Imprime as melhores viagens possíveis
    while (len(uberPossibilities) > 0):
        cheapest = uberPossibilities[retriveCheapestTrip(uberPossibilities)]
        path = " ".join([str(x) for x in cheapest[3]])
        print("passageiros " + str(cheapest[0]+1) + " e " + str(cheapest[1]+1)
              + " percurso:  " + path)
        
        # Remove todas as viagens que englobam os passageiros da menor viagem selecionada
        uberPossibilities = [trip for trip in uberPossibilities if trip[0] != cheapest[0]
                                                                   and trip[0] != cheapest[1]
                                                                   and trip[1] != cheapest[0]
                                                                   and trip[1] != cheapest[1]]

        # Remove passageiros já alocados da lista de passageiros que precisam de viagens
        passengers.remove(cheapest[0])
        passengers.remove(cheapest[1])
    
    # Imprime as viagens individuais remanescentes
    for p in passengers:
        if (p in trips.keys()):
            path = " ".join([str(x) for x in trips[p]])
        else:
            path = str(ongoingTrips[p][2]) + " " + str(ongoingTrips[p][1])
        print("passageiro " + str(p+1) + " percurso: " + path)

if __name__ == "__main__":
    main()