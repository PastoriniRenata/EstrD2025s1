#include <iostream>
using namespace std;
#include "Set.h"

//PARA CORRERLO POR TERMINAL: g++ -o prueba Set-main.cpp Set.cpp LinkedList.cpp   


// Función auxiliar para imprimir el Set usando
void printSet(Set s) {
    NodoS* nodo = s->primero;

    cout << "[ ";
    while (nodo != NULL) {
        cout << nodo->elem << " ";
        nodo = nodo->siguiente;
    }
    cout << "]" << endl;
}

int main() {
    //   Set   /
    Set miSet = emptyS();

    cout << "agrego 1, 2 y 3 al set." << endl;
    AddS(1, miSet);
    AddS(2, miSet);
    AddS(3, miSet);
    printSet(miSet);  // Esperado (en orden inverso al agregado): [ 3 2 1 ]

    cout << "pertenece 2? " << (belongsS(2, miSet) ? "si" : "no") << endl;
    cout << "pertenece 4? " << (belongsS(4, miSet) ? "si" : "no") << endl;

    cout << "elimino el 2:" << endl;
    RemoveS(2, miSet);
    printSet(miSet);  // Esperado: [ 3 1 ]

    cout << "elimino el 3:" << endl;
    RemoveS(3, miSet);
    printSet(miSet);  // Esperado: [ 1 ]

    cout << "elimino el 1:" << endl;
    RemoveS(1, miSet);
    printSet(miSet);  // Esperado: [ ]

    cout << "esta vacio? " << (isEmptyS(miSet) ? "si" : "no") << endl;

    DestroyS(miSet);
    cout << "set destruido bip bop " << endl;

    //   Queue   

    return 0;
}