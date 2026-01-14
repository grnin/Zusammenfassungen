// Compiled with Typst 0.14.2
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "WrStat",
  fach-long: "Wahrscheinlichkeit und Statistik",
  semester: "HS24",
  tableofcontents: (enabled: true, depth: 3, columns: 2),
  appendix: (
    "WrStat/LinRegTabelle.typ",
    "WrStat/t-Test.typ",
    "WrStat/ChiQuadTabelle.typ",
    "WrStat/SmirnoffTest.typ",
    "WrStat/Tabellen.typ",
  ),
)

// Global configuration
// Grid size defaults
#set grid(columns: (1fr, 1fr), gutter: 1em)

// Icon for the "Construct" button on the TI n-spire
#let tr-constructs-button = box(
  stroke: 0.75pt,
  inset: (x: 0.2em),
  outset: (y: 0.25em, bottom: 0.55em),
  radius: 0.25em,
  $script(abs(ballot) cases(ballot, ballot))$,
)

// Styling for example exercises
#let example-block(body) = {
  set enum(numbering: "a)")
  show emph: set text(fill: black, weight: "regular")
  body
}


= Hitchhiker's Guide to WrStat
#hinweis[*Hinweis:* In der Zusammenfassung werden Anweisungen zur Taschenrechnerbenutzung gegeben. Diese beziehen sich
  auf den TI nSpire CX II-T und das Skript auf #underline[https://github.com/KROIA/OST_WrStat].
  
  Das Skript kann entweder mithilfe der Software, die dem TR beilag, oder der Webseite
  #underline[https://nspireconnect.ti.com/nsc/] auf den TR kopiert werden. Die Webseite ist nur mit Chrome auf Mac oder
  Windows verwendbar, auf Linux muss der User Agent manuell angepasst werden.
  
  Wenn das Skript in den "MyLib"-Ordner abgelegt und im Scratchpad Menu-1-7-1 (Bibliotheken aktualisieren) ausgewählt
  wird, sind anschliessend alle Funktionen des Skripts direkt im Scratchpad mit der Buch-Taste $->$ 6 $->$ wrstat
  erreichbar.
]

Nachfolgend ist die Reihenfolge einer typischen WrStat-Prüfung von Andreas Müller:

#{
  // Disable these headings showing up in the table of contents
  show heading.where(level: 2): set heading(outlined: false)
  [
    == Aufgabe 1
    _ @kombinatorik _ Gegeben ist ein Fliesstext oder ein Bild.\
    #hinweis["Auf wie viele Arten..." / "Wie viele verschiedene Kombinationen"]

    == Aufgabe 2
    _ @linreg: _ Gegeben ist eine Tabelle mit zwei Spalten und/oder eine Grafik mit Punkten oder einer Linie.\
    #hinweis["Finden Sie ein Modell ...."]

    == Aufgabe 3
    _ @dichte: _ Gegeben ist eine Funktion und das Wort "Wahrscheinlichkeitsdichte" kommt vor.\
    #hinweis["Betrachten Sie die Funktion ..." / "Gegeben ist die Funktion ..."]

    == Aufgabe 4
    - _ @verteilung: _
      Gegeben ist meist ein längerer Text mit Prozentzahlen.\
      #hinweis["Wann ist ..." / "Zu welcher Zeit ..." / "Mit wie vielen ...", "Wie gross ist die Wahrscheinlichkeit ..."]
    - _ @test: _
      Gegeben ist eine Studie oder Untersuchung mit diversen Messdaten.\
      #hinweis["Kann man daraus schliessen ..." / "Kann damit eine Aussage über xy gemacht werden" / "Formulieren Sie einen Test ..."]

    == Aufgabe 5
    _ @test: _ Gegeben ist eine Studie oder Untersuchung mit diversen Messdaten.\
    #hinweis["Kann man daraus schliessen ..." / "Kann damit eine Aussage über xy gemacht werden" / "Formulieren Sie einen Test ..."]

    == Aufgabe 6
    _ @verteilung: _ Gegeben ist meist ein längerer Text mit Prozentzahlen.\
    #hinweis["Wann ist ..." / "Zu welcher Zeit ..." / "Mit wie vielen ...", "Wie gross ist die Wahrscheinlichkeit ..."]

    == Aufgabe 7 / 8
    - _ @verteilung: _
      Gegeben ist meist ein längerer Text mit Prozentzahlen\
      #hinweis["Wann ist ..." / "Zu welcher Zeit ..." / "Mit wie vielen ...", "Wie gross ist die Wahrscheinlichkeit ..."]
    - _ @test: _
      Gegeben ist eine Studie oder Untersuchung mit diversen Messdaten\
      #hinweis["Kann man daraus schliessen ..." / "Kann damit eine Aussage über xy gemacht werden" / "Formulieren Sie einen Test ..."]
    - _ @ereignisse: _
      Gegeben ist eine komplizierte Situation. Nur "Ja / Nein"-Resultate, keine Messwerte, Abhängigkeit.\
      #hinweis["Wie gross ist die Wahrscheinlichkeit, dass ..." / "Wie wahrscheinlich ist es, ..." / "Wie häufig ..."]
  ]
}

#pagebreak()

= Kombinatorik <kombinatorik>
#hinweis[
  Meist Aufgabe 1\
  *Punkteverteilung:* Punkte sind auf Teilaufgaben verteilt. Pro Erkennung von Problemtyp manchmal auch ein Punkt.
]

== Methodik
#definition[
  #v(0.5em)
  ==== Aufgabe
  Gegeben ist ein Fliesstext oder ein Bild.

  Die Frage ist meist "Auf wie viele Arten ..." / "Wie viele verschiedene Kombinationen ..."

  ==== Vorgehensweise
  + Aufgabe zuerst auslassen und am Schluss der Prüfung lösen, weil meist relativ kompliziert und zeitintensiv.
  + Versuchen, die Texte auf eines der untenstehenden Probleme herunterzubrechen
  + Entsprechende Regeln anwenden
]

== Produktregel: Die Für-jedes-gibt-es Regel
#definition[
  #grid(
    columns: (2fr, 1fr),
    [
      Für jede der $n$ Möglichkeiten gibt es eine von der ersten Position _unabhängige Anzahl_ $k$ Möglichkeiten
      für den Rest, also $n dot k$ Möglichkeiten.
    ],
    [
      $ n_1 dot n_2 dot ... dot n_k = product_(i=1)^k n_i $
    ],
  )
]

_Beispiele:_
#v(-0.5em)
#example-block[
  + _Wie viele mögliche Würfelkombinationen können entstehen, wenn $i$ verschiedene Würfel mit je $j$ Augen geworfen werden?_

    Da die Würfel voneinander unabhängig sind, gibt es $i dot j$ verschiedene Kombinationen.

  + _Ein Autohändler bietet 5 verschiedene Fahrzeugtypen in 30 verschiedenen Farben an. Zu jedem Fahrzeugtyp gibt es
    7 verschiedene Extraausstattungen. Wie viele verschiedene Fahrzeuge kann der Autohändler verkaufen?_

    Da die Fahrzeugtypen ($i$), die Farben ($j$) und die Extraausstattungen ($k$) voneinander unabhängig sind, gibt es\
    $i dot j dot k$ verschiedene Fahrzeuge, also $5 dot 30 dot 7 = underline(1050)$.
]


== Permutationen/Reihenfolge
_"Auf wie viele Arten lassen sich $n$ verschiedene Objekte anordnen?"_\
Für das erste Objekt stehen $n$ Plätze zur Verfügung. Für das zweite Objekt muss einer der $n-1$ verbleibenden Plätze
gewählt werden. Bisher sind nun $n dot (n-1)$ Möglichkeiten gefunden. Führt man diese Reihenfolge fort, ergeben
sich $n!$ Möglichkeiten.

#definition[
  $n$ Objekte kann man auf $n dot (n-1) dot (n-2) dot ... dot 1 = n!$ Arten anordnen.
  #hinweis[(Bei mehreren Gruppen: $n! dot m!$)]\
]

_Beispiele:_
#v(-0.5em)
#example-block[
  + _In wie vielen verschiedenen Reihenfolgen können 8 Läufer ins Ziel gelangen?_\
    $ 8! = underline(40'320) $

  + _Es treten 7 Frauen und 7 Männer an. Es gibt geschlechtergetrennte Ranglisten. Wie viele Kombinationen gibt es?_
    $ 7! dot 7! = 5040^2 = underline(254'001'600) $

  Eine Skiverleihfirma besitzt 6 Paare weisser und 7 Paare schwarzer Skis einer bestimmten Grösse. Die Skis sind
  asymmetrisch, man kann linke und rechte Skis unterscheiden. Nach dem Sommer werden die Skis aus dem Lagercontainer
  geholt, wo sie ziemlich durcheinandergeraten sind.

  + _Auf wie viele Arten können die Skis zu Paaren zusammengefügt werden?_
    $ n_"schwarz" ! dot n_"weiss" ! = 7! dot 6! = 5040 dot 720 = underline(3'628'800) $

  + _Der Marketingchef findet, es dürften durchaus auch gemischfarbige Paare vermietet werden, wie viele mögliche
    Paarungen gibt es in diesem Fall?_
    $ (n_"schwarz" + n_"weiss")! = (7 + 6)! = 13! = underline(6'227'020'800) $

  + _Bei der Revision stellt sich heraus, dass zwei schwarze linke Skis und eine linker weisser Ski nicht mehr zu reparieren
    sind. Wie viele mögliche Paarungen gibt es jetzt noch?_

    Hat man nur $n$ linke und $m$ rechte Skis einer gewissen Farbe, mit $n < m$, muss man zuerst aus den $m$ Skis davon
    $n$ auswählen, die man verwenden will. Das geht auf $binom(m, n)$ Arten. Davon kann man wieder $n!$ Anordnungen bilden.
    Die Gesamtzahl möglicher Paarungen ist also
    $ binom(m, n) dot n! = binom(7, 5) dot 5! = underline(1'814'400) $

    #hinweis[TR: Menü-5-3 / $"nCr"(m,n)$]
]


== Auswahlproblem
#v(-0.5em)
=== Kombination: Ziehen ohne Zurücklegen
_"Auf wie viele Arten kann man $k$ Objekte aus $n$ auswählen?"_\
Sei $C^n_k$ die Anzahl der Möglichkeiten, $k$ aus $n$ Objekten auszuwählen. Es ist zuerst $k$ mal eine Auswahl zu treffen.
Für die erste Auswahl stehen $n$ Objekte zur Verfügung. Danach muss noch $k - 1$ mal eine Auswahl getroffen werden,
es stehen noch $n-1$ Alternativen zur Verfügung. So lassen sich $n dot (n - 1) dot (n - 2)...(n - k + 1)$ Möglichkeiten finden.
Ist die Reihenfolge der Objekte nicht relevant, muss noch durch $k!$ geteilt werden.

#definition[
  $
    C^n_k = (n dot (n-1) dot (n-2) dot ... dot (n-k+1) dot (n-k) dot (n-k-1) dot ... dot 2 dot 1) / (k! dot (n-k)!)
    = n! / (k! dot (n-k)!)\
    arrow.double.r.l space C^n_k = C^(n-1)_(k-1) + C^(n-1)_k = binom(n, k)
  $
  #hinweis[TR: Menü-5-3 / $"nCr"(n, k)$]
]

_Beispiele:_
#v(-0.5em)
#example-block[
  + _In einem Wald mit 1'000 Bäumen schlägt fünfmal der Blitz ein. Wir dürfen annehmen, dass kein Baum zweimal getroffen wird.
    Auf wie viele Arten können die getroffenen Bäume im Wald verteilt sein?_

    Es müssen 5 von 1'000 Bäumen ausgewählt werden:
    $ binom(1000,5) = 1000! / (5!(1000-5)!) = underline(8'250'291'250'200) $

  + _In einem von $n = 6$ Koffern befindet sich eine Waffe. Es dürfen zwei Koffer geöffnet werden.
    Wie viele Möglichkeiten gibt es für Erfolg und wie viele für Misserfolg?_

    Es gibt $binom(6, 2) = 15$ Möglichkeiten, zwei Schachteln auszuwählen, aber nur $binom(5, 2) = 10$ Möglichkeiten,
    zwei Schachteln auszuwählen, die die Tatwaffe nicht enthalten. Es gibt also 5 Möglichkeiten für Erfolg und
    10 Möglichkeiten für Misserfolg.
]


=== Variation: Ziehen mit Zurücklegen
#hinweis[Perlenkettenproblem]\
_"Auf wie viele Arten kann man $k$ mal unter $n$ verschiedenen Objekten auswählen?"_\

#definition[Anzahl Möglichkeiten, $n$ verschiedene Objekte $k$ mal auszuwählen: $V_(n, k) = n^k$]

_Beispiel:_ Auf wie viele Arten kann man eine Perlenkette der Länge $k = 10$ aus $n = 4$ Farben von Perlen herstellen?

$ V_(4,10) = 4^10 = underline(1'048'576 "Möglichkeiten") $

#pagebreak()

#example-block[
  === Beispiel 1: Kartenspiel
  Ein Kartenspiel mit 52 Karten besteht aus 26 roten und 26 schwarzen Karten.
  + _Auf wie viele Arten kann man das Kartenspiel mischen?_

    Dies ist ein Anordnungsproblem, es gibt $52!$ solche Reihenfolgen.

  + _Auf wie viele Arten kann man das Kartenspiel mischen, so dass die oberste und die unterste Karte die gleiche Farbe haben?_

    Zunächst wählen wir eine von 52 Karten, dies wird die oberste Karte. Dann wählen wir eine Karte der gleichen Farbe,
    davon gibt es noch $25$, dies wird die unterste Karte. Die verbleibenden $50$ Karten können nun in jeder beliebiger
    Reihenfolge dazwischengelegt werden.
    $ 52 dot 25 dot 50! $

  + _Welcher Prozentsatz der möglichen Kartenstapel hat gleichfarbige oberste und unterste Karten?_

    Dies ist der Quotient
    $ (52 dot 25 dot 50!) / 52! = 0.490 = underline(49%) $

  + _Jetzt werden dem Spiel noch drei Joker-Karten hinzugefügt, die sowohl als rot als auch als schwarz betrachtet werden
    können. Auf wie viele Arten kann man das erweiterte Kartenspiel mischen, sodass die oberste und unterste Karte die gleiche
    Farbe haben?_

    Die oberste Karte könnte nun eine Farbkarte #hinweis[(Schwarz oder Rot)] oder eine Jokerkarte sein.

    *Fall 1, Jokerkarte:* Es gibt $3$ mögliche Jokerkarten für die erste Karte, dann passt jede beliebige Karte als unterste
    Karte, davon gibt es $54$. Die verbleibenden Karten können beliebig angeordnet werden.
    $ 3 dot 54 dot 53! $

    *Fall 2, Farbkarte:* Gleich wie Aufgabe b), einfach andere Zahlen
    $ 52 dot 28 dot 53! $

    Die beiden Fälle sind disjunkt, können also addiert werden.
    $ 3 dot 54 dot 53! + 52 dot 28 dot 53! $

  === Beispiel 2: Wortanordnungen
  #hinweis[Hinweis: Das deutsche Alphabet hat 5 Vokale und 21 Konsonanten.]

  + _Wie viele Wörter der Länge 9 gibt es, die genau 4 benachbarte und zwei einzelne Vokale enthalten?_

    Die Vokalgruppen lassen sich auf 12 Arten anordnen #hinweis[(aufzeichnen und zählen)]. Die insgesamt $6$ Vokalplätze
    lassen sich auf $5^6$ Arten belegen, die $3$ Konsonantenplätze auf $26^3$ Arten. Die Gesamtzahl der Wörter wird daher
    $ 12 dot 5^6 dot 21^3 = underline(1'736'437'500) $

  + _Wie viele Wörter der Länge 9 gibt es, die genau 6 benachbarte Vokale enthalten?_

    Die Vokalgruppe lässt sich auf $4$ verschiedene Arten platzieren. Da es immer noch $6$ Vokalplätze und
    $3$ Konsonantenplätze gibt, ist die Gesamtzahl der Wörter daher
    $ 4 dot 5^6 dot 21^3 = underline(578'812'500) $

  #pagebreak()

  === Beispiel 3: Zugwagen
  In einem Zugwagen gibt es $16$ Plätze, davon $8$ Fenster- und $8$ Gangplätze. Je die Hälfte ist in Fahrtrichtung gerichtet.
  Eine Gesellschaft von zwölf Personen will im Zug Platz nehmen.

  + _Auf wie viele Arten können die Reisenden die Plätze annehmen?_

    Es müssen $12$ der $16$ Plätze ausgewählt werden, das ist auf $binom(16,12)$ Arten möglich. Auf den $12$ ausgewählten
    Plätzen können die Fahrgäste auf $12!$ Arten angeordnet werden. Deshalb gilt
    $ binom(16, 12) dot 12! = "nCr"(16,12) dot 12! = underline(871'782'912'000) $

  + _Vier der Personen möchten unbedingt einen Fensterplatz haben. Auf wie viele Arten können die Reisenden nun Platz nehmen?_

    $4$ der $8$ Fensterplätze können auf $binom(8, 4)$ Arten ausgewählt werden und die Fensterplatzfahrer in $4!$ möglichen
    Arten platziert werden. Dann werden $8$ von $12$ Plätzen für die verbleibenden Gäste gewählt und auf $8!$ Arten angeordnet.
    So ergeben sich
    $
      binom(8, 4) dot 4! dot binom(12, 8) dot 8! = "nCr"(8,4) dot 4! dot "nCr"(12,8) dot 8! = underline(33'530'112'000)
    $

  + _Einer Person wird übel, wenn sie nicht in Fahrtrichtung schauen kann, und benötigt einen Fensterplatz.
    Wie viele Arten gibt es nun?_

    Die Person nimmt einen von $4$ Fensterplätzen in Fahrtrichtung ein. Die anderen $4$ Gäste werden auf die $7$ verbleibenden
    Fensterplätze platziert und anschliessen werden $7$ von den verbleibenden $11$ Plätzen gewählt.
    $
      4 dot binom(7, 4) dot 4! dot binom(11, 7) dot 7! = 4 dot "nCr"(7, 4) dot 4! dot "nCr"(11,7) dot 7! = underline(5'588'352'000)
    $
]

#pagebreak()

= Lineare Regression <linreg>
#hinweis[
  Meist Aufgabe 2\
  *Punkteverteilung:* Methode der linearen Regression (1), Wert von $a$ (1), Wert von $b$ (1), Wert von $r$ (1),
  Beurteilung der linearen Regression (1)
]

== Methodik
#definition[
  #v(0.5em)
  ==== Aufgabe
  Gegeben ist eine Tabelle mit zwei Spalten und/oder eine Grafik mit Punkten oder einer Linie.

  Die Frage ist meist "Finden Sie ein Modell ...."

  ==== Vorgehensweise
  + Beiblatt _"Lineare Regression"_ verwenden
  + TR-Skript _"linreg"_ verwenden: $ "linreg"mat(
      x_1, y_1;
      x_2, y_2;
      dots.v, dots.v;
      x_n, y_n;
  ) $
  #hinweis[2.15214E6 = 2'152'140. $arrow$ Punkt um 6 Stellen nach rechts schieben]
  + Auf die Prüfung schreiben, dass die Lineare Regression auf dem Beiblatt steht
  + Formel $y(x) = a dot x + b$ mit $a$ und $b$ von linearer Regression verwenden, um Aufgabe zu lösen
]

== Definition
Seien $X$ und $Y$ zwei reelle Zufallsvariablen. Der _lineare Zusammenhang_ zwischen diesen zwei Messwerten kann
mit der Gleichung _*$Y = a dot X + b + "Fehler"$*_ dargestellt werden.\
$a$ und $b$ müssen so gewählt werden, dass der Fehler minimal ist: _*$"var"(Y - a dot X - b)$* soll minimal werden._\
Dies gilt dann, wenn:

$ a = (E(X dot Y) - E(X) dot E(Y)) / (E(X^2) - E(X)^2) = "cov"(X, Y) / "var"(x) $
$ b = E(Y) - a dot E(X) $

== Beispiele
#example-block[
  1. Wie viele $y$ werden innerhalb vom Zeitraum $x = 10 "Tage"$ verwendet?
  $ y(x) = a dot 10 + b $

  2. An welchem Zeitpunkt $x$ ist $y = 100$?
  $ 100 = a dot x + b quad arrow.double quad (100 - b) / a = x $
]

== Regressionskoeffizient
Für die _Fehlerbeurteilung_ wird der Regressionskoeffizient verwendet. Die Regression ist umso _genauer_, je näher der
Koeffizient _*$r$* bei *$plus.minus 1$*_ liegt. $r$ hat immer das gleiche Vorzeichen wie die Steigung der Regressionsgerade\ #hinweis[(fallend = minus)].

$ r = "cov"(X, Y) / sqrt("var"(X) dot "var"(Y)) $

- _*$r = 0$*:_ kein linearer Zusammenhang zwischen $X$ und $Y$
- _*$r approx plus.minus 1$*:_ kein Fehler bei der Approximation, strikter linearer Zusammenhang \
  #hinweis[($+1$: positiver/steigender linearer Zusammenhang, $-1$: negativer/fallender Zusammenhang)]



= Erwartungswert und Varianz, Wahrscheinlichkeitsdichte <dichte>
#hinweis[
  Meist Aufgabe 3\
  *Punkteverteilung:* Normierungsbedingung / Formel auf 1 setzen (1), Bestimmen der Variable in der Verteilungsfunktion
  $phi(x)$ (1), Erwartungswert aufschreiben (1), Erwartungswert berechnen (1), Varianzformel aufschreiben (1),
  Varianz berechnen (1)
]

== Methodik
#definition[
  #v(0.5em)
  ==== Aufgabe
  Gegeben ist eine Funktion und das Wort "Wahrscheinlichkeitsdichte" kommt vor.

  Die Frage ist oft: "Betrachten Sie die Funktion ..." / "Gegeben ist die Funktion ..."

  ==== Vorgehensweise
  + Zuerst muss überprüft werden, ob es sich wirklich um eine Wahrscheinlichkeitsdichte handelt.\
    Dafür muss die Variable #hinweis[(oft $a$)] so gewählt werden, dass das Integral von $phi$ den Wert 1 hat.
  + Integral mit TR ausrechnen
  + Erwartungswert ausrechnen #hinweis[Falls Funktion $y$-Achsensymmetrisch, ist $E(X) =$ Mittelpunkt der Funktion]
  + Varianzformel $"var"(X) = E(X^2) - E(X)^2$ hinschreiben, ausrechnen

  #hinweis[
    *TR-Tipps:*
    - Integral: #tr-constructs-button -Taste (Betrag und Cases-Icon) drücken, Integral-Symbol auswählen
    - Solve-Funktion: Menu-3-1
    - Wenn Solve beim Lösen eines Integrals ein Integral zurück gibt, auszurechnende Variabel aus dem Integral herausnehmen
    - Zahlen in Brüche umwandeln: Menu-Zahl-Brüche approximieren
  ]
]

#pagebreak()

#example-block[
  === Beispiel 1: Symmetrische Funktion
  ==== Aufgabenstellung
  Die Funktion
  $
    phi(x) = cases(
      0                     &x <= -1,
      a sqrt(x+1) quad quad &-1 < x <= 0,
      a sqrt(1-x)           &0 < x <= 1,
      0                     &x > 1
    )
  $

  soll als Wahrscheinlichkeitsdichte einer Zufallsvariable $X$ verwendet werden.

  #align(center, image("img/wrstat_06.png", width: 60%))

  + _Wie muss $alpha$ gewählt werden, damit $phi$ wirklich eine Wahrscheinlichkeitsdichte ist?_
  + _Bestimmen Sie den Erwartungswert $E(X)$_
  + _Bestimmen Sie die Varianz $"var"(X)$_

  ==== Lösung
  + Es muss gelten: #hinweis[(Integralgrenzen aus der Wahrscheinlichkeitsfunktion übernehmen)]

    $
      1 = integral_(-infinity)^infinity phi(x) space dif x
      = integral^0_(-1) a sqrt(x+1) space dif x + integral^1_0 a sqrt(1 - x ) space dif x
    $

    Formel mit dem Taschenrechner mit der Funktion $"solve"()$ lösen:

    $
      "solve"(1 = integral^0_(-1) a sqrt(x+1) space dif x + integral^1_0 a sqrt(1 - x ) space dif x, space a)
      arrow.double a = 3 / 4
    $

  + Da die Funktion $phi(x)$ symmetrisch bzw. gerade ist, ist $E(X) = 0.$\
    #hinweis[(Ist die Funktion gerade, aber nicht um 0, ist $E(X) =$ Mittelpunkt)]

  + Für die Varianz brauchen wir $E(X^2)$:

    $
      E(X^2) = integral^infinity_(-infinity) x^2 phi(x) space dif x
      = 2a integral^1_0 x^2 sqrt(1-x) space dif x
    $

    Wieder mit TR lösen ($e = $ Variable für $E(X^2)$):

    $
      "solve"(e = 2 dot overbracket(3/4, a) integral^1_(0) x^2 sqrt(1-x) space dif x, e)
      arrow.double e = 8 / 35 arrow.double E(X^2) = 8 / 35
    $

    Varianz berechnen:\
    $ "var"(X) = E(X^2) - E(X)^2 = E(X^2) - 0^2 = E(X^2) = 8 / 35 approx 0.22857 $

  #pagebreak()

  === Beispiel 2: Symmetrische Funktion, konstant
  ==== Aufgabenstellung
  Man betrachte die Funktion
  $
    phi(x) = cases(
      a quad quad &-3/2 <= x <= -1/2 "oder" 1/2 <= x <= 3/2,
      0           &"sonst"
    )
  $

  + _Wie muss $a$ gewählt werden, damit $phi(x)$ die Wahrscheinlichkeitsdichte einer Zufallsvariable $X$ wird?_
  + _Zeichnen Sie einen Graphen der Verteilungsfunktion $F_X (x)$._
  + _Bestimmen Sie $E(X)$._
  + _Bestimmen Sie die Varianz $"var"(X)$._

  ==== Lösung
  + Das Integral von $phi(x)$ muss $1$ werden.
    $
      1 = integral^infinity_(-infinity) phi(x) space dif x = integral^(-1 / 2)_(-3 / 2) a space dif x
      + integral^(3 / 2)_(1 / 2) a space dif x overbracket(arrow.double, "TR solve") a = 1 / 2
    $

  + $F_X$ ist konstant in den Teilen des Definitionsbereiches, wo $phi(x) = 0$ ist. Ausserhalb dieses Bereichs hat der Graph
    die Steigung $a = 1/2$. Der Graph von $F_X(x)$ sieht also wie folgt aus:

    #align(center, image("img/wrstat_07.png", width: 50%))

  + Da $phi(x)$ eine gerade Funktion ist, ist $E(X) = 0$.

  + Die Varianz kann mit Hilfe von $E(X^2)$ berechnet werden.
    $
      E(X^2) &= integral^infinity_(-infinity) x^2 phi(x) space dif x\
      &= integral^(-1 / 2)_(-3 / 2) a x^2 space dif x + integral^(3 / 2)_(1 / 2) a x^2 space dif x\
      &= integral^(-1 / 2)_(-3 / 2) 1 / 2 x^2 space dif x + integral^(3 / 2)_(1 / 2) 1 / 2 x^2 space dif x
      overbracket(arrow.double, "TR solve") E(X^2) = 13 / 12
    $

    Varianz berechnen:\
    $ "var"(X) = E(X^2) - E(X)^2 = E(X^2) - 0^2 = E(X^2) = 13 / 12 approx 1.08333 $

  #pagebreak()

  #grid(
    columns: (3fr, 1fr),
    [
      === Beispiel 3: Asymmetrische Funktion, Median
      ==== Aufgabenstellung

      Die Funktion
      $
        phi(x) = cases(
          0                      &x <= 0,
          a(x^2 - x^4) quad quad &0 < x <= 1,
          0                      &1 < x
        )
      $
      soll als Wahrscheinlichkeitsdichte einer Zufallsvariable $X$ verwendet werden.

    ],
    [
      #image("img/wrstat_09.png")
    ],
  )

  + _Wie muss $a$ gewählt werden, damit $phi(x)$ tatsächlich eine Wahrscheinlichkeitsdichte sein kann?_
  + _Bestimmen Sie den Erwartungswert von $X$._
  + _Bestimmen Sie die Verteilungsfunktion $F_X (x)$._
  + _Bestimmen Sie die Varianz von $X$._
  + _Bestimmen Sie den Median von $X$._

  ==== Lösung
  + $a$ muss so gewählt werden, dass das Integral von $phi$ über $RR$ den Wert $1$ haben muss.
    Man berechnet daher:
    $
      1 = integral^infinity_(-infinity) phi(x) space dif x = integral^1_0 a(x^2 - x^4) space dif x
      = a integral^1_0 (x^2 - x^4) space dif x overbracket(arrow.double, "TR solve") a = 15 / 2
    $

  + Der Erwartungswert ist das Integral von $x dot phi(x)$:
    $
      E(X) &= integral^infinity_(-infinity) x dot phi(x) space dif x = integral^1_0 x dot a(x^2 - x^4) space dif x
      overbracket(=, "TR solve") 5 / 8
    $

  + Die Verteilungsfunktion ist für $x$-Werte zwischen 0 und 1:
    $
      F_X (x) = integral^x_(-infinity) phi(xi) space dif xi = integral^x_0 a(x^2 - x^4) space dif x
      overbracket(=, "TR") (-x^3 dot (3x^2 - 5)) / 2
    $

    Die Verteilungsfunktion ist damit
    $
      F_X (x) = cases(
        0                                           &x <= 0,
        display((-x^3 dot (3 x^2 - 5))/2) quad quad &0 < x <= 1,
        1                                           &x > 1,
      )
    $

  + Für die Varianz brauchen wir zunächst $E(X^2)$:
    $
      E(X^2) = integral^infinity_(-infinity) x^2 dot phi(x) space dif x = integral^1_0 x^2 dot a(x^2 - x^4) space dif x
      overbracket(=, "TR solve") 3 / 7
    $

    Daraus kann nun die Varianz berechnet werden:
    $
      "var"(X) = E(X^2) - E(X)^2 = 3 / 7 - (5 / 8)^2 overbracket(=, "TR") 17 / 448 approx 0.037946
    $

  + Der Median $x_"med"$ ist derjenige Wert, für den $F_X (x_"med") = 1/2$. Es gilt also
    $
      (-x^3_"med" dot (3 x^2_"med" - 5)) / 2 = 1 / 2 overbracket(arrow.double, "TR solve") x_"med" = -1.343209 "oder" 0.643138
    $
    Da die Funktion nur zwischen $0$ und $1$ Werte annimmt, muss der erste $x_"med"$ Wert verworfen werden.\
    $x_"med"$ ist also $0.643138$.
]


== Theorie
=== Begriffe
- _Zufallsvariable:_ Eine Zufallsvariable $X$ ist eine Funktion $X: Omega arrow RR$, die einem Versuchsausgang $omega$
  einen Wert $X(omega)$ zuordnet. #hinweis[(Die Zufälligkeit liegt in dem Versuch, der das $omega$ ermittelt)]
  - _Diskrete Zufallsvariable:_ Nimmt nur einzelne, genau bestimmte Zahlenwerte an #hinweis[(z.B. Würfelzahlen)]
  - _Stetige Zufallsvariable:_ Nimmt einen beliebigen Wert in einem Intervall an
    #hinweis[(Einzelwerte haben Wahrscheinlichkeit $0!$)]
- _Ereignisse:_ Die Zufallsvariable $X$ definiert neue Ereignisse

Eine Zufallsvariable kann wieder neue Ereignisse und Wahrscheinlichkeiten definieren. Bei stetigen Zufallsvariablen
ist ${X = a}$ nur beschränkt von Nutzen, da selten das exakt selbe Ereignis eintrifft
#hinweis[(z.B. nie die exakt selbe Messung durch Messfehler)].

#table(
  columns: (1fr, 1fr, auto),
  table.header([Ereignis/W'keit gleich $a$], [Ereignis/W'keit kleiner als $a$], [Ereignis/W'keit zwischen $a$ und $b$]),
  [$A = {X = a}, quad Rho({X = a})$],
  [$A = {X <= a}, quad Rho({X <= a})$],
  [$A = {a < X <= b}, quad Rho({a < X <= b})$],
)

#grid(
  columns: (2fr, 1fr),
  [
    === Wahrscheinlichkeitsdichte $bold(phi(x))$
    Die Wahrscheinlichkeitsdichte $phi(x)$ von $F(x)$ ist die _Ableitung_ von $F(x)$ und sagt aus, wie gross die Wahrscheinlichkeit ist, dass ein Wert in einem Intervall ist. _Achtung:_ nur für stetige Zufallsvariablen.

    #definition[
      Die Ableitung der Verteilungsfunktion heisst _Wahrscheinlichkeitsdichte_.
      $ phi(x) = dif / (dif x) F(x) = F'(x) $

      $F(x)$ ist eine Stammfunktion.
      $ Rho(a < X <= b) = integral^b_a phi(x) dif x $
    ]
  ],
  image("img/wrstat_08.png"),
)

#v(-0.5em)
=== Erwartungswert
#definition[
  Ist $X$ eine Zufallsvariable, dann ist der Erwartungswert\
  $
    E(X) = sum "Wert" dot "Wahrscheinlichkeit" = sum_(omega in Omega) X(omega) dot Rho({omega})
    = display(sum^k_(i=1) X(A_i) dot P(A_i))
  $
  wobei $X$ konstant auf $A_i$ und $A_i = Omega$ sein muss.
]

Wenn die Wahrscheinlichkeit in allen Fällen _gleich_ ist #hinweis[(Laplace-Experiment)], entspricht der Erwartungswert dem
_Durchschnitt_, dieser muss kein annehmbarer Wert der Zufallsvariable sein.

Der _empirische Erwartungswert_ entspricht dem gewichteten Mittelwert #hinweis[(arithmetisches Mittel)].
$ E(X) = sum_i X(i) dot Rho(X = x_i) $

#v(-0.5em)
==== Beispiel Würfelspiel
#table(
  columns: (auto,) + (1fr,) * 6,
  table.header([Augenzahl], [1], [2], [3], [4], [5], [6]),

  [_Gewinn_],
  [$0$], [$0$], [$fxcolor("grün", 5)$], [$fxcolor("rot", 1)$], [$fxcolor("gelb", 2)$], [$fxcolor("orange", 2)$],

  [_Wahrscheinlichkeit_],
  [$1\/6$], [$1\/6$], [$1\/6$], [$1\/6$], [$1\/6$], [$1\/6$]
)

$
  E(X) = sum "Wert" dot "Wahrscheinlichkeit" = 0 dot 1 / 6 + 0 dot 1 / 6 + fxcolor("grün", 5) dot 1 / 6 + fxcolor("rot", 1)
  dot 1 / 6 + fxcolor("gelb", 2) dot 1 / 6 + fxcolor("orange", 2) dot 1 / 6 = 10 / 6 = 5 / 3 = underline(1.666)
$

==== Rechenregeln
Sind $X, Y$ Zufallsvariablen, dann gilt:
- _Multiplikation_ mit einem Faktor: $E(lambda dot X) = lambda dot E(X)$ #hinweis[(z.B. Gewinn verdoppeln)]
- _Addition_ zweier Zufallswerte: $E(X + Y) = E(X) + E(Y)$
- _Produkt_ zweier Zufallswerte: $E(X dot Y) = E(X) dot E(Y)$, nur falls $X$ und $Y$ _unabhängig_ sind.\
  #hinweis[(Unabhängig = keine gegenseitige Beeinflussung)]
- _Potenzieren:_ $E(X^2) != E(X)^2$ #hinweis[($E(X)$ und $E(X)$ sind nie unabhängig)]
- Erwartungswert einer _Konstante_ $c$: $E(c) = c$

==== Verbindung zu Wahrscheinlichkeit
Ist $A subset Omega$ ein Ereignis, dann ist die _charakteristische Funktion_ von $A$ eine Zufallsvariable:
$
  chi_A: Omega arrow RR: omega arrow chi_A (omega) = cases(
    1 quad omega in A,
    0 quad omega in.not A
  )
$

Ihr Erwartungswert ist:
$E(chi_A) = chi_A (A) dot Rho(A) + chi_A (dash(A)) dot Rho(dash(A)) = 1 dot Rho(A) + 0 dot (1 - Rho(A)) = Rho(A)$

_Oder anders ausgedrückt:_ Gibt es nur die Ereignisse "Trifft ein"/"Trifft nicht ein", ist der Erwartungswert gleich der
Wahrscheinlichkeit des Eintreffen des Ereignis.

=== Varianz (Streumass)
#definition[
  Die _Varianz_ ist die mittlere quadratische Abweichung vom Erwartungswert bzw. die _Streuung_ einer Zufallsvariable.
  Je grösser die Varianz, desto grösser ist die Wahrscheinlichkeit für eine grosse Abweichung vom Erwartungswert.
  $ "var"(X) = E(X^2) - E(X)^2 $
]
Die Varianz ist aufgrund der Quadrierung in einer _anderen Einheit als die Messwerte_ und kann darum häufig nicht für konkrete Aussagen verwendet werden #hinweis[(z.B. $"Jahre"^2$)]. Möchte man die Varianz in z.B. einem Histogramm zusammen mit den Messungen visualisieren, sollte _*$sqrt("var"(X))$*_ verwendet werden

==== Beispiel Kopf (1) oder Zahl (0)
Faire Münze: $Rho(X = 0) = Rho(X=1) = 0.5, quad E(X) = 0.5, quad X^2 = X$:

$display(
  "var"(x) &= 1/2 dot (0 - E(X))^2 + 1/2 dot (1 - E(X))^2 = 1/2 dot (-1/2)^2 + 1/2 dot (1/2)^2
  = 1/2 dot 1/4 + 1/2 dot 1/4 = 1/4 \
  &= E(X^2) - E(X)^2 = 1/2 - (1/2)^2 = 1/2 - 1/4 = 1/4
)$

#grid(
  [
    ==== Beispiel Würfel
    #hinweis[
      #table(
        columns: (auto,) * 6,
        align: right,
        table.header([*$omega$*], [*$Rho(omega)$*], [*$X$*], [*$X^2$*], [*$X - E(X)$*], [*$(X - E(X))^2$*]),

        [$\u{2680}$], [$1\/6$], [$1$], [$1$], [$-2.5$], [$6.25$],
        [$\u{2681}$], [$1\/6$], [$2$], [$4$], [$-1.5$], [$2.25$],
        [$\u{2682}$], [$1\/6$], [$3$], [$9$], [$-0.5$], [$0.25$],
        [$\u{2683}$], [$1\/6$], [$4$], [$16$], [$0.5$], [$0.25$],
        [$\u{2684}$], [$1\/6$], [$5$], [$25$], [$1.5$], [$2.25$],
        [$\u{2685}$], [$1\/6$], [$6$], [$36$], [$2.5$], [$6.25$],
        table.hline(stroke: 1.5pt + black),
        [], [], [$ E(X) = \ 21\/6 $], [$ E(X^2) = \ 91\/6 $], [], [$ "var"(X) = 35\/12 $],
      )
    ]
  ],
  image("img/wrstat_10.png"),
)

$ "var"(X) = E(X^2) - E(X)^2 = 91 / 6 - 21^2 / 6^2 = (91 dot 6 - 21^2) / 6^2 = 105 / 6^2 = 35 / 12 approx 2.9166 $

#pagebreak()

==== Rechenregeln
Sind $X, Y$ _unabhängige_ Zufallsvariablen, dann gilt:
- _Multiplikation_ mit einem Faktor: $"var"(lambda dot X) = lambda^2 dot "var"(X)$
- _Addition_ zweier unabhängiger Zufallswerte: $"var"(X + Y) = "var"(X) + "var"(Y)$
- _Subtraktion_ zweier unabhängiger Zufallswerte: $"var"(X - Y) = "var"(X) + "var"(-Y) = "var"(X) + "var"(Y)$
- _Produkt_ zweier Zufallswerte: $"var"(X dot Y) = "var"(X) dot "var"(Y) + "var"(Y)E(X)^2 + "var"(X)E(Y)^2$
- Varianz einer _Konstante_ $c$: $"var"(c) = 0$


=== Korrelation und Kovarianz
#definition[
  Zwei Zufallsvariablen $X, Y$ sind _unkorreliert_, wenn der Erwartungswert des Produktes $E(X dot Y)$ dasselbe ist
  wie das Produkt des Erwartungswertes $E(X) dot E(Y)$
  $ E(X dot Y) = E(X) dot E(Y) => "unkorreliert" $

  Die _Kovarianz_ misst die Stärke des Zusammenhangs zwischen zwei Zufallsvariablen.
  $ "cov"(X, Y) = E(X dot Y) - E(X) dot E(Y) $
]
Bei einer grossen _positiven Kovarianz_ ist ein starker positiver/gleichläufiger Zusammenhang vorhanden
#hinweis[(wird $X$ grösser, wird $Y$ auch grösser)], bei grosser _negativen Kovarianz_ ein starker negativer/gegenläufiger
Zusammenhang #hinweis[(wird $X$ grösser, wird $Y$ kleiner)]. Ist das _Resultat nahe 0_, besteht kein linearer Zusammenhang.

Unabhängige Zufallsvariablen sind immer auch unkorreliert. Das umgekehrte muss aber nicht zwangsläufig korrekt sein.

=== Genauigkeit des Mittelwerts
#definition[
  *Tschebyscheff-Ungleichung*\
  Wahrscheinlichkeit, dass eine Zufallsvariable $X$ um mehr als $epsilon$ vom Erwartungswert $E(X)$ abweicht:
  $ Rho(|X - mu| > epsilon) <= ("var"(X)) / epsilon^2 $
]

#definition[
  *Satz von Bernoulli*\
  Je mehr Messungen, desto unwahrscheinlicher ist eine grosse Abweichung des Mittelwertes $M_n$ vom Erwartungswert $mu$.
  Für eine Verbesserung um 1 Stelle muss $n$ 100-mal grösser werden.
  $ Rho(|M_n - mu| > epsilon) <= ("var"(X)) / (n dot epsilon^2) $
]

#definition[
  *Gesetz der grossen Zahlen*\
  Je grösser die Anzahl Durchführungen, desto kleiner die Wahrscheinlichkeit, dass die relative Häufigkeit $h_n$ stark
  von der Wahrscheinlichkeit des Ereignisses $A$ abweicht.
  $ Rho(|h_n - Rho(A)| > epsilon) <= (Rho(A) dot (1 - Rho(A))) / (n dot epsilon^2) <= 1 / (4 dot n dot epsilon^2) $
]

#pagebreak()

= Wahrscheinlichkeitsverteilung <verteilung>
#hinweis[
  Meist Aufgaben 4, 6 und 7 - kann also in bis zu 3 Aufgaben vorkommen. Normalverteilung fast immer,
  Binomial & Poisson sind sehr häufig\
  *Punkteverteilung:* Korrekter Verteilung verwendet (1), Standardisierung (1), Werte korrekt aus Tabelle ablesen (1),
  Korrekte Gleichung für $mu$ / $sigma$ (1), $mu$ und $sigma$ korrekt berechnet
]

== Methodik
#definition[
  #v(0.5em)
  ==== Aufgabe
  Gegeben ist meist ein längerer Text mit Prozentzahlen

  Die erste Frage ist meist "Wann ist ..." / "Zu welcher Zeit ..." / "Mit wie vielen ..." und die zweite
  "Wie gross ist die Wahrscheinlichkeit ..."

  ==== Vorgehensweise
  + Erkennen, welche Verteilung verwendet werden sollte
    - _Exponentialverteilung:_ Etwas geht kaputt, Radioaktiver Zerfall, Warteschlangen
    - _Normalverteilung:_ Messungen weichen von einem Mittelwert ab
    - _Binomialverteilung:_ Ereignis tritt ein oder nicht, Person ist X $=>$ ja/nein
    - _Poissonverteilung:_ In der Aufgabenstellung steht das Wort "selten"
  + Ähnlichstes Beispiel verwenden, Formeln entsprechend aufschreiben und ausrechnen
]

Ein _Zufallsprozess_ erzeugt _Zufallsvariablen_ mit einer gewissen Verteilung, die den _Zufallsprozess_ modellieren.
Es gibt verschiedene Verteilungen, man muss _klären_, nach welcher Verteilung die Werte verteilt sind.

== Zentraler Grenzwertsatz
#definition[
  Der _zentrale Grenzwertsatz_ besagt, dass sich der Mittelwert und die Summe unabhängig und identisch verteilter
  Zufallsvariablen bei einer beliebigen Verteilung mit zunehmenden Stichprobenumfang der Normalverteilung annähern.\
  Oder anders gesagt: Viele kleine unabhängige Zufallseffekte summieren sich ungefähr zu einer Normalverteilung.
  Dadurch sind z.B. Mittelwerte von Stichproben normalverteilt.

  $ S_N = (X_1 + ... + X_n) / sqrt(n) quad => quad lim_(n -> infinity) e^(t^2\/2) "(Standardnormalverteilung)" $

  Ist also die Verteilung unbekannt, kann die Wahrscheinlichkeit approximativ mit der Normalverteilung berechnet werden.
]

#pagebreak()

== Exponentialverteilung
Wird verwendet für radioaktiver Zerfall oder Warteschlangen.\ *Anwendung:* gedächtnislose Prozesse.\
$T$ ist _gedächtnislos_, wenn die Wahrscheinlichkeit, dass das Ereignis in einem Intervall eintritt, immer gleich gross ist.
Die Vergangenheit hat _keinen Einfluss_ auf den Ausgang eines Experimentes.\
#hinweis[(Bedeutung von $a$: $1\/a =$ "Mean Time between Failure")]

#definition[
  Die Dichte- und Verteilungsfunktion der Exponentialverteilung sind:
  #grid(
    [
      $
        phi(x) = cases(
          a dot e^(-a dot x) quad &x >= 0,
          0                       &"sonst"
        )
      $
    ],
    [
      $
        F(x) = cases(
          0                 &"für" x < 0,
          1 - e^(-a x) quad &"für" x >= 0.
        )
      $
    ]
  )

  #table(
    columns: (1fr,) * 3,
    table.header([Erwartungswert], [Varianz], [Median]),
    [$ E(X) = 1 / a $], [$ "var"(X) = sigma = 1 / a^2 $], [ $ "Median" t_(1 / 2) = ln(2) / a $ ],
  )
]


=== Beispiel: Komponentenlebensdauer
#example-block[
  _Mittlere Lebensdauer einer Komponente ist eine Woche. Nach einem Jahr wird diese Komponente also etwa 52 mal ausgewechselt.
  Für Budgetzwecke wird angenommen, dass man mit 10 zusätzlichen Austauschaktionen pro Jahr durchkommt._

  _Verwenden Sie eine geeignete, einfache Approximation, um die Wahrscheinlichkeit zu berechnen, dass das Budget nicht reicht._

  Jede Komponente hat eine exponentialverteilte Lebensdauer $T_1, ... , T_n$ mit $a = 1$ (Woche).
  Gefragt ist die Wahrscheinlichkeit, dass die gesamte Lebensdauer der $n$ Komponenten kleiner ist als $52$.

  $
    X = T_1 + ... + T_n, quad "gesucht:" Rho(X < 52)
  $

  ==== Approximation mit Normalverteilung
  Eine Summe vieler kleiner Einflüsse kann mit der Normalverteilung approximiert werden. Damit gilt:
  $
    E(X) = mu = n dot E(T) = n dot 1["Woche"] = n, quad "var"(X) = sigma^2 = n dot "var"(T) = n dot 1["Woche"^2] = n,
    quad sigma = sqrt(n)
  $

  Standardisierung:
  $
    Rho(X < 52) = Rho(X <= 52) = Rho((X - mu)/sigma <= (52-mu)/sigma) = Rho(Z <= (52 - n)/sqrt(n))
  $

  $52 - n < 0$ ist nicht in Tabelle der Verteilungsfunktion, deshalb muss das Komplement abgelesen werden
  $
    Rho(Z <= (52 - n)/sqrt(n)) = 1 - Rho(Z <= (- 52 + n)/sqrt(n)) = 1 - Rho(Z <= (n - 52)/sqrt(n))
  $

  Für $n = 62$ gilt also:
  $
    1 - Rho(Z <= (62 - 52)/sqrt(62)) = 1 - Rho(Z <= 1.27) arrow.double 1 - overbracket("normCdf"(-infinity, 1.27, 0, 1),
    "Menu"-5-5-2) = 1 - 0.89796 = 0.102 arrow.double underline(10.2%)
  $
]

#pagebreak()

== Gleichverteilung
Jeder Wert innerhalb eines Intervalls ist gleich wahrscheinlich.\
*Anwendungen:* Verteilung von Zufallszahlen, keine bevorzugten Werte.

#definition[Die Dichte- und Verteilungsfunktion der Gleichverteilung sind:
  #grid(
    [
      $
        phi(x) = cases(
          0            &x < a,
          1/(b-a) quad &x in [a,b],
          0            &x > b
        )
      $
    ],
    [
      $
        F(x) = cases(
          0                &x < a,
          (x-a)/(b-a) quad &x in [a,b],
          1                &x > b
        )
      $
    ]
  )

  #table(
    columns: (1fr,) * 3,
    table.header([Erwartungswert], [Varianz], [Median]),
    [$ E(X) = (a + b) / 2 $], [$ "var"(X) = (b-a)^2 / 12 $], [$ "Median" = (a + b) / 2 $],
  )
]


=== Beispiel: Masse von Kartoffeln
#example-block[
  _Selektierte Kartoffeln haben eine Masse zwischen $80$ und $100g$. Diese werden im Intervall besser mit einer
  Gleichverteilung anstatt einer Normalverteilung beschrieben._

  1. _Wie gross ist die Varianz der Masse einer selektierten Kartoffel?_

    $ K = "Masse einer selektierten Kartoffel", quad a = 80g, quad b = 100g, quad E(K) = mu_0 = (80 + 100) / 2 = 90g $

    Die Varianz einer Gleichverteilung zwischen $a$ und $b$ ist

    $ sigma^2_0 = "var"(K) = (b - a)^2 / 12 = (100 - 80)^2 / 12 = 33.333g^2 $

  2. _Wie gross muss $n$ sein, damit man mit mindestens $10"kg"$ Kartoffeln rechnen kann?_\
    Die Masse $K_1, ..., K_n$ der $n$ Kartoffeln sind gleichverteilte Zufallsvariablen mit Erwartungswert $90g$, daher hat
    die Summe $X = K_1 + ... + K_n$ den Erwartungswert $E(X) = n dot mu_0$. Damit der Erwartungswert $10"kg"$ erreicht,
    muss $n >= 10"kg"\/mu_0$ sein:

    $
      E(X) = n dot mu_0, quad E(X) >= 10"kg" quad arrow.double quad n = E(X) / mu_0 = (10"kg") / (90g)
      = (10'000g) / (90g) = 111.11 quad arrow.double quad underline(n = 112)
    $

  3. _Die Masse der Kartoffeln kann aber immer noch streuen. Wie gross ist die Wahrscheinlichkeit, nicht die verlangten
    $10"kg"$ zu erhalten?_\
    Nach dem zentralen Grenzwertsatz ist $X$ annähernd normalverteilt mit Erwartungswert $mu = n dot mu_0$ und Varianz
    $sigma^2 = n dot sigma^2_0$. Die Wahrscheinlichkeit, dass $X < 10"kg"$ ist, kann jetzt mit Standardisierung berechnet werden
    $
      Rho(X < 10"kg") = Rho(X <= 10"kg") &= Rho((X - mu)/sigma <= (10"kg" - mu)/sigma)\
      &= Rho(Z <= (10"kg" - mu)/sigma) = Rho(Z <= (10"kg" - n dot mu_0)/(sqrt(n) dot sigma_0))
      = Phi((10"kg" - n dot mu_0)/(sqrt(n) dot sigma_0))
    $

    Da das Argument $Phi$ negativ ist, gehen wir zum Komplement über #hinweis[(Achtung: Dividend und Einheiten ändern sich!)]
    $
      = 1 - Phi((n dot mu_0 - 10"kg")/(sqrt(n) dot sigma_0)) = 1 - Phi((112 dot 90"g" - 10"kg")/(sqrt(112) dot 33.333"g"^2))
      = 1 - Phi((112 dot 90"g" - 10'000"g")/(sqrt(112) dot sqrt(33.333"g"))) = 1- Phi(1.3093)
    $

    Für $n = 112$ ergibt sich
    #v(-0.5em)
    $
      Rho(X < 10"kg") = 1 - Phi(1.3093) = 1 - overbracket("normCdf"(-infinity, 1.3093, 0, 1), "Menu"-5-5-2) = 1 - 0.9047
      = 0.0953 = underline(9.53%)
    $
]

#pagebreak()

== Normalverteilung
Modellierung vieler kleiner Einflüsse, Messwerte, wiederholte Experimente.\
*Anwendungen:* Messwerte, Summe vieler kleiner Einflüsse mit vergleichbar grosser Varianz, Approximation der Binomialverteilung.

#definition[
  #grid(
    row-gutter: 1em,
    align: horizon,
    [$ phi(x) = 1 / (sqrt(2pi) sigma) dot e^(-x^2 / (2 sigma^2)) $],
    [*$sigma$*: Standardabweichung],
  )

  #table(
    columns: (1fr,) * 3,
    table.header([Erwartungswert], [Varianz], [Median]),
    [$ E(X) = mu $],
    [$ "var"(X) = sigma^2 $],
    [$ "Median" = mu $]
  )
]

=== Typische Werte der Normalverteilung
$
  plus.minus 1 sigma arrow.double 68%, quad
  plus.minus 2 sigma arrow.double 95%, quad
  plus.minus 3 sigma arrow.double 99.7%
$


=== Standardnormalverteilung
#definition[
  #grid(
    align: horizon,
    [
      $
        Z = (X - mu) / sigma quad => quad Phi(Z) "(aus Verteilungs-Tabelle)"\
        Phi(Z) = cases(
          Phi(Z)                & Z >= 0,
          1 - Phi(abs(Z)) quad & Z < 0
        )
      $
    ],
    [
      *$Z$:* standardnormalverteilte Zufallsvariable\
      *$X$:* nicht-standardisierte normalverteilte Zufallsvar.\
      *$mu, sigma^2$:* Params der nicht-standardisierten Normalvert.
      *$Phi$:* Verteilungsfunktion, Wert aus Tabelle ablesen
    ]
  )

  #table(
    columns: (1fr,) * 2,
    table.header([Erwartungswert], [Varianz]),
    [$ E(Z) = 0 $],
    [$ "var"(Z) = 1 $],
  )

  #hinweis[
    TR Tabellenwert der Standardnormalverteilung lesen:\
    $Phi(x)$ wenn $x$ bekannt: Menu-5-5-3 / $"invNorm"(x,0,1), x = "Fläche"$\
    $Phi(x)$ wenn $a$ und $b$ gegeben: Menu-5-5-2 / $"normCdf"(a,b, mu, sigma)$
  ]
]

==== Beispiel
$
  Rho(fxcolor("grün", a) < X <= fxcolor("orange", b))
  &= Rho((fxcolor("grün", a) - mu)/sigma < (X - mu)/sigma <= (fxcolor("orange", b) - mu)/sigma)\
  &= Rho((fxcolor("grün", a) - mu)/sigma < Z <= (fxcolor("orange", b) - mu)/sigma)\
  &= Phi((fxcolor("orange", b) - mu)/sigma) - Phi((fxcolor("grün", a) - mu)/sigma)
$

#example-block[
  === Beispiel 1: Feuerwerk
  _Feuerwerk wird in der Silvesternacht ungefähr um Mitternacht gezündet. 5% des Feuerwerks wird schon vor 22 Uhr, 25% erst nach 1 Uhr gezündet._

  + _Zu welcher Zeit erreicht die Explosionsdichte ihr Maximum?_

    Die gegebenen Wahrscheinlichkeiten sind:
    $ Rho(X < 22 "Uhr") = 0.05, quad Rho(X > 25 "Uhr") = 0.25 => Rho(X < 25) = 0.75 $

    Wahrscheinlichkeiten standardisieren:
    $ Rho((X - mu)/sigma < (22 - mu)/sigma) = 0.05, quad Rho((X - mu)/sigma < (25 - mu)/sigma) = 0.75 $

    Da wir die Wahrscheinlichkeiten schon haben, müssen wir die Werte aus der Quantiltabelle herauslesen oder
    mit TR $"invNorm"(p, 0, 1)$ erhalten.
    $ Phi^(-1)(0.75) = 0.6745, quad Phi^(-1)(0.05) = -1 dot Phi^(-1)(1 - 0.05) = -1 dot 1.6449 = -1.6449 $

    Gleichungssystem aufstellen, mit TR #tr-constructs-button -Taste rechts neben "9" $->$
    "$script(cases(ballot, ballot))$" und dieses dann mit $"solve"()$ lösen
    $
      cases(
        (22 - mu)/sigma &= -1.6449,
        (25 - mu)/sigma &= 0.6745
      )
      quad => quad mu = 24.1276, quad sigma = 1.2934
    $

    Wandelt man $mu$ in Stunden und Minuten um, erhält man als Mittelwert 00:08 Uhr.

  + _Wie hoch ist die Wahrscheinlichkeit, nach 2 Uhr noch Explosionen zu hören?_
    $ Rho(X > 26) = Rho(Z > (26 - mu)/sigma) = Rho(Z > (26 - 24.1276)/1.2934) = Rho(Z > 1.4477) $

    Wert aus Standardnormalverteilungstabelle lesen oder mit TR $"normCdf"(-infinity, 1.4477, 0, 1)$
    $ Phi(1.4477) = 0.9261 $

    Da man nur $Rho(X < x)$ berechnen kann, muss noch minus 1 gerechnet werden
    $ Rho(X > 26) = 1 - Rho(X < 26) = 1 - Rho(Z < 1.4477) = 1 - 0.9261 = 0.0739 = underline(7.39%) $

  === Beispiel 2: Geburtsgewicht
  _8.2% aller Babies werden mit einem Geburtsgewicht unter $x_"min" = 2.5"kg"$ geboren und gelten als "low birth weight".
  Das mittlere Gewicht ist 3.5kg. Wie schwer ist ein Baby mindestens, welches schwerer als 95% aller Babies ist?_

  Die Wahrscheinlichkeiten aus der Aufgabe herauslesen und standardisieren:
  $
    Rho(X <= x_"min") = 0.082, quad 0.082 = Rho((X - mu)/sigma <= (x_"min" - mu)/sigma) = Rho(Z <= (x_"min" - mu)/sigma)
  $

  Wert aus Quantil-Standardnormalverteilungstabelle lesen #hinweis[(1 - Wert rechnen, um ihn aus der Tabelle ablesen zu können,
  danach mit mal -1 wieder zurücktransformieren)] oder direkt mit TR $"invNorm"(0.082, 0, 1)$
  $ Phi^(-1)(0.082) = -1 dot Phi^(-1)(1 - 0.082) = -1 dot 1.392 = -1.392 $

  Standardabweichung $sigma$ berechnen:
  $ sigma = (x_"min" - mu) / (-1.392) = (2.5 - 3.5) / (-1.392) = 0.7184 $

  $Z$-Wert für 95%-Quantile aus der Quantilentabelle ablesen oder mit $"invNorm"(0.95, 0, 1)$:
  $ Z = Phi^(-1)(0.95) = 1.6449 $

  Das kritische Gewicht $x$ mithilfe der Standardnormalverteilungsformel berechnen:
  $ Z = (x - mu) / sigma quad => quad 1.644 = (x - 3.5) / (0.7184) quad => quad x = underline(4.682"kg") $

]

Sollte eine Frage zur Varianz bei $n$ Stichproben kommen, muss die Varianz einfach durch $n$ geteilt werden.
$ "var"(M_n) = "var"(X) / n = sigma^2 / n, sigma_1 = sqrt("var"(M_n)) $

#pagebreak()

== Binomialverteilung
Bei einem Zufallsexperiment mit zwei möglichen Ausgängen sind die verschiedenen Versuchsausgänge binomialverteilt.\
*Anwendungen:* Anzahl Eintreten eines Bernoulliexperimentes, z.B. Würfe eines fairen Würfels

#definition[
  Die Wahrscheinlichkeitsfunktion der Binomialverteilung ist:
  #grid(
    align: horizon,
    [$ Rho(X = k) = binom(n,k) dot p^k dot (1-p)^(n-k) $],
    [
      *$k$*: Anzahl Ereignisse\
      *$n$*: Anzahl Durchführungen\
      *$p$*: Wahrscheinlichkeit, dass Ereignis eintritt
    ]
  )

  #table(
    columns: (1fr, 1fr),
    align: horizon,
    table.header([Erwartungswert], [Varianz]),
    [$ E(X) = n dot p = mu $], [$ "var"(X) = n dot p dot (1 - p) = sigma^2 $],
  )

  #hinweis[
    TR Binomialkoeffizient $binom(n,k)$: menu-5-3 / $"nCr"(n, k)$,
    TR Binomialverteilung: menu-5-5-A / $"binomPdf"(n, p, k)$
  ]
]

=== Normalapproximation Binomialverteilung
$X$ ist die Summe von $n$ kleinen Einflüssen auf das Gesamte $arrow.double Rho(X <= k)$ kann mit der _Normalverteilung_
approximiert werden, sofern die _Anzahl Wiederholungen *$n$*_ gross genug ist und man sich in der Mitte der Normalverteilung
befindet.

$display((X - mu)/sigma = (X - n p)/sqrt(n p (1-p))) quad$ ist angenähert standardnormalverteilt.

=== Standardisierung mit Korrektur
Für eine genauere Approximation kann folgende Korrektur eingefügt werden:

#grid(
  columns: (1.2fr, 1fr),
  gutter: 2em,
  [
    $
      Rho(a fxcolor("grün", <) X fxcolor("orange", <=) b)
      = Phi((b fxcolor("orange",+ 1/2) - n p)/sqrt(n p (1-p))) - Phi((a fxcolor("grün", + 1/2) - n p)/sqrt(n p (1-p)))
      \ \
      Rho(a fxcolor("grün", <=) X fxcolor("orange", <=) b)
      = Phi((b fxcolor("orange",+ 1/2) - n p)/sqrt(n p (1-p))) - Phi((a fxcolor("grün", - 1/2) - n p)/sqrt(n p (1-p)))
    $
  ],
  image("img/wrstat_11.png"),
)


=== Beispiel 1: Schwurbler-Anteil (nicht selten)
An eine Verschwörungstheorie glauben 14% der Amerikaner. Ein Dorf hat 87 Einwohner.\
Wie gross ist die Wahrscheinlichkeit, in diesem Dorf mehr als 10 Anhänger dieser Theorie zu finden?

$ X = "Anzahl Anhänger im Dorf", quad n = 87, quad p = 0.14 $

*Erwartungswert und Varianz*\
$ mu = n dot p = 12.180, quad sigma = sqrt(n p(1-p)) approx 3.2365 $

*Nomalverteilungsapproximation der Binomialverteilung*\
Standardisierung: $Z = (X - mu)\/sigma$

$
  Rho(X <= 10) &approx Rho(Z < (overbracket(10.5, X + 1/2) - mu)/sigma)
  = Rho(Z < (10.5 - 12.180)/3.2365) = Rho(Z < -0.5191) overbracket(=, 5-5-2) 0.3018\
  arrow.double Rho(X > 10) &approx 1 - 0.3018 = 0.698 arrow.double underline(69.8%)
$


=== Beispiel 2: Würfel, Abweichung mit Grenzen
Wie gross ist die Wahrscheinlichkeit, in hundert Würfen von fairen Sechserwürfeln eine um mehr als 5 von der
erwarteten Anzahl abweichende Anzahl gerader Augenzahlen zu erhalten?

$ X = "Anzahl gerader Augenzahlen", quad n = 100, quad p = 1 / 2 quad ("Wahrscheinlichkeit gerade Augenzahl") $

*Erwartungswert und Varianz*\
$ mu = n dot p = 50, quad sigma = sqrt(n p(1-p)) = 5 $

*Nomalverteilungsapproximation der Binomialverteilung*\
$
  Rho(X < 45 and X > 55) &= 1 - Rho(45 <= X <= 55)\
  Rho(45 <= X <= 55) &= Rho((45 - mu)/sigma <= (X - mu)/sigma <= (55-mu)/sigma)\
  &approx Rho((overbracket(-5.5, 45 - 50 + 1/2))/5 <= Z <= overbracket(5.5, 55 - 50 + 1/2)/5) = Rho(-1.1 <= Z <= 1.1)
$

Wert für $1.1$ aus Standardnormalverteilungstabelle lesen oder mit TR 5-5-2 $"normCdf"(-infinity, 1.1, 0, 1)$
$
  Phi(1.1) - Phi(-1.1) = Phi(1.1)-(1-Phi(1.1)) = 0.8643 - (1 - 0.8643) = 0.7286\
  arrow.double Rho(X < 45 and X > 55) = 1 - 0.7286 = 0.2714 arrow.double underline(27.14%)
$

=== Beispiel 3: Mehr als X Ereign. (nicht selten)
$40%$ aller Kreditkartentransaktionen sind Visa-Transaktionen. Wie wahrscheinlich ist es, in einer Stichprobe von 1000
Transaktionen _mehr als_ 430 Visa-Transaktionen zu finden?

$ X = "Anzahl Visa-Transaktionen", quad n = 1000, quad p = 0.4, quad Y = "Normalverteilte Zufallsvariable" $

*Erwartungswert und Varianz*\
$ mu = n dot p = 400, quad sigma = sqrt(n p(1-p)) = sqrt(240) $

*Normalverteilungsapproximation der Binomialverteilung*\
$ Rho(X <= 430) approx Rho(Y <= 430 + 1/2) $

Standardisierung mit $Z = (Y - mu)\/sigma$
$ Rho((Y-mu)/sigma <= (430 + 1/2 - 400)/sigma) = Rho(Z <= (430.5 - 400)/sqrt(240)) = Rho(Z <= 1.9688) $

Quantilwert berechnen mit TR: Menü-5-5-2 $"normCdf"()$
$
  Phi^(-1)(1.9688) = "normCdf"(-infinity, 1.9688, 0, 1) = 0.97551\
  arrow.double Rho(X > 430) = 1 - 0.97551 = 0.02449 arrow.double underline(2.44%)
$

#pagebreak()

== Poisson-Verteilung
Für gedächtnislose Prozesse mit gleichem Parameter $a$, einer Anzahl Ereignisse mit exponentialverteilten Intervallen,
Approximation der Binomialverteilung für seltene Ereignisse, die mit Rate $lambda$ eintreten.\
*Anwendung:* Wenn in einer (Teil-)Aufgabenstellung das Wort "selten" steht.

#definition[
  Die Wahrscheinlichkeitsfunktion der Poisson-Verteilung ist:

  #grid(
    columns: (1fr, 1.2fr),
    [
      $ Rho_lambda (k) = (lambda^k) / k! e^(-lambda) $
    ],
    [
      *$k$:* Anzahl Ereignisse\
      *$lambda$:* Durchschnittliches Auftreten des Ereignis im Intervall
    ],
  )

  #table(
    columns: (1fr, 1.2fr),
    table.header([Erwartungswert], [Varianz]),
    [$ E(X) = lambda $], [$ "var"(X) = lambda $],
  )
]


#example-block[
  === Beispiel 1: Schwurbler-Anteil (selten)
  _1% der Personen glauben, dass die Erde Flach ist. Wie wahrscheinlich ist es, in einem Dorf mit 87 Einwohner
  *mehr als* zwei Flacherdler hat?_

  $ n = 87, quad p = 0.01, quad lambda = n dot p = 87 dot 0.01 = 0.87 $

  $
    Rho(X > 2) &= 1 - Rho(X <= 2)\
    Rho(X <= 2) &= e^(- lambda) sum^2_(k=0) lambda^k / k! = e^(-lambda) (1 + lambda + lambda^2 / 2) approx 0.9420\
    arrow.double P(X > 2) &= 1 - 0.9420 = 0.0508 arrow.double underline(5.08%)
  $


  === Beispiel 2: 6er mit 5 Würfeln
  _Es passiert *sehr selten*, dass beim Werfen von 10 fairen Sechserwürfel genau 5 Würfel eine Fünf zeigen.
  Wie wahrscheinlich ist es, dass dies in 100 Versuchen *mehr als 2 mal* passiert?_

  Genau fünf Fünfer beim Wurf von 10 Würfeln haben die Wahrscheinlichkeit $p$.\
  #hinweis[Binom TR: Menü-5-3 / $"nCr"(10,5)$]

  $ n = 100, quad p = binom(10,5) (1^5 dot 5^5) / 6^10 = 0.013024, quad lambda = n dot p = 100 dot 0.013024 = 1.3024 $

  $
    Rho(Y > 2) &= 1 - Rho(X <= 2)\
    Rho(X <= 2) &= e^(- lambda) sum^2_(k=0) lambda^k / k! = e^(-lambda) (1 + lambda + lambda^2 / 2) = 0.8566\
    arrow.double P(Y > 2) &= 1 - 0.8566 = 0.1434 arrow.double underline(14.34%)
  $

  === Beispiel 3: Mehr als X Ereignisse (selten)
  _Betrügerische Transaktionen sind *selten*, erreichen aber etwa 1% des gesamten Zahlungsvolumens._

  _Unter der Annahme, dass die Wahrscheinlichkeit einer betrügerischen Transaktion $0.1%$ ist, wie wahrscheinlich ist es,
  dass der Händler in einer Stichprobe von $1000$ Transaktionen mehr als $3$ betrügerische findet?_

  $ n = 1000, quad p = 0.001, quad lambda = n dot p = 1000 dot 0.001 = 1 $

  $
    Rho(X > 3) &= 1 - P(X <= 3)\
    Rho(X <= 3)&= e^(- lambda) sum^3_(k=0) lambda^k / k!
    = e^(-lambda) ( 1 + lambda + lambda^2 / 2! + lambda^3 / 3!) approx 0.981012\
    arrow.double Rho(X > 3) &= 1 - 0.981012 = 0.018988 arrow.double underline(1.89%)
  $
]

#pagebreak()

= Hypothesen testen <test>
#hinweis[
  Meist Aufgaben 4 oder 5 und manchmal auch noch 8 - kann also in zwei Aufgaben vorkommen.\
  *Punkteverteilung:* Korrekter Test verwendet (1), Korrekte Nullhypothese (1), sinnvolles $alpha$ (1), Korrekte Werte (1),
  Festlegen, ob Nullhypothese verworfen werden kann (1), Korrekte Schlussfolgerung notieren (1)
]

== Methodik
#definition[
  #v(0.5em)
  ==== Aufgabe
  Gegeben ist eine Studie oder Untersuchung mit diversen Messdaten.

  Die Frage ist meist "Kann man daraus schliessen ..." / "Kann damit eine Aussage über xy gemacht werden" /
  "Formulieren Sie einen Test ... "

  ==== Vorgehensweise
  + Korrekte Testmethode auswählen und entsprechendes Beiblatt verwenden
  + Anleitung des ausgewählten Tests folgen

  #hinweis[Sinnvolles $alpha$: $0.05, 0.01, 0.001$ (Häufig $0.05$)]
]

== T-Test
- *Wann verwenden?* Beim Vergleich der Mittelwerte zweier _kontinuierlicher_ Datengruppen,
  Daten sind _Normalverteilt_ und weisen die gleiche Varianz auf. Die Beobachtungen sind _unabhängig_.
- *Was macht der Test?* Testet, ob sich zwei Stichproben _nicht_ signifikant voneinander unterscheiden.
- *Gegeben:* 2 Listen an Datenwerten oder Anzahl Stichproben, Mittelwert und Varianz

*Beispiel Nullhypothese $H_0$:*
Die Stichproben $X_1, .... , X_n$ und $Y_1, ... , Y_m$ mit gleicher Varianz haben den gleichen Erwartungswert.

=== Berechnung
+ Beiblatt _"T-Test"_ verwenden
+ Falls 2 Listen an Datenwerten gegeben: TR-Skript _"tverttest"_ verwenden:
  $ "tverttest"(mat(X_1; X_2; dots.v; X_n), mat(Y_1; Y_2; dots.v; Y_m), alpha) $
+ Falls zwei Datengruppen mit Anzahl Messpunkte, Durchschnittswert und Standardabweichung gegeben:
  TR-Skript _"tverttest2"_ verwenden #hinweis[(Der obere Teil des Beiblattes mit den Messdaten bleibt in diesem Fall leer)]
  $ "tverttest2"(n, m x, s x, m, m y, s y, alpha) $
  #hinweis[
    $n =$ Anzahl Werte Messreihe X, $m x = $ Durchschnitt der X-Werte, $s x =$ Standardabweichung der X-Werte\
    $m =$ Anzahl Werte Messreihe Y, $m y =$ Durchschnitt der Y-Werte, $s y =$ Standardabweichung der Y-Werte
  ]
+ Auf Prüfung schreiben, dass der T-Test auf dem Beiblatt steht

#pagebreak()

== $bold(chi^2)$ Test
*Wann verwenden?* Um zu prüfen, ob sich die _Häufigkeitsverteilung_ einer kategorialen Variable von einer
angenommenen Gleichverteilung unterscheidet.

*Was macht der Test?* Häufigkeiten oder Anteile von zwei oder mehr Gruppen kategorialer Daten vergleichen und
feststellen, ob sie sich signifikant unterscheiden

*Gegeben:* Eine Messung für jede Kategorie

*Beispiel Nullhypothese $H_0$:* Die beobachteten Häufigkeiten $n_i$ entsprechen den Wahrscheinlichkeiten $p_i$

=== Berechnung
- Beiblatt _"$bold(chi^2)$-Test"_ verwenden
- TR-Skript _"x2test"_ verwenden:\
  #hinweis[(Achtung: wenn $P(x_i) = 18%$, muss in Tabelle $0.18$ geschrieben werden und nicht $18$)]
  $ "x2test"(mat(Rho(x_1), x_1; Rho(x_2), x_2; dots.v, dots.v; Rho(x_n), x_n), alpha) $
- Auf Prüfung schreiben, dass der $chi^2$-Test auf dem Beiblatt steht


== Kolmogorov-Smirnov-Test
*Wann verwenden?* Wenn mehrere Zufallsvariablen und Grenzen angegeben sind.

*Was macht der Test?* Testet, ob eine gegebene Zufallsvariable einer _Gleichverteilung_ folgt.

*Gegeben:* $n$ Werte, die scheinbar gleichverteilt sind, Min- und Max Grenze.

=== Berechnung
- Beiblatt _"Beiblatt Kolmogorov-Smirnov-Test"_ verwenden
- TR-Skript _"smirnovtest"_ verwenden #hinweis[(Skript sortiert Werte automatisch)]:
  $ "smirnovtest"(mat(x_1; x_2; dots.v; x_n), "minVal", "maxVal") $
  #hinweis[(Achtung: $K_"krit"$ muss manuell aus Tabelle ausgelesen werden)]
- Auf Prüfung schreiben, dass der Kolmogorov-Smirnov-Test auf dem Bleiblatt steht


== Weitere Theorie
=== Grundsätzliche Testmethode
+ _Nullhypothese $H_0$_ #hinweis[(Nichts besonderes)] und ggf. Alternativhypothese $H_1$
  #hinweis[(Etwas besonderes)] formulieren
+ _Testgrössen_ und _Verteilung_ unter Annahme der Nullhypothese bestimmen
+ Wahl des _Signifikanzniveaus $bold(alpha)$_ #hinweis[(Oft 0.05, 0.01, 0.001)]
+ _Kritischer Wert_ für Testgrösse bestimmen, die nur mit Wahrscheinlichkeit $alpha$ erreicht wird
+ Kritischer Wert erreicht? _$bold(=> H_0)$ verwerfen_

- _Fragestellung:_ Hilft das neue Medikament dem Patienten, schneller gesund zu werden?
- _Nullhypothese $H_0$:_ Es ist kein Unterschied in der Genesungszeit zwischen Medikament und Placebo feststellbar.
- _Alternativhypothese $H_1$:_ Die Genesungszeit zwischen Medikament und Placebo ist verschieden.


#pagebreak()

= Ereignisse und Wahrscheinlichkeit <ereignisse>
#hinweis[Meist Aufgabe 7 oder 8. \
  *Punkteverteilung:* Wahl geeigneter Ereignisse (1), Wahrscheinlichkeiten korrekt zuordnen (1), Korrekte Sätze anwenden (1-2), Gesuchte Wahrscheinlichkeiten berechnen (Rest)]

== Methodik
#definition[
  #v(0.5em)
  ==== Aufgabe
  Gegeben ist eine komplizierte Situation. Nur "ja / nein"-Resultate, keine Messwerte, Abhängigkeit.

  Die Frage ist oft: Mit welcher Wahrscheinlichkeit passiert etwas? "Wie gross ist die Wahrscheinlichkeit, dass ..." /
  "Wie wahrscheinlich ist es, ..." / "Wie häufig ..."

  ==== Vorgehensweise
  + Ereignisse ableiten und hinschreiben
  + Bedingte Wahrscheinlichkeiten zuordnen
  + Gesuchte bedingte Wahrscheinlichkeiten identifizieren
  + Rechenregeln anwenden: Satz von Bayes und/oder Totale Wahrscheinlichkeit
]

#definition[
  *Satz von Bayes*\
  Für zwei beliebige Ereignisse mit $A$ und $B$ mit nicht verschwindender Wahrscheinlichkeit gilt:
  $
    Rho(A|B) dot Rho(B) = Rho(A inter B) = Rho(B|A) dot Rho(A) quad
    arrow.double quad Rho(A|B) = Rho(B|A) dot Rho(A) / Rho(B)
  $
]

#definition[
  *Satz der Totalen Wahrscheinlichkeit*\
  Hat man für ein Ereignis $A$ mehrere Bedingungen $B_i$ #hinweis[(z.B. mehrere Fälle oder Ursachen für $A$)],
  kann man die Wahrscheinlichkeit für $A$ berechnen, wenn man die bedingten Wahrscheinlichkeiten für $B_i$
  zusammenzählt #hinweis[(Aus Einzelfällen lässt sich die Gesamtsituation zusammenstellen.)]

  $ Rho(A) = sum_(i=1)^n Rho(A|B_i) dot Rho(B_i) $
]

/*=== Beispiel: Monty-Hall-Problem
#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    ==== Experiment
    + Spieler wählt eine Tür
    + Spielleiter öffnet eine Tür, hinter der sich eine Ziege verbirgt
    + Spieler kann bei der Wahl bleiben oder die Tür wechseln.
  ],
  [
    ==== Ereignisse
    $Omega = {$ Alle Spielverläufe $}$ \
    $Z = {$ Erste Wahl ist eine Ziege $}$, $Rho(Z) = 2/3$ \
    $A = {$ Erste Wahl ist ein Auto $}$, $Rho(A) = 1/3$ \
    $G = {$ Gewinnt ein Auto $}$ \
  ]
)
==== Spielstrategien
+ _Wechselstrategie:_ Auf die verbleibende, nicht geöffnete Tür wechseln.
+ _Bleibestrategie:_ Bei der Tür der ersten Wahl bleiben.

*Totale Wahrscheinlichkeit:*
$Rho(G) = fxcolor("grün", Rho(G|A)) dot fxcolor("rot", Rho(A)) + fxcolor("gelb", Rho(G|Z)) dot fxcolor("orange", Rho(Z))$\
*Bleibestrategie:*
$Rho(G|A) = 1$, $Rho(G|Z) = 0 arrow.double Rho(G) = fxcolor("grün", 1) dot fxcolor("rot", 1/3) + fxcolor("gelb", 0)
dot fxcolor("orange", 2/3) = Rho(A) = 1/3$\
*Wechselstrategie:*
$Rho(G|A) = 0$, $Rho(G|Z) = 1 arrow.double Rho(G) = fxcolor("grün", 0) dot fxcolor("rot", 1/3) + fxcolor("gelb", 1)
dot fxcolor("orange", 2/3) = Rho(Z) = 2/3$

$arrow.double$ Wechselstrategie ist vorteilhaft.

#pagebreak()*/

=== Beispiel: Positiver HIV-Test
#v(0.5em)
#grid(
  [
    ==== Experiment
    Ein HIV-Test ist nicht immer zuverlässig, er kann einer erkrankten Person ein negatives Resultat liefern oder umgekehrt.
    _Ist das Auftreten des gesuchten Ereignis seltener als die Fehlerquote, ist der Test schlechter als 50%_.
  ],
  [
    ==== Ereignisse
    $Omega = {$ Alle Testausgänge $}$\
    $H = {$ Person mit HIV infiziert $}$, $Rho(H) = 0.001$\
    $T = {$ Test positiv $}$, $Rho(T|H) = 0.999$\
    $Rho(dash(T)|dash(H)) = {$ negat. Test bei gesunder Pers. $} = 0.9999$\
  ]
)

*Totale Wahrscheinlichkeit $Rho(T)$ für positiven Test, egal ob infiziert*\
$
  Rho(T) &= fxcolor("grün", Rho(T|H)) dot fxcolor("rot", Rho(H)) + fxcolor("gelb", Rho(T|dash(H)))
  dot fxcolor("orange", Rho(dash(H)))\
  &= fxcolor("grün", Rho(T|H)) dot fxcolor("rot", Rho(H)) + underbracket((1 - fxcolor("hellblau", Rho(dash(T)|dash(H))))
    dot (1 - fxcolor("orange", Rho(H))), "Umkehren des Ereignisses in bekannte Werte")\
  &= 0.999 dot 0.0001 + 0.0001 dot 0.9999 = underline(0.00019899)
$

*Wahrscheinlichkeit, bei positivem Test infiziert zu sein $Rho(H|T)$*

$Rho(H|T) = Rho(T|H) dot display(Rho(H)/Rho(T)) = 0.999 dot display(0.0001/0.00019899) = underline(0.502)$


== Bedingte Wahrscheinlichkeit
#definition[
  Wahrscheinlichkeit, dass $A$ eintritt, wenn wir schon wissen, dass $B$ eingetreten ist, $A$ und $B$ sind _unabhängig_.
  $ Rho("was wir wissen wollen" | "was wir wissen") = Rho(A|B) = Rho(A inter B) / Rho(B) $
]

=== Beispiel: Enterprise
Wie gross ist die Wahrscheinlichkeit zu sterben, wenn man ein Redshirt auf der Enterprise ist?
#grid(
  columns: (2fr, 1.6fr, 0.7fr),
  [
    #v(-0.75em)
    #table(
      columns: (auto,) * 4,
      align: (x, y) => { if (x > 1 and y > 0) { right } else { auto } },
      table.header([Bereich], [Shirtfarbe], [Bestand], [Tot]),
      [*Command*], [gold], [55], [9],
      [*Science*], [blau], [136], [7],
      [*Engineering*], [rot], [149], [6],
      [*Security*], [rot], [90], [18],
      table.hline(stroke: 1.5pt + black),
      table.footer([*Total*], [], [430], [40])
    )
  ],
  [
    *Ereignisse*\
    - $Omega = {"Alle Besatzungsmitglieder"}$
    - $G = {"Command"}$
    - $B = {"Science"}$
    - $R = {"Redshirts"}$
    - $S = {"Security"}$
    - $T = {"kommt um"}$
  ],
  image("img/wrstat_03.png"),
)

*$Rho(R|T)$: Wahrscheinlichkeit, dass ein Toter ein rotes Shirt trägt.*
#grid(
  columns: (2fr, 1fr),
  [
    - _Was wir wissen wollen:_ Trägt die Person ein rotes Shirt?
    - _Was wir wissen:_ Person ist tot.
  ],
  [
    $ fxcolor("grün", Rho(R|T) = Rho(R inter T)/Rho(T)) $
  ],
)

#v(-0.5em)

*$Rho(T|R)$: Wahrscheinlichkeit, dass ein Redshirt umkommt*\
#grid(
  columns: (2fr, 1fr),
  [
    - _Was wir wissen wollen:_ Ist die Person tot?
    - _Was wir wissen:_ Die Person trägt ein rotes Shirt.
  ],
  [
    $ fxcolor("rot", Rho(T|R) = Rho(T inter R)/Rho(R)) $
  ],
)

#v(-0.5em)

=== Satz von Bayes
#definition[
  Für zwei beliebige Ereignisse mit $A$ und $B$ mit nicht verschwindender Wahrscheinlichkeit gilt:
  $
    Rho(A|B) dot Rho(B) = Rho(A inter B) = Rho(B|A) dot Rho(A) quad
    arrow.double quad Rho(A|B) = Rho(B|A) dot Rho(A) / Rho(B)
  $
]

Der Satz von Bayes kann angewendet werden, um _von einer Wahrscheinlichkeit auf die andere zu schliessen_:
$
  fxcolor("grün", Rho(R|T)
  = Rho(R inter T)/Rho(T)) dot underbracket(Rho(R)/Rho(R), "erweitern")
  = underbracket(fxcolor("rot", Rho(T inter R)/Rho(R)) dot Rho(R)/Rho(T), "umstellen")
  = underbracket(fxcolor("rot", Rho(T|R)), "einsetzen") dot Rho(R) / Rho(T) quad
  arrow.double quad bold(Rho(R|T) = Rho(T|R) dot Rho(R)/Rho(T))
$

#hinweis[*Merksatz:* Wert rechts vom Strich kommt unter den Strich (90° drehen). $Rho(R|T)$ wird zu $... dot Rho(R)\/Rho(T)$ ]

Im Allgemeinen gilt $Rho(A|B) eq.not Rho(B|A)$, der Satz von Bayes erlaubt aber, die Schlussrichtung umzukehren.

=== Unabhängigkeit
$A$ und $B$ heissen _unabhängig_, wenn $Rho(A inter B) = Rho(A) dot Rho(B)$\
#hinweis[
  (Wahrscheinlichkeit für $A$ und $B$ zusammen ist gleich gross wie die einzelne Wahrscheinlichkeit von
  $A$ und $B$ multipliziert)
]

#grid(
  [
    *Abhängig*\
    $Rho(A|B) < Rho(A|dash(B))$\
    #hinweis[$B$ beeinflusst $A$, W'keit mit $B$ ist darum anders als ohne. $B$ verändert also die Form von $A$.]
    #v(-0.75em)
    #image("img/wrstat_04.png", width: 57%)
  ],
  [
    *Unabhängig*\
    $Rho(A|B) = Rho(A|dash(B))$\
    #hinweis[$B$ beeinflusst $A$ nicht, W'keit ist gleich. Der Anteil von $A$ ist bei $B$ und $dash(B)$ gleich.]
    #v(-0.75em)
    #image("img/wrstat_05.png", width: 57%)
  ]
)

Bei bedingten Wahrscheinlichkeiten gilt:
$ Rho(dash(A)|B) = 1 - Rho(A|B) $

Der Begriff _"unabhängig"_ wird manchmal _verwechselt_ mit dem Begriff _"disjunkt"_. Zwei disjunkte Ereignisse
$A$ und $B$, also mit $Rho(A dot B) = emptyset$, können aber _nur dann unabhängig_ sein, wenn eins der beiden
Ereignisse die _Wahrscheinlichkeit 0_ hat. Nur dann ist $Rho(A) dot Rho(B) = 0 = Rho(emptyset) = Rho(A dot B)$.

=== Satz der Totalen Wahrscheinlichkeit
#definition[
  Hat man für ein Ereignis $A$ mehrere Bedingungen $B_i$ #hinweis[(z.B. mehrere Fälle oder Ursachen für $A$)], kann man
  die Wahrscheinlichkeit für $A$ berechnen, wenn man die bedingten Wahrscheinlichkeiten für $B_i$ zusammenzählt
  #hinweis[(Aus Einzelfällen lässt sich die Gesamtsituation zusammenstellen.)]

  $ Rho(A) = sum_(i=1)^n Rho(A|B_i) dot Rho(B_i) $
]

==== Beispiel
Wie gross ist die Wahrscheinlichkeit $Rho(T)$, auf der Enterprise umzukommen?
#v(-0.3em)
#grid(
  columns: (1.2fr, 0.2fr),
  [
    *Wahrscheinlichkeitsfallunterscheidung:* Aus den bedingten Wahrscheinlichkeiten die Bedingung herausrechnen,
    um die Totale Wahrscheinlichkeit zu erhalten.

    $& Rho(T inter G) &= Rho(T|G) dot Rho(G)\
     + &Rho(T inter B) &= Rho(T|B) dot Rho(B)\
     + &Rho(T inter R) &= Rho(T|R) dot Rho(R)\
     #place(line(length: 4.5cm, stroke: 0.075em), dy: -3.4mm)
     &Rho(T)$
  ],
  image("img/wrstat_03.png"),
)

== Weitere Theorie
- _Ergebnis:_ Die einzelnen, sich gegenseitig ausschliessenden möglichen Ausgänge eines Zufallsexperiments,
  also der tatsächlich eingetretene Fall/Messwert #hinweis[(z.B. Werfen einer 5 mit einem Würfel)]
- _Ereignis:_ Ergebnisse können zu Ereignissen zusammengefasst werden. Diese Teilmengen werden mit Grossbuchstaben
  gekennzeichnet. #hinweis[(z.B. Würfeln einer geraden Augenzahl $A = {2, 4, 6}$)]
- _Elementarereignis ${omega}$:_ Ein Ereignis, welches nur ein Ergebnis beinhaltet. Teilmenge von $Omega$\
  #hinweis[(Vereinfacht gesagt: "Das Elementarereignis $omega$ ist der Ausgang eines Experiments")].

#grid(
  columns: (2.4fr, 1fr),
  [
    === Versuche
    - $omega =$ _Elementarereignis_, ein (möglicher) Versuchsausgang
    - $Omega =$ Menge aller Elementarereignisse
    - $A =$ Ereignis 1 #hinweis[(Alle Versuchsausgänge, bei denen der Würfel 1 zeigt)]
    - $B =$ Ereignis $>=$ 4

    === Spezielle Ereignisse
    - _$bold(A = Omega subset Omega)$:_ Das _sichere_ Ereignis #hinweis[(Das Ereignis $A = Omega$ tritt immer auf)].
    - _$bold(B = emptyset = {} subset Omega)$:_ Das _unmögliche_ Ereignis #hinweis[(Tritt nie ein, z.B. das Würfeln einer 7)].
    - Haben zwei Ereignisse keine Überschneidungen, sind sie _paarweise disjunkt_.
  ],
  image("img/wrstat_01.png"),
)


=== Ereignis-Algebra
Eine Ereignis-Algebra ist eine Menge $cal(A)$ von Ereignissen derart, dass gilt:
+ Die _Vereinigung_ von zwei Ereignissen ist ein Ereignis:
  $A, B in cal(A) space arrow.double space A union B in cal(A)$ #hinweis[(A oder B)]
+ Die _Differenz_ von zwei Ereignissen ist ein Ereignis:
  $A, B in cal(A) space arrow.double space A without B in cal(A)$ #hinweis[(A ohne B)]
+ Es gibt das _unmögliche Ereignis_: $emptyset = Omega without Omega in cal(A)$
+ Das _Komplement_ eines Ereignisses ist ebenfalls ein Ereignis:
  $A in cal(A) space arrow.double space dash(A) = Omega without A in cal(A)$ #hinweis[(`!A`, nicht A)]
+ Die _Schnittmenge_ von zwei Ereignissen ist ein Ereignis:\
  $A, B in cal(A) space arrow.double space A inter B
    = (A union B) without ((A without B) union (B without A)) in cal(A)$ #hinweis[(A und B)]


=== Wahrscheinlichkeit
#table(
  columns: (1fr, 0.3fr, auto),
  table.header([Begriff], [Modell], [Beispiel Würfel]),
  [Versuchsausgang, Elementarereignis], [$omega$], [Zahl, die gewürfelt wird],
  [alle Versuchsausgänge], [$Omega$], [${1,...,6}$],
  [Ereignis], [$A subset Omega$], [$A ={1,2}, B = {2,...,4}$],
  [Ereignis ist eingetreten], [$omega in A$], [$1$ wurde gewürfelt],
  [sicheres Ereignis, tritt immer ein], [$Omega$], [${1,...,6}$],
  [unmögliches Ereignis, kann nicht eintreten], [$emptyset$], [${7}$],
  [$A$ und $B$ treten ein], [$A inter B$], [${2}$],
  [$A$ oder $B$ treten ein], [$A union B$], [${1,...,4}$],
  [$A$ hat $B$ zur Folge, wenn $A$, dann auch $B$], [$A subset B$], [],
  [Komplementärereignis, nicht $A$], [$dash(A) = Omega without A$], [${3,...,6}$],
)

/*==== Rechenregeln
#columns(2)[
  - $A inter (B union C) = (A inter B) union (A inter C)$
  - $A union (B inter C) = (A union B) inter (A union C)$
  #colbreak()
  - $dash(A inter B) = dash(A) union dash(B)$
  - $dash(A union B) = dash(A) inter dash(B)$
]*/

=== Definition Wahrscheinlichkeit
#definition[
  $
    Rho(A) = lim_("Anzahl Versuche" arrow infinity) "Anzahl Eintreten von A" / "Anzahl Versuche"
    = lim_(n arrow infinity) "rel. Häufigkeit von A"
  $
]

Die Wahrscheinlichkeit eines Ereignisses $A subset Omega$ ist eine Zahl $Rho(A)$ mit _folgenden Eigenschaften_:
#grid(
  columns: (5.5fr, 1.1fr),
  [
    - $0 <= Rho(A) <= 1$ #hinweis[Wertebereich, eine Wahrscheinlichkeit ist immer zwischen 0 und 1]
    - $Rho(Omega) = 1$ #hinweis[Wahrscheinlichkeit des sicheren Ereignisses]
    - $Rho(emptyset) = 0$ #hinweis[Wahrscheinlichkeit des unmöglichen Ereignisses]
    - $Rho(dash(A)) = Rho(Omega without A) = 1 - Rho(A)$ #hinweis[Wahrscheinlichkeit des komplementären Ereignisses]
    - $Rho(A without B) = Rho(A) - Rho(A inter B)$ #hinweis[Wahrscheinlichkeit der Differenz zweier Ereignisse $A$ und $B$]
    - $Rho(A union B) = Rho(A) + Rho(B) - Rho(A inter B)$
      #hinweis[Wahrscheinlichkeit der Vereinigung zweier beliebiger Ereignisse (Schnittmenge subtrahieren)]
    - $Rho(A_1 union A_2 union ... union A_n union ...) = Rho(A_1) + Rho(A_2) + ... + Rho(A_n) + ...$
      #hinweis[Diskunkte Vereinigung, Ereignisse nicht gleichzeitig möglich ($A_j inter A_i = emptyset$ für $i != j$)]
  ],
  image("img/wrstat_02.png"),
)

=== Laplace-Experiment
#definition[
  Alle Versuchsausgänge haben die _gleiche Wahrscheinlichkeit_. Nur das _unmögliche Ereignis_ hat W'keit $0$.\
  #hinweis[Würfeln, Karten ziehen, Münzen werfen.]
  $ Rho(A) = "Anzahl günstige Ausgänge" / "Anzahl mögliche Ausgänge" = abs(A) / abs(Omega) $
]

==== Beispiel zwei Würfel
$i$: Resultat Würfel 1, $k$: Resultat Würfel 2, $D$: Pasch gewürfelt, $S$: Summe der Würfel ergibt 7
- $Omega = [6] crossmark [6] = {(i, k) | 1 <= i, k <= 6} quad arrow.double quad abs(Omega) = 36$
- $D = "Pasch" = {(i,i) | 1 <= i <= 6} quad arrow.double quad Rho(D) = 6 / 36 = 1 / 6$
- $S = "Summe = 7" = {(i,k) | i + k = 7} quad arrow.double quad Rho(S) = 6 / 36 = 1 / 6$

=== Bernoulli-Experiment
#definition[
  Genau zwei Versuchsausgänge mit Wahrscheinlichkeiten $p$ und $1-p$\
  #hinweis[Münzen werfen, Mädchen oder Junge, Ereignis $A$ tritt ein oder nicht.]
  $ p = Rho(A), quad 1 - p = 1 - Rho(A) = Rho(dash(A)) $
]
