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

= Programme und Bibliotheken
== C Toolchain
`C-Quelle -> Präprozessor -> Bereinigte C-Quelle -> Compiler -> Assembler-Datei -> Assembler -> Objekt-Datei -> Linker -> Executable`

- _Präprozessor:_ Die Ausgabe des Präprozessors ist eine reine C-Datei (Translation-Unit)
  ohne Makros, Kommentare oder Präprozessor-Direktiven.
- _Linker:_ Der Linker verknüpft Objekt-Dateien (und statische Bibliotheken) zu
  Executables oder dynamischen Bibliotheken. Löst Referenzen der Objekt-Dateien
  untereinander soweit wie möglich auf. Executable und dynamische Bibliotheken müssen
  vollständig aufgelöst sein.

== Loader und das ELF
Der _Loader_ lädt Executables und eventuelle _dynamische_ Bibliotheken dieser in den
Hauptspeicher. Executable und dynamische Bibliotheken müssen also _alle Informationen_
enthalten, die der Loader benötigt. Lädt _keine statische Bibliotheken_, diese werden
bereits vorher im Kompilationsprozess vom Linker mit Executable oder dynamischer
Bibliothek verknüpft.

=== Linux Loader
Eine Funktion der `exec*`-Familile erhält `syscall`. Diese wird auf `sys_execve`
übersetzt. _Sucht_ Datei, _prüft_ Rechte (x-Bits) und _öffnet_ die spezifizierte Datei.
_Zählt und kopiert_ die Argumente und Umgebungsvariablen #hinweis[(weil execv#emph[e])].
_Übergibt den Request_ an jeden registrierten "Binary Handler" #hinweis[(für verschiedene
Dateiformate: ELF, a.out etc.)]. Diese versuchen nacheinander jeweils die _Datei zu laden_
und zu interpretieren #sym.arrow _Ausführung des neuen Programms_.

#wrap-content(
  image("img/bsys_16.png"),
  align: bottom + right,
  columns: (80%, 20%),
)[
  === ELF (Executable and Linking Format)
  _Binär-Format_, das Kompilate spezifiziert. Eigentlich zwei Formate / Views, werden aber
  oft beide benötigt: _Linking View_ #hinweis[(wichtig für Linker)] und
  _Execution View_ #hinweis[(wichtig für Loader)]. Verwendung:
  - _Object-Files:_ Linking View
  - _Programme:_ Execution View
  - _Shared Objects (Dynamische Bibliotheken):_ Linking View und Execution View

  === Struktur des ELF
  - #link(<elf-header>)[_Header_]
  - #link(<elf-pht>)[_Programm Header Table_] #hinweis[(nur in Execution View erforderlich)]
  - #link(<elf-pht>)[_Segmente_] #hinweis[(nur in Execution View erforderlich)]
  - #link(<elf-sht>)[_Section Header Table_] #hinweis[(nur in Linking View erforderlich)]
  - #link(<elf-sht>)[_Sektionen_] #hinweis[(nur in Linking View erforderlich)]
]

#pagebreak()

#wrap-content(
  image("img/bsys_17.png"),
  align: bottom + right,
  columns: (85%, 15%),
)[
  ==== Segmente und Sektionen
  Segmente und Sektionen sind jeweils eine _andere Einteilung für die gleichen
  Speicherbereiche_. Die _View des Loaders_ sind die _Segmente_:
  Diese definieren die Portionen, die in den Hauptspeicher geladen werden.
  Die _View des Compilers_ sind die _Sektionen_: Diese definieren "gleichartige" Daten
  #hinweis[(z.B. `.data`, `.text`)]. Der _Linker_ vermittelt zwischen beiden Views:
  kombiniert gleichnamige Sektionen aus unterschiedlichen Objekt-Dateien und definiert Segmente.
]

==== Header <elf-header>
Der Header #hinweis[(52 Byte)] beschreibt _den Aufbau_ der Datei:
- _Typ:_ Relozierbar #hinweis[(beliebig verschiebbar im Speicher)],
  Ausführbar, Shared Object
- _32-bit oder 64-bit_
- _Encoding:_ little-endian oder big-endian
- _Maschinenarchitektur:_ z.B. i386, Motorola 68k
- _Entrypoint:_ Adresse, an der das Programm starten soll #hinweis[(Default: `_start`)]
- _Infos zu den Einträgen in der Program Header Table:_ Relative Adresse, Anzahl und Grösse
- _Infos zu den Einträgen in der Section Header Table:_ Relative Adresse, Anzahl und Grösse

==== Segment/Program Header Table und Segmente <elf-pht>
Die Segment Header Table #hinweis[(SHT/PHT)] ist eine Tabelle mit $n$ Einträgen.
Jeder Eintrag (je 32 Byte) _beschreibt ein Segment:_
- Segment-Typ und Flags
- Offset und Grösse in der Datei
- Virtuelle Adresse und Grösse im Speicher
  #hinweis[(möglich zusätzlich auch physische Adresse)]

Die SHT ist die _Verbindung zwischen den Segmenten im RAM und im File_.
Die PHT definiert, wo ein Segment in der Datei liegt und wohin der Loader das Segment in
den RAM laden soll.

_Achtung:_ Grösse der Datei und Grösse im Speicher können unterschiedlich sein.
Es kann auch Speicher reserviert werden. Deswegen kann Dateigrösse 0 sein, aber Speicher
z.B. 5MB.\
Segmente werden vom Loader _zur Laufzeit_ verwendet: Der _Loader_ lädt bestimmte Segmente
in den Speicher und kann weitere Segmente für andere Informationen verwenden
#hinweis[(dynamisches Linken oder Meta-Informationen)].

==== Section Header Table und Sektionen <elf-sht>
Die Section Header Table (auch SHT) ist eine Tabelle mit $m$ Einträgen ($m$ meist $!= n$).
Jeder Eintrag (je 40 Byte) _beschreibt eine Sektion_:
- _Name:_ Referenz auf String Table
- _Section-Typ_ und Flags
- _Offset_ und _Grösse_ in der Datei
- _Spezifische Informationen_ je nach Sektions-Typ

Sektionen werden vom _Linker_ verwendet: Sammelt alle Sektionen aus allen Object-Files
zusammen. _Verschmilzt_ Sektionen _gleichen Namens_ aus verschiedenen Object-Files und
_erzeugt ausführbares Executable_.

#columns(2)[
  ===== Sektionstypen #hinweis[(Auswahl)]
  - _`SHT_PROGBITS`:_ Daten definiert vom Programm,
    Linker interpretiert Inhalt nicht
  - _`SHT_SYMTAB`:_ #link(<symbol-tabelle>)[Symbol-Tabelle]
  - _`SHT_STRTAB`:_ #link(<string-tabelle>)[String-Tabelle]
  - _`SHT_REL/RELA`:_ Relokations-Informationen
  - _`SHT_HASH`:_ Hashtabelle für Symbole
  - _`SHT_DYNAMIC`:_ Informationen für dynamisches Linken
  - _`SHT_NOBITS`:_ Sektionen ohne Daten in der Datei

  #colbreak()

  ===== Sektionsattribute
  - _`SHF_WRITE`:_ Daten dieser Sektion sollen bei Ausführung _schreibbar_ sein
    #hinweis[(SH#emph[F] für Flag)]
  - _`SHF_ALLOC`:_ Daten dieser Sektion sollen bei Ausführung _im Speicher liegen_
  - _`SHF_EXECINSTR`:_ Daten dieser Sektion stellen _Maschinencode_ dar
]

#pagebreak()

===== Spezielle Sektionen #hinweis[(Auswahl)]
- _`.bss`:_ Uninitialisierte Daten #hinweis[(`SHT_NOBITS, SHF_ALLOC, SHF_WRITE`)]
- _`.data` / `data1`:_ Initialisierte Daten
  #hinweis[(`SHT_PROGBITS, SHF_ALLOC, SHF_WRITE`) - `data1` ist historisch]
- _`.debug`:_ Debug-Informationen #hinweis[(`SHT_PROGBITS`)]
- _`.rodata` / `.rodata1`:_ Read-Only Daten #hinweis[(`SHT_PROGBITS, SHF_ALLOC`)]
- _`.text`:_ Ausführbare Instruktionen #hinweis[(`SHF_PROGBITS, SHF_ALLOC, SHF_EXECINSTR`)]
- _`.symtab`:_ #link(<symbol-tabelle>)[Symbol-Tabelle] #hinweis[(`SHT_SYMTAB`)]
- _`.strtab`:_ #link(<string-tabelle>)[String-Tabelle] #hinweis[(`SHT_STRTAB`)]

==== String-Tabelle <string-tabelle>
Bereich in der Datei, der nacheinander _null-terminierte Strings enthält_.
Strings werden _relativ zum Beginn der Tabelle_ referenziert
#hinweis[(z.B. Tabelle beginnt bei Dateioffset 1234, String bei 1238 #sym.arrow
String-Referenz = 4)].\
Enthält typischerweise _Namen von Symbolen_ und _keine String-Literale_
#hinweis[(z.B. "Hello World" - diese sind typischerweise in `.rodata`)]

==== Symbole & Symboltabelle <symbol-tabelle>
Die Symboltabelle enthält jeweils _einen Eintrag je Symbol_.
Ein Symbol hat _16 Byte_.
- 4 Byte _Name_: Referenz in String-Tabelle
- 4 Byte _Wert_: Je nach Symboltyp, kann z.B. Adresse sein
- 4 Byte _Grösse_: Grösse des Symbold #hinweis[(z.B. Länge einer Funktion)]
- 4 Byte _Info_: Typ #hinweis[(Objekt, Funktion, Sektion...)],
  Binding-Attribute, Referenz auf Sektions-Header

== Bibliotheken
#wrap-content(
  image("img/bsys_18.png"),
  align: top + right,
  columns: (69%, 31%),
)[
  === Statische Bibliotheken
  Statische Bibliotheken sind _Archive von Objekt-Dateien_. Archive sind Dateien, die
  andere Dateien enthalten #hinweis[(wie ein ZIP ohne Kompression)], werden mit dem Tool
  "`ar`" erzeugt. Per Konvention folgen Bibliotheksnamen dem Muster `lib<name>.a`.\
  Referenziert wird dann nur `<name>: clang -lmylib ...`.

  Der Linker behandelt statische Bibliotheken wie _mehrere Objekt-Dateien_.
  Alle gelinkten statischen Bibliotheken werden vom Linker im Programm-Image _verteilt_,
  alle Variablen und Funktionen werden auf absolute Adressen _fixiert_.

  Ursprünglich gab es _nur statische Bibliotheken_. Das war _einfach_ zu implementieren,
  jedoch müssen Programme bei Änderungen in Bibliotheken _neu erstellt_ werden und die
  _Funktionalität ist fix_ #hinweis[(Keine Plugins möglich)].
]
#wrap-content(
  image("img/bsys_19.png"),
  align: top + right,
  columns: (70%, 30%),
)[
  === Dynamische Bibliotheken
  Dynamische Bibliotheken linken erst zur _Ladezeit_ bzw. Laufzeit des Programms.
  _Höherer Aufwand_ für Programmierer, Compiler, Linker und OS.
  Das Executable enthält nur noch Referenz auf Bibliothek. Vorteile davon sind:

  *Entkoppelter Lebenszyklus:*
  Das Programm kann _Updates erhalten_, ohne das Binary zu ändern.
  Funktionalität kann unabhängig voneinander _geupdatet_ werden.
  Bugfixes können _direkt_ zur Anwenderin gebracht werden.
]

*Verzögertes Laden:*
Das Programm muss _nur die Bibliotheken laden_, die es minimal braucht.
Führt zu schnelleren Ladezeiten.

*Flexibler Funktionsumfang:*
Programme können um Funktionalitäten _ergänzt_ werden, die beim Schreiben nicht vorgesehen
war. _Ablauf:_ Programm definiert API für Plugin-Bibliotheken und enthält Mechanismus,
anhand des Modulnamens Bibliotheken zu finden.

#pagebreak()

=== POSIX: Shared Objects API
```c void * dlopen (char * filename, int mode)``` _öffnet eine dynamische Bibliothek_ und
gibt ein _Handle_ darauf zurück.
`mode` gibt Art an, wie mit der Bibliothek umgegangen wird:
- _`RTLD_NOW`:_ Alle Symbole werden beim Laden der Bibliothek gebunden
- _`RTLD_LAZY`:_ Symbole werden bei Bedarf gebunden
- _`RTLD_GLOBAL`:_ Symbole können beim Binden anderer Objekt-Dateien verwendet werden\
  #hinweis[(damit andere Libs diese benutzen können)]
- _`RTLD_LOCAL`:_ Symbole werden nicht für andere Objekt-Dateien verwendet

```c void * dlsym (void * handle, char * name)``` gibt die _Adresse des Symbols_ `name`
aus der mit `handle` bezeichneten _Bibliothek_ zurück.
Keine Typinformationen, nur Adresse. Es ist also weder klar, ob es sich um Funktionen oder
Variablen handelt, noch welche Signatur bzw. welchen Typ diese haben.

```c
// type "func_t" is a address of a function with a int param and int return type
typedef int (*func_t)(int);
handle = dlopen("libmylib.so", RTLD_NOW); // open library
func_t f = dlsym(handle, "my_function"); // write address of "my_function" into a func_t
int *i = dlsym(handle, "my_int"); // get address of "my_int"
(*f)(*i); // call "my_function" with "my_int" as parameter
```
Dabei ist `f` die Adresse der Funktion namens `my_function` in `libmylib.so.1` und `i` die
Adresse der globalen Variable namens `my_int`. Beides sind Symbole, die von der Library
exportiert werden.

```c int dlclose (void * handle)```
schliesst das durch `handle` bezeichnete, zuvor von `dlopen` geöffnete Objekt.
Gibt 0 zurück, wenn erfolgreich. _Aufgepasst vor offenen Pointer auf Library-Symbole!_

```c char * dlerror()```
gibt die Fehlermeldung als null-terminierten String zurück, wenn ein Fehler aufgetreten war.

=== Shared-Object Konventionen
==== Automatisches Laden von Shared Objects
Shared Objects können _automatisch_ bei Bedarf geladen werden. Im Executable (ELF)
muss eine Referenz auf das Shared Object (ELF) hinterlegt sein (Dependency).
Das OS sucht automatisch beim Programmstart die richtigen Bibliotheken.

==== Shared Objects Benennungsschema
- _Linker-Name:_ `lib + Bibliotheksname + .so` #hinweis[(z.B. libmylib.so)]
- _SO-Name:_ `Linker-Name + . + Versionsnummer` #hinweis[(z.B. libmylib.so.2)]
- _Real-Name:_ `SO-name + . + Unterversionsnummer` #hinweis[(z.B. libmylib.so.2.1)]

Sind in POSIX meist gelinkt im Dateisystem: Linker #sym.arrow SO #sym.arrow Real
#hinweis[(libmylib.so #sym.arrow libmylib.so.2 #sym.arrow libmylib.so.2.1)]\
_Real-Name_ wird beim _Erstellen des Shared Objects_ verwendet.
Die _Versionsnummer_ wird erhöht, wenn sich die Schnittstelle _ändert_.
Die _Unterversionsnummer_ wird erhöht, wenn die Schnittstelle gleichbleibt
#hinweis[(Bugfixes)]. Der Linker verwendet den Linker-Namen, der Loader verwendet
den SO-Namen.

==== Shared Objects Koexistenz verschiedener Versionen
Alle Versionen und Unterversionen können gleichzeitig existieren und verwendet werden.
Programme können bei Bedarf die Unterversion ganz präzise angeben
#hinweis[(`libmylib.so.2` zeigt auf die neuste 2-er Version)].

=== Erstellen von Bibliotheken
==== Erstellen von statischen Bibliotheken mit dem `clang`
Zuerst kompilieren mit ```sh clang -c f1.c -o f1.o;```
```sh clang -c f2.c -o f2.o```,
dann zusammenfügen zu einem Archiv: ```sh ar r libmylib.a f1.o f2.o```
#hinweis[(`r` fügt Dateien hinzu oder überschreibt existierende)]

==== Dynamische Bibliotheken mit `clang` kompilieren
Falls zusätzlich zu den Befehlen oben `-fPIC` für Position-Independent Code verwendet
wird, kann ein spezielles Image erzeugt werden mit
```sh clang -shared -Wl, -soname, libmylib.so.2 -o libmylib.so.2.1 f1.o f2.o -lc```,
wobei _`-shared`_ = Erzeugen eines Shared Objects,
_`-Wl,`_ = Weitergeben der folgenden Option an den Linker,\
_`-soname`_ = spezifizieren des SO-Namens `libmylib.so.2`,
_`-lc`_ = Einbinden der Standard C-Bibliothek (`libc.so`).

=== Verwenden von Bibliotheken
- _Statische Bibliothek #hinweis[(Link-time Library)]:_
  ```sh clang main.c -o main -L. -lmylib```\
  #hinweis[(`-L.` fügt "." zum Suchpfad hinzu, `-lmylib` bezieht sich auf die Bibliothek
    `mylib`, nach Konvention also auf Datei `libmylib.a`)]
- _Dynamische Bibliothek, die mit Programm geladen werden soll #hinweis[(Load-time Library)]:_\
  ```sh clang main.c -o main -lmylib```\
  #hinweis[(`-lmylib` bezieht sich auf `libmylib.so`, ohne `-L.` muss `libmylib.so` im OS
    installiert sein)]
- _Dynamische Bibliothek, die mit `dlopen` geladen werden soll #hinweis[(Run-time Library)]:_\
  ```sh clang main.c -o main -ldl```\
  #hinweis[(`-ldl` linkt auf (dynamische) Bibliothek `libdl.so`, die `dlopen` etc zur
    Verfügung stellt)]

*Shared Objects:*
Referenzierte Shared Objects sind im _Executable_ abgelegt. _`readelf -d`_ zeigt den
_Inhalt der dynamischen Sektion_. Typ der entsprechenden Einträge ist _`NEEDED`_.
Das Tool _`ldd`_ zeigt _alle, auch indirekt_ benötigten Shared Objects an.
Dazu führt es die Executable aus, sollte deshalb nur auf _vertrauenswürdigen Executables_
ausgeführt werden.
Nahezu alle Executeables benötigen _zwei Shared Objects_:
- _`libc.so`:_ Standard C library
- _`ld-linux.so`:_ ELF Shared Object loader. Wird indirekt vom OS aufgerufen, wenn ein
  Shared Object geladen werden soll. Findet und lädt nacheinander alle benötigten
  Shared Objects, danach rekursiv die Dependencies der geladenen Shared Objects.

=== Implementierung von dynamischen Bibliotheken
Dynamische Bibliotheken müssen _verschiebbar_ sein und mehrere Bibliotheken müssen in den
_gleichen Prozess_ geladen werden können. Die Aufgabe des Linkers wird in den
Loader / Dynamic Linker verschoben #hinweis[(Load Time Relocation)].
#wrap-content(
  image("img/bsys_21.png"),
  align: top + right,
  columns: (60%, 40%),
)[
  Dynamische Bibliotheken sollen _Code zwischen Programmen teilen_.
  Code soll _nicht mehrfach_ im Speicher abgelegt werden, auch wenn mehrere Programme die
  Bibliothek verwenden. Das kann durch _Shared Memory_ gelöst werden.
  Jedes Programm kann eine _eigene virtuelle Page_ für den Code definieren.
  Diese werden auf denselben Frame im RAM gemappt, so belegt der Code den Hauptspeicher
  nur einmal.
]
_Code-Sharing_ erlaubt jedoch keinen _Position-Dependent Code_.
Wenn zwei Prozesse unterschiedliche virtuelle Seiten verwenden, an welchen Prozess werden
die Adressen angepasst? Deshalb muss mit dynamischen Bibliotheken mit
_Position-Independent Code_ gearbeitet werden. Dieser verwendet _keine absoluten
Adressen_, sondern nur Adressen _relativ zum Instruction Pointer_.

=== Position-Independent Code (PIC)
Für Position-Independent Code (PIC) muss der _Prozessor relative Instruktionen anbieten._
`x86_64` #hinweis[(64-bit Prozessoren)] hat relative Funktionsaufrufe und
Move-Instruktionen, `x86_32` #hinweis[(32-bit Prozessoren)] nur relative Calls.
Relative Moves können aber über relative Calls emuliert werden.

==== Relative Moves via Relative Calls
CPU legt bei einem Call die _Rücksprungadresse auf den Stack_.
Funktion `f` will relativen Move ausführen und ruft Hilfsfunktion `h` auf.
`h` kopiert _Rücksprungadresse_ vom Stack in ein _Register_ und springt zurück.
`f` hat nun die _Rücksprungadresse = Instruction Pointer_ im Register und kann relativ
dazu arbeiten, weil `f` nun weiss, wo sie im Speicher liegt.

==== Global Offset Table (GOT)
Existiert einmal pro dynamischer Bibliothek und Executable. Enthält _pro Symbol_, welches
von anderen Libs benötigt wird, _einen Eintrag_. Im Code werden relative Adressen in die
GOT verwendet. Der Loader füllt zur Laufzeit die Adressen in die GOT ein.

==== Procedure Linkage Table (PLT)
Implementiert _Lazy Binding_ #hinweis[(erst binden, wenn benötigt)].
Enthält _pro Funktion einen Eintrag_. PLT-Eintrag enthält einen _Sprungbefehl_ an Adresse
in GOT-Eintrag. Der GOT-Eintrag zeigt zunächst auf eine _Proxy-Funktion_, welche dann den
Link zur richtigen Funktion sucht und den eigenen GOT-Eintrag überschreibt.
_Vorteil:_ Erspart bedingten Sprung #hinweis[(teuer)].
