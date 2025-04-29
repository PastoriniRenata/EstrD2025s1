{-
Ejercicio 1
Indicar el costo de heapsort :: Ord a => [a] -> [a] (de la práctica anterior) suponiendo que
el usuario utiliza una priority queue con costos logarítmicos de inserción y borrado (o sea, usa una
Heap como tipo de representación).

-}
heapSort :: Ord a => [a] -> [a]
heapSort xs = pqALista (listaAPq xs)

listaAPq :: Ord a => [a] -> PriorityQueue a
listaAPq   []   = emptyPQ
listaAPq (x:xs) = insertPQ x (listaAPq xs)


pqALista :: Ord a => PriorityQueue a -> [a]
pqALista pq = if isEmptyPQ pq then []
                              else findMinPQ pq : pqALista (deleteMinPQ pq)


{-
    - n es la cantidad de elementos de la lista ingresada como argumento

    listaAPq:
        - emptyPQ tiene un costo O(1), se desestima
        - insertPQ tiene un costo O(log m) en el peor caso, donde m es el tamaño actual de la PQ
        ==> listaAPq tiene un costo O(n * (log m)) ya que hace una operacion logaritmica por cada llamado recursivo sobre la lista. Y como estoy calculando
                    el peor caso y la PQ va a terminar teniendo la misma cantidad de elementos que en la lista ingresada
                ==> n = m -> O(n *(log m)) = O( n * (log n))

    pqALista:
        - isEmptyPQ tiene costo O(1), se desestima
        - findMinPQ tiene costo O(1), se desestima
        - deleteMinPQ tiene costo O(log n), se desestima

        ==> pqALista tiene osto O(n * (log n)), donde n es la cantidad de elementos de la PQ ingresada por argumento, y donde por cada llamado 
                recursivo hace operaciones logaritmica (deleteMinPQ) (basicamente xq necesito acceder a TODOS los elementos de la PQ y cuando los borra tiene costo (log m))
            
    heapSort:
        - tiene un costo de O( n * (log n) + n * (log n)), se suman xq se ejecutan secuencialmente (no se si esta bien dicho) y no 
            dependen una d la otra para existir el termino lineal se desestima por 
            ser el mas chico --> O(n * (1+n)) --> O(n * n) --> O(n^2)
        

-}










