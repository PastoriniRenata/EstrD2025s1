{-
1. Defina las siguientes funciones polimórficas utilizando pattern matching sobre listas (no
utilizar las funciones que ya vienen con Haskell):
-}

--Dada una lista de elementos, si es vacía devuelve True, sino devuelve False.
--Definida en Haskell como null
estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia xs = False

--Dada una lista devuelve su primer elemento.
--Definida en Haskell como head.
--Nota: tener en cuenta que el constructor de listas es :
elPrimero :: [a] -> a
-- Precondicion: la lista NO debe ser vacía
elPrimero (x:xs) = x 

--Dada una lista devuelve esa lista menos el primer elemento.
--Definida en Haskell como tail.
--Nota: tener en cuenta que el constructor de listas es :
sinElPrimero :: [a] -> [a]
sinElPrimero [] = []
sinElPrimero (x:xs) = xs

--Dada una lista devuelve un par, donde la primera componente es el primer elemento de la
--lista, y la segunda componente es esa lista pero sin el primero.
--Nota: tener en cuenta que el constructor de listas es :
splitHead :: [a] -> (a, [a])
-- Precondicion: la lista NO debe ser vacía
splitHead (x:xs) = (x, xs)