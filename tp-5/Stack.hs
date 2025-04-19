{-
Una Stack es un tipo abstracto de datos de naturaleza LIFO (last in, first out). Esto significa
que los últimos elementos agregados a la estructura son los primeros en salir (como en una pila de
platos). Su interfaz es la siguiente:
-}
module Stack
    (Stack, emptyS, isEmptyS, push, top, pop, lenS )
where


-- 2. Implementar el tipo abstracto Stack utilizando una lista.

data Stack a = St [a] Int
    deriving Show
    {-
    Inv. representacion
        - El ultimo elemento en ingresar es el ultimo en salir
        - n la cantidad de elementos de la pila
    -}

--Crea una pila vacía.
emptyS :: Stack a
emptyS = St [] 0

--Dada una pila indica si está vacía.
isEmptyS :: Stack a -> Bool
isEmptyS (St [] _) = True
isEmptyS    _    = False


--Dados un elemento y una pila, agrega el elemento a la pila.
push :: a -> Stack a -> Stack a
push x (St xs n) = St (x:xs) (n+1)


--Dada un pila devuelve el elemento del tope de la pila.
top :: Stack a -> a
top (St [] _) = error "La pila está vacía"
top (St xs _)  = let (y:ys) = xs
                 in y

--Dada una pila devuelve la pila sin el primer elemento.
pop :: Stack a -> Stack a
pop (St [] _) = error "La pila está vacía"
pop (St xs n)  = let (y:ys) = xs
                     in (St ys (n-1))

--Dada la cantidad de elementos en la pila.
--Costo: constante.
lenS :: Stack a -> Int
lenS (St xs n) = n
