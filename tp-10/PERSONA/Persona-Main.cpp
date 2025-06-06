#include <iostream>
using namespace std;
#include "Persona.cpp"


int main (){
    Persona p = consPersona("Renata", 25);

    cout << "La persona:  " << nombre(p) << " , de edad: " << edad(p) << endl;  

    crecer(p);

    cout << "La persona con una año más:  " << nombre(p) << " , de edad: "  << edad(p) << endl; //

    cambioDeNombre("Azu",p);

    cout << "La persona:  " << nombre(p) << " , de edad: " << edad(p) << endl;  // Azu 26


    Persona p2 = consPersona("Pablo", 27);


    cout << "Azu es más grande que Pablo (Falso):  "  <<  esMayorQueLaOtra(p, p2) << endl; 


    cout << "Pablo es más grande que Azu (True):  "  <<  esMayorQueLaOtra(p2, p) << endl; 

    Persona elMasGrande = laQueEsMayor(p, p2);

    cout << "La Persona más grande es:  "  <<  "La persona:  " << nombre(elMasGrande) << " , de edad: " <<  edad(elMasGrande) << endl; 
    
    return 0;
}





