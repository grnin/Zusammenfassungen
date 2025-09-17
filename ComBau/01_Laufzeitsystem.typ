#import "../template_zusammenf.typ": *

= Laufzeitsysteme
- _Compiler:_ Transformiert Quellcode in Maschinencode.
- _Runtime System:_ Unterstützt die Programmausführung mit Software- und Hardware-Mechanismen.\
  Kann prozessor-nativ #hinweis[(C++)], VM-kompiliert #hinweis[(Java, C++)] oder
  interpretiert sein #hinweis[(Python, JavaScript)].

Source Code $arrow.r$ Compiler $arrow.r$ Maschinencode $arrow.r$ Laufzeitsystem

#grid(
  columns: (3fr, 1fr),
  gutter: 1em,
  [
    == Aufbau Compiler
    - _Lexer:_ Zerlegt Programmtext in Terminalsymbole #hinweis[(Tokens)]
    - _Parser:_ Erzeugt Syntaxbaum gemäss Programmstruktur
    - _Semantic Checker:_ Löst Symbole auf, prüft Typen und semantische Regeln
    - _Optimization:_ Wandelt Zwischendarstellung in effizientere Darstellung um #hinweis[(Optional)]
    - _Code Generation:_ Erzeugt ausführbaren Maschinencode
    - _Zwischendarstellung:_ Beschreibt Programm als Datenstruktur
  ],
  image("img/combau_01.png", width: 60%),
)

#grid(
  columns: (3fr, 1fr),
  gutter: 1em,
  [
    == Aufbau Laufzeitsystem
    - _Loader:_ Lädt Maschinencode in Speicher, veranlasst Ausführung
    - _Interpreter:_ Liest Instruktionen und emuliert diese in Software
    - _JIT Compiler:_ Übersetzt Code-Teile in Hardware-Instruktionscode
    - _HW-Ausführung:_ Lässt Instruktionscode direkt auf Prozessor laufen
    - _Metadaten, Heap & Stacks:_ Verwaltung von Programminfos, Objekten und Prozeduraufrufen
    - _Garbage Collection:_ Automatische Freigabe von nicht erreichbaren Objekten
  ],
  image("img/combau_02.png"),
)

== Definition einer Programmiersprache
- _Syntax:_ definiert Struktur des Programms #hinweis[(Bewährte Formalismen für Syntax)]
- _Semantik:_ definiert Bedeutung des Programms #hinweis[(Meist in Prosa beschrieben)]

Eine Sprache ist die _Menge von Folgen von Terminalsymbolen_, die mit der Syntax herleitbar sind.\
Die _Syntax_ einer Sprache ist formal definiert durch:
- _Menge von Terminalsymbolen_ #hinweis[(Können nicht weiter ersetzt werden: `"1"`, `"Hallo"`)]
- _Menge von Nicht-Terminalsymbolen_ #hinweis[(Können in der Syntax weiter ersetzt werden: `Term`, `Expression`)]
- _Menge von Produktionen_ #hinweis[(Definition einer Regel: `Expression = Term`)]
- _Startsymbol_ #hinweis[(In ComBau nicht weiter relevant)]


=== Formalismus zur Syntax-Definition
Beschreibung der Syntax mittels Regeln/Formeln:

`Language = Subject Verb
Subject = "Anna" | "Paul"
Verb = "talks" | "listens"`

Mit dieser Sprache können folgende Sätze gebildet werden:
"Anna talks", "Anna listens", "Paul talks" und "Paul listens".

==== Rekursion mit vereinfachter EBNF
`Expression = "(" ")" | "(" Expression ")"` $space arrow.r space$ "`()`", "`(())`", "`((()))`", usw.

#pagebreak()
