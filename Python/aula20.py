import time

# Função teste
def testFunction(values, constant):
  result = 0
  for i in range(0, len(values)):
    for j in range(i+1, len(values)):
      result += (values[i] * values[j]) + constant
  return result

# 1-) Decorator para imprimir o tempo de execução.
def tempoExecucao(f):
  def wrapper(*args):
    begin = time.time()
    f(args[0])
    end = time.time()
    print("Tempo: " + str((end - begin) * 1000000) + " µs")
  
  return wrapper

f1 = tempoExecucao(testFunction)

# 2-) Decorator para construir uma String com linhas para a hora, argumentos e saída de cada chamada da função. A String será acessada via atributo.
def log(f):
  executionLogs = []
  def wrapper(*args):
    executionLog = time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())
    values, constant = args
    result = f(values, constant)
    executionLog += " | Input: " + str(args) + "| Output: " + str(result)
    executionLogs.append(executionLog)

    print("Log:")
    for l in executionLogs:
        print(l)
  
  return wrapper

f2 = log(testFunction)

# 3-) Decorator para memorizar a função. Memorização é criar um dicionário que se lembra dos valores de entrada e de saída da função já executados. Se um desses valores de entrada for re-executado, a função não será re-executada - ela apenas retorna o valor de saída memorizado.
def memorizador(f):
  executionMap = {}
  def wrapper(*args):
    # Converte argumentos para string única
    values, constant = args
    strValues = [str(v) for v in values]
    argsKey = "_".join(strValues) + "_" + str(constant)
    
    if (argsKey in executionMap):
      print(executionMap[argsKey])
    else:
      result = f(values, constant)
      print(result)
      executionMap[argsKey] = result
  
  return wrapper

f3 = memorizador(testFunction)

# 4-) Decorator para "loggar" argumentos e horário de execução num arquivo dado como argumento
def logToFile(f, fileName):
  logFile = open(fileName, "a")
  def wrapper(*args):
    executionLog = time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())
    values, constant = args
    result = f(values, constant)
    executionLog += " | Output: " + str(result)
    logFile.write(executionLog)
    logFile.write("\n")

  return wrapper

f4 = logToFile(testFunction, "test_log.txt")