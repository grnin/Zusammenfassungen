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

= Dateisystem API
_Dateiendungen_ sind die Zeichen nach dem letzten Punkt. Dateiendungen haben für
File System (FS) und OS _(fast) keine Relevanz_. Bestimmte Programme deuten Dateiendung
als Typ. Häufig wird der Typ aber durch _Magic Numbers_ oder Strings innerhalb der Datei
gekennzeichnet.

== Dateisystem-Grundlagen
#v(-0.5em)
=== Schutz gegen falsche Datentypen
Es liegt an der Applikation, den Dateityp richtig zu bestimmen.
Applikationen müssen sich gegen "Datenmüll" (bzw. Fehlinterpretation) schützen.
Sie dürfen _nie_ annehmen, dass Daten _gültig_ sind, sondern müssen diese _validieren_ und
auf Grenzverletzungen überprüfen.

=== Begriffe
- _Verzeichnis:_ Liste, die Dateien oder weitere Verzeichnisse enthalten kann.
  Als Datei realisiert, die diese Liste enthält. Hat einen Dateinamen.
- _Verzeichnishierarchie:_ Gesamtheit aller Verzeichnisse im System.
  Jedes Verzeichnis (ausser Wurzelverzeichnis) hat genau ein Elternverzeichnis
  (Baum-Hierarchie).
- _Wurzelverzeichnis:_ Oberstes Verzeichnis in der Hierarchie. Hat keinen Namen, wird aber
  oft mit `/` bezeichnet. #hinweis[(Windows: Root pro Partition, Unix: Root pro OS)]

=== Besondere Verzeichnisse
Jedes Verzeichnis enthält zwei implizite Referenzen auf Verzeichnisse:
- _`.`_ #hinweis[(ein Punkt)]: Referenz auf sich selbst
- _`..`_ #hinweis[(zwei Punkte)]: Referenz auf das Elternverzeichnis
Jeder Prozess hat ein _Arbeitsverzeichnis (working directory)_, welches den Bezugspunkt
für relative Pfade darstellt. Dieses wird beim Prozessstart von aussen festgelegt.
Wird mit ```c getcwd()``` ermittelt und mit
```c chdir()``` #hinweis[(nimmt Pfad als String)] bzw.
```c fchdir()``` #hinweis[(nimmt file descriptor)] geändert.

=== Pfade
Ein Pfad spezifiziert eine Datei oder ein Verzeichnis in der Verzeichnishierarchie.
Verzeichnisnamen werden durch `/` voneinander getrennt (Windows: `\`).
- _Absoluter Pfad_ beginnt mit `/` #hinweis[(vom Root-Verzeichnis aus)]
- _Relativer Pfad_ beginnt _nicht_ mit `/` #hinweis[(vom Arbeitsverzeichnis aus)]
- _Kanonische Pfade_ sind absolute Pfade ohne `"."` und `".."`.
  Können mit ```c realpath()``` ermittelt werden.

==== Längster Pfadname
Verschiedene Implementierungen von POSIX dienen unterschiedlichen Zwecken.
Systeme können unterschiedliche Limits haben. Jedes POSIX-System definiert den
Header ```c <limits.h>```:
- _`NAME_MAX`:_ Maximale Länge eines Dateinamens (exklusive terminierender Null)
- _`PATH_MAX`:_ Maximale Länge eines Pfads (inklusive terminierender Null)
  #hinweis[(beinhaltet Wert von `NAME_MAX`)]
- _`_POSIX_NAME_MAX`:_ Minimaler Wert von `NAME_MAX` nach POSIX #hinweis[(14)]
- _`_POSIX_PATH_MAX`:_ Minimaler Wert von `PATH_MAX` nach POSIX #hinweis[(256)]

_Beispiel - Arbeitsverzeichnis ausgeben:_
```c
int main (int argc, char ** argv) {
  char *wd = malloc(PATH_MAX); // PATH_MAX = Maximale Länge des Pfades
  getcwd(wd, PATH_MAX);
  printf("Current WD is %s", wd);
  free(wd);
  return 0;
}
```

#pagebreak()

=== Zugriffsrechte (Unix)
Jeder Datei und jedem Verzeichnis sind Zugriffsrechte zugeordnet.
Gehört genau einem Benutzer (Owner) und genau einer Gruppe.
Hat je 3 Permission-Bits für _Owner_, _Gruppe_, und _andere Benutzer_.
- _Read-Bits:_ Darf lesen
- _Write-Bits:_ Darf schreiben
- _Execute/Search-Bits:_ Darf ausführen (Datei) bzw. durchsuchen (Verzeichnis)

Es gibt eine feste Reihenfolge der 9 Permission Bits: `owner rwx - group rwx - other rwx`.\
Schreibweise: `r=4, w=2, x=1`\ `0740` oder `rwx r-- ---` bedeutet
owner hat alle Rechte, Gruppe kann nur lesen, andere haben keine Rechte.

==== POSIX
Die POSIX-API definiert die `STAT_INODE` Konstanten für die Zugriffsrechte in
```c <sys/stat.h>```. Beispiele:
- _`S_IRWXU`_ `= 0700 = rwx------` #hinweis[read, write & execute for user]
- _`S_IWUSR`_ `= 0200 = -w-------` #hinweis[write for user]
- _`S_IRGRP`_ `= 0040 = ---r-----` #hinweis[read for group]
- _`S_IXOTH`_ `= 0001 = --------x` #hinweis[execute for other]
Können mit `|` verknüpft werden, z.B. `S_IRWXU | S_IRGRP`

#wrap-content(
  image("img/bsys_5.png"),
  align: top + right,
  columns: (64%, 36%),
)[
  == Überblick APIs
  - _POSIX-API:_ für direkten Zugriff, alle Dateien sind rohe Binärdaten\
    #hinweis[(so wie sie in der Datei gespeichert sind)]
  - _C-API:_ für direkten Zugriff auf Streams #hinweis[(Textdateien)], Abstraktion
    über Dateien, Pipes, etc. Für formatierte Ein- und Ausgabe, OS leitet alle
    Zugriffe an Treiber weiter.

  == POSIX File API
  API für _direkten, unformatierten Zugriff_ auf Inhalt der Datei.
  Sollte _nur für Binärdaten_ verwendet werden. Funktionen sind deklariert in
  ```c <unistd.h>``` #hinweis[(Unix Standard API)] und ```c <fcntl.h>```
  #hinweis[(File Control)] und geben im Fehlerfall `-1` zurück.
  Der Fehler-Code kann dann mit `errno` abgefragt werden.
]

=== `errno`
- _Makro oder globale Variable vom Typ `int`_
  #hinweis[(verhält sich immer wie eine globale Variable)]
- Wird von vielen Funktionen gesetzt.
- Sollte _unmittelbar nach Auftreten eines Fehlers_ aufgerufen werden
  #hinweis[damit Wert nicht von anderer Funktion überschrieben wird]

```c
if (chdir("docs") < 0) {
  // hier nichts anderes machen, damit Fehlercode nicht überschrieben wird
  if (errno == EACCESS) {
    printf("Error: Access denied");
  }
}
```

==== `char * strerror (int code)`
`strerror` gibt die Adresse eines Strings zurück, der den Fehlercode `code` textuell
beschreibt.

```c
if (chdir("docs") < 0) {
  printf("Error: %s\n", strerror (errno)); //e.g. Error: Permission denied
}
```

==== `void perror (const char *text)`
`perror` #hinweis[(präfix error)] schreibt `text` gefolgt von einem Doppelpunkt und vom
Ergebnis von `strerror(errno)` auf den Errorstream.

```c
if (chdir("docs") < 0) {
  perror("chdir"); // chdir: No such file or directory
}
```

=== File-Descriptor
Files werden in der POSIX-API über _File-Deskriptoren (FD)_ repräsentiert.
Gilt immer nur innerhalb eines Prozesses. Ein neu erstellter FD returnt einen Index,
über welchen auf ihn zugegriffen werden kann.
- Index in eine _Tabelle aller geöffneten Dateien im Prozess_
- Tabelleneintrag enthält _Index in systemweite Tabelle_ aller geöffneten Dateien
- Die systemweite Tabelle enthält Daten, um physische Datei zu identifizieren.
  Zustandsbehaftet: merkt sich aktuellen Offset (Offset des Bytes, das als nächstes
  gelesen werden wird)

#wrap-content(
  image("img/bsys_6.png"),
  align: top + right,
  columns: (60%, 40%),
)[
  In jedem Prozess sind drei Standard File-Deskriptoren definiert:
  - _`STDIN_FILENO = 0`:_ standard input
  - _`STDOUT_FILENO = 1`:_ standard output
  - _`STDERR_FILENO = 2`:_ standard error
]

=== Öffnen und Schliessen von Dateien: ```c int open (char *path, int flags, ...)```
erzeugt einen File-Deskriptor auf die Datei, die an `path` liegt.
`flags` gibt an, wie die Datei geöffnet werden soll.\
#hinweis[(können über Pipe kombiniert werden. Sollen noch Berechtigungs-Flags verwendet
  werden, werden diese als eigener Parameter angegeben)]

- _`O_RDONLY`:_ nur lesen
- _`O_RDWR`:_ lesen und schreiben
- _`O_CREAT`:_ Erzeuge Datei, wenn sie nicht existiert;
  benötigt weiterer Parameter für Zugriffsrechte
- _`O_APPEND`:_ Setze Offset ans Ende der Datei vor jedem Schreibzugriff
  #hinweis[(ohne dieses Flag wird bei jedem Schreiben der Inhalt von Anfang an überschrieben)]
- _`O_TRUNC`:_ Setze Länge der Datei auf 0 #hinweis[(Inhalt löschen)]

```c int close (int fd)``` _dealloziert_ den _File-Deskriptor `fd`_.
Dieser kann später von `open` für eine andere Datei verwendet werden
#hinweis[(gleiche File-Deskriptoren != gleiche Datei)].
Gibt `0` #hinweis[(OK)] oder `-1` #hinweis[(Fehler, z.B. FD existiert nicht)] zurück.
Wird die Datei _nicht geschlossen_, kann es sein, dass das _FD-Limit_ des Prozesses
erreicht wird und _keine weiteren Dateien_ mehr geöffnet werden können.
Es können auch _mehrere FDs diesselbe Datei öffnen_, da diese aber _verschiedene Offsets_
haben können, besteht die Gefahr, dass sie sich _gegenseitig Daten überschreiben_ -
nicht empfehlenswert.

```c
int fd = open("myfile.dat", O_RDONLY);
if (fd < 0) {
  // error handling, -1 means error
}
// read data
close(fd); //gets written on the disk and the resources (and the file) can be used again
```

=== Lesen und Schreiben von Dateien: ```c ssize_t read(int fd, void * buffer, size_t n)```
#wrap-content(
  image("img/bsys_7.png"),
  align: top + right,
  columns: (65%, 35%),
)[
  versucht, die nächsten $n$ Byte am aktuellen Offset von `fd` in den `buffer` zu kopieren.

  ```c ssize_t write(int fd, void * buffer, size_t n)``` versucht, die nächsten $n$ Byte
  vom `buffer` an den aktuellen Offset von `fd` zu kopieren.

  Beide Funktionen geben die Anzahl der gelesenen / geschriebenen Bytes zurück oder -1 bei
  Fehler #hinweis[(darum ist return type signed size)]. Blockieren normalerweise, bis $n$
  Bytes kopiert wurden, ein Fehler auftritt oder das Ende der Datei erreicht wurde.
  Erhöhen Offset von `fd` um Anzahl gelesener / geschriebener Bytes.
]

#pagebreak();

```c
#define N 32
char buf[N]
char spath[PATH_MAX]; // source path
char dpath[PATH_MAX]; // destination path
// ... gets paths from somewhere
int src = open(spath, O_RDONLY);
int dst = open(dpath, O_WRONLY | O_CREAT, S_IRWXU);
ssize_t read_bytes = read(src, buf, N);
write(dst, buf, read_bytes); // if file gets closed early, use return value of "read_bytes"
close(src);
close(dst);
```

=== Springen in einer Datei: ```c off_t lseek(int fd, off_t offset, int origin)```
#wrap-content(
  image("img/bsys_8.png"),
  align: top + right,
  columns: (75%, 25%),
)[
  setzt den Offset von `fd` auf `offset`. `origin` gibt an, wozu `offset` relativ ist:
  - _`SEEK_SET`:_ Beginn der Datei #hinweis[(absoluter Offset)]
  - _`SEEK_CUR`:_ Aktueller Offset #hinweis[(relativer Offset)]
  - _`SEEK_END`:_ Ende der Datei #hinweis[(Offset über Datei hinaus)]

  Gibt neuen Offset zurück oder -1 bei Fehler.\

  Weitere Anwendungsmöglichkeiten:
  - _`lseek(fd, 0, SEEK_CUR)`:_ gibt aktuellen Offset zurück
  - _`lseek(fd, 0, SEEK_END)`:_ gibt die Grösse der Datei zurück
  - _`lseek(fd, n, SEEK_END)`:_ hängt bei nachfolgendem `write` $n$ Nullen an Datei\
    #hinweis[(Padding, um Datei auf bestimmte Grösse zu setzen)]
]

=== Lesen und Schreiben ohne Offsetänderung:
```c
ssize_t pread(int fd, void * buffer, size_t n, off_t offset)
ssize_t pwrite(int fd, void * buffer, size_t n, off_t offset)
```

Wie `read` bzw. `write`. Statt des Offsets von `fd` wird der zusätzliche Parameter
`offset` verwendet.\
#hinweis[(`off_t >= signed int`)] Der Offset von `fd` wird _nicht_ verändert.

=== Unterschiede Windows und POSIX
- Bestandteile von Pfaden werden durch _Backslash_ (`\`) getrennt.\
  #hinweis[(müssen darum in C-Strings doppelt geschrieben werden, da `\` Escape-Character ist)]
- Ein _Wurzelverzeichnis pro_ Datenträger/Partition
- Andere File-Handling-Funktionen #hinweis[(CreateFile, ReadFile, WriteFile,
  SetFilePointer, CloseHandle)]

== C Stream API
- _Unabhängig vom Betriebssystem:_ für POSIX und Windows gleich
- _Stream-basiert:_ zeichen-orientiert #hinweis[(Ist dafür da, mit Text zu arbeiten)]
- Kann _gepuffert_ oder _ungepuffert_ sein. Für Dateien im Normalfall _gepuffert_.
  Transferiert selbstständig grössere Daten-Blöcke zwischen Datei und Puffer.
- Hat einen eigenen _File-Position-Indicator_: Bei gepufferten Streams bestimmte Position
  im Puffer, bei ungepufferten Streams entspricht dieser dem Offset des File-Descriptors.

=== Streams
Datenstruktur `FILE` enthält _Informationen über einen Stream_.
Soll _nicht direkt verwendet werden_, sondern nur über von C-API erzeugte Pointer
_`(FILE *)`_. Soll nicht kopiert werden, Pointer an sich kann von API als ID
verwendet werden.

Drei definierte Standard-Streams analog zu den Standard-FDs:\
```c FILE *stdin```, ```c FILE *stdout```, ```c FILE *stderr```

#pagebreak()

=== Öffnen einer Datei: ```c FILE * fopen(char const *path, char const *mode)```
erzeugt `FILE`-Objekt (und damit Stream) für Datei an `path`. `mode` gibt Flags analog zu
`open` als nullterminierten String an:
- _`"r"`:_ wie `O_RDONLY` #hinweis[(Datei lesen)]
- _`"w"`:_ wie `O_WRONLY | O_CREAT | O_TRUNC`
  #hinweis[(in neue oder bestehende geleerte Datei schreiben)]
- _`"a"`:_ wie `O_WRONLY | O_CREAT | O_APPEND`
  #hinweis[(in neue oder bestehende Datei anfügen)]
- _`"r+`:_ wie `O_RDWR` #hinweis[(Datei lesen & schreiben)]
- _`"w+"`:_ wie `O_RDWR | O_CREAT | O_TRUNC`
  #hinweis[(neue oder geleerte bestehende Datei lesen & überschreiben)]
- _`"a+"`:_ wie `O_RDWR | O_CREAT | O_APPEND`
  #hinweis[(neue oder bestehende Datei lesen & an Datei anfügen)]

Gibt Pointer auf erzeugtes `FILE`-Objekt zurück oder 0 bei Fehler.

```c FILE * fdopen(int fd, char const * mode)``` ist wie ```c fopen()```, aber statt Pfad
wird direkt der File-Deskriptor übergeben.

```c int fileno (FILE *stream)``` gibt File-Deskriptor zurück, auf den sich der Stream
bezieht, oder -1 bei Fehler.

Da die POSIX- & Stream-API _unterschiedliche Offsets_ haben, sollte man nach dem Umwandlen
mit den obigen Funktionen die "vorherige" API _nicht mehr verwenden_, da es wie bei
mehreren FDs auf diesselbe Datei zu _Konflikten_ kommen kann.

=== Schliessen einer Datei: ```c int fclose(FILE *file)```
Ruft ```c fflush()``` auf, schliesst den durch `file` bezeichneten Stream, entfernt `file`
aus Speicher und gibt 0 zurück wenn OK, andernfalls `EOF`.

=== Flushen einer Datei: ```c int fflush(FILE *file)```
Schreibt eventuell zu schreibenden Inhalt aus dem Hauptspeicher in die Datei.
Wird automatisch aufgerufen, wenn der Puffer voll ist oder die Datei geschlossen wird.
Gibt 0 zurück wenn OK, andernfalls `EOF`.

=== Lesen aus einer Datei: ```c int fgetc(FILE *stream)```
Liest das nächste Byte vom `stream` als _unsigned char_ und gibt es als _int_ zurück
#hinweis[(weil man den nächstgrösseren Dateityp `int` benötigt, um Fehlercodes abzubilden)].
Erhöht den _File-Position-Indicator_ um 1.

```c char * fgets(char *buf, int n, FILE *stream)``` liest bis zu $n-1$ Zeichen aus
`stream`, bis Newline oder `EOF` auftritt. Hängt eine 0 an, und erzeugt damit
null-terminierten String. Gibt `buf` zurück, oder 0 wenn ein Fehler auftrat.
Erhöht den File-Position-Indicator entsprechend der gelesenen Zeichen.

==== Lesen rückgängig machen: ```c int ungetc(int c, FILE *stream)```
Schiebt `c` zurück in den `stream` auf den _Unget-Stack_.
`fgetc` bevorzugt immer den Unget-Stack: `c` wird bei der nächsten Leseoperation so
zurückgegeben, als ob es an der Stelle gestanden hätte.
Die Datei selbst wird _nicht_ verändert.
Der Unget-Stack hat _mindestens Grösse 1: Funktioniert mindestens einmal_.
Gibt `c` zurück, oder `EOF` im Fehlerfall.

=== Schreiben in eine Datei: ```c int fputc(int c, FILE *stream)```
Konvertiert `c` in _unsigned char_ und schreibt diesen auf `stream`.
Gibt entweder `c` zurück oder `EOF`. Erhöht den File-Position-Indicator um 1.

```c int fputs(char *s, FILE *stream)``` schreibt die Zeichen vom String `s` bis
zur terminierenden 0 in `stream`. Die terminierende 0 wird _nicht_ mitgeschrieben.
Gibt im Fehlerfall `EOF` zurück.

#pagebreak()

=== Dateiende und Fehler:
- ```c int feof(FILE *stream)``` gibt 0 zurück, wenn Dateiende _noch nicht_ erreicht wurde
- ```c int ferror(FILE * stream)``` gibt 0 zurück, wenn _kein_ Fehler auftrat

```c
int return_value = fgetc (stream);
if (return_value == EOF) {
  if (feof(stream) != 0) {
    // EOF reached
  } else if (ferror(stream) != 0) {
    // Error occured, check errno
  } // feof() and ferror() need to be checked separately
}
```

=== Manipulation des File-Position-Indicator:
- *```c long ftell(FILE *stream)```*
  gibt den gegenwärtigen FPI zurück.\
  #hinweis[(POSIX-Erweiterung von C: `ftello` mit Rückgabetyp `off_t`)]
- *```c int fseek (FILE *stream, long offset, int origin)```*
  setzt den FPI, analog zu `lseek`.\
  #hinweis[(POSIX-Erweiterung von C: `fseeko` mit `off_t` als Typ für `offset`)]
- *```c int rewind (FILE *stream)```*
  setzt den Stream zurück.\
  Äquivalent zu ```c fseek(stream, 0, SEEK_SET)``` und Löschen des Fehlerzustands.
