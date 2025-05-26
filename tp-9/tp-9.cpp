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

    if(n>=0){                               //4 --> true
        desdeCeroHastaNRecursivo (n-1);     
        cout<< n << endl;       
    }

}


/*


                                                                            4-1                                                3-1                                                2-1                                                1-1                                                 0-1
-- desdeCeroHastaNRecursivo(4) -- 4>=0 ->true ---- desdeCeroHastaNRecursivo( 3 ) -- 3>=0 -> true ---> desdeCeroHastaNRecursivo( 2 ) --> 2>=0 -> true --> desdeCeroHastaNRecursivo( 1 ) --- 1>=0 -> true --> desdeCeroHastaNRecursivo( 0 ) ---- 0>=0 -> true -> desdeCeroHastaNRecursivo( -1 ) --- -1>=0 -> false ---|                                                                                                                                                           
                                               |                                                   |                                                     |                                                   |                                                    |                                                 |
                                               |                                                   |                                                     |                                                   |                                                    |                                                 |
            cout<< 4 << endl;            <---  |            cout<< 3 << endl;                 <--- |            cout<< 2 << endl;                   <--- |            cout<< 1 << endl;                 <--- |       cout<< 0 << endl;                        <--- NO HACE NADA XQ NO ENTRA EN EL IF             <--|


*/


int multIterativo(int n, int m){
//Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
    int x = m;
    
    if(n==0 || m==0){
        x = 0;
    }else{
        while(n>1){
            x += m;
            n--;
        };
    };
    return x;
}


int multRecursiva(int n, int m){
//Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).

    return (n==0 || m==0) ? 0 : m + multRecursiva(n-1, m);
}



void primerosNIterativa(int n, string s){
//Propósito: imprime los primeros n char del string s, separados por un salto de línea.
//Precondición: el string tiene al menos n char.
    for(int i=0 ; i<n; i++){
        cout << s[i] << endl;
    }
}



void primerosNRecursiva(int n, string s){
//Propósito: imprime los primeros n char del string s, separados por un salto de línea.
//Precondición: el string tiene al menos n char.

    if(n>=0){
        primerosNRecursiva(n-1, s);
        cout<< s[n-1] << endl;
    }

}

bool perteneceIterativo(char c, string s){
//Propósito: indica si un char c aparece en el string s.
    bool rta = false;
    for(int i = 0; s[i] != '\0'  /* && !rta  */ ; i++){
        rta = rta || (s[i] == c);
    }

    return rta;
}





bool perteneceRec(char c, string s, int i){
    //Proposito: indica si un char c aparece en el string s, a partir del char i del string dado.
    // Precondicion: el string tiene al menos i chars

    if(s[i] !='\0'){
        return s[i] == c || perteneceRec(c, s, i+1);
    }
    return s[i] == c ;  // compara el c con '\0'
    
}

bool perteneceRecursivo(char c, string s){
//Propósito: indica si un char c aparece en el string s.
    return perteneceRec(c, s, 0);
}





int aparicionesIterativo(char c, string s){
//Propósito: devuelve la cantidad de apariciones de un char c en el string s.
    int rta = 0;
    for(int i = 0; s[i]!= '\0' ; i++ ){
        if(s[i] == c){ 
            rta++;
        }     
    }

    return rta;
}




int aparicionesRec(char c, string s, int i){
    if(s[i] != '\0'){
        if (s[i] == c){
            return 1 + aparicionesRec(c,s, i+1);
        }else{
            return aparicionesRec(c,s, i+1);
        }
        //return (s[i] == c) ? (1 + aparicionesRec(c,s, i++) ): aparicionesRec(c,s, i++);
    }

    return 0;
}

int aparicionesRecursiva(char c, string s){
//Propósito: devuelve la cantidad de apariciones de un char c en el string s.
    return aparicionesRec(c, s, 0);
}



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
    desdeCeroHastaNIterativo(4);
    cout << "." << endl;
    
    
    desdeCeroHastaNRecursivo(4);
    cout << "." << endl;
    
    cout << multIterativo(0, 2) << endl;
    
    cout<<""<< endl;
    cout << multRecursiva(0, 2) << endl;
    
    primerosNIterativa(3, "hola");
    cout << "" << endl;
    cout << "" << endl;
    primerosNRecursiva(3, "hola");
  
    cout << perteneceIterativo('z', "hola") << endl;
    
    cout << "" << endl;
    
    cout << perteneceRecursivo('z', "hola") << endl;

    
    cout << aparicionesIterativo('a', "holaaaa") << endl;
    
    cout << "" << endl;
    
    cout << aparicionesRecursiva('a', "holaaaa") << endl;
    
    */

    cout << 10.55 / 2  << endl;

    
    return 0;
}