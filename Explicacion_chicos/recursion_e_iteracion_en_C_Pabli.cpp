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


bool perteneceIterativa(char c, string s){
// Propósito: indica si un char c aparece en el string s.
    bool res = false; 

    for(int i=0; s[i] != '\0' ; i++){
        res = res || s[i] == c;
    }

    return res;
}



//---------------
bool perteneceRecu(char c, string s, int i){
    if(s[i] != '\0'){
        return s[i] == c || perteneceRecu(c, s, i+1);
    }else{
        return s[i] == c; // compara c con el '/0' entonces da false
    }

}

bool perteneceRecursiva(char c, string s){
// Propósito: indica si un char c aparece en el string s.
    return perteneceRecu( c, s, 0);
}










int aparicionesIterativo(char c, string s){
// Propósito: devuelve la cantidad de apariciones de un char c en el string s.
    int res = 0; 

    for(int i=0; s[i] != '\0' ; i++){
        if(s[i] == c){
            res++;
        }
    }

    return res;
}


int aparicionesRecu(char c, string s, int i){
    if(s[i] != '\0'){
        if(s[i] == c){
            return 1 + aparicionesRecu(c, s, i+1);
        }else {
            return aparicionesRecu(c, s, i+1);
        }
    }else{
        return s[i] == c ; // compara c con el '/0' entonces da false
    }

}

int aparicionesRecursivo(char c, string s){
// Propósito: devuelve la cantidad de apariciones de un char c en el string s.
    return aparicionesRecu(c ,s ,0);
}


int main(){

    cout << aparicionesRecursivo('h', "hola") << "  (1)  "<< endl;
    cout << aparicionesRecursivo('x', "hola") << "  (0)  "<< endl;
    cout << aparicionesRecursivo('a', "renata") << "  (2)  "<< endl;
    
    return 0;
}