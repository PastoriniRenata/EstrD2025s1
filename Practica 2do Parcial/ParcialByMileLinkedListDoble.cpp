Linked List doble: implementación de una lista doblemente enlazada. (NO ES UNA RONDA)
Una lista doblemente enlazada está compuesta por nodos que contienen:
• Un valor de tipo int.
• Un puntero al nodo anterior (prev).
• Un puntero al nodo siguiente (next).
La lista mantiene dos punteros principales:
• head: apunta al primer nodo de la lista.
• last: apunta al último nodo de la lista.
Cuando la lista está vacía, tanto head como last son NULL
// Definición de nodos y lista
struct NodeSt {
    int value;
    NodeSt* prev;
    NodeSt* next;
};
struct DListSt {
    Node* head;
    Node* last;
};
typedef DlistSt* Dlist;
typedef NodeSt* Node;


INVARIANTES:
    -El puntero DListSt no apunta a NULL
    -Si head apunta a NULL, entonces last tambien apunta a NULL
    -Si last apunta a NULL, entonces head tambien apunta a NULL
    -Si DList tiene un solo nodo, tanto head como last apuntan al mismo nodo    
    -Si la DListSt no es vacía existe un unico nodo cuyo prev apunta a NULL, y 
        debe ser el head de la DListSt
    -Si la DListSt no es vacía existe un unico nodo cuyo next apunta a NULL, y 
        debe ser el last de la DListSt

OBS 1: Si la DListSt tiene un unico nodo, entonces el prev y el next de ese nodo apuntan a NULL
obs 2: Se aceptan valores repetidos en la DListSt
obs 3: NodeSt puede ser NULL


//INTERFAZ:
DList createDList(){
//Crea y devuelve una lista vacía.
    DListSt* list = new DListSt;
    list->head = NULL;
    list->last = NULL;

    return list;
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void addFront(DList list, int value){
//Agrega un nodo al principio.
    NodeSt* nuevo = new NodeSt;
    nuevo->value = value;
    nuevo->prev = NULL;
    nuevo->next = list->head; // puede ser NULL si la lista es vacía

    if(list->head == NULL){ // lista vacía
        list->last = nuevo;
    }else{ // lista no vacía
        nuevo->next = list->head;
        nueo->next->prev = nuevo;
    }

    list->head = nuevo;

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void addBack(DList list, int value){
//Agrega un nodo al final.
    NodeSt* nuevo = new NodeSt;
    nuevo->value = value;
    nuevo->prev = list->last; // puede ser un NULL si la lista es vacía
    nuevo->next = NULL;
    
    if(list->head == NULL){ // si mi lista es vacía
        list->head = n;
    }else{
        list->last->next = nuevo;
    }
    list->last = nuevo;
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

int size(DList list){
//Devuelve la cantidad de nodos.
    int cant = 0;
    NodeSt* curr = list->head;
    while(curr != NULL){
        cant++;
        curr = curr->next;       
    }
    return cant;
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//EXTRAS COMO IMPLEMENTADOR
bool contains(DList list, int value){
//Devuelve true si el valor está en la lista.
    NodeSt* curr = list->head;
    while(curr!=NULL && curr->value !=value){
        curr = curr->next;
    }
    return curr != NULL; // Alcanza con preguntar si llegó al final. 
                         // Si recorrió la lista entera, significa que no lo encontró antes por lo que no pertenece
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void insertAfter(DList list, Node node, int value){
//Inserta un nuevo nodo después del nodo dado.
//OBS: nada te garantiza que el nodo dado pertenece a la DList.
    if(node == NULL || !pertenece(list, node)){ exit(1); }

    NodeSt* nuevo = new NodeSt;
    nuevo->value = value;
    nuevo->prev = node;
    nuevo->next = node->next;
    if(list->last == node){
        list->last = nuevo;
    }else{
        nuevo->next->prev = nuevo;
    }
}

AUXILIAR

bool pertenece(DList list, Node node){
    NodeSt* curr = list->head;
    if(curr != NULL){
        while(curr!=NULL && curr != node){
            curr = curr->next;
        }
    }
    return curr != NULL; // Alcanza con preguntar si llegó al final. 
                         // Si recorrió la lista entera, significa que no lo encontró antes por lo que no pertenece

}


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void removeNode(DList list, Node node){
//Elimina el nodo dado.
//Precond: node != NULL
    OBS: no fallo en caso de que el node NO pertenezca a la list xq no cambia en mi flujo de info.
         Si tengo una lista con 3 nodos, cuyos values son 1, 2 y 3, y pido que borre un nodo que es 4, 
         la lista resultante va a cumplir con lo que quiero, el 4 no va a estar, pero xq nunca estuvo.

    if(list->head == node && list->tail == node){ // UN ELEMENTO
        list->head = NULL;
        list->tail = NULL;
    }else if(list->head == node){ //Al menos 2 elementos y el node es el head
        list->head = node->next;
        node->next->prev = NULL;
    }else if(list->tail == node){ //Al menos 2 elementos y el node es el tail
        list->tail =
    }else if(pertenece(list,node)){ //Al menos 2 elementos y el nodo está en el medio
        node->prev->next = node->next;
        node->next->prev = node->prev;
    }

    //tomo la desicion de no eliminar el nodo que me pasan xq nada me garantiza que no estoy rompiendo algo por fuera y no me lo piden

}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

OTRAS FUNCIONES DE LA INTERFAZ, NECESARIAS PARA PODER IMPLEMENTAR LAS DE USURAIO (NO LAS IMPLEMENTAMOS):
Node first(DList list); el head de la list -> si la lista es vacía devuelve NULL

Node next(Node node); dado un node, devuelve su siguiente -> puede devolver NULL si llega al final de la DList

int value (Node node); dado un node devuelve su value 
//Precond: node!=NULL

Node last (DList list); dada una DList, devuelve su ultimo nodo. Si la lista esta vacía devuelve NULL


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//COMO USUARIO: (sin usar contains, insertAfter
DList fromArray(int arr[], int n){
//Crea una lista a partir de un arreglo.
    DList list = createDList();
    for(int i=0; i<n ; i++){
        addBack(list, arr[i]);
    }
    return list;
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void toArray(DList list, int arr[]){
//Copia la lista en un arreglo.
    int cant = size(list);
    int arr = NULL;
    if(cant>0){
        arr = new int[cant];
        Node curr = first(list);
        for(int i=0; i<cant ; i++){
            arr[i] = value(curr);
            curr = next(curr);
        }
    }
    return arr;
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void mergeLists(DList l1, DList l2){ // AL FINAL LA HICIMOS COMO IMPLEMENTADOR XQ NO SE PODIA COMO USUARIO
//Agrega todos los nodos de list2 al final de list1, dejando list2 vacía.
    if(l1->head != NULL && l2->head != NULL ){ // 2 listas NO vacías
        l1->tail->next = l2->head;
        l2->head->prev = l1->tail;
        l1->tail = l2-> tail;
    }
    if(l1->head == NULL && l2->head != NULL){ //la l1 vacia y l2 con elementos
        l1->head = l2->head;
        l1->tail = l2->tail;
    }

    l2->head = NULL
    l2->tail = NULL
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


//TAMBIÉN IMPLEMENTAR COMO USUARIO