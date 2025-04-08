#import "../template_zusammenf.typ": *

= Objekt-Orientierung
Die wichtigsten Merkmale der Objekt-Orientierung kommen erst zur Laufzeit zum Tragen.
Dazu gehören Themen wie _Speicherverwaltung_ und _Typpolymorphie_.

== OO im Compiler
In der _Entwicklung des Compilers_ wurden bereits einige OO-Features eingebaut:

==== Lexer
Der _`new()`-Operator_ musste erkannt werden für die Instanzierung von Klassen, die Erstellung von Arrays
sowie der `instanceof`-Operator. Das _`this`-Keyword_ ist zwar reserviert, wurde im Lexer aber als Identifier behandelt
und erst später im Semantic Checker weiterverarbeitet.

==== Parser
Hier wurden _mehrere Konstrukte_ für die Objekt-Orientierung verwendet: _Indirect Access Designators_, wie Member Accesses
für Felder #hinweis[(```java car.seats```)] oder _Methoden_ #hinweis[(```java car.drive()```)],
_Type Casts_ #hinweis[(```java (Vehicle)car```)] und _Type Tests_ #hinweis[(```java car instanceof Vehicle```)], als auch die
_Definition von Basisklassen_ #hinweis[(```java class Car extends Vehicle```)]
und Interfaces #hinweis[(```java class Lambo implements SportsCar```)].

==== Semantic Checker
Die Designator- und Typenauflösung musste OO-Features beinhalten, wie die _Auflösung von Member- oder
Element Access Designators_, die _`this`-Referenz_ und auch Typen für die _Objekterzeugung_, _Arrayerzeugung_, _Feldzugriffe_,
_Methodenaufrufe_, _Type Casts_ und _Type Tests_. Eine _spezielle Prüfung_ stellt fest, dass _`this`_ ein
_reserviertes Schlüsselwort_ ist, dass nur _gelesen_ werden kann.

Auch im _Semantic Checker_ sind bereits _OO-Features implementiert_: Zuweisungs-Kompabilität der Typen,
`null` kann jedem Referenztyp zugewiesen werden, Subklasse kann zu Basisklasse zugewiesen werden #hinweis[(impliziter Upcast)],
Interface-Typ passt auf Klassen, welche Interface implementieren, Typüberprüfungen bei `a == b`.

Ebenfalls wird auf zyklische Vererbungen geprüft: ```java class A extends B {} class B extends A {}``` ist nicht erlaubt.
`extends` darf nur bei Klassen, `implements` nur bei Interfaces verwendet werden. Beim Overriding muss diesselbe Signatur
und Rückgabetyp verwendet werden. Overloading ist in SmallJ nicht erlaubt.

#grid(
  columns: (0.3fr, 1fr),
  gutter: 1em,
  [
    ```java
    class Base {
      void f(int x) {}
    }
    ```
  ],
  [
    ```java
    class Sub extends Base {
      int f(string s) {} // Signature doesn't match, not allowed
    }
    ```
  ],
)

==== Code Generator
Im Code Generator sind _mehrere Opcodes_ für die OO-Unterstützung nötig: _`getfield`_ und _`readfield`_ lesen
bzw. schreiben Felder einer Klasse, _`new`_ initalisiert neue Instanzen und _`ldc null`_ lädt die `null`-Referenz.

#table(
  columns: (1fr,) * 4,
  table.header([Code], [Stack davor #hinweis[(links = oben)]], [Instruktion], [Stack danach]),
  [`p.left`], [`p`], [`getfield left`], [`value`],
  [`p.left = value`], [`value, p`], [`putfield left`], [---],
  [`new Point()`], [---], [`new Point`], [`reference` zu Point Obj.],
  [`null`], [---], [`ldc null`], [`null`]
)

== Heap
#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    Objekte werden in einem _speziellen Speicher im Laufzeitsystem_, im sogenannten _Heap_, gespeichert.
    Der _Heap_ ist ein linearer Adressraum, in welchem die Objekte alloziert werden.
    Jedes Objekt benötigt einen _individuellen Speicher_ für seine Felder und Typinformationen.

    Der Heap ist _unabhängig_ vom Call Stack. Anders als Parameter oder lokale Variablen, können Objekte normalerweise
    nicht auf dem Call Stack gespeichert werden, weil Objekte nicht zwingend an die _Lebensdauer einer Methode gebunden_ sind.
    Dies nennt man _Method Escape_.

    ```cs
    Point getPoint() { return new Point(); }
    void setup(Rectangle r) { r.topLeft = new Point(); }
    // Points/Rectangles live longer than their creating method
    ```
  ],
  [#image("img/combau_23.png")],
)

=== Allokation
Ohne Garbage Collector gibt es noch _keine Freigabe / Deallokation_, deshalb wird Speicher einfach
_fortlaufend_ alloziert, bis der _Heap voll_ ist. SmallJ unterstützt keine expliziten `free`/`delete` Statements
und ist deswegen vollständig vom _Garbage Collector abhängig_.

=== Deallokation
Es gibt keine _Hierarchie_ unter Objekten und auch keine hierarchische _Lebensdauer_. Eine _Deallokation_ verursacht
deshalb _Lücken_ im Heap, welche mit dem Garbage Collector wieder aufgeräumt werden müssen.

== Objekt-Referenzen
Auf Objekte wird in SmallJ immer durch eine _Referenz_ verwiesen #hinweis[(Call by Reference)]. Die Variablen speichern
nur die Referenzen, d.h. die _Speicheradresse_ des Objektes im Heap. Diese Referenz bzw. dieser Zeiger ermöglicht es,
_zum Heap-Block zu navigieren_ und auf dessen Inhalt zuzugreifen oder Methoden für dieses Objekt aufzurufen --
sogenanntes _Dereferencing_. Das Dereferencing von `null` führt zu einem Laufzeitfehler.

Referenzen können statisch sein oder vom Stack oder Heap kommen.
- _Stack-Referenzen:_ Referenzen in lokalen Variablen, Parametern oder Evaluation Stacks
- _Heap-Referenzen:_ Von Instanzfeldern oder Feldern in Arrays
- _Statische Referenzen:_ In SmallJ nicht vorhanden
- _Register-Referenzen:_ JIT-kompilierter Code

== Native Memory Access
Die VM verwendet einen _unmanaged Heap_, damit die .NET Runtime bei diesem nicht selbst die Garbage Collection ausführt.
Der Heap wird mit 64-Bit Pointern addressiert und darf keine .NET-Referenzen speichern. Stattdessen findet das Mapping
über ein ```cs Dictionary<long, object>``` statt.

```cs
ulong[] _heap = new ulong[HeapSize];
long value = Read(address); ... Write(address, value);
```

== Objektblock-Layout
Das interne Layout der Blöcke im .NET Array bzw. Heap wird wie folgt definiert. Jedes dieser Elemente wird durch
einen eigenen Eintrag im Array repräsentiert, jeder Eintrag ist 8 Byte gross.
- _Mark Flag:_ Aktuell noch leer, reserviert für GC
- _Block Size:_ Gesamtgrösse des Heap Blocks
- _Type Tag:_ Eine Referenz zum entsprechenden Class Descriptor, Mapping via .NET Dictionary
- _Fields:_ Hier ist der Inhalt des Blocks gespeichert. Der Pointer zeigt direkt hierhin.
  Damit alle Felder gleich gross sind, werden sie mit _Padding_ bis 64 Bit bzw. 8 Byte aufgefüllt.

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [#image("img/combau_24.png")], [#image("img/combau_25.png")],
)
