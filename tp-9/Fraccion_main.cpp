#include <iostream>
using namespace std;
#include "Fraccion.cpp"


int main(){
    Fraccion f1 = consFraccion(1, 3);
    Fraccion f2 = consFraccion(2, 4);

    cout<< "Resultado de ejecutar 'numerador' :   "  <<  numerador(f1) << "  El valor esperado: 1  "<< endl;

    cout << "Resultado de ejecutar 'denominador' :   " <<  denominador(f1) << "  El valor esperado: 3  "<< endl;

    cout << "Resultado de ejecutar 'division' :   " <<  division(f1) << "  El valor esperado:  0,333  "<< endl;

    Fraccion fraccMultiplicada = multF(f1, f2);

    cout << "Resultado de ejecutar la multiplicacion dentre 1/3 y 2/4 :   " << numerador(fraccMultiplicada) << "/" << denominador(fraccMultiplicada) << "  El valor esperado: 2/12  "<< endl;

    Fraccion fracSimplificadaf1 = simplificada(f1);
    Fraccion fracSimplificadaf2 = simplificada(f2);
    Fraccion fracSimplificadaf3 = simplificada(fraccMultiplicada);

    cout << "Resultado de ejecutar la simplificacion de la fraccion 1/3:   " << numerador(fracSimplificadaf1) << "/" << denominador(fracSimplificadaf1) << "  El valor esperado: 1/3  "<< endl;

    cout << "Resultado de ejecutar la simplificacion de la fraccion 2/4 :   " << numerador(fracSimplificadaf2) << "/" << denominador(fracSimplificadaf2) << "  El valor esperado: 1/2  "<< endl;

    cout << "Resultado de ejecutar la simplificacion de la fraccion 2/12 :   " << numerador(fracSimplificadaf3) << "/" << denominador(fracSimplificadaf3) << "  El valor esperado: 1/6  "<< endl;

    Fraccion sumaF1yF2 = sumF(f1, f2);

    cout << "Resultado de ejecutar la suma entre 1/3 y 2/4 (sin simplificar) :   " << numerador(sumaF1yF2) << "/" << denominador(sumaF1yF2) << "  El valor esperado: 10/12  "<< endl;

    Fraccion sumaF1yF2Simplif = simplificada(sumaF1yF2);
    
    cout << "Resultado de ejecutar la suma entre 1/3 y 2/4 (con simplificar) :   " << numerador(sumaF1yF2Simplif) << "/" << denominador(sumaF1yF2Simplif) << "  El valor esperado: 5/6  "<< endl;

    return 0;
}

