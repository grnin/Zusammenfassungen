#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de"
) */

= Signale, Pipes und Sockets
== Signale
Signale ermöglichen es, einen Prozess _von aussen_ zu unterbrechen.
Wird ein Signal an einen Prozess geschickt, verhält sich das OS, als ob ein
_Interrupt_ geschickt wurde #hinweis[(quasi Software-Interrupts)]:
- _Unterbrechen_ des gerade laufenden Prozesses/Threads
- Auswahl und Ausführen der _Signal-Handler-Funktionen_
- _Fortsetzen_ des Prozesses

=== Quelle von Signalen
- _Hardware / OS_
  #hinweis[(ungültige Instruktion, Zugriff auf ungültige Speicheradresse, Division durch 0)]
- _Andere Prozesse_
  #hinweis[(Abbruch des Benutzerprogramms über Ctrl-C, Aufruf des Kommandos `kill`)]

=== Signale behandeln
Jeder Prozess hat _pro Signal einen Handler_. Bei Prozessbeginn gibt es für jedes Signal
einen von _drei Default-Handlern_:
- _Ignore-Handler:_ ignoriert das Signal
- _Terminate-Handler:_ beendet das Programm
- _Abnormal-Terminate-Handler:_ beendet das Programm und erzeugt Core Dump
  #hinweis[(Snapshot des Programms)]
Fast alle Signal-Handler können _überschrieben_ werden, _ausser `SIGKILL` und `SIGSTOP`._


=== Wichtige Signale
*Programmfehler:*
Diese Signale werden vom OS erzeugt und nutzen standardmässig den
Abnormal-Termination-Handler:
- _`SIGFPE`:_ Fehler in arithmetischen Operation #hinweis[(floating point error)]
- _`SIGILL`:_ Ungültige Instruktion #hinweis[(illegal instruction)]
- _`SIGSEGV`:_ Ungültiger Speicherzugriff #hinweis[(segmentation violation)]
- _`SIGSYS`:_ Ungültiger Systemaufruf

*Prozesse abbrechen:*
- _`SIGTERM`:_ Normale Anfrage an den Prozess, sich zu beenden
  #hinweis[(terminate)]
- _`SIGINT`:_ Nachdrücklichere Aufforderung an den Prozess, sich zu beenden
  #hinweis[(interrupt, Ctrl-C)]
- _`SIGQUIT`:_ Wie `SIGINT`, aber anormale Terminierung
  #hinweis[(Ctrl-\\)]
- _`SIGABRT`:_ Wie `SIGQUIT`, aber vom Prozess an sich selber
  #hinweis[(abort, bei Programmfehler z.B.)]
- _`SIGKILL`:_ Prozess wird "abgewürgt", kann vom Prozess nicht verhindert werden

*Stop and Continue:*
- _`SIGTSTP`:_ Versetzt den Prozess in den Zustand _stopped_, ähnlich wie _waiting_
  #hinweis[(terminal stop, Ctrl-Z)]
- _`SIGSTOP`:_ Wie `SIGTSTP`, aber kann nicht ignoriert oder abgefangen werden
- _`SIGCONT`:_ Setzt den Prozess fort
  #hinweis[(Auf shell mit `fg` / `bg` = foreground / background)]

=== Signale von der Shell senden
Das Kommando `kill` sendet ein Signal an einen oder mehrere Prozesse
#hinweis[(ohne Angabe eines Signals wird `SIGTERM` gesendet)]
- _`kill 1234 5678`_ sendet `SIGTERM` an Prozesse `1234` und `5678`
- _`kill -KILL 1234`_ sendet `SIGKILL` an Prozess `1234`
- _`kill -l`_ listet alle möglichen Signale auf

=== Signal-Handler im Programm ändern: `sigaction`
*```c int sigaction (int signal, struct sigaction *new, struct sigaction *old)```*\
_`signal`_ ist die _Nummer des Signals_ #hinweis[(`SIGKILL` oder `SIGSTOP` nicht erlaubt)].
_Definiert_ Signal-Handler für `signal`,\ wenn `new` $!= 0$.
_Gibt_ den _bestehenden_ Signal-Handler für `signal` _zurück_, wenn `old` $!= 0$

*```c struct sigaction { void (*sa_handler)(int); sigset_t sa_mask; int sa_flags;}```*\
_`sa_handler`_ ist die _Adresse der Funktion_, die aufgerufen wird, wenn das Signal auftritt.
_`sa_mask`_ gibt an, welche Signale während Handler-Ausführung blockiert werden, das
eigene Signal wird immer blockiert.
_`sa_flags`_ ermöglicht verschiedene zusätzliche Eigenschaften.

=== Signale spezifizieren
_`sigset_t`_ wird nur mit folgenden Funktionen verwendet:
- _```c int sigemptyset (sigset_t *set)```:_ Kein Signal ausgewählt
- _```c int sigfillset (sigset_t *set)```:_ Alle Signale ausgewählt
- _```c int sigaddset (sigset_t *set, int signal)```:_ Fügt `signal` der Menge hinzu
- _```c int sigdelset (sigset_t *set, int signal)```:_ Entfernt `signal` aus der Menge
- _```c int sigismember (const sigset_t *set, int signal)```:_ Gibt 1 zurück, wenn
  `signal` in der Menge enthalten ist.


== Pipes
Eine geöffnete Datei entspricht einem _Eintrag in der File-Descriptor-Tabelle (FDT)_
im Prozess. Zugriff über _File-API_ #hinweis[(`open`, `close`, `read`, `write`, ...)].
Prozess weiss _nicht_, was eine Datei ist und wie das OS damit umgeht. Das OS speichert
_je Eintrag der Prozess-FDT_ einen _Verweis auf die globale FDT_. Wenn ein Prozess mit
`fork` neu erzeugt wird, wird auch die _FDT_ des Parents in das Child _kopiert_.

=== ```c int dup (int source_fd); int dup2 (int source_fd, int destination_fd);```
_Duplizieren den File-Descriptor_ `source_fd` und geben den neuen File-Descriptor zurück.
_`dup`_ alloziert einen _neuen FD_, _`dup2`_ _überschreibt_ `destination_fd`.

=== Umleiten des Ausgabestreams
```c
int fd = open ("log.txt", ...);
int id = fork ();
if (id == 0) { // child
  dup2 (fd, 1); // duplicate fd for log.txt as standard output
  // e.g. load new image with exec*, fd's remain
} else { // parent
  close (fd);
}
```

=== Abstrakte Dateien
Die _Konsole_ ist _keine Datei_ auf einem Datenträger, aber trotzdem _Standard-Ausgabestream_.
Die Abstraktion _"Datei"_ sagt _nichts über die Infrastruktur_ aus. Eine "Datei" muss nur
`open`, `close` etc. unterstützen. _"In POSIX, everything is a file"._

Eine Pipe ist eine "Datei" im Hauptspeicher, die über zwei File-Deskriptoren verwendet wird:
- _read end_ zum Lesen aus der Pipe
- _write end_ zum Schreiben in die Pipe
Daten, die in _write end_ geschrieben werden, können aus _read end_ genau _einmal_
und als _FIFO_ gelesen werden.
Pipes unterstützen _kein `lseek`_, erlauben aber _Kommunikation über Prozess-Grenzen hinweg_.

=== ```c int pipe (int fd[2]) // equivalent to int pipe(int *fd)```
_Erzeugt eine Pipe_ und zwei FD's #hinweis[(0 = read, 1 = write)], die in `fd` abgelegt werden.
Pipe lebt solange, wie eines der beiden Enden in einem Prozess geöffnet ist.
Rückgabewert 0, wenn OK, sonst -1 und Fehlercode in `errno`.
Unter Linux _Default-Pipe-Grösse: 16 Pages_ #hinweis[(mit 4 KB-Pages = 64 KB)].
Kann mit `close`, `read` und `write` _wie Datei_ verwendet werden.

#pagebreak()

=== Daten von Parent zu Child
```c
int fd [2];
pipe (fd);
int id = fork();

if (id == 0) { // Child
  close (fd [1]); // don't use write end
  char buffer [BSIZE];
  int n = read (fd[0], buffer, BSIZE);
} else {
  close (fd[0]); // don't use read end
  char * text = "Die Zemmefassig isch viel z lang";
  write (fd [1], text, strlen(text) + 1);
}
```

=== Lesen aus einer Pipe
Aus einer Pipe kann mit `read` gelesen werden, als ob sie eine _Datei_ wäre.
Sind _keine Daten_ in der Pipe, _blockiert_ `read`, bis Daten hineingeschrieben werden.
Gibt es zusätzlich _kein geöffnetes Write-End_ mehr, gibt `read` 0 zurück _(EOF)_.
_Lesender Prozess_ muss deshalb sein _Write-End schliessen_, damit schreibender Prozess
über das Schliessen seines Write-Ends das _Ende der Kommunikation mitteilen_ kann.

=== Standard-Ausgabe mit -Eingabe verknüpfen
#wrap-content(
  image("img/bsys_37.png"),
  align: top + right,
  columns: (80%, 20%),
)[
  Beispiel-Befehl in Shell: `cmda | cmdb`
  ```c
  int fd [2];
  pipe (fd);
  int id1 = fork();

  if (id1 == 0){ // child (cmda)
    close (fd [0]); // don't use read end
    dup2 (fd [1], 1); // define pipe write end as stdout
    exec ("cmda", ...);
  } else { // parent (shell)
    int id2 = fork();
    if (id2 == 0) { // child (cmdb)
      close (fd[1]); // don't use write end
      dup2 (fd [0], 0);
      exec ("cmdb", ...);
    } else { // parent (shell)
      wait (0);
      wait (0);
    }
  }
  ```
]

Pipes sind _unidirektional:_ es ist nicht spezifiziert, was beim Schreiben ins _read end_
oder Lesen vom _write end_ passiert. Sind _alle read ends_ geschlossen, erhält Prozess mit
_write end_ ein _`SIGPIPE`_ #hinweis[(Broken Pipe)].

_Wann_ der Transport erfolgt, ist implementierungsabhängig. Mehrere `writes` können bspw.
zusammengefasst werden. Ein Rückgabewert $<n$ von `read(...,n)` bedeutet _nicht_,
dass später nicht noch mehr Daten kommen können. Lesen mehrere Prozesse die selbe Pipe,
ist unklar, welcher die Daten erhält.

=== ```c int mkfifo (const char *path, mode_t mode);```
Erzeugt eine Pipe _mit Namen und Pfad_ im Dateisystem. Hat via `mode` _permission bits_
wie eine normale Datei. Lebt _unabhängig vom erzeugenden Prozess_, je nach System auch
über Reboots hinweg. Muss explizit mit _`unlink` gelöscht_ werden.

#pagebreak()

== Sockets
#wrap-content(
  image("img/bsys_38.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  Berkeley Sockets sind eine Abstraktion über Kommunikationsmechanismen.
  Beispiele: UDP, TCP über IP sowie Unix-Domain-Sockets. Ein Socket _repräsentiert einen
  Endpunkt auf einer Maschine_. Kommunikation findet im Regelfall zwischen zwei Sockets statt.
  Sockets benötigen für Kommunikation einen Namen: #hinweis[(IP: IP-Adresse, Portnr.)]
]

=== ```c int socket(int domain, int type, int protocol);```
_Erzeugt einen neuen Socket als "Datei"_. Socket sind nach Erzeugung zunächst _unbenannt_.
Alle Operationen blockieren per default.
Gibt FD zurück ($>= 0$) bzw. -1 bei Fehler mit Fehlercode in `errno`.


- _`domain`:_ Adress-Domäne #hinweis[(`AF_UNIX`: Innerhalb einer Maschine,
  `AF_INET`: Internet-Kommunikation über IPv4, Adressen sind IP-Adressen plus Ports,
  `AF_INET6`: Internet-Kommunikation über IPv6)]
- _`type`:_ Art der Kommunikation #hinweis[(`SOCK_DGRAM`: Datagram-Socket wie UDP,
  `SOCK_STREAM`: Byte-Stream Socket wie TCP)]
- _`protocol`:_ System-spezifisch, 0 = Default-Protocol

*Ein Client verwendet einen Socket in folgender Reihenfolge:*
+ _`connect`:_ Verbindung unter Angabe einer Adresse aufbauen
  #hinweis[(Socket erhält damit Namen)]
+ _`send` / `write`:_ Senden von Daten, $0 - infinity$ mal #hinweis[(z.B. eine Anfrage)]
+ _`recv` / `read`:_ Empfangen von Daten, $0 - infinity$ mal #hinweis[(z.B. eine Antwort)]
+ _`close`:_ Schliessen der Verbindung

*Ein Server verwendet einen Socket in folgender Reihenfolge:*
+ _`bind`:_ Festlegen einer nach aussen sichtbaren Adresse
  #hinweis[(z.B. zuweisen von IP/Port)]
+ _`listen`:_ Bereitstellen einer Queue zum Sammeln von Verbindungsanfragen von Clients
+ _`accept`:_ Erzeugen einer Verbindung auf Anfrage von Client
  #hinweis[(erzeugt neuen Socket)]
+ _`recv` / `read`:_ Empfangen von Daten, $0 - infinity$ mal #hinweis[(z.B. eine Anfrage)]
+ _`send` / `write`:_ Senden von Daten, $0 - infinity$ mal #hinweis[(z.B. eine Antwort)]
+ _`close`:_ Schliessen der Verbindung

=== Beispiel Angabe IP-Adresse
```c
struct sockaddr_in ip_addr;
ip_addr.sin_port = htons (443); // default HTTPS port
inet_pton (AF_INET, "192.168.0.1", &ip_addr.sin_addr.s_addr);
// port in memory: 0x01 0xBB
// addr in memory: 0xC0 0xA8 0x00 0x01
```
_`htons`_ konvertiert 16 Bit von Host-Byte-order #hinweis[(LE)] zu Network-Byte-Order
#hinweis[(BE)], _`htonl`_ 32 Bit. _`ntohs`_ und _`ntohl`_ sind Gegenstücke.
_`inet_pton`_ konvertiert protokoll-spezifische Adresse von String zu Network-BO.
_`inet_ntop`_ ist das Gegenstück #hinweis[(network-to-presentation)].

=== ```c int bind (int socket, const struct sockaddr *local_address, socklen_t addr_len);```
_Bindet_ den Socket an die _angegebene_, unbenutze _lokale Adresse_, wenn noch nicht gebunden.
_Blockiert_, bis der Vorgang abgeschlossen ist.
Gibt 0 zurück, wenn alles OK, sonst -1 und Fehlercode in `errno`.

=== ```c int connect (int socket, const struct sockaddr *remote_addr, socklen_t addr_len);```
_Aufbau einer Verbindung_. _Bindet_ den Socket an eine _neue_, unbenutzte _lokale Addresse_,
wenn noch nicht gebunden. _Blockiert_, bis Verbindung steht oder ein Timeout eintritt.
Gibt 0 zurück, wenn alles OK, sonst -1 und Fehlercode in `errno`.

=== ```c int listen (int socket, int backlog);```
_Markiert_ den Socket als _"bereit zum Empfang von Verbindungen"_. Erzeugt eine
_Warteschlange_, die so viele Verbindungsanfragen aufnehmen kann, wie `backlog` angibt.
Gibt 0 zurück, wenn alles OK, sonst -1 und Fehlercode in `errno`.

=== ```c int accept (int socket, struct sockaddr *remote_address, socklen_t address_len);```
_Wartet_ bis eine _Verbindungsanfrage_ in der Warteschlange _eintrifft_. Erzeugt einen
neuen Socket und bindet ihn an eine neue lokale Adresse. Die Adresse des Clients wird in
_`remote_address`_ geschrieben. Der neue Socket kann keine weiteren Verbindungen annehmen,
der bestehende hingegen schon.
Gibt FD des neuen Sockets zurück, wenn alles OK, sonst -1 und Fehlercode in `errno`.

=== Typisches Muster für Server
```c
int server_fd = socket ( ... );
bind (server_fd, ...);
listen (server_fd, ...);
while (running) {
  int client_fd = accept (server_fd, 0, 0);
  delegate_to_worker_thread (client_fd); // will call close(client_fd)
}
```

=== `send` und `recv`
```c ssize_t send (int socket, const void *buffer, size_t length, int flags);```\
```c ssize_t recv (int socket, void *buffer, size_t length, int flags);```

_Senden und Empfangen von Daten_. Puffern der Daten ist Aufgabe des Netzwerkstacks.
```c
send (fd, buf, len, 0) == write (fd, buf, len);
recv (fd, buf, len, 0) == read (fd, buf, len)
```

=== ```c int close (int socket);```
_Schliesst_ den Socket für den _aufrufenden_ Prozess. Hat ein anderer Prozess den Socket
noch geöffnet, bleibt die Verbindung bestehen. Die Gegenseite wird _nicht_ benachrichtigt
#hinweis[(Schlechte Idee, besser `shutdown`)].

=== ```c int shutdown (int socket, int mode);```
_Schliesst_ den Socket für _alle_ Prozesse und baut die entsprechende Verbindung ab.
- _`mode = SHUT_RD`:_ Keine Lese-Zugriffe mehr
- _`mode = SHUT_WR`:_ Keine Schreib-Zugriffe mehr
- _`mode = SHUT_RDWR`:_ Keine Lese- oder Schreib-Zugriffe mehr
