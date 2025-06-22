#include <iostream>
using namespace std;
#include "Arboles.h"
#include "ArrayList.h"

int sumarT(Tree t){
//Dado un árbol binario de enteros devuelve la suma entre sus elementos.
    if(isEmptyT(t)){
        return 0;
    }else{
        return rootT(t) + sumarT(left(t)) + sumarT(right(t));
    }
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

int sizeT(Tree t){
//Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árb ol (size
//en inglés).
    if(isEmptyT(t)){
        return 0;
    }else{
        return 1 + sizeT(left(t)) + sizeT(right(t));
    }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bool perteneceT(int e, Tree t){
//Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el
//árbol.
    if(isEmptyT(t)){
        return false;
    }else{
        return rootT(t)==e || perteneceT(e,left(t)) || perteneceT(e, right(t));
    }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


int aparicionesT(int e, Tree t){
//Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árb ol que son
//iguales a e.
    if(isEmptyT(t)){
        return 0;
    }else{
        return ((rootT(t)==e) ? 1 : 0) + aparicionesT(e,left(t)) + aparicionesT(e,right(t));
    }

}


//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


int heightT(Tree t){
//Dado un árb ol devuelve su altura.
    if(isEmptyT(t)){
        return 0;
    }else{
        int heightTleft = heightT(left(t));
        int heightTright = heightT( right(t));

        return 1 + (( heightTleft > heightTright) ? heightTleft : heightTright) ;
    }

}


//------------------------------------------------------------------------------------------------------------------------------------

void agregarTodosLosDelprimerArrayAlsegundo(ArrayList xs, ArrayList arrayL){
//Precondicion: arrayL tiene suficiente espacio para todos los elementos de xs

    for(int i = 0; i< lengthAL(xs); i++){
        add( get(i, xs) , arrayL);
    }
    
}

ArrayList append(ArrayList xs, ArrayList ys){
//Crea una nueva lista a partir de la primera y la segunda (en ese orden).
    ArrayList arrayL = newArrayListWith( lengthAL(xs) + lengthAL(ys) );

    agregarTodosLosDelprimerArrayAlsegundo(xs, arrayL);
    agregarTodosLosDelprimerArrayAlsegundo(ys, arrayL);

    return arrayL;

}


void aLista( ArrayList acumulador, Tree t){
    if(!isEmptyT(t)){
        add(rootT(t), acumulador);
        aLista(acumulador, left(t));
        aLista(acumulador, right(t));
    }
}

ArrayList toList(Tree t){
//Dado un árb ol devuelve una lista con to dos sus elementos.
    ArrayList acumulador = newArrayList();
    aLista(acumulador, t);
    return acumulador;
}

//------------------------------------------------------------------------------------------------------------------------------------

void hojas(ArrayList acumulador, Tree t){
    if(!isEmptyT(t)){
        if(isEmptyT(left(t)) && isEmptyT(right(t))){
            add(rootT(t), acumulador);
        }else{
            hojas(acumulador, left(t)); 
            hojas(acumulador, right(t));
        }
    }
}



ArrayList leaves(Tree t){
//Dado un árbol devuelve los elementos que se encuentran en sus hojas.
    ArrayList acumulador = newArrayList();
    
    hojas(acumulador, t);

    return acumulador;

}

//------------------------------------------------------------------------------------------------------------------------------------

void nivelN (ArrayList acumulador, int n, Tree t){

    if(!isEmptyT(t) && n>=0){
        if(n==0){
            add(rootT(t), acumulador);
        }else{
            nivelN(acumulador, n-1, left(t));
            nivelN(acumulador, n-1, right(t));
        }
    }
}


/*
ArrayList nivelN (ArrayList acumulador, int n, Tree t){
    if(isEmptyT(t)){
        return acumulador;
    }else{
        if(n==0){            
            add(rootT(t), acumulador);
            return acumulador;
        }else{
            return append(nivelN(acumulador, n-1, left(t)), nivelN(acumulador, n-1, right(t)));
        }
    }
}
*/

ArrayList levelN(int n, Tree t){
//Dados un número n y un árb ol devuelve una lista con los nodos de nivel n.
    ArrayList acumulador = newArrayList();
    nivelN(acumulador, n, t);
    return acumulador;
}



/*




*/


// Función auxiliar para imprimir un ArrayList
void printArrayList(ArrayList xs) {
    cout << "[";
    for(int i = 0; i < lengthAL(xs); i++) {
        cout << get(i, xs);
        if(i < lengthAL(xs) - 1) {
            cout << ", ";
        }
    }
    cout << "]" << endl;
}

int main() {
    // Crear árboles de prueba
    Tree empty = emptyT();
    Tree leaf1 = nodeT(1, emptyT(), emptyT());
    Tree leaf2 = nodeT(2, emptyT(), emptyT());
    Tree leaf3 = nodeT(3, emptyT(), emptyT());
    Tree leaf4 = nodeT(4, emptyT(), emptyT());
    
    Tree tree1 = nodeT(5, leaf1, leaf2);
    Tree tree2 = nodeT(6, leaf3, leaf4);
    Tree bigTree = nodeT(10, tree1, tree2);
    
    // Probar isEmptyT
    cout << "isEmptyT(empty)  (SI): " << isEmptyT(empty) << endl;
    cout << "isEmptyT(bigTree) (NO): " << isEmptyT(bigTree) << endl;
    
    // Probar rootT
    cout << "rootT(bigTree) (10): " << rootT(bigTree) << endl;
    cout << "rootT(tree1) (5): " << rootT(tree1) << endl;
    
    // Probar sumarT
    cout << "sumarT(bigTree) (31): " << sumarT(bigTree) << endl;
    cout << "sumarT(tree1) (8): " << sumarT(tree1) << endl;
    
    // Probar sizeT
    cout << "sizeT(bigTree) (7): " << sizeT(bigTree) << endl;
    cout << "sizeT(empty) (0): " << sizeT(empty) << endl;
    
    // Probar perteneceT
    cout << "perteneceT(3, bigTree) (SI): " << perteneceT(3, bigTree) << endl;
    cout << "perteneceT(99, bigTree) (NO): " << perteneceT(99, bigTree) << endl;
    
    // Probar aparicionesT
    Tree repTree = nodeT(2, nodeT(2, emptyT(), emptyT()), nodeT(1, emptyT(), emptyT()));
    cout << "aparicionesT(2, repTree) (3 VECES): " << aparicionesT(2, repTree) << endl;
    
    // Probar heightT
    cout << "heightT(bigTree) (3): " << heightT(bigTree) << endl;
    cout << "heightT(leaf1) (1): " << heightT(leaf1) << endl;
    
    // Probar toList
    cout << "toList(bigTree) [1,2,3,4,5,6,10]: ";
    printArrayList(toList(bigTree));
    
    // Probar leaves
    cout << "leaves(bigTree) ([1,2,3,4]): ";
    printArrayList(leaves(bigTree));
    
    // Probar levelN
    cout << "levelN(0, bigTree) [10]: ";
    printArrayList(levelN(0, bigTree));
    cout << "levelN(1, bigTree) [5,6] :";
    printArrayList(levelN(1, bigTree));
    cout << "levelN(2, bigTree) [1,2,3,4]: ";
    printArrayList(levelN(2, bigTree));
    
    return 0;
}



