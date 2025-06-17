#include <iostream>
using namespace std;
#include "LinkedListV2.h"



LinkedList nil(){
//Crea una lista vacía.
    LinkedListSt* list = new LinkedListSt;

    list->cantidad = 0;
    list->primero = NULL;
    list->ultimo = NULL;

    return list;

}


bool isEmpty(LinkedList xs){
//Indica si la lista está vacía.
    return xs->cantidad == 0;
}

int head(LinkedList xs){
//Devuelve el primer elemento.
    return (xs->primero) -> elem;
}

void Cons(int x, LinkedList xs){
//Agrega un elemento al principio de la lista.
/*
    crear el elemento

    su siguiente va a ser el que actualmente es el 1er elemento de la linked list

    hacer que el cabezal de la linkedList esté apuntando a el elemento q creé
*/
    NodoL* n = new NodoL;
    n->elem = x;
    n->siguiente = xs->primero;

    xs->primero = n;
    
    if(xs->cantidad == 0){
        xs->ultimo = n;
    }
    xs->cantidad++;

}

void Tail(LinkedList xs){
//Quita el primer elemento.
/*
    me guardo el nodo en una variable para poder borrarlo de memoria

    reapunto el cabezal al siguiente de este

    borro de memoria el nodo

*/
    NodoL* temp = xs->primero;

    xs-> primero = temp->siguiente;

    xs->cantidad--;
    
    delete temp;
}

int length(LinkedList xs){
//Devuelve la cantidad de elementos.
    return xs->cantidad;
}

void Snoc(int x, LinkedList xs){
//Agrega un elemento al final de la lista.
    /*
        Creo el nodo del nuevo elemento con el siguiente como NULL
        
        agarro el ultimo de xs y hago q apunte e este como siguiente 
        
        Hago q el ultimo elemento de la estructura apunte a este

    */

    NodoL* n = new NodoL;

    n-> elem = x;
    n-> siguiente = NULL;     
    
    if(xs->primero == NULL ){
        xs->primero = n;
    }else{
        xs->ultimo->siguiente = n;
    }
    
    xs->ultimo = n;
    xs->cantidad ++;

}





// LISTITERATOR

ListIterator getIterator(LinkedList xs){
//Apunta el recorrido al primer elemento.
    IteratorSt* iterator = new IteratorSt;

    iterator -> current = xs->primero;

    return iterator;
}


int current(ListIterator ixs){
//Devuelve el elemento actual en el recorrido.
    return ixs->current->elem;
}


void SetCurrent(int x, ListIterator ixs){
//Reemplaza el elemento actual por otro elemento.
    ixs->current->elem = x;
}


void Next(ListIterator ixs){
//Pasa al siguiente elemento.
    ixs->current = ixs->current->siguiente;
}


bool atEnd(ListIterator ixs){
//Indica si el recorrido ha terminado.
    return ixs->current == NULL;
}


void DisposeIterator(ListIterator ixs){
//Libera la memoria ocupada por el iterador.
    delete ixs;
}

void DestroyL(LinkedList xs){
//Libera la memoria ocupada por la lista.
    delete xs;
}






