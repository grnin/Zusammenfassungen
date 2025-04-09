#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de"
)*/

= Mutexe und Semaphore
Jeder Thread hat seinen _eigenen_ Instruction-Pointer und Stack-Pointer.
Die IPs aller Threads werden _unabhängig_ voneinander bewegt. Bei parallelen Threads
völlig unabhängig und _nicht synchron_, selbst bei identischem Code. Bei nebenläufigen
Threads auf dem selben Prozessor immer in Bursts bis zum nächsten Thread-Wechsel.

== Synchronisations-Mechanismen Grundlagen
Ein Thread erzeugt Items: _der Producer_.
Ein anderer Thread verarbeitet diese: _der Consumer_.
Beide Threads arbeiten _unterschiedlich schnell_. Items werden über einen _begrenzt
grossen Ring-Puffer_ übermittelt.
Falls der Puffer voll ist, muss der Producer warten, bevor er wieder etwas auf den Puffer
legen kann. Gleichermassen muss der Consumer warten, falls der Puffer leer ist.

Da C für _keine noch so kleine Operation garantiert_, dass sie in eine
_einzige Instruktion_ übersetzt wird #hinweis[(non-atomic)], wird dieses Problem eine
_Race-Condition_ auslösen.

=== Race-Condition
Wenn Ergebnisse von der _Ausführungsreihenfolge_ einzelner Instruktionen abhängen, spricht
man von einer _Race Condition_. Register werden beim Kontext-Wechsel gesichert,
der Counter aber nicht. Greifen _nebenläufige Threads_ schreibend und lesend auf den
_gleichen Hauptspeicherbereich_ zu, gibt es _keine Garantien_, was passieren wird.
Wenn die Änderung nicht schnell genug erfolgt, bekommt sie der andere Thread nicht mit,
während er selbst Änderungen vornimmt. Ein Thread muss andere Threads vom Zugriff
ausschliessen können - _Threads müssen synchronisiert werden_.

=== Critical Sections
Jeder kooperierende Thread hat einen Code-Bereich, in dem er Daten mit anderen Threads
teilt, die _Critical Section_. Es wird ein _Protokoll_ benötigt, anhand dessen Threads den
Zugang zu ihren Critical Sections _synchronisieren_ können.

=== Atomare Instruktionen
Eine atomare Instruktion kann vom Prozessor _unterbrechungsfrei_ ausgeführt werden.\
#hinweis[*Achtung:* Selbst einzelne Assembly-Instruktionen können unter Umständen nicht
  atomar durchgeführt werden, z.B. non-aligned Memory Access]

=== Anforderungen an Synchronisations-Mechanismen
- _Gegenseitiger Ausschluss:_ Wenn ein Thread in seiner Critical Section ist, dürfen alle
  anderen Threads ihre Critical Section nicht betreten. #hinweis[(mutual exclusion, mutex)]
- _Fortschritt:_ Wenn kein Thread in seiner Critical Section ist und irgendein Thread in
  seine Critical Section möchte, muss in endlicher Zeit eine Entscheidung getroffen
  werden, wer als nächstes in die Critical Section darf.
- _Begrenztes Warten:_ Es gibt eine feste Zahl $n$, sodass gilt: Wenn ein Thread seine
  Critical Section betreten will, wird er nur $n$-mal übergangen.

=== Implementierung von Synchronisations-Mechanismen
Moderne Computer-Architekturen geben _kaum Garantien_ bezüglich der Ausführung von
Instruktionen. Instruktionen müssen _nicht atomar_ sein, Sequenzen können äquivalent
_umgeordnet_ werden. Synchronisations-Mechanismen können auf modernen Computern
_nur mit Hardwareunterstützung_ implementiert werden.

==== Konzept: Abschaltung von Interrupts
Alle Interrupts werden abgeschaltet, wenn eine _Critical Section betreten_ werden soll.
Auf Systemen mit _einem Prozessor effektiv_, weil es zu keinem Kontext-Wechsel kommen kann.
Für Systeme mit _mehreren Prozessoren_ jedoch _nicht praktikabel_, da Interrupts für alle
Threads ausgeschaltet werden müssten.
_Generell gefährlich:_ Solange die Interrupts ausgeschaltet sind, kann das OS den Thread
nicht unterbrechen.

==== Verwendung spezieller Instruktionen
Moderne Prozessoren stellen eine von zwei _atomaren_ Instruktionen zur Verfügung, mit
denen _Locks_ implementiert werden können:
- _Test-And-Set:_ Setzt einen `int` auf 1 und returnt den vorherigen Wert
- _Compare-And-Swap:_ Das gleiche, aber in Fancy: überschreibt einen `int` mit einem
  spezifizierten Wert, wenn dieser dem erwarteten Wert entspricht.

*Test-And-Set:*
Liest den Wert von einer Adresse (0 oder 1) und setzt ihn dann auf 1.
```c
test_and_set (int * target) { int value = *target; *target = 1; return value; }

int lock = 0;
// T1: sets lock = 1 & reads 0, T2 sets lock = 1, but reads 1
while (tas (&lock) == 1) { /* busy loop */ }
/* critical section */
lock = 0;
```

*Compare-And-Swap*:
_Liest_ einen Wert aus dem Hauptspeicher und _überschreibt_ ihn im Hauptspeicher,
falls er einem _erwarteten Wert_ entspricht.

```c
compare_and_swap (int *a, int expected, int new_a) {
  int value = *a;
  if (value == expected) { *a = new_a; }
  return value;
}

while (cas (&lock, 0, 1) == 1) { /* busy loop */ }
/* critical section */
lock = 0;
```
Kommen zwei Threads $T_1$ und $T_2$ genau gleichzeitig an die `while`-Schleife, garantiert
die Hardware, dass _nur $bold(T_1)$ `test_and_set`_ bzw. _`compare_and_swap`_ ausführt.
$T_1$ setzt `lock` auf 1, liest aber 0 und _verlässt_ die Schleife sofort.\
$T_2$ sieht `lock` auf jeden Fall als 1 und _bleibt_ in der Schleife.

#pagebreak()

== Semaphore
Ein Semaphore enthält einen _Zähler $bold(z >= 0)$_. Auf den Semaphor wird nur über
spezielle Funktionen zugegriffen:
- _Post (v):_ Erhöht $z$ um 1
- _Wait (p):_ Wenn $z > 0$, verringert $z$ um $1$ und setzt Ausführung fort.
  Wenn $z=0$, versetzt den Thread in waiting, bis ein anderer Thread $z$ erhöht.

=== Producer-Consumer-Problem mit Semaphoren
Der _Producer_ wartet darauf, dass mindestens ein Element _frei_ ist.
Der _Consumer_ wartet darauf, dass mindestens ein Element _gefüllt_ ist.
Dafür verwenden wir _zwei Semaphore_.
Die Consumer und Producer geben sich diese gegenseitig frei.
```c
semaphore free = n;
semaphore used = 0;
```
#columns(2)[
  ```c
  // Producer
  int w = 0; // Index auf zuletzt geschr. Elem.
  while (1) {
    // Warte, falls Customer zu langsam
    WAIT (free); // Hat es Platz in Queue?
    produce_item (&buffer[w], ...);
    POST (used); // 1 Element mehr in Queue
    w = (w+1) % BUFFER_SIZE;
  }
  ```
  #colbreak()
  ```c
  // Consumer
  int r = 0; // Index auf zu lesendes Elem.
  while (1) {
    // Warte, falls Producer zu langsam
    WAIT (used); // Hat es Elemente in Queue?
    consume (&buffer[r]);
    POST (free); // 1 Element weniger in Queue
    r = (r+1) % BUFFER_SIZE;
  }
  ```
]


=== ```c int sem_init (sem_t *sem, int pshared, unsigned int value);```
_Initialisiert den Semaphor `sem`_, sodass er `value` Marken enthält
#hinweis[(max. Grösse der Queue)]. Ist `pshared = 0`, kann `sem` nur innerhalb eines
Prozesses verwendet werden, ansonsten über mehrere.

==== Anwendung als globale Variable
Typischerweise legt man im Programm eine _globale Variable_ `sem` vom Typ `sem_t` an.
_Bevor_ der erste Thread gestartet wird, der `sem` verwenden soll, wird _`sem_init`_
aufgerufen, z.B. im `main()`.

```c
sem_t sem;
int main ( int argc, char ** argv ) { sem_init (&sem, 0, 4); }
```

==== Anwendung als Parameter für den Thread
Alternativ definiert man im Struct, das dem Thread übergeben wird, einen Member `sem` vom
Typ `sem_t *`.\
Der Speicher für den Semaphor wird dann entweder auf dem Stack oder auf dem Heap alloziert.

```c
struct T { sem_t *sem; ... };
int main ( int argc, char ** argv ) {
  sem_t sem;
  sem_init (&sem, 0, 4);
  struct T t = { &sem, ... };
}
```

=== `sem_wait` und `sem_post`
```c int sem_wait (sem_t *sem); int sem_post (sem_t *sem);```
implementieren _Post_ und _Wait_. Geben 0 zurück, wenn Aufruf OK, sonst -1 und Fehlercode
in `errno`. Im _Fehlerfall_ wird der Semaphor _nicht verändert_.

=== `sem_trywait` und `sem_timedwait`
```c
int sem_trywait (sem_t *sem);
int sem_timedwait (sem_t *sem, const struct timespec *abs_timeout);
```
Sind wie `sem_wait`, aber _brechen ab_, falls Dekrement _nicht_ durchgeführt werden kann.
`sem_trywait` bricht sofort ab, `sem_timedwait` nach der angegebenen Zeitdauer.
Es gibt kein `sem_trypost`.

=== ```c int sem_destroy (sem_t *sem);```
_Entfernt_ möglichen zusätzlichen _Speicher_, den das OS mit `sem` _assoziiert_ hat.

#pagebreak()

== Mutexe
Ein Mutex hat einen _binären Zustand $bold(z)$_, der nur durch zwei Funktionen verändert werden kann:
- _Acquire:_ Wenn $z = 0$, setze $z$ auf 1 und fahre fort.
  Wenn $z = 1$, blockiere den Thread , bis $z = 0$
- _Release:_ Setzt $z = 0$

Kann durch einen Semaphor mit _Beschränkung_ von $z$ auf 1 realisiert werden.
Acquire und Release heissen auch _Lock_ bzw. _Unlock_.

Ein Mutex ist die _einfachste Form_ der Synchronisierung.
Acquire und Release müssen immer paarweise durchgeführt werden.
```c ACQUIRE(mutex); ++counter; RELEASE(mutex);```

=== POSIX Thread Mutex API
==== ```c int pthread_mutex_init(pthread_mutex_t *mutex, const pthread_mutexattr_t *attr);```
_Initialisiert_ die opake Daten-Struktur _`pthread_mutex_t`_.
Attribute sind _optional_, Verwendung analog zu `pthread`-Attributen mit
`pthread_mutexattr_init, ..._destroy`.\
_Attribute:_
- `protocol`: z.B. `PTHREAD_PRIO_INHERIT`: Mutex verwendet Priority-Inheritance,
- `pshared`: Mutex kann von anderen Prozessen verwendet werden,
- `type`: Mutex kann beliebig oft vom selben Thread aquiriert werden,
- `prioceiling`: Minimale Priorität der Threads, die den Mutex halten.

```c
int pthread_mutex_lock (pthread_mutex_t *mutex);    // acquire (blocking)
int pthread_mutex_trylock (pthread_mutex_t *mutex); // attempt to acquire (non-blocking)
int pthread_mutex_unlock (pthread_mutex_t *mutex);  // release
int pthread_mutex_destroy (pthread_mutex_t *mutex)  // cleanup
```

#grid(
  columns: (0.9fr, 1fr),
  gutter: 1em,
  [
    ```c
    // Beispiel Initialisierung
    pthread_mutex_t mutex; // global variable
    int main() {
      // 0 = default Attribute
      pthread_mutex_init (&mutex, 0);
      // run threads and wait for them to finish
      pthread_mutex_destroy (&mutex);
    }
    ```
  ],
  [
    ```c
    // Beispiel Verwendung in Threads
    void * thread_function (void * args) {
      while (running) {
        ...
        // Enter critical section
        pthread_mutex_lock (&mutex);
        // Perform atomic action, e.g. ++counter
        // Leave critical section
        pthread_mutex_unlock (&mutex);
        ...
      }
    }
    ```
  ],
)

#wrap-content(
  image("img/bsys_35.png"),
  align: top + right,
  columns: (75%, 25%),
)[
  === Priority Inversion und Priority Inheritance
  - Thread $A$ hat _niedrige Priorität_ und hält einen Mutex $M$
  - Thread $B$ hat _mittlere Priorität_
  - Thread $C$ hat _hohe Priorität_ und läuft gerade.
    Nach 10ms benötigt Thread $C$ den Mutex $M$.

  Ein _hoch-priorisierter_ Thread wartet auf eine Ressource, die von einem _niedriger
  priorisierten_ Thread _gehalten_ wird. Ein Thread mit Prioriät zwischen diesen beiden
  Threads erhält den Prozessor. Die effektiven Prioritäten des hoch-priorisierten und des
  mittel-priorisierten Threads sind _invertiert_ gegenüber den zugewiesenen Prioritäten.
  _Gemeinsam verwendete Ressourcen werden bei Prioritiy Inversion im schlimmsten Fall mit
  der niedrigsten Priorität aller beteiligten Threads gehalten._
]
#wrap-content(
  image("img/bsys_36.png"),
  align: top + right,
  columns: (75%, 25%),
)[
  Um dieses Problem zu lösen, wird bei Priority Inheritance die _Priorität von $bold(A)$
  temporär auf die Priorität von $bold(C)$ gesetzt_, damit der Mutex schnell wieder
  freigegeben wird. $A$ läuft, bis er den Mutex $M$ freigibt, danach erhält $A$ wieder die
  vorherige Priorität und $C$ läuft weiter.
]
