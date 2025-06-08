#include <iostream>
#include "LinkedList.h"
using namespace std;



LinkedList nil(){
//Crea una lista vacía.
    LinkedList list = new LinkedListSt;

    list->cantidad = 0;
    list->primero = NULL;

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

    NodoL n = new NodoL;

    n->elem = x;
    n->siguiente = xs->primero;

    xs->primero = n;
    xs->cantidad++;

}


void Tail(LinkedList xs){
//Quita el primer elemento.
/*
    me guardo el nodo en una variable para poder borrarlo de memoria

    reapunto el cabezal al siguiente de este

    borro de memoria el nodo

*/

    NodoL temp = xs->primero;

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
    ListIterator actual = xs->siguiente;

    while(actual)
}

ListIterator getIterator(LinkedList xs){}
//Apunta el recorrido al primer elemento.



int current(ListIterator ixs){}
//Devuelve el elemento actual en el recorrido.



void SetCurrent(int x, ListIterator ixs){}
//Reemplaza el elemento actual por otro elemento.



void Next(ListIterator ixs){}
//Pasa al siguiente elemento.



bool atEnd(ListIterator ixs){}
//Indica si el recorrido ha terminado.



void DisposeIterator(ListIterator ixs){}
//Libera la memoria ocupada por el iterador.



void DestroyL(LinkedList xs){}
//Libera la memoria ocupada por la lista.







