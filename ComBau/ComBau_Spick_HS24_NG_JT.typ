// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "ComBau",
  fach-long: "Compilerbau",
  semester: "HS24",
  landscape: true,
  display-title-footer: false,
  column-count: 4,
  font-size: 12pt,
)

// Global settings
#set par(justify: false, spacing: 0.5em, leading: 0.5em)
#set text(hyphenate: true)


= Laufzeitsysteme
Source Code $arrow$ Compiler $arrow$ Maschinencode $arrow$ Laufzeitsystem

#grid(
  columns: (1.4fr, 2fr),
  gutter: 1em,
  [#image("img/combau_01.png")], [#image("img/combau_02.png")],
)

*Syntax:* Struktur des Programms\
*Semantik:* Bedeutung des Programms


= EBNF-Syntax
Kann _kontextfreie Grammatiken_ #hinweis[(Extended Backus-Naur Form)] darstellen.
#small[
  #table(
    columns: (auto,) * 3,
    table.header([Begriff], [Beispiel], [Sätze]),
    [Konkatenation], [`"A" "B"`], ["`AB`"],
    [Alternative], [`"A" | "B"`], ["`A`" oder "`B`"],
    [Option], [`["A"]`], [$emptyset$ oder "`A`"],
    [Wiederholung], [`{"A"}`], [$emptyset$,`"A"`,`"AA"`, ...],
  )]

==== Beispiel: *$a * b + c$*
#hinweis[
  #tcolor("grün", `Expression`) `=` #tcolor("orange", `Term`) `|` #tcolor("grün", `Expression`) `"+"` #tcolor("orange", `Term`).\
  #tcolor("orange", `Term`) `=` #tcolor("rot", `Variable`) `|` #tcolor("orange", `Term`) `"*"` #tcolor("rot", `Variable`).\
  #tcolor("rot", `Variable`) `= "a" | "b" | "c" | "d"`.
]
\
#grid(
  columns: (1fr, 1fr),
  rows: 4em,
  [#image("img/combau_03.png")], [#image("img/combau_04.png")],
)

Darf nicht _mehrdeutig_ sein:
#hinweis[
  #tcolor("grün", `Expression`) `=` #tcolor("rot", `Number`) `|` #tcolor("grün", `Expression`) `"-"` #tcolor("grün", `Expression`).\
  #tcolor("rot", `Number`) `= "1" | "2" | "3"`.
]

#image("img/combau_05.png", width: 50%)

#hinweis[
  *Besser:*
  #tcolor("grün", `Expression`) `=` #tcolor("rot", `Number`) `{ "-"` #tcolor("rot", `Number`) `}`.
]


= Lexikalische Analyse
_Input:_ Zeichenfolge, _Output:_ Folge von Terminalsymbolen #hinweis[(Tokens)].\
Kann _Reguläre Sprachen_ analysieren.
#hinweis[(Regulär = hat rekursionsfreien EBNF oder kann in rekursionsfreien EBNF umgewandelt werden)]
Eliminiert _Whitespaces_ und _Kommentare_, merkt _Positionen_ im Code.\
*Maximum Munch:* Lexer ist greedy.\

*Vorteile:*
Abstraktion #hinweis[(Parser muss sich nicht um Textzeichen kümmern)],
Einfachheit #hinweis[(Parser hat nur noch Lookahead pro Symbol)],
Effizienz #hinweis[(benötigt keinen Stack)].\
Hat _one-character-lookahead_, um Typ immer bestimmen zu können.

*Tokens:*
_Fixe / Static Token `(1)`_ #hinweis[(Keywords, Operatoren, Interpunkt.)],
_Identifiers `(2)`_ #hinweis[`MyClass`],
_Integer `(3)`_ #hinweis[`123`],
_Strings `(4)`_ #hinweis[`"Hello"`],
_Characters `(5)`_ #hinweis[`'a'`] \
```java while (i < 100) {x = x + 1; }```
_`"while"`_ #hinweis[(1)],
_`"("`_ #hinweis[(1)],
_`"x"`_ #hinweis[(2)],
_`"<"`_ #hinweis[(1)],
_`100`_ #hinweis[(3)],
_`")"`_ #hinweis[(1)],
_`"{"`_ #hinweis[(1)],
_`"="`_ #hinweis[(1)],
_`"+"`_ #hinweis[(1)],
_`"1"`_ #hinweis[(3)],
_`";"`_ #hinweis[(1)],
_`"}"`_ #hinweis[(1)]

#hinweis[*Fehler:* Invalid Symbol, Unclosed stuff, overflow]


= Rec. Descent Parser
_Input:_ Tokens, _Output:_ Syntaxbaum\
Parser erkennt, ob Eingabetext den _Syntax_ erfüllt.
Funktioniert mit _kontextfreien Sprachen_ #hinweis[(als EBNF ausdrückbar + Stack)].
_Concrete Syntax Tree_ #hinweis[(Parse Tree)]: Vollständige Ableitung, erleichtert Parsen.
_Abstract Syntax Tree:_ Minimale Ableitung.

#grid(
  columns: (1fr, 1fr),
  rows: 6.5em,
  [#image("img/combau_07.png")], [#image("img/combau_08.png")],
)

==== Parser-Klassen
- _`L`_ für von links, _`R`_ für von rechts
- _`L`_ für Top down, _`R`_ für Bottom up
- _Zahl_ für Anzahl Token Lookahead

#image("img/combau_09.png", width: 90%)
#image("img/combau_10.png", width: 90%)
#hinweis[LR-Parser ist mächtiger als LL-Parser, kann Linksrekursion behandeln. `E = [E] "x"`]


= Semantische Analyse
Syntaktisch #emoji.checkmark `!=` Semantisch #emoji.checkmark\
_Input:_ Syntaxbaum, _Output:_ Symboltabelle. Prüft, ob das Programm korrekt ist, _kontextsensitive Grammatik_
#hinweis[(Designators aufgelöst, alles deklariert, Typregeln erfüllt, Argumente und Parameter kompatibel,
  keine zyklische Vererbung, nur eine main Methode, ...).]

*Symboltabelle:*
Datenstruktur zur Verwaltung von Deklarationen.
#image("img/combau_13.png")
#hinweis[
  ```java
  class Counter { int number;
    void set(int value) { int temp;
      temp = number; number = value; }
    void increase()
      { number = number + 1; } }
  ```
]

*Shadowing:* Deklaration innen verdecken gleichnamige äussere Scopes.\
*Global Scope:* Enthält vordefinierte Typen, Konstanten, `this`, Built-in\ Methoden und `array.length`


= Code-Generierung
_Input:_ Zwischendarstellung, _Output:_ Ausführbarer Maschinencode\
*Visitor Pattern:* Traversieren des AST pro Methode\
#small[
  ```java while (x < 10) { x = x + 1; }```
  ```asm begin: load 1
         ldc 10
         icmplt
         if_false end
         load 1
         ldc 1
         iadd
         store 1
         goto begin
  end:   ...
  ```
]
#image("img/combau_42.png", width: 94%)
#hinweis[
  + `this`-Referenz: Index 0
  + $n$ Params: Index $1 ... n$
  + $m$ lokale Variablen: Index $n+1...n+m$
]


= Code-Optimierung
_Arithmetik_ #hinweis[(Zweierpotenzen in Bit-Operation umwandeln)],
_Algebraisch_ #hinweis[(Redundante Operatoren entfernen, konstante Literale zusammenfassen)],
_Loop-Invariant Code Motion_ #hinweis[(Unveränderter Code aus Schlaufe nehmen)],
_Common Subexpressions_ #hinweis[(Wiederholt ausgewertete Teilausdrücke zusammenfassen)],
_Dead Code Elimination_ #hinweis[(Nicht Verwendetes entfernen)],
_Copy Propagation_ #hinweis[(redundante `load` und `stores` entfernen)],
_Constant Propagation_ #hinweis[(konstante Variablen durch Konstante ersetzen)],
_Partial Redundancy Elimination_ #hinweis[(Expressions in Pfaden so wenig wie möglich evaluieren)]\

*Static Single Assignment (SSA):*\
Variablen werden umbenannt, damit jede nur ein einziges Mal zugewiesen wird
#hinweis[(Veränderungen schnell erkennbar)].\
Bei Verzweigungen: $phi$`(x1, x2)`\

*Peephole Optimization:*
Sliding Window, Optimierungen werden auf diesen kleinen Bereich vorgenommen.


= Virtual Machine
Nützlich für _Mehrplattformensupport_.\

*Loader:*
_Liest Assembly_ und _alloziert_ notwendige _Laufzeitstrukturen_.\
Kreiert Metadaten, initiiert Programmausführung.\

*Interpreter:*
Arbeitet mit einem _Call Stack_, der aus _Activation Frames_ besteht.
Jeder _Activation Frame_ verwaltet einen _Evaluation Stack_.

*Instruction Pointer:*
Adresse der nächsten Instruktion\
#hinweis[(springt bei Branches \<Zahl> + 1)]\

*Evaluation Stack:*
Stack der Methode. #hinweis[(item = register)]\

*Call Stack:*
Stack der _Methoden-\ aufrufe_. Verwaltet lokale Variablen und Rücksprungadresse #hinweis[(item = activation frame)]
_Managed_ #hinweis[(mit Klassen modelliert)]
_Unmanaged_ #hinweis[(Funktioniert mit Stack Pointer und Base Pointer)]


= Objekt-Orientierung
*Heap:*
Objekte im Laufzeitsystem werden im Heap gespeichert
#hinweis[(Können nicht auf Stack gespeichert werden wegen nicht-hierarchischer Lifetime Dependency)].
Ist ein linearer Adressraum. _Unabhängig_ vom Call Stack. Objekte werden immer durch eine _Referenz_ verwiesen.

*Objektblock:*
_Mark Flag_ #hinweis[(Für GC)],
_Block Size_ #hinweis[(Gesamtgrösse des Blocks)],
_Type Tag_ #hinweis[(Referenz zum Class Descriptor)],
_Fields_ #hinweis[(Inhalt des Blocks)]
#image("img/combau_25.png")

*Typ-Polymorphismus:*
_Subklasse_ erbt von und erweitert _Basisklasse_. _Downcasts_ müssen dynamisch überprüft werden.\

*Ancestor Tables:*
Jeder Class Descriptor hat eine #hinweis[(Nur bei Single Inheritance)].
#image("img/combau_27.png", width: 90%)

*Virtuelle Methoden:*
Methoden können _überschrieben_ werden, Inhalt der bestehenden Methode wird ersetzt.\

*Virtual Method Table:*
Jeder _Klassendeskriptor_ hat eine _vTable_ mit den Methoden
#hinweis[(zu oberst von Basisklasse, bei Overriding wird nicht ersetzt, sondern ergänzt).]\

*Typdekriptoren:*
Werden vom Loader generiert. Nützlich für Type Checking, Ancestor Table, vTables #hinweis[(im Bild)].
#image("img/combau_28.png", width: 90%)

*iTable:*
Global durchnummeriert, jede Methode hat in ihrer iTable an der Stelle Interfaces,
wo sie sich auch in der globalen Tabelle befinden. Die Einträge verweisen auf vTables.


= Garbage Collection
*Dangling Pointer:* Referenz auf bereits gelöschtes Element\
*Memory Leak:* Verwaiste Objekte\
*Garbage:* Nicht mehr verwendete und erreichbare Objekte

*Reference Counting:*
Counter pro Objekt mit eingehenden Referenzen\
#hinweis[(Problematisch bei Zyklen).]\

*Ablauf:*
_Mark Phase_ #hinweis[(Ausgehend vom Root Set (Call Stack) werden alle erreichbaren Objekte markiert)]\
_Sweep Phase_ #hinweis[(Alle nicht markierten Objekte werden gelöscht)]

*Free List:*
Liste der freien Blöcke, wird bei Allozierung traversiert. Nebeneinanderliegende werden wieder verschmolzen.\

*Stop & Go:*
GC läuft _sequenziell_ und _exklusiv_. Mutator muss warten.\
#hinweis[Mark-Phase hätte Probleme bei Parallelität wegen Heap-Veränderungen, Sweep-Phase würde aber funktionieren.]\

*Compacting GC / Moving GC:*
Schiebt Objekte im Heap wieder zusammen. Der freie Speicher befindet sich zu hinterst im Heap.
Referenzen müssen _nachgetragen_ werden. _Mark-Phase_ gleich wie bei Stop & Go,
_Sweep-Phase_ hätte dann der Mutator Zugriff auf verschobene Adressen.
#hinweis[(Vorteile: Eliminiert External Fragmentation, schnelle Speicherallozierung)]


= JIT Compiler
*Profiling:*
Ausführung von Code-Teilen zählen, um _Hot Spots_ #hinweis[(oft ausgeführter Code)] zu erkennen.\

*Intel 64 Architektur:*
Instruktionen benutzen _Register_ #hinweis[(`RSP`: Stack Pointer, `RBP`: Base Pointer, `RIP`: Instruction Pointer)]

#small[
  ```cs
  load 1 // x laden
  ldc 1  // 1 laden
  isub   // x - 1
  ldc 3  // 3 laden
  idiv   // RAX = (x - 1) / 3
  ```
  ```asm
  # x64 Code: x sei in RAX
  MOV RBX, 1    # 1 laden
  SUB RAX, RBX  # RAX = x - 1
  MOV RBX, 3    # 3 laden
  CDQ           # RDX vorbereiten
  IDIV RBX      # RAX = (x-1)/3
  # Resultat ist in RAX
  ```
]

*Lokale Register-Allokation:*
Jeder Eintrag des Eval. Stack wird auf ein Register abgebildet.

*Globale Register-Allokation:*
Zusätzlich auch lokale Variablen und Params.
