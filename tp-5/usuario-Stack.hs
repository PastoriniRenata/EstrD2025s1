import Stack

-- STACK
st1 :: Stack Int
st1 = push 4 (push 3 (push 2 (push 1 (push 0 emptyS))))

--Dada una lista devuelve una pila sin alterar el orden de los elementos.
apilar :: [a] -> Stack a
apilar []     = emptyS
apilar (x:xs) = push x (apilar xs)

--  apilar [1,2,3,4,5,6] >> resultado >> S [1,2,3,4,5,6] 6

--Dada una pila devuelve una lista sin alterar el orden de los elementos.
desapilar :: Stack a -> [a]
desapilar st = if isEmptyS st then []
                              else (top st) : (desapilar (pop st))

-- desapilar st1 >> resultado >> [4,3,2,1,0]


--Dada una posicion válida en la stack y un elemento, ubica dicho elemento en dicha
--posición (se desapilan elementos hasta dicha posición y se inserta en ese lugar).
insertarEnPos :: Int -> a -> Stack a -> Stack a
insertarEnPos 0 x st = push x st
insertarEnPos n x st = push (top st) (insertarEnPos (n-1) x (pop st))

-- insertarEnPos 0 5 st1 >> resultado >> S [5,4,3,2,1,0] 6
-- insertarEnPos 5 5 st1 >> resultado >> S [4,3,2,1,0,5] 6


