# Evidencia 1 - Implementación del análisis léxico

La lengua que elegí es la Chalkobsa el cual según investigue es un idioma ficticio de la novela Dune de Frank Herbert. También es el nombre de una lengua secreta que usaban los nobles y príncipes circasianos en la Edad Media. En este caso usaremos las siguientes cinco palabras:

1.	**albudeite** - agua escasa (nombre de Ishia)
2.	**almirez** - arena nueva, generalmente de color gris
3.	**araq** - sudor
4.	**atambal** - Arena impactada con la propiedad de amplificar cualquier golpe de sonido; se encuentra en la cara barloventa de las dunas
5.	**atanin** – papada

Un autómata finito es el modelo más básico para el reconocimiento de patrones, y existen dos tipos principales: el autómata finito determinista (DFA) y el autómata finito no determinista (NFA). En el caso del DFA, cada entrada específica lleva a un único estado, lo que significa que su comportamiento es completamente predecible. En contraste, el NFA presenta dos características distintivas: puede hacer transiciones con entradas nulas y permite que una misma entrada conduzca a múltiples estados posibles. Así, si se recibe una entrada particular, el autómata puede seguir diferentes caminos simultáneamente.

Bajo este concepto tome la desición de usar un DFA, ya que solo necesito que acepte las cinco palabras validas de mi lenguaje y ninguna más. Esto nos permite que se pueda seguir una ruta unica por cada palabra y no sea tan necesario implementar un NFA. 

# Modelos 

En este caso decidi crear un único autómata para todas mis palabras. Es importante destacar que el automata solo funcionara en base al siguiente alfabeto:

∑ = a, l, b, u, d, e, i, t, m, i, r, z, q, n

![automata corre](https://github.com/user-attachments/assets/64b8ed12-6c63-4eec-889a-fa925a70c6b2)

En base a este autómata me tome la tarea de llegar a la expresion regular mas abreviada que pude para el mismo. Al final llegue a la siguiente:

**(^a) (l(budeite | mirez) | ta(mbal | nin) | raq)**

Adjunto una captura de prueba desde regex101 para comprobar que la expresión funciona solo con mis cinco palabras del lenguaje:

![pruebaaa](https://github.com/user-attachments/assets/180623e1-949c-48e5-84ea-b4afa5e3a4a7)

# Implementación

Utilicé el autómata para construir una base de conocimiento en Prolog y realizar un análisis léxico. En esta base de conocimiento, cada transición está definida por un predicado move/3, que indica el estado actual, el siguiente estado y el símbolo de transición entre ellos.

**Definición de transiciones**

Las transiciones del autómata se modelan con la siguiente regla:

`move(estado_inicial, estado_siguiente, símbolo).`

Cada uno de estos hechos representa cómo se puede mover el autómata de un estado a otro al leer un símbolo específico.

**Estado de aceptación**

El autómata tiene un único estado de aceptación, aunque podrían definirse múltiples si fuera necesario. Esto se representa con:

`accepting_state(z).`

**Verificación de palabras en el autómata**

Para comprobar si una secuencia de símbolos es aceptada por el autómata, se utilizan reglas recursivas:

1. **Regla auxiliar**
   La función go_over_automaton/1 sirve como punto de entrada y comienza la verificación desde el estado inicial.

   go_over_automaton(ListtoCheck) :-
    automatonCheck(ListtoCheck, a).

2. **Caso Base**
   Si se ha recorrido toda la lista de símbolos, se verifica si el estado actual es un estado de aceptación.
   
   automatonCheck([], InitialState) :-
    accepting_state(InitialState).

4. **Caso recursivo**
   Se verifica si el estado actual y el símbolo de entrada tienen una transición definida. Si es así, se continúa con el siguiente estado y el resto de la lista.
   
   automatonCheck([Symbol | RestofList], InitialState) :-
    move(InitialState, NextState, Symbol),
    automatonCheck(RestofList, NextState).

**Archivo fuente**

Todas estas reglas y la base de conocimiento se almacenan en el archivo `automata.pl.` Si una palabra pertenece al lenguaje definido por el autómata, el programa devuelve `true`; de lo contrario, devuelve `false`.




    






