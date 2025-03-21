--Defina las siguientes funciones utilizando recursión sobre números enteros, salvo que se indique
--lo contrario:


--Dado un número n se devuelve la multiplicación de este número y todos sus anteriores hasta
--llegar a 0. Si n es 0 devuelve 1. La función es parcial si n es negativo.
factorial :: Int -> Int
-- n tiene que ser un numero natural o 0
factorial 0 = 1
factorial n = n * factorial n-1

--Dado un número n devuelve una lista cuyos elementos sean los números comprendidos entre
--n y 1 (incluidos). Si el número es inferior a 1, devuelve la lista vacía.
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva n = if n<0 then [] else n : cuentaRegresiva (n-1)

--Dado un número n y un elemento e devuelve una lista en la que el elemento e repite n veces.
repetir :: Int -> a -> [a]
repetir 0 _ = []
repetir n x = x : repetir (n-1) x

--Dados un número n y una lista xs, devuelve una lista con los n primeros elementos de xs.
--Si la lista es vacía, devuelve una lista vacía.
losPrimeros :: Int -> [a] -> [a]
losPrimeros _   []   = []
losPrimeros 0   _    = []
losPrimeros n (x:xs) = x: losPrimeros (n-1) xs

--Dados un número n y una lista xs, devuelve una lista sin los primeros n elementos de lista
--recibida. Si n es cero, devuelve la lista completa.
sinLosPrimeros :: Int -> [a] -> [a]
sinLosPrimeros _   []   = []
sinLosPrimeros 0   xs   = xs
sinLosPrimeros n (x:xs) = sinLosPrimeros (n-1) xs