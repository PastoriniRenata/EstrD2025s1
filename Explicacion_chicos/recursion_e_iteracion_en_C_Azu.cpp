#include <iostream> // Necesario para mostrar por consola con cout
using namespace std;


//Hacer iteracion y recursion de c/u


/*

iterar --> while y for

*/
// 1) Factorial
int factorialIterativo(int n){ // n! = n * ((n-1)!) 
                               //    = n * (n-1) * ( (n-2)! ) 
                               //    = n * (n-1) * (n-2) * ..... * 0!
    int x = 1;
    while( n > 1){
        x = x * n; // x = 1 * 5 -> 5 // x = 5 * 4 --> 20 // .....  // x = 60 * 2 --> 120
        n = n - 1; // n = 5 - 1 -> 4 // n = 4 - 1 --> 3  // .....  // n = 2 - 1 --> 1
    }

    return x;
}


int factorialRecursivo(int n){ // n! = n * ((n-1)!) 
                               //    = n * (n-1) * ( (n-2)! ) 
                               //    = n * (n-1) * (n-2) * ..... * 0!
    if(n > 1){
        return n * factorialRecursivo(n-1);
    }else{
        return 1;
    }

}


int main(){
    cout << factorialIterativo(5) << "  (120)  " << endl;
    cout << factorialRecursivo(5) << "  (120)  " << endl;

    return 0;
}