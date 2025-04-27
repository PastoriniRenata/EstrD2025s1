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


{-
    - n es la cantidad de elementos de la lista ingresada como argumento

    listaAPq:
        - emptyPQ tiene un costo O(1), se desestima
        - insertPQ tiene un costo O(m) en el peor caso, donde m es el tamaño actual de la PQ
        ==> listaAPq tiene un costo O(n * m) ya que hace una operacion lineal por cada llamado recursivo sobre la lista. Como estoy calculando
                    el peor caso y la PQ va a terminar teniendo la misma cantidad de elementos que en la lista ingresada
                ==> n = m -> O(n * m) -> O(n^2)

    pqALista:
        - isEmptyPQ tiene costo O(1), se desestima
        - findMinPQ tiene costo O(1), se desestima
        - deleteMinPQ tiene costo O(1), se desestima

        ==> pqALista tiene osto O(m), donde m es la cantidad de elementos de la PQ ingresada por argumento, y donde por cada llamado 
                recursivo hace operaciones constantes
            
            --> como la PQ tiene la misma cantidad de elementos que la lista original --> m = n --> pqALista tiene osto O(n)

    heapSort:
        - tiene un costo de O(n + n^2), se suman xq van una dsps d la otra y no dependen una d la otra para existir
            el termino lineal se desestima por ser el mas chico --> O(n * (1+n)) --> O(n * n) --> O(n^2)
        

-}

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

{-
    - n es la cantidad de elementos del map

    costo de losValoresDe:
        - lookupM tiene costo O(n)

        --> como se hace una operacion lineal por cada llamado recursivo, losValoresDe tiene costo O(n*n) --> O(n^2)


    COSTO DE valuesM
    - keys tiene costo O(n)
    - losValoresDe tiene costo O(n^2)

    -> el costo operacional de valuesM es O(n + n^2) --> O(n * (1+n)) ---el uno es aborbido por la suma con n ---> valuesM es O(n^2)

-}




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: indica si en el map se encuentran todas las claves dadas.
todasAsociadas :: Eq k => [k] -> Map k v -> Bool
todasAsociadas   []   map = True
todasAsociadas (k:ks) map = elem k (keys map) && (todasAsociadas ks map)

{-  
    - n es la cantidad de elementos del map
    - k es la cantidad de elementos de la lista ingresada por argumento
    - keys tiene costo O(n)
    - elem tiene costo O(n), ya que recorre la lista de claves del map. Osea que tiene la misma cantidad de elementos del map



    ==> todasAsociadas tiene costo O((n+n) * k) --> O(2n*k) -- el 2 es absorbido -- > O(n*k) ya que por cada llamado recursivo (las k iteraciones), se hace una operacion de costo linela
    
            ==> todasAsociadas tiene costo O(n)
-}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: convierte una lista de pares clave valor en un map.
listToMap :: Eq k => [(k, v)] -> Map k v
listToMap   []   = emptyM
listToMap (t:ts) = let (x, y) = t
                        in assocM x y (listToMap ts)


{-
    - t es la cantidad de elementos del la lista de claves-valores
    - assocM tiene costo O(m), donde m es la cantidad de elementos del MAP actual. Como estoy calculando el peor costo -> m=t en el peor caso --> assocM tiene costo O(t)

    ==> listToMap tiene costo O(t^2), ya que realiza una operacion lineal por cada llamdo recursivo.

-}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: convierte un map en una lista de pares clave valor.
mapToList :: Eq k => Map k v -> [(k, v)]
mapToList map = crearTuplas (keys map) map

crearTuplas :: Eq k => [k] -> Map k v -> [(k, v)] 
crearTuplas   []   map = []
crearTuplas (k:ks) map = let valor = fromJust (lookupM k map) -- puedo usar el from just xq la lista de claves la cree a partir del map, x lo q tengo la garantía de q todas las claves tiene un valor asociado
                            in (k,valor) : crearTuplas ks map

{-
    - n es la cantidad de elementos del map
    - keys tiene costo O(n)


    cresarTuplas:
        - k es la cantidad de elementos de la lista ingresada por argumento. 
            => Como la lista fue creada a partir del map k = n
        
        - n es la cantidad de elementos del map
        - lookupM tiene costo O(n)
        - fromJust tiee costo O(1), se desestima

        ==> crearTuplas tiene costo O(n*k) -> O(n*n) -> O(n^2), ya que por los n llamados recursivos se hace una operacion lineal de costo O(n)

-}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
--la misma clave.

agruparEq :: Eq k => [(k, v)] -> Map k [v]
agruparEq    []    = emptyM
agruparEq (kv:kvs) = let (c, v) = kv
                        in agregarAlMap c v (agruparEq kvs)

agregarAlMap :: Eq k => k -> v -> Map k [v] -> Map k [v]
agregarAlMap x y map = case lookupM x map of
                            Just vs -> assocM x (y:vs) map
                            Nothing -> assocM x [y] map


{-
    agregarAlMap
         - n la cantidad de elementos del map
         - lookupM tiene costo O(n)
         - assocM tiene costo O(n)

         --> agregarAlMap hace dos operaciones lineales --> tiene costo O(n+n) --> O(2n) --> O(n)



    agruparEq
         agruparEq hace una operacion lineal (agregarAlMap) por cada llamado recursivo al recorrer la lista ingresada por parametro.
         - m cantidad de elementos de la lista ingresada por parametro

        agruparEq tiene costo O(m*n)
            --> nada te garantiza que la cantidad de elementos que va a terminar teniendo el map va a ser la misma cantidad de elementos que tiene la lista de tuplas, xq puede haber claves repetidas.
                    Pero como estoy claculando el costo para el peor caso, y mi peor caso es que n=m
                --> agruparEq tiene costo O(n*n) --> O(n^2)
-}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
--cada número asociado con dichas claves.
incrementar :: Eq k => [k] -> Map k Int -> Map k Int
incrementar   []   map = map
incrementar (c:cs) map = case lookupM c map of
                                Just v  -> assocM c (v+1) (incrementar cs map)
                                Nothing -> incrementar cs map


{-
    - c es la cantidad de claves en la lista ingresada por argumento
    - n es la cantidad de elementos del map ingresada por argumento

    - lookupM tiene costo O(n)
    - assocM tiene costo O(n)


==> como estoy calculando el peor costo, mi funcion "incrementar" hace una operacion con costo O(n+)

-}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
--una clave del primero existe en el segundo, es reemplazada por la del primero.
--OBS: assoc pisa el valor si la clave ya existe en el map
mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
mergeMaps map1 map2 = unirMaps (keys map1) map1 map2

unirMaps :: Eq k => [k] -> Map k v -> Map k v -> Map k v
unirMaps   []    _   map2 = map2
unirMaps (c:cs) map1 map2 = unirMaps cs map1 (assocM c (fromJust (lookupM c map1)) map2) -- como lo hice yo
                 -- forma que les gusta a ellos: assoocM c (fromJust(lookupM c map1) (unirMaps cs map1 map2))

{-
COSTO con V1 de Map:
    - Costo de unirMaps:
        - assocM tiene costo O(m), donde m es la cantidad de elementos del map2
        - fromJust tiene costo O(1)
        - lookUpM tiene costo O(n), donde n es la cantidad de elementos del map1


        --> unirMaps tiene costo O((n+m) * k), ya que por cada elemento de la lista ingresada por parametro, los k elementos, se 
             hace una operacion de costo (n + m), n al tener que usar lookupM en el map1 y m al usar assocM en el map2


        --> usando la VERSION 1 de Map k=n, ya que al no haber elementos repetidos, la cantidad de claves es la misma que a cantidad de elementos del map
                --> unirMaps tiene costo O((n+m) * n) -->  O(n*m + n^2)


    - Costo de mergeMaps:
        - keys tiene costo O(n), donde n es la cantidad de elementos del map1
        - unirMaps tiene costo O((n+m) * k), donde m es la cantidad de elementos del map2, n es la cantidad de elementos del map1
             y k la cantidad de claves en la lista ingresada por parametro

        --> mergeMaps tiene costo O((n+m) * k + k) - asorbo el + k -> O((n+m) * k), donde:
                                                    - n cantidad de elementos de map2
                                                    - m cantidad de elementos de map1
                                                    - k la cantidad de claves obtenidas de map1 (que usando la version 1 de MAP k=n, xq no hay elementos repetidos)

                --> tiene costo O((n+m) * k + k) --> O((n+m+1) *k), el 1 es absorbido ya que (n+m) podría ser muchisimo más grande, obteniendo finalmente el costo O((n+m) * k)


                --> EN LA VERSION 1 DE MAP --> mergeMaps tiene costo O(n*m + n^2)        



COSTO POR EL PROFESOR (Cristian):


-}




fromJust :: Maybe v -> v
--Precondicion: unicamente toma valores Just
fromJust (Just x) = x


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
-- respuesta version 2 >> M [("a",[1,3]),("b",[2,4]),("a",[3]),("b",[4]),("c",[5])] 
--        está bien xq admite repetidos la estructura y como cuando haga lookup las 2das tuplas nunca me las va a devolver, está bien
--        trabaja de más al pedo, pero está bien

-- >> incrementar lk m3
-- respuesta >> M [("d",2),("c",2),("b",2),("a",2)]
--        => con V3  --> M ["d","c","b","a","a","b","c","d"] [2,2,2,2,1,1,1,1] xq admite repetidos, entonces agrega los que quiero incrementar con su nuevo valor y los otros quedan olvidados al fondo del map

-- >> incrementar lk m4
-- respuesta >> M [("d",2),("c",2),("a",2)]

m6 :: Map String Int
m6 = assocM "a" 2 (assocM "b" 2 (assocM "c" 2 (assocM "d" 2 emptyM)))

{-

m6 :: Map String Int
m6 = assocM "a" 2 (assocM "b" 2 (assocM "c" 2 (assocM "d" 2 emptyM)))

m4 :: Map String Int
m4 = assocM "g" 1 (assocM "h" 1 (assocM "c" 1 (assocM "d" 1 (assocM "a" 1 emptyM))))

mergeMaps m3 m4 --> M [("a",1),("b",1),("d",1),("c",1),("h",1),("g",1)]

-}



--Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
--su posición en la lista.
indexar :: [a] -> Map Int a
indexar xs = mapIndexado 0 xs


mapIndexado ::  Int -> [a] ->  Map Int a
mapIndexado  n   []  = emptyM
mapIndexado  n (x:xs)= assocM n x (mapIndexado (n+1) xs)



--Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
--en el string, y los valores la cantidad de veces que aparecen en el mismo.
ocurrencias :: String -> Map Char Int
ocurrencias   ""   = emptyM
ocurrencias (c:cs) = case lookupM c ( ocurrencias cs) of
                            Just v  -> assocM c (v+1) (ocurrencias cs)
                            Nothing -> assocM c 1 (ocurrencias cs)


