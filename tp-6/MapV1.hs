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


--Propósito: devuelve un map vacío
emptyM :: Map k v
emptyM = M []

--Propósito: agrega una asociación clave-valor al map.
assocM :: Eq k => k -> v -> Map k v -> Map k v
assocM c vl (M kvs) = M (agregarALaLista c vl kvs)

agregarALaLista :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
--OBS: en caso de que ya exista una tupla con esa clave, la pisa con la nueva. En caso de que no exista la agrega 
-- al final
agregarALaLista c vl    []    = [(c, vl)]
agregarALaLista c vl (kv:kvs) = let (a, _) = kv
                                    in if c == a then (c,vl) : kvs
                                                 else kv : agregarALaLista c vl kvs

--Propósito: encuentra un valor dado una clave.
lookupM :: Eq k => k -> Map k v -> Maybe v
lookupM c (M kvs) = buscarValor c kvs

buscarValor :: Eq k => k -> [(k, v)] -> Maybe v
buscarValor _    []    = Nothing
buscarValor c (kv:kvs) = let (a, b) = kv
                            in if c==a then Just b
                                       else buscarValor c kvs


--Propósito: borra una asociación dada una clave.
deleteM :: Eq k => k -> Map k v -> Map k v
deleteM c (M kvs) = M (borrarDeLista c kvs)

borrarDeLista :: Eq k => k -> [(k, v)] -> [(k, v)]
borrarDeLista _    []    = []
borrarDeLista c (kv:kvs) = let (a, b) = kv
                                in if c==a then kvs
                                           else kv : (borrarDeLista c kvs)

--Propósito: devuelve las claves del map.
keys :: Map k v -> [k]
keys (M kvs) = lasClaves kvs

lasClaves :: [(k, v)] -> [k]
lasClaves [] = []
lasClaves (kv: kvs) = let (a, b) = kv
                          in a : lasClaves kvs

