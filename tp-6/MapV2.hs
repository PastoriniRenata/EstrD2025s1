{-
La interfaz del tipo abstracto Map es la siguiente:


COMO ACEPTA REPETIDOS, lookup te garantiza que los valores se "pisen", dandote el par (clave,valor) más reciente,
ya que como agrego por adelante al map, se que el priemrop que encuentr, va a ser el más nuevo. Los otros van a ser basura,
haciendo que los costos de funciones como keys sean innecesariamente más costosos (por tener repetidas las claves 
innecesariamente)
-}

module MapV2
    (Map, emptyM, assocM, lookupM, deleteM, keys)
where

data Map k v = M [(k,v)]
    deriving Show


--Propósito: devuelve un map vacío
emptyM :: Map k v
emptyM = M []

--Propósito: agrega una asociación clave-valor al map.
assocM :: Eq k => k -> v -> Map k v -> Map k v
assocM c vl (M kvs) = M ((c,vl):kvs)



--Propósito: encuentra un valor dado una clave.
lookupM :: Eq k => k -> Map k v -> Maybe v
lookupM c (M kvs) = buscarValor c kvs

buscarValor :: Eq k => k -> [(k, v)] -> Maybe v
--OBS: para que se cumpla el objetivo de que Map te devuelve el valor mas reciente agregado a la estructur,
-- lookup va a buscar el primer valor que esté asociado a la clave pasada por aprametro y va a devolverlo
buscarValor _    []    = Nothing
buscarValor c (kv:kvs) = let (a,b) = kv
                            in if c==a then Just b
                                       else buscarValor c kvs


--Propósito: borra una asociación dada una clave.
deleteM :: Eq k => k -> Map k v -> Map k v
--OBS: Como admito repetidos, voy a tener que borrar TODAS LAS REPETICIONES del map
deleteM c (M kvs) = M (borrarTodasLasRep c kvs)


borrarTodasLasRep :: Eq k => k -> [(k, v)] -> [(k, v)]
borrarTodasLasRep c    []    = []
borrarTodasLasRep c (kv:kvs) = let (a, b) = kv
                                in if c==a then borrarTodasLasRep c kvs
                                           else kv : borrarTodasLasRep c kvs


--Propósito: devuelve las claves del map.
-- OBS: tengo que tomar las claves SIN repetidas
keys :: Eq k =>  Map k v -> [k]
keys (M kvs) = sinRepetidos (lasClaves kvs)


lasClaves :: [(k, v)] -> [k]
lasClaves [] = []
lasClaves (kv: kvs) = let (a, b) = kv
                          in a : lasClaves kvs

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = if elem x xs then    sinRepetidos xs
                                   else x: sinRepetidos xs


