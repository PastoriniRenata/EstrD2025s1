/* 
Definir el tipo de dato Persona, como un puntero a un registro con el nombre y la edad de la
persona. Realizar las siguientes funciones:
*/
#include <iostream>
using namespace std;

struct PersonaSt{
    string nomb;
    int ed;
};

typedef PersonaSt* Persona;

Persona consPersona(string nombre, int edad);
//Devuelve a una persona nueva, con el nombre y la edad dados



string nombre(Persona p);
//Devuelve el nombre de una persona



int edad(Persona p);
//Devuelve la edad de una persona



void crecer(Persona p);
//Aumenta en uno la edad de la persona.



void cambioDeNombre(string nombre, Persona p);
//Modifica el nombre una persona.



bool esMayorQueLaOtra(Persona p1, Persona p2);
//Dadas dos personas indica si la primera es mayor que la segunda.



Persona laQueEsMayor(Persona p1, Persona p2);
//Dadas dos personas devuelve a la persona que sea mayor.