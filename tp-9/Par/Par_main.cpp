#include <iostream>
using namespace std;
#include "Par.h"
/*ACA VA SOLO EL MAIN*/
int main (){
    Par p = consPar(2,9);

    cout << "El par:  "<< "(" << p.x << "," << p.y << ")" << endl;  

    cout << "El 1er elemento:  " << fst(p) << endl;

    cout << "El 2do elemento:  " << snd(p) << endl;

    cout << "El mayor:  " << maxDelPar(p) << endl; 

    Par ps = swap(p);

    cout << "El par intercambiado:  "  << "(" << ps.x << "," << ps.y << ")" << endl; 

    Par pr =  divisionYResto(2,4);

    cout  << "El 1er elemento es la division y el 2do el resto:  " << "(" << pr.x << "," << pr.y << ")" << endl; 
 
    return 0;
}
