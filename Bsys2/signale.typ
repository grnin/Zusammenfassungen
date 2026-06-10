#import "../template--additional-formatting-templates.typ": *


// Signal Tabelle


== Signale
Signale ermöglichen es, einen Prozess _von aussen_ zu unterbrechen, wie ein _Interrupt_.
_Unterbrechen_ des gerade laufenden Prozesses/Threads, Auswahl und Ausführen der
_Signal-Handler-Funktionen_, _Fortsetzen_ des Prozesses. Werden über ungültige Instruktionen
oder Abbruch auf Seitens Benutzer ausgelöst. Jeder Prozess hat pro Signal einen Handler.

// *Handler:*
// _Ignore-Handler_ #hinweis[(ignoriert das Signal)],
// _Terminate-Handler_ #hinweis[(beendet das Programm)],
// _Abnormal-Terminate-Handler_ #hinweis[(beendet Programm und erzeugt Core-Dump)].
// Fast alle Signale ausser `SIGKILL` und `SIGSTOP` können _überschrieben_ werden.\



==== Die 3 Default-Handler für Signale
Mit `kill` kann eines dieser Signale gesendet werden:






*Abnormal-Terminate-Handler*: beendet das Programm und erzeugt Core Dump (für Programmfehler)\
// *Programmfehler-Signale:*
_`SIGFPE`_ #hinweis[(Fehler in arithmetischen Operation)],
_`SIGILL`_ #hinweis[(Ungültige Instruktion)],
_`SIGSEGV`_ #hinweis[(Ungültiger Speicherzugriff)],
_`SIGSYS`_ #hinweis[(Ungültiger Systemaufruf)]
#table(
    columns: 2,
    stroke: rgb("#00287e2d"),
    [SIGFPE], [Fehler in arithmetischer Operation],
    [SIGILL], [Ungültige Instruktion],
    [SIGSEGV], [Ungültiger Speicherzugriff],
    [SIGSYS], [Ungültiger Systemaufruf],
);

*Terminate-Handler* beendet das Programm (Prozess abbrechen)\
// *Prozesse abbrechen:*
_`SIGTERM`_ #hinweis[(Normale Anfrage an den Prozess, sich zu beenden)],
_`SIGINT`_ #hinweis[(Nachdrücklichere Aufforderung an den Prozess, sich zu beenden)],
_`SIGQUIT`_ #hinweis[(Wie `SIGINT`, aber anormale Terminierung)],
_`SIGABRT`_ #hinweis[(Wie `SIGQUIT`, aber vom Prozess an sich selber)],
_`SIGKILL`_ #hinweis[(Prozess wird "abgewürgt", kann nicht verhindert werden)]
#table(
    columns: 2,
    stroke: rgb("#00287e2d"),
    [SIGTERM], [die normale, höfliche Anfrage an den Prozess, sich zu beenden],
    [SIGINT], [Etwas nachdrücklichere Aufforderung, Wird generiert, wenn der Benutzer `Ctrl-C` drückt],
    [SIGQUIT],
    [Wie SIGINT, aber anormale Terminierung. Wird generiert, wenn der Benutzer `Ctrl-\` (Ctrl-AltGr-<) drückt],

    [SIGABRT],
    [Wie SIGQUIT (anormale Terminierung). Wird bevorzugt vom Prozess an sich selbst geschickt, z.B. wenn er selbst einen Programmierfehler bemerkt],

    [SIGKILL], [Kann der Prozess nicht blockieren, ignorieren oder abfangen, *nicht überschreibbar*],
);

*Ignore-Handler* ignoriert das Signal\
// *Stop and Continue:*
_`SIGTSTP`_ #hinweis[(Versetzt den Prozess in den Zustand _stopped_, ähnlich wie _waiting_)],
_`SIGSTOP`_ #hinweis[(Wie `SIGTSTP`, aber kann nicht ignoriert oder abgefangen werden)],
_`SIGCONT`_ #hinweis[(Setzt den Prozess fort)]\
#table(
    columns: 2,
    stroke: rgb("#00287e2d"),
    [SIGTSTP], [Versetzt einen Prozess in den Zustand stopped, ähnlich wie waiting. `Ctrl-Z`],
    [SIGSTOP], [Wie SIGTSTP, aber *nicht überschreibbar* (abfrangen/ignorieren)],
    [SIGCONT], [Setzt den Prozess fort. Wird auf der Shell mit den Kommandos fg / bg erzeugt],
);

// ==== *Signale von der Shell senden:*
// _`kill 1234 5678`_ sendet `SIGTERM` an Prozesse `1234` und `5678`
==== *```c int sigaction(int signal, struct sigaction *new, struct sigaction *old)```:*\
Definiert Signal-Handler für `signal`, wenn `new` $!= 0$.
#hinweis[(Eigene Signal-Handler definiert via `sigaction` struct:
    `sa_handler`: Zu callende Funktion,
    `sa_mask`: Blockierte Signale während Ausführung,
    bearbeitet nur durch `sig*set()`-Funktionen:
    `sigemptyset`, `sigfillset`, `sigaddset`, `sigdelset`, `sigismember`)]\
sigaction = transp. Datenstruktur, sigset_t = opake Datenstr. + implementationsabhängig

