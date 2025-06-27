#include <iostream>
using namespace std;
#include "Arboles-BFS.h"
//#include "Queue.h"



/*

EJERCICIO 8


          10
         /  \
        3    5 
       / \    \
      7   8    30

*/
int sumarT(Tree t){
//Dado un árbol binario de enteros devuelve la suma entre sus elementos.
    Queue colacha = emptyQ();
    int suma = 0;

    if(!isEmptyT(t)){
        Enqueue(t, colacha);
    }
    cout<< "llega aca" << endl;
    while(!isEmptyQ(colacha)){
        Tree actual = firstQ(colacha);
        cout<< "llega aca 2" << endl;

        Dequeue(colacha);
        cout<< "llega aca 3" << endl;

        suma += rootT(actual);
        cout<< "llega aca 4" << endl;

        if(!isEmptyT(left(actual))){
            cout<< "llega aca 5" << endl;

            Enqueue(left(actual), colacha);

            

        }

        if(!isEmptyT(right(actual))){
            

            Enqueue(right(actual), colacha);

            

        }

    }

    DestroyQ(colacha);

    return suma;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

int sizeT(Tree t){
//Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árb ol (size
//en inglés).
    Queue colacha = emptyQ();
    int cantElementos = 0;

    if(!isEmptyT(t)){
        Enqueue(t, colacha);
    }

    while(!isEmptyQ(colacha)){
        Tree actual = firstQ(colacha);
        Dequeue(colacha);
        cantElementos++ ;

        if(!isEmptyT(left(actual))){
            Enqueue(left(actual), colacha);
        }

        if(!isEmptyT(right(actual))){
            Enqueue(right(actual), colacha);
        }

    }

    DestroyQ(colacha);

    return cantElementos;

}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bool perteneceT(int e, Tree t){
//Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el
//árbol.
    Queue colacha = emptyQ();

    if(!isEmptyT(t)){
        Enqueue(t, colacha);
    }

    while(!isEmptyQ(colacha) && rootT(firstQ(colacha)) != e){

        Tree actual = firstQ(colacha);
        Dequeue(colacha);

        if(!isEmptyT(left(actual))){
            Enqueue(left(actual), colacha);
        }

        if(!isEmptyT(right(actual))){
            Enqueue(right(actual), colacha);
        }

    }
    
    bool pertenece = !isEmptyQ(colacha) && rootT(firstQ(colacha)) == e;

    DestroyQ(colacha);

    return pertenece;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


int aparicionesT(int e, Tree t){
//Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son
//iguales a e.
    Queue colacha = emptyQ();
    int apariciones = 0;

    if(!isEmptyT(t)){
        Enqueue(t, colacha);
    }

    while(!isEmptyQ(colacha)){

        Tree actual = firstQ(colacha);
        Dequeue(colacha);
        apariciones += (rootT(actual) == e) ? 1 : 0 ;

        if(!isEmptyT(left(actual))){
            Enqueue(left(actual), colacha);
        }

        if(!isEmptyT(right(actual))){
            Enqueue(right(actual), colacha);
        }

    }

    DestroyQ(colacha);

    return apariciones;
}



//------------------------------------------------------------------------------------------------------------------------------------



ArrayList toList(Tree t){
//Dado un árbol devuelve una lista con to dos sus elementos.
    Queue colacha = emptyQ();
    int apariciones = 0;
    ArrayList lista = newArrayList();

    if(!isEmptyT(t)){
        Enqueue(t, colacha);
    }

    while(!isEmptyQ(colacha)){

        Tree actual = firstQ(colacha);
        Dequeue(colacha);

        add(rootT(actual), lista);

        if(!isEmptyT(left(actual))){
            Enqueue(left(actual), colacha);
        }

        if(!isEmptyT(right(actual))){
            Enqueue(right(actual), colacha);
        }

    }

    DestroyQ(colacha);

    return lista;
}




