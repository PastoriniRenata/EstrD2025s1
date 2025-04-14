{-
1. Implementar la variante del tipo abstracto Set con una lista que no tiene repetidos y guarda
la cantidad de elementos en la estructura.
Nota: la restricción Eq aparece en toda la interfaz se utilice o no en todas las operaciones
de esta implementación, pero para mantener una interfaz común entre distintas posibles
implementaciones estamos obligados a escribir así los tipos.
-}
module SetSinRepetidos
    (Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList)
where

data Set a = S [a] Int
    --deriving Show
 
    {- INV. REP. en S elem n
        * La lista de elementos elem no tiene elementos repetidos
        * n es la cantidad de elementos en la lista elem
    -}

--Un Set es un tipo abstracto de datos que consta de las siguientes operaciones:


--Crea un conjunto vacío.
emptyS :: Set a
emptyS = S [] 0

--Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS :: Eq a => a -> Set a -> Set a
addS x set = if pertenece x (setToList set) then set
                                              else agregarAlSet x set


pertenece :: Eq a => a -> [a] -> Bool 
pertenece n []     = False
pertenece n (x:xs) = n == x || pertenece n xs

agregarAlSet :: a -> Set a -> Set a
agregarAlSet x (S xs n) = S (x:xs) (n+1)


--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongs :: Eq a => a -> Set a -> Bool
belongs x st = pertenece x (setToList st)

--Devuelve la cantidad de elementos distintos de un conjunto.
sizeS :: Eq a => Set a -> Int
sizeS (S _ n) = n

--Borra un elemento del conjunto. 
removeS :: Eq a => a -> Set a -> Set a
removeS x (S ls n) = if pertenece x ls then S (sacar x ls) (n-1)
                                       else S ls n

sacar :: Eq a => a -> [a] -> [a]
sacar a []     = []
sacar a (x:xs) = if a==x then xs else x: (sacar a xs)

--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionS :: Eq a => Set a -> Set a -> Set a
unionS set1 set2 = unirS (setToList set1) set2

unirS ::  Eq a => [a] -> Set a -> Set a
unirS []     set = set
unirS (x:xs) set = addS x (unirS xs set)

--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList :: Eq a => Set a -> [a]
setToList (S ls _) = ls











