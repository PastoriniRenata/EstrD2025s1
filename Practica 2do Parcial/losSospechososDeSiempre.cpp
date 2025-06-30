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





bool esSospechosa(string nombre, Investigacion investigacion){
//Propósito: indica si esa persona tiene al menos una evidencia en su contra.
//Nota: la persona puede no existir.
//Eficiencia: O(N)
//Puntaje: 0.75

}



ArrayList posiblesInocentes(Investigacion investigacion);
//Propósito: devuelve a las personas con cero evidencia en su contra.
//Nota: suponer que el ArrayList es de nombres.
//Eficiencia: O(N)
//Puntaje: 0.75
void ingresarPersonas(ArrayList nombres, Investigacion investigacion);
//Propósito: ingresa a personas nuevas a la investigación (mediante sus nombres), sin evidencia en su contra.
//Nota: suponer que el ArrayList es de nombres.
//Precondición: las personas no existen en la investigación y no hay nombres repetidos.
//Eficiencia: O(N)
Puntaje: 1
void ingresarUnaEvidencia(ArrayList nombres, Investigacion investigacion);
//Propósito: incrementa en uno la evidencia a una lista de personas.
//Precondición: la evidencia aún no está asociada a esa persona.
//Nota 1: la persona y la evidencia existen, pero NO están asociadas.
//Nota 2: suponer que el ArrayList es de nombres.
//Eficiencia: O(N)
//Puntaje: 1


