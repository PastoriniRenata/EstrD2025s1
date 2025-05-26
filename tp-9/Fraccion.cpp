#include <iostream>
using namespace std;
#include "Fraccion.h"



// Propósito: construye una fraccion
// Precondición: el denominador no es cero
Fraccion consFraccion(int numerador, int denominador){
    Fraccion fr;
    fr.numerador = numerador;
    fr.denominador = denominador;
    return fr;
}

// Propósito: devuelve el numerador
int numerador(Fraccion f){
    return f.numerador;
}

// Propósito: devuelve el denominador
int denominador(Fraccion f){
    return f.denominador;
}

// Propósito: devuelve el resultado de hacer la división
float division(Fraccion f){
    float num = f.numerador; // si no lo transformaba en float me daba la division entera!!

    return num / f.denominador ;
}

// Propósito: devuelve una fracción que resulta de multiplicar las fracciones
// (sin simplificar)
Fraccion multF(Fraccion f1, Fraccion f2){
    f1.numerador    *= f2.numerador;
    f1.denominador  *= f2.denominador;

    return f1;
}


bool esDivisorDe(int i, int x){
    //Proposito; indica si i es divisor de x. Osea que la division entre x e i NO tiene resto.
    return x%i == 0;
}

int maxComunDiv(int x, int y){
    //Proposito: devuelve el maximo comun divisor entre x e y.
    int div = 1;
    for(int i = 1; i<=x && i<=y  ; i++){
        if (esDivisorDe(i, x) && esDivisorDe(i, y)){
            div = i;
        }
        
    }

    return div;
    
}


// Propósito: devuelve una fracción que resulta
// de simplificar la dada por parámetro
Fraccion simplificada(Fraccion p){
    int mcDiv = maxComunDiv(p.numerador, p.denominador);

    p.numerador = p.numerador/mcDiv;
    p.denominador = p.denominador/mcDiv;

    return p;

}



//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Propósito: devuelve la fracción resultante de sumar las fracciones
Fraccion sumF(Fraccion f1, Fraccion f2){
    Fraccion suma;

    suma.numerador = f1.numerador * f2.denominador + f2.numerador * f1.denominador;
    suma.denominador = f1.denominador * f2.denominador;

    return suma; // simplificada(suma);
}


