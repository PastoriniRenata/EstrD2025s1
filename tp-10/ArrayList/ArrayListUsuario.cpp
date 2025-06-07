#include "ArrayList.h"
#include <iostream>
using namespace std;



//Definir las siguientes funciones utilizando la interfaz de ArrayList:
int sumatoria(ArrayList xs){
//Devuelve la suma de todos los elementos.
    int* sum = 0;

    for(int i = 0; i<lengthAL(xs); i++){
        sum += get(i, xs);
    }

    return sum;
}



void sucesores(ArrayList xs){
//Incrementa en uno todos los elementos.
    for(int i = 0; i<lengthAL(xs); i++){
        set(i, get(i, xs)+1, xs);
    }
}

bool pertenece(int x, ArrayList xs){
//Indica si el elemento pertenece a la lista.
    bool perten = false; // es mala practica usar un acumulador???
    for(int i = 0; i<lengthAL(xs) ; i++){
        perten = perten || get(i, xs) == x ;
    }

    return perten;
}

int apariciones(int x, ArrayList xs){
//Indica la cantidad de elementos iguales a x.
    int cantRepeticiones = 0;
    for(int i = 0; i<lengthAL(xs) ; i++){
        if(get(i, xs) == x){ cantRepeticiones++ }
    }

    return cantRepeticiones;
}



void agregarTodosAlArray(ArrayList xs, ArrayList arrayL){
//Precondicion: arrayL tiene igual capacidad o superior a xs

    for(int i = 0; i<xs->cantidad ; i++){
        
    }
    
}


ArrayList append(ArrayList xs, ArrayList ys){
//Crea una nueva lista a partir de la primera y la segunda (en ese orden).
    ArrayList arrayL = newArrayListWith( xs->capacidad + ys->capacidad);

    arrayL -> cantidad = xs->cantidad + ys->cantidad;

    agregarTodosAlArray(xs, arrayL);
    agregarTodosAlArray(ys, arrayL);

    
    return arrayL;

}






int minimo(ArrayList xs){
//Devuelve el elemento más chico de la lista.

}




