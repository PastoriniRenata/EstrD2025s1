{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
import Distribution.Compat.Lens (_1)
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
siguiente Oeste   = Norte


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


