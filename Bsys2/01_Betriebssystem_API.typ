// Compiled with Typst 0.11.1
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.0": wrap-content

/* #show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de"
) */

= Betriebssystem API
Aufgaben eines Betriebssystems:
- _Abstraktion_ und damit _Portabilität_
  #hinweis[(von Hardware, Protokollen, Software-Services)]
- _Resourcenmanagement_ und _Isolation_ der Anwendungen
  #hinweis[(Rechenzeit, RAM- & Speicherverwendung etc.)]
- _Benutzerverwaltung_ und Sicherheit

==== Grenzen der Portierbarkeit
Applikation muss auf allen Bildschirmgrössen, mit allen verschiedenen Bedienarten
(Maus vs. Touchscreen) etc. funktionieren.
Moderne Betriebssysteme bieten dafür Mechanismen an, es obliegt aber der Applikation,
diese zu verwenden. Das OS kann nicht entscheiden, was die Applikation meint.

==== Grenzen der Isolierbarkeit
Applikationen, die auf einem Bildschirm laufen, konkurrieren zwangsläufig um Bildschirm
und Tastatur. Häufiges Problem: Fokus-Diebstahl über Popups

==== Prozessor Privilege Level
Moderne OS benötigen Prozessor mit mindestens zwei Privilege Levels:
- _Kernel-Mode:_ Darf jede Instruktion ausführen #hinweis[(Ring 0)]
- _User-Mode:_ Darf nur eine beschränkte Menge an Instruktionen ausführen #hinweis[(Ring 3)]

Das OS läuft im Kernel-Mode und bestimmt über Software.

== Grundaufbau eines Betriebssystems
OS werden typischerweise in einen _Kern_ und einen _Nicht-Kernbereich_ aufgeteilt.
Kern umfasst die Komponenten, die im Kernel-Mode laufen müssen, alle anderen Komponenten
sollten im User-Mode laufen.

=== Microkernel
Kernelfunktionalität _reduziert_ auf ein Minimum. Selbst Gerätetreiber laufen im
User-Mode, nur _kritische Teile_ des Kernels laufen im Kernel-Mode.
_Stabil_ und Analysierbar, jedoch _Performance-Einbussen_.

=== Monolithische Kernel
Die meisten OS-Kernel sind monolithisch.
_Vorteil:_ weniger Wechsel zwischen den Modi #sym.arrow bessere Performance.
_Nachteil:_ weniger Schutz vor Programmierfehlern, da weniger Isolierung.

=== Unikernel
Ein "normales" Programm als Kernel, die Kernelfunktionalität ist in einer Library.
Keine Trennung zwischen Kernel- und User-Mode.
_Vorteil:_ Echte Minimalität, extrem kompakt.
_Nachteil:_ Single Purpose, Applikationsentwickler muss sich mit Hardware
auseinandersetzen.

=== Wechsel des Privilege Levels vom User zum Kernel Mode
Die `syscall` Instruktion auf Intel x86 Prozessoren veranlasst den Prozessor, in den
_Kernel Mode zu schalten_ und den IP auf OS-Code (System Call Handler) umzusetzen.
Dadurch ist gewährleistet, dass im Kernel Mode immer Kernel-Code läuft.

=== Zusammenspiel von Applikation und Kernel Code
Da es nur einen `syscall`-Befehl gibt, muss jede OS-Kernel-Funktion mit einem _Code_
versehen werden. Dieser Code muss in einem Register übergeben werden.
Zusätzlich müssen je nach Funktion _Parameter_ in anderen Registern übergeben werden.
Z.B. System Call `exit`: Hat den Code 60 und erwartet den Exit-Code des Programms
in einem Register.

#pagebreak()

=== ABI vs. API
#table(
  columns: (1fr, 1fr),
  table.header(
    [Application Binary Interface - ABI],
    [Application Programming Interface - API],
  ),

  [
    - Abstrakte Schnittstellen
    - Plattformunabhängige Aspekte
    - Kann für diverse OS gleich sein
  ],
  [
    - Konkrete Schnittstellen
    - Calling Convention
    - Abbildung von Datenstrukturen
  ],
)

Linux-Kernels sind API-, aber nicht ABI-kompatibel. Die API-Kompabilität ist dadurch
gegeben, dass Applikationen nicht direkt Syscalls aufrufen, sondern C-Wrapper-Funktionen
verwenden. Diese verwenden zum Kernel passenden Binärcode.

=== POSIX (Portable Operating System Interface)
Jedes OS hat eigene API und ABI. Der OS-spezifische Teil der UNIX/C-API ist jedoch als
POSIX standardisiert. macOS und Linux sind POSIX-konform, Windows nicht.

==== Man Pages
Man pages #hinweis[(manual pages)] enthalten Dokumentation für die Programme auf einem
POSIX-System. Liefert viele Informationen über ein POSIX-System.
Ist in 9 Kapitel aufgeteilt, z.b. Kapitel 3 für Libraries.

==== Shell
Programm, das es erlaubt, über Texteingabe Betriebssystemfunktionen aufzurufen.
Gibt viele verschiedene Shells mit unterschiedlichem Syntax.
Benötigt keine besonderen Rechte oder spezielle Vorkehrungen.
Benötigt nur Ausgabe- und Eingabe-Stream.

#wrap-content(
  image("img/bsys_1.png"),
  align: bottom + right,
  columns: (70%, 30%),
)[
  == Programmargumente
  Wird ein Programm gestartet, kann es Programmargumente erhalten.\
  _Beispiel:_ ```sh clang -c abc.c -o abc.o```
]

=== Programmargumente aus der Shell
Shell teilt Programmargumente in _Strings_ auf.
Fast alle Shells verwenden _Leerzeichen als Trennung_ zwischen Programmargumenten.
Viele Shells erlauben Spaces in Programmargumenten durch die Verwendung von _Quotes_.
Das OS interessiert sich _nicht_ für den _Inhalt_ der Argumente.

#wrap-content(
  image("img/bsys_2.png"),
  align: top + right,
  columns: (59%, 41%),
)[
  === Calling Convention
  Beim Start schreibt das OS die Programmargumente als _null-terminierte Strings_ in den
  Speicherbereich des Programms. Zusätzlich legt das OS ein _Array_ `argv` an, dessen
  Elemente jeweils auf das _erste Zeichen eines Programmarguments_ zeigen.
  Der Pointer auf dieses Array und die Anzahl der Elemente `argc` wird dem Programm an
  _einer vom OS definierten Stelle_ zur Verfügung gestellt, z.B. in Registern oder
  auf dem Stack. Die Art und Weise wie/wo dies gehandhabt wird, ist die Calling Convention.
]

=== Programmargumente in C
In C wird dieser Umstand durch die beiden Parameter der Funktion ```c main()``` ausgedrückt.
```c int argc``` enthält die Anzahl der Programmargumente + 1.
```c char **argv``` enthält den Pointer auf das Array.
_Achtung:_ `argv[0]` ist der Programmname, die Argumente selbst folgen als
`argv[1]` bis `argv[argc - 1]`

```c int main(int argc, char ** argv) { ... }```

#wrap-content(
  image("img/bsys_4.png"),
  align: bottom + right,
  columns: (64%, 36%),
)[
  == Umgebungsvariablen
  Die Umgebungsvariablen eines Programms sind eine Menge an Strings, die jeweils
  mindestens ein `=` enthalten, z.B.:

  ```sh
  OPTER=1
  OPTIND=1
  OSTYPE=linux-gnu
  PATH=/home/ost/bin:/home/ost/.local/bin
  ```
]
- Der Teilstring vor dem `=` wird als _Key_ bezeichnet
- Der Teilstring nach dem `=` wird als _Value_ bezeichnet
- Jeden Key kann es _höchstens einmal_ geben

Unter POSIX verwaltet das OS die Umgebungsvariablen innerhalb jedes laufenden Prozesses.
Sie werden _initial_ vom erzeugenden Prozess festgelegt, also z.B. der Shell
#hinweis[(die Shell kopiert ihre Umgebungsvariablen in den Prozess)].
Das OS legt die Umgebungsvariablen als ein _null-terminiertes Array von Pointern auf
null-terminierte Strings_ ab. Unter C zeigt die Variable ```c extern char **environ``` auf
dieses Array. _`environ`_ sollte nicht direkt verwendet werden, sondern nur über folgende
Funktionen manipuliert werden: _`getenv()`_, _`putenv()`_, _`setenv()`_ und _`unsetenv()`_.

==== Abfragen einer Umgebungsvariable: ```c char * getenv (const char * key)```
durchsucht die Umgebungsvariablen nach dem Key `key` und gibt die Adresse des ersten
Zeichens des entsprechenden Values zurück falls vorhanden, ansonsten `0`.

```c
char *value = getenv("PATH");
// value = "/home/ost/bin:/home/ost/.local/bin"
```

==== Setzen einer Umgebungsvariable:\ ```c int setenv (const char *key, const char *value, int overwrite)```
Wenn `key` schon in einer Umgebungsvariable `v` enthalten ist _und_ `overwrite != 0`:
überschreibt den Wert von `v` mit `value`. Wenn `key` noch nicht in einer 
Umgebungsvariable enthalten ist: fügt eine neue Umgebungsvariable hinzu und kopiert `key`
und `value` dort hinein. Gibt `0` zurück wenn alles OK, ansonsten Fehlercode in `errno`.

```c int ret = setenv("HOME", "/usr/home", 1);```

==== Entfernen einer Umgebungsvariable: ```c int unsetenv (const char *key)```
entfernt die Umgebungsvariable mit dem Key `key`. Gibt `0` zurück wenn alles OK, ansonsten
Fehlercode in `errno`.

```c int ret = unsetenv("HOME");```

==== Hinzufügen einer Umgebungsvariable: ```c int putenv (char * kvp)```
fügt den Pointer `kvp` #hinweis[(key-value-pair)] dem Array der Umgebungsvariablen hinzu.
Der String, auf den `kvp` zeigt, wird _nicht_ kopiert. Wird der String nach dem Setzen der
Umgebungsvariabel geändert, wird diese ebenfalls geändert.
Wenn der Key schon vorhanden ist, wird der String gelöscht, auf den der existierende
Pointer zeigt. D.h. der Pointer verweist anschliessend auf eine leere Stelle.
Gibt `0` zurück wenn alles OK, ansonsten Fehlercode in `errno`. _Gefährliche Funktion!_

```c int ret = putenv("HOME=/usr/home");```

== Zweck von Programmargumenten und Umgebungsvariablen
#table(
  columns: (1fr, 1fr),
  table.header([Programmargumente], [Umgebungsvariablen]),
  [
    - werden explizit angegeben
    - nützlich für Informationen, die bei jedem Aufruf anders sind
      #hinweis[(z.B. die Datei, die kompiliert werden soll)]
  ],
  [
    - werden implizit bereitgestellt
    - nützlich für Informationen, die bei jedem Aufruf gleich sind
      #hinweis[(z.B. Pfade für Hilfsprogramme, Libraries)]
  ],
)

_Grössere Konfigurationsinformationen_ sollten bevorzugt über _Dateien_ übermittelt
werden. Das ist häufig nötig wegen Beschränkungen der Zeilenlänge.
Datenformat völlig in der Hand des Programms; keine Unterstützung durch das OS.
Der Dateiname kann als Umgebungsvariable oder Programmargument übergeben werden.

Manche Betriebssysteme kennen noch andere Mechanismen, z.B. Windows Registry, die eher
einer Datenbank gleicht.
