#include "ArrayList.h"
#include <iostream>
using namespace std;

// AUX. para mostrar la lista
void PrintList(ArrayList xs) {
    cout << "[" ;
    for (int i = 0; i < lengthAL(xs); i++) {
        cout << get(i, xs) << ", ";
    }
    cout << "]" << endl;
}

int main() {
    
    ArrayList list = newArrayList();
    cout << "lista nueva: capacidad (16) -> " << list->capacidad << " cantidad (0) -> " << list->cantidad << endl;

    for (int i = 1; i <= 5; i++) {
        add(i * 10, list);
    }
    cout << "despues de agregar 5 elementos: ";
    PrintList(list);

    set(2, 99, list);
    cout << "despues de set(2, 99): ";
    PrintList(list);

    remove(list);
    cout << "despues de remove(): ";
    PrintList(list);

    resize(20, list);
    cout << "despues de resize(20): capacidad: " << list->capacidad << ", cantidad: " << list->cantidad << endl;

    add(100, list);
    add(200, list);
    cout << "despues de agregar 100 y 200: ";
    PrintList(list);

    resize(3, list);
    cout << "despues de resize(3): ";
    PrintList(list);

    ArrayList newList = newArrayListWith(5);
    cout << "lista personalizada  capacidad -> " << newList->capacidad << " cantidad -> " << newList->cantidad << endl;

    cout << "prueba de limites - get(10): ";
    int valor = get(10, list);
    cout << valor << endl;


    return 0;
}