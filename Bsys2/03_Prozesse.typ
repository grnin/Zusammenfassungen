// Compiled with Typst 0.12
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

#let wait = ```c wait()```

= Prozesse
Wenn ein Prozessor nur ein einziges Programm ausführt, laufen auf ihm _nur zwei
Software-Akteure:_ Das _Programm_ und das _Betriebssystem_.

Dieses System nennt man Monoprogrammierung: _Kommunikation_ vom Programm zum OS auf
SW-Ebene über _C-Funktionsaufrufe_. Das Programm _kennt nur sich selbst_ und das OS.

Moderne Prozessoren bieten _genügend Rechenleistung_, um _viele Programme_ gleichzeitig
ausführen zu können. All diese Programme müssen _gleichzeitig_ im Hauptspeicher sein.
OS muss jedem Programm _nacheinander_ (nicht gleichzeitig) Zeit auf dem Prozessor
zuweisen. Das OS benötigt eine _Verwaltungseinheit_ für Programme, die laufen sollen:
_den Prozess_.

Die _Monoprogrammierung_ soll jedoch erhalten bleiben. Aufgabe des OS ist es, Programme
voneinander zu _isolieren_. Jedem Prozess ist ein _virtueller Adressraum_ zugeordnet.

#wrap-content(
  image("img/bsys_9.png"),
  align: top + right,
  columns: (85%, 13%),
)[
  == Grundlagen
  Ein Prozess umfasst:
  - Das _Abbild eines Programms_ im Hauptspeicher #hinweis[text section]
  - die _globalen Variablen des Programms_ #hinweis[data section]
  - Speicher für den _Heap_
  - Speicher für den _Stack_

  === Prozess vs Programm
  - Ein _Programm_ ist _passiv_: beschreibt bestimmte Abläufe #hinweis[(wie ein Rezept)]
  - Ein _Prozess_ ist _aktiv_: führt Abläufe aus #hinweis[(das Kochen des Rezeptes)]
]

Ein Programm kann als verschiedene, voneinander unabhängige Prozesse _mehrfach_ ausgeführt
werden. Unter POSIX kann ein Prozess mehrere Programme _nacheinander_ ausführen.

#pagebreak()

== Betriebssystemsicht
Das Betriebssystem hält Daten über jeden Prozess in jeweils einem
_Process Control Block (PCB)_ vor.

#wrap-content(
  image("img/bsys_10.png"),
  align: bottom + right,
  columns: (75%, 25%),
)[
  === Process Control Block (PCB)
  Speicher für alle Daten, die das OS benötigt, um die Ausführung des Prozesses ins
  Gesamtsystem zu integrieren, u.a.:
]
- Eigene _Process ID_, Parent ID und andere wichtige IDs
- Speicher für den _Zustand_ des Prozessors #hinweis[(Prozesskontext)]
- _Scheduling-Informationen_ #hinweis[(welcher Prozess ist wann an der Reihe)]
- Daten zur _Synchronisation_ und _Kommunikation_ zwischen Prozessen
- _Dateisystem-relevante_ Informationen #hinweis[(z.B. offene Dateien)]
- _Security-Informationen_ #hinweis[(Prozess selber sieht diese nicht)]

=== Interrupts und Prozesse
Wenn ein Interrupt auftritt, muss der _Kontext_ des aktuellen Prozesses im dazugehörigen
PCB gespeichert werden #hinweis[(context save)]:
Register, Flags, Instruction Pointer, MMU-Konfiguration

Dann wird der _Interrupt-Handler_ aufgerufen, der je nach Bedarf den Kontext
_komplett überschreiben_ kann. Nach dem Ende des Interrupt-Handlers wird der Kontext des
Prozesses aus seinem PCB _wiederhergestellt_ #hinweis[(context restore)].

_Ablauf eines Kontext-Wechsels:_ OS sichert Kontext von Prozess $A$ im PCB $A$ und stellt
den Kontext von Prozess $B$ aus dem PCB $B$ wieder her.
Nach Rücksprung aus dem Interrupt-Handler läuft somit Prozess $B$ statt $A$.

=== Prozess-Erstellung
Um aus einem Programm einen Prozess zu machen, muss das OS _einen Prozess erzeugen_ und
_ein Programm in diesen Prozess laden_. Unter POSIX sind beide Schritte getrennt, unter
Windows finden beide in einer einzigen Funktion statt.

#wrap-content(
  image("img/bsys_11.png"),
  align: bottom + right,
  columns: (85%, 15%),
)[
  === Prozess-Hierarchie
  In POSIX hat jeder Prozess ausser Prozess 1 genau _einen_ Parent-Prozess.
  Jeder Prozess kann _beliebig viele_ Child-Prozesse haben.
  Dadurch wird eine _Baum-Struktur_ definiert: Die _Prozess-Hierarchie_.
  Diese kann mit dem Tool `pstree` angezeigt werden.
]

== Prozess API
=== Die Funktion `fork()`
```c pid_t fork(void)``` erzeugt eine _exakte Kopie_ (Child $C$) des Prozesses
(Parent $P$), aber: $C$ hat eine _eigene Prozess-ID_ und als _Parent-Prozess-ID_ die ID
von $P$. Die Funktion führt in _beiden_ Prozessen den Code an derselben Stelle fort:
Am Rücksprung aus `fork`.

#let fork-code = ```c
pid_t new_pid = fork();

if (new_pid > 0) {
  // code running in parent
} else if (new_pid == 0) {
  // code running in child
}
```

#wrap-content(
  fork-code,
  align: bottom + right,
  columns: (64%, 36%),
)[
  - In $P$ bei _Erfolg_: Gibt die Prozess-ID von C zurück (> 0)
  - In $P$ bei _Misserfolg_: Gibt -1 zurück und Fehlercode in `errno`
  - In $C$: Gibt 0 zurück
]

=== Die Funktion `exit()`
```c void exit(int code)``` entspricht dem gleichnamigen Betriebssystem-Aufruf.
Kann an jeder Stelle im Programm verwendet werden und bietet somit eine Alternative zum
"Rücksprung" aus ```c main()```. Springt nie zurück, sondern _beendet das Programm_.
`code` ist der Code, der am Ende des Prozesses zurückgegeben wird
#hinweis[(return/exit value des Programms)].

=== Die Funktion `wait()`
```c pid_t wait(int *status)``` unterbricht den Prozess, bis einer seiner Child-Prozesse
beendet wurde. Gibt die Statusinformationen über den `int` zurück, auf den `status` zeigt
#hinweis[(Out-Parameter)]. Der Status wird durch Macros aus dem Header
```c <sys/wait.h>``` abgefragt:

- _`WIFEXITED(*status)`:_ `!= 0`, wenn Child ordnungsgemäss beendet wurde.
  #hinweis[(wait-if)]
- _`WEXITSTATUS(*status)`:_ Exit-Code von Child

Gibt -1 zurück, wenn ein Fehler auftritt, Fehlercode in `errno`.
`ECHILD`: Hat kein Child mehr, um darauf zu warten.
`EINTR`: Wurde von einem Signal unterbrochen.

=== Die Funktion `waitpid()`
```c pid_t waitpid (pid_t pid, int *status, int options)``` ist wie #wait, aber `pid`
bestimmt, auf welchen Child-Prozess man warten will.
- _`pid > 0`:_ Wartet nur auf den Child-Prozess mit dieser `pid`
- _`pid == -1`:_ Wartet auf irgendeinen Child-Prozess (= #wait)
- _`pid == 0`:_ wartet auf alle Child-Prozesse welche diesselbe Prozessgruppen-ID wie der
  Parent haben
- _`pid < -1`:_ wartet auf alle Child-Prozesse welche diesselbe Prozessgruppen-ID wie der
  absolute `pid`-Wert haben

Gibt -1 zurück, wenn ein Fehler auftritt, Fehlercode in `errno`.
`ECHILD`: Hat kein Child mehr, um darauf zu warten.
`EINTR`: Wurde von einem Signal unterbrochen.

=== Zusammenspiel von `fork()` und `wait()`
#image("img/bsys_12.png")

```c
void spawn_worker (...) {
  if (fork() == 0) {
    // ... do something in worker process
    exit(0); // exit from worker process
  }
}
for (int i = 0; i < n; ++i) {
  spawn_worker(...);
}
// ... do something in parent process
do { pid = wait(0); } while (pid > 0 || errno != ECHILD); // wait for all children
```

=== `exec()`-Funktionen
Es gibt 6 `exec()`-Funktionen: `execl()`, `execle()`, `execlp()`, `execv()`, `execve()`, `execvp()`.
Jede `exec`-Funktion _ersetzt_ im gerade laufenden Prozess das Programmimage
_durch ein anderes Programmimage_.

Bei jeder `exec`-Funktion müssen die _Programmargumente spezifiziert_ werden.
- _Bei den `execl*`-Funktionen als Liste_
  #hinweis[(`l` für Liste)]: `execl(path, arg0, arg1, ...)`
- _Bei den `execv*`-Funktionen als Array_
  #hinweis[(`v` für Vektor/Array)]: `execv(path, argv)`

_Die `exec*e`-Funktionen_ erlauben die _Angabe eines Arrays_ für die _Umgebungsvariabeln_,
in den anderen Versionen bleiben die Umgebungsvariablen gleich.

_Die `exec*p`-Funktionen_ suchen den _Dateinamen_ über die Umgebungsvariable _`PATH`_,
die anderen verwenden absolute/relative Pfade.

#table(
  columns: (auto, 1fr, auto, auto),
  table.header(
    [],
    [],
    [Programmargumente\ als Liste],
    [Programmargumente\ als Array],
  ),
  table.cell(rowspan: 2)[Angabe des Pfads],
  [mit neuem Environment],
  [`execle()`],
  [`execve()`],
  table.cell(rowspan: 2)[mit altem Environment],
  [`execl()`],
  [`execv()`],
  [Suche über `PATH`],
  [`execlp()`],
  [`execvp()`]
)

=== Zusammenspiel von `fork()`, `exec()` und `wait()`
#image("img/bsys_13.png")

=== Zombie-Prozess
#wrap-content(
  image("img/bsys_14.png"),
  align: top + right,
  columns: (40%, 60%),
)[
  Wenn ein Prozess $C$ _beendet_ wird, ist sein Parent-Prozess $P$ verantwortlich dafür,
  _auf jeden Fall_ #wait aufzurufen. Das OS weiss nicht, _wann_ das passieren wird.
  Das OS muss die Statusinformationen von $C$ solange vorhalten, bis $P$ #wait aufruft.
  _$C$ ist zwischen seinem Ende und dem Aufruf von #wait durch $P$ ein Zombie-Prozess_
  #hinweis[(tot, aber noch nicht entfernt)].

  _Dauerhafter Zombie-Prozess:_ Bleibt ein Prozess $C$ längere Zeit ein Zombie, bedeutet
  das, dass sein Parent $P$ #wait längere Zeit nicht aufruft.
  Vermutlich hat $P$ einen Fehler. Die Situation kann bereinigt werden, indem $P$ gestoppt
  wird und $C$ somit an Prozess 1 übertragen wird.
]

=== Orphan-Prozess
#wrap-content(
  image("img/bsys_15.png"),
  align: top + right,
  columns: (40%, 60%),
)[
  Wird ein Prozess $P$ _beendet_, haben seine Child-Prozesse $C$ keinen Parent-Prozess
  mehr. Sie _verwaisen_ und werden zu _Orphan-Prozessen_. $P$ kann nicht mehr seiner
  Verantwortung nachkommen und auf $C$ warten. $C$ würden bei ihrem Ende zu
  _dauerhaften Zombie-Prozessen_ und würden nie entfernt werden.

  Damit das nicht passiert, werden beim Ende eines Prozesses $P$ all seine Child-Prozesse
  an den Prozess mit der `pid=1` _übertragen_. Dieser Prozess ruft in einer
  _Endlosschleife_ #wait auf und beendet somit alle ihm übertragenen Orphan-Prozesse.
]

=== Die Funktion `sleep()`
```c unsigned int sleep (unsigned int seconds)``` unterbricht die Ausführung, bis die
Anzahl der Sekunden _ungefähr_ verstrichen ist.
Kann vom _System auch unterbrochen werden_.
Gibt die Anzahl Sekunden zurück, die vom Schlaf noch verblieben sind.

=== Die Funktion `atexit()`
```c int atexit (void (*function)(void))``` dient dazu, dass ein Programm kurz vor seinem
Ende letzte _Aufräumarbeiten_ durchführen kann. Diese Aufräum-Funktionen werden dann nach
einem Aufruf von `exit` in _umgekehrter Reihenfolge der Registrierung_ aufgerufen.
#hinweis[(Funktionen werden also von unten nach oben ausgeführt)]

=== Funktionen zum Lesen von PIDs
```c pid_t getpid(void)``` und ```c pid_t getppid(void)``` geben die Prozess-ID des
aufrufenden Prozesses bzw. seines Parent-Prozesses zurück.

```c
int main() {
  pid_t my_pid = getpid();
  pid_t my_parent_pid = getppid();
  printf("I am %d, my parent is %d\n", my_pid, my_parent_pid);
}
```
