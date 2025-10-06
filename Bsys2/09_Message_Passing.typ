#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

/* #show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de"
) */

= Message Passing und Shared Memory
Prozesse sind voneinander _isoliert_, müssen jedoch trotzdem miteinander _interagieren_.\
*Beispiel Chrome Browser:*
Jede Seite wird durch einen eigenen Prozess gerendert, Seiten können sich _nicht_
gegenseitig _beeinflussen_. Ein weiterer Prozess stellt _GUI_ sowie Zugriffe auf
Filesystem und Netzwerk zur Verfügung.
Dies _reduziert_ Auswirkungen von _Security-Exploits_.

== Message-Passing / Message Queueing
Message-Passing ist ein Mechanismus mit zwei Operationen:
- _Send:_ Kopiert die Nachricht _aus_ dem Prozess: ```c send (message)```
- _Receive:_ Kopiert die Nachricht _in_ den Prozess: ```c receive (message)```
Dabei können Implementierungen nach verschiedenen Kriterien unterschieden werden:
- #link(<message-size>)[_Feste_ oder _Variable_ Nachrichtengrösse]
- #link(<message-direct>)[_Direkte_] oder
  #link(<message-indirect>)[_indirekte_] Kommunikation
- #link(<message-sync>)[_Synchrone_ oder _asynchrone_ Kommunikation]
- #link(<message-buffer>)[_Pufferung_]
- #link(<message-prio>)[Mit oder ohne _Prioritäten_ für Nachrichten]

#pagebreak()

=== Feste oder variable Nachrichtengrösse <message-size>
Message-Passing mit _fester Nachrichtengrösse_ ist _umständlicher zu verwenden_.
Benutzer muss bei _Überschreiten_ der Nachrichtengrösse selbst _Vorsorge treffen_,
um die Nachricht in kleinere Teilnachrichten aufzutrennen. Bei _Unterschreiten_ wird
Speicher _verschwendet_.\
Message-Passing mit _variabler Nachrichtengrösse_ ist _aufwändiger zu implementieren_.

=== Direkte Kommunikation - Senden <message-direct>
Bei direkter Kommunikation werden Nachrichten von einem Prozess $P_1$ an einen Prozess
$P_2$ adressiert. $P_1$ muss den Empfänger einer Nachricht kennen.
Kommunikation _nur zwischen genau zwei Prozessen_: ```c send(P2, message)```.

=== Direkte Kommunikation - Empfangen
- _Symmetrische direkte Kommunikation ```c receive(P1, message)```:_
  $P_2$ muss den Sender seiner Nachricht _kennen_
- _Asymmetrische direkte Kommunikation ```c receive(id, message)```:_
  $P_2$ muss den Sender seiner Nachricht _nicht_ kennen, sondern erhält
  die ID in einem Out-Parameter `id`:

=== Indirekte Kommunikation <message-indirect>
Bei indirekter Kommunikation existieren spezifische OS-Objekte: _Mailboxen, Ports oder Queues_.
- ```c send(Q, message)```: Prozess $P_1$ _sendet_ Nachrichten _an eine Queue_ $Q$
- ```c receive(Q, message)```: Prozess $P_2$ _empfängt_ Nachrichten _aus einer Queue_ $Q$
Kommunikation erfordert, dass beide Teilnehmer die _gleiche Mailbox kennen_.
Es kann _mehr als eine_ Mailbox zwischen zwei Teilnehmern geben.

==== Mehr als zwei Teilnehmer
Bei mehr als zwei Teilnehmer müssen Regeln definiert werden, welcher Prozess die Nachricht
empfängt, wie _Beschränkung_ der Queue auf nur einen Sender und Empfänger,
Beschränkung des Aufrufs von `receive()` auf nur einen Prozess, _zufällige Auswahl_ oder
Auswahl nach _Algorithmus_.

==== Lebenszyklus der Queue
- _Queue gehört einem Prozess:_ Queue lebt solange wie der Prozess
- _Queue gehört dem Betriebssystem:_ Queue existiert unabhängig von einem Prozess.
  OS muss Mechanismus zum Erzeugen und Löschen der Queue zur Verfügung stellen.

=== Synchronisation <message-sync>
Message-Passing kann _blockierend (synchron)_ oder _nicht-blockierend (asynchron)_ sein,
alle Kombinationen sind möglich:
- _Blockierendes Senden:_ Sender wird solange blockiert, bis die Nachricht vom Empfänger
  empfangen wurde
- _Nicht-blockierendes Senden:_ Sender sendet Nachricht und fährt sofort weiter
- _Blockierendes Empfangen:_ Empfänger wird blockiert, bis Nachricht verfügbar
- _Nicht-blockierendes Empfangen:_ Empfänger erhält Nachricht, wenn verfügbar, oder 0

==== Rendezvous
Sind Empfang und Versand _beide blockierend_, kommt es zum _Rendezvous_, sobald beide
Seiten ihren Aufruf getätigt haben #hinweis[(Sender weiss, dass Empfänger empfangen hat)].
OS kann eine _Kopieroperation sparen_ und _direkt_ vom Sende- in den Empfänger-Prozess
kopieren. _Impliziter Synchronisationsmechanismus_.

#columns(2, gutter: 0em)[
  ```c
  // Producer
  message msg;
  open (Q);
  while (1) {
    produce_next (&msg);
    send (Q, &msg); // blocked until sent
  }
  ```
  #colbreak()
  ```c
  // Consumer
  message msg;
  open (Q);
  while (1) {
    receive (Q, &msg); // blocked until received
    consume_next (&msg);
  }
  ```
]

#pagebreak()

=== Pufferung <message-buffer>
Je nach Nachrichten-Kapazität der Queue kann man drei Arten des Pufferung unterscheiden:
- _Keine:_ Queue-Länge ist 0, keine Nachrichten können gespeichert werden,
  Sender muss blockieren
- _Beschränkte:_ Maximal $n$ Nachrichten können gespeichert werden.
  Sender blockiert erst, wenn Queue voll ist.
- _Unbeschränkte:_ Beliebig viele Nachrichten passen in die Queue, Sender blockiert nie

=== Prioritäten <message-prio>
In manchen Systemen können Nachrichten mit _Prioritäten_ versehen werden.
Der Empfänger holt die Nachricht mit der _höchsten Priorität zuerst_ aus der Queue.

=== POSIX Message-Passing
OS-Message-Queues mit _variabler Länge_, haben mind. 32 Prioritäten und können
_synchron und asynchron_ verwendet werden.
==== ```c mqd_t mq_open (const char *name, int flags, mode_t mode, struct mq_attr *attr);```
_Öffnet eine Message-Queue_ mit systemweitem `name` und gibt einen
_Message-Queue-Descriptor_ zurück.
- _`name`_ sollte immer mit "`/`" beginnen und sonst keine "`/`" enthalten
- _`flags`:_
  `O_RDONLY` für read-only,
  `O_RDWR` für lesen und schreiben,
  `O_CREAT` erzeugt Queue, falls sie nicht existiert und
  `O_NONBLOCK` definiert, dass `send` und `receive` nicht blockieren
- _`mode`:_ Legt Zugriffsberechtigungen fest: `S_IRUSR` | `S_IWUSR`
- _`struct mq_attr`:_ Beinhaltet Flags, maximale Anzahl Nachrichten in Queue,
  maximale Nachrichtengrösse und Anzahl der Nachrichten, die aktuell in der Queue sind.
  Lesen/Schreiben mit `mq_getatrr()`/`mq_setattr()`.

==== ```c int mq_close (mqd_t queue);```
_Schliesst die Queue_ mit dem Descriptor `queue` für diesen Prozess.
Sie _bleibt_ aber noch _im System_, bis sie entfernt wird.

==== ```c int mq_unlink (const char *name);```
_Entfernt die Queue_ mit dem Namen `name` aus dem System.
_Name_ wird _sofort entfernt_ und Queue kann anschliessend _nicht mehr geöffnet_ werden.
_Queue_ selber wird _entfernt_, sobald _alle Prozesse sie geschlossen_ haben.

==== ```c int mq_send (mqd_t queue, const char *msg, size_t length, unsigned int priority);```
_Sendet die Nachricht_, die an Adresse `msg` beginnt und `length` Bytes lang ist, in die `queue`.
_Blockiert_ erst, wenn die _Queue voll_ ist #hinweis[(ausser mit `O_NONBLOCK`, returnt
dann -1)]. Gibt es auch als Variante mit _Timeout_: `mq_timedsend()`.

==== ```c int mq_receive (mqd_t queue, const char *msg, size_t length, unsigned int *priority);```
_Kopiert die nächste Nachricht_ aus der Queue in den Puffer, der an Adresse `msg` beginnt
und `length` Bytes lang ist #hinweis[(sollte $>=$ der maximalen Nachrichtengrösse der Queue sein)].
_Blockiert_, wenn die Queue _leer_ ist.
Gibt es auch als Variante mit _Timeout_: `mq_timedreceive()`.
`priority` ist ein Out-Parameter für die Priorität der empfangenen Nachricht.
Gibt _Grösse_ der empfangenen Nachricht zurück.

#wrap-content(
  image("img/bsys_39.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  == Shared Memory
  Frames des Hauptspeichers werden _zwei (oder mehr) Prozessen_ $P_1$ und $P_2$
  _zugänglich_ gemacht. In $P_1$ wird Page $V_1$ auf einen Frame $F$ abgebildet.
  In $P_2$ wird Page $V_2$ auf _denselben_ Frame $F$ abgebildet.
  Beide Prozesse können _beliebig_ auf dieselben Daten zugreifen.

  Eine Adresse in $V_1$ ergibt nur für $P_1$ Sinn, dieselbe Adresse gehört für $P_2$ zu
  einer _völlig anderen_ Speicherstelle. _Keine absoluten Adressen/Pointer verwenden!_
  Im Shared Memory müssen _relative Adressen_ verwendet werden.
  #hinweis[(Pointer müssen relativ zur Anfangs-Adresse sein, z.B. als Offset bezogen auf Start-Adresse)]
]

=== POSIX API
Das OS benötigt ein _spezielles Objekt $bold(S)$_, das Informationen über den gemeinsamen
Speicher verwaltet. $S$ wird in POSIX wie eine Datei verwendet.\
Ausserdem benötigt das OS ein _Objekt $bold(M_i)$_, je Prozess $P_i$, der diesen Speicher
verwenden möchte, um die spezifischen Mappings zu speichern #hinweis[(Mapping Table)].

==== ```c int shm_open (const char *name, int flags, mode_t mode);```
_Öffnet ein Shared Memory_ mit system-weitem `name` und gibt FD zurück.
- _`name`_ sollte immer mit "`/`" beginnen und sonst keine "`/`" enthalten
- _`flags`:_
  - `O_RDONLY` für read-only
  - `O_RDWR` für lesen und schreiben
  - `O_CREAT` erzeugt Shared Memory, falls es nicht existiert
- _`mode`:_ Legt Zugriffsberechtigungen fest: `S_IRUSR` | `S_IWUSR`

```c
int fd = shm_open ("/mysharedmemory", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
// Erzeugt (falls nötig) und öffnet Shared Memory /mysharedmemory zum Lesen und Schreiben
```

==== ```c int ftruncate (int fd, offset_t length);```
_Setzt Grösse der "Datei"_.
Gibt 0 zurück wenn alles OK, sonst -1 und Fehlercode in `errno`.
Muss _zwingend_ nach Shared Memory-Erstellung gesetzt werden, um entsprechend viele Frames zu allozieren.
Wird für Shared Memory _mit ganzzahligen Vielfachen_ der Page-/Framegrösse verwendet.

==== ```c int close (int fd);```
_Schliesst "Datei"_. Gibt 0 zurück wenn alles OK, sonst -1 und Fehlercode in `errno`.
Shared Memory _bleibt aber im System_, auch wenn kein Prozess das Shared Memory mehr offen hält.

==== ```c int shm_unlink (const char * name);```
_Löscht_ das Shared Memory mit dem `name` aus dem System. Dies kann danach _nicht mehr
geöffnet_ werden, bleibt aber _vorhanden_, bis es kein Prozess mehr geöffnet hält.

==== ```c
void * mmap(void *hint_address, size_t length, int protection, int flags,
int file_descriptor, off_t offset)
```
Mapped das Shared Memory, das mit `fd` geöffnet wurde, in den virtuellen Adressraum des
laufenden Prozesses und gibt die (virtuelle) Adresse des ersten Bytes zurück.
```c
void * address = mmap(
  0,                      // void *hint_address (0 because nobody cares)
  size_of_shared_memory,  // size_t length (same as used in ftruncate)
  PROT_READ | PROT_WRITE, // int protection (never use execute)
  MAP_SHARED,             // int flags
  fd,                     // int file_descriptor
  0                       // off_t offset (start map from first byte)
);
```

==== ```c int munmap (void *address, size_t length);```
_Entfernt das Mapping_ wieder aus dem virtuellen Adressraum.

== Vergleich Message-Passing & Shared Memory
_Shared Memory_ ist oft der _schneller zu realisierende Ansatz_.
Existierende Applikationen können relativ schnell auf mehrere Prozesse mit Shared Memory
umgeschrieben werden. Oft aber _schwer wartbar_.
Das System ist _weniger stark modularisiert_ und Prozesse sind schlechter gegeneinander _geschützt_.

_Message-Passing_ erfordert _mehr Engineering-Aufwand_.
Existierende Applikationen müssen in grossen Teilen neu implementiert werden.
Bei _sauber gekapselten_ Anwendungen viel geringeres Problem.
Lassen sich leicht als _verteilte Systeme_ erweitern.
Bei einigen OS sogar schon implementiert, z.B. QNX

#pagebreak()

=== Performance
- _Einzel-Prozessor-System:_ Im Normalfall Shared-Memory wegen entfallenden Kopieroperationen
- _Mehr-Prozessor-System:_ Shared-Memory benötigt zusätzlichen Aufwand aufgrund Cache-Synchronisation

Message-Passing-Systeme liegen auf Mehr-Prozessor-Systemen häufig _gleichauf_ und werden
in Zukunft vermutlich sogar _performanter_ sein als Shared-Memory-Systeme.

== Vergleich Message-Queues & Pipes
#table(
  columns: (1fr, 1fr),
  table.header(
    [Message-Queues],
    [Pipes],
  ),

  [
    - bidirektional
    - Daten sind in einzelnen Messages organisiert
    - beliebiger Zugriff
    - Haben immer einen Namen


  ],
  [
    - unidirektional
    - übermittelt Bytestrom an Daten
    - FIFO-Zugriff
    - Müssen keinen Namen haben
  ],
)
