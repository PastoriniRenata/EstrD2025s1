
{-

1. Implementar el tipo abstracto MultiSet utilizando como representación un Map. Indicar los
ordenes de complejidad en peor caso de cada función de la interfaz, justificando las respuestas.

-}

module MultiSet 
    (MultiSet, emptyMS, addMS, ocurrencesMS, unionMS, intersectionMS, multiSetToList) 
where

import MapV1

data MultiSet a = MS (Map a Int)
    deriving Show


{-
module MapV1
    (Map, emptyM, assocM, lookupM, deleteM, keys)
where

-}
--Propósito: denota un multiconjunto vacío.
emptyMS :: MultiSet a
emptyMS = MS emptyM

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al
--multiconjunto.
addMS :: Ord a => a -> MultiSet a -> MultiSet a
addMS x (MS map) = case lookupM x map of
                        Just v  -> MS (assocM x (v+1) map)
                        Nothing -> MS (assocM x   1   map)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dados un elemento y un multiconjunto indica la cantidad de apariciones de ese
--elemento en el multiconjunto.
ocurrencesMS :: Ord a => a -> MultiSet a -> Int
ocurrencesMS x (MS map) = case lookupM x map of
                                Just v  -> v
                                Nothing -> 0


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de
--ambos multiconjuntos.
unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a -- (opcional)
unionMS  ms1 ms2 = let clavesMS1 = keys (elMap ms1)
                        in MS (unirlos (elMap ms1) clavesMS1 (elMap ms2))

elMap :: MultiSet a -> Map a Int
elMap (MS map) = map

unirlos :: Ord a => Map a Int -> [a] -> Map a Int -> Map a Int
-- Prop: dado un map, sus claves en una lista, y otro map. Une las ocurrencias de los elementos en cada map en uno solo
unirlos  _     []   map2 =  map2
unirlos map1 (c:cs) map2 = let ocurrs = fromJust (lookupM c map1) -- puedo usar fromJust xq es la lista de claves del map1
                                    in case lookupM c map2 of
                                            Just v  -> assocM c (v + ocurrs) (unirlos map1 cs map2)
                                            Nothing -> assocM c    ocurrs    (unirlos map1 cs map2)

fromJust :: Maybe v -> v
--Precondicion: unicamente toma valores Just
fromJust (Just x) = x


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Propósito: dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos
--multiconjuntos tienen en común.

intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a -- (opcional)
intersectionMS ms1 ms2 = let lasClavesMS1 = keys (elMap ms1)
                                in MS (interseccionM lasClavesMS1 (elMap ms1) (elMap ms2))


interseccionM :: Ord a => [a] -> Map a Int -> Map a Int -> Map a Int 
interseccionM   []   map1 map2 = emptyM
interseccionM (c:cs) map1 map2 = if existeClaveEn c map1 && existeClaveEn c map2
                                        then assocM c (fromJust (lookupM c map1) + fromJust (lookupM c map2)) (interseccionM cs map1 map2)
                                        --             NO SE SI VA LA SUMA O LA DIFERENCIA
                                        else interseccionM cs map1 map2


existeClaveEn :: Ord a => a -> Map a Int -> Bool
--Prop: dada una clave y un map, indica si existe una tupla con esa clave en el map dado
existeClaveEn c map = case lookupM c map of
                            Just v  -> True
                            Nothing -> False

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dado un multiconjunto devuelve una lista con todos los elementos del conjunto y
--su cantidad de ocurrencias.
multiSetToList :: Eq a => MultiSet a -> [(a, Int)]
multiSetToList (MS map) = mapToList (keys map) map


mapToList :: Eq a => [a] -> Map a Int -> [(a, Int)] 
mapToList   []   map = []
mapToList (k:ks) map = let valor = fromJust (lookupM k map)
                            in (k,valor) : mapToList ks map





ms1 :: MultiSet String
ms1 = MS m1

ms2 :: MultiSet String
ms2 = MS m2

m1 = assocM "a" 1 (assocM "b" 2 (assocM "c" 3 (assocM "d" 4 emptyM)))

m2 = assocM "a" 1 (assocM "f" 2 (assocM "c" 3 (assocM "h" 4 (assocM "i" 5 (assocM "j" 6 emptyM)))))


{-
addMS "e" ms1 ==> MS (M [("d",4),("c",3),("b",2),("a",1),("e",1)])
addMS "a" ms1 ==> MS (M [("d",4),("c",3),("b",2),("a",2)])

ocurrencesMS "a" ms1 ===> 1
ocurrencesMS "c" ms1 ===> 3

unionMS ms1 ms2 ==> MS (M [("d",4),("c",6),("b",2),("a",2),("f",2),("h",4),("i",5),("j",6)])


intersectionMS ms1 ms2 ==> MS (M [("c",6),("a",2)]) -- Tome como que tengo q sumar los valores de las claves q coinciden en ambos MS

multiSetToList ms1 ==> [("d",4),("c",3),("b",2),("a",1)]

-}
