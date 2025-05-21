{-
Ejercicio 1
Indicar el costo de heapsort :: Ord a => [a] -> [a] (de la práctica anterior) suponiendo que
el usuario utiliza una priority queue con costos logarítmicos de inserción y borrado (o sea, usa una
Heap como tipo de representación).


heapSort :: Ord a => [a] -> [a]
heapSort xs = pqALista (listaAPq xs)

listaAPq :: Ord a => [a] -> PriorityQueue a
listaAPq   []   = emptyPQ
listaAPq (x:xs) = insertPQ x (listaAPq xs)


pqALista :: Ord a => PriorityQueue a -> [a]
pqALista pq = if isEmptyPQ pq then []
                              else findMinPQ pq : pqALista (deleteMinPQ pq)



    - n es la cantidad de elementos de la lista ingresada como argumento

    listaAPq:
        - emptyPQ tiene un costo O(1), se desestima
        - insertPQ tiene un costo O(log m) en el peor caso, donde m es el tamaño actual de la PQ
        ==> listaAPq tiene un costo O(n * (log m)) ya que hace una operacion logaritmica por cada llamado recursivo sobre la lista. Y como estoy calculando
                    el peor caso y la PQ va a terminar teniendo la misma cantidad de elementos que en la lista ingresada
                ==> n = m -> O(n *(log m)) => O( n * log n)

    pqALista:
        - isEmptyPQ tiene costo O(1), se desestima
        - findMinPQ tiene costo O(1), se desestima
        - deleteMinPQ tiene costo O(log n)

        ==> pqALista tiene osto O(n * log n), donde n es la cantidad de elementos de la PQ ingresada por argumento, y donde por cada llamado 
                recursivo hace una operacion logaritmica (deleteMinPQ) (basicamente xq necesito acceder a TODOS los elementos de la PQ y cuando los borra tiene costo (log n)
            
    heapSort:
        - tiene un costo de O( n * log n + n * log n), se suman xq se realizan secuencialmente y no 
            dependen una d la otra para existir 
            O( n * log n + n * log n) --> O( 2 * n * log n) -- el 2 se desestima --> O(n * log n)
        
-}




{-
Ejercicio 2
Implementar las siguientes funciones suponiendo que reciben un árbol binario que cumple los
invariantes de BST y sin elementos repetidos (despreocuparse por el hecho de que el árbol puede
desbalancearse al insertar o borrar elementos). En todos los costos, N es la cantidad de elementos
del árbol. Justficar por qué la implementación satisface los costos dados.

BSTs (Árboles Binarios de Búsqueda): Árboles donde cada nodo tiene un valor mayor que todos los valores en su subárbol 
izquierdo y menor que todos los valores en su subárbol derecho. 

Ejemplo de BST:


        			 8
                  /     \
			    3         10
			  /   \        \
			 1     6        14
			      / \      / 
			     4   7    13

-}
bst :: Tree Int
bst = NodeT 8 (NodeT 3  (NodeT 1 (EmptyT)
                                 (EmptyT))
                        (NodeT 6 (NodeT 4 EmptyT EmptyT)
                                 (NodeT 7 EmptyT EmptyT)))
              (NodeT 10 (EmptyT)
                        (NodeT 14 (NodeT 13 EmptyT EmptyT)
                                  (EmptyT)))

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show
--Propósito: dado un BST dice si el elemento pertenece o no al árbol.
--Costo: O(log N) --> justirficación: se recorre una sola rama del tree. En el peor caso se recorre una unica rama del arbol y no encontrás  
                    -- el valor, teniendo q llegar 

belongsBST :: Ord a => a -> Tree a -> Bool
belongsBST _      EmptyT     = False
belongsBST x (NodeT y t1 t2) = x==y || belongsBST x (laRamaQueTengoQueVer x y t1 t2)
                

laRamaQueTengoQueVer :: Ord a => a -> a -> Tree a -> Tree a -> Tree a
laRamaQueTengoQueVer x y t1 t2 = if x>y then t2
                                        else t1






-- ESTA MAL:

{- La posicion en la que tiene q ir ubicado es: ser mas grande q su padre y estar en el medio entre sus dos hijos
cuando empiezo a comparar (estructura del if), si x es mas grande que el nodo en el q estoy, me voy por la rama derecha
  si es mas chico, me voy por la izquierda y vuelvo a evaluar


  Pasos para la inserción:
    Comenzar en la raíz: Se comienza el proceso en el nodo raíz del BST.
    Comparar y moverse:
    Si x es menor que y, se mueve al subárbol izquierdo.
    Si x es mayor que y, se mueve al subárbol derecho.
    Si x es igual a y, no se inserta (la propiedad BST no permite duplicados).
    Encontrar un nodo hoja: Se sigue moviéndose hasta llegar a un nodo hoja (un nodo sin hijos).
    Insertar el nuevo nodo: Se crea un nuevo nodo con x y se enlaza como hijo izquierdo o derecho del nodo hoja, según corresponda (menor o mayor). 
    
    Ejemplo:
    Supongamos que queremos insertar el valor 20 en un BST donde la raíz es 10, el subárbol izquierdo tiene 5 y el subárbol derecho 15. 
    Comenzar en la raíz (10): El 20 es mayor que 10, así que se mueve al subárbol derecho.
    Moverse en el subárbol derecho (15): El 20 es mayor que 15, se mueve al subárbol derecho.
    Encontrar un nodo hoja: El subárbol derecho de 15 es vacío (nulo), por lo que se ha encontrado la posición para la inserción.
    Insertar el nuevo nodo: Se crea un nuevo nodo con el valor 20 y se enlaza como hijo derecho de 15.
-}
{-
insertBST :: Ord a => a -> Tree a -> Tree a
--Propósito: dado un BST inserta un elemento en el árbol.
--Costo: O(log N)
insertBST x emptyT = NodeT x emptyT emptyT
insertBST x (NodeT y t1 t2) = if x<y then NodeT y t1 (... x ... t2)-- se va al izquierdo
                                     else   if x>y then NodeT y (... x ... t1) t2  -- si es maypr se va al derecho
                                                    else NodeT x t1 t2   -- sino (osea q está en el medio) lo inserto




deleteBST :: Ord a => a -> Tree a -> Tree a
--Propósito: dado un BST borra un elemento en el árbol.
--Costo: O(log N)



splitMinBST :: Ord a => Tree a -> (a, Tree a)
--Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
--Costo: O(log N)



splitMaxBST :: Ord a => Tree a -> (a, Tree a)
--Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
--Costo: O(log N)


esBST :: Tree a -> Bool
--Propósito: indica si el árbol cumple con los invariantes de BST.
--Costo: O(N2




elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
--Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
--elemento dado.
--Costo: O(log N)



elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
--Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
--elemento dado.
--Costo: O(log N)



balanceado :: Tree a -> Bool
--Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
--nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
--Costo: O(N2)
-}




--EJERCICIO 3

{-
Implementar como usuario del tipo abstracto Map las siguientes funciones:
-}
--Propósito: obtiene los valores asociados a cada clave del map.
valuesM :: Eq k => Map k v -> [Maybe v]
valuesM map = losValoresDe (keys map) map


losValoresDe :: Eq k => [k] -> Map k v -> [Maybe v]
losValoresDe   []   map = []
losValoresDe (k:ks) map = lookupM k map : losValoresDe ks map

{-
    - K es la cantidad de claves del Map

    costo de losValoresDe:
        - x es la cantidad de elementos de la lista ingresada por argumento
        - lookupM tiene costo  O(log K)

        --> como se hace una operacion logaritmica por cada llamado recursivo, losValoresDe tiene costo O(x * log K), como la lista de claves está creada a partir del map ==> x=Kç
            ==> losValoresDe tiene costo O(K * log K)


    COSTO DE valuesM
    - keys tiene costo O(k)
    - losValoresDe tiene costo O(k * log K)

    -> el costo operacional de valuesM es O(k + k * log k) --el termino más grande absorbe al menor--> valuesM es O(k * log k)

-}




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: indica si en el map se encuentran todas las claves dadas.
todasAsociadas :: Eq k => [k] -> Map k v -> Bool
todasAsociadas   []   map = True
todasAsociadas (k:ks) map = elem k (keys map) && (todasAsociadas ks map)

{-  
    - K es la cantidad de elementos del map
    - x es la cantidad de elementos de la lista ingresada por argumento
    - keys tiene costo O(K)
    - elem tiene costo O(K), ya que recorre la lista de claves del map. Osea que tiene la misma cantidad de elementos del map

    ==> todasAsociadas tiene costo O((K+K) * x) --> O(2K*x) -- el 2 es absorbido -- > O(K*x) ya que por cada llamado recursivo (las x iteraciones), se hace una operacion de costo lineal (K)
                             (elem + keys) * cant de elementos de la lista   
            
            ==> todasAsociadas tiene costo O(K*x)
-}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: convierte una lista de pares clave valor en un map.
listToMap :: Eq k => [(k, v)] -> Map k v
listToMap   []   = emptyM
listToMap (t:ts) = let (x, y) = t
                        in assocM x y (listToMap ts)


{-

    - t es la cantidad de elementos del la lista de claves-valores igresada por argumento
    - assocM tiene costo O(log K), donde K es la cantidad de elementos del MAP actual. 
    
    ==> listToMap tiene costo O(log K * t), ya que realiza una operacion logaritmica por cada llamdo recursivo (t llamados recursivos).
            Como estoy calculando el peor costo -> t=K en el peor caso 
            ==>listToMap tiene costo O(K * log K)

-}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: convierte un map en una lista de pares clave valor.
mapToList :: Eq k => Map k v -> [(k, v)]
mapToList map = crearTuplas (keys map) map

crearTuplas :: Eq k => [k] -> Map k v -> [(k, v)] 
crearTuplas   []   map = []
crearTuplas (k:ks) map = let valor = fromJust (lookupM k map) -- puedo usar el from just xq la lista de claves la cree a partir del map, x lo q tengo la garantía de q todas las claves tiene un valor asociado
                            in (k,valor) : crearTuplas ks map

{-
    crearTuplas:
        - c es la cantidad de elementos de la lista ingresada por argumento. 
            => Como la lista fue creada a partir del map c = K
        
        - K es la cantidad de claves en el map
        - lookupM tiene costo O(log K)
        - fromJust tiene costo O(1), se desestima

        ==> crearTuplas tiene costo O(c * log K) -- como c=K --> O(k * log K), ya que por cada llamado recursivo se hace una operación de costo logaritmico



    mapToList:
        - K es la cantidad de claves en el map
        - keys tiene costo O(K)
        - crearTuplas tiene costo O(K * log K)

            mapToList tiene costo O(k * log K + k) -- el termino más grande absorbe al más chico --> mapToList tiene costo O(k * log K)

-}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dada una lista de pares clave valor, agrupa los valores de los pares que compartan
--la misma clave.

agruparEq :: Eq k => [(k, v)] -> Map k [v]
agruparEq    []    = emptyM
agruparEq (kv:kvs) = let (c, v) = kv
                        in agregarAlMap c v (agruparEq kvs)

agregarAlMap :: Eq k => k -> v -> Map k [v] -> Map k [v]
agregarAlMap x y map = case lookupM x map of
                            Just vs -> assocM x (y:vs) map
                            Nothing -> assocM x [y] map


{-
    agregarAlMap
         - K la cantidad de claves del map
         - lookupM tiene costo O(log K)
         - assocM tiene costo O(log K)

         --> agregarAlMap hace dos operaciones logaritmicas secuenciales --> tiene costo O(log K + log K) -se simplifica -> O( log K)


    agruparEq
         agruparEq hace una operacion logaritmica (agregarAlMap) por cada llamado recursivo al recorrer la lista ingresada por parametro.
         - m cantidad de elementos de la lista ingresada por parametro

        agruparEq tiene costo O(m * log K)
            --> nada te garantiza que la cantidad de elementos que va a terminar teniendo el map va a ser la misma cantidad de elementos que tiene la lista de tuplas, xq puede haber claves repetidas.
                    Pero como estoy calculando el costo para el peor caso, y mi peor caso es que K=m
                ==> agruparEq tiene costo O(K * log K)
-}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dada una lista de claves de tipo k y un map que va de k a Int, le suma uno a
--cada número asociado con dichas claves.
incrementar :: Eq k => [k] -> Map k Int -> Map k Int
incrementar   []   map = map
incrementar (c:cs) map = case lookupM c map of
                                Just v  -> assocM c (v+1) (incrementar cs map)
                                Nothing -> incrementar cs map


{-
    - c es la cantidad de claves en la lista ingresada por argumento
    - K es la cantidad de elementos del map ingresada por argumento

    - lookupM tiene costo O(log K)
    - assocM tiene costo O(log K)


        ==> como estoy calculando el peor costo, mi funcion "incrementar" hace una operacion con costo O(c * (log K + log K)) --> O(c * log K)

-}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Propósito: dado dos maps se agregan las claves y valores del primer map en el segundo. Si
--una clave del primero existe en el segundo, es reemplazada por la del primero.
--OBS: assoc pisa el valor si la clave ya existe en el map
mergeMaps:: Eq k => Map k v -> Map k v -> Map k v
mergeMaps map1 map2 = unirMaps (keys map1) map1 map2

unirMaps :: Eq k => [k] -> Map k v -> Map k v -> Map k v
unirMaps   []    _   map2 = map2
unirMaps (c:cs) map1 map2 = unirMaps cs map1 (assocM c (fromJust (lookupM c map1)) map2) -- como lo hice yo
                 -- forma que les gusta a ellos: assoocM c (fromJust(lookupM c map1) (unirMaps cs map1 map2))

{-

    - Costo de unirMaps:

        - assocM tiene costo O(log m), donde m es la cantidad de claves del map2
        - fromJust tiene costo O(1)
        - lookUpM tiene costo O(log n), donde n es la cantidad de claves del map1
        - c es la cantidad de claves en la lista ingresada por parametro

        --> unirMaps tiene costo O((log n + log m) * c), ya que por cada elemento de la lista ingresada por parametro se 
             hace una operacion de costo (log n + log m), log n al tener que usar lookupM en el map1 y log m al usar assocM en el map2


        --> Como la lista ingresada por argumentos fue creada a partir de las claves del map1 ==> k=n 
                    ==> unirMaps tiene costo O((log n + log m) * n)


    - Costo de mergeMaps:
        - keys tiene costo O(n), donde n es la cantidad de claves del map1
        - unirMaps tiene costo O((log n + log m) * n), donde m es la cantidad de claves del map2, n es la cantidad de claves del map1

        --> mergeMaps tiene costo O((log n + log m) * n + n) - asorbo el + k -> O((n+m) * k), donde: - m cantidad de claves de map1
                                                                                                       - n cantidad de claves de map2
                                                

                --> tiene costo O((log n + log m) * n + n) =el menor termino es absorbido=> O((log n + log m) * n) 
                
                
-}


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
{-
Ejercicio 4
Dado la siguiente representación para el tipo abstrcto Empresa:
-}


(Map SectorId (Set Empleado))
                                                                     ________ (1, setEmpleado)________
                                                                    /                                 \
                                                        (2, setEmpleado)                          (9, setEmpleado)
                                                         /            \                           /             \
                                            (3, setEmpleado)        (4, setEmpleado)         (10, setEmpleado)  (11, setEmpleado)
                                               /        \             /          \
                                 (5, setEmpleado) (6, setEmpleado) (7, setEmpleado) (8, setEmpleado)

--un empleado puede estar asignado a más de un sector

setEmpleado:
                              empl1
                            /      \
                       empl2      empl3
                       /  \         /  \
                   empl4  empl5  empl6 empl7
                   /   \
               empl8   empl9


(Map CUIL Empleado)
                                                       ________ (cuil1, empl1)________
                                                      /                                 \
                                          (cuil2, empl2)                          (cuil9, empl9)
                                           /            \                           /             \
                              (cuil3, empl3)        (cuil4, empl4)         (cuil10, empl10)  (cuil11, empl11)
                                 /        \             /          \
                   (cuil5, empl5) (cuil6, empl6) (cuil7, empl7) (cuil8, empl8)



Empleado: NO TENGO LA MAS PALIDA IDEA DE COMO ESTÁ IMPLEMENTADO!!!

tanto Map como Set exponen una interfaz eficiente con costos logarítmicos para inserción, búsqueda y borrado, tal cual vimos en clase. 
            ==> osea que los implementan con un BST, y podrian llegar a ser AVL, pero no tenes garantia de que sea AVL . 
                De lo que Si tenes certeza de que es BST xq sino no podria ser una interfaz con costo logaritmico.

{-
Donde se observa que:
- los empleados son un tipo abstracto.
- el primer map relaciona id de sectores con los empleados que trabajan en dicho sector.
- el segundo map relaciona empleados con su número de CUIL.
- un empleado puede estar asignado a más de un sector
- tanto Map como Set exponen una interfaz eficiente con costos logarítmicos para inserción, búsqueda y borrado, tal cual vimos en clase.

Y sabemos que la interfaz de Empleado es:
-}

--Propósito: construye un empleado con dicho CUIL.
--Costo: O(1)
consEmpleado :: CUIL -> Empleado

--Propósito: indica el CUIL de un empleado.
--Costo: O(1)
cuil :: Empleado -> CUIL

--Propósito: incorpora un sector al conjunto de sectores en los que trabaja un empleado.
--Costo: O(log S), siendo S la cantidad de sectores que el empleado tiene asignados.
incorporarSector :: SectorId -> Empleado -> Empleado

--Propósito: indica los sectores en los que el empleado trabaja.
--Costo: O(S)
sectores :: Empleado -> [SectorId]

{-
Dicho esto, indicar invariantes de representación adecuados para la estructura y definir la
siguiente interfaz de Empresa, respetando los costos dados y calculando los faltantes. Justificar
todos los costos dados. En los costos, S es la cantidad de sectores de la empresa, y E es la
cantidad de empleados.

OBS Renu: S es la cantidad de claves en el 1er mapa (Map SectorId (Set Empleado)) y E es la cantidad de claves del 2do mapa (Map CUIL Empleado)
-}
type SectorId = Int
type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)

{-
(Map, emptyM, assocM, lookupM, deleteM, keys)
(Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList)


    Invariante de Representacion
        Siendo --> ConsE emplXSectores empleados 
                - emplXSectores = Map SectorId (Set Empleado)
                - empleados     = Map CUIL Empleado
            
        - todo empleado en el set de emplXSectores, debe existir en el map empleados asociado a un CUIL
        - los CUIL deben ser >0 y tener 11 digitos
        - Todos los sectores que el empleado tiene asignados (en el TAD empleado), deben coincidir con todos los sectores en los que el empleado está incluido en el map emplXSectores y viceversa

CONSULTA PARA EL MARTES: un empleado puede estar en la nomina (2do map), pero no tener ningun sector asignado (osea q no está en el 1er map)??
       
-}


--Propósito: construye una empresa vacía.
--Costo: O(1)
consEmpresa :: Empresa
consEmpresa = ConsE emptyM emptyM
{-
    -  emptyM tiene costo O(1)

    ==> consEmpresa tiene costo O(1+1) --> O(1)

-}


--Propósito: devuelve el empleado con dicho CUIL.
--Precondición: el CUIL es de un empleado de la empresa.
--Costo: O(log E)
buscarPorCUIL :: CUIL -> Empresa -> Empleado
buscarPorCUIL cuil (ConsE _ mapEmpleado) = fromJust (lookupM cuil mapEmpleado) 

{-
    - E es la cantidad de empleados en la empresa (cant de claves del mapEmpleados)
    - lookupM tiene costo O(log E)
    - fromJust tiene costo O(1), se desestima

    ==> buscarPorCUIL tiene costo O(log E)

-}



--Propósito: indica los empleados que trabajan en un sector dado.
--Costo: O(log S + E)
empleadosDelSector :: SectorId -> Empresa -> [Empleado]
empleadosDelSector id (ConsE mapSectrs _ ) = case lookupM id mapSectrs of
                                                Just set -> setToList ( set )
                                                Nothing  -> []
    
{-
    - S es la cantidad de sectores en la empresa
    - E es la cantidad de empleados en la empresa
    - lookupM tiene costo O(log S)
    - setToList costo O(E), ya que en mi peor caso sería que en el sector estén asignados TODOS los empleados de mi empresa 

    ==> el costo de empleadosDelSector es O(log S + E)

-}


--Propósito: indica todos los CUIL de empleados de la empresa.
--Costo: O(E)
todosLosCUIL :: Empresa -> [CUIL]
todosLosCUIL (ConsE _ mapEmpleado) = keys mapEmpleado

{-
    - E es la cantidad de empleados de la empresa
    - keys tiene un costo de O(K), siendo K la cantidad de keys del map

    ==> como mi map contiene a todos los empleados de mi empresa --> K=E ==> todosLosCUIL tiene costo O(E)
-}



--Propósito: indica todos los sectores de la empresa.
--Costo: O(S)
todosLosSectores :: Empresa -> [SectorId]
todosLosSectores (ConsE mapSectrs _) = keys mapSectrs

{-
    - S es la cantidad de sectores de mi empresa
    - keys tiene un costo de O(K), siendo K la cantidad de keys del map

    ==> como mi map contiene a todos los sectores de mi empresa --> K=S ==> todosLosSectores tiene costo O(S)
-}


--Propósito: agrega un sector a la empresa, inicialmente sin empleados.
--Costo: O(log S)
agregarSector :: SectorId -> Empresa -> Empresa
agregarSector id (ConsE mapSectrs mapEmpleado) = ConsE ( assocM id emptyS mapSectrs) mapEmpleado
                                                 
{-
    - S es la cantidad de sectores de la empresa
    - assocM tiene costo O(log K), donde K es la cantidad de claves del map

    ==> como mi mapSectrs contiene a todos los sectores de mi empresa --> K=S --> agregarSector tiene costo O(log S)
-}


--Propósito: agrega un empleado a la empresa, que trabajará en dichos sectores y tendrá el CUIL dado.
--Costo: calcular.
--Propósito: construye un empleado con dicho CUIL.

--OBS: asumo que el alguno de los sectores de la lista de sectores puede no existir
agregarEmpleado :: [SectorId] -> CUIL -> Empresa -> Empresa
agregarEmpleado ids cuil (ConsE mapSectrs mapEmpleado) = let empleado = agregarSectoresAEmpleado ids (consEmpleado cuil)
                                                               in ConsE (agregarASectores ids empleado mapSectrs) (assocM cuil empleado mapEmpleado)

agregarSectoresAEmpleado :: [SectorId] -> Empleado -> Empleado
--OBS: NO se aclara si el TAD empleado verifica que no haya ids repetidos, pero para no programar a la defensiva, interpreto que SI lo chequea
agregarSectoresAEmpleado   []     empleado = empleado
agregarSectoresAEmpleado (id:ids) empleado = incorporarSector id  (agregarSectoresAEmpleado ids empleado)

agregarASectores :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
--Proposito: dado una lista de sectores, un empleado y un Map de sectores, agrega al empleado en los sectores con los ids en la lista. En caso de que el sector no exista, lo crea
agregarASectores    []    empleado mapSectrs = mapSectrs
agregarASectores (id:ids) empleado mapSectrs = case lookupM id mapSectrs of
                                                Just set -> assocM id (addS empleado set)    (agregarASectores ids empleado mapSectrs)
                                                Nothing  -> assocM id (addS empleado emptyS) (agregarASectores ids empleado mapSectrs)


                   
    -- tengo que crear al empleado con el cuil dado --> LISTO
    -- tengo que agregarle los sectores en los que trabaja --> LISTO
    -- tengo q agregar al empleado a la empresa --> LISTO
    -- tengo que agregar al empleado en cada sector asignado (o bien ya existe ese secto o bien lo tengo q crear) --> LISTO

{-
    - E es la cantidad de empleados de la empresa
    - S es la cantidad de sectores de la empresa

    agregarASectores: 
        - I es la cantidad de elementos de la lista ingresada por argumento 
        - E es la cantidad de empleados de la empresa
        - S es la cantidad de sectores de la empresa

        - lookupM tiene costo O(log S), ya que trabaja sobre el map que contiene a todos los sectores de la empresa
        - assocM tiene costo O(log S), ya que trabaja sobre el map que contiene a todos los sectores de la empresa
        - addS tiene costo O(log E), ya que como peor caso el set sobre el que trabaja, podría llegar a tener a todos los empleados de la empresa
        - emptyS tiene costo O(1), se desestima

        ==> agregarASectores tiene costo O(I * (log S + log S + log E)) --> O(I * (2 * log S + log E)) ===> O(I * (log S + log E))
            I ≠ S xq contemplo el caso en el que los sectores de la lista ingresada por argumento no existan en mi empresa (osea q los tengo q crear)
    
    agregarSectoresAEmpleado:
        - I es la cantidad de elementos de la lista ingresada por argumento 
        - S es la cantidad de sectores de la empresa
        - incorporarSector tiene costo O(log M), siendo M la cantidad de sectores que tiene asignado el empleado. Como estoy calculando el peor 
            caso el empleado podría tener asignados TODOS los sectores de la empresa ==> M = S
            --> incorporarSector tiene costo O(log S)

        ==> agregarSectoresAEmpleado tiene costo O(I * log S), ya que hace una operación logaritmica en cada llamado recursivo.

    agregarEmpleado:
        - E es la cantidad de empleados de la empresa
        - S es la cantidad de sectores de la empresa
        - agregarSectoresAEmpleado tiene costo O(I * log S)
        - consEmpleado tiene costo O(1), se desestima
        - agregarASectores tiene costo O(I * (log S + log E))
        - assocM tiene costo O(log E), ya que trabaja sobre el map que contiene a todos los empleados de la empresa

        ===> agregarEmpleado tiene costo O(I * log S + I * (log S + log E) + log E) 
        -hago la distributiva de la I -> O(I * log S + I * log S + I * log E + log E)
        (I * log E ) absorbe a (log E)-> O(2 * I * log S + I * log E) 
                   El 2 es absorbido --> O( I * log S + I * log E) 
                     Factor comun I  --> O( I (log S +log E) ) 


        =====> agregarEmpleado tiene costo  O( I (log S +log E) ) 
-}



--Propósito: agrega un sector al empleado con dicho CUIL.
--Costo: calcular.
agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
-- OBS: asumo que el sector y empleado pueden NO existir
agregarASector id cuil (ConsE mapSectrs mapEmpleado) = case lookupM cuil mapEmpleado of
                                                                Just empleado -> ConsE (agregarEmpleadoASect id empleado mapSectrs) (assocM cuil (incorporarSector id empleado) mapEmpleado) -- caso de que el empleado exista

                                                                Nothing       -> let emplNuevo  = incorporarSector id (consEmpleado cuil)   -- como el empleado no existe, creo uno nuevo y le asigno el sector
                                                                                    in  ConsE (agregarEmpleadoASect id emplNuevo mapSectrs) (assocM cuil emplNuevo mapEmpleado) 
                                                                                        --      lo agrego al set del sector                  lo agrego como epleado nuevo a la empresa

agregarEmpleadoASect :: SectorId -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
--Proposito: agregar un empleado al sector ingresado por argumento. Si el sector no existe en el map, lo creo
agregarEmpleadoASect id empleado mapSectrs = case lookupM id mapSectrs of
                                                Just set -> assocM id (addS empleado set) mapSectrs
                                                Nothing  -> assocM id (addS empleado emptyS) mapSectrs

    -- Tengo que agergar el sector al empleado --> LISTO
    -- Tengo que agregar el empleado al sector --> LISTO

{-
    agregarEmpleadoASect:
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa
        - lookupM tiene costo O(log S) ya que el map con el que trabaja es el que contiene a todos los sectores de la empresa
        - assocM tiene costo O(log S) ya que el map con el que trabaja es el que contiene a todos los sectores de la empresa
        - addS tiene costo O(log E),  ya que el set con el que tabaja podría contener, en el peor caso, a todos los empleados de la empresa

            ==> agregarEmpleadoASect tiene costo O(log S + log S + log E) ==> O(log S + log E)

    agregarASector:
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa
        - lookupM tiene costo O(log E), ya que trabaja con el map que contiene a todos los empleados aasciados a su CUIL como clave.

                JUST: 
                    - assocM tiene costo O(log E), ya que trabaja con el map que contiene a todos los empleados aasciados a su CUIL como clave.
                    - incorporarSector tiene costo O(1), se desestima
                    - agregarEmpleadoASect tiene costo O(log S + log E)

                    ==> el JUST tiene costo O(log E + log S + log E) -> O(log S + log E)

                NOTHING:
                    - assocM tiene costo O(log E), ya que trabaja con el map que contiene a todos los empleados aasciados a su CUIL como clave.
                    - incorporarSector tiene costo O(1), se desestima
                    - agregarEmpleadoASect tiene costo O(log S + log E)
                    - consEmpleado tiene costo O(1), se desestima
                    ==> el NOTHING tiene costo O(log E + log S + log E) -> O(log S + log E)

                
                Conclusion: no importa que camino tome (JUST O NOTHING), tiene el mismo costo

        ===> agregarASector tiene costo O(log E +  log E + log S + log E)           
                                         lookup + assocM + agregarEmpleadoASect

                =====> agregarASector tiene costo O(log E + log S) 
-}


--Propósito: elimina al empleado que posee dicho CUIL.
--Costo: calcular.

{-
(Map, emptyM, assocM, lookupM, deleteM, keys)
(Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList)

-}
borrarEmpleado :: CUIL -> Empresa -> Empresa
--Precondicion: existe un empleado con dicho cuil en la empresa
borrarEmpleado cuil (ConsE mapSectrs mapEmpleado) = let empleado = fromJust (lookupM cuil mapEmpleado)
                                                        idsABorrar = sectores empleado
                                                        in ConsE (borrarAEmplDeLosSectores idsABorrar empleado mapSectrs) (deleteM cuil mapEmpleado)


borrarAEmplDeLosSectores :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
-- OBS: como la lista de ids la extraje del empleado, me garantiza que todos los ids existen en el mapSectrs, por lo q puedo usar fromJust
borrarAEmplDeLosSectores    []    emp mapSectrs = mapSectrs
borrarAEmplDeLosSectores (id:ids) emp mapSectrs = let setSector = removeS emp (fromJust (lookupM id mapSectrs)) -- el sector con el empleado ya borrado
                                                      in borrarAEmplDeLosSectores ids (assocM id setSector mapSectrs)



-- tengo que borrar al empleado del segundo map -- LISTO
-- tengo q borrar al empleado de cada sector en el que estaba -- LISTO

--estrategia: agarrar la lista de sectores del empleado y recorrerla


{-
    borrarAEmplDeLosSectores:
        - I es la cantidad de ids en la lista ingresada por argumento
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa
        - removeS tiene costo O(log E), ya que el set sobre el que trabaja, en el peor caso, puede llegar a contener a todos los Empleados de la empresa
        - fromJust tiene costo O(1)
        - lookupM tiene costo O(log S), ya que trabaja con el map que tiene como claves todos los sectores de la empresa
        - assocM tiene costo O(log S), ya que trabaja con el map que tiene como claves todos los sectores de la empresa


        ==> tiene costo O( (log E + log S + log S) * I) ya  que por cada llamado recursivo (I llamados recursivos), se hacen operaciones logaritmicasas de costo (log E + log S + log S), donde uno de los 
            terminos (log S) es absorbido por el otro, obteniendo que 
                                                    ===> borrarAEmplDeLosSectores tiene costo O( (log E + log S) * I)
                                                    ==> como en el peor caso el empleado puede estar en todos los sectores, I = S
                                                    ===> borrarAEmplDeLosSectores tiene costo O( (log E + log S) * S)


    borrarEmpleado:
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa
        - fromJust tiene costo O(1), se desestima
        - lookupM tiene costo O(log E), ya que trabaja sobre el map que contiene a todos los empleados de la empresa
        - sectores tiene costo O(S)
        - borrarAEmplDeLosSectores tiene costo O( (log E + log S) * S)
        - deleteM tiene costo O(log E), ya que trabaja sobre el map que contiene a todos los empleados de la empresa

        ==> borrarEmpleado tiene costo O(log E +  (log E + log S) * S + log E)
                                       O(log E + S * log E + S * log S + log E) --> los termino multiplicados por S ((S * log E) y (S* log S))absorbe a los terminos mas pequeños (log E y log S)
                                   --> O(S * log E + S * log S) 
                                   
                    =====> borrarEmpleado tiene costo ==> O(S * (log E + log S))
-}






---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ejercicio 5
--Como usuario del tipo Empresa implementar las siguientes operaciones, calculando el costo obtenido al implementarlas, y justificando cada uno adecuadamente.


comenzarCon :: [SectorId] -> [CUIL] -> Empresa
--Propósito: construye una empresa con la información de empleados dada. Los sectores no tienen empleados.
--Costo: calcular.
comenzarCon sectores cuils = agregarEmpleados cuil (agregarSectores sectores consEmpresa)

agregarSectores :: [SectorId] -> Empresa -> Empresa
agregarSectores    []    empresa = empresa
agregarSectores (id:ids) empresa = agregarSector id (agregarSectores ids empresa)


agregarEmpleados :: [CUIL] -> Map CUIL Empleado
agregarEmpleados   []   empresa = empresa
agregarEmpleados (c:cs) empresa = agregarEmpleado [] (agregarEmpleados cs empresa)



{-
    COSTO:
        agregarEmpleados
            - C es la cantidad de elementos en la lista de CUILs ingresada por argumento
            agregarEmpleado tiene costo  O( I (log S +log E) ) --> I = O xq paso una lista vacía siempre???, lo tomo como valor desestimable --> I es absorbido --> O( log S +log E )
                - E es la cantidad de empleados en la empresa
                - S es cantidad de sectores en la empresa

            --> agregarEmpleados tiene costo O(C * ( log S +log E ))
            ==> como mi empresa está inicialmente vacía, mi empresa va a terminar teniendo C empleados, Por lo que C = E

            ==> O(E * ( log S +log E ))



        agregarSectores
            - E es la cantidad de empleados en la empresa
            - S es cantidad de sectores en la empresa
            - I es la cantidad de SectoresId en la lista ingresada por argumento

            - agregarSector tiene costo O(log S)

            ==> agregarSectores tiene costo O(I* log S), como inicialmente mi empresa esta vacía, entonces mi empresa va a terminar teniendo I empleados en el peor caso
            ===> como I = E ==> agregarSectores tiene costo O(S * log S)


        ==> comenzarCon :
            - agregarEmpleados tiene costo O(E * ( log S +log E ))
            - agregarSectores tiene costo O(S * log S)

            ==> comenzarCon tiene costo O( E * ( log S +log E ) + S * log S) , ya que se realizan ambas operaciones de manera independiente, de manera secuencial
                                        O( E * log S + E * log E + S * log S)
                                        O( (E+S) * log S + E * log E )

-}



recorteDePersonal :: Empresa -> Empresa
--Propósito: dada una empresa elimina a la mitad de sus empleados (sin importar a quiénes).
--Costo: calcular.
recorteDePersonal empresa = let cuils = todosLosCUIL empresa
                                cantCuilsABorrar = lenght cuils / 2
                                in 
                            borrarLosprimerosNEmpleados cuils cantCuilsABorrar empresa


borrarLosprimerosNEmpleados :: [CUIL] -> Int -> Empresa -> Empresa
-- Precondicion: el largo de la lista debe ser igual o mayor al n ingresado por argumento
borrarLosprimerosNEmpleados    _   0 empresa = empresa
borrarLosprimerosNEmpleados (c:cs) n empresa = borrarEmpleado c (borrarLosprimerosNEmpleados cs (n-1) empresa)


{-
    borrarLosprimerosNEmpleados:
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa
        - n el numero ingresado por argumento 
        - borrarEmpleado tiene costo ==> O(S * (log E + log S))
        
        ==> borrarLosprimerosNEmpleados tiene costo O(N * (S * (log E + log S))), donde N es la mitad de los empleados de la empresa


    recorteDePersonal:
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa
        - N es la mitad de los emleados de la empresa

        - todosLosCUIL tiene costo O(E)
        - lenght tiene costo O(E)
        - borrarLosprimerosNEmpleados tiene costo O(N * (S * (log E + log S)))

        ==> recorteDePersonal tiene costo O( E + E + N * (S * (log E + log S)) )
                                          O(  2*E  + N * (S * (log E + log S)) )
                                          O( E + N * (S * (log E + log S)) )
                                          O( E + N * S * (log E + log S))

-}





convertirEnComodin :: CUIL -> Empresa -> Empresa
--Propósito: dado un CUIL de empleado le asigna todos los sectores de la empresa.
--Costo: calcular.
convertirEnComodin cuil empresa = let sectores = todosLosSectores empresa
                                    in agregarEmpleado sectores cuil empresa
    

{-

    convertirEnComodin
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa 
        - todosLosSectores tiene costo O(S)
        - agregarEmpleado tiene costo  O( I (log S +log E), donde I es la cantidad de sectores en la lista ingresada por argumento. Como en este caso estoyu sando 
                    la lista de todos los sectores de la empresa --> I = S
                    ==> agregarEmpleado tiene costo  O( S (log S +log E))



        ==> convertirEnComodin tiene costo O(S + S (log S +log E)), donde el termino lineal S se absorbe ya que crece mucho más lento que el otro
            ==> convertirEnComodin tiene costo O(S (log S +log E))  

-}


esComodin :: CUIL -> Empresa -> Bool
--Propósito: dado un CUIL de empleado indica si el empleado está en todos los sectores.
--Costo: calcular.
esComodin cuil empresa = let sectores = todosLosSectores empresa
                             empleado = buscarPorCUIL cuil empresa
                             sectoresEmpleado = sectores empleado
                             in todosPertenecen sectores sectoresEmpleado


todosPertenecen :: [SectorId] -> [SectorId] -> Bool
todosPertenecen    []    sectoresEmpleado = False -- xq si no hay sectores quiero que me de false
todosPertenecen    [id]    sectoresEmpleado =  elem id sectoresEmpleado -- pero no quiero que me de false como caso base
todosPertenecen (id:ids) sectoresEmpleado = elem id sectoresEmpleado && todosPertenecen ids sectoresEmpleado

{-
    todosPertenecen
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa 
        - I es la cantidad de sectores en la segunda lista ingresada por argumento
        - elem tiene costo O(I), ya que trabaja con la 2da lista.

        ==> todosPertenecen tiene costo O(S * I) , donde mi peor caso sería que la 2da lista de ids contenga a todos los sectores de la lista --> I = S
            ==> todosPertenecen tiene costo O(S^2)

    esComodin:
        - E es la cantidad de empleados en la empresa
        - S es cantidad de sectores en la empresa
        - todosPertenecen tiene costo O(S^2)
        - todosLosSectores tiene costo O(S)
        - buscarPorCUIL tiene costo O(log E)
        - sectores tiene costo O(S)

        ==> esComodin tiene costo O(S^2 + S + log E + S)
                                  O(S^2 + 2 * S + log E) --> el termino cuadratico S^2 absorbe el termino lineal 2*S
                                  O(S^2 + log E)

-}
                    








```haskell
------------------------------
--RECOPILAR ELEMENTOS DEL MAP: O(N) --> donde N es la cantidad de claves del map
------------------------------
valuesMap :: Map k v  -> [k] ->  [v]
valuesMap map   []   = []
valuesMap map (c:cs) = c : valuesMap cs
------------------------------
--RECOPILAR ELEMENTOS DE LA PriorityQueue: O(N) --> donde N es la cantidad de elementos de la PQ
------------------------------
valuesPQ :: PriorityQueue a -> [a]
valuesPQ pq = if isEmptyPQ pq
                then []
                else findMinPQ pq : valuesPQ (deleteMin pq)
------------------------------
--RECOPILAR ELEMENTOS DEL MultiSet: --> donde N es la cantidad de elementos del MS
------------------------------
ya existe: multiSetToList que tiene costo O(N)
------------------------------
--RECOPILAR ELEMENTOS DEL Set: O(N) --> donde N es la cantidad de elementod del Set
------------------------------
ya existe: setToList que tiene costo O(N) 
------------------------------
--RECOPILAR ELEMENTOS DEL Stack: O(N) --> donde N es la cantidad de elementod del Stack
------------------------------
valuesStack :: Stack a -> [a]
valuesStack stack = if isEmptyS stack
                        then []
                        else top stack : valuesStack (pop stack)
------------------------------
--RECOPILAR ELEMENTOS DE LA Queue: O(N) --> donde N es la cantidad de elementod de la Queue
------------------------------
valuesQueue :: Queue a -> [a]
valuesQueue q = if isEmptyQ q then []
                              else firstQ q : valuesQueue (dequeue q)
------------------------------
--RECOPILAR ELEMENTOS DE LA MaxHeap: O(N) 
------------------------------
valuesMaxHeap :: MaxHeap a -> [a]
valuesMaxHeap mh = if isEmptyH mh
                        then []
                        else maxH mh : valuesMaxHeap (deleteH mh)
------------------------------
--RECOPILAR ELEMENTOS DE LA Heap: O(N) --> donde N es la cantidad de elementod de la Heap
------------------------------
valuesHeap :: Heap a -> [a]
valuesHeap heap = if isEmptyH heap
                        then []
                        else minH mh : valuesHeap (deleteH mh)

```




