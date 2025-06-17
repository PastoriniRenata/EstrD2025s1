#include <iostream>
using namespace std;
#include "LinkedList.h"


struct NodoS {
    int elem; // valor del nodo
    NodoS* siguiente; // puntero al siguiente nodo
};

struct SetSt {
    int cantidad; // cantidad de elementos diferentes
    NodoS* primero; // puntero al primer nodo
};

typedef SetSt* Set;

Set emptyS();
//Crea un conjunto vacío.

bool isEmptyS(Set s);
//Indica si el conjunto está vacío.

bool belongsS(int x, Set s);
//Indica si el elemento pertenece al conjunto.

void AddS(int x, Set s);
//Agrega un elemento al conjunto.

void RemoveS(int x, Set s);
//Quita un elemento dado.

int sizeS(Set s);
//Devuelve la cantidad de elementos.

LinkedList setToList(Set s);
//Devuelve una lista con los lementos del conjunto.

void DestroyS(Set s);
//Libera la memoria ocupada por el conjunto.
