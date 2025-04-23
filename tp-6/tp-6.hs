import PriorityQueue
import MapV1

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
listToMap (t:ts) = let (x, y) = t
                        in assocM x y (listToMap ts)


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
agruparEq    []    = emptyM
agruparEq (kv:kvs) = let (c, v) = kv
                        in agregarAlMapa c v (agruparEq kvs)

agregarAlMapa :: Eq k => k -> v -> Map k [v] -> Map k [v]
agregarAlMapa x y map = case lookupM x map of
                            Just vs -> assocM x (y:vs) map
                            Nothing -> assocM x [y] map


--Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
--cada número asociado con dichas claves.
incrementar :: Eq k => [k] -> Map k Int -> Map k Int
incrementar   []   map = map
incrementar (c:cs) map = case lookupM c map of
                                Just v  -> incrementar cs (assocM c (v+1) map)
                                Nothing -> incrementar cs map


--Propósito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
--una clave del primero existe en el segundo, es reemplazada por la del primero.
--OBS por mi: assoc pisa el valor si la clave ya existe en el mapa
mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
mergeMaps map1 map2 = unirMapas (keys map1) map1 map2

unirMapas :: Eq k => [k] -> Map k v -> Map k v -> Map k v
unirMapas   []    _   map2 = map2
unirMapas (c:cs) map1 map2 = case lookupM c map1 of
                                    Just v  -> unirMapas cs map1 (assocM c v map2)
                                    Nothing -> unirMapas cs map1 map2




m1 :: Map Int String
m1 = assocM 1 "uno" (assocM 2 "dos" (assocM 3 "tres" (assocM 4 "cuatro" (assocM 5 "cinco" emptyM))))

lk :: [String]
lk = ["a", "b", "c", "d"]

m3 :: Map String Int
m3 = assocM "a" 1 (assocM "b" 1 (assocM "c" 1 (assocM "d" 1 emptyM)))

m4 :: Map String Int
m4 = assocM "g" 1 (assocM "h" 1 (assocM "c" 1 (assocM "d" 1 (assocM "a" 1 emptyM))))

m5 :: Map String Int
m5 = assocM "a" 2 (assocM "b" 2 (assocM "c" 2 (assocM "d" 2 emptyM)))

lkv :: [(String, String)]
lkv = [("a", "aa"), ("b", "bb"), ("c", "cc"), ("d", "dd"), ("e", "ee"), ("f", "ff"), ("g", "gg")]

-- >> valuesM m1
-- respuesta >> [Just "cinco",Just "cuatro",Just "tres",Just "dos",Just "uno"]

-- >> todasAsociadas [1,2,3,4,5,6,7] m1
-- respuesta >> False

-- >> todasAsociadas [1,3,4,5] m1
-- respuesta >> True

-- >> listToMap lkv
-- respuesta >> M [("g","gg"),("f","ff"),("e","ee"),("d","dd"),("c","cc"),("b","bb"),("a","aa")]

-- >> mapToList m1
-- respuesta >> [(5,"cinco"),(4,"cuatro"),(3,"tres"),(2,"dos"),(1,"uno")]

-- >> agruparEq [("a", 1), ("b", 2), ("a", 3), ("b", 4), ("c", 5)]
-- respuesta >> M [("c",[5]),("b",[2,4]),("a",[1,3])]

-- >> incrementar lk m3
-- respuesta >> M [("d",2),("c",2),("b",2),("a",2)]

-- >> incrementar lk m4
-- respuesta >> M [("d",2),("c",2),("a",2)]



