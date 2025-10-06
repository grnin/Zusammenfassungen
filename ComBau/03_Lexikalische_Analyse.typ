#import "../template_zusammenf.typ": *

= Lexikalische Analyse
Der Lexer kümmert sich um die _lexikalische Analyse_.
Der Input ist eine _Zeichenfolge_ #hinweis[(Programmtext)], der Output eine _Folge von Terminalsymbolen_ #hinweis[(Tokens)].

Der Lexer _fasst Textzeichen zu Tokens zusammen_ #hinweis[(Bsp: "1234" ergibt Integer 1234)],
_eliminiert Whitespaces_ und _Kommentare_ und _merkt Positionen_ im Programmcode #hinweis[(für Fehlermeldungen)].\
Er erleichtert die spätere syntaktische Analyse:
- _Abstraktion:_ Parser muss sich nicht um Textzeichen kümmern
- _Einfachheit:_ Parser braucht Lookahead pro Symbol, nicht pro Textzeichen
- _Effizienz:_ Lexer benötigt keinen Stack im Gegensatz zum Parser

== Tokens
#grid(
  columns: (auto, auto),
  gutter: 1em,
  [
    - _Fixe Tokens:_ Keywords, Operatoren, Interpunktion\ #hinweis[(`if`, `else`, `while`, `*`, `&&`, ...)]
    - _Identifiers:_ `MyClass`, `readFile`, `name2`, etc.
  ],
  [
    - _Zahlen:_ `123`, `0xfe12`, `1.2e-3`, etc.
    - _Strings:_ `"Hello!"`, `01234`, `\n`, etc.
    - _Characters:_ `'a'`, `'0'`, etc. #hinweis[(nicht in SmallJ)]
  ],
)

== Reguläre Sprachen
Lexer unterstützen nur _reguläre_ Sprachen. Reguläre Sprachen sind Sprachen, deren EBNF _ohne Rekursion_ ausdrückbar sind.
#hinweis[(Eine rekursive EBNF kann auch eine reguläre Sprache sein, solange sie auch ohne Rekursion dargestellt werden könnte)].

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Beispiele Regulär:*\
    #tcolor("grün", `Integer`) `=` #tcolor("orange", `Digit`) `{` #tcolor("orange", `Digit`) `}`.\
    #tcolor("orange", `Digit`) `= "0" | ... | "9"`.

    #tcolor("grün", `Integer`) `=` #tcolor("orange", `Digit`) `[` #tcolor("grün", `Integer`) `]`.\
    #hinweis[Kann zu obigem Beispiel umformuliert werden, ist also auch ohne Rekursion lösbar.]
  ],
  [
    *Beispiele Nicht-Regulär:* \
    #tcolor("grün", `Integer`) `=` #tcolor("orange", `Digit`) `{` #tcolor("grün", `Integer`) `}`. \
    #tcolor("orange", `Digit`) `= "0" | ... | "9"`.

    #tcolor("grün", `Ausdruck`) `= [ "("` #tcolor("grün", `Ausdruck`) `")" ]`\
    #hinweis[Muss sich merken, wie viele offene Klammern vorhanden sind, um gleich viele schliessende zu haben.]
  ],
)

=== Theoretische Einordnung
_Reguläre Sprache_ #hinweis[(Endlicher Automat, für Lexer)] `<<`
_Kontextfreie Sprache_ #hinweis[(Pushdown Automat mit Gedächtnis, für Parser)]\ `<<`
_Kontextsensitive Sprache_ #hinweis[(Bounded Turing Maschine, für Semantic Checker)]

#grid(
  columns: (2.5fr, 1fr),
  gutter: 1em,
  [
    == Identifier
    Bezeichner von Klassen, Methoden, Variablen etc. Beginnt mit einem Buchstaben, danach sind Buchstaben und Ziffern erlaubt
    #hinweis[(Java erlaubt auch Underscores)].\
    #tcolor("grün", `Identifier`) `=` #tcolor("rot", `Letter`) `{` #tcolor("rot", `Letter`) `|` #tcolor("orange", `Digit`) `}`. \
    #tcolor("rot", `Letter`) `= "A" | ... | "Z" | "a" | ... | "z"`.\
    #tcolor("orange", `Digit`) `= "0" | ... | "9"`.

    == Maximum Munch
    Der Lexer absorbiert _so viele Zeichen wie möglich_ in einem Token, er ist also _greedy_.
    #hinweis[(`my1234Name` wird als einziges Token gelesen und nicht als drei einzelne Token)].
  ],
  image("img/combau_06.png"),
)

== Whitespaces und Kommentare
Werden vom Lexer _übersprungen_. Ein Whitespace _trennt_ jedoch zwei Tokens.
Die Trennung erfolgt aber manchmal auch _ohne Whitespace_. #hinweis[(z.B `1234name` wird in Integer und Identifier getrennt)]

== Implementation
#v(-0.5em)
=== Token-Repräsentation
#grid(
  columns: (1.6fr, 1fr),
  gutter: 1em,
  [
    Eine abstrakte `Token` Basisklasse beschreibt die _Position_ des Tokens im Sourcecode.
    Die Subklassen implementieren die einzelnen Tokentypen: _`IntegerToken`_, _`IdentifierToken`_ und _`ValueToken`_
    enthalten den entsprechenden Wert, während _`FixToken`_ einen _`TokenTag`_ enthält.\
    Dies ist ein Enum, welches alle Keywords, Operatoren und Interpunktion enthält, aber keine Typen und Konstanten
    #hinweis[(`true`, `false`, `null`)].

    Jeder Token-Typ hat einen _eigenen Lexer_, der Input wird charakterweise gelesen. Um den Typ zuzuweisen, reicht der
    aktuelle Charakter jedoch nicht immer aus. Der Lexer hat darum einen _one character lookahead_, mit welchem der momentane
    und der nächste Charakter gelesen wird, um den Typ zu bestimmen.

    Zuerst werden alle Whitespaces entfernt. Bei den _Operatoren und Interpunktionen_ kann mit einem Switch-Case das
    entsprechende `FixToken` ausgegeben werden.\
    Ist der Charakter eine _Ziffer_, wird ein Integer-Token erstellt. Dazu wird die Ziffer in einen `char` gecastet,
    was im ASCII-Wert resultiert; minus den ASCII-Wert von `0` gerechnet ergibt den Ziffernwert. Die momentane Zahl wird
    mal 10 gerechnet und die Ziffer hinten angehängt. Ebenfalls muss noch geprüft werden, ob der Integer gültig ist
    (`MIN_VALUE` $<= i <=$ `MAX_VALUE`).

    Bei einem _Buchstaben_ kommt entweder ein Identifier oder ein Keyword in Frage. Dazu wird nach dem Erreichen des ersten
    nicht-alphanumerischen Zeichen geprüft, ob sich der Name im `TokenTag` Enum befindet.

    Trifft der Lexer auf einen `/`, wird geprüft, ob darauf ein `/` oder `*` folgt: Dann sind die nachfolgenden Zeichen
    _Kommentare_ und werden bis zur nächsten Newline #hinweis[(Zeilenkommentar)] oder `*/` #hinweis[(Blockkommentar)]
    ignoriert. Folgt keines dieser Zeichen, wird ein _Divisions-`FixToken`_ ausgegeben.

    In anderen Sprachen gibt es _Spezialfälle_, welche separat behandelt werden müssen: `char`-Literale, String/Char-Escaping,
    Hexadezimale Integers und Kommazahlen. Ebenfalls wird Error Handling für nicht geschlossene Blöcke
    #hinweis[(Kommentare, Loops, Strings)], zu grosse/kleine Zahlen und ungültige Zeichen implementiert.
    Diese Fehlermeldungen sollen dem Nutzer mit der entsprechenden Zeilenposition angegeben werden.
    Speziell soll im Lexer bei fehlerhaftem Input _kein Infinite Loop_ ausgelöst werden.
  ],
  [
    ```cs
    // IntegerTokenLexer
    int value = 0;
    while (!IsEnd() && IsDigit()) {
      // Char cast to int -> ASCII value
      int digit = Current - '0';
      value = value * 10 + digit;
      readNext();
    }
    token = new IntegerToken(..., value);

    // NameTokenLexer
    string name = Current.ToString();
    Next();
    while (!IsEnd()
      && (IsLetter() || IsDigit())) {
        name += Current;
        Next();
    }
    token = Keywords.TryGetValue(name, out var tag)
      ? new FixToken(..., tag)
      : new IdentifierToken(..., name)

      
    // SlashTokenLexer
    case '/': SkipLineComment();
    case '*': SkipBlockComment();
    default:
      token = new FixToken(DIVISION);
    void SkipLineComment() {
      CheckNext('/');
      while (!IsEnd && Current != '\n')
      { next(); }
    }
    
    void SkipBlockComment() {
      do {
        Next();
        while (!IsEnd && Current != '*')
          { Next(); }
        Next(); // look for / after *
      } while (!IsEnd && Current != '/')
    }
    ```
  ],
)

== Lexer-Generatoren
Verschiedene Tools können Lexer aus EBNF oder Regex _automatisch erstellen_. Diese _ersparen Programmierarbeit_
und Flüchtigkeitsfehler, generieren aber _verbosen Code_, haben _feste Token-Representation_ und _erstellen Abhängigkeiten_.
