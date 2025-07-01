struct PersonaSt {
    string nombre;
    int evidencia;
}

typedef PersonaSt* Persona;

struct InvestigacionSt {
    ArrayList sospechosos; // lista de Persona
}
typedef InvestigacionSt* Investigacion;

/*
Ejercicios
Invariantes
a) Dar invariantes de representación válidos según la descripción de la estructura.
    Puntaje: 1

    --> PersonaSt
        - El puntero PersonaSt no apunta a NULL.
        - el nombre no apunta a NULL
        - la cantidad de evidencias debe ser mayor o igual a cero.



    --> InvestigacionSt
        - El puntero InvestigacionSt no apunta a NULL
        - Todos los elementos en la lista son punteros validos a estructuras PersonaSt. 
        - No existe dos personas en la lista de sospechosos con el mismo nombre


    Implementación
    Implementar la siguiente interfaz de Investigacion, utilizando la representación y los costos dados y calculando los costos
    de cada subtarea definida:
*/


Investigacion comenzarInvestigacion(){
//Propósito: crea una investigación sin personas.
//Eficiencia: O(1)
//Puntaje: 0.25
    InvestigacionSt* inv = new InvestigacionSt;

    inv ->sospechosos = emptyAL();

    return inv;
}
/*
COSTO:
    - crear un puntero --> O(1) ???
    - emptyAL() --> O(1)

    --> como son todas operaciones secuenciales de costo constante --> comenzarInvestigacion es de costo O(1)

*/


ArrayList nombresIngresados(Investigacion investigacion){
//Propósito: devuelve los nombres de personas ingresadas.
//Nota: suponer que el ArrayList es de nombres. --> ArrayList de string?
//Eficiencia: O(N)
//Puntaje: 0.25
    ArrayList nombres = emptyAL();

    for(int i = 0; isValidIndex(i, investigacion->sospechosos); i++){
       // PersonaSt* p = get( i, investigacion->sospechosos); // si fuera usiario de Persona, en lugar de PersonaSt* iria Persona
        add( get( i, investigacion->sospechosos) -> nombre , nombres);
    }

    return nombres;
}

/*

MEMORIA: usuario de ArrayList e implementador de Investigación
En el frame de la función se crea un espacio para la variable nombres que es un ArrayList que se va a ir modificando
de manera dinámica agregando nombres de personas. 
Por cada funciones de la interfaz de ArrayList usadas (isValidIndex, add, get, emptyAL), cada vez que se las invoca, 
se crea un frame en el stack frame.


COSTO operacional:
    - N la cantidad de personas en la investigación
    - emptyAL() --> O(1)
    - isValidIndex --> O(1)
    - get --> O(1)
    - add --> O(1)
    - acceder a los campos de las estructuras tiene costo O(1)

    --> Por cada iteración se hacen operaciones secuenciales de costo constante, donde se hacen un total de N iteraciones 
        --> nombresIngresados tiene costo O(N)

*/



int cantEvidenciaDePersonas(Investigacion investigacion){
//Propósito: devuelve la sumatoria de evidencia de las personas.
//Eficiencia: O(N)
//Puntaje: 0.75
    int cantEvidencias = 0;
    for(int i = 0; isValidIndex(i, investigacion->sospechosos); i++){
        Persona p = get( i, investigacion->sospechosos);
        cantEvidencias = p -> evidencias;
    }
    return cantEvidencias;
}
/*
COSTO:
    - N la cantidad de personas en la investigación
    - isValidIndex --> O(1)
    - get --> O(1)
    - acceder a los campos de las estructuras tiene costo O(1)

    --> Por cada iteración se hacen operaciones secuenciales de costo constante, donde se hacen un total de N iteraciones --> cantEvidenciaDePersonas tiene costo O(N)

*/


bool casoCerrado(Investigacion investigacion){
//Propósito: indica si la investigación posee al menos una persona con al menos 5 evidencias en su contra.
//Eficiencia: O(N)
//Puntaje: 0.75
    int i = 0; 
    while(isValidIndex(i, investigacion->sospechosos) && get( i, investigacion->sospechosos)->evidencias < 5){
        i++;
    }
    return isValidIndex(i, investigacion->sospechosos) && get( i, investigacion->sospechosos)->evidencias >= 5 ;
}
/*
COSTO:
    - N la cantidad de personas en la investigación
    - isValidIndex --> O(1)
    - get --> O(1)
    - acceder a los campos de las estructuras tiene costo O(1)

    --> Por cada iteración se hacen operaciones secuenciales de costo constante, donde, en peor caso, se hacen un total de N iteraciones --> casoCerrado tiene costo O(N)
*/




//Propósito: devuelve los nombres de personas ingresadas.
//Nota: suponer que el ArrayList es de nombres.
//Eficiencia: O(N)
ArrayList nombresIngresados(Investigacion investigacion){
    ArrayList arrayL =  emptyAL();
    
    for(int i = 0; isValidIndex(i,investigacion->sospechosos); i++){
        add(get(i,investigacion->sospechosos)->nombre,arrayL);
    }

    return arrayL;
}

Costo operacional:
n sienda la cantidad de personas en la investigacion
costo de emptyAL() -> O(1)
crear variable -> O(1)
En cada iteracion del for tenemos un costo de O(1) porque cada funcion que se ejecuta es secuencial e independiente y tienen 
costo constante, por lo cual vamos a tener n interaciones logrando un costo O(n) siendo n la cantidad de personas en la investigacion

costo en memoria:
cuando arranca mi funcion se crea un stack frame donde se inicializa la variale con un puntero a una array, guardando espacio en la memoria heap.
al usar las funciones add,get,isvalidIndex se generan nuevos stack frame para cada una de ellas. ese espacio se va ir llenando a medida que va
iterando el for, por ultimo se retorna esa arrayList sin liberar el espacio en memoria heap.

//Propósito: devuelve la sumatoria de evidencia de las personas.
//Eficiencia: O(N)
int cantEvidenciaDePersonas(Investigacion investigacion){
    int cant = 0;
    
    for(int i = 0; isValidIndex(i,investigacion->sospechosos); i++){
        cant += get(i,(investigacion->sospechosos))->evidencia;
    }

    return cant;  
}


//Propósito: indica si la investigación posee al menos una persona con al menos 5 evidencias en su contra.
//Eficiencia: O(N)
bool casoCerrado(Investigacion investigacion){

    int i = 0;

    while(isValidIndex(i,investigacion->sospechosos) && get(i,(investigacion->sospechosos))->evidencia < 5){
        i++;
    }

    return isValidIndex(i,investigacion->sospechosos);
}

costo memoria:
cuando arranca mi funcion se crea un stack frame donde se guarda la variable iniciada y declarada en la memoria estatica. Por cada invocacion de
las funciones de la interfase de arrayList isvalidIndex y get, se crean nuevos stack frame temporales con sus respectivos parametros y variables 
locales. Estos frame se eliminan automaticamente al finalizar cada ejecucion de cada funcion. 
En Memoria dinamica: no hay cambios.

//Propósito: indica si esa persona tiene al menos una evidencia en su contra.
//Nota: la persona puede no existir.
//Eficiencia: O(N)
bool esSospechosa(string nombre, Investigacion investigacion){
    int i = 0;


    while(isValidIndex(i,investigacion->sospechosos) && get(i,(investigacion->sospechosos))->nombre != nombre){
        i++;
    }


    return isValidIndex(i,investigacion->sospechosos) && get(i,(investigacion->sospechosos))->evidencia > 0;
}
costo memoria:
cuando arranca mi funcion se crea un stack frame donde se guarda la variable iniciada y declarada en la memoria estatica. Por cada invocacion de
las funciones de la interfase de arrayList isvalidIndex y get, se crean nuevos stack frame temporales con sus respectivos parametros y variables 
locales. Estos frame se eliminan automaticamente al finalizar cada ejecucion de cada funcion. 
En Memoria dinamica: no hay cambios.

//Propósito: devuelve a las personas con cero evidencia en su contra.
//Nota: suponer que el ArrayList es de nombres.
//Eficiencia: O(N)
ArrayList posiblesInocentes(Investigacion investigacion){
    ArrayList per = emptyAl();

    for(int i = 0; isValidIndex(i,investigacion->sospechosos); i++){
        if(get(i,(investigacion->sospechosos))->evidencia == 0){
            add(get(i,(investigacion->sospechosos),per));
        }
    }

    return per;
}

COSTO MEMORIA:

Memoria estática:
Cuando ingreso en mi función se crea un stack frame donde se guarda la variable local per, la cual es un puntero a el ArrayList creado.
Por cada invocación a las funciones de la interfaz de ArrayList (emptyAl, isValidIndex, get, add) se crean nuevos stack frame temporales con sus 
respectivos parámetros y varaibles locales, los cuales se eliminan automáticamente al finalizar la ejecución de cada funcion.

Memoria Dinámica:
La función emptyAl() devuelve un puntero a una ArrayList nueva en la heap. 
Al invocar la función add(...) se guarda el elemento dado en una celda de memoria previamente reservada???

Al finalizar la ejecución de posiblesInocentes(...) el stack frame se elimina y el Array de salida per no se libera en esta funcón ya que se retorna.


//Propósito: ingresa a personas nuevas a la investigación (mediante sus nombres), sin evidencia en su contra.
//Nota: suponer que el ArrayList es de nombres.
//Precondición: las pers
void ingresarPersonas(ArrayList nombres, Investigacion investigacion){

    for(int i = 0; isValidIndex(i, nombres); i++){
        PersonaSt* per = new PersonaSt;

        per->nombre = get(i, nombres);
        per->evidencias = 0;

        add(per, investigacion->sospechosos);
    }
}

Costo en MEMORIA:
Al iniciar mi funcion se crea un stack frame donde se inicializan las variables por cada iteracion del for, en donde al inicar PersonaST crea 
un puntero guardando el espacio en memoria heap, por cada invocación a las funciones de la interfaz de ArrayList (isValidIndex, get, add) se 
crean nuevos stack frame temporales con sus respectivos parámetros y varaibles locales, los cuales se eliminan automáticamente al finalizar
la ejecución de cada funcion.






//Propósito: incrementa en uno la evidencia a una lista de personas.
//Precondición: la evidencia aún no está asociada a esa persona.
//Nota 1: la persona y la evidencia existen, pero NO están asociadas.
//Nota 2: suponer que el ArrayList es de nombres.
//Eficiencia: O(N)

void agregarUnoA(string nombre, Investigacion investigacion){
    int i = 0;

    while(get(i, investigacion->sospechosos)->nombre != nombre){ // como la NOTA 1 te asegura que la persona existe, se que nunca vamos a llegar al final del Array, no necesito chequearlo
        i++;
    }
    get(i, investigacion->sospechosos)->envidencia ++;
}

void ingresarUnaEvidencia(ArrayList nombres, Investigacion investigacion){
    for(int i = 0; isValidIndex(i, nombres); i++){
        agregarUnoA( get(i, nombres), investigacion);
    }
}


Costo operacional: O(N*M), donde M, en peor caso M = N

agregarUnoA
    - N es la cantidad de personas en la investigación
    - get -> O(1)

    En cada iteración se ejecutan funciones de costo constante las cuales son independientes y secuenciales. En peor caso se recorren todas las
    personas de la investigacióm, obteniendo así un costo lineal

    => agregarUnoA tiene costo O(1)


ingresarUnaEvidencia
    - M es la cantidad de nombres en el ArrayList ingresado por argumento.
    - N es la cantidad de personas en la investigación
    - isValidIndex -> O(1)
    - agregarUnoA -> O(N)

    Por cada iteración al recorrer el ArrayList de nombres ingresado por argumento se hace una operación de costo constante (isValidIndex) 
    y una operación de costo linel (agregarUnoA). Como el costo constante se desestima, ingresarUnaEvidencia tiene costo final O(N*M), donde
    M, en peor caso, podría ser igual a N.



Costo en Memoria:
    agregarUnoA
        cuando arranca mi funcion se crea un stack frame donde se guarda la variable iniciada y declarada en la memoria estatica. Por cada 
        invocacion de la funcion de la interfaz de arrayList (get), se crea un nuevo stack frame temporal con sus respectivos parametros 
        y variables locales. Este frame se elimina automaticamente al finalizar la ejecucion de la funcion. 

        Por otro lado, en la memoria dinamica hay cambios al acceder al puntero de la persona a la que quiero incrementar en uno sus evidencias.

    
    ingresarUnaEvidencia
        cuando arranca mi funcion se crea un stack frame en memoria estática. 
        Por cada invocacion de la funcion de la interfaz de arrayList (isValidIndex, get) y la funcion auxiliar agregarUnoA, se crea un 
        nuevo stack frame temporal con sus respectivos parametros y variables locales. Estos frames se eliminan automaticamente al 
        finalizar la ejecucion cada una de las funciones.  

        Memoria Dinamica: no hay cambios.





int cantidadDeInocentes(Investigacion investigacion){
//Propósito: Indica la cantidad de inocentes.
    ArrayList pInocentes = posiblesInocentes(investigacion);
    int i = 0;
    while(isValidIndex(i, pInocentes)){
        i++;
    }
//no tengo manera como usuario de eliminar la lista q creé, pero la borraría
    return i;
}

COSTO:
    - N es la cantidad de personas en la investigación
    - posiblesInocentes -> O(N)
    - isValidIndex -> O(1)

    En cada iteración se hacen operaciones de costo constante. En conjunto con la ejecucion de posiblesInocentes al ser secuencial e 
    independiente, el costo de cantidadDeInocentes es O(N + N), ya que posiblesInocentes podría devolver un ArrayList con todas
    las personas de la investigacion.

    => cantidadDeInocentes tiene costo => O(2*N) => O(N) ya que el valor constante se desestima.


COSTO MEMORIA:
    cuando arranca mi funcion se crea un stack frame donde se guarda la variable iniciada y declarada en la memoria estatica. Por cada 
    invocacion de la funcion de la interfaz de arrayList (isValidIndex), se crea un nuevo stack frame temporal con sus respectivos parametros 
    y variables locales. Este frame se elimina automaticamente al finalizar la ejecucion de la funcion. 
    A su vez para la ejecucion de posiblesInocentes se crea un nuevo stack frame, el cual se elimina al terminar la ejecución, 
    
    
    Memoria dinamica: no puedo hablar de memroia dinamica de ArrayList, xq soy usuario de los TAD Investigación y Array, los cuales no 
    se como están construido, por lo cual no se que su implementación está conformada por punteros.

bool todasInocentes(Investigacion investigacion){
//Propósito: Indica si las personas en la investigación son todas inocentes.
    return cantEvidenciaDePersonas(investigacion) == 0;
}






