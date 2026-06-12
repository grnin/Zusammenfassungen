#import "../template--additional-formatting-templates.typ": *

/* preview
#import "../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content
#show: project.with(
    authors: ("Jasmin Fässler", "Nina Grässli", "Jannis Tschan"),
    fach: "BSys2",
    fach-long: "Betriebssysteme 2",
    semester: "FS26",
    language: "de",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)
// */

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


Mit `kill` kann ein Signal, mit einem dieser Default-Handler, gesendet werden:
===== *Abnormal-Terminate-Handler* | Beendet Programm + Core Dump (für Programmfehler)
_`SIGFPE`_ #hinweis[(Fehler in arithmetischen Operation)],
_`SIGILL`_ #hinweis[(Ungültige Instruktion)], \
_`SIGSEGV`_ #hinweis[(Ungültiger Speicherzugriff)],
_`SIGSYS`_ #hinweis[(Ungültiger Systemaufruf)]
// #table(
//     columns: 2,
//     stroke: rgb("#00287e2d"),
//     [SIGFPE], [Fehler in arithmetischer Operation],
//     [SIGILL], [Ungültige Instruktion],
//     [SIGSEGV], [Ungültiger Speicherzugriff],
//     [SIGSYS], [Ungültiger Systemaufruf],
// );
===== *Terminate-Handler* | Beendet das Programm (Prozess abbrechen)
_`SIGKILL`_ #hinweis[(*nicht überschreibbar*)]
_`SIGTERM`_ #hinweis[(Normale höfliche Anfrage an den Prozess, sich zu beenden)],
\
_`SIGINT`_ #hinweis[(Nachdrücklichere Aufforderung an Prozess, sich zu beenden)],
_`SIGQUIT`_ #hinweis[(Wie `SIGINT`, aber anormale Terminierung `Ctrl-\`)],
_`SIGABRT`_ #hinweis[(Wie `SIGQUIT`, aber vom Prozess an sich selber (Programmierfehler bemerkt))],
// #table(
//     columns: 2,
//     stroke: rgb("#0039b31a"),
//     inset: (top: 4pt, right: 3pt, bottom: 4pt, left: 3pt),
//     [SIGTERM], [die normale, höfliche Anfrage an den Prozess, sich zu beenden],
//     [SIGINT], [Etwas nachdrücklichere Aufforderung, Wird generiert, wenn der Benutzer `Ctrl-C` drückt],
//     [SIGQUIT],
//     [Wie SIGINT, aber anormale Terminierung. Wird generiert, wenn der Benutzer `Ctrl-\` (Ctrl-AltGr-<) drückt],

//     [SIGABRT],
//     [Wie SIGQUIT (anormale Terminierung). Wird bevorzugt vom Prozess an sich selbst geschickt, z.B. wenn er selbst einen Programmierfehler bemerkt],

//     [SIGKILL], [Kann der Prozess nicht blockieren, ignorieren oder abfangen, *nicht überschreibbar*],
// );
===== *Ignore-Handler* | ignoriert das Signal
// *Stop and Continue:*
_`SIGTSTP`_ #hinweis[(Versetzt den Prozess in den Zustand _stopped_, ähnlich wie _waiting_ `Ctrl-Z`)], \
_`SIGSTOP`_ #hinweis[(Wie `SIGTSTP`, aber *nicht überschreibbar*)],
_`SIGCONT`_ #hinweis[(Setzt den Prozess fort (`fg`))]\
// #table(
//     columns: 2,
//     stroke: rgb("#00287e2d"),
//     [SIGTSTP], [Versetzt einen Prozess in den Zustand stopped, ähnlich wie waiting. `Ctrl-Z`],
//     [SIGSTOP], [Wie SIGTSTP, aber *nicht überschreibbar* (abfangen/ignorieren)],
//     [SIGCONT], [Setzt den Prozess fort. Wird auf der Shell mit den Kommandos fg / bg erzeugt],
// );

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

