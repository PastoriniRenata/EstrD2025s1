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


--Propósito: devuelve un map vacío
emptyM :: Map k v
emptyM = M []

--Propósito: agrega una asociación clave-valor al map.
assocM :: Eq k => k -> v -> Map k v -> Map k v
assocM c vl (M ) =



--Propósito: encuentra un valor dado una clave.
lookupM :: Eq k => k -> Map k v -> Maybe v




--Propósito: borra una asociación dada una clave.
deleteM :: Eq k => k -> Map k v -> Map k v




--Propósito: devuelve las claves del map.
keys :: Map k v -> [k]




