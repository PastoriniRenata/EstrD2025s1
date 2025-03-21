-- 1. Defina las siguientes funciones polimórficas:
--Dado un elemento de algún tipo devuelve ese mismo elemento.
loMismo :: a -> a
loMismo x = x
--Dado un elemento de algún tipo devuelve el número 7.
siempreSiete :: a -> Int
siempreSiete _ = 7 
--Dadas una tupla, invierte sus componentes.
swap :: (a,b) -> (b, a)
swap (x, y) = (y, x)



