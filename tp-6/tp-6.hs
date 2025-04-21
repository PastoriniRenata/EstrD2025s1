import PriorityQueue

{-
Ejercicio 2
Implementar la función heapSort :: Ord a => [a] -> [a], que dada una lista la ordena de
menor a mayor utilizando una Priority Queue como estructura auxiliar. ¿Cuál es su costo?
OBSERVACIÓN: el nombre heapSort se debe a una implementación particular de las Priority
Queues basada en una estructura concreta llamada Heap, que será trabajada en la siguiente
práctica.
-}


pq = insertPQ 5 (insertPQ 4 (insertPQ 3 (insertPQ 2 (insertPQ 1 emptyPQ))))

heapSort :: Ord a => [a] -> [a]
heapSort xs = pqALista (listaAPq xs)

listaAPq :: Ord a => [a] -> PriorityQueue a
listaAPq   []   = emptyPQ
listaAPq (x:xs) = insertPQ x (listaAPq xs)


pqALista :: Ord a => PriorityQueue a -> [a]
pqALista pq = if isEmptyPQ pq then []
                              else findMinPQ pq : pqALista (deleteMinPQ pq)









--------------------------------------------------------------------------------------------------------------------------------------

{-
Implementar como usuario del tipo abstracto Map las siguientes funciones:
-}
--Propósito: obtiene los valores asociados a cada clave del map.
valuesM :: Eq k => Map k v -> [Maybe v]
valuesM map = losValoresDe (keys map) map


losValoresDe :: Eq k => [k] -> Map k v -> [Maybe v]
losValoresDe   []   map = []
losValoresDe (k:ks) map = lookupM k map : losValoresDe ks map


--Propósito: indica si en el map se encuentran todas las claves dadas.
todasAsociadas :: Eq k => [k] -> Map k v -> Bool
todasAsociadas   []   map = True
todasAsociadas (k:ks) map = case lookupM k map of
                                Just v  -> todasAsociadas ks map -- si llega al final de la lista da true. 
                                Nothing -> False                 -- en cuanto uno de los valores no lo enuentra me da false


--Propósito: convierte una lista de pares clave valor en un map.
listToMap :: Eq k => [(k, v)] -> Map k v
listToMap   []   = emptyM
listToMap (t:ts) = assocM (first t) (second t) (listToMap ts)


--Propósito: convierte un map en una lista de pares clave valor.
mapToList :: Eq k => Map k v -> [(k, v)]
mapToList map = crearTuplas (keys map) map

crearTuplas :: Eq k => [k] -> Map k v -> [(k, v)] 
crearTuplas   []   map = []
crearTuplas (k:ks) map = case lookupM k map of
                            Just v  -> (k,v) : crearTuplas ks map
                            Nothing -> crearTuplas ks map


--Propósito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
--la misma clave.
agruparEq :: Eq k => [(k, v)] -> Map k [v]





--Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
--cada número asociado con dichas claves.
incrementar :: Eq k => [k] -> Map k Int -> Map k Int





--Propósito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
--una clave del primero existe en el segundo, es reemplazada por la del primero.
mergeMaps:: Eq k => Map k v -> Map k v -> Map k v






