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

= Threads
#wrap-content(
  image("img/bsys_22.png"),
  align: top + right,
  columns: (75%, 25%),
)[
  == Prozessmodell
  Jeder Prozess hat virtuell den _ganzen Rechner_ für _sich alleine_.
  _Prozesse_ sind gut geeignet für _unabhängige Applikationen_.
  Nachteile: Realisierung _paralleler Abläufe_ innerhalb derselben Applikation
  ist _aufwändig_. _Overhead_ zu gross falls nur kürzere Teilaktivitäten,
  _gemeinsame Ressourcennutzung_ ist _erschwert_.
]

#wrap-content(
  image("img/bsys_23.png"),
  align: top + right,
  columns: (85%, 15%),
)[
  == Threadmodell
  Threads sind _parallel ablaufende Aktivitäten innerhalb eines Prozesses_,
  welche auf _alle_ Ressourcen im Prozess gleichermassen Zugriff haben
  #hinweis[(Code, globale Variablen, Heap, geöffnete Dateien, MMU-Daten)]

  === Thread als Stack + Kontext
  Jeder Thread benötigt einen _eigenen Kontext_ und einen _eigenen Stack_,
  weil er eine eigene Funktions-Aufrufkette hat. Diese Informationen werden
  häufig in einem _Thread-Control-Block_ abgelegt.
  #hinweis[(Linux: Kopie des PCB mit eigenem Kontext)]
]

== Amdahls Regel
#wrap-content(
  image("img/bsys_24.png"),
  align: top + right,
  columns: (70%, 30%),
)[
  Bestimmte Teile eines Algorithmus können _nicht_ parallelisiert werden,
  weil sie _voneinander abhängen_. Man kann für jeden Teil eines Algorithmus
  angeben, ob dieser _parallelisiert_ werden kann oder nicht.
]
#wrap-content(
  image("img/bsys_25.png"),
  align: top + right,
  columns: (65%, 35%),
)[
  / $T$: Ausführungszeit, wenn _komplett seriell_ durchgeführt\
    #hinweis[Im Bild: $T = T_0 + T_1 + T_2 + T_3 + T_4 $]
  / $n$: Anzahl der Prozessoren
  / $T'$: Ausführungszeit, wenn _maximal parallelisiert_ #hinweis[gesuchte Grösse]
  / $T_s$: Ausführungszeit für den Anteil, der _seriell_ ausgeführt werden _muss_\
    #hinweis[Im Bild: $T_s = T_0 + T_2 + T_4$]
  / $T - T_s$: Ausführungszeit für den Anteil, der _parallel_ ausgeführt werden _kann_\
    #hinweis[Im Bild: $T - T_s = T_1 + T_3$]
  / $(T - T_s) / n$: Parallel-Anteil verteilt auf alle $n$ Prozessoren\
    #hinweis[Im Bild: $(T_1 + T_3) / n$]
  / $T_s + (T - T_s) / n$: Serieller Teil + Paralleler Teil
    #hinweis[$= T'$]

  Die _serielle Variante_ benötigt also höchstens _$f$ mal mehr Zeit_ als
  die _parallele Variante_ #hinweis[(wegen Overhead nur $<=$)]:
]

#block($ f <= T / T^' = T / (T_s + (T - T_s) / n) $)
$f$ heisst auch _Speedup-Faktor_, weil man sagen kann, dass die parallele
Variante maximal $f$-mal schneller ist als die serielle.

Definiert man $s = T_s/T$, also den seriellen Anteil am Algorithmus,
dann ist $s dot T = T_s$. Dadurch erhält man $f$ unabhängig von der Zeit:

#block($
  f <= T / (T_s + (T - T_s) / n) = T / (s dot T + (T - s dot T) / n)
  = T / (s dot T + (1 - s) / n dot T) => f <= 1 / (s + (1 - s) / n)
$)

#wrap-content(
  image("img/bsys_26.png"),
  align: top + right,
  columns: (60%, 40%),
)[
  === Bedeutung
  - Abschätzung einer _oberen Schranke_ für den maximalen Geschwindigkeitsgewinn
  - Nur wenn _alles_ parallelisierbar ist, ist der Speedup _proportional_ und _maximal_
    #hinweis[$f(0,n) = n$]
  - Sonst ist der Speedup mit _höherer Prozessor-Anzahl_ immer _geringer_
    #hinweis[(Kurve flacht ab)]
  - $f(1,n)$: rein seriell

  === Grenzwert
  Mit höherer Anzahl Prozessoren nähert sich der Speedup $1/s$ an:
]
#grid(
  columns: (1fr, 1fr, 1fr),
  [$ lim_(n -> infinity) (1 - s) / n = 0 $],
  [$ lim_(n -> infinity) s + (1 - s) / n = s $],
  [$ lim_(n -> infinity) 1 / (s + (1 - s) / n) = 1 / s $],
)

== POSIX Thread API
=== `pthread_create()`
```c
int pthread_create(
    pthread_t *thread_id, pthread_attr_t const *attributes,
    void * (*start_function) (void *), void *argument
)
```
_Erzeugt einen Thread_ und gibt bei _Erfolg 0_ zurück, sonst einen Fehlercode.
Die _ID_ des neuen Threads wird im _Out-Parameter `thread_id`_ zurückgegeben.
_`attributes`_ ist ein _opakes Objekt_, mit dem z.B. die _Stack-Grösse_
spezifiziert werden kann.

Die _erste Instruktion_, die der neue Thread ausführen soll, ist ein
_Aufruf der Funktion_, deren Adresse in _`start_function`_ übergeben wird.
Diese Funktion muss ebendiese Signatur haben. Zusätzlich übergibt der Thread
das Argument `argument` an diese Funktion. Dies ist typischerweise ein Pointer
auf eine Datenstruktur auf dem Heap. #hinweis[(*Achtung:* Legt man diese Struktur
auf dem Stack an, muss man sicherstellen, dass man während der Lebensdauer
des Threads den Stack nicht abbaut.)]

#grid(
  columns: (50%, 60%),
  gutter: 11pt,
  [
    ```c
    //Erstellung
    struct T {
      int value;
    };
    void * my_start (void * arg) {
      struct T * p = arg;
      printf ("%d\n", p->value);
      free (arg);
      return 0:
    }
    ```
  ],
  [
    ```c
    //Verwendung
    void start_my_thread (void) {
      struct T * t = malloc (
       sizeof (struct T));
      t->value = 109;
      pthread_t tid;
      pthread_create (
        &tid,
        0, // default attributes
        &my_start,
        t
      );
    }
    ```
  ],
)

==== Thread-Attribute
Um Attribute _anzugeben_, muss man nach folgendem _Muster_ verfahren,
da `pthread_attr_t` je nach Implementation _weiteren Speicher_ benötigen kann:

```c
pthread_attr_t attr; // Variabel erstellen
pthread_attr_init (&attr); // Variabel initialisieren
pthread_attr_setstacksize (&attr, 1 << 16); // 64kb Stackgrösse
pthread_create (..., &attr, ...); // Thread erstellen
pthread_attr_destroy (&attr); // Attribute löschen
```

=== Lebensdauer eines Threads
Ein Thread _lebt_ solange, bis eine der folgenden Bedingungen eintritt:
- Er springt aus der Funktion _`start_function`_ zurück
- Er ruft _`pthread_exit`_ auf #hinweis[(Normales `exit` terminiert Prozess)]
- Ein _anderer Thread_ ruft _`pthread_cancel`_ auf
- Sein _Prozess_ wird _beendet_.

=== ```c void pthread_exit (void *return_value)```
_Beendet_ den Thread und gibt den `return_value` zurück.
Das ist äquivalent zum _Rücksprung aus `start_function` mit dem Rückgabewert_.

=== ```c int pthread_cancel (pthread_t thread_id)```
Sendet eine _Anforderung_, dass der Thread mit `thread_id` _beendet_ werden soll.
Die Funktion _wartet nicht_, dass der Thread _tatsächlich beendet_ wurde.
Der Rückgabewert ist 0, wenn der Thread existiert, bzw. `ESRCH` #hinweis[(error_search)],
wenn nicht.

=== ```c int pthread_detach (pthread_t thread_id)```
_Entfernt den Speicher_, den ein Thread belegt hat, falls dieser _bereits beendet_ wurde.
Beendet den Thread aber _nicht_. #hinweis[(Erstellt Daemon Thread)]

=== ```c int pthread_join (pthread_t thread_id, void **return_value)```
_Wartet_ solange, bis der Thread mit `thread_id` _beendet_ wurde.
Nimmt den _Rückgabewert_ des Threads im Out-Parameter _`return_value`_ entgegen.
Dieser kann _`NULL`_ sein, wenn nicht gewünscht. Ruft _`pthread_detach`_ auf.

=== ```c pthread_t pthread_self (void)```
Gibt die _ID_ des _gerade laufenden_ Threads zurück.

== Thread-Local Storage (TLS)
In C geben viele System-Funktionen den Fehlercode nicht direkt zurück,
sondern über `errno`, z.B. die `exec`-Funktionen. Wäre `errno` eine _globale Variable_,
würde folgender Code bei mehreren Threads _unerwartetes Verhalten_ aufeisen:
```c
void f (void) {
  int result = execl (...);
  if (result == -1) {
    int error = errno; // Kann auch von einem anderen Thread sein
    printf ("Error %d\n", error);
  }
}
```
TLS ist ein Mechanismus, der _globale Variablen per Thread_ zur Verfügung stellt.
Dies benötigt mehrere explizite Einzelschritte:\
*Bevor Threads erzeugt werden:*
- Anlegen eines _Keys_, der die TLS-Variable _identifiziert_
- _Speichern_ des Keys in einer _globalen Variable_
*Im Thread:*
- _Auslesen_ des Keys aus der globalen Variable
- _Auslesen / Schreiben_ des Werts anhand des Keys über besondere Funktionen

=== ```c int pthread_key_create( pthread_key_t *key, void (*destructor) (void*) )```
Erzeugt einen _neuen Key_ im Out-Parameter `key`. _`pthread_key_t`_ ist eine
_opake Datenstruktur_. Für jeden Thread und jeden Key hält das OS einen Wert
vom Typ _`void *`_ vor. Dieser Wert wird immer mit _`NULL`_ initialisiert.
Das OS ruft den _`destructor`_ am Ende des Threads mit dem jeweiligen
_thread-spezifischen Wert_ auf, wenn dieser dann nicht `NULL` ist.
Gibt 0 zurück wenn alles OK, sonst Fehlercode.

=== ```c int pthread_key_delete( pthread_key_t key)```
_Entfernt den Key_ und die entsprechenden Values aus allen Threads.
Der Key darf nach diesem Aufruf _nicht mehr verwendet_ werden.
Sollte erst aufgerufen werden, wenn alle dazugehörende Threads beendet sind.
Das Programm muss dafür sorgen, _sämtlichen Speicher freizugeben_,
der eventuell zusätzlich alloziert worden war.
Gibt 0 zurück wenn alles OK, sonst Fehlercode.

=== `pthread_setspecific` und `pthread_getspecific`
```c int pthread_setspecific( pthread_key_t key, const void * value )```\
```c void * pthread_getspecific( pthread_key_t key )```
_schreibt_ bzw. _liest_ den Wert, der mit dem Key in diesem Thread assoziiert ist.
Typischerweise verwendet man den Wert als _Pointer auf einen Speicherbereich_, bspw:

```c
// Setup
typedef struct {
  int code;
  char *message;
} error_t;
pthread_key_t error;
void set_up_error (void) { // wird am Anfang des Threads aufgerufen
  pthread_setspecific( error, malloc( sizeof( error_t )))
}

// Lesen und Schreiben im Thread
void print_error (void) {
  error_t * e = pthread_getspecific (error);
  printf("Error %d: %s\n", e->code, e->message);
}
int force_error (void) {
  error_t * e = pthread_getspecific (error);
  e->code = 98;
  e->message = "file not found";
  return -1;
}

// Main und Thread
void *thread_function (void *) {
  set_up_error();
  if (force_error () == -1) { print_error (); }
}
int main (int argc, char **argv) {
  pthread_key_create (&error, NULL); // Key erzeugen
  pthread_t tid;
  pthread_create (&tid, NULL, &thread_function, NULL); // Threads erzeugen
  pthread_join (tid, NULL);
}
```