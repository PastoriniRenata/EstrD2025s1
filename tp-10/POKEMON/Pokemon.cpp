#include <iostream>
using namespace std;
#include "Pokemon.h"


Pokemon consPokemon(TipoDePokemon tipo){
//Dado un tipo devuelve un pokémon con 100 % de energía.
    Pokemon p = new PokeSt;
    p -> tipo = tipo;
    p -> vida = 100;

    return p;   
}


TipoDePokemon tipoDePokemon(Pokemon p){
//Devuelve el tipo de un pokémon.
    return p->tipo;
}


int energia(Pokemon p){
//Devuelve el porcentaje de energía.
    return p->vida;  
}


void perderEnergia(int energia, Pokemon p){
//Le resta energía al pokémon.
    p -> vida = p -> vida - energia;

}


/*--------------------------------------*/


bool esTipoSuperior(TipoDePokemon t1, TipoDePokemon t2){
    return (t1 == "Agua" &&  t2 == "Fuego") || 
           (t1 == "Fuego" &&  t2 == "Planta" )|| 
           (t1 == "Planta" &&  t2 == "Agua" );
}

bool superaA(Pokemon p1, Pokemon p2){
//Dados dos pokémon indica si el primero, en base al tipo, es superior al segundo. Agua supera
//a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
    return esTipoSuperior(p1->tipo, p2->tipo);
}

