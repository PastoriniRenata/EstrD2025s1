#include <iostream>
using namespace std;
#include "Persona.h"




Persona consPersona(string nombre, int edad){
//Devuelve a una persona nueva, con el nombre y la edad dados
   // Persona p = new Persona; ---> DA ERROR cannot initialize a variable of type 'Persona' (aka 'PersonaSt *') with an rvalue of type 'Persona *' (aka 'PersonaSt **')
    Persona p = new PersonaSt;

    p -> nomb = nombre;
    p -> ed = edad;
 
    return p;

}


string nombre(Persona p){
//Devuelve el nombre de una persona
    return p -> nomb;
}


int edad(Persona p){
//Devuelve la edad de una persona
    return p -> ed;
}


void crecer(Persona p){
//Aumenta en uno la edad de la persona.
    int edad = p -> ed;

    p -> ed = edad + 1;
}


void cambioDeNombre(string nombre, Persona p){
//Modifica el nombre una persona.
    p -> nomb = nombre;
}


bool esMayorQueLaOtra(Persona p1, Persona p2){
//Dadas dos personas indica si la primera es mayor que la segunda.
    return p1 -> ed > p2 -> ed;
}


Persona laQueEsMayor(Persona p1, Persona p2){
//Dadas dos personas devuelve a la persona que sea mayor.
    if (p1->ed >= p2->ed){
        return p1;
    }else{
        return p2;
    }
}