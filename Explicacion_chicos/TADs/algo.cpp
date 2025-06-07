#include "algo.h" // Incluye el archivo de cabecera con la interfaz del TAD Par
#include <iostream> // Necesario para mostrar por consola con cout
using namespace std;


Par consPar(int x, int y){
// Propósito: construye un par
    Par unPar;

    unPar.x = x;
    unPar.y = y;
    
    return unPar;
} 


int fst(Par p){ // Propósito: devuelve la primera componente
    return p.x;
}

int snd(Par p){ // Propósito: devuelve la segunda componente
    return p.y;
}

int maxDelPar(Par p){ // Propósito: devuelve la mayor componente
    return (p.x > p.y) ? p.x : p.y ;
/*
    if(p.x>p.y){
        return p.x;
    }else{
        return p.y;
    }
*/  
}

Par swap(Par p){ // Propósito: devuelve un par con las componentes intercambiadas
    //return consPar(p.y, p.x); // es valido llamar a la otra fucnion xq estamos en memoria estatica

    Par unPar;

    unPar.x = p.y;
    unPar.y = p.x;

    return unPar;
}

Par divisionYResto(int n, int m){ // Propósito: devuelve un par donde la primer componente es la división y la segunda el resto entre ambos números
    return consPar( n/m , n%m);
}                  