#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de",
)*/

= X Window System
== GUI Basiskonzepte
Frühere Unix-Systeme waren rein _textorientierte_ Bedienschnittstellen und basierten auf
_programmgesteuerten Interaktionen_. Moderne Unix-Systeme verwenden ein _GUI mittels des
X Window System_ oder mittels anderen Technologien #hinweis[(Google Android, Apple Aqua,
Canonical Mir Display Server, Wayland).] Diese sind _Ereignisgesteuerte Interaktionen:_
Benutzer entscheidet, wann welches Ereignis ausgelöst wird, Programm reagiert auf Benutzer.

=== Vorteile
Auf Unix-Kern aufgesetzt und damit _austauschbar_. Installierbar, wenn _tatsächlich benötigt_.
Realisiert _Netzwerktransparenz_, _Plattform-unabhängig_.
X legt die _GUI-Gestaltung nicht_ fest.

=== Fenster
_Rechteckiger Bereich des Bildschirms._ Kann beliebig viele weitere Fenster enthalten
#hinweis[(z.B. Dialogbox, Scrollbar, Button...)], es gibt eine _Baumstruktur_ aller Fenster.
Der _Bildschirm_ ist die Wurzel.

=== Maus und Mauszeiger
Die _Maus_ ist ein physisches Gerät, das 2D-Bewegungen in Daten übersetzt.
Der _Mauszeiger_ ist eine Rastergrafik, die auf dem Bildschirm angezeigt wird.

Das OS bewegt den Mauszeiger _analog_ zur physischen Bewegung der Maus.
Die _Maustasten lösen Ereignisse_ aus. Das Ereignis soll für _das Fenster_ gelten,
über dem sich _der Hotspot_ befindet.

Der _Maustreiber erzeugt Nachrichten_, das _OS verteilt_ diese an die zuständige
_Applikation_, welche die Nachricht _verarbeitet_. Dieser Prozess ist _asynchron_.

=== GUI Architektur
Das GUI braucht mehr als X Window System.
- _X Window System:_ Grundfunktionen der Fensterdarstellung
  #hinweis[(Events von Kernel erhalten & Fenster zuordnen)]
- _Window Manager:_ Verwaltung der sichtbaren Fenster, Umrandung, Knöpfe
- _Desktop Manager:_ Desktop-Hilfsmittel wie Taskleiste, Dateimanager, Papierkorb etc.

_X_ selbst ist _unabhängig_ von einem bestimmten Window Manager oder Desktop.
Es existieren _viele verschiedene Implementierungen_ des Window Manager und Desktops.
Die _Gestaltung der Bedienoberfläche_ und Bedienphilosophie bleiben damit _frei_.

#pagebreak()

=== Window-Manager
_Läuft im Client_ und realisiert eine _Window Layout Policy_.
Platziert Client-Fenster auf dem Bildschirm.
Ist (nur) eine _Client-Applikation mit Sonderrechten_ zur Fensterverwaltung.

_Typische Dienste des Window Manager_ für den Benutzer:
- Applikationsfenster mit _Titelleiste, Umrandung und zusätzlichen Knöpfen_ versehen
- Fenster _verschieben_, _Grösse_ ändern, minimieren, maximieren
- Neue Applikationen _starten_
- _Darstellungsreihenfolge_ #hinweis[(stacking order)] überlappender Fenster ändern

=== Fensterverwaltung
_Fensterhierarchie:_ Root-Window ist zuoberst, bedeckt den ganzen Bildschirm.
Kinder des Root-Windows sind Top-Level Windows der Applikationen.
Die übrigen Kindfenster sind zur Anzeige von Menüs, BUTTons, usw. in Applikationen.\
Kindfenster können Elternfenster teilweise _überlappen_, jedoch overflow hidden.
Eingaben werden nur im Überlappungsbereich empfangen.
Es gibt zwei unterstützte _Fensterklassen:_
`InputOutput` #hinweis[(kann Ein- und Ausgaben verarbeiten)] und
`InputOnly` #hinweis[(Kann nur Eingaben verarbeiten)].

Der Window-Manager _dekoriert_ Top-level Windows von Applikationen mit Buttons,
Scrollbars, Titelleiste usw., indem er hinter jedes Top-level Window ein _Extrafenster_ legt.

=== Beispiele Grafischer Desktops basierend auf X
- _GNOME #hinweis[(Default auf Ubuntu)]:_ verwendet
  GTK+ #hinweis[(Fenster-Elemente und Widgets)],
  GDK #hinweis[(Wrapper für Grafikfunktionen)] und
  GLib #hinweis[(Allgemeine Datenstrukturen und Algorithmen)]
- _KDE_ verwendet Qt Toolkit #hinweis[(Fensterelemente, Widgets, Algorithmen)]

#wrap-content(
  image("img/bsys_52.png"),
  align: bottom + right,
  columns: (50%, 50%),
)[
  == Basiskonzepte des X Window System
  - _Display:_ Rechner mit Tastatur, Zeigegerät und $1..m$ Bildschirme
  - _X Client:_ Applikation, die einen Display nutzen will.
    Kann lokal oder entfernt laufen.
  - _X Server:_ Softwareteil des X Window System, der ein Display ansteuert.
    Läuft stets auf dem Rechner, auf dem die GUI-Ein-/Ausgaben anfallen.
]

=== Xlib
Ist das _C Interface_ für das X Protocol. Header wird in C Files eingebunden über
```c #include <X11/Xlib.h>```. Kompiliertes Executable muss mit X11 Library gelinkt werden:
`-lX11`. Hat zahlreiche Funktionen und Datentypen, wird aber meist _nicht direkt
verwendet_, sondern über X-Toolkits, welche eine _Software-Schicht oberhalb der Xlib_
darstellen. Diese stellen _Standardbedienelemente_ fertig zur Verfügung,
z.B. Command Buttons, Labels und Menüs. #hinweis[(Xt Toolkit, Tk Toolkit, Motif Toolkit,
Open Look Toolkit, GTK+ Toolkit, Qt Toolkit)]

==== Verbindung zum Display
Um einen Display zu verwenden, muss eine _Verbindung_ zu diesem bestehen.
Die Verbindung wird im _Datentyp `Display`_ gespeichert.

*```c Display * XOpenDisplay (char *display_name)```*
öffnet eine Verbindung zum lokalen oder entfernten Display namens `display_name`.
Falls `NULL`, wird der Wert der Umgebungsvariable `DISPLAY` verwendet.

*```c void XCloseDisplay (Display *display)```*
schliesst die Verbindung und entfernt die Ressourcen.

Es gibt Funktionen, um bestimmte Eigenschaften des Displays anzuzeigen
#hinweis[(`XDisplayHeight`, `XDisplayWidth`, `XRootWindow`)]

==== Erzeugen von Fenstern
_`XCreateSimpleWindow`_ ist eine einfachere Variante von _`XCreateWindow`_ mit folgenden
Parametern: Display, Parent Window, Koordinaten der oberen linken Ecke, Breite und Höhe,
Breite des Rands, Stil des Rands, Stil des Fensterhintergrunds.
_`XDestroyWindow`_ entfernt es und alle seine Unterfenster.

==== Anzeigen von Fenstern
- *```c XMapWindow (Display *, Window)```* bestimmt, dass ein Fenster auf dem Display
  angezeigt werden soll. Wird nur angezeigt, wenn _Elternfenster auch angezeigt_ wird.
  Teile des Fensters, die von anderen Fenstern _überdeckt_ werden, werden
  _nicht angezeigt_.
- *```c XMapRaised (Display *, Window)```* bringt das Fenster in den Vordergrund.
- *```c XMapSubwindows (Display *, Window)```* zeigt alle Unterfenster an.

Für jedes Fenster, das tatsächlich angezeigt wird, wird ein `Expose` Event erzeugt.

==== Verstecken von Fenstern
- *```c XUnmapWindow (Display *, Window)```* versteckt ein Fenster und all seine Unterfenster.
- *```c XUnmapSubwindows (Display *, Window)```* versteckt alle Unterfenster eines Fensters.

Für jedes Fenster, das versteckt wird, wird ein `UnmapNotify` Event erzeugt.

== Event Handling
=== X Protocol
Legt die _Formate für Nachrichten_ zwischen X Client und Server fest.
Es gibt 4 Typen von Nachrichten:
- _Requests:_ Dienstanforderungen, Client #sym.arrow Server
  #hinweis[("Zeichne eine Linie", "liefere aktuelle Fensterposition")]
- _Replies:_ Antworten auf bestimmte Requests, Client #sym.arrow.l Server
- _Events:_ spontane Ereignismeldungen, Client #sym.arrow.l Server
  #hinweis[("Mausklick", "Fenstergrösse wurde verändert")]
- _Errors:_ Fehlermeldungen auf vorangegangene Requests, Client #sym.arrow.l Server

=== Nachrichtenpufferung bei Requests
#wrap-content(
  image("img/bsys_53.png"),
  align: top + right,
  columns: (60%, 40%),
)[
  Für _Requests_ gibt es einen _Nachrichtenpuffer auf der Client-Seite_
  #hinweis[(Request Buffer)]. _Ziel:_ möglichst wenige Anforderungsübertragungen
  an X Server. Gruppierung von Anforderungen für bessere _Kommunikationseffizienz_.

  Übertragung an Server nur, wenn _sinnvoll oder zwingend nötig_\
  #hinweis[(Client beginnt auf Event zu warten und blockiert, Client-Request Reply des
    Servers wird benötigt, Client verlangt explizit Pufferleerung)]
]

#wrap-content(
  image("img/bsys_54.png"),
  align: top + right,
  columns: (46%, 54%),
)[
  === Nachrichtenpufferung bei Ereignissen
  Ereignisse werden _doppelt gepuffert_: beim X Server und beim Client.
  Die _Server-seitige Pufferung_ berücksichtigt _Netzwerkverfügbarkeit_,
  die _Client-Seitige_ hält _Events bereit_, bis vom Client abgeholt.
  Der Client liest Messages im Message-Loop mittels Funktion `XNextEvent()`.
]
=== X Event Handling
Ereignisse werden vom _Client verarbeitet oder weitergeleitet_. Der Client muss vorher
festlegen, _welche Ereignistypen_ er empfangen will #hinweis[(`XSelectInput()`)].
Die Selektion ist pro Fenster individuell, nur _selektierte_ Ereignistypen werden dem
Client _zugestellt_. Default: leer. Vom Fenster nicht gewünschte Ereignistypen gehen an
das übergeordnete Fenster.

*```c XSelectInput (Display *display, Window w, long event_mask)```*
legt als Maske fest, welche Events ausgewählt werden.
Masken sind vordefiniert, z.B. `ExposureMask` für `Expose`-Events.

*```c XNextEvent (Display *display, Event *event)```*
kopiert den nächsten Event aus dem Buffer in `event`. Die Identifikation des betroffenen
Displays und Fenster ist Teil des Events. #hinweis[(`event.display`, `event.window`)]

Der Client entscheidet, _wann_ er ein Event entgegennimmt.
Die Verarbeitung der Events erfolgt in einer Programmschleife in der Form:
```c
while(1) {
  XNextEvent(display, &event);
  switch (event.type) {
    case Expose: // Typisches Event: verlangt Neuzeichnen des Fensters
      ...
      break;
    case KeyPress: // Event: Taste wurde gedrückt
      ...
      if(...) exit(0);
      break;
  }
}
```

Events sind vom Typ _`XEvent`_. Dieser Typ ist eine C-Union über alle Event-Typen,
d.h. er ist so gross wie der _grösste Event-Typ_. Es gibt _33 verschiedene Event-Typen_
unterschiedlicher Grösse. Jeder Event-Typ ist ein _`struct`_, der als erstes den
_`int type`_ enthält. Der Programm-Code soll anhand von `type` den richtigen
_Union-Member_ verwenden.

== Zeichnen
=== Ressourcen
X Ressourcen sind _Server-seitige Datenhaltung zur Reduktion des Netzwerkverkehrs_.
Sie halten Informationen im Auftrag von Clients. Clients identifizieren Informationen mit
zugeordneten _Nummern_ #hinweis[(IDs)]. Damit ist _kein Hin- und Herkopieren_ komplexer
Datenstrukturen nötig.

==== Beispiele von X Ressourcen
- _Window:_ beschreibt Fenstereigenschaften
- _Pixmap:_ Rastergrafik #hinweis[(Verwendung z.B. für Icons, schnelles Neuzeichnen)]
- _Colormap:_ Farbtabelle #hinweis[(Setzt Farbindizes in konkrete Farben um)]
- _Font:_ Beschreibung einer Schriftart
- #link(<graphics-context>)[_Graphics-Context (GC):_] Grafikelementeigenschaften
  #hinweis[(Liniendicke, Farbe, Füllmuster)].
  Gleicher GC kann für verschiedene Grafikelemente benutzt werden.

=== Sichtbarkeit und Aktualisierung von Fensterinhalten
==== Pufferung verdeckter Fensterinhalte
- _Minimal:_ keine Pufferung durch X Server, Client muss bei Sichtbarwerden neu zeichnen
- _Optional:_ X Server hat Hintergrundspeicher zum Sichern der Inhalte abgedeckter Fenster
- Abfragbar von Applikation ob vorhanden mittels `XDoesBackingStore()`

==== X-Ressource Pixmap
_Server-seitiger Grafikspeicher_, von Client privat anleg- und nutzbar.
_Anwendung:_ z.B. komplizierte Inhalte in pixmap schreiben, bei Bedarf pixmap in Fenster
kopieren #hinweis[(pixmap wird immer gecached)].

#pagebreak()

=== X Grafikfunktionen
Bilddarstellung mittels _Rastergrafik_ und _Farbtabelle_
#hinweis[(Heute weniger als Tabelle, weil zu viele Farben)].
- _Schwarz/Weiss:_ genau ein Bit pro Bildpunkt
- _Farben oder Grautöne:_ Mehrere Bits pro Bildpunkt.
  Keine direkte Farbzuordnungen zu Binärwerten, sondern Index in einer Farbtabelle
  #hinweis[(color lookup table, colormap)].
  Jedes Fenster kann theoretisch eine eigene Farbtabelle benutzen. In der Praxis oft nur
  eine einzige Farbtabelle für alle Applikationen.

_Vorteil Tabelle:_ Reduktion der Bits pro Farbe von $n$ #hinweis[(Anzahl Bits pro absolut
darstellbarer Farbe)] auf $m$ #hinweis[(Anzahl Bits pro gleichzeitig darstellbarer Farbe)].
Es sind also statt $2^n$ nur noch $2^m$ Farben gleichzeitig darstellbar
#hinweis[(Gilt nur für normale Fensterelemente, Bilder & Videos können ganzen Farbraum nutzen)].

_Grafikgrundfunktionen_ erlauben das Zeichnen von Geometrischen Figuren, Strings und Texten.
_Ziele_ für das Zeichnen können Fenster oder Pixmap sein.

=== Graphics Context <graphics-context>
Grafikgrundfunktionen _benötigen einen Graphics Context_ #hinweis[(X Ressource)].
Legt diverse _Eigenschaften_ fest, die Systemaufrufe nicht direkt unterstützen
#hinweis[(z.B. Liniendicke, Farben, Füllmuster)]. Client muss erst _GC anlegen_ vor Aufruf
einer Zeichenfunktion. Client kann _mehrere GCs gleichzeitig_ nutzen.
_`XCreateGC`_ legt neuen GC an,
_`XCopyGC`_ kopiert GC,
_`XFreeGC`_ zerstört GC.
_`XDefaultGC`_ gibt den Standard GC für den angegebenen Screen zurück.

=== Grafik-Primitive (Auswahl)
- _Einfache Formen:_ `XDrawPoint(s)`, `XDrawLine(s)`, `XDrawSegments`, `XDrawRectangle(s)`,
  `XFillRectangle(s)`, `XDrawArc(s)`, `XFillArcs`
- _Text:_ `XDrawString`, `XDrawText`
- _Bilder:_ `XPutImage`

== Fenster schliessen
Die Schaltfläche zum Schliessen eines Fensters wird vom _Window Manager_ erzeugt.
X weiss _nichts_ über die spezielle Bedeutung dieser Schaltfläche,
der _Window Manager schliesst_ das Fenster. Damit die Applikation davon erfährt,
gibt es ein _Protokoll_ zwischen Window Manager und der Applikation.
Der Window Manager sendet ein _`ClientMessage` Event_ an die Applikation.
Dieses Event muss in seinem `data`-Teil die ID eines Properties
_`WM_DELETE_MESSAGE`_ enthalten.

=== Atoms
Ein Atom ist die _ID eines Strings_, der für _Meta-Zwecke_ benötigt wird.
Anstelle der Strings verwendet man stattdessen die entsprechenden Atoms.
Das _erspart_ das ständige Parsen der Strings
#hinweis[(z.B. statt `WM_DELETE_MESSAGE` verwendet man intern Atom 5)].

*```c Atom XInternAtom (Display *, char *, Bool only_if_exists)```*
_übersetzt_ den String in ein Atom auf dem angegeben Display.
_`only_if_exists`_ gibt an, ob das Atom erzeugt werden soll, wenn es nicht existiert
#hinweis[(`only_if_exists = false`)].

=== Properties
Mit jedem Fenster können _Properties_ assoziiert werden.
Der Window Manager _liest und/oder setzt_ diese Properties.
_Generischer Kommunikations-Mechanismus_ zwischen Applikation und Window Manager.
Eine Property wird über ein Atom _identifiziert_. Zu jedem Property gehören _spezifische
Daten_ #hinweis[(z.B. ein oder mehrere Strings oder eine Liste von Atomen).]

==== `WM_PROTOCOLS`
Der X Standard definiert eine _Anzahl an Protokollen_, die der Window Manager verstehen soll.
Ein Client kann sich für Protokolle _registrieren_. Dazu muss er im Property
_`WM_PROTOCOLS`_ die Liste der Atome der Protokollnamen speichern.
Das geschieht mit der Funktion `XSetWMProtocols.`

*```c XSetWMProtocols (Display *, Window, Atom *first_proto, int count)```*
speichert im Property `WM_PROTOCOLS` die Atome aus dem Array, das an `first_proto` beginnt
und `count` Elemente enthält.

==== `WM_DELETE_WINDOW`
Der Window Manager schickt ein Event an den Client, wenn man auf den Close-Button drückt.
Der Event-Typ ist `ClientMessage`, wird immer vom Client verarbeitet.
Im Datenteil des Events steht das Atom von `WM_DELETE_WINDOW`.

#table(
  columns: (1fr, auto),
  table.header([Registrierung des Clients], [Verarbeiten des Events]),
  [
    ```c
    Atom atom = XInternAtom (display,
      "WM_DELETE_WINDOW",
      /* only_if_exists = */ False);
    XSetWMProtocols (
      display, window, &atom, 1);
    ```
  ],
  [
    ```c
    switch (event.type) {
      case ClientMessage:
        if (event.client->data.l[0] == atom) { ... }
        break;
    }
    ```
  ],
)
