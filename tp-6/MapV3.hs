{-
La interfaz del tipo abstracto Map es la siguiente:



-}

module MapV3
    (Map, emptyM, assocM, lookupM, deleteM, keys)
where
{-
Implementar el TAD Map como dos listas, una de claves y otra de valores, donde la clave ubicada en la posición i está
asociada al valor en la misma posición, pero de la otra lista.


Mi desicion: permite repetidos en las listas
-}
data Map k v = M [k] [v]
    {-
        Inv de Rep
        -- Ambas listas deben tener la misma canitdad de elementos
        -- No hay claves repetidas??
    -}
    deriving Show


--Propósito: devuelve un map vacío
emptyM :: Map k v
emptyM = M [] []

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: agrega una asociación clave-valor al map.
assocM :: Eq k => k -> v -> Map k v -> Map k v
assocM c vl (M cs vs) = M (c:cs) (vl:vs)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: encuentra un valor dado una clave.
lookupM :: Eq k => k -> Map k v -> Maybe v
lookupM c (M cs vs) = buscarValor c cs vs
    
buscarValor :: Eq k => k -> [k] -> [v] ->  Maybe v
--OBS: para que se cumpla el objetivo de que Map te devuelve el valor mas reciente agregado a la estructur,
-- lookup va a buscar el primer valor que esté asociado a la clave pasada por aprametro y va a devolverlo
buscarValor _    []       _   = Nothing -- si la 1ra está vacia la 2da tambn
buscarValor c (cl:cls) (vl:vls)  =  if c == cl then Just vl
                                               else buscarValor c cls vls

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Propósito: borra una asociación dada una clave.
deleteM :: Eq k => k -> Map k v -> Map k v
--OBS: Como admito repetidos, voy a tener que borrar TODAS LAS REPETICIONES del map
deleteM c (M ks vs) = M (borrarClave c ks) (borrarValor c ks vs) 


borrarValor :: Eq k => k -> [k] -> [v] -> [v]
-- Poposito: dada una clave, una lista de claves y una lista de valores, elimina el valor asociado a la clave
borrarValor _    []        _     = [] -- si una es vacía, la otra tambien
borrarValor c (cl:cls) (vl:vls)  = if c==cl then borrarValor c cls vls
                                            else vl : (borrarValor c cls vls)


borrarClave :: Eq k => k -> [k] -> [k]
-- Poposito: dada una clave y una lista de claves, elimina la clave
borrarClave _    []    = []
borrarClave c (cl:cls) = if c==cl then borrarClave c cls
                                  else cl : (borrarClave c cls)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: devuelve las claves del map.
-- OBS: tengo que tomar las claves SIN repetidas
keys :: Eq k =>  Map k v -> [k]
keys (M ks vs) = sinRepetidos ks

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = if elem x xs then    sinRepetidos xs
                                   else x: sinRepetidos xs


