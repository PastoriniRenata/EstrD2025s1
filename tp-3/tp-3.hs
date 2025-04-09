{-
1.1. Celdas con bolitas
Representaremos una celda con bolitas de colores rojas y azules, de la siguiente manera:
-}
data Color = Azul | Rojo
    deriving Show
data Celda = Bolita Color Celda | CeldaVacia
    deriving Show

{-
En dicha representación, la cantidad de apariciones de un determinado color denota la cantidad
de bolitas de ese color en la celda. Por ejemplo, una celda con 2 bolitas azules y 2 rojas, podría
ser la siguiente:
Bolita Rojo (Bolita Azul (Bolita Rojo (Bolita Azul CeldaVacia)))
Implementar las siguientes funciones sobre celdas:
-}
celda1 = Bolita Rojo (Bolita Azul (Bolita Rojo (Bolita Azul (Bolita Azul CeldaVacia))))

--Dados un color y una celda, indica la cantidad de bolitas de ese color. Nota: pensar si ya existe una operación sobre 
-- listas que ayude a resolver el problema.
nroBolitas :: Color -> Celda -> Int
nroBolitas   _     CeldaVacia       = 0
nroBolitas col1 (Bolita col2 celda) = uniSiEsMismoColor col1 col2 + nroBolitas col1 celda

uniSiEsMismoColor :: Color -> Color -> Int
uniSiEsMismoColor col1 col2 = boolANro (esMismoColor col1 col2)

esMismoColor :: Color -> Color -> Bool
esMismoColor Azul Azul = True
esMismoColor Rojo Rojo = True
esMismoColor  _    _   = False

boolANro :: Bool -> Int
boolANro True  = 1
boolANro False = 0

--Dado un color y una celda, agrega una bolita de dicho color a la celda.
poner :: Color -> Celda -> Celda
poner c celda = Bolita c celda

--Dado un color y una celda, quita una bolita de dicho color de la celda. Nota: a diferencia de Gobstones, esta función es total.
sacar :: Color -> Celda -> Celda
sacar col     CeldaVacia        = CeldaVacia
sacar col1 (Bolita col2 celda ) = if esMismoColor col1 col2 then celda else (Bolita col2 (sacar col1 celda) )

--Dado un número n, un color c, y una celda, agrega n bolitas de color c a la celda.
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0  _  celda      = celda
ponerN n col CeldaVacia = ponerN (n-1) col (Bolita col CeldaVacia)
ponerN n col celda      = ponerN (n-1) col (Bolita col celda)



{-
1.2. Camino hacia el tesoro
Tenemos los siguientes tipos de datos
-}
data Objeto = Cacharro | Tesoro
    deriving Show
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino
    deriving Show

camino_1 = Cofre [Cacharro ,Cacharro] (Cofre [Cacharro] (Nada (Cofre [] (Nada (Cofre [Cacharro,Cacharro,Cacharro, Tesoro] Fin)))))
camino_2 = Cofre [Cacharro ,Cacharro] (Cofre [Cacharro] (Nada (Cofre [] (Nada (Cofre [Cacharro,Cacharro,Cacharro] Fin)))))
camino_3 = Cofre [Cacharro ,Cacharro] (Cofre [Cacharro] (Nada (Cofre [Tesoro] (Nada (Cofre [Cacharro,Cacharro,Cacharro] Fin)))))

--Definir las siguientes funciones:
--Indica si hay un cofre con un tesoro en el camino.
hayTesoro :: Camino -> Bool
hayTesoro Fin               = False
hayTesoro (Cofre objs camino) = hayTesoroEnLista objs || hayTesoro camino
hayTesoro (Nada  camino     ) = hayTesoro camino

hayTesoroEnLista :: [Objeto] -> Bool
hayTesoroEnLista []     = False
hayTesoroEnLista (o:os) = esTesoro o || hayTesoroEnLista os

esTesoro :: Objeto -> Bool
esTesoro Cacharro = False
esTesoro Tesoro   = True



--Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
--Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
pasosHastaTesoro :: Camino -> Int
--Precondición: tiene que haber al menos un tesoro.
pasosHastaTesoro Fin               =  0
pasosHastaTesoro (Cofre objs camino) = if hayTesoroEnLista objs then 0 else 1 + pasosHastaTesoro camino
pasosHastaTesoro (Nada  camino     ) = 1 + pasosHastaTesoro camino



--Indica si hay un tesoro en una cierta cantidad exacta de pasos. Por ejemplo, si el número de
--pasos es 5, indica si hay un tesoro en 5 pasos.
hayTesoroEn :: Int -> Camino -> Bool
hayTesoroEn 0 camino              = hayTesoroAca camino
hayTesoroEn n Fin                 = False
hayTesoroEn n (Cofre objs camino) = hayTesoroEn (n-1) camino
hayTesoroEn n (Nada  camino )     = hayTesoroEn (n-1) camino


hayTesoroAca :: Camino -> Bool
hayTesoroAca (Cofre objs camino)  = hayTesoroEnLista objs
hayTesoroAca        _  = False




--Indica si hay al menos "n" tesoros en el camino.
alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros n camino = n <= cantTesorosEnCamino camino

cantTesorosEnCamino :: Camino -> Int
cantTesorosEnCamino Fin               = 0
cantTesorosEnCamino (Cofre objs camino) = cantTesorosEnLista objs + cantTesorosEnCamino camino
cantTesorosEnCamino (Nada  camino     ) = cantTesorosEnCamino camino

cantTesorosEnLista :: [Objeto] -> Int
cantTesorosEnLista [] = 0
cantTesorosEnLista (o:os) = unoSiEsTesoro o + cantTesorosEnLista os

unoSiEsTesoro :: Objeto -> Int
unoSiEsTesoro Cacharro = 0
unoSiEsTesoro Tesoro   = 1

--Dado un rango de pasos, indica la cantidad de tesoros que hay en ese rango. Por ejemplo, si
--el rango es 3 y 5, indica la cantidad de tesoros que hay entre hacer 3 pasos y hacer 5. Están
--incluidos tanto 3 como 5 en el resultado.

camino_4 = Cofre [Cacharro ,Cacharro, Tesoro] 
                (Cofre [Cacharro] 
                    (Nada 
                        (Cofre [Tesoro,Tesoro] 
                            (Nada 
                                (Cofre [Cacharro,Cacharro,Cacharro,Tesoro] 
                                    Fin)))))

{- cantTesorosEnLista 3 5 camino_4 

camino_4 = 
          paso 0: Cofre [Cacharro ,Cacharro, Tesoro] 
          paso 1    (Cofre [Cacharro] 
          paso 2        (Nada 
-Desde -> paso 3           (Cofre [Tesoro,Tesoro] 
          paso 4                (Nada 
-Hasta -> paso 5                    (Cofre [Cacharro,Cacharro,Cacharro,Tesoro] 
          paso 6                        Fin)))))


cantTesorosEntre 3 5 camino_4 --> 3

--> hay 3 cofres

-}


cantTesorosEntre :: Int -> Int -> Camino -> Int
cantTesorosEntre 0 n camino              = tesorosHastaPaso n camino
cantTesorosEntre x y Fin                 = 0
cantTesorosEntre x y (Cofre objs camino) = cantTesorosEntre (x-1) (y-1) camino
cantTesorosEntre x y (Nada  camino     ) = cantTesorosEntre (x-1) (y-1) camino

tesorosHastaPaso :: Int -> Camino -> Int
tesorosHastaPaso 0 camino              = cantTesorosEnPasoActual camino
tesorosHastaPaso n Fin                 = 0
tesorosHastaPaso n (Cofre objs camino) = cantTesorosEnLista objs + tesorosHastaPaso (n-1) camino
tesorosHastaPaso n (Nada  camino     ) = tesorosHastaPaso (n-1) camino

cantTesorosEnPasoActual :: Camino -> Int
cantTesorosEnPasoActual (Cofre objs camino) = cantTesorosEnLista objs
cantTesorosEnPasoActual       _             = 0





--2. Tipos arbóreos
--2.1. Árboles binarios
--Dada esta definición para árboles binarios
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show
--defina las siguientes funciones utilizando recursión estructural según corresponda:
tree_1 :: Tree Int
tree_2 :: Tree Int
tree_3 :: Tree Int
tree_4 :: Tree String
tree_5 :: Tree String
tree_6 :: Tree Int
tree_7 :: Tree Int

tree_1 = NodeT 1 (NodeT 2  (NodeT 3 (EmptyT) 
                                      (NodeT 4 (EmptyT) 
                                                (NodeT 5 (NodeT 6 (EmptyT) 
                                                                    (EmptyT)) 
                                                          (EmptyT)))) 
                            (EmptyT)) 
                  (NodeT 7  (EmptyT)
                            (EmptyT))

tree_2 = EmptyT
tree_3 = NodeT 10 (NodeT 10 (EmptyT) (EmptyT)) (EmptyT)
tree_4 = NodeT "hola" (NodeT "chau" (EmptyT) (EmptyT)) (EmptyT)
tree_5 = NodeT "Hola" (NodeT "Mundo" EmptyT EmptyT) (NodeT "Hola" EmptyT EmptyT)
tree_6 = NodeT 10 (EmptyT)(EmptyT)


tree_7 = NodeT 1 (NodeT 2  (NodeT 3 (EmptyT) 
                                      (NodeT 4 (EmptyT) 
                                                (NodeT 5 (NodeT 6 (EmptyT) 
                                                                    (EmptyT)) 
                                                          (EmptyT)))) 
                           (EmptyT)) 
                  (NodeT 7  (NodeT 8 (EmptyT) 
                                     (NodeT 9 (EmptyT) 
                                              (NodeT 10 (NodeT 11 (EmptyT) 
                                                                  (NodeT 12 (NodeT 13 EmptyT EmptyT)
                                                                            (EmptyT))) 
                                                        (EmptyT))))
                            (EmptyT))

arbol_1_prueba = (NodeT 1 (NodeT 2 (NodeT 3 (NodeT 4 (EmptyT)
                                                     (EmptyT))
                                            (NodeT 4 (EmptyT)
                                                     (EmptyT)))
                                   (NodeT 3 (NodeT 4 (EmptyT)
                                                     (EmptyT))
                                            (NodeT 4 (NodeT 5 (EmptyT)
                                                              (EmptyT))
                                                     (EmptyT))))
                          (NodeT 2 (NodeT 3 (NodeT 4 (EmptyT)
                                                     (EmptyT))
                                            (NodeT 4 (EmptyT)
                                                     (EmptyT)))
                                   (NodeT 3 (NodeT 4 (NodeT 5 (EmptyT)
                                                              (EmptyT))
                                                     (EmptyT))
                                            (NodeT 4 (NodeT 5 (EmptyT)
                                                              (EmptyT))
                                                     (EmptyT)))))

--Dado un árbol binario de enteros devuelve la suma entre sus elementos.
sumarT :: Tree Int -> Int
sumarT EmptyT          = 0
sumarT (NodeT n t1 t2) = n + sumarT t1 + sumarT t2



--Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size
--en inglés).
sizeT :: Tree a -> Int
sizeT EmptyT          = 0
sizeT (NodeT n t1 t2) = 1 + sizeT t1 + sizeT t2



--Dado un árbol de enteros devuelve un árbol con el doble de cada número.
mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT          = EmptyT
mapDobleT (NodeT n t1 t2) = NodeT (n*2) (mapDobleT t1) (mapDobleT t2)



--Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el
--árbol.
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT _ EmptyT          = False
perteneceT x (NodeT n t1 t2) = (x==n) || perteneceT n t1 || perteneceT n t2



--Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son
--iguales a e.
aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT _ EmptyT          = 0
aparicionesT x (NodeT n t1 t2) = unoSiEsMismoElemento x n + aparicionesT x t1 + aparicionesT x t2

unoSiEsMismoElemento :: Eq a => a -> a -> Int
unoSiEsMismoElemento x y = if x==y then 1 else 0

--Dado un árbol devuelve los elementos que se encuentran en sus hojas.
--NOTA: en este tipo se define como hoja a un nodo con dos hijos vacíos.
{-
leaves :: Tree a -> [a]
leaves EmptyT          = []
leaves (NodeT n t1 t2) = if esVacio t1 && esVacio t2 then [n]
                                                     else leaves t1 ++ leaves t2
-}
esVacio :: Tree a -> Bool
esVacio EmptyT = True
esVacio   _    = False




leaves :: Tree a -> [a]
leaves EmptyT          = []
leaves t = case t of
                (NodeT x EmptyT EmptyT) -> [x]
                (NodeT x t1 t2)         -> leaves t1 ++ leaves t2
    

{-
LEAVES EN CLASE

leaves :: Tree a -> [a]
leaves EmptyY           = ...
leaves t  = case t of 
                NodeT x EmptyT EmptyT -> [x]
                NodeT x t1 t2         -> leaves t1 ++ leaves t2


-}

tree_gonza = NodeT 1 (NodeT 2 (NodeT 4 (EmptyT)
                                       (NodeT 8 (EmptyT)
                                                (EmptyT)))
                              (NodeT 5 (EmptyT)
                                       (EmptyT))) 
                     (NodeT 3 (NodeT 6 (NodeT 9 (EmptyT)
                                                (NodeT 11 (NodeT 12 (NodeT 13 EmptyT 
                                                                              EmptyT)
                                                                    (EmptyT))
                                                          (EmptyT)))
                                       (EmptyT))
                              (NodeT 7 (EmptyT)
                                       (NodeT 10 (EmptyT)
                                                 (EmptyT))))






--Dado un árbol devuelve su altura.
--Nota: la altura de un árbol (height en inglés), también llamada profundidad, es
--la cantidad de niveles del árbol1
-- La altura para EmptyT es 0, y para una hoja es 1.
heightT :: Tree a -> Int
heightT EmptyT          = 0
heightT (NodeT n t1 t2) = 1 + max (heightT t1) (heightT t2)

--Dado un árbol devuelve el árbol resultante de intercambiar el hijo izquierdo con
--el derecho, en cada nodo del árbol.
mirrorT :: Tree a -> Tree a
mirrorT EmptyT          = EmptyT
mirrorT (NodeT n t1 t2) = NodeT n (mirrorT t2) (mirrorT t1)

--Dado un árbol devuelve una lista que representa el resultado de recorrerlo en
--modo in-order.
--Nota: En el modo in-order primero se procesan los elementos del hijo izquierdo,
--luego la raiz y luego los elementos del hijo derecho.
toList :: Tree a -> [a]
toList EmptyT          = [] 
toList (NodeT n t1 t2) = n : (toList t1) ++ (toList t2)

--Dados un número n y un árbol devuelve una lista con los nodos de nivel n. El
--nivel de un nodo es la distancia que hay de la raíz hasta él. La distancia de la
--raiz a sí misma es 0, y la distancia de la raiz a uno de sus hijos es 1.
--Nota: El primer nivel de un árbol (su raíz) es 0.
levelN :: Int -> Tree a -> [a]
levelN _ EmptyT          = []
levelN 0 (NodeT x t1 t2) = [x]
levelN n (NodeT x t1 t2) = levelN (n-1) t1 ++ levelN (n-1) t2


--Dado un árbol devuelve una lista de listas en la que cada elemento representa
--un nivel de dicho árbol.
listPerLevel :: Tree a -> [[a]]
listPerLevel tr = listaPorNivel 0 (heightT tr -1) tr  -- el -1 es para que no me ponga una lista vacía por el ultimo nivel q es todo EmptyT

listaPorNivel :: Int -> Int -> Tree a -> [[a]]
listaPorNivel n x tr = if n==x then [levelN n tr] 
                               else levelN n tr : listaPorNivel (n+1) x tr
    


--Devuelve los elementos de la rama más larga del árbol
ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT          = []
ramaMasLarga (NodeT n t1 t2) = n : ramaMasLarga (elArbolMasLargo t1 t2)

elArbolMasLargo :: Tree a -> Tree a -> Tree a
elArbolMasLargo t1 t2 = if heightT t1 < heightT t2 then t2 else t1



--Dado un árbol devuelve todos los caminos, es decir, los caminos desde la raíz
--hasta cualquiera de los nodos.
--ATENCIÓN: se trata de todos los caminos, y no solamente de los maximales (o
--sea, de la raíz hasta la hoja), o sea, por ejemplo
--todosLosCaminos (NodeT 1 (NodeT 2 (NodeT 3 EmptyT 
--                                           EmptyT)
--                                   EmptyT)
--                          (NodeT 4 (NodeT 5 EmptyT 
--                                            EmptyT)
--                                    EmptyT))
--    = [ [1], [1,2], [1,2,3], [1,4], [1,4,5] ]
-- OBSERVACIÓN: puede resultar interesante plantear otra función, variación de ésta para devolver solamente los caminos maximales.
treePractica :: Tree Int
treePractica = NodeT 1 (NodeT 2 (NodeT 3 EmptyT EmptyT) EmptyT) (NodeT 4 (NodeT 5 EmptyT EmptyT) EmptyT)

todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT          = []
todosLosCaminos (NodeT n t1 t2) = [n] : agregarAlPrincipio n (todosLosCaminos t1) ++ agregarAlPrincipio n (todosLosCaminos t2)


--Dada una lista de listas de elementos de tipo a, agrega al principio de cada lista otro elemento de tipo a

agregarAlPrincipio :: a -> [[a]] -> [[a]]
agregarAlPrincipio _    []    = []
agregarAlPrincipio n (xs:xss) = (n:xs) : agregarAlPrincipio n xss



-- 2.2. Expresiones Aritméticas
-- El tipo algebraico ExpA modela expresiones aritméticas de la siguiente manera:
data ExpA = Valor Int
            | Sum ExpA ExpA
            | Prod ExpA ExpA
            | Neg ExpA
    deriving Show

-- Implementar las siguientes funciones utilizando el esquema de recursión estructural sobre Exp:
-- Dada una expresión aritmética devuelve el resultado evaluarla.
eval :: ExpA -> Int
eval (Valor n )        = n 
eval (Sum   exp1 exp2) = eval exp1 + eval exp2
eval (Prod  exp1 exp2) = eval exp1 * eval exp2
eval (Neg   exp1)      = - eval exp1

nro1 = Valor 1
nro2 = Valor 2
nro3 = Sum nro1 nro2   -- 1 + 2 = 3
nro4 = Prod nro2 nro3  -- 2 * 3 = 6
nro5 = Neg nro4        -- = -6 

-- Dada una expresión aritmética, la simplifica según los siguientes criterios (descritos utilizando
-- notación matemática convencional):
-- a) 0 + x = x + 0 = x
-- b) 0 * x = x * 0 = 0
-- c) 1 * x = x * 1 = x
-- d) - (- x) = x


nro6  = Neg nro5 -- = 6
nro7  = Neg nro6 -- = -6
nro8  = Prod nro4 nro7 -- 6 * -6 = -36
nro9  = Sum nro8 nro4 -- -36 + 6 = -30
nro10 = Sum nro9 (Neg nro8) -- -30 + -(-36) = -30 + 36 = 6

nro11 = Valor 1                     -- >  1              ---- simplificar --->                                     --rta--> Valor 1                      
nro12 = Valor 0                     -- >  0              ---- simplificar --->                                     --rta--> Valor 0             
nro13 = Sum nro11 nro12             -- >  1              ---- simplificar ---> nro11 + nro12 = 1 + 0 = 1 = nro11   --rta--> Valor 1  
nro14 = Prod nro12 nro13            -- >  0              ---- simplificar ---> Prod nro12 nro13 = 0 * 1            --rta--> Valor 0               
nro15 = Sum nro13 nro14             -- >  1              ---- simplificar ---> Sum nro13 nro14 = 1 + 0 = nro13     --rta--> Valor 1
nro16 = Neg (Neg nro15)             -- > -(-1) = 1       ---- simplificar ---> Neg(Neg nro15)                      --rta--> Valor 1


nro17 = Valor 2                        -- >  2              ---- simplificar --rta--> Valor 2                      
nro18 = Valor 3                        -- >  3              ---- simplificar --rta--> Valor 3             
nro19 = Sum nro17 nro18                -- >  5              ---- simplificar --rta--> Sum (Valor 2) (Valor 3)
nro20 = Prod nro18 nro19               -- >  15             ---- simplificar --rta--> Prod (Valor 3) (Sum (Valor 2) (Valor 3))         
nro21 = Sum nro19 nro20                -- >  20             ---- simplificar --rta--> Sum (Sum (Valor 2) (Valor 3)) (Prod (Valor 3) (Sum (Valor 2) (Valor 3)))
nro22 = Neg (Neg nro21)                -- > -(-20) = 20     ---- simplificar --rta--> Sum    (Sum (Valor 2) (Valor 3))     (Prod (Valor 3) (Sum (Valor 2) (Valor 3)))
nro23 = Neg (Neg (Neg (Valor 2)))      -- > - (-(-2)) = -2 ---- simplificar --rta--> Neg (Valor 2)
nro24 = Neg (Prod (Neg nro18) nro19 )  -- >  -(- 15) = 15   ---- simplificar --rta--> Neg (Prod (Neg (Valor 3)) (Sum (Valor 2) (Valor 3))) ???      
nro25 = Sum (Sum (Valor 2) (Valor 3))  (Prod (Valor 0) (Sum (Valor 2) (Valor 3))) -- >  = 5      ---- simplificar --rta--> Sum (Valor 2) (Valor 3))
                                                                    



simplificar :: ExpA -> ExpA
simplificar (Valor n)         = Valor n
simplificar (Sum exp1 exp2)   = simplificarSuma (simplificar exp1) (simplificar exp2)
simplificar (Prod exp1 exp2)  = simplificarProducto (simplificar exp1) (simplificar exp2)
simplificar (Neg exp)         = simplificarNegacion (simplificar exp)

simplificarSuma :: ExpA -> ExpA -> ExpA
simplificarSuma (Valor 0) exp2 = exp2
simplificarSuma exp1 (Valor 0) = exp1
simplificarSuma exp1 exp2      = Sum exp1 exp2

simplificarProducto :: ExpA -> ExpA -> ExpA
simplificarProducto (Valor 0) _    = Valor 0
simplificarProducto _ (Valor 0)    = Valor 0
simplificarProducto (Valor 1) exp2 = exp2
simplificarProducto exp1 (Valor 1) = exp1
simplificarProducto exp1 exp2      = Prod exp1 exp2

simplificarNegacion :: ExpA -> ExpA
simplificarNegacion (Valor x) = Valor (-x)
simplificarNegacion (Neg exp) = exp













