// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "Ex&Ev",
  fach-long: "Experimentieren & Evaluieren",
  semester: "HS24",
  tableofcontents: (enabled: true, depth: 2, columns: 2),
)

// Global variables definition
#let x- = $dash(x)$ // Mittelwert von x
#let y- = $dash(y)$ // Mittelwert von y

// Document specific settings
#show table.cell: set par(justify: false)

#let example-block(body) = {
  set enum(numbering: "a) 1)")
  show emph: set text(fill: black, weight: "regular")
  body
}

#{
  set quote(block: true, quotes: false)
  show quote: set par(justify: false)
  show quote: set align(center)
  show quote: set pad(x: 14em, y: 20em)
  quote(attribution: [eure Nina])[
    Diese Zusammenfassung wurde komplett von Jannis Tschan verfasst, ich habe sie lediglich redigiert.
    Der Dank gebührt also ihm :)
  ]
}

#pagebreak()

#hinweis[*Hinweis:* In der Zusammenfassung werden Anweisungen zur Taschenrechnerbenutzung gegeben. Diese beziehen sich auf
den TI nSpire CX II-T und das Skript auf #underline[https://github.com/takotori/StudentenportalSpick].]

= Grundlagen
Durch Experimente soll ein besseres Verständnis der realen Welt und deren Zusammenhänge erhalten werden,
mit dem Ziel Verbesserungen zu erreichen.

== Modell nach Shewhart-Cycle
Hypothese formulieren #sym.arrow Daten im Experiment gewinnen #sym.arrow Hypothese prüfen #sym.arrow ggf. Modell anpassen

== Versuchsplanung
Hindernisse im Erkenntnisgewinn: Komplexität, Kompliziertheit, Rauschen/Dynamik

== Prozessmodell
Einflussgrössen: Einstellgrössen, Störgrössen #sym.arrow Prozess/Experiment #sym.arrow Zielgrössen\
Praktisches Problem #sym.arrow Statistisches Problem #sym.arrow Statistische Lösung #sym.arrow Praktische Lösung
- _Systematischer Fehler:_ durch Versuchsaufbau gegeben, reproduzierbar
  #hinweis[(falscher Aufbau, Denkfehler bei Experimentdesign)]
- _Zufälliger Fehler:_ nicht kontrollierbar, schwankendes Ergebnis #hinweis[(Messfehler)]

== Modell nach Design of Experiments (DoE)
Methodik zur systematischen Planung und statistischen Auswertung von Experimenten
- _Zielgrössen:_ Ergebnis eines Versuchs, Messwerte oder daraus berechnete Grössen, mehrere pro Versuch möglich
- _Einflussgrössen:_ Können Zielgrössen in Experiment beeinflussen
  - _Steuergrössen:_ Können beeinflusst werden #hinweis[(z.B. Temperatur in Schmelzofen, RAM-Grösse etc.)]
  - _Störgrössen:_ Können nicht (direkt) beeinflusst werden #hinweis[(z.B. Ausfallrate, Verunreinigungen)]
- _Faktoren:_ Wesentliche Einflussgrössen, die das Experiment stark beeinflussen
- _Faktorstufen:_ Werte der Faktoren
  - _Quantitative Faktoren:_ Zahlenwerte auf Messskala #hinweis[(z.B. CPU-Last, Speicherverbrauch)]
  - _Qualitative Faktoren:_ Namen, Bezeichnungen #hinweis[(z.B. Ort der Serverfarm, Strassenname)]
- _Simulation:_ Durchführen von Experimenten am Modell anstatt am realen System

=== Vorgehensweise
#{
  set par(justify: false)
  grid(
    [
      + Ausgangssituation und Problem beschreiben
      + Untersuchungsziel festlegen
      + Zielgrössen und Faktoren festlegen
      + Entscheidung treffen, ob das Problem _analytisch-mathematisch_ oder _experimentell_ gelöst werden soll
      Falls das Problem _experimentell_ gelöst wird:
      5. Versuchsplan aufstellen
      + Blockbildung #hinweis[(Aufteilung der Versuchsobjekte anhand eines Merkmals in Blöcke, vermindert Fehlervarianz)]
    ],
    [
      7. Aufwandsabschätzung
      + _Durchführungsplanung_, falls Experiment _am realen Objekt_, _Modell erstellen_, falls Experiment am _Modell_
      + Versuche durchführen
      + Versuchsergebnisse auswerten
      + Ergebnisse interpretieren und Massnahmen ableiten
      + Absicherung, Dokumentation und weiteres Vorgehen
    ],
  )
}

==== Ausgangssituation und Problem beschreiben (1)
- Wer ist Kunde? Wer ist Konkurrenz? Was braucht der Kunde? Was ist die Verbesserung?
- Was ist die (langfristige) Zielsetzung?
- Welches (Teil-)Problem soll durch die geplante Untersuchung gelöst werden?
- Wie viel Zeit und Geld stehen maximal zur Verfügung? #hinweis[(Kosten-Nutzen-Analyse)]
- Wer ist von der geplanten Untersuchung betroffen? Ist mit Widerstand zu rechnen?
- Wer ist für was verantwortlich?
- Was ist bereits bekannt? Liegen (aktuelle) Daten vor?
- _Ist das Problem wirklich verstanden?_

#pagebreak()

==== Untersuchungsziel festlegen (2)
- _Optimale Lage des Mittelwerts:_ Das Prozessergebnis oder ein Produktparameter sollen einen
  bestimmten Wert annehmen
- _Reduzierung der Streuung/Robustheit:_ Oft ist weniger die Lage des Mittelwerts des Prozessergebnisses
  problematisch als dessen Streuung
- _Erkennen der wichtigsten Störgrössen:_ Durch systematische Beobachtungen (der Fertigung) und einfache Versuche herausfinden
- _Gleichzeitig machen und lernen:_ Durch systematische Veränderung der Prozessparameter im laufenden Prozess
  können Verbesserungsmöglichkeiten erkannt werden
- _Funktion und Zuverlässigkeit nachweisen_

==== Zielgrössen festlegen (3)
- _Kundenorientiert und Relevant:_ Zielgrössen müssen die Probleme des Kunden abbilden
- _Quantifizierung:_ Zielgrössen müssen messbare Grössen sein
- _Vollständigkeit:_ Alle wesentlichen Prozessergebnisse bzw. Produkteigenschaften müssen als Zielgrössen erfasst werden
- _Verschiedenheit:_ Möglichst wenige und möglichst unterschiedliche Zielgrössen definieren

_Auswahl der Zielgrössen:_ Auswahl erfolgt in zwei Schritten: Zuerst möglichst viele Einflussgrössen mittels Brainstorming
sammeln und anschliessend auf eine handhabbare Anzahl reduzieren.\
Beim Brainstorming helfen Prozessablaufdiagramme, Ursache-Wirkungs-Diagramme, Einflussgrössen-Zielgrössen-Matrizen etc.

=== Beispiel
Zur Fertigung einer bestimmten Chemikalie werden mehrere Ausgangsstoffe einschliesslich Katalysator in einem Reaktionsgefäss
vermischt. Die Mischung wird anschliessend über längere Zeit unter Rühren erhitzt, dabei erfolgt die Reaktion.
Dann wird das Reaktionsprodukt abgetrennt.

Ziel ist eine _Erhöhung der Ausbeute bei möglichst geringen Kosten_. Unten ein Auszug aus der Liste der Einflussgrössen,
mit den Einschätzungen des Teams zur Grösse ihres Einflusses auf die beiden Zielgrössen "Ausbeute" und "Kosten".
Aus der Fertigungsüberwachung ist bekannt, dass die Standardabweichung der Ausbeute aufgrund der Zufallsstreuung
$sigma = 1%$ beträgt, wenn ein Ausbeute-Unterschied von $2%$ relevant ist.

#table(
  columns: (1fr,) * 4,
  table.header([Einflussgrösse], [Art], [Ausbeute], [Kosten]),
  [*Temperatur*], [Steuergrösse], [Stark], [Gering],
  [*Reaktionszeit*], [Steuergrösse], [Stark], [Stark],
  [*Katalysatormenge*], [Steuergrösse], [Stark], [Gering],
  [*Rührrate*], [Steuergrösse], [Gering], [Kein],
  [*Materialcharge*], [Störgrösse], [Gering], [Kein],
  [*Bediener*], [Störgrösse], [Gering], [Kein],
  [*Verunreinigungen*], [Störgrösse], [Stark], [Gering],
)

Nach Abschluss der _Ideenfindung_ werden die Ideen _bewertet_ und _gewichtet_. Anschliessend wird eine handhabbare Anzahl
von Faktoren _ausgewählt_ #hinweis[(3-6)]. Diese müssen _unabhängig_ voneinander _veränderbar_ sein.

Im Beispiel werden die obersten 3, _Temperatur_, _Reaktionszeit_ und _Katalysatormenge_ ausgewählt.

==== Faktorstufen
- _Kleiner Abstand_ zwischen den Stufen ergibt ein _kleiner Unterschied der Ergebnisse_. Ein _grosser Abstand_ führt zu
  _Abweichungen der Ergebnisse_ von der Linearität.
- Kann ein Faktor _nicht genau gemessen_ werden, sollte der Abstand der Faktorstufe _mindestens *$6 sigma$*_ sein.
- Eine _Extrapolation_ der Ergebnisse über den untersuchten Bereich hinaus ist nicht zulässig, daher sollte
  die Untersuchung _den interessanten Bereich_ enthalten.


= Fehlerfortpflanzung
Fehler können nur _geschätzt_, nicht berechnet werden. Um den Bereich abzuschätzen, in denen der tatsächliche Wert
maximal oder mit einer gewissen Wahrscheinlichkeit liegt, verwendet man _Fehlerrechnung_ bzw. Fehlerfortpflanzung.
Der Fehler wird jeweils mit $Delta$ gekennzeichnet.\
Man unterscheidet zwischen dem _maximalen_ und dem _wahrscheinlichen_ Fehler.

== Impliziter Fehler
Oft wird der Fehler nicht explizit angegeben. Dann basiert die Genauigkeit auf der Anzahl Nachkommastellen:
Mindestens 0.5 Einheiten _nach der letzten Stelle_ bis maximal 2-4 Einheiten _der letzten Stelle_ nach dem Punkt.

*Beispiele:*
- $t = 15.32s => Delta t = [plus.minus 0.005s; plus.minus 0.04s]$
- $t = 15.3s => Delta t = [plus.minus 0.05s; plus.minus 0.4s]$
- $t = 15.320s => Delta t = [plus.minus 0.0005s; plus.minus 0.004s]$

== Maximaler Fehler
Der maximale Fehler in der Fehlerfortpflanzung bezeichnet den _grössten möglichen Fehler_, der bei der Berechnung
eines Ergebnisses von mehreren Messwerten entstehen kann. Will man diesen _Fehler reduzieren_, verbessert man
möglichst diejenigen Messwerte, welche in der Berechnung am grössten sind.
#hinweis[(z.B. in einer Formel $a\/b^2$ sollte man die Genauigkeit von $b$ verbessern, da es durch das Quadrieren einen
grösseren Einfluss auf das Resultat als $a$ hat)]

=== Absoluter Fehler
Beim absoluten Fehler wird die Abweichung in _derselben Masseinheit_ angegeben wie der Wert.
Wird meist bei _Messergebnissen_ angegeben. Wird auch als $m_"abs"$ bezeichnet.

*Beispiel:*
$
  overbracket(L = 5.8"cm", "Messwert"), quad overbracket(Delta L = 0.1"cm", "absoluter Fehler")
  quad => quad 5.8"cm" plus.minus 0.1"cm" = [5.7, 5.9]"cm"
$

=== Relativer Fehler
Der relative Fehler ist ein _Prozentwert_, also _einheitslos_. Durch den relativen Fehler kann bestimmt werden,
welcher Wert den _grössten Anteil am Gesamtfehler_ hat, also am ehesten optimiert werden sollte.
Er wird sowohl verwendet, um ein _Gefühl für die Messgenauigkeit_ zu bekommen als auch bei _Messgeräten_ als _Angabe_
auf den _eingestellten Messbereich_. Wird auch als $m_"rel"$ bezeichnet.

*Absoluten in relativen Fehler umwandeln:*
$
  overbracket(L = 5.8"cm", "Messwert"), quad overbracket(Delta L = 0.1"cm", "absoluter Fehler")
  quad => quad "absoluter Fehler" / "Messwert" = (Delta L) / L = (0.1"cm")/(5.8"cm") = 0.017 = underline(1.7%)
$

*Relativen in absoluten Fehler umwandeln:*
$
  overbracket(L = 5.8"cm", "Messwert"), quad overbracket(Delta L = 1.7%, "relativer Fehler")
  quad => quad "Messwert" dot "relativer Fehler" = 5.8"cm" dot 0.017 = underline(0.1"cm")
$

=== Partielle Differentiation <part-diff>
Partielle Differentiation ($(delta f)/(delta x)$) ist eine _Ableitung_ eines Terms mit _mehreren Variablen_.
Dabei wird nach jeder Variable in einer eigenen Rechnung abgeleitet, wobei die anderen Variablen wie Konstanten behandelt werden.
Mithilfe dieser Methode kann der Gesamtfehler eines Terms mit mehreren Variablen bestimmt werden.\
#hinweis[TR: Wie normale Ableitung (Menü #sym.arrow 4 #sym.arrow 1), aber es müssen explizit Mal-Zeichen gesetzt werden.] \

#hinweis[Anmerkung: Im Skript wird die Notation $display((delta x)/(delta y))$ bzw. $delta x$ für eine
partielle Ableitung verwendet. $space display((delta f)/(delta x) equiv dif/(dif x)(f))$]

#pagebreak()

=== Berechnung
Bei _Summen & Differenzen addieren_ sich die _absoluten Fehler_. Beinhaltet die Formel eine _Multiplikation/Division
mit mehreren Messwerten_, darf der Absolute Fehler nicht berechnet werden. Stattdessen den _relativen Fehler_ berechnen und
in den absoluten Fehler _umwandeln_. Bei _Produkten & Quotienten addieren_ sich die _relativen Fehler_.

#definition[
  Der Maximale Fehler $Delta f$ _für absolute Fehler in einer Formel_ $f$ wird über die partielle Differentiation berechnet:
  #grid(
    columns: (0.6fr, 1fr),
    align: horizon,
    [$ Delta f = sum_(i=1)^n abs((delta f)/(delta x_i) dot Delta x_i) $],
    [
      *_$x_i$_*: Steuergrösse(n) ohne absolutem Fehler\
      *_$f$_*: Formel, welche Multiplikation/Division mit Steuergrössen enthält\
      *_$delta f\/delta x_i$_*: Partielle Ableitung von $f$ mit $x_i$\
      *_$Delta x_i$_*: Absoluter Fehler der Steuergrösse $x_i$
    ],
  )
]

*Beispiel Summen und Differenzen: Was ist der gesamte absolute Fehler?*\
#hinweis[Absoluter Fehler für die Berechnung verwenden]

*Gegeben:* $W = display(m/2 - D/8), quad m = 0.300"kg" plus.minus 0.002"kg", quad D = 10.0"kg" plus.minus 0.5"kg"$

+ Fehler in Formel einsetzen, ausrechnen.
$ W = m_"abs"/ 2 - D_"abs" / 8 = 0.002 / 2 + 0.5 / 8 = 0.001 + 0.0625 = underline(0.0635"kg") $

*Beispiel Multiplikation und Division: Was ist der gesamte relative Fehler?* \
#hinweis[Relativer Fehler für die Berechnung verwenden]\
*Ausgangslage:*
Es gibt meist eine Formel mit Multiplikation/Division sowie mehrere Steuergrössen mit einem absoluten Fehler.\
*Gegeben:*
Formel $g = display((4 pi^2 l)/t^2), quad l = 784"mm" plus.minus 2"mm", quad t = 17.7s plus.minus 0.1s$

1. Partielle Ableitung der Formel nach Steuergrössen ($l,t$) durchführen #hinweis[(siehe Kapitel @part-diff)]
$ (delta g)/(delta t) = (-8 pi^2 l)/t^3, quad (delta g)/(delta l) = (4 pi^2)/t^2 $

2. Formel anwenden, um den absoluten Fehler $Delta g$ der Formel $g$ zu erhalten.
$
  Delta g = abs((-8 pi^2 l)/t^3 dot Delta t) + abs((4 pi^2)/t^2 dot Delta l)
  = abs((-8 pi^2 dot 784"mm")/(17.7s^3) dot 0.1s) + abs((4 pi^2)/(17.7^2) dot 2"mm")
  = 1.368 "mm"\/s^2
$

3. Relative Fehler der gewünschten Formel ausrechnen
$ (Delta g) / g = 1.368 \/ (4 pi^2 dot 784)/(17.7^2) = 0.01385 = underline(1.38%) $

#hinweis[TR: Seite 2.3 - Formel und Werte eingeben, gibt den relativen Fehler zurück]

*Beispiel Multiplikation und Division: Was ist der gesamte absolute Fehler?*\
#hinweis[Relativer Fehler für die Berechnung verwenden]

*Gegeben:*
Formel $g = display((4 pi^2 l)/t^2), quad g_"rel" = 1.383%, quad l = 784"mm" plus.minus 2"mm", quad t = 17.7s plus.minus 0.1s$

1. Werte ohne Verwendung des Fehlers in Formel einsetzen\
$ g = (4 pi^2 dot 784) / (17.7)^2 = 98.794 "mm"\/s^2 $
2. Resultat durch 100 teilen und mit relativem Fehler multiplizieren\
$ g_"abs" = 98.794 \/ 100 dot 1.383% = 1.366 space => space underline(98.789 "mm"\/s^2 plus.minus 1.366 "mm"\/s^2) $


== Fehlergrenzen
Die Fehlergrenzen bestimmen die _maximal mögliche Abweichung_ von einem Wert innerhalb einer _festen Intervallgrenze_.
Sie können für _relative & absolute Fehler_ bestimmt werden.\
Aus dem _absoluten Fehler_ können die Intervallgrenzen gebildet werden, indem der absolute Fehler auf den Messwert
angewendet wird und der Maximal- & Minimalwert des Messwertes _als Intervall_ angegeben wird.

Zur Bestimmung gibt es _2 Methoden_: Minimal-/Maximalwert und partielle Differentiation.
Ersteres wird nicht empfohlen, da es bei mehreren Variablen schnell komplex wird.

*Beispiel mit partieller Differentiation:*\
Bei einer Messung werden folgende Werte gemessen. $W$ stellt eine Beziehung der gemessenen Werte dar.\
$
  m = 0.300"kg" plus.minus 0.002"kg", space h = 0.3m plus.minus 0.002m, \
  D = 10.0"kg"/s^2 plus.minus 0.5"kg"/s^2, quad g = 9.81m/s^2 plus.minus 0.01m/s^2, quad
  W = (m dot g dot h)/2+(D dot h^2)/8
$

+ Nach jeder Variable ableiten

  #{
    set list(spacing: 1.3em)
    [
      $
        (delta W)/(delta m) & = dif/(dif m) ((m dot g dot h)/2 + (D dot h^2)/8) = (g dot h)/2 \
        (delta W)/(delta g) & = dif/(dif g) ((m dot g dot h)/2 + (D dot h^2)/8) = (m dot h)/2 \
        (delta W)/(delta h) & = dif/(dif h) ((m dot g dot h)/2 + (D dot h^2)/8) = (m dot g)/2
                              + (D dot 2h) / 8 = (m dot g) / 2 + (D dot h) / 4 \
        (delta W)/(delta D) & = dif/(dif D) ((m dot g dot h)/2 + (D dot h^2)/8) = h^2/8
      $
    ]
  }

+ Ableitungen und Fehler in Formel einsetzen

  $
    Delta W & = abs((g dot h)/2 dot Delta m) + abs(((m dot g)/2 + (D dot h)/4) dot Delta h)
              + abs(h^2/8 dot Delta D) + abs((m dot h)/2 dot Delta g) \
            & = abs((9.81 dot 0.3)/2 dot 0.002) + abs(((0.3 dot 9.81)/2 + (10 dot 0.3)/4) dot 0.002) + abs(0.3^2/8 dot 0.5)
              + abs((0.3 dot 0.3)/2 dot 0.01) \
            & = 0.00294 + 0.00444 + 0.005626 + 0.00045 = plus.minus 0.0135 thin ("km" dot m^2)/s^2 \
          W & = (0.554 plus.minus 0.0135) ("km" dot m^2)/s^2 = [0.541, 0.568] ("km" dot m^2)/s^2
  $

== Wahrscheinlicher Fehler
Der wahrscheinliche Fehler gibt ähnlich wie der maximale Fehler ein Fehlerintervall zu einem Messwert an.
Jedoch befindet sich der Messwert _nur sehr wahrscheinlich_ in diesem Intervall, im Gegensatz zum absoluten Fehler,
dessen Wert sich definitiv in diesem Intervall befindet.

#pagebreak()

= Statistik-Grundlagen & Untersuchung
#v(-0.5em)
== Grundbegriffe
- _Statistik:_ Entwicklung & Anwendung von Methoden zur Erhebung, Aufbereitung, Analyse & Interpretation von Daten
- _Beschreibende Statistik:_ Vollständige Kenntnis über Untersuchungsobjekt
  #hinweis[(z.B. CPU-Load für alle Server der Firma bekannt)]
- _Schliessende Statistik:_ Untersuchungsdaten liegen nur teilweise vor #hinweis[(z.B. repräsentative Umfragen)]
- _Merkmalsträger:_ Gegenstand einer statistischen Untersuchung. Besitzt Merkmale.\
  #hinweis[(Beispiele: Server, Werkmaschine, Personengruppe)]
- _Merkmal:_ Eine Eigenschaft, die bei einer statistischen Untersuchung eines Merkmalträgers von Bedeutung ist\
  #hinweis[(z.B. Ausfallzeit, Servicedauer, Kosten, Latenz, Geschlecht, Bildungsgrad...)]
- _Merkmalswert:_ Der Wert eines Merkmals, der aufgrund Beobachtung, Messung oder Befragung festgestellt wurde.
  Ist oft Median mehrerer Messungen. #hinweis[(z.B. CPU-Last = 45%, Kosten pro Jahr = 4'500 Fr., Latenz = 25ms)]
- _Grundgesamtheit:_ Menge aller Merkmalsträger, die gemeinsame Abgrenzungsmerkmale besitzen
- _Abgrenzungsmerkmale:_ Merkmale, mit denen Merkmalsträger gruppiert werden können
  - _Räumlich:_ Örtliche Gemeinsamkeit #hinweis[(z.B. alle Server einer Serverfarm, alle Personen an der OST, ...)]
  - _Zeitlich:_ Ergebnisse innerhalb eines Zeitraums #hinweis[(z.B. alle Messergebnisse eines Tages, Produktion pro Monat, ...)]
  - _Sachlich:_ Merkmalträger gleichen Typus #hinweis[(z.B. alle Maschinen eines Herstellers, alle Schüler einer Klasse, ...)]
- _Urliste:_ Unsortierte, nicht aufbereitete Daten, die direkt von der Messung stammen.
- _Primärstatistik:_ Erheben neuer Daten für die Untersuchung. Die erhobenen Daten sind optimal auf die Untersuchungsfrage
  zugeschnitten, aber die Erhebung ist teuer & aufwändig.
- _Sekundärstatistik:_ Verwenden bereits vorhandener Daten für die Untersuchung. Günstiger, aber die Daten sind nicht auf
  die Fragestellung ausgerichtet und evtl. veraltet.
- _Empirische Daten:_ Am realen Objekt gemessene Daten #hinweis[(durch Experiment, Messungen etc.)]
- _Theoretische Daten:_ Daten aus Modell oder Theorie, der eine theoretische Verteilungsfunktion zugrunde liegt
- _Polygonzug:_ Liniendiagramm #hinweis[(will de Rinkel ums verrecke eloquent sii muess)]

== Skalen
Die Merkmalswerte können nach einem bestimmten Ordnungsprinzip als _Werte_ in eine _Skala_ eingetragen werden.
#table(
  columns: (auto, 1fr, 1fr, auto),
  table.header([Skalentyp], [Erklärung], [Vergleich], [Beispiel]),
  [*Nominalskala*],
  [Werte sind qualitativ gleich, haben keine Wertigkeit],
  [Können nur durch Häufigkeit/Anzahl verglichen werden],
  [Familienstand #hinweis[(Ledig, verheiratet, ...)]\ Strassen #hinweis[(Paradeplatz, Seestrasse, ...)] ],

  [*Ordinalskala*],
  [Werte haben eine relative Rangordnung],
  [Können nach Intensität geordnet werden],
  [Flugklassen #hinweis[(Economy, Business Class, First Class)] \ kalt, warm, heiss],

  [*Intervallskala*],
  [reelle Zahlen, Nullpunkt ist willkürlich, negative Werte möglich],
  [Der absolute Abstand zwischen Werten kann gemessen werden],
  [Temperatur in °C #hinweis[-12, 0, 25,...] \ Uhrzeit #hinweis[20:00, 0:00, 09:35, ...]\
    #hinweis[8:00 ist nicht doppelt so spät wie 4:00]],

  [*Verhältnisskala*],
  [reelle Zahlen, Nullpunkt ist absolut Null, keine negativen Werte],
  [Der verhältnismässige Abstand (vielfaches) kann gemessen werden],
  [Gewicht in kg #hinweis[0, 25, 98, ...]\ Temperatur in °K: #hinweis[0, 1, 300, ...]\
    #hinweis[50kg ist doppelt so schwer wie 25kg]],
)

Die Intervall- & Verhältnisskala werden unter dem Oberbegriff _Kardinalskala (metrische Skala)_ zusammengefasst.

#pagebreak()

#table(
  columns: (auto,) + (1fr,) * 4,
  table.header([ablesbare Merkmalswerte], [Nominalskala], [Ordinalskala], [Intervallskala], [Verhältnisskala]),
  [Verschiedenartigkeit (`==`, `!=`)], cell-check, cell-check, cell-check, cell-check,
  [Rangordnung (`<`, `>`)], cell-cross, cell-check, cell-check, cell-check,
  [einfache Abstände / Intervall (`+`, `-`)], cell-cross, cell-cross, cell-check, cell-check,
  [verhältnismässige Abstände (`*`, `/`)], cell-cross, cell-cross, cell-cross, cell-check,
)

== Ablauf der Untersuchung
Die _Experimentplanung_ besteht aus 3 Phasen: _Datenerhebung_, _Datenaufbereitung & -darstellung_ und
_Datenanalyse & -interpretation_. In der Planungsphase muss festgelegt werden, welche _Merkmale_ bei welchen Merkmalsträgern
mit welcher Technik zu erheben sind, welche _Aufbereitungsverfahren_ einzusetzen sind, welche _Daten-Darstellungsformen_
zu verwenden ist und welche _statistischen Analyseverfahren_ angewendet werden.\
Werden die Daten _gezielt und periodisch_ durch Experimente erfasst & gepflegt, spricht man von _Data Farming_.

== Einfache Häufigkeitsverteilung
Gibt an, _wie häufig_ ein Merkmalswert $x_i$ aufgetreten ist.
#definition[
  #grid(
    columns: (0.25fr, 1fr),
    inset: (left: 1em, top: 0.25em),
    align: horizon,
    [
      $
                      n & = sum^v_(i=1) h_i \
                    f_i & = h_i/n \
        sum^n_(i=1) f_i & = 1
      $
    ],
    [
      _$bold(h_i)$:_ Absolute einfache Häufigkeit, Anzahl Merkmalsträger mit Wert $x_i$\
      _$bold(f_i)$:_ Relative einfache Häufigkeit, Prozentanteil der Merkmalsträger mit Wert $x_i$\
      _$bold(n)$:_ Gesamtanzahl aller Merkmalsträger\
      _$bold(v)$:_ Anzahl verschiedener Merkmalswerte
    ],
  )
]
*Beispiel:* Verteilung der Alterskategorien der Mitarbeiter eines Spitals mit $n = 50$ Personen:\
- *$h_1$:* $10$ Mitarbeiter in der Altersklasse $30 quad => quad bold(f_1) = h_1 \/ n = 10 \/ 50 = 20%$
- *$h_2$:* $15$ Mitarbeiter in der Altersklasse $40 quad => quad bold(f_2) = h_2 \/ n = 15 \/ 50 = 30%$
- *$h_3$:* $25$ Mitarbeiter in der Altersklasse $50 quad => quad bold(f_3) = h_3 \/ n = 25 \/ 50 = 50%$


== Kumulierte Häufigkeitsverteilung
Auch _Summenhäufigkeit_ genannt. Misst die Häufigkeit über verschiedene Messungen hinweg, indem sie alle bisherigen Messungen
(die einfache Häufigkeit $h_i$ bzw. $f_i$) aufsummiert.

#definition[
  #grid(
    columns: (25%, 75%),
    align: horizon,
    [
      $
                    H_i & = sum^i_(a=1) h_a \
                    F_i & = sum^i_(a=1) f_a = H_i / n = 1 \
        sum^n_(i=1) f_i & = 1
      $
    ],
    [
      _$bold(H_i)$:_ Absolute kumulierte Häufigkeit, Anzahl Messungen mit Merkmalswert $<= x_i$\
      _$bold(F_i)$:_ Relative kumulierte Häufigkeit, Prozentanteil der Messungen mit Wert $i$\
      _$bold(n)$:_ Gesamtanzahl aller Messungen\
      _$bold(k)$:_ Anzahl verschiedener Merkmalswerte
    ],
  )
]

*Beispiel:* Gleiche Aufgabenstellung wie bei der einfachen Häufigkeit
$
              bold(H_1) = h_1 = 10 quad & => quad bold(F_1) = H_1 \/ n = 10 \/ 50 = 20% \
        bold(H_2) = h_1 + h_2 = 25 quad & => quad bold(F_2) = H_2 \/ n = 25 \/ 50 = 50% \
  bold(H_3) = h_1 + h_2 + h_3 = 50 quad & => quad bold(F_3) = H_3 \/ n = 50 \/ 50 = 100%
$

#pagebreak()

== Klassifizierte Häufigkeitsverteilung <klassifizierte-häufigkeit>
Um Verteilungen mit mehr als 10 Merkmalswerten übersichtlich darstellen zu können, werden Merkmalswerte zu
_Klassen_ zusammengefasst. Die Differenz zwischen der Ober- und Untergrenze einer Klasse ist die _Klassenbreite_.

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Klassenbreite nach Sturges #hinweis[(*$m$* aufrunden auf Ganzzahl)]], [Faustregel für Anzahl Klassen]),
  [$ m approx 1 + 3.32 dot log(n) \ K_b = (x_max - x_min)/m $], [$ j_max = sqrt(n) $],
)

_*$j$:*_ Anzahl Klassen, _*$K_b$:*_ Klassenbreite, _*$x^u_j$:*_ untere Klassengrenze, _*$x^o_j$:*_ obere Klassengrenze.

*Beispiel: Alter der Bewohner einer Nachbarschaft*
#table(
  columns: (auto,) * 6,
  align: (x, y) => if (x >= 2 and y > 0) { right } else { center },
  table.header(
    [$bold(j)$],
    [Rechnungsbetrag\ $bold(x^u_j <= x_i <= x^o_j)$],
    [Absolute einfache Häufigkeit $bold(h_j)$],
    [Absolute kumul. Häufigkeit $bold(H_j)$],
    [Relative einfache Häufigkeit $bold(f_j)$],
    [Relative kumul. Häufigkeit $bold(F_j)$],
  ),
  [$1$], [$0$ bis $20$], [$8$], [$8$], [$0.05$], [$0.05$],
  [$2$], [$20$ bis $40$], [$40$], [$48$], [$0.25$], [$0.3$],
  [$3$], [$40$ bis $60$], [$80$], [$128$], [$0.5$], [$0.8$],
  [$4$], [$60$ bis $80$], [$32$], [$160$], [$0.2$], [$1$],
  table.hline(stroke: 1.5pt),
  [$Sigma$], [], [$160$], [], [], [],
)

=== Klassenrechnungen
Um den Anteil der Klassen _unterhalb_ eines Wertes $g$ zu bestimmen, kann die _lineare Interpolation_ zwischen
Klassengrenzen genutzt werden:

#definition[
  #grid(
    align: horizon,
    [$ F(x < g) = F_j + (F_(j+1) - F_j) / (x^o_(j+1) - x^u_(j+1)) dot (x - x^u_(j+1)) $],
    [
      _*$g$*:_ Grenzwert\
      _*$j$*:_ Klasse unterhalb des Grenzwertes\
      _*$j+1$*:_ Klasse, in welcher sich der Grenzwert befindet
    ],
  )
]

*Beispiel:* Anteil Bewohner unter $50$ Jahre in der obigen Tabelle:
$space g = 50, space j = 2, space j+1 = 3$

$F(x < 50) = F_2 + display((F_3 - F_2)/(x^o_3 - x^u_3)) dot (x - x^u_3)
= 0.3 + display((0.8 - 0.3)/(60 - 40)) dot (50 - 40) = 0.55 = underline(55%)$

Für den Anteil der Klassen _überhalb_ eines Wertes wird zuerst die lineare Interpolation durchgeführt und
dann 1 minus dieses Resultat gerechnet.\
$F(x > 50) = 1 - F(x < 50) = 1 - 0.55 = 0.45 = underline(45%)$

Liegen _unterschiedliche Klassenbreiten_ vor, kann nicht mehr mit der absoluten Häufigkeit $h_i$ gearbeitet werden.
Je breiter die Klasse, desto mehr Elemente könnten sich darin befinden. Hier muss auf die _Häufigkeitsdichte $d_i$_
ausgewichen werden.

#definition[
  #grid(
    align: horizon,
    [$ d_i = h_i / (x^o_i - x^u_i) $],
    [
      _*$h_i$*_: Absolute Häufigkeit der Klasse\
      _*$x^u_j$:*_ untere Klassengrenze\
      _*$x^o_j$:*_ obere Klassengrenze
    ],
  )
]

#pagebreak()

= Häufigkeitsverteilungen & Parameter
Typische Eigenschaften der Häufigkeitsverteilung können mit Hilfe von Kenngrössen, den sogenannten _Parametern_,
beschrieben werden. Dabei werden viele Einzelinformationen zu wenigen, aussagekräftigen Grössen verdichtet.

== Mittelwerte & Lageparameter
Lageparameter sind _Kennzahlen_, welche eine zentrale Tendenz der Messwerte aufzeigen, z.B. das Zentrum der Werte.

=== Modus
_Derjenige Merkmalswert, der am häufigsten beobachtet wird._ Sind das mehrere, gibt es mehrere Modi (_Multimodi_).
Kann für jede Verteilungsart bzw. jedes Skalenniveau bestimmt werden. Ist von Ausreissern unbeeinflusst.\
Um bei einer klassifizierten Häufigkeit einen einzigen Wert zu erhalten #hinweis[(und nicht nur die häufigste Klasse)],
kann der Modus mit dieser Formel geschätzt werden:

#definition[
  #grid(
    columns: (1.2fr, 1fr),
    align: horizon,
    [$ "Mo" = x^u_m + (h_m - h_(m-1)) / ((h_m - h_(m-1)) + (h_m - h_(m+1))) dot (x^o_m - x^u_m) $],
    [
      _*$m$:*_ Klassennummer der häufigsten Klasse\
      _*$h_m$:*_ Modusklasse ($h_j$ Wert der häufigsten Klasse)\
      _*$x^o_m$/$x^u_m$:*_ Obere/Untere Klassengrenze
    ],
  )
]

Sind die Klassen unterschiedlich breit, muss zuerst noch die Klasse mit der höchsten Dichte $d_i$ gefunden werden:
$
  d_i = h_i / (x^o_i - x^u_i) quad => quad max(d_i) quad => quad
  "Mo" = x^u_i + (h_i - h_(i-1)) / ((h_i - h_(i-1)) + (h_i - h_(i+1))) dot (x^o_i - x^u_i)
$

*Beispiele ohne Klasse:*\
$
  ["Löwe", "Giraffe", "Affe", "Löwe"] => "Mo" = underline("Löwe"), quad
  [1,2,6,5,3,4,3] => "Mo" = underline(3), quad
  [1,2,6,3,4,3,2] => "Mo" = underline([2, 3])
$

*Beispiel mit Klassen:* \
Daten siehe Beispiel-Tabelle in @klassifizierte-häufigkeit

1. Klasse auswählen, die am meisten auftaucht (grösster $h_j$-Wert)
$ m = 3, quad h_m = h_3 = 80 $

2. Grenzen ($x_m^u$/$x_m^o$) und Modusklassen ($h_j$) aus Tabelle ablesen
$ x^u_m = x^u_3 = 40, quad x^o_m = x^o_3 = 60, quad h_(m-1) = h_2 = 40, quad h_(m+1) = h_4 = 32 $

3. Werte in Formel einsetzen
$ "Mo" = 40 + display((80-40) / ((80-40) + (80-32))) dot (60-40) = underline(49.overline(09)) $

=== Median
_Merkmalswert, der in der Rangordnung die mittlere Position einnimmt_ #hinweis[(Wert mit Index $n\/2$)].
Um den Median berechnen zu können, müssen die Merkmale zuerst _sortiert_ werden, deswegen müssen sie mindestens
ordinalskaliert sein #hinweis[(keine Nominalwerte)]. Der Median ist _unbeeinflusst von Ausreissern_, darum gut geeignet
für _schiefe Verteilungen_ #hinweis[(asymmetrische/ungerade Graphen)].

Es wird unterschieden zwischen einer _geraden_ und _ungeraden_ Anzahl Werte. Ergibt die Berechnung des mittleren Index
eine Kommazahl, müssen die Werte darunter und darüber addiert und durch 2 geteilt werden.

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([ungerade Anzahl Werte], [gerade Anzahl Werte]),
  [$ "Me" = x_((n+1)\/2) $], [$ "Me" = (x_(n\/2) + x_((n\/2)+1)) / 2 $],
)

#pagebreak()

Wie beim Modus wird der Median bei der klassifizierten Häufigkeit wieder durch eine Formel abgeschätzt:
$ "Me" = x^u_m + (n/2 - H_(m-1)) / (H_m - H_(m-1)) dot (x^o_m - x^u_m) $

*Beispiele ohne Klassen:* \
#hinweis[Auf TR: Menü $->$ 6 $->$ 3 $->$ 4: Median. Werte in geschwungene Klammer packen (CTRL + "`)`").
Müssen nicht sortiert sein.]

*Ungerade:*
$
  {44%, 42%, 40%, 43.5%, 41.5%} => "sortieren" => {40%, 41.5%, 42%, 43.5%, 44%}, quad n = 5\
  "Me" = x_((n+1)\/2) = x_((5+1)\/2) = x_3 = underline(42%)
$
*Gerade:*
$
  {44%, 42%, 43.5%, 41.5%} => "sortieren" => {41.5%, 42%, 43.5%, 44%}, quad n = 4\
  "Me" = (x_(n\/2) + x_((n\/2)+1)) / 2 = (x_(4\/2) + x_((4\/2)+1)) / 2
  = (x_2 + x_3) / 2 = (42% + 43.5%) / 2 = underline(42.75%)
$

*Beispiel mit Klassen:* \
Daten siehe Beispiel-Tabelle in @klassifizierte-häufigkeit.

1. Klasse ermitteln, die sich von der Anzahl Merkmalsträger in der Mitte befindet
$ n / 2 = h_n / 2 = H_4 / 2 = 160 / 2 = 80 space => space 48 < 80 < 128 space => space m = 3 $

2. Grenzen & absolute kumulierte Häufigkeiten ($H_j$) aus Tabelle ablesen
$ x^u_m = x^u_3 = 40, quad x^o_m = x^o_3 = 60, quad H_(m-1) = H_2 = 48, quad H_m = H_3 = 128 $

3. Werte in Formel einsetzen\
$ "Me" = 40 + (160\/2 - 48) / (128 - 48) dot (60-40) = underline(48) $

=== Quantile & Quartile
_Quantile_ zerlegen Merkmalswerte in eine _gewisse Anzahl Teile_, _Quartile_ in _vier Teile_.
Ebenfalls geläufig sind _Dezile_ #hinweis[(10 Teile)] und _Perzentile_ #hinweis[(100 Teile)].
Das 1. Quantil wird auch als 25% Quantil/Perzentil bezeichnet. Die Berechnung erfolgt analog des Medians,
anstatt $n\/2$ wird einfach $n\/4$ gerechnet. Soll also zb. das 3. Quartil (75% Quantil) ausgerechnet werden,
muss $(3n)\/4$ gerechnet werden.

#table(
  columns: (auto, auto, auto),
  align: horizon,
  table.header([ungerade], [gerade], [klassifizierte Häufigkeit]),
  [
    $
      Q_1 = x_((n+1)\/4)
    $ #hinweis[falls $(n+1) \/ 4$ keine Ganzzahl ist, muss das arithmetische Mittel von den zwei angrenzenden Werten
    verwendet werden.]
  ],
  [$ Q_1 = (x_(n\/4) + x_((n\/4)+1))/2 $],
  [$ Q_1 = x^u_m + (n/4 - H_(m-1))/(H_m - H_(m-1)) dot (x^o_m - x^u_m) $],

  [$ Q_3 = x_(((n+1) dot 3)\/4) $],
  [$ Q_3 = (x_(3n\/4) + x_((3n\/4) +1)) / 2 $],
  [$ Q_3 = x^u_m + ((3n) / 4 - H_(m-1)) / (H_m - H_(m-1)) dot (x^o_m - x^u_m) $],
)

#pagebreak()

#grid(
  columns: (2.1fr, 1fr),
  [
    *Berechnung des zentralen 80%-Dezilabstand:*\
    Dazu muss das 9. Dezentil minus das 1. Dezentil gerechnet werden
    #hinweis[(beim 60%-Dezilabstand wären es 8. Dezentil minus 2. Dezentil)].
    Das erste Dezil liegt in der 2. Klasse ($fxcolor("rot", 400)\/10 = 40$),
    das letzte in der 5. Klasse ($(9 dot fxcolor("rot", 400)) \/ 10 = 360$).

    $
      D 1 = x^u_2 + ((1n\/10) - H_1) /h_2 dot (x^o_2 - x^u_2) & = 10 + (40 - 20)/160 dot (20-10) = 11.25 \
      D 9 = x^u_5 + ((9n\/10) - H_4) /h_5 dot (x^o_5 - x^u_5) & = 40 + (360 - 300)/88 dot (80-40) = 67.27 \
                                             I_80 = D 9 - D 1 & = 67.27 - 11.25 = underline(56.02)
    $
  ],
  [
    #small[
      #table(
        align: end,
        columns: (auto,) * 3 + (1fr,) + (auto,) * 2,
        table.header([*$i$*], [von ($bold(x^u_i)$)], [bis ($bold(x^o_i)$)], [*$h_i$*], [*$d_i$*], [*$H_i$*]),
        [$1$], [$4$], [$10$], [$20$], [$3.3$], [$20$],
        [$2$], [$10$], [$20$], [$160$], [$16.0$], [$180$],
        [$3$], [$20$], [$30$], [$80$], [$8.0$], [$260$],
        [$4$], [$30$], [$40$], [$40$], [$4.0$], [$300$],
        [$5$], [$40$], [$80$], [$88$], [$2.2$], [$388$],
        [$6$], [$80$], [$120$], [$12$], [$0.3$], [$400$],
        table.hline(stroke: 1.5pt + black),
        [], [], [], [$n = fxcolor("rot", 400)$], [], [],
      )
    ]
  ],
)

=== Arithmetisches Mittel (Durchschnitt) <arith-mittel>
De Durchschnitt halt, de söttsch kenne Kolleg. Häufig benutzt, kann aber zu starken Verzerrungen und Fehlschlüssen führen,
da Ausreisser den Durchschnitt stark verändern können. Darum nicht geeignet für schiefe Verteilungen, sondern nur
für eingipflige, symmetrische Verteilungen #hinweis[(z.B. Bell Curve, Normalverteilung)]

#hinweis[Auf TR: Menü $->$ 6 $->$ 3 $->$ 3: Mittelwert. Werte in geschwungene Klammer schreiben (CTRL + "`)`")]

#definition[
  #grid(
    align: horizon,
    [$ #x- = 1/n sum_(i=1)^n x_i dot h_i $],
    [
      _$bold(#x-)$:_ Arithmetisches Mittel \
      _*$n$*:_ Anzahl der Werte\
      _*$x_i$*:_ Datenwerte \
      _*$h_i$*:_ Häufigkeit der Datenwerte #hinweis[(1, wenn nichts angegeben)]
    ],
  )
]

==== Klassifiziertes Arithmetisches Mittel
Auch hier muss die _klassifizierte Häufigkeit_ wieder speziell behandelt werden:
Zuerst muss die _Klassenmitte $bold(acute(x_i))$_ für jede Klasse berechnet werden, dann die Summe von
allen $acute(x_i) dot h_i$ mit $1/n$ multiplizieren.

#definition[
  #grid(
    align: horizon,
    [
      $
        #x- = 1/n sum^v_(i=1) acute(x_i) dot h_i\ \
        acute(x_i) = (x^o_i + x^u_i)/2
      $
    ],
    [
      _$bold(#x-)$:_ Arithmetisches Mittel \
      _*$n$*:_ Anzahl der Werte\
      _*$acute(x_i)$*:_ Klassenmitte von Klasse $i$ \
      _*$h_i$*:_ Häufigkeit von Klasse $i$
    ],
  )
]

*Beispiel mit Klassen:* \
Daten siehe Beispiel-Tabelle in @klassifizierte-häufigkeit

1. Klassenmitten berechnen
$
  acute(x_i) = ((x^u_i + x^o_i) / 2) => { (0+20)/2 = 10, quad (20+40)/2 = 30, quad (40+60)/2 = 50, quad (60+80)/2 = 70}
$

2. Produkte $acute(x_i) dot h_i$ für alle Klassen berechnen
$ acute(x_i) dot h_i => {10 dot 8 = 80, quad 30 dot 40 = 1'200, quad 50 dot 80 = 4'000, quad 70 dot 32 = 2'240} $

3. Summen von allen $h_i$ und allen $acute(x_i) dot h_i$ bestimmen
$ sum^n_(i=1) h_i = 160 quad sum^n_(i=1) acute(x_i) dot h_i = 7520 $

4. Werte in Formel einsetzen
$ #x- = 1/160 dot 7'520 = underline(47.023) $

=== Harmonisches Mittel
Um den _Durchschnitt verhältnisskalierter Zahlen_ zu berechnen, verwendet man das harmonische Mittel.
Die Merkmalswerte dürfen untereinander keine gemischten Vorzeichen haben. Das einfache Harmonische Mittel wird
bei einheitslosen oder beziehungslosen Zahlen verwendet #hinweis[(siehe @gewichtet-harmonisch-mittel)].

$ overline("MH") = n / (sum^n_(i=1) 1 / x_i) $

In den allermeisten Fällen verwendet man jedoch das gewichtete harmonische Mittel.

==== Gewichtetes Harmonisches Mittel <gewichtet-harmonisch-mittel>
Ein Sonderfall sind Brüche, die Beziehungen widerspiegeln; sie werden meist mit _"x pro y"_ bezeichnet
#hinweis[(z.B. Kilometer pro Stunde, Preis pro Liter, Personen pro Quadratmeter)].
Bei diesen muss das _gewichtete Harmonische Mittel_ verwendet werden:

$ overline("MH") = (sum^v_(i=1) h_i) / (sum^v_(i=1) h_i \/ x_i) $

#example-block[
  *Beispiele für gewichtetes HM:*\
  + _Ein Kipplaster fährt auf dem $5"km"$ Hinweg $10 "km/h"$ und auf dem Rückweg $30 "km/h"$.
    Was ist die mittlere Geschwindigkeit_?

    $ h_1 = h_2 = 5"km", quad x_1 = (5"km") / (10"km/h"), quad x_2 = (5"km") / (30"km/h") $
    $
      overline("MH") = (sum^v_(i=1) h_i) / (sum^v_(i=1) h_i \/ x_i) = (5+5) / ((5\/10) + (5\/30)) = underline(15"km/h")
    $

  + _Eine moderne Abfüllanlage füllt $50'000$ Flaschen pro Stunde ab, eine ältere Anlage nur $30'000$ Flaschen pro Stunde.
    Wie viele Flaschen werden durchschnittlich pro Stunde abgefüllt, wenn auf der modernen Anlage $300'000$ Flaschen und
    auf der älteren $150'000$ Flaschen abgefüllt werden?_

    1. Aus Text Klassenmittelwerte $acute(x_i)$ suchen #hinweis[(Beziehungszahl, also Wert pro $h$)]
    $ acute(x_1) = 30'000 "Fl/h", quad acute(x_2) = 50'000 "Fl/h" $

    2. Aus Text Anzahl Merkmalsträger $h_i$ suchen #hinweis[(erreichte Anzahl X)]
    $ h_1 = 150'000 "Fl" quad h_2 = 50'000 "Fl" $

    3. Werte in Formel einsetzen
    $ overline("MH") = (30'000 + 50'000) / (300'000 \/ 50'000 + 150'000 \/ 30'000) = underline(40'909 "Fl/h") $
]

#pagebreak()

=== Geometrisches Mittel
_Die n-te Wurzel aus dem Produkt aller beobachteten Merkmalswerte._ Es zeigt die _durchschnittliche Veränderung_
zwischen Merkmalswerten auf: Sie sind Quotienten aus zeitlich benachbarten Grössen #hinweis[(z.B. Wachstum)].
Die Werte müssen wegen der Division $> 0$ sein. Funktioniert nur für mindestens verhältnisskalierte Merkmalswerte.
Nicht sinnvoll für klassifizierte Häufigkeiten.

#table(
  columns: (1fr,) * 2,
  table.header([Formel für durchschnittlichen Merkmalswert], [Formel für durchschnittliche Veränderung]),
  [$ "MG" = root(n, product^n_(i=1) x_i) $], [$ "MG" = root(n-1, "Endwert"/"Anfangswert") $],
)


#columns(2)[
  *Beispiel für durchschnittlichen Merkmalswert*\
  $x_i = (3.2, 3.1, 3.4, 3.6, 3.4, 3.1, 3.3, 1.9, 2.0)$

  + Anzahl Werte zählen\
    $n = 9$
  + Werte multiplizieren\
    $product^n_(i=1) x_i = 16048.38$
  + Geometrisches Mittel berechnen\
    $root(9, 16048.38) = 2.93$

  #colbreak()

  *Beispiel für durchschnittliche Veränderung*\
  $[40] space arrow(dot 1.2) space [48] space arrow(dot 1.25) space [60] space arrow(dot 0.95) space [57]$

  + Anzahl Werte zählen\
    $n = 4$
  + Anfangs- und Endwert in Formel einfügen\
    $root(3, 57/40) = underline(1.125)$
]

== Streumasse
Streumasse sind Kennzahlen, die die _Verteilung_ der Messwerte _um ein Zentrum_ angeben.

=== Spannweite
_Differenz aus dem grössten und kleinsten Merkmalswert._ Ist als Streumass geeignet, wenn allein die Länge
des Streubereiches interessiert, da es keine Information über die Streuung an sich liefert.
Äusserst empfindlich auf Ausreisser. Merkmale müssen mindestens _Intervallskaliert_ sein.
#hinweis[($v$ = Grösster Wert der Klasse)]

#table(
  columns: (1fr,) * 2,
  table.header([Normale Berechnung], [Klassifizierte Häufigkeit]),
  [$ R = "grösster Wert" - "kleinster Wert" $], [$ R = x^o_v - x^u_1 $],
)

*Beispiel ohne Klassen:*\
$
  x_i = (3.2, 3.1, 3.4, 3.6, 3.4, 3.1, 3.3, 1.9, 2.0) overbracket(=>, "sortieren") (1.9, 2.0, 3.1, 3.1, 3.2, 3.3, 3.4, 3.4, 3.6)
$
$ x_"min" = 1.9, quad x_"max" = 3.6 quad R = 3.6 - 1.9 = 1.7 $

*Beispiel mit Klassen:*\
Daten siehe Beispiel-Tabelle in @klassifizierte-häufigkeit\
$ x^u_1 = 0, quad x^o_v = 80, quad R = 80 - 0 = underline(80) $

=== Zentraler Quartilsabstand (ZQA)
_Abstand zwischen dem 1. & 3. Quartil._ Zeigt, wie nahe die Werte um den Median herum zusammenliegen.
Dadurch sind Ausreisser kein Problem. Ist geeignet, um den Kernbereich einer Häufigkeitsverteilung darzustellen.
Werte müssen mindestens Intervallskaliert sein.

$ "ZQA" = Q_3 - Q_1 $

#pagebreak()

*Beispiel Ausfallzeiten (in h) von $20$ Maschinen:* \
*Frage:* Wie streut die Ausfallzeit der Maschinen in Abhängigkeit von der Wahrscheinlichkeit um das Mittel $0.5$?

#grid(
  columns: (1fr, 1.0fr),
  [
    $
        Q_1 & = x_[1\/4 dot n] = x_[1\/4 dot 20] = fxcolor("rot", x_[5]) = 2h \
        Q_3 & = x_[3\/4 dot n] = x_[3\/4 dot 20] = fxcolor("grün", x_[15]) = 11h \
      "ZQA" & = 11h - 2h = underline(9h)
    $
  ],
  [
    #small[
      #table(
        columns: (auto,) + (1fr,) * 8,
        align: (x, _) => if (x > 0) { right } else { auto },
        table.header([Ausfallzeit (h)], [$0$], [$2$], [$5$], [$6$], [$7$], [$11$], [$12$], [$14$]),
        [$h_i$], [$4$], [$2$], [$2$], [$2$], [$4$], [$3$], [$2$], [$1$],
        [$H_i$], [$4$], [$fxcolor("rot", 6)$], [$8$], [$10$], [$14$], [$fxcolor("grün", 17)$], [$19$], [$20$],
      )
    ]
  ],
)

=== Mittlere absolute Abweichung
_Durchschnittliche Entfernung der Merkmalswerte vom arithmetischen Mittel._ Ist Einheitenbehaftet.
Wird häufig bei der Beschreibung der erfassten Datenmenge mit angegeben. Besser geeignet als Varianz/Standardabweichung.
Ausreisser werden erfasst, Gefahr einer verzerrten Beschreibung entsteht.

#definition[
  #grid(
    columns: (1fr, 1.2fr),
    align: horizon,
    [$ delta = 1 / n sum^v_(i=1) abs(x_i - #x-) $],
    [
      _*$n$*:_ Anzahl der Merkmalsträger\
      _*$v$*:_ Anzahl der verschiedenen Merkmalswerte\
      _*$x_i$*:_ Merkmalswert mit Index $i$\
      _*$h_i$*:_ absolute einfache Häufigkeit beim Merkmalswert $x_i$\
      _$bold(#x-)$:_ arithmetisches Mittel der Merkmalswerte
    ],
  )
]

Bei der Klassifizierten Häufigkeit wird die Klassenmitte $acute(x)$ verwendet und zusätzlich noch die
absolute einfache Häufigkeit $h_i$ dazugerechnet:

#definition[
  #grid(
    columns: (1fr, 1.2fr),
    align: horizon,
    [$ delta = 1 / n sum^v_(i=1) abs(acute(x_i) - #x-) dot h_i $],
    [
      _*$n$*:_ Anzahl der Merkmalsträger\
      _*$v$*:_ Anzahl der verschiedenen Merkmalswerte\
      _*$h_i$*:_ absolute einfache Häufigkeit beim Merkmalswert $x_i$\
      _$bold(#x-)$:_ arithmetisches Mittel der Merkmalswerte \
      _*$acute(x_i)$*:_ Klassenmitte
    ],
  )
]

*Beispiel ohne Klassen:* \
Urliste: $x_i = (3.2, 3.1, 3.4, 3.1, 1.9, 2.0)$
1. Arithmetisches Mittel berechnen #hinweis[(Berechnung des Werts siehe @arith-mittel)]
$ n = 6, quad #x- = 2.78 $

#v(-0.5em)
2. Werte in Formel einsetzen
$
  delta & = 1/6 dot abs(3.2 - 2.78) + abs(3.1 - 2.78) + abs(3.4 - 2.78) + abs(3.1 - 2.78) + abs(1.9 - 2.78) + abs(2.0 - 2.78)\
        & = 1/6 dot 3.34 = underline(0.556)
$

#v(-0.5em)
*Beispiel mit Klassen:* \
Daten siehe Beispiel-Tabelle in @klassifizierte-häufigkeit\:
1. Arithmetisches Mittel berechnen #hinweis[(Berechnung des Werts siehe @arith-mittel)]:
$ #x- = 47.023 $
#v(-0.5em)

2. Für jede Klasse $abs(acute(x_i) - #x-)$ berechnen
$
  abs(acute(x_i) - #x-) => {abs(10 - 47.023) = 37.023, abs(30 - 47.023) = 17.023, abs(50 - 47.023) = 2.977,
  abs(70 - 47.023) = 22.977}
$

3. Für jede Klasse $abs(acute(x_i) - #x-) dot h_i$ berechnen
$
  abs(acute(x_i) - #x-) dot h_i => {8 dot 37.023 = 296.184, 40 dot 17.023 = 680.92, 80 dot 2.977 = 239.76,
  32 dot 22.977 = 735.264}
$

4. Summieren und in Formel einfügen
#v(-0.5em)
$ delta = 1/4 dot (296.184 + 680.92 + 239.76 + 735.264) = 1/4 dot 1'952.128 = underline(488.032) $


=== Varianz & Standardabweichung
_Die Varianz ($bold(sigma^2)$ bzw. $bold("var"(x))$) ist die Verteilung der Werte um das arithmetische Mittel._
Die Varianz ist aufgrund der Quadrierung in einer anderen Einheit als die Messwerte und kann darum häufig nicht
für konkrete Aussagen verwendet werden #hinweis[(z.B. $"Jahre"^2$)].

_Die Standardabweichung $bold(sigma)$ ist die durchschnittliche Entfernung aller Werte vom arithmetischen Mittel_ und
die Quadratwurzel der Varianz. Dadurch ist die Standardabweichung wieder in derselben Einheit wie die Messwerte und
kann konkrete Angaben liefern #hinweis[(z.B. die Länge weicht durchschnittlich 5.2cm vom Mittelwert 25cm ab.)]

Beide Kennzahlen sind _nur Vergleichswerte_ und liefern nur Informationen über mehr/weniger Streuung.
Sind empfindlich auf Ausreisser.

#table(
  columns: (1fr,) * 3,
  align: horizon,
  table.header([Normale Varianz-Berechnung], [Klassifizierte Häufigkeit-Varianz], [Standardabweichung]),
  [$ sigma^2 = 1/n sum^v_(i=1) (x_i - #x-)^2 $],
  [$ sigma^2 = 1/n sum^v_(i=1) (x_i - #x-)^2 dot h_i $],
  [$ sigma = sqrt(sigma^2) $],
)

*Beispiel ohne Klassen:* \
Urliste: $x_i = (3.2, 3.1, 3.4, 3.1, 1.9, 2.0)$

1. Arithmetisches Mittel berechnen
$ n = 6 quad #x- = 2.78 $

2. Varianz berechnen
$
  sigma^2 & = 1/6 dot ((3.2 - 2.78)^2 + (3.1 - 2.78)^2 + (3.4 - 2.78)^2 + (3.1 - 2.78)^2 + (1.9 - 2.78)^2 + (2.0 - 2.78)^2)\
          & = 1/6 dot 2.1484 = underline(0.358)
$

3. Standardabweichung berechnen\
$ sigma = sqrt(0.358) = underline(0.598) $

*Beispiel mit Klassen:*\
Daten siehe Beispiel-Tabelle in @klassifizierte-häufigkeit

1. Arithmetisches Mittel berechnen #hinweis[Berechnung des Werts siehe @arith-mittel]
$ #x- = 47.023 $

2. Für jede Klasse $(acute(x_i) - #x-)^2$ berechnen
$ (acute(x_i) - #x-)^2 => {(10 - 47.023)^2 = 1'370, (30-47.023)^2 = 289, (50-47.023)^2 = 8.86, (70-47.023)^2 = 528} $

3. Für jede Klasse $(acute(x_i) - #x-)^2 dot h_i$ berechnen
$
  (acute(x_i) - #x-)^2 dot h_i => {1'370 dot 8 = 10'960, 289 dot 40 = 11'560, 8.86 dot 80 = 708.8, 528 dot 32 = 16'896}
$

4. $h_i$ und $(acute(x_i) - #x-)^2 dot h_i$ summieren und in Formel einfügen
$ sigma^2 = 1/4 dot (10'960 + 11'560 + 708.8 + 16'896) = 1/4 dot 40124.8 = underline(10'031.2) $

5. Standardabweichung berechnen
$ sigma = sqrt(10'031.2) = underline(100.15) $

=== Variationskoeffizient
_Misst die relative Streuung in Relation zur Lage der Häufigkeitsverteilung._ Wird aus der Standardabweichung und
dem arithmetischem Mittel berechnet. Dient aufgrund dessen ebenfalls nur als _Vergleichswert_.
Kann zum Vergleich unterschiedlicher Mittelwerte und Dimensionen verwendet werden.

#definition[
  #grid(
    columns: (1fr, 1.2fr),
    align: horizon,
    [$ "VK" = sigma/#x- dot 100 $],
    [
      _*$sigma$*:_ Standardabweichung\
      _$bold(#x-)$:_ arithmetisches Mittel der Merkmalswerte
    ],
  )
]

*Beispiel:*\
In welchem Laden ist die Streuung der Preise für ein Produkt geringer?\
*Gegeben:*
$dash(x)_A = 7 "CHF", quad sigma_A = 2.80 "CHF", quad dash(x)_B = 750 "CHF", quad sigma_B = 20.40 "CHF"$

$ "VK"_A = 2.80/7 dot 100 = 40%, quad "VK"_B = 20.40/750 dot 100 = 2.72 % & $
*Schlussfolgerung:*
Die Streuung der Preise für B ist relativ geringer als für A.

== Übersicht Lageparameter & Streumasse
#table(
  columns: (auto,) + (1fr,) * 4,
  table.header([Parameter], [Nominalskala], [Ordinalskala], [Intervallskala], [Verhältnisskala]),
  [Modus], cell-check, cell-check, cell-check, cell-check,
  [Median], cell-cross, cell-check, cell-check, cell-check,
  [Perzentil], cell-cross, cell-check, cell-check, cell-check,
  [Arithmetisches Mittel], cell-cross, cell-cross, cell-check, cell-check,
  [Harmonisches Mittel], cell-cross, cell-cross, cell-cross, cell-check,
  [Geometrisches Mittel], cell-cross, cell-cross, cell-cross, cell-check,
  [Spannweite], cell-cross, cell-cross, cell-check, cell-check,
  [Zentraler Quartilsabstand], cell-cross, cell-cross, cell-check, cell-check,
  [Mittlere absolute Abweichung], cell-cross, cell-cross, cell-check, cell-check,
  [Varianz & Standardabweichung], cell-cross, cell-cross, cell-check, cell-check,
  [Variationskoeffizient], cell-cross, cell-cross, cell-cross, cell-check,
)

#grid(
  columns: (1.5fr, 1fr),
  [
    == Boxplot
    Fasst verschiedene _Streuungs- und Lagemasse_ in _einer Darstellung_ zusammen und vermittelt einen _schnellen Eindruck_,
    in welchem Bereich sich die Daten befinden und wie sie sich über diesen Bereich verteilen.
  ],
  image("img/ExEv_02.png"),
)


= Zeitreihen, Regression & Korrelation
Bei der _Untersuchung des Zusammenhangs_ zwischen zwei Merkmalen $X$ und $Y$ interessieren folgende Fragen:
- Besteht ein _Zusammenhang_ zwischen $X$ und $Y$? #hinweis[(Feststellung der Abhängigkeit)]
- Von welcher _Form_ ist der Zusammenhang? #hinweis[(Regressionsanalyse)]
- Von welcher _Stärke / Intensität_ ist der Zusammenhang? #hinweis[(Korrelationsanalyse)]

== Zeitreihen
Eine Zeitreihe ist eine _zeitlich geordnete Folge_ von Merkmalswerten. Es besteht ein Zusammenhang zwischen
dem Merkmalsträger $x$ und den diskreten Zeitpunkten $t_i$. Alle Datensätze, die als $x$-Achse die Zeit besitzen,
sind Zeitreihen. Mithilfe der _Zeitreihenanalyse_ können Strukturen und Gesetzmässigkeiten einer Zeitreihe erkannt werden.

Ein _Trend_ beschreibt die langfristige Grundrichtung einer Zeitreihe, er erlaubt einen #hinweis[(vorsichtigen)] Blick
in die Zukunft. Trends können linear, exponentiell, polynomial oder logistisch sein.

=== Gleitender Mittelwert
Um zu verhindern, dass besondere Ereignisse einen grundlegenden Verlauf verschleiern, werden Werte _geglättet_.
Mit dem _gleitenden Mittelwert_ wird aus einer bestimmten Anzahl Vergangenheitswerten sowie dem Gegenwartswert ein
Mittelwert gebildet. Dieser dient als Prognose bzw. Trenderkennung für die kommende Periode.

#definition[
  #grid(
    columns: (55%, 45%),
    align: horizon,
    [$ M_t = 1/t dot (sum^(t-1)_(T=0) x_T) + x_t $],
    [
      _*$t$*:_ Fenstergrösse\
      _*$x_T$*:_ Vergangenheitswerte\
      _*$x_t$*:_ Gegenwartswert\
    ],
  )
]

*Beispiel zur Glättung:*\
Mit einer Fenstergrösse von $t = 3$ wird $y_i = (851, 863, 878, 792, 589, 851, 863)$ geglättet:
$ M_3 = 1/3 dot (851 + 863 + 878) = 864 quad M_4 = 1/3 dot (863 + 878 + 792) = 844 quad ... $
$ y_"geglättet" = (864, 844, 753, 744, 768) $

*Beispiel zur Prognose:* \
Eine Firma hat in den letzten 6 Jahren diese Anzahl Maschinen verkauft. Welcher Absatz ist für 2024 zu erwarten?

#columns(2)[
  #table(
    columns: (auto,) * 7,
    [2018], [2019], [2020], [2021], [2022], [2023], [2024],
    [3], [7], [14], [8], [3], [1], [?],
  )

  #colbreak()

  $M_7 & = 1/6 dot sum^(5)_(T=1) x_T + x_6\
       & = 1/6 dot (3 + 7 + 14 + 8 + 3 + 1) = 36/6 = underline(6)$
]

Hier zeigt sich die Schwachstelle des gleitenden Mittelwerts zur Prognose: Obgleich fallender Verkaufszahlen liegt
der prognostizierte Wert darüber. Darum verwendet man in solchen Fällen besser die Regression.

== Regression
#grid(
  columns: (1.5fr, 1fr),
  gutter: 1em,
  [
    Beim Experimentieren entstehen _Zahlentupel_: Ein _Faktorwert *$x_i$*_ #hinweis[(Input, "control")] und
    ein _Ergebniswert *$y_i$*_ #hinweis[(Output, "response")]. Ziel ist es, die Form/Tendenz des Zusammenhangs durch
    eine mathematische Funktion zu beschreiben, die _Regressionsfunktion_. Mit dieser ist auch eine Interpolation möglich.
    Für Regressionen müssen die Merkmalswerte mindestens _intervallskaliert_ sein.

    Durch eine _Regressionsanalyse_ kann der funktionale Zusammenhang zwischen einer abhängigen und einer
    unabhängigen Grösse anhand von Einzelmessungen modelliert werden. Werden die Wertekombinationen #hinweis[($x$, $y$)]
    der Merkmalsträger in ein Koordinatensystem eingetragen, ergibt sich ein _Streuungsdiagramm_ (Punktewolke).
  ],
  image("img/ExEv_03.png"),
)

=== Regressfunktion
Je nach Abhängigkeit der Parameter voneinander wird für die Regression eine andere _Regressfunktion_ verwendet.
#definition[
  Bei _einseitiger_ Beeinflussung #hinweis[($y$ wird nur durch Parameter $x$ bestimmt)] gilt diese Regressfunktion:
  $
    hat(y) = a_1 + b_1 dot x_i, quad quad quad a_1 = #y- - b_1 dot #x-, quad quad quad
    b_1 = (sum^n_(i=1) x_i dot y_i - n dot #x- dot #y-) / (sum^n_(i=1) x_i^2 - n dot #x-^2)
  $

  Bei _wechselseitiger_ Beeinflussung #hinweis[($x$ und $y$ beeinflussen sich gegenseitig)] oder unbekannter Abhängigkeit gilt:
  $
    hat(x) = a_2 + b_2 dot y_i, quad quad quad a_2 = #x- - b_2 dot #y-, quad quad quad
    b_2 = (sum^n_(i=1) x_i dot y_i - n dot #x- dot #y-) / (sum^n_(i=1) y_i^2 - n dot #y-^2)
  $
]

#table(
  columns: (25%, 75%),
  table.header([Regressvariable], [Definition]),
  [Regressionsgerade $hat(y)$],
  [
    Beschreibt den Zusammenhang zwischen dem unabhängigen Merkmal $X$ und dem abhängigen Merkmal $Y$.
    Je stärker die Abweichung, desto stärker der Zusammenhang.
  ],

  [Regressionsparameter $b_1$],
  [
    Steigungsmass, um wie viele Einheiten sich $Y$ tendenziell ändert, wenn $X$ um eine Einheit grösser wird.
    Entspricht bei der linearen Regression der Geradensteigung.
  ],

  [Regressionsparameter $a_1$], [Tendenzieller Wert des Merkmals $Y$, wenn der Wert von $X = 0$],
)

=== Lineare Regression <lin-reg>
Bei der linearen Regression wird ein Modell anhand einer Geraden erstellt.
Dieses kann dann mithilfe der Methode der _kleinsten Quadrate (Mean Squared Error)_ bewertet werden.

*Beispiel mit einseitiger Beeinflussung:* \
Gegeben sind $x_i$ und $y_i$, die restlichen Tabellenwerte müssen berechnet werden.

#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    + $y_i$, $x_i dot y_i$ und $x_i^2$ ausrechnen #hinweis[(siehe Tabelle)]

    + Arithmetisches Mittel für $x$ und $y$ berechnen.
    $
      n = 7, quad
      #x- = (#fxcolor("grün", $sum^n_1 x_i$))/n = #fxcolor("grün", "28")/7 = 4, quad
      #y- = (#fxcolor("orange", $sum^n_1 y_i$))/n = #fxcolor("orange", "60.9")/7 = 8.7
    $

    3. $a$ und $b$ berechnen\
    $
      b & = (#fxcolor("rot", $sum^n_(i=1) x_i dot y_i$) - n dot #x- dot #y-)
          / (#fxcolor("dunkelblau", $sum^n_(i=1) x_i^2$) - n dot #x-^2)
          = (#fxcolor("rot", "290.6") - 7 dot 4 dot 8.7)/(#fxcolor("dunkelblau", "140") - 7 dot 4^2) = 1.68 \
      a & = #y- - b dot #x- = 8.7 - 1.68 dot 4 = 1.98
    $

    4. $a$ und $b$ in lineare Regressionsformel eintragen\
    $ f(x) = a + b dot x = underline(1.98 + 16.8 dot x) $
  ],
  [
    #table(
      rows: 2.0em,
      columns: (1fr,) * 4,
      align: horizon + right,
      table.header([*$x_i$*], [*$y_i$*], [*$x_i dot y_i$*], [*$x_i^2$*]),
      [1], [3.2], [3.2], [1],
      [2], [4.2], [8.4], [4],
      [3], [9], [27], [9],
      [4], [8], [32], [16],
      [5], [12], [60], [25],
      [6], [11.5], [69], [36],
      [7], [13], [91], [49],
      table.hline(stroke: 1.5pt + black),
      table.footer(
        [$bold(Sigma) space #fxcolor("grün", "28")$],
        [$#fxcolor("orange", "60.9")$],
        [$#fxcolor("rot", "290.6")$],
        [$#fxcolor("dunkelblau", "140")$],
      ),
    )
  ],
)

#pagebreak()

=== Exponentielle Regression
Folgt der Trend des Streuungsdiagramm einem exponentiellen Verlauf, kann ein exponentielles Modell erstellt werden.
Mit Anwendung des natürlichen Logarithmus kann die exponentielle Verteilung linearisiert werden:
$
  underbracket(y'_i = ln(y_i), "So kommt man auf" y'_i) quad quad
  underbracket(y_i (x_i) = e^(a + b dot x_i), "Das ist die exponentielle Regression") quad quad
  underbracket(f(x) = ln(y_i (x_i)) = a + b dot x_i, "So wird sie in lineare Regression umgewandelt")
$

*Beispiel:*
#grid(
  columns: (2fr, 1.1fr),
  gutter: 1em,
  [
    + $y'_i = ln(y_i)$, $x_i dot y'_i$ und $x_i^2$ ausrechnen #hinweis[(siehe Tabelle)]

    + Arithmetisches Mittel von $x$ und $y'$ ausrechnen.
    $
      n = 7, quad
      #x- = (sum^n_1 x_i)/n = 28/7 = 4, quad
      #y-' = (sum^n_1 y_i)/n = 2.46/7 = 0.35
    $

    3. $a$ und $b$ mit linearer Regressionsformel berechnen
    $
      b & = (sum^n_(i=1) x_i dot y'_i - n dot #x- dot #y-') / (sum^n_(i=1) x_i^2 - n dot #x-^2)
          = (27.91 - 7 dot 4 dot 0.35)/(140 - 7 dot 4^2) = 0.65 \
      a & = #y-' - b dot #x- = 0.35 - 0.65 dot 4 = -2.25
    $

    4. $a$ und $b$ in die exponentielle Polynomformel einsetzen
    $ f(x) = e^(a+b dot x) = underline(e^(-2.25 + 0.65 dot x)) $
  ],
  [
    #table(
      rows: 2.0em,
      columns: (auto,) * 5,
      align: horizon + right,
      table.header([*$x_i$*], [*$y_i$*], [*$y'_i$*], [*$x_i dot y'_i$*], [*$x_i^2$*]),
      [1], [0.20], [-1.61], [-1.61], [1],
      [2], [0.40], [-0.92], [-1.84], [4],
      [3], [0.80], [-0.22], [-0.66], [9],
      [4], [1.44], [0.36], [1.44], [16],
      [5], [2.40], [0.88], [4.40], [25],
      [6], [5.00], [1.16], [9.66], [36],
      [7], [10.60], [2.36], [16.52], [49],
      table.hline(stroke: 1.5pt + black),
      table.footer([$bold(Sigma) space 28$], [$20.84$], [$2.46$], [$27.91$], [$140$]),
    )
  ],
)

==== Logarhitmische Regression
Die Logarhitmische Regression funktioniert vom Vorgehen ähnlich wie die exponentielle, hat jedoch eine andere Zielformel:
$
  underbracket(y'_i = e^(y_i), "So kommt man auf" y'_i) quad quad
  underbracket(y_i (x_i) = ln(a + b dot x), "Das ist die logarithmische Regression") quad quad
  underbracket(f(x) = e^(a+b dot x), "So wird sie in lineare Regression umgewandelt")
$

#pagebreak()

=== Polynomiale Regression
Ist kein _linearer_ oder _exponentieller_ Verlauf sichtbar, kann eine _Polynomiale Regression_ durchgeführt werden.
Der Grad des Polynoms kann ebenfalls festgelegt werden, allerdings wird in der Praxis selten höher als der 3. Grad berechnet.
Für die polynomiale Regression ist die Berechnung des Korrelationskoeffizienten nicht sinnvoll.
$ f(x) = a_0 + a_1(x-x_1) + a_2(x-x_1)(x-x_2) + ... + a_n (x-1)...(x-x_n) $

Um die Werte für die polynomiale Regression zu bestimmen, wird der _Newton-Algorithmus_ angewendet.
Dieser berechnet rekursiv die Koeffizienten $a$ des Polynoms. In jedem Schritt werden die $x$ und $y$-Werte des momentanen und
des vorherigen Wertes durch die Spanne der x-Werte dividiert.

$
  D_(i,i-1) = (y_i - y_(i-1))/(x_i - x_(i-1)) quad => quad
  D_(2,1) = (y_2 - y_1)/(x_2 - x_1) quad => quad
  D_(3,2,1) = (D_(2,3) - D_(2,1))/(x_3 - x_1)
$

*Beispiel:*\
+ Alle notwendigen $D_(i,...,i-n)$ berechnen
#table(
  columns: (auto,) * 6,
  align: right,
  table.header([*$x_i$*], [*$y_i$*], [*$D_(i,i-1)$*], [*$D_(i,...,i-2)$*], [*$D_(i,...,i-3)$*], [*$D_(i,...,i-4)$*]),
  [$1$], [$52.5$], [---], [---], [---], [---],

  [$2$], [$34.0$], [$D_(2,1) = (34 - 52.5) / (2 - 1) = -18.5$], [---], [---], [---],

  [$3$],
  [$13.5$],
  [$D_(3,2) = (13.5 - 34) / (3 - 2) = -20.5$],
  [$D_(3,2,1) = (-20.5 - (-18.5)) / (3-1) = -1$],
  [---],
  [---],

  [$4$],
  [$0$],
  [$D_(4,3) = (0 - 13.5)/(4 - 3) = -13.5$],
  [$D_(4,3,2) = (-13.5 -(-20.5))/(4-2) = 3.5$],
  [$D_(4,3,2,1) = (3.5 - (-1)) / (4-1) = 1.5$],
  [---],

  [$5$],
  [$2.5$],
  [$D_(5,4) = (2.5 - 0) / (5 - 4) = 2.5$],
  [$D_(5,4,3) = (2.5 - (-13.5)) / (5-3) = 8$],
  [$D_(5,4,3,2) = (8 - 3.5) / (5-2) = 1.5$],
  [$D_(5,4,3,2,1) = 0$],

  [$6$], [$30$], [$D_(6,5) = 27.5$], [$D_(6,5,4) = 12.5$], [$D_(6,5,4,3) = 1.5$], [$D_(6,5,4,3,2) = 0$],

  [$7$], [$91.5$], [$D_(7,6) = 61.5$], [$D_(7,6,5) = 17$], [$D_(7,6,5,4) = 1.5$], [$D_(7,6,5,4,3) = 0$],
)
#hinweis[($D_(i,...,i-5)$ und $D_(i,...,i-6)$ wurden aus Platzgründen weggelassen, haben aber alle den Wert 0.)]

2. Die hintersten $D_(i,...,i-n)$ in einer Zeile als $a_i$ einsetzen.
  $
    a_0 = y_1 = 52.5 quad a_1 = D_(2,1) = -18.5 quad
    a_2 = D_(3,2,1) = -1 quad a_3 = D_(4,3,2,1) = 1.5 quad a_4 = a_5 = a_6 = 0
  $

+ Die $a$'s in die Polynomformel einsetzen\
  $ f(x) = 53.5 - 18.5(x-1) - 1(x-1)(x-2) + 1.5(x-1)(x-2)(x-3) $

+ Das Polynom ausmultiplizieren
  $ underline(f(x) = 1.5x^3 - 10x^2 + x + 60) $

#hinweis[(Die Werte sind hier ab $a_4$ alle 0, daher ist das Polynom vom Grad 3. Die Werte sind in diesem Fall exakt 0,
da sie direkt von einem Polynom 3. Grades stammen)]

#pagebreak()

=== Logistische/Qualitative Regression
#grid(
  columns: (2fr, 1fr),
  align: horizon,
  [
    Die Logistische Regression unterscheidet sich von den bisherigen Typen, da sie prüft, ob eine _Abhängigkeit_ zwischen
    einer binären Variable und einer oder mehreren unabhängigen Variablen besteht. D.h. Sie _beantwortet `true/false`-Fragen_.

    Die Output-Werte liegen immer _zwischen 0 und 1_. Dazwischen muss ein Wert für die _Entscheidungsschwelle_ festgelegt werden, also die Grenze, bei der zwischen `true/false` gewechselt wird.

    Sie wird nicht mit der kleinsten-Quadrate-Methode #hinweis[(Mean Squared Error)], sondern mit der Maximum-Likelihood-Methode oder der Sigmoid-Funktion berechnet.
    Ist die Grundlage für Klassifizierungs-Algorithmen und neuronale Netze.
  ],
  image("img/ExEv_04.png"),
)

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Logistische Regressionsformel], [Sigmoid-Funktion]),
  [
    $
      P(Y_k = 1) = (exp(beta_0 + sum^n_(i=1) beta_i dot X_(k dot i))) / (1 + exp(beta_0 + sum^n_(i=1) beta_i dot X_(k dot i)))
    $
  ],
  [$ f(x) = 1/(1+e^(-(x))) $],
)

== Korrelation
Eine Korrelation beschreibt eine Beziehung zwischen zwei oder mehreren Merkmalen, Zuständen oder Funktionen.
_Die Beziehung muss keine kausale Beziehung sein_: manche Elemente eines Systems beeinflussen sich gegenseitig nicht,
oder es besteht eine stochastische, also vom Zufall beeinflusste Beziehung zwischen ihnen. Korrelation ist nur ein _Indiz_
für einen kausalen Zusammenhang. Um dies festzustellen, ist die Zusammenarbeit mit Fachkundigen nötig.

Die _Autokorrelation_ ist die Korrelation eines Merkmals mit sich selbst zu einem früheren Zeitpunkt #hinweis[(anstatt mit
einem anderen Merkmal)]. Damit können Vergleiche zwischen aktuellen und vergangenen Daten aufgestellt werden.

Die _Korrelationsanalyse_ hat die Aufgabe, die Intensität des rechnerischen #hinweis[(nicht des kausalen)] Zusammenhangs
festzustellen und aufzuzeigen, wie gross der Einfluss des einen Merkmals auf das andere ist.
Dafür werden _Kenngrössen_ benötigt. Welches Verfahren im speziellen Fall eingesetzt werden darf, hängt von der
_Skalierung_ der Merkmale ab. Da wir aber immer davon ausgehen, dass beide Merkmale mindestens intervallskaliert sind,
wird in ExEv immer der Korrelationskoeffizient von Bravais Pearson (siehe @pearson) angewendet.

=== Zusammenhang
Zwei Merkmale sind _statistisch unabhängig_, wenn der Wert des einen Merkmals nicht vom Wert des anderen Merkmals abhängt.
Zu unterscheiden sind eine _formale Abhängigkeit_ #hinweis[(eine zahlenmässig begründete Abhängigkeit zwischen den Merkmalen)]
und _Sachliche Abhängigkeit_ #hinweis[(verursacht der Wert des einen Merkmals den Wert des anderen $->$ Kausalität)].

#pagebreak()

=== Korrelationskoeffizient von Pearson <pearson>
Der Korrelationskoeffizient von Bravais Person _zeigt die Stärke des linearen Zusammenhangs an_. Bei einem Wert gegen
_*$+1$*_ ist ein starker _positiver/gleichläufiger_ Zusammenhang vorhanden #hinweis[(wird $x$ grösser, wird $y$ auch grösser)],
bei Werten gegen _*$-1$*_ ein starker _negativer/gegenläufiger_ Zusammenhang #hinweis[(wird $x$ grösser, wird $y$ kleiner)].
Ist das Resultat nahe _*$0$*_, besteht _kein_ linearer Zusammenhang. Bei entgegengesetzter Steigung der Variablen ist keine
Bestimmung möglich. Nur bei linearer Regression sinnvoll.

Die _Kovarianz_ ist ein Mass für die Streuung der Merkmalsträger bzw. deren Kombinationen ($x_i, y_i$) um das arithmetische
Mittel $#x-, #y-$. Sie berechnet die Varianz in Bezug auf die Abhängigkeit zweier Variablen.
Die Kovarianz wird dann auf den Wertebereich $[-1, 1]$ normiert; so entsteht der _Korrelationskoeffizient_.

#table(
  columns: (40%, 60%),
  align: horizon,
  table.header([Kovarianz], [Korrelationskoeffizient]),
  [$ sigma_(X Y) = 1/n sum^n_(i=1) (x_i - #x-) dot (y_i - #y-) $],
  [
    $
      r = (sigma_(X Y))/(sigma_X dot sigma_Y)
      = (sum^n_(i=1) (x_i - #x-) dot (y_i - #y-)) / (sqrt((sum^n_(i=1) (x_i - #x-)^2) dot (sum^n_(i=1) (y_i - #y-)^2)))
    $
  ],
)

*Beispiel:* Werte aus 1. Aufgabe von @lin-reg
#small[
  #table(
    columns: (1fr,) * 6 + (auto,),
    align: right,
    table.header(
      [*$x_i$*],
      [*$y_i$*],
      [*$x_i dot y_i$*],
      [*$x_i^2$*],
      [*$(x_i-#x-)^2$*],
      [*$(y_i-#y-)^2$*],
      [*$(x_i-#x-) dot (y_i-#y-)$*],
    ),
    [$1$], [$3.2$], [$3.2$], [$1$], [$9$], [$30.25$], [$16.5$],
    [$2$], [$4.2$], [$8.4$], [$4$], [$4$], [$20.25$], [$9$],
    [$3$], [$9$], [$27$], [$9$], [$1$], [$0.09$], [$-0.3$],
    [$4$], [$8$], [$32$], [$16$], [$0$], [$0.49$], [$0$],
    [$5$], [$12$], [$60$], [$25$], [$1$], [$10.89$], [$3.3$],
    [$6$], [$11.5$], [$69$], [$36$], [$4$], [$7.84$], [$5.6$],
    [$7$], [$13$], [$91$], [$49$], [$9$], [$18.49$], [$12.9$],
    table.hline(stroke: 1.5pt + black),
    table.footer([$bold(Sigma) space 28$], [$60.9$], [$290.6$], [$140$], [$28$], [$88.3$], [$47$]),
  )
]
+ $(x_i-#x-)^2$, $(y_i-#y-)^2$ und $(x_i -#x-) dot (y_i-#y-)$ ausrechnen (siehe Tabelle)

+ Kovarianz berechnen
$
  sigma_(x y) & = 1/n sum^n_(i=1) (x_i - #x-) dot (y_i - #y-) \
              & = 47/7 = 6.71
$

3. Standardabweichungen $sigma_x$ und $sigma_y$ berechnen\
$
  sigma_x & = sqrt((sum^n_(i=1) (x_i-#x-)^2)/n) = sqrt(28/7) = 2 \
  sigma_y & = sqrt((sum^n_(i=1) (y_i-#y-)^2)/n) = sqrt(88.3/7) = 3.55
$

4. Kovarianzkoeffizient berechnen\
$ r = sigma_(x y)/(sigma_x dot sigma_y) = 6.71/(2 dot 3.55) = underline(0.95) $
$=>$ starker positiver Zusammenhang

#hinweis[*Achtung:* Wird das wrstat TR Skript "linreg" verwendet, werden beim Schritt drei nicht die Standardabweichungen, sondern die Varianzen angegeben (also ohne $sqrt(.)$)]

#pagebreak()

= Wahrscheinlichkeit
Die Wahrscheinlichkeitsrechnung befasst sich mit _Zufallsexperimenten._ Dabei ist der Ausgang nicht (exakt) vorhersagbar.
Wir erhalten unter "_gleichen_ Versuchsbedingungen" jeweils _verschiedene_ Ergebnisse.
Aufgabe der Wahrscheinlichkeitsrechnung ist es, die Wahrscheinlichkeit für den (Nicht-)Eintritt eines Ereignisses zu bestimmen.

== Zufallsexperimente
- _Zufallsexperiment:_ Vorgang, der als beliebig oft wiederholbar angesehen werden kann und dessen Ergebnis vom Zufall abhängt.
  #hinweis[(z.B. Werfen eines Würfels)]
- _Zufallsvorgang:_ Vorgang, dessen Ausgang aufgrund von Unkenntnis oder Unwissenheit nicht vorhergesagt werden kann.
- _Ergebnis:_ Die einzelnen, sich gegenseitig ausschliessenden möglichen Ausgänge eines Zufallsexperiments, also der
  tatsächlich eingetretene Fall/Messwert #hinweis[(z.B. Werfen einer 5 mit einem Würfel)]
- _Ereignis:_ Ergebnisse können zu Ereignissen zusammengefasst werden. Diese Teilmengen werden mit Grossbuchstaben
  gekennzeichnet. #hinweis[(z.B Würfeln einer geraden Augenzahl $A = {2,4,6}$)]
- _Elementarereignis ${omega}$:_ Ein Ereignis, welches nur ein Ergebnis beinhaltet. Teilmenge von $Omega$.
- _Ergebnismenge $Omega$_: Alle möglichen Ergebnisse eines Zufallsexperiments. Sie kann endlich #hinweis[(Werfen eines Würfels
  $Omega = {1,...,6}$)], unendlich #hinweis[(Lebensdauer eines Geräts $Omega = {omega in RR | omega >= 0}$)] oder binär sein
  #hinweis[(Gerät funktionstüchtig $Omega = {0, 1}$)].

== Wahrscheinlichkeitsraum
Ein _Wahrscheinlichkeitsraum (*$Omega, cal(A), Rho$*)_ wird zur mathematischen Beschreibung von Zufallsexperimenten verwendet.
Ein Wahrscheinlichkeitsraum wird mittels drei Elementen beschrieben:
- Der _Ergebnismenge_ $Omega$ mit allen möglichen Ergebnissen des Zufallsexperiments.
- Dem _System der Ereignisse_ $cal(A)$, eine Menge von Teilmengen von $Omega$.
- Dem _Wahrscheinlichkeitsmass_ $Rho : cal(A) -> [0, 1]$, welchem jedem Ereignis eine Wahrscheinlichkeit
  zwischen 0 und 1 zuordnet.


=== System der Ereignisse
Alle Ereignisse eines Vorgangs zusammengefasst bilden ein _System der Ereignisse_, bezeichnet mit kalligrafischen
Grossbuchstaben $cal(A\, B\, C...)$. Damit können Relationen gebildet werden #hinweis[(Vereinigungen, Durchschnitt etc.)].

Jedes System der Ereignisse enthält folgende Ereigniskombinationen:
- _$bold(A union B)$ - Oder:_ Eines der beiden Ergebnisse tritt ein
- _$bold(A inter B)$ - Und:_ Beide Ereignisse treffen ein
- _Komplementärereignis $bold(dash(A))$/$bold(A^complement)$_: Das Gegenereignis tritt auf #hinweis[("nicht $A$")]
- _Sicheres Ereignis:_ Die Ergebnismenge $Omega$ #hinweis[(alle Ergebnisse zusammen)] tritt immer ein
- _Unmögliches Ereignis $bold(emptyset)$:_ Ereignis tritt nie ein, beschrieben durch die leere Menge.
  Immer in $Omega$ enthalten. #hinweis[(0 würfeln)]
- _Unvereinbares/Disjunktes Ereignis:_ Ereignisvereinigung kann nie gleichzeitig eintreten:\
  $A inter B = emptyset$ #hinweis[(1 Würfel zeigt nie 3 und 5 gleichzeitig)]

=== Wahrscheinlichkeitsmass
Das _Wahrscheinlichkeitsmass $bold(Rho)$_ ordnet jedem Ereignis $A$ eine Wahrscheinlichkeit $Rho(A)$ zwischen 0 und 1 zu.
Die Summe aller Wahrscheinlichkeiten in einem Wahrscheinlichkeitsraum (also $Rho(Omega)$) ist immer $1$.
#small[
  #table(
    columns: (auto, 1fr),
    table.header([Rechenregel], [Formel]),
    [Gegenwahrscheinlichkeit], [$Rho(A^complement) = 1 - Rho(A)$],

    [Unmögliches Ereignis], [$Rho(emptyset) = 0$],

    [Monotonieeigenschaft],
    [$A subset B => Rho(A) <= Rho(B)$ #hinweis[(wenn $A$ in B enthalten, muss B mind. gleich gross wie A sein)]],

    [Additionssatz #hinweis[(mit Überlappung)]],
    [$Rho(A union B) = Rho(A) + Rho(B) - Rho(A inter B)$ #hinweis[(Schnittmenge entfernen, sonst doppelt)]],

    [Additionssatz #hinweis[(ohne Überlappung)]], [$Rho(A union B) = Rho(A) + Rho(B)$],

    [Multiplikationssatz #hinweis[(ohne Bedingung)]], [$Rho(A inter B) = Rho(A) dot Rho(B)$],

    [Multiplikationssatz #hinweis[(mit Bedingung)]], [$Rho(A inter B) = Rho(A) dot Rho(B|A) = Rho(B) dot Rho(A|B)$],
  )
]

#pagebreak()

== Laplace-Experiment
Ein Laplace-Experiment ist eine spezielle Form eines Zufallsexperiments, bei dem es nur _Elementarereignisse $bold({omega})$_
gibt und diese alle die _gleiche Wahrscheinlichkeit_ haben. Dazu muss die Ergebnismenge $Omega$ _endlich_ sein. Laplace-Experimente dürfen aber auch Ereignisse haben, die aus mehreren Elementarereignissen bestehen
#hinweis[(siehe Beispiel unten)].

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Wahrscheinlichkeit eines Elementarereignisses], [Wahrscheinlichkeit eines beliebigen Ereignis]),
  [$ Rho({omega_i}) = 1/n $],
  [$ Rho(A) = abs(A)/abs(Omega) = "Anz. Ereignisse für A"/"Anz. aller Elementarereignisse" $],
)

*Beispiel:*\
Das Werfen eines Würfels ist ein Laplace-Experiment, da es nur Elementarereignisse gibt:
$Omega = {1,2,3,4,5,6}$\
- Wahrscheinlichkeit, eine 2 zu würfeln #hinweis[(Elementarereignis)]:
  $Rho({omega_i}) = 1\/n = underline(1\/6)$\
- Wahrscheinlichkeit für das Ereignis "gerade Zahl":
  $A = {2,4,6}, quad Rho(A) = abs(A)\/abs(Omega) = 3\/6 = underline(1\/2)$

== Bedingte Wahrscheinlichkeit
Will man die Wahrscheinlichkeit eines Ereignis berechnen, das von einem anderen abhängig ist, wendet man die bedingte
Wahrscheinlichkeit an. Als Faustregel kann auch gesagt werden _"Wahrscheinlichkeit von $A$, wenn $B$"_.
$ Rho("was wir wissen wollen"|"was wir wissen") = Rho(A|B) = Rho(A inter B)/Rho(B) $

Sie tritt vor allem bei mehrstufigen Experimenten auf, wenn nach einer Stufe jeweils andere Ereignisse eintreffen können
#hinweis[(z.B. mehrere Münzwürfe hintereinander stellen einen Kopf/Zahl Binary Tree auf)].
Aus der Formel oben schliesst sich die _bedingte Pfadregel_:
#definition[
  #grid(
    columns: (2.5fr, 1fr),
    align: horizon,
    [
      $
        Rho(A inter B) = Rho(B) dot Rho(A|B) \
        Rho(B) -> Rho(A|B) -> Rho(A inter B)
      $
    ],
    image("img/ExEv_01.png"),
  )
]

Aus dieser lässt sich der _Satz von Bayes_ schliessen. Damit kann die "Bedingung" umgekehrt werden:
Wissen wir $Rho(A|B)$, können wir auch $Rho(B|A)$ ausrechnen.
#definition[
  $
    Rho(A|B) dot Rho(B) = Rho(A inter B) = Rho(B|A) dot Rho(A) quad
    => quad Rho(A|B) = Rho(B|A) dot Rho(A)/Rho(B)
  $
]

#pagebreak()

*Beispiel*
#table(
  columns: (1fr,) * 4,
  table.header(
    [],
    [Erkrankt ($bold(B)$)],
    [Nicht erkrankt $bold(dash(B))$],
    table.vline(stroke: 1.5pt + black),
    [Summe $bold(Sigma)$],
  ),
  [_Geimpft ($bold(A)$)_], [$117$], [$389$], [$506$],
  [_Nicht Geimpft ($bold(dash(A))$)_], [$289$], [$165$], [$454$],
  table.hline(stroke: 1.5pt + black),
  [_Summe $bold(Sigma)$_], [$406$], [$554$], [$960$],
)

Wahrscheinlichkeit, an Grippe zu erkranken:
$ Rho(B) = abs(B)/abs(Omega) = 406/960 = 42.3% $

Wahrscheinlichkeit, dass Person nicht geimpft ist:
$ Rho(dash(A)) = abs(dash(A))/abs(Omega) = 454/960 = 47.3% $

Wahrscheinlichkeit, trotz Impfung zu erkranken #hinweis[(Laplace)]:
$
  Rho(B|A) = Rho(A inter B)/Rho(A) = (abs(A inter B)\/Omega)/(abs(A)\/abs(Omega)) = abs(A inter B)/abs(A) = 117/506 = 32.1%
$

=== Unabhängige Ereignisse
Wird das Ereignis $A$ nicht vom Eintreten des Ereignisses $B$ beeinflusst, gilt $Rho(A|B) = Rho(A)$.
Die Ereignisse sind also voneinander _stochastisch unabhängig_. Bei diesen gelten auch die jeweiligen Komplemente $A^complement$, $B^complement$ und $A^complement inter B^complement$ als unabhängig. Die _unabhängige Pfadregel_ lautet also
$ Rho(A inter B) = Rho(B) dot Rho(A) $

Durch _Umformen_ dieser Formel kann man die Zahlenwerte für die Ereignisse berechnen. Dies ist nützlich, um herauszufinden,
ob Variablen _voneinander unabhängig_ sind oder nicht. Weichen die Werte erheblich von den ursprünglichen
Wahrscheinlichkeitswerten ab, sind die Variablen voneinander abhängig.
$ |X inter Y| = (|X| dot |Y|)/(abs(Omega)) $

Sind alle Ereignisse innerhalb einer Menge voneinander unabhängig, spricht man von _stochastischer/vollständiger Unabhängigkeit_.
Dann kann bei einer fehlender Wahrscheinlichkeit diese aus den Schnittmengen der anderen mithilfe des _Multiplikationssatzes_
berechnet werden. Gesucht wird $Rho(A)$, gegeben sind $Rho(B)$ und $Rho(C)$.
$ Rho(A) = Rho(B inter A) + Rho(C inter A) quad => quad Rho(B) dot Rho(A|B) + Rho(C) dot P(A|C) $

Der Begriff "unabhängig" wird manchmal verwechselt mit dem Begriff "disjunkt". Zwei disjunkte Ereignisse $A$ und $B$,
also mit $Rho(A dot B) = emptyset$, können aber nur dann unabhängig sein, wenn eines der beiden Ereignisse die
Wahrscheinlichkeit 0 hat. Nur dann ist $Rho(A) dot Rho(B) = 0 = Rho(emptyset) = Rho(A dot B)$.

#pagebreak()

=== Totale/Vollständige Wahrscheinlichkeit
#definition[
  Hat man für ein Ereignis $A$ mehrere Bedingungen $B_i$ #hinweis[(z.B. mehrere Fälle oder Ursachen für $A$)],
  kann man die Wahrscheinlichkeit für $A$ berechnen, wenn man die bedingten Wahrscheinlichkeiten für $B_i$ zusammenzählt
  #hinweis[(Aus Einzelfällen lässt sich die Gesamtsituation zusammenstellen)].

  $ Rho(A) = sum_(i=1)^n Rho(A|B_i) dot Rho(B_i) $
]

*Beispiel*:\
Wie gross ist die Wahrscheinlichkeit $Rho(T)$, auf der Enterprise umzukommen?

#v(-0.3em)
#grid(
  columns: (1.2fr, 0.2fr),
  [
    *Wahrscheinlichkeitsfallunterscheidung:*
    Aus den bedingten Wahrscheinlichkeiten die Bedingung herausrechnen, um die Totale Wahrscheinlichkeit zu erhalten.

    $
        &Rho(T inter G) &= Rho(T|G) dot Rho(G)\
      + &Rho(T inter B) &= Rho(T|B) dot Rho(B)\
      + &Rho(T inter R) &= Rho(T|R) dot Rho(R)\
        #place(line(length: 4.5cm, stroke: 0.075em), dy: -3.4mm)
        &Rho(T)
    $
  ],
  image("img/ExEv_05.png"),
)

*Beispiel:*\
Aus einem Jasskartenset (36 Karten) werden 2 Karten gezogen.
Wie gross ist die Wahrscheinlichkeit, beim zweiten Zug ein Ass zu ziehen?

#grid(
  align: horizon,
  [
    $
      Rho(A) & = Rho(A|B_1) dot P(B_1) + Rho(A|B_2) dot Rho(B_2) \
             & = 4/35 dot 32/36 + 3/35 dot 4/36 = underline(1/9)
    $
  ],
  [
    $Rho(A|B_i)$: Ass im zweiten Zug (nur noch 35 Karten)\
    $Rho(B_1)$: Kein Ass im ersten Zug $= 32\/36$\
    $Rho(B_2)$: Ass im ersten Zug $= 4\/36$
  ],
)

*Beispiel:*\
In einem Behälter liegen 3 Arten von Batterien im Verhältnis 20:30:50. $B_1$ hält zu $70%$ länger als 100 Stunden,
$B_2$ zu $40%$ und $B_3$ zu $30%$. Wie hoch ist die Wahrscheinlichkeit, dass eine zufällig gewählte Batterie länger
als $100$ Stunden hält?

#grid(
  align: horizon,
  [
    $
      Rho(A) & = sum^3_(i=1) Rho(A|B_i) dot Rho(B_i) \
             & = 0.7 dot 0.2 + 0.4 dot 0.3 + 0.3 dot 0.5 = underline(0.41)
    $
  ],
  [
    $n$: Anzahl Arten von Batterien\
    $Rho(A)$: Gewählte Batterie hält länger als 100h\
    $Rho(A|B_i)$: Wahrsch., dass $B_i$ länger als 100h hält\
    $Rho(B_i)$: Wahrscheinlichkeit, dass $B_i$ gewählt wird
  ],
)

= Kombinatorik
Die Kombinatorik liefert mathematische Modelle zur _Bestimmung der Anzahl möglicher Anordnungen_ von Elementen.
Dabei kann mit oder ohne Berücksichtigung der Elementreihenfolge und -wiederholung gearbeitet werden.

- _Menge:_ Liste, die jedes Element nur einmal enthält, die Reihenfolge der Elemente ist irrelevant.
- _Tupel:_ Liste, die Elemente mehrfach enthalten kann. Die Reihenfolge der Elemente ist relevant.
- _n-Tupel:_ Tupel mit $n$ Elementen. Hat an der $n$-ten Stelle jeweils $k_n$ mögliche Permutationen.
  Es gibt für die Besetzung jeweils $k_1 dot k_2 dot ... dot k_n$ verschiedene n-Tupel.

Man unterscheidet zwei Arten der Auswahlverfahren einer Reihenfolge:
- _Mit Wiederholung/Zurücklegen:_ Die Elemente sind nicht einzigartig und dürfen sich in der Anordnung wiederholen
  #hinweis[(z.B. Zahlen in Zahlenschloss, Bälle mit verschiedenen Farben)]
- _Ohne Wiederholung/Zurücklegen:_ Die Elemente sind alle einzigartig und dürfen nicht mehrmals vorkommen.
  #hinweis[(z.B. Personen an Tisch, Lotto-Zahlen)]

Es gibt drei verschiedene Techniken, um Elemente anzuordnen:

== Permutation <permutation>
_"Auf wie viele Arten lassen sich $n$ verschiedene Objekte anordnen?"_\
Bei der Permutation wird die ganze Menge angeordnet, jedes Element der Menge wird also genau einmal in die Anordnung gelegt.

#table(
  columns: (1fr,) * 2,
  align: (_, y) => if (y == 1) { horizon } else { auto },
  table.header([ohne Wiederholung], [mit Wiederholung]),
  [$ P(n) = n! $], [$ P_(n_1,...,n_k)(n) = n!/(n_1 ! dot n_2 ! dot ... dot n_k !) $],
  [
    Für das erste Objekt stehen $n$ Plätze zur Verfügung. Für das zweite Objekt muss einer der $n-1$ verbleibenden Plätze
    gewählt werden. Bisher sind nun $n dot (n-1)$ Möglichkeiten gefunden. Führt man diese Reihenfolge fort, ergeben
    sich $n!$ Möglichkeiten.
  ],
  [
    Sind von den Elementen mindestens zwei identisch, werden diese zu Klassen zusammengefasst.
    Die $n$ zu füllenden Plätze werden durch das Produkt der Fakultäten der Häufigkeiten aller Klassen $n_i$ geteilt.
  ],
)

*Beispiel:*\
Eine Maschine muss vier Aufträge nacheinander abarbeiten. Wie viele Anordnungen sind möglich?\
$ Rho(n) = 4! = underline(24) $

#example-block[
  *Beispiel:*\
  + _Ein Zahlenschloss hat eine Kombination mit den Ziffern "$1, 1, 4, 4, 4, 8$". Wie viele Codes gibt es?_
  $
    n_1(1) = 2, space n_2(4) = 3, space n_3(8) = 1, space => quad n = 2+3+1 = 6\
    Rho_(2, 3, 1) = 6!/(2! dot 3! dot 1!) = 720/12 = underline(60)
  $

  2. _Wie viele Kombinationen beginnen mit $4$?\
    Da der erste Platz nun fix mit einer $4$ besetzt ist, haben wir eine neue Fragestellung mit den Ziffern "$1, 1, 4, 4, 8$":_
  $
    n_1(1) = 2, space n_2(4) = 2, n_3(8) = 1 quad => quad n = 2 + 2 + 1 = 5\
    Rho_(2, 2, 1) = 5!/(2! dot 2! dot 1!) = 120/4 = underline(30)
  $
]

== Kombination <kombination>
_"Auf wie viele Arten kann man $k$ Objekte aus $n$ auswählen?"_\
Es wird eine Teilmenge aller Elemente angeordnet. Die Reihenfolge der Elemente ist hier nicht relevant, man spricht
auch von einer _ungeordneten (Stich-)probe_. Die Permutation ist ein Spezialfall der Kombination, bei welcher $n=k$.

#table(
  columns: (1fr,) * 2,
  align: (_, y) => if (y == 1) { horizon } else { auto },
  table.header([ohne Wiederholung], [mit  Wiederholung]),
  [$ K_k (n) = (product^(n-k+1)_n n)/k! = n!/(k! dot (n-k)!) = binom(n, k) $],
  [$ K^W_k (n) = (n+k-1)!/(k! dot (n-k)!) = binom(n + k - 1, k) $],

  [
    Es ist zuerst $k$ mal eine Auswahl zu treffen. Für die erste Auswahl stehen $n$ Objekte zur Verfügung.
    Danach muss noch $k-1$ mal eine Auswahl getroffen werden, es stehen noch $n-1$ Alternativen zur Verfügung.
    So lassen sich insgesamt\ $n dot (n-1) dot (n-2)...(n-k+1)$ Möglichkeiten finden.
  ],
  [
    Die Wiederholung addiert noch $k-1$ zum oberen Term der Matrix, da wir die Elemente wieder zur Verfügung haben.
    Die Matrixschreibweise entspricht dem Binomialkoeffizienten und kann auch als $C^n_k$ geschrieben werden.
  ],
)

#hinweis[
  Es gibt mehrere Schreibweisen für die Kombinationsformeln. Für das Lösen der Aufgaben kannst du diejenige verwenden,
  die dir am besten liegt. Die Beispiele zeigen absichtlich alle Schreibweisen an.\
  TR: Menü $->$ 5: Wahrscheinlichkeit $->$ 3: Kombinationen $-> "nCr"("obere Zahl", "untere Zahl")$
]

*Beispiel:*\
Bei einem Pokémon-Turnier soll jeder der 25 Teilnehmer einmal gegen jeden spielen. Wie viele Spiele werden ausgetragen?
$ K_2(25) = (25 dot 24)/2! = 25!/(2! dot (25-2)!) = binom(25, 2) = underline(300) $

*Beispiel:*\
Im Nationalrat werden 3 Sitze neu vergeben. Es stellen sich 6 Parteien dafür auf.
Eine Partei kann mehr als einen Sitz erhalten. Die Reihenfolge ist irrelevant, da es keinen Unterschied macht,
ob $"ABC"$ oder $"CBA"$ #hinweis[(egal ob Partei A 1. oder 3. wird, sie erhalten auf beide Arten 1 Sitz)].
Wie viele Kombinationen sind möglich?
$ K^W_3(6) = binom(6+3-1, 3) = binom(8, 3) = (8 dot 7 dot 6)/3! = 8!/(3! dot (8-3)!) = underline(56) $

*Beispiel:*\
Aus 50 Glühbirnen wird eine Stichprobe von 5 entnommen. Wie gross ist die Wahrscheinlichkeit, dass aus
diesen 5 genau 2 defekt sind, wenn total 10 defekt sind?

Das gewünschte Ergebnis kann in einem Laplace-Experiment mit zwei Fällen dargestellt werden:
- $2$ defekte Glühbirnen aus total $10$ defekten ziehen
- $(5 - 2) = 8$ funktionsfähige Glühbirnen aus total $(50 - 10) = 40$ Funktionsfähigen ziehen
$
  Rho{3 "Defekte"} = (mat(10; 2) dot mat(50-10; 5-2))/mat(50; 5)
  = ((10 dot 9)\/2 dot (40 dot 39 dot 38)\/(2 dot 3))/(2'118'760) = underline(0.21)
$

== Variation <variation>
_"Auf wie viele Arten kann man $bold(k)$ mal unter $bold(n)$ verschiedenen Objekten auswählen?"_\
Es wird eine Teilmenge, bei welcher die Reihenfolge relevant ist, angeordnet.
Diese Teilmenge wird als _geordnete (Stich-)probe_ bezeichnet.

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([ohne Wiederholung], [mit Wiederholung]),
  [$ V_k (n) = n!/(n-k)! = product^(n-k+1)_n n $], [$ V^W_k (n) = n^k $],
)

*Beispiel:*\
Auf wie viele Arten kann man eine Perlenkette der Länge $k = 10$ aus $n = 4$ Farben von Perlen herstellen?\
$ V_10 (4) = 4^10 = underline(1'048'576 "Möglichkeiten") $

*Beispiel:*\
Wie viele Kombinationen gibt es bei einem 5-stelligen Zahlenschloss mit jeweils $10$ Ziffern pro Stelle?\
$ 10^5 = underline(100'000 "Kombinationen") $

*Beispiel:*\
Aus $18$ Teilnehmer eines Rennens müssen die ersten 3 in der richtigen Reihenfolge getippt werden.
Wie viele Möglichkeiten gibt es?
$
  k = 3, quad quad n = 18\
  V^W_3 (18) = product^(18-3+1)_18 n = product^16_18 n = 18 dot 17 dot 16 = underline(4'896)
$

#pagebreak()

== Bestimmung der Kombinatorik-Formel <kombinator-checklist>
#hinweis[Wird Frage mit "Ja" beantwortet: #sym.checkmark folgen, wird Frage mit "Nein" beantwortet: #sym.crossmark folgen]

+ *Ist jedes vorgegebene Element genau einmal anzuordnen?*\ #hinweis[(Ganze Menge verwenden, keine Stichprobe)]\
  #sym.checkmark Schritt 2\
  #sym.crossmark Schritt 3

+ *Sind die vorgegebenen Elemente alle verschieden?*\
  #sym.checkmark #link(<permutation>)[Permutation ohne Wiederholung]\
  #sym.crossmark #link(<permutation>)[Permutation mit Wiederholung]

+ *Darf ein vorgegebenes Element wiederholt ausgewählt werden?*\
  #hinweis[(Ist Grundelement nicht nur einmal vorhanden?)]\
  #sym.checkmark Schritt 5\
  #sym.crossmark Schritt 4

+ *Ist die Anordnung der Elemente von Bedeutung?*\
  #sym.checkmark #link(<variation>)[Variation ohne Wiederholung]\
  #sym.crossmark #link(<kombination>)[Kombination ohne Wiederholung]

+ *Ist die Anordnung der Elemente von Bedeutung?*\
  #sym.checkmark #link(<variation>)[Variation mit Wiederholung]\
  #sym.crossmark #link(<kombination>)[Kombination mit Wiederholung]


= Diskrete Verteilungen
Mit Hilfe einer Wahrscheinlichkeitsverteilung lassen sich zufallsbehaftete Ereignisse oder Variablen
#hinweis[(sogenannte Zufallsvariablen)] modellieren. _Diskrete Verteilungen_ stellen die Ergebnisse von Experimenten dar,
welche eine feste Anzahl von Ereignissen haben #hinweis[(z.B. 6 Ereignisse eines Würfels, Anzahl Studenten
mit einer bestimmten Note)]

== Zufallsvariable
Eine Zufallsvariable $X(omega)$ ist eine Funktion, welche jedem möglichen Ergebnis $omega$ eines Zufallsexperiments
_eine reelle Zahl $x$ zuordnet_. Dabei steht in der Fallunterscheidung links die Realisierung der Zufallsvariable
#hinweis[(konkreter Wert)] und rechts das Ereignis #hinweis[($omega in {...}$)].

*Beispiel:*
Beim Roulette auf erstes Dutzend ($1-12$) setzen. Ergebnisse $omega$: $2$ Fr. Gewinn, $1$ Fr. Verlust (des Einsatzes)
$
  X: {0,1,...,36} -> RR, quad
  X(omega) = cases(
    2 & "für" omega in {1,2,...,12},
    -1 & "für" omega in {0,13,14,...,36}
  )
$

== Diskrete Wahrscheinlichkeitsfunktion <diskret-wkeit-urliste>
Eine _Wahrscheinlichkeitsfunktion $bold(f(x))$_ weist den Werten einer Zufallsvariable die Wahrscheinlichkeit
ihres Auftretens $p$ zu und bildet damit ein Tupel $[x_i, p_i]$. Dieses wird häufig als _Graph_ dargestellt.
Jede Verteilung hat ihre eigene Wahrscheinlichkeitsfunktion. Eine Wahrscheinlichkeitsfunktion wird als
Fallunterscheidung dargestellt mit einem $"sonst"$-Fall mit Wahrscheinlichkeit $0$ #hinweis[(default switch case)].
$
  f(x) = cases(
    P(X = x_i) = p_i"," quad & x = x_i in {x_1,...,x_k},
    0"," & "sonst."
  )
$

#grid(
  [
    Die _diskrete Wahrscheinlichkeitsfunktion\ $bold(f(x_i) = Rho(X=x))$_ wird als _Balkendiagramm_ dargestellt.
    Die Wahrscheinlichkeit $Rho(x_i)$ eines Ereignisses kann unmittelbar an ihrem Balken abgelesen werden und
    die Summe aller Wahrscheinlichkeiten ist $1$.
  ],
  image("img/ExEv_06.png"),
)



- _Verteilung der Zufallsvariable:_ Die Gesamtheit der Tupel der Wahrscheinlichkeitsfunktion.
  Wird normalerweise als Graph dargestellt.
- _Realisation:_ Wert, den die Zufallsvariable in einem konkreten Experimentdurchlauf annimmt.
- _Erwartungswert $bold(E(x))$:_ Wert, der die Zufallsvariable im Mittelwert annimmt.
  Die Wahrscheinlichkeit sollte um diesen Wert am grössten sein. Pro Verteilungstyp unterschiedlich.
- _Erfolgswahrscheinlichkeit $bold(p)$:_ Wahrscheinlichkeit, dass ein Ereignis eintritt
- _Misserfolgswahrscheinlichkeit $bold(q)$:_ Wahrscheinlichkeit, dass ein Ereignis nicht eintritt #hinweis[(häufig $1-p$)]

Die Konzepte der Zufallsvariable lassen sich auf diese der _beschreibenden Statistik_ mappen:
#table(
  columns: (1fr,) * 2,
  table.header([Zufallsvariable $X$], [Merkmal $x$]),
  [Realisation], [Merkmalswert],
  [Wahrscheinlichkeit], [relative Häufigkeit],
  [Wahrscheinlichkeitsfunktion], [einfache relative Häufigkeit],
  [Verteilungsfunktion], [kumulierte relative Häufigkeit],
  [Erwartungswert], [arithmetisches Mittel],
)

*Beispiel:*\
Bestimme die Wahrscheinlichkeiten der Zahlen der Urliste
$ x_i = {1,4,2,2,4,3,1,2,2,2,3,4,5,1,1,2,3,4,5,5}, quad n = 20 $
#grid(
  gutter: 1em,
  [
    #table(
      columns: (1fr,) * 7,
      align: (x, y) => { if (x > 0 and y > 0) { right } else { auto } },
      table.header([*$i$*], [*$x_i$*], [*$h_i$*], [*$f_i$*], [*$F_i$*], [*$x_i f_i$*], [*$x_i^2f_i$*]),
      [1], [1], [4], [0.20], [0.20], [0.20], [0.20],
      [2], [2], [6], [0.30], [0.50], [0.60], [1.20],
      [3], [3], [3], [0.15], [0.65], [0.45], [1.35],
      [4], [4], [4], [0.20], [0.85], [0.80], [3.20],
      [5], [5], [3], [0.15], [1.00], [0.75], [3.75],
      table.hline(stroke: 1.5pt),
      [$Sigma$], [], [20], [], [], [2.80], [9.70],
    )
  ],
  [
    + Tabelle mit abs. & relat. Häufigkeiten $h_i$, $f_i$ erstellen
    + Wahrscheinlichkeitsfunktion mit $f_i$ erstellen
      $
        f(x) = cases(
          0.2 & x=1,
          0.3 & x=2,
          0.15 quad & x=3,
          0.2 & x=4,
          0.15 & x=5,
          0 & "sonst."
        )
      $
  ],
)

== Diskrete Verteilungsfunktion
Eine _Verteilungsfunktion $bold(F(x) = Rho(X <= x))$_ stellt die Summe aller Wahrscheinlichkeiten dar, bei denen sich
die Realisierungen unterhalb eines Wertes $x$ befinden. Wird auch als _summierte/kumulierte Wahrscheinlichkeit_ bezeichnet.

Viele Verteilungsfunktionen haben eigene _Verteilungsparameter_, welche die genaue Grösse der Verteilung bestimmen.
Während ein _Skalenparameter_ die Streuung und somit die Breite einer Verteilung bestimmt, beeinflusst ein _Formparameter_
die Form einer Verteilungsfunktion; er bewirkt mehr als nur eine Skalierung oder Verschiebung.

*Beispiel:*\
Bestimme die Verteilungsfunktion der Urliste vom Beispiel der Diskreten Wahrscheinlichkeitsfunktion
+ Tabelle mit relativen kumulierten Häufigkeit $F_i$ erstellen #hinweis[(siehe oben)]
+ Verteilungsfunktion mit $F_i$ erstellen. _Die Fälle ausserhalb des Wertebereichs nicht vergessen!_
  $
    F(x) = cases(
      0 & x < 1,
      0.2 & x = 1,
      0.5 & x = 2,
      0.65 quad & x = 3,
      0.85 & x = 4,
      1 & x >= 5
    )
  $

=== Empirische Verteilungsfunktion
Die empirische Verteilungsfunktion zeigt die Wahrscheinlichkeit an, dass ein Messwert _höchstens eine bestimmte Grösse_ hat.
Sie wird angewendet, wenn konkrete Messwerte vorliegen, also beispielsweise berechnet sie, in welchem Anteil
bei 20 Würfen mit 2 Würfeln höchstens eine 5 gefallen ist.
#definition[
  #grid(
    columns: (1fr, 1fr),
    align: horizon,
    [$ F(x_i) = sum^i_(j=1) f(x_j) = sum^i_(j=1) = n_j/n $],
    [
      _*$F(x_i)$*:_ Verteilungswert des Messwerts $x_i$\
      _*$sum^i_(i=1)$*:_ Summiere für alle Werte bis zum Messwert $x_i$\
      _*$f(x_j)$*:_ Relative Häufigkeit des Messwerts $j$\
      _*$n_j$*:_ Absolute Häufigkeit des Messwerts $j$\
      _*$n$*:_ Gesamtanzahl der Messwerte der Stichprobe\
    ],
  )
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert (Mittelwert)], [Varianz]),
  [$ E(X) = mu = sum_i x_i dot f(x_i) = sum_i x_i dot n_j/n $],
  [
    $
      "var"(X) & = sum^v_(i=1) (x_i - #x-)^2 dot f(x_i) \
               & = E(x^2) - (E(x))^2
    $
  ],
)

*Beispiel:*\
Bestimme Erwartungswert & Varianz der Urliste vom Beispiel der Diskreten Wahrscheinlichkeitsfunktion @diskret-wkeit-urliste.

+ Tabelle mit relativer Häufigkeit $f_i$ und Erwartungswert $x_i dot n_j\/n$ erstellen #hinweis[(siehe Beispiel oben)]
+ Summe bilden, um Gesamt-Erwartungswert zu erhalten
$ E(x) = sum_i x_i dot f(x_i) = underline(2.8) $

3. Tabelle um Spalte $x_i^2 dot f(x_i)$ erweitern und Summe bilden
+ Varianz berechnen mit der Summe der neuen Spalte
$ "var"(x) = E(x^2) - (E(x))^2 = sum^v_(i=1) x_i^2 dot f(x_i) - (E(x))^2 = 9.7 - 2.8^2 = underline(1.86) $

*Beispiel:*\
An der letzten Ex&Ev-Prüfung hatten die 20 Studierenden folgenden Notenspiegel.
Wie wahrscheinlich ist es, dass eine Person eine 4 oder besser erreicht hat?
#{
  show emph: set text(fill: black, weight: "regular", style: "oblique")
  table(
    columns: (1fr,) * 7,
    [*Note*], [6], [5], [4], [3], [2], [1],
    [*Häufigkeit*], [4], [5], [7], [2], [1], [1],
  )
}
$
  Rho(x_i <= 4 <= x_20) = sum^20_(j=i) f(x_j) = sum^20_(j=i) n_j/20 = 4/20 + 5/20 + 7/20 = 16/20 = 0.8 = underline(80%)
$

#pagebreak()

== Bernoulli-Verteilung
#grid(
  columns: (2fr, 1fr),
  [
    Die _Bernoulli-Verteilung $bold("Ber"(p))$_ hat nur 0 und 1 als mögliche Ereignisse, eignet sich also um festzustellen,
    ob ein Ereignis eintritt oder nicht. Ist von Wiederholungen unabhängig, die (Miss-)Erfolgswahrscheinlichkeiten
    $p$ und $q = 1 - p$ bleiben also gleich.
  ],
  image("img/ExEv_07.png"),
)

#definition[
  Die Wahrscheinlichkeitsfunktion der Bernoulli-Verteilung ist:
  $ f(x) = P(X = x) = cases(1-p &", falls" x = 0, p &", falls" x = 1, 0 &", sonst") $
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = p $], [$ "var"(X) = p dot q $],
)

*Beispiel:*\
In einem Experiment mit Bernoulli-Verteilung auf ${0, 1}$ ist das Ereignis $1$ viermal so wahrscheinlich
wie das\ Ereignis $0$. Bestimme Wahrscheinlichkeitsfunktion, Verteilungsfunktion, Erwartungswert & Varianz.

Die Summe der Wahrscheinlichkeit ist 1, also folgt:
$1 = p + (1 - p) quad => quad p + 4p = 5p -> p = 0.2$

Daraus lassen sich alle Werte bilden:

#table(
  columns: (1fr,) * 4,
  align: horizon,
  table.header([Wahrscheinlichk.funktion], [Verteilungsfunktion], [Erwartungswert], [Varianz]),
  [$ f(x) = cases(0.2 quad &x = 0, 0.8 &x = 1, 0 &"sonst") $],
  [$ F(X) = cases(0 &x < 0, 0.2 quad &x = 0, 1 &x >= 1) $],
  [$ E(x) = p = 0.2 $],
  [$ sigma^2 = p dot (1 - p) = 0.16 $],
)

#pagebreak()

== Binomial-Verteilung
#grid(
  columns: (2fr, 1fr),
  [
    Die _Binomial-Verteilung $bold("Bin"(n,p))$_ hat ebenfalls nur 0 und 1 als mögliche Ergebnisse.
    Sie zeigt aber die Wahrscheinlichkeit auf, ob ein Ereignis wahrscheinlich/genau/höchstens/mindestens x-mal auftritt --
    also die _Anzahl Erfolge in einer Serie von zufälligen Ereignissen_. Die Bernoulli-Verteilung ist ein Spezialfall
    der Binomial-Verteilung, bei welcher $n = 1$.
  ],
  image("img/ExEv_08.png"),
)

#definition[
  Die Wahrscheinlichkeitsfunktion der Binomialverteilung ist:
  #grid(
    align: horizon,
    [$ f(x) = Rho(X = x) = binom(n, x) dot p^x dot (1-p)^(n-x) $],
    [
      _*$x$*:_ Anzahl Ereignisse\
      _*$n$*:_ Anzahl Realisationen, in denen Ereignis eintritt\
      _*$p$*:_ Wahrscheinlichkeit, dass Ereignis eintritt
    ],
  )
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = n dot p $], [$ "var"(X) = n dot p dot q = n dot p dot (1 - p) $],
)

*Beispiel*:\
Auf eine Reise sind $10$ Personen angemeldet. Die Wahrscheinlichkeit einer Absage ist $5%$.
Wie hoch ist die Chance, dass genau $2$ Personen absagen?
$
  Rho(X = 2) = binom(n, k) dot p^k dot (1-p)^(n-k)
  = binom(10, 2) dot 0.05^2 dot (1 - 0.05)^(10-2)
  = binom(10, 2) dot 0.05^2 dot 0.95^8 = underline(0.075)
$

Wie hoch ist die Wahrscheinlichkeit, dass mindestens $3$ Gäste absagen? Dazu muss $1$ minus die Wahrscheinlichkeit
von $0$ bis $2$ Absagen gerechnet werden.
$
  Rho = 1 - Rho(X <= x = 2) = 1 - sum^x_(i=0) mat(n; x_i) dot p^(x_i) dot (1 - p)^(n-x_i) =
  = 1 - sum^2_(i=0) mat(10; i) dot 0.05^(i) dot 0.95^(10-i) = underline(0.011)
$

#pagebreak()

== Poisson-Verteilung
#grid(
  columns: (2fr, 1fr),
  [
    Die _Poisson-Verteilung $bold("Poi"(mu))$_ zeigt, wie hoch die Wahrscheinlichkeit ist, dass ein Ereignis in einem
    Intervall genau oder höchstens $x$-mal eintritt, wenn bekannt ist, dass in diesem Intervall das Ereignis
    durchschnittlich\ $mu$-mal auftritt. Durch sie können Wahrscheinlichkeiten _seltener Ereignisse_ bestimmt werden.
  ],
  image("img/ExEv_09.png"),
)

#definition[
  Die Wahrscheinlichkeitsfunktion der Poisson-Verteilung ist:
  #grid(
    columns: (1fr, 1.1fr),
    [$ f(x) = Rho(X = x) = mu^x/x! dot e^(-mu) $],
    [
      _*$x$ oder $lambda$*:_ Anzahl Ereignisse\
      _*$mu$*:_ Durchschnittliches Auftreten des Ereignis im Intervall
    ],
  )
  #hinweis[TR Skript: $"p_atleast_k"$ beinhaltet Grenze $k$ *nicht*]
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = mu $], [$ "var"(X) = mu $],
)

*Beispiel:*\
An einer Hotline rufen in einer Stunde durchschnittlich $5$ Kunden an. Sie kann $9$ Anrufe gleichzeitig bearbeiten.\
#hinweis[(Nicht dieselbe Aufgabe wie bei der Exponential-Verteilung, es hängt von der Fragestellung ab!)]

Wie gross ist die Wahrscheinlichkeit, dass genau $3$ Kunden anrufen?
$ Rho(3) = mu^x/x! dot e^(-mu) = 5^3/(3!) dot e^(-5) = underline(0.14) $

Wie gross ist die Wahrscheinlichkeit, dass die Hotline mit mehr als 9 Anrufen gleichzeitig zu kämpfen hat und
somit überlastet ist?\
Dazu muss $1$ minus die Wahrscheinlichkeit von $0$ bis $9$ Anrufen gerechnet werden.
$
  Rho = 1 - Rho(X <= x = 9) = 1 - sum^x_(i=0) mu^x/x! dot e^(-mu)
  = 1 - sum^9_(i=0) 5^i/i! dot e^(-5) = 1 - 0.9682 = underline(0.0318)
$

=== Approximation der Binomialverteilung
Mit der Poissonverteilung kann die Binomialverteilung approximiert werden, wenn die Datengrundlage genügend klein ist
#hinweis[(Faustregel: Bei $n p <= 10$ und $n >= 1500 p$ kann die Approximation gemacht werden)].
Die Rechnung funktioniert dann ganz normal wie bei der Poisson-Verteilung.


= Stetige Verteilungen
Häufig arbeitet man nicht mit Werten, die exakt gleich sind #hinweis[(Würfelaugen, Anzahl Personen in Schlange, Ausfallzeit)],
sondern nur annähernd gleich #hinweis[(Länge von 2 Gegenständen, Füllstand von 2 Behältern)] oder mit Systemen, bei denen
sich der Zustand über die Zeit kontinuierlich ändert #hinweis[(Wartezeit in Schlange, Stromverbrauch eines Gebäude,
Alterungsprozesse)]. Solche Prozesse können durch _stetige Zufallsvariablen_ beschrieben werden.

#pagebreak()

== Wahrscheinlichkeitsdichtefunktion
Anstatt der Wahrscheinlichkeitsfunktion bei den diskreten Verteilungen gibt es bei den stetigen Verteilungen
die _Wahrscheinlichkeitsdichte_ bzw. _Dichtefunktion $bold(f(x))$_ .

#definition[
  $ f(x) = Rho(a <= X <= b) = integral^b_a f(x) dif x $
]

Mithilfe der Dichtefunktion kann die _Wahrscheinlichkeit_ ermittelt werden, dass ein Wert _realisiert_ wird,
der _innerhalb_ eines vorab definierten _Intervalls_ liegt. Im Gegensatz zu Wahrscheinlichkeiten können
Wahrscheinlichkeitsdichtefunktionen auch Werte _über 1_ annehmen.

=== Stetige Verteilungsfunktion
Die stetige Verteilungsfunktion $F(x)$ wird aus der _Integration_ der Dichtefunktion $f(x)$ gebildet.
Anders herum wird durch _Ableiten_ der Stetigen Verteilungsfunktion die Dichtefunktion berechnet.
$ F(X) = integral^infinity_(-infinity) f(t) dif t, quad quad f(x) = F'(x) $

== Rechteck-Verteilung/Gleichverteilung
Die Rechteck-Verteilung #hinweis[(auch als Gleichverteilung bezeichnet)] beschreibt Vorgänge, bei denen die Ereignisse
nur Zahlen im Intervall $[a,b]$ sein können. Alle Ergebnisse in $[a,b]$ sind _gleich wahrscheinlich_.
Sie wird beispielsweise angenommen, wenn Fehler- oder Temperaturgrenzen angegeben sind.

#definition[
  Die _Dichte- und Verteilungsfunktion_ der Rechteck-Verteilung sind:
  #grid(
    align: horizon,
    [$ f(x|a;b) = 1/(b-a) $],
    [$ F(x|a;b) = (x-a)/(b-a) $],
  )
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = (a + b)/2 $], [$ "var"(X) = 1/12 dot (b-a)^2 $],
)

*Beispiel:*\
#example-block[
  _Eine Person trifft zu einer zufälligen Zeit an einer Bushaltestelle ein, bei der alle 10min ein Bus fährt._

  + Wie gross ist die Wahrscheinlichkeit, dass sie 3 Minuten auf den Bus warten muss?

    + $a$ und $b$ aus dem Text bestimmen #hinweis[(Wie oft geschieht etwas?)]\
      Wartezeit zwischen 0 und 10 Minuten: $[a, b] = [0, 10]$

    + $x$ aus Text bestimmen\
      $x = 3$

    + Wahrscheinlichkeit ist ein konkreter Wert, in Dichte-Formel einsetzen

  $ f(3|0; 10) = 1/(10-0) = 0.1 = underline(10%) $

  2. Wie hoch ist die Wahrscheinlichkeit, dass sie höchstens 3 Minuten warten muss?

    + Wahrscheinlichkeit ist ein Intervall, deswegen Verteilungsfunktion verwenden

  $ F(x <= x| 0; 10) = (3 - 0)/(10 - 0) = 0.3 = underline(30%) $
]

#pagebreak()

== Dreiecks-Verteilung
Die Dreiecks-Verteilung hat zusätzlich zu den _Maximalwerten $bold([a,b])$_ noch den _wahrscheinlichsten Wert $bold(c)$_.
Alle Werte sammeln sich also _um_ $c$ an, befinden sich aber immer _zwischen_ $a$ und $b$.
Bei vielen praxisnahen Anwendungen sind nur _spärlich Daten_ vorhanden, um eine konkrete Verteilung der Grundgesamtheit
zu schätzen. Sind Werte wie Min, Max und Modus bekannt, nimmt man oft die Dreiecksverteilung.

#definition[
  Die _Dichte- und Verteilungsfunktion_ der Dreieck-Verteilung sind:
  #show math.cases: set text(size: 1.2em)
  #grid(
    align: horizon,
    [
      $
        f(x) = cases(
          (2 dot (x-a))/((b-a) dot (c-a))"," quad & a <= x <= c,
          2/(b-a)"," & x = c,
          (2 dot (b-x))/((b-a) dot (b-c))"," & c < x <= b
        )
      $
    ],
    [
      $
        F(x) = cases(
          (x-a)^2/((b-a) dot (c-a))"," & a <= x <= c,
          (c-a)/(b-a)"," & x = c,
          1 - (b-x)^2/((b-a) dot (b-c))"," quad & c < x <= b
        )
      $
    ],
  )
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = (a+b+c)/3 $], [$ "var"(X) = ((a-b)^2 + (b-c)^2 + (a-c)^2)/36 $],
)

== Exponential-Verteilung
Die Exponential-Verteilung ist der _Kehrwert_ der _Poisson-Verteilung_. Sie hat den Parameter $lambda$, der die
_Zahl eines erwarteten Ereignis $bold(A)$ pro Einheitsintervall_ festlegt. Damit wird die Wahrscheinlichkeit berechnet,
dass der Abstand zwischen zwei aufeinanderfolgenden Ereignissen $A$ höchstens das $x$-Fache der gegebenen Zeit
oder Strecke beträgt.\
Ein häufiger Einsatzzweck ist die _Berechnung der Länge von zufälligen Zeitintervallen_ #hinweis[(z.B. Zeit zwischen 2 Anrufen,
Lebensdauer von Atomen beim radioaktiven Zerfall, Lebensdauer von Maschinen ohne Berücksichtigung von Verschleiss).]

#definition[
  Die _Dichte- und Verteilungsfunktion_ der Exponential-Verteilung sind:
  #grid(
    align: horizon,
    [
      $
        f(t) = cases(
          lambda dot e^(-lambda dot x) space & ", für" x >= 0,
          0 & ", sonst"
        )
      $
    ],
    [
      $
        F(x) = cases(
          1 - e^(-lambda dot x) space & ", für" x >= 0,
          0 & ", für" x < 0
        )
      $
    ],
  )
]

#table(
  columns: (1fr,) * 3,
  align: horizon,
  table.header([Erwartungswert], [Varianz], [Median]),
  [$ E(X) = 1/lambda $], [$ "var"(X) = 1/lambda^2 $], [$ "Me" = ln(2)/lambda $],
)

*Beispiel:*\
#example-block[
  _Bei einer Hotline rufen pro Stunde durchschnittlich $5$ Kunden an._\
  #hinweis[(Nicht die gleiche Aufgabe wie bei der Poisson-Verteilung, es hängt von der Fragestellung ab!)]\

  + Wie viele Minuten vergehen durchschnittlich zwischen Anrufen?
    + $lambda$ bestimmen: $lambda = 5$
    + Aufgabenstellung beinhaltet "Durchschnittlich" $=>$ gesucht ist der *Erwartungswert*:\
  $ E(x) = mu = 1/lambda = 1/5 = 0.2 quad => quad 60 dot 0.2 = underline(12 "Minuten") $

  2. Wie gross ist die Wahrscheinlichkeit, dass höchstens $6$ Minuten zwischen $2$ Anrufen vergehen?
    + Wahrscheinlichkeit ist ein Intervall, also *Verteilungsfunktion*\
  $ 6 "Minuten"\/60 = 0.1 quad => quad F(x <= 0.1) = 1 - e^(5 space dot space 0.1) = 0.39 = underline(39%) $

  3. Wie gross ist die Wahrscheinlichkeit, dass zwischen zwei Anrufen $6$ bis $15$ Minuten vergehen?\
  $ F(0.1 <= x <= 0.25) = F(0.25) - F(0.1) = 0.71 - 0.39 = 0.32 = underline(32%) $
]

== Weibull-Verteilung
Die Weibull-Verteilung kann je nach _Einstellung ihrer Parameter_ der _Exponential-_ oder der _Normalverteilung_ ähneln.
Sie kann wie die Exponential-Verteilung eine zufällige Lebensdauer abschätzen, jedoch kann sie die Vorgeschichte
eines Merkmals berücksichtigen.

Ein häufiger _Einsatzbereich_ ist die Bestimmung von Wahrscheinlichkeiten für _Lebenszeiten von Maschinen oder Bauteilen_,
wobei anders als bei der Exponentialverteilung _Alter_ und _Nutzungsintensität_ mit in die Berechnungen eingehen können.
Besonders im Falle von kostenintensiven Anlagen ist diese aufwendige Differenzierung von Bedeutung.
Empirische Untersuchungen zeigen nämlich bei vielen Anlagen:

+ In der _ersten Phase_ eine zunächst hohe, dann sinkende Ausfallwahrscheinlichkeit,
  etwa bis die optimale Einrichtung und Einstellung erfolgt ist
+ In der _zweiten Phase_ eine gleichbleibend niedrige Ausfallrate
+ Mit zunehmendem Alter in der_ dritten Phase_ altersbedingt eine ansteigende Ausfallrate.

_Die Verteilung hat zwei Parameter:_ Den _Skalenparameter $bold(lambda)$_ und den _Formparameter $bold(k)$_.

_*$lambda$*_ gibt die mittlere Ausfallwahrscheinlichkeit pro Intervall an.

Beim Formparameter _*$k$*_ der Weibull-Verteilung können wir verschiedene Interpretationen ablesen:
- _$bold(k < 1)$_: Ausfallrate nimmt mit der Zeit ab #hinweis[(Ausfälle finden frühzeitig statt)]
- _$bold(k = 0)$_: Ausfallrate ist konstant #hinweis[(zufällige äussere Einflüsse verursachen Ausfall)]
- _$bold(k > 1)$_: Ausfallrate nimmt mit der Zeit zu #hinweis[(Alterungsprozesse verursachen Ausfälle)]

Da die Verteilung bei $k = 0$ wie die Exponentialverteilung auch eine _konstante Ausfallrate_ annimmt,
stellt diese also einen Spezialfall der Weibull-Verteilung dar.

#definition[
  Die _Dichte- und Verteilungsfunktion_ der Weibull-Verteilung sind:
  #grid(
    [
      $
        f(t) = cases(
          lambda dot k dot t^(k-1) dot e^(-lambda dot t^k) space & "für" t >= 0,
          0 & "sonst"
        )
      $
    ],
    [
      $
        F(x) = cases(
          1 - e^(-lambda dot x^k) space & "für" x >= 0,
          0 & "für" x < 0
        )
      $
    ],
  )
]
#table(
  columns: (1fr,) * 2,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = 1/lambda dot Gamma(1 + 1/k) quad => quad 1/lambda dot (1 + 1/k)! $],
  [$ "var"(X) = 1/lambda^2 dot (Gamma(1+2/k) - Gamma^2(1+1/k)) $],
)

=== Gammafunktion $Gamma()$ <gamma-func>
Die beiden Kenngrössen der Weibull-Verteilung und die Gamma-Verteilung verwenden die Gammafunktion $Gamma()$.\
Sie definiert, wie die _Fakultät_ für positive reelle Zahlen gehandhabt wird.
$
  Gamma(n) = cases(
    Gamma(n + 1) = n! & "," n in NN,
    Gamma(n) = integral^infinity_0 (t^(n-1) dot e^(-t))dif t space & "," n in RR^+
  )
$
#hinweis[In der Prüfung kann tendenziell einfach die Fakultät für die Gamma-Funktion eingesetzt werden.]

#pagebreak()

== Gamma-Verteilung
Die _Gamma-Verteilung $bold(G(theta, k))$_ wird häufig verwendet, um Warteschlangen zu modellieren
#hinweis[(z.B. Bedien- oder Reparaturzeiten)]. Sie hat den _Skalenparameter $theta$_ und den _Formparameter $k$_.
Für $k = 1$ erhält man die _Exponentialverteilung._

#definition[
  Die _Dichtefunktion_ der Gamma-Verteilung. Die Verteilungsfunktion ist zu kompliziert für die Prüfung.
  #set text(size: 1.1em)
  $ f(t) = (x^(k-1) dot e^(-t\/theta))/(theta^k dot Gamma(k)) space ", für" t >= 0 $
]

#table(
  columns: (1fr,) * 2,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = k dot theta $], [$ "var"(X) = k dot theta^2 $],
)

== Normalverteilung <normalvert>
Die _Normalverteilung $bold(cal(N)(mu, sigma^2))$_ ist eine der wichtigsten Verteilungen, sie bildet eine _Gauss-Glockenkurve_.
Die Werte sammeln sich symmetrisch um den _höchsten Punkt $bold(mu)$_ der Glockenkurve an.
Die Wendepunkte der Kurven sind _*$plus.minus sigma$*_ Einheiten von $mu$ entfernt. Die _Varianz *$sigma^2$*_ bestimmt,
wie eng die Werte um $mu$ liegen, bei einer hohen Varianz ist die Kurve entsprechend breiter.

Der _zentrale Grenzwertsatz besagt_, dass sich der Mittelwert und die Summe unabhängig und identisch verteilter
Zufallsvariablen bei einer beliebigen Verteilung mit zunehmenden Stichprobenumfang der Normalverteilung annähern.\
*Oder anders gesagt:* Viele kleine unabhängige Zufallseffekte summieren sich ungefähr zu einer Normalverteilung.
Dadurch sind z.B. Mittelwerte von Stichproben normalverteilt.

Ist also die Verteilung unbekannt, kann die Wahrscheinlichkeit approximativ mit der Normalverteilung berechnet werden.
Dazu sollte aber eine _Stichprobe $bold(n > 30)$_ vorliegen, wenn nicht, sollte man besser die Student-t-Verteilung verwenden.

#definition[
  #show math.attach: set text(size: 1.2em)
  #grid(
    row-gutter: 1em,
    align: horizon,
    [$ f(x) = 1/(sigma dot sqrt(2 dot pi)) dot e^(-1/2 dot ((t - mu)/sigma)) $],
    [
      _*$mu$*:_ Erwartungswert #hinweis[(Mittelwert)]\
      _*$sigma$*:_ Standardabweichung
    ],
    [
      $
        F(x) = integral^x_(-infinity) (1/(sigma dot sqrt(2 dot pi)) dot e^(-1/2 dot ((t - mu)/sigma))) dif t, sigma > 0
      $
    ],
    [
      #hinweis[Da dieses Integral nicht integrierbar ist, müssen die Verteilungswerte aus der
      Standardnormalverteilungstabelle abgelesen werden $->$ Standardisierung erforderlich!]
    ],
  )
]

#table(
  columns: (1fr,) * 2,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = mu $], [$ "var"(X) = sigma^2 $],
)

=== Standardnormalverteilung <std::normalverteilung>
Für die Verteilungsfunktion der Normalverteilung kann keine Stammfunktion gefunden werden, deswegen müssen
die Wahrscheinlichkeitswerte aus einer Verteilungstabelle abgelesen werden. Es gibt aber unendlich viele Normalverteilungen,
weil die Parameter $mu$ und $sigma$ unendlich viele Werte annehmen können. Um dieses Problem zu lösen und für jede
Normalverteilung einen Wahrscheinlichkeitswert zu erhalten, _standardisiert_ man die Normalverteilung.

Eine _standardisierte Normalverteilung $bold(cal(N)(0, 1))$_ ist gegeben, wenn $mu = 0$ und $sigma^2 = 1$.
Um eine _standardisierte Zufallsvariable $bold(Z)$_ zu erhalten, gilt folgende Formel. Mit diesem Wert kann die
_Wahrscheinlichkeit $bold(Phi(Z))$_ #hinweis[(manchmal auch $F(Z)$)] aus einer Standardnormalverteilungstabelle
abgelesen werden.\
_Achtung:_ Ist $Z < 0$, muss 1 minus $Phi$ vom positiven Wert gerechnet werden!

#definition[
  #grid(
    columns: (1fr, 1.5fr),
    align: horizon,
    [
      $
             Z & = (X - mu)/sigma quad => quad Phi(Z) \
        Phi(Z) & = cases(Phi(Z) &"," Z >= 0, 1 - Phi(abs(Z)) space &"," Z < 0)
      $
    ],
    [
      _*$Z$*:_ standardnormalverteilte Zufallsvariable\
      _*$X$*:_ nicht-standardisierte normalverteilte Zufallsvariable\
      _*$mu, sigma^2$*:_ Parameter der nicht-standardisierten Normalverteilung \
      _*$Phi$*:_ Verteilungsfunktion, Wert aus Tabelle ablesen
    ],
  )
  #hinweis[Taschenrechner: Menü-5-5-2 $"normCdf"(-#sym.infinity, x, 0, 1)$]
]

Ebenfalls gibt es eine Umkehrfunktion um von der Wahrscheinlichkeit $q$ das $q$-Quantil $z_q$ zu erhalten.
Dazu schlägt man in der Quantile der Standartnormalverteilungstabelle nach.
$ Phi(Z_q) = q "(aus Quantil-Tabelle oder TR normCdf)" $

*Beispiel:*\
#example-block[
  _Bier wird in Dosen mit einer durchschnittlichen Füllmenge von $753 "ml"$ mit einer Standardabweichung von $2"ml"$ abgefüllt._

  + Wie gross ist die Wahrscheinlichkeit, dass die Sollfüllmenge von $750"ml"$ unterschritten wird?
    + Transformieren zu Standardnormalverteilung
    $ Z = (x - mu)/sigma = (750 - 753)/2 = -1.5 $

    2. Wert von $Z$ in Standardnormalverteilungstabelle nachschlagen\
  $ Rho(Z <= -1.5) = Phi(Z) = 1 - Phi(abs(Z)) = 1 - Phi(1.5) = 1 - 0.9332 = 0.0668 = underline(6.68%) $

  2. Wie gross ist die Wahrscheinlichkeit, dass in einer Dose mindestens 757ml enthalten sind?
    1. Transformieren zu Standardnormalverteilung
    $ Z = (x - mu)/sigma = (757 - 753)/2 = 2 $

    2. Grösser als etwas $=>$ 1 - kleiner als etwas\
  $ Rho(Z > 2) = 1 - Rho(Z < 2) = 1 - Phi(Z) = 1 - Phi(2) = 1 - 0.9773 = 0.0227 = underline(2.28%) $
]

Bei zwei Grenzen ($x$ zwischen $y$ und $z$), müssen die Wahrscheinlichkeiten einfach voneinander subtrahiert werden.
Um aus der Wahrscheinlichkeit die Anzahl zu erhalten, Gesamtanzahl mal Wahrscheinlichkeit rechnen.

== Überblick stetige Verteilungen
#table(
  columns: (auto, 1fr),
  table.header([Name], [Anwendung]),
  [_Rechteck-Verteilung /\ Gleichverteilung_],
  [Zahlen sind in einem Intervall und alle gleich wahrscheinlich\ #hinweis[(z.B. Fehler- oder Temperaturgrenzen)]],

  [_Dreiecks-Verteilung_],
  [Zahlen sind in einem Intervall und haben einen wahrscheinlichsten Wert\ #hinweis[(wenn Minimum, Maximum und Modus bekannt sind)]],

  [_Exponential-Verteilung_], [Wenn Zahlen exponentialverteilt sind #hinweis[(Radioaktiver Zerfall, Lebensdauer)]],

  [_Weibull-Verteilung_],
  [Ähnelt der Exponential- oder der Normalverteilung\ #hinweis[(z.B. für Lebensdauer, wenn Vorgeschichte relevant)]],

  [_Gamma-Verteilung_], [Wird häufig für Warteschlangenmodellation verwendet],

  [_Normalverteilung_],
  [Viele kleine unabhängige Zufallseffekte. Ist die Verteilung unbekannt, kann sie mit der Normalverteilung approximiert werden.],
)

#pagebreak()

== Erzeugen von Pseudo-Zufallszahlen
Um Simulationsexperimente durchzuführen, müssen Zufallszahlen erzeugt werden.
- Diese müssen _einer bestimmten Verteilungsfunktion folgen_ #hinweis[(muss auf die Experimentdaten passen)]
- Diese müssen _eindeutig in ihrer Reihenfolge wiederholbar sein_\
  #hinweis[(damit Experiment unter gleichen Bedingungen wiederholbar ist)]
- Es müssen _beliebig viele Zufallszahlenfolgen erzeugbar sein_\
  #hinweis[(um verschiedenen Prozessen verschiedenes Verhalten zu geben und unterschiedliche Experimente durchzuführen)]

"Echte" Zufallszahlen sind aufgrund von fehlender Reproduzierbarkeit und schlechten statistischen Eigenschaften ungeeignet,
deshalb verwendet man _Pseudo-Zufallszahlen_.

Ein _Random Number Generator (RNG)_ kann gleichverteilte Pseudo-Zufallszahlen z.B. durch _linear congruential generators_
realisieren. Diese haben einen Initialwert, den _Seed_, welcher immer die gleiche Folge an Pseudo-Zufallszahlen generiert.
Ein Durchlauf dauert so lange, bis wieder der Seed ausgegeben wird. Es ist nicht garantiert, dass jeder Wert im
Intervall $[0, m]$ ausgegeben wird. Je nach Parameter kann ein Durchlauf eine sehr kurze/lange Zyklenlänge haben.

#definition[
  #grid(
    columns: (1fr, 2fr),
    align: horizon,
    [$ X_(n+1) = (a dot X_n + c) mod(m) $],
    [
      _*$m$*:_ Modulus, die Zufallszahl wird im Intervall $[0, m]$ sein, meist Primzahl\
      _*$a$*:_ Multiplier, die letzte Zahl wird damit multipliziert\
      _*$c$*:_ Increment, die Multiplikation wird um diesen Wert verschoben\
      _*$x_0$*:_ Seed, Initialwert
    ],
  )
]

*Beispiel mit $m = 9$, $a = 2$, $c = 0$, $x_0 = 1$*\
$
  [1] space arrow((2 dot 1 + 0) mod 9) space [2] space arrow((2 dot 2 + 0) mod 9) space
  [4] space arrow((2 dot 4 + 0) mod 9) space [8] space arrow((2 dot 8 + 0) mod 9) space [7] -> [5] -> [1]
$

*Beispiel mit $m = 9$, $a = 4$, $c = 1$, $x_0 = 0$*\
$
  [0] space arrow((4 dot 0 + 1) mod 9) space [1] space arrow((4 dot 1 + 1) mod 9) space
  [5] space arrow((4 dot 5 + 1) mod 9) space [3] -> [4] -> [8] -> [6] -> [7] -> [2] -> [0]
$

=== Inversive Transformationsmethode
Durch die inversive Transformationsmethode, auch _Simulationslemma_ genannt, kann aus gleichverteilten Zufallszahlen,
welche durch eine Zufallsfunktion $U = F x(X)$ erzeugt wurden, mithilfe der Umkehrfunktion $X = F^(-1)x(U)$ eine
andere Verteilungsfunktion generiert werden.

*Beispiel:* \
#example-block[
  _Gegeben sind die zwischen $[0, 1]$ gleichverteilten Zufallszzahlen:_
  $ "Intervall" = [0,1], quad u_i = (0.71, 0.11, 0.98, 0.64) $

  + Transformiere die Zahlen so, dass sie einer Gleichverteilung mit $a = 2, b = 7$ folgen.
    + Verteilungsfunktion der Gleichverteilung aufschreiben und mit $u$ gleichsetzen
    $ F(x) = u = (x-a)/(b-a) $

    2. Verteilungsfunktion invertieren (nach $x$ auflösen) und Werte von $u_i$ in Formel einfügen
  $ F^(-1)(u) = x = u dot (b-a) + a = u_i dot (7 - 2) + 2 quad => quad underline(x_i = (5.55, 2.55, 6.90, 5.20)) $

  2. Transformiere die Zahlen so, dass sie einer Exponentialverteilung mit $lambda = 0.5$ folgen.\
  $
    F(x) = u = 1 - e^(-lambda dot x) quad => quad F^(-1)(u) = x = 1/lambda dot ln(1-r) quad => quad
    underline(x_i = (2.48, 0.23, 7.82, 2.04))
  $
]


= Schliessende Statistik
Die schliessende Statistik versucht auf der _Basis statistischer Modelle_ und _Daten aus Stichproben_ zu
allgemeinen Aussagen über eine Grundgesamtheit zu gelangen. Es werden Hypothesen über Verteilungen von Merkmalen getestet,
indem die angenommenen Verteilungen mit gemessenen Werten #hinweis[(Stichproben)] verglichen werden.

Liegt nur eine _Stichprobe_ der Grundmenge vor #hinweis[(z.B. eine Messreihe, diese ist auch nur eine Stichprobe)],
_ohne_ dass der _Mittelwert *$mu$* _oder die _Varianz *$sigma^2$*_ bekannt sind, können mithilfe der Schliessenden Statistik
Testverfahren bzw. -verteilungen bestimmt werden, die Aussagen über die Genauigkeit der Schätzungen und die
Verteilfunktion erlauben.

== Konfidenzintervall
Das Konfidenzintervall gibt den Wertebereich an, in welcher sich ein Datenpunkt einer Verteilung mit einer
bestimmten Wahrscheinlichkeit, dem _Konfidenzniveau $bold(alpha)$_, befinden sollte.\
Beliebte Konfidenzniveaus sind 90%, 95%, 99% #hinweis[(verwendet als 0.9, 0.95, 0.99)].

#grid(
  [
    Haben wir _eine Stichprobe_ #hinweis[(gemessene Daten)] ${x_1, ..., x_n}$, ist der Mittelwert dieser:
    $ #x- = 1/n sum^n_(i=1) x_i $
  ],
  [
    Hat man _mehrere Stichproben_, ist der Mittelwert aller Stichproben die _Stichprobenfunktion_:
    $ dash(X) = 1/n sum^n_(i=1) X_i $
  ],
)

Der Konfidenzintervall ist selbst wieder eine Zufallsvariable und streut um den Mittelwert der Grundgesamtheit.

#definition[
  #grid(
    align: horizon,
    [$ Rho(#x- _u <= dash(X) <= #x- _o) = 1 - alpha $],
    [
      _$bold(#x- _u), bold(#x- _o)$:_ Untere/Obere Grenze des Konfidenzintervalls\
      _$bold(dash(X))$:_ Wert der Realisation\
      _*$alpha$*:_ Konfidenzniveau als Kommazahl in $[0, 1]$
    ],
  )
]

==== Satz 1: Wenn der Stichprobenmittelwert dieselbe Verteilung wie $X$ hat, gilt
- Die Summe der Zufallsvariablen #hinweis[(einzelne Mittelwerte)] ist wieder eine Zufallsvariable
- Der Erwartungswert der Stichprobe ist gleich dem Erwartungswert der Grundgesamtheit\
$ dash(X) = mu_#x- = 1/n sum^n_(i=1) X_i = mu $
- Die Varianz der Stichprobe wird immer kleiner, je grösser der Stichprobenumfang $n$ wird
  #hinweis[(die gemessenen Mittelwerte nähern sich dem tatsächlichen Mittelwert)].
$ sigma^2_dash(X) = sigma^2/n $

#grid(
  columns: (2fr, 1fr),
  [
    *Beispiel Würfel:*\
    Je öfters ein Würfel geworfen wird, desto kleiner wird die Varianz, während der Mittelwert gleich bleibt.
  ],
  image("img/ExEv_10.png"),
)

#small[
  #table(
    columns: (1fr,) * 4,
    table.header([], [1\. Wurf], [2\. Wurf], [3\. Wurf]),
    [*Mittelwert $mu$*], [$3.5$], [$3.5$], [$3.5$],
    [*Varianz $sigma^2$*], [$2.29$], [$2.29\/2 = 1.46$], [$2.29\/3 = 0.97$],
    [*Standardabweichung $sigma$*], [$1.71$], [$1.21$], [$0.89$],
  )
]

==== Satz 2: Ist die Zufallsvariable $X$ zusätzlich noch normalverteilt, ist auch der Stichprobenmittelwert normalverteilt
#definition[
  #grid(
    columns: (1fr, 1.2fr),
    align: horizon,
    [$ dash(X) => N(mu; sigma/sqrt(n)) $],
    [
      _*$sigma, mu$*:_ Standardabweichung & Mittelwert der Grundmenge\
      _*$N$*:_ Verteilungsfunktion der Normalverteilung\
      _*$n$*:_ Anzahl Stichproben\
      _$bold(dash(X))$:_ Zufallsvariable der Stichprobe
    ],
  )
]

== Testverfahren der Normalverteilung <test-normal>
Viele Ergebnisse sind annähernd normalverteilt, je grösser die Anzahl Stichproben wird.\ #hinweis[(siehe @normalvert)]\
_Faustregel:_ Ab $n >= 30$ ist die Normalverteilung unabhängig von der tatsächlichen Verteilung als Approximation geeignet.

#definition[
  _Standardisierte Stichproben-Zufallsvariable_
  #grid(
    align: horizon,
    [$ Z = (X - mu)/(sigma\/sqrt(n)) $],
    [
      _*$n$*:_ Anzahl Durchführungen\
      _*$X$*:_ Gesuchter Wert\
      _*$sigma, mu$*:_ Standardabweichung & Mittelwert
    ],
  )
]

*Beispiel mit unterer Schranke:*\
Eine Maschine produziert im normalverteilten Mittel $10$ Stück pro Sekunde mit einer Standardabweichung von $1.5$ pro Sekunde.
Es werden $50$ Messungen durchgeführt.

Mit welcher Wahrscheinlichkeit liegt die mittlere Produktion unter $9.5$ Stück?
+ Variablen aus dem Text bestimmen\
$ n = 50, quad mu = 10, quad X = 9.5, quad sigma = 1.5 $

2. Werte in Formel einsetzen
$ Z = (9.5 - 10)/(1.5 \/ sqrt(50)) = -2.36 $

3. Berechneten Wert in die Tabelle der Standardnormalverteilung einsetzen\
$ Phi(Z) = Phi(-2.36) = 0.0091 $

$arrow.double$ Der Mittelwert liegt mit einer Wahrscheinlichkeit von $0.91%$ im Intervall $[-infinity, 5]$

*Beispiel: mit Konfidenzintervall (erlaubte Toleranz) die Wahrscheinlichkeit berechnen*\
Eine Maschine produziert im normalverteilten Mittel $10$ Stück pro Sekunde mit einer Standardabweichung von $1$ pro Sekunde.
Es werden $25$ Messungen durchgeführt. Mit welcher Wahrscheinlichkeit liegt die mittlere Produktion
zwischen $9.8$ und $10.2$ Stück pro Sekunde?

+ Wahrscheinlichkeitsformel aufstellen
$ Rho(9.8 <= #x- <= 10.2) = 1 - alpha $

2. Die Konfidenzintervallschranken standardisieren #hinweis[(in standardisierte Zufallsvariable konvertieren)]

$
  Rho((9.8-10)/(1\/sqrt(25)) <= dash(Z) <= (10.2-10)/(1\/sqrt(25)))
  = Rho(-0.2/0.2 <= dash(Z) <= 0.2/0.2) = Rho(-1 <= dash(Z) <= 1)
$

3. Mit den Schranken die Wahrscheinlichkeit in der Standardnormalverteilungstabelle ablesen
$
  Phi(1) = underbracket("normCdf"(-infinity, 1,0,1), 5-5-2 "im TR") = 0.8413, quad Phi(-1) = 1 - Phi(1)
  = 1 - 0.8413 = 0.1587
$

4. Die Differenz der Wahrscheinlichkeit der Schranken berechnen\
$ 0.8413 - 0.1587 = 0.6843 = underline(68.43%) $

#pagebreak()

*Beispiel: mit Wahrscheinlichkeit das Konfidenzintervall berechnen*\
In welchem Konfidenzintervall liegt der Mittelwert bei der obenstehenden Aufgabe, wenn das Konfidenzniveau
#hinweis[(vorgegebene Wahrscheinlichkeit)] $95%$ ist?

1. Variablen aus dem Text bestimmen\
$ n = 50, quad alpha = 0.95, quad sigma = 1.5 $

2. $Z$-Wert aus der Standardnormalverteilungs-Quantiltabelle auslesen\
  #hinweis[(Da die Abweichung beidseitig sein kann, muss der Wert 0.975 anstelle von 0.95 verwendet werden.)]\
$ Phi^(-1)(Z_q) = Phi(0.975) = underbracket("invNorm"(0.975,0,1), 5-5-3 "im TR") = underline(1.96) $

== Studentische t-Verteilung
Ist die Anzahl Stichproben $< 30$, ist die _$t$-Verteilung_ oft besser geeignet als die Normalverteilung.
Sie flacht an den Enden weniger stark ab als die Normalverteilung, ist aber dafür um den Mittelwert weniger hoch.
Auch wird bei der $t$-Verteilung die _Standardabweichung nicht benötigt_.
Der Vertrauensfaktor $t$ wird aus der $t$-Verteilungstabelle abgelesen und ist von der Anzahl Freiheitsgrade abhängig.

=== Freiheitsgrad
Der _Freiheitsgrad $bold(r)$/$bold(nu)$_ bestimmt bei einer Gleichung, wie viele Parameter "frei" wählbar sind,
wenn das Resultat $y$ bekannt ist. Bei den Verteilungstests ist vor allem der Mittelwert wichtig.
Ist dieser bekannt, können $n-1$ Parameter zufällig gewählt werden. Der letzte aber muss so gewählt werden,
dass die Summe aller Parameter $mu$ ergibt.

*Beispiel:*\
Bei $n = 5, mu = 7$ können die ersten $4$ Werte frei gewählt werden, der $5$. aber so, dass die Werte in
der Summe $7$ ergeben. Die Anzahl Freiheitsgrade ist also $4$.

#definition[
  #grid(
    align: horizon,
    [
      _Dichtefunktion_ der $t$-Verteilung:
      $
          f(t) & = 1/(sqrt(r) dot B(1/2, r/2)) dot (1 + t^2/r)^(-1/2 dot (r + 1)) \
        B(x,y) & = integral^1_0 (t^(x-1) dot (1 - t)^(y-1)) dif t \
             t & = (#x- - mu)/(sigma\/sqrt(n))
      $
    ],
    [
      _*$t$*:_ Vertrauensfaktor #hinweis[(aus der t-Verteilungstabelle ablesen)]\
      _*$r$*:_ Anzahl Freiheitsgrade\
      _*$B()$*:_ Betafunktion
    ],
  )
  #hinweis[TR: Menü-5-5-5 $-> "tCdf"(-infinity, x, r)$]
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = 0, "für" r > 1 $], [$ "var"(X) = r/(r-2), "für" r > 2 $],
)

#pagebreak()

*Beispiel:*
#example-block[
  _Eine Zufallsvariable $X$ ist $t$-verteilt mit $nu = 10$ Freiheitsgraden._

  + Wie hoch ist die Wahrscheinlichkeit, dass $x$ zwischen $-1.4$ und $1.8$ liegt?
    + Vertrauensfaktoren aus der $t$-Verteilungstabelle bei entsprechendem $k$ ablesen.
      Dabei sollten die Werte in der Tabelle die oben genannten Grenzwerte vollständig umfassen\
      $ F(x < 1.4) approx 0.9, quad F(x < 1.8) approx 0.95 $

    + Wahrscheinlichkeit ausrechnen, dabei $1$ minus negativer Wert rechnen
      $
        Rho(-1.4 < x < 1.8) & = F(x < 1.8) - F(x < -1.4) \
                            & = F(x < 1.8) - (1 - F(x < 1.4)) = 0.95 - (1-0.9) = underline(0.85)
      $
    #hinweis[Einfacher geht es mit dem Taschenrechner: Menü-5-5-5 $"tCdf"(x_u, x_o, r) arrow "tCdf"(-1.4, 1.8, 10) = 0.853091$]

  + In welchem mittlerem Bereich liegen die Realisationen mit einer Wahrscheinlichkeit von $99%$?\
    1. Wert aus $t$-Verteilungstabelle bei entsprechendem $k$ ablesen\
    $ 0.995 = Rho(x > 3.1693) $

    2. Intervall bilden, in welchem sich der Prozentsatz der Werte befindet\
    $ x = [-3.1693, +3.1693] $
]

== Chi-Quadrat-Verteilung
Hat man Zufallsvariablen, die _unabhängig_ und _standardnormalverteilt_ sind, ist die Chi-Quadratverteilung $chi^2$
die Verteilung der Summe der quadrierten Zufallsvariablen. Solche Summen quadrierter Zufallsvariablen treten auf bei:
_Varianz $bold(sigma^2)$ einer Stichprobe_, _Hypothesentest über die Verteilungsform_, _Unabhängigkeitstest_.
Wie die $t$-Verteilung hat sie die _Anzahl Freiheitsgrade_ als Parameter. Nähert sich mit zunehmender Anzahl Freiheitsgrade
der Normalverteilung an.

#definition[
  _Dichtefunktion_ der $chi^2_r$-Verteilung:
  #grid(
    row-gutter: 1em,
    align: horizon,
    [
      $
        f(t) & = cases(
                 1/(2^(r\/2) dot Gamma(r\/2)) dot t^((r\/2)-1) dot e^(-(t\/2)) space & ", für" t > 0,
                 0 & ", für" t <= 0
               )
      $
    ],
    [
      _*$t$*:_ Vertrauensfaktor, aus der $chi^2$-Tabelle ablesen\
      _*$r$*:_ Anzahl Freiheitsgrade\
      _*$Gamma()$*:_ Gammafunktion\ #hinweis[(siehe Kapitel @gamma-func)]\
    ],
  )
  #hinweis[TR: Menü-5-5-8 $-> chi^2"norm"(0, x, r)$ ]
]

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Erwartungswert], [Varianz]),
  [$ E(X) = r $], [$ "var"(X) = 2 dot r $],
)

*Beispiel:*
#example-block[
  _Eine Zufallsvariable $X$ ist $chi^2$-verteilt mit $nu = 10$ Freiheitsgraden._

  Wie hoch ist die Wahrscheinlichkeit, dass $x$ zwischen $15$ und $20$ liegt?
  + Werte aus der $chi^2$-Verteilungstabelle ablesen #hinweis[(ungenaue Werte!)]
  $ F(x < 15) approx 0.9, quad F(x < 20) approx 0.975 $

  2. Wahrscheinlichkeit ausrechnen
  $ Rho(15 < x < 20) = F(x < 20) - F(x < 15) = 0.975 - 0.9 = underline(0.075) $

  Einfacher geht es mit dem Taschenrechner: Menü-5-5-8 $-> chi^2"norm"(x_u, x_o, r)$
  $ chi^2"norm"(15, 20, 10) = 0.102809 "(genauer als mit der Tabelle)" $
]


= Schätzverfahren
Häufig sind _$mu$, $sigma$ und die Verteilungsfunktion bekannt_, wenn sehr viele Messungen/Experimente durchgeführt werden.
Diese sind jedoch teuer und sollen deshalb auf ein Minimum reduziert werden. Deswegen werden die Parameter oft geschätzt.

- _Schätzverfahren:_ Schätzt unbekannte Parameter der Verteilung eines Merkmals in der Grundgesamtheit anhand einer Stichprobe
  - _Punktschätzung:_ Schätzung durch Angabe eines einzigen Wertes
  - _Intervallschätzung:_ Schätzung durch Angabe eines Intervalls
- _Schätzfunktion:_ Ordnet einer Stichprobe einen Wert zu und lässt damit von der Stichprobe auf die Grundgesamtheit schliessen. Damit lässt sich der Fehler einer falschen Schätzung bestimmen/minimieren
- _Schätzwert $bold(hat(T))$:_ Ergebnis der Schätzung von $T$, dem Parameter der Grundgesamtheit
- _Anteilswert $bold(p = k\/n)$_: Die Wahrscheinlichkeit eines Ereignisses. Ist ein Laplace-Experiment.
- _Zufallsstichprobe:_ Es werden zufällig Elemente aus der Grundgesamtheit für eine Stichprobe gewählt.

== Punktschätzung
Mit der Punktschätzung wird ein oder mehrere Parameter so gut wie möglich durch einen einzelnen Wert angenähert.
Dies geschieht durch die _quadratische Abweichung_:
$ E[(hat(T) - T)^2] = "var"(hat(T)) + [E(hat(T) - T)^2] $

Ist $E(hat(T) - T) = 0$, ist die Schätzung _erwartungstreu_, hat also keine Abweichung vom tatsächlichen Wert.

#table(
  columns: (1fr,) * 2,
  align: horizon,
  table.header([Mittelwert-Schätzfunktion], [Varianz-Schätzfunktion]),
  [$ mu = #x- = 1/n sum^n_(i = 1) x_i $], [$ sigma^2 = s^2 = 1/(n-1) sum^n_(i=1) (x_i - dash(X))^2 $],
)
Die durch obenstehende Schätzfunktionen erzeugten Parameter sind normalverteilt ($mu$) bzw. Chi-Quadrat-verteilt ($sigma$)

== Intervallschätzung des Erwartungswertes
Die Intervallschätzung zielt darauf ab, einen Bereich anzugeben, der mit einer gewissen #hinweis[(selbst gewählten)]
Wahrscheinlichkeit den wahren Wert enthält. Dieser Bereich  wird auch _Konfidenzintervall_ genannt.
Häufige Konfidenzintervalle sind $90%$, $95%$ und $99%$.

Es gibt _5 Schritte zur Erstellung eines Konfidenzintervalls_ für den Mittelwert $dash(X)$ der Stichprobe $X$:

*1.  Feststellung der Verteilungsform*\
Zuerst muss festgestellt werden, welche Verteilung das Stichprobenmittel $dash(X)$ besitzt:
#table(
  columns: (27%, 0.39fr, 1fr),
  align: horizon,
  table.header([Verteilung des Merkmals $dash(X)$], [Varianz $sigma^2$ bekannt], [Varianz $sigma^2$ unbekannt]),
  [*Normalverteilt*],
  [$dash(X)$ ist normalverteilt],
  [
    Bei $n<=30$: $dash(X)$ ist $t$-verteilt mit $k = n-1$ Freiheitsgraden\
    Bei $n > 30$: $dash(X)$ ist approximativ normalverteilt
  ],

  [*Nicht normalverteilt*],
  table.cell(colspan: 2, rowspan: 2, align: center)[$dash(X)$ ist approximativ normalverteilt],

  [*Unbekannt ($n>30$)*],
)

*2. Feststellung der Varianz*\
Als zweites wird die _Varianz_ für das Stichprobenmittel _bestimmt_, wobei gilt:

$ N = "Grösse der Grundmenge", quad n = "Grösse der Stichprobe", quad s^2 = "Varianz-Schätzfunktion" $

Für die Bestimmung von mit/ohne Zurücklegen/Wiederholung siehe Kapitel @kombinator-checklist.
#table(
  columns: (1fr,) * 3,
  align: horizon,
  table.header([Stichprobenart], [Varianz $sigma^2$ bekannt], [Varianz $sigma^2$ unbekannt]),
  [*Mit Zurücklegen*\ #hinweis[(unendliche Grundgesamtheit)]],
  [$ sigma^2_dash(X) = sigma^2/n $],
  [$ hat(sigma)^2_dash(X) = s^2/n $],

  [*Ohne Zurücklegen und $display(n/N < 0.05)$*],
  [$ sigma^2_dash(X) approx sigma^2/n $],
  [$ hat(sigma)^2_dash(X) approx s^2/n $],

  [*Ohne Zurücklegen und $display(n/N >= 0.05)$*],
  [$ sigma^2_dash(X) = sigma^2/n dot (N-n)/(N-1) $],
  [$ sigma^2_dash(X) = s^2/n dot (N-n)/N $],
)

*3. Bestimmen des Quantilwerts $Z$*\
Mittels Tabelle oder Rechner.

*4. Berechnen des maximalen Schätzfehlers*\
Der maximale Schätzfehler ist das Produkt aus Quantilwerts und Standardabweichung von $X$.

*5. Ermitteln der Konfidenzintervallgrenzen*\
Die Konfidenzgrenzen ergeben sich durch Addition/Subtraktion des max. Schätzfehlers vom Stichprobenmittel $dash(X)$.

== Intervallschätzung eines Anteilwerts
Funktioniert ähnlich wie die Schätzung des Erwartungswerts

*1. Bestimmen der Verteilungsform von $P$*\
Ist $n dot P dot (1-P) > 9$, ist die Schätzfunktion approximativ normalverteilt.

*2. Bestimmen der Varianz von $P$*\
Für die Bestimmung von mit/ohne Zurücklegen/Wiederholung siehe Kapitel @kombinator-checklist.

#table(
  columns: (1fr,) * 3,
  align: horizon,
  table.header([Stichprobenart], [Varianz $sigma^2$ bekannt], [Varianz $sigma^2$ unbekannt]),
  [*Mit Zurücklegen*\ #hinweis[(unendliche Grundgesamtheit)]],
  table.cell(colspan: 2)[$ hat(sigma)^2_P = (P dot (1-P))/n $],

  [*Ohne Zurücklegen und $display(n/N < 0.05)$*],
  table.cell(colspan: 2)[$ hat(sigma)^2_P approx (P dot (1-P))/n $],

  [*Ohne Zurücklegen und $display(n/N >= 0.05)$*],
  [$ hat(sigma)^2_dash(X) = (P dot (1-P))/n dot (N-n)/(N-1) $],
  [$ hat(sigma)^2_dash(X) = (P dot (1-P))/n dot (N-n)/N $],
)

*3. Bestimmen des Quantilwerts $Z$*\
Mittels Tabelle oder Rechner.

*4. Berechnung des maximalen Schätzfehlers*\
Der maximale Schätzfehler ist das Produkt aus Quantilwerts und Standardabweichung von $P$.

*5. Ermitteln der Konfidenzintervallgrenzen*\
Die Konfidenzgrenzen ergeben sich durch Addition/Subtraktion des max. Schätzfehlers vom Stichprobenmittel $dash(P)$.

#pagebreak()

== Stichprobenumfangberechnung
Für die Intervallschätzung muss manchmal die _Stichprobengrösse_ bestimmt werden, also wie viele Proben mindestens
in der Stichprobe enthalten sein müssen, um eine bestimmte _Genauigkeit $alpha$_ erreichen zu können.
Für die Bestimmung des $Z$-Wertes aus der Standardnormalverteilung muss die Wahrscheinlichkeit $1-alpha$ angewendet werden.

#definition[
  #grid(
    align: horizon,
    row-gutter: 1em,
    [
      _Mit Zurücklegen/Wiederholung_
      $ n >= (Z^2 dot sigma^2)/e^2 $
      _Ohne Zurücklegen/Wiederholung_
      $ n >= (Z^2 dot N dot sigma^2)/(e^2 dot (N-1) + Z^2 dot sigma^2) $
    ],
    [
      _*$N$*:_ Anzahl Elemente in der Grundgesamtheit\
      _*$sigma^2$*:_ Varianz der Verteilung\
      _*$e$*:_ Absolute Abweichung bzw. Fehler vom Mittelwert\
      _*$Z$*:_ standardnormalverteilte Zufallsvariable\ #hinweis[(siehe @std::normalverteilung)]
    ],
  )
]

*Beispiel ohne Zurücklegen*\
#example-block[
  _Eine Lieferung von $1'000$ Paketen Zucker ist mit einer $95%$ Konfidenz zu untersuchen, ob der garantierte
  Mittelwert eingehalten wird. Der Fehler $e = 0.2$g und die Standardabweichung $sigma = 1.2$g sind bekannt._

  + Wie viele Pakete müssen mindestens entnommen werden?

    1. $Z$ aus Quantil-Standardnormalverteilungstabelle $Phi(Z_q)$ bestimmen\
      $ 95% => 2.5% "links & rechts der Normalverteilung" = 0.975 quad => quad Z = Phi(0.975) = 1.96 $

    2. Werte in Formel einsetzen\
      $
        n >= (1.96^2 dot 1'000 dot 1.2^2)/(0.2^2 dot (1'000-1) + 1.96^2 dot 1.2^2) = 121.6 quad => quad underline(n > 122)
      $
]

== Intervallschätzung der Varianz
#definition[
  #grid(
    align: horizon,
    [
      $
        Rho(
          ((n-1) dot s^2)/(y_(1-alpha/2; r=n-1)) <= sigma^2
          <= ((n-1) dot s^2)/(y_(alpha/2; r=n-1))
        )
      $
    ],
    [
      _*$r$*:_ Anzahl Freiheitsgrade\
      _*$s$*:_ Varianzschätzfunktion\
      _*$y$*:_ Verteilungsfunktion für neue, $chi^2$-verteilte Zufallsvariable
    ],
  )
]


= Testverfahren
Durch Erstellen und Experimentieren an einem Modell eines realen Produktionssystems möchte man ein verbessertes Modell
erhalten, welches sich dann auf die realen Systeme anwenden lässt. In diesem Prozess werden zwei Hypothesen
#hinweis[(Annahmen)] aufgestellt:

- _*$H_0$*:_ Das Modell verhält sich bezüglich der zu untersuchenden Fragestellung wie das reale System
  #hinweis[(Keine Veränderung)]
- _*$H_1$*:_ Das verbesserte Modell verhält sich signifikant leistungsstärker als das ursprüngliche System
  #hinweis[(Veränderung)]

Diese beiden Hypothesen müssen überprüft werden, bzw. die Wahrscheinlichkeit des Fehlers soll bestimmt werden.

#pagebreak()

== Fehlerarten
Bei der Überprüfung einer Hypothese kann es zu zwei verschiedenen Arten von Fehlern kommen.

#grid(
  columns: (3fr, 1fr),
  [
    === Fehler erster Art (false negative)
    Der Fehler erster Art #hinweis[(auch Produzentenrisiko genannt)] ist _die Ablehnung einer korrekten Hypothese:_
    Wenn der Wert ausserhalb des Konfidenzintervalls liegt, wird die Hypothese verworfen. Hat man beispielsweise
    einen $95%$-Konfidenzintervall und der erhaltene Wert liegt aber in den anderen $5%$, so wird die Hypothese
    als "unwahrscheinlich" verworfen, obwohl sie eigentlich korrekt ist.
  ],
  image("img/ExEv_11.png"),
)

#grid(
  columns: (3fr, 1fr),
  [
    === Fehler zweiter Art (false positive)
    Der Fehler zweiter Art #hinweis[(auch Konsumentenrisiko genannt)] ist _das Annehmen einer inkorrekten Hypothese:_
    Der erhaltene Wert bzw. die erhaltene Verteilung hat beispielsweise einen anderen Mittelwert als die Hypothese
    angenommen hat. Durch den gesetzten Konfidenzintervall liegt dieser aber immer noch in einem wahrscheinlichen Bereich.
    Die Hypothese wird somit angenommen, obwohl sie nicht der tatsächlichen Verteilung entspricht.
  ],
  image("img/ExEv_12.png"),
)

== Parametertest
Der _Parametertest_ prüft anhand einer Stichprobe, ob eine Hypothese zu einem bestimmten Parameter
#hinweis[(Mittelwert oder Varianz)] zutrifft. Um diesen durchführen zu können, wird jeweils eine Annahme über
die Verteilung der _Grundgesamtheit_ getroffen.

Bevor ein Parametertest durchgeführt werden kann, müssen zunächst verschiedene Werte festgelegt werden:
- _Nullhypothese $bold(H_0)$:_ Fragestellung, welche aussagt, dass die geprüften Daten *keinen Zusammenhang* haben,
  das Experiment hat nicht den gewünschten Effekt
- _Alternativhypothese $bold(H_1)$:_ Fragestellung, welche aussagt, *dass sich etwas ändert* -- das Experiment hat
  den gewünschten Effekt. Sie ist immer die Negation #hinweis[(das Gegenteil)] der Nullhypothese
  #hinweis[(vgl. indirekter Beweis in der Mathematik)]
- _Signifikanzzahl $bold(alpha)$:_ Die Irrtumswahrscheinlichkeit der Nullhypothese, also um wie viel Prozent die Messung
  abweichen darf, ohne dass sie verworfen wird. Häufig auch in der Form $1-alpha$ angegeben.
- _Kritischer Wert:_ Wird dieser Wert mit Wahrscheinlichkeit $alpha$ überschritten, ist die Nullhypothese widerlegt.
- _Annahmebereich:_ Befindet sich das Parametertest-Resultat innerhalb des Annahmebereichs, ist die Nullhypothese angenommen.
  Analog wird beim _Ablehnungsbereich_ die Nullhypothese verworfen. Krit. Wert ist die Grenze.

Das _Ziel eines Parametertests_ ist es, aufzuzeigen, ob die Messung den kritischen Wert über-/unterschreitet und damit
die Nullhypothese widerlegt. Tut sie das, hat das Experiment ein _signifikantes Ergebnis_.

Es kann viele Möglichkeiten für die Widerlegung der Nullhypothese geben. Scheitert ein Test, heisst das nicht,
dass die Nullhypothese wahr ist, sondern nur, dass sie noch nicht widerlegt wurde.

*Beispiel zur Aufstellung der Hypothesen*\
_Fragestellung_: Hilft das neue Medikament dem Patienten, schneller gesund zu werden?
- _Nullhypothese $H_0$:_ Es ist *kein* Unterschied in der Genesungszeit zwischen Medikament und Placebo feststellbar.
- _Alternativhypothese $H_1$:_ Es ist *ein* Unterschied in der Genesungszeit zwischen Medikament und Placebo feststellbar.

#pagebreak()

*Beispiel:*\
#example-block[
  _Die Zugstärke eines Rasenmäher-Modells hat einen Mittelwert von $1500 N$ und eine Standardabweichung von $50 N$.
  Man behauptet, mit einem neuen Verfahren die Zugstärke erhöhen zu können. Ein Test wird mit $60$ Rasenmähern durchgeführt und
  ergibt eine mittlere Zugstärke von $1550 N$._

  + Kann man an dieser Behauptung mit einer Irrtumswahrscheinlichkeit von $0.05$ festhalten?
    + Werte aus Text herausschreiben
    $ X = 1550, quad "Mittelwert" mu = 1500, quad "Standardabweichung" sigma = 50, quad n = 60, quad alpha = 0.05 $

    2. Hypothesen definieren:
      - $H_0$: Das neue Verfahren hat keine Veränderung der Zugstärke ergeben, $mu = 1500 N$
      - $H_1$: Es hat eine Verbesserung der Zugstärke gegeben, $mu > 1500 N$

    + $p$-Wert und kritischer $Z$-Wert ausrechnen:
    $ p = 1 - alpha = 0.95, quad z = "invNorm"(0.95,0,1) = 1.645 $

    3. Effektiver $Z$-Wert ausrechnen #hinweis[(Formel siehe @test-normal)]:
    $ Z = (X - mu)/(sigma \/ sqrt(n)) = (1550 - 1500) / (50\/sqrt(60)) = 7.74 $

    4. Effektiver $Z$-Wert mit $Z$-krit vergleichen. Ist $Z > Z$-krit: Nullhypothese verwerfen.\
      $7.74 > 1.645$, das heisst, die Null-Hypothese muss verworfen und die Alternativ-Hypothese angenommen werden.
]

== Differenztests für Mittelwerte von Normalverteilungen
Manchmal will man mithilfe von Stichproben untersuchen, ob zwei Mittelwerte $mu_1 = mu_2$ gleich sind oder signifikant
voneinander abweichen. z.B. ob ein angepasstes Modell im Durchschnitt besser ist als das reale System.
- _Abhängige Stichproben:_ Die Messwerte haben eine Beziehung zueinander
- _Unabhängige Stichproben:_ Die Messwerte haben keine Beziehung zueinander

*Beispiel:*\
Vergleich Lohn im Alter von $30$ Jahren vs. $50$ Jahren: Befragt man $30$- und $50$-jährige Personen, ist die
Stichprobe _unabhängig_. Befragt man $50$-jährige nach ihrem derzeitigen Lohn und ihrem Lohn als sie $30$ Jahre alt waren,
ist die Stichprobe _abhängig_.

#definition[
  #grid(
    align: horizon,
    [
      _Annahmebereich für unabhängige Stichproben_
      $ c = plus.minus z sqrt(sigma^2_1/n_1 + sigma^2_2/n_2) $
    ],
    [
      _*$Z$*:_ Aus Tabelle Normalverteilung \
      _*$sigma_1^2, sigma_2^2$*:_ Varianz der Stichproben 1 und 2\
      _*$n_1, n_2$*:_ Gesamt-Anzahlen der Stichproben 1 und 2 \
    ],
  )
]

=== Abhängige Stichproben
1. Bilden der Nullhypothese $H_0$: $mu_1 = mu_2$ #hinweis[(Trifft sie ein, müsste die Differenz gegen 0 gehen)]
2. Signifikanzzahl $alpha$ festlegen
3. Annahmegrenzen mithilfe Normalverteilungstabelle festlegen

=== Unabhängige Stichproben
Bei einer unabhängigen Stichprobe muss die Varianz für jede Probe einzeln geschätzt werden.
1. Bilden der Nullhypothese $H_0$: $mu_1 = mu_2$
2. $plus.minus Z$ mit Normalverteilungstabelle festlegen
3. Annahmebereich mit Formel oben berechnen
4. Mittelwerte der Stichproben $mu_1$ und $mu_2$ berechnen
5. Nullhypothese wird angenommen, wenn Differenz $d_i = mu_1 - mu_2$ in den Annahmebereich fällt

== Chi-Quadrat-Test
Mit _Verteilungstests_ können Hypothesen über die Wahrscheinlichkeitsverteilung einer Stichprobe überprüft werden.
Wir verwenden in unserem Fall den _Chi-Quadrat-Test_: Bei ihm werden die Häufigkeiten von empirisch ermittelten Verteilungen
#hinweis[(Messwerte)] mit der theoretischen Verteilung verglichen. Dabei werden die Differenzen der Häufigkeitswerte quadriert,
normiert und aufaddiert.

*Beispiel*:\
Test, ob ein Würfel eine Gleichverteilung produziert und damit fair ist.
Ein Würfel wurde 60-mal geworfen mit folgenden Häufigkeiten:
$
  h^e = {\u{2680} arrow.bar 7, space \u{2681} arrow.bar 8, space \u{2682} arrow.bar 13, space \u{2683} arrow.bar 8, space
         \u{2684} arrow.bar 9, space \u{2685} arrow.bar 15}
$

1. Werte aus Text herausschreiben
$ n = 6, quad p = 1/6, quad h^"th" = n dot p = 10, quad "Annahme:" alpha = 0.05 $

2. Hypothesen definieren \
  - $H_0$: Die Würfel produzieren eine Gleichverteilung, sind also fair
  - $H_1$: Die Würfel produzieren keine Gleichverteilung, sind also nicht fair

3. Differenz zwischen der empirischen $h^e$ und theoretischen $h^"th"$ Verteilung bilden\
$
  h^e - h^"th" = {\u{2680} arrow.bar 7 - 10 = -3, space \u{2681} arrow.bar -2, space \u{2682} arrow.bar 3, space
                  \u{2683} arrow.bar -2, space \u{2684} arrow.bar 1, space \u{2685} arrow.bar 5}
$

4. Normieren, um negative Werte zu entfernen\
$
  (h^e_i - h^"th"_i)^2/h^"th"_i space => space {1 arrow.bar (7-10)^2/10 = 0.9, 2 arrow.bar (8-10)^2/10 = 0.4,
    3 arrow.bar 0.9, 4 arrow.bar 0.4, 5 arrow.bar 0.1, 6 arrow.bar 2.5}
$

5. Summe der normierten Werte bilden, um $D$ zu erhalten
$ D = 0.9 + 0.4 + 0.9 + 0.4 + 0.1 + 2.5 = underline(5.2) $

6. $D_"krit"$ aus $chi^2$-Tabelle ablesen oder von TR und mit $D$ vergleichen. Ist $D > D_"krit"$: Nullhypothese verwerfen.\
  $5.2 < 11.0705$, das heisst, die Null-Hypothese kann nicht verworfen werden.
