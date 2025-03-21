-- Definir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las siguientes funciones:
data Persona = P String Int
    deriving Show

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
data Pokemon = Poke TipoDePokemon Int
    deriving Show

data TipoDePokemon = Agua | Fuego | Planta
    deriving Show

data Entrenador = E String Pokemon Pokemon
    deriving Show

{-
Dados dos Pokémon indica si el primero, en base al tipo, es superior al segundo. Agua
supera a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
-}
superaA :: Pokemon -> Pokemon -> Bool
superaA p1 p2 = esTipoSuperior (elTipo p1) (elTipo p2)

elTipo :: Pokemon -> TipoDePokemon
elTipo (Poke t _ ) = t


esTipoSuperior :: TipoDePokemon -> TipoDePokemon -> Bool
-- Dados dos tipos de Pokemon, indica si el primero es superior al segundo
esTipoSuperior Agua   Fuego  = True
esTipoSuperior Fuego  Planta = True
esTipoSuperior Planta Agua   = True
esTipoSuperior   _      _    = False


--Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe t (E _ p1 p2) = unoSiEsMismoTipo t (elTipo p1) + unoSiEsMismoTipo t (elTipo p2)

unoSiEsMismoTipo :: TipoDePokemon -> TipoDePokemon -> Int
unoSiEsMismoTipo Agua Agua     = 1
unoSiEsMismoTipo Fuego Fuego   = 1
unoSiEsMismoTipo Planta Planta = 1
unoSiEsMismoTipo    _     _    = 0

--Dado un par de entrenadores, devuelve a sus Pokémon en una lista.
juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
juntarPokemon (E _ p1 p2, E _ p3 p4) = [p1, p2, p3, p4]




