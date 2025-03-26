--RECURSION SOBRE LISTAS

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
conjuncion (x:xs)  = x && (conjuncion xs)


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
losMenoresA n (x:xs) = if n > x then x : losMenoresA n xs else losMenoresA n xs

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


-- RECURSION SOBRE NUMEROS

--Defina las siguientes funciones utilizando recursión sobre números enteros, salvo que se indique
--lo contrario:


--Dado un número n se devuelve la multiplicación de este número y todos sus anteriores hasta
--llegar a 0. Si n es 0 devuelve 1. La función es parcial si n es negativo.
factorial :: Int -> Int
-- n tiene que ser un numero natural o 0
factorial 0 = 1
factorial n = n * factorial (n-1)

--Dado un número n devuelve una lista cuyos elementos sean los números comprendidos entre
--n y 1 (incluidos). Si el número es inferior a 1, devuelve la lista vacía.
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva n = if n<1 then [] else n : cuentaRegresiva (n-1)

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


-- REGITROS

--Definir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las siguientes funciones:

data Persona = P String Int
    deriving Show

persona_1 = P "A" 20
persona_2 = P "B" 30
persona_3 = P "C" 45
persona_4 = P "D" 25

--promedio edad = 30

--Dados una edad y una lista de personas devuelve a las personas mayores a esa edad.
mayoresA :: Int -> [Persona] -> [Persona]
mayoresA _ [] = []
mayoresA n (x:xs) = if esMayorA n x then x : mayoresA n xs else mayoresA n xs

esMayorA :: Int -> Persona -> Bool
esMayorA n (P _ e) = n < e

--Dada una lista de personas devuelve el promedio de edad entre esas personas. Precondición: la lista al menos posee una persona.
promedioEdad :: [Persona] -> Int
--Precondición: la lista al menos posee una persona.
promedioEdad xs = div (sumatoriaEdades xs) (longitud xs)

sumatoriaEdades :: [Persona] -> Int
sumatoriaEdades []     = 0
sumatoriaEdades (x:xs) = edadDe x + sumatoriaEdades xs

edadDe :: Persona -> Int
edadDe (P _ e) = e


--Dada una lista de personas devuelve la persona más vieja de la lista. Precondición: la lista al menos posee una persona.
elMasViejo :: [Persona] -> Persona
-- Precondición: la lista al menos posee una persona
elMasViejo [x]    = x
elMasViejo (x:xs) = elMayor x (elMasViejo xs)
    
elMayor :: Persona -> Persona -> Persona
elMayor p1 p2 = if esMayor p1 p2 then p1 else p2

esMayor :: Persona -> Persona -> Bool
esMayor (P _ e1) (P _ e2) = e1>e2


--Modificaremos la representación de Entreador y Pokemon de la práctica anterior de la siguiente manera:
data TipoDePokemon = Agua | Fuego | Planta
    deriving Show
data Pokemon = ConsPokemon TipoDePokemon Int
    deriving Show
data Entrenador = ConsEntrenador String [Pokemon]
    deriving Show

poke_1 = ConsPokemon Agua 50
poke_2 = ConsPokemon Fuego 48
poke_3 = ConsPokemon Agua 32
poke_4 = ConsPokemon Fuego 32
poke_5 = ConsPokemon Fuego 32
poke_6 = ConsPokemon Planta 32
poke_7 = ConsPokemon Planta 32
entrenador_1 = ConsEntrenador "A" [poke_3, poke_1, poke_6]
entrenador_2 = ConsEntrenador "B" [poke_2, poke_4]
entrenador_3 = ConsEntrenador "C" [poke_2]
entrenador_4 = ConsEntrenador "D" [poke_1, poke_6]
entrenador_5 = ConsEntrenador "E" [poke_1, poke_3]

entr_6 = ConsEntrenador "F" [poke_1, poke_2, poke_6]


--Como puede observarse, ahora los entrenadores tienen una cantidad de Pokemon arbitraria.
--Definir en base a esa representación las siguientes funciones:

--Devuelve la cantidad de Pokémon que posee el entrenador.
cantPokemon :: Entrenador -> Int
cantPokemon (ConsEntrenador _ xs) = longitud xs


--Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
cantPokemonDe t (ConsEntrenador _ xs) = cantPokesDe t xs



cantPokesDe :: TipoDePokemon -> [Pokemon] -> Int
cantPokesDe _ []     = 0
cantPokesDe t (x:xs) = unoSiEsMismoTipo t (tipoDe x) + cantPokesDe t xs

unoSiEsMismoTipo :: TipoDePokemon -> TipoDePokemon -> Int
unoSiEsMismoTipo Agua Agua     = 1
unoSiEsMismoTipo Fuego Fuego   = 1
unoSiEsMismoTipo Planta Planta = 1
unoSiEsMismoTipo    _     _    = 0


--Dados dos entrenadores, indica la cantidad de Pokemon de cierto tipo, que le ganarían a los Pokemon del segundo entrenador.
cuantosDeTipo_De_LeGananATodosLosDe_ :: TipoDePokemon -> Entrenador -> Entrenador -> Int
cuantosDeTipo_De_LeGananATodosLosDe_ t (ConsEntrenador _ ps1) (ConsEntrenador _ ps2) = cantidadDeTipo_De_SuperanA_ t ps1 ps2

cantidadDeTipo_De_SuperanA_ :: TipoDePokemon -> [Pokemon] -> [Pokemon] -> Int
cantidadDeTipo_De_SuperanA_ t [] _          = 0
cantidadDeTipo_De_SuperanA_ t xs []         = cantDeTipo t xs
cantidadDeTipo_De_SuperanA_ t (x:xs) ys = if esDeTipo t (tipoDe x) 
                                            then unoSileGanaATodos x ys + cantidadDeTipo_De_SuperanA_ t xs ys 
                                            else cantidadDeTipo_De_SuperanA_ t xs ys

cantDeTipo :: TipoDePokemon -> [Pokemon] -> Int
cantDeTipo t []     = 0
cantDeTipo t (x:xs) = unoSiEsMismoTipo t (tipoDe x) + cantDeTipo t xs

esDeTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esDeTipo Agua Agua     = True
esDeTipo Fuego Fuego   = True
esDeTipo Planta Planta = True
esDeTipo    _     _    = False

tipoDe:: Pokemon -> TipoDePokemon
tipoDe (ConsPokemon t _) = t

unoSileGanaATodos :: Pokemon -> [Pokemon] -> Int
unoSileGanaATodos _ []     = 1
unoSileGanaATodos p (x:xs) = unoSi_SuperaA_ p x * unoSileGanaATodos p xs -- si a por lo menos 1 no le gana, ya me da 0 

unoSi_SuperaA_ :: Pokemon -> Pokemon -> Int
unoSi_SuperaA_ (ConsPokemon t1 _) (ConsPokemon t2 _) = unoSiEsTipoSuperior t1 t2

unoSiEsTipoSuperior :: TipoDePokemon -> TipoDePokemon -> Int
-- Dados dos tipos de Pokemon, devuelve 1 si el primero es superior al segundo
unoSiEsTipoSuperior Agua   Fuego  = 1
unoSiEsTipoSuperior Fuego  Planta = 1
unoSiEsTipoSuperior Planta Agua   = 1
unoSiEsTipoSuperior   _      _    = 0



{-
PARA TESTEAR:
cuantosDeTipo_De_LeGananATodosLosDe_ Agua entrenador_1 entrenador_2 --rta--> 2, xq tiene 2 pokes de agua y los 2 le ganan a todos los pokes del 2do enttrenador xq son los 2 d fuego

cuantosDeTipo_De_LeGananATodosLosDe_ Agua entrenador_1 entrenador_4 --rta--> 0 ,xq tiene 2 pokes de agua, pero ninguno le puede ganar a los 2 pokes del entrenador 4, xq uno de sus pokes es de planta

entrenador_1 =ConsEntrenador "A" [poke_3, poke_1, poke_6]
entrenador_2 =ConsEntrenador "B" [poke_2, poke_4]
entrenador_4 =ConsEntrenador "D" [poke_1, poke_6]
-}

--Dado un entrenador, devuelve True si posee al menos un Pokémon de cada tipo posible.
esMaestroPokemon :: Entrenador -> Bool
esMaestroPokemon (ConsEntrenador _ ps) = hayDeLosTresTipos ps

hayDeLosTresTipos :: [Pokemon] -> Bool
--Dada una lista de pokemon, indica si en la misma hay al menos un pokemon de cada tipo.
hayDeLosTresTipos [] = False
hayDeLosTresTipos ps =  (hayPokeDe Agua ps) && (hayPokeDe Fuego ps) && (hayPokeDe Planta ps)

hayPokeDe :: TipoDePokemon -> [Pokemon] -> Bool
hayPokeDe _ []     = False
hayPokeDe t (p:ps) = oBien (elPokeEsDeTipo t p) (hayPokeDe t ps)

elPokeEsDeTipo :: TipoDePokemon -> Pokemon -> Bool
elPokeEsDeTipo t1 (ConsPokemon t2 _) = esMismoTipo t1 t2

esMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esMismoTipo Agua Agua     = True
esMismoTipo Fuego Fuego   = True
esMismoTipo Planta Planta = True
esMismoTipo    _     _    = False


{-
PARA TESTEAR 
esMaestroPokemon entr_6 --> True
esMaestroPokemon entrenador_1 --> False
esMaestroPokemon entrenador_2 --> False
esMaestroPokemon entrenador_3 --> False

entr_6 =ConsEntrenador "F" [poke_1, poke_2, poke_6]
entrenador_1 =ConsEntrenador "A" [poke_3, poke_1, poke_6]
entrenador_2 =ConsEntrenador "B" [poke_2, poke_4]
entrenador_3 =ConsEntrenador "C" [poke_2]
-}




{-
El tipo de dato Rol representa los roles (desarollo o management) de empleados IT dentro
de una empresa de software, junto al proyecto en el que se encuentran. Así, una empresa es
una lista de personas con diferente rol. La definición es la siguiente:
-}

data Seniority = Junior | SemiSenior | Senior
    deriving Show

data Proyecto = ConsProyecto String
    deriving Show

data Rol = Developer Seniority Proyecto | Management Seniority Proyecto
    deriving Show

data Empresa = ConsEmpresa [Rol]
    deriving Show


proy1 = ConsProyecto "Proy A"
proy2 = ConsProyecto "Proy B"
proy3 = ConsProyecto "Proy C"
proy4 = ConsProyecto "Proy D"

rol1 = Developer Junior proy1
rol2 = Management Senior proy2
rol3 = Developer SemiSenior proy3
rol4 = Developer Senior proy1

empresa = ConsEmpresa [rol1, rol2, rol3, rol4]

empresaSinRepetidos = ConsEmpresa [rol1, rol2, rol3]

empresaConRepetidos = ConsEmpresa [rol1, rol4]


--Definir las siguientes funciones sobre el tipo Empresa:

--Dada una empresa denota la lista de proyectos en los que trabaja, sin elementos repetidos.
proyectos :: Empresa -> [Proyecto]
proyectos (ConsEmpresa rs) = proyectosSinRepetidos rs

proyectosSinRepetidos :: [Rol] -> [Proyecto]
proyectosSinRepetidos []     = []
proyectosSinRepetidos (r:rs) = if proyectoPerteneceALaLista (proyectoDe r) (proyectosSinRepetidos rs)
                                                then proyectosSinRepetidos rs
                                                else proyectoDe r : proyectosSinRepetidos rs

proyectoDe :: Rol -> Proyecto
proyectoDe (Developer _ p)  = p
proyectoDe (Management _ p) = p

elProyecto :: Proyecto -> String
elProyecto (ConsProyecto proy) = proy


proyectoPerteneceALaLista :: Proyecto -> [Proyecto] -> Bool
proyectoPerteneceALaLista _ [] = False
proyectoPerteneceALaLista x (s:ss) = oBien (sonElMismoProyecto x s) (proyectoPerteneceALaLista x ss)

sonElMismoProyecto :: Proyecto -> Proyecto -> Bool
sonElMismoProyecto (ConsProyecto s1) (ConsProyecto s2) = s1==s2







--Dada una empresa indica la cantidad de desarrolladores senior que posee, que pertecen
--además a los proyectos dados por parámetro.
losDevSenior :: Empresa -> [Proyecto] -> Int
losDevSenior (ConsEmpresa rs) ps = losSeniorQueParticipanEn rs ps

losSeniorQueParticipanEn :: [Rol] -> [Proyecto] -> Int
losSeniorQueParticipanEn   []     _ = 0
losSeniorQueParticipanEn (r:rs)  ps = unoSiEsSeniorYSuProyectoEstaEn_ (laSeniority r) (proyectoDe r) ps + losSeniorQueParticipanEn rs ps

unoSiEsSeniorYSuProyectoEstaEn_ :: Seniority -> Proyecto -> [Proyecto] -> Int
--Dado una seniority, un proyecto y una lista de proyectos. Devuelve uno si la seniority es Senior y el proyecto est'a en la lista de proyectos
unoSiEsSeniorYSuProyectoEstaEn_ Senior  p  ps = unoSiElProyectoPertenece p ps
unoSiEsSeniorYSuProyectoEstaEn_   _     _  _  = 0

unoSiElProyectoPertenece :: Proyecto -> [Proyecto] -> Int
unoSiElProyectoPertenece  p ps = if proyectoPerteneceALaLista p ps then 1 else 0

laSeniority :: Rol -> Seniority
laSeniority (Developer s _)  = s
laSeniority (Management s _) = s









--Indica la cantidad de empleados que trabajan en alguno de los proyectos dados.
cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
cantQueTrabajanEn ps (ConsEmpresa rs) = cantQueTrabajan ps rs

cantQueTrabajan :: [Proyecto] -> [Rol] -> Int
cantQueTrabajan _    []     = 0
cantQueTrabajan ps (r: rs)  = unoSiTrabajaEnAlguno ps r + cantQueTrabajan ps rs


unoSiTrabajaEnAlguno :: [Proyecto] -> Rol -> Int
unoSiTrabajaEnAlguno ps (Developer _ p)  = unoSiElProyectoPertenece p ps
unoSiTrabajaEnAlguno ps (Management _ p) = unoSiElProyectoPertenece p ps




--Devuelve una lista de pares que representa a los proyectos (sin repetir) junto con su
--cantidad de personas involucradas.
asignadosPorProyecto :: Empresa -> [(Proyecto, Int)]
asignadosPorProyecto (ConsEmpresa rs) = cantPorProyecto rs

cantPorProyecto :: [Rol] -> [(Proyecto, Int)]
cantPorProyecto []      = []
cantPorProyecto (r:rs)  = agregarATupla r (cantPorProyecto rs)

agregarATupla :: Rol -> [(Proyecto, Int)] -> [(Proyecto, Int)] 
agregarATupla (Developer _ p)  ps = sumarUnoEnTuplaCorrespondiente p ps
agregarATupla (Management _ p) ps = sumarUnoEnTuplaCorrespondiente p ps


sumarUnoEnTuplaCorrespondiente :: Proyecto -> [(Proyecto, Int)] -> [(Proyecto, Int)] 
sumarUnoEnTuplaCorrespondiente p   []   = [(p, 1)] -- si llega a esto es xq la tupla no existe, por lo que tiene que crearla de cero
sumarUnoEnTuplaCorrespondiente p (t:ts) = if esLaTupla p t 
                                            then sumarUnoA t : ts 
                                            else t : sumarUnoEnTuplaCorrespondiente p ts

esLaTupla :: Proyecto -> (Proyecto, Int) -> Bool
esLaTupla p1 (p2, _) = sonElMismoProyecto p1 p2

sumarUnoA :: (Proyecto, Int) -> (Proyecto, Int) 
sumarUnoA (p , n) = (p, n+1)



