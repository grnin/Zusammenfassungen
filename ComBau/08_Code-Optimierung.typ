#import "../template_zusammenf.typ": *

= Code-Optimierung
Code-Optimierungen können an _verschiedenen Orten im Compiler_ angewendet werden.
- _Ahead-of-Time Compiler:_ Vor #hinweis[(Plattform-unabhängig)] oder nach #hinweis[(VM-Abhängig)] der Code-Generierung
- _JIT-Compiler:_ Vor #hinweis[(Maschinen-unabhängig)] oder nach #hinweis[(Maschinen-Abhängig)] der Code-Generierung

#grid(
  columns: (5fr, 1fr),
  gutter: 1em,
  [
    == Aufgaben der Optimierung
    Die Aufgabe der Optimierung ist es, eine _Zwischendarstellung_ in eine _effizientere_, aber
    _gleichwertige_ Darstellung umzuwandeln.

    ==== Mögliche Zwischendarstellungen
    - _AST + Symbol-Tabelle_
    - _Bytecode_
    - _Three-Address-Code mit Registern_ #hinweis[(Zwei Operanden und ein Resultat)]
  ],
  image("img/combau_31.png"),
)

== Optimierte Arithmetik
Je nach Maschine können gewisse Operationen _"teurer"_ sein als andere. Dies gilt insbesondere für die _Multiplikation_,
_Division_ und _Modulo_. Diese Operationen umzuschreiben kann zu einer _Leistungssteigerung_ führen.

=== Bit-Operationen
Multiplikation, Division oder Modulo mit einer _Zweierpotenz_ können in eine _Bit-Operation_ umgewandelt werden.
#table(
  columns: (0.2fr, 1fr),
  table.header([Original], [Optimiert]),
  [`x * 32`], [`x << 5` #hinweis[($2^5 = 32$, Bitshift um 5 Stellen nach links)]],
  [`x / 32`], [`x >> 5` #hinweis[(Bitshift um 5 Stellen nach rechts)]],
  [`x % 32`],
  [
    `x & 31` #hinweis[(Bitwise and, "isoliert" die 5 hintersten Bits,
    welche kleiner als 32 sind und den Rest von $x div 32$ darstellen)]
  ],
)

=== Algebraische Vereinfachung
- Entfernung von _redundanten Operatoren_ #hinweis[(`Expr / 1 => Expr, Expr * 0 => 0`)]
- AST-Bäume, die nur aus _konstanten Literalen_ bestehen, können _zusammengefasst_ werden #hinweis[(`1 + 3 => ldc 4`)]
- Sonstige _redundanten_ AST-Bäume #hinweis[(Doppel-Minus: `--Expr => Expr`)]

Diese Expressions dürfen aber nur vereinfacht werden, wenn sie _keine Seiteneffekte_ besitzen\
#hinweis[(Keine Exceptions, kein Schreiben von Variablen, keine I/O-Operationen)]

=== Loop-Invariant Code
Code in einer _Schlaufe_, welcher sich jedoch nicht verändert, kann aus der Schlaufe _herausgenommen_ werden.
So muss er _nicht_ bei jedem Durchlauf _neu evaluiert_ werden. Dies nennt man _Code Motion_.

#grid(
  columns: (auto,) * 3,
  gutter: 2em,
  align: horizon,
  [
    ```cs
    while (x < N * M) {
      k = y * M;
      x = x + k;
    }
    ```
  ],
  [`=>`],
  [
    ```cs
    k = y * M; temp = N * M;
    while (x < temp) {
      x = x + k;
    }
    ```
  ]
)

== Common Subexpressions
Wiederholt ausgewertete _Teilausdrücke_ können _zusammengefasst_ werden, vorausgesetzt, sie _verändern_
sich zwischen den Auswertungen _nicht_. Dieser Schritt heisst _Common Subexpression Elimination (CSE)_.

#grid(
  columns: (auto,) * 3,
  gutter: 2em,
  align: horizon,
  [
    ```cs
    ...
    x = a * b + c;
    ...
    y = a * b + d;
    ```
  ],
  [`=>`],
  [
    ```cs
    temp = a * b;
    x = temp + c;
    ...
    y = temp + d;
    ```
  ]
)

#pagebreak()

== Dead Code Elimination
Wird eine Variable geschrieben, aber nachher _nicht weiterverwendet_, ist das _Dead Code_ und kann _entfernt_ werden.
Dabei ist darauf zu achten, dass nach der Entfernung von Dead Code allfällig _neu entstandener Dead Code_ ebenfalls
entfernt werden muss. Dies _verkleinert_ die Code-Grösse, was die _Laufzeit_ durch weniger Cache-Benutzung
und Ladezeiten _verbessert_.

#grid(
  columns: (auto,) * 5,
  gutter: 1em,
  align: horizon,
  [
    ```cs
    a = readInt();
    b = a + 1;
    writeInt(a);
    c = b / 2; // wird nicht verwendet
    ```
  ],
  [`=>`],
  [
    ```cs
    a = readInt();
    b = a + 1; // wird nicht verwendet
    writeInt(a);
    ```
  ],
  [`=>`],
  [
    ```cs
    a = readInt();
    writeInt(a);
    ```
  ]
)

== Copy Propagation
Code, der redundante `loads` und `stores` beinhaltet, kann ebenfalls _vereinfacht_ werden. Dabei wird bei jedem Lesen
einer Variable diese durch ihr _letztes Assignment ersetzt_. Hier im Beispiel zusammen mit Dead Code Elimination:

#grid(
  columns: (auto,) * 7,
  gutter: 1em,
  align: horizon,
  [
    ```cs
    t = x + y;
    u = t;
    writeInt(u);
    ```
  ],
  [`=>`],
  [
    ```cs
    t = x + y;
    u = x + y; // <-
    writeInt(u);
    ```
  ],
  [`=>`],
  [
    ```cs
    t = x + y;
    u = x + y;
    writeInt(x + y); // <-
    ```
  ],
  [`=>`],
  [
    ```cs
    writeInt(x + y);
    ```
  ]
)

== Constant Propagation
Wird auch _Constant Folding_ genannt. Wenn durch eine statische Analyse festgestellt wird, dass mehrere Variablen
zur Laufzeit _garantiert immer den gleichen Wert_ haben, sind diese _konstant_ und können entsprechend durch diese
Konstante _ersetzt_ werden. Anschliessend kann in einem weiteren Schritt Dead Code und Duplikate entfernt werden.

#grid(
  columns: (auto,) * 3,
  gutter: 2em,
  align: horizon,
  [
    ```cs
    a = 1;
    if ( ... ) {
      a = a + 1; // a immer 2
      b = a;     // b immer 2
    } else {
      b = 2;     // b immer 2
    }
    c = b + 1;   // c immer 3
    ```
  ],
  [`=>`],
  [
    ```cs
    a = 1;
    if ( ... ) {
      a = 2;
      b = 2;
    } else {
      b = 2;
    }
    c = 3;
    ```
  ]
)

== Partial Redundancy Elimination
Eine Expression ist partial redundant, wenn sie in _einigen_, aber nicht allen Pfaden _erneut berechnet wird_.

Im Beispiel wird `x + 4` beim Durchlauf des `if`-Pfades _zweimal_ evaluiert, im `else`-Pfad jedoch nur _einmal_.\
Dies kann behoben werden, indem die Expression _in beiden Pfaden_ evaluiert wird, dafür am _Schluss nicht mehr_.\
So wird sie in beiden Pfaden _nur jeweils einmal_ evaluiert. Dafür gibt es in diesem Beispiel _mehr Lese- und Schreiboperationen_.

#grid(
  columns: (auto,) * 3,
  gutter: 2em,
  align: horizon,
  [
    ```cs
    if ( ... ) {
      y = x + 4;
    } else {
      ...
    }
    z = x + 4;
    ```
  ],
  [`=>`],
  [
    ```cs
    if ( ... ) {
      t = x + 4;
      y = t;
    } else {
      ...
      t = x + 4;
    }
    z = t;
    ```
  ]
)


== Erkennung von Optimierungspotential
Es ist immer ein _Abwägen_, welche Optimierung am sinnvollsten ist. Eine Optimierung kann wiederum ein anderes
Optimierungspotential auslösen.

Es gibt verschiedene _Techniken_, um Optimierungspotential zu erkennen:
- Static Single Assignment
- Peephole Optimization
- Dataflow Analysis #hinweis[(Wird in ComBau nicht behandelt)]


=== Static Single Assignment (SSA)
_Static Single Assignment_ ist eine Codetransformation, die verschiedene Analysen und Optimierungen _erleichtert_,
die auf dem _Lesen_ und _Schreiben_ von _Variablen_ beruhen.

Es kann auf einen _Abstract Syntax Tree_ #hinweis[(AST)], auf _Intermediate Code_ oder auf _Maschinencode_ angewendet werden.
_Das Ziel ist einfach:_ Jede Variable wird _nur einmal_ im Code zugewiesen. Der Code wird also wie folgt _umgeschrieben_,
sodass bei jeder _neuen Zuweisung_ ein _anderer Variablenname_ verwendet wird:

#grid(
  columns: (auto,) * 3,
  gutter: 2em,
  align: horizon,
  [```cs x = 1; x = 2; y = x;```], [`=>`], [```cs x1 = 1; x2 = 2; y1 = x2;```]
)

Damit ist schnell ersichtlich, ob sich eine Variable _geändert_ hat oder nicht.

Bei _Verzweigungen_ wird es etwas komplexer, weil nicht klar ist, welche Version der Variable weiterverwendet wird.
Dafür gibt es die _*$phi$*(`x1`, `x2`)-Funktion_: Falls der erste Pfad ausgeführt wird, wähle den ersten Wert, ansonsten
den zweiten. In echtem Maschinencode wird die $phi$-Funktion durch eine _temporäre Variable_ realisiert.

```cs
if ( ... ) { x1 = 1; } else { x2 = 2; }
y1 = φ(x1, x2)
```

==== Common Subexpressions in SSA
Common Subexpressions sind in SSA _direkt entscheidbar_, weil sofort erkannt wird, ob sich die Variablen in der
Zwischenzeit _geändert_ haben.

```cs
x1 = a1 * b1 + c1;
...
y1 = a1 * b1 + d1; //a und b enthalten denselben Wert wie vorhin, können also zusammengefasst werden
...
z = a1 * b2 + d3; // b und d wurden in der Zwischenzeit geändert
```

==== Dead Code Elimination in SSA
```cs
x1 = 1; // x1 wird nie gelesen => Dead Code, zu entfernen
x2 = 2; // wird gelesen, darf nicht entfernt werden
y1 = x2 + 1;
writeInt(y1);
```

==== SSA-Berechnung
Die _Umwandlung der Variablen_ und vor allem die _Platzierung der Phis_ ist sehr _aufwendig_. In simplen oder
performance-optimierten Compilern wie bei JIT wird darum häufig darauf verzichtet. Hier sind günstigere Techniken
gewünscht, wie zum Beispiel die _Peephole Optimization_.

=== Peephole Optimization
#grid(
  columns: (1.2fr, 1fr),
  gutter: 1em,
  [
    Die Peephole Optimization ist eine sehr _einfache und günstige_ Technik, um Optimierungen vorzunehmen.
    Im JIT-Compiler wird sie für Intermediate Code oder Maschinencode benutzt.

    Die Technik verwendet ein _"Sliding Window"_ mit z.B. jeweils 3 Instruktionen. Es werden _nur_ diese 3
    Instruktionen angesehen und _mögliche Optimierungen angewendet_. Anschliessend wird das Fenster um 1 weitergeschoben.
  ],
  image("img/combau_32.png"),
)

== Zusammenfassung
#table(
  columns: (0.4fr, 1fr),
  table.header([Techniken], [Optimierung, die die Technik ermöglicht]),
  [Template-Based Code Gen,\ Peephole Optimization], [Optimierte Arithmetik, Algebraische Vereinfachung],
  [Static Single Assignment (SSA)],
  [
    Common Subexpression Elimination, Dead Code Elimination, Copy Propagation,
    Constant Propagation, Partial Redundancy Elimination
  ],
)
