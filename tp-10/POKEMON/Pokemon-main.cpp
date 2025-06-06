#include <iostream>
using namespace std;
#include "Pokemon.h"


int main() {
    // Pokemones
    Pokemon pikachu = consPokemon("Electrico");
    Pokemon charmander = consPokemon("Fuego");

    // Tipos
    cout << "Tipo de pikachu: " << tipoDePokemon(pikachu) << endl;
    cout << "Tipo de charmander: " << tipoDePokemon(charmander) << endl;

    // Mostrar energia
    cout << "Energía de pikachu: " << energia(pikachu) << "%" << endl;
    cout << "Energía de charmander: " << energia(charmander) << "%" << endl;

    // Perder energia
    perderEnergia(30, pikachu);
    perderEnergia(50, charmander);

    // Mostrar energía después del daño
    cout << "Energía de pikachu después de perder 30: " << energia(pikachu) << "%" << endl;
    cout << "Energía de charmander después de perder 50: " << energia(charmander) << "%" << endl;

    // Comparar superioridad
    if (superaA(pikachu, charmander)) {
        cout << "Pikachu supera a Charmander" << endl;
    } else {
        cout << "Pikachu no supera a Charmander" << endl;
    }

    // Liberar memoria (si estás usando new dentro de consPokemon)
    delete pikachu;
    delete charmander;

    return 0;
}