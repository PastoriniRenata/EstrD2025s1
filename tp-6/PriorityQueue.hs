
module PriorityQueue
    (PriorityQueue, emptyPQ, isEmptyPQ, insertPQ, findMinPQ, deleteMinPQ)
where

{-
Ejercicio 1
La siguiente interfaz representa colas de prioridad, llamadas priority queue, en inglés. La misma
posee operaciones para insertar elementos, y obtener y borrar el mínimo elemento de la estructura.
Implementarla usando listas, e indicando el costo de cada operación.
-}

data PriorityQueue a = Pq [a]
    deriving Show
{-
    Inv de representacion
    - La lista de elementos está ordenada según la prioridad de menor a mayor de los elementos



OBS: los elementos de tipo a saben de que manera ordenarse. Por ejemplo los nro (1,2,3,4,...), alfabeticamente (a,b,c,d,...), si fuera una cola de hospital, etc.
-}
--Propósito: devuelve una priority queue vacía.
emptyPQ :: PriorityQueue a -- O(1)
emptyPQ = Pq []

--Propósito: indica si la priority queue está vacía.
isEmptyPQ :: PriorityQueue a -> Bool -- O(1)
isEmptyPQ (Pq xs) = null xs

--Propósito: inserta un elemento en la priority queue.
insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a
insertPQ x (Pq xs) = Pq (insertarConPrioridad x xs) -- O(n)

insertarConPrioridad :: Ord a => a -> [a] -> [a]
insertarConPrioridad x   []   = [x]
insertarConPrioridad x (y:ys) = if x<y then x:y:ys
                             else y: (insertarConPrioridad x ys)


--Propósito: devuelve el elemento más prioriotario (el mínimo) de la priority queue.
--Precondición: parcial en caso de priority queue vacía. --> La priority que no está vacía
findMinPQ :: Ord a => PriorityQueue a -> a -- O(1)
findMinPQ (Pq xs) = head xs

--Propósito: devuelve una priority queue sin el elemento más prioritario (el mínimo).
--Precondición: parcial en caso de priority queue vacía.  --> La priority que no está vacía
deleteMinPQ :: Ord a => PriorityQueue a -> PriorityQueue a --O(1)
deleteMinPQ (Pq xs) = Pq (tail xs)








