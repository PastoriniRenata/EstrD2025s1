#include <iostream>
using namespace std;
#include "Set.h"

Set emptyS(){
//Crea un conjunto vacío.
    SetSt* set = new SetSt;

    set -> cantidad = 0;
    set-> primero = NULL;

    return set;
}

bool isEmptyS(Set s){
//Indica si el conjunto está vacío.
    return s -> cantidad == 0;
}

//----------------------------------------------------------------------------

bool pertenece (int x, NodoS* ns){
    // indica si el elemento es el nodo actual o algun ode los nodos sujetos a él?
    //bool existe = false;
    NodoS* temp = ns;

    while( temp != NULL && temp->elem != x){
        //existe = temp->elem == x;
        temp = temp->siguiente;
    }
//    delete temp; --> NO HACE FALTA BORRARLA XQ ES UNA VARIABLE LOCAL DEL TIPO PUNTERO QUE VA A FUNCIONAR SOLO DENTRO DE LA FUNCION

    return temp != NULL ; //existe
}

bool belongsS(int x, Set s){
//Indica si el elemento pertenece al conjunto.
    return pertenece(x, s->primero);
}

//----------------------------------------------------------------------------


void AddS(int x, Set s){
//Agrega un elemento al conjunto.
    if( !pertenece(x, s->primero)){
        NodoS* n = new NodoS;
        n -> elem = x;
        n->siguiente = s->primero; 

        s->primero = n;
        s->cantidad ++;
    }

}

void RemoveS(int x, Set s){
//Quita un elemento dado.
    NodoS* curr = s->primero;
    
    if(curr != NULL && curr->elem == x){
        s->primero = curr->siguiente;
        s->cantidad--;
        delete curr;
        return;
    }

/* ES VALIDO, PÉRO ES MALA PRACTICA HACERLO ASÍ: 

    while(curr != NULL){
        if(curr->siguiente != NULL && curr->siguiente->elem == x){
            NodoS* temp = curr->siguiente;
            curr->siguiente = temp -> siguiente;
            s->cantidad --;

            delete temp;
            break;
        }

        curr = curr->siguiente;  
    
    }


*/
//MEJOR HACERLO ASÍ!:
    while(curr != NULL && curr->siguiente != NULL ){
        if(curr->siguiente->elem == x){
            NodoS* temp = curr->siguiente;
            curr->siguiente = temp -> siguiente;
            s->cantidad --;

            delete temp;
            break;
        }

        curr = curr->siguiente;  
    
    }
}

int sizeS(Set s){
//Devuelve la cantidad de elementos.
    return s->cantidad;
}



void DestroyS(Set s){
//Libera la memoria ocupada por el conjunto.
    NodoS* actual = s->primero;
    
    while( actual != NULL ){
        NodoS* temp = actual->siguiente; 
        delete actual;

        actual = temp;
 
    }
 
    delete s;

}



LinkedList setToList(Set s){
//Devuelve una lista con los lementos del conjunto.
    LinkedList xs = nil();

    NodoS* curr = s->primero;
    
    while (curr != NULL){
        Cons(curr->elem , xs);
    }

    delete curr;
    DestroyS(s);

    return xs;
    
}


