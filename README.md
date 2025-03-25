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

# Implementación y pruebas de la expresión regular

Para mi implementación de la expresión regular utilice C++

```
#include <iostream>
#include <regex>
#include <vector>

using namespace std;

bool coincide_expresion(const string &palabra) {
    regex patron(R"(^a(l(budeite|mirez)|ta(mbal|nin)|raq))"); // Expresión regular
    return regex_match(palabra, patron);
}

void probar_expresion() {
    vector<string> palabras = {
        "albudeite", "almirez", "atambal", "atanin", "araq",
        "alba", "atamin", "a", "albur", "albañil", "at"
    };

    for (const auto &palabra : palabras) {
        cout << palabra << " -> " << (coincide_expresion(palabra) ? "Coincide" : "No coincide") << endl;
    }
}

int main() {
    probar_expresion();
    return 0;
}
```

# Implementación

Primero, se definen las transiciones del autómata con la relación move/3. Cada transición tiene un estado de origen, un estado de destino y un símbolo (una letra). Estas reglas modelan cómo se pueden formar las palabras a partir del estado inicial a hasta el estado de aceptación z.

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

El autómata tiene un único estado de aceptación, aunque podrían definirse múltiples si fuera necesario. Esto se representa con:

```accepting_state(z).```

La función principal `verificar_automata` inicia la verificación llamando a `comprobar_automata`, que es una función recursiva. Esta función revisa cada letra de la lista y verifica si existe una transición válida hasta llegar a un estado final.

Por último, se incluyen varios casos de prueba, como `albudeite`, `almirez`, `araq`, `atambal` y `atanin`. Cada uno imprime la palabra y el resultado esperado (verdadero si la palabra es reconocida por el autómata). Esto permite comprobar que la implementación funciona correctamente.



# Analisis

La complejidad temporal del reconocimiento de palabras en este autómata es O(n), donde n es la longitud de la palabra a verificar. Esta complejidad es consistente con el comportamiento de los autómatas finitos deterministas (DFA), cuya evaluación de cadenas es lineal con respecto al tamaño de la entrada. Por supuesto esto se podia solucionar con un NFA, por poner un ejemplo, sin embargo en este caso particular solo seria volver el trabajo mas pesado ya que nuestro lenguaje solo requiere la validez de cinco palabras.

El reconocimiento de palabras en un lenguaje se puede resolver utilizando distintos enfoques computacionales. Le pregunte a Chat GPT sobre otras alternativas de solución comunes y encontre lo siguiente:

- Una alternativa sería usar expresiones regulares, que también tienen O(n) en el mejor caso, pero pueden ser más eficientes si están bien optimizadas en lenguajes como Python o C.

- Otra opción sería un árbol de prefijos (trie), que permite búsquedas rápidas pero requiere más memoria. En este caso, la complejidad sigue siendo O(n), pero con mejor manejo de múltiples palabras.

- En resumen, la solución en Prolog es sencilla y clara, pero si se quisiera procesar muchas palabras de manera eficiente, otras estructuras podrían ser mejores.




# Referencias

Hopcroft, J. E., Motwani, R., & Ullman, J. D. (2006). Introduction to Automata Theory, Languages, and Computation. Pearson.

Sipser, M. (2012). Introduction to the Theory of Computation. Cengage Learning.

Stroustrup, B. (2013). The C++ Programming Language (4th Edition). Addison-Wesley.

Aho, A. V., Lam, M. S., Sethi, R., & Ullman, J. D. (2006). Compilers: Principles, Techniques, and Tools (2nd Edition). Pearson.

Documentación oficial de C++: cplusplus.com


    






