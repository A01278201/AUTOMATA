% Primero definimos las transiciones del autómata

move(a, b, a).
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

% Estado de aceptación
estado_aceptacion(z).

% Verifica si una lista de caracteres es aceptada por el autómata
verificar_automata(ListaCaracteres) :-
    comprobar_automata(ListaCaracteres, a).

comprobar_automata([], EstadoInicial) :-
    estado_aceptacion(EstadoInicial).

comprobar_automata([Simbolo | RestoLista], EstadoInicial) :-
    mover(EstadoInicial, EstadoSiguiente, Simbolo),
    comprobar_automata(RestoLista, EstadoSiguiente).

% Casos de prueba
albudeite :-
    write('albudeite'), nl,
    write('Esperado: verdadero'), nl,
    verificar_automata([a, l, b, u, d, e, i, t, e]).

almirez :-
    write('almirez'), nl,
    write('Esperado: verdadero'), nl,
    verificar_automata([a, l, m, i, r, e, z]).

araq :-
    write('araq'), nl,
    write('Esperado: verdadero'), nl,
    verificar_automata([a, r, a, q]).

atambal :-
    write('atambal'), nl,
    write('Esperado: verdadero'), nl,
    verificar_automata([a, t, a, m, b, a, l]).

atanin :-
    write('atanin'), nl,
    write('Esperado: verdadero'), nl,
    verificar_automata([a, t, a, n, i, n]).

% Expresión regular equivalente: (^a)(l(budeite|mirez)|ta(mbal|nin)|raq)
