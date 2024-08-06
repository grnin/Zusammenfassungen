// Compiled with Typst 0.11.1
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.0": wrap-content

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de"
)*/

= Scheduling
Auf einem Prozessor läuft zu einem Zeitpunkt immer _höchstens ein Thread_. Es gibt folgende _Zustände:_
#wrap-content(
  image("img/bsys_27.png"),
  align: bottom + right,
  columns: (60%, 40%),
)[
  - _Running:_ der Thread, der gerade läuft
  - _Ready:_ Threads die laufen können, es aber gerade nicht tun
  - _Waiting:_ Threads, die auf ein Ereignis warten
    #hinweis[(können nicht direkt in den Status running wechseln, müssen neu gescheduled werden)]
  Übergänge von einem Status zum anderen werden _immer vom OS_ vorgenommen.
  Dieser Teil vom OS heisst _Scheduler_.
]
#wrap-content(
  image("img/bsys_28.png"),
  align: top + right,
  columns: (55%, 45%),
)[
  == Grundmodell
  Threads, die auf Ereignisse _warten_, müssen das _nicht_ in einer _Endlosschleife_ tun
  #hinweis[(Busy-Wait)]. Stattdessen registriert das OS sie auf das entsprechende Ereignis
  und setzt sie in den Zustand _waiting_. Tritt das Ereignis auf, ändert das OS den
  Zustand auf _ready_. Es laufen nur Threads auf dem Prozessor, die _nicht warten_.

  === Ready-Queue
  In der Ready-Queue #hinweis[(kann auch ein Tree sein)] befinden sich alle Threads, die
  _bereit sind zu laufen_. Neue Threads kommen typischerweise direkt in die Ready-Queue
  #hinweis[(Einige OS stellen neue Threads auf waiting)].
]
=== Powerdown-Modus
Wenn kein Thread _laufbereit_ ist, schaltet das OS den Prozessor in _Standby_.
Der Prozessor wird dann durch den nächsten _Interrupt_ wieder geweckt.
So wird erheblich _Energie gespart_. _Busy-Waits_ sind verpönt, weil sie das Umschalten
ins Standby verhindern.

=== Arten von Threads
- _I/O-lastig:_ Kommuniziert sehr häuftig mit I/O-Geräten und rechnet relativ wenig
  #hinweis[(USB, Tastatur, Speicher)]. Priorisieren _kurze Latenz_.
- _Prozessor-lastig:_ Kommuniziert kaum oder gar nicht mit I/O-Geräten und rechnet fast
  ausschliesslich. Priorisieren _mehr CPU-Zeit_.
Der Unterschied ist fliessend, aber gute Systeme _trennen rechen-intensive von
interaktiven Aktivitäten_. #hinweis[(I/O-Thread, UI-Thread etc.)]

=== Arten der Nebenläufigkeit
- _Kooperativ:_ Jeder Thread entscheidet selbst, wann er den Prozessor abgibt
  #hinweis[(Auch non-preemptive genannt)]
- _Präemptiv:_ Der Scheduler entscheidet, wann einem Thread der Prozessor entzogen wird
  #hinweis[(besseres System)]

*Präemptives Multithreading:* Der Thread läuft immer so lange weiter, bis er:
- Auf Ein-/Ausgabedaten, einen anderen Thread oder eine Ressource zu _warten_ beginnt,
  d.h. blockiert
- _freiwillig_ auf den Prozessor _verzichtet_ #hinweis[(yield)]
- ein _System-Timer-Interrupt_ auftritt
- ein anderer Thread _ready_ wird, der auf einen Event gewartet hat und _bevorzugt werden soll_
- ein neuer Prozess _erzeugt_ wird und _bevorzugt werden soll_

=== Parallele, quasiparallele und nebenläufige Ausführung
- _Parallel:_ Alle Threads laufen tatsächlich gleichzeitig, für $n$ Threads werden $n$
  Prozessoren benötigt.
- _Quasiparallel:_ $n$ Threads werden auf $<n$ Prozessoren _abwechselnd_ ausgeführt,
  sodass der Eindruck entsteht, dass sie parallel laufen würden.
- _Nebenläufig:_ Überbegriff für parallel oder quasiparallel; aus Sicht des Programmierers
  sind thread-basierte Programme meist nebenläufig.

#wrap-content(
  image("img/bsys_29.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  === Bursts
  - _Prozessor-Burst:_ Intervall, in dem ein Thread den Prozessor in einem parallelen
    System _voll belegt_, also vom Einrit in _running_ bis zum nächsten _waiting_.
  - _I/O-Burst:_ Intervall, in dem ein Thread den Prozessor _nicht_ benötigt,
    also vom Eintritt in _waiting_ bis zum nächsten _running_.
]
Jeder Thread kann als _Abfolge_ von _Prozessor-Bursts_ und _I/O-Bursts_ betrachtet werden.

== Scheduling-Strategien
Anforderungen an einen Scheduler können vielfältig sein.
_Geschlossene Systeme:_
Der Hersteller kennt alle Anwendungen und weiss, in welcher Beziehung sie zueinander
stehen #hinweis[(Router, TV Box)].
_Offene Systeme:_
Der Hersteller des OS muss von typischen Anwendungen ausgehen und dahin gehend optimieren.

*Anforderungen aus Sicht der Anwendung sind z.B. die Minimierung von:*
- _Durchlaufzeit (turnaround time):_ Zeit vom Starten des Threads bis zu seinem Ende
- _Antwortzeit (respond time):_ Zeit vom Empfang eines Requests bis die Antwort zur
  Verfügung steht
- _Wartezeit (waiting time):_ Zeit, die ein Thread in der Ready-Queue verbringt

*Anforderungen aus Sicht des Systems sind z.B. die Maximierung von:*
- _Durchsatz (throughput):_ Anzahl Threads, die pro Intervall bearbeitet werden
- _Prozessor-Verwendung (processor utilization):_ Prozentsatz der Verwendung des
  Prozessors gegenüber der Nichtverwendung

Grundsätzlich können Scheduler _nicht_ auf _alle Anforderungen gleichzeitig optimiert_
werden. Es gibt _keinen optimalen Scheduler_ für _alle_ Systeme. Die Wahl des Schedulers
hängt vom Einsatzzweck ab.

=== Beispiel Utilization und Antwortzeit
_Latenz_ ist die durchschnittliche Zeit zwischen Auftreten und vollständigem Verarbeiten
eines Ereignisses. Im schlimmsten Fall tritt das Ereignis dann auf, wenn der Thread gerade
vom Prozessor entfernt wurde. Um die Antwortzeit zu verringern, muss jeder Thread öfters
ausgeführt werden, was jedoch zu mehr Thread-Wechsel und somit zu mehr Overhead führt.
_Die Utilization nimmt also ab, wenn die Antwortzeit verringert wird._

#wrap-content(
  image("img/bsys_30.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  === Idealfall: Parallele Ausführung #hinweis[($bold(n)$ Threads auf $bold(n)$ Prozessoren)]
  Jeder Thread kann seinen Prozessor immer dann verwenden, wenn er ihn braucht.
  In der Praxis _unrealistisch_, es gibt immer mehr Threads als Prozessoren.
  Dient als _idealisierte Schranke_ für andere Scheduling-Strategien.
]

#wrap-content(
  image("img/bsys_31.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  === FCFS-Strategie #hinweis[(First Come, First Served)]
  Threads werden in der Reihenfolge gescheduled, in der sie der Ready-Queue hinzugefügt
  werden. _Nicht präemptiv:_ Threads geben den Prozessor nur ab, wenn sie auf waiting wechseln
  oder sich beenden. Die durchschnittliche Wartezeit hängt von der Reihenfolge
  des Eintreffens der Threads ab. Wird der längste Prozessor-Burst zuerst bearbeitet,
  warten die kürzeren Threads länger.
]
#wrap-content(
  image("img/bsys_32.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  === SJF-Strategie #hinweis[(Shortest Job First)]
  Scheduler wählt den Thread aus, der den _kürzesten_ Prozessor-Burst hat.
  Bei gleicher Länge wird nach FCFS ausgewählt. Kann _kooperativ_ oder _präemptiv_ sein.
  Ergibt _optimale Wartezeit:_ Der kürzeste Prozessor-Burst blockiert die anderen Threads minimal.\
  Kann nur _korrekt implementiert_ werden, wenn die Länge der Bursts _bekannt_ sind.
  Kann sonst nur mit einer _Abschätzung historischer Daten annähernd_ implementiert werden.
]
#wrap-content(
  image("img/bsys_33.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  === Round-Robin-Scheduling
  Der Scheduler definiert eine _Zeitscheibe_ von etwa 10 bis 100ms. Das Grundprinzip folgt
  _FCFS_, aber ein Thread kann nur solange laufen, bis seine _Zeitscheibe erschöpft_ ist,
  dann wird der in der _Ready-Queue hinten angehängt_. Benötigt er nicht den gesamten
  Time-Slice, beginnt die Zeitscheibe des nächsten Threads entsprechend früher.
  Die _Wahl der Zeitscheibe beeinflusst das Verhalten_ massiv.
]

=== Prioritäten-basiertes Scheduling
Jeder Thread erhält _eine Nummer_, seine _Priorität_. Threads mit höherer Priorität werden
vor Threads mit niedriger Priorität ausgewählt. Threads mit gleicher Priorität werden nach
FCFS ausgewählt. SJF ist ein Spezialfall davon: kurzer nächster Prozessor-Burst entspricht
hoher Priorität. Prioritäten je nach OS z.B. von 0 bis 7 oder von 0 bis 4096.
Auf manchen OS ist 0 die höchste, auf anderen die niedrigste Priorität. Chaos ensues.

==== Starvation
Ein Thread mit _niedriger Priorität_ kann _unendlich lange nicht laufen_, weil immer
Threads mit _höherer Priorität_ laufen.
Abhilfe z.B. mit _Aging:_ in bestimmten Abständen wird die Priorität um 1 erhöht.

=== Multi-Level Scheduling
Threads werden nach bestimmten Kriterien in verschiedene _Level_ aufgeteilt,
z.B. Priorität, Prozesstyp, Hintergrund- oder Vordergrund. Für jedes Level gibt es eine
_eigene Ready-Queue_. Jedes Level kann nach einem eigenen Verfahren geschedulet werden,
z.B. Queues gegeneinander priorisieren #hinweis[(Threads in Queues mit _höherer Priorität_
werden _immer_ bevorzugt)] oder Time-Slices pro Queue
#hinweis[(80% für UI-Queue mit Round-Robin, 20% für Hintergrund-Queue mit FCFS)].

#wrap-content(
  image("img/bsys_34.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  === Multi-Level Scheduling mit Feedback
  Je Priorität eine Ready-Queue. Threads aus Ready-Queues mit _höherer Priorität_ werden
  _immer_ bevorzugt. Erschöpft ein Thread seine Zeitscheibe, wird seine Priorität um 1
  verringert. Typischerweise werden die Zeitscheiben mit _niedrigerer_ _Priorität_
  _grösser_ und Threads mit _kurzen Prozessor-Bursts bevorzugt_.
  Threads in tiefen Queues dürfen zum Ausgleich länger am Stück laufen.
]
== Prioritäten in POSIX
=== #link("https://www.youtube.com/watch?v=UBX8MWYel3s")[Der Nice-Wert]
Jeder Prozess $p$ hat einen Nice-Wert $n_p$ #hinweis[(in Linux jeder Thread)].
Dieser geht von $-20$ bis zu $+19$ und ist ein Hinweis ans System:
- Soll $p$ _bevorzugen_, wenn $n_p$ _kleiner_ ist #hinweis[($p$ ist weniger nett)]
- Soll $p$ _weniger_ oft laufen lassen, wenn $n_p$ _grösser_ #hinweis[($p$ ist netter)]

==== Nice-Wert beim Start erhöhen oder verringern: ```sh nice [-n increment] utility [argument...]```
Startet `utility` #hinweis[($u$, mit den optionalen Argumenten)] mit möglicherweise
_anderem Nice-Value_ als der aufrufende Prozess $p$.
Wenn kein `increment` angegeben: $n_u >= n_p$.
Wenn `increment` ($i$) angegeben: $n_u = n_p + i$

==== Nice-Wert im Prozess erhöhen oder verringern: ```c int nice (int i)```
Addiert `i` zum Nice-Wert des aufrufenden Prozesses $p$.
Gibt $n_p$ zurück oder $-1$, wenn Fehler. Da $-1$ aber auch ein gültiger Nice-Wert ist,
muss man den Fehler wie folgt abfragen:
```c
errno = 0; // reset errno
if (nice(i) == -1 && errno != 0) { /* Errror */ } else { /* -1 is nice value */ }
```

==== Nice-Wert im Prozess abfragen oder setzen: ```c int getpriority``` / ```c int setpriority```
```c int getpriority (int which, id_t who)``` gibt den Nice-Wert von $p$ zurück\
```c int setpriority (int which, id_t who, int prio)``` setzt den Nice-Wert
von $p$ auf $n$. Gibt 0 zurück wenn OK, sonst -1 und Fehlercode in `errno`.

Spezifiziert Prioriät für einzelnen Prozess, Prozessgruppe oder alle Prozesse eines Users.
- _`which`:_ `PRIO_PROCESS`, `PRIO_PGRP` oder `PRIO_USER`
- _`who`:_ ID des Prozesses, der Gruppe oder des Users

==== Priorität bei Threads setzen: ```c ...schedparam```
```c int pthread_getschedparam(pthread_t thread, int * policy, struct sched_param * param)```\
```c int pthread_setschedparam(pthread_t thread, int policy, const struct sched_param * param)```\
```c int pthread_attr_getschedparam(const pthread_attr_t * attr, struct sched_param * param)```\
```c int pthread_attr_setschedparam(pthread_attr_t * attr, const struct sched_param * param)```

Die Priorität kann während der Thread läuft mit den regulären Funktionen, vor dem
Threadstart mit den `attr`-Funktionen gesetzt werden. Attribute eines Threads enthalten
ein _`struct sched_param`_. Dieser kann vom Thread oder seinen Attributen _abgefragt_
werden. Enthält ein Member `sched_priority`, das die _Priorität_ bestimmt.

==== Priorität bei Thread-Erzeugung setzen
```c
pthread_attr_t a;
pthread_attr_init (&a);

struct sched_param p;
pthread_attr_getschedparam ( &a, &p ); // read parameter
// set p.sched_priority
pthread_attr_setschedparam ( &a, &p );
pthread_create ( &id, &a, thread_function, argument );
pthread_attr_destroy ( &a ); // destroy attributes
```