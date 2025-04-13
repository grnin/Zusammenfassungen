#import "../template_zusammenf.typ": *

= Typ-Polymorphismus
== Vererbung
Zur Vereinfachung implementieren wir nur _single Inheritance_
#hinweis[(Jede Klasse kann nur von einer anderen Klasse direkt erben)]

```java
class Vehicle { /* ... */ }
class Car extends Vehicle { /* ... */ }
class Cabriolet extends Car { /* ... */ }
```

=== Code Reuse
Subklasse _erbt_ Variablen & Methoden und _erweitert_ Layout der Basisklasse.
#grid(
  columns: (1fr, 1.1fr),
  gutter: 1em,
  [
    ```java
    class Vehicle { int model; int color; }
    // type desc: Vehicle
    ```
  ],
  [
    ```java
    class Car extends Vehicle { int wheels; }
    // type desc: Car, beinhaltet auch model und wheels
    ```
  ],
)

== Typ-Polymorphismus
Objekt der Subklasse ist auch vom Typ der Basisklasse(n). Subtyp ist auf Basistyp _zuweisungskompatibel_.

```cs
Vehicle v;      // Statischer = deklarierter Typ, definiert zu Compile-Time
v = new Car();  // Dynamischer = effektiver Typ, existiert zu Runtime
                // statischer Typ != dynamischer Typ
```

=== Type Test & Cast
Für _Downcasts_ sind _dynamische Typchecks_ nötig, welche durch _`instanceof`_ realisiert werden. _Upcasts_ können
immer statisch vom Compiler determiniert werden. ```java null instanceof Car``` ergibt immer `false`, während
```java (Car)null``` ohne Fehler erfolgt. Dies funktioniert, da `null` auf jeden Reference-Type zuweisbar ist.
#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    ```java
    Vehicle v; Car c; v = ...;
    // Type Test
    // Dynamischer Typ von 'v' ist 'Vehicle' oder Subklasse
    if (v instanceof Car) {
      // Type Cast
      // Dynamischer Typ von 'v' ist 'Car' oder Subklasse
      c = (Car)v;
    }
    ```
  ],
  [
    #image("img/combau_26.png");
  ],
)

Type Casts _verändern_ den _Typ_ des Objektes _nicht_. Es reicht nicht aus, nur zu überprüfen, ob der dynamische
Typ `Car` ist, sondern man muss _die ganze Kette der Basistypen durchnavigieren_. Das ist jedoch _ineffizient_.
Deshalb gibt es _fixe Stufen_ für die Vererbung.

== Ancestor Tables
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    Die _fixen Stufen der Vererbung_ können für eine _effizientere Basistypenerkennung_ verwendet werden.
    Jeder Class Descriptor beinhaltet eine _Ancestor Table_, die eine _Tabelle aller Basisklassen_ in der Vererbungsliste
    der Klasse ist. Der erste Eintrag stellt die oberste Vererbungsstufe dar. Die _Ancestor Table_ beinhaltet immer
    auch die _aktuelle Klasse_. So lassen sich die Basisklassen _viel effizienter_ überprüfen. Die _Anzahl_ der
    Vererbungsstufen ist jedoch typischerweise _begrenzt_. Dieses System funktioniert nur bei _single Inheritance_.
  ],
  [
    #image("img/combau_27.png")
  ],
)

```cs
// implementation of 'instanceof'
var instance = CheckPointer(Pop());                     // pointer to the variable/object
var desc = heap.GetDescriptor(instance);                // dereference type tag of object
var target = CheckClassDescriptor(instruction.Operand); // type descriptor of target class
var level = target.AncestorLevel;                       // get ancestor level of target class
var table = desc.AncestorTable;
if (level >= ancestorTable.Length || level > desc.AncestorLevel) {
  throw new VirtualMachineException("Invalid cast");
}
Push(table[level] == target); // check if type at the ancestor level is the same as the target

// additional code for 'checkcast' after the 'instanceof' code
if (!CheckBoolean(Pop())) { throw new VMException("Invalid cast") } Push(instance);
```

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    Ein _Compiler_ kann gewisse _unnötige Type Tests_ oder Casts _eliminieren_, beispielsweise wenn der dynamische
    dem statischen Typ entspricht oder wenn ein _expliziter Upcast_ vorhanden ist.
  ],
  [
    ```java
    Vehicle v; Car c;
    v instanceof Vehicle // dynamic == static type
    c instanceof Vehicle // upcast to base class
    ```
  ],
)

Gewisse Programmiersprachen wie C\# haben eine _Root-Klasse_ #hinweis[(`object`)], von welcher alle anderen erben.
Diese lebt implizit in der Ancestor Table auf Stufe -1 und der Compiler kann _jeden Typ-Test_ zu dieser Klasse
immer mit _`true`_ beantworten, solange die Referenz nicht `null` ist.
Auch ein Type Cast zu dieser Klasse ist immer erfolgreich.

== Virtuelle Methoden
In SmallJ sind alle Methoden _Instanzmethoden_ #hinweis[(nicht statisch)] und
_virtuell_ #hinweis[(können überschrieben werden, overriding)]. Das bedeutet, dass eine Unterklasse eine
_gleichnamige Methodendeklaration_ #hinweis[(mit derselben Signatur)] beinhalten kann wie die Basisklasse.
In einem solchen Fall wird die Methode _nicht neu deklariert_, sondern _der Inhalt_ der geerbten Methode _wird ersetzt_.

```java
class Vehicle { void drive() { ... } void park() { ... } }
class Car extends Vehicle { void drive() { ... } /* überschreibt vehicle.drive() */ ... }
```

=== Dynamic Dispatch
Der _dynamische Typ_ #hinweis[(also Laufzeitsystem)] entscheidet, _welche Implementation_ aufgerufen wird.
Der einzige Zweck des statischen Typ ist, dem Compiler zu zeigen, dass eine deklarierte Methode existiert.\
Dynamic Dispatch ist nützlich für die _Erweiterbarkeit_ von Software, da es erlaubt, künftige Logik auf
_typsichere Art_ und Weise einzubauen #hinweis[(Es ist garantiert, dass die aufgerufene Methode existiert,
obwohl die Implementierung dynamisch ist)].

```java
Car c; c = new Car();
Vehicle v; v = c; // Dynamic Type = Car
v.drive();        // ruft Car.drive() auf
```

#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    === Virtual Method Table
    Da virtuelle Methodenaufrufe sehr häufig sind, benötigen sie eine schnelle Implementation in der Runtime.
    Sie werden durch eine _virtuelle Tabelle_ #hinweis[(vTable)] realisiert. Jeder _Klassendeskriptor_ hat eine Tabelle
    mit _seinen enthaltenen virtuellen Methoden_. Jeder Tabelleneintrag _assoziiert_ die Methodenimplementierung für die
    deklarierte Methode.

    Im Beispiel existieren zwei Klassendeskriptoren, einer für `Vehicle` und einer für `Car`. _`Vehicle`_ hat zwei
    Tabelleneinträge, da in dieser Klasse nur zwei Methoden deklariert sind; diese verweisen auf die
    _ursprüngliche Implementierung_. Da `drive()` in `Car` überschrieben wurde, zeigt dieser Eintrag der vTable von
    `Car` nun _nicht mehr_ auf `vehicle.drive()`, sondern auf die _neue_ `drive()`-Logik in `Car`.
  ],
  [
    #image("img/combau_28.png")
  ],
)

==== Lineare Erweiterung
Jede virtuelle Methode des Typs hat _einen Eintrag_ in der vTable. Methoden der Basisklasse sind oben, neu
deklarierte Methoden der Subklasse unten. Wird eine Methode _überschrieben_, wird sie nicht unten angefügt, sondern _ersetzt_.
Somit hat jede virtuelle Methode eine _fixe Position_ in der vTable. Diese ist im deklarierten Typ _statisch bekannt_.

==== Ausführen von Virtual Method Calls
Durch die Virtual Table funktioniert das Aufrufen einer Virtuellen Methode in _konstanter Zeit_ #hinweis[($O(1)$)].
Die _vTables_ und die dazugehörigen Positionen werden von der VM im Loader generiert.\
_Diese Schritte_ werden beim Aufrufen ausgeführt:
+ Der _Type Tag wird dereferenziert_, um den Klassendeskriptor für den dynamischen Typ des Objekts zu erhalten
+ Der _Klassendeskriptor enthält den Virtual Table_, in welchem der Eintrag mithilfe der bereits bekannten Position
  der deklarierten Methode nachgeschlagen wird #hinweis[(`drive()` hat Position 0 im Typ `Vehicle`)]
+ Der _entsprechende Method Descriptor wird aufgerufen_, um Informationen über Typen von Parameter, Return Type
  und Lokalen Variablen zu erhalten
+ Der _Code_ hinter dem vTable-Eintrag wird _ausgeführt_ #hinweis[(overridden `Car.drive()` Implementation)]

== Interfaces
Mittels Interfaces kann in SmallJ auch eine _eingeschränkte Mehrfachimplementierung_ angeboten werden.
Interfaces stellen _nur Methoden_ und _keine Instanzvariablen_ zur Verfügung.

```java
interface IA { void f(); }
interface IB { void g(); }
class Ab implements IA, IB { void f() { ... } void g(){ ... } }
```

Bei Interfaces würde wegen der _Mehrfachimplementierung_ der gleiche Ansatz wie mit den vTables _nicht_ funktionieren.
Bei den _vTables_ kann davon ausgegangen werden, dass jede Methode sowohl bei der Basisklasse als auch bei
der Klasse selbst die _gleiche Position_ in der Tabelle hat. Da eine Klasse jedoch von _mehreren_ Interfaces erben kann,
stimmt diese _Reihenfolge nicht überein_ #hinweis[(Eine Klasse `Ab` erbt von `IA` und von `IB` jeweils eine Methode,
die Implementation der Methode von `IB` steht bei der Table der Klasse `Ab` an zweiter Stelle, im Interface `IB`
jedoch an erster Stelle)].

Interfaces müssen deshalb vom Loader _global durchnummeriert_ werden. Pro Klassendeskriptor wird eine _Interface-Tabelle_
#hinweis[(iTable)] generiert. Sie enthält die Interfaces _an der Stelle_, an welcher sich die Interfaces auch in
der _globalen Tabelle_ befinden. Nicht implementierte Interfaces sind an ihrer Stelle im iTable `null`.\
Die Einträge in der _iTable verweisen_ dann auf die _vTable_ des _jeweiligen Interfaces_.

#grid(
  columns: (auto,) * 4,
  gutter: 1em,
  [
    ```
    Global Interface Table
    IA -> 0
    IB -> 1
    ```
  ],
  [
    ```
    class Ab implements IA, IB
    0 -> IA
    1 -> IB
    ```
  ],
  [
    ```
    class A implements IA
    0 -> IA
    1 -> null
    ```
  ],
  [
    ```
    class B implements IB
    0 -> null
    1 -> IB
    ```
  ]
)

Wird eine Methode eines Interfaces _gecallt_, wird vom Class Descriptor der Klasse auf die iTable verwiesen,
wo das Interface von der _iTable_ geholt und dort dem Verweis in der _vTable_ auf die korrekte Methode gefolgt wird.

=== Type Test & Cast bei Interfaces
- _Type Test:_ `y instanceof IA`
- _Type Cast:_ `(IA)y`
Verwendet den gleichen Mechanismus wie oben: _Prüfe_, ob der Interface Eintrag in der _iTable vorhanden_ ist.

=== Speicherproblem
Da es eine _globale Durchnummerierung_ der Interfaces gibt, entstehen bei den _einzelnen Klassen_ lange _iTables_ mit
_vielen Lücken_ durch nicht implementierte Interfaces. Somit kann es zu _Speicherproblemen_ kommen.

Als Abhilfe kann man die iTables mehrerer Interfaces im Speicher _kollisionsfrei_ übereinanderlegen.
#hinweis[(z.B. iTable `S` mit Eintrag bei Index 3 mit iTable `T` mit Einträgen 0 und 4 zu iTable `S&T` mit
Einträgen 0, 3 und 4 zusammenlegen)]\ Dafür muss man _prüfen_, ob der Eintrag für den aktuellen Typ _gültig_ ist.
Dies geschieht mit einem _Vermerk / Tag_ des Class Descriptors in der vTable.

Weiter _optimieren_ lässt sich dieses Konzept, indem man die einzelnen iTables zu _einer einzigen iTable zusammenfasst_
und alle Klassendesktriptoren dann auf einen _unterschiedlichen Offset_ in dieser "globalen" iTable zeigen, ab welchem
ihre implementierten Interfaces eingetragen sind.
