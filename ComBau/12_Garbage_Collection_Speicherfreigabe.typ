#import "../template_zusammenf.typ": *

= Garbage Collection & Speicherfreigabe
Die _Speicherfreigabe_ ist ein wichtiger Aspekt der Virtuellen Maschine. Es gibt _drei verschiedene Arten_ von Speicher
mit verschiedenen Verwaltungsoptionen:

- _Metadaten:_ Keine Freigabe für Typdeskriptoren, Ancestor Tables, vTables etc. nötig
- _Call Stack:_ Der Activation Frame wird bei Return aus der Methode automatisch freigegeben
- _Heap:_ Muss mit Garbage Collection aktiv freigegeben werden, da Objekte keine hierarchische Lifetime besitzen

== Explizite Freigabe
`delete`-Statement zum manuellen Deallozieren eines Objektes #hinweis[(Pendant zu `new`)].
Ist zum Beispiel in C oder C++ so gelöst.

```java x = new T(); ... delete x;```

==== Probleme
Mit _expliziter Speicherfreigabe_ kann es zu _schwerwiegenden_ Speicherfehler kommen.
#table(
  columns: (1fr, 1fr),
  table.header([Dangling Pointers], [Memory Leaks]),
  [
    Referenz auf bereits gelöschtes Element\
    #hinweis[(Kann nicht berechtigten Speicher lesen oder fremden Speicher überschreiben: Security + Safety Issues)]
    ```cs
    x = new T(); x = y; delete x;
    // y now points to free space
    // or a different subsequent allocation
    ```
  ],
  [
    Verwaiste Objekte, die nicht abräumbar sind\
    #hinweis[(Nicht löschbarer Garbage füllt den Heap)]
    ```cs
    x = new T(); x = null;
    // The pointer has been cleared, but the object
    // is still present on the heap
    // unreachable -> undeletable without GC
    ```
  ],
)

== Garbage Collection
Das Laufzeitsystem kümmert sich um die _automatische Freigabe_ von Garbage #hinweis[(nicht mehr benötigte Objekte)].\
*Nutzen:* _Memory Safety_ und eine _Vereinfachung_ der Programmierung.

=== Garbage
Als Garbage werden Objekte bezeichnet, die _nicht mehr erreichbar_ sind und daher _nicht mehr gebraucht_ werden können.
Der umgekehrte Fall ist jedoch etwas anders: Es kann Objekte geben, die _nicht mehr benutzt_ werden, aber trotzdem
noch _erreichbar_ sind. Das System kann jedoch nicht "in die Zukunft schauen", um herauszufinden, ob das Objekt noch
verwendet wird, und klassifiziert es darum nicht als Garbage.

=== Reference Counting
Mit _Reference Counting_ wird durch einen _Counter_ #hinweis[(rc)] pro Objekt festgehalten,
_wie viele eingehende Referenzen_ auf dieses Objekt vorhanden sind. Ist _`rc == 0`_, ist das Objekt Garbage,
die _Umkehrung_ davon gilt aber _nicht_ #hinweis[(Zyklische Referenzen)].

Bei _jeder Zuweisung_ von Referenzen muss zusätzlich eine Referenz erstellt/verschoben werden, was _sehr teuer_ ist.

```cs
x = y; // wird zu:
y.rc++; x.rc--; if (x.rc == 0) { delete x; } x = y; // rc++ first, in case the object is the same
```

==== Zyklische Objekte
_Zyklische Objekte_ werden mit Reference Counting _nie_ zu Garbage, weil alle Elemente im Zyklus _eine eingehende Referenz_
haben, auch wenn _keine Referenz von aussen_ mehr vorhanden ist. Ergibt _Memory Leaks_. Die könnte mit
#link(<weak-ref>)[_weak pointers_] umgangen werden, welche vom Counter nicht mitgezählt werden. Diese können aber wiederum
zu Memory Leaks und verfrühter Objekt-Löschung führen. Deshalb ist Reference Counting _ungeeignet_ für den Garbage Collector.

== Garbage Collector (GC)
Ein Garbage Collector bietet eine _nachhaltigere Lösung_ für die Rückgewinnung von freiem Heap-Speicher ohne
Dangling Pointer oder Memory Leaks. Ein GC ist ein _automatischer Mechanismus_, welcher den _Heap analysiert_ und Garbage
nach einer nicht-deterministischen Verzögerung _freigibt_.

=== Transitive Erreichbarkeit
Objekte, die das Programm _noch verwenden_ könnte, dürfen _nicht gelöscht_ werden. Das heisst, ausgehend von
_Ankerpunkten_ #hinweis[(Root Set)] werden alle direkt und indirekt über Referenzen vom Programm erreichbaren Objekte als
_"Nicht-Garbage" markiert_. Die nicht markierten Objekte sind Garbage und können entfernt werden.

==== Root Set
#grid(
  columns: (1.2fr, 1fr),
  gutter: 1em,
  [
    Die Analyse der transitiven Erreichbarkeit muss bei bestimmten _Referenzen der ersten Ebene beginnen_.
    Diese erste Ebene wird als _"Root Set"_ bezeichnet und umfasst die folgenden Quellen des laufenden Programms:

    - _Statische Variablen:_ In SmallJ nicht vorhanden
    - _Call Stack:_ Referenzen in Parametern und lokalen Variablen, `this`-Referenz, Evaluation Stack
    - _Register:_ Bei JIT-Compiler relevant

    Das Root Set wird in unserem Fall durch die _Pointer auf dem Call Stack_ erkannt.
  ],
  [
    ```cs
    IEnumerable<Pointer>
    GetRootSet(CallStack callStack) {
      var list = new List<Pointer>();
      foreach (var frame in callStack) {
        CollectPointers(frame.Parameters);
        CollectPointers(frame.Locals);
        CollectPointers(frame.EvaluationStack);
        list.add(frame.ThisReference);
      }
      return list;
    }
    ```
  ],
)

Eine Referenz kann sich nur auf dem _Evaluation Stack_ befinden, wenn eine Heapallokation mit _komplexen Ausdrücken_
ausgeführt wird #hinweis[(z.B. ```cs setUpVehicles(new Car(), new Cabriolet(), new Truck())```)]. Angenommen, der Heap
hat keinen Platz mehr für den neuen `Truck`, befinden sich zu diesem Zeitpunkt bereits `Car` und `Cabriolet` auf
dem Evaluation Stack. Diese Objekte _leben bereits_ und werden nur vom Evaluation Stack _referenziert_. Würde der
Evaluation Stack sich also _nicht_ im Root Set befinden, würde der GC diese Objekte _fehlerhafterweise löschen_.

Auch die _`this`-Referenz_ im Root Set ist essentiell: Das impliziert erstellte `main`-Objekt wird häufig nur vom
`this` der `main()`-Methode oder anderen Methodenaufrufen innerhalb des `main`-Objekts referenziert.


=== Mark & Sweep Algorithmus
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    - _Mark Phase:_ Markiere alle erreichbaren Objekte
    - _Sweep Phase:_ Lösche alle nicht markierten Objekte
  ],
  [
    ```cs void Collect() { Mark(); Sweep(); }```
  ],
)

#pagebreak()

=== Mark Phase
Traversiere ausgehend vom Root Set alle _durch Pointer erreichbaren Elemente_ und _markiere_ diese mit dem
_`Mark Flag`_ als "Non-Garbage". Dieses Flag wird im Objektblock im _reservierten Bereich_ vor der `blockSize` gesetzt.

```cs void Mark() { foreach (var root in RootSet) { Traverse(root); } }```

Die Traversierung wird mit _Depth-First Traversal_ durchgeführt. Jedes _erreichte Objekt_ wird _markiert_ und
anschliessend durch die von diesem Objekt ausgehenden _Verweise durchiteriert_, um diese Objekte _ebenfalls zu markieren_.
Da Heap-Strukturen _zyklisch_ sein können, werden _bereits markierte Objekte übersprungen_.

```cs
void traverse(Pointer current) {
  long block = heap.GetAddress(current) - BLOCK_HEADER_SIZE;
  if (!IsMarked(block)) {
    SetMark(block); // Mark Flag im Objekt-Header
    foreach (var next in GetPointers(current)) { // Referenzen im Objekt enumerieren
      Traverse(next);
    }
  }
}
```

==== Pointer im Objekt
#grid(
  columns: (0.8fr, 1fr),
  gutter: 1em,
  [
    Der GC muss wissen, wo sich im Objekt _Pointer_ befinden #hinweis[(Felder eines Referenztypen, Elemente in einem
    Array eines Referenztypen)]. Um diese zu erfassen, kann der GC den _Typdeskriptor_ über den Type-Tag des Blocks erhalten.
    Ist es ein _Klassendeskriptor_, kann er die Felder mit Referenztypen so erkennen. Bei _Arrays_ wird im Type Tag geprüft,
    ob es einen Referenztyp speichert, ansonsten ist kein GC nötig.
  ],
  [
    ```cs
    IEnumerable<Pointer> GetPointers(Pointer current) {
      var descr = heap.GetDescriptor(current);
      var fields = ((ClassDescriptor)descr).AllFields;
      for(var i = 0; i < fields.Length; i++) {
        if (!IsPointerType(fields[i].getType())) continue;
        var value = heap.ReadField(current, i);
        if (value != null) yield return (Pointer)value;
      }
    }
    ```
  ],
)


==== Rekursive Traversierung
Der GC braucht _zusätzlichen Speicher_ für den Call-Stack, was problematisch ist, weil der Speicher beim Aufruf vom GC
oft bereits _knapp_ ist. Es _existieren_ Algorithmen zur Traversierung _ohne Zusatzspeicher_, wie z.B.
_Pointer Rotation Algorithmus_ von Deutsch-Schorr-Waite. Für uns reicht jedoch die rekursive Traversierung aus.

=== Sweep Phase
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    Lösche linear alle Elemente im Heap, die in der Mark Phase _nicht_ markiert wurden. Weil diese Phase _linear_ durch
    den Heap traversiert, werden _alle Elemente_ besucht. Bei _markierten Objekten_ wird das _`Mark Flag` entfernt_,
    _unmarkierte Blöcke_ werden wieder als _freie Blöcke registriert_. Blöcke, welche bereits frei sind, werden nicht
    weiterverarbeitet und einfach so gelassen, wie sie sind.
  ],
  [
    ```cs
    void Sweep() {
      long current = HEAP_START;
      while (current < HEAP_SIZE) {
        if (IsGarbage(current)) { // !Marked && !Free
          Free(current); // Register free bl. in heap
        }
        ClearMark(current);
        current += heap.GetBlockSize(current);
      }
    }
    ```
  ],
)

=== Free List
Freie Blöcke können _nach der Garbage Collection_ überall im Heap _verstreut_ sein. Dieses Phänomen wird _externe
Fragmentierung_ genannt. Durch das _Freigeben von Speicher_ kann nicht mehr der simple Free Pointer verwendet werden,
der Heap muss jetzt _mehrere freie Blöcke verwalten_. Dafür wird die _free list_ eingeführt, eine _lineare Linked-List_
mit allen freien Blöcken. Vor der Sweep-Phase werden die freien Blöcke nach und nach in die am Anfang leere _free list_
eingetragen. Jedes Element in der Free List beinhaltet im Objekt-Block _anstelle des Type-Tags_ einen _Pointer auf den
nächsten Eintrag_ in der free list. So sind die einzelnen freien Blöcke _linear miteinander verkettet_.

==== Neue Heap-Allozierung
Die _Free-List_ wird _traversiert_, bis ein _passender Block_ gefunden ist. Ein allfälliger _Überschuss_ des Blockes wird
_wieder_ in die Free List _eingetragen_.

==== Strategien
- _First Fit:_ Keine Sortierung, erster passender Block wird für die Allozierung verwendet #hinweis[$O(n)$]
- _Best Fit:_ Die freien Blöcke sind nach aufsteigender Grösse sortiert, um einen möglichst passenden Block zu finden.
  Dies führt zu unbrauchbar kleinen Fragmenten #hinweis[$O(n)$]
- _Worst Fit:_ Die Blöcke sind nach absteigender Grösse sortiert. Es wird sofort ein passender Block gefunden.
  Hohe externe Fragmentierung. $O(1)$ für das Allozieren und $O(n)$ für das erneute Einsetzen vom Rest des Free Blocks.
- _Segregated Free List:_ Mehrere Free Lists mit verschiedenen Grössenklassen
  #hinweis[(z.B. Blöcke mit 64-128 bytes, 128-196, etc.)]. Da eine konstante Anzahl von Listen verwendet werden soll,
  gibt es eine _Overflow List_, in welche alle "zu grossen" Blöcke eingefügt werden #hinweis[(z.B. alle Blöcke >= 32kB)].
  Sehr kleine Blöcke #hinweis[(< 64 bytes)] werden nicht wieder eingefügt, da sie zu klein für weitere Verwendung sind
  und dies _interne Fragmentierung_ auslösen würde. Allokation und erneutes Einfügen eines Restblocks benötigen nur $O(1)$.
- _Buddy-System:_ Blockgrössen sind 2er Potenz, falls kein Platz vorhanden wird ein grösserer Block in zwei kleinere aufgeteilt,
  falls Buddy bei Deallokation auch frei ist, werden beide Blöcke verschmolzen. Durch die exponentiellen Grösseklassen
  haben die meisten Blöcke aber unbrauchbare Reste, welche nicht weiter verwendet werden können, was ebenfalls wieder
  zu Interner Fragmentierung führt.
- _Compacting Garbage Collection:_ Siehe Kapitel @compacting-gc

Viele der oben beschriebenen _Nachteile_ können aber durch einen _einfachen Trick mitigiert_ werden.
Wenn die Heap-Blöcke _ihre Grösse_ am Anfang und Ende _speichern_, kann der benachbarte Block trivial bestimmt werden,
der Heap ist dann quasi eine _Double-Linked-List_ an Blöcken. So können Blockreste schnell mit potenziell freien
benachbarten Blöcken _verschmolzen_ werden #hinweis[(der Vorgänger- und/oder Nachfolgeblock)] und von ihrer momentanen
Free List in eine neue Grössenklasse verschoben werden.

=== Heap Fragmentierung
Um zu verhindern, dass der Heap immer weiter _zerstückelt_ wird und schlussendlich alle freien Blöcke in der Free List
zu klein sind, werden _benachbarte freie Blöcke_ in der Sweep Phase _miteinander verschmolzen_.
Anschliessend müssen die Block Tags des vorherigen Blocks und des neu verschmolzenen Blocks entsprechend angepasst werden,
damit Elemente wieder korrekt in der Liste eingetragen sind.

=== Ausführungszeitpunkt
Garbage wird _nicht sofort_ erkannt und freigegeben #hinweis[(Delayed Garbage Collection)]. Unmittelbare Deallokation war
nur mit der Reference Counting-Methodik möglich. Der GC läuft spätestens, wenn der _Heap voll_ ist.
Jedes Mal beim _Allozieren_ von Speicher #hinweis[(`new`-Operator)] wird _überprüft_, ob noch _genug Platz_ verfügbar ist,
falls nicht, wird der _GC gestartet_. Er kann aber auch _prophylaktisch früher_ gestartet werden, insbesondere bei _Finalizer_.

=== Stop & Go
Der GC läuft _sequentiell_ und _exklusiv_. Das heisst, der _Mutator_ #hinweis[(Das produktive Programm)], wird während
dem Ausführen des GC's unterbrochen. So entsteht ein "Stop & Go"-Ablauf #hinweis[(auch _"Stop-the-World"_ genannt)],
in dem sich der Mutator und der GC abwechseln. Das _Anhalten des Mutators_ ist essentiell für die korrekte Funktionsweise
des Mark-and-Sweep-Algorithmus, da ansonsten _während des GC-Durchlaufs_ der Heap _verändert_ werden könnte, womit die
Mark-Phase nicht mehr richtig funktionieren würde. Die Sweep-Phase könnte jedoch bei korrekter Synchronisierung
#hinweis[(Locks, atomic instructions)] gleichzeitig laufen #hinweis[(Lazy Sweep)].

Stop & Go ist allerdings ungeeignet für zeit- oder performancekritische Anwendungen, da die Ausführung des GC häufig nicht
vorhergesagt werden kann und dadurch in für das Programm ungeeigneten Momenten laufen kann.

== Finalizer
Ein _`finalizer`_ ist eine Methode, die _vor dem Löschen_ eines Objektes ausgeführt wird.
Kann für _Abschlussarbeiten_ verwendet werden, wie das Schliessen von Verbindungen, Lösen von Concurrent Locks, etc.
Wird vom _GC initiiert_, wenn das Objekt Garbage geworden ist.

#pagebreak()

=== Separate Finalisierung
Der Finalizer wird nicht in der GC-Phase ausgeführt, sondern später. Gründe dafür können sein:
- _Kann lange oder unendliche Laufzeit haben:_ Blockiert sonst GC, bei Stop-and-Go-GC sogar ganzes Programm
- _Kann neue Objekte allozieren:_ Korrumpiert GC und/oder Heap
- _Programmfehler im Finalizer:_ Kann zu Crash des GC's führen
- _Resurrection:_ Ein Objekt, welches gerade finalisiert wird, kann eine Referenz auf ein noch lebendes Objekt besitzen.
  Durch diese Referenz kann der Finalizer einen auf das Garbage-Objekt zeigenden Pointer im lebenden Objekt kreieren,
  und damit der Garbage Collection entgehen. Ein wiederbelebtes Objekt lässt nicht nur sich selbst, sondern auch
  alle anderen direkt oder indirekt referenzierten Garbage im Objekt wiederbeleben. Dies ist allerdings eine
  komplett valide Operation in einer Runtime, also müssen GC's damit umgehen können.

=== Internals
Es gibt ein _finalizer Set_ #hinweis[(Registrierte Finalizer von allen lebenden Objekten)] und eine
_pending queue_ #hinweis[(Alle Finalizer von Objekten, welche als Garbage identifiziert wurden
und so schnell wie möglich laufen sollten)].

Garbage mit Finalizer wird im die _Pending Queue_ eingetragen. Die Pending Queue zählt als _zusätzliches Root Set_
und somit wird das Element und alle seine Referenzen _wiederbelebt_. Dies ist nötig, weil das Objekt für die Finalization
_erhalten bleiben muss_. Es ist also aus der Sicht des GCs eine _zweite Mark-Phase_ innerhalb des selben Durchlaufs nötig.
#hinweis[(*Erste Phase:* Markiere und erkenne Garbage mit Finalizer, welche in die Pending Queue eingefügt werden.
*Zweite Phase:* Eine weitere Mark Phase für die Pending Queue, welche jetzt im Root Set ist, wird durchgeführt.
Dadurch werden alle Referenzen des Objekts mit dem Finalizer wiederbelebt.)]

Aus der Sicht des _Objekts mit Finalizer_ sind _zwei volle GC-Durchläufe_ nötig, um den Garbage vollständig zu entfernen.
#hinweis[(*Erster Durchlauf:* Finalizer wird der Pending Queue hinzugefügt. *Zwischen GC-Läufen:* Finalizer wird ausgeführt.
*Zweiter Durchlauf:* Ausgeführter Finalizer ist nicht mehr in der Pending Queue, damit nicht mehr im Root Set und durch
Sweep entfernt, falls immer noch Garbage)]

_Nach dem Finalizer_ wird der `pending`-Eintrag _gelöscht_. Da der Speicher bei sehr wenig freiem Platz eventuell
_nicht schnell genug freigegeben_ werden kann, lassen die meisten Systeme den GC _prophylaktisch_ laufen, damit die
Finalizer noch fertig laufen können, bevor der Heap-Speicher erschöpft ist.

#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    Grundsätzlich ist es _nicht empfohlen_, die Garbage Collection _manuell_ auszuführen, da dies mit den Heuristiken
    des GCs konfliktieren kann und damit die Performance reduziert. Es kann aber _vor zeit- und speicherintensiven_
    Operationen nützlich sein, so viel freien Platz wie möglich zu schaffen.
  ],
  [
    ```cs
    // C# manual GC Run
    GC.Collect();
    GC.WaitForPendingFinalizers();
    ```
  ],
)

=== Probleme
- Die _Reihenfolge_ der Finalizer ist _unbestimmt_, da sie keine hierarchische Lifetime besitzen.
  Die Finalizer können also auch bei Vererbungen in Klassen in einer unerwarteten Reihenfolge laufen.
- Finalizer laufen _beliebig verzögert_, oder möglicherweise gar nicht, wenn `main()` fertig
- Sie laufen _nebenläufig_ zum Hauptprogramm, z.B. in einem eigenen Finalizer-Thread oder zwischen der normalen
  Programmausführung. Dies kann zu Concurrency-Problemen führen.
- Frage, ob der Finalizer nach einer Wiederbelebung erneut laufen soll. Dies ist in Java und C\# nicht der Fall,
  in C\# kann ein Finalizer aber mit ```cs GC.ReRegisterForFinalize(this);``` erneut ausgeführt werden.

== Weak Reference <weak-ref>
_Weak References_ zählen _nicht_ als Referenz für den GC, im Gegensatz zu den normalen _Strong References_.
Garbage mit Weak References kann aber noch solange erreicht werden, bis es abgeräumt worden ist.
_Nach Freigabe_ des verwiesenen Objektes wird die _Referenz auf `null`_ gesetzt. Wird für Implementation von Caches verwendet.

Meist werden _Weak References_ intern via _Hash Table_ implementiert. Jede Weak Reference zeigt auf einen\
_Tabelleneintrag_, welcher dann auf das Target Object zeigt. Diese werden dann in der Mark Phase des GCs ignoriert
und in der Sweep Phase werden alle Einträge geleert, bei welchen das Target Object gelöscht wurde.

#table(
  columns: (1fr, 1fr),
  table.header([Short Weak Reference], [Long Weak Reference]),
  [
    Wird zurückgesetzt, sobald der GC das Target Objekt als Garbage identifiziert hat, bevor der Finalizer läuft.
    Dadurch kann es im Finalizer zu Wiederbelebung des Targets kommen.
  ],
  [
    Wird zurückgesetzt, bevor der GC das Target Object definitiv löscht, also nach dem Finalizer.
    Hat das Objekt also noch verbleibende Finalizer oder wird wiederbelebt, zeigt die Weak Reference immer noch darauf.
  ],
)


== Compacting GC <compacting-gc>
Durch Allozieren und Löschen entstehen _viele kleine Lücken_ im Heap. Obwohl in Summe genug freier Speicher verfügbar wäre,
kann es so sein, dass ein neues Objekt _keinen Platz_ mehr hat, weil alle Lücken _zu klein_ sind.

Der _Compacting GC_ #hinweis[(auch _Mark & Copy GC_ oder _Moving GC_ genannt)] _schiebt die Objekte wieder zusammen_,
sodass sich der gesamte freie Platz am Ende des Heaps befindet. Hier genügt wieder ein simpler Free Pointer,
eine Free List wird nicht benötigt. Allokationen werden am _Heap-Ende_ gemacht, bei Verschiebungen müssen alle Referenzen
_nachgetragen_ werden. Da dies im gesamten System geschehen muss, wird separat der gesamte Speicherplatz nach zu
verschiebenden Referenzen durchsucht. Dies kann auf verschiedene Arten geschehen:
- _Remembered Set:_ Speichert die Adressen aller eingehenden Pointer pro Objekt
- _Forwarding Pointer:_ Ein zweiter Pointer zeigt auf die momentane Objektadresse.
  Zeigt dieser nach dem Ausführen des GCs nicht mehr auf das eigene Objekt, wurde das Objekt verschoben und der
  Originalpointer muss angepasst werden. Benötigen viel Speicher und jeder Pointer muss zwei Mal dereferenced werden.

Das System muss jederzeit die _Positionen aller Pointer kennen_, da es diese aktualisieren muss.
Da in C/C++ Zahlen zu Pointern und umgekehrt gecasted werden können, kann ein Compacting GC hier nicht realisiert werden.

== Inkrementeller GC
Ein _Nachteil_ des "Stop-the-World"-GCs ist, dass die Programmausführung währenddessen _pausiert_ werden muss.
Dies ist für gewisse Anwendungsfälle nicht akzeptabel. In solchen Fällen werden _inkrementelle GCs_ eingesetzt;
diese sollen quasi-parallel zum Mutator laufen, indem sie den Mutator _mehrmals kurz unterbrechen_ und in diesen
ihre Arbeit _inkrementell verrichten_.

=== Arten von Inkrementellen GCs
==== Generational GC
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    _Junge Objekte_ werden _schneller freigegeben_, weil diese tendenziell eine _kurze Lebenserwartung_ haben
    #hinweis[(Zeitspiegelungsheuristik)]. Es gibt 3 Generationen, deren Grenzen jeweils durch einen Pointer markiert werden:
    #table(
      columns: (1fr,) * 4,
      table.header([Alter], [Generation], [GC-\ Frequenz], [GC-Pause]),
      [neu], [G0], [hoch], [kurz],
      [mittel], [G1], [mittel], [mittel],
      [alt], [G2], [tief], [lang],
    )
  ],
  image("img/combau_29.png"),
)

Wird nun G0 aufgeräumt, werden alle _nicht-markierten Elemente in G0 aufgeräumt_, und zusätzlich alle Referenzen
von G1/G2, welche auf G0 zeigen. Die verbleibenden Blöcke werden _eine Altersstufe nach oben_, zu G1, _geschoben_.

Wenn eine alte Generation aufgeräumt wird, müssen auch die neueren mit aufgeräumt werden, um _zyklischen Garbage_,
welcher mehrere Generationen umspannt, zu erfassen. Dazu muss das System _Reference-Writes_ in alten Generationen
erkennen können. Dazu müssen _Write Barriers_ in G1/G2 erstellt werden.
- _Software-based write barriers:_ (JIT) Compiler, Loader, und/oder Interpreter fügen mit jedem Schreiben eines
  Pointers zusätzlichen Code ein, um potentielle Root Set-Kandidaten zu registrieren
- _Hardware-based write barriers:_ Virtual Memory Management. Die betroffenen Memory Pages sind read-only, dadurch gibt es
  beim Schreiben einen Page Fault. Der Interrupt-Handler prüft dann auf das Schreiben von Referenzen

==== Partitioned GC
Heap wird in Partitionen zerlegt. Das Markieren wird _nebenläufig_ durchgeführt, und in einer zweiten
"Stop the World"-Phase werden verpasste Updates nachgeführt. Die Mark Phasen erstellen für jede Partition ein
eigenes Root Set, welches alle Referenzen von anderen in diese Partition führen, das _Remembered Set_.
Damit diese Referenzen während der Mark Phase nicht verändert werden, sind auch hier `write` Barriers notwendig.
Danach weiss der GC, wie viel Garbage jede Partition besitzt.

Der GC _fokussiert_ zuerst auf _Partitionen_ mit _viel Garbage_. Die _verbleibenden Objekte_ werden dann in eine neue
Partition verschoben, was eine Anpassung der Referenzen wie im Moving GC notwendig macht.
Die vorherigen Partitionen können nun in Gänze _gelöscht_ werden. Zyklischer Garbage zwischen Partitionen benötigt
jedoch immer noch einen vollständigen GC.