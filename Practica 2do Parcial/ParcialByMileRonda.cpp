struct RondaSt {
RondaNode* current;
}
struct RondaNode {
int value;
RondaNode* prev;
RondaNode* next;
}


INTERFAZ DE RONDA:
// Crea una ronda vacía.
Ronda mkRonda(){
    RondaSt* ronda = new RondaSt;
    ronda->curr = NULL;

    return ronda;
}


INVARIANTES:
    - El puntero RondaSt no apunta a NULL
    - Existe cadena de nodos que empieza en current y siguiendo los punteros next/prev
        se llega nuevamente a current
- alguno más???

// Inserta un nuevo nodo con value después del current y lo deje como el nuevo current
void insert(Ronda r, int value){
    RondaNode* n = new RondaNode;
    n-value = value;
    if(r->current == NULL){
        n->next = n;
        n->prev = n;
    }else{
        n->next = r->current->next;
        n->prev = r->current;
        r->current->next = n;
        n->next->prev = n;
    }
    r->current = n;
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Devuelve la cantidad de elementos en la ronda.
int lenght(Ronda r){
    int cant = 0;
    RondaNode* actual = r->current;
    if(actual != NULL){
        cant++;
        actual = actual->next;
        while(actual != r->current){
            cant++;
            actual = actual->next;
        }
    }

    return cant;
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Devuelve el valor del nodo actual.
int current(Ronda r){
    if(r->current == NULL){ exit(1);}

    return r->current->value;
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Mover el current n posiciones en la ronda
void move(Ronda r, int n){
    if(r->current == NULL){ return;}

    if(n>= 0){
        for(int i = 0; i<n ; i++){
            r->current = r->current->next;
        }
    }else{ // n<0
        for(int i = 0; i>0 ; i--){
            r->current = r->current->prev;
        }
    }
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


EXTRAS COMO IMPLEMENTADOR:
// Buscar un valor en la ronda
bool contains(Ronda r, int value){
    RondaNode* actual = r->current;
    if(actual != NULL){
        actual = actual->next;
        while(actual != r->current && actual->value != value){
            actual = actual->next;
        }
    }
    return actual != NULL && actual->value == value;
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


// Combinar dos rondas en una
// que inserte todos los elementos de r2 en r1 después del current de r1, y deje a r2 vacía.
void merge(Ronda r1, Ronda r2){
    if(r1->curr != NULL && r2->curr != NULL){
        r1->curr->next->prev = r2->curr->prev;
        r2->curr->prev->next = r1->curr->next;
        r2->curr->prev = r1->curr;
        r1->curr->next = r2->curr;
    }else if(r1->curr == NULL){
        r1->curr = r2->curr; //si r2 tambien es vacía, se sobreescribe un NULL
    }
    r2->curr = NULL;
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Eliminar todos los nodos con valor par
REVISAR!!!
void removeEvens(Ronda r){
    RondaNode* actual = r->current;
    if(actual != NULL && actual == actual->next){ // una ronda con un solo elemento
        if(actual->value % 2 == 0){
            delete(actual);
            r->current = NULL;
        }
    }else if(actual != NULL){ // una ronda con mas de un elemento
        actual = actual->next;
        while(actual != r->current){
            if(actual->value %2 == 0){
                RondaNode* aBorrar = actual;
                actual = actual->prev;
                actual->next = aBorrar->next;
                aBorrar->next->prev = actual;
                delete(aBorrar);
            }
            actual = actual->next;
        }

        //el caso de que haya que borrar el current. El actual es r->current
        if(actual->value %2 == 0){ // el actual->next queda como curr
                RondaNode* aBorrar = actual;
                actual = actual->prev;
                actual->next = aBorrar->next;
                aBorrar->next->prev = actual;
                r->curr = actual;

                delete(aBorrar);
            }
    }
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Crear una copia de la ronda que devuelva un nuevo Ronda igual a r.
Ronda copy(Ronda r){ // ES MEZCLA ENTRE IMPLEMENTADOR Y USUARIO??
    RondaSt* copia = new RondaSt;
    if(r->current != NULL){
        RondaNode* actual = r->current->next;
        insert2(copia, r->current->value);
        while(r->current != actual){
            insert2(copia, actual->value);
            actual = actual->next;
        }
    }else{
        copia->current = NULL;
    }
    return copia;

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


COMO USUARIO: (SIN USAR LOS EXTRAS)

// Propósito: crea una ronda con los elementos de un array.
// Precondición: xs tiene al menos n elementos.
Ronda fromArray(int xs[], int n){
    Ronda nuevaR = mkRonda();
    for(int i=0; i<n ; i++){
        insert(nuevaR, xs[i]);
    }
    return nuevaR;
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Propósito: copia los elementos de la ronda en un array.
// Precondición: xs tiene espacio suficiente para size(r) elementos.
void toArray(Ronda r, int xs[]){
    int n = length(r);
    for(int i = 0; i<n ; i++){
        xs[i] = current(r);
        move(r, 1);
    }
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// Propósito: devuelve la suma de todos los valores de la ronda.
// Precondición: si la ronda está vacía, devuelve 0.
int sumRonda(Ronda r){
    if(current(r) == NULL){ return 0;} // xq haces esto???

    int totalElems = length(r);
    int suma = 0;
    for(int = 0; i < totalElems ; i++){
        suma += current(r);
        move(r, 1);
    }
    return suma
}