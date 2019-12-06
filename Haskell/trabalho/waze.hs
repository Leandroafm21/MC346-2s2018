-- MC346 - Projeto 1 
-- http://www.ic.unicamp.br/~wainer/cursos/2s2018/proj-haskell.html

-- Flávia Bertoletti Silvério             | RA 167605
-- Leandro Augusto Fernandes de Magalhães | RA 171836

-- Graph type definition:
--     A Vertix contains its id, the distance to the source, the predecessor
--     and mean of transport used to arrive it; and a list of Edges.
--     An Edge contains its destination Vertix, mean of transport and weight
--     (travel time).
data Edge = Edge String String Float deriving (Eq, Show, Ord)
data Vertix = Vertix String Float String String [Edge] deriving (Eq, Show)

main = do
    -- Read and parse test file
    input <- getContents
    let linesInput = lines input
    let graphEdges = getEdges linesInput []
    let transportLines = getLines linesInput [] 0
    let sourceAndDestination = getSourceAndDestination linesInput 0

    -- Graph creation
    let source = getItemAt sourceAndDestination 0
    let destination = getItemAt sourceAndDestination 2
    -- Graph with all Vertixes that has leaving edges
    let rawGraph = insertEdges [] graphEdges
    -- Graph  with the remaining Vertixes (that has no leaving edges)
    let graph = insertDestinationVertixes rawGraph graphEdges
    -- Graph with the source Vertix distance equal to 0 (all the others have
    -- been set with Infinity)
    let initializedGraph = initialize graph [source]

    -- Find the shortest Paths leaving the source Vertix
    let shortestPaths = djikstra initializedGraph transportLines []

    -- Reconstruct the shortest Path between the source and destination and
    -- print it
    let shortestPath = reconstructPath shortestPaths [source] [destination] []
    putStrLn $ (unwords shortestPath)

    -- Calculate the distance (time taken) of the shortest Path and print it
    -- (the calculation is necessary to fix wait times being summed two times
    -- if the same bus or subway is used between three points)
    let timeTaken = calculateTime shortestPath shortestPaths transportLines 0 "" 0
    putStrLn $ (show (timeTaken) :: String)

    -- Finish main
    return ()

-- Parse the Graph edges from the test file, returning them as a list of lists.
--
-- Ex. (from exemplo0.txt) [
--                          [a b a-pe 0.4]
--                          [b a a-pe 0.6]
--                          ...
--                          [f h a-pe 12.3]
--                         ]
getEdges (x:xs) edges
    | x == "" = edges
    | otherwise = getEdges xs (edges ++ [words x])

-- Parse the bus/subway lines' information from the test file, also returning
-- them as a list of lists.
-- k (3rd parameter) is a control accumulator that will be incremented when an
-- empty line is found on the test file, that indicates the end of the edges and
-- beginning of lines' information.
--
-- When k = 0, edges are being read;
-- When k = 1, lines are being read (and saved on another accumulator);
-- When k = 2, all the lines were read.
getLines (x:xs) lines k
    | x == "" = getLines xs lines (k+1)
    | k == 2 = lines
    | k == 1 = getLines xs (lines ++ [words x]) k
    | otherwise = getLines xs lines k

-- Parse the source and destination to find the shortest path between, returning
-- it as a string.
-- Just like above, the k is a control accumulator. When k = 2, all that there's
-- left to read is the source and destination.
getSourceAndDestination (x:xs) k
    | x == "" = getSourceAndDestination xs (k+1)
    | k == 2 = x
    | otherwise = getSourceAndDestination xs k

-- Given a list, return the raw element at position k.
getItemAt (x:xs) 0 = x
getItemAt (x:xs) k = getItemAt xs (k-1)

-- Compare two strings, returning True if they're qual and False
-- otherwise.
compareString [] [] = True
compareString [] _ = False
compareString _ [] = False
compareString (x:xs) (y:ys)
    | x == y = compareString xs ys
    | otherwise = False

-- Search for a given Vertix on the Graph, returning True if found and False
-- otherwise.
findVertix [] _ = False
findVertix ((Vertix source _ _ _ _):vs) v
    | (compareString source v) == True = True
    | otherwise = findVertix vs v

-- Insert remaining Vertixes on the Graph (Vertixes without leaving Edges).
insertDestinationVertixes graph [] = graph
insertDestinationVertixes graph (e:es)
    | (findVertix graph label) == True = insertDestinationVertixes graph es
    | otherwise = insertDestinationVertixes (graph ++ [(Vertix label (1/0) "" "" [])]) es
    where label = (getItemAt e 1)

-- Insert a single Edge on the Graph.
insertEdge :: [Vertix] -> String -> Edge -> [Vertix]
-- If the Graph is empty, just return a list containing one Vertix, with only
-- one element in the list of Edges.
insertEdge [] s e = [Vertix s (1/0) "" "" [e]]
-- If the Graph isn't empty, insert the Edge at the source Vertix's list or
-- at its end (if the source Vertix isn't there yet).
insertEdge ((Vertix source distance predecessor mean edges):vs) s e
    | (compareString source s) == True = (Vertix source distance predecessor mean (edges ++ [e]):vs)
    | otherwise = ((Vertix source distance predecessor mean edges):(insertEdge vs s e))

-- Insert all Edged-Vertixes on the Graph, returning it at the end.
insertEdges :: [Vertix] -> [[String]] -> [Vertix]
insertEdges graph [] = graph
insertEdges graph (e:es) = insertEdges (insertEdge graph sourceVertix newEdge) es
    where sourceVertix = (getItemAt e 0)
          newEdge = (Edge (getItemAt e 1) (getItemAt e 2) (read (getItemAt e 3) :: Float))

-- Initialize the source Vertix distance with 0 (maintain others as Infinity).
initialize ((Vertix source distance predecessor mean edges):vs) s
    | (compareString source s) == True = ((Vertix source 0 "" "início" edges):vs)
    | otherwise = ((Vertix source distance predecessor mean edges):(initialize vs s))

-- Find the shortest paths between required source and all destinations using
-- Djikstra's Algorithm.
djikstra [] _ paths = paths
djikstra ((Vertix source distance predecessor mean edges):vs) lines paths = do
    -- Extract minimum d-valued Vertix.
    let (Vertix cSource cDistance cPredecessor cMean cEdges) = extractMin vs distance (Vertix source distance predecessor mean edges)
    -- Add it to the Paths.
    let newPaths = (paths ++ [(Vertix cSource cDistance cPredecessor cMean cEdges)])
    -- Relax Edges.
    let relaxedGraph = relaxVertix ((Vertix source distance predecessor mean edges):vs) ((Vertix source distance predecessor mean edges):vs) cSource lines
    -- Remove the minimum d-value Vertix from the Graph and proceed.
    let refreshedRelaxedGraph = removeMin relaxedGraph cSource
    djikstra refreshedRelaxedGraph lines newPaths

-- Get the Vertix with minimum calculated distance.
extractMin [] _ localMinVertix = localMinVertix
extractMin ((Vertix source distance predecessor mean edges):vs) localMinDistance localMinVertix
    | distance < localMinDistance = extractMin vs localMinDistance (Vertix source distance predecessor mean edges)
    | otherwise = extractMin vs localMinDistance localMinVertix

-- Find the minimum d-valued Vertix, and call relaxEdges for its Edges.
relaxVertix [] fullGraph _ _ = fullGraph
relaxVertix ((Vertix source distance _ mean edges):vs) fullGraph v lines
    | (compareString source v) == True = relaxEdges source distance mean edges fullGraph lines
    | otherwise = relaxVertix vs fullGraph v lines

-- For each Edge, update the value d of its destination Vertix (which is, in
-- fact, the relaxing process) by calling relaxGraph.
relaxEdges _ _ _ [] fullGraph _ = fullGraph
relaxEdges source distance mean ((Edge destination transport travelTime):es) fullGraph lines = do
    let totalTime = (getWaitTime transport lines) + travelTime
    relaxEdges source distance mean es (relaxGraph fullGraph source destination (distance+totalTime) transport) lines

-- Get the wait time of a transport. If not bus or subway, return 0, otherwise
-- return half of its leaving period.
getWaitTime _ [] = 0
getWaitTime transport (l:ls)
    | (compareString transport "a-pe") == True = 0
    | (compareString transport (getItemAt l 0)) == True = (read (getItemAt l 1) :: Float)/2
    | otherwise = getWaitTime transport ls

-- Find the Vertix that needs its value (d and predecessor) changed and update
-- it.
relaxGraph [] _ _ _ _ = []
relaxGraph ((Vertix source distance predecessor mean edges):vs) s d currentDistance currentMean
    | ((compareString source d) == True && currentDistance < distance) = ((Vertix source currentDistance s currentMean edges):(relaxGraph vs s d currentDistance currentMean))
    | otherwise = ((Vertix source distance predecessor mean edges):(relaxGraph vs s d currentDistance currentMean))

-- Remove the first Vertix with minimum calculated distance, which will always
-- be also the first found on extractMin.
removeMin ((Vertix source distance predecessor mean edges):vs) min
    | (compareString source min) == True = vs
    | otherwise = ((Vertix source distance predecessor mean edges):(removeMin vs min))

-- Get the information of the Vertix with required label.
getVertix ((Vertix source distance predecessor mean edges):vs) v
    | (compareString source v) == True = (Vertix source distance predecessor mean edges)
    | otherwise = getVertix vs v

-- Reconstruct the Path between the destination and source, by using the
-- predecessors.
reconstructPath paths s d path
    | (compareString s source) == True = s:path
    | otherwise = reconstructPath paths s predecessor (mean:source:path)
    where (Vertix source distance predecessor mean edges) = getVertix paths d

-- Calculate the time taken between the first and the last Vertix of the
-- shortest Path, considering when the same bus or subway is used to travel
-- between three points.
calculateTime [x] paths _ _ _ time = ((getDistanceAt paths x) + time)
calculateTime (x:xs) paths lines k prev time
    | (mod k 2 == 1 && (compareString x prev) == True) = calculateTime xs paths lines (k+1) x (time - (getWaitTime x lines))
    | (mod k 2 == 1) = calculateTime xs paths lines (k+1) x time
    | otherwise = calculateTime xs paths lines (k+1) prev time

-- Get the calculated distance of a Vertix (only used on destination Vertix, to
-- get the shortest path size).
getDistanceAt ((Vertix source distance predecessor mean edges):vs) v
    | (compareString source v) == True = distance
    | otherwise = getDistanceAt vs v

-- [DEBUG] Print the elements of a Graph.
printEdges [] = putStrLn $ "end of Edges"
printEdges ((Edge destination transport travelTime):es) = do
    putStrLn $ (destination ++ " " ++ transport ++ " " ++ (show travelTime :: String))
    printEdges es
printGraph [] = putStrLn $ "----------End of Graph----------"
printGraph ((Vertix source distance predecessor mean edges):vs) = do
    putStrLn $ source ++ " " ++ (show distance :: String) ++ " " ++ mean
    printEdges edges
    printGraph vs

-- [DEBUG] Print the shortest Paths.
printPaths [(Vertix source distance predecessor mean edges)] = do
    putStrLn $ source ++ " " ++ predecessor ++ " " ++ (show distance :: String) ++ " " ++ mean
    putStrLn $ "----------End of ShortestPaths----------"
printPaths ((Vertix source distance predecessor mean edges):vs) = do
    putStrLn $ source ++ " " ++ predecessor ++ " " ++ (show distance :: String) ++ " " ++ mean
    printPaths vs
