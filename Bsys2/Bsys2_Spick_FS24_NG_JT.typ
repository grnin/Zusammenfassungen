// Compiled with Typst 0.11.1
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.0": wrap-content

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  language: "de",
  column-count: 5,
  font-size: 4pt,
  landscape: true,
)

#let wait = ```c wait()```

```c
int *px = &x; // &x = Adresse des ints, * = Pointer-Bezeichner
int y = *px;  // *px = Wert einer int-Adresse, y = 5, * = Dereferenzoper.
```

#table(
  columns: (auto,) * 5 + (2.75em,) * 4 + (1fr,) * 4,
  [$4096$],[$2048$],[$1024$],[$512$],[$256$],[$128$],[$64$],[$32$],[$16$],[$8$],[$4$],[$2$],[$1$],
  [$2^12$],[$2^11$],[$2^10$],[$2^9$],[$2^8$],[$2^7$],[$2^6$],[$2^5$],[$2^4$],[$2^3$],[$2^2$],[$2^1$],[$2^0$],
  [#hex("1000")],[#hex("800")],[#hex("400")],[#hex("200")],[#hex("100")],[#hex("80")],[#hex("40")],[#hex("20")],[#hex("10")],[#hex("8")],[#hex("4")],[#hex("2")],[#hex("1")],
)

#table(
  columns: (1fr,) * 6,
  [$1'048'576$],[$65'536$],[$4'096$],[$256$],[$16$],[$1$],
  [$16^5$],[$16^4$],[$16^3$],[$16^2$],[$16^1$],[$16^0$],
  [#hex("10 0000")],[#hex("01 0000")],[#hex("00 1000")],[#hex("00 0100")],[#hex("00 0010")],[#hex("00 0001")],
)

#{
  show raw: set text(size: 0.9em)
  table(
    columns: (1fr,) * 16,
    align: (_, y) => if (y == 2) { center } else { left },
    [$0$],[$1$],[$2$],[$3$],[$4$],[$5$],[$6$],[$7$],[$8$],[$9$],[$A$],[$B$],[$C$],[$D$],[$E$],[$F$],
    [$0$],[$1$],[$2$],[$3$],[$4$],[$5$],[$6$],[$7$],[$8$],[$9$],[$10$],[$11$],[$12$],[$13$],[$14$],[$15$],
    [`0000`],[`0001`],[`0010`],[`0011`],[`0100`],[`0101`],[`0110`],[`0111`],[`1000`],[`1001`],[`1010`],[`1011`],[`1100`],[`1101`],[`1110`],[`1111`],
  )
}

= Betriebssystem API
*Aufgaben:*
Abstraktion, Portabilität, Ressourcenmanagement & Isolation der Anwendungen,
Benutzerverwaltung und Sicherheit.\
*Privilege Levels:*
_Kernel-Mode_ #hinweis[(darf alles ausführen, Ring 0)],
_User-Mode_ #hinweis[(darf nur beschränkte Menge an Instruktionen ausführen, Ring 3)]\
*Kernels:*
_Microkernel_ #hinweis[(nur kritische Teile laufen im Kernel-Mode)],
_Monolithisch_ #hinweis[(meiste OS, weniger Wechsel, weniger Schutz)],
_Unikernel_ #hinweis[(Kernel ist nur ein Programm)]\
*`syscall`*
veranlasst den Prozessor, in den Kernel Mode zu schalten. Jede OS-Kernel-Funktion
hat einen Code, der einem Register übergeben werden muss. #hinweis[(`exit` hat den Code 60)]\
*ABI:*
Application Binary Interface, Abstrakte Schnittstelle mit platformunabhängigen Aspekten.
*API:*
Application Programming Interface, Konkrete Schnittstellen, Calling Convention, Abbildung
von Datenstrukturen. _Linux-Kernels_ sind API-, aber nicht ABI-kompatibel.
#hinweis[(C-Wrapper-Funktionen)]\
*POSIX:*
Portable Operating System Interface. Sammlung von IEEE Standards, welche die Kombatibilität
zwischen OS gewährleistet. Windows ist nicht POSIX-konform.

== Programmargumente
`clang` *`-c abc.c -o abc.o`*. Die Shell teilt Programmargumente in Strings auf
#hinweis[(Trennung durch Leerzeichen, sonst Quotes)].
*Calling Convention:*
OS schreibt Argumente als null-terminierte Strings in den Speicherbereich des Programms.
Zusätzlich legt das OS ein Array `argv` an, dessen Elemente jeweils auf das erste Zeichen
eines Arguments zeigen. Die Art und Weise, wie das gehandhabt wird, ist die Calling Convention.
Werden explizit angegeben, nützlich für Informationen, die bei jedem Aufruf anders sind.\
```c int main(int argc, char ** argv) { ... } // argv[0] = program path```

== Umgebungsvariablen
Strings, die mindestens ein `Key=Value` enthalten #hinweis[`OPTER=1`, `PATH=/home/ost/bin`].
Der Key muss einzigartig sein. Unter POSIX verwaltet das OS die Umgebungsvariablen innerhalb
jedes laufenden Prozesses. Werden initial festgelegt. Das OS legt die Variablen als ein
null-terminiertes Array von Pointern auf null-terminierte Strings ab. Unter C zeigt die
Variable ```c extern char **environ``` darauf. Sollte nur über untenstehende Funktionen
manipuliert werden. Werden implizit bereitgestellt, nützlich für Informationen, die bei
jedem Aufruf gleich sind.

- *Abfragen einer Umgebungsvariable:* ```c char *value = getenv("PATH");```
- *Setzen einer Umgebungsvariable:* ```c int ret = setenv("HOME", "/usr/home", 1);```
- *Entfernen einer Umgebungsvariable:* ```c int ret = unsetenv("HOME");```
- *Hinzufügen einer Umgebungsvariable :* ```c int ret = putenv("HOME=/usr/home");```\
  #hinweis[gefährlich wegen Pointer auf NULL]

_Grössere Konfigurationsinformationen_ sollten über _Dateien_ übermittelt werden.

= Dateisystem API
Applikationen dürfen nie annehmen, dass Daten gültig sind.\
*Arbeitsverzeichnis:*
Bezugspunkt für relative Pfade, jeder Prozess hat eines
#hinweis[(`getcwd()`, `chdir()`: nimmt String, `fchdir()`: nimmt File Deskriptor)].\
*Pfade:*
Absolut #hinweis[(beginnt mit /)],
Relativ #hinweis[(beginnt nicht mit /)],
Kanonisch #hinweis[(Absolut, ohne "." und "..". `realpath()`)]\
- _`NAME_MAX`:_ Maximale Länge eines Dateinamens (exklusive terminierender Null)
- _`PATH_MAX`:_ Maximale Länge eines Pfads (inklusive terminierender Null)
  #hinweis[(beinhaltet Wert von `NAME_MAX`)]
- _`_POSIX_NAME_MAX`:_ Minimaler Wert von `NAME_MAX` nach POSIX #hinweis[(14)]
- _`_POSIX_PATH_MAX`:_ Minimaler Wert von `PATH_MAX` nach POSIX #hinweis[(256)]

```c int main (int argc, char ** argv) { char *wd = malloc(PATH_MAX); getcwd(wd, PATH_MAX); printf("Current WD is %s", wd); free(wd); return 0; } // Gibt Arbeitsverzeichnis aus```

*Zugriffsrechte:*
Je 3 Permission-Bits für Owner, Gruppe und andere Benutzer.
Bits sind: _`r`_ead, _`w`_rite, e_`x`_ecute. `r=4, w=2, x=1`.
_Beispiel:_ `0740` oder `rwx r-- ---`
#hinweis[Owner hat alle Rechte, Gruppe kann lesen, andere haben keine Rechte.]
*POSIX:*
_`S_IRWXU`_ `= 0700`, _`S_IWUSR`_ `= 0200`, _`S_IRGRP`_ `= 0040`, _`S_IXOTH`_ `= 0001`.
Werden mit | verknüpft.

*POSIX-API:*
für direkten Zugriff, alle Dateien sind rohe Binärdaten.
*C-API:*
für direkten Zugriff auf Streams.
*POSIX FILE API:*
für direkten, unformatierten Zugriff auf Inhalt der Datei. Nur für Binärdaten verwenden.
*`errno`:*
Makro oder globale Variable vom typ `int`.
Sollte direkt nach Auftreten eines Fehlers aufgerufen werden.

```c if (chdir("docs") < 0) { if (errno == EACCESS) { printf("Error: Denied"); }}```

*`strerror`*
gibt die Adresse eines Strings zurück, der den Fehlercode `code` textuell beschreibt.
*`perror`*
schreibt `text` gefolgt von einem Doppelpunkt und vom Ergebnis von `strerror(errno)`
auf den Errorstream.

== File-Descriptor (FD)
Files werden in der POSIX-API über FD's repräsentiert. Gilt nur _innerhalb eines Prozesses_.
Returnt _Index in Tabelle_ aller geöffneter Dateien im Prozess #sym.arrow
Enthält _Index in systemweite Tabelle_ #sym.arrow Enthält Daten zur Identifikation der Datei.
_`STDIN_FILENO = 0`:_ standard input,
_`STDOUT_FILENO = 1`:_ standard output,
_`STDERR_FILENO = 2`:_ standard error

*```c int open (char *path, int flags, ...)```:*
_öffnet_ eine Datei. Erzeugt FD auf Datei an `path`.
`flags` gibt an, *wie* die Datei geöffnet werden soll.
_`O_RDONLY`:_ nur lesen,
_`O_RDWR`:_ lesen und schreiben,
_`O_CREAT`:_ Erzeuge Datei, wenn sie nicht existiert,
_`O_APPEND`:_ Setze Offset ans Ende der Datei vor jedem Schreibzugriff,
_`O_TRUNC`:_ Setze Länge der Datei auf 0

*```c int close (int fd)```:*
_schliesst_ Datei bzw. _dealloziert_ den FD. Kann dann wieder für andere Dateien verwendet
werden. Wenn FD's nicht geschlossen werden, kann das FD-Limit erreicht werden, dann können
keine weiteren Dateien mehr geöffnet werden.
Wenn mehrere FDs die gleiche Datei öffnen, können sie sich gegenseitig Daten überschreiben.

```c
int fd = open("myfile.dat", O_RDONLY);
if (fd < 0) { /* error handling */ } /* read data; */ close(fd);
```

*```c ssize_t read(int fd, void * buffer, size_t n)```:*\
_kopiert_ die nächsten $n$ Bytes am aktuellen Offset _von fd in den Buffer_.\
*```c ssize_t write(int fd, void * buffer, size_t n)```:*\
_kopiert_ die nächsten $n$ Byte _vom `buffer` an den aktuellen Offset von `fd`_

```c
#define N 32
char buf[N]
char spath[PATH_MAX]; // source path
char dpath[PATH_MAX]; // destination path
// ... gets paths from somewhere
int src = open(spath, O_RDONLY);
int dst = open(dpath, O_WRONLY | O_CREAT, S_IRWXU);
ssize_t read_bytes = read(src, buf, N);
write(dst, buf, read_bytes); //if file gets closed early, use return value of "read_bytes"
close(src);
close(dst);
```

*```c off_t lseek(int fd, off_t offset, int origin)```:*
_Springen in einer Datei_. Verschiebt den Offset und gibt den neuen Offset zurück.
_`SEEK_SET`:_ Beginn der Datei,
_`SEEK_CUR`:_ Aktueller Offset,
_`SEEK_END`:_ Ende der Datei.
_`lseek(fd, 0, SEEK_CUR)`_ gibt aktuellen Offset zurück,
_`lseek(fd, 0, SEEK_END)`:_ gibt die Grösse der Datei zurück.

*```c ssize_t pread/pwrite(int fd, void * buffer, size_t n, off_t offset)```:*\
_Lesen und Schreiben ohne Offsetänderung_. Wie `read` bzw. `write`. Statt des Offsets von
`fd` wird der zusätzliche Parameter `offset` verwendet.

=== Unterschiede Windows und POSIX
Bestandteile von Pfaden werden durch _Backslash_ (`\`) getrennt, ein _Wurzelverzeichnis pro_
Datenträger/Partition, andere File-Handling-Funktionen.

== C Stream API
Unabhängig vom Betriebssystem, Stream-basiert, gepuffert oder ungepuffert,
hat einen eigenen File-Position-Indicator.\
*Streams:*
`FILE *` enthält _Informationen über einen Stream_. Soll nicht direkt verwendet oder kopiert
werden, sondern nur über von C-API erzeugte Pointer.

*```c FILE * fopen(char const *path, char const *mode)```:*
_Öffnen eine Datei._ Erzeugt `FILE`-Objekt für Datei an `path`. Flags für `mode`:
_`"r"`_ #hinweis[(Datei lesen)],
_`"w"`_ #hinweis[(in neue oder bestehende geleerte Datei schreiben)],
_`"a"`:_ #hinweis[(in neue oder bestehende Datei anfügen)],
_`"r+`:_ #hinweis[(Datei lesen & schreiben)],
_`"w+"`_ #hinweis[(neue oder geleerte bestehende Datei lesen & überschreiben)],
_`"a+"`_ #hinweis[(neue oder bestehende Datei lesen & an Datei anfügen)].
Gibt Pointer auf erzeugtes `FILE`-Objekt zurück oder 0 bei Fehler.
```c FILE * fdopen(int fd, char const * mode)```
ist gleich, aber statt Pfad wird direkt der FD übergeben.
```c int fileno (FILE *stream)```
gibt FD zurück. Nach API-Umwandlung vorherige nicht mehr verwenden.\
*```c int fclose(FILE *file)```:*
_Schliesst eine Datei._
Ruft ```c fflush()``` #hinweis[(schreibt Inhalt aus Speicher in die Datei)] auf, schliesst
den Stream, entfernt `file` aus Speicher und gibt 0 zurück wenn OK, andernfalls `EOF`.\
*```c int fgetc(FILE *stream)```:*
_Liest_ das nächste Byte und erhöht FPI um 1.\
```c char * fgets(char *buf, int n, FILE *stream)``` liest bis zu $n-1$ Zeichen aus `stream`.\
*```c int ungetc(int c, FILE *stream)```:*
_Lesen rückgängig machen._ Nutzt Unget-Stack.\
*```c int fputc(int c, FILE *stream)```: *
_Schreibt `c` in eine Datei._ ```c int fputs(char *s, FILE *stream)``` schreibt die Zeichen
vom String `s` bis zur terminierenden 0 in `stream`.

=== Dateiende und Fehler:
```c int feof(FILE *stream)``` gibt 0 zurück, wenn Dateiende _noch nicht_ erreicht wurde\
```c int ferror(FILE * stream)``` gibt 0 zurück, wenn _kein_ Fehler auftrat.

=== Manipulation des File-Position-Indicator (FPI):
```c long ftell(FILE *stream)``` gibt den gegenwärtigen FPI zurück,
```c int fseek (FILE *stream, long offset, int origin)``` setzt den FPI, analog zu `lseek`,
```c int rewind (FILE *stream)``` setzt den Stream zurück.

= Prozesse
Prozesse #hinweis[(aktiv)] sind die _Verwaltungseinheit_ des OS für Programme #hinweis[(passiv)].
Jedem Prozess ist ein _virtueller Adressraum_ zugeordnet.\
Ein Prozess umfasst das _Abbild eines Programms_ im Hauptspeicher #hinweis[(text section)],
die _globalen Variablen des Programms_ #hinweis[(data section)],
Speicher für den _Heap_ und Speicher für den _Stack_.\
*Process Control Block (PCB):*
Das Betriebssystem hält Daten über jeden Prozess in jeweils einem _PCB_ vor. Speicher für
alle Daten, die das OS benötigt, um die Ausführung des Prozesses ins Gesamtsystem zu
integrieren, u.a.: Diverse IDs, Speicher für Zustand, Scheduling-Informationen, Daten zur
Synchronisation, Security-Informationen etc.\
*Interrupts:*
_Kontext_ des aktuellen Prozesses muss im dazugehörigen PCB gespeichert werden #hinweis[(context save)]:
Register, Flags, Instruction Pointer, MMU-Konfiguration. _Interrupt-Handler_ überschreibt
den Kontext. Anschliessend wird Kontext aus PCB wiederhergestellt #hinweis[(context restore)].\
*Prozess-Erstellung:*
Das OS erzeugt den Prozess und lädt das Programm in den Prozess.
Unter POSIX getrennt, unter Windows eine einzige Funktion.\
*Prozess-Hierarchie:*
Baumstruktur, startet bei Prozess 1.

== Prozess-API
*```c pid_t fork(void)```*
erzeugt _exakte Kopie_ ($C$) als Kind des Prozesses ($P$), mit eigener Prozess-ID (>0).
Die Funktion führt in _beiden_ Prozessen den Code an derselben Stelle fort.\
*```c void exit(int code)```:* Beendet das Programm und gibt `code` zurück.\
*```c pid_t wait(int *status)```:* unterbricht Prozess, bis Child beendet wurde.\
*```c pid_t waitpid (pid_t pid, int *status, int options)```:*
wie #wait, aber `pid` bestimmt, auf welchen Child-Prozess man warten will
#hinweis[(> 0 = Prozess mit dieser ID, -1 = irgendeinen, 0 = alle C mit der gleichen Prozessgruppen-ID)].

```c
void spawn_worker (...) {
  if (fork() == 0) { /* do something in worker process; */ exit(0); }
}
for (int i = 0; i < n; ++i) { spawn_worker(...); }
// ... do something in parent process
do { pid = wait(0); } while (pid > 0 || errno != ECHILD); // wait for all children
```

*`exec()`-Funktionen:*
Jede davon _ersetzt_ im gerade laufenden Prozess das Programmimage _durch ein anderes_.
Programmargumente müssen spezifiziert werden. #hinweis[(`..l` als Liste, `..v` als Array)]

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

=== Zombie- & Orphan-Prozesse
$C$ ist zwischen seinem Ende und dem Aufruf von #wait durch $P$ ein Zombie-Prozess.
_Dauerhafter Zombie-Prozess:_ $P$ ruft wegen Fehler #wait nie auf.
_Orphan-Prozess:_ $P$ wird vor $C$ beendet. $P$ kann somit nicht mehr auf $C$ warten, was
bei Beendung von $C$ in einem dauerhaften Zombie resultiert. Wenn $P$ beendet wird, werden
deshalb alle $C$ an Prozess mit `pid=1` übertragen, der #wait in einer Endlosschleife aufruft.

*```c unsigned int sleep (unsigned int seconds)```:*
_unterbricht_ Ausführung, bis eine Anzahl Sekunden ungefähr verstrichen ist.
Gibt vom Schlaf noch vorhandene Sekunden zurück.\
*```c int atexit (void (*function)(void))```:*
Registriert Funktionen für Aufräumarbeiten vor Ende.\
*```c pid_t getpid()/getppid()```* geben die (Parent-)Prozess-ID zurück.

= Programme und Bibliotheken
`C-Quelle -> Präprozessor -> Bereinigte C-Quelle -> Compiler -> Assembler-Datei -> Assembler -> Objekt-Datei -> Linker -> Executable`\
_Präprozessor:_ Die Ausgabe des Präprozessors ist eine reine C-Datei (Translation-Unit) ohne
Makros, Kommentare oder Präprozessor-Direktiven.
_Linker:_ Der Linker verknüpft Objekt-Dateien (und statische Bibliotheken) zu Executables
oder dynamischen Bibliotheken.
_Loader_ lädt Executables und eventuelle dynamische Bibliotheken dieser in den Hauptspeicher.

== ELF (Executable and Linking Format)
_Binär-Format_, das Kompilate spezifiziert. Besteht aus #tcolor("grün", "Linking View")
#hinweis[(wichtig für Linker, für Object-Files und Shared Objects)] und
#tcolor("orange", "Execution View") #hinweis[(wichtig für Loader, für Programme und Shared Objects)].
*Struktur:*
Besteht aus _Header_,
#tcolor("orange", "Programm Header Table") #hinweis[(execution view)],
#tcolor("orange", "Segmente") #hinweis[(execution view)],
#tcolor("grün", "Section Header Table") #hinweis[(linking view)],
#tcolor("grün", "Sektionen") #hinweis[(linking view)]

== Segmente und Sektionen
#tcolor("orange", "Segmente") und #tcolor("grün", "Sektionen") sind eine andere Einteilung
für die gleichen Speicherbereiche. View des #tcolor("orange", "Loaders") sind die
#tcolor("orange", "Segmente"), view des #tcolor("grün", "Compilers") die #tcolor("grün", "Sektionen").
Definieren "gleichartige" Daten. Der _Linker_ vermittelt zwischen beiden Views.

*Header:*
Beschreibt den _Aufbau_ der Datei: Typ, 32/64-bit, Encoding, Maschinenarchitektur,
Entrypoint, Infos zu den Einträgen in PHT und SHT.\
#tcolor("orange", "Segment/Program Header Table und Segmente:") Tabelle mit $n$ Einträgen,
jeder Eintrag #hinweis[(je 32 Byte)] beschreibt ein Segment #hinweis[(Typ und Flags, Offset
und Grösse, virtuelle Adresse und Grösse im Speicher - kann unterschiedlich zur Dateigrösse
sein)]. Ist Verbindung zwischen Segmenten im RAM und im File.
Definiert, wo ein Segment liegt und wohin der Loader es im RAM laden soll.\
Segmente werden vom _Loader_ dynamisch _zur Laufzeit_ verwendet.\
#tcolor("grün", "Section Header Table und Sektionen:") Tabelle mit $m$ Einträgen ($!=n$).
Jeder Eintrag #hinweis[(je 40 Byte)] beschreibt eine Sektion #hinweis[(Name, Section-Typ,
Flags, Offset und Grösse, ...)].
Werden vom _Linker_ verwendet: Verschmilzt Sektionen und erzeugt auführbares Executable.\
*String-Tabelle:*
Bereich in der Datei, der nacheinander _null-terminierte Strings enthält_.
Strings werden relativ zum Beginn der Tabelle referenziert.\
*Symbole & Symboltabelle:*
Die Symboltabelle enthält jeweils _einen Eintrag je Symbol_
#hinweis[(16 Byte: 4B Name, 4B Wert, 4B Grösse, 4B Info)].

== Bibliotheken
*Statische Bibliotheken:*
Archive von Objekt-Dateien. Name: `lib<name>.a`, referenziert wird nur `<name>`.
_Linker_ behandelt statische Bibliotheken wie _mehrere Objekt-Dateien_. Ursprünglich gab es
_nur statische Bibliotheken_ #hinweis[(Einfach zu implementieren, aber Funktionalität fix)].\
*Dynamische Bibliotheken:*
Linken erst zur Ladezeit bzw. Laufzeit des Programms. Höherer Aufwand, jedoch austauschbar.
Executable enthält nur Referenz auf Bibliothek. *Vorteile:* Entkoppelter Lebenszyklus,
Schnellere Ladezeiten durch Lazy Loading, Flexibler Funktionsumfang.

== POSIX Shared Objects API
*```c void * dlopen (char * filename, int mode)```:*
_öffnet_ eine dynamische Bibliothek und gibt ein Handle darauf zurück. `mode`:
_`RTLD_NOW`:_ #hinweis[(Alle Symbole werden beim Laden gebunden)]
_`RTLD_LAZY`:_ #hinweis[(Symbole werden bei Bedarf gebunden)],
_`RTLD_GLOBAL`:_ #hinweis[(Symbole können beim Binden anderer Objekt-Dateien verwendet
werden)],
_`RTLD_LOCAL`:_ #hinweis[(Symbole werden nicht für andere OD verwendet)]\
*```c void * dlsym (void * handle, char * name)```:*
gibt die _Adresse des Symbols_ `name` aus der mit `handle` bezeichneten _Bibliothek_ zurück.
Keine Typinformationen #hinweis[(Variabel? Funktion?)]

```c
// type "func_t" is a address of a function with a int param and int return type
typedef int (*func_t)(int);
handle = dlopen("libmylib.so", RTLD_NOW); // open library
func_t f = dlsym(handle, "my_function"); // write "my_function" addr into a func_t
int *i = dlsym(handle, "my_int"); // get address of "my_int"
(*f)(*i); // call "my_function" with "my_int" as parameter
```

*```c int dlclose (void * handle)```:*
schliesst das durch `handle` bezeichnete, zuvor geöffnete Objekt.\
*```c char * dlerror()```:*
gibt Fehlermeldung als null-terminierten String zurück.

*Konventionen:*
Shared Objects können _automatisch_ bei Bedarf geladen werden.
Der Linker verwendet den Linker-Namen, der Loader verwendet den SO-Namen.
_Linker-Name:_ `lib + Bibliotheksname + .so` #hinweis[(z.B. libmylib.so)],
_SO-Name:_ `Linker-Name + . + Versionsnummer` #hinweis[(z.B. libmylib.so.2)],
_Real-Name:_ `SO-name + . + Unterversionsnummer` #hinweis[(z.B. libmylib.so.2.1)]\
*Shared Objects:*
Nahezu alle Executeables benötigen _zwei Shared Objects_:
_`libc.so`:_ Standard C library,
_`ld-linux.so`:_ ELF Shared Object loader #hinweis[(Lädt Shared Objects und rekursiv alle
Dependencies)].\
*Implementierung dynamischer Bibliotheken:*
Müssen verschiebbar sein, mehrere müssen in den gleichen Prozess geladen werden.
Die Aufgabe des Linkers wird in den Loader bzw. Dynamic Linker verschoben
#hinweis[(Load Time Relocation)].

== Shared Memory
Dynamische Bibliotheken sollen _Code zwischen Programmen teilen_. Code soll _nicht mehrfach_
im Speicher abgelegt werden. Mit Shared Memory kann jedes Programm eine _eigene virtuelle
Page_ für den Code definieren. Diese werden auf denselben Frame im RAM gemappt.
Benötigt _Position-Independendent Code_ #hinweis[(Adressen nur relativ zum Instruction
Pointer, Prozessor muss relative Instruktionen anbieten)].\
*Relative Moves via Relative Calls:*
Mittels Hilfsfunktion wird Rücksprungadresse in Register abgelegt, somit kann relativ dazu
gearbeitet werden.\
*Global Offset Table (GOT):*
Pro dynamische Bibliothek & Executable vorhanden, enthält pro Symbol einen Eintrag.
Der Loader füllt zur Laufzeit die Adressen in die GOT ein.\
*Procedure Linkage Table (PLT):*
Implementiert Lazy Binding. Enthält pro Funktion einen Eintrag, dieser enthält Sprungbefehl
an Adresse in GOT-Eintrag. Dieser zeigt auf eine Proxy-Funktion, welche den GOT-Eintrag
überschreibt. _Vorteil:_ erspart bedingten Sprung.

= Threads
Jeder _Prozess_ hat virtuell den _ganzen Rechner_ für _sich alleine_.
_Prozesse_ sind gut geeignet für _unabhängige Applikationen_.
Nachteile: Realisierung _paralleler Abläufe_ innerhalb derselben Applikation ist _aufwändig_.
_Overhead_ zu gross falls nur kürzere Teilaktivitäten, _gemeinsame Ressourcennutzung_ ist _erschwert_.

*Threads:*
_parallel ablaufende Aktivitäten innerhalb eines Prozesses_, welche auf _alle_ Ressourcen im
Prozess gleichermassen Zugriff haben. Benötigen _eigenen Kontext_ und _eigenen Stack_.
Informationen werden in einem _Thread-Control-Block_ abgelegt.

== Amdahls Regel
Nur bestimmte Teile eines Algorithmus können parallelisiert werden.
/ $T$: Ausführungszeit, wenn _komplett seriell_ durchgeführt
  #hinweis[Im Bild: $T = T_0 + T_1 + T_2 + T_3 + T_4 $]
/ $n$: Anzahl der Prozessoren
/ $T'$: Ausführungszeit, wenn _maximal parallelisiert_
  #hinweis[gesuchte Grösse]
/ $T_s$: Ausführungszeit für den Anteil, der _seriell_ ausgeführt werden _muss_
  #hinweis[Im Bild: $T_s = T_0 + T_2 + T_4$]
/ $T - T_s$: Ausführungszeit für den Anteil, der _parallel_ ausgeführt werden _kann_
  #hinweis[Im Bild: $T_1 + T_3$]

#wrap-content(
  image("img/bsys_25.png"),
  align: top + right,
  columns: (54%, 46%),
)[
  / $(T - T_s) / n$: Parallel-Anteil verteilt auf alle $n$ Prozessoren, Im Bild: $(T_1 + T_3) / n$

  / $T_s + (T - T_s) / n$: Serieller Teil + Paralleler Teil #hinweis[$= T^'$]

  Die _serielle Variante_ benötigt also höchstens _$f$ mal mehr Zeit_ als die _parallele Variante_:
]

#block($ f <= T / T^' = T / (T_s + (T - T_s) / n) $)
$f$ heisst auch _Speedup-Faktor_, weil die parallele Variante max. $f$-mal schneller ist als
die serielle.

Definiert man $s = T_s/T$, also den seriellen Anteil am Algorithmus, dann ist
$s dot T = T_s$. Dadurch erhält man $f$ unabhängig von der Zeit:

#block($
  f <= T / (T_s + (T - T_s) / n) = T / (s dot T + (T - s dot T) / n)
  = T / (s dot T + (1 - s) / n dot T) => f <= 1 / (s + (1 - s) / n)
$)

#wrap-content(
  image("img/bsys_26.png"),
  align: top + right,
  columns: (61%, 39%),
)[
  === Bedeutung
  - Abschätzung einer _oberen Schranke_ für den maximalen Geschwindigkeitsgewinn
  - Nur wenn _alles_ parallelisierbar ist, ist der Speedup _proportional_ und _maximal_
    #hinweis[$f(0,n) = n$]
  - Sonst ist der Speedup mit _höherer Prozessor-Anzahl_ immer _geringer_
    #hinweis[(Kurve flacht ab)]
  - $f(1,n)$: rein seriell

  *Grenzwert:* Mit höherer Anzahl Prozessoren nähert sich der Speedup $1/s$ an:
]

#grid(
  columns: (1fr, 1fr, 1fr),
  [$ lim_(n -> infinity) (1 - s) / n = 0 $],
  [$ lim_(n -> infinity) s + (1 - s) / n = s $],
  [$ lim_(n -> infinity) 1 / (s + (1 - s) / n) = 1 / s $],
)

== POSIX THREAD API
*```c int pthread_create(
    pthread_t * thread_id, pthread_attr_t const *attributes,
    void * (*start_function) (void *), void *argument)
```*
_erzeugt einen Thread_, die ID des neuen Threads wird im Out-Parameter `thread_id`
zurückgegeben. _`attributes`_ ist ein opakes Objekt, mit dem z.B. die Stack-Grösse
spezifiziert werden kann. Die erste auszuführende Instruktion ist die Funktion in
`start_function`. `argument` ist ein Pointer auf eine Datenstruktur auf dem Heap für die
Argumente für `start_function`.

#grid(
  columns: (40%, 60%),
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
      struct T * t = malloc (sizeof (struct T));
      t->value = 109;
      pthread_t tid;
      pthread_create (
        &tid,
        0, // default attributes
        &my_start,
        t);}
    ```
  ],
)

*Thread-Attribute:*
```c
pthread_attr_t attr; // Variabel erstellen
pthread_attr_init (&attr); // Variabel initialisieren
pthread_attr_setstacksize (&attr, 1 << 16); // 64kb Stackgrösse
pthread_create (..., &attr, ...); // Thread erstellen
pthread_attr_destroy (&attr); // Attribute löschen
```
*Lebensdauer:*
Lebt solange, bis er aus der Funktion _`start_function`_ zurückspringt, er _`pthread_exit`_
oder ein anderer Thread _`pthread_cancel`_ aufruft oder sein Prozess beendet wird.

*```c void pthread_exit (void *return_value)```:*
_Beendet_ den Thread und gibt den `return_value` zurück.
Das ist äquivalent zum Rücksprung aus `start_function` mit dem Rückgabewert.\
*```c int pthread_cancel (pthread_t thread_id)```:*
Sendet eine _Anforderung_, dass der Thread mit `thread_id` _beendet_ werden soll.
Die Funktion _wartet nicht_, dass der Thread _tatsächlich beendet_ wurde. Der Rückgabewert
ist 0, wenn der Thread existiert, bzw. `ESRCH` #hinweis[(error_search)], wenn nicht.\
*```c int pthread_detach (pthread_t thread_id)```:*
_Entfernt den Speicher_, den ein Thread belegt hat, falls dieser _bereits beendet_ wurde.
Beendet den Thread aber _nicht_. #hinweis[(Erstellt Daemon Thread)]\
*```c int pthread_join (pthread_t thread_id, void **return_value)```:*
_Wartet_ solange, bis der Thread mit `thread_id` _beendet_ wurde.
Nimmt den _Rückgabewert_ des Threads im Out-Parameter _`return_value`_ entgegen.
Dieser kann _`NULL`_ sein, wenn nicht gewünscht. Ruft _`pthread_detach`_ auf.\
*```c pthread_t pthread_self (void)```:*
Gibt die _ID_ des _gerade laufenden_ Threads zurück.

== Thread-Local Storage (TLS)
TLS ist ein Mechanismus, der _globale Variablen per Thread_ zur Verfügung stellt.
Dies benötigt mehrere explizite Einzelschritte:
*Bevor Threads erzeugt werden:*
Anlegen eines _Keys_, der die TLS-Variable _identifiziert_,
_Speichern_ des Keys in einer _globalen Variable_
*Im Thread:*
_Auslesen_ des Keys aus der globalen Variable,
_Auslesen / Schreiben_ des Werts anhand des Keys.

*```c int pthread_key_create(pthread_key_t *key, void (*destructor) (void*))```:*
Erzeugt einen _neuen Key_ im Out-Parameter `key`. _Opake Datenstruktur_.
Am Thread-Ende Call auf `destructor`.\
*```c int pthread_key_delete (pthread_key_t key)```:*
_Entfernt den Key_ und die entsprechenden Values aus allen Threads. Der Key darf nach diesem
Aufruf _nicht mehr verwendet_ werden. Sollte erst aufgerufen werden, wenn alle dazugehörende
Threads beendet sind.\
*```c int pthread_setspecific(pthread_key_t key, const void * value)```\
```c void * pthread_getspecific( pthread_key_t key )```*
_schreibt_ bzw. _liest_ den Wert, der mit dem Key in diesem Thread assoziiert ist.
Oft als _Pointer auf einen Speicherbereich_ verwendet.

#grid(
  columns: (auto,) * 2,
  [
    ```c
    // Setup
    typedef struct {
      int code;
      char *message;
    } error_t;
    pthread_key_t error;
    void set_up_error (void) {
      // am Anfang des Threads aufgerufen
      pthread_setspecific(
       error, malloc(sizeof(error_t)))}
    ```
  ],[
    ```c
    // Lesen und Schreiben im Thread
    void print_error (void) {
      error_t * e = pthread_getspecific(error);
      printf("Error %d: %s\n",
        e->code, e->message);}
    int force_error (void) {
      error_t * e = pthread_getspecific(error);
      e->code = 98;
      e->message = "file not found";
      return -1;}
    ```
  ])

```c
// Main und Thread
void *thread_function (void *) {
  setu_up_error();
  if (force_error () == -1) { print_error (); }
}
int main (int argc, char **argv) {
  pthread_key_create (&error, NULL); // Key erzeugen
  pthread_t tid;
  pthread_create (&tid, NULL, &thread_function, NULL); // Threads erzeugen
  pthread_join (tid, NULL);
}
```

= Scheduling
#wrap-content(
  image("img/bsys_27.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  Auf einem Prozessor läuft zu einem Zeitpunkt immer _höchstens ein Thread_.
  Es gibt folgende Zustände:
  _Running_ #hinweis[(der Thread, der gerade läuft)],
  _Ready_ #hinweis[(Threads die laufen können, es aber gerade nicht tun)],
  _Waiting:_ #hinweis[(Threads, die auf ein Ereignis warten, können nicht direkt in den
  Running State wechseln)].
  _Übergänge_ von einem Status zum anderen werden _immer vom OS_ vorgenommen.
  Dieser Teil vom OS heisst _Scheduler_.
]
#wrap-content(
  image("img/bsys_28.png"),
  align: top + right,
  columns: (40%, 60%),
)[
  Das OS _registriert Threads_ auf ein Ereignis und setzt sie in den Zustant "waiting".
  Tritt das Ereignis auf, ändert das OS den Zustand auf _ready_.
  #hinweis[(Es laufen nur Threads auf dem Prozessor, die _nicht warten_.)] \
  *Ready-Queue:*
  In der Ready-Queue #hinweis[(kann auch ein Tree sein)] befinden sich alle Threads, die
  _bereit sind zu laufen_.\
  *Powerdown-Modus:*
  Wenn kein Thread _laufbereit_ ist, schaltet das OS den Prozessor in _Standby_ und wird
  durch _Interrupt_ wieder geweckt.
]
*Arten von Threads:*
_I/O-lastig_ #hinweis[(Wenig rechnen, viel I/O-Geräte-Kommunikation)],
_Prozessor-lastig_ #hinweis[(Viel rechnen, wenig Kommunikation)]\
*Arten der Nebenläufigkeit:*
_Kooperativ_ #hinweis[(Threads entscheiden selbst über Abgabe des Prozessors)],
_Präemptiv_ #hinweis[(Scheduler entscheidet, wann einem Thread der Prozessor entzogen wird)]\
*Präemptives Multithreading:*
Thread läuft, bis er auf etwas zu _warten_ beginnt, Prozessor _yielded_,
ein _System-Timer-Interrupt_ auftritt oder ein _bevorzugter Thread_ erzeugt oder ready wird.\
*Parallele, quasiparallele und nebenläufige Ausführung:*
_Parallel_ #hinweis[(Tatsächliche Gleichzeitigkeit, $n$ Prozessoren für $n$ Threads)],
_Quasiparallel_ #hinweis[($n$ Threads auf $<n$ Prozessoren abwechselnd)],
_Nebenläufig_ #hinweis[(Überbegriff für parallel oder quasiparallel)]

#wrap-content(
  image("img/bsys_29.png"),
  align: top + right,
  columns: (37%, 63%),
)[
  *Bursts:*
  _Prozessor-Burst_ #hinweis[(Thread belegt Prozessor voll)],
  _I/O-Burst_ #hinweis[(Thread belegt Prozessor nicht)].
  Jeder Thread kann als _Abfolge_ von _Prozessor-Bursts_ und\ _I/O-Bursts_ betrachtet werden.
]

== Scheduling-Strategien
Anforderungen an einen Scheduler können vielfältig sein.
_Geschlossene Systeme_ #hinweis[(Hersteller kennt Anwendungen und ihre Beziehungen)] vs.
_Offene Systeme_ #hinweis[(Hersteller muss von typischen Anwendungen ausgehen)]

*Anwendungssicht, Minimierung von:*
_Durchlaufzeit_ #hinweis[(Zeit vom Starten des Threads bis zu seinem Ende)],
_Antwortzeit_ #hinweis[(Zeit vom Empfang eines Requests bis die Antwort zur Verfügung steht)],
_Wartezeit_ #hinweis[(Zeit, die ein Thread in der Ready-Queue verbringt)].\
*Aus Systemsicht, Maximierung von:*
_Durchsatz_ #hinweis[(Anzahl Threads, die pro Intervall bearbeitet werden)],
_Prozessor-Verwendung_ #hinweis[(Prozentsatz der Verwendung des Prozessors gegenüber der Nichtverwendung)]\
*Latenz*
ist die durchschnittliche Zeit zwischen Auftreten und Verarbeiten eines Ereignisses.
Im schlimmsten Fall tritt das Ereignis dann auf, wenn der Thread gerade vom Prozessor
entfernt wurde. Um die Antwortzeit zu verringern, muss jeder Thread öfters ausgeführt
werden, was jedoch zu mehr Thread-Wechsel und somit zu mehr Overhead führt.
_Die Utilization nimmt also ab, wenn die Antwortzeit verringert wird._

*Idealfall: Parallele Ausführung* #hinweis[(Dient als _idealisierte Schranke_)]
#image("img/bsys_30.png", width: 80%)

*FCFS-Strategie* #hinweis[(First Come, First Served)]\
_Nicht präemptiv:_ Threads geben den Prozessor nur ab, wenn sie auf waiting wechseln oder
sich beenden.
#image("img/bsys_31.png", width: 80%)

*SJF-Strategie* #hinweis[(Shortest Job First)]\
Scheduler wählt den Thread aus, der den _kürzesten_ Prozessor-Burst hat. Bei gleicher Länge
wird nach FCFS ausgewählt. Kann _kooperativ_ oder _präemptiv_ sein. Ergibt _optimale
Wartezeit_, kann jedoch nur _korrekt implementiert_ werden, wenn die Länge der Bursts
_bekannt_ sind.
#image("img/bsys_32.png", width: 80%)

*Round-Robin:*
_Zeitscheibe_ von etwa 10 bis 100ms. _FCFS_, aber ein Thread kann nur solange laufen,
bis seine _Zeitscheibe erschöpft_ ist, dann wird der in der _Queue hinten angehängt_.
#image("img/bsys_33.png", width: 80%)

*Prioritäten-basiert:*
Jeder Thread erhält _eine Nummer_, seine _Priorität_. Threads mit höherer Priorität werden
vor Threads mit niedriger Priorität ausgewählt. Threads mit gleicher Priorität werden nach
FCFS ausgewählt. Prioritäten je nach OS unterschiedlich.\
*Starvation:*
Thread mit niedriger Priorität wird immer _übergangen_ und kann nie laufen.
Abhilfe z.B. mit _Aging:_ in bestimmten Abständen wird die Priorität um 1 erhöht.\
*Multi-Level Scheduling:*
Threads werden in _Level_ aufgeteilt #hinweis[(Priorität, Prozesstyp, Hinter-/Vordergrund)],
jedes Level hat eigene Ready-Queue und kann individuell geschedulet werden.
#hinweis[(zB. Timeslice/Queue)]\
*Multi-Level Scheduling mit Feedback:*
Erschöpft ein Thread seine Zeitscheibe, wird seine Priorität um 1 verringert.
Typischerweise werden die Zeitscheiben mit _niedrigerer Priorität grösser_ und Threads mit
_kurzen Prozessor-Bursts bevorzugt_. Threads in tiefen Queues dürfen zum Ausgleich länger am
Stück laufen.
#image("img/bsys_34.png", width: 80%)

== Prioritäten in POSIX
*Nice-Wert:*
Jeder Prozess hat einen Nice-Wert von $-20$ #hinweis[(soll bevorzugt werden)]
bis $+19$ #hinweis[(nicht bevorzugt)]
*```sh nice [-n increment] utility [argument...]```:*
Nice-Wert beim Start erhöhen oder verringern\
*```c int nice (int i)```:*
Nice-Wert im Prozess erhöhen oder verringern. #hinweis[(Addiert `i` zum Wert dazu.)]\
*```c int getpriority (int which, id_t who)```:*
gibt den Nice-Wert von $p$ zurück\
*```c int setpriority (int which, id_t who, int prio)```:*
setzt den Nice-Wert.\
#hinweis[(_`which`:_ `PRIO_PROCESS`, `PRIO_PGRP` oder `PRIO_USER`,
  _`who`:_ ID des Prozesses, der Gruppe oder des Users)]

==== Priorität bei Thread-Erzeugung setzen
Funktionen ohne `attr` bevor Thread gestartet wird:\
```c int pthread_getschedparam(pthread_t thread, int * policy, struct sched_param * param)```
bzw. ```c int pthread_setschedparam(pthread_t thread, int policy, const struct sched_param * param)```
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
= Mutexe und Semaphore
Jeder Thread hat seinen _eigenen_ Instruction-Pointer und Stack-Pointer. Wenn Ergebnisse von
der _Ausführungsreihenfolge_ einzelner Instruktionen abhängen, spricht man von einer _Race
Condition_. Threads müssen _synchronisiert_ werden, damit keine _Race Condition_ entsteht.\
*Critical Section:*
Code-Bereich, in dem Daten mit anderen Threads _geteilt_ werden. Muss unbedingt
synchronisiert werden.\
*Atomare Instruktionen:*
Eine atomare Instruktion kann vom Prozessor _unterbrechungsfrei_ ausgeführt werden.
#hinweis[*Achtung:* Selbst einzelne Assembly-Instruktionen nicht immer atomar]\
*Anforderungen an Synchronisations-Mechanismen:*
_Gegenseitiger Ausschluss_ #hinweis[(Nur ein Thread darf in Critical Section sein)],
_Fortschritt_ #hinweis[(Entscheidung, wer in die Critical Section darf, muss in endlicher Zeit getroffen werden)],
_Begrenztes Warten_ #hinweis[(Thread wird nur $n$ mal übergangen, bevor er in die Critical Section darf)].\
*Implementierung:*
Nur _mit HW-Unterstützung_ möglich. Es gibt zwei atomare Instruktionen,
_Test-And-Set_ #hinweis[(Setzt einen `int` auf 1 und returnt den vorherigen Wert:
```c test_and_set(int * target) {int value = *target; *target = 1; return value;}```)] und
_Compare-and-Swap_ #hinweis[(Überschreibt einen `int` mit einem spezifizierten Wert, wenn
dieser dem erwarteten Wert entspricht:
```c compare_and_swap (int *a, int expected, int new_a) {int value = *a; if (value == expected) { *a = new_a; } return value;}```)].

== Semaphore
Enthält Zähler $z >= 0$. Wird nur über _`Post(v)`_ #hinweis[(Erhöht $z$ um 1)] und
_`Wait(v)`_ zugegriffen #hinweis[(Wenn $z > 0$, verringert $z$ um $1$ und fährt fort.
Wenn $z = 0$, setzt den Thread in waiting, bis anderer Thread $z$ erhöht)].\
*```c int sem_init (sem_t *sem, int pshared, unsigned int value)```:*
_Initialisiert_ den Semaphor, typischerweise als _globale Variable_.
`pshared = 1`: Verwendung über mehrere Prozesse: ```c sem_t sem; int main ( int argc, char ** argv ) { sem_init (&sem, 0, 4); }```
oder als Parameter für den Thread #hinweis[(Speicher auf dem Stack oder Heap)]:
```c struct T { sem_t *sem; ... };```

*```c int sem_wait (sem_t *sem); int sem_post (sem_t *sem)```:*
implementieren _Post_ und _Wait_.
*```c int sem_trywait (sem_t *sem); int sem_timedwait (sem_t *sem, const struct timespec *abs_timeout)```:*
Sind wie `sem_wait`, aber _brechen ab_, falls Dekrement _nicht_ durchgeführt werden kann.
`sem_trywait` bricht sofort ab, `sem_timedwait` nach der angegebenen Zeitdauer.\
*```c int sem_destroy (sem_t *sem)```:*
_Entfernt Speicher_, den das OS mit `sem` _assoziiert_ hat.

```c
semaphore free = n;
semaphore used = 0;
```
#grid(
  columns: (auto, auto),
  [
    ```c
    // Producer
    while (1) {
      // Warte, falls Customer zu langsam
      WAIT (free); // Hat es Platz in Queue?
      produce_item (&buffer[w], ...);
      POST (used); // 1 Element mehr in Queue
      w = (w+1) % BUFFER_SIZE;
    }
    ```
  ],
  [
    ```c
    // Consumer
    while (1) {
      // Warte, falls Producer zu langsam
      WAIT (used); // Hat es Elemente in Queue?
      consume (&buffer[r]);
      POST (free); // 1 Element weniger in Q
      r = (r+1) % BUFFER_SIZE;
    }
    ```
  ],
)

== Mutexe
Ein Mutex hat einen _binären Zustand $bold(z)$_, der nur durch zwei Funktionen verändert werden kann:
_Acquire_ #hinweis[(Wenn $z = 0$, setze $z$ auf 1 und fahre fort. Wenn $z = 1$, blockiere
den Thread, bis $z = 0$)],
_Release_ #hinweis[(Setzt $z = 0$)]. Auch als non-blocking-Funktion:
```c int pthread_mutex_trylock (pthread_mutex_t *mutex)```

#grid(
  columns: (auto, auto),
  [
    ```c
      // Beispiel Initialisierung
      pthread_mutex_t mutex; // global
      int main() {
        pthread_mutex_init (&mutex, 0);
        // run threads & wait for them to finish
        pthread_mutex_destroy (&mutex);
    }
    ```
  ],
  [
    ```c
    // Beispiel Verwendung in Threads
    void * thread_function (void * args) {
      while (running) { ...
        // Enter critical section:
        pthread_mutex_lock (&mutex);
        // Leave critical section:
        pthread_mutex_unlock (&mutex);...}}
    ```
  ],
)

*Priority Inversion:*
Ein _hoch-priorisierter_ Thread $C$ wartet auf eine Ressource, die von einem _niedriger
priorisierten_ Thread $A$ _gehalten_ wird. Ein Thread mit Prioriät zwischen diesen beiden
Threads erhält den Prozessor. Kann mit *Priority Inheritance* gelöst werden: Die Priorität
von $A$ wird temporär auf die Priorität von $C$ gesetzt, damit der Mutex schnell wieder
freigegeben wird.

= Signale, Pipes und Sockets
== Signale
Signale ermöglichen es, einen Prozess _von aussen_ zu unterbrechen, wie ein _Interrupt_.
_Unterbrechen_ des gerade laufenden Prozesses/Threads, Auswahl und Ausführen der
_Signal-Handler-Funktionen_, _Fortsetzen_ des Prozesses. Werden über ungültige Instruktionen
oder Abbruch auf Seitens Benutzer ausgelöst. Jeder Prozess hat pro Signal einen Handler.\
*Handler:*
_Ignore-Handler_ #hinweis[(ignoriert das Signal)],
_Terminate-Handler_ #hinweis[(beendet das Programm)],
_Abnormal-Terminate-Handler_ #hinweis[(beendet Programm und erzeugt Core-Dump)].
Fast alle Signale ausser `SIGKILL` und `SIGSTOP` können _überschrieben_ werden.\
*Programmfehler-Signale:*
_`SIGFPE`_ #hinweis[(Fehler in arithmetischen Operation)],
_`SIGILL`_ #hinweis[(Ungültige Instruktion)],
_`SIGSEGV`_ #hinweis[(Ungültiger Speicherzugriff)],
_`SIGSYS`_ #hinweis[(Ungültiger Systemaufruf)]\
*Prozesse abbrechen:*
_`SIGTERM`_ #hinweis[(Normale Anfrage an den Prozess, sich zu beenden)],
_`SIGINT`_ #hinweis[(Nachdrücklichere Aufforderung an den Prozess, sich zu beenden)],
_`SIGQUIT`_ #hinweis[(Wie `SIGINT`, aber anormale Terminierung)],
_`SIGABRT`_ #hinweis[(Wie `SIGQUIT`, aber vom Prozess an sich selber)],
_`SIGKILL`_ #hinweis[(Prozess wird "abgewürgt", kann nicht verhindert werden)]\
*Stop and Continue:*
_`SIGTSTP`_ #hinweis[(Versetzt den Prozess in den Zustand _stopped_, ähnlich wie _waiting_)],
_`SIGSTOP`_ #hinweis[(Wie `SIGTSTP`, aber kann nicht ignoriert oder abgefangen werden)],
_`SIGCONT`_ #hinweis[(Setzt den Prozess fort)]\
*Signale von der Shell senden:*
_`kill 1234 5678`_ sendet `SIGTERM` an Prozesse `1234` und `5678`\
*```c int sigaction (int signal, struct sigaction *new, struct sigaction *old)```:*\
Definiert Signal-Handler für `signal`, wenn `new` $!= 0$.
#hinweis[(Eigene Signal-Handler definiert via `sigaction` struct:
  `sa_handler`: Zu callende Funktion,
  `sa_mask`: Blockierte Signale während Ausführung,
  bearbeitet nur durch `sig*set()`-Funktionen:
  `sigemptyset`, `sigfillset`, `sigaddset`, `sigdelset`, `sigismember`)]\

== Pipes
Eine geöffnete Datei entspricht einem _Eintrag in der File-Descriptor-Tabelle (FDT)_ im
Prozess. Zugriff über _File-API_ #hinweis[(`open`, `close`, `read`, `write`, ...)].
Das OS speichert _je Eintrag der Prozess-FDT_ einen _Verweis auf die globale FDT_.
Bei `fork()` wird die FDT auch kopiert.\
*```c int dup (int source_fd); int dup2 (int source_fd, int destination_fd)```:*
_Duplizieren_ den File-Descriptor `source_fd`. _`dup`_ alloziert einen neuen FD,
_`dup2`_ überschreibt `destination_fd`.

=== Umleiten des Ausgabestreams
```c
int fd = open ("log.txt", ...);
int id = fork ();
if (id == 0) { // child
  dup2 (fd, 1); // duplicate fd for log.txt as standard output
  // e.g. load new image with exec*, fd's remain
} else { /* parent */ close (fd); }
```

Eine *Pipe* ist eine "Datei" #hinweis[(Eine Datei muss nur `open`, `close` etc.
unterstützen)] im Hauptspeicher, die über zwei File-Deskriptoren verwendet wird:
_read end_ und _write end_. Daten, die in _write end_ geschrieben werden, können aus
_read end_ genau _einmal_ und als _FIFO_ gelesen werden. Pipes erlauben _Kommunikation über
Prozess-Grenzen hinweg_. Ist unidirektional.
#grid(
  columns: (50%, auto),
  gutter: 0.5em,
  [
    ```c
    int fd [2]; // 0 = read, 1 = write
    pipe (fd);
    int id = fork();
    ```
    Pipe lebt nur so lange, wie mind. ein Ende geöffnet ist. Alle Read-Ends geschlossen
    #sym.arrow `SIGPIPE` an Write-End. Mehrere Writes können zusammengefasst werden.
    Lesen mehrere Prozesse dieselbe Pipe, ist unklar, wer die Daten erhält.
  ],
  [
    ```c
    if (id == 0) { // Child
      close (fd [1]); // don't use write end
      char buffer [BSIZE];
      int n = read (fd[0], buffer, BSIZE);
    } else {
      close (fd[0]); // don't use read end
      char * text = "La li lu";
      write (fd [1], text, strlen(text) + 1);
    }
    ```
  ],
)

*```c int mkfifo (const char *path, mode_t mode)```:*
Erzeugt eine Pipe _mit Namen und Pfad_ im Dateisystem. Hat via `mode` permission bits wie
normale Datei. Lebt unabhängig vom erzeugenden Prozess, je nach System auch über Reboots
hinweg. Muss explizit mit `unlink` gelöscht werden.

== Sockets
Ein Socket _repräsentiert einen Endpunkt auf einer Maschine_.
Kommunikation findet im Regelfall zwischen zwei Sockets statt
#hinweis[(UDP, TCP über IP sowie Unix-Domain-Sockets)].
Sockets benötigen für Kommunikation einen Namen: #hinweis[(IP: IP-Adresse, Portnr.)]\
*```c int socket(int domain, int type, int protocol)```: *
_Erzeugt_ einen neuen Socket als "Datei". Socket sind nach Erzeugung zunächst _unbenannt_.
Alle Operationen blockieren per default.\
_`Domain`_ #hinweis[(`AF_UNIX`, `AF_INET`)],
_`type`_ #hinweis[(`SOCK_DGRAM`, `SOCK_STREAM`)],
_`protocol`_ #hinweis[(System-spezifisch, 0 = Default-Protocol)]\
*Client:*
_`connect`_ #hinweis[(Verbindung unter Angabe einer Adresse aufbauen)],
_`send` / `write`_ #hinweis[(Senden von Daten, $0 - infinity$ mal)],
_`recv` / `read`_ #hinweis[(Empfangen von Daten, $0 - infinity$ mal)],
_`close`_ #hinweis[(Schliessen der Verbindung)]\
*Server:*
_`bind`_ #hinweis[(Festlegen einer nach aussen sichtbaren Adresse)],
_`listen`_ #hinweis[(Bereitstellen einer Queue zum Sammeln von Verbindungsanfragen von Clients)],
_`accept`_ #hinweis[(Erzeugen einer Verbindung auf Anfrage von Client)],
_`recv` / `read`_ #hinweis[(Empfangen von Daten, $0 - infinity$ mal)],
_`send` / `write`_ #hinweis[(Senden von Daten, $0 - infinity$ mal)],
_`close`_ #hinweis[(Schliessen der Verbindung)]\

```c
struct sockaddr_in ip_addr;
ip_addr.sin_port = htons (443); // default HTTPS port
inet_pton (AF_INET, "192.168.0.1", &ip_addr.sin_addr.s_addr);
// port in memory: 0x01 0xBB
// addr in memory: 0xC0 0xA8 0x00 0x01
```

_`htons`_ konvertiert 16 Bit von Host-Byte-order #hinweis[(LE)] zu Network-Byte-Order
#hinweis[(BE)], _`htonl`_ 32 Bit. _`ntohs`_ und _`ntohl`_ sind Gegenstücke
_`inet_pton`_ konvertiert protokoll-spezifische Adresse von String zu Network-BO.
_`inet_ntop`_ ist das Gegenstück #hinweis[(network-to-presentation)].\
*```c int bind (int socket, const struct sockaddr *local_address, socklen_t addr_len)```:*
_Bindet_ den Socket an die angegebene, unbenutze lokale Adresse, wenn noch nicht gebunden.
Blockiert, bis der Vorgang abgeschlossen ist.\
*```c int connect (int socket, const struct sockaddr *remote_addr, socklen_t addr_len)```:*
_Aufbau_ einer Verbindung. Bindet den Socket an eine neue, unbenutzte lokale Addresse, wenn
noch nicht gebunden. Blockiert, bis Verbindung steht oder ein Timeout eintritt.\
*```c int listen (int socket, int backlog)```:*
_Markiert_ den Socket als "bereit zum Empfang von Verbindungen". Erzeugt eine Warteschlange,
die so viele Verbindungsanfragen aufnehmen kann, wie `backlog` angibt.\
*```c int accept (int socket, struct sockaddr *remote_address, socklen_t address_len)```:*
_Wartet_ bis eine Verbindungsanfrage in der Warteschlange eintrifft.
Erzeugt einen neuen Socket und bindet ihn an eine neue lokale Adresse. Die Adresse des
Clients wird in `remote_address` geschrieben. Der neue Socket kann keine weiteren
Verbindungen annehmen, der bestehende schon.

=== Typisches Muster für Server
```c
int server_fd = socket ( ... ); bind (server_fd, ...); listen (server_fd, ...);
while (running) {
  int client_fd = accept (server_fd, 0, 0);
  delegate_to_worker_thread (client_fd); // will call close(client_fd)
}
```

*```c send (fd, buf, len, 0) = write (fd, buf, len); recv (fd, buf, len, 0) = read (fd, buf, len)```:*
_Senden und Empfangen von Daten_. Puffern der Daten ist Aufgabe des Netzwerkstacks.\
*```c int close (int socket)```:*
_Schliesst_ den Socket für den aufrufenden Prozess. Hat ein anderer Prozess den Socket noch
geöffnet, bleibt die Verbindung bestehen. Die Gegenseite wird nicht benachrichtigt.
*```c int shutdown (int socket, int mode)```:*
_Schliesst_ den Socket für alle Prozesse und baut die entsprechende Verbindung ab. `mode`:
_`SHUT_RD`_ #hinweis[(Keine Lese-Zugriffe mehr)],
_`SHUT_WR`_ #hinweis[(Keine Schreib-Zugriffe mehr)],
_`SHUT_RDWR`_ #hinweis[(Keine Lese- oder Schreib-Zugriffe mehr)]


= Message Passing und Shared Memory
Prozesse sind voneinander isoliert, müssen jedoch trotzdem miteinander interagieren.
_Message-Passing_ ist ein Mechanismus mit zwei Operationen:
_Send_ #hinweis[(Kopiert die Nachricht _aus_ dem Prozess: ```c send (message)```)],
_Receive:_ #hinweis[(Kopiert die Nachricht _in_ den Prozess: ```c receive (message)```)].
Dabei können Implementierungen nach verschiedenen Kriterien unterschieden werden
#hinweis[(Feste oder Variable Nachrichtengrösse, direkte oder indirekte / synchrone oder
  asynchrone Kommunikation, puffering, mit oder ohne Prioriäten für Nachrichten)]\
*Feste oder variable Nachrichtengrösse:*
feste Nachrichtengrösse ist einfacher zu implementieren, aber umständlicher zu verwenden als
variable Nachrichtengrösse.\
*Direkte Kommunikation:*
Kommunikation nur zwischen genau zwei Prozessen, Sender muss Empfänger kennen. Es gibt
_symmetrische direkte Kommunikation_ #hinweis[(Empfänger muss Sender auch kennen)] und
_asymmetrische direkte Kommunikation_ #hinweis[(Empfänger muss Sender nicht kennen)].\
*Indirekte Kommunikation:*
Prozess sendet Nachricht an _Mailboxen, Ports oder Queues_. Empfänger empfängt aus diesem
Objekt. Beide Teilnehmer müssen die gleiche(n) Mailbox(en) kennen.\
*Lebenszyklus Queue:*
Wenn diese Queue einem Prozess gehört, lebt sie solange wie der Prozess.
Wenn sie dem OS gehört, muss das OS das Löschen übernehmen.\
*Synchronisation:*
_Blockierendes Senden_ #hinweis[(Sender wird solange blockiert, bis die Nachricht vom Empfänger empfangen wurde)],
_Nicht-blockierendes Senden_ #hinweis[(Sender sendet Nachricht und fährt sofort weiter)],
_Blockierendes Empfangen_ #hinweis[(Empfänger wird blockiert, bis Nachricht verfügbar)],
_Nicht-blockierendes Empfangen_ #hinweis[(Empfänger erhält Nachricht, wenn verfügbar, oder 0)]\
*Rendezvous:*
Sind Empfang und Versand _beide blockierend_, kommt es zum Rendezvous, sobald beide Seiten
ihren Aufruf getätigt haben. _Impliziter Synchronisationsmechanismus_.

#grid(
  columns: (auto, auto),
  gutter: 0.5em,
  [
    ```c
    // Producer
    message msg;
    open (Q);
    while (1) {
      produce_next (&msg);
      send (Q, &msg); // blocked until sent
    }
    ```
  ],
  [
    ```c
    // Consumer
    message msg;
    open (Q);
    while (1) {
      receive (Q, &msg); // blocked until rec.
      consume_next (&msg);
    }
    ```
  ],
)

*Pufferung:*
_Keine_ #hinweis[(Queue-Länge ist 0, Sender muss blockieren)],
_Beschränkte_ #hinweis[(Maximal $n$ Nachrichten, Sender blockiert, wenn Queue voll ist.)],
_Unbeschränkte_ #hinweis[(Beliebig viele Nachrichten, Sender blockiert nie)].\
*Prioriäten:*
In manchen Systemen können Nachrichten mit _Prioritäten_ versehen werden.
Der Empfänger holt die Nachricht mit der _höchsten Priorität zuerst_ aus der Queue.

=== POSIX Message-Passing
OS-Message-Queues mit _variabler Länge_, haben mind. 32 Prioritäten und können
_synchron und asynchron_ verwendet werden.\
*```c mqd_t mq_open (const char *name, int flags, mode_t mode, struct mq_attr *attr)```:*
_Öffnet_ eine Message-Queue mit systemweitem `name`, returnt Message-Queue-Descriptor.
#hinweis[(`name` mit `/` beginnen, `flags` & `mode` wie bei Dateien,
  `mq_attr`: Div. Konfigs & Queue-Status, R/W mit `mp_getattr`/`mq_setattr`)]\
*```c int mq_close (mqd_t queue)```:*
_Schliesst_ die Queue mit dem Descriptor `queue` für diesen Prozess.\
*```c int mq_unlink (const char *name)```:*
_Entfernt_ die Queue mit dem Namen `name` aus dem System.
_Name_ wird _sofort entfernt_ und Queue kann anschliessend _nicht mehr geöffnet_ werden.\
*```c int mq_send (mqd_t queue, const char *msg, size_t length, unsigned int priority)```:*
_Sendet_ die Nachricht, die an Adresse `msg` beginnt und `length` Bytes lang ist,
in die `queue`.\
*```c int mq_receive (mqd_t queue, const char *msg, size_t length, unsigned int *priority)```:*
_Kopiert_ die nächste Nachricht aus der Queue in den Puffer, der an Adresse `msg` beginnt
und `length` Bytes lang ist.
_Blockiert_, wenn die Queue _leer_ ist.

== Shared Memory
Frames des Hauptspeichers werden _zwei (oder mehr) Prozessen_ $P_1$ und $P_2$ _zugänglich_
gemacht. In $P_1$ wird Page $V_1$ auf einen Frame $F$ abgebildet. In $P_2$ wird Page $V_2$
auf _denselben_ Frame $F$ abgebildet. Beide Prozesse können _beliebig_ auf dieselben Daten
zugreifen. Im Shared Memory müssen _relative Adressen_ verwendet werden.

=== POSIX API
Das OS benötigt eine "Datei" _$bold(S)$_, das Informationen über den gemeinsamen Speicher
verwaltet und eine _Mapping Table_ je Prozess.

*```c int fd = shm_open ("/mysharedmemory", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR)```:*\
Erzeugt falls nötig und öffnet Shared Memory /mysharedmemory zum Lesen und Schreiben.\
*```c int ftruncate (int fd, offset_t length)```:*
_Setzt_ Grösse der "Datei". Muss _zwingend_ nach SM-Erstellung gesetzt werden, um
entsprechend viele Frames zu allozieren.
Wird für Shared Memory mit ganzzahligen Vielfachen der Page-/Framegrösse verwendet.\
*```c int close (int fd)```:*
_Schliesst_ "Datei". Shared Memory _bleibt aber im System_.\
*```c int shm_unlink (const char * name)```:*
_Löscht_ das Shared Memory mit dem `name`.
#hinweis[(bleibt vorhanden, solange noch von Prozess geöffnet)]\
*```c int munmap (void *address, size_t length)```:*
_Entfernt_ das Mapping.
```c
void * address = mmap( // maps the shared memory into virt. address space of process
  0,                      // void *hint_address (0 because nobody cares)
  size_of_shared_memory,  // size_t length (same as used in ftruncate)
  PROT_READ | PROT_WRITE, // never use execute
  MAP_SHARED,             // int flags
  fd,                     // int file_descriptor
  0                       // off_t offset (start map from first byte)
);
```

== Vergleich Message-Passing und Shared Memory
_Shared Memory_ ist schneller zu realisieren, aber schwer wartbar.
_Message-Passing_ erfordert mehr Engineering-Aufwand, schlussendlich aber in
Mehr-Prozessor-Systemen bald performanter.


== Vergleich Message-Queues und Pipes
#table(
  columns: (auto, 1fr),
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

= Unicode
== ASCII - American Standard Code for Information Interchange
Hat _128 definierte Zeichen_ #hinweis[(erste Hexzahl = Zeile, zweite Hexzahl = Spalte,
d.h. #hex("41") = `A`)].
#image("img/bsys_40.png")

*Codepages:*
unabhängige Erweiterungen auf 8 Bit. Jede ist unterschiedlich und nicht erkennbar.\
*Unicode:*
Hat zum Ziel, einen eindeutigen Code für _jedes vorhandene Zeichen_ zu definieren.
#hex("D8 00") bis #hex("DF FF") sind wegen UTF-16 keine gültigen Code-Points.\
*Code-Points (CP):*
Nummer eines Zeichen - "welches Zeichen?"\
*Code-Unit (CU):*
Einheit, um Zeichen in einem Encoding darzustellen #hinweis[(bietet den Speicherplatz)]\
#hinweis[_$bold(P_i) =$_ $i$-tes Bit des unkodierten CPs,
  _$bold(U_i) =$_ $i$-tes Code-Unit des kodierten CPs,
  _$bold(B_i) =$_ $i$-tes Byte des kodierten CPs]

== UTF-32
Jede CU umfasst _32 Bit_, jeder CP kann mit _einer CU_ dargestellt werden. Direkte Kopie der
Bits in die CU bei Big Endian, bei Little Endian werden $P_0$ bis $P_7$ in $B_3$ kopiert usw.
Wird häufig intern in Programmen verwendet. Obere 11 Bits oft "zweckentfremdet".

#image("img/bsys_43.png")

== UTF-16
Jede CU umfasst _16 Bit_, ein CP benötigt _1 oder 2 CUs_. Encoding muss Endianness
berücksichtigen. Die 2 CUs werden Surrogate Pair genannt, $U_0$: high surrogate,
$U_1$: low surrogate. Bei _2 Bytes_ #hinweis[(1 CU)] wird direkt gemappt und vorne mit
Nullen aufgefüllt. Bei _4 Bytes_ sind #hex("D800") bis #hex("DFFF") #hinweis[(Bits 17-21)]
wegen dem Separator _ungültig_ und müssen "umgerechnet" werden.\

#image("img/bsys_45.png")

==== Beispiel
Encoding von U+10'437 (\u{10437})
#hinweis[#fxcolor("grün", bits("00 0100 0001", suffix: false))
#fxcolor("gelb", bits("00 0011 0111"))]:

1. Code-Point $P$ minus #hex("10000") rechnen und in Binär umwandlen\
  $P = hex("10437"), Q = hex("10437") - hex("10000") = hex("0437")
    = fxcolor("grün", #bits("00 0000 0001", suffix: false)) fxcolor("gelb", bits("00 0011 0111"))$
2. Obere & untere 10 Bits in Hex umwandlen\
  $fxcolor("grün", #hex("0001", suffix: false)) fxcolor("gelb", hex("0137"))$\
3. Oberer Wert mit #hex("D800") und unterer Wert mit #hex("DC00") addieren, um Code-Units zu erhalten\
  $U_1 = fxcolor("grün", hex("0001")) + hex("D800") = fxcolor("orange", hex("D801")),
    U_2 = fxcolor("gelb", hex("0137")) + hex("DC00") = fxcolor("hellblau", hex("DD37"))$\
4. Zu BE/LE zusammensetzen\
  $"BE" = underline(fxcolor("orange", #hex("D801", suffix: false)) thin
  fxcolor("hellblau", hex("DD37"))), thick
    "LE" = underline(fxcolor("orange", #hex("01D8", suffix: false)) thin
  fxcolor("hellblau", hex("37DD")))$

== UTF-8
Jede CU umfasst _8 Bit_, ein CP benötigt _1 bis 4 CUs_. Encoding muss Endianness _nicht_
berücksichtigen. Standard für Webpages. Echte Erweiterung von ASCII.
#let nextCU = bits("10xx xxxx")
#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header([Code-Point in], [$bold(U_3)$], [$bold(U_2)$], [$bold(U_1)$], [$bold(U_0)$], [signifikant]),
  [#hex("0") - #hex("7F")], [], [], [], [#bits("0xxx xxxx")], [7 bits],
  [#hex("80") - #hex("7FF")], [], [], [#bits("110x xxxx")], [#nextCU], [11 bits],
  [#hex("800") - #hex("FFFF")], [], [#bits("1110 xxxx")], [#nextCU], [#nextCU], [16 bits],
  [#hex("10000") - #hex("10FFFF")], [#bits("1111 0xxx")], [#nextCU], [#nextCU], [#nextCU], [21 bits],
)
#image("img/bsys_44.png")

==== Beispiele
- _ä_: $P = hex("E4") = fxcolor("grün", #bits("00011", suffix: false)) thin
  fxcolor("gelb", bits("10 0110"))$\
  $=> P_10 ... P_6 = fxcolor("grün", bits("00011")) = fxcolor("rot", hex("03")),
    P_5 ... P_0 = fxcolor("gelb", bits("100100")) = fxcolor("orange", hex("24"))$\
  $=> U_1 = hex("C0") (= bits("11000000")) + fxcolor("rot", hex("03")) = hex("C3"),
    U_0 = hex("80") (= bits("10000000")) + fxcolor("orange", hex("24")) = hex("A4")$\
  $=> ä = underline(hex("C3 A4"))$
- _ặ_: $P = hex("1EB7") = fxcolor("grün", #bits("0001", suffix: false)) thin
    fxcolor("gelb", #bits("111010", suffix: false)) thin fxcolor("hellblau", bits("110111"))$\
  $=> P_15 ... P_12 = fxcolor("grün", hex("01")),
    P_11 ... P_6 = fxcolor("gelb", hex("3A")),
    P_5 ... P_0 = fxcolor("hellblau", hex("37"))$\
  $=> U_2 = hex("E0") (= #bits("11100000")) + fxcolor("grün", hex("01")) = hex("E1"),
    U_1 = hex("80") + fxcolor("gelb", hex("3A")) = hex("BA"),
    U_0 = hex("80") + fxcolor("hellblau", hex("37")) = hex("B7")$\
  $=> ặ = underline(hex("E1 BA B7"))$

== Encoding-Beispiele
#{
  set text(size: 0.94em)
  table(
    align: (_, y) => if (y == 0) { left } else { right },
    columns: (auto,) + (1fr,) * 6,
    table.header([Zeichen], [Code-Point], [UTF-32BE], [UTF-32LE], [UTF-8], [UTF-16BE], [UTF-16LE]),
    [A],[#hex("41")],[#hex("00 00 00 41")],[#hex("41 00 00 00")],[#hex("41")],[#hex("00 41")],[#hex("41 00")],
    [ä],[#hex("E4")],[#hex("00 00 00 E4")],[#hex("E4 00 00 00")],[#hex("C3 A4")],[#hex("00 E4")],[#hex("E4 00")],
    [$alpha$],[#hex("3 B1")],[#hex("00 00 03 B1")],[#hex("B1 03 00 00")],[#hex("CE B1")],[#hex("03 B1")],[#hex("B1 03")],
    [ặ],[#hex("1E B7")],[#hex("00 00 1E B7")],[#hex("B7 1E 00 00")],[#hex("E1 BA B7")],[#hex("1E B7")],[#hex("B7 1E")],
    [𐌰],[#hex("1 03 30")],[#hex("00 01 03 30")],[#hex("30 03 01 00")],[#hex("F0 90 8C B0")],[#hex("D8 00 DF 30")],[#hex("00 D8 30 DF")],
  )
}
#hinweis[Bei LE / BE werden nur die Zeichen _innerhalb_ eines Code-Points vertauscht,
  nicht die Code-Points an sich.]

= Ext2-Dateisystem
_Partition_ #hinweis[(Ein Teil eines Datenträgers, wird selbst wie ein Datenträger behandelt.)],
_Volume_ #hinweis[(Ein Datenträger oder eine Partition davon.)],
_Sektor_ #hinweis[(Kleinste logische Untereinheit eines Volumes.
Daten werden als Sektoren transferiert. Grösse ist von HW definiert.
Enthält Header, Daten und Error-Correction-Codes.)],
_Format_ #hinweis[(Layout der logischen Strukturen auf dem Datenträger, wird vom Dateisystem definiert.)]\

== Block
Ein Block besteht aus _mehreren aufeinanderfolgenden Sektoren_ #hinweis[(1 KB, 2 KB oder
4 KB (normal))]. Das gesamte Volume ist in _Blöcke aufgeteilt_ und Speicher wird _nur in
Form von Blöcken_ alloziert. Ein Block enthält nur Daten einer _einzigen Datei_. Es gibt
_Logische Blocknummern_ #hinweis[(Blocknummer vom Anfang der Datei aus gesehen, wenn Datei
eine ununterbrochene Abfolge von Blöcken wäre)] und
_Physische Blocknummern_ #hinweis[(Tatsächliche Blocknummer auf dem Volume)].

== Inodes
#wrap-content(
  image("img/bsys_42.png"),
  align: top + right,
  columns: (30%, 70%),
)[
  Enthält _alle Metadaten_ über die Datei, _ausser Namen oder Pfad_ #hinweis[(Grösse,
  Anzahl der verwendeten Blöcke, Erzeugungszeit, Zugriffszeit, Modifikationszeit,
  Löschzeit, Owner-ID, Group-ID, Flags, Permission Bits)].
  Hat eine _fixe Grösse_ je Volume: Zweierpotenz, mind. 128 Byte, max. 1 Block.
  Der Inode _verweist auf die Blöcke_, die _Daten für eine Datei_ enthalten.
  Enthält ein Array _`i_block`_ mit 15 Einträgen zu je 32 Bit.
]
*Lokalisierung:*
Alle Inodes aller Blockgruppen gelten als _eine grosse Tabelle_. Startet mit 1.\
*Erzeugung:*
Neue Verzeichnisse werden in der Blockgruppe angelegt, die von allen Blockgruppen mit
_überdurchschnittlich vielen freien Inodes_ die _meisten Blöcke frei_ hat, Dateien in der
Blockgruppe des Verzeichnis oder nahen Gruppen. Bestimmung anhand _Inode-Usage-Bitmaps_.\
*File-Holes:*
Bereiche in der Datei, in der _nur Nullen_ stehen. Ein solcher Block wird _nicht alloziert_.

== Blockgruppe
Eine Blockgruppe besteht aus _mehreren aufeinanderfolgenden Blöcken_ bis zu 8 mal der Anzahl
Bytes in einem Block.\
*Layout:*
_Block 0_ #hinweis[(Kopie des Superblocks)],
_Block $bold(1)$ bis $bold(n)$_ #hinweis[(Kopie der Gruppendeskriptorentabelle)],
_Block $bold(n+1)$_ #hinweis[(Block-Usage-Bitmap mit einem Bit je Block der Gruppe)],
_Block $bold(n+2)$_ #hinweis[(Inode-Usage-Bitmap mit einem Bit je Inode der Gruppe)],
_Block $bold(n+3)$ bis $bold(n+m+2)$_ #hinweis[(Tabelle aller Inodes in dieser Gruppe)],
_Block $bold(n+m+3)$ bis Ende der Gruppe_ #hinweis[(Blöcke der eigentlichen Daten)]\
*Superblock:*
Enthält _alle Metadaten_ über das Volume #hinweis[(Anzahlen, Zeitpunkte, Statusbits,
Erster Inode, ...)] \ immer an Byte 1024, wegen möglicher Bootdaten vorher.\
*Sparse Superblock:*
Kopien des Superblocks werden nur in Blockgruppe 0, 1 und allen reinen Potenzen von 3, 5
oder 7 gehalten #hinweis[(Sehr hoher Wiederherstellungsgrad, aber deutlich weniger
Platzverbrauch)].\
*Gruppendeskriptor:*
32 Byte _Beschreibung einer Blockgruppe_. #hinweis[(Blocknummer des Block-Usage-Bitmaps,
Blocknummer des Inode-Usage-Bitmaps, Nummer des ersten Blocks der Inode-Tabelle,
Anzahl freier Blöcke und Inodes in der Gruppe, Anzahl der Verzeichnisse in der Gruppe)]\
*Gruppendeskriptortabelle:*
Tabelle mit Gruppendeskriptor pro Blockgruppe im Volume. Folgt direkt auf Superblock(-kopie).
$32 dot n$ Bytes gross. Anzahl Sektoren $= (32 dot n)/"Sektorgrösse"$\
*Verzeichnisse:*
Enthält _Dateieinträge_ mit variabler Länge von 8 - 263 Byte
#hinweis[(4B Inode, 2B Eintraglänge, 1B Dateinamenlänge, 1B Dateityp, 0 - 255B Dateiname
aligned auf 4B).] Defaulteinträge: "." und ".."\
*Links:*
Es gibt _Hard-Links_ #hinweis[(gleicher Inode, verschiedene Pfade:
Wird von verschiedenen Dateieinträgen referenziert)] und
_Symbolische Links_ #hinweis[(Wie eine Datei, Datei enthält Pfad anderer Datei)].


== Vergleich FAT, NTFS, Ext2
#{
  set text(size: 0.8em)
  table(
    columns: (1fr, 1fr, auto),
    table.header([FAT], [Ext2], [NTFS]),
    [
      - Verzeichnis enthält alle Daten über die Datei
      - Datei ist in einem einzigen Verzeichnis
      - Keine Hard-Links möglich
    ],
    [
      - Dateien werden durch Inodes beschrieben
      - Kein Link von der Datei zurück zum Verzeischnis
      - Hard-Links möglich
    ],
    [
      - Dateien werden durch File-Records beschrieben
      - Verzeichnis enthält Namen und Link auf Datei
      - Link zum Verzeichnis und Name sind in einem Attribut
      - Hard-Links möglich
    ],
  )
}

= Ext4
_Vergrössert_ die wichtigen Datenstrukturen, besser für grosse Dateien, erlaubt höhere
maximale Dateigrösse. Blöcke werden mit _Extent Trees_ verwaltet, _Journaling_ wird eingeführt.

== Extents
Beschreiben ein _Intervall physisch konsekutiver Blöcke_. Ist 12 Byte gross
#hinweis[(4B logische Blocknummer, 6B physische Blocknummer, 2B Anzahl Blöcke)].
Positive Zahlen = Block initialisiert, Negativ = Block voralloziert. Im Inode hat es in den
60 Byte für direkte und indirekte Block-Adressierung Platz für 4 Extents und einen Header.\
*Extent Trees*
_Index-Knoten_ #hinweis[(Innerer Knoten des Baums, besteht aus Index-Eintrag und Index-Block)],
_Index-Eintrag_ #hinweis[(Enthält Nummer des physischen Index-Blocks und kleinste logische
Blocknummer aller Kindknoten)],
_Index-Block_ #hinweis[(Enthält eigenen Tree-Header und Referenz auf Kindknoten)]\
*Extent Tree Header:*
Benötigt ab 4 Extents, weil zusätzlicher Block.
Magic Number #hex("F30A") #hinweis[(2B)],
Anzahl Einträge, die direkt auf den Header folgen #hinweis[(2B)],
Anzahl Einträge, die maximal auf den Header folgen können #hinweis[(2B)],
Tiefe des Baums #hinweis[(2B)] - #hinweis[(0: Einträge sind Extents, $>=$1: Einträge sind Index Nodes)],
Reserviert #hinweis[(4B)]\
*Index Node:*
Spezifiziert einen Block, der _Extents enthält_. Besteht aus einem Header und den Extents
#hinweis[(max. 340 bei 4 KB Blockgrösse)]. Ab 1360 Extents zusätzlicher Block mit Index
Nodes nötig.

=== Notation
#{
  set text(size: 0.8em)
  table(
    columns: (1fr, 1fr),
    table.header([(in)direkte Addressierung], [Extent-Trees]),
    [_direkte Blöcke:_ Index $|->$ Blocknr.],
    [_Indexknoten:_ Index $|->$ (Kindblocknr, kleinste Nummer der 1. logischen Blöcke aller Kinder)],

    [_indirekte Blöcke:_ indirekter Block.Index $|->$ direkter Block],
    [_Blattknoten:_ Index $|->$ (1. logisch. Block, 1. phy. Block, Anz. Blöcke)],

    [], [_Header:_ Index $|->$ (Anz. Einträge, Tiefe)],
  )
}

==== Beispiel Berechnung 2MB grosse, konsekutiv gespeicherte Datei, 2KB Blöcke ab Block #hex("2000")
_(In-)direkte Block-Adressierung_\
2 MB = $2^21$B, 2 KB = $2^11$B, $ 2^(21-11) = 2^10 = #fxcolor("rot", hex("400"))$
Blöcke von #fxcolor("grün", hex("2000")) bis #fxcolor("orange", hex("23FF"))\
$0 arrow.bar #fxcolor("grün", hex("2000")), 1 arrow.bar #hex("2002"), ... , #hex("B")
arrow.bar #hex("200B")$
$#hex("C") arrow.bar #hex("2400")$ #hinweis[(indirekter Block)]\
$#hex("1400").#hex("0") arrow.bar #hex("200C"),
#hex("1400").#hex("1") arrow.bar #hex("200D"),
...,
#hex("1400").#hex("3F3") arrow.bar #fxcolor("orange", hex("23FF"))$

_Extent Trees_\
*Header:* $0 arrow.bar (1,0)$\
*Extent:* $1 arrow.bar (0, #fxcolor("grün", hex("2000")), #fxcolor("rot",hex("400")))$

== Journaling
Wenn Dateisystem beim _Erweitern_ einer Datei _unterbrochen_ wird, kann es zu
_Inkonsistenzen_ kommen. _Journaling_ verringert Zeit für Überprüfung von Inkonsistenzen erheblich.\
*Journal:*
Datei, in die Daten schnell geschrieben werden können. Bestenfalls 1 Extent.\
*Transaktion:*
Folge von Einzelschritten, die gesamtheitlich vorgenommen werden sollten.\
*Journaling:*
Daten als Transaktion ins Journal, dann an finale Position schreiben #hinweis[(committing)],
Transaktion aus dem Journal entfernen.\
*Journal Replay:*
Transaktionen im Journal werden nach Neustart noch einmal ausgeführt.\
*Journal Modi:*
_(Full) Journal_ #hinweis[(Metadaten und Datei-Inhalte ins Journal, sehr sicher aber langsam)],
_Ordered_ #hinweis[(Nur Metadaten ins Journal, Dateiinhalte werden immer vor Commit geschrieben)],
_Writeback_ #hinweis[(Nur Metadaten ins Journal, beliebige Reihenfolge, nicht sehr sicher aber schnell).]

= X Window System
Setzt _Grundfunktionen der Fensterdarstellung_. Ist austauschbar, realisiert Netzwerktransparenz.
Plattformunabhängig, legt die GUI-Gestaltung nicht fest.\
*Programmgesteuerte Interaktion:* Benutzer reagiert auf Programm.\
*Ereignisgesteuerte Interaktion:* Programm reagiert auf Benutzer.\
*Fenster:*
Rechteckiger Bereich des Bildschirms. Es gibt eine Baumstruktur aller Fenster,
der Bildschirm ist die Wurzel #hinweis[(z.B. Dialogbox, Scrollbar, Button...)].\
*Display:* Rechner mit Tastatur, Zeigegerät und 1..m Bildschirme\
*X Client:* Applikation, die einen Display nutzen will. Kann lokal oder entfernt laufen.\
*X Server:* Softwareteil des X Window System, der ein Display ansteuert. Beim Nutzer.

== GUI Architektur
Nicht nur X Window System, sondern auch _Window Manager_ #hinweis[(Verwaltung der sichtbaren
Fenster, Umrandung, Knöpfe. Läuft im Client und realisiert Window Layout Policy)] und
_Desktop Manager_ #hinweis[(Desktop-Hilfsmittel wie Taskleiste, Dateimanager, Papierkorb etc.)].\

== Xlib
Ist das _C Interface_ für das X Protocol. Wird meist nicht direkt verwendet.\
*Funktionen:*
```c XOpenDisplay()``` #hinweis[öffnet Verbindung zum Display,
NULL = Wert von `DISPLAY` Umgebungsvariabel)],
```c XCloseDisplay()``` #hinweis[schliesst Verbindung],
```c XCreateSimpleWindow()``` #hinweis[erzeugt ein Fenster],
```c XDestroyWindow()``` #hinweis[entfernt ein Fenster & Unterfenster],
```c XMapWindow()``` #hinweis[bestimmt, dass ein Fenster angezeigt werden soll (unhide)],
```c XMapRaised()``` #hinweis[bringt Fenster in den Vordergrund],
```c XMapSubwindows()``` #hinweis[zeigt alle Unterfenster an, `Expose` Event],
```c XUnmapWindow()``` #hinweis[versteckt Fenster],
```c XUnmapSubwindows()``` #hinweis[versteckt Unterfenster, `UnmapNotify` Event]

*X Protocol:*
Legt die _Formate für Nachrichten_ zwischen X Client und Server fest.
_Requests_ #hinweis[(Dienstanforderungen, Client #sym.arrow Server)],
_Replies_ #hinweis[( Antworten auf Requests, Client #sym.arrow.l Server)],
_Events_ #hinweis[(Ereignismeldungen, Client #sym.arrow.l Server)],
_Errors_ #hinweis[(Fehlermeldungen auf vorangegangene Requests, Client #sym.arrow.l Server)]\
*Request Buffer:*
Nachrichtenpufferung auf der Client Seite. Für _Effizienz_.
*Pufferung bei Ereignissen:*
Werden beim X Server und beim Client gepuffert.
_Server-Seitig_ berücksichtigt Netzwerkverfügbarkeit, _Client-Seitige_ hält Events bereit.\
*X Event Handling:*
Ereignisse werden vom Client verarbeitet oder weitergeleitet.
Muss _festlegen, welche_ Typen er empfangen will.
```c XSelectInput()``` #hinweis[legt fest, welche Events via Event-Masken emfpangen werden,
z.B. `ExposureMask`],
```c XNextEvent()``` #hinweis[kopiert den nächsten Event aus dem Buffer].

== Zeichnen
*Ressourcen:*
Server-seitige Datenhaltung zur Reduktion des Netzwerkverkehrs.
Halten Informationen im Auftrag von Clients. Diese identifizieren Informationen mit IDs.
Kein Hin- und Herkopieren komplexer Datenstrukturen nötig.
#hinweis[(z.B. Window, Pixmap, Colormap, Font, Graphics-Context)]\
*Pufferung verdeckter Fensterinhalte:*
_Minimal_ #hinweis[(keine Pufferung)] oder
_Optional_ #hinweis[(Hintergrundspeicher zum Sichern vorhanden)]\
*Pixmap:*
Server-Seitiger _Grafikspeicher_, wird immer gecached.\
*X Grafikfunktionen:*
Bilddarstellung mittels _Rastergrafik_ und _Farbtabelle_. Erlauben das Zeichnen von Figuren,
Strings und Texten. _Ziele_ für das Zeichnen können Fenster oder Pixmap sein.\
*Graphics Context:*
Legt diverse _Eigenschaften_ fest, die Systemaufrufe nicht direkt unterstützen
#hinweis[(z.B. Liniendicke, Farben, Füllmuster)].
Client kann mehrere GCs gleichzeitig nutzen.

== Fenster Schliessen
Schaltfläche wird vom _Window Manager_ erzeugt. X weiss _nichts_ über spezielle Bedeutung
der Schaltfläche, der Window Manager schliesst das Fenster. Es gibt ein _Protokoll_ zwischen
Window Manager und Applikation. `ClientMessage` Event mit `WM_DELETE_MESSAGE`.\
*Atoms:*
_ID eines Strings_, der für _Meta-Zwecke_ benötigt wird. Erspart Parsen der Strings.\
*Properties:*
Werden mit jedem Fenster assoziiert.
_Generischer Kommunikations-Mechanismus_ zwischen Applikation und Window Manager.\
*`WM_PROTOCOLS`:*
Von X Standard definierte Anzahl an Protokollen, die der Window Manager verstehen soll.
Ein Client kann sich für Protokolle _registrieren_. \
*`WM_DELETE_WINDOW`:*
Wird beim Drücken des "x" vom Window Manager an den Client geschickt.

= Meltdown
Meltdown ist eine _HW-Sicherheitslücke_, die es ermöglicht, den _gesamten physischen
Hauptspeicher auszulesen_.
Ein Prozess kann dadurch geheime Informationen anderer Prozesse lesen.\
Der Prozessor muss dazu gebracht werden können:
1. aus dem _geschützten Speicher_ an Adresse $a$ das Byte $m_a$ zu _lesen_
2. die Information $m_a$ in irgendeiner Form $f_a$ _zwischenzuspeichern_
3. _binäre Fragen_ der Form "$f_a eq.quest i$" zu beantworten
4. Von $i = 0$ bis $i = 255$ _iterieren_: $f_a eq.quest i$
5. Über alle $a$ _iterieren_

== Performance-Optimierungen
Mapping des Speichers in jeden virtuellen Adressraum, Out-of-Order Execution (03E),
Spekulative Ausführung.\
*Seiteneffekte O3E:*
Cache weiss nicht, ob Wert spekulativ angefordert wurde und speichert alles.
Da Wert als Teil des Tags gespeichert und die _Zeit gemessen_ werden kann, die ein
Speicherzugriff benötigt, kann man herausfinden, ob etwas im Cache ist oder nicht
#hinweis[(Timing Side Channel Attack)].\
*Tests:*
Verschiedene CPUs #hinweis[(Intel, einige ARMs, keine AMDs)] und verschiedene OS
#hinweis[(Linux, Windows 10)] sind betroffen.
_Geschwindigkeit_ bis zu 500 KB pro Sekunde bei 0.02% Fehlerrate.\
*Einsatz:*
Auslesen von Passwörtern, Zugriff auf andere Dockerimages. Nachweis schwierig.\
*Gegenmassnahmen:*
_Kernel page-table isolation "KAISER":_ verschiedene Page Tables für Kernel- bzw. User-Mode.
Nachteil: System wieder langsam.\
*Spectre:*
Gleiches Ziel, verwendet jedoch _Branch Prediction_ mit spekulativer Ausführung.
Branch Prediction wird nicht per Prozess _unterschieden_. Alle Prozesse, die auf dem selben
Prozessor laufen, verwenden die _selben Vorhersagen_. Ein Angreifer kann damit den Branch
Predictor _für einen anderen Prozess "trainieren"_. Der _Opfer-Prozess_ muss zur Kooperation
_"gezwungen"_ werden, indem im verworfenen Branch auf Speicher zugegriffen wird.
Nicht leicht zu fassen, aber auch nicht leicht zu implementieren.
