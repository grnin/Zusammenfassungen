#import "../template_zusammenf.typ": *

= Code Generierung
Der _Code Generator_ kümmert sich um die Erzeugung von ausführbarem Maschinencode. Der Input ist eine _Zwischendarstellung_
und der Output _(Virtual) Maschine Code_ in einem _Assembly- bzw. Object File_.

== Compiler Frontend/Backend
- _Frontend:_ Java, C\#, Scala, ...
- _Backend:_ x64 Assembly, Java Bytecode, .NET CLI, ...

AST & Symboltabelle trennt das _Frontend_ vom _Backend_. Diese Trennung erlaubt _Mehrsprachen-_ und
_Mehrplattformenkompatibilität_ im Compiler, da alle Sprachen auf _dieselbe Intermediate Language_ #hinweis[(IL)]
kompiliert werden und aus diesem der Maschinencode für die entsprechende Platform generiert werden kann.

== Stack-Prozessor
Instruktionen benutzen einen _Auswertungs-Stack_ anstelle von CPU-Registern. Jede Instruktion hat eine _definierte Anzahl_
von _Pop_- und _Push-Aufrufen_. Am Anfang und am Schluss der Methode ist der _Evaluations-Stack_ leer. Um eine Instruktion
_ausführen_ zu können, müssen vor dem Aufruf die entsprechenden Werte auf den _Evaluation Stack_ gepusht werden.\
Jede Methode hat ihren _eigenen Evaluation Stack_, dieser muss zu Beginn und am Ende der Methode _leer_ sein.

== Instruktionen
=== Beispiel: `while`-Bytecode <while-bytecode-example>
#grid(
  columns: (auto, 1fr),
  gutter: 3em,
  [
    ```cs
    while (x < 10) {
      x = x + 1;
    }
    ```
  ],
  [
    ```asm
    begin: load 1 ; "x" has index 1
           ldc 10
           icmplt
           if_false end ; jump to code after loop if statement is false
           load 1
           ldc 1
           iadd ; x + 1
           store 1
           goto begin
    end:
    ```
  ],
)

#table(
  columns: (auto, 1fr, 1fr),
  table.header([SmallJ-Instruktion], [Bedeutung], [Auswertungs-Stack]),
  [`ldc <const>`], [Lade Konstante #hinweis[(`int`, `boolean`, `string`)]], [1 Push],
  [`iadd`], [Integer Addition], [2 Pop, 1 Push],
  [`isub`], [Integer Subtraktion], [2 Pop, 1 Push],
  [`imul`], [Integer Multiplikation], [2 Pop, 1 Push],
  [`idiv`], [Integer Division], [2 Pop, 1 Push],
  [`irem`], [Integer Modulo], [2 Pop, 1 Push],
  [`ineg`], [Integer Negation], [1 Pop, 1 Push],
  [`bneg`], [Boolesche Negierung], [1 Pop, 1 Push],
  [`load <num>`], [Lade Parameter oder lokale Variable], [1 Push],
  [`store <num>`], [Speichere Parameter oder lokale Variable], [1 Pop],
  [`cmpeq`], [Compare Equal #hinweis[(Verschiedene Typen)]], [Pop right, Pop left, Push boolean],
  [`cmpne`], [Compare Not Equal #hinweis[(Verschiedene Typen)] ], [Pop right, Pop left, Push boolean],
  [`icmpgt`], [Integer Compare Greater Than], [Pop right, Pop left, Push boolean],
  [`icmpge`], [Integer Compare Greater Equal], [Pop right, Pop left, Push boolean],
  [`icmplt`], [Integer Compare Less Than], [Pop right, Pop left, Push boolean],
  [`icmple`], [Integer Compare Less Equal], [Pop right, Pop left, Push boolean],
  [`goto <label>`], [Branch/Jump #hinweis[(Bedingungslos)]], [---],
  [`if_true < label>`], [Branch falls true], [1 Pop],
  [`if_false <label>`], [Branch falls false], [1 Pop],
)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    === Load / Store Indexierung für Locals
    Mit `load` / `store` können Parameter und lokale Variablen verwendet werden.
    Die Parameter werden zuerst deklariert, damit sie innerhalb der Methode nicht redefiniert werden können.
    + _"`this`"_ Referenz: Index 0 #hinweis[(Virtuelle Methode, read-only)]
    + _$bold(n)$ Parameter_: Index $1 ... n$
    + _$bold(m)$ lokale Variablen_: Index $n+1 ... n+m$

    ```cs
    void swap(int a, int b) {
      int temp;
      temp = a; // load 1 (a) / store 3 (temp)
      a = b; // load 2 (b) / store 1 (a)
      b = temp; // load 3 (temp) / store 2 (b)
      ... }
    ```
  ],
  image("img/combau_16.png"),
)

== Metadaten
Durch die Metadaten kann die _Speicher-_ und _Typensicherheit_ zur Runtime _verifiziert_ werden.
Dies ist insbesondere beim _Laden von Libraries_ wichtig, um Kompatibilität zu garantieren.\
Die Zwischensprache kennt alle Informationen zu
- _Klassen:_ Namen, Typen der Fields und Methoden
- _Methoden:_ Namen, Parametertypen und Rückgabetyp
- _Lokale Variablen:_ Typen und Namen

Es ist _kein direktes Speicherlayout_ festgelegt, dies liegt in der Hand der Runtime-VM. Namen von
_lokalen Variablen und Parameter_ sind _nicht enthalten_, sie werden nur _durchnummeriert_,
weil dies Platz & Performance spart.

== Code-Generierung
+ _Traversiere Symboltabelle_: Erzeuge Bytecode Metadaten
+ _Traversiere AST pro Methode (Visitor):_ Erzeuge Instruktionen via Bytecode Assembler
+ _Serialisiere in Output Format:_ Mittels .NET Standard Library oder Proprietäres Binärformat

=== Bytecode Assembler
While-Loop von @while-bytecode-example in Bytecode Assembler:
```cs
var assembler = new Assembler(...);
var begin = assembler.CreateLabel();
var end = assembler.CreateLabel();
assembler.SetLabel(begin);
assembler.Emit(LOAD, 1);
...
```

=== Backpatching
Nach der Generierung des Bytecodes sollen die _Labels_ in den Jumps in _relative Offsets_, die _Branch Offsets_,
umgewandelt werden. Diese geben an, _wie viele_ Instruktionen nach oben/unten gesprungen werden soll, bis das Label
erreicht wird. Die Labels werden danach entfernt.

`if_false end -> if_false<5>`\
`goto begin -> goto<-9>`

=== Template-Basierte Generierung
_Postorder-Traversierung:_ Kinder zuerst besuchen und jeweils Template für erkanntes Teilbaum-Muster anwenden.

==== Verschiedene Teilbaum-Muster
#image("img/combau_17.png", width: 70%)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    ==== Beispiel
    ```cs // Assignment -> rechter Node, dann Post-Order
    (1) load 1
    // load <varNum> wird angewendet, x hat Wert 1
    (2) load 1
    // load <varNum> wird erneut angewendet
    (3) ldc 1
    // ldc <const> wird angewendet
    (4) isub
    // isub Teilbaum erkannt
    (5) imul
    // imul Teilbaum erkannt
    (6) ldc 2
    // ldc <const> wird angewendet
    (7) idiv
    // idiv Teilbaum erkannt
    (8) store 2
    // store <varNum> wird ohne Rekursion angewendet, y hat Wert 2
    ```
  ],
  image("img/combau_18.png", width: 70%),
)

#pagebreak()

==== Traversierungsreihenfolge
- _Bei Expressions:_ Immer Post-Order
- _Bei Statements:_ Je nach Code-Template
  - _Assignment:_ Beim obersten Knoten zum Kindknoten rechts traversieren #hinweis[(Statement rechts von `=`)]
    $->$ Post-Order zum Knoten ganz links #hinweis[(Target)] traversieren und auswerten
    $->$ Den Knoten rechts #hinweis[(Wert)] auswerten
    $->$ Beim obersten Knoten links #hinweis[(Variable links von `=`)] `store`-Instruktion emitten\
    #hinweis[(`a = 2 * b -> ldc 2, load b, imul, store a`)]
  - _Member Access:_ Klassenvariabel mit `load` laden, bevor auf Feld zugegriffen werden kann\
    #hinweis[(`a.f = 7 -> load a, ldc 7, store f`)]
  - _If-Statement:_
    #v(-0.5em)
    ```
          <Condition>
          if_false else
          <Then-Block>
          goto endif
    else: <Else-Block>
    endif:
    ```
  - _While-Statement:_
    #v(-0.5em)
    ```
    whileStart: <Condition>
                if_false whileEnd
                <While-Block>
                goto whileStart
    whileEnd:
    ```
#v(-0.5em)

=== Bedingte Auswertung
Die _`&&`_ und _`||`_ Operatoren haben eine _Short-Circuit Logik_: Das rechte Statement wird nur evaluiert, wenn es für
das Resultat _entscheidend_ ist. Ist die linke Seite bei `&&` bereits `false` bzw. bei `||` schon `true`, kann direkt
im Code weitergefahren werden.
#v(-0.5em)
#grid(
  columns: (1fr,) * 2,
  gutter: 1em,
  [
    ```cs
    // Pseudo code for "&&"
    // a && b => a ? b : false
           left
           if_false short
           right
           goto end
    short: ldc false
    end:
    ```
  ],
  [
    ```cs
    // Pseudo code for "||"
    // a || b => a ? true : b
           left
           if_true short
           right
           goto end
    short: ldc true
    end:
    ```
  ]
)


=== Methodenaufruf
- _Statisch:_ Vordefinierte Methoden #hinweis[(`readInt()`, `writeString()`)] mit `invokestatic`
- _Dynamisch:_ An Objekt gebunden #hinweis[(`x.run()`, `this.delete()`)] mit `invokevirtual`.
  Bei `this` wird immer `load 0` generiert, auch wenn es im Code selber implizit ist.

Bei _virtuellen Methodenaufrufen_ muss die Objektreferenz zuunterst auf dem Evaluation Stack liegen, darüber
befinden sich _die Parameter_ von vorne nach hinten. Am Ende der Methode befindet sich eine _`ret`-Instruktion_,
um die Methode zu verlassen. Hat die Methode einen _Return Type_ #hinweis[(nicht `void`)], muss dieser Wert
vor `ret` auf den Stack gepusht werden. Dieser wird dann auf den Stack des Aufrufers gepusht.
Der Evaluation Stack der aufgerufenen Methode muss am Schluss leer sein.

#grid(
  columns: (0.5fr, 1fr),
  [
    ```cs
    int sum(int x, int y) {
      return x + y;
    }

    int five;
    five = 5;
    sum(10, five);
    ```
  ],
  [
    ```asm
    ldc 5             ; load number '5'
    store 1           ; store '5' into 'five'
    load 0            ; load object reference of function (here 'this')
    ldc 10            ; load first parameter (constant)
    load 1            ; load second parameter (variable)
    invokevirtual sum ; call the 'sum' function
    load 1            ; load parameter 'x'
    load 2            ; load parameter 'y'
    iadd              ; add numbers and put result on stack
    ret               ; return value on stack and exit method
    ```
  ],
)
