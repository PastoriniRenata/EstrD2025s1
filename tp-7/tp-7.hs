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
        - tiene un costo de O( n * log n + n * log n), se suman xq se ejecutan secuencialmente y no 
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


{-
insertBST :: Ord a => a -> Tree a -> Tree a
--Propósito: dado un BST inserta un elemento en el árbol.
--Costo: O(log N)



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






