#include <iostream>
using namespace std;
#include "Entrenador.h"



Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon){
//Dado un nombre, una cantidad de pokémon, y un array de pokémon de ese tamaño, devuelve
//un entrenador.
    Entrenador e = new EntrenadorSt;

    e-> nombre = nombre;
    e-> cantPokemon = cantidad;
    e-> pokemon = pokemon;

    return e;
}

// Devolver un Pokemon de tipo Fuego
Pokemon agarrarPokeDeFuego(Entrenador e ; TipoDePokemon t){
    // Precondicion: el entrenador tiene un pokemon del tipo dado!
    int i = 
}


























string nombreDeEntrenador(Entrenador e){
//Devuelve el nombre del entrenador.
    return  e-> nombre;
}

int cantidadDePokemon(Entrenador e){
//Devuelve la cantidad de pokémon que posee el entrenador.
    return  e-> cantPokemon;
}



int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e){
//Devuelve la cantidad de pokémon de determinado tipo que posee el entrenador.
    int cantPks = 0;

    for(int i = 0; i< e->cantPokemon; i++){
        if( tipoDePokemon(e->pokemon[i]) == tipo ){
            cantPks++;
        }
    }

    return cantPks;
}

Pokemon pokemonNro(int i, Entrenador e){
//Devuelve el pokémon número i de los pokémon del entrenador.
//Precondición: existen al menos i − 1 pokémon.
    return e->pokemon[i];
}




/*----------------------------------------------------------*/

bool elPokeLeGanaAtodos(Pokemon p, Entrenador e2){
    bool leGanaAtodos = true;
    for(int i = 0; i< e2->cantPokemon; i++ ){
        leGanaAtodos = leGanaAtodos && superaA(p, e2->pokemon[i]);
    }

    return leGanaAtodos;
}


bool leGanaATodos(Entrenador e1, Entrenador e2){
//Dados dos entrenadores, indica si, para cada pokémon del segundo entrenador, el primero
//posee al menos un pokémon que le gane.

    bool unoLeGanaATodos = false;
    for(int i=0; i< e1->cantPokemon ; i++){
        unoLeGanaATodos = unoLeGanaATodos || elPokeLeGanaAtodos(e1->pokemon[i], e2);
    }

    return unoLeGanaATodos;
}
