#include <iostream> // Necesario para mostrar por consola con cout
using namespace std;

//Hacer iteracion y recursion de c/u


/*
iterar --> while y for

*/
// 1) Factorial
int factorialIterativo(int n){
    int x = 1 ;
    while(n>0){
        x = x * n;
        n = n-1;
    }
    return x;
}


int factorialRecursivo(int n){
    if(n<=1){
        return 1;
    }else{
        return n * factorialRecursivo(n-1);
    }
}

/*


// 2) Imprimir n veces el char pasado por parametro
void imprimirNVecesRecursivo(char c){

}

void imprimirNVecesIterativo(char c){

}

// 3) Sumar n veces 1 a m
void sumarNVecesRecursivo(int n, int m){

}


void sumarNVecesIterativo(int n, int m){

}

*/



int main(){

    cout << factorialIterativo(5) << "  (120)  "<< endl;
    
    return 0;
}