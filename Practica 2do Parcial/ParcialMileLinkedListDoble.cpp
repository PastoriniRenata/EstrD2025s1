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
ME QUEDÉ ACAAAAAA
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void removeNode(DList list, Node node){
//Elimina el nodo dado.
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

OTRAS FUNCIONES DE LA INTERFAZ, NECESARIAS PARA PODER IMPLEMENTAR LAS DE USURAIO (NO LAS IMPLEMENTAMOS):
Node first(DList list); el head de la list -> si la lista es vacía devuelve NULL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Node next(Node node); dado un node, devuelve su siguiente -> puede devolver NULL si llega al final de la DList
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

int value (Node node); dado un node devuelve su value 
//Precond: node!=NULL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Node last (DList list); dada una DList, devuelve su ultimo nodo. Si la lista esta vacía devuelve NULL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




//COMO USUARIO: (sin usar contains, insertAfter
DList fromArray(int arr[], int n){
//Crea una lista a partir de un arreglo.
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void toArray(DList list, int arr[]){
//Copia la lista en un arreglo.
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void mergeLists(DList list1, DList list2){
//Agrega todos los nodos de list2 al final de list1, dejando list2 vacía.
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


//TAMBIÉN IMPLEMENTAR COMO USUARIO