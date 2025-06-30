#include <iostream>
using namespace std;


//Invariantes de representacion
// PersonaSt 
//1)el int de las evidencias no puede ser un numero < a 0
//2)El puntero persanast no es null 

// InvestigacionSt 
//1)El puntero investigacionst no es null 
//2)todos los punteros persomast en la lista de sospechosos  no son null
//3)en la lista de sospechosos no hay 2 sospechosos con el mismo nombre

//Propósito: crea una investigación sin personas.
//Eficiencia: O(1)
Investigacion comenzarInvestigacion(){
    InvestigacionSt* i = new InvestigacionSt;
    i->sospechosos = emptyAL();

    return i;
}
//O(1)el costo de hacer new es O(1) asignar la lista vacia tambien tiene el mismo costo por lo
//tanto el costo final es de O(1).

//Propósito: devuelve los nombres de personas ingresadas.
//Nota: suponer que el ArrayList es de nombres.
//Eficiencia: O(N)
ArrayList nombresIngresados(Investigacion investigacion){
    ArrayList nombres = emptyAL();
    
    for(int i = 0; isValidIndex(i, investigacion->sospechosos);i++){
        add(get(i,investigacion->sospechosos)->nombre,nombres);
    }

    return nombres;
}

//Propósito: devuelve la sumatoria de evidencia de las personas.
//Eficiencia: O(N)
int cantEvidenciaDePersonas(Investigacion investigacion){
    int evidencia = 0;

    for(int i = 0; isValidIndex(i, investigacion->sospechosos);i++){
        evidencia += get(i,investigacion->sospechosos)->evidenica;
    }

    return evidencia;
}

//Propósito: indica si la investigación posee al menos una persona con al menos 5 evidencias en su contra.
//Eficiencia: O(N)
bool casoCerrado(Investigacion investigacion){
    bool tieneCinco = false;

    for(int i = 0; isValidIndex(i, investigacion->sospechosos) && tieneCinco;i++){
        tieneCinco = get(i,investigacion->sospechosos)->evidenica >= 5;
    }

    return tieneCinco;
}

//Propósito: indica si esa persona tiene al menos una evidencia en su contra.
//Nota: la persona puede no existir.
bool esSospechosa(string nombre, Investigacion investigacion){
    int cant = 0;
    bool esta = false;

    for(int i = 0; isValidIndex(i, investigacion->sospechosos) && !esta;i++){
        esta = (get(i,investigacion->sospechosos)->nombre == nombre);
        if(esta){
            cant = get(i,investigacion->sospechosos)->evidencia;
        }
    }

    return cant >= 1;
}

//Propósito: devuelve a las personas con cero evidencia en su contra.
//Nota: suponer que el ArrayList es de nombres.
//Eficiencia: O(N)
ArrayList posiblesInocentes(Investigacion investigacion){
    ArrayList sinEvidencia = emptyAL();

    for(int i = 0; isValidIndex(i, investigacion->sospechosos);i++){
        if(get(i,investigacion->sospechosos)->evidencia == 0){
            add(get(i,investigacion->sospechosos)->nombre,sinEvidencia);
        }
    }

    return sinEvidencia;
}

//Propósito: ingresa a personas nuevas a la investigación (mediante sus nombres), sin evidencia en su contra.
//Nota: suponer que el ArrayList es de nombres.
//Precondición: las personas no existen en la investigación y no hay nombres repetidos.
void ingresarPersonas(ArrayList nombres, Investigacion investigacion){

}


//usar la linkedlist como una estructurea axuliar 
//se pueden agregar precondiciones
int[] ascendente(int values[],int n){

}

//como implementador de linkedList
int[] toArray(linkedList xs){

}

//implementador de linkedList
void reverse(linkedlist xs){

}

//implementador de linkedList
LinkedList from(int[] ns){

}

//implementador de linkedList
LinkedList from(int[] ns,int n){

}

/usar la linkedlist como una estructurea axuliar 
//se pueden agregar precondiciones
int[] ascendente(int[] values,int n){
  LinkedList res = nil();
  int max;

  if (n != 0) {
    Snoc(values[0], res);
    max = values[0];
  }

  for (int i = 1; i<n ; i++){
    if(max<values[i]){ 
      Snoc(values[i], res);
      max = values[i];
    }
    
  }
  int[] resultado = toArray(res);

  DestroyL(res);
  
  return resultado;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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








    
    
    
    
    
    - M es la cantidad e nombres en el ArrayList ingresado por argumento.















