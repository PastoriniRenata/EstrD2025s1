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
duplicarAceitunas pizza = Capa (duplicarSiSonAceitunas ing) (duplicarAceitunas piz)


pizzaMile = Capa Salsa (Capa Queso (Capa Jamon (Capa (Aceitunas 8) Prepizza)))

duplicarSiSonAceitunas :: Ingrediente -> Ingrediente
duplicarSiSonAceitunas (Aceitunas n) = Aceitunas (n*2)
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


{-
tesorosPorNivel mapa_1 --> [[],[Tesoro],[Tesoro]]
tesorosPorNivel mapa_2 --> [[],[],[]]
tesorosPorNivel mapa_6 --> [[],[],[Tesoro]]
-}


--Devuelve todos lo caminos en el mapa.
todosLosCaminos :: Mapa -> [[Dir]]
todosLosCaminos (Fin _ )              = []
todosLosCaminos (Bifurcacion _ m1 m2) = [Izq] : agregarAlPrincipio Izq (todosLosCaminos m1) ++ [Der] : agregarAlPrincipio Der (todosLosCaminos m2)
                                        

agregarAlPrincipio :: a -> [[a]] -> [[a]]
agregarAlPrincipio _    []    = []
agregarAlPrincipio n (xs:xss) = (n:xs) : agregarAlPrincipio n xss




mapa_Mile :: Mapa
mapa_Mile =
  Bifurcacion
    (Cofre [Tesoro])
    (Fin (Cofre [Chatarra]))
    ( Bifurcacion
        (Cofre [Tesoro])
        (Fin (Cofre [Chatarra]))
        ( Bifurcacion
            (Cofre [Tesoro])
            (Fin (Cofre [Chatarra]))
            ( Bifurcacion
                (Cofre [Tesoro])
                (Fin (Cofre [Chatarra]))
                (Fin (Cofre [Tesoro]))
            )
        )
    )

{-
               BifurcaciOn                                                                                                                      
               /         \                                                                                                              
           Fin           BifurcaciOn                              ----> [Izq] [Der]                                                                                                                       
         [Chatarra]        /       \                                                                                                                                                                                                                              
                        Fin     BifurcaciOn                       ---->          [Der, Izq] [Der, Der]                                                                                                                                                                                              
                    [Chatarra]    /        \                                                                                              
                               Fin       BifurcaciOn              ---->                [Der, Der, Izq] [Der, Der, Der]                                                                                                                                                                                             
                           [Chatarra]      /        \                                                                                             
                                        Fin         Fin           ---->                         [Der, Der, Der, Izq]  [Der, Der, Der, Der]                                                                                                         
                                    [Chatarra]    [Tesoro]                      


todosLosCaminos mapa_Mile
-}


mapa_Mile2:: Mapa
mapa_Mile2 =
  Bifurcacion
    (Cofre [])
    (Fin (Cofre []))
    ( Bifurcacion
        (Cofre [])
        (Fin (Cofre []))
        ( Bifurcacion
            (Cofre [])
            ( Bifurcacion
                (Cofre [])
                ( Bifurcacion
                    (Cofre [])
                    (Fin (Cofre []))
                    ( Bifurcacion
                        (Cofre [])
                        ( Bifurcacion
                            (Cofre [])
                            ( Bifurcacion
                                (Cofre [])
                                (Fin (Cofre [Tesoro]))
                                (Fin (Cofre []))
                            )
                            (Fin (Cofre []))
                        )
                        (Fin (Cofre []))
                    )
                )
                (Fin (Cofre []))
            )
            (Fin (Cofre []))
        )
    )

{- Mapa6

                b
              /   \
            f       b
                  /   \
                f       b
                      /   \
                    b       f
                   / \
                 b     b
                / \   / \
              f    b  f   f
                  / \
              f[T]   f

caminoDeLaRamaMasLarga [Der, Der, Izq, Izq, Der, Izq, Izq]
-}



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
        deriving Show
data Barril = Comida | Oxigeno | Torpedo | Combustible
        deriving Show
data Sector = S SectorId [Componente] [Tripulante]
        deriving Show

type SectorId = String
type Tripulante = String

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
        deriving Show
data Nave = N (Tree Sector)
        deriving Show




nave_1 = N ( NodeT (S "A" [LanzaTorpedos, (Motor 10)] ["Rena", "Gonza"])  (NodeT  (S "B" [LanzaTorpedos, (Motor 20)] ["Azu", "Mile"]) EmptyT 
                                                                                                                                      EmptyT   ) 

                                                                          (NodeT  (S "C" [ (Motor 30)] ["Pabli", "Ami"]) EmptyT
                                                                                                                         (NodeT (S "D" [(Motor 40), Almacen [Comida, Oxigeno, Combustible]] ["Mar"]) EmptyT
                                                                                                                                                                                                     EmptyT )))



{-
                                                S "A" [LanzaTorpedos, (Motor 10)] ["Rena", "Gonza"])  
                                                /                                               \
                                               /                                                 \
        S "B" [LanzaTorpedos, (Motor 20)] ["Azu", "Mile"])                                      S "C" [ (Motor 30)] ["Pabli", "Ami"]
                                                                                                                           \
                                                                                                                            \
                                                                                                                        S "D" [(Motor 40), Almacen [Comida, Oxigeno, Combustible]] ["Mar"]

-}




nave_2 = N ( NodeT (S "E" [LanzaTorpedos, (Motor 1)] [ "Gonza"])  (NodeT  (S "F" [LanzaTorpedos, (Motor 2), Almacen [Oxigeno, Combustible] ] ["Azu"]) EmptyT 
                                                                                                                     EmptyT) 

                                                                  (NodeT  (S "G" [ (Motor 3)] ["Pabli", "Ami"]) EmptyT
                                                                                                                (NodeT (S "H" [Almacen [Comida, Torpedo, Combustible]] ["Mile"]) EmptyT
                                                                                                                                                                                 EmptyT )))



--Implementar las siguientes funciones utilizando recursión estructural:

--Propósito: Devuelve todos los sectores de la nave.
sectores :: Nave -> [SectorId]
sectores (N sectores) = losSectores sectores

losSectores :: Tree Sector -> [SectorId]
losSectores EmptyT = []
losSectores (NodeT sect s1 s2) = sectorId sect : losSectores s1 ++ losSectores s2

sectorId :: Sector -> SectorId
sectorId (S id _ _) = id


{-
sectores nave_1 --> ["A", "B", "C", "D"]
sectores nave_2 --> ["E", "F", "G", "H"]
-}


--Propósito: Devuelve la suma de poder de propulsión de todos los motores de la nave. Nota:
--el poder de propulsión es el número que acompaña al constructor de motores.
poderDePropulsion :: Nave -> Int
poderDePropulsion (N sectores) = sumaPropulsion sectores


sumaPropulsion :: Tree Sector -> Int
sumaPropulsion (EmptyT)           = 0
sumaPropulsion (NodeT sect s1 s2) = propulsionDelSector sect + sumaPropulsion s1 + sumaPropulsion s2

propulsionDelSector :: Sector -> Int
propulsionDelSector (S _ cs _ ) = totalPropulsionEnLista cs

totalPropulsionEnLista :: [Componente] -> Int
totalPropulsionEnLista []     = 0
totalPropulsionEnLista (c:cs) = propulsionSiEsMotor c + totalPropulsionEnLista cs

propulsionSiEsMotor :: Componente -> Int
propulsionSiEsMotor (Motor prop) = prop
propulsionSiEsMotor       _      = 0

{-
poderDePropulsion nave_1  ---> 100
poderDePropulsion nave_2  ---> 6
-}





--Propósito: Devuelve todos los barriles de la nave.
barriles :: Nave -> [Barril]
barriles (N sects) = losBarriles sects


losBarriles :: Tree Sector -> [Barril]
losBarriles EmptyT              = []
losBarriles (NodeT sect s1 s2)  = barrilesEnSector sect ++ losBarriles s1 ++ losBarriles s2

barrilesEnSector :: Sector -> [Barril]
barrilesEnSector (S _ cs _) = barrilesEnComponentes cs

barrilesEnComponentes :: [Componente] -> [Barril]
barrilesEnComponentes []     = [] 
barrilesEnComponentes (c:cs) = agregarSiEsAlmacen c (barrilesEnComponentes cs)


agregarSiEsAlmacen :: Componente -> [Barril] -> [Barril]
agregarSiEsAlmacen (Almacen bs) barriles = bs ++ barriles
agregarSiEsAlmacen       _      barriles = barriles


{-
barriles nave_1 --> [Comida, Oxigeno, Combustible]
barriles nave_2 --> [Oxigeno, Combustible, Comida, Torpedo, Combustible]
-}


--Propósito: Añade una lista de componentes a un sector de la nave.
--Nota: ese sector puede no existir, en cuyo caso no añade componentes.
agregarASector :: [Componente] -> SectorId -> Nave -> Nave
agregarASector cps sId (N sects) = N (agregarEnSector cps sId sects)


agregarEnSector :: [Componente] -> SectorId -> Tree Sector -> Tree Sector
agregarEnSector  _   _       EmptyT        = EmptyT
agregarEnSector cps sId (NodeT sect s1 s2) = if esMismoSector sId (idDelSector sect) 
                                                                then NodeT (colocarComponentes cps sect) s1 s2
                                                                else NodeT sect (agregarEnSector cps sId s1) (agregarEnSector cps sId s2)


idDelSector :: Sector -> SectorId 
idDelSector (S id _ _) = id

esMismoSector :: SectorId -> SectorId -> Bool
esMismoSector s1 s2 = s1 == s2

colocarComponentes :: [Componente] -> Sector -> Sector
colocarComponentes cps1 (S id cps2 trps) = S id (cps2++cps1) trps


{-
agregarASector [LanzaTorpedos] "C" nave_1 :

   modificado --> N (NodeT (S "A" [LanzaTorpedos, Motor 10] ["Rena","Gonza"]) (NodeT (S "B" [LanzaTorpedos,Motor 20] ["Azu","Mile"]) EmptyT EmptyT) (NodeT (S "C" [ LanzaTorpedos, Motor 30] ["Pabli", "Ami"]) EmptyT (NodeT (S "D" [Motor 40, Almacen [Comida, Oxigeno, Combustible]] ["Mar"]) EmptyT EmptyT )))

NO modificado --> N (NodeT (S "A" [LanzaTorpedos, Motor 10] ["Rena","Gonza"]) (NodeT (S "B" [LanzaTorpedos,Motor 20] ["Azu","Mile"]) EmptyT EmptyT) (NodeT (S "C" [                Motor 30] ["Pabli","Ami"]) EmptyT (NodeT (S "D" [Motor 40,Almacen [Comida,Oxigeno,Combustible]] ["Mar"]) EmptyT EmptyT)))


-}


--Propósito: Incorpora un tripulante a una lista de sectores de la nave.
asignarTripulanteA :: Tripulante -> [SectorId] -> Nave -> Nave
--Precondición: Todos los id de la lista existen en la nave.
asignarTripulanteA tp ids (N sectorT) = N (asignarALosTripulantes tp ids sectorT)


asignarALosTripulantes :: Tripulante -> [SectorId] -> Tree Sector -> Tree Sector
--Precondición: Todos los id de la lista existen en la nave.
asignarALosTripulantes   _   []    sectorT = sectorT
asignarALosTripulantes  tp (i:is)  sectorT = asignarALosTripulantes tp is (asignarTripEn tp i sectorT)



asignarTripEn :: Tripulante -> SectorId -> Tree Sector -> Tree Sector
--Precondición: el id de la lista existe en la nave.
asignarTripEn   _   _  EmptyT             = EmptyT 
asignarTripEn  tp  id  (NodeT sect s1 s2) = NodeT (agregarSiEsSector tp id sect) (asignarTripEn tp id s1) (asignarTripEn tp id s2)

agregarSiEsSector :: Tripulante -> SectorId -> Sector -> Sector
agregarSiEsSector tp id sect = if esMismoSector id (idDelSector sect) then insertarEnSector sect tp
                                                                       else sect 

insertarEnSector :: Sector -> Tripulante -> Sector
insertarEnSector (S id cs tps) tp = S id cs (tp:tps)

{-
asignarTripulanteA "Holaaaaaa" ["C", "A"] nave_1 :

              NO modificado --> N (NodeT (S "A" [LanzaTorpedos,Motor 10] ["Rena","Gonza"]) (NodeT (S "B" [LanzaTorpedos,Motor 20] ["Azu","Mile"]) EmptyT EmptyT) (NodeT (S "C" [Motor 30] ["Pabli","Ami"]) EmptyT (NodeT (S "D" [Motor 40,Almacen [Comida,Oxigeno,Combustible]] ["Mar"]) EmptyT EmptyT)))

COMO DEBERIA SER modificado --> N (NodeT (S "A" [LanzaTorpedos,Motor 10] ["Rena","Gonza","Holaaaaaa"]) (NodeT (S "B" [LanzaTorpedos,Motor 20] ["Azu","Mile"]) EmptyT EmptyT) (NodeT (S "C" [Motor 30] ["Pabli","Ami","Holaaaaaa"]) EmptyT (NodeT (S "D" [Motor 40,Almacen [Comida,Oxigeno,Combustible]] ["Mar"]) EmptyT EmptyT)))

                 Modificado --> N (NodeT (S "A" [LanzaTorpedos,Motor 10] ["Holaaaaaa","Rena","Gonza"]) (NodeT (S "B" [LanzaTorpedos,Motor 20] ["Azu","Mile"]) EmptyT EmptyT) (NodeT (S "C" [Motor 30] ["Holaaaaaa","Pabli","Ami"]) EmptyT (NodeT (S "D" [Motor 40,Almacen [Comida,Oxigeno,Combustible]] ["Mar"]) EmptyT EmptyT)))


-}

--Propósito: Devuelve los sectores en donde aparece un tripulante dado.
sectoresAsignados :: Tripulante -> Nave -> [SectorId]
sectoresAsignados tp (N sectorT) = losSectoresDelTripulante tp sectorT


losSectoresDelTripulante :: Tripulante -> Tree Sector -> [SectorId]
losSectoresDelTripulante  _        EmptyT       = []
losSectoresDelTripulante  tp (NodeT sect s1 s2) = idSiEstaEnSector tp sect ++ losSectoresDelTripulante tp s1  ++ losSectoresDelTripulante tp s2

idSiEstaEnSector :: Tripulante -> Sector -> [SectorId]
idSiEstaEnSector tp (S id _ tps) = if pertenece tp tps   -- SON STRINGS ASIQUE LOS PUEDO COMPARAR POR IGUALDAD
                                                     then [id]
                                                     else []

pertenece :: Eq a => a -> [a] -> Bool
pertenece _ []     = False
pertenece e (x:xs) = e==x || pertenece e xs



nave_3 = N ( NodeT (S "A" [LanzaTorpedos, (Motor 10)] ["Rena", "Gonza"])  (NodeT  (S "B" [LanzaTorpedos, (Motor 20)] ["Azu", "Mile"]) EmptyT 
                                                                                                                                      EmptyT   ) 

                                                                          (NodeT  (S "C" [ (Motor 30)] ["Pabli","Mile","Ami"]) EmptyT
                                                                                                                         (NodeT (S "D" [(Motor 40), Almacen [Comida, Oxigeno, Combustible]] ["Mar","Rena"]) EmptyT
                                                                                                                                                                                                     EmptyT )))

{-
sectoresAsignados "Rena" nave_3 --> ["A", "D"]
sectoresAsignados "Mile" nave_3 --> ["B", "C"]

-}



--Propósito: Devuelve la lista de tripulantes, sin elementos repetidos.
tripulantes :: Nave -> [Tripulante]
tripulantes (N sectsT) = losTripulantes sectsT


losTripulantes :: Tree Sector -> [Tripulante]
losTripulantes EmptyT             = []
losTripulantes (NodeT sect s1 s2) = agregarLosTripulantes (agregarLosTripulantes (losTripulantesDelSector sect) (losTripulantes s1)) (losTripulantes s2)


losTripulantesDelSector :: Sector -> [Tripulante]
losTripulantesDelSector (S _ _ tps) = tps

agregarLosTripulantes :: [Tripulante] -> [Tripulante] -> [Tripulante]
--agrega los tripulantes de la primera lista en la segunda, SIN REPETIDOS
agregarLosTripulantes   []   ts  = ts
agregarLosTripulantes (t:ts) tps = if pertenece t tps then agregarLosTripulantes ts tps
                                                      else t: agregarLosTripulantes ts tps


{-
tripulantes nave_1 --> ["Rena","Gonza","Azu","Mile","Pabli","Ami","Mar"]
tripulantes nave_3 --> ["Gonza","Azu","Pabli","Mile","Ami","Mar","Rena"]
-}











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



manada1 = M (Cazador "A" ["carne","pescado"] (Explorador "B" ["Terr1","Terr2"] (Cría "C") 
                                                                               (Explorador "D" ["Terr3"] (Cría "E") 
                                                                                                         (Cría "F"))) 
                                             (Cría "G") 
                                             (Cazador "H" ["pescado"] (Cría "I")
                                                                      (Cría "J")
                                                                      (Cazador "K" ["pollo", "carne"] (Cría "L")
                                                                                                      (Cría "M")
                                                                                                      (Cría "N"))))
{-                                                                      Cazador "A" ["carne","pescado"]
                                                                       /             |                  \
                                                                      /              |                   \
                                        Explorador "B" ["Terr1","Terr2"]           Cría "G"              Cazador "H" ["pescado"]
                                        /                 \                                             /          |            \
                                       /                   \                                           /           |             \
                                 Cría "C"         Explorador "D" ["Terr3"]                         Cría "I"     Cría "J"       Cazador "K" ["pollo", "carne"]
                                                 /                       \                                                       /          |           \
                                                /                         \                                                     /           |            \       
                                            Cría "E"                   Cría "F"                                             Cría "L"    Cría "M"       Cría "N" 
-}

manada2 = M (Cazador "A" ["carne","pescado","carne","pescado"] (Explorador "B" ["Terr1","Terr2"] (Cría "C") 
                                                                                                 (Explorador "D" ["Terr1"] (Cría "E") 
                                                                                                                           (Cría "F"))) 
                                                               (Cría "G") 
                                                               (Cazador "H" ["pescado","carne","pescado"] (Cría "I")
                                                                                                          (Cría "J")
                                                                                                          (Cazador "K" ["pollo", "carne","carne","pescado"] (Cría "L")
                                                                                                                                                            (Cría "M")
                                                                                                                                                            (Cría "N"))))
{-                                                            Cazador "A" ["carne","pescado","carne","pescado"]
                                                                       /             |                  \
                                                                      /              |                   \
                                        Explorador "B" ["Terr1","Terr2"]           Cría "G"         Cazador "H" ["pescado","carne","pescado"]
                                        /                 \                                             /          |            \
                                       /                   \                                           /           |             \
                                 Cría "C"         Explorador "D" ["Terr1"]                         Cría "I"     Cría "J"    Cazador "K" ["pollo", "carne","carne","pescado"]
                                                 /                       \                                                       /          |           \
                                                /                         \                                                     /           |            \       
                                            Cría "E"                   Cría "F"                                             Cría "L"    Cría "M"       Cría "N"   

          
-}

manada3 = M (Cazador "A" ["carne","pescado","carne","pescado"] (Explorador "B" ["Terr1","Terr2"] (Cría "C") 
                                                                                                 (Explorador "D" ["Terr3"] (Cría "E") 
                                                                                                                           (Cazador "F" ["carne","pescado","carne","pescado","carne","pescado"] (Cría "O")
                                                                                                                                                                                                (Cría "P")
                                                                                                                                                                                                (Cría "Q")))) 
                                                               (Cría "G") 
                                                               (Cazador "H" ["pescado","carne","pescado"] (Cría "I")
                                                                                                          (Cría "J")
                                                                                                          (Cazador "K" ["pollo", "carne","carne","pescado"] (Cría "L")
                                                                                                                                                            (Cría "M")
                                                                                                                                                            (Cría "N"))))
{-                                                            Cazador "A" ["carne","pescado","carne","pescado"]
                                                                       /             |                  \
                                                                      /              |                   \
                                        Explorador "B" ["Terr1","Terr2"]           Cría "G"         Cazador "H" ["pescado","carne","pescado"]
                                        /                 \                                             /          |            \
                                       /                   \                                           /           |             \
                                 Cría "C"         Explorador "D" ["Terr3"]                         Cría "I"     Cría "J"    Cazador "K" ["pollo", "carne","carne","pescado"]
                                                 /                       \                                                                   /          |           \
                                                /                         \                                                                 /           |            \       
                                          Cría "E"       Cazador "F" ["carne","pescado","carne","pescado","carne","pescado"]            Cría "L"    Cría "M"       Cría "N"                
                                                           /                  |                    \                                            
                                                          /                   |                     \                                                 
                                                      Cría "O"             Cría "P"              Cría "Q"





-}

--Propósito: dada una manada, indica si la cantidad de alimento cazado es mayor a la cantidad de crías.
buenaCaza :: Manada -> Bool
buenaCaza manada = cantCríasEnManada manada < cantAlimentoEnManada manada

cantCríasEnManada :: Manada -> Int
cantCríasEnManada (M lobo) = cantCríasDe lobo

cantCríasDe :: Lobo -> Int
cantCríasDe (Cría _)               = 1
cantCríasDe (Explorador _ _ l1 l2) = cantCríasDe l1 + cantCríasDe l2
cantCríasDe (Cazador _ _ l1 l2 l3) = cantCríasDe l1 + cantCríasDe l2 + cantCríasDe l3
 
cantAlimentoEnManada :: Manada -> Int
cantAlimentoEnManada (M lobo) = cantAlimentoEn lobo

cantAlimentoEn :: Lobo -> Int
cantAlimentoEn (Cría _)                = 0
cantAlimentoEn (Explorador _  _ l1 l2) = cantAlimentoEn l1 + cantAlimentoEn l2
cantAlimentoEn (Cazador _ ps l1 l2 l3) = longitud ps + cantAlimentoEn l1 + cantAlimentoEn l2 + cantAlimentoEn l3

longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

{-
buenaCaza manada1 --> False ( 5 presas y  9 Crías)
buenaCaza manada2 --> True  (11 presas y  9 Crías)
buenaCaza manada3 --> True  (17 presas y 11 Crías)
-}


--Propósito: dada una manada, devuelve el nombre del lobo con más presas cazadas, junto
--con su cantidad de presas. Nota: se considera que los exploradores y crías tienen cero presas
--cazadas, y que podrían formar parte del resultado si es que no existen cazadores con más de
--cero presas.
elAlfa :: Manada -> (Nombre, Int)
elAlfa (M lobo) = elAlfaEn lobo

elAlfaEn :: Lobo -> (Nombre, Int)
elAlfaEn (Cría n)                = (n, 0)
elAlfaEn (Explorador n  _ l1 l2) = elMasCazador (n, 0) (elMasCazador (elAlfaEn l1) (elAlfaEn l2))
elAlfaEn (Cazador n ps l1 l2 l3) = elMasCazador (n, longitud ps) 
                                                (elMasCazador (elAlfaEn l1) 
                                                              (elMasCazador (elAlfaEn l2) 
                                                                            (elAlfaEn l3) ))

elMasCazador :: (Nombre, Int) -> (Nombre, Int) -> (Nombre, Int) 
elMasCazador (n1, cantPresas1) (n2, cantPresas2) = if cantPresas1 > cantPresas2 then (n1, cantPresas1)
                                                                                else (n2, cantPresas2)
{-
elAlfa manada1 --por como está programado--> ("K",2)
elAlfa manada2 --por como está programado--> ("K",4)
elAlfa manada3 ----------------------------> ("F",6)
-}




--Propósito: dado un territorio y una manada, devuelve los nombres de los exploradores que
--pasaron por dicho territorio.
losQueExploraron :: Territorio -> Manada -> [Nombre]
losQueExploraron tr (M lobo) = lobosQueExploraron tr lobo

lobosQueExploraron :: Territorio -> Lobo -> [Nombre]
lobosQueExploraron  _ (Cría n)                = []
lobosQueExploraron tr (Explorador n trs l1 l2) = baciaSiNoExploro tr trs n ++ lobosQueExploraron tr l1 ++ lobosQueExploraron tr l2 
lobosQueExploraron tr (Cazador n  ps l1 l2 l3) = lobosQueExploraron tr l1 ++ lobosQueExploraron tr l2 ++ lobosQueExploraron tr l3

baciaSiNoExploro :: Territorio -> [Territorio] -> Nombre -> [Nombre]
baciaSiNoExploro t trs n = if pertenece t trs then [n] else []

{-
losQueExploraron "Terr1" manada1 --> ["B"]
losQueExploraron "Terr3" manada1 --> ["D"]
losQueExploraron "Terr2" manada1 --> ["B"]
-}


--Propósito: dada una manada, denota la lista de los pares cuyo primer elemento es un territorio y cuyo segundo elemento es la lista de los nombres de los exploradores que exploraron
--dicho territorio. Los territorios no deben repetirse.
exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
exploradoresPorTerritorio (M lobos) = lobosExploradoresPorTerritorio (losTerritorios lobos) lobos


losTerritorios :: Lobo -> [Territorio]
--Obs: sin repetidos
losTerritorios (Cría _ )                 = []
losTerritorios (Explorador _ trs l1 l2) = agregarSiNoPertenecen trs  (losTerritorios l1 ++ losTerritorios l2)
losTerritorios (Cazador _  _  l1 l2 l3) = losTerritorios l1 ++ losTerritorios l2 ++ losTerritorios l3

agregarSiNoPertenecen :: [Territorio] -> [Territorio] -> [Territorio]
agregarSiNoPertenecen []      ts2 = ts2
agregarSiNoPertenecen (t:ts1) ts2 = if pertenece t ts2 then agregarSiNoPertenecen ts1 ts2 else t : (agregarSiNoPertenecen ts1 ts2)

lobosExploradoresPorTerritorio :: [Territorio] -> Lobo -> [(Territorio, [Nombre])]
lobosExploradoresPorTerritorio []     _ = []
lobosExploradoresPorTerritorio (t:ts) l = (t, lobosQueExploraron t l) : lobosExploradoresPorTerritorio ts l

{-
exploradoresPorTerritorio manada1 --> [("Terr1",["B"]),("Terr2",["B"]),("Terr3",["D"])]   
                         rta real---> [("Terr1",["B"]),("Terr2",["B"]),("Terr3",["D"])]            
exploradoresPorTerritorio manada2 --> [("Terr1",["B","D"]),("Terr2",["B"])] 
                         rta real---> [("Terr2",["B"]),("Terr1",["B","D"])]  -- xq como esta programado lo de sin repetidos me queda al reves
exploradoresPorTerritorio manada3 --> [("Terr1",["B"]),("Terr2",["B"]),("Terr3",["D"])]
                         rta real---> [("Terr1",["B"]),("Terr2",["B"]),("Terr3",["D"])]
-}

--Propósito: dado el nombre de un lobo y una manada, indica el nombre de todos los cazadores que tienen como subordinado al lobo dado (puede ser un subordinado directo, o el
--subordinado de un subordinado).
cazadoresSuperioresDe :: Nombre -> Manada -> [Nombre]
--Precondición: hay un lobo con dicho nombre y es único.
cazadoresSuperioresDe n (M lobo) = losCazadoresSuperioresDe n lobo


losCazadoresSuperioresDe :: Nombre -> Lobo -> [Nombre]
losCazadoresSuperioresDe n  (Cría _ )                 = []
losCazadoresSuperioresDe n  (Explorador  _   _ l1 l2) = losCazadoresSuperioresDe n (loboEnElQueSeEncuentraElSubordinado n l1 l2)
losCazadoresSuperioresDe n1 (Cazador n2  _  l1 l2 l3) = if n1==n2 then [] else n2 :  losCazadoresSuperioresDe n1 (loboEnElQueSeEncuentraElSubordinado n1 l1 (loboEnElQueSeEncuentraElSubordinado n1 l2 l3))

loboEnElQueSeEncuentraElSubordinado :: Nombre -> Lobo -> Lobo -> Lobo
loboEnElQueSeEncuentraElSubordinado n l1 l2 = if existeElLobo n l1 then l1 else l2

existeElLobo :: Nombre -> Lobo -> Bool
existeElLobo n1 (Cría n2)                 = n1 == n2
existeElLobo n1 (Explorador n2   _ l1 l2) = n1 == n2 || existeElLobo n1 l1 || existeElLobo n1 l2
existeElLobo n1 (Cazador n2  _  l1 l2 l3) = n1 == n2 || existeElLobo n1 l1 || existeElLobo n1 l2 || existeElLobo n1 l3










manadaEj = M (Cazador "DienteFiloso" ["Búfalos", "Antílopes"] (Cría "Hopito")
                 
                                                              (Explorador "Incansable" ["Oeste hasta el río"] (Cría "MechónGris")
                                                                                                              (Cría "Rabito"))
      
                                                              (Cazador "Garras" ["Antílopes", "Ciervos"] (Explorador "Zarpado" ["Bosque este"] (Cría "Osado")
                                                                                                                                               (Cazador "Mandíbulas" ["Cerdos", "Pavos"] (Cría "Desgreñado")
                                                                                                                                                                                         (Cría "MalCríado")
                                                                                                                                                                                         (Cazador "TrituraHuesos" ["Conejos"] (Cría "Peludo")
                                                                                                                                                                                                                              (Cría "Largo")
                                                                                                                                                                                                                              (Cría "Menudo"))))
      
                                                                                                         (Cría "Garrita")
                                                                                                         (Cría "Manchas")))



{-
la función cazadoresSuperioresDe debería dar lo siguiente:
cazadoresSuperioresDe "Mandíbulas" manadaEj = ["DienteFiloso", "Garras"]
cazadoresSuperioresDe "Rabito" manadaEj = ["DienteFiloso"]
cazadoresSuperioresDe "DienteFiloso" manadaEj = []
cazadoresSuperioresDe "Peludo" manadaEj = ["DienteFiloso", "Garras", "Mandíbulas", "TrituraHuesos"]


-}