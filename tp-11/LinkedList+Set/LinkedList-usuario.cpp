#include <iostream>
using namespace std;
#include "LinkedList.h"


int sumatoria(LinkedList xs){
//Devuelve la suma de todos los elementos.
    ListIterator iterador = getIterator(xs);
    int rta = 0;

    while(!atEnd(iterador)){
        rta += current(iterador);
        Next(iterador);
    }

    DisposeIterator(iterador);
    DestroyL(xs); // ????

    return rta;
}


void Sucesores(LinkedList xs){
//Incrementa en uno todos los elementos.
    ListIterator iterador = getIterator(xs);

    while(!atEnd(iterador)){
        SetCurrent( current(iterador) + 1 , iterador);
        Next(iterador);
    }
    DisposeIterator(iterador);
}


bool pertenece(int x, LinkedList xs){
//Indica si el elemento pertenece a la lista.
    ListIterator iterador = getIterator(xs);
    
    bool encontrado = false;
    while(!atEnd(iterador) && !encontrado) {
        encontrado = current(iterador) == x;

        Next(iterador);
    }
    DisposeIterator(iterador);
    
    return encontrado;
}


int apariciones(int x, LinkedList xs){
//Indica la cantidad de elementos iguales a x.
    ListIterator iterador = getIterator(xs);
    int rta = 0;

    while(!atEnd(iterador)){
        if(current(iterador) == x){
            rta ++;
        }

        Next(iterador);
    }
    DisposeIterator(iterador);

    return rta;
}


int minimo(LinkedList xs){
//Devuelve el elemento más chico de la lista.

// obs (mia): no puede ser una lista vacía!!??!!??

    ListIterator iterador = getIterator(xs); // primer elemento de la lista.
    int min = current(iterador); // primer elemento de la lista.


    while(!atEnd(iterador)){

        if(current(iterador)< min ){ // va a comparar el primero de la lista con él mismo, pero no pasa nada.
            min = current(iterador);
        }

        Next(iterador);
    }

    DisposeIterator(iterador);
    
    return min;
}


LinkedList copy(LinkedList xs){
//Dada una lista genera otra con los mismos elementos, en el mismo orden.
//Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
    ListIterator iterador = getIterator(xs); // primer elemento de la lista.
    LinkedList ys = nil();

    while(!atEnd(iterador)){
        Snoc(current(iterador), ys);

        Next(iterador);
    }

    DisposeIterator(iterador);
    return ys;

}


void Append(LinkedList xs, LinkedList ys){
//Agrega todos los elementos de la segunda lista al final de los de la primera.
//La segunda lista se destruye.
//Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
    ListIterator iterador = getIterator(ys); // primer elemento de la lista.

    while(!atEnd(iterador)){
        Snoc(current(iterador), xs);
        Next(iterador);
    }

    DisposeIterator(iterador);
    DestroyL(ys);
}



// Función auxiliar para mostrar la lista
void mostrarLista(LinkedList xs) {
    ListIterator it = getIterator(xs);
    
    cout << "[ ";
    while (!atEnd(it)) {
        cout << current(it) << " ";
        Next(it);
    }
    
    cout << "]" << endl;
    DisposeIterator(it);
}

int main() {
    // Crear lista vacía
    LinkedList lista = nil();
    
    // Agregar elementos: [1, 2, 3]
    Cons(3, lista);
    Cons(2, lista);
    Cons(1, lista);
    
    cout << "Lista original: ";
    mostrarLista(lista);
    // Snoc agrega al final
    Snoc(4, lista);
    Snoc(5, lista);
    cout << "Despues de Snoc(4) y Snoc(5): ";
    mostrarLista(lista);

    // Sumatoria
    cout << "Sumatoria: " << sumatoria(lista) << endl;

    // Sucesores
    Sucesores(lista);
    cout << "Despues de sucesores: ";
    mostrarLista(lista);

    // Pertenece
    cout << "Pertenece 3? " << pertenece(3, lista) << endl;
    cout << "Pertenece 99? " << pertenece(99, lista) << endl;

    // Apariciones
    Snoc(3, lista);
    Snoc(1, lista);

    
    cout << "Despues de agregar otro 3 y un 1: ";
    mostrarLista(lista);
    cout << "Apariciones de 3: " << apariciones(3, lista) << endl;


    // Mínimo
    cout << "Minimo: " << minimo(lista) << endl;

    // Copiar lista
    LinkedList copia = copy(lista);
    cout << "Copia de la lista: ";
    mostrarLista(copia);

    // Append
    LinkedList otra = nil();
    Cons(100, otra);
    Cons(200, otra);
    cout << "Otra lista: ";
    mostrarLista(otra);

    Append(lista, otra); // ahora lista tiene todo
    cout << "Lista despues de append con otra: ";
    mostrarLista(lista);

    // Liberar memoria
    DestroyL(lista);
    DestroyL(copia);
    
    return 0;
}








