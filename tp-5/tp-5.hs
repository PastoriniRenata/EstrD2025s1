import SetSinRepetidos
--import SetConRepetidos
--import QueueV1
--import QueueV2
import QueueV3


{-
1. Cálculo de costos
Especificar el costo operacional de las siguientes funciones:
-}


head' :: [a] -> a -- O(1)
head' (x:xs) = x
{-
 -> + tiene costo O(1)
-}

sumar :: Int -> Int      -- O(1)
sumar x = x + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1

{-
 -> + tiene costo O(1)
-}


factorial :: Int -> Int  -- O(n) donde n es el numero ingresado por parametro, osea la cantidad de iteraciones 
factorial 0 = 1          -- que hace la funcion
factorial n = n * factorial (n-1)
{-
 -> * tiene costo O(1)

-> costo total  O(n) donde n es el numero ingresado por parametro. Se realiza una operacion constante por 
    cada iteraciones que hace la funcion
-}





longitud :: [a] -> Int 
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

{-
    -> + tiene costo O(1)
    -> longitud tiene costo O(n)  donde n es la cantidad de elementos que tiene la lista, osea su largo
-}

factoriales :: [Int] -> [Int] -- O(m * n)  donde m es el largo de la lista y n es el costo de usar la funcion factorial en cada iteración
factoriales []     = []
factoriales (x:xs) = factorial x : factoriales xs
{-
    -> : tiene costo O(1)
    -> factorial tiene costo O(n), donde n es el valor numerico más grande de la lista ingresada por parametro
    -> factoriales tiene costo O(m * n) donde m es el largo de la lista y n es el costo de usar la funcion factorial en cada iteración
-}

pertenece :: Eq a => a -> [a] -> Bool 
pertenece n []     = False
pertenece n (x:xs) = n == x || pertenece n xs

{-
    -> == costo O(1)
    -> || tiene costo O(1)
    -> pertenece tiene costo O(n), donde n es el alrgo de la lista 

-}

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos []     = []
sinRepetidos (x:xs) = if pertenece x xs
                                then sinRepetidos xs
                                else x : sinRepetidos xs

{-
    -> if tiene costo O(1)
    -> pertenece tiene costo O(n) donde n es el largo de la lista
    -> : costo o(1)

    -> la funcion sinRepetidos tiene n iterasiones con costo O(n) cada una de ellas al usar la funcion pertenece. 
        --> sinRepetidos tiene costo O(n^2)
-}


-- equivalente a (++)
append :: [a] -> [a] -> [a]
append [] ys = ys
append (x:xs) ys = x : append xs ys
{-
    -> : costo o(1)
    -> n iterasiones
    --> append tiene costo O(n), donde n es el largo de la priemra lista ingresada por parametro.
-}



concatenar :: [String] -> String
concatenar [] = []
concatenar (x:xs) = x ++ concatenar xs
{-
concatenar ["Hola, ", "como ", "estas?"]
"Hola, como estas?"

    -> ++ costo o(n), donde n es la cantidad de caractere de x (el string que esté agregando en esa iterasión)
    --> concatenar tiene costo O(n*m), donde n es el promedio de largo de los string que estan en la lista y 
                                       m es el largo de la lista ingresada por parametro

-}


takeN :: Int -> [a] -> [a]
takeN 0 xs = []
takeN n [] = []
takeN n (x:xs) = x : takeN (n-1) xs
{-
    -> : costo o(1)
    -> n la cantidad de elementos de la lista que se quieren "agarrar"
    --> takeN tiene costo O(n), ya que como mucho hace n iteraciones. Podrian ser menos si la lista ingresada por parametro 
                                tiene menos elementos que los que se quieren agarrar
-}

dropN :: Int -> [a] -> [a]
dropN 0 xs = xs
dropN n [] = []
dropN n (x:xs) = dropN (n-1) xs
{-
    -> n la cantidad de elementos de la lista que se quieren "tirar"
    --> dropN tiene costo O(n), ya que como mucho hace n iteraciones. Podrian ser menos si la lista ingresada por parametro 
                                tiene menos elementos que los que se quieren agarrar
-}

partir :: Int -> [a] -> ([a], [a])
partir n xs = (takeN n xs, dropN n xs)
{-
    -> dropN tiene costo O(n)
    -> takeN tiene costo O(n)
    --> partir  tiene costo O(n+n) --> O(2n)
-}

minimo :: Ord a => [a] -> a
minimo [x] = x
minimo (x:xs) = min x (minimo xs)
{-
    -> min tiene costo O(1)
    -> n el largo de la lista
    -> minimo tiene coto O(n), las n iterasiones que hace la funcion con costo O(1)
-}

sacar :: Eq a => a -> [a] -> [a]
sacar n [] = []
sacar n (x:xs) = if n == x
                       then xs
                       else x : sacar n xs
{-
    -> if costo O(1)
    -> == costo O(1)
    --> sacar tiene costo O(l), donde l es el largo de la lista.
-}

ordenar :: Ord a => [a] -> [a]
ordenar [] = []
orderar xs = let m = minimo xs
                in m : ordenar (sacar m xs)
{-
    -> let costo O(1)
    -> minimo cotos O(n)
    --> ordenar tiene costo O(m*n), donde m es el largo de la vista ingresada por parametro 
        y n el costo de usar la funcion minimo en cada iterasion
-}









--SET


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
sinRepetidosS :: Eq a => [a] -> [a]
sinRepetidosS xs = setToList (sinRepetidosAux xs)

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
        ---> sizeS (unirTodos tree_set )     --> 3
-}





--QUEUES
--(Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue)

q1 = enqueue 1 (enqueue 2 (enqueue 3 emptyQ))

q2 = enqueue 11 (enqueue 22 (enqueue 33 emptyQ))

--Cuenta la cantidad de elementos de la cola.
lengthQ :: Queue a -> Int
lengthQ q = if isEmptyQ q then 0
                          else 1 + lengthQ (dequeue q)


--Dada una cola devuelve la lista con los mismos elementos,
--donde el orden de la lista es el de la cola.
--Nota: chequear que los elementos queden en el orden correcto.
queueToList :: Queue a -> [a]
queueToList q = if isEmptyQ q then []
                              else firstQ q : queueToList (dequeue q)


--Inserta todos los elementos de la segunda cola en la primera.
unionQ :: Queue a -> Queue a -> Queue a
unionQ q1 q2 = if isEmptyQ q2 then q1
                              else unionQ (enqueue (firstQ q2) q1) (dequeue q2)














