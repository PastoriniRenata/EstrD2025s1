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
