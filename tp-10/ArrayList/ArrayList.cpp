#include <iostream>
using namespace std;
#include "ArrayList.h"




ArrayList newArrayList(){
//Crea una lista con 0 elementos.
//Nota: empezar el array list con capacidad 16.
    ArrayList arrayL = new ArrayListSt;
    int xs[16];

    arrayL -> cantidad = 0;
    arrayL -> capacidad = 16;
    arrayL -> elementos = xs;

    return arrayL;
}



ArrayList newArrayListWith(int capacidad){
//Crea una lista con 0 elementos y una capacidad dada por parámetro.
    ArrayList arrayL = new ArrayListSt;
    int xs[capacidad];

    arrayL -> cantidad = 0;
    arrayL -> capacidad = capacidad;
    arrayL -> elementos = xs;

    return arrayL;
}


int lengthAL(ArrayList xs){
//Devuelve la cantidad de elementos existentes.
    return xs->cantidad;
}


int get(int i, ArrayList xs){
//Devuelve el iésimo elemento de la lista.
    return xs->elementos[i];
}

void set(int i, int x, ArrayList xs){
//Reemplaza el iésimo elemento por otro dado.
    xs->elementos[i] = x;

}

void resize(int capac, ArrayList xs){
//Decrementa o aumenta la capacidad del array.
//Nota: en caso de decrementarla, se pierden los elementos del final de la lista.
    int ys[capac];

    for(int i=0; (i<capac) && ( i < xs->capacidad) ; i++){
        ys[i] = xs->elementos[i];
    }

    xs->elementos = ys;

}

void add(int x, ArrayList xs){
//Agrega un elemento al final de la lista.

    if (xs-> capacidad != xs->cantidad){
        xs -> elementos [xs->cantidad] = x; // en la primera posicion sin ocupar pongo el elemento x
        xs -> cantidad += 1;
    }

}


void remove(ArrayList xs){
//Borra el último elemento de la lista.
    // Borrarlo seria que en la memoria haya basura, osea q lo unico q cambio es la cantidad de elementos, no?
    if ( xs-> cantidad >0){
        xs-> cantidad -= 1;
    }
}




