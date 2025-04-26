{-
La interfaz del tipo abstracto Map es la siguiente:

1. Como una lista de pares-clave valor sin claves repetidas

OBS mía: Como no acepta claves repetida, me tengo que encargar de borrar la combinacion (clave, valor) en caso 
de que ya exista en el map. En caso de que no exista, la creo directamente
-}

module MapV1
    (Map, emptyM, assocM, lookupM, deleteM, keys)
where

data Map k v = M [(k,v)]
    deriving Show
    {-
        Invariante en (M clvs)
            donde clvs es una lista de tuplas asociadas clave-valor 
            -- las claves no se repiten
    -}


--Propósito: devuelve un map vacío
emptyM :: Map k v -- --> O(1)
emptyM = M []

--Propósito: agrega una asociación clave-valor al map.
assocM :: Eq k => k -> v -> Map k v -> Map k v -- tiene costo O(n), donde n es la cantidad de elementos en el map
assocM c vl (M kvs) = M (agregarALaLista c vl kvs)


agregarALaLista :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
--OBS: en caso de que ya exista una tupla con esa clave, la pisa con la nueva. En caso de que no exista la agrega 
-- al final
agregarALaLista c vl    []    = [(c, vl)]
agregarALaLista c vl (kv:kvs) = let (a, _) = kv
                                    in if c == a then (c,vl) : kvs -- por invariante, de estar la clave-valor, esta una unica vez
                                                 else kv : agregarALaLista c vl kvs

{-
    - n es la cantidad de elementos en el map

    agregarALaLista tiene costo O(n), ya que en el peor caso se hacen n llamados recursivos para poder agregar la tupla a la lista -->  assocM tiene costo O(n)
-}



--Propósito: encuentra un valor dado una clave.
lookupM :: Eq k => k -> Map k v -> Maybe v
lookupM c (M kvs) = buscarValor c kvs

buscarValor :: Eq k => k -> [(k, v)] -> Maybe v
buscarValor _    []    = Nothing
buscarValor c (kv:kvs) = let (a, b) = kv
                            in if c==a then Just b
                                       else buscarValor c kvs

{-
    - n es la cantidad de elementos en el map
    
    buscarValor tiene costo O(n), ya que en el peor caso se hacen n llamados recursivos para poder buscar el valor  --> lookupM tiene costo O(n)

-}



--Propósito: borra una asociación dada una clave.
deleteM :: Eq k => k -> Map k v -> Map k v
deleteM c (M kvs) = M (borrarDeLista c kvs)

borrarDeLista :: Eq k => k -> [(k, v)] -> [(k, v)]
borrarDeLista _    []    = []
borrarDeLista c (kv:kvs) = let (a, b) = kv
                                in if c==a then kvs
                                           else kv : (borrarDeLista c kvs)

{-
    - n es la cantidad de elementos en el map
    
    borrarDeLista tiene costo O(n), ya que en el peor caso se hacen n llamados recursivos para poder borrar la tupla de la lista --> deleteM tiene costo O(n)

-}



--Propósito: devuelve las claves del map.
keys :: Map k v -> [k]
keys (M kvs) = lasClaves kvs

lasClaves :: [(k, v)] -> [k]
lasClaves [] = []
lasClaves (kv: kvs) = let (a, b) = kv
                          in a : lasClaves kvs

{-
    - n es la cantidad de elementos en el map
    
    lasClaves tiene costo O(n), ya que en el peor caso se hacen n llamados recursivos para poder recopilar las claves de cada tupla --> keys tiene costo O(n)

-}