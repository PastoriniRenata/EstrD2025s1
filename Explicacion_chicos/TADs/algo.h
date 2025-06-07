#include <iostream> // Inclusión de biblioteca estándar de entrada/salida
using namespace std; // BÁSICOS en todos los archivos


struct RepresentacionPar { 
    int x;
    int y;
};

// --> Equivalente al 'type' de Haskell
typedef RepresentacionPar Par; // Alias: Par representa la implementación oculta


Par consPar(int x, int y); // Propósito: construye un par
int fst(Par p); // Propósito: devuelve la primera componente
int snd(Par p); // Propósito: devuelve la segunda componente
int maxDelPar(Par p); // Propósito: devuelve la mayor componente
Par swap(Par p); // Propósito: devuelve un par con las componentes intercambiadas
Par divisionYResto(int n, int m); // Propósito: devuelve un par donde la primer componente es la división y la segunda el resto entre ambos números


