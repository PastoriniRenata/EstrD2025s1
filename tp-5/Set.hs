import Interfaz

-- 2. Como usuario del tipo abstracto Set implementar las siguientes funciones:
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
        deriving Show
--Dados una lista y un conjunto, devuelve una lista con todos los elementos que pertenecen
--al conjunto.
losQuePertenecen :: Eq a => [a] -> Set a -> [a]
losQuePertenecen   []    _  = []
losQuePertenecen (x:xs) set = if belongs x set then x : (losQuePertenecen x set)
                                               else losQuePertenecen x set


--Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos   []   = emptyS
sinRepetidos (x:xs) = addS x (sinRepetidos xs)

--Dado un arbol de conjuntos devuelve un conjunto con la union de todos los conjuntos
--del arbol.
unirTodos :: Eq a => Tree (Set a) -> Set a
unirTodos EmptyT            = emptyS
unirTodos (NodeT set t1 t2) = unionS set (unionS (unirTodos t1) (unirTodos t2))
