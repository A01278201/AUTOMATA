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

Utilicé un autómata para crear una base de conocimiento y realizar un análisis léxico en Prolog. En esta base de conocimiento, cada transición se define mediante un predicado de move, que representa el estado actual, el siguiente estado y el símbolo de transición entre ellos.


```move(a, b, a).
move(b, c, l).
move(c, d, b).
move(d, e, u).
move(e, f, d).
move(f, g, e).
move(g, h, i).
move(h, i, t).
move(i, z, e).

move(c, j, m).
move(j, k, i).
move(k, l, r).
move(l, m, e).
move(m, z, z).

move(b, n, r).
move(n, o, a).
move(o, z, q).

move(b, p, t).
move(p, q, a).
move(q, r, m).
move(r, s, b).
move(s, t, a).
move(t, z, l).

move(q, u, n).
move(u, y, i).
move(y, z, n).

```

Cada uno de estos hechos representa cómo se puede mover el autómata de un estado a otro al leer un símbolo específico.

**Estado de aceptación**

El autómata tiene un único estado de aceptación, aunque podrían definirse múltiples si fuera necesario. Esto se representa con:

```accepting_state(z).```



**Archivo fuente**

Todas estas reglas y la base de conocimiento se almacenan en el archivo `automata.pl.` Si una palabra pertenece al lenguaje definido por el autómata, el programa devuelve `true`; de lo contrario, devuelve `false`.

# Analisis

La complejidad temporal del reconocimiento de palabras en este autómata es O(n), donde n es la longitud de la palabra a verificar. Esta complejidad es consistente con el comportamiento de los autómatas finitos deterministas (DFA), cuya evaluación de cadenas es lineal con respecto al tamaño de la entrada.

# Comparación de Complejidad con Soluciones Alternativas

El reconocimiento de palabras en un lenguaje se puede resolver utilizando distintos enfoques computacionales. Le pregunte a Chat GPT sobre otras alternativas de solución comunes y me dio lo siguiente:

**Solución con Expresiones Regulares - O(n) en promedio, O(n²) en el peor caso**




    






