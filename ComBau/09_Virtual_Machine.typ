#import "../template_zusammenf.typ": *

= Virtual Machine
Um die mit dem eigenen Compiler in die Intermediate Language kompilierten Programme laufen zu lassen,
brauchen wir eine _Laufzeitumgebung_, also eine _Virtuelle Maschine_.

*Nutzen:*
_Mehrplattformensupport_ #hinweis[(Der gleiche Compiler kann für verschiedene Plattformen verwendet werden,
es muss nur die VM portiert werden, damit alle Programme laufen)],
_Mehrsprachigkeit_ #hinweis[(kann mehrere Sprachen unterstützen, welche auf dieselbe IL kompilieren)],
_Sicherheit_ #hinweis[(VM verhindert elementare Sicherheitsprobleme wie Speicherfehler und erlaubt Sandboxing)].

== Aufbau einer virtuellen Maschine
Loader $arrow.r$ Interpreter #hinweis[(mit Just-in-Time Compiler)] $arrow.r$ Metadaten, Heap & Stacks
$arrow.r$ Garbage Collection

== Loader
Der Loader _liest_ das _Assembly_ bzw. Object File und _alloziert_ die notwendigen _Laufzeitstrukturen_.
Er kreiert _Metadaten_ für Klassen, Methoden, Variablen, Code, z.B die Definition der Speicher-Layouts für
Fields/Variablen/Parameter #hinweis[(Typengrösse, Offsets)]. Ebenfalls löst er die Verweise zu
Methoden/Typen/anderen Assemblies auf absolute Speicheradressen auf; die _Relocation_. Danach _initiiert_ er die
Programmausführung und macht optional eine _Code Verifikation_. Schlussendlich instanziert die VM die Klasse, welche die
Main-Methode enthält und ruft sie dynamisch auf.

Der _Verifier_ überprüft, ob der Bytecode _valide_ ist. Die meisten dieser Checks können aber auch zur Laufzeit
durchgeführt werden. Geprüft werden unter anderem Type Errors, Evaluation stack Under-/Overflow,
Undefinierte Variablen/Methoden/Klassen, Illegale Instruktionen & Branches und weitere sprachspezifische Fälle.

#grid(
  columns: (3fr, 1.4fr),
  gutter: 3em,
  [
    === Metadaten
    Metadaten sind _Laufzeitinformationen_ über Typen & Methoden #hinweis[(Klassen: Feldtypen und Methoden, Arrays: Elementtyp)].
    Diese Informationen sind notwendig, um das Programm korrekt auszuführen und Typsicherheit garantieren zu können.
    Zu diesem Zweck wandelt der Loader die Metadaten in Laufzeitstrukturen um, die _Descriptors_, welche später
    weiterverwendet werden.

    Der Loader erstellt für jede Klasse einen _Class Descriptor_, der den Base Type, die beinhalteten Felder und ihre
    Typen und die beinhalteten Methoden spezifiziert.\
    Zusätzlich gibt es auch _Method Descriptors_, die Parametertypen, Returntypen und die lokalen Variablen spezifizieren.
  ],
  [
    #image("img/combau_34.png")
    #image("img/combau_35.png")
  ],
)

=== Code Patching
Der Bytecode wird _direkt_ in den Speicher der VM _geladen_. Bestimmte Operanden müssen jedoch _angepasst_ werden,
damit sie _korrekt weiterverwendet_ werden können. Zum Beispiel müssen _spezifische Referenzen_
#hinweis[(auf Klassen, Methoden, Variabeln, Typen...)] _oder Offsets_ angepasst werden, damit sie eine _Referenz_
auf den entsprechenden Descriptor bilden. Diesen Vorgang nennt man _Code Patching_.

#table(
  columns: (1fr, 1fr),
  table.header([Original], [Patched]),
  [`invokevirtual MyMethod`], [`callvirt <method_desc>`],
  [`new MyClass`], [`new <class_desc>`],
  [`newarr MyType`], [`newarr <type_desc>`],
  [`getfield MyField`], [`getfield <field_desc>`],
  [`putfield MyField`], [`putfield <field_desc>`],
  [`checkcast MyClass`], [`checkcast <class_desc>`],
  [`instanceof MyClass`], [`instanceof <class_desc>`],
)

== Interpreter
Der Interpreter _führt den Code der Zwischensprache aus_. Er verfügt über einen _Interpreter Loop_, die eine Anweisung
nach der anderen emuliert. Er besteht aus drei Schritten: _Fetch_ #hinweis[(Instruktion laden)],
_Decode_ #hinweis[(Instruktion und Operanden auslesen)] und _Execute_ #hinweis[(Instruktion ausführen)].

=== Bestandteile
- _Interpreter Loop:_ Emuliert eine Instruktion nach der anderen #hinweis[```cs while (true) { Execute(code[IP++]) }```]
- _Instruction Pointer (IP):_ Adresse der nächsten Instruktion
- _Evaluation Stack:_ Für den virtuellen Stack Prozessor
- _Locals & Parameters:_ Von der aktiven Methode
- _Method Descriptor:_ Für aktive Methode

=== Ablauf
+ Der Interpreter Loop holt die _erste Instruktion_ `load 1` beim IP, wir laden also die lokale Variable mit Value `12`
  und pushen diese auf den _Evaluation Stack_.
+ Anschliessend _bewegt sich der IP eines nach vorne_ zur nächsten Instruktion `ldc 10`, womit der Interpreter Loop
  `10` auf den Evaluation Stack pusht.
+ Die nächste Instruktion `icmplt` poppt _zuerst den rechten_ und _dann den linken Operand_ für den _Vergleich_ vom
  Evaluation Stack. Hier wird nun `10 < 12` verglichen, was `false` ergibt. Dieses _Resultat_ wird wieder
  _auf den Stack gepusht_.
+ Nun kommt die Instruktion `if_false`, welche das Resultat der letzten Instruktion vom Stack poppt, und weil
  dieses `false` ist, wird nun der _Branch verwendet_ und der IP springt um 5 nach vorne. Da jedoch der IP
  _zuerst zur nächsten Instruktion_ geht und dann erst springt, gehen wir _insgesamt um 6_ nach vorne.

#image("img/combau_20.png")

=== Ausführung des Interpreter-Loops <interpreter-loop>
`Execute()` _emuliert Instruktion_ je nach Op-Code.

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    ```cs
    while (true) {
      var instruction = code[instructionPointer];
      instructionPointer++;
      execute(instruction);
    }
    ```
    Der Loop läuft, bis das Programm _beendet_ ist oder ein Fehler auftritt. Der IP wird vor der zu aufrufenden Funktion
    inkrementiert, deswegen gelten die Offsets von _relativen Jumps_ auch erst ab der Instruktion _danach_.
  ],
  [
    ```cs
    switch (instruction.OpCode) {
      case LDC:
        Push(instruction.Operand);
        break;
      case IADD:
        var right = Pop();
        var left = Pop();
        var result = left + right
        Push(result);
        break;
      ...
    }
    ```
  ],
)

== Call Stack
Ein Programm beinhaltet _mehrere Methoden_ und _Sprünge_ zwischen den Methoden. Damit pro Methode der Zustand
des Evaluation Stacks zwischengespeichert werden kann, braucht es neben dem Evaluation Stack auch einen _Call Stack_.
Dieser speichert die _Activation Frames_, ein Frame pro aufgerufene Methode. Die aktive Methode liegt _zuoberst_ auf dem Stack.
Jeder _Activation Frame_ speichert _Parameter_, _lokale Variablen_ und den _Evaluation Stack_ pro aktive Methode.

_Jedes Mal_, wenn eine Methode mithilfe des Opcodes _`invokevirtual`_ aufgerufen wird, wird ein
_neues Activation Frame_ auf den Call Stack gepusht.\
Wenn zum Beispiel eine Methode `g()`, die _bereits aufgerufen wurde_, also bereits auf dem Call Stack ist,
_rekursiv_ erneut aufgerufen wird, wird diese ein _zweites Mal auf den Call Stack gepusht_, mit einem _neuen Set_
an lokalen Variablen und einem _neuen, leeren Evaluation Stack_.\
Bei einem _Rücksprung_ durch den Opcode _`return`_ aus der Methode `g()` wird das oberste Frame wieder vom Call Stack _entfernt_.


=== Methodenaufruf
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    Bei einem _Methodenaufruf_ ruft der _Caller_ #hinweis[(Methode, welche den Function Call aufruft)] den
    _Callee_ #hinweis[(Zu aufrufende Methode)] auf. Zuerst wird der Method Descriptor des Callees bestimmt, indem der
    Operand des `ìnvokeVirtual`-Opcodes evaluiert wird. Dieser spezifiziert die _Anzahl Parameter_; basierend darauf
    werden die Argumente und anschliessend die `this`-Referenz auf das Objekt der auszuführenden Methode
    von hinten vom Stack gepoppt.
  ],
  [
    ```cs
    var met = (MethodDescriptor)instruction.Operand;
    var nofParams = met.ParameterTypes.Length;
    var args = new object[nofParams];
    for(int i = args.Length - 1; i >= 0; i--) {
      args[i] = Pop();
    }
    var target = Pop(); // 'this' reference
    var af = new ActivationFrame(met, target, args);
    callStack.Push(af);
    ```
  ],
)

=== Methodenrücksprung
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    Wird eine Methode _beendet_, wird im aktuellen Method Descriptor geprüft, ob sie einen _Return Type_ hat
    oder `void` ist. Hat sie einen, wird dieser Wert vom Stack gepoppt und nach der Entfernung des Activation Frames
    auf den Evaluation Stack des Callers gepusht.
  ],
  [
    ```cs
    var met = activeFrame.Method;
    var hasReturn = met.ReturnType != null; // void?
    object result = hasReturn ? Pop() : null;
    callStack.Pop(); // go back to caller
    if (hasReturn) { Push(result); }
    ```
  ],
)

=== Design
Ein Call Stack kann auf _zwei Arten_ aufgebaut werden:
- _Managed Call Stack:_ Im Interpreter, Objekt-orientierte Darstellung #hinweis[(Fokus auf Komfort)]
- _Unmanaged Call Stack:_ Bei HW-Execution #hinweis[(JIT)], Kontinuierlicher Speicherblock #hinweis[(Fokus auf Effizienz)]

==== Managed Call Stack
Wird mit _Klassen_ modelliert. Ein Aktivierungsframe ist eine _Instanz einer Klasse_, die einen Verweis auf den
Method Descriptor sowie die lokalen Variablen, Parameter, this-Referenz, Evaluation Stack und den
aktuellen IP des Callers enthält.

```cs
class ActivationFrame {
  public MethodDescriptor Method { get; }
  public Pointer ThisReference { get; }
  public object[] Arguments { get; }
  public object[] Locals { get; }

  public EvaluationStack EvaluationStack { get; }
  public int InstructionPointer { get; }
}

class CallStack {
  private readonly Stack<ActivationFrame> _stack;
}
```

#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    ==== Unmanaged Call Stack <unmanaged-call-stack>
    Folgt dem klassischen _Design eines Betriebssystems_. Bevorzugter Weg, wenn die VM in einer _low-level Sprache_
    implementiert oder JIT-Code ausführt wird. Der IP #hinweis[(auch Program Counter genannt)] ist _eine Adresse_
    im generierten Code Block. Ausserdem wird ein _zusammenhängender virtueller Speicherblock_ für den Stack alloziert.\
    Der Frame der aktiven Methode ist durch den _Stack Pointer_ #hinweis[(SP)] und den _Base Pointer_
    #hinweis[(BP, auch Frame Pointer genannt)], abgegrenzt. Oberhalb des BPs werden die _lokalen Variablen_ und
    der _Evaluation Stack_ der _aktiven Methode_ gespeichert. Unterhalb des BPs befinden sich die _Parameter_ der
    aktiven Methode und der SP und BP des Callers, zu letzterem wird bei _Return zurückgesprungen_.
  ],
  image("img/combau_21.png"),
)

#grid(
  columns: (1.5fr, 1fr),
  gutter: 1em,
  [
    == Laufzeitstrukturen
    Die Abbildung rechts dient als Zusammenfassung der Laufzeitstrukturen einer virtuellen Maschine.
    Der _Interpreter_ arbeitet mit einem _Call Stack_ der aus _Activation Frames_ besteht.
    Jeder _Activation Frame_ verwaltet einen _Evaluation Stack_.\
    Wenn die VM _Multi-Threading_ unterstützen würde, müsste das Laufzeitsystem über mehrere Call Stacks verfügen,
    für jeden _aktiven Thread_ einen.
  ],
  image("img/combau_22.png"),
)

== Verifikation
_Erkenne_ und _verhindere_ falschen Byte-Code, die durch _Fehler im Compiler_ oder _böswillige Manipulation_ entstehen.

=== Verhinderungsstrategien
- _Statische Analyse_ zur Laufzeit
- _Überprüfung zur Laufzeit_ #hinweis[(Unser Approach)]

==== Folgendes ist zu Überprüfen:
#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    - _Korrekte Benutzung der Instruktionen_ #hinweis[(Typen stimmen, Methodenaufrufe stimmen, Sprünge sind gültig,
      Op-Codes stimmen, Stack-Überlauf oder Unterlauf erkennen)]
    - _Typen sind bekannt_ #hinweis[(Metadaten, Werte auf dem Evaluation Stack haben einen Typ)]
  ],
  [
    ```cs
    // type safe iadd
    int right = CheckInt(Pop());
    int left = CheckInt(Pop());
    Push(left + right);
    ```
  ],
)

==== Weitere Sicherheitsmassnahmen
- Variablen immer _initialisieren_
- _Null-dereference_ und index-out-of-bounds Checks
- _Kompatibilität_ von externen Verweisen
- _Garbage Collection_

== Interpretation vs. Kompilation
#table(
  columns: (1fr, 1fr),
  table.header([Interpretation], [Kompilation]),
  [
    _Ineffizient_, dafür _flexibel_ und _einfach_ zu entwickeln. Akzeptabel für selten ausgeführten Code.
  ],
  [
    Kompilierter HW-Prozessor Code ist _schneller_, JIT-Compilation für Hot Spots für noch mehr Performance.
    Kompilation _kostet_, Laufzeit macht es (allenfalls) wett.
  ],
)

#pagebreak()
