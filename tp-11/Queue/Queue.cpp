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

    return q;
}

bool isEmptyQ(Queue q){
//Indica si la cola está vacía.
//Costo: O(1).
    return q->primero == NULL;
}

int firstQ(Queue q){
//Devuelve el primer elemento.
//Costo: O(1).
    return q->primero->elem;
}

void Enqueue(int x, Queue q){
//Agrega un elemento al final de la cola.
//Costo: O(1).
    NodoQ* nq = new NodoQ;

    nq->elem=x;
    nq->siguiente = NULL;

    if(q->cantidad==0){
        q->primero = nq;
        q->ultimo = nq;
    }else{
        q->ultimo->siguiente = nq;
        q->ultimo = nq;
    }

    

    q->cantidad++;

}

void Dequeue(Queue q){
//Quita el primer elemento de la cola.
//Costo: O(1).
    if(q->cantidad > 1){
        NodoQ* temp = q->primero;
        q->primero = temp->siguiente;
        q->cantidad --;


    }else{
        q->primero = NULL;
        q->ultimo = NULL;
    }
}

int lengthQ(Queue q){
//Devuelve la cantidad de elementos de la cola.
//Costo: O(1).
    return q->cantidad;
}

void MergeQ(Queue q1, Queue q2){
//Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
//Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
    if(q1->cantidad>0 && q2->cantidad>0){
        q1->ultimo->siguiente = q2->primero;
        q1->ultimo = q2->ultimo; 

    }else{
        if(q1->cantidad==0){
            q1->primero = q2->primero;
            q1->ultimo = q2->ultimo;

        }
    }

    q1->cantidad += q2->cantidad; 

    delete(q2);


}

//Costo: O(1).




void DestroyQ(Queue q){
//Libera la memoria ocupada por la cola.
//Costo: O(n).
    if(q->cantidad>0){
        NodoQ* curr = q->primero;
        NodoQ* siguiente = curr->siguiente;

        while(siguiente != NULL){
            delete(curr);
            curr = siguiente;
            siguiente = curr->siguiente;
        }

        delete(curr);
        delete(siguiente);

    }

    delete(q);
    
}