#import "../template_zusammenf.typ": *

= JIT Compiler
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    Der JIT-Compiler wandelt _Bytecode_ direkt in _nativen Code_ für den jeweiligen Prozessor um.
    So kann die Ausführung direkt gestartet werden, ohne dass noch eine Interpretation durch die Runtime stattfinden muss.
    Das führt zu einer _viel effizienteren_ Ausführung. Macht jedoch nur für kritische Teile bzw. _Hot Spots_ Sinn,
    welche _oft ausgeführt_ werden, weil die JIT-Compilation _ebenfalls Zeit kostet_ und sich nur lohnt,
    wenn der entsprechende Code _oft ausgeführt_ wird #hinweis[(z.B. Loops, oft aufgerufene Methoden)].
  ],
  [
    *Beispiel für Hotspot (Loop)*
    ```asm begin: load 1
           load 2
           icmplt
           if_false end
           load 1
           ldc 1
           iadd
           store 1
           br begin
    end:   ...
    ```
  ],
)

== Profiling
#grid(
  columns: (2.5fr, 1fr),
  gutter: 1em,
  [
    Der Interpreter _zählt_ die Ausführung von gewissen Code-Teilen, um _Hot Spots zu erkennen_.
    Wenn der Zähler einen bestimmten _Schwellenwert_ überschreitet, veranlasst der Interpreter den JIT-Compiler für
    dieses Codestück. Ein _Loop_ wird beispielsweise an _jeder Jump-Instruktion_ auf Ausführung geprüft.

    Ein einmal _JIT-kompilierter Codeteil_ wird nach der Kompilierung _gecached_ und beim erneuten Erreichen
    des Codes ausgeführt. JIT-Code, welcher noch viel häufiger ausgeführt wird, kann auch nach und nach mit immer
    stärkeren JIT-Optimierungen rekompiliert werden. Dazu werden wie beim regulären Code Profiling-Zähler in
    den Code eingefügt. Die Technik, zusätzliche Logik zum kompilierten Code hinzuzufügen, nennt sich _Code Instrumentation_.
    Wir implementieren einen JIT-Compiler, welcher nur auf Methoden-Ebene arbeitet.
  ],
  [
    #image("img/combau_33.png")
  ],
)

#grid(
  columns: (2.5fr, 1fr),
  gutter: 1em,
  [
    == Intel 64 Architektur
    Instruktionen auf der x64-Prozessorarchitektur benutzen _Register_, im Gegensatz zu unserer Stack-basierender VM.
    Es gibt _14 allgemeine Register_ für Ganzahlen, wir verwenden diese aber auch, um Booleans zu speichern:\
    `RAX, RBX, RCX, RDX, RSI, RDI, R8, R9, ..., R15`

    ==== Spezielle Register
    _`RSP`:_ Stack Pointer, _`RBP`:_ Base Pointer, _`RIP`:_ Instruction Pointer
    #hinweis[(kann nicht explizit geschrieben / gelesen werden)], diverse Floating Point Register
  ],
  [
    #image("img/combau_30.png")
  ],
)
Die Intel x64-Architektur unterstützt auch _Zugriffe auf die kleineren Register_, welche Teil der grösseren sind
#hinweis[(`RAX` 64-bit, `EAX`, 32-bit, `AX` 16-bit, `AH`/`AL` obere/untere 8-bit)]. Es wäre sogar performanter,
die 32-bit SmallJ Strings in die 32-bit grossen Register zu speichern, der Einfachheit halber greift aber der
JIT-Compiler nur auf die vollen 64-bit Register zu.

=== Instruktionen
#table(
  columns: (auto, 1fr),
  table.header([Instruktion], [Bedeutung]),
  [`ADD RAX, RBX`], [`RAX += RBX`],
  [`SUB RAX, RBX`], [`RAX -= RBX`],
  [`IMUL RAX, RBX`], [`RAX *= RBX`],
  [`IDIV RBX`], [`RDX` muss vorher 0 sein bei nicht-negativem `RAX`, ansonsten -1. `RAX /= RBX, RDX = RAX % RBX`],
  [`CDQ`],
  [
    Vorzeichenbehaftete Konvertierung von `RAX` to `RDX:RAX`\
    #hinweis[(Convert to quad word: `RDX` wird zu 0 bzw. -1 je nach Vorzeichen von `RAX`])
  ],
)

#grid(
  columns: (1.5fr, 1fr),
  gutter: 1em,
  [
    ==== `IDIV`-Instruktion
    Die _`IDIV`-Instruktion_ ist auf mehrere Arten speziell: Sie führt _gleichzeitig_ eine Division und eine
    Modulo-Operation durch. Die beiden Register `RDX:RAX` werden zusammen als 128-bit Zahl durch den Operand der
    Instruktion geteilt. Ist die Zahl _positiv_, muss `RDX` 0 sein, ansonsten 1. Dies kann mit der _`CDQ`-Instruktion_
    gelöst werden, welche diesen Wert je nach Zahl in `RAX` setzt. Somit kann der JIT-Compiler `IDIV` _vorbereiten_.

    `IDIV` benutzt die fest vorgegebenen Register _`RAX`_ für das Resultat der Division und _`RDX`_ für das Ergebnis
    von Modulo. Dieses implizite Schreiben von Registern nennt man _Register Clobbering_, da es die vorherigen Werte
    darin zerstört. Der Aufrufer muss daher _sicherstellen_, dass die vorherigen Werte in diesen Registern _gespeichert_
    werden und sie, nachdem das Resultat auf den Evaluation Stack gepushed wurde, _wiederherstellen_.
  ],
  [
    ```asm
    # Move current RAX/RDX values into
    # registers previously checked as free
    MOV R8, RAX
    MOV R9, RDX
    CDQ          # Prepare RDX before IDIV
    IDIV RBX     # RAX = RDX:RAX / RBX
    # Division in RAX, Modulo in RDX
    # Push result on stack, restore RAX/RDX
    ```
    ```cs // IDIV implementation in JIT
    Reserve(X64Register.RDX); // Free RDX
    Force(X64Register.RAX, Pop());
    var divisor = Pop();
    _assembler.Cdq();
    _assembler.Idiv(divisor);
    Push(x64Register.RAX);
    Release(x64Register.RDX);
    Release(divisor);
    ```
  ],
)

==== Beispiel `(x - 1) / 3`
#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    ==== VM Bytecode
    ```cs
    load 1 // x laden
    ldc 1  // 1 laden
    isub   // x - 1
    ldc 3  // 3 laden
    idiv   // RAX = (x - 1) / 3
    ```
  ],
  [
    ==== x64 Code
    ```asm
    # x sei in RAX
    MOV RBX, 1    # 1 laden
    SUB RAX, RBX  # RAX = x - 1
    MOV RBX, 3    # 3 laden
    CDQ           # RDX für IDIV vorbereiten
    IDIV RBX      # RAX = (x - 1) / 3
    # Resultat ist in RAX
    ```
  ],
)

=== Register-Allokation
Um die _passenden Register_ für die Code-Fragmente zu bestimmen, müssen _zwei Aspekte_ berücksichtigt werden:
- Die Reigsterwahl hängt von _vorherigen Instruktionen_ ab und davon, wo diese Instruktionen die Werte platziert haben.
- Instruktionen können Register _belegen_ und _freigeben_.

==== Die Register-Allokation kann auf zwei Ebenen erfolgen:
- _Lokale Register-Allokation:_ Nur für den Evaluation Stack. Jeder Eintrag des Stacks wird auf ein Register abgebildet.
  Der Register Stack entspricht dem Evaluation Stack. Pro übersetzte Bytecode-Instruktion wird der Stack nachgeführt.
- _Globale Register-Allokation:_ Auch lokale Variablen und Parameter werden in Registern gespeichert.
  Die Abfrage der Variablen wird dadurch deutlich schneller, jedoch hat es nur eine begrenzte Anzahl Register,
  deshalb kann diese Allokation nur bedingt genutzt werden. `int`-Parameter werden oft als Register übergeben
  #hinweis[(Windows C Calling Convention: `RCX`, `RDX`, `R8`, `R9` -- UNIX-like: `RDI`, `RSI`, `RDX`, `RCX`, `R8`, `R9`)].

#pagebreak()

Bei komplexen Evaluation Stacks oder zu grosser Globaler Register-Allokation können die freien Register ausgehen,
sogenannter _Register Pressure_. Als Gegenmittel kann _Stack Spilling_ angewendet werden: Registerwerte werden temporär
auf dem Stack gespeichert. Alternativ kann auch globale Register-Allokation temporär ausgesetzt werden und die Werte
werden an ihrem "normalen" Platz gespeichert. Wir setzen diese Massnahmen aber in unserem JIT-Compiler nicht um.

=== Intel Branches
#grid(
  columns: (3.75fr, 1fr),
  gutter: 1em,
  [
    Auf dem Intel-Prozessor basieren _bedinge Verzweigungen_ #hinweis[(Branches)] auf einem _Bedingungscode_,
    der sich aus einem _vorangegangenen Vergleich_ durch die `CMP`-Instruktion ergibt. Im Beispiel rechts werden
    zunächst _`RAX` und `RBX` verglichen_. Wenn die Werte _gleich_ sind, springt der Prozessor zur Zielposition,
    andernfalls fährt er mit der nächsten Anweisung fort. #hinweis[(Zur Demonstration hier mit Label, in Bytecode mit
    relativem Jump Offset, siehe @interpreter-loop)]
  ],
  [
    ```asm
            CMP RAX, RBX
            JE target
            ....
    target:
    ```
  ],
)

==== Instruktionen
#table(
  columns: (auto, 1fr),
  table.header([Instruktion], [Bedeutung]),
  [`CMP reg1, reg2`], [Compare, speichert das Resultat in `RFLAGS`-Register],
  [`JE label`], [Jump if equal],
  [`JNE label`], [Jump if not equal],
  [`JG label`], [Jump if greater, `reg1 > reg2`],
  [`JGE label`], [Jump if greater equal, `reg1 >= reg2`],
  [`JL label`], [Jump if less, `reg1 < reg2`],
  [`JLE label`], [Jump if less equal, `reg1 <= reg2`],
  [`JMP label`], [Unconditional Jump],
)

==== Branch Code Template
Der _Bytecode_ gibt _vor_ dem Sprung an, welche Condition zum Sprung führt.
Der _Native Intel Code_ gibt die Condition jedoch erst _beim_ Sprung an.
#grid(
  columns: (auto,) * 3,
  gutter: 2em,
  align: horizon,
  [
    ```asm
    icmplt
    if_true <target>
    ```
  ],
  [`=>`],
  [
    ```asm
    CMP <left_register>, <right_register>
    JL <offset>
    ```
  ]
)

=== Register Buchhaltung
Wird _globale Register-Allokation_ verwendet, muss nachverfolgt werden, in welchen Registern sich welche Variablen befinden.
Die Werte in den Registern können die Inhalte von Parametern/lokalen Variablen oder Werte vom Evaluation Stack sein.
Im _Allocation Record_ wird aufgezeichnet, wo sich ein Wert befindet #hinweis[(Evaluation Stack, Register oder Lokale Variable)].

Soll beispielsweise der _erste Parameter_ geladen werden, muss gar nicht die Instruktion `load 1` ausgegeben werden,
sondern es kann einfach der _Allocation Record angepasst_ werden. Wird die Windows Calling Convention verwendet,
befindet sich der erste Parameter in _`RCX`_, dieses Register muss nun einfach zuoberst auf den Evaluation Stack
gepusht werden. Dies gilt ebenfalls für jeden Parameter und jede Variable, welche in einem Register gespeichert werden.

Die gleiche Technik kann auch dazu verwendet werden, um _Register zu verschieben_ #hinweis[(z.B. für `IDIV`)].
Es wird nur der Speicherort innerhalb des Allocation Records geändert. Dadurch wird das Zurückverschieben des Werts
ebenfalls hinfällig.
#grid(
  columns: (1fr, 1fr),
  [#image("img/combau_36.png")], [#image("img/combau_37.png")],
)


In unserer JIT-Implementation haben wir verschiedene Helper-Methoden für den Umgang mit Registern:
#table(
  columns: (auto, 1fr),
  table.header([Operation], [Effekt]),
  [`acquire()`], [Reserviere ein beliebiges freies Register],
  [`release(reg)`], [Gebe Register frei, falls nicht für lokale Variablen oder Parameter benutzt],
  [`reserve(reg)`], [Reserviere ein spezifisches Register (mittels Relokation falls nötig)],
)

== JIT Compiler Implementation
In einem _Switch Case_ werden alle Bytecode-Instruktionen abgearbeitet und die entsprechenden Assembly-Instruktionen
ausgegeben. Viele Bytecode-Instruktionen können 1:1 gemapped werden. _Unser JIT-Compiler_ ist limitiert auf simple
Methoden und unterstützt der Einfachheit halber Methoden mit diesen Inhalten nicht: Methodenaufrufe,
Systemaufrufe #hinweis[(Heapallokation, Virtual Calls, Type Tests/Casts)], Felderzugriff, Arrays,
`this`-Referenzzugriff, Strings, nur bis zu 4 Parameter, limitierte Rückgabetypen #hinweis[(nur `void`, `int`, `bool`)].

```cs
switch (opCode) {
  ...
  case LDC:   var target = Acquire(); // get any free register
              var value = (int)instruction.Operand; // needs similar implementation for bools
              assembler.MOV_RegImm(target, value); // Move register immediate (variable)
              Push(target);
              break;
  case LOAD:  var index = (int)instruction.Operand;
              reg = IsParameter(index) ? allocation.Parameters[index - 1] : ... ;
              Push(reg);
              break;
  case STORE: var index = (int)instruction.Operand;
              var target = IsLocal(index) ? allocation.Locals[index-1-nofParams] : ...;
              var source = Pop();
              assembler.MOV_RegReg(target, source); // move register-to-register
              Release(source);
              break;
  case ISUB:  var operand2 = Pop();
              var operand1 = Pop();
              var result = Acquire();
              assembler.MOV_RegReg(result, operand1);
              assembler.SUB_RegReg(result, operand2);
              Release(operand1);
              Release(operand2);
              Push(result);
              break;
  ...
}
```

=== Ausführen von nativem Code in .NET
Der Code des JIT-Compilers muss sich in einer speziellen _Virtual Page_ befinden, welche eine explizite
_Code-Ausführungserlaubnis_ besitzt. Diese ist nicht Teil des .NET-Heaps. Der JIT-Compiler umgeht einen
_Sicherheitsmechanismus_, dass Code in Pages nicht vom Prozessor ausgeführt werden darf
#hinweis[(erschwert Remote Code Execution)]. In .NET wird der Code in einen Delegat verpackt
#hinweis[(```cs Marshal.GetDelegateForFunctionPointer<>()```)]. Dieser führt den Code dann ausserhalb der .NET Runtime
aus, was auch bedeutet, dass der JIT-Code _nicht_ mit Standard-IDE-Mittel debuggt werden kann.


=== Inkonsistente Allokation bei Branches
Wenn _mehrere Branches_ zum _gleichen Ziel_ führen, kann es passieren, dass verschiedene Registerzuweisungen
verwendet werden. Diese _nicht eindeutige Allokation_ kann _schwerwiegende Probleme_ verusachen.
Deshalb müssen die Allokationen mit _`MatchAllocation()` vor jedem Branch abgeglichen_ werden.
Die _Speicherorte_ der Werte werden damit an die Orte angepasst, die von der Location nach dem Sprung erwartet werden.\
Diese Verschiebung soll ausgeführt werden, wenn...
- ein _Conditional Branch_ bevorsteht #hinweis[(`if_true`, `if_false`)]
- ein _Unconditional Branch_ bevorsteht #hinweis[(`goto`)]
- an _jedem Start eines Branches_, der durch die vorherige Instruktion erreicht werden kann
  #hinweis[(Start von `if`, `while` etc.)]

== Optimierte Globale-Register-Allokation
Da es _nur 14 Register_ gibt, sollten wir genau abwägen, welche Variablen in diese gespeichert werden sollten.
Um den _maximalen Nutzen_ der globalen Register-Allokation zu erhalten, sollten _zwei Aspekte_ beachtet werden:
Die _Anzahl Aufrufe_ einer Variable sowie ihre _Lifetime_. Ersteres lässt sich leicht mit einem Usage Counter feststellen,
so werden z.B. Variablen in Loops eher ausgewählt.

Für zweiteres benötigen wir einen _Register Interference Graph_, um festzustellen, ob eine Variable noch gültig ist.
Falls nicht, kann sie durch eine andere lebende Variable ersetzt werden. Der Graph stellt alle Variablen dar und zieht
jeweils eine Kante zwischen zwei Variablen, wenn sie zum selben Zeitpunkt leben, also überlappende Lifetimes besitzen.
#grid(
  columns: (1.2fr, 1fr),
  gutter: 1em,
  align: horizon,
  [#image("img/combau_38.png")], [#image("img/combau_39.png")],
)

Sobald zwei Variablen _keine Kante_ haben, können sie sich ein Register teilen, da sie nie zum selben Zeitpunkt leben.
Da wir so wenig Register wie möglich verwenden wollen, haben wir ein _Graph Coloring Problem_, ein NP-Problem,
für welches _kein optimaler Algorithmus_ existiert. Es existiert jedoch ein _pragmatischer Algorithmus_, welcher
akzeptable Resultate liefert:\
Für $k$ verschiedene Register entferne alle Nodes mit weniger als $k$ Kanten und weise sie dem nächsten freien Register zu.
Die verbleibenden Nodes können nicht in $k$ Register untergebracht werden. Deswegen wählen wir einen der
verbleibenden Nodes und legen ihn auf den Stack #hinweis[(Register Spilling)]. Dann wird dieser Node entfernt und
der Algorithmus fährt weiter.

== JIT Assembler & Linker
Der JIT benötigt ebenfalls einen _Assembler_ und einen _Linker_. In unserem JIT-Compiler werden die Instruktionen
nach der Intel 64 Architektur-Spezifikation encodiert. Der Linker patcht die _Adressen im Instruktionscode_,
z.B. das Linken von Addressen zu statischen Variablen oder Methodenaufrufziele, die bereits zur JIT-Kompilierzeit bekannt sind.
Diese _statischen Adressen_ können dann direkt in die entsprechenden Instruktions-Operanden eingefügt werden.
Ebenfalls fügt der Linker aneinanderliegende JIT-Blöcke zusammen, damit nicht mehr unnötig zum Interpreter zurückgesprungen werden muss.

In unserer SmallJ-VM verwenden wir nur einen simplen Assembler ohne Linker, da wir weder statischen Variablen
noch Methodenaufrufe innerhalb von JIT-Code unterstützen.

== Native Stack-Verwaltung
Während der _Interpreter_ einen _managed Stack_ verwendet, benötigt der _JIT-Code_ einen _nativen Stack_,
welcher aus einem eigenen Speicherblock besteht, auf welchen der _Base- und Stack-Pointer zeigen_.

Eine _effizientere Vorgehensweise_ ist es, wenn beide Code-Arten sich denselben Stack teilen.
Dafür müsste der Interpreter-Code aber ebenfalls einen nativen Stack verwenden, wie in Abschnitt @unmanaged-call-stack
beschrieben. Der _Interpreter_ und _JIT-Code_ verwenden dann _abwechselnd_ diesen Stack, wobei beide Komponenten
ihren spezifischen Activation Frames reservieren. Wird von einer Methode returnt, wird automatisch in der
_richtigen VM-Komponente_ fortgefahren.

Dadurch wird auch der _Wechsel_ zwischen dem Interpreter und dem JIT-Code vereinfacht:
Das System kann einfach den obersten Activation Frame auf dem Stack ersetzten und mit der jeweiligen Komponente fortfahren.
Diese Technik wird _On-Stack-Replacement (OSR)_ genannt.

#grid(
  columns: (1.2fr, 1fr),
  gutter: 1em,
  align: horizon,
  [#image("img/combau_40.png")], [#image("img/combau_41.png")],
)

== Zusätzliche JIT-Funktionen
JIT-Compiler in anderen Sprachen müssen auch _System Calls_ #hinweis[(Heapallokation, Virtual Calls, Type Tests/Casts)]
handhaben können. Auch sollte der GC _nativen Code_ aufräumen. Dazu kann der JIT-Compiler weitere Deskriptoren generieren,
welche die Orte von Pointern auf dem Call Stack und in Registern aufzeichnen.
