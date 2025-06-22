#include <iostream>
using namespace std;
#include "Queue.h"

void imprimirQueue(Queue q) {
    NodoQ* actual = q->primero;
    cout << "[ ";
    while (actual != NULL) {
        cout << actual->elem << " ";
        actual = actual->siguiente;
    }
    cout << "]" << endl;
}

int main(){
    cout << "----------------------------------" << endl;
    cout << "------------ Queue ---------------" << endl;
    cout << "----------------------------------" << endl;
    
    cout << "creando queue vacia q1" << endl;
    Queue q1 = emptyQ();

    cout << "enqueue 10, 20, 30 en q1" << endl;
    Enqueue(10, q1);
    Enqueue(20, q1);
    Enqueue(30, q1);

    cout << "como queda q1 despues de equeue: ";
    imprimirQueue(q1);

    cout << "primer elemento: " << firstQ(q1) << endl;
    cout << "cantidad total elementos: " << lengthQ(q1) << endl;

    Dequeue(q1);
    cout << "contenido de q1 despues de dequeue: ";
    imprimirQueue(q1);

    cout << "creando queue vacia q2" << endl;
    Queue q2 = emptyQ();
    Enqueue(100, q2);
    Enqueue(200, q2);

    cout << "contenido de q2: ";
    imprimirQueue(q2);

    MergeQ(q1, q2);

    cout << "contenido de q1 despues de merge q1 con q2: ";
    imprimirQueue(q1);

    cout << "cantidad total de elementos en q1: " << lengthQ(q1) << endl;

    cout << "queue destruida bip bop" << endl;
    DestroyQ(q1);

    return 0;
}