#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

/* #show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de"
) */

= Meltdown
Meltdown ist eine _HW-Sicherheitslücke_, mit der der _gesamte physische Hauptspeicher
ausgelesen_ werden kann. Insbesondere kann damit ein Prozess alle geheimen Informationen
_anderer_ Prozesse lesen.

Folgende _Eigenschaften_ müssen für diese Sicherheitslücke gegeben sein:

Der Prozessor muss dazu gebracht werden können:
+ aus dem _geschützten Speicher_ an Adresse $a$ das Byte $m_a$ zu _lesen_
+ die Information $m_a$ in irgendeiner Form $f_a$ _zwischenzuspeichern_
+ _binäre Fragen_ der Form "$f_a eq.quest i$" zu beantworten
+ Von $i = 0$ bis $i = 255$ _iterieren_: $f_a eq.quest i$
+ Über alle $a$ _iterieren_

== Performance-Optimierungen in realen Systemen
Moderne HW und OS verwenden zahlreiche und nicht immer intuitive "Tricks" für
Performance-Optimierung:
#link(<md-caches>)[_Caches_],
#link(<md-O3E>)[_Out-of-Order Execution_],
#link(<md-speck>)[_Spekulative Ausführung_],
#link(<md-mapping>)[_Mapping_ des gesamten physischen Speichers in jeden virtuellen Adressraum].

=== Mapping des Speichers in jeden virtuellen Adressraum <md-mapping>
Virtueller Speicher soll Prozesse gegeneinander schützen.
Deshalb hat jeder Prozess seinen eigenen virtuellen Adressraum.
_Kontext-Wechsel_ sind jedoch relativ _teuer_. Deshalb arbeitet das OS aus
_Performance-Gründen_ im _Kontext des Prozesses_. Der OS-Kernel wechselt den Kontext
_nicht_, sondern _mappt alle Kernel-Daten_ in den Adressraum.\
Die Page-Table ist so konfiguriert, dass _nur das OS_ auf diese Teile _zugreifen_ darf.

Da das OS auf _alle Prozesse_ zugreifen können muss, mappt der OS-Kernel den
_gesamten physischen Hauptspeicher_ in jeden virtuellen Adressraum.

=== Out-of-Order Execution (O3E) <md-O3E>
Moderne Prozessoren führen Befehle aus, wenn alle benötigten Daten zur Verfügung stehen
#hinweis[(Solange das Endergebnis dadurch nicht beeinträchtigt wird)].
Dadurch kann sich _die Reihenfolge der Befehle ändern_.

==== Spekulative Ausführung <md-speck>
Out-of-Order Execution wird auch dann _vorgenommen_, wenn der Befehl später
_gar nicht ausgeführt_ wird. Erfordert prozessor-internen Zustand neben den Registern -
_wesentliche Voraussetzung für Geschwindigkeit_ moderner Prozessoren.
Wenn der Wert dann nicht gebraucht wird, wird er wieder _verworfen_ #hinweis[(z.B. Befehle
nach conditional jumps)]. Beim Zugriff auf eine Adresse, für die keine Berechtigung
besteht, liest das OS den Wert zwar, gibt ihn aber nicht an den Prozess weiter.
Schritt 1 ist damit erfüllt, da durch spekulative Ausführung auf jeglichen Speicher
zugegriffen werden kann.

#pagebreak()

==== Seiteneffekte von Out-of-Order Execution <md-caches>
Der _Cache weiss nicht_, ob ein Wert _spekulativ_ angefordert wurde.
Wird also trotzdem in den Cache geschrieben. Dieser kann vom Prozess nicht ausgelesen
werden, da die MMU entscheidet, ob der Cache die Daten an ihn weitergeben darf.
```c
char dummy_array[4069 * 256]; // page size * char size
char * sec_addr = 0x1234;
char sec_data = *sec_addr; // Exception, no permission
char dummy = dummy_array[sec_data]; // speculative
```
Schritt 2 ist damit erfüllt, da im Cache $m_a$ als Teil des Tags gespeichert wird.\
#hinweis[(`dummy_array` + `sec_data` #sym.arrow `sec_data` = Tag - `dummy_array`).]

=== Cache auslesen
Jedoch kann _die Zeit gemessen_ werden, die ein Speicherzugriff benötigt:
_Lange Zugriffszeit:_ Adresse war nicht im Cache,
_Kurze Zugriffszeit:_ Adresse war im Cache.
Dies nennt man auch _Timing Side Channel Attack_.
Mit der Assembly-Instruktion ```asm clflush p``` werden alle Zeilen, die die Adresse `p`
enthalten gelöscht. Das ermöglicht "Flush & Reload": Über das gesammte Array iterieren und
`clflush` ausführen, damit wird sichergestellt dass das gesamte Array nicht im Cache ist.
Schritt 3 ist somit auch erfüllt: Die Zugriffszeit verrät, ob $f_a$ im Cache.

== Tests von Meltdown
Verschiedene CPUs #hinweis[(Intel, einige ARMs, keine AMDs)] und verschiedene OS
#hinweis[(Linux, Windows 10)] sind betroffen. _Geschwindigkeit_ bis zu 500 KB pro Sekunde
bei 0.02% Fehlerrate. So schnell können "sichere" Daten ausgelesen werden.
#hinweis[(1 GB in 35min mit 210KB Fehlern)]

== Einsatz von Meltdown
Meltdown kann zum Beispiel zum _Auslesen von Passwörtern_ aus dem Browser via Malware oder
für _Zugriff auf andere Dockerimages_ auf dem gleichen Host verwendet werden.
Kann jedoch _nicht_ aus einer VM heraus auf den Host oder auf geschlossene Systeme zugreifen.

Nachweis des Einsatzes ist sehr schwierig, die Attacke hinterlässt quasi _keine Spuren_.
_AMD und ARM sind nicht betroffen_, vermutlich weil sie die Zugriff-Checks anders durchführen.

== Gegenmassnahmen
_Kernel page-table isolation "KAISER":_ verschiedene Page Tables für Kernel- bzw. User-Mode.
Der _Impact auf die Performance_ ist auf Linux-Systemen sehr unterschiedlich, kaum messbar
bei Computerspielen, 5% beim Kompilieren, bis zu 20% bei Datenbanken und
_30% bei weiteren Anwendungen_.

== Spectre
Angriff, der das gleiche Ziel hat wie Meltdown, nämlich Speicherbereiche anderer Prozesse
zu lesen. Verwendet jedoch einen anderen Mechanismus: _Branch Prediction mit spekulativer
Ausführung_.

Moderne Prozessoren _lernen_ über die Zeit, _ob ein bedingter Sprung erfolgt_ oder nicht.
Muss der Prozessor noch auf die Sprungbedingung warten, kann er schon _spekulativ den
Zweig ausführen, den er für wahrscheinlicher hält_.

=== Angriffsfläche von Branch Prediction
Branch Prediction wird nicht per Prozess _unterschieden_.
Alle Prozesse, die auf dem selben Prozessor laufen, verwenden die _selben Vorhersagen_.
Ein Angreifer kann damit den Branch Predictor _für einen anderen Prozess "trainieren"_.
Der _Opfer-Prozess_ muss zur Kooperation _"gezwungen"_ werden, indem im verworfenen Branch
auf Speicher zugegriffen wird.

Spectre ist _nicht besonders leicht zu fassen_, aber auch _nicht besonders leicht zu implementieren_.

=== Fazit
HW-Probleme können teilweise durch SW _kompensiert_ werden, Designentscheidungen können
_weitreichende Konsequenzen_ haben.
