{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import Distribution.Simple.Utils (xargs)
{-# HLINT ignore "Use foldr" #-}
{-# HLINT ignore "Use map" #-}
{-Defina las siguientes funciones utilizando recursión estructural sobre listas, salvo que se indique
lo contrario:
-}

--Dada una lista de enteros devuelve la suma de todos sus elementos.
sumatoria :: [Int] -> Int
sumatoria []     = 0
sumatoria (x:xs) = x + sumatoria xs

--Dada una lista de elementos de algún tipo devuelve el largo de esa lista, es decir, la cantidad
--de elementos que posee.
longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

--Dada una lista de enteros, devuelve la lista de los sucesores de cada entero.
sucesores :: [Int] -> [Int]
sucesores []     = []
sucesores (x:xs) =  x+1 : sucesores xs

--Dada una lista de booleanos devuelve True si todos sus elementos son True.
conjuncion :: [Bool] -> Bool
conjuncion []      = True
conjuncion (x:xs)  = yTambien x (conjuncion xs)

yTambien :: Bool-> Bool-> Bool
yTambien True x = x
yTambien False _ = False

--Dada una lista de booleanos devuelve True si alguno de sus elementos es True.
disyuncion :: [Bool] -> Bool
disyuncion []     = False
disyuncion (x:xs) = oBien x (disyucion xs)

oBien :: Bool -> Bool -> Bool
oBien True  _    = True
oBien False  b   = b

--Dada una lista de listas, devuelve una única lista con todos sus elementos.
aplanar :: [[a]] -> [a]
aplanar []       = []
aplanar (xs:xss) = unirListas xs (aplanar xss)

unirListas :: [a] -> [a] -> [a]
-- voy a recorrer la 1ra lista
unirListas   []    ys = xs
unirListas (x:xs)  ys = x : unirListas xs ys

--Dados un elemento e y una lista xs devuelve True si existe un elemento en xs que sea igual a e.
pertenece :: Eq a => a -> [a] -> Bool
pertenece 
pertenece 

--Dados un elemento e y una lista xs cuenta la cantidad de apariciones de e en xs.
apariciones :: Eq a => a -> [a] -> Int

--Dados un número n y una lista xs, devuelve todos los elementos de xs que son menores a n.
losMenoresA :: Int -> [Int] -> [Int]
