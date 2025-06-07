#include "algo.h" // Incluye el archivo de cabecera con la interfaz del TAD Par
#include <iostream> // Necesario para mostrar por consola con cout
using namespace std;

int main(){
    Par p = consPar(4, 2);

    cout << "El primer valor del par es: " << fst(p) << endl;

    cout << "El segundo valor del par es: " << snd(p) << endl;

    cout << "El maximo del par es:" << maxDelPar(p) << endl;

    Par p2 = swap(p);

    cout << "El par swapeado: (" << fst(p2) << "," << snd(p2) << ")" << endl;

    Par p3 = divisionYResto(6, 3);

    cout << "El primer elemento es la division y el 2do el resto entre 6 y 3 --> (" << fst(p3) << "," << snd(p3) << ")" << endl;

    return 0;
}

