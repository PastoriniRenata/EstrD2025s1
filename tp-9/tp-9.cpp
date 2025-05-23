#include <iostream>
using namespace std;


/*
Ejercicio 2
Indicar el propósito de los siguientes procedimientos o funciones, dando algunos ejemplos de uso
junto con su resultado. Considerar el consumo de memoria de cada programa, y si puede mejorarse.
*/
//1. 
void printFromTo(char c1, char c2) {
// Proposito: imprimir por terminal del valor c1 al c2, separando los valores por coma
// Precondición: c1 < c2
    for(int i = 0; c1 + i <= c2; i++) {
        cout << c1 + i << ", ";
    }
    cout << endl;
}


//2. 
int fc(int n) {
    // Proposito: retorna el factorial de n. 
    // Precondición: n >= 0
    int x = 1;
    while(n > 0) {
        x = x * n;
        n--;
    }
    return x;
}

//3
int ft(int n, int m) {
    // Proposito: retorna la sumatoria de los valores que se encuentran en el intervalo de numeros entre n y m inclusives
    // Precondición: n <= m
    if (n == m) {
        return n;
    }
    return n + ft(n+1, m);

    /*
    ft(8,12)
    8 + ft(9,12)
          9 + ft (10,12)
               10 + ft (11,12)
                     11 + ft(12,12)
                            12
    8 +   9     10  + 11 + 12 ---> 50       
    


    ft(10,10) --> 10    
    
    */
}

int main(){
    cout<< ft(8, 12) << endl;
    cout<< ft(10, 10);
    return 0;
}

/*Ejercicio 4
Dar dos implementaciones para las siguientes funciones, una iterativa y otra recursiva, y utilizando
la menor cantidad posible de variables. Recordar definir subtareas en caso de que sea estrictamente
necesario.
*/

void printNIterativa(int n, string s){
//Propósito: imprime n veces un string s.
    while(n>0){
        n -= 1; 
        cout<< s ;
    }
};

void printNRecursiva(int n, string s){
//Propósito: imprime n veces un string s.
    if(n>0){
        
        cout<< s ;
        printNRecursiva(n-1, s);
    }
};








void cuentaRegresivaIterativa(int n){
//Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
    while(n>=0){
        cout<< n << endl;
        n -= 1; 
    }
}

void cuentaRegresivaRecursiva(int n){
//Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
    if(n>=0){
        cout<< n << endl;
        cuentaRegresivaRecursiva(n -1); 
    }
}


void desdeCeroHastaNIterativo(int n){
//Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
    int x = 0;
    while(x<= n){
        cout<< x << endl;
        x += 1;
    }

}


void desdeCeroHastaNRecursivo(int n){
//Propósito: imprime los números de 0 hasta n, separados por saltos de línea.

    if(n>0){
        desdeCeroHastaNRecursivo (n-1);
    }
    
    cout<< n << endl;
}

/*
int mult(int n, int m)
//Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).


void primerosN(int n, string s)
//Propósito: imprime los primeros n char del string s, separados por un salto de línea.
//Precondición: el string tiene al menos n char.


bool pertenece(char c, string s)
Propósito: indica si un char c aparece en el string s.


int apariciones(char c, string s)
//Propósito: devuelve la cantidad de apariciones de un char c en el string s.




*/



int main(){
    /*
    printNIterativa(4, "Renu");
    cout << "." << endl;

    printNRecursiva(4, "Renu");
    cout << "." << endl;

    cuentaRegresivaIterativa(4);
    cout << "." << endl;

    cuentaRegresivaRecursiva(5);
    cout << "." << endl;
*/
    desdeCeroHastaNIterativo(4);
    cout << "." << endl;

    desdeCeroHastaNRecursivo(4);
    cout << "." << endl;


    return 0;
}