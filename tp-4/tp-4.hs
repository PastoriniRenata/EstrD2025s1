{-
1. Pizzas
Tenemos los siguientes tipos de datos:

-}

data Pizza = Prepizza
            | Capa Ingrediente Pizza
    deriving Show
data Ingrediente = Salsa
                   | Queso
                   | Jamon
                   | Aceitunas Int
    deriving Show

-- Definir las siguientes funciones:

-- EJEMPLOS
pizza1 = Capa Queso(Capa Jamon(Capa (Aceitunas 8)(Capa Queso(Capa Jamon(Capa Queso(Capa Queso(Capa Queso (Capa Jamon Prepizza))))))))
pizza2 = Capa Jamon Prepizza
pizza3 = Capa Queso(Capa Jamon Prepizza)

--Dada una pizza devuelve la cantidad de ingredientes
cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza       = 0
cantidadDeCapas (Capa ing piz) = 1 + cantidadDeCapas piz



--Dada una lista de ingredientes construye una pizza
armarPizza :: [Ingrediente] -> Pizza
armarPizza []     = Prepizza
armarPizza (i:is) = Capa i (armarPizza is)


--Le saca los ingredientes que sean jamón a la pizza
sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza         = Prepizza
sacarJamon (Capa Jamon piz) = sacarJamon piz
sacarJamon (Capa  ing  piz) = Capa ing (sacarJamon piz)



--Dice si una pizza tiene solamente salsa y queso (o sea, no tiene de otros ingredientes. En
--particular, la prepizza, al no tener ningún ingrediente, debería dar verdadero.)
tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso Prepizza = True
tieneSoloSalsaYQueso (Capa ing piz) = esQuesoOSalsa ing && tieneSoloSalsaYQueso piz

esQuesoOSalsa :: Ingrediente -> Bool
esQuesoOSalsa ing = esQueso ing || esSalsa ing

esQueso :: Ingrediente -> Bool
esQueso Queso = True
esQueso   _   = False

esSalsa :: Ingrediente -> Bool
esSalsa Salsa  = True
esSalsa   _    = False




--Recorre cada ingrediente y si es aceitunas duplica su cantidad
duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza         = Prepizza
duplicarAceitunas (Capa  ing  piz) = Capa (duplicarSiSonAceitunas ing) (duplicarAceitunas piz)


duplicarSiSonAceitunas :: Ingrediente -> Ingrediente
duplicarSiSonAceitunas (Aceitunas n ) = Aceitunas (n*2)
duplicarSiSonAceitunas      ing       = ing


--Dada una lista de pizzas devuelve un par donde la primera componente es la cantidad de
--ingredientes de la pizza, y la respectiva pizza como segunda componente.
cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
cantCapasPorPizza []     = []
cantCapasPorPizza (p:ps) = cantCapasPizza p : cantCapasPorPizza ps


cantCapasPizza :: Pizza -> (Int, Pizza)
cantCapasPizza pz = (cantidadDeCapas pz, pz)


--2. Mapa de tesoros (con bifurcaciones)
--Un mapa de tesoros es un árbol con bifurcaciones que terminan en cofres. Cada bifurcación y
--cada cofre tiene un objeto, que puede ser chatarra o un tesoro.
data Dir    = Izq | Der
        deriving Show
data Objeto = Tesoro | Chatarra
        deriving Show
data Cofre  = Cofre [Objeto]
        deriving Show
data Mapa   = Fin Cofre
              | Bifurcacion Cofre Mapa Mapa
        deriving Show


{-
hayTesoro mapa_1 --> True
hayTesoro mapa_2 --> False
hayTesoro mapa_3 --> True
hayTesoro mapa_4 --> True
hayTesoro mapa_5 --> False
-}
mapa_1 = (Bifurcacion (Cofre [Chatarra, Chatarra,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                      (Fin (Cofre [Chatarra, Tesoro])))      
                                                            (Fin (Cofre [Chatarra, Tesoro])))
{-
                                                Cofre [Chatarra, Chatarra,Chatarra]
                                                 /                             \
                                                /                               \
                            Cofre [Chatarra, Chatarra]                        Cofre [Chatarra, Tesoro]
                                     /             \                                   
                                    /               \                                  
                        Cofre [Chatarra]         Cofre [Chatarra, Tesoro] 

-} 

mapa_2 = (Bifurcacion (Cofre [Chatarra, Chatarra,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                      (Fin (Cofre [Chatarra])))      
                                                            (Fin (Cofre [Chatarra])))

{-NO TIENE TESOROS
                                                Cofre [Chatarra, Chatarra,Chatarra]
                                                 /                             \
                                                /                               \
                            Cofre [Chatarra, Chatarra]                        Cofre [Chatarra]
                                     /             \                                   
                                    /               \                                  
                        Cofre [Chatarra]         Cofre [Chatarra] 
-}

mapa_3 = (Bifurcacion (Cofre [Chatarra, Chatarra,Tesoro,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                             (Fin (Cofre [Chatarra, Tesoro])))      
                                                                   (Fin (Cofre [Chatarra, Tesoro])))

mapa_4 = (Fin (Cofre [Chatarra, Tesoro]))

mapa_5 = (Fin (Cofre []))


--Definir las siguientes operaciones:

--Indica si hay un tesoro en alguna parte del mapa.
hayTesoro :: Mapa -> Bool
hayTesoro (Fin c)               = hayTesoroAca (listaDelCofre c)
hayTesoro (Bifurcacion c m1 m2) = hayTesoroAca (listaDelCofre c) || hayTesoro m1 || hayTesoro m2


listaDelCofre :: Cofre -> [Objeto]
listaDelCofre (Cofre objs) = objs

hayTesoroAca :: [Objeto] -> Bool
hayTesoroAca []     = False
hayTesoroAca (x:xs) = case x of 
                        Tesoro   -> True
                        Chatarra -> hayTesoroAca xs
      


--Indica si al final del camino hay un tesoro. Nota: el final de un camino se representa con una
--lista vacía de direcciones.

hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn   ds   (Fin cofre) = esVacia ds && hayTesoroAca (listaDelCofre cofre) 
hayTesoroEn   []   map         =               hayTesoroAca (listaDelCofre (cofreDelMapa map))                      
hayTesoroEn (x:xs) map         = hayTesoroEn xs (siguienteMapaEnDireccion x map)  

cofreDelMapa :: Mapa -> Cofre
cofreDelMapa (Fin c)             = c
cofreDelMapa (Bifurcacion c _ _) = c

siguienteMapaEnDireccion :: Dir -> Mapa -> Mapa
siguienteMapaEnDireccion Izq (Bifurcacion _ map _ ) = map
siguienteMapaEnDireccion Der (Bifurcacion _  _ map) = map

esVacia :: [a] -> Bool
esVacia [] = True
esVacia  _ = False

mapa_6 = (Bifurcacion (Cofre [Chatarra, Chatarra,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                      (Fin (Cofre [Chatarra, Tesoro])))      
                                                            (Fin (Cofre [Chatarra, Chatarra])))
{-
                                        Bifurcacion Cofre [Chatarra, Chatarra,Chatarra]
                                                 /                             \
                                                /                               \
                         Bifurcacion Cofre [Chatarra, Chatarra]               Fin Cofre [Chatarra, Chatarra]
                                     /             \                                   
                                    /               \                                  
                     Fin Cofre [Chatarra]        Fin Cofre [Chatarra, Tesoro] 


caminoAlTesoro mapa_6 --> [Izq, Der]
-} 
mapa_7 = Bifurcacion (Cofre []) (Fin (Cofre [])) (Fin (Cofre []))


mapa_8 = (Bifurcacion (Cofre [Chatarra, Chatarra,Tesoro,Chatarra]) (Fin (Cofre [Chatarra, Tesoro]))
                                                                   (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                             (Fin (Cofre [Chatarra, Tesoro]))) )     
                                              

--Indica el camino al tesoro. 
--Precondición: existe un tesoro y es único.
caminoAlTesoro :: Mapa -> [Dir]
caminoAlTesoro (Fin cofre)               = [] --si está en la raíz, entonces no hay camino
caminoAlTesoro (Bifurcacion cofre m1 m2) = if hayTesoroEnCofreActual cofre then [] 
                                                                           else case siguienteMapaYDireccion m1 m2 of
                                                                                                (map, direcc) -> direcc : caminoAlTesoro map


                                                

hayTesoroEnCofreActual :: Cofre -> Bool
hayTesoroEnCofreActual (Cofre objs) = hayTesoroAca objs


siguienteMapaYDireccion :: Mapa -> Mapa -> (Mapa, Dir)
siguienteMapaYDireccion m1 m2 = if hayTesoro m1 then (m1, Izq) else (m2, Der)




--Indica el camino de la rama más larga.
-- caminoDeLaRamaMasLarga mapa_6 --> [Izq, Izq]
caminoDeLaRamaMasLarga :: Mapa -> [Dir]
caminoDeLaRamaMasLarga (Fin cofre)               = [] 
caminoDeLaRamaMasLarga (Bifurcacion cofre m1 m2) = case mapaYDireccionAlCaminoMasLargo m1 m2 of
                                                                        (map, direcc) -> direcc : caminoDeLaRamaMasLarga map


mapaYDireccionAlCaminoMasLargo :: Mapa -> Mapa -> (Mapa, Dir)
mapaYDireccionAlCaminoMasLargo m1 m2 = if largoCamino m1 < largoCamino m2 then (m2, Der)
                                                                          else (m1, Izq)

largoCamino :: Mapa -> Int
largoCamino (Fin _ )              = 1 
largoCamino (Bifurcacion _ m1 m2) = 1 + max (largoCamino m1) (largoCamino m2)



--Devuelve los tesoros separados por nivel en el árbol.

-- REHACERRRRRRR
tesorosPorNivel :: Mapa -> [[Objeto]]
tesorosPorNivel map  = filtrarChatarra (listPerLevelMap map)


filtrarChatarra :: [[Objeto]] -> [[Objeto]]
filtrarChatarra []       = []
filtrarChatarra (os:oss) = sacarChatarra os : filtrarChatarra oss

sacarChatarra :: [Objeto] -> [Objeto]
sacarChatarra []     = []
sacarChatarra (o:os) = if esTesoro o then  o : sacarChatarra os else sacarChatarra os


esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro    _   = False


levelNMap :: Int -> Mapa -> [Objeto]
levelNMap 0 mapa                  =  listaDelCofre (cofreActual mapa)
levelNMap n (Fin _ )              =  []
levelNMap n (Bifurcacion _ m1 m2) = levelNMap (n-1) m1 ++ levelNMap (n-1) m2


cofreActual :: Mapa -> Cofre
cofreActual (Fin c)             = c
cofreActual (Bifurcacion c _ _) = c

listPerLevelMap :: Mapa -> [[Objeto]]
listPerLevelMap map = listaPorNivelMap 0 (heightMap map -1) map  

listaPorNivelMap :: Int -> Int -> Mapa -> [[Objeto]]
listaPorNivelMap n x map = if n==x then [levelNMap n map] 
                                   else levelNMap n map : listaPorNivelMap (n+1) x map
    
heightMap :: Mapa -> Int
heightMap (Fin _ ) = 1
heightMap (Bifurcacion _ m1 m2) = 1 + max (heightMap m1) (heightMap m2)





--Devuelve todos lo caminos en el mapa.
todosLosCaminos :: Mapa -> [[Dir]]
todosLosCaminos (Fin _ )              = []
todosLosCaminos (Bifurcacion _ m1 m2) = [Izq] : agregarAlPrincipio Izq (todosLosCaminos m1) ++ [Der] : agregarAlPrincipio Der (todosLosCaminos m2)


agregarAlPrincipio :: a -> [[a]] -> [[a]]
agregarAlPrincipio _    []    = []
agregarAlPrincipio n (xs:xss) = (n:xs) : agregarAlPrincipio n xss

{-
mapa_1 = (Bifurcacion (Cofre [Chatarra, Chatarra,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                      (Fin (Cofre [Chatarra, Tesoro])))      
                                                            (Fin (Cofre [Chatarra, Tesoro])))

                                                Cofre [Chatarra, Chatarra,Chatarra]
                                                 /                             \
                                                /                               \
                            Cofre [Chatarra, Chatarra]                        Cofre [Chatarra, Tesoro]
                                     /             \                                   
                                    /               \                                  
                        Cofre [Chatarra]         Cofre [Chatarra, Tesoro] 
                        
todosLosCaminos mapa_1 --> [ [Izq], [Izq, Der], [Izq, Izq], [Der]]


mapa_2 = (Bifurcacion (Cofre [Chatarra, Chatarra,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                      (Fin (Cofre [Chatarra])))      
                                                            (Fin (Cofre [Chatarra])))

        NO TIENE TESOROS
                                                Cofre [Chatarra, Chatarra,Chatarra]
                                                 /                             \
                                                /                               \
                            Cofre [Chatarra, Chatarra]                        Cofre [Chatarra]
                                     /             \                                   
                                    /               \                                  
                        Cofre [Chatarra]         Cofre [Chatarra] 



todosLosCaminos mapa_2 --> [ [Izq], [Izq, Der], [Izq, Izq], [Der]]




mapa_3 = (Bifurcacion (Cofre [Chatarra, Chatarra,Tesoro,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                             (Fin (Cofre [Chatarra, Tesoro])))      
                                                                   (Fin (Cofre [Chatarra, Tesoro])))

                                           Cofre [Chatarra, Chatarra,Tesoro,Chatarra]
                                                 /                             \
                                                /                               \
                            Cofre [Chatarra, Chatarra]                        Cofre [Chatarra, Tesoro]
                                     /             \                                   
                                    /               \                                  
                        Cofre [Chatarra]         Cofre [Chatarra, Tesoro] 


todosLosCaminos mapa_3 --> []




mapa_4 = (Fin (Cofre [Chatarra, Tesoro]))

mapa_5 = (Fin (Cofre []))

mapa_6 = (Bifurcacion (Cofre [Chatarra, Chatarra,Chatarra]) (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                      (Fin (Cofre [Chatarra, Tesoro])))      
                                                            

                                        Bifurcacion Cofre [Chatarra, Chatarra,Chatarra]
                                                 /                             \
                                                /                               \
                         Bifurcacion Cofre [Chatarra, Chatarra]               Fin Cofre [Chatarra, Chatarra]
                                     /             \                                   
                                    /               \                                  
                     Fin Cofre [Chatarra]        Fin Cofre [Chatarra, Tesoro] 

mapa_7 = Bifurcacion (Cofre []) (Fin (Cofre [])) (Fin (Cofre []))

mapa_8 = (Bifurcacion (Cofre [Chatarra, Chatarra,Tesoro,Chatarra]) (Fin (Cofre [Chatarra, Tesoro]))
                                                                   (Bifurcacion (Cofre [Chatarra, Chatarra]) (Fin (Cofre [Chatarra]))
                                                                                                             (Fin (Cofre [Chatarra, Tesoro])))      

                                           Cofre [Chatarra, Chatarra,Tesoro,Chatarra]
                                                 /                             \
                                                /                               \
                              Cofre [Chatarra, Tesoro]                      Cofre [Chatarra, Chatarra]                        
                                                                              /             \                                   
                                                                             /               \                                  
                                                                 Cofre [Chatarra]         Cofre [Chatarra, Tesoro] 



todosLosCaminos mapa_8 --> [ [Izq], [Der, Der], [Der, Izq], [Der]]                                              
-}















--Nave Espacial
--modelaremos una Nave como un tipo algebraico, el cual nos permite construir una nave espacial,
--dividida en sectores, a los cuales podemos asignar tripulantes y componentes. La representación
--es la siguiente:
data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
data Barril = Comida | Oxigeno | Torpedo | Combustible
data Sector = S SectorId [Componente] [Tripulante]
type SectorId = String
type Tripulante = String
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
data Nave = N (Tree Sector)

--Implementar las siguientes funciones utilizando recursión estructural:

--Propósito: Devuelve todos los sectores de la nave.
sectores :: Nave -> [SectorId]
sectores (N sectores) = losSectores sectores

losSecrtores :: Tree Sector -> [SectorId]
losSectores EmptyT = []
losSectores (NodeT sect s1 s2) = sectorId sect : losSectores s1 ++ losSectores s2

sectorId :: Sector -> SectorId
sectorId (S id _ _) = id




--Propósito: Devuelve la suma de poder de propulsión de todos los motores de la nave. Nota:
--el poder de propulsión es el número que acompaña al constructor de motores.
poderDePropulsion :: Nave -> Int
poderDePropulsion (N sectores) 





{-
--Propósito: Devuelve todos los barriles de la nave.
barriles :: Nave -> [Barril]

--Propósito: Añade una lista de componentes a un sector de la nave.
--Nota: ese sector puede no existir, en cuyo caso no añade componentes.
agregarASector :: [Componente] -> SectorId -> Nave -> Nave

--Propósito: Incorpora un tripulante a una lista de sectores de la nave.
--Precondición: Todos los id de la lista existen en la nave.
asignarTripulanteA :: Tripulante -> [SectorId] -> Nave -> Nave

--Propósito: Devuelve los sectores en donde aparece un tripulante dado.
sectoresAsignados :: Tripulante -> Nave -> [SectorId]

--Propósito: Devuelve la lista de tripulantes, sin elementos repetidos.
tripulantes :: Nave -> [Tripulante]



{- 4. Manada de lobos
Modelaremos una manada de lobos, como un tipo Manada, que es un simple registro compuesto
de una estructura llamada Lobo, que representa una jerarquía entre estos animales.
Los diferentes casos de lobos que forman la jerarquía son los siguientes:
Los cazadores poseen nombre, una lista de especies de presas cazadas y 3 lobos a cargo.
Los exploradores poseen nombre, una lista de nombres de territorio explorado (nombres de
bosques, ríos, etc.), y poseen 2 lobos a cargo.
Las crías poseen sólo un nombre y no poseen lobos a cargo.
La estructura es la siguiente:
-}

type Presa      = String -- nombre de presa
type Territorio = String -- nombre de territorio
type Nombre     = String -- nombre de lobo
data Lobo       = Cazador Nombre [Presa] Lobo Lobo Lobo
                | Explorador Nombre [Territorio] Lobo Lobo
                | Cría Nombre
data Manada = M Lobo

--1. Construir un valor de tipo Manada que posea 1 cazador, 2 exploradores y que el resto sean
--crías. Resolver las siguientes funciones utilizando recursión estructural sobre la estructura
--que corresponda en cada caso:


--Propósito: dada una manada, indica si la cantidad de alimento cazado es mayor a la cantidad de crías.
buenaCaza :: Manada -> Bool


--Propósito: dada una manada, devuelve el nombre del lobo con más presas cazadas, junto
--con su cantidad de presas. Nota: se considera que los exploradores y crías tienen cero presas
--cazadas, y que podrían formar parte del resultado si es que no existen cazadores con más de
--cero presas.
elAlfa :: Manada -> (Nombre, Int)


--Propósito: dado un territorio y una manada, devuelve los nombres de los exploradores que
--pasaron por dicho territorio.
losQueExploraron :: Territorio -> Manada -> [Nombre]


--Propósito: dada una manada, denota la lista de los pares cuyo primer elemento es un territorio y cuyo segundo elemento es la lista de los nombres de los exploradores que exploraron
--dicho territorio. Los territorios no deben repetirse.
exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]


--Propósito: dado el nombre de un lobo y una manada, indica el nombre de todos los cazadores que tienen como subordinado al lobo dado (puede ser un subordinado directo, o el
--subordinado de un subordinado).
--Precondición: hay un lobo con dicho nombre y es único.
--Suponiendo la siguiente manada de ejemplo:
cazadoresSuperioresDe :: Nombre -> Manada -> [Nombre]



manadaEj =
        Cazador "DienteFiloso" ["Búfalos", "Antílopes"]
        (Cría "Hopito")
        (Explorador "Incansable" ["Oeste hasta el río"]
        (Cría "MechónGris")
        (Cría "Rabito")
        )
        (Cazador "Garras" ["Antílopes", "Ciervos"]
        (Explorador "Zarpado" ["Bosque este"]
        (Cría "Osado")
        (Cazador "Mandíbulas" ["Cerdos", "Pavos"]
        (Cría "Desgreñado")
        (Cría "Malcriado")
        (Cazador "TrituraHuesos" ["Conejos"]
        (Cría "Peludo")
        (Cría "Largo")
        (Cría "Menudo")
        )
        )
        )
        (Cría "Garrita")
        (Cría "Manchas")
        )
la función cazadoresSuperioresDe debería dar lo siguiente:
cazadoresSuperioresDe "Mandíbulas" manadaEj = ["DienteFiloso", "Garras"]
cazadoresSuperioresDe "Rabito" manadaEj = ["DienteFiloso"]
cazadoresSuperioresDe "DienteFiloso" manadaEj = []
cazadoresSuperioresDe "Peludo" manadaEj =
["DienteFiloso", "Garras", "Mandíbulas", "TrituraHuesos"]


-}