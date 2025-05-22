#include <iostream>
using namespace std;
#include "Par.h"
/*Aca armo las funciones de la practica!!!*/




/*
Ejercicio 3
Dada la estructura de pares representada como struct en C++, definir las siguientes funciones
sobre pares. Recordar probar las implementaciones en un procedimiento main.
*/
struct Par {
    int x;
    int y;
};


// Propósito: construye un par
Par consPar(int x, int y){
    Par unPar;
    unPar.x = x;
    unPar.y = y;
    
    return unPar;
};

// Propósito: devuelve la primera componente
int fst(Par p){
    return 0;
};

// Propósito: devuelve la segunda componente
int snd(Par p){
    return 0;
};
// Propósito: devuelve la mayor componente
int maxDelPar(Par p){
    return 0;
};
// Propósito: devuelve un par con las componentes intercambiadas
Par swap(Par p){
    Par unPar;
    unPar.x = p.y;
    unPar.y = p.x;
    
    return unPar;
};
// Propósito: devuelve un par donde la primer componente
// es la división y la segunda el resto entre ambos números
Par divisionYResto(int n, int m){
    Par unPar;
    unPar.x = n;
    unPar.y = m;
    
    return unPar;
};