
-- Dado un número devuelve su sucesor
sucesor :: Int -> Int
sucesor x = x + 1
--Dados dos números devuelve su suma utilizando la operación +.
sumar :: Int -> Int -> Int
sumar x y = x + y

{-Dado dos números, devuelve un par donde la primera componente es la división del
primero por el segundo, y la segunda componente es el resto de dicha división. Nota:
para obtener el resto de la división utilizar la función mod :: Int -> Int -> Int,
provista por Haskell.
-}
divisionYResto :: Int -> Int -> (Int, Int)
divisionYResto x y = ( div x y , mod x y)


--Dado un par de números devuelve el mayor de estos
maxDelPar :: (Int,Int) -> Int
maxDelPar (x, y) = if x>y then x else y




