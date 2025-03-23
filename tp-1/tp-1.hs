--NUMEROS ENTEROS

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

--TIPOS ENUMERATIVOS

{-
 Definir el tipo de dato Dir, con las alternativas Norte, Sur, Este y Oeste. Luego implementar
las siguientes funciones:
a) opuesto :: Dir -> Dir
Dada una dirección devuelve su opuesta.
b) iguales :: Dir -> Dir -> Bool
Dadas dos direcciones, indica si son la misma. Nota: utilizar pattern matching y no ==.
c) siguiente :: Dir -> Dir
Dada una dirección devuelve su siguiente, en sentido horario, y suponiendo que no existe
la siguiente dirección a Oeste. ¾Posee una precondición esta función? ¾Es una función
total o parcial? ¾Por qué?
-}

data Dir = Norte | Sur | Este | Oeste 
    deriving Show

opuesto :: Dir -> Dir
opuesto Norte   = Sur
opuesto Sur     = Norte
opuesto Este    = Oeste
opuesto Oeste   = Este


iguales :: Dir -> Dir -> Bool
iguales Norte Norte = True
iguales Sur   Sur   = True
iguales Este  Este  = True
iguales Oeste Oeste = True
iguales _ _         = False

siguiente :: Dir -> Dir
siguiente Norte   = Este
siguiente Sur     = Oeste
siguiente Este    = Sur
siguiente Oeste   = error "No existe siguiente"


{-
Definir el tipo de dato DiaDeSemana, con las alternativas Lunes, Martes, Miércoles, Jueves,
Viernes, Sabado y Domingo. Supongamos que el primer día de la semana es lunes, y el último
es domingo. Luego implementar las siguientes funciones:
-}

data DiaDeSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo
    deriving Show 

{-
Devuelve un par donde la primera componente es el primer día de la semana, y la
segunda componente es el último día de la semana. Considerar definir subtareas útiles
que puedan servir después.
-}
primeroYUltimoDia :: (DiaDeSemana, DiaDeSemana)
primeroYUltimoDia = (primerDiaDeLaSemana, ultimoDiaDeLaSemana)

primerDiaDeLaSemana :: DiaDeSemana
primerDiaDeLaSemana = Lunes

ultimoDiaDeLaSemana :: DiaDeSemana
ultimoDiaDeLaSemana = Domingo

--Dado un día de la semana indica si comienza con la letra M.
empiezaConM :: DiaDeSemana -> Bool
empiezaConM Martes    = True
empiezaConM Miercoles = True
empiezaConM _         = False


{-
Dado dos días de semana, indica si el primero viene después que el segundo. Analizar
la calidad de la solución respecto de la cantidad de casos analizados (entre los casos
analizados en esta y cualquier subtarea, deberían ser no más de 9 casos).
Ejemplo: vieneDespues Jueves Lunes = True
-}

vieneDespues :: DiaDeSemana-> DiaDeSemana-> Bool
vieneDespues Lunes Domingo = True
vieneDespues dia1 dia2 =  nroDia dia1 > nroDia dia2


nroDia :: DiaDeSemana -> Int
nroDia Lunes     = 1
nroDia Martes    = 2 
nroDia Miercoles = 3
nroDia Jueves    = 4
nroDia Viernes   = 5
nroDia Sabado    = 6
nroDia Domingo   = 7


--Dado un día de la semana indica si no es ni el primer ni el ultimo dia.
estaEnElMedio :: DiaDeSemana -> Bool
estaEnElMedio Lunes   = False
estaEnElMedio Domingo = False
estaEnElMedio _       = True




{-
Los booleanos también son un tipo de enumerativo. Un booleano es True o False. Defina
las siguientes funciones utilizando pattern matching (no usar las funciones sobre booleanos
ya definidas en Haskell):
-}

{-
Dado un booleano, si es True devuelve False, y si es False devuelve True.
En Haskell ya está definida como not.
-}
negar :: Bool -> Bool
negar True  = False
negar _     = True

{-
Dados dos booleanos, si el primero es True y el segundo es False, devuelve False, sino
devuelve True.
Esta función NO debe realizar doble pattern matching.
Nota: no viene implementada en Haskell.
-}
implica :: Bool -> Bool -> Bool
implica True b  = b
implica False _ = True


{-
Dados dos booleanos si ambos son True devuelve True, sino devuelve False.
Esta función NO debe realizar doble pattern matching.
En Haskell ya está definida como \&\&.
-}
yTambien :: Bool -> Bool -> Bool
yTambien  True  b = b
yTambien  False _ = False


{-Dados dos booleanos si alguno de ellos es True devuelve True, sino devuelve False.
Esta función NO debe realizar doble pattern matching.
En Haskell ya está definida como ||.
-}
oBien :: Bool -> Bool -> Bool
oBien True  _    = True
oBien False  b   = b


--REGISTROS

-- Definir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las siguientes funciones:
data Persona = P String Int
    deriving Show
p1 = P "A" 25
p2 = P "B" 33
-- Devuelve el nombre de una persona
nombre :: Persona -> String
nombre (P n _) = n

-- Devuelve la edad de una persona
edad :: Persona -> Int
edad (P _ e) = e

-- Aumenta en uno la edad de la persona.
crecer :: Persona -> Persona
crecer (P n e) = P n (e+1)

-- Dados un nombre y una persona, devuelve una persona con la edad de la persona y el nuevo nombre.
cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre n2 (P n1 e) = P n2 e

-- Dadas dos personas indica si la primera es mayor que la segunda.
esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra (P n1 e1) (P n2 e2) = e1 > e2

-- Dadas dos personas devuelve a la persona que sea mayor
laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor p1 p2 = if esMayorQueLaOtra p1 p2 then p1 else p2


{-
Definir los tipos de datos Pokemon, como un TipoDePokemon (agua, fuego o planta) y un
porcentaje de energía; y Entrenador, como un nombre y dos Pokémon. Luego definir las
siguientes funciones:
-}
data Pokemon = ConsPokemon TipoDePokemon Int
    deriving Show

data TipoDePokemon = Agua | Fuego | Planta
    deriving Show

data Entrenador = ConsEntrenador String Pokemon Pokemon
    deriving Show

poke_1 = ConsPokemon Agua 1
poke_2 = ConsPokemon Fuego 2
poke_3 = ConsPokemon Agua 3
poke_4 = ConsPokemon Fuego 4
poke_5 = ConsPokemon Fuego 5
poke_6 = ConsPokemon Planta 6
poke_7 = ConsPokemon Planta 7
entrenador_1 =ConsEntrenador "A" poke_3 poke_1
entrenador_2 =ConsEntrenador "B" poke_2 poke_4
entrenador_3 =ConsEntrenador "C" poke_2 poke_3
entrenador_4 =ConsEntrenador "D" poke_1 poke_6
entrenador_5 =ConsEntrenador "E" poke_1 poke_3


{-
Dados dos Pokémon indica si el primero, en base al tipo, es superior al segundo. Agua
supera a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
-}
superaA :: Pokemon -> Pokemon -> Bool
superaA p1 p2 = esTipoSuperior (elTipo p1) (elTipo p2)

elTipo :: Pokemon -> TipoDePokemon
elTipo (ConsPokemon t _ ) = t


esTipoSuperior :: TipoDePokemon -> TipoDePokemon -> Bool
-- Dados dos tipos de Pokemon, indica si el primero es superior al segundo
esTipoSuperior Agua   Fuego  = True
esTipoSuperior Fuego  Planta = True
esTipoSuperior Planta Agua   = True
esTipoSuperior   _      _    = False


--Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe t (ConsEntrenador _ p1 p2) = unoSiEsMismoTipo t (elTipo p1) + unoSiEsMismoTipo t (elTipo p2)

unoSiEsMismoTipo :: TipoDePokemon -> TipoDePokemon -> Int
unoSiEsMismoTipo Agua Agua     = 1
unoSiEsMismoTipo Fuego Fuego   = 1
unoSiEsMismoTipo Planta Planta = 1
unoSiEsMismoTipo    _     _    = 0

--Dado un par de entrenadores, devuelve a sus Pokémon en una lista.
juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
juntarPokemon (ConsEntrenador _ p1 p2, ConsEntrenador _ p3 p4) = [p1, p2, p3, p4]



--FUNCIONES POLIMORFICAS

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





--PATTERN MATCHING SOBRE LISTAS

{-
1. Defina las siguientes funciones polimórficas utilizando pattern matching sobre listas (no
utilizar las funciones que ya vienen con Haskell):
-}

--Dada una lista de elementos, si es vacía devuelve True, sino devuelve False.
--Definida en Haskell como null
estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia  _ = False

--Dada una lista devuelve su primer elemento.
--Definida en Haskell como head.
--Nota: tener en cuenta que el constructor de listas es :
elPrimero :: [a] -> a
-- Precondicion: la lista NO debe ser vacía
elPrimero (x:xs) = x 

--Dada una lista devuelve esa lista menos el primer elemento.
--Definida en Haskell como tail.
--Nota: tener en cuenta que el constructor de listas es :
sinElPrimero :: [a] -> [a]
sinElPrimero [] = []
sinElPrimero (x:xs) = xs

--Dada una lista devuelve un par, donde la primera componente es el primer elemento de la
--lista, y la segunda componente es esa lista pero sin el primero.
--Nota: tener en cuenta que el constructor de listas es :
splitHead :: [a] -> (a, [a])
-- Precondicion: la lista NO debe ser vacía
splitHead (x:xs) = (x, xs)

