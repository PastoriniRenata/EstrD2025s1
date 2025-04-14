
--import SetSinRepetidos
import SetConRepetidos

-- 2. Como usuario del tipo abstracto Set implementar las siguientes funciones:
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
        deriving Show
--Dados una lista y un conjunto, devuelve una lista con todos los elementos que pertenecen
--al conjunto.
losQuePertenecen :: Eq a => [a] -> Set a -> [a]
losQuePertenecen   []    _  = []
losQuePertenecen (x:xs) set = if belongs x set then x : (losQuePertenecen xs set)
                                               else losQuePertenecen xs set

set_Vacio = emptyS                      -- --> S []      0
set_1 = addS 1 emptyS                   -- --> S [1]     1       
set_2 = addS 2 (addS 1 emptyS)          -- --> S [1,2]   2      
set_3 = addS 3 (addS 2 (addS 1 emptyS)) -- --> S [1,2,3] 3   

{-
losQuePertenecen [1,2,3,4,5,6] set_Vacio --> []               
losQuePertenecen [1,2,3,4,5,6] set_1     --> [1]                       
losQuePertenecen [1,2,3,4,5,6] set_2     --> [1,2]                       
losQuePertenecen [1,2,3,4,5,6] set_3     --> [1,2,3]                       
-}



--Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos xs = setToList (sinRepetidosAux xs)

sinRepetidosAux :: Eq a => [a] -> Set a
sinRepetidosAux   []   = emptyS
sinRepetidosAux (x:xs) = addS x (sinRepetidosAux xs)

{-
sinRepetidos [1,2,3,4,5,6] --> [1,2,3,4,5,6]               
sinRepetidos [1,1,2,2,3,3] --> [1,2,3]                       
sinRepetidos [1,1,1,1,1,1] --> [1]                       
sinRepetidos [1,2,3,1,2,3] --> [1,2,3]                       
-}




--Dado un arbol de conjuntos devuelve un conjunto con la union de todos los conjuntos
--del arbol.
unirTodos :: Eq a => Tree (Set a) -> Set a
unirTodos EmptyT            = emptyS
unirTodos (NodeT set t1 t2) = unionS set (unionS (unirTodos t1) (unirTodos t2))

tree_set :: Tree (Set Int)
tree_set = NodeT set_1 (NodeT set_Vacio (EmptyT) 
                                         (NodeT set_2 (EmptyT)
                                                      (NodeT set_3 EmptyT 
                                                                   EmptyT))) 
                        (EmptyT)






{-
unirTodos tree_set --> S [1,2,3] 3
        ---> setToList (unirTodos tree_set ) --> [1,2,3]
        ---> sizeS (unirTodos tree_set )     --> [1,2,3]
-}