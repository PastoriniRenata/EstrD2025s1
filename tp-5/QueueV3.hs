{-
5. Queue con dos listas
Implemente la interfaz de Queue pero en lugar de una lista utilice dos listas. Esto permitirá
que todas las operaciones sean constantes (aunque alguna/s de forma amortizada).
La estructura funciona de la siguiente manera. Llamemos a una de las listas fs (front stack) y
a la otra bs (back stack). Quitaremos elementos a través de fs y agregaremos a través de bs, pero
todas las operaciones deben garantizar el siguiente invariante de representación: Si fs se encuentra
vacía, entonces la cola se encuentra vacía.
-}

module QueueV3
    (Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue)
where

data Queue a = Q [a] [a]
    deriving Show
    {-
    --> invariante de representación: Si fs se encuentra vacía, entonces la cola se encuentra vacía.
    -}



{-
    Llamemos a una de las listas fs (front stack) y a la otra bs (back stack). 
    Quitaremos elementos a través de fs y agregaremos a través de bs
-}

--Crea una cola vacía.
emptyQ :: Queue a
emptyQ = Q [] []

--Dada una cola indica si la cola está vacía.
isEmptyQ :: Queue a -> Bool
isEmptyQ (Q [] _) = True
isEmptyQ    _     = False


--Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue :: a -> Queue a -> Queue a
--Si fs está vacía, entonces bs tambn
enqueue x (Q [] bs)  = Q [x] bs -- bs = []
enqueue x (Q fs bs)  = Q fs (bs ++ [x])


--Dada una cola devuelve el primer elemento de la cola. 
firstQ :: Queue a -> a
firstQ (Q [] _ )  = error "No hay elementos en la lista"
firstQ (Q fs bs)  = head fs



--Dada una cola la devuelve sin su primer elemento.
dequeue :: Queue a -> Queue a
dequeue (Q  [] _ ) = error "Lista cola vacía"
dequeue (Q [x] ys) = Q ys []         --cuando la fs queda vacía, bs pasa a ser fs y la bs queda vacía
dequeue (Q  xs ys) = Q (tail xs) ys  -- si xs tiene más de un elemento, simplemente se le saca el primer elemento















