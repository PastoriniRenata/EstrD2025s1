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
disyuncion (x:xs) = oBien x (disyuncion xs)

oBien :: Bool -> Bool -> Bool
oBien True  _    = True
oBien False  b   = b

--Dada una lista de listas, devuelve una única lista con todos sus elementos.
aplanar :: [[a]] -> [a]
aplanar []       = []
aplanar (xs:xss) = unirListas xs (aplanar xss)

unirListas :: [a] -> [a] -> [a]
-- voy a recorrer la 1ra lista
unirListas   []    ys = ys
unirListas (x:xs)  ys = x : unirListas xs ys

--Dados un elemento e y una lista xs devuelve True si existe un elemento en xs que sea igual a e.
pertenece :: Eq a => a -> [a] -> Bool
pertenece _ []     = False
pertenece e (x:xs) = oBien (e==x) (pertenece e xs)

--Dados un elemento e y una lista xs cuenta la cantidad de apariciones de e en xs.
apariciones :: Eq a => a -> [a] -> Int
apariciones _ []     = 0
apariciones e (x:xs) = unoSiSonIguales e x + apariciones e xs


unoSiSonIguales :: Eq a => a -> a -> Int
unoSiSonIguales x y = if x==y then 1 else 0

--Dados un número n y una lista xs, devuelve todos los elementos de xs que son menores a n.
losMenoresA :: Int -> [Int] -> [Int]
losMenoresA _ []     = []
losMenoresA n (x:xs) = if n<x then x : losMenoresA n xs else losMenoresA n xs

--Dados un número n y una lista de listas, devuelve la lista de aquellas listas que tienen más
--de n elementos.
lasDeLongitudMayorA :: Int -> [[a]] -> [[a]]
lasDeLongitudMayorA _ []       = []
lasDeLongitudMayorA n (xs:xss) = if tieneMasDeNElementos n xs then xs:lasDeLongitudMayorA n xss else lasDeLongitudMayorA n xss


tieneMasDeNElementos :: Int -> [a] -> Bool
tieneMasDeNElementos n xs = n < longitud xs

--Dados una lista y un elemento, devuelve una lista con ese elemento agregado al final de la
--lista.
agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal  []  x    = [x]
agregarAlFinal (y:ys) x = y : agregarAlFinal ys x

--Dadas dos listas devuelve la lista con todos los elementos de la primera lista y todos los
--elementos de la segunda a continuación. Definida en Haskell como (++).
agregar :: [a] -> [a] -> [a]
agregar []     ys = ys
agregar (x:xs) ys = x : agregar xs ys

--Dada una lista devuelve la lista con los mismos elementos de atrás para adelante. Definida
--en Haskell como reverse.
reversa :: [a] -> [a]
reversa []     = []
reversa (x:xs) = agregarAlFinal (reversa xs) x 

--Dadas dos listas de enteros, devuelve una lista donde el elemento en la posición n es el
--máximo entre el elemento n de la primera lista y de la segunda lista, teniendo en cuenta que
--las listas no necesariamente tienen la misma longitud.
zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] ys         = ys
zipMaximos xs []         = xs
zipMaximos (x:xs) (y:ys) = if x>y then x : zipMaximos xs ys else y : zipMaximos xs ys


--Dada una lista devuelve el mínimo
elMinimo :: Ord a => [a] -> a
-- obs: la lista NO puede ser vacía
elMinimo [x]    = x
elMinimo (x:xs) = min x (elMinimo xs)