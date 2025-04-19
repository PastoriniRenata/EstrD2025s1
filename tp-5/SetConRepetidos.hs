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
    deriving Show
 
    {- INV. REP. en S elem
       -- Para el usuario no tiene repetidos (internamente si los puede tener)
    -}

--Un Set es un tipo abstracto de datos que consta de las siguientes operaciones:


--Crea un conjunto vacío.
emptyS :: Set a
emptyS = S []

--Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS :: Eq a => a -> Set a -> Set a
addS x (S xs) = S (x:xs)  -- en esta version NO controlo si ya está en la lista, se encarga setToList de no darle repetidos al usuario

{-
    --> : es O(1)
    --> abrir estructura es O(1)

    --> addS es constante --> O(1)
-}

--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongs :: Eq a => a -> Set a -> Bool
belongs x (S xs) = elem x xs


{-
    --> elem tiene costo O(n), ya que realiza una operacion constante por cada elemento de la lista

    --> setToList tiene costo O(n^2), ya que realiza una operacion lineal por cada elemento de la lista del set

    --> belongs tiene costo O(n + n^2)   ??? ---- (n^2)  absorbe a  " + n "  ??? ----> O(n^2)
-}


--Devuelve la cantidad de elementos distintos de un conjunto.
sizeS :: Eq a => Set a -> Int
sizeS (S xs) = length (sinRepetidos xs)


{-
--> longitud tiene costo lineal O(m) donde m es la cantidad de elementos de la lista ingresada por parametro, ya que 
        hace una operacion constante por cada elemento de la lista

--> setToList O(n^2), donde n es la cantidad de elementos del set

--> sizeS tiene costo lineal + cuadratico --> 
-}



--Borra un elemento del conjunto. 
-- OBS mia: tengo que sacar todas las repeticiones del elemento
removeS :: Eq a => a -> Set a -> Set a
removeS x (S ls) = S (sacarTodasLasRepeticiones x ls)

sacarTodasLasRepeticiones :: Eq a => a -> [a] -> [a]
sacarTodasLasRepeticiones a []     = []
sacarTodasLasRepeticiones a (x:xs) = if a==x then sacarTodasLasRepeticiones a xs else x : (sacarTodasLasRepeticiones a xs)



--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionS :: Eq a => Set a -> Set a -> Set a
unionS (S xs) (S ys) = S (xs++ys)


--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList :: Eq a => Set a -> [a]
setToList (S ls) = sinRepetidos ls


sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) = if elem x xs then    sinRepetidos xs
                                   else x: sinRepetidos xs

{-
    --> elem tiene costo O(n), donde n es la cantidad de elementos de la lista pasada por parametro

    --> sinRepetidos hace una operacion lineal por cada elemento de la lista ingresada por parametro  --> tiene costo O(n^2)

    --> setToList --> O(n^2)
-}









