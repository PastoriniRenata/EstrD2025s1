#include <iostream>
using namespace std;
#include "Queue.h"




Queue emptyQ(){
//Crea una cola vacía.
//Costo: O(1).
    QueueSt* q = new QueueSt;

    q-> cantidad = 0;
    q-> primero = NULL;
    q-> ultimo = NULL;
}

bool isEmptyQ(Queue q){
//Indica si la cola está vacía.
//Costo: O(1).
    return q->primero == NULL;
}

int firstQ(Queue q){
//Devuelve el primer elemento.
//Costo: O(1).
    return q->primero;
}

void Enqueue(int x, Queue q){
//Agrega un elemento al final de la cola.
//Costo: O(1).
    NodoQ* nq = new NodoQ;

    nq->elem;
    nq->siguiente = NULL;

    NodoQ* temp = q->ultimo;

    temp->siguiente = nq;
    q->ultimo = nq;

}

void Dequeue(Queue q){
//Quita el primer elemento de la cola.
//Costo: O(1).
    if(q->cantidad > 1){
        NodoQ* temp = q->primero;
        q->

    }else{
        q->primero = NULL;
        q->ultimo = NULL;
    }
}

int lengthQ(Queue q){}
//Devuelve la cantidad de elementos de la cola.
//Costo: O(1).


void MergeQ(Queue q1, Queue q2){}
//Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
//Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.


//Costo: O(1).
void DestroyQ(Queue q){}
//Libera la memoria ocupada por la cola.
//Costo: O(n).
