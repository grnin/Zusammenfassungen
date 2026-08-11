// Compiled with Typst 0.15.1
#import "../template_zusammenf.typ": *
#import "@preview/chronos:0.3.0"

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "UIP",
  fach-long: "UI Patterns and Frameworks",
  semester: "HS25",
  language: "de",
  font-size: 8.5pt,
  tableofcontents: (enabled: true, columns: 3, depth: 3),
)

// 4 A4 blätter, doppelseitig: 16 Seiten ZF
// 80 Punkte allgemein
// 40 Punkte MAUI

// Global configuration
#show table.cell: set par(justify: false)

// Decrease font size in single- and multiline code blocks
#show raw.where(block: false): set text(size: 0.95em)
#show raw.where(block: true): set text(size: 0.83em)

#set page(columns: 2, margin: 2.5em)

= Einleitung
#v(-0.5em)
== Vorteile von GUIs
Dank GUIs kann auch die breite Öffentlichkeit Computer verwenden.
- _Einfacher Einstieg:_ Wenig Lernaufwand, User muss keine Befehle merken
- _Übersicht:_ Ein GUI zeigt ganz einfach grafisch eine Übersicht über das Programm und seinen Funktionen an.
  Dadurch können auch Funktionen entdeckt werden, die man als Benutzer noch nicht kannte
- _Keine Tippfehler:_ Im Vergleich zu CLIs kann man Klicken statt Tippen, was Fehler durch Vertippen ausschliesst
- _Visuelles Feedback:_ Status, Fortschritt, Warnungen etc. sind sofort erkennbar

== RAD / Low-Code Entwicklung
Mit Low-Code Entwicklung und _Rapid Application Development (RAD)_ können sehr schnell GUIs zusammengeklickt werden.
Dieser Ansatz führt jedoch langfristig zu vielen Problemen wie _Abhängigkeit_ #hinweis[(Vendor Lock-in)], _Wartbarkeit_
#hinweis[(Fehlende Vorgabe von Separation of Concerns)], _Nachvollziehbarkeit_ #hinweis[(Riesige Vererbungshierarchien
  der UI Controls)] und _Testing_ #hinweis[(Gibt es nicht)].
*RAD ist eine Zeitbombe:*
Weiterentwicklung wird unmöglich und ein Neuanfang ist finanziell unrealistisch.

== Schlechter Code
_Lesen und Verstehen_ von Code ist der grösste Teil der Programmierarbeit. Das Lokalisieren von Bugs ist bei schwer
lesbarem Code sehr aufwändig. Das führt zu _hohen Kosten für die Weiterentwicklung_. Es ist bei schlechtem Code fast
unmöglich, kleine Einheiten zu ändern ohne dabei anderen, funktionierenden Code nicht anzutasten. Durch _schlechte
Testbarkeit_ schleichen sich bei der Weiterentwicklung neue Fehler ein.

== Langlebigkeit von User Interfaces
Die Langlebigkeit von User Interfaces wird beeinflusst durch:
- _Nachvollziehbarkeit & Wartbarkeit:_ Durch Unabhängigkeit der Geschäftslogik von der Darstellung, Testbarkeit und
  Lesbarkeit wird die Nachvollziehbarkeit und Wartbarkeit sichergestellt.
- _Langfristige Unabhängigkeit:_ Abhängigkeit von Herstellern vermindern, Plattformunabhängigkeit, Abtrennung von UI
  Technologien
- _Austauschbarkeit des UIs:_ Verschiedene Darstellungen anbieten #hinweis[(Mobile/Desktop UIs)], verschiedene Arten von
  Benutzerinteraktion anbieten #hinweis[(Maus/Tastatur, Touch)], Darstellung und Interaktion austauschen, ohne die Geschäftslogik anzutasten.
- _Nicht alles neu erfinden:_ Es gibt Muster (Patterns) und Prinzipien, die sich bewährt haben, Konzepte, die vieles
  vereinfachen und Gerüste (Frameworks) für unsere Applikationen.


= Design Prinzipien
Software-Design-Prinzipien sind _Regeln_ und _Grundsätze_, die bei der Entwicklung bedacht werden sollten und helfen,
systematische Probleme zu lösen. Sie unterstützen dabei, _Qualitätseigenschaften_ der Software wie Wartbarkeit,
Erweiterbarkeit und Stabilität zu erreichen. Dabei müssen sie aber nicht stur eingesetzt werden, sondern nur wo
sinnvoll.

== KISS (Keep it simple, stupid)
Systeme und Lösungen sollten _so einfach wie möglich_ gehalten werden, da Komplexität zu schwer wartbarem und
fehleranfälligem Code führt. Sollte aber nie ein Vorwand sein, ein UI nicht von Geschäftslogik zu trennen.\
*Ziel:*
Einfachheit eines Designs beibehalten, um die Verständlichkeit und Wartbarkeit zu fördern.\
*Vorgehen:*
Unnötige Funktionen oder komplizierte Architektur vermeiden. Klare, nachvollziehbare Lösungen verwenden.

== YAGNI (You ain't gonna need it)
Funktionen und Features, die aktuell _nicht benötigt_ werden, sollten _nicht implementiert_ werden. Die Entwickler
sollten sich auf die _unmittelbaren Anforderungen_ konzentrieren. Saubere Architektur ist aber trotzdem ein Muss.\
*Ziel:*
Ressourcenverschwendung und unnötige Komplexität vermeiden.\
*Vorgehen:*
Nur das implementieren, was aktuell benötigt wird. Zusätzliche Features auf den Zeitpunkt verschieben, an welchem
sie gebraucht werden.

== DRY (Don't Repeat yourself)
Jede Information innerhalb eines Systems sollte _nur einmal existieren_. Duplikation führt zu Inkonsistenzen und
erschwert die Wartung, da Änderungen an mehreren Stellen durchgeführt werden müssen.\
*Ziel:*
Reduzierung von Redundanz und Erhöhung der Wartbarkeit.\
*Vorgehen:*
Gemeinsame Logik oder Daten an einem zentralen Ort speichern und wiederverwenden, anstatt zu duplizieren.

== Law of Demeter (Don't talk to strangers)
Objekte sollten nur mit _eng verwandten_ Objekten kommunizieren. Ein Objekt sollte nicht direkt auf die inneren Details
anderer Objekte zugreifen, sondern nur mit den unmittelbaren Nachbarn interagieren.\
*Ziel:*
Reduzierung der Abhängigkeiten zwischen Klassen und Verbesserung der Kapselung.
*Vorgehen:*
Verkettete Methodenaufrufe vermeiden #hinweis[(z.B. `car.getMotor().start()`)]. Jede Klasse sollte nur Methoden von
Objekten aufrufen, die sie direkt kennt #hinweis[(z.B. Wrapper-Methode `car.start()`, welche `motor.start()` callt)].

== Komposition vor Vererbung
Vererbungen kreieren _statische Abhängigkeiten_: Die Child-Klasse ist komplett abhängig vom Parent, sie kann ohne sie
nicht kompiliert werden. Änderungen im Parent betreffen auch alle Children. Häufig benötigt eine Klasse _nicht alle
Eigenschaften_ seines Parents. Deswegen wird Komposition #hinweis[("hat"-Beziehung)] vorgezogen: Entweder durch
Interfaces oder Kombination von Objekten zur Laufzeit #hinweis[(eine Instanz der Child-Klasse ist eine Klassenvariabel
  im Parent)].\
*Ziel:*
Vermeidung starrer, hierarchischer Beziehungen und Förderung von lose gekoppelten, flexiblen Systemen. \
*Vorgehen:*
Anstatt eine Unterklasse von einer Basisklasse abzuleiten, sollten Interfaces definiert werden, welche sich
auf die Fähigkeiten eines Objekts beziehen. Sehr oft ist eine "hat"-Beziehung #hinweis[(Komposition)] die richtige
Lösung.

== S.O.L.I.D. Prinzipien
*Single Responsibility Principle (SRP):*
Es sollte nie mehr als einen Grund dafür geben, eine Einheit zu ändern. Jede Klasse oder Komponente sollte also nur
_eine Verantwortung_ haben.
*Ziel:*
Verbesserung der Verständlichkeit und Wartbarkeit durch klare Trennung der Verantwortlichkeiten.

*Open / Closed Principle (OCP):*
Einheiten sollten sowohl _offen für Erweiterungen_ als auch _geschlossen für Modifikationen_ sein. Das bedeutet, dass
bestehender Code nicht verändert, sondern ergänzt werden sollte, wenn neue Funktionen hinzugefügt werden.
*Ziel:*
Reduzierung der Änderungen an bestehendem Code und Erleichterung der Erweiterbarkeit des Systems.

*Liskov Substitution Principle (LSP):*
_Subtypen_ sollten ohne Probleme überall _eingesetzt_ werden können, wo der _Basistyp_ erwartet wird. Ein Objekt einer
abgeleiteten Klasse muss sich also wie ein Objekt der Basisklasse verhalten.
*Ziel:*
Sicherstellen, dass der Code mit Unterklassen genauso funktioniert wie mit der Basisklasse.
_Beispiel:_ Eine `Pinguin`-Klasse, die von einer `Vogel`-Klasse erbt, sollte keine `fly()`-Methode haben.

*Interface Segregation Principle (ISP):*
Clients sollten nicht dazu gezwungen werden, von Interfaces abzuhängen, die sie nicht verwenden. Statt grosse,
umfassende Interfaces zu erstellen, sollten diese in kleinere, spezifischere Interfaces aufgeteilt werden.
*Ziel:*
Erhöht Flexibilität und Lesbarkeit, da jede Klasse nur die Methoden implementieren muss, die sie tatsächlich benötigt.

*Dependency Inversion Principle (DIP):*
High-Level-Module sollen nicht von Modulen niedriger Ebene abhängen. Beide sollen von Abstraktionen (Interfaces) abhängen.
*Ziel:*
Reduzierung der Kopplung zwischen Modulen und Erhöhung der Flexibilität.

_ISP und DIP treten selten alleine auf, sie sind oft Ursache oder Folge anderer Prinzipien. ISP tritt oft mit LSP auf._

=== Übersicht
#table(
  columns: (auto, 0.48fr, 1fr),
  table.header([], [Weg], [Ziel]),

  [*SRP*],
  [Trennung und Fokus der Komponenten auf jeweils eine Aufgabe.],
  [
    _Klarheit_ bezüglich Aufgabe der Komponente\
    _Lokalisierbarkeit_ eines Fehlers
  ],

  [*OCP*],
  [Kernlogik kapseln und Erweiterungen durch Schnittstellen ermöglichen.],
  [
    _Stabilität:_ keine Änderung bestehender Logik
    _Erweiterbarkeit_ durch passende neue Komponenten
  ],

  [*LSP*],
  [Erwartungen an Schnittstellen vollständig erfüllen.],
  [
    _Austauschbarkeit_ der Implementationen\
    _Robustheit:_ keine unerwarteten Ereignisse
  ],

  [*ISP*],
  [Schnittstellen auf den minimalen Verwendungszweck reduzieren.],
  [
    _Spezifität_ für die verwendete Komponente\
    _Wiederverwendbarkeit_ der kleinen Schnittstelle
  ],

  [*DIP*],
  [Feste Kopplung vermeiden.],
  [
    _Unabhängigkeit:_ Abhängigkeiten austauschbar,
    _Testbarkeit:_ Abhängigkeiten durch "Testdummies" ersetzbar
  ],
)

= Design Patterns
Design Patterns sind Beschreibungen _erfolgreicher Strukturen_ von Software für _bestimmte Problemstellungen_.
Sie adressieren _wiederkehrende Probleme_ und beschreiben _generische Lösungen_, die funktionieren.
Design Patterns bieten eine gemeinsame Sprache für Experten, um diese Aspekte zu benennen.

== Architectural Patterns
Architekturmuster sind _wiederverwendbare_ Lösungen für _häufige Probleme_ der Softwarearchitektur. Sie behandeln
verschiedene Themen der Softwaretechnik, wie zum Beispiel die Leistungsgrenze von Computerhardware, hohe Verfügbarkeit
und die Minimierung von Geschäftsrisiken. Oft bauen Architekturpattern auf einer _Kombination aus mehreren Design
Patterns_ auf.

== GoF Design Patterns
_Gang of Four (GoF):_ Buch über Design Patterns von 1994 von Erich Gamma, Richard Helm, Ralph Johnson und John
Vlissides.\
*Creational Patterns (blau):* Patterns für die _Erstellung von Objekten_, welche die Wiederverwendbarkeit des Codes
verbessern.\
*Structural Patterns (orange):* Patterns, um Objekte in grösseren Strukturen _flexibel und effizient anzuordnen_.\
*Behavioral Patterns (grün):* Patterns für Algorithmen und Zuteilung der _Zuständigkeiten zwischen Objekten_. Sie sind
_Micro Frameworks_ und damit Grundlage für Frameworks.

// Create a new grid for a GoF design pattern
#let pattern(
  content,
  image,
) = {
  set text(size: 8pt)
  grid(
    columns: (1.5fr, 1fr),
    gutter: 5%,
    content, image,
  )
}

#pattern(
  [
    ==== Factory Method (nicht verwenden)
    _Absicht:_ Definiert eine Erzeugungs-Interface, aber Unterklassen entscheiden, welche konkrete Klasse instanziiert wird.
    _Problem:_ `new()` koppelt Code hart an konkrete Klassen.\
    _Lösung:_ Objekterzeugung in eine Factory Method auslagern.
    _Motivation:_ Flexible Instanziierung #hinweis[(z. B. anhand Laufzeitdaten)].
  ],
  image("img/gof_factorymethod.png"),
)

#pattern(
  [
    ==== Abstract Factory
    _Absicht:_ Erzeugt passende Objektfamilien ohne konkrete Klassen.
    _Problem:_ Konkrete Klassen binden den Code; Kombinationen werden inkonsistent.
    _Lösung:_ Abstract Factory + pro Familie eine Concrete Factory.
    _Motivation:_ Produktfamilien per Factory-Austausch wechseln.

  ],
  image("img/gof_abstractfactory.png"),
)

#pattern(
  [
    ==== Builder
    _Absicht:_ Baut Objekte schrittweise; Builder-Funktionen erzeugen Varianten.
    _Problem:_ Viele Optionen führen zu fetten Konstruktoren oder zu vielen Subklassen.
    _Lösung:_ Bauprozess in Builder mit klaren Schritten auslagern.
    _Motivation:_ Praktisch fürs Bootstrapping eines DI-Containers.
  ],
  image("img/gof_builder.png"),
)

#pattern(
  [
    ==== Prototype
    _Absicht:_ Kopiert Objekte ohne Abhängigkeit vom konkreten Typ.
    _Problem:_ Neuerstellung ist teuer oder konkrete Klassen sollen nicht genannt werden.
    _Lösung:_ `clone()`-Methode bereitstellen.
    _Motivation:_ Ähnliche Objekte klonen und anpassen statt neu bauen. Meist durch Programmiersprache
    schon nativ implementiert.
  ],
  image("img/gof_prototype.png"),
)

#pattern(
  [
    ==== Singleton (nicht verwenden)
    _Absicht:_ Genau eine Instanz + globaler Zugriff.
    _Problem:_ Mehrere Instanzen machen Shared-Resources unübersichtlich.
    _Lösung:_ Konstruktor privat, `getInstance()` liefert immer dieselbe Instanz.
    _Motivation:_ Zentraler, kontrollierter Zugriff; aber schlecht testbar wegen globalem Zustand,
    deshalb besser via DI.
  ],
  image("img/gof_singleton.png", width: 55%),
)

#pattern(
  [
    ==== Adapter
    _Absicht:_ Macht inkompatible Schnittstellen kompatibel.
    _Problem:_ Bestehende Klasse passt nicht zur erwarteten API.
    _Lösung:_ Adapter kapselt das Objekt und übersetzt Aufrufe.\
    _Motivation:_ Interface-Anpassung & Entkopplung von Frameworkcode.
  ],
  image("img/gof_adapter.png"),
)

#pattern(
  [
    ==== Proxy <proxy>
    _Absicht:_ Stellvertreter kontrolliert Zugriff und ergänzt Logik.
    _Problem:_ Objekt ist teuer/langsam oder Zugriff muss geregelt werden.\
    _Lösung:_ Proxy mit gleicher Schnittstelle #hinweis[(z.B. Lazy Loading, Cache, Checks)] delegiert ans echte Objekt.\
    _Motivation:_ z.B. für Benachrichtigungen.
  ],
  image("img/gof_proxy.png"),
)

#pattern(
  [
    ==== Decorator
    _Absicht:_ Fügt einem Objekt zusätzliches Verhalten hinzu, ohne die Klasse zu ändern.\
    _Problem:_ Funktion soll erweitert werden, ohne die Klasse zu ändern.
    _Lösung:_ Anlegen eines Decorator um ein Objekt um Aufrufe weiterzuleiten und zu ergänzen.
    _Motivation:_ Anordnung von UI Elementen.
  ],
  image("img/gof_decorator.png"),
)

#pattern(
  [
    ==== Facade
    _Absicht:_ Vereinfacht den Zugriff auf ein komplexes Subsystem.
    _Problem:_ Client kennt zu viele Details/Abhängigkeiten, wird unübersichtlich, stark gekoppelt.
    _Lösung:_ Facade kapselt Komplexität und bietet nur nötige Methoden.
    _Motivation:_ Unterstützt ISP durch klare, schlanke Schnittstellen.
  ],
  image("img/gof_facade.png"),
)

#pattern(
  [
    ==== Bridge
    _Absicht:_ Trennt verwandte Klassen voneinander, können unabhängig entwickelt werden.\
    _Problem:_ Viele Variantendimensionen führen zu Klassenexplosion.
    _Lösung:_ Abstraktion hält Implementor-Interface und delegiert.\
    _Motivation:_ Abstraktion/Implementierung erweitern ohne gegenseitige Änderungen.
  ],
  image("img/gof_bridge.png"),
)

#pattern(
  [
    ==== Composite <composite>
    _Absicht:_ Baut Objektbäume und behandelt Gruppen wie Einzelobjekte.
    _Problem:_ Client muss ständig zwischen Element #hinweis[(Leaf Nodes)] und Gruppe #hinweis[(non-Leaf Nodes)]
    unterscheiden, wird komplex.
    _Lösung:_ Gemeinsames Component-Interface: `Leaf` und `Composite` implementieren es,
    Composite verwaltet Kinder und delegiert.
    _Motivation:_ Anordnung von UI Elementen.
  ],
  image("img/gof_composite.png"),
)

#pattern(
  [
    ==== Observer
    _Absicht:_ Benachrichtigt mehrere Abonnenten bei Änderungen.
    _Problem:_ Polling oder starke Kopplung der Abhängigen.
    _Lösung:_ Observer registrieren und bei Änderungen automatisch informieren #hinweis[(1:n Beziehung)].
    _Motivation:_ Zentrale Verteilung; neue Beobachter ohne Logikänderung.
    #hinweis[(Subject: Sich ändernde Quelle, Observer: der Zuhörer)]
  ],
  image("img/gof_observer.png"),
)

#pattern(
  [
    ==== Mediator <mediator>
    _Absicht:_ Reduziert direkte, chaotische Abhängigkeiten durch Kommunikation über einen Vermittler.
    _Problem:_ Viele Direktverbindungen führen zu Spaghetti-Kopplung, schwer wartbar.
    _Lösung:_ Kommunikation über Mediator bündeln statt direkt #hinweis[(m:1:n Beziehung)].
    _Motivation:_ Messaging-/Benachrichtigungsmechanismen.
  ],
  image("img/gof_mediator.png"),
)

#pattern(
  [
    ==== State <state>
    _Absicht:_ Verhalten wechselt je nach internem Zustand.
    _Problem:_ Viele Zustände führen zu langen `if/else`-Ketten im Objekt.
    _Lösung:_ Zustände werden als eigene State-Klassen modelliert.
    _Motivation:_ Zustandslogik wird getrennt. So können Zustände ergänzt werden, ohne die
    bestehenden Bedingungen aufzublähen.
  ],
  image("img/gof_state.png"),
)

#pattern(
  [
    ==== Memento
    _Absicht:_ Ein Objektzustand wird gespeichert und wiederhergestellt, ohne Implementierungsdetails offenzulegen.
    _Problem:_ Undo/Restore sollte möglich sein, ohne die Kapselung zu verletzen.
    _Lösung:_ Ein Memento #hinweis[(Snapshot)] hält den Zustand, ein Caretaker #hinweis[(History)] verwaltet die Mementos.
    _Motivation:_ Rücksprünge werden ermöglicht, während interne Details verborgen bleiben.
  ],
  image("img/gof_memento.png"),
)

#pattern(
  [
    ==== Strategy
    _Absicht:_ Kapselt austauschbare Algorithmen.
    _Problem:_ Algorithmus-Varianten führen zu verzweigtem Code und starker Koppelung.\
    _Lösung:_ Jede Variante als eigene Strategy, zur Laufzeit wählen.
    _Motivation:_ Für Kapselung und Austauschbarkeit von Logik.
  ],
  image("img/gof_strategy.png"),
)

#pattern(
  [
    ==== Command
    _Absicht:_ Eine Anfrage wird als eigenständiges Objekt mit allen nötigen Infos verpackt.\
    _Problem:_ Aktionen sollen später, in einer Queue oder mit Undo ausführbar sein.\
    _Lösung:_ Ein Command kapselt Aktionen und wird vom Aufrufer entkoppelt.
    _Motivation:_ Für Kapselung und Austauschbarkeit von Logik.
  ],
  image("img/gof_command.png"),
)

#pattern(
  [
    ==== Chain of Responsibility
    _Absicht:_ Anfragen werden durch eine Kette von Handlern weitergereicht, bis einer sie verarbeitet.
    _Problem:_ Ein fester Empfänger erzeugt starre Logik und Sonderfälle.
    _Lösung:_ Jeder Handler entscheidet, ob er die Anfrage bearbeitet oder weiterleitet.
    _Motivation:_ Für Middleware
  ],
  image("img/gof_chain_of_responsibility.png"),
)

#pattern(
  [
    ==== Iterator
    _Absicht:_ Durchläuft eine Sammlung ohne interne Details offenzulegen.
    _Problem:_ Traversierung hängt stark von der konkreten Datenstruktur ab.
    _Lösung:_ Ein Iterator-Interface kapselt das Durchlaufen.
    _Motivation:_ Einheitliche Traversierung verschiedener Collections, Implementierungsdetails bleiben verborgen
    #hinweis[(Wie in C++)].
  ],
  image("img/gof_iterator.png"),
)


= Frameworks
Ein Framework nimmt dem Applikationsentwickler _Standardaufgaben_ ab #hinweis[(Instanziierung, Auswahl der Komponenten,
  Request Handling, Event Handling, ...)]. Es ist ein _Gerüst_ für den Applikationscode und funktioniert nach dem
_Hollywood Prinzip/Inversion of Control_. Es baut auf _Structural Design Patterns_ und/oder _Meta Programmierung_
#hinweis[(z.B Reflection, Code Generation, Interpreter)] auf.\
Ein Framework bietet Strukturierung durch _Modularität_, _Kapselung_, _Layering_ und _Abstraktionen_. Es bietet dafür
_Control Flow_, _Hooks_ und _Extension Points_.

*Gefahren von Frameworks:*
Starke Kopplung durch eigene Subklassen von Framework-Klassen, _Schulungsaufwand_, _Verminderte Testbarkeit_
#hinweis[(Adapter verwenden, DI und Integration Tests nutzen)], _Angst vor Updates_, _Vendor Lock-In / Abhängigkeit_
#hinweis[(offene Standards nutzen, restriktive Vertragsklauseln meiden, eigene Interfaces nutzen, Exit-Plan dokumentieren)],
schwierige Migration einzelner Komponenten.\
*Ein Framework ist gut, wenn:*
Der eigene Code möglichst _wenig Abhängigkeiten_ zum Framework hat, das Framework so viel _Standardaufgaben_ wie möglich
_übernimmt_, ohne dass die Konfiguration zu _aufwändig_ wird.\
*Framework-Entwicklungs-Schwierigkeiten:*
Verbesserungen müssen vorgenommen werden, _ohne_ dass sich die _bestehende API ändert_. Es sollte keine _Breaking Changes_
geben. _Web Standards_ können ein Segen oder eine Bremse für Frameworks sein: Passe ich mich an oder mache ich etwas eigenes?
Wann zu einem neuen Standard wechseln? Frameworks haben oft viele _Abhängigkeiten_, was alles komplizierter macht.
_Dilemma:_ Flexibilität vs. Einfachheit, Innovation vs. Stabilität, Anpassbarkeit vs. Meinungsvorgaben,
Rückwärtskompabilität vs. Modernisierung, Funktionsumfang vs. Leistung.\
*Inversion of Control (Hollywood Prinzip):*
Anfragen können durch das Framework bearbeitet und an den richtigen Applikationscode weitergeleitet werden.
Das Framework ruft also Applikationscode auf. Dies nennt man "Inversion of Control".
_Hollywood Prinzip:_ Don't Call Us - We will call you! Hollywood ruft dich an, um dich zu engagieren, nicht umgekehrt.\

== Unterschied Framework zu Library & Runtime
*Library:*
Die Funktionalität der Bibliothek wird aus dem Applikationscode aufgerufen #hinweis[(Kein Hollywood Prinzip)].
Beim Verwenden einer Library wird der Applikationscode _abhängig_ von der Library.
Businessrelevante Libraries sollten wie _Infrastruktur-Code_ behandelt werden und in eine Komponente ausserhalb
der Business Layer _abgekoppelt_ werden. Dies gelingt mit _Interfaces_, welche die Library kapseln.\
*Runtime:*
_Abstraktionslayer_ über das darunter liegende Betriebssystem. Kümmert sich um _Interpretation_ des Codes,
_Speicherverwaltung_ und _OS-Schnittstellen_. Oft liefert eine Runtime gleich auch ein Framework mit, welches die API der
Runtime nutzt und ein Gerüst für den Applikationscode bietet. Frameworks können Inversion of Control und Dependency
Injection für bessere Separation of Concerns und Testing nutzen.

== Instanziierung von Objekten
Objekte sollten nur erzeugt werden, wenn sie auch gebraucht werden. Die gleichen Instanzen müssen an verschiedenen Orten
verwendet werden können. Hier sind _Dependency Inversion Principle_ und _Interface Segregation_ zu beachten.
*Aufteilung nach Dependency Inversion Principle:*
_Geschäftslogik_ sollte so weit wie möglich von _Technologie_ getrennt sein. Es werden also _Abstraktionen / Interfaces_
eingeführt, welche von den Komponenten abhängen.

#grid(
  columns: (1.2fr, 1fr),
  align: horizon,
  [
    *Layer Architektur:*
    Im einfachsten Fall entsteht durch die Separation eine Layer-Architektur. Die obere Schicht kommuniziert nur über
    Interfaces mit der unteren.
    *Crosscutting Concerns:*
    In einer Layer-Architektur kommt es oft zu Crosscutting Concerns #hinweis[(Security Context, Konfiguration)],
    die in mehreren Layern gebraucht werden.
  ],
  image("img/crosscutting.png"),
)

Wie können diese Objekte in einer _ganzen Applikation verfügbar_ gemacht werden, _ohne_ die Implementation _global_
zugänglich zu machen? Diese _Vertical Layer_ werden beim _Bootstrapping_ in den _Application Context_ enkapsuliert,
welcher den einzelnen Layern übergeben wird.\
*Bootstrapping:* Der Prozess, in welchem während des Systemstarts alle nötigen Komponenten und Abhängigkeiten geladen
werden. Einstiegspunkt zwischen Framework und Applikationscode. Stellt Service-Builder und -Provider bereit.

=== Service Provider
Das Framework definiert applikationsweite _Handler_ #hinweis[(z.B. Router, Navigator, ein Command oder Strategy
  Pattern)]. Dieser Handler kann _Anfragen_ entgegennehmen oder auf _Zustandsänderungen_ reagieren. Über eine
_Konfiguration_ wird definiert, bei welcher Anfrage welches Applikationsobjekt für die Bearbeitung des Befehls zuständig
sein soll. Diese Anfrage wird durch den Handler an einen _Service Provider_ oder einen _Dependency Injection Container_
#hinweis[(siehe Kapitel @dic)] weitergeleitet. Der _Service Provider_ ist eine konfigurierbare _Factory_, die
Applikationsobjekte und Abhängigkeiten dynamisch auflöst. Er ist eine _zentrale Komponente_ in einem Framework und
für die Verwaltung und Bereitstellung von Diensten zuständig. Wird im Bootstrapper _separiert_ vom restlichen
Applikationscode konfiguriert und ist dem Applikationscode möglichst _unbekannt_.

=== Service Builder
Ein Service Builder ist ein _dynamischer Builder_ #hinweis[(GOF Pattern)] für einen Service Provider oder DI-Container.
Er arbeitet eng mit dem Service Provider zusammen, um die benötigten Dienste zu konfigurieren.
Er ist für das _Bootstrapping_ des Service Providers zuständig.
*Service-Arten:*
- _Transient:_ Returnt jedes Mal neue Instanz des Service
- _Singleton:_ Returnt dieselbe Instanz beim Aufruf

== Middleware
Middleware ist eine _konfigurierbare_ Komponente in einer Pipeline. Sie kann _Anfragen_ und Antworten _verändern_,
_erweitern_ oder _blockieren_, bevor sie an die nächste Komponente weitergereicht werden. Häufig in Webservern.
- _Anfragebearbeitung_ #hinweis[(Authentifizierung, Autorisierung, Validierung, Fehlerbehandlung)]
- _Protokollierung, Monitoring_ #hinweis[(Erfassen von Requests/Responses, Monitoring)]
- _Datenumwandlung_ #hinweis[(Konvertierung von Formaten, (De-)serialisierung)]

Wird oft _zwischen_ Handler des Frameworks und Applikationscode eingeschleust #hinweis[(Data Modification)] oder um
einen Aufruf _herum gestülpt_ #hinweis[(Error Handling)]. Damit wird das _Framework_ und nicht unser Code _erweitert_.
Somit fungiert es als _Extension Point_ eines Frameworks #hinweis[(Abwandlung von Chain of Responsibility Pattern)].
Es können darin _Decorators_ und _Proxies_ aneinandergekettet werden, um Anfragen und Antworten zu modifizieren.

=== Middleware-Pipeline
*Pipeline-Struktur:* Jede Middleware kann _vor_ und _nach_ dem nächsten Schritt eingreifen. Durch _`next()`_ wird
entschieden, ob der Request _weitergeleitet_ wird. Die _Reihenfolge_ in der Pipeline beeinflusst die _Verarbeitung_.
Durch die _Kettenreihenfolge_ wird hinzufügen, entfernen und umordnen sehr _flexibel_. Jede _Middleware_ übernimmt _eine
spezifische Aufgabe_, z.B.:\
`Logging -> Auth. -> Autorisierung -> Fehlerbehandlung -> Endpunkt`

```ts
export const logMiddleware = <TServices>(s: IServiceProvider<TServices>) =>
  async (input: RenderResult, next: (result: RenderResult) =>
  Promise<RenderResult> ) => {
    console.log(`logging middleware received`, input);
    return await next(input); };
```
== Meta Programming & Reflection
*Introspection:* Fähigkeit eines Programms, seinen _eigenen Zustand_ zu _beobachten_ und _analysieren_
#hinweis[(Abfragen von Objekteigenschaften oder -methoden)].\
*Intercession:* Fähigkeit eines Programms, seinen eigenen _Ausführungszustand_ zu _verändern_ oder seine _Interpretation
anzupassen_ #hinweis[(Attribut hinzufügen)].\
*Type Reflection:* Fähigkeit, _zur Laufzeit_ Informationen über die _Typen_ von Variablen, Objekten etc. zu erhalten
#hinweis[(`typeof, instanceof, constructor`)].\
*Structural Reflection:* Fähigkeit, _zur Laufzeit_ Informationen über die _Struktur_ von Objekten und Funktionen zur
erhalten und möglicherweise zu verändern #hinweis[(`Object.keys(), Object.getOwnPropertyNames()`)].

*Annotation / Attributierung:* Code wird _zur Kompilierzeit_ mit Metadaten angereichert, welche zur Laufzeit über
_Reflections_ ausgelesen werden können.

#grid(
  [
    ```ts
    class MyClass {
      @Log // <- Annotation
      logMe(a1: string, a2: number) {
        console.log("Running..."); }}
    ```
  ],
  [
    ```ts
    new MyClass().logMe("test", 42);
    // Output:
    // logme Args: ["test",42]
    // Running...
    ```
  ],
)

```ts
function Log(target: any, key: string, descr: PropertyDescriptor) {
  const originalFunction = descr.value;
  descr.value = function (...args: any[]) {
    console.log(`${key} Args: ${JSON.stringify(args)}`);
    return originalFunction.apply(this, args); }; }
```

*Nachteile Annotation:*
Müssen _direkt auf Anwendungscode_ platziert werden $->$ _statische Abhängigkeit zum Framework_.
Die _Nachvollziehbarkeit_ leidet, weil "Magie"/"Framework-Fuckery" passiert.

*Type Reflection in C\#:*
_Abfragen von Informationen _zu einer Klasse, _ohne_ eine _Instanz_ zu erzeugen. _Dynamisches Nachladen_ von Assemblies,
_Suche_ nach Typen, Interfaces usw., _Erzeugen von generischen_ Typen.\
*Code Reflection in C\#:*
_LINQ_ Expressions, _dynamische_ Kompilierung, _dynamische_ Erstellung von Lambda-Ausdrücken.

== Dependency Injection Container <dic>
Ist ein _Service Provider_ mit einem "intelligenten" _Service Builder_, der Abhängigkeiten selbst auflöst. Dies wird
meist mit _Reflection_ gelöst. Die _manuelle Konfiguration_ mit dem Service Builder wird dadurch _minimiert_.\
*Weitere Fähigkeiten:*
_Ressourcenverwaltung_ #hinweis[(Post-Construct, Pre-Destroy)], _Fehlerbehandlung_, Behandlung _zirkulärer_ Referenzen,
komplexe Scopes, Container Hierarchien, Configuration-/Parameterinjection, Lazy Injection,
Interception/Middleware, Multiinjection #hinweis[(Collections von Objekten als Konstruktionsparameter)].

In _C\# oder Java_ sind Type Reflections mächtiger als in TypeScript. Das erlaubt dem DI-Container, _Typen ohne Attribute zu
registrieren_. C\# kann Typen nach bestimmten Kriterien _suchen_ und Objekte alleine anhand der Typeninformationen
instanziieren #hinweis[(Constructor enthält Interfaces als Parameter, welche .NET automatisch ergänzt)].
Der Anwendungscode ist somit _nicht vom Framework abhängig_.


= Separated Presentation
Code, der die Darstellung manipuliert, sollte _nur_ das tun. Oft wird ein UI weiter unterteilt in
_Präsentation_ #hinweis[(Inhalt, verschiedene Ausgabegeräte, Medien, Layouts, Animationen)],
_Applikationslogik_ #hinweis[(Applikations-Zustand, Prozesse, die durch das UI ausgelöst werden. Sollte nichts über das UI wissen.)]
und _Interaktionslogik_ #hinweis[(verschiedene Eingabegeräte, Eventhandling, Navigation)].
_Diese Abtrennung ist die Grundlage aller UI-Architekturpatterns_.

*Vorteile:* _Nachvollziehbarkeit_ und Testbarkeit, _Wiederverwendbarkeit_, _Migrationsfähigkeit_ & _Austauschbarkeit_
der Präsentation, alternative Eingabe wird erleichtert, Fokus der Entwickler im Team.

Für UI-Updates wird oft das _Observer Pattern_ angewandt. *Vorteil:* Stellt View & Model-Synchronisation sicher, keine
statische Abhängigkeit von Model & View. *Nachteil:* Kontrollfluss wird verborgen.

== Begriffe der UI-Programmierung
*Imperative Programmierung:*
Beschreibt die _Umsetzungsschritte_, ist in Business-Logik und komplexen Prozessen verbreitet
#hinweis[(Bspw. Template Engines und Frameworks)]. Für UIs wenig geeignet, da viel Code geschrieben werden muss. \
*Deklarative Programmierung:*
Beschreibt das gewünschte _Resultat_, ermöglicht intuitivere UI-Definitionen. HTML & CSS sind deklarativ.
_Trennung_ von _Präsentations- und Geschäftslogik_ wird einfacher.\
*Markup Sprache:*
Daten werden mit _Semantik_ angereichert, damit _Interpreter_ Inhalt auf seine Art anzeigen kann
#hinweis[(Bspw. HTML, XML, Markdown)]. _Content vs. Semantik:_ HTML: `<h1>` gibt nur an, dass Inhalt als Titel
präsentiert werden soll, aber nicht, wie er dargestellt wird.\
*Template Engine:*
Erlaubt in Kombination mit Markup _dynamische Daten zu rendern_ #hinweis[(durch Conditional Rendering, Loops, Placeholders)].\
*Template Extensions:*
Erweiterung für deklarative UI Programmierung, z.T. direkt von Laufzeitumgebung angeboten #hinweis[(z.B. Razor, ASP, PHP)].
Der Programmcode im Template wird in der nativen Sprache geschrieben. \
*Deklarative View Engine:*
Teile eines UI Frameworks, ermöglichen _viel mehr_ als traditionelle Server-side Template Engines. Mehrfaches Rendering,
Events, Dateninitialisierung, Data-Binding, Komponenten, Komposition. Praktisch alle _modernen JS UI Frameworks_
verwenden solche Konzepte. Im Hintergrund oft Abwandlung von _Observer Pattern_ mit _Data-Binding_.\
*Vorteile Deklaratives UI:*
_Klarheit & Lesbarkeit_, Design-Tools für _visuelle Bearbeitung_, _Wiederverwendbarkeit_ trotz unterschiedlichem Styling,
Beschränkung der Möglichkeiten #hinweis[(weniger in Versuchung Logik im UI zu implementieren)].

== MVC (Model-View-Controller)
*View #hinweis[(Observer)]:* Rendert die _UI-Elemente_, _reagiert_ auf _Änderungen_ des Models.\
*Controller:* Reagiert auf _Benutzereingaben_, _empfängt_ und _validiert_ Eingabe, leitet Manipulation des Models ein.\
*Model #hinweis[(Subject)]:* Verwaltet _Daten_ und _Zustand_ der Anwendung.

#align(center)[
  #chronos.diagram({
    import chronos: *
    _par(
      "View",
      color: rgb("#fff"),
      display-name: align(center)[*View*\ #hinweis[Screen Representation]],
      show-bottom: false,
    )
    _par(
      "Controller",
      color: rgb("#fff"),
      display-name: align(center)[*Controller*\ #hinweis[User Interaction]],
      show-bottom: false,
    )
    _par(
      "Model",
      color: rgb("#fff"),
      display-name: align(center)[*Model* \ #hinweis[Application Object]],
      show-bottom: false,
    )

    _seq("View", "Controller", comment: [Input / Events\ weiterleiten \ #hinweis[(Delegation)]])
    _seq("Controller", "Model", comment: [Modell aktualisieren \ #hinweis[(Input validieren und weiterleiten)]])
    _seq("Model", "View", comment: [Änderung melden #hinweis[(`notifyObservers()`)]], dashed: true)
  })
]

In MVC ist nur die _logische Zuordnung_ zu _Interaktion_ #hinweis[(Controller)], _Präsentation_ #hinweis[(View)] und
_Applikationslogik_ #hinweis[(Model)] klar definiert.\
*Schwächen von MVC:*
Ermöglicht es nur schwer, Controls in Applikationen mit einem _anderen Datenmodel_ wieder zu verwenden.
Es ist schwierig, _visuelle UI Editoren_ für MVC Architektur zu bauen.

=== Forms and Controls
In den 90ern beliebt. _Sammlungen von wiederverwendbaren UI Elementen_ mit definierten Interfaces.
Entwicklung per _WYSIWYG_: Controls wurden per _Drag and Drop_ eingefügt, danach _EventHandler_ für die Controls schreiben.
Zusammen gab das ein _Formular_, welches _Applikations-Logik_ enthielt.\
*Probleme:*
Enge Kopplung, wenig Wiederverwendbarkeit, schwer test- und wartbare Views, Vendor Lock-In, Toolabhängigkeit,
verletzte SOLID-Prinzipien. _RAD und Low-Code verursachen Forms & Controls._

== MVP Passive View (Model-View-Presenter)
*View:* Keine _statische Abhängigkeit_ oder _Observer-Kommunikation_ zum Model. _Interface_, um Austauschbarkeit zu
erhöhen. Die View _beobachtet nicht_, sie wird _aktiv vom Presenter manipuliert_.\
*Presenter #hinweis[(Observer)]:* Observer des Models. Ändert die View aktiv über ein Interface und konvertiert die Daten.\
*Model #hinweis[(Subject)]:* Verwaltet _Daten_ und _Zustand_ der Anwendung.

#align(center)[
  #chronos.diagram(
    {
      import chronos: *
      _par(
        "View",
        color: rgb("#fff"),
        display-name: align(center)[*View*\ #hinweis[Screen Representation]],
        show-bottom: false,
      )
      _par(
        "Presenter",
        color: rgb("#fff"),
        display-name: align(center)[*Presenter*\ #hinweis[User Interaction]],
        show-bottom: false,
      )
      _par(
        "Model",
        color: rgb("#fff"),
        display-name: align(center)[*Model* \ #hinweis[Application Object]],
        show-bottom: false,
      )

      _seq("View", "Presenter", comment: [Input / Events\ weiterleiten \ #hinweis[(Delegation)]])
      _seq("Presenter", "Model", comment: [Modell aktualisieren \ #hinweis[(Input validieren und weiterleiten)]])
      _seq("Model", "Presenter", comment: [Benachrichtigung \ #hinweis[(`notifyObservers()`)]], dashed: true)
      _seq("Presenter", "View", comment: [Ansicht aktualisieren\ #hinweis[(Interface)]])
    },
    width: 93%,
  )
]

In MVP ist die _Aufgabentrennung_, die _Kommunikation_ zwischen den Komponenten und die _statische Abhängigkeit_
zwischen den Komponenten klar definiert.

*Vorteile:*
Stark in _Separation of Concerns_ und in der Programmierung mit einem Domain Model. Gut in _Wiederverwendung_
von Widgets und Controls und Erstellung durch WYSIWYG-Editoren. Gute _Testbarkeit_ und _Nachvollziehbarkeit_.\
*Nachteile:*
_Komplexität_ ist stark erhöht. \
*Vergleich zu MVC:*
In MVP beobachtet der Presenter das Model. Die View beobachtet nicht, sondern wird aktiv vom Presenter manipuliert.
_Presenter_ ist eher auf _Widget-Ebene_ implementiert, verwaltet _mehrere Controls_. Die _View_ wird als eine
_Struktur von Controls_ angesehen, enthält _kein Verhalten_ bzgl. Reaktion der Control auf _Benutzereingaben_.
Änderungen am Model werden oft als Befehle in einem _Command Pattern_ implementiert. Grundlage für
_Undo/Redo Funktionen_.\
*Wann verwenden:*
Architektur soll _unabhängig_ von UI Technologie sein. Es sind mehrere _technologisch unterschiedliche UIs_ möglich.
M, V und P können auf _verschiedene Computer_ verteilt werden #hinweis[(Server-Client)]. _Thin Clients_ möglich.

=== MVP und Mediator Pattern (Mediated MVP)
Hilft, den _Presenter_ aufzuteilen, _schlanker_ und _testbarer_ zu machen. Durch Events, welche durch die Views auf dem
Mediator #hinweis[(Presenter)] aufgerufen werden, wird _Kommunikation erleichtert_ und _Abhängigkeit verringert_.
Models können Kommunikation ebenfalls über Mediator regeln und benötigen _keinen Observer_ mehr. Befehle können in Commands
gepackt werden, was Funktionen wie _Undo/Redo_ einfach implementierbar macht. #hinweis[(Siehe @mediator)].

*Vorteile:*
_Reduzierte Komplexität_ durch zentrale Steuerung, verbesserte _Wartbarkeit_, erleichterte _Erweiterbarkeit_.\
*Nachteile:*
_Single Point of Failure_, potentielle _Performance-Einbussen_, erhöhte _Abhängigkeit_ vom Mediator.

==== MVP mit Commands/Selections/Interactions
Events können durch Mediated MVP in Gruppen unterteilt werden:
- _Commands:_ Kapseln Aktionen, die auf dem Model ausgeführt werden
- _Selections:_ Bestimmen, welche Teile des Models von Aktionen betroffen sind. Views können so gezielt aktualisiert
  werden.
- _Interactors_ entscheiden und koordinieren #hinweis[(Passender Command wählen, Parameter von Selections ableiten, über
    Presenter anstossen)].

Diese Aufteilung ist ein _Grundbaustein moderner Architekturen_ #hinweis[(Flux/Redux, Signals, State Machines)].
Damit und mit einem Pub/Sub Pattern können auch verteilte MVPs umgesetzt werden.

== MVP Supervising Controller
*Supervising Controller #hinweis[(MVP + Data Binding)]:*
Der Presenter verarbeitet User Input und enthält UI Logik #hinweis[(Button-Press, Navigation)].
Die View bindet sich durch Data Binding an das Model. Damit entfällt viel Boilerplate im Vergleich zu Passive View,
allerdings wird man dafür von der Data-Binding-Technologie abhängig, was die Austauschbarkeit der View verringert.
Besser Variante unten verwenden!

/*
MVP mit _UI State_, _Deklarativem UI_ und _Data Binding_. Ist eine Mischung aus _MVC_, _MVP Passive View_ und
_Forms & Controls_ mit klaren Regeln und ohne deren Nachteile. UI Zustand ist nicht mehr im Model angesiedelt,
sondern fungiert als State zwischen Presenter und View.
*/

*Supervising Controller mit Presentation Model:*
Presenter formt das Domain-Model in eine _View-nahe Struktur_ #hinweis[(Presentation Model)] um. Die View reagiert mit
_Observer Pattern_ auf Änderungen im _Presentation Model_ #hinweis[(Durch Data Binding an State gebunden)].
Der Presenter betrachtet das _Presentation Model_ als Interface für die View und _manipuliert View nicht direkt_
#hinweis[(verarbeitet Input & aktualisiert State)].

*Vorteile:*
Presenter wird _noch weniger Abhängig_ von Controls oder Widgets und State-Manipulation kann direkt mit dem Presenter
getestet werden. Komposition wird _einfacher_ und kann rein _deklarativ_ erfolgen.\
*Nachteil:*
_Abhängigkeit_ des State von der Data Binding Technologie.

=== State
Umfasst alle _Zustandsinformationen_ des UI #hinweis[(Sichtbarkeit, Aktivierung, Auswahl, Fokus, Formularwerte und
  temporäre Zustände)]. State ist _flüchtig_, nicht permanent abgespeichert. Der State kann mit Übergängen über
_Zustandsautomaten_ modelliert werden und _beeinflusst die Presentation_.

_MVP beinhaltet zwingend Separation of Concerns, Wiederverwendbarkeit & Austauschbarkeit der View, Separates Testen
von View, Presenter und Model._


= Data Binding
_Data Binding_ stellt sicher, dass jede _Änderung in einem UI-Element_ automatisch auf die zugrunde liegende Abstraktion
_übertragen_ wird, und umgekehrt. Data Binding ist ein _automatisiertes Observer Pattern_ mit Fokus auf _Synchronisation_
zwischen _State_ und _View_.

*Benachrichtigungsmechanismus:*
Das beobachtbare Objekt löst bei einer Änderung einen _Event_ mit dem Namen des geänderten Properties aus.
Die View-Engine muss nur diesen `PropertyChanged`-Event _abonnieren_, um über Änderungen informiert zu werden.
Änderungen an _Collections_ sind komplexer und müssen gezielt erkannt #hinweis[(`add`, `remove`,  `clear`)]
und behandelt werden.

*One-Way Binding:*
Erlaubt die Darstellung von Daten in der View _ohne Rückfluss_ zum _Model_, das Model ist also read-only.\
*Two-Way Binding:*
Synchronisiert Änderungen durch _deklarative Anweisungen_ zwischen View und Model in _beide Richtungen_.
Damit kann das Model auch verändert werden. Ist eine _zentrale Komponente_ in modernen UI-Frameworks.\
*View Engine:*
Framework, welches _Standardaufgaben_ der Programmierung von _Präsentation_ und _Benutzerinteraktion_ abnimmt.
Oft erweiterte deklarative _Template Engines_, welche die Views automatisch und dynamisch an Änderungen des
State anpassen. Diese automatische Synchronisation zwischen View und State nennt man _Data Binding_.\
*Deklarative Anweisungen:*
Werden von der View Engine als _Informationen für Automatisierung_ der "Abonnierung" #hinweis[(Observer Pattern)]
von Datenänderungen verwendet. Findet durch Kompilierung, Reflection oder Zugriff über Propertynamen statt
#hinweis[(`obj[propName]`)].\
*Data Binding Hooks:*
Bei einer Datenänderung #hinweis[(`before`, `onChange`, `afterChange`, `onError`)] kann z.B. ein _Validator_
zum Zug kommen, eine _Datenkonvertierung_ stattfinden oder ein _visueller Effekt_ ausgelöst werden.\
*Vergessene Updates beim Data Binding:*
Es können trotzdem Updates im Model/UI verloren gehen: Dev vergisst, `PropertyChanged`-Event bei Änderungen
einzurichten, Änderungen ausserhalb der getrackten Wege, Race Conditions.


= MVVM (Model-View-ViewModel) <mvvm>
Basiert auf MVP Supervising Controller, aber einfacherer _Kontrollfluss_ #hinweis[(bei MVP entweder über Presenter oder
  Data Binding -- wo soll eingegriffen werden?)]. State der View und des Presenters verschmelzen zum View Model.
Synchronisation zur View über _Data Binding mittels UI-Framework_.

#align(center)[
  #chronos.diagram(
    {
      import chronos: *
      _par(
        "View",
        color: rgb("#fff"),
        display-name: align(center)[*View*\ #hinweis[Screen repr.]],
        show-bottom: false,
      )
      _par(
        "UI",
        color: rgb("#fff"),
        display-name: align(center)[*UI-Framework*\ #hinweis[Two-Way-Binding]],
        show-bottom: false,
        shape: "queue",
      )
      _par(
        "View-Model",
        color: rgb("#fff"),
        display-name: align(center)[*View-Model*\ #hinweis[User Interaction]],
        show-bottom: false,
      )
      _par(
        "Model",
        color: rgb("#fff"),
        display-name: align(center)[*Model* \ #hinweis[Application Object]],
        show-bottom: false,
      )

      _seq("View", "View-Model", comment: [Event / Command Binding], dashed: true)
      _seq("View-Model", "Model", comment: [Modell\ aktualisieren \ #hinweis[(Input validieren\ und weiterleiten)]])
      _seq("Model", "View-Model", comment: [Notification \ #hinweis[(Observer Pattern)]], dashed: true)
      _seq("View-Model", "View", comment: [Data Binding], dashed: true)
    },
    width: 90%,
  )
]

*Vorteile:*
Weniger _Boilerplate-Code_ als MVP, Automatische _Synchronisierung_ der View über _Data Binding_, klare
_Trennung der Verantwortlichkeiten_ durch Commands und Data Binding, _Testbarkeit_ des ViewModels ohne die View,
_Wartbarkeit_ durch Kapselung.\
*Nachteile:*
Starke _Abhängigkeit_ von der View Engine. ViewModel muss sich an _Konventionen_ des Frameworks halten. Data Binding
erschwert _Debugging_. Two Way Binding kann _Performance_ negativ beeinflussen.\
MVVM implementiert meist _Data Binding ohne automatische Auslösung_ von `PropertyChanged`. Macht es einfacher,
_Zyklische Updates zu erkennen_ und bei explizit ausgelösten Benachrichtungungen die _Performance zu optimieren_.
Aber es können _Updates vergessen_ werden.

== Interaktionslogik
*Commands:*
Abstraktion der Benutzerinteraktion. _Enkoppelt_ UI von der Interaktionslogik. Prüft `CanExecute()` und
delegiert Workload weiter an ViewModel, welches wiederum das Model aufruft, welches die Modifikation der Daten
durchführt. Können _mehrere_ VMs manipulieren.\
_`CanExecute()`:_ Kondition, ob Befehl ausgeführt werden kann #hinweis[(z.B. `!= null`)]\
*Vorteile von Command Interfaces:*
_Konsistenz_ und _Wiederverwendbarkeit_ in der View, _leicht testbar_, da Interaktionslogik von UI entkoppelt ist.
_Klare Trennung_ von Benutzeroberfläche, Interaktionslogik und Geschäftslogik.
Möglichkeit der _Unterstützung einer Undo/Redo-Funktionalität_.

#table(
  columns: (auto, auto, auto, auto),
  table.header([], [Eigenschaft], [MVP (passiv)], [MVVM]),
  table.cell(rowspan: 3, align: horizon, rotate(-90deg, reflow: true)[*Abhängigkeit*]),
  [*View von\ Framework*],
  [keine Abhängigkeit],
  [stark an Framework gekoppelt],

  [*Presenter/VM\ $->$ View*],
  [über Interface],
  [Framework-Mechanismus],

  [*View $->$\ Presenter/VM*],
  [über Mediator Interface oder Event Binding],
  [direkte Referenzierung auf Widget Ebene],

  table.cell(rowspan: 2, align: horizon, rotate(-90deg, reflow: true)[*Informationsfluss*]),
  [*Presenter/VM\ $->$ View*],
  [Manipulation der View über Interface],
  [Data Binding],

  [*View $->$\ Presenter/VM*],
  [Events, Eventhandler oder direkter Methoden-aufruf auf Presenter],
  [Two Way Binding,\ Commands],
)

== Dynamische Proxies <dynamic-proxies>
Zur _Automatisierung des Observer Patterns_. Mit einem Proxy werden Änderungen am Zustand _abgefangen_ und _automatisch_
an alle Abonnenten #hinweis[(z.B. die View)] weitergeleitet #hinweis[(siehe @proxy)]. Die State-Logik kennt den Proxy nicht.
Proxy-basierte _Observable State Pattern_ bieten eine _flexiblere Alternative_ zu klassischem MVVM Pattern, da es den
Zustand _unabhängig_ von einem _spezifischen Framework_ hält und so die _Abhängigkeit_ des ViewModels vom Framework
_reduziert_ #hinweis[(State ist keine eigenständige Objekt-Instanz)].

== Komponenten-basierte Architektur
Architekturtyp, der auf einem _anderen Abstraktionslevel_ ist als MVC, MVP oder MVVM. Es ist eine _vertikale Trennung_:
Jede Komponente kapselt Darstellung, Logik und Daten für einen bestimmten UI-Bereich. Die einzelnen Komponenten können
_zusätzlich_ nach einem MV(X) Pattern implementiert werden. _Deklarative UIs _sind komponentenbasiert. Angular, vueJS
und React haben eine ausgeprägte Komponentenbasierung mit vorgegebener innerer Kompontentenarchitektur.\

_Slots:_ Austauschbare "Platzhalter" einer Komponente für Child-Komponenten.

*Vorteile:*
_Wiederverwendbarkeit_, _Komposition_ #hinweis[(Komponenten können für grössere Features kombiniert werden)],
_Kapselung_ #hinweis[(einfachere Umsetzung von OCP)] und eine klare _Trennung_ von Anliegen.
Komponenten sind in der Regel _unabhängig_ und können in verschiedenen Kontexten eingesetzt werden.\
*Nachteile:*
_Schlechte Separated Presentation:_ jede Komponente verwaltet ihre eigene Logik, Darstellung und Daten.
_Aufwendige Kommunikation/Synchronisation:_ ohne weitere Tools ist Kommunikation zwischen Komponenten aufwendig.\
*Eliminieren der Nachteile:*
- _Passive Komponenten:_ State wird nur von übergeordneten Komponenten kontrolliert. Verbessert Wiederverwendbarkeit und
  Testbarkeit.
- _Isolated Stateful Components:_ Komponenten, die einen State verwalten/manipulieren sollen nichts anderes tun.
  Ihre Childkomponenten sollten ebenfalls nur passive Komponenten verwenden.
- _State Container:_ Erleichtern die Synchronisation zwischen Komponenten und fördern Separated Presentation.
  "Abstrakte View" ist ohne View testbar.

=== Moderne Komponentenbasierte Architektur
- *Lokaler State:* State #hinweis[(ohne State Container)] ist lokal in Komponente gekapselt.\
- *View:* _Deklarative View_ als Teil der Komponente.\
- *Interaktionslogik:* Oft in der Komponente gekapselt, _ohne View testbar_.\
- *Interne Kommunikation zur View:* Durch Data Binding/Events oder Hooks.\
- *Wiederverwendbarkeit:* Komponenten sind _eigenständig_ und für verschiedene Teile der App verwendbar.\
- *Interne Pattern:* Angular oder vueJS basieren stark auf _Data Binding_. MVVM, Observable State oder Reactive Konzepte
  sind deshalb naheliegend. Bei _funktionalem React_ #hinweis[(Ohne State Container)] entsteht eine Art _MVC_.
  Controller und View sind _verschmolzen_. Erster Teil der Funktion ist der Controller, der zweite Teil die View.\
- *Sharing von State:* _State Container_ erlauben _State Sharing_ zwischen Komponenten und Trennung von State und View.
  Manipulation des States ist stark von _MVP_ beeinflusst. _Zyklische Pattern_ #hinweis[(MVU/MVI)] werden oft unterstützt.


= Patterns in React
React arbeitet nach dem Hollywood Prinzip, ist also ein Framework.

== JavaScript XML (JSX)
_Deklarativer Syntax_ für HTML in JS. Ermöglicht Implementation von _wiederverwendbaren Komponenten_ und mächtigen
_Kompositionen_ #hinweis[(React nutzt das Composite Pattern, siehe @composite)]. Wird von vielen JS-UI-Frameworks
verwendet und muss nicht unbedingt HTML ausgeben. Funktionen müssen JSX returnen, nur _Props_ #hinweis[(simple
  JS-Objekte)] als Parameter möglich. CSS in "`{{...}}`".\
*TypeScript XML:* typisiertes JSX für TypeScript.

=== JSX zu JavaScript kompilieren
Der _TypeScript Compiler_ oder _Babel_ #hinweis[(ein JS Compiler)] können JSX/TSX kompilieren.
Die gängigen Tools erwarten `*.jsx`/`*.tsx` als Dateiendung.

```json
{ // tsconfig.json
  "compilerOptions": {
    "jsx": "react", // gibt JSX Standard an, mit dem gearbeitet wird
    "jsxFactory": "React.createElement", // Factory-Funktion, die JSX generiert. Benötigte Signatur: createElement(type, props, ...childern)
    "jsxFragmentFactory": "Fragment" }
```
*Eigenes JSX Framework:*
Obige _Angaben_ in Compiler-Optionen setzen, Funktion _`createElement(type, props, ..children)`_ bereitstellen
#hinweis[(oder Adapter um JS-Funktion `document.createElement()` schreiben)].\
#hinweis[```tsx createElement("div", {id: "root"});``` generiert ```html <div id=root></div>```]\
*vDOM:*
React baut vereinfacht gesagt aus den JSX-Funktionen einen _Virtual DOM_ mit den HTML-Elementen, ihren Attributen und
ihren Kindern.\
*Render-Funktion:*
Damit die Inhalte im HTML angezeigt werden können, braucht es eine `render()`-Funktion, die den _vDOM in HTML umwandelt_.

== Functional Components
_Functional Components_ #hinweis[(FC)] werden als Funktion in JSX geschrieben. Sind _Komponenten_, die als JSX Tags
wiederverwendet werden können. Können _Props_ und _Children_ entgegennehmen und einen _Zustand_ kapseln.

==== Beispiel einer Funktionalen Komponente und deren Aufruf
```tsx
const HelloMessage = (props: { name: string }) => {
  return <div style={{ fontSize: 20px }}> // <- CSS in camelCase
    Hello {props.name}</div>;}

const HelloWorld = () => { return <div><HelloMessage name="OST" /></div>; }
```

Im Beispiel oben wird das _Dependency Inversion Principle_ verletzt, weil `HelloWorld` direkt von `HelloMessage`
abhängig ist. `HelloMessage` müsste als Prop an `HelloWorld` übergeben werden:

```tsx
const HelloWorld = (props: { children?: React.ReactNode }) => {
  return <div>{ props.children }</div>; };
const App = () => {
  return (<HelloWorld><HelloMessage name="OST" /></HelloWorld>); };
```

=== React Hooks
Hooks ermöglichen das _Eingreifen_ in den Rendering Prozess einer Funktionalen Komponente. Die wichtigsten sind
`useState()` und `useEffect()`. Sie erlauben es, Komponenten mit _Zustand_ zu implementieren und auf Änderungen des
Zustands zu _reagieren_.

React verwaltet für jede FC einen _Component Context_ im Hintergrund, in welchem Informationen zum _letzten Rendern_
der Komponente gespeichert werden #hinweis[(Fiber-Architektur)]. Die Hooks werden _der Reihe nach registriert_ und die
Informationen mithilfe eines _aufsteigenden Indexes_ in einer Struktur auf dem Component Context abgespeichert und somit
immer in der gleichen Reihenfolge aufgerufen. Deshalb darf ein Hook nicht mit einer _Conditional Anweisung_
#hinweis[(`if`)] zugewiesen werden, weil er dann nur manchmal aufgerufen wird und somit die _Reihenfolge_ durcheinander
gebracht wird.

Die nachfolgenden Beispiele sind _vereinfacht_, da React _asynchron_ rendert und Zustandsänderungen zusammenfasst
#hinweis[("Batching")]. React verwaltet eine eigene _Update Queue_ und kann wartende Updates abbrechen
#hinweis[(interrupting)]

==== `useState(initialState)`
Ist ein _Observer Pattern_ #hinweis[(Subject: Gespeicherter State-Wert "count", Observer: React Komponente "Counter" )].
Damit lässt sich ein Zustand _definieren_, _lesen_ und _ändern_. Returnt die _Variable_ und dazugehörigen _Setter_
#hinweis[(Benachrichtigungsmechanismus)].

```tsx
import { useState } from 'react';
export const Counter = () => {
  const [count, setCount] = useState(0);
  return ( <div>
      <p>Aktueller Zählerstand: {count}</p>
      <button className="button scale08"
        onClick={() => setCount(count + 1)}>+</button></div> );	};
```
==== `useEffect(setup, dependencies)`
Ist ein _Observer Pattern_ #hinweis[(Subject: Dependency-Array, Observer: Effect-Callback)]. Führt _asynchron_
Seiteneffekte wie Datenabrufe oder DOM-Manipulationen nach dem Rendern aus. Wird immer ausgeführt, wenn sich
Abhängigkeiten ändern #hinweis[(Trigger)]. Mehrere Aufrufe registrieren mehrere Handler. Blockiert _nicht_ das UI.

```tsx
const url = "http://localhost:5093"; const player = new Player { /* ... */ };
useEffect(() => {
  const connection = createConnection(url, player)
  connection.connect();
  return () => connection.disconnect(); // Effect Callback: Observer
}, [url, player]); // dependency-array, contains values used in `setup` lambda
```
Ist das Dependencies-Array leer, wird der Effect nur beim ersten Render ausgeführt. Ansonsten bei jedem Rerender durch
Änderungen an den Dependencies.

Sollte _nicht verwendet_ werden, um den _abgeleiteten Zustand zu verwalten_, der direkt aus Props oder anderem Zustand
berechnet werden kann, da das zu _unnötiger Komplexität_ führt #hinweis[(`useEffect()` wird erst nach dem Rendern
  ausgeführt, somit muss einmal mehr gerendert werden)]. `useMemo()` ist die synchrone Variante von `useEffect()`
#hinweis[(siehe Kapitel @usememo)].

== Reconciliation und Fibers
React verwendet einen _vDOM_, weil direkte DOM-Manipulationen _langsam_ und _ineffizient_ sind.
React nutzt _Reconciliation_ für effiziente Updates: nur _betroffene_ Komponenten werden neu ausgeführt
#hinweis[(unbetroffene Child-Komponenten werden ebenfalls nicht ausgeführt)].

_Vor React v16_ wurden _Position im Array_ und _Name_ der Komponente verglichen. Der State kann so jedoch in die falsche
Komponente rutschen, wenn keine _stabilen und eindeutigen Keys_ verwendet werden.\
_Seit React v16_ werden _Fibers_ verwendet, eine interne Datenstruktur für vDOM. Speichern _State_, _Props_ und
Referenzen zu HTML-Elementen. Navigation via _`child`_, _`sibling`_, _`return`_ #hinweis[(Parent)] und _`stateNode`_
#hinweis[(Verbindung zum echten DOM-Element)].

*Current Fiber vs. Work-in-Progress Fiber:*
_Current Fiber_ ist der aktuelle UI-Zustand. _WIP Fiber_ entsteht während der Reconciliation.
_WIP_ wird nach Reconciliation zum neuen _Current Fiber_.

== Concurrent Mode
JS hat im Browser nur _einen einzigen Thread_. Asynchronität bedeutet hier, dass die Behandlung einer Anfrage auf einen
_späteren Zeitpunkt_ verschoben werden kann, ohne den _Hauptthread_ zu blockieren. Dies wird durch das
_Event-Loop-Modell_ erreicht. Asynchrone Aufgaben werden in eine _Warteschlange_ gestellt und nacheinander
_abgearbeitet_.\
Der _Concurrent Mode_ in React verbessert die _Reaktionsfähigkeit_ durch das Priorisieren und Unterbrechen des
Renderings. So bleibt das UI reaktionsfähig.\
*Fiber-basierte Aufteilung:*
React teilt das Rendering in _kleine Einheiten_ auf. Jede _Fiber_ ist eine _Arbeitseinheit_. Nach jedem Fiber wird
überprüft, ob es etwas _wichtigeres_ gibt, _falls ja:_ Unterbrechen und wichtigere Aufgabe zuerst.
_Falls nein:_ weiter mit dem nächsten Fiber.\
*Zwei-Phasen-Struktur:*
_Render Phase_ ist unterbrechbar und beinhaltet vDOM erstellen, Komponenten ausführen und  Änderungen berechnen.
Die _Commit Phase_ ist nicht unterbrechbar und beinhaltet DOM-Änderungen anwenden, Refs aktualisieren und
`useEffect()` ausführen. Muss atomic erfolgen.\
*Prioriäten in React:*
_Immediate_ sind Benutzer-Inputs. Dafür wird das aktuelle Rendering unterbrochen.
_Normal_ sind Netzwerk-Responses oder Animations-Updates.
_Low_ sind Hintergrund Tasks wie Analytics.

==== `useMemo(calculateValue, dependencies)` <usememo>
Im Vergleich zu _`useEffect()`_ gibt es noch _`useMemo()`_, welches _synchron_ ist und das Rendering _blockiert_.
Wird _während_ dem Rendering ausgeführt und für _pure functions_ verwendet. Es speichert Ergebnisse im Component Context.
So werden teure Berechnungen nicht unnötig wiederholt. _`useCallback()`_ wird für das gleiche verwendet, nur speichert es
Funktionen.


= Reactivity
Reactivity ist die Fähigkeit eines Systems, _automatisch_ auf _Änderungen_ in seinem Zustand zu reagieren.
In reaktiven Systemen werden _Abhängigkeiten_ zwischen Datenquellen und abhängigen Komponenten erstellt:
Änderungen in den Daten lösen eine automatische Aktualisierung der abhängigen Komponenten aus.
Bietet einen _effizienten_ und _sicheren_ Ansatz zur Gestaltung moderner, _ereignisgesteuerter_ UIs und
_vermeidet_ typische _Probleme_, die im Observer Pattern auftreten.

== Probleme des Observer Pattern
- *Kontrollfluss-Chaos:* Kontrollfluss ist _nicht direkt im Code erkennbar_, da dynamisch aufgebaut.
  _Unübersichtlich_, erschwert Lesen, Testen und Debugging. _Unnötige Aufrufe_ von Handlern, wenn ein Observer
  bei mehreren Subjects "subscribed" ist.
- *Verpasste Events:* Wird ein Handler erst _nach dem Auslösen registriert_, geht das vorherige Event _verloren_.
  Automatischer Aufruf des letzten Events beim _`subscribe()`_ hilft dagegen.
- *Memory Leaks:* Entwickler müssen alle Callbacks wieder _deregistrieren_.
- *State-Chaos:* In Callbacks wird oft der _State verändert_. Wird schnell _unübersichtlich_. Dagegen hilft entweder das
  Aufgeben der Kapselung oder die Verwendung eines anderen Synchronisationsmechanismus.
- *Endlosloops:* _Zirkuläre Abhängigkeiten_ werden oft übersehen.
- *Race Conditions:* _Ordering-, Reentrancy- und Scheduling-Effekte_ können ähnliche Probleme verursachen.
  Wird schnell sehr _unübersichtlich_.
- *SOLID Verstösse:*
  _SRP_ #hinweis[(Subject verwaltet Zustand und Benachrichtigungen, Observer empfangen Benachrichtigungen und
    verarbeiten diese)], _OCP_ #hinweis[(Für verschieden benachrichtigte Observer muss eine Änderung am Subject
    vorgenommen werden)] und _ISP_ #hinweis[(Je nach Interface müssen Observer nicht benötigte Methoden implementieren,
    da das Interface annimmt, dass Subjects unterschiedlich benachrichtigt werden)].

```ts
let path: Path | null = null;  // ⚠️ 1. State Chaos: escaped scope
const moveObserver = (event: MouseEvent) => {
  path?.lineTo(event.position);  // ⚠️ 2. Komplexität Kontrollfluss
  draw(path); };
control.addMouseDownObserver((event) => {
  path = new Path(event.position);  // Schritt 1
  // ⚠️ 3. Verpassen des ersten Events möglich
  control.addMouseMoveObserver(moveObserver);
  // ⚠️ 4. Memory Leak: manuelles Cleanup nötig (dispose nötig)
});
control.addMouseUpObserver((event) => {
  control.removeMouseMoveObserver(moveObserver);  // Schritt 3
  // ⚠️ 5. Race Condition / Fehlende Separation of Concerns
  path?.close();
  draw(path);
  // ⚠️ 6. Endlosloop falls draw() auch Events triggert
});
```

== Signals, Effects & Computed <signals-effects-computed>
Damit lassen sich die typischen Probleme des Observer Patterns reduzieren.\
*Reactivity:*
_Automatische_ Reaktion auf lokale Zustandsänderungen. Beinhaltet die _Automatisierung_ der Mechanismen
und des Lifecycle Management des Observer Patterns. Meist für Datensynchronisation mit UI verwendet.\

*Signal:*
Ein Signal hat _einen Wert_, der sich _ändern_ kann. Es kann andere Komponenten über Änderungen _informieren_
und beinhaltet ein _verstecktes Tracking_, das erfassen kann, wann es gelesen wird. Ist ein _Observer Pattern_ für nur
einen primitiven Wert.\

```ts
const mySignal = new Signal(0); // Ein Signal mit Initialwert 0
mySignal.subscribe((value) => console.log(value));
// Benachrichtigung bei Wertänderung. Nur versteckt aufgerufen
mySignal.value = 5; // Ändert den Wert und benachrichtigt Abonnenten
```

*Effect:*
Wird _automatisch_ neu ausgeführt, wenn sich ein Wert eines Signals _ändert_, welches in der letzten Ausführung
des Effects verwendet wurde. Eignet sich für UI Updates. Kann _mehrere_ Signals enthalten und abonnieren.

```ts
// Der Effect wird in einem UI Framework automatisch erstellt
const counterUpdate = new Effect(() => {
  counterElement.textContent = `Counter: ${counterSignal.value}`; });
counterUpdate.run(); // wird durch das UI Framework aufgerufen.
counterSignal.value++; // automatisches Update
```

*Computed:*
_Kombination von Signal und Effekt_. Verwendet einen Effect, um ein gekapseltes Signal zu _modifizieren_ und
ermöglicht das _Lesen_ und die _Subscription_ von diesem Signal. Wird oft _lazy_ umgesetzt
#hinweis[(werden bei Abhängigkeit durch den Dependency Tracker "dirty" gesetzt und bei Bedarf neu berechnet)].

```ts
// Der Effect wird in einem UI Framework automatisch erstellt
const A = new Signal(8); const B = new Signal(12);
const sum = new Computed(() => { return A.value + B.value; });
sum.subscribe((value) => console.log(value));
A.value = 2; // Ausgabe 14 (durch Änderung von A)
```

*Vorteile:*
Kontrollfluss durch Dependency Container kontrolliert, Effekt liest immer Wert beim ersten Zugriff,
Zentrale Verwaltung von Signals, Race Conditions unwahrscheinlich, keine Memory Leaks oder Endlosloops.\
*Dependency Tracker:*
Arbeitet im Hintergrund und _verbindet Signal und Effect_. Ansonsten _unsichtbar_.
Zuständig für das Verfolgen von _reaktiven Abhängigkeiten_ und _Aufrufen von Effect_ bei Änderungen.\
*Signals vs. `useState()`:*
Mit `useState()` wird der State der Komponente gehalten. Mit Signals kann dieser _herausgelöst_, _wiederverwendet_
und _separat getestet_ werden: Damit wird nur der betroffene Teil, nicht die ganze Komponente aktualisiert.
Signals ermöglichen _fein granulare Reaktivität_ durch präzise Abhängigkeiten
und automatische Aktualisierungen. Signals sollten in der _Programmiersprache_ und nicht im Framework integriert sein.
Dies führt zu kompletter _Trennung_ von non-View-Code von View und Framework.

== Reactive Programming
Reaktives Programmieren ist ein _asynchrones Programmierparadigma_, das sich auf die Reaktion auf Datenströme
#hinweis[(Menge von Events)] und Ereignisse über _Zeit_ konzentriert. Klassisches Observer Pattern ist imperativ,
Reactive Programming hingegen _deklarativ_ aus dem Blickwinkel der _Veränderungen_. So entsteht das Konzept von
_Streams_. Observer agieren als _Consumer_ dieser Streams.\
*Promises:*
Versprechen, dass in Zukunft ein Resultat kommen wird. Handler wird im Vergleich zum Observer Pattern nur
_einmal_ aufgerufen. `then()` wrappt den Rückgabewert automatisch in ein Promise, das macht _Chaining_ möglich
#hinweis[(Im Observer Pattern nicht möglich, weil `setValue()` `void` zurückgibt)].\
*Stream:*
Eine _Sequenz von Ereignissen_, die über eine _Zeitspanne_ auftreten.\
*Observable:*
Ein _Stream_, dessen Ereignisse #hinweis[(Wert, Fehler, Endsignal)] von einem _Abonnenten_ #hinweis[(Observer)]
verarbeitet werden können. Bietet Unterstützung für _Nachrichtenaustausch_ zwischen Publisher und
Subscriber. Vereinfacht _Ereignisverarbeitung_, asynchrone Programmierung und Handhabung mehrerer Werte. Ist _lazy_
#hinweis[(Code wird erst bei Aufruf von `subscribe()` ausgeführt)], vereinfacht _Abmelden_ durch direktes Zurückgeben
von `unsubscribe()` bei Aufruf von `subscribe()`.\
*Observer:*
_Implementiert_ `next()`, `error()` und `complete()`. Das Observable _ruft diese Methoden auf_, um Werte,
Fehler oder das Ende des Streams zu signalisieren.\
*Operatoren:*
_Transformieren_ Observables und geben neue zurück. _Filter_ z.B. filtert Ereignisse und lässt nur bestimmte weiter.\
*Pipe:*
Wird verwendet, um mehrere Operatoren auf ein Observable anzuwenden und den Datenstrom zu _transformieren_.
Erlaubt _sauberes Verketten_ von Operatoren wie `map()`, `filter()` etc. Macht den Code _modularer_ und _übersichtlicher_.\
*Rate Limiting:*
_Debounce_ wartet nach jedem Ereignis eine bestimmte Zeit und emittiert letzten Wert nach einer Inaktivitätsperiode
#hinweis[(z.B. zum Aktionen erst auszuführen, wenn Benutzer Eingabe beendet hat)]. _Throttle_ emittiert sofort und
ignoriert dann weitere Werte für eine bestimmte Zeitspanne #hinweis[(z.B. um Verarbeitung von Ereignissen zu reduzieren,
  die in hoher Frequenz auftreten, wie Scroll, um Ressourcen zu schonen)].\
*Subject:*
Spezielles Observable, das Werte an _viele Observer_ verteilen kann #hinweis[(Multicast)]. Es kann sowohl als
_Observable_ als auch als _Observer_ agieren. Bei Multicast teilen sich alle Abonnenten den selben Datenfluss, sodass
alle die _gleichen_ Werte _gleichzeitig_ erhalten. Subject ist ein Beispiel für _Hot Observable_, da es bereits aktiv ist
und Daten sendet, egal ob Abonnenten vorhanden sind oder nicht.


= State Container
State Container wie Redux _speichern den Zustand_ an einem zentralen Ort, bieten Methoden _zur Änderung_ und ermöglichen
einheitlichen Datenfluss. Vorteile sind die konsistente _"Single Source of Truth"_ und ein klarer, unidirektionaler
Datenfluss, was _Wartung_ und _Debugging_ erleichtert. *Reacts Context API* ist ein primitiver State Container
#hinweis[(kein Time-Travel-Debugging oder autom. Dependency-Tracking)].

*Lokaler State* von Komponenten ist schwer zu teilen und führt zu Problemen bei Trennung von State und UI-Logik.\
*State Sharing:* Notwendig, um Zustände in komplexen Anwendungen konsistent und effizient zu verwalten.\

== Lösungen für State Sharing
*State Lifting & Props Drilling:*
Die _einfachste_ Lösung für State Sharing. Mit _State Lifting_ wird der State _eine Hierarchie weiter nach oben_
verschoben und mit _Props Drilling_ wird er an _Childkomponenten_ weitergegeben. Wird jedoch schnell _performance-intensiv_
weil der gesamte vDOM neu gerendert werden muss. Führt auch zu _unübersichtlichem_ und _fehleranfälligem_ Code.
_Verletzt_ _SRP_ und _ISP_.\
*`useContext()`:*
Der State wird _indirekt hierarchisch_ ohne Props Drilling _geteilt_. Verwendete Konponente definert _Kontext_
#hinweis[(`createContext()`)], alle Komponenten weiter unten in Hierarchie können ihn verwenden #hinweis[(`useContext()`)].\
Provider = Container, Context = State, `useContext()` = Consumer\
*Dependency Injection:*
MVVM Frameworks #hinweis[(WPF, MAUI)] können einen DI-Container verwenden, um den State zu teilen und das gleiche
ViewModel in verschiedenen Komponenten zu verwenden oder Observable Proxies zu teilen.

== Redux
Ist ein _State Container_, der oft in React-Anwendungen verwendet wird. Bietet eine _einheitliche_ und _vorhersagbare_
Datenverwaltung und schafft eine _zentrale Quelle_ für den gesamten Anwendungszustand. Das macht es einfacher,
Änderungen zu verfolgen und Fehler zu minimieren. Debugging durch _Time Traveling_. Redux implementiert das _Observer
Pattern_ & _Command Pattern_.

*Store:* Zentraler _Speicherort_ für _gesamter Zustand_ der Anwendung mit Benachrichtigungsmechanismus für Änderungen.

#v(-0.5em)
#grid(
  columns: (1.1fr, 1fr),
  [
    *Action:*
    Beschreibt, _was_ in der Anwendung _geschehen_ soll. Enthält einen _Type_ für die Art der Änderung
    #hinweis[(z.B. `ADD_ITEM`)] und zusätzliche Daten als _Payload_.
    *Action Creator:*
    Funktion, die eine _Action_ mit einem _Payload_ aus einem Event erstellt und das _Resultat_ mit `dispatch()`
    an den _Store_ sendet.
    *Reducer:*
    Pure Function #hinweis[(Ohne Side Effects)], die den _aktuellen State_ und eine _Action_ annimmt und einen
    _neuen Zustand_ zurück gibt. _Verarbeitet die Action_. Vereinfacht Testing. Datenfluss läuft _zirkulär_ und
    _unidirektional_.
  ],
  image("img/redux.png"),
)

*Vorteile:*
_Vorhersagbarkeit:_ jede State-Änderung läuft durch den gleichen Pfad. _Debuggbarkeit:_ Action-Log speichert
Veränderungen und _Time-Travel-Debugging_ ist möglich.
*Nachteil:*
Viel Boilerplate, Overkill bei kleinen Applikationen.

Redux ist mehr oder weniger _MVP_ mit _Commands/Selections/Interactors_: Commands $->$ Actions, Selections $->$
`useSelector()`, Interactors $->$ Reducers, Model $->$ Store, Passive Views $->$ "Stupid Views".
Redux bringt aber einige Verbesserungen: Unidirectional Flow, Immutable Updates, Pure Functions, Time Travel Debugging,
Predictable State Changes.
*Redux Toolkit (RTK):*
Offizielle, moderne Art, Redux-Logik zu schreiben. _RTK Query_ ist eine fortgeschrittene Daten-Fetching-Lösung,
die darauf aufbaut #hinweis[(beinhaltet automatisches Caching, Background Updates, Optimistic Updates, Error Handling,
  Loading States, Tag-basierte Invlidierung, ...)].

=== Thunks (Async)
_Middleware_ erweitert Redux um zusätzliche Funktionalität wie Logging, Caching oder _Asynchronität_.
Ein _Thunk_ ist eine Funktion, die eine bestimmte Berechnung oder Aktion _verzögert_ ausführt und erst aufruft, wenn
sie wirklich benötigt wird #hinweis[(In React z.B. um Code nach dem Abschluss von asynchronem Code auszuführen)].
_Thunk Middleware_ ist eine spezielle Middleware für Redux und ermöglicht _asynchrone Logik_ durch Dispatching von Thunks.
_Typische Thunk Patterns sind:_\
- *Loading States:* `START`, `SUCCESS`, `ERROR` ermöglichen UI-Feedback während asynchroner Operation.\
- *Conditional Dispatching:* Zugriff auf aktuellen State via `getState()`
  #hinweis[(z.B. User nur fetchen, wenn nicht geladen oder Daten veraltet sind)]\
- *Chain Thunks:* Ein Thunk kann andere Thunks dispatchen\
- *Error Handling:* Zentrale Fehlerbehandlung in Thunks

== Reaktive State Container (z.B. MobX)
*MobX vs. Redux:*
Weniger _Boilerplate_, kein explizites _Dispatching_, einfacher bei _komplexen_ State-Änderungen.
_Automatische Synchronisierung_ von UI und State durch _Dependency-Tracking_. Schlechtere Nachvollziehbarkeit,
schwierigeres Debugging. Grössere direkte Abhängigkeiten vom State Container.

=== MobX Kernkonzepte
MobX verwendet ein _Observable State Proxy_ Pattern #hinweis[(siehe @dynamic-proxies)] für Zugriffs- und Änderungs-Detection,
kombiniert mit _Signal Read-Tracking_ #hinweis[(siehe @signals-effects-computed)] für automatische Dependency Registration
#hinweis[(Reaktivität)] ohne zentralen Store.

- *Observable (State):* Datenstruktur, die auf Änderungen reagiert. MobX verwendet _Observable State Proxies_,
  um Zustand zu verwalten.\
- *Actions:* Definieren von State-Änderungen. Actions _modifizieren_ Observable State.
  Die Updates lösen erst zum Schluss ein Rendering aus.\
- *Computed:* Abgeleitete Werte, reactive Funktionen die automatische Updates auslösen können.
  _Identisch zu lazy Signal_.\
- *Reactions:* Automatische Reaktionen #hinweis[(effect / autorun)]. Änderungen werden automatisch getrackt.

#image("img/mobx.png")

*makeAutoObservable():*
Ermöglicht das _automatische Konvertieren_ einer Instanz einer Klasse in Observable Werte, Computed und Actions.
Besser als \@Decorators, welche deprecated sind. _`autorun()`:_ MobX-Version von `effect()`.\
*Performance-Realität:*
Mit `observer()` von MobX in React wird die _ganze Component neu gerendert_ und der _vDOM komplett neu_ erstellt.
Ist also _nur automatisches Component-Tracking_, keine _feingranularen_ DOM-Updates möglich.
Dafür braucht es andere Frameworks.

*TC39:*
Erweiterter zukünftiger Signal Standard für JavaScript, der MobX _obsolet_ macht. Alle MobX-Features sind damit
nativ in JS verfügbar.\
*Hauptunterschiede zu MobX:*
_Explizite Signal API_ #hinweis[(Mit Decorators ist TC39 nicht von Proxies abhängig)] und
_Native Browser Support_ #hinweis[(bald ohne Library verfügbar)].\
*Deep Reactivity:*
Viele Frameworks brauchen Deep Reactivity #hinweis[(Reaktive Objektbäume)], das ist _performancetechnisch_ nicht optimal.
TC39 bietet bessere Alternativen für _"Flat Reactivity"_ mit `SignalObject` oder über Decorators.

== State Machines als State Container
*Probleme vom State Pattern:*
If-Else _Chaos_, Diverse verletzte _SOLID_ Prinzipien #hinweis[(LSP, DIP, OCP, ISP)]. Viel _Boilerplate_,
schwer visualisierbar, unklares _Memory Management_, Keine Hierarchie, keine Guards #hinweis[(Transitions jederzeit möglich)],
Kein Event System. Für _komplexe_ State Logik _unzureichend_ #hinweis[(siehe @state)].\

*State Machines* hingegen sind klar überblickbar:
#v(-0.5em)
```ts
const playerMachine = { initial: 'stopped', states: {
    stopped: { on: { PLAY: 'playing' } },
    playing: { on: { PAUSE: 'paused' } },
    paused: { on: { PLAY: 'playing' } } } };
```

*Verbesserungen von modernen State Machine Frameworks:*
_Weniger Code:_ Konfiguration statt Implementation, _Typ-Sicherheit:_ Auto-generierte TypeScript Types,
_Visualisierung:_ State Charts sind selbstdokumentierend, _Testing:_ States und Transitions sind explizit testbar,
_Hierarchical States:_ Nestet States und parallele States möglich.\
*XState*
kombiniert _State Machine_ mit _State Container_. Bietet kein Boilerplate dank _deklarativer Config_,
_Guards_ für bedingte Transitions, hierarchisch & parallele _States_, _Event-based_ System.\
*Hierarchical State Machines:*
Erlauben die Modellierung komplexer Zustände mit _Unterzuständen_, was die _Übersichtlichkeit_ bei komplexer Logik erhöht.\
*Guards und Actions:*
Guards ermöglichen _bedingte Transitions_, Actions führen _Side Effects_ aus. Das macht State Logik _testbar_
und _vorhersagbar_.\

*Vorteile:*
_Robustheit_ #hinweis[(Verhindern von unmöglichen Zuständen, deterministisch)], bessere _Developer Experience_,
_Skalierbarkeit_\
*Nachteile:*
_Learning_, _Verbosity_ #hinweis[(Mehr Boilerplate für simple Logic)],
_Integration_ #hinweis[(Zusätzliche Dependency, Codebase Migration)]\
*Verwenden bei:*
_Komplexer UI-Logik_, Business Prozesse #hinweis[(Workflows)], Bug-prone Areas, Games, Echtzeit-Kommunikationsprotokolle.\
*Nicht verwenden bei:*
_Einfachen Use-Cases_, Datenintensiven Applikationen.

_State Machines = Transitions + Guards + Hierarchie + Events + Tooling_

== Moderne MV\* Pattern
*Probleme klassischer MVP/MVVM:*
_Bidirectional Data Binding_ #hinweis[(Schwer nachvollziehbare Updates)], _schwierige State Synchronization_ zwischen
State und View.\
*MVVM Two-Way Binding Probleme:*
Der Setter muss selber implementiert und mit Benachrichtigungslogik befüllt werden. Daraus entsteht ein
_unkontollierter Kontrollfluss_ #hinweis[(Cascading Updates, Side Effects in Setter, schwer debugbare Zyklen, Performance)].\
*Reactive MVVM:*
Bietet automatische Reaktivität, Transactional Updates, Computed Values mit Memoization, Automatisches Cleanup,
Unidirectional Data Flow, einfachere Testbarkeit.\
*MVU (Model View Update):*
Einfachere, _funktionale Architektur_ für synchrone, deterministische _Zustandsänderungen_.
Spezifische Implementierung von _MobX_.

#image("img/mvu.png")

*The Elm Architecture (TEA):*
_Model:_ Immutable State/Datenstruktur der Anwendung.
_View:_ Pure Function, die Model zu HTML/UI rendert, sendet Messages bei User-Interaktionen.
_Update:_ Pure Function, die Message und Model zu neuem Model berechnet.
_Geschlossener Kreis:_ Model zu View #hinweis[(rendering)] zu Update #hinweis[(bei Messages)] zu neuem Model.
_Eigenschaften:_ Alle Functions sind pure #hinweis[(testbar)], State ist immutable #hinweis[(time-travel)],
unidirectional flow #hinweis[(predictable)].
_Einfluss:_ Redux, moderne React Patterns basieren auf TEA Prinzipien.\

#grid(
  columns: (1fr, 1fr),
  [
    *MVI (Model View Intent):*
    Vorhersage von _Zustandsänderungen_, _Single Source of Truth_, _Unidirektionaler_ zirkulärer Datenfluss.
    Spezifische Implementierung _Redux_.\
    *VIPER:*
    iOS Clean Architecture
    #image("img/viper.png")
  ],
  image("img/mvi.png"),
)
#v(-1em)


= Rendering Strategien
Rendering Strategien _wählen_ heisst, die untenstehenden Concerns der jeweiligen Situation entsprechend in _Balance_ zu
bringen.
- _Performance:_ Statisch #hinweis[(Sofort verfügbar)], dynamisch #hinweis[(Berechnung erforderlich)]
- _SEO & Auffindbarkeit:_ Bestimmt Business-Erfolg
- _Kosten:_ Serverlast #hinweis[(Infrastruktur-Kosten)], Entwicklung #hinweis[(Implemetation, Wartung)]
- _User Experience:_ Time to interactivity, white screen, UI Reaktionen
- _Sicherheit:_ Code-Offenlegung #hinweis[(Remote Presentation Risk)], Attack Surface
- _Wartbarkeit & Testing:_ Logik, visuelle Validierung, Nachvollziehbarkeit

*Server Side Rendering (SSR):*
Server rendert den gesamten HTML-Inhalt und sendet ihn an den Client. Seite sofort sichtbar und SEO-freundlich.
Interaktivität benötigt weitere Technologien. _Geeignet für:_ SEO-relevante Seiten mit wenig Traffic,
Seiten mit personalisiertem Zugriff #hinweis[(z.B. eCommerce)].\
*Client Side Rendering (CSR):*
HTML und JS werden an den Browser gesendet, der die Seite dann rendert. Initial-Ladevorgang langsamer, dafür
Seitenübergägne reaktiv und flüssig. Schlecht für SEO, wenn Crawler JS nicht rendert.
_Geeignet für:_ Hochinteraktive Anwendungen mit dynamischen Inhalten #hinweis[(z.B. Dashboards)].\
*Static Site Generation (SSG):*
HTML wird zur Build-Zeit vorab generiert und als statische Dateien bereitgestellt. Client erhält sofort fertige HTML-Seite.
Extrem schnelle Ladezeit. _Geeignet für:_ wenig dynamische Sites die schnelles Laden erfordern
#hinweis[(z.B. Doku-Seiten, Wikis, Unternehmenswebseiten)].\
*Deferred Static Generation / Incremental Static Regeneration (DSG, ISR):*
Seiten werden on-demand bei der ersten Anfrage generiert und als statische Dateien gecacht. Bereits generierte Seiten
werden zeitgesteuert und ergebnisbasiert neu generiert, um Inhalte aktuell zu halten. _Geeignet für:_ Grosse Content-Webseiten
mit Mischung aus dynamischen und statischen Inhalten #hinweis[(z.B. Nachrichtenplattformen, Produktseiten)].\
*Edge-Side Rendering (ESR):*
HTML wird an Edge-Servern des CDN generiert, die geografisch näher zum Nutzer stehen. Kombination aus Server-Performance
und globaler Verteilung für optimale Ladezeiten. _Geeignet für:_ Globale Anwendungen mit lokalisiertem Content
#hinweis[(Internationale Shops, SaaS)].

*Core Web Vitals:*
_Largest Contentful Paint_ #hinweis[(LCP, grösstes Element geladen)],
_First Input Delay_ #hinweis[(FID, Erste Eingabe-Reaktion)],
_Cumulative Layout Shift_ #hinweis[(CLS, visuelle Stabilität)].\
*Performance Metriken:*
_Time to First Byte_ #hinweis[(TTFB, Server-Antwortzeit)],
_First Contentful Paint_ #hinweis[(FCP, erstes sichtbares Element)],
_Time to Interactive_ #hinweis[(TTI, voll interaktionsfähig)].\
*Erfolgs-Prinzipien:*
Anforderungen vor Technologie, Team-Expertise berücksichtigen, einfach starten und dann erweitern,
Validierungs-Metriken verwenden

== Hybride Rendering Strategien
Kombiniert Strategien. _Performance:_ SSG für statische Inhalte, _SEO:_ SSR für dynamische Inhalte,
_Interaktivität:_ CSR für User Interfaces, _Flexibilität:_ Per-Page Strategien. Mit Frameworks wie Next.js ist das möglich.
*Vorteile:*
Einfaches Wählen der Rendering-Strategie, Performance #hinweis[(Code Splitting, Image Optimization)], file-based
Routing, API Routes, Zero-Config.

=== Hydration
Schnell sichtbare Inhalte durch SSR, anschliessend Interaktivität auf dem Client durch JS und State. Dabei werden Event
Listeners attached und State rekonstruiert. _Hydration Mismatch:_ Server hat andere Daten als Client.
_Lösung:_ Server-Daten werden serialisiert und an Client übertragen.
_Vorteile:_ Schnellere Ladezeiten, SEO-freundlich, Benutzerinteraktion.\
*Full Hydration:*
Server rendert komplettes HTML, Client lädt alles, alles neu rendern #hinweis[(Re-execution)], dann Event Listeners anhängen.
_Vorteile:_ Einfachste Implementierung, keine Architektur-Komplexität, einfaches Debugging, Bewährte Technologie.
_Nachteile:_ Performance bei Scale, grosse TTI, Verschwendete CPU durch doppelte Arbeit, Mobile Probleme.\
*Selective Hydration:*
Einteilung in _Suspense Boundaries_. User Interaction triggern Hydration. Viewport-basiert: Sichtbare Bereiche zuerst rendern.\
_Vorteile:_ Schnellere Performance, intelligente Priorisierung, Mobile Performance.
_Nachteile:_ Komplexere Architektur, schwieriges Debugging #hinweis[(non-deterministic)], Bundle-Size wird nicht geringer.
_Time Slicing:_ Hydration wird in 5ms Chunks vorgenommen, Browser bleibt responsiv.
_Priority Lanes:_ zuerst `UserBlocking` #hinweis[(Eingaben)], dann sichtbarer Inhalt, dann versteckte Inhalte.
_Ergebnis:_ Keine Konfiguration nötig, Intelligente Unterbrechung, Smooth User Experience.\
*Concurrent Hydration:*
Mit React Fiber. _Interruptible:_ Hydration pausiert für User-Interaktionen,
_Prioritized:_ Wichtige UI-Elemente werden zuerst hydriert, _Progressive:_ Schrittweise Hydration ohne Blocking des UI.\
*Streaming Hydration:*
Server streamt HTML Shell, gleichzeitiges Data Fetching & HTML Streaming, Chunk-wise Hydration & Progressive Enhancement.
_Vorteile:_ Schnellster First Paint, Parallel Processing, Mobile optimiert, Progressive UX, Bessere perceived Performance.
_Nachteile:_ Server-Komplexität, Framework-Abhängigkeit, Debugging schwierig wegen asynchroner Streams, Monitoring komplex.
_Verwenden bei:_ Slow Data Sources, Content-Heavy Pages, Mobile First\
*Prefetching (Re-)Hydration:*
Link Hover Detection #hinweis[(Prefetch bei Hover)], Viewport Intersection, User Pattern Analysis, Background Rehydration.
_Vorteile:_ Instant Navigation, Smart Prediction, Mobile Performance, SPA-ähnlich, Cache Optimierung.
_Nachteile:_ Bandwidth Overhead #hinweis[(ungenutzte Prefetches)], Server Load, Mobile Battery, Prediction Accuracy.
_Optimierungsstrategien:_ Connection-aware, Data-Saver Optionen respektieren, Priority-based pre-fetch, Analytics-driven pre-fetch.
_Verwenden bei:_ Multi-Page apps, E-Commerce, Browse Heavy Sites.\
*Partial Hydration #hinweis[(Island Architecture)]:*
Statische Basis, Interaktive "Inseln".
_Vorteile:_ Extreme Performance, minimale Bundle Size, Instant First Paint, Battery Life, Bessere SEO.
_Nachteile:_ Intensive Planung, Framework-Limits, State Management, Lernkurve.
_Verwenden bei:_ Landing Pages, Produktseite\
*Progressive Hydration:*
Enterprise Pattern. Multi-Stage nach Priorität, Framework-gesteuert, Performance Budgets, Business-Priorität.
_Vorteile:_ Optimales UX, Business-Orientiert, Framework-Support, Flexible Balance, Adaptivität
_Nachteile:_ Höchste Komplexität, Framework-Abhängigkeit, Monitoring komplex, Debugging schwierig.
_Use-Cases:_ E-Commerce, Financial, SaaS.

=== Resumability (Qwik)
*Probleme bei normaler Hydration:*
Server rendert Component Tree, Client lädt JS Bundle, erstellt identischen Component Tree, und vereint JS mit DOM
$->$ Verursacht Performance Impact durch doppelte Arbeit.\
*Resumability:*
Server rendert HTML & serialisiert State. Client lädt nur einen Loader #hinweis[(z.B. QwikLoader)], deserialisiert State
aus HTML und ist sofort interaktiv. _23x schnellere Time to Interactive, 200x kleineres Bundle._\
_Qwik_ hat zum Ziel: 0ms to interactive, _Instant Loading_, Serializable Applications, Dev Experience wie React.
Setzt auf _globalen Event Listener_. Der Optimizer _transformiert Event Handler in URLs_
#hinweis[(z.B. `./chunk-abc.js#handleClick`)]. Diese URLs werden als Strings im HTML serialisiert und der Code wird
_lazy_ beim Klick geladen.
*Qwik-Serialisierung:*
References als IDs statt Kopien bedeutet, dass _circular References_ möglich sind.
_Ideal für:_ Performance-kritische Apps, Hohe Effizienz, perfekter Server/Client Sync.
_Herausforderungen:_ Entwickler Experience, Technische Grenzen
#hinweis[(Nicht alle Datentypen serialisierbar, Build-Komplexität)].

== Micro Frontends
*Warnsignale bei wachsenden Applikationen:*
_Trägheit_ der Weiterentwicklung durch hohe Komplexität, _Technologie-Stagnation_ durch Abhängigkeit,
_Team-Koordination_ schwierig, _Inkonsistentes Design_ durch zu grosse Teams, _Langsame Ladezeiten_ wegen zu grossen Bundles.\
*Micro Frontends:*
Teile grosse Anwendungen in _unabhängige_ Frontend-Module, die separat entwickelt und deployed werden können.
Ermöglichen modularisierte, flexible Frontend-Architektur.\
*Vorteile:*
Incremental Upgrades von Komponenten und Dependencies, _Unabhängige_ Entwicklung, einfache Codebasis, unabhängige Teams,
hohe _Skalierbarkeit_, Nutzung _unterschiedlicher_ Technologien möglich. \
*Nachteile:*
_Erhöhte Komplexität_ bei Integration, Testing und Monitoring und _Performance Overhead_ durch duplicated Dependencies,
mehr Netzwerk-Requests und grössere Bundle Sizes durch mehrere Frameworks.

=== Kernprinzipien
- _Technology Agnostic:_ Jedes Team wählt seinen Stack
  #hinweis[(Keine Abhängigkeiten, Experimentieren möglich. Shared Dependencies z.B. müssen aber koordiniert werden)]
- _Isolated Team Code:_ Keine geteilte Runtime
  #hinweis[(Fehler-Isolation, Independent Updates, Keine Konflikte. Isolation auf verschiedenen Ebenen wie Build-Zeit
    und Runtime)]
- _Team Prefixes:_ Namespacing für CSS und Events
  #hinweis[(Vermeidet Konflikte, macht Ownership klar ersichtlich, erleichtert Debugging. z.B.
    `[team]-[component]-[element]`)]
- _Native Browser Features:_ Browser APIs nutzen
  #hinweis[(weniger Dependencies, mehr Stabilität und Performance, Framework-agnostisch)]
- _Build Resilient Sites:_ Progressive Enhancement
  #hinweis[(Resilienz-Strategien wie Graceful Degradation, Fallback Components, Error Boundaries. z.B. zeige Skeleton UI
    wenn Service langsam ist, Basic HTML funktioniert auch ohne JS)]

=== Integration Strategien
- _Server-side:_ Templates & SSI #hinweis[(Server Side Includes)]. Fragments zur Build-Zeit zusammenfügen, Edge Side
  Includes #hinweis[(CDN-Level Integration)], Backend rendert komplette Seite.
  #hinweis[(Perfektes SEO, Schnelles Laden, einfache Implementation. Aber: Schwierig bei dynamischen Inhalten,
    limitierte Interaktivität, gemeinsame Deployment-Pipeline nötig)]
- _Build-Time:_ Nicht empfohlen, zerstört Hauptvorteile von Micro Frontends wie Autonomie und Unabhängigkeit.
  Shared Repository, Monorepo. #hinweis[(Coordination Hell, Shared Dependencies, Build Failures, Testing Bottleneck)]
- _iFrames:_ Einfach, aber limitiert. #hinweis[(Starke Isolation, Legacy Integration, Sicherheit)]
- _JavaScript:_ Flexibelster Ansatz. #hinweis[(Runtime-Integration ohne Build-Coupling, Shared State Management möglich,
    Error Isolation & Fallbacks)]
- _Web Components:_ Browser-Nativ #hinweis[(Keine Framework-Abhängigkeit)]

== Entity Component System (ECS)
_Observer Pattern_ ist für _komplexe Interaktionen_ wegen Memory Leaks, Event Listener Explosionen, Event Storm
#hinweis[(viele Events durch viele Elemente)], Event Chain Debugging, unklarer State Synchronisation und
durch Tight Coupling _ungeeignet_. \
_ECS_ bietet zentrale Koordination #hinweis[(keine Event Listener nötig)], Performance Optimierung durch Spatial
Partitioning, Memory Effizienz #hinweis[(Keine Event Listener, keine Memory leaks)], einfaches Debugging, Skalierbarkeit
und direkte Manipulation.\
*Time-Based Architecture:*
Gut für Animationen & Physik, real-time Simulationen, 1000+ bewegende Objekte.\
*Drei Kernkomponenten:*
_Entity:_ ID-Nummer, _Component:_ Pure Daten wie Position, Velocity, Health.
_System:_ Logik. Verarbeitet Entities mit bestimmten Components. Objekte werden durch Komposition von Components definiert.
*Ablauf Game Loop:*
Alle Systems sequentiell durchlaufen, Entity mit passenden Components ausgewählt, System modifiziert Component,
nächstes System.

= Multiplattform-Frontends & .NET MAUI
#v(-0.5em)
== Multiplattform-Frontends
Multiplattform-Frameworks sollen _nativ-anfühlendes UI_ auf verschiedene Formfaktoren und Hardware mit
_unterschiedlichen_ (Design-)Anforderungen und Ressourcen bringen. Auch sollten die Features und der Use Case der
Plattform _angepasst_ werden #hinweis[(Mobile: Simpel, Desktop: Viele Features)].
Darum baut man besser _spezialisierte Apps_, anstatt eine universelle App mit Kompromissen.

*Konsequenzen für die Entwicklung:*
- _Dev Experience und Tooling:_ Hot Reload #hinweis[(Live Preview auf verschiedenen Plattformen)], Remote Debugging auf
  echten Geräten, Emulatoren #hinweis[(Performance-Unterschied)], Wechseln zwischen Targets, Build Times
  #hinweis[(separate Builds für jede Plattform)], Dependencies #hinweis[(Platform-spezifisch managen)]
- _Teststrategien und Herausforderungen:_ Plattformspezifische Integration Tests, End2End Tests #hinweis[(echte Geräte
    vs. Emulatoren)], Manuelles Testing jeder Platform, Device Fragmentation #hinweis[(5000+ Android Devices)],
  Support verschiedener OS Versionen, komplexe CI/CD #hinweis[(Builds und Integration Tests für jede Plattform)]
#colbreak()
- _Architektur und Maintenance:_ 60-80% shared code vs. 20-40% plattform-spezifisch, Abstraktion von Plattform APIs?,
  DI für Plattform-Services oder Conditionals #hinweis[(`if "iOS"`)]?, Updates auf mehreren OS, Breaking Changes,
  Technical Debt exponentiell mit vielen Plattformen
- _Performance:_ Native schnell, Multiplattform-FWs häufig langsam und gross

*Bei Code Sharing gilt: Je näher am OS/UI, desto schwieriger die Abstraktion.*
- _Gut teilbarer Code:_ Business-Logik, Datenmodelle & DTOs, API-Clients, State Management
  #hinweis[(ViewModels, Stores, Services)], Utilities #hinweis[(Formatierung, Parsing, Caching)].\
- _Schlecht teilbarer Code:_ Plattform-spezifische Features #hinweis[(Kamera, Biometrie)], Native UI Elemente,
  Betriebssystem APIs, UI/UX Patterns #hinweis[(Navigation, Menüstruktur)]

#table(
  columns: (1.1fr, 1fr),
  table.header([Native UI Approach], [Unified UI Approach]),
  [
    UI Komponenten werden _abstrahiert_ und auf die nativen Controls der Plattform gemapped.
    #plus-list[
      + Echtes Plattform Look & Feel
      + UI automatisch vom OS angepasst #hinweis[(z.B. iOS Liquid Glass-Update)]
      + Kleinere App-Grösse #hinweis[(20-40MB)]
      + Zugriff plattformspezifische APIs
    ]
    #v(-0.5em)
    #minus-list[
      + Unterschiedliches UI pro Plattform
      + Weniger UI Kontrolle
      + Starke Framework-Abhängigkeit
    ]
  ],
  [
    UI Komponenten werden in einer eigenen Rendering-Engine gerendert.
    #plus-list[
      + Einheitliches Look & Feel überall
      + Volle Kontrolle über UI/UX
      + Oft bessere Animations-Performance
    ]
    #v(-0.5em)
    #minus-list[
      + Grössere App #hinweis[(10-200MB)]
      + Plattform-Updates verzögert
      + Fühlt sich nicht nativ an
    ]
  ],
)

Durch Frameworks wird _Abstraktion_ der Plattform und des UX, eine _gemeinsame Codebase_ und _einheitliches_ Tooling
versprochen. In der Realität hat man oft _Framework-Abhängigkeiten_, _Abstraktions-Grenzen_ #hinweis[(nicht alle
  Features abbildbar)], Bindung an Update-Zyklen und Debugging-Komplexität. Die Verwendung ist ein Trade-off zwischen
_Developer Convenience_ und _Plattform-Flexibilität_.

_Native UI Frameworks:_ .NET MAUI, React Native, Qt, Kotlin Multiplat., Swift UI\
_Unified UI Frameworks:_ Flutter, Avalonia UI, Uno Plattform, Electron, Tauri, .NET MAUI Blazor Hybrid

== UI-Prinzipien
#v(-0.25em)
==== Klassisches Imperatives UI
Beschreibt, wie UI _aufgebaut_ wird, _manuelle_ Objekterstellung und Konfiguration, _explizite_ Event-Handler
Registrierung, direkte _State-Mutation_ erlaubt, Schritt-für-Schritt Konstruktion, keine automatische Reaktivität.\
_Beispiele:_ Windows Forms, Java Swing, iOS UIKit, GTK.

```java
JPanel panel = new JPanel();                                      // Java Swing
panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
JLabel label = new JLabel("Hello World");
label.setFont(new Font("JetBrains Mono", Font.PLAIN, 24));
label.addActionListener(e -> {/*...*/}); panel.add(label);
```

==== XML-basierendes Imperatives UI
Reine _Markup-Sprache_ #hinweis[(nicht alleine ausführbar)], _getrennt_ von Logik #hinweis[(Code Behind)],
keine eingebetteten Expressions, _statische Struktur_ zur Design-Zeit, Plattform-spezifische _XML-Dialekte_,
Tooling-Support #hinweis[(z.B. Visual Studio Designer, IntelliSense)].\
_Beispiele:_ XAML #hinweis[(WPF/MAUI)], Android XML, Java FX FXML, XUL, Glade

```xml
<LinearLayout android:orientation="vertical">                <!--Android XML-->
 <TextView android:text="Hello World" android:textSize="24sp" />
 <Button android:text="Start" android:onClick="onButtonClick" /></LinearLayout>
```

==== Template-basierendes Deklaratives UI
HTML-Templates mit _Framework Directives_, Logik _separiert_, Template-Expressions möglich, _Two-Way Data Binding_ oft
unterstützt, _reaktive_ Updates #hinweis[(Template re-rendert bei State-Änderung)]. _Beispiele:_ Angular, Vue.js

```js
@Component({                                               // Angular Component
 selector: 'app-example',
 template: `<div><h1 [style.fontSize.px]="24">Hello There</h1>
 <button (click)="onClick()">Start</button>
 <ul><li *ngFor="let i of items">{{ i }}</li></ul></div>`})

export class ExampleComponent {
  items = ['Nina', 'Jannis']; // Get placed in the for-loop above
  onClick() {/* ... */} }
```

==== Code-basierendes Deklaratives UI (modern)
In Programmiersprache _eingebettet_, kann Expressions und Logik _inline_ enthalten, _reaktive_ Updates
#hinweis[(UI reflektiert State)], _Side Effects_ erlaubt, Stateful Components #hinweis[(`useState`, `State<T>`)], Component
Composition, UI und Logik können _gemischt_ werden. _Beispiele:_ Flutter, Swift UI, Jetpack Compose, React, SolidJS,
Svelte.

```dart
Column(                                         // Flutter (Dart (JVM-basiert))
 children: const [Text('UIPain!', style: TextStyle(fontSize: 24)),
   ElevatedButton(onPressed: null, child: Text('Click Me')),],)
```

#pagebreak()

==== Rein funktionales Deklaratives UI
Rein _funktionale_ Paradigmen, _Immutable_ State #hinweis[(keine Objektmutationen)], Strikte _Typsicherheit_ zur
Compilezeit, _Unidirectional_ Data Flow, _Seiteneffekte_ im Typensystem #hinweis[(Elm: Commands, Haskell: Monads)],
keine impliziten Seiteneffekte in View-Funktionen. Elm: Garantiert keine Runtime Exceptions.\
_Beispiele:_ Elm, Reflex-DOM #hinweis[(Haskell)]

```hs
view :: MonadWidget t m  => Dynamic t Model -> m ()     -- Reflex-DOM (Haskell)
view model = el "div" $ do
    el "h1" $ dynText $ fmap (const "Hello World") model
    button <- button "Click Me"
    pure ()
```

== Was ist .NET MAUI?
Microsoft .NET MAUI (Multiplatform App UI) wurde 2022 als Nachfolger von Xamarin.Forms mit .NET 6 eingeführt
#hinweis[(Aktuell ist .NET 10)].
_Zweck:_ Vereinheitlichung der Cross-Plattform-Entwicklung mit einem einzigen Projekt für alle Plattformen
#hinweis[(Write once, run anywhere)]. Wie alle .NET-Sprachen verwendet es _nuget_ als Paketmanager. MAUI basiert auf
dem _MVVM-Prinzip_ #hinweis[(siehe @mvvm)].
_Vorteile_: Abstrahierte UI-Komponenten, Hot Reload, Native OS-/Hardwarezugriffe. MAUI unterstützt nativ Android,
iOS, Windows, macOS und Web #hinweis[(Linux jedoch nicht)].

Das UI wird durch _XAML_ definiert, eine deklarative Sprache basierend auf _XML_, die zusammen mit C\# zu UI Elementen
kompiliert wird. Es ermöglicht die _Trennung_ von Layout und Code. Je nach Framework gibt es andere XAML Dialekte, MAUI
verwendet _MAUI XAML_. Die XAML-Baumstruktur ist auch über C\# definierbar, aber XAML ist oft _leichtgewichtiger_ und
kürzer, insbesondere bei Verschachtelungen.\
Neben dem klassischen .NET MAUI gibt es _.NET MAUI Blazor Hybrid_, ein Unified UI Web-Framework, welches in WebView
#hinweis[(Chromium)] gerendert wird. Durch die Verwendung von Blazor kann C\# anstatt JS für Client-Code verwendet
werden. Es wird _kein WebAssembly verwendet_, darum ähnliche Performance wie nativer .NET-Code.
WebDev-Tooling verfügbar #hinweis[(Hot Reload, Browser Dev Tools)].

== Aufbau
==== Startup eines MAUI-Programms
`Platforms -> MAUI Program -> App -> App Shell -> Main Page`

==== Dateien in einem MAUI-Projekt
- _`Platforms`-Ordner:_ Plattform-spezifischer (Startup-)Code
- _`Resources`-Ordner:_ Von allen Plattformen verwendete Ressourcen
- _`App.xaml`:_ Einstiegspunkt in MAUI-Applikation
- _`AppShell.xaml`:_ Definition der visuellen Hierarchie mittels Shell (optional)
  #hinweis[(z.B. Pages, Flyoutmenüs, Tabs etc.)]
- _`MainPage.xaml`:_ Inhalt des ersten Fensters der App
- _`MainPage.xaml.cs`:_ Code-Behind C\#-Code der Main Page
- _`MauiProgram.cs`_: Bootstrapping der MAUI-Applikation #hinweis[(Builder)]

==== Zusammensetzung einer Main Page (Drei `partial`-Klassen)
- _XAML-Markup:_ Definiert die UI-Elemente als hierarchischer Baum mit Bindings und Ressourcen. Wird zu C\# kompiliert.
- _C\# Code-Behind:_ Die Logik hinter den UI-Elementen #hinweis[(z.B. Event-Handler)]
- _Generierter C\# Code:_ Verknüpft die XAML-Elemente mit dem Code-Behind, generiert entsprechende Felder

#image("img/maui_compilation.png")

= XAML
Die _Extensible Application Markup Language (XAML)_ ist eine XML-basierende Beschreibungssprache zur _Gestaltung_
grafischer Oberflächen. Sie ist _hierarchisch_ als Baum strukturiert. Durch sie lässt sich Layout und Code voneinander
trennen. Es gibt _kein "standardisiertes" XAML_, stattdessen hat jedes Framework seinen eigenen XAML-Dialekt.

*UI im Code Behind laden:*
#v(-0.5em)
```cs
public partial class MainPage : ContentPage {
  public MainPage() {
    InitializeComponent(); // With XAML, you only need this line
    // If you want to use Imperative UI (Code will override XAML):
    var button = new Button { Text = "OK", WidthRequest = 60, Margin = 5 };
    var label = new Label { /*...*/ };
    var stackLayout = new VerticalStackLayout { label, button };
    this.Content = stackLayout;
}}
```

== XAML Trees
#grid(
  columns: (1fr, 0.7fr),
  [
    Das XAML kann als _zwei verschiedene Trees_ angezeigt werden. Diese Trees funktionieren ähnlich wie der _DOM_ auf
    Webseiten.

    Ein _`StackLayout`_ mit 2 Labels besteht aus 3 Logischen Elementen, hat aber je nach Platform 10+ native Views.
    Beispielsweise hat ein Button auf Android 3 native Views:\ `ButtonHandler`$->$`MaterialButton`$->$`TextView`

  ],
  align(center, image("img/xaml_trees.png")),
)

*Visual Tree (grün + blau):*
Vollständiger, visuell dargestellter Baum. Ist _Plattformspezifisch_ #hinweis[(abhängig von Handler & nativen Controls)]
und enhält automatisch generierte Knoten #hinweis[(Templates, Wrappers)].
_Verwendung:_ Layout-Debugging #hinweis[(Warum wird ein Element nicht angezeigt?)], Performance-Analyse
#hinweis[(Wie viele native Views werden erstellt?)], Handler-Probleme #hinweis[(MAUI Control-zu-native View-Mapping)].\
*Logical Tree (grün):*
Nur explizit definierte XAML-Elemente. _Plattformunabhängig_. Die Grundlage für Ressourcen, BindingContext und Navigation.
_Verwendung:_ Ressourcen-Lookup, BindingContext-Vererbung, Navigation & Hierarchie, Code-Operationen #hinweis[(`FindByName`)]

== XAML-Grundlagen
#v(-0.5em)
=== XML Namespaces
Mit dem _`xmlns`-Attribut_ auf dem Root-Element werden _Namespaces_ definiert. _Standard-Namespace:_ ohne Doppelpunkt
#hinweis[(Präfix optional)]\
_Benannter Namespace:_ mit Doppelpunkt #hinweis[(nur mit Präfix verwendbar)]
#v(-0.5em)
```xaml
<?xml version="1.0" encoding="utf-8" ?><Application
  xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
  xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
  xmlns:local="clr-namespace:UIP_Vorlesung_10"
  x:Class="Vorlesung_10.App"><!-- ... --></Application>
```

*Übliche Namespaces in MAUI:*
#v(-0.5em)
_`xmlns`:_ Standard-Namespace für MAUI-Control Library #hinweis[(Wenn nicht vorhanden, müssen MAUI-Elemente geprefixt
  werden)], _`xmlns:x`:_ XAML-spezifische Elemente, _`xmlns:local`:_ Eigene Controls/ViewModels aus dem Projekt,
_`x:Class`_: Name der Code-Behind-Klasse im Namespace `x` #hinweis[(Üblicherweise immer `x`, kann aber auch anders
  benannt werden)].

#v(-0.5em)
=== Named Elements
Elemente können _benannt_ werden. Ermöglicht Zugriff im Code-Behind. Attribut führt zum Property in der generierten
Klasse. MAUI kennt nur `x:Name`-Attribut.\
```xaml <Label x:Name="MyLabel" />``` Code Behind: ```cs this.MyLabel.Text = "El Töni";```

=== Event Handler
Reaktion auf Ereignisse der UI Controls. Methode wird im XAML registriert und im Code Behind implementiert.
Immer zwei Parameter: _`object`_: Auslöser des Events, _`EventArgs`_: Event-spezifische Argumente, abgeleitet
von `EventArgs`. *Achtung:* Gefahr von Top-Down Abhängigkeit!\
#v(-0.5em)
```xaml
<Button Clicked="OnClick" Text="Start" />
```
```cs
private void OnClick(object sender, EventArgs args) { /*...*/ }
```

=== Type Converter
Um Werte aus dem UI in andere Typen zu konvertieren, können eigene Typen-Konverter von `TypeConverter` abgeleitet
werden.
#v(-0.5em)
```xaml
<local:LocationControl Center="10, 20">
```
```cs
public partial class LocationControl : Label {                  // Code Behind
  public Location Center { set => this.Text = $"{value.Lat}/{value.Long}"; } }
```
```cs
[TypeConverter(typeof(LocationConverter))]                      // Data Model
public class Location {
  public double Lat { get; set; } public double Long { get; set; } }
```
```cs
public class LocationConverter : TypeConverter {
  public override object ConvertFrom(
    ITypeDescriptorContext ctx, CultureInfo culture, object value) {
    // Missing checks: Array contains 2 elems? Strings convertible to double?
    var valueAsString = (string)value;
    var valueArray = valueAsString.Split(',');
    return new Location { Lat = Convert.ToDouble(valueArray[0]),
      Long = Convert.ToDouble(valueArray[1]) } } }
```

=== Property Element vs. Attribute Syntax
#grid(
  [
    XAML kann mit der _Property Element Syntax_ oder der _Attribute Syntax_ geschrieben werden. Die Attribute Syntax ist
    kompakter, benötigt aber Type Converter #hinweis[(z.B. String `"Red"` zu `Color` konvertieren)]. Die Property
    Element Syntax wird für komplexe Objekte oder wenn kein Type Converter vorhanden ist verwendet.
    ```xaml
    <Label Text="Attribute Syntax" TextColor="Red" Background="Blue"/>
    ```
  ],
  [
    ```xaml
    <Label Text="Property Element Syntax">
      <Label.TextColor>
        <Color>Red</Color>
      </Label.TextColor>
      <Label.Background>
        <SolidColorBrush>
          <SolidColorBrush.Color>
            <Color>Blue</Color>
          </SolidColorBrush.Color>
        </SolidColorBrush>
      </Label.Background>
    </Label>
    ```
  ],
)
#v(-0.5em)

=== Content Properties
Jede _XAML-Klasse_ kann genau _eine Eigenschaft_ mit der `[ContentProperty()]`-Annotation als ihren Inhalt definieren.
Diese kann dann in verkürztem Syntax in das Element geschrieben werden.
#grid(
  columns: (1fr, auto),
  [
    ```xaml
    <MyLabel
      Text="Normales Property" />
    <MyLabel>Content Property
    </MyLabel>
    ```
  ],
  [
    ```cs
    // Annotation sets "main field"
    [ContentProperty(nameof(Text))]
    public class MyLabel : View {
      public string Text { get; set; } }
    ```
  ],
)

Elemente, welche andere Elemente enthalten, können ebenfalls via Content Property gesetzt werden, um die Lesbarkeit von
Beziehungen zu fördern.

#grid(
  columns: (auto, 1fr),
  gutter: 0.5em,
  [
    ```xaml
    <VerticalStackLayout>
      <Label Text="Inhalt" />
      <Label>Inhalt</Label>
    </VerticalStackLayout>
    <!-- Oben: Content Property Syntax
    Rechts: Property Element Syntax -->
    ```
  ],
  [
    ```xaml
    <VerticalStackLayout>
      <VerticalStackLayout.Children>
        <Label Text="Inhalt" />
        <Label>Inhalt</Label>
      </VerticalStackLayout.Children>
    </VerticalStackLayout>
    ```
  ],
)

=== Attached Properties
Das Setzen einer Eigenschaft auf einem Element, welche zu einem anderen Element gehört -- sie wird dem anderen Element
_angehängt_. Wird meist bei Layouts angewendet, diese müssen gewisse _Werte_ für die Gestaltung _kennen_. Die
Kind-Elemente definieren diese Werte. Fördert Lesbarkeit des XAML. Im Beispiel wird `Grid.Row` anstatt direkt auf `Grid`
auf den Children gesetzt. Equivalenter C\# Code: ```cs Grid.SetRow(R, 0); Grid.SetRow(G, 1); Grid.SetRow(B, 2)```
```xaml
<Grid RowDefinitions="3*,2*,1*" >
  <Label Grid.Row="0" x:Name="R" Background="Red" />
  <Label Grid.Row="1" x:Name="G" Background="Green" />
  <Label Grid.Row="2" x:Name="B" Background="Blue" /></Grid>
```

=== Markup Extensions
Erlauben es, Logik zur _Compile-Zeit_ in XAML einzubetten.\
*Syntax:* `{Präfix:Klassenname Property=Value}`.
*Spezialfälle:*
`{x:Null}`: Null-Wert, `{Binding Name}`: Data Binding, `{StaticResource ButtonStyle}`: Ressourcen-Lookup.
Eigene Extensions können durch Implementieren von `IMarkupExtension` erstellt werden.
_Verwendung:_ Übersetzungen, Formatierungen, Ressourcen-Lookup.
```xaml
<Label Text="{local:Translate Key='WelcomeMessage'}" />
```
```cs
public class TranslateExtension : IMarkupExtension {
  public string Key { get; set; }
  public object ProvideValue(IServiceProvider sp) {
    // Look up translation in resources
    return AppResources.ResourceManager.GetString(Key); } }
```

= GUI-Grundelemente in XAML
#hinweis[($->$ bedeutet: "Hat 1 oder mehr davon")]
#v(-0.5em)
#image("img/maui_basic_elements.png")

#figure(
  supplement: none,
  caption: [
    #hinweis[*Violett:* Basisklassen, *Weinrot:* Application & Window, *Grün:* Pages, *Rot:* Layouts,\
      *Blau:* Views & Controls, *Gelb:* Cells]
  ],
  image("img/maui_class_hierarchy.png"),
)

=== Basisklassen
Die abstrakten Basisklassen ergänzen schrittweise _weitere Funktionalität_. Sie stehen allen ableitenden GUI-Elementen
_zur Verfügung_. Nicht alle Klassen leiten alle Basisklassen ab und nicht alle GUI-Elemente besitzen alle Attribute
#hinweis[(Alle `View`-Klassen haben Margin, aber nur `Layout`-Klassen auch Padding)].\
*Klassen:*
- _`BindableObject`:_ Implementation von Data-Binding, Validierung, Typenkonvertierung und Events.
- _`Element`:_ Basisklasse für hierarchische Steuerelemente mit allen notwendigen Methoden und Eigenschaften.
- _`NavigableElement`:_ Unterstützt Navigation.
- _`VisualElement`:_ Bildschirm-Element, das Platz zur Anzeige erhält, visuelle Darstellung hat und Touch-Eingabe haben
  kann.
- _`View`:_ Visuelles Element zur Platzierung von Layouts und Steuerelementen.

== Application & Window
Die _Application_-Klasse legt über das _`MainPage`-Property_ den ersten Screen fest. Ebenfalls erzeugt und verwaltet sie
_Fenster_. Das _Hauptfenster_ wird via _`CreateWindow()`_, weitere Fenster über _`Application.Current.OpenWindow()`_
geöffnet #hinweis[(iOS unterstützt kein Multiwindowing)]. Um auf _Window-Lifecycle-Events_
#hinweis[(Window erstellt/geschlossen)] zuzugreifen muss `CreateWindow()` überschrieben werden
#hinweis[(`Application`-Lifecycle-Methoden sind seit MAUI 9 deprecated)]. Die Application-Klasse ermöglicht die zentrale
Verwaltung von App-weiten XAML-Ressourcen.

```cs
public partial class App : Application {
  public App() { InitializeComponent(); MainPage = new FirstPage();}
  // Zugriff auf Window für Konfiguration & Events
  protected override Window CreateWindow(IActivationState activationState) {
    var window = base.CreateWindow(activationState);
    window.Title = "Name des Fensters"; // Fenster konfigurieren
    // Window-Lifecycle-Events abonnieren
    window.Created += (sender, eventArgs) => { /* ... */ };
    window.Activated += (sender, eventArgs) => { /* ... */ };
    return window; } }
```
#v(-0.5em)
=== Lifecycles
#grid(
  [
    MAUI leitet wichtige _Lifecycle-Events_ der darunterliegenden Plattformen auf _Window-Ebene weiter_.
    Im Multi-Window-Modus hat jedes Window seinen eigenen Lifecycle. Lifecycle-Events sind nur auf der Window-Ebene
    verfügbar.
  ],
  image("img/maui_lifecycle.png"),
)

#v(-0.5em)

== Pages
#grid(
  [
    Elemente zur _Strukturierung_ und _Gestaltung_ ganzer Screens. Sie füllen normalerweise ihre Eltern-Windows
    vollständig aus. _Verschachtelung_ von Pages ist üblich #hinweis[(z.B. `ContentPage` innerhalb von `NavigationPage`
      oder `TabbedPage`)].
  ],
  image("img/maui_pages.png"),
)
#v(-0.5em)

- _`ContentPage`:_ Leerer Screen ohne Zusatzelemente
- _`FlyoutPage`:_ Slide-in Menu von Links #hinweis[("Hamburger-Menu")]
- _`NavigationPage`:_ Hierarchische Navigation mit Toolbar
- _`TabbedPage`:_ Wechsel zwischen Inhalten mit Tabs

#v(-0.5em)
*Hauptgrund Verwendung von Page Typen:* Verschiedene Arten zu navigieren.

=== NavigationPage
Die Navigation kann auf 3 verschiedene Arten eingerichtet werden:
+ _`Application.MainPage`:_ Austausch der angezeigten Page, genügt für sehr einfache Apps
+ _`NavigableElement.Navigation`:_ Erlaubt hierarchische Navigation #hinweis[(Stack)], Modale Navigation
  #hinweis[(Benutzer kann nicht zur vorherigen Seite zurückkehren, ohne sie zu schliessen)], funktioniert immer,
  Mode-less nur mit `NavigationPage`
+ _Shell:_ Navigation auf Basis von URIs, viele Eigenheiten und Spezialfälle

```cs
// Option 1: App.xaml.cs
public partial class App : Application {
  public App() { InitializeComponent();
    MainPage = new NavigationPage(new FirstPage());  } }
```
```cs
// Option 2: FirstPage.xaml.cs
private async void NextPage(object s, EventArgs e) {
  await Navigation.Push(new SecondPage()); }
// Option 2: SecondPage.xaml.cs
private async void PrevPage(object s, EventArgs e) {
  await Navigation.PopAsync(); }
```

#grid(
  columns: (1fr, 1fr),
  [
    === Tabbed Page
    Erstellt standardmässig eine Tab-Leiste oben im Fenster.
  ],
  image("img/maui_tabs.png"),
)

```xaml
<TabbedPage>
  <ContentPage Title="Tab 1" IconImageSource="i1.png" />
  <ContentPage Title="Tab 2" IconImageSource="i2.png" />
  <ContentPage Title="Tab 3" IconImageSource="i3.png" />
</TabbedPage>
```

=== Flyout Page
#grid(
  columns: (1fr, 1.2fr),
  [
    Die NavigationPage im XAML ist nötig, damit auf Android eine _Navigation Bar_ inklusive Menü-Icon dargestellt wird.
    Passt sich nach OS grössenabhängig an. Bei wenig Platz erscheint oben links ein Menü-Icon fürs Ein-/Ausklappen.
    #image("img/maui_flyout.png", width: 100%)
  ],
  [
    ```xaml
    <FlyoutPage>
      <FlyoutPage.Flyout>
        <ContentPage Title="Menu">
            <Label Text="Menu" />
        </ContentPage>
      </FlyoutPage.Flyout>
      <FlyoutPage.Detail>
        <NavigationPage>
          <x:Arguments>
            <ContentPage Title="Inhalt">
              <Label Text="Inhalt" />
            </ContentPage>
          </x:Arguments>
        </NavigationPage>
      </FlyoutPage.Detail>
    </FlyoutPage>
    ```
  ],
)

== Layouts
#grid(
  [
    Elemente zur _Ausrichtung_ und _Gruppierung_ von Views. Layouts sind Container für Kind-Elemente: Parent-Child
    Beziehung #hinweis[(Composite Design-Pattern)], Verschachtelung möglich.
  ],
  image("img/maui_layouts.png", width: 100%),
)
- _`StackLayout`:_ Horizontale oder Vertikale Anordnung
- _`FlexLayout`:_ Ähnlich wie Stack, mit Wrapping & mehr Gestaltung
- _`Grid`:_ Anordnung in Zeilen und Spalten
- _`AbsoluteLayout`:_ Absolute oder proportionale Anordnung im Layout

=== Stack Layout
Das `StackLayout` existiert aus _Kompatibilitätsgründen_ mit _Xamarin_. In .NET MAUI sollten die optimierten Ableitungen
verwendet werden. Abgesehen von fehlenden Orientation-Attribut funktionieren sie gleich.

```xaml
<StackLayout Orientation="Horizontal"></StackLayout> <!-- Legacy -->
<StackLayout Orientation="Vertical"></StackLayout> <!-- Legacy -->
<VerticalStackLayout></VerticalStackLayout> <!-- Optimierte Ableitung -->
<HorizontalStackLayout></HorizontalStackLayout> <!-- Optimierte Ableitung -->
```

=== Grössenangaben für Views
Vertical Stacks verwenden `HorizontalOptions` und umgekehrt für die Platzierung der Kinder. Grössenangaben auf Views
#hinweis[(`WidthRequest`/`HeightRequest`)] sind optional, sonst so gross wie nötig dargestellt. Die Grössenangaben sind
_Device-independent Units_ #hinweis[(50 doppelt so gross wie 25)]. Alle Grössenangaben sind Wünsche an die Rendering
Engine #hinweis[(`MinWidthRequest` $<=$ `WidthRequest` $<=$ `MaxWidthRequest`)]

*Gültige Werte für `HorizontalOptions`/`VerticalOptions`:*\
_Start_ #hinweis[(links/oben)], _Center_ #hinweis[(zentriert)], _End_ #hinweis[(rechts/unten)],
_Fill_ #hinweis[(Füllt  den verfügbaren Platz)]\
*Verfügbarkeit Padding/Margins:*
_Pages_ #hinweis[(nur Padding)], _Layouts_ #hinweis[(Padding & Margin)],
_Views_ #hinweis[(Padding & Margin wo sinnvoll)]\
*Gültige Padding/Margins:*
_`n`_ #hinweis[(Gleicher Wert für alle Seiten)], _`x,y`_ #hinweis[(horizontal/vertikal)],
_`l,t,r,b`_ #hinweis[(Left, Top, Right, Bottom -- Achtung: anders als in CSS!)]


```xaml
<VerticalStackLayout>
 <Label Text="K1" HorizontalOptions="Start"><!-- ... --></VerticalStackLayout>
```

=== Flex Layout
Flexible Variante des Stack Layouts #hinweis[(Komplizierter & Langsamer)].
*Wichtige Eigenschaften:*
_`Direction`_ #hinweis[(Richtung der Kinder)], _`Wrap`_ #hinweis[(Automatischer Umbruch)],
_`JustifyContent`_: #hinweis[(Verteilung in Hauptrichtung)], _`AlignItems`_ #hinweis[(Verteilung in Nebenrichtung)]\
```xaml <FlexLayout Direction="Row" Wrap="Wrap"></FlexLayout>```

=== Grid Layout
Erlaubt _Stapelung_ von Elementen #hinweis[(mehrere Elemente innerhalb einer Zelle)].\
Abstand zwischen Zellen #hinweis[(`ColumnSpacing`)] und Reihen #hinweis[(`RowSpacing`)] sowie Verbindung zwischen Zellen
#hinweis[(`ColumnSpan`)] und Reihen #hinweis[(`RowSpan`)] möglich.\
*Spezial-Werte:*
_`*`_ #hinweis[(Rest des Platzes)], _`N*`_ #hinweis[(Proportionaler Anteil an Gesamtfläche)],\
_`Auto`_ #hinweis[(Anpassen auf die Children, rechenaufwändig)].

```xaml
<Grid><Grid.RowDefinitions>
  <RowDefinition Height="1*" /><RowDefinition Height="2*" />
  <RowDefinition Height="3*" /></Grid.RowDefinitions>
<!-- Same for ColumnDefinitions. "Grid.Row" = Attached Property -->
<Label Grid.Row="0" Grid.Column="0" /> <!--Same for others--> </Grid>
```

Die Definition kann auch direkt in `Grid` erledigt werden:
#v(-0.5em)
```xaml
<Grid RowDefinitions="50,Auto,*" ColumnDefinitions="*,*,*" ></Grid>
```

=== Absolute Layout
Oft verwendet, um _Overlays_ zu gestalten. Zwei Varianten:
_1) Absolute Werte:_ Positionierung ab linker, oberer Ecke. Selten verwendet wegen Gerätevielfalt,
_2) Proportionale Werte:_ Bezug auf Grösse des Elternelements, kombinierbar mit absoluten Werten.
_LayoutBounds_-Property: Abstand linker Rand, Abstand oberer Rand, Element-Breite, Element-Höhe

```xml
<AbsoluteLayout LayoutBounds="20,10,60,20">Absolut</AbsoluteLayout>
<AbsoluteLayout LayoutBounds="0.5,0.5,0.5,0.5">Proportional</AbsoluteLayout>
```

== Views / Controls
Elemente, die _interagierbar_ sind. Alle Views erben von `VisualElement`.\
*Gemeinsame Eigenschaften:*
_Aussehen_ #hinweis[(`BackgroundColor`, `Opacity`)],
_Zustand_ #hinweis[(`IsVisual`, `IsEnabled`)],
_Grösse_ #hinweis[(`Margin`, `WidthRequest`, `HeightRequest`)],
_Transformationen_ #hinweis[(`Rotation`, `Scale`, `Translation`)]\
*Arten von Views*
- _Display Views:_ Nur Anzeige von Infos, keine Interaktion #hinweis[(Label, Image)]
- _Interactive Views:_ Benutzereingaben, lösen Events aus #hinweis[(Button, Entry)]
- _Container Views:_ Enthalten andere Views, erweitern Funktionalitäten von Kind-Elementen
  #hinweis[(ScrollView, Border)]

=== Events
Views unterstützen verschiedene Events:
_Tippen_ #hinweis[(`Tapped`)], _Fokusänderungen_ #hinweis[(`Focused`, `Unfocused`)],
_Eigenschaft-Änderungen_ #hinweis[(`PropertyChanged`)], _Grössen-Änderungen_ #hinweis[(`SizeChanged`)].
Viele Views haben zusätzlich eigene Events:
`Button` #hinweis[(`Clicked`, `Pressed`, `Released`)], `Entry` #hinweis[(`TextChanged`, `Completed`)],
`Switch` #hinweis[(`Toggled`)].

=== Collection Views
Inhalte _variablen Umfangs_ darstellen.
*Arten:*
_`ListView`_ #hinweis[(Einfache Listen)], _`TableView`_ #hinweis[(Gruppierte  Listen)],
_`Picker`_ #hinweis[(Auswahl: 1 von N)], _`CarouselView`_ #hinweis[(Horizontales Swiping)].\
*Wichtige Properties:*
_`ItemsSource`_ #hinweis[(darzustellende Collection)], _`ItemTemplate`_ #hinweis[(Darstellung einzelner Items,
  meist via `ItemTemplate.DataTemplate`)], _`ItemsLayout`_ #hinweis[(Linear/Grid Layout)],
_`SelectionMode`_ #hinweis[(Anzahl auswählbarer Elemente: `None`, `Single`, `Mutiple`)]

== Plattformspezifische Anpassungen
Unterschiedliche UIs nach Plattform mit _`OnPlatform`_ #hinweis[(nach OS)] und _`OnIdiom`_ #hinweis[(nach Gerätetyp)].
Default-Wert sollte immer gesetzt werden.
*Anwendungsfall:*
Verschiedene Controls je nach Plattform #hinweis[(nur mit Property Element Syntax)]
- _`OnPlatform`:_ `iOS`, `Android`, `MacCatalyst`, `WinUI` #hinweis[(Compile-Time Definition)]
- _`OnIdiom`:_ `Phone`, `Desktop`, `Tablet`, `TV`, `Watch` #hinweis[(Runtime Definition)]

```xaml
<Label Text="{OnIdiom 'Default', Phone='On a Phone'}" />
<OnPlatform x:TypeArguments="View">
  <On Platform="iOS"><Label Text="iOS gets Label"/></On>
  <On Desktop><Button Text="Desktop gets Button"</On></OnPlatform>
```


= .NET MAUI Design
Das Aussehen von Views wird über Attribute beeinflusst.

== Bilder
In `Resources/Images` _JPG_, _PNG_ oder _SVG_ ablegen. SVGs werden in PNG konvertiert #hinweis[(schnelleres Rendering &
  bessere Grössenanpassungen für verschiedene DPIs)]. `Image` kann auch GIF-Animationen anzeigen, Web-Bilder
#hinweis[(inkl. Lade-Indikator & Caching)] und Bilder aus DLLs/Assemblies und Byte Arrays laden.
Aus App Icon & Splash Screen werden _plattformspezifische_ Elemente automatisch _erzeugt_.\
*Aspect kontrolliert Skalierung:*
_`AspectFit`_ #hinweis[(Bildverhältnis beibehalten)],
_`AspectFill`_ #hinweis[(Fläche füllen, Verhältnis beibehalten)],
_`Fill`_ #hinweis[(Fläche füllen, Bildverhältnis ignorieren)],
_`Center`_ #hinweis[(gemäss Originalgrösse zentriert darstellen)]\
*Dateinamen:*
Lowercase, alphanumerisch und mit Underscores.\
```xaml <Image Source="ost_logo_v1.svg" Aspect="AspectFit" />```

== Schriften
In `Resources/Fonts` _TTF/OTF-Datei_ ablegen. Muss im `Builder` registriert werden. Danach im XAML mit `FontFamily`
setzbar. OS spezifische Schriftgrösse wird auf alle Views mit Text angewendet. _Icons_ in Schriftarten
#hinweis[(z.B. FontAwesome)] mit `FontImageSource` verwenden.
```cs
var builder = MauiApp.CreateBuilder();
builder.UseMauiApp<App>().ConfigureFonts(fonts => {
 fonts.AddFont("JetBrains-Mono.ttf", "JetBrainsMono") });
```
```xaml
<Label Text="print('Hello World!')" FontFamily="JetBrainsMono" />
```

== Farben
Meist mehrere Varianten, wie Farbe zugewiesen werden kann #hinweis[(z.B. Label: Background (Brush), BackgroundColor
  (Color))]. _`Color`_ enthält Farbe, _`Brush`_ Farbverläufe. `Color` wird intern zu `SolidColorBrush` umgewandelt.
Brush hat Subtypen wie `LinearGradientBrush`.
#v(-0.5em)
```xaml
<Label Text="Brush"><Label.Background>
  <LinearGradientBrush StartPoint="0,0" EndPoint="0,1">
  <GradientStop Offset="0.0" Color="#6E1C50" />
  <GradientStop Offset="0.5" Color="#AE5C90" />
</LinearGradientBrush></Label.Background></Label>
```

== Animationen
Alle _`VisualElement`_-Objekte unterstützen: `Fading`, `Scale`, `Rotate`, `Translate`. Es können variable
Zeitdauern & Easing angewendet werden #hinweis[(Default: 250ms & linear)].

== Rahmen & Schatten
_`Border`_ #hinweis[(Container Control)] zeichnet Rahmen & Hintergründe. Ermöglicht Formen, Farbverläufe, Linienmuster,
Padding. Schatten werden über _`Shadow`_ gesetzt. _`StrokeShape`_ beschreibt geometrische Formen.
#v(-0.5em)
```xaml
<Border StrokeShape="RoundRectangle 20,20,20,20"><Border.Shadow>
  <Shadow Brush="White"></Border.Shadow></Border>
```

== Ressourcen
_Beliebiges Objekt_, das in XAML definiert werden kann #hinweis[(Brush, Color etc.)].
Besitzt `x:Key` zur Identifikation. _Ziel: Wiederverwendung_.\
`VisualElement.Resources` = lokal, `Application.Resources` = global.
- _Statische Resourcen `{StaticResource Key}`:_ Einmalige Auswertung beim Laden der Page, Dictionary-Lookup zur Runtime.
  Schneller als Dyn. Resourcen.
- _Dynamische Resourcen `{DynamicResource Key}`:_ Wiederholte Auswertung, Behählt Link zum Dictionary Key zur Laufzeit.
  Reagiert auf Änderungen im Dict.
Die gleiche Resource kann je nach Bedarf sowohl mit `StaticResource` als auch mit `DynamicResource` referenziert werden.\
*Suchreihenfolge:*
Aktuelles Element $->$ Parent-Elemente $->$ `Application. Resources`. Suche bricht beim ersten Treffer ab.\
Schlüssel _nicht gefunden_: Ignoriert #hinweis[(XAML)], Exception #hinweis[(C\#)].

```xaml
<ContentPage><ContentPage.Resourcs>
  <SolidColorBrush x:Key="OSTBrush">
</ContentPage.Resources></ContentPage>
<Label Background="{StaticResource Key=OSTBrush}" />
```
```cs
var brush = Resources["OSTBrush"] as Brush;
```
#v(-0.5em)
=== Resource Dictionaries
Ressourcen können in einem _Resource Dictionary_ gespeichert werden. Code-Behind optional. Nimmt alle XAML-Elemente auf.
Basistypen können im XAML definiert werden, mit entsprechendem Import. Kann mit anderen Dictionaries gemerged werden.
Wird entweder in `Application.Resources`, `VisualElement.Resources` oder als eigenständige `.xaml`-Datei definiert.\
*Priorität bei Schlüsselkollisionen:* 1. Lokale Resources 2. Merged Resources #hinweis[(Später definierte Merges
  überschreiben frühere Merges!)]

```xaml
<!-- MyDict.xaml, import namespaces for C# types -->
<ResourceDictionary xmlns:s="clr-namespace:System;assembly=System.Runtime">
  <s:Double x:Key="Margin">2</s:Double></ResourceDictionary>
<!-- MainWindow.xaml -->
<ResourceDictionary><ResourceDictionary.MergedDictionary>
  <ResourceDictionary Source="MyDict.xaml">
</ResourceDictionary></ResourceDictionary.MergedDictionary>
<Label Margin="{StaticResource Margin}" />
```

=== Statische Werte
Mit _`x:static`_ kann auf C\#-Konstanten zugegriffen werden. _Keine Ressourcen!_
#v(-0.5em)
```cs
public static class MyRes {
  public static SolidColorBrush B3 = new (Color.FromArgb("FFFF")); }
```
```xaml
<ContentPage xmlns:local="clr-namespace:Resources.Examples">
  <Label Background="{x:Static local:MyRes.B3}"></ContentPage>
```

== Styles
Ressourcen können Werte _zentral_ verwalten, sie müssen aber immer noch bei _jedem_ Element _referenziert_ werden.
Styles können Properties _gruppieren_ und auf Elemente anwenden.
*Zwei Arten der Zuweisung:*\
_1) Explizit:_ `x:Key` auf Style, `Style="{StaticResource MyStyle}"` auf gewünschtem Element setzen
#hinweis[(MyStyle = `x:Key`)].
_2) Implizit:_ `TargetType="Button"` gibt an, für welche Element-Typen der Style gilt. Ohne `x:Key` wirkt der Style
für alle Elemente dieses Typs. _Inline-Attribute_ können Styles _überschreiben_. Styles können mit _`BasedOn=""`_
_vererbt_ werden.

=== MauiCSS
Auch mit _CSS_ können Elemente gestylt werden. Einbinden über `<StyleSheet>` in `<Application.Resources>`, Zuweisung mit
`StyleClass=""`. Die Build-Action der CSS-Datei muss auf _`MauiCSS`_ gesetzt werden. Kann nicht alles, was XAML kann und
auch nicht alles, was reguläres CSS kann #hinweis[(keine Media-Queries oder `px`-Anweisungen)]. Kann auch direkt in XAML
geschrieben werden:
#v(-0.5em)
```xaml
<StyleSheet><![CDATA[^contentpage { color: red; }]]></StyleSheet>
```

== Theming
Mit der _`AppThemeBinding` Markup-Extension_ kann nach Light- und Darkmode unterschieden werden. Auch kann ein
Default-Wert #hinweis[(OS gibt kein Theme vor)] gesetzt werden #hinweis[(Erster Wert ist Default, wenn nicht gesetzt)].\
```xaml <Label TextColor="{AppThemeBinding Light=Black Dark=White}">Hi!</Label>```\
Mit _`Application.Current.RequestedTheme`_ kann das aktuelle Theme ausgelesen werden,
_`Application.Current.RequestedThemeChanged`_ ist der Event für den Theme-Wechsel. _`Value`_ gibt Ressource zurück, die
derzeit verwendet wird.\
Das _eingebaute Theming_ ist _unflexibel_: Kein Laden von Resource Dictionaries, kein OS-unabhängiges Theme ladbar.
Muss also selber gebaut werden:
+ _Mehrere Resource Dictionaries_ mit identischen Keys #hinweis[(z.B. `Light.xaml` & `Dark.xaml`)]
+ Laden des Standard-Themes als _Merged Dictionary_
+ Zugriff auf alle Ressourcen via _`DynamicResource`_
+ Laden eines neuen Dictionaries beim Wechsel des Themes
Ergibt saubere Trennung der Ressourcen, bei Wechsel können aber Controls kurz flackern, nur aktueller VisualTree wird
aktualisiert. Die Markup Extension _`AppThemeBinding`_ passt das Theme automatisch am dem OS an.

== Custom Controls
Es gibt 4 verschieden komplexe Stufen zur eigenen Erstellung von Controls:
#v(-0.75em)

=== Stufe 1: Eigene Controls definieren
_Leere Ableitung_ von MAUI-View, die alle Attribute der Basisklasse übernimmt. Eigene Attribute möglich. Verwendung via
Klassennamen nach Import des Namespaces im XAML #hinweis[(`xmlns:cc="clr-namespace:V_13.CustomControls"`)]. Präfix wie
gewohnt frei wählbar. Auch als Typ für implizite Styles möglich.\
```cs public class AlertLabel : Label { /* Empty */ } ```

=== Stufe 2: Darstellung via Custom Templates verändern
Die _visuelle Repräsentation_ der View soll _kontrolliert_ werden um z.B. Labels abgerundete Ecken zu geben.
Dafür gibt es _Control Templates:_ Die View muss _von `ContentView` ableiten_ und alle Inhalte im XAML in
_`<ContentView.ControlTemplate><ControlTemplate>`_ gepackt werden. Mit _`ControlTemplates`_ ist die Struktur im XAML
ohne Anpassung der gesamten Control-Klasse _austauschbar_.

==== Bindable Property
Um eigene Daten auf der View zu definieren, muss ein _Bindable Property_ verwendet werden, normale .NET Properties
funktionieren nicht. Diese können im XAML mit _`Text="{TemplateBinding Message}"`_ verwendet werden. Wird das Property
geändert, werden auch die entsprechenden UI-Elemente angepasst. Können nur auf Control Templates verwendet werden und
keine ganzen XAML-Elemente darstellen.

```xaml
<!-- ControlTemplate.xaml -->
<ContentView><ContentView.ControlTemplate><ControlTemplate>
  <Border StrokeShape="RoundRectangle 10,10,10,10">
  <Label Text="{TemplateBinding Message}" /></Border>
</ControlTemplate></ContentView.ControlTemplate></ContentView>
```
```cs
public static readonly BindableProperty MessageProperty =
  BindableProperty.Create(
    nameof(Message),  // Name of property
    typeof(string),   // Type of property
    typeof(AlertBox), // Type the property should belong to
    string.Empty);    // Initial value
public String Message { get => (string)GetValue(MessageProperty);
  set => SetValue(MessageProperty, value); }
```
```xaml
<ContentPage xmlns:cc="clr-namespace:V_13.CustomControls">
    <cc:AlertBox Message="Box 1" /> <!-- Bindable Property used here -->
    <cc:AlertBox Message="Box 2" /></ContentPage>
```

=== Stufe 3: Inhalt mit Content Presenter anzeigen
_`ContentPresenter`_ ist ein _Platzhalter_ für beliebige XAML-Elemente in Control Templates. Gibt den Inhalt von
_`Content`_ aus. Ermöglicht _Verschachtelung_ in Custom Controls. Nötig, weil in `ControlTemplate` nicht auf Content
zugegriffen werden kann. Bei Vererbung würde _ganzer_ Content _überschrieben_.

```xaml
<!-- Anstatt <Label> <ContentPresenter /> in ControlTemplate.xaml verwenden -->
<ContentPage xmlns:cc="clr-namespace:V_13.CustomControls">
  <cc:AlertBox><Image Source=/><Label/></cc:AlertBox></ContentPage>
```

=== Stufe 4: Anpassung der nativen Views mit "Handlers"
Um native Views #hinweis[(z.B. Buttons)] anzupassen oder MAUI-Controls auf native Platform-Controls abzubilden, werden
_Handler_ benötigt. Sind mächtiger als `OnPlatform`/`OnIdiom`. *Ablauf:*
1. Ableiten des gewünschten Handlers
2. Überschreiben von `ConnectHandler()`.
3. Mit `#if ANDROID` etc. mehrere Versionen von `ConnectHandler()` erstellen.
4. Registrieren in Builder mit\ ```cs ConfigureMauiHandlers(h => h.AddHandler<Entry, CustomHandler>())```


= .NET MAUI Architecture
#v(-0.5em)
== Data Binding in MAUI
_Entkopplung_ von View #hinweis[(XAML)] und Model #hinweis[(C\# Klassen)] durch Data Binding.
Controller verbleibt momentan noch im Code Behind -- nicht ideal.
UI-Elemente können mit dem _BindingContext_ mit dem Model verbunden werden:\
```cs var u = new User(); this.BindingContext = u;```\
Danach können die Properties _direkt im XAML verwendet_ werden:
```xaml <Label Text="{Binding FirstName}">```.
Die Datenquelle kann mit der _`Path`-Eigenschaft_ überschrieben werden. Quelle muss `INotifyPropertyChanged` implementieren.
_`Mode`-Eigenschaft:_ Richtung des Datenflusses.
_`Converter`-Eigenschaft:_ Datenumwandlung zwischen Quelle und Ziel.

=== Binding Mode
Standardwert abhängig von Ziel-Eigenschaft. *Beispiel:* ```xaml {Binding Mode=OneWay}```
- _OneTime:_ Einmalige Aktualisierung des Ziels beim Setzen der Quelle
- _OneWay:_ Ziel wird bei jeder Änderung der Quelle aktualisiert
- _OneWayToSource:_ Quelle wird bei jeder Änderung des Ziels aktualisiert
- _TwoWay:_ Quelle & Ziel werden gegenseitig synchronisiert

=== Value Converter
Hilfsobjekt zur _Datenumwandlung_. Implementiert `IValueConverter` mit `Convert()` #hinweis[(Quelle $->$ Ziel)] und
`ConvertBack()` #hinweis[(Ziel $->$ Quelle)].

```cs
public class C : IValueConverter {
  public object Convert(object value) { /* ... */ }
  public object ConvertBack(object value) { /* ... */ } }
```
```xaml
<ContentPage xmlns:con="clr-namespace:(...)">
<ContentPage.Resources><con:C x:Key="myCon"/><ContentPage.Resources>
<Entry Text="{Binding Path=Name Converter={StaticResource myCon}}"/>
```

=== Multi-Binding
Verwendung analog zu Binding `Path`, `Mode`, etc. _Mehrere Quell-Eigenschaften_. Nur in _Property Element Syntax_.
Ist Zieleigenschaft kein String, muss Converter `IMultiValueConverter` implementieren. Ist das erste Zeichen im Format
String "`{`", muss es mit `{}` escaped werden.
```xaml
<Label><Label.Text><MultiBinding StringFormat="{}{0}, {1} ({2} J.)">
  <Binding Path="LastName" /><Binding Path="FirstName" />
  <Binding Path="Age" /></MultiBinding></Label.Text></Label>
```

=== Binding Context
Enthält _Standardquelle_ für Bindings. Property von `BindableObject`. Wenn undefiniert: Traversierung des Logical Trees
nach oben bis zum ersten Treffer. Beliebige Quell-Objekte möglich. Meist pro Page ein BindingContext.
*Datenquellen*:
_`BindingContext`_ #hinweis[(Code Behind)] _`{Binding Source=}`_ #hinweis[(XAML-Default)], _`{Relative Source=}`_
#hinweis[(Visual Tree-Referenz)], _`{x:Reference}`_ #hinweis[(Property von Element, z.B. `x:Name`)]

=== Compiled Bindings
Bindings werden erst zur _Runtime_ aufgelöst #hinweis[(kein IDE-Support)]. _`x:DataType`_ vergibt explizit Typ.
*Vorteile:* Compile-Time- statt Runtime-Fehler, bessere Performance.

== Observer Pattern in .NET
Damit Änderungen an Binding Properties aktualisiert werden, muss die Klasse _`INotifyPropertyChanged` (INPC)_
implementieren.\ *Quelle:* `Observable` mit INPC, *Ziel:* `Observer` mit Event Handler. Es gibt in MAUI keine
Basisklasse, die INPC implementiert, um Framework-unabhängig zu bleiben
#hinweis[(INPC funktioniert in allen XAML-Frameworks)]

```cs
public class UserViewModel : INotifyPropertyChanged {
  public event PropertyChangedEventHandler PropertyChanged;
  protected virtual void OnPropertyChanged(string name) {
    var eventArgs = new PropertyChangedEventArgs(name);
    PropertyChanged?.Invoke(this, eventArgs); // Send name of changed property
  }
  private string _firstName = "Nina";
  public string FirstName {
    get => _firstName;
    set { if (_firstName == value) { return; }
      _firstName = value;
      OnPropertyChanged(nameof(FirstName)); } } }
```

== Observable Collections
Collections können mit Collection Views dargestellt werden #hinweis[(z.B: CarouselView, Eigenschaften: `ItemsSource`,
  `ItemTemplate`, `ItemsLayout`)]. Für Data Binding muss _`INotifyCollectionChanged` (INCC)_ implementiert werden.
_`ObservableCollection<T>`_ implementiert INCC #hinweis[(für Add/Remove Element)] und INPC
#hinweis[(für Änderung an Element in der Collection)]. Die enthaltenen Elemente müssen aber ihre Änderungen
selbstständig via INPC kommunizieren! `ObservableCollection` sollte bevorzugt verwendet werden, Eigenimplementation
meist Overkill.
#v(-0.25em)

=== Custom Item Templates
`DataTemplate` definiert die Darstellung von Daten in Collections. `ItemTemplate` ist eine Property, die ein
`DataTemplate` enthält. Für eigene Layouts wird ein _`ContentView`_ erstellt. Bietet vollständige Kontrolle
über Layout und Inhalt. _`x:DataType`_ aktiviert Compiled Bindings.
_Vorteile ggü. Inline Templates:_ Wiederverwendbarkeit, eigene Code-Behind Logik, bessere Organisation.

== Commands
Mit Data Binding können _Properties verknüpft_ werden, aber keine Methoden.
*Lösung:* Methoden in Objekte packen und `ICommand` implementieren. Parameter werden in View gebunden.
- ```cs void Execute(object param)```: Code der Aktion #hinweis[(z.B. Alter von Nutzer verringern)]. Sollte meist
  `CanExecuteChanged` invoken
- ```cs bool CanExecute(object param)```: Kann Aktion ausgeführt werden? #hinweis[(Alter $>=$ 0?)]
- Event `CanExecuteChanged`: Auslösen wenn `CanExecute`-Bedingung ändert #hinweis[(Alter ändert sich)]
#v(-0.5em)
```xaml
<Button Text="Decrease Age" Command="{Binding DecreaseAge}"
  CommandParameter="{Binding SelectedUser}" />
```

== MVVM in MAUI
Die Applikation sollte vollständig über UI-Abstraktionen bedienbar sein #hinweis[(für Tests)]. Die View soll dumm sein.
_Model:_ Businesslogik & Datenstrukturen #hinweis[(C\# Klassen, Interfaces)]
_View:_ Darstellung #hinweis[(XAML & CodeBehind, MAUI Control Library)]\
_ViewModel:_ Darstellungslogik, Model für View adaptieren #hinweis[(C\#-Klasse mit INPC)]\
_V $<=>$ VM:_ Lose Kopplung #hinweis[(Data Binding)], _VM $<=>$ M:_ Starke Kopplung #hinweis[(Methoden/Events)]

*Wohin gehört welcher Code:*
_Model:_ Logik ist Teil der Domäne oder wird mehrfach verwendet. _ViewModel:_ Logik ist unabhängig vom verwendeten
UI-Framework. _View:_ Der Rest.

=== Bootstrapping und Dependency Injection (DI)
UI-Elemente werden mit dem .NET DI Container instanziiert. Er löst Verkettungen automatisch auf
#hinweis[(TodoListPage  $->$ IManageTodos $->$ ITodoRepository)].

/*
```cs
builder.Services.AddTransient<ITodoRepository, TodoRepository>();
builder.Services.AddTransient<IManageTodos, ManageTodos>();
builder.Services.AddTransient<TodoListPage>();
// Erhält Interface des vorherigen Transient
public ManageTodos(ITodoRepository repo) : IManageTodos {}
public TodoListPage(IManageTodos manageTodos) {}
```
*/

#grid(
  columns: (1fr, 1fr),
  [
    == Gesamtarchitektur
    Es werden _4 Unterprojekte_ erstellt. Referenzen von Core auf Infrastruktur sind nicht kompilierbar $->$
    versehentliche _Architekturverletzungen unmöglich_. _Unittests_ sollten hauptsächlich Usecases und View Models testen.
    Das UI-Projekt referenziert `Infrastructure` und `ViewModels` nur für Bootstrapping.
  ],
  image("img/maui_architektur.png"),
)


= MAUI Advanced
#v(-0.75em)
== Background Threads
MAUI baut auf plattform-spezifischen Mechanismen auf und hat einen _Main Thread_ #hinweis[(GUI-Aktualisierung)] und
eventuelle _Background Threads_ #hinweis[(für langlaufende Aktionen)].
*Stolperfallen:*
Langlaufende Operationen auf Main Thread _blockieren_ GUI, GUI-Updates aus Background Threads führen zu _Exceptions_.
*Lösungen:*
- _Eigene Threads:_ `Task.Run()` #hinweis[(Thread-Pool)], Parallel LINQ, `new Thread()` #hinweis[(manuelle
    Thread-Erstellung -- vermeiden!]), `BackgroundWorker` #hinweis[(veraltet!)]
- _Ans OS delegieren:_ `async`/`await`
  #hinweis[(Thread wird freigegeben, OS managed IO und benachrichtigt bei Completion)]

Über die _`MainThread`_-Klasse lässt sich Code an den Main Thread zurückdelegieren: _`BeginInvokeOnMainThread()`_
#hinweis[(fire-and-forget, für einfache UI-Updates ohne Abhängigkeiten, keine Garantie wann Update passiert)],
_`InvokeOnMainThreadAsync()`_ #hinweis[(Abwarten mit `await`, wenn Reihenfolge wichtig, z.B. UI-Update, dann DB.)]

=== Best Thread Practices
Bei _`async`-Aufrufen_ aus Main Thread _ohne UI-Manipulation_ ist keine spezielle Aktion mit `MainThread` nötig.
_Background Threads_ für intensive Berechnungen oder IO nutzen. _Keine UI Updates_ aus Background Threads $->$
dafür `MainThread`-Funktionen verwenden. Vermeide Blockierungen durch _synchronen_ Code #hinweis[(`.Wait()`, `.Result`)]

== Daten speichern
- _`FileSystem.Current.AppDataDirectory`_ #hinweis[(User Data)],
- _`FileSystem.Current.CacheDirectory`_ #hinweis[(Temp Data)],
- _`OpenAppPackageFileAsync(filename)`_ #hinweis[(Read-only Stream für MAUI-Assets)]

_Für kleinere Datenmengen:_ `Preferences.Set()/.Get()` #hinweis[(Schnell, für nicht sensitive Daten)],
`SecureStorage.SetAsync()/.GetAsync()` #hinweis[(Verschlüsselt, für Tokens/Passwörter)]. Bei Secure Storage ist _Error
Handling wichtig!_ Device Security Settings können sich ändern, dann Key entfernen und neu authentifizieren.

=== State Restauration & App Lifecycle
*Service Pattern:*
Zentraler `AppStateService` kapselt Storage APIs mit type-safe Constants. Kombiniert Preferences & SecureStorage.\
*App Lifecycle Integration:*
`OnStart()` #hinweis[(State restore)], `OnSleep()` #hinweis[(State speichern vor Background)],
`OnResume()` #hinweis[(State validieren)]

== Navigation & Routing
*Shell Navigation:*
Bietet Navigation Stack Management und Deep Linking. Zwischen verschiedenen UI-Elementen kann mit URIs navigiert
werden #hinweis[(Navigation ohne feste Hierarchie, Query Parameter unterstützt)].
_`IQueryAttributable`_ bietet eine saubere Trennung, ist trim-safe und mit modernen Deployment-Szenarien kompatibel.
Sollte man bei Native AOT Deployment verwenden.
*Navigation Lifecycle:*
_`OnNavigating`_ ist vor Navigation, _`OnNavigated`_ nach Navigation.

== Platform Integration
MAUI enthält für viele Fälle bereits _einheitliche APIs_, welche auf Plattform APIs gemapped werden. Genügt das nicht,
können pro Plattform eigene Services erstellt werden. Dazu ist Wissen über APIs der Zielplattform nötig.\
*Varianten:*
_Conditional Compilation_ #hinweis[(Alles in einer Datei, `#if iOS`. Schlechte Lesbarkeit, unübersichtlich.
  Nur für einfache Features)],
_Cross-Platform API_ #hinweis[(`partial class`, jede Plattform in eigener Datei. Empfohlene Variante)],
_Plattform-spezifische Registrierung_ #hinweis[(Plattform registriert eigene Services beim Start)]

== Loslösung vom Framework
Input-Validierung ist oft business-lastig, muss aber häufig in UI verwendet werden. Mit dem Dependency Inversion
Principle lassen sich MAUI-Funktionen über Abstraktionen im ViewModel ansprechen: Interfaces definieren und per DI im
Constructor injizieren. #hinweis[(GoF Pattern: Adapter)]

== Error Handling
Error Handling ist stark plattformabhängig, Fehler müssen je nachdem pro Plattform anders gehandhabt werden.
Implementierung kann via Delegates oder Interfaces stattfinden. Mit `INotifyPropertyChanged` & `INotifyDataErrorInfo`
können Fehlermeldungen framework-unabhängig implementiert werden.
