#import "../template_zusammenf.typ": *

= Recursive Descent Parser
Der _Parser_ kümmert sich um die syntaktische Analyse. Der Input ist eine _Reihe von Terminalsymbolen_ des Lexers
und der Output ein _Syntaxbaum_.

== Kontextfreie Sprache
Der Parser kann mit _kontextfreien_ Sprachen umgehen. Eine _kontextfreie_ Sprache ist als beliebige EBNF ausdrückbar
und hat einen Push-Down Automat (Stack). Viele Aspekte sind aber _kontextabhängig_, z.b. _Variablen_ sind vor
Gebrauch deklariert, _Booleans_ sind nicht addierbar, _Argumente_ müssen auf Parameter passen, etc.
Die _Kontextabhängigkeit_ wird später im _semantic Checker_ geprüft.

=== Beispiel
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Syntax*\
    #tcolor("grün", `Expression`) `=` #tcolor("orange", `Term`) `{ ( "+" | "-" )` #tcolor("orange", `Term`)` }`.\
    #tcolor("orange", `Term`) `=` #tcolor("rot", `Number`) `| "("` #tcolor("grün", `Expression`) `")"`.\
    #tcolor("rot", `Number`) `= "0" | ... | "9"`.

    *Input*\
    `1 + ( 2 - 3 )`
  ],
  [
    *Ableitung*\
    #tcolor("grün", `Expression`)\
    #tcolor("orange", `Term`) `"+"` #tcolor("orange", `Term`)\
    #tcolor("rot", `Number`) `"+"` #tcolor("orange", `Term`)\
    #tcolor("rot", `Number`) `"+"` `"("` #tcolor("grün", `Expression`) `")"`\
    #tcolor("rot", `Number`) `"+"` `"("` #tcolor("grün", `Expression`) `"-"` #tcolor("orange", `Term`) `")"`\
    #tcolor("rot", `Number`) `"+"` `"("` #tcolor("orange", `Term`) `"-"` #tcolor("orange", `Term`) `")"`\
    #tcolor("rot", `Number`) `"+"` `"("` #tcolor("rot", `Number`) `"-"` #tcolor("orange", `Term`) `")"`\
    #tcolor("rot", `Number`) `"+"` `"("` #tcolor("rot", `Number`) `"-"` #tcolor("rot", `Number`) `")"`\
  ],
)

== Aufgabe des Parsers
Der Parser _analysiert_ die gesamte Syntaxdefinition #hinweis[(mit oder ohne rekursive Regeln)].
Er erkennt, ob der Eingabetext _die Syntax erfüllt_ oder nicht. Hier ist eine _eindeutige Ableitung_ gewünscht,
weil es sonst in der Syntaxdefinition ein Problem gibt. Er _erzeugt_ den Syntaxbaum für weitere Compiler-Schritte.

#pagebreak()

Die _Ableitung der Syntaxregeln_ wird als Baum widerspiegelt.
#table(
  columns: (1fr, 1fr),
  align: (_, y) => if (y == 2) { center } else { auto },
  table.header([Concrete Syntax Tree (Parse Tree)], [Abstract Syntax Tree]),
  [
    _Vollständige Ableitung_ der Syntaxregeln, welche alle Grammatik-Regeln der Sprache widerspiegelt.\
    Parser-Generatoren können nur Parse-Trees liefern.
  ],
  [
    _Unwichtige Details_ werden _weggelassen_, Struktur wird _vereinfacht_ und für Weiterverarbeitung optimiert.\
    Selbst implementierter Parser kann direkt Abstract Syntax Tree liefern.
  ],
  image("img/combau_07.png", width: 40%),
  image("img/combau_08.png", width: 50%),
)

== Parsing-Strategien
#v(-0.5em)
=== Parser-Klassen nach D.E. Knuth
Parser können je nach ihrer Arbeitsweise in _Klassen_ eingeteilt werden.
Die Notation besteht aus zwei Buchstaben und einer Zahl.
#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    - _Erster Buchstabe:_ `L` für links nach rechts und `R` für von rechts nach links
    - _Zweiter Buchstabe:_ `L` für Top-Down Parser, `R` für Bottom-Up Parser
    - _Zahl:_ für Anzahl Symbol Lookahead
  ],
  [*Beispiel: `LL(1)`:* links nach rechts, Top-Down, ein Token lookahead],
)

#table(
  columns: (1fr, 1fr),
  table.header([Top-Down (LL)], [Bottom-Up (LR)]),
  [
    - Beginne mit _Start-Symbol_
    - Wende _Produktionen_ an
    - _Expandiere_ Start-Symbol auf Eingabetext
    `Expr -> Term + Term -> ... -> 1 + ( 2 - 3 )`
  ],
  [
    - Beginne mit _Eingabetext_
    - Wende _Produktionen_ an
    - _Reduziere_ Eingabetext auf Start-Symbol
    `Expr <- Term + Term <- ... <- 1 + ( 2 - 3 )`
  ],

  image("img/combau_09.png"), image("img/combau_10.png"),
)

== Top-Down Parsing
In einem Recursive Descent Parser hat eine Expression weitere Terme, ein Term hat allenfalls eine weitere Expression
$arrow$ _Rekursive Definition_. Um dies abzubilden, muss beim Parsen ebenfalls _Rekursion_ verwendet werden.

_Pro Nicht-Terminalsymbol_ wird _eine Methode_ implementiert. Wenn ein Nicht-Terminalsymbol vorkommt, wird die
entsprechende Methode _aufgerufen_. Diese Methode funktioniert bei rekursiven und nicht-rekursiven Syntaxen.
Der _Stack_ ist _implizit_ durch Methodenaufrufe gegeben.
Die bevorzugte Vorgehensweise ist die _zielorientierte Satzzerlegung_ #hinweis[(direct prediction)]:
Die Syntax wird _analysiert_ und _systematische Kriterien_ für das Parsen _bestimmt_, damit immer klar ist,
welche Produktion als nächstes angewendet wird. Ist dies nicht möglich, muss mit _Backtracking_ gearbeitet werden:
Bei einem Syntaxfehler wird der letzte Schritt rückgängig gemacht und ein anderer Pfad gewählt.
Wird ein Pfad gefunden, ist die Syntax _valide_.

=== One Token Lookahead
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #tcolor("grün", `Statement`) `=` #tcolor("orange", `Assignment`) | #tcolor("rot", `IfStatement`).\
    #tcolor("orange", `Assignment`) `= Identifier "="` #tcolor("gelb", `Expression`).\
    #tcolor("rot", `IfStatement`) `= "if" "("` #tcolor("gelb", `Expression`) `")" Statement`.
  ],
  [
    ```cs
    void ParseStatement() {
    if (???) ParseAssignment();
    else if (???) ParseIfStatement(); }
    ```
  ],
)

Nach welcher _Bedingung_ soll hier verzweigt werden? Um dies zu entscheiden, kann _one Token Lookahead_ verwendet werden.
Mit dieser Methode werden _mögliche erste Terminalsymbole_ bestimmt, die mit einer Produktion ableitbar sind -- die _FIRST-Menge_.

`FIRST(Assignment) = { Identifier }`\
`FIRST(IfStatement) = { "if" }`

```cs
void ParseStatement() {
  if (IsIdentifier() /* FIRST(Assignment) */) ParseAssignment();
  else if (Is(TokenTag.IF) /* FIRST(IfStatement) */) ParseIfStatement();
}
```

`FIRST()` kann auch _mehrere Elemente_ enthalten:

`FIRST(LoopStatement) = { "while", "do" }`\
```cs if (Is(TokenTag.WHILE) || Is(TokenTag.DO)) { ParseLoopStatement(); }```

=== K Tokens Lookahead
Es kann auch sein, dass Lookahead von einem Token _nicht ausreicht_.
In einem solchen Fall brauchen wir einen _Lookahead mit k Tokens_.

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #tcolor("grün", `Statement`) `=` #tcolor("orange", `Assignment`) | #tcolor("rot", `MethodCall`).\
    #tcolor("orange", `Assignment`) `=` #tcolor("gelb", `Identifier`) `"=" Expression`.\
    #tcolor("rot", `MethodCall`) `=` #tcolor("gelb", `Identifier`) `"(" ")"`.
  ],
  [
    `FIRST(Assignment) = { Identifier }`\
    `FIRST(MethodCall) = { Identifier }`
  ],
)

_k = 2_ würde in diesem Beispiel ausreichen. Um dies zu implementieren, ist eine _technische Syntax-Umformung_
notwendig, damit ein _one Token Lookahead_ wieder ausreicht -- der gemeinsame Teil wird _zusammengefasst_.

#tcolor("grün", `Statement`) `=` #tcolor("gelb", `Identifier`) `(` #tcolor("orange", `AssignmentRest`) | #tcolor("rot", `MethodCallRest`) `)`. \
#tcolor("orange", `AssignmentRest`) `=` `"=" Expression`. \
#tcolor("rot", `MethodCallRest`) `=` `"(" ")"`.

```cs
void ParseStatement() {
  var identifier = ReadIdentifier();
  if (Is(TokenTag.ASSIGN)) ParseAssignmentRest(identifier);
  else if (Is(TokenTag.OPEN_PARENTHESIS)) ParseMethodCallRest(identifier);
}
```

=== Linksrekursion
Eine Linksrekursion wie hier: #tcolor("grün", `Sequence`) `=` #tcolor("grün", `Sequence`) `["s"]` sollte vermieden werden.
Jedes _Nicht-Terminalsymbol_ löst einen Aufruf der _jeweiligen `Parse()`-Methode_ auf. Da `Sequence` ganz links steht,
muss die `ParseSequence()`-Methode _vor_ der Überprüfung auf `s` aufgerufen werden -- es gibt somit _keine Abbruchbedingung_
der Rekursion und sie ist endlos. Deshalb sollte Linksrekursion _vermieden_ werden, stattdessen sollte die _EBNF-Repetition_
verwendet werden: #tcolor("grün", `Sequence`) `= {"s"}`

#grid(
  columns: (1fr,) * 2,
  [
    ```cs
    // Sequence = Sequence ["s"] Parse
    void ParseSequence() {
      ParseSequence(); // Recursion Error
      if (!AtEnd) {
        if (Current == 's') {
          Next();
        }
        else {
          Error();
        } } }
    ```
  ],
  [
    ```cs
    // Sequence = {"s"} Parse
    void ParseSequence() {
      while (!AtEnd) {
        if (Current == 's') {
          Next();
        }
        else {
          Error();
          break;
        } } }
    ```
  ]
)
