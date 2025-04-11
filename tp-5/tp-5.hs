{-
1. Cálculo de costos
Especificar el costo operacional de las siguientes funciones:
-}


head' :: [a] -> a -- O(1)
head' (x:xs) = x


sumar :: Int -> Int      -- O(1)
sumar x = x + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1


factorial :: Int -> Int  -- O(n) donde n es el numero ingresado por parametro, y la cantidad de iteraciones 
                         -- que hace la funcion para 
factorial 0 = 1
factorial n = n * factorial (n-1)


longitud :: [a] -> Int -- O(n)
longitud []     = 0
longitud (x:xs) = 1 + longitud xs


factoriales :: [Int] -> [Int] -- O(m * n)  donde m es el largo de la lista y n es el costo de factorial
factoriales []     = []
factoriales (x:xs) = factorial x : factoriales xs


pertenece :: Eq a => a -> [a] -> Bool
pertenece n []     = False
pertenece n (x:xs) = n == x || pertenece n xs


sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos []     = []
sinRepetidos (x:xs) = if pertenece x xs
                                then sinRepetidos xs
                                else x : sinRepetidos xs

