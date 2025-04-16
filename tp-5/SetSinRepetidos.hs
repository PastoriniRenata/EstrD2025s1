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


--Crea un conjunto vacío. --> Costo constante --> O(1)
emptyS :: Set a
emptyS = S [] 0

--Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS :: Eq a => a -> Set a -> Set a
addS x set = if elem x (setToList set) then set
                                       else agregarAlSet x set

agregarAlSet :: a -> Set a -> Set a
agregarAlSet x (S xs n) = S (x:xs) (n+1)

{-
    --> elem tiene costo lineal --> O(n), donde n es la cantidad de elementos del set

    addS tiene costo lineal --> O(n)

-}


--Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongs :: Eq a => a -> Set a -> Bool
belongs x st = elem x (setToList st)

{-
    --> setToList tiene costo constante --> O(1), ya que unicamenete abre la estructura del set para devolver la lista
    --> elem tiene costo linel --> O(n), donde n es la cantidad de elementos de la lista del set

    --> belongs tiene costo lineal --> O(n), donde n es la cantidad de elementos del set
-}


--Devuelve la cantidad de elementos distintos de un conjunto.
sizeS :: Eq a => Set a -> Int -- --> tiene costo constante, ya que solo se abre la estructura --> O(1)
sizeS (S _ n) = n



--Borra un elemento del conjunto. 
removeS :: Eq a => a -> Set a -> Set a
removeS x (S ls n) = if elem x ls then S (sacar x ls) (n-1)
                                  else S ls n

sacar :: Eq a => a -> [a] -> [a]
sacar a []     = []
sacar a (x:xs) = if a==x then xs else x: (sacar a xs)

{-
    --> sacar tiene costo lineal --> O(n), donde n es la cantidad de elementos de la lista pasada por parametro

    --> removeS tiene costo lineal --> O(n), ya que abrir la estructura y usar un if tiene costo constante y donde
                                             n es la cantidad de elementos de la lista del set 

-}

--Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionS :: Eq a => Set a -> Set a -> Set a
unionS set1 set2 = unirS (setToList set1) set2
{-
    --
-}

unirS ::  Eq a => [a] -> Set a -> Set a
unirS []     set = set
unirS (x:xs) set = addS x (unirS xs set)

--Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList :: Eq a => Set a -> [a]
setToList (S ls _) = ls











