#import "../template_zusammenf.typ": *

= Semantische Analyse
Ein Programm kann _syntaktisch richtig_, aber _semantisch trotzdem falsch_ sein.

```cs
boolean x;
if ( x + x ) { int x; x = 0; } // bool nicht addierbar, x ist mehrfach deklariert
```

Der _Semantic Checker_ kümmert sich um die semantische Analyse. Er wendet _kontextsensitive Regeln_ an, welche
z.B. prüfen, ob zwei Werte addierbar sind oder ob eine Variable mehrfach definiert wird. Der Input ist ein konkreter
oder abstrakter _Syntaxbaum_ und der Output eine _Zwischendarstellung_ #hinweis[(Abstrakter Syntaxbaum + Symboltabelle)].

== Semantische Prüfung
Prüfe, dass Programm _alle_ über die Syntax hinausgehenden _Regeln_ enthält.
- _Deklaration:_ Jeder Identifier ist eindeutig deklariert
  #hinweis[(keine Mehrfachdeklarationen, kein Identifier ist ein reserviertes Keyword)]
- _Typen:_ Typregeln sind erfüllt #hinweis[(Typen stimmen bei Operatoren, Kompatible Typen bei Zuweisungen,
  Argumentliste passt auf Parameterliste, Bedingungen in `if`, `while` sind `boolean`, `return`-Ausdruck hat Wert des Return Types)]
- _Methodenaufrufe:_ Argumente und Parameter sind kompatibel
- _Weitere Regeln:_ z.B. keine zyklische Vererbung, nur eine `main()`-Methode, `array.length()` ist read-only

=== Benötigte Informationen
- _Deklarationen:_ Variablen, Methoden, Parameter, Felder, Klassen, Interfaces
- _Typen:_ Vordefinierte Typen #hinweis[(`int`, `boolean` etc.)], Benutzerdefinierte Typen #hinweis[(Klassen, Interfaces)],
  Arrays, Typ-Polymorphismus- und Vererbungsinformationen

== Symboltabelle
#grid(
  columns: (1.3fr, 1fr),
  gutter: 1.5em,
  [
    *Beispiel Deklarationen*
    ```cs
    class Counter {
      int number;
      void set(int value) {
        int temp;
        temp = number;
        number = value;
        writeInt(temp);
      }
      void increase() { number = number + 1; }
    }
    ```
  ],
  [
    Die Symboltabelle ist eine Datenstruktur zur Verwaltung der Deklarationen.
    Widerspiegelt hierarchische Bereiche im Programm, die _Scopes_.
    #image("img/combau_13.png")
  ],
)

=== Shadowing
Deklarationen in inneren Scopes _verdecken gleichnamige_ des äusseren Scopes. _Ausnahme:_ Innerhalb Scopes der
gleichen Methode ist Shadowing meist verboten #hinweis[(z.B selbe Variable in- und ausserhalb eines `while`-Loop definiert)]

=== Global Scope
Wenn es mehrere Klassen und Interfaces gibt, gibt es für jede Klasse eine Tabelle mit den klassenspezifischen Deklarationen.
Es gibt jedoch auch _Deklarationen im Global Scope_. Hier werden alle Klassen des Programms sowie globale Variablen referenziert.

Auch vordefinierte _Typen_ #hinweis[(Value Types wie int und boolean, Reference Types wie string)],
_Konstanten_ #hinweis[(true, false, null)], _this_ #hinweis[(in Methoden als read-only Parameter)],
_Built-in Methoden_ #hinweis[(`writeString()` etc.)] und _Felder_ #hinweis[(`length`: read-only und nur für Array-Typen)]
(aber keine Keywords!) werden hier eingetragen. Sie werden hier definiert, um die Implementation des Lexers und Parsers zu vereinfachen.

_Array Typen:_ Sind im Source _nicht_ mit eigenem Namen definiert. Haben eine _String-Repräsentation_ der Form
`<Element-Typ>"[]"`, damit sie via Namen nachgeschlagen werden können.

=== Aufbau der Symboltabelle
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [#image("img/combau_14.png")], [#image("img/combau_15.png")],
)

== Vorgehen
+ _Erstellen_ aller deklarierten Symbole #hinweis[(und Eintragen in die Symboltabelle)]
+ Typen aller Deklarationen _auflösen_
+ Verwendung der Deklarationen in AST #hinweis[(Abstract Syntax Tree)] _auflösen_
+ Typen in AST _prüfen_

=== Erstellen aller deklarierten Symbole
Die Symbole werden zuerst durch eine _Registrierung aller Deklarationen im Programm_ konstruiert.
Anschliessend wird der AST von _oben nach unten traversiert_, ausgehend vom Global Scope.
Pro Klasse, Interface, Methode, Parameter und Variable wird das _entsprechende Symbol_ in den _richtigen Bereich eingefügt_.

In dieser Phase werden die Deklarationen _nur gesammelt und registiert_, die Typen werden _noch nicht aufgelöst_.

=== Typen aller Deklarationen auflösen
In dieser Phase _löst_ der Semantic Checker _alle Typen_ der in der ersten Phase hinzugefügten Deklarationen _auf_
#hinweis[(Felder, Parameter, lokale Variablen, Return type, Basisklasse)]. Für jeden Typ wird der _entsprechende Zieltyp_
in der Symboltabelle gesucht. "Welches Symbol deklariert den Identifier?" Dies geschieht von _innen nach aussen_.

=== Verwendung der Deklarationen in AST auflösen
In disem Schritt werden die Anweisungen aller Methoden im AST traversiert und _jeder Designator aufgelöst_. Ein _Designator_
ist entweder eine _Variable_, ein _Arrayelement_ oder eine _Methode_. Bei einfachen Designatoren kann in der _Symboltabelle_
nach dem Namen gesucht werden. Bei einem _Member Access_ #hinweis[(z.B `car.seats`)], muss zuerst das Feld #hinweis[(`seats`)]
im Scope der Klasse #hinweis[(`car`)] nachgeschlagen werden. Bei einem _Arrayzugriff_ #hinweis[(z.B. `a[3]`)] wird nach der
Array-Typdefinition gesucht und daraus der Elementtyp erfasst.

#pagebreak()

=== Typen in AST prüfen
Mit einer _Post-Order-Traversierung_ werden die Typen zuerst in den unteren Knoten bestimmt. Die Typen der Blattknoten
sind vordefinierte Typen wie `int` oder `string`. _Designatoren_ haben die _Typen_, welche in der vorherigen Phase _bestimmt_
wurden. Unäre oder Binäre Ausdrücke erhalten ihren Typ je nach Operanden.\
Da in SmallJ der `+` Operator nur für `int` definiert ist, kann als Typ also implizit `int` angenommen werden. 


== Implementation
#grid(
  columns: (0.95fr, 1fr),
  gutter: 1em,
  [
    Wie beim Lexer und Parser arbeitet die _Semantische Analyse_ mit dem _Visitor Pattern_. Dabei fungiert das Feld
    `ExpressionType` als globaler Zustand, welche den Typ des zuletzt geprüften Nodes beinhaltet. Im nebenstehenden
    `BinaryExpressionNode` wird zuerst rekursiv der linke, dann der rechte Kindknoten geparst, um deren Typen zu erhalten.
    Gehört der Operator des Nodes zu einer arithmetischen Operation, wird geprüft, dass sowohl der linke, als auch rechte
    Teil des Ausdrucks einer `int`-Variable zuweisbar sind. Ist das der Fall, wird für diesen Node der Typ `int` in
    `ExpressionType` geschrieben.
  ],
  [
    ```cs
    TypeSymbol? ExpressionType { get; private set; }
    override void Visit(BinaryExpressionNode node) {
      var left = node.Left; var right = node.Right;
      left.Accept(this);
      var leftType = ExpressionType;
      right.Accept(this);
      var rightType = ExpressionType;
      switch (node.Operator) {
        case Operator.DIV or Operator.MINUS or ...:
          CheckAssignableTo(left, leftType, @int);
          CheckAssignableTo(right, rightType, @int);
          ExpressionType = @int; break;
      } }
    ```
  ],
)

== Intermediate Representation
Die Symboltabelle mit aufbereitetem AST ergibt eine _Zwischendarstellung_ für das Compiler-Backend.
Damit kann mit der _Code Generierung_ weitergefahren werden.
