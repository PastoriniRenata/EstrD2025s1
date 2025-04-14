{-
3. Implementar la variante del tipo abstracto Set que posee una lista y admite repetidos. En
otras palabras, al agregar no va a chequear que si el elemento ya se encuentra en la lista, pero
sí debe comportarse como Set ante el usuario (quitando los elementos repetidos al pedirlos,
por ejemplo). Contrastar la eficiencia obtenida en esta implementación con la anterior.

-}



module SetConRepetidos
    (Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList)
where

data Set a = S [a] 
    --deriving Show
 
    {- INV. REP. en S elem
       ???
    -}

--Un Set es un tipo abstracto de datos que consta de las siguientes operaciones:


--Crea un conjunto vacío.
emptyS :: Set a
emptyS = S []

--Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS :: Eq a => a -> Set a -> Set a
addS x (S xs) = S (x:xs)  -- No controla si ya está en la lista


--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongs :: Eq a => a -> Set a -> Bool
belongs x st = pertenece x (setToList st)


pertenece :: Eq a => a -> [a] -> Bool 
pertenece n []     = False
pertenece n (x:xs) = n == x || pertenece n xs


--Devuelve la cantidad de elementos distintos de un conjunto.
sizeS :: Eq a => Set a -> Int
sizeS (S xs) = longitudSinRepetidos xs

longitudSinRepetidos ::  Eq a => [a] -> Int
longitudSinRepetidos []     = 0
longitudSinRepetidos (x:xs) = if pertenece x xs -- osea está repetido   
                                    then longitudSinRepetidos xs
                                    else 1 + longitudSinRepetidos xs 



--Borra un elemento del conjunto. 
-- OBS mia: tengo que sacar todas las repeticiones del elemento
removeS :: Eq a => a -> Set a -> Set a
removeS x (S ls) = S (sacarTodasLasRepeticiones x ls)

sacarTodasLasRepeticiones :: Eq a => a -> [a] -> [a]
sacarTodasLasRepeticiones a []     = []
sacarTodasLasRepeticiones a (x:xs) = if a==x then sacarTodasLasRepeticiones a xs else x : (sacarTodasLasRepeticiones a xs)



--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionS :: Eq a => Set a -> Set a -> Set a
unionS set1 set2 = unirS (setToList set1) set2

unirS ::  Eq a => [a] -> Set a -> Set a
unirS xs (S ls) = S (xs++ls)

--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList :: Eq a => Set a -> [a]
setToList (S ls) = sinRepetidos ls


sinRepetidos :: Eq a => [a] -> [a]











