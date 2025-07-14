Lista de Tareas Prioritarias:
Representa un gestor de tareas prioritarias, como los usados en sistemas operativos o
aplicaciones de productividad. Deberás implementar una lista ordenada donde cada tarea tiene:
• Nombre único (string): Identificador de la tarea.
• Prioridad (entero): Números menores indican mayor urgencia (ej: prioridad 1 > prioridad 3).
La lista debe mantenerse en todo momento ordenada ascendentemente por prioridad (las tareas
más urgentes primero) y sin nombres repetidos.
struct TaskNodeSt {
    string name; // nombre único de la tarea
    int priority; // prioridad de la tarea
    TaskNodeSt* prev; // tarea anterior
    TaskNodeSt* next; // tarea siguiente
};
typedef TaskNodeSt* Task;
struct TaskListSt {
    TaskNodeSt* first; // primera tarea
    TaskNodeSt* last; // última tarea
};
typedef TaskListSt* TaskList;

INVARIANTES:
    -TaskListSt es un puntero valido que no apunta a NULL
    -El int que indica la priority es mayor o igual a cero
    -No hay nombres repetados en al TaskListSt
    -En la TaskListSt si first es NULL, entonces last tambien lo es
    -En la TaskListSt si last es NULL, entonces first tambien lo es
    -Si un TaskNodeSt pertenece a una TaskListSt y el campo prev de ese nodo apunta a NULL, entonces ese nodo 
        es el first de la TaskListSt a la que pertenece, y es el unico nodo en la TaskListSt que apunta como 
        prev a NULL

    -Si un TaskNodeSt pertenece a una TaskListSt y el campo next de ese nodo apunta a NULL, entonces ese nodo 
        es el last de la TaskListSt a la que pertenece, y es el unico nodo en la TaskListSt que apunta como 
        next a NULL

OBS: si una TaskListSt tiene un único TaskNodeSt, entonces next de ese nodo apunta a NULL y prev de ese nodo
     apunta a NULL




INTERFAZ
TaskList newTaskList(){
//Crea y devuelve una lista vacía de tareas.
    TaskListSt* list = new TaskListSt;

    list->first = NULL;
    list->last = NULL;

    return list;
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


void addTask(TaskList l, string name, int p){
//Inserta una nueva tarea en la lista según su prioridad. 
//Precondición: el nombre no existe en la lista.
    TaskNodeSt* nuevo = new TaskNodeSt;
    nuevo->name = name;
    nuevo->priority = p;
    nuevo->prev = NULL;
    nuevo->next = NULL;
    if(l->first == NULL){ //lista vacía
        l->first = nuevo;
        l->last = nuevo;
    }else if(l->first->priority >= p ){ // va en el first xq la prioridad del q ingresa 
                                        // es menor a la menor prioridad de la lista
        nuevo->next = l->first;
        l->first = nuevo;
    }else if(l->last->priority <= p ){ // va en el last xq la prioridad del q ingresa 
                                       // es mayor a la mayor prioridad de la lista
        nuevo->prev = l->last;
        l->last = nuevo;
    }else{ // va en el medio
        TaskNodeSt* curr = l->first;
        while(    curr != NULL     && curr-> priority <= p){
                 \____________/
                        |
               // No va a pasar
               // nunca, no se si
               // hace falta ponerlo
            curr = curr->next;
        } //tengo que agregar antes del curr
        
        nuevo->prev = curr->prev;
        nuevo->next = curr;
        curr->prev = nuevo;
        nuevo->prev->next = nuevo;
    }
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


void removeTask(TaskList l, string name){
//Elimina la tarea con el nombre dado. Precondición: la tarea existe.


}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


void changePriority(TaskList l, string name, int p){
//Cambia la prioridad de la tarea dada y la reubica en la lista.


}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


bool exists(TaskList l, string name){
//Devuelve true si la tarea existe.


}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Task find(TaskList l, string name){
//Devuelve el nodo de la tarea con el nombre dado.
//Precondición: la tarea existe.

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void insertOrdered(TaskList l, Task n){
//Inserta un nodo ya creado en la posición ordenada correspondiente.

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


FUNCIONES OBSERVADORAS EXTRAS (No las implementamos)

string taskName(Task t);   // devuelve el nombre de la Task dada
Task first(TaskList l);    // devuelve el primer task de la lista dada. OBS: puede devolver NULL, q es un nodo valido
int taskPriority(Task t);  // devuelve la prioridad de la tarea dada. Precondicion: t != NULL
Task nextTask(Task t);     // devuelve la tarea siguiente a la tarea dada. Puede devolver NULL, q es un nodo valido
Task prevTask(Task t);     // devuelve la tarea previa a la tarea dada. Puede devolver NULL, q es un nodo valido
int length(TaskList l);    // devuelve la cantidad de elementos de la lista dada.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



USUARIO

TaskList fromArrays(string* nombres, int* prioridades, int n){
//Crea una lista de tareas a partir de dos arrays paralelos (nombres y prioridades).
//Precondición: ambos arrays tienen al menos n elementos.

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


string tareaConMayorPrioridad(TaskList l){
//Devuelve el nombre de la tarea con mayor prioridad (menor número).
//Precondición: la lista no está vacía.

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


int sumaDePrioridades(TaskList l){
//Devuelve la suma de todas las prioridades de las tareas de la lista.


}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void mergeTL(TaskList l1, TaskList l2){
//Agrega todas las tareas de l2 a l1 y deja a l2 vacía.
//Precondición: no hay nombres repetidos entre las listas.

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


int contarTareasConPrioridad(TaskList l, int p){
//Devuelve cuántas tareas tienen prioridad igual a un valor dado p.


}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void eliminarLasDePrioridad(TaskList l, int p){
//Elimina todas las tareas con prioridad menor a p.


}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void toArray(TaskList l){
//Copia los nombres de las tareas en un array de strings. (string* o string[])

}

