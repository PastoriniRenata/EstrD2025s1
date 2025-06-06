#include <iostream>
using namespace std;
#include "Entrenador.h"
// DA ERROR: g++ -o prueba Entrenador-main.cpp Entrenador.cpp          --> xq le falta info de pokemon
//PARA PROBAR: g++ -o prueba Entrenador-main.cpp Entrenador.cpp Pokemon.cpp



int main() {
    // Creación de Pokémon de prueba
    cout << "=== Creando Pokémon ===" << endl;
    Pokemon pikachu = consPokemon("Planta");
    Pokemon charmander = consPokemon("Fuego");
    Pokemon bulbasaur = consPokemon("Planta");
    Pokemon squirtle = consPokemon("Agua");

    // Mostrar información básica de Pokémon
    cout << "\n=== Información de Pokémon ===" << endl;
    cout << "Tipo de Pikachu (Planta): " << tipoDePokemon(pikachu) << endl; 
    cout << "Tipo de Charmander (Fuego): " << tipoDePokemon(charmander) << endl;
    cout << "Energía inicial de Squirtle (Agua): " << energia(squirtle) << "%" << endl;

    // Creación de entrenadores
    cout << "\n=== Creando Entrenadores ===" << endl;
    Pokemon equipoAsh[] = {pikachu, squirtle}; // Planta - Agua
    Entrenador ash = consEntrenador("Ash Ketchum", 2, equipoAsh);

    Pokemon equipoMisty[] = {squirtle}; // Agua
    Entrenador misty = consEntrenador("Misty", 1, equipoMisty);

    Pokemon equipoBrock[] = {bulbasaur}; //Planta
    Entrenador brock = consEntrenador("Brock", 1, equipoBrock);

    // Prueba de funciones de Entrenador
    cout << "\n=== Probando funciones de Entrenador ===" << endl;
    cout << "Nombre del entrenador (Ash): " << nombreDeEntrenador(ash) << endl;
    cout << "Cantidad de Pokémon de Ash (2): " << cantidadDePokemon(ash) << endl;
    cout << "Pokémon 0 de Ash (picachu -> Planta): " << tipoDePokemon(pokemonNro(0, ash)) << endl;

    // Prueba de cantidadDePokemonDe
    cout << "\n=== Pokémon de tipo Agua ===" << endl;
    cout << "Ash tiene (1)  ----->  " << cantidadDePokemonDe("Agua", ash) << " Pokémon de tipo Agua" << endl;
    cout << "Misty tiene (1)  ----->  " << cantidadDePokemonDe("Agua", misty) << " Pokémon de tipo Agua" << endl;

    // Prueba de leGanaATodos
    cout << "\n=== Batallas entre Entrenadores ===" << endl;
    cout << "¿Ash (Planta y Agua ) tiene un Poke que le gana a todos los de Misty(Agua)? (SI, Planta le gana al Agua)  -----> " << (leGanaATodos(ash, misty) ? "Sí" : "No") << endl;
    cout << "¿Misty (Agua) tiene un Poke que le gana a todos los de Brock (Planta)? (NO, Agua no le gana a planta)   -----> " << (leGanaATodos(misty, brock) ? "Sí" : "No") << endl;
    cout << "¿Brock (Planta) tiene un Poke que le gana a todos los de Ash (Planta, Agua)?  (NO, Planta no le gana a Planta) -----> " << (leGanaATodos(brock, ash) ? "Sí" : "No") << endl;

    // Modificar energía para probar relaciones de tipo
    cout << "\n=== Probando relaciones de tipo ===" << endl;
    cout << "¿Squirtle (Agua) supera a Charmander (Fuego)? (Si)   -----> " 
         << (superaA(squirtle, charmander) ? "Sí" : "No") << endl;
    cout << "¿Bulbasaur (Planta) supera a Squirtle (Agua)? (Si)   -----> " 
         << (superaA(bulbasaur, squirtle) ? "Sí" : "No") << endl;

    // Liberar memoria
    cout << "\n=== Liberando memoria ===" << endl;
    delete pikachu;
    delete charmander;
    delete bulbasaur;
    delete squirtle;
    delete ash;
    delete misty;
    delete brock;

    return 0;
}
