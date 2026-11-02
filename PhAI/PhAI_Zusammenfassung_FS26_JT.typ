// Compiled with Typst 0.15.1
#import "../template_zusammenf.typ": *
#import "charts.typ": *

#show: project.with(
  authors: ("Jannis Tschan",),
  fach: "PhAI",
  fach-long: "Physik Anwendungen für Informatik",
  semester: "FS26",
  language: "de",
  column-count: 5,
  font-size: 4.5pt,
  landscape: true,
  heading-page-number-in-ref: false,
)

// Shortcut for creating a variable with the half-arrow. Short for "hook" because it looks like one :)
#let hk(var) = $harpoon(#var)$

// Block for styling example exercises
#let example-block(body) = {
  set enum(numbering: "1)")
  show emph: set text(fill: black, weight: "regular")
  body
}

// Icon for the "Construct" button on the TI n-spire
#let tr-constructs-button = box(
  stroke: 0.1em,
  inset: (x: 0.2em),
  outset: (y: 0.25em, bottom: 0.55em),
  radius: 0.25em,
  baseline: -0.2em,
  $script(abs(ballot) cases(ballot, ballot))$,
)

#v(-1em)
#hinweis[*Hinweis:* Die Anweisungen zur Taschenrechnerbenutzung beziehen sich auf den TI nSpire CX II-T CAS.]

= Mathematik-Grundlagen
#v(-0.5em)
== Geometrie
Winkelfunktionen am rechtwinkligem Dreieck, Umwandlungen von Grad/Bogenmass
#definition(
  grid(
    columns: (1fr, auto),
    align: center + horizon,
    row-gutter: 0em,
    trigo(),
    $
      a": Ankathete," space g": Gegenkathete", space h": Hypothenuse"\
      sin(alpha) = g/h, quad cos(alpha) = a/h, quad tan(alpha) = g/a\
    $,
    grid.cell(colspan: 2)[
      $
        cos(15°) -> deg quad cos(15) -> "rad" space space
        (x ["deg"] dot pi)/180 = x ["rad"] quad x["rad"]/pi dot 180 = x[deg]
      $
    ],
  ),
)

In einem Dreieck kann eine Linie gezogen werden. Diese verkleinert das Dreieck.\
Die neue Grösse kann mit dem Strahlensatz berechnet werden.

#definition(
  grid(
    columns: (1fr, auto),
    align: center + horizon,
    strahlensatz(),
    $
      triangle "SAB, geschnitten mit Line ergibt" triangle "SA'B'"\
      abs("SA")/abs("SA'") = abs("SB")/abs("SB'"), quad
      abs("SA")/abs("AA'") = abs("SB")/abs("BB'"), quad
      abs("AA'")/abs("SA") = abs("BB'")/abs("SB")
    $,
  ),
)

== Einheitenpräfixe
#grid(
  table(
    columns: (1fr,) * 3,
    align: center,
    table.header([Präfix], [Zeichen], [Faktor]),
    [Exa], $"E"$, $10^(18)$,
    [Peta], $"P"$, $10^(15)$,
    [Tera], $"T"$, $10^(12)$,
    [Giga], $"G"$, $10^(9)$,
    [Mega], $"M"$, $10^(6)$,
    [Kilo], $"k"$, $10^(3)$,
    [Hekto], $"h"$, $10^(2)$,
    [Deka], $"da"$, $10^1$,
  ),
  table(
    columns: (1fr,) * 3,
    align: center,
    table.header([Präfix], [Zeichen], [Faktor]),
    [Dezo], $"d"$, $10^(-1)$,
    [Zenti], $"c"$, $10^(-2)$,
    [Milli], $"m"$, $10^(-3)$,
    [Mikro], $upright(mu)$, $10^(-6)$,
    [Nano], $"n"$, $10^(-9)$,
    [Piko], $"p"$, $10^(-12)$,
    [Femto], $"f"$, $10^(-15)$,
    [Atto], $"a"$, $10^(-18)$,
  ),
)

== Ableiten
#definition[
  #table(
    columns: (1fr, 0.7fr, 1fr),
    align: horizon,
    table.header([Kettenregel], [Produktregel], [Quotientenregel]),
    $
      dif/(dif x) (f(x) dot g(x)) =\
      f'(x) dot g(x) + f(x) dot g'(x)
    $,
    $
      dif/(dif x) (f(g(x))) =\
      f'(g(x)) dot g'(x)
    $,
    $
      dif/(dif x) (g(x)/h(x)) =\
      (g'(x) dot h(x) - g(x) dot h'(x)) / ((h(x))^2)
    $,
  )
]

#{
  set text(size: 0.96em)
  table(
    columns: (auto,) * 9,
    align: center,
    table.header(
      $bold(F(x))$, $x$, $1/(n+1) dot x^(n+1)$, $ln(x)$, $2/3 dot sqrt(x^3)$, $-cos(x)$, $sin(x)$, $e^x$, $x dot ln(x)$
    ),

    $bold(f(x))$, $1$, $x^n$, $1/x \/ x^(-1)$, $sqrt(x) \/ x^(1/2)$, $sin(x)$, $cos(x)$, $e^x$, $ln(x)$,

    $bold(f'(x))$,
    $0$,
    $n dot x^(n-1)$,
    $(- 1 \/ x^2)/(-1 dot x^(-2))$,
    $1/(2 sqrt(x)) \/ 1/2 dot x^(-1/2)$,
    $cos(x)$,
    $-sin(x)$,
    $e^x$,
    $1/x$,
  )
}

=== Partielle Ableitungen
Funktionen mit mehreren Variablen werden übersichtshalber nach jeder Variable einzeln abgeleitet. Um sie von der
regulären Ableitung (auch _totale Ableitung_ genannt) abzugrenzen, wird sie mit $partial$ anstatt $dif$ geschrieben.
Wird der Inhalt der Funktion ausgeschrieben, fehlt das $f$ oberhalb des Bruchstrichs.

#definition[$ (partial f)/(partial x) = partial/(partial x)(x^2 dot y) $]

#hinweis[
  TR: Wie normale Ableitung (Menü #sym.arrow 4 #sym.arrow 1), aber es müssen explizit Mal-Zeichen gesetzt werden.
  Wenn nach einem Winkel abgeleitet wird ($alpha$), fügt der TR gerne noch $pi$ und $180 dot$ hinzu.
  Diese Angaben können ignoriert werden.
]

*Beispiel:* $"Gegeben:" f(x, y) = x^2 dot e^y + y^2 - x$
#grid(
  $
    (partial f)/(partial x) & = partial/(partial x) (x^2 dot e^y + y^2 - x) \
                            & = underline(2x dot e^y + 0 - 1)
  $,
  $
    (partial f)/(partial y) & = partial/(partial y) (x^2 dot e^y + y^2 - x) \
                            & = underline(x^2 dot e^y + 2y - 0)
  $,
)

Sind die Variablen in der Funktion ebenfalls Funktionen, müssen diese auch abgeleitet werden, damit eine totale
Ableitung gebildet werden kann.

#definition[
  $
    f = f(x, y), space x = x(t), space y = y(t)
    quad => quad
    (dif f)/(dif t) = (partial f)/(partial x) dot (dif x)/(dif t) + (partial f)/(partial y) dot (dif y)/(dif t)
  $
]

Totale Ableitungen nach der Zeit $t$ werden in der Physik oft als $dot(x)$ geschrieben;
der Punkt bedeutet also _"totale Ableitung nach der Zeit"_.
#definition[
  $
    dot(F) = (dif F)/(dif t)
    quad quad
    dot.double(F) = (dif F)/(dif t)((dif F)/(dif t))
  $
]

*Beispiel:* $"Gegeben:" f(x, y) &= x^2 dot e^y + y^2 - x, quad space x(t) = sin(t), quad space y(t) = t^2$
$
  x(t) = sin(t) space => space (dif x)/(dif t) = dot(x) = cos(t)
  quad quad quad
  y(t) = t^2 space => space (dif y)/(dif t) = dot(y) = 2t
$
$
  (dif f)/(dif t) & = (partial f)/(partial x) dot (dif x)/(dif t) + (partial f)/(partial y) dot (dif y)/(dif t) \
                  & = underline((2x dot e^y -1) dot cos(t) + (x^2 dot e^y + 2y) dot 2t)
$

== Linearisierung
Mit der Linearisierung kann ein Punkt auf einer Funktion mit einer Tangente angenähert werden.
Funktionen mit zwei oder mehr Variablen müssen partiell abgeleitet werden.

#definition(
  grid(
    align: horizon,
    $
         f(x) space & => space Delta f approx (dif f)/(dif x) dot Delta x \
                    \
      f(x, y) space & => space Delta f = (partial f)/(partial x) dot Delta x + (partial f)/(partial y) dot Delta y \
            Delta x & = x - x_0
    $,
    [
      _$bold(x\,y)$:_ Zu linearisierender Punkt\
      _$bold(x_0)$:_ Entwicklungspunkt/Ausgangspunkt\
      _$bold(Delta x)$:_ Differenz zwischen $x_0$ und $x$\
      _$bold(Delta f)$:_ Veränderung des Funktionswerts $f$
    ],
  ),
)

*Beispiel: Linearisierung von $f$ an der Stelle $x = 1, y = 0$*
#v(-0.5em)
#example-block[
  $ "Gegeben:" f(x, y) = x^2 dot sin(y), quad space x(t) = 3t, quad space y(t) = t^2 $
  #v(-0.5em)
  #grid(
    columns: (1fr, 1.6fr),
    [
      + Partielle Ableitungen berechnen
      + Partielle Ableitungen in Formel einsetzen
      + Werte der angegebenen Stelle einsetzen und ausrechnen
    ],
    $
      1) space (partial f)/(partial x) & = 2x dot sin(y),
                                         quad (partial f)/(partial y) = x^2 dot cos(y) \
                      2) space Delta f & = (partial f)/(partial x) dot Delta x + (partial f)/(partial y) dot Delta y \
                                       & = (2x dot sin(y)) dot Delta x + (x^2 dot cos(y)) dot Delta y \
                      3) space Delta f & = (2 dot 1 dot sin(0)) Delta x + (1^2 dot cos(0)) dot Delta y \
                                       & = (2 dot 0) dot Delta x + (1 dot 1) dot Delta y
                                         = underline(Delta y)
    $,
  )
]

Nach der Linearisierung können _Näherungswerte_ mit der Funktion gebildet werden.\
*Beispiel:*
$
  "Gesucht:" f(0.9, 0.1) \
  "Gegeben:" f(x, y) = x^2 dot sin(y) "linearisiert mit" x = 1, y = 0, quad Delta f = Delta y
$
#v(-0.5em)
#grid(
  columns: (auto, 1fr),
  $
               1) space Delta x & = x - 1 = 0.9 - 1 = -0.1 \
               2) space Delta y & = y - 0 = 0.1 - 0 = 0.1 \
    3) space space space thin f & = f(1, 0) = + Delta f = 1^2 dot sin(0) + 0.1 = underline(0.1)
  $,
  $
    "Approximierung:"\
    x = 0.9 approx 1, space y = 0.1 approx 0\
    Delta f = Delta y = 0.1
  $,
)

== SI-Einheiten und davon abgeleitete Einheiten
#grid(
  columns: (auto, 1fr),
  table(
    columns: (auto,) * 4,
    align: center + horizon,
    table.header([Basisgrösse], [Variable], [Masseinheit], [Basiswert]),
    [Zeit], $t$, [Sekunde], $1"s"$,
    [Länge], $l$, [Meter], $1"m"$,
    [Masse], $m$, [Kilogramm], $1"kg"$,
    [Stromstärke], $I$, [Ampere], $1"A"$,
    [Temperatur], $T$, [Kelvin], $1"K"$,
    [Stoffmenge], $n$, [Mol], $1"mol"$,
    [Lichtstärke], $I_V$, [Candela], $1"cd"$,
    [Kraft], $N$, [Newton], $ "N" = 1 ("kg" dot "m")/("s"^2) $,
    [Energie], $J$, [Joule], $ 1"J" = 1"Nm" = ("kg" dot "m"^2)/("s"^2) $,
  ),
  [
    Newton und Joule sind keine SI-Einheiten, sondern _abgeleitete Einheiten_, da sie aus anderen Einheiten
    zusammengesetzt werden.

    Bei _Joule_ wird $1"J"$ verbraucht, wenn ein Körper $1"m"$ mit einer Kraft von $1"N"$ mit einer gleichbleibenden
    Geschwindigkeit gezogen wird.
  ],
)
#v(-1.5em)

Bei _Newton_ gilt:
- Mit der Kraft von $1"N"$ kann ein ruhender Körper mit Masse $1"kg"$ innerhalb von $1"s"$ auf $1"m"\/"s"$ beschleunigt
  werden kann.
- Verdoppelt man die Masse oder die Beschleunigung, verdoppelt sich auch die benötigte Kraft
  -- die Kraft ist proportional zur Masse und zur Geschwindigkeit
- Halbiert man die Zeit, verdoppelt sich die benötigte Kraft -- die Kraft ist umgekehrt proportional zur Dauer

=== Umrechnungen
_Achtung!_ In der Prüfung sind die Einheiten oft nicht in SI-Einheiten angegeben!
Einfachheitshalber sollten sie in diese konvertiert werden.\
#hinweis[(TR: Zahl eingeben, Buch-Taste #sym.arrow 3 #sym.arrow Umrechnungsassistent, Einheiten auswählen, Enter)]

#{
  set math.frac(style: "horizontal")
  grid(
    $
      "km"/"h" -> "m"/"s" & = x/3.6 \
             "kWh" -> "J" & = x/3.6 \
            "Ws" -> "kWh" & = x/3.6/1000 \
    $,
    $
      "m"/"s" -> "km"/"h" & = x dot 3.6 \
             "J" -> "kWh" & = x dot 3.6 \
            "kWh" -> "Ws" & = x dot 3.6 dot 1000 \
    $,
  )
}

== Messfehler
Bei Messungen kommt es immer zu Fehlern. Es gibt zwei Arten von Messfehlern:
- _Systematischer Fehler:_ Fehler durch ungenaue Messgeräte oder den Experimentaufbau.
  Verschwindet bei wiederholtem Messen nicht.
- _Statistischer Fehler:_ Fehler durch den Experimentator.
  Wird durch wiederholtes Messen und Mittelwertbildung verringert.

#grid(
  align: horizon,
  [
    Ein Messfehler wird meist als Abweichung angegeben. Daraus ergibt sich ein Intervall möglicher Werte.
  ],
  $ l = (2.50 plus.minus 0.05)"m" space => space (2.45; 2.55)"m" $,
)

*Regeln beim Messfehler*
- Der Messfehler muss _1 bis 2 signifikante Ziffern_ beinhalten. Als signifikante Ziffern zählen alle Ziffern $!= 0$.
  Damit hat $0.05$ eine signifikante Stelle.
- Der Messfehler hat _genau so viele Dezimalstellen_ wie der Messwert.\
  $(2.5 + 0.05)"m"$ verstösst beispielsweise gegen diese Regel #hinweis[($10^(-1)$ vs. $10^(-2)$)].
- Die Anzahl der signifikanten Stellen im Ergebnis einer Multiplikation oder Division ist nie grösser als die der Grösse
  mit den wenigsten signifikanten Stellen:\
  $1.2 dot 0.0315 = 0.03cancel(78) = 0.38$
- Die Anzahl der Dezimalstellen bei einer Addition oder Subtraktion mehrerer Grössen entspricht der des Terms mit der
  kleinsten Anzahl von Dezimalstellen:\
  $1.040 + 1.210415 = 2.250cancel(415) = 2.250$

Sollten aber doch Zahlen von diesen Regeln abweichen, müssen sie entsprechend gerundet werden.\
*Beispiele:*
$16.1612 plus.minus 8.7 approx 16.2 plus.minus 8.7 quad 870'261 plus.minus 10'125 approx 870'000 plus.minus 10'000$

=== Fehlerfortpflanzungsgesetz
Das Fehlerfortpflanzungsgesetz wird benutzt, um den _totalen Messfehler einer Formel_ mit mehreren Variablen
#hinweis[(die ebenfalls einzeln einen Messfehler besitzen)] zu erhalten. Es kann auf systematische und statistische
Fehler angewendet werden, jedoch gibt es für statistische Fehler bessere Methoden, siehe @statistische-fehlerrechnung.

#colbreak()

_Achtung! Ist eine Messgrösse in Grad angegeben, den TR in den Grad-Modus schalten_
#hinweis[(Oben rechts auf "RAD" klicken)] _und den Fehler vorher ins Bogenmass umrechnen!_

#definition[
  #grid(
    columns: (1fr, 1.2fr),
    align: horizon,
    $ Delta f = sum_(i=1)^n abs((delta f)/(delta x_i) dot Delta x_i) $,
    [
      _$bold(x_i)$_: Messgrösse ohne absoluten Fehler\
      _$bold(f)$_: Formel, welche Messgrössen enthält\
      _$bold(delta f\/delta x_i)$_: Partielle Ableitung von $f$ mit $x_i$\
      _$bold(Delta x_i)$_: Absoluter Fehler der Messgrösse $x_i$\
    ],
  )
]

#hinweis[
  *TR:* Leider keine built-in Funktion. Am besten die gegebene Funktion als Variable speichern, damit sie für die
  partiellen Ableitungen wiederverwendet werden kann: `err := x^2/sqrt(y)`.\
  Partielle Ableitungen einzeln bestimmen, #tr-constructs-button drücken und $|square.stroked.dotted|$ auswählen.
  Die Partielle Ableitung kann von oben mit "Enter" kopiert werden. Delta einsetzen.
  Wiederholen, bis alle Variablen abgedeckt sind. Hinter der Rechnung können Variablen mit `| x=2 and y=3` substituiert werden.
]

*Beispiel:*
#example-block[
  $"Gegeben:" space x = 2.0 plus.minus 0.1, quad space y = 4.0 plus.minus 0.5, quad space f = x^2/sqrt(y)$
  #grid(
    columns: (1fr, 1.1fr),
    [
      + $f$ partiell ableiten und in $Delta f$ einfügen
      + Werte ohne Messfehler ($x,y$) und Messfehler ($Delta x, Delta y$) in $Delta f$ einfügen
      + Ausrechnen
      + $f$ ausrechnen und Messfehler bilden

      #image("img/tr_fehlerfortpfl.png")
    ],
    $
            1) space Delta f & = abs((delta f)/(delta x)) dot Delta x + abs((delta f)/(delta y)) dot Delta y \
                       space & = abs((2x)/sqrt(y)) dot Delta x + abs(x^2/(2 sqrt(y^3))) dot Delta y \
            2) space Delta f & = abs((2 dot 2.0)/sqrt(4.0)) dot 0.1 + abs(2.0^2/(2 sqrt(4.0^3))) dot 0.5 \
            3) space Delta f & = 0.2 + 0.125 = 0.325 \
      4) quad space.narrow f & = 2.0^2/sqrt(4.0) = 2 quad => quad underline(2 plus.minus 0.325)
    $,
  )
]

=== Fehlerfortpflanzung für statistische Fehler <statistische-fehlerrechnung>
Bei statistischen Fehlern wird aus mehreren Messungen $x_1 .. x_n$ ein _Mittelwert $bold(dash(x))$_ und die
_Standardabweichung $bold(sigma)$_ errechnet. Bei genügend Messungen kann von einer Normalverteilung ausgegangen werden.

Die _Standardunsicherheit $bold(Delta x)$_ ist die Standardabweichung des Mittelwerts. Mit ihr können wir behaupten,
dass der tatsächliche Wert sich mit einer _Wahrscheinlichkeit von $bold(68%)$_ im Intervall
$(dash(x) - Delta x; dash(x) + Delta x)$ befindet.

#definition(
  table(
    columns: (1fr, 1.4fr, 1.1fr),
    align: horizon,
    table.header([Mittelwert], [Standardabweichung], [Standardunsicherheit]),
    $ dash(x) = 1/n dot sum_(i=1)^n x_i $,
    $ sigma = sqrt(1/(n - 1) dot sum_(i=1)^n (x_i - dash(x))^2) $,
    $ Delta x = sigma/sqrt(n) $,
  ),
)


= Kinematik
Die Kinematik beschreibt _Bewegungen von Objekten im Raum_. Dabei sind die _Position_, die _Geschwindigkeit_, die
_Beschleunigung_ und die _benötigte Zeit_ des Objekts wichtig.

*Begriffe*
- _Teilchen:_ Objekte werden in der Kinematik häufig auf einen einzelnen Punkt reduziert, in welchem die Struktur des
  Objekts keine Rolle mehr spielt. Jedes Objekt wird also sozusagen auf ein Atom reduziert. Das Teilchen repräsentiert
  oft den Schwerpunkt des Objekts.
- _Bewegung in der Ebene:_ Einschränkung der Bewegung eines Teilchens auf zwei Dimensionen.
- _Ort des Teilchens:_ Position, an welcher sich das Teilchen befindet. In einer Dimension gleichbedeutend mit der
  zurückgelegten Strecke. Meist in Meter angegeben.

*Einheiten der Kinematik*
#v(-0.75em)
#table(
  columns: (1fr, 1fr, auto, 1fr),
  align: center + horizon,
  table.header([Basisgrösse], [Variable], [Masseinheit], [Basiswert]),
  [Position], $hk(r)$, [Meter], $1"m"$,
  [Zeit], $t$, [Sekunde], $1"s"$,
  [Geschwindigkeit], $hk(v) = dot(hk(r))$, [Meter pro Sekunde], $1"m"\/"s"$,
  [Beschleunigung], $hk(a) = dot(hk(v)) = dot.double(hk(r))$, [Meter pro Sekunde hoch 2], $1"m"\/"s"^2$,
)

== Vektoren und Koordinaten
Die Position eines Teilchens in der Ebene wird als $x$- und $y$-Koordinate angegeben. Diese werden oft zu einem
_Ortsvektor $bold(hk(r))$_ zusammengefasst. Analog wird die Position im dreidimensionalen Raum mit einer zusätzlichen
$z$-Koordinate angegeben.
$
  x = 2, quad y = 1\
  hk(r) = 2 hat(x) + 1 hat(y) = vec(2, 1) = mat(2, 1)
$

Die mit Hut versehenen Symbole sind _Einheitsvektoren_. Bei ihnen ist die jeweilige Komponente auf $1$ gesetzt, während
alle anderen $0$ sind. Einheitsvektoren können mithilfe des Betrags des Vektors bestimmt werden.

#grid(
  align: center + horizon,
  $
    hat(x) = vec(1, 0, 0), space
    hat(y) = vec(0, 1, 0), space
    hat(z) = vec(0, 0, 1)
  $,
  $ hat(hk(r)) = hk(r)/(abs(hk(r))) $,
)

== Bahn eines Teilchens <bahn-teilchen>
Die _Länge eines Vektors $bold(abs(hk(r)))$_ wird mit dem Pythagoras berechnet.
Damit ist es möglich, den _Abstand zwischen zwei Teilchen_ zu erhalten.
$
  abs(hk(r)) = sqrt(r_x^2 + r_y^2 + r_z^2)\
  abs(hk(r_1) - hk(r_2)) = abs(hk(r_2) - hk(r_1))
  = sqrt((r_(1, x) - r_(2, x))^2 + (r_(1, y) - r_(2, y))^2 + (r_(1, z) - r_(2, z))^2)
$

Um die Bewegung eines Teilchens zu beschreiben, wird der Begriff _Bahn $bold(hk(r)(t))$_ verwendet.
Die Funktion ordnet dem Teilchen zu jedem Zeitpunkt $t$ seine Position zu.
Mit der Startposition $hk(r)_A$ und der Endposition $hk(r)_E$ kann der _Verschiebungsvektor $bold(Delta hk(r))$_
gebildet werden, welcher die Verschiebung des Teilchens #hinweis[(Luftlinie)] anzeigt.\
Die totale Distanz kann dann mithilfe des Betrags des Verschiebungsvektors gebildet werden.
#grid(
  $ Delta hk(r) = hk(r)_E - hk(r)_A $,
  $ abs(Delta hk(r)) = abs(hk(r)_E - hk(r)_A) $,
)

=== Position auf Kreis
#{
  let (cos-sin, sin-cos) = position-auf-kreis(30deg)
  grid(
    align: center,
    cos-sin,
    sin-cos,
  )
}

#grid(
  [
    *Beispiel: Bewegung auf dem Kreis*\
    Die Bewegung auf dem Einheitskreis kann mit Sinus und Cosinus dargestellt werden.
    Ist der _Cosinus oben_, startet die Bewegung von der _$bold(x)$-Achse_ aus.
    Wenn der _Sinus oben_ ist, startet sie von der _$bold(y)$-Achse_ aus.

    $ hk(r)(t) = vec(cos(t), sin(t)) $

    In einer _halben Umrundung_ legt das Teilchen eine Distanz von $abs(hk(r)) = 2$ zurück, indem es sich um 2 Einheiten
    gegen die \ $x$-Richtung verschiebt.
  ],
  bewegung-auf-kreis(),
)
#v(-0.5em)
$ Delta hk(r) = vec(cos(pi), sin(pi)) - vec(cos(0), sin(0)) = vec(-1, 0) - vec(1, 0) = vec(-2, 0) $

Nach einer _ganzen Umdrehung_ ist das Teilchen wieder am Ausgangspunkt.
$ Delta hk(r)(0) = Delta hk(r)(2 pi) = vec(0, 0) $

== Geschwindigkeit eines Teilchens
Die Geschwindigkeit ist die Strecke pro Zeit und kann mithilfe der Start-/End-Position des Teilchens und der
Start-/Endzeit ausgerechnet werden.
Dadurch erhält man den _mittleren Geschwindigkeitsvektor $bold((Delta hk(r))/(Delta t))$_.

#definition[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    $ hk(v)_(0 -> 1) = dot(hk(r)) = (Delta hk(r))/(Delta t) = (hk(r)_1 - hk(r)_0)/(t_1 - t_0) $,
    [
      _$bold(hk(v)_(0 -> 1))$_: Geschwindigkeit zw. Zeitpunkt 0 und 1\
      _$bold(hk(r)_0\, hk(r)_1)$_: Position zum Zeitpunkt 0/1\
      _$bold(t_0\, t_1)$_: Vergangene Zeit zum Zeitpunkt 0/1
    ],
  )
]

Um die _Geschwindigkeit zum Zeitpunkt $bold(t)$_ zu erhalten, die sogenannte _Momentangeschwindigkeit $bold(hk(v)(t))$_,
wird die Position nach der Zeit abgeleitet.

#definition[
  #grid(
    columns: (1fr, auto),
    $ hk(v)(t) = dif/(dif t) hk(r)(t) = dot(hk(r))(t) $,
    [
      _$bold(hk(v)(t))$_: Momentangeschwindigkeit zum Zeitpunkt $t$\
      _$bold(dot(hk(r))(t))$_: Erste Ableitung der Position (Ortsvektor)
    ],
  )
]

Um den _Betrag der Momentangeschwindigkeit_ $hk(v) = vec(v_x, v_y)$ zu berechnen, was der Anzeige der Tachometers
entspricht, wird der Satz des Pythagoras verwendet. Die $x$- und $y$-Komponenten bilden den resultierenden Vektor
#hinweis[(Hypothenuse)].

#definition[$ abs(hk(v)) = sqrt(v^2_x + v^2_y) $]

=== Umwandlung der Momentangeschwindigkeit
Mit der Momentangeschwindigkeit $hk(v)$ und einem Ortsvektor $hk(r)_A$ kann die _Position $bold(hk(r))$_
zum Zeitpunkt $t$ ermittelt werden.
#definition[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    $ hk(r)(t) = hk(r)_A + integral^t_(t_A) hk(v)(t) dif t $,
    [
      _$bold(hk(r)(t))$:_ Position des Teilchens zum Zeitpunkt $t$\
      _$bold(hk(r)_A)$_: Position des Teilchens zu einem anderen Zeitpunkt\
      _$bold(hk(v)(t))$:_ Momentangeschwindigkeit
    ],
  )
]

Die Momentangeschwindigkeit $hk(v)(t)$ kann in den mittleren Geschwindigkeitsvektor $(Delta hk(r))/(Delta t)$
_umgewandelt_ werden.
#definition[
  #grid(
    align: horizon,
    $ (Delta hk(r))/(Delta t) = 1/(t_E - t_A) dot integral^(t_E)_(t_A) hk(v)(t) dif t $,
    [
      _$bold(t_E - t_A)$:_ Zeitdifferenz zwischen Start-/Endpunkt ($Delta t$)
    ],
  )
]

*Beispiel: Momentangeschwindigkeit am Kreis*
#v(-0.5em)
#grid(
  columns: (1.3fr, auto),
  align: (x, _) => if (x == 1) { center } else { auto },
  [
    #example-block[
      _Ein Teilchen bewegt sich entlang der Bahnkurve \ $hk(r)(t) = vec(cos(t), sin(t))$.
      Bestimmen Sie die Momentangeschwindigkeit des Teilchens zum Zeitpunkt $t$._
    ]
    $
      hk(v)(t) = dot(r)(t) = dif/(dif t) vec(cos(t), sin(t)) = underline(vec(-sin(t), cos(t)))
    $

    Der Geschwindigkeitsvektor weist tangential an den Kreis. Er zeigt genau in die Richtung, in die sich das Teilchen
    zur Zeit $t = pi/2$ bewegt. Die Länge des Pfeils entspricht dabei seiner Geschwindigkeit.
  ],
  momentangeschwindigkeit-kreis(),
)

*Beispiel: Teilchenposition am Kreis*
#v(-0.5em)
#example-block(
  grid(
    align: horizon,
    [
      _Ein Teilchen befindet sich zum Zeitpunkt $t = 0$ im Punkt $hk(r) = vec(1, 0)$.
      Es bewegt sich mit einer Momentangeschwindigkeit von\ $hk(v) = vec(-sin(t), cos(t))$.
      Wo befindet sich das Teilchen zum Zeitpunkt $t = pi/2$ (Viertelumdrehung)?_

      Der gegebene Vektor $hk(r)$ wird als $hk(r)_A$ in die Formel eingesetzt. Die Momentangeschwindigkeit wird
      zwischen $0$ und $pi/2$ integriert, um die Teilchenposition bei einer Viertelumdrehung zu erhalten:
      Es befindet sich an der Position $x = 0, y = 1$.
    ],
    $
         hk(r)(t) & = hk(r)_A + integral^t_(t_A) hk(v)(t) dif t \
      hk(r)(pi/2) & = vec(1, 0) + integral^(pi/2)_0 vec(-sin(t), cos(t)) dif t \
                  & = vec(1, 0) + vec(cos(pi / 2) - cos(0), sin(pi / 2) - sin(0)) \
                  & = vec(1, 0) + vec(0 - 1, 1-0) = underline(vec(0, 1))
    $,
  ),
)

=== Skalare Geschwindigkeit
Für Strecken-Berechnungen reicht eine _skalare Geschwindigkeit_, eine eindimensionale Angabe ohne Vektor.
Sie ist der _Betrag der Momentangeschwindigkeit_ und wird auch als $v$ #hinweis[(ohne Vektorpfeil)] geschrieben.
#definition[
  $ abs(hk(v)(t)) = abs(dot(hk(r))(t)) = sqrt((dot(r)_x)^2 + (dot(r)_y)^2 + (dot(r)_z)^2) $
]

Dagegen ist der Betrag der mittleren Geschwindigkeit $abs((Delta hk(r))/(Delta t))$ quasi nutzlos.
Viel wichtiger ist der _Durchschnitt des Betrags der Momentangeschwindigkeit_.
Sie gibt die _skalare Durchschnittsgeschwindigkeit_ an -- das, was wir unter Durchschnittsgeschwindigkeit verstehen.

#definition[
  $ abs(hk(v)) dif t = 1/(t_B - t_A) integral^(t_B)_(t_A) abs(dot(r)(t)) dif t $
]

Ist die _Momentangeschwindigkeit_ _konstant_, ist sie gleich der _Durchschnittsgeschwindigkeit_.
Bewegt sich daher ein Teilchen zu jedem Zeitpunkt mit $3 "m"\/"s"$, ist auch die Durchschnittsgeschwindigkeit $3 "m"\/"s"$.

*Beispiel: Geschwindigkeit auf dem Kreis*\
#example-block[
  _Ein Teilchen bewegt sich entlang der Bahnkurve $hk(r)_t = vec(cos(t), sin(t))$ und weist die
  Momentangeschwindigkeit $dot(r)(t) = vec(-sin(t), cos(t))$ auf._

  _a) Bestimmen sie die skalare Geschwindigkeit._

  $ abs(hk(v)(t)) = abs(vec(-sin(t), cos(t))) = sqrt((-sin(t))^2 + (cos(t))^2) = sqrt(1) = underline(1) $
  Das Teilchen vollführt pro Zeiteinheit eine Umdrehung auf der Kreisbahn.

  _b) Bestimmen Sie die Durchschnittsgeschwindigkeit im Zeitintervall $[0; 2pi]$._

  $ abs(hk(v)) dif t = 1/(2pi - 0) integral^(2pi)_0 1 dif t = 1/(2pi) dot 2pi = underline(1) $
  Das Teilchen bewegt sich immer mit einer Geschwindigkeit von $1$, die Durchschnittsgeschwindigkeit ist also auch $1$.

  _c) Bestimmen Sie den mittleren Geschwindigkeitsvektor in dieser Zeit._
  $
    Delta hk(r) = hk(r)(2pi) - hk(r)(0) = vec(cos(2pi), sin(2pi)) - vec(cos(0), sin(0)) = vec(1, 0) - vec(1, 0) = vec(0, 0)\
    (Delta hk(r))/(Delta t) = vec(0, 0)/(2pi) = underline(vec(0, 0))\
  $
  Da die Anfangsposition gleich der Endposition ist, hat sich aus dieser Sicht keine Bewegung stattgefunden.
]

== Beschleunigung eines Teilchen
Die Beschleunigung $hk(a)(t)$ misst die _Änderung der Momentangeschwindigkeit_.
Es gibt zwei Gründe, wieso sich die Beschleunigung ändern kann:
+ _Betrag_ der Momentangeschwindigkeit ändert sich #hinweis[(Beschleunigen/bremsen)]
+ _Richtung_ der Momentangeschwindigkeit ändert sich #hinweis[(Bewegungsrichtung ändert sich, z.B. Fliehkraft)]

Die Basiseinheit der Beschleunigung ist $"m"\/"s"^2$. Das lässt sich einfach erklären: Geschwindigkeit misst die Meter
pro Sekunde, die Beschleunigung wie stark sich diese "Meter pro Sekunde" pro Sekunde verändern:
$("m"\/"s")/"s" = "m"/"s"^2$.

#definition[
  #grid(
    columns: (1fr, auto),
    $ hk(a)(t) = dif/(dif t) hk(v)(t) = dot(hk(v)) = dot.double(hk(r)) $,
    [
      _$bold(dot(hk(v)))$_: Erste Ableitung der Geschwindigkeit\
      _$bold(dot.double(hk(r)))$:_ Zweite Ableitung der Position #hinweis[(Ortsvektor)]
    ],
  )
]


= Bewegungen
#v(-0.5em)
== Gleichförmge Kreisbewegungen <gleichförmige-kreisbewegung>
Wenn sich ein Teilchen mit einer konstanten Geschwindigkeit #hinweis[(der Winkel wächst linear an, eine _konstante
  Winkelgeschwindigkeit_)] auf einer Kreisbahn bewegt, ist es eine _gleichförmige Kreisbewegung_.
Für eine sich ändernde Winkelgeschwindigkeit, siehe @ungleichförmige-kreisbewegung.

Die Formel unten wird verwendet, um die _Bahnkurve einer gleichförmigen Kreisbewegung_ zu berechnen, siehe @bahn-teilchen.
Die _Winkelgeschwindigkeit $bold(omega)$_ #hinweis[(auch Kreisfrequenz genannt)] gibt an, wie lange eine Umdrehung
im Verhältnis dauert #hinweis[($omega = 2$: Teilchen macht 2 Umdrehungen pro Zeit)].
Die _Phase $bold(phi)$_ gibt den Winkel an, wo auf dem Kreis die Bewegung begonnen wird.
Häufig wird beim Punkt $vec(R, 0)$ gestartet; hier ist der Winkel $phi = 0°$.

#definition(
  grid(
    columns: (1fr, auto),
    align: horizon,
    $
      hk(r)(t) = R dot vec(cos(omega dot t + phi_0), sin(omega dot t + phi_0))\
      omega = (2pi)/T
    $,
    [
      _$bold(R)$:_ Radius des Kreises\
      _$bold(omega)$:_ Winkelgeschwindigkeit im Bogenmass\
      _$bold(phi_0)$:_ Winkel des Teilchens bei $t = 0$ #hinweis[(Phase)] \
      _$bold(T)$:_ Anzahl Umdrehungen pro Zeit #hinweis[(Umlaufdauer)]
    ],
  ),
)

Befindet sich das Teilchen auf einem _Einheitskreis_ #hinweis[(Radius = 1)], vereinfacht sich die Gleichung.

#definition(
  grid(
    columns: (1fr, 1.35fr),
    align: horizon,
    $ hk(r)(t) = vec(cos(t), sin(t)) $,
    [
      Im Einheitskreis ist immer $R = 1$.\
      Eine Umrundung findet immer in einer Zeiteinheit statt, darum $omega = 1$. Das
      Teilchen startet auch meist bei 0°, also $phi_0 = 0$.
    ],
  ),
)

Die Frequenz gibt die Anzahl Drehungen pro Sekunde an.
#definition(
  grid(
    align: horizon,
    $ f = 1/T $,
    [
      _$bold(f)$:_ Frequenz, Einheit Herz ($1"Hz"$)
    ],
  ),
)

#pagebreak()

#grid(
  align: (x, _) => if (x == 1) { center + horizon } else { auto },
  [
    Insgesamt gilt, dass sowohl die _konstante Geschwindigkeit_, als auch die Beschleunigung mit der
    _Winkelgeschwindigkeit_ zusammenhängen. Die Beschleunigung _weist zum Kreiszentrum hin_.

    $ v = R dot omega quad quad quad hk(a) = -omega^2 dot hk(r) $

    *Beispiel:* Wirbelt man ein Stein an einer Schnur in der Luft, zieht ihn die Beschleunigung auf diese Kreisbahn
    zurück. Lässt man los, wirkt keine Beschleunigung mehr und der Stein fliegt in Richtung $v$.
  ],
  kreis-beschleunigung(),
)

*Beispiel: Beschleunigung am Fahrrad*\
#example-block[
  _Sie fahren mit dem Fahrrad auf einem Kreis mit Radius $R = 5.0"m"$ mit konstanter (skalarer) Geschwindigkeit
  $v = 5.0"m"/"s"$._

  _Finden Sie eine Formel für die Bahnkurve des Fahrrads $hk(r)(t)$ wenn $r(0) = vec(5, 0)$._
  #grid(
    columns: (1fr, auto),
    [
      + Formel für gleichmässige Kreisbewegung aufstellen.
      + Da $sin(t)/cos(t) = tan(t)$ kann mit den Koordinaten von $r(0)$ der Winkel $phi$ über $arctan$ ausgerechnet
        werden. Dieser ist in diesem Fall 0, da der Punkt auf der $x$-Achse liegt.
      + Die Formel von 1) kann nun vereinfacht werden.
      + Eine Gleichung kann aufgestellt werden: Die gegebene Geschwindigkeit $v$ entspricht dem Betrag der
        Momentangeschwindigkeit $abs(hk(v))$, was wiederum der Ableitung der gesuchten Bahnkurven-Formel $hk(r)(t)$
        entspricht.
      + Um $dot(r)$ zu erhalten, muss die Formel aus 3) abgeleitet werden. Achtung Kettenregel bei $omega$!
      + $omega$ ausklammern und Betrag berechnen. $sin^2 + cos^2$ gibt immer 1.
      + In die Gleichung von 4) kann jetzt $abs(dot(r))$ eingesetzt werden. Nach $omega$ auflösen.
    ],
    $
      1) & space hk(r)(t) = R dot vec(cos(omega dot t + phi_0), sin(omega dot t + phi_0)) \
      2) & space phi = arctan((r_y (0))/(r_x (0))) \
        & space phi = arctan(0/5) = 0 \
      3) & space hk(r)(t) = 5"m" dot vec(cos(omega dot t), sin(omega dot t)) \
      4) & space abs(dot(r)) = abs(hk(v)) = v = 5.0"m"/"s" \
      5) & space dot(r) = (dif hk(r))/(dif t) = 5"m" vec(-sin(omega dot t) dot omega, cos(omega dot t) dot omega) \
      6) & space abs(dot(r)) = 5"m" dot omega dot sqrt(sin^2(omega t) + cos^2(omega t)) \
        & space abs(dot(r)) = 5"m" dot omega dot 1 \
      7) & space 5"m" dot omega = 5.0"m"/"s" space => space omega = (5.0"m"/"s")/(5"m") = 1/"s" \
      8) & space hk(r)(t) = underline(5"m" dot vec(cos(t dot 1/"s"), sin (t dot 1/"s")))
    $
  )
  #v(-0.5em)
  8. Einsetzen in $hk(r)(t)$. Der Cosinus und Sinus haben in dieser Formel die Einheit Sekunde erhalten.

  _Bestimmen sie die Beschleunigung, welche auf das Fahrrad wirkt._
  #grid(
    [
      + Bahnkurve aus dem oberen Aufgabenteil ableiten, um die Geschwindigkeit zu erhalten.
        Durch das $omega = 1/s$ gilt die Kettenregel, die Sekunde wird aus dem Vektor herausgenommen!
      + Durch eine zweite Ableitung wird die Geschwindigkeitsformel erhalten.
        Auch hier wird durch die Kettenregel die Sekunde erneut herausgezogen.
    ],
    $
               hk(r)(t) & = 5"m" dot vec(cos(t dot 1/"s"), sin(t dot 1/"s")) \
      1) space hk(v)(t) & = dot(hk(r))(t) = 5 "m"/"s" dot vec(-sin(t/"s"), cos(t/"s")) \
      2) space hk(a)(t) & = dot(hk(v))(t) = underline(5 "m"/"s"^2 dot vec(-cos(t/"s"), -sin(t/"s")))
    $,
  )
]

== Ungleichförmige/Allgemeine Kreisbewegung <ungleichförmige-kreisbewegung>
Ändert sich die Winkelbeschleunigung während der Bewegung, ist sie ungleichförmig.
Sie verwendet eine allgemeinere Formel als die gleichförmige Kreisbewegung.

#definition(
  grid(
    $ hk(r)(t) = r dot vec(cos phi(t), sin phi(t)) $,
    [
      _$bold(r)$:_ Kreisradius\
      _$bold(phi(t))$:_ Aktueller Winkel\
    ],
  ),
)

Die Geschwindigkeit der gleichförmigen Kreisbewegung, die _Bahngeschwindigkeit $bold(v)$_, zeigt nur an,
wie schnell sich das Teilchen bewegt, aber nicht in welche Richtung.

#definition(
  grid(
    columns: (1fr, auto),
    align: horizon,
    $ v = r dot dot(phi)(t) = r dot omega $,
    [
      _$bold(r)$:_ Position des Teilchens auf dem Kreis\
      _$bold(omega)$:_ Winkelgeschwindigkeit\
      _$bold(dot(phi)(t))$:_ Erste Ableitung der Winkelfunktion
    ],
  ),
)

Der _Geschwindigkeitsvektor $bold(hk(v)(t))$_ zeigt an, in welche Richtung und wie schnell sich ein Teilchen
auf der Kreisbahn bewegt.

#definition(
  grid(
    columns: (1fr, auto),
    align: horizon,
    $ hk(v)(t) = r dot dot(phi)(t) dot vec(-sin phi(t), cos phi(t)) $,
    [
      _$bold(r)$:_ Kreisradius\
      _$bold(phi(t))$:_ Aktueller Winkel im Bogenmass\
      _$bold(dot(phi)(t))$:_ Erste Ableitung der Winkelfunktion
    ],
  ),
)

*Beispiel:*\
#example-block[
  _a) Wie lautet die Bahn eines Teilchens $hk(r)(t)$, das sich mit konstanter Geschwindigkeit $v$ entlang einer
  Kreisbahn bewegt?_

  #grid(
    [
      + Die Geschwindigkeitsformel wird nach $dot(phi)(t)$ umgestellt.
      + Integrieren der Formel im Grenzbereich $[0, t]$. Um den Anfangswinkel zu berücksichtigen, $phi(0)$ zum Integral
        dazurechnen.
      + $phi(0)$ kann jetzt als Anfangswert $phi_0$ bezeichnet werden.
      + Einfügen in die Bahnformel

      Die resultierende Formel ist nun gleich der Bahnkurvenformel der gleichförmigen Kreisbewegung:
      $omega = v/r = (2pi)/T$.
    ],
    $
      1) & space dot(phi)(t) = v/r \
      2) & space phi(t) = phi(0) + integral_0^t v/r dif t \
          & space phi(t) = phi(0) + v/r dot t \
      3) & space phi(0) = phi_0 \
      4) & space hk(r)(t) = r dot vec(cos phi (t), sin phi (t)) \
          & space hk(r)(t) = underline(r dot vec(cos(phi_0 + v/r dot t), sin(phi_0 + v/r dot t)))
    $
  )

  #colbreak()

  _b) Bestimmen Sie die Beschleunigung dieses Teilchens. In welche Richtung weist die Beschleunigung und welchen Betrag
  hat sie?_

  #grid(
    columns: (1fr, auto),
    [
      + Formel aus oberem Aufgabenteil ableiten, die $r$'s kürzen sich weg.
      + Neue Formel nochmal ableiten.\ $v/r$ ausklammern ergibt $v dot v/r = v^2/r$.
      + Betrag der Beschleunigung bestimmen. Der Betrag des Vektors berechnet sich über Pythagoras: \
        $ sqrt(cos(phi_0 + v/r dot t)^2 + sin(phi_0 + v/r dot t)^2) $
        Da $cos^2 + sin^2$ immer $1$ ergibt, fällt der Term weg.
    ],
    $
      1) &space dot(hk(r))(t) = dif/(dif r) (r dot vec(cos(phi_0 + v/r dot t), sin(phi_0 + v/r dot t))) \
      &space dot(hk(r))(t) = cancel(r) dot v/cancel(r) dot vec(-sin(phi_0 + v/r dot t), cos(phi_0 + v/r dot t))\
      2) &space dot.double(hk(r))(t) = dif/(dif r) (v dot vec(-sin(phi_0 + v/r dot t), cos(phi_0 + v/r dot t))) \
      &space dot.double(hk(r))(t) = v dot v/r dot vec(-cos(phi_0 + v/r dot t), -sin(phi_0 + v/r dot t)) \
      3) &space abs(dot.double(hk(r))(t)) = abs(v^2/r) dot abs(vec(cos(phi_0 + v/r dot t), sin(phi_0 + v/r dot t))) = underline(v^2/r)
    $,
  )
]
_Die Beschleunigung zeigt immer zum Mittelpunkt des Kreises._

== Gleichförmige Bewegung
Die gleichförmige Bewegung ist ein _Spezialfall der gleichmässigen beschleunigten Bewegung_, bei welcher
_keine Beschleunigung_ herrscht. Die Geschwindigkeit ist also _konstant_.

#definition[
  #grid(
    columns: (1fr,) * 3,
    align: horizon,
    $ hk(a) = 0 $, $ hk(v)(t) = hk("const") $, $ hk(r)(t) = hk(r)_0 + v_0 dot t $,
  )
]

== Gleichmässig beschleunigte Bewegung
In einer gleichmässigen beschleunigten Bewegung ist die Beschleunigung eines Teilchens _konstant_.
Dadurch können wir die Geschwindigkeit und Bahnbewegungen durch _Stammfunktionen_ erhalten.
Diese sind in der Definition unten bereits aufgelöst. Dabei ist $Delta t = t - t_0$, wobei häufig $t_0 = 0$.\
Ist die _Beschleunigung negativ_ #hinweis[(z.B. Abbremsen)], wird sie auch _gleichmässig verzögerte Bewegung_ genannt.

#definition[
  #grid(
    columns: (1fr, 1fr, 1.8fr),
    align: horizon,
    $ hk(a) = hk("const") $,
    $ hk(v)(t) = v_0 + hk(a) dot Delta t $,
    $ hk(r)(t) = hk(r)_0 + v_0 dot Delta t + 1/2hk(a) dot (Delta t)^2 $,
  )
]
#v(-0.25em)
=== Eindimensionale gleichmässig beschleunigte Bewegung
Wenn die gleichmässige beschleunigte Bewegung _nur in einer Dimension stattfindet_, können vereinfachte Formeln
verwendet werden. Bei eindimensionalen Rechnungen wird anstatt $r$ oft die Variable $h$ für Höhe verwendet.\
*Beispiele:* freier Fall #hinweis[(ohne Luftwiderstand)], Brems- und Beschleunigungen von Fahrzeugen.\
#hinweis[(Wenn nur eine Geschwindigkeit gegeben ist, z.B. beim Abbremsen auf 0, $v_0$ bzw. $v_0 dot t$ weglassen)]

#definition[
  #grid(
    columns: (1fr,) * 3,
    align: horizon,
    $ a = (v - v_0)/t = v^2/(2 dot s) $, $ v = v_0 + a dot t $, $ s = v_0 dot t + 1/2 dot a dot t^2 $,
  )
]

== Schiefer Wurf
#grid(
  columns: (1fr, auto),
  [
    Der Schiefe Wurf ist ein Spezialfall der gleichmässigen beschleunigten Bewegung. Dabei wird ein _Teilchen mit einer
    Anfangsgeschwindigkeit $bold(hk(v)_0)$ geworfen_ und der Luftwiderstand vernachlässigt.

    Die Bahnkurve verwendet dabei diesselbe Formel wie oben, nur dass $hk(a) = hk(g)$, da die einzige Beschleunigung die
    Schwerkraft ist. Die Schwerkraft wirkt auf der $y$-Achse und ist negativ, da sie nach unten zeigt.
  ],
  schiefer-wurf(),
)

#definition[
  #grid(
    align: horizon,
    $
      hk(r)(t) = hk(r)_0 + hk(v)_0 dot t + 1/2 dot hk(g) dot t^2\
      hk(g) = vec(0, -9.81 plus.minus 0.03) "m"/"s"^2 \
      hk(v_0) = v_0 dot vec(cos(alpha), sin(alpha))
    $,
    [
      _$bold(hk(r_0))$:_ Startposition, oft $vec(0, y_0)$\
      _$bold(hk(v_0))$:_ Anfangsgeschwindigkeit\
      _$bold(t)$:_ Zeit\
      _$bold(hk(g))$:_ Schwerkraft\
      _$bold(alpha)$:_ Wurfwinkel\
    ],
  )
]

Beim Schiefen Wurf wird die Anfangsposition $hk(r)_0$ oft auf die $y$-Achse gesetzt.
Auch wird häufig der Wurfwinkel angegeben, womit die Geschwindigkeit berechnet werden kann.
Die Anfangsgeschwindigkeit $v_0$ kann auch als skalare Geschwindigkeit angegeben werden, um eine einzige Zahl für
die Geschwindigkeit zu erhalten.

$ v_0 = abs(hk(v)) = sqrt((v_(0, x))^2 + (v_(0, y))^2) $


Teilt man die $x$- und $y$-Komponenten in eigene Formel auf, erkennt man:
$
  x(t) & = v_0 dot cos(alpha) dot t quad     & => & quad "Geschwindigkeit ist konstant" \
  y(t) & = y_0 + v_0 dot sin(alpha) - g quad & => & quad "Zieht Teilchen nach unten"
$

Wird nach der _Wurfparabel_ #hinweis[($y(x)$-Funktion)] gefragt, lautet diese
$
  y(x) = overbracket(y_0 + tan(alpha_0) dot x, "Steigung auf Gerade")
  - overbracket(g/(2 dot v_0^2 dot cos^2(alpha_0)) dot x^2, "Gravitation zieht nach unten")
$
#v(-0.25em)
Daraus wird die _Wurfweite_ berechnet. Sie ist die Distanz in $x$-Richtung, bis das Objekt wieder auf Ausgangshöhe ist.
Ein Ball fliegt am weitesten, wenn er schnell geworfen wird #hinweis[($display(lim_(v -> infinity))$)] und der Winkel
möglichst 45° ist #hinweis[($sin(2alpha_0) = 1$)]. Die Wurfweite kann auch bestimmt werden, wenn statt des Winkels die
Geschwindigkeiten in $x$ und $y$-Richtung oder die Wurfdauer bekannt sind.

#v(-0.25em)
$
  x_1 = v_0^2/g dot sin(2 dot alpha_0) quad quad
  x_1 = (2 dot v_(0, x) dot v_(0,y))/(g) quad quad
  x_1 = v_(0, x) dot t
$
#v(-0.25em)

#grid(
  columns: (3fr, 1fr),
  align: horizon,
  [
    Die _maximale Höhe_ des Wurfs $h_"max"$ wird über die Ausgangsgeschwindigkeit $v_0$ und der doppelten Gravitation
    $g$ berechnet.
    #hinweis[(Umstellen nach $v_0$ liefert nur die $y$-Komponente, die $x$-Komponente muss separat berechnet werden!)]
  ],
  $ h_"max" = v_0^2/(2 dot g) $,
)

#colbreak()

*Beispiel*\
#example-block[
  _Ein Cabrio-Fahrer fährt mit $36"km"/"h" = 10"m"/"s"$ auf einer flachen, geraden Strasse. Während dieser Fahrt wirft
  er einer Apfel mit $18"km"/"h" = 5"m"/"s"$ senkrecht nach oben. Wie gross ist die Reichweite dieses Wurfes?_

  #grid(
    [
      + Die Anfangsgeschwindigkeit $v_0$ des Schiefen Wurfs ist bereits in seine Komponenten zerlegt.
      + Die Strecken-Formel ebenfalls in $x$ und $y$ Komponenten zerlegen.
        Da $hk(r)_0 = 0$, können wir diesen Teil weglassen.
      + Uns interessiert, wenn $y = 0$. Dann ist der Apfel wieder auf Ausgangshöhe.
        Dazu setzen wir die $y$-Komponente der Streckenformel auf $0$.
      + Auflösen nach $t$ und einsetzen
      + Einsetzen in Wurfweite-Formel
    ],
    $
      1) & space v_(0, x) = 10"m"/"s", quad v_(0, y) = 5"m"/"s" \
      2) & space hk(r)(t) = vec(v_(0, x), v_(0, y)) dot t + 1/2 dot vec(0, -g) dot t^2 \
      3) & space 0 = v_(0, y) dot t + 1/2 dot -g dot t^2 \
      4) & space t = (2 dot v_(0, y))/g = (2 dot 5"m"/"s")/(9.81"m"/"s"^2) = 1.02"s" \
      5) & space x_1 = v_(0, x) dot t = 10 "m"/"s" dot 1.02"s" = underline(10.2"m")
    $,
  )
]

*Übersicht Schiefer Wurf*
#v(-0.75em)
#table(
  columns: (1fr, 1fr, 1.2fr),
  align: horizon,
  table.header([Äussere Kraft], [Bewegungsgleichung], [Allgemeine Lösung]),
  $
    hk(F) = m dot hk(g)\
    hk(g) = vec(0, -g)
  $,
  $
    m dot dot.double(hk(r)) = m dot hk(g)\
    g = (9.81 plus.minus 0.03) "m"/"s"^2
  $,
  $
    hk(r)(t) = r_0 + v_0 dot t + 1/2 dot hk(g) dot t^2\
    hk(v)(t) = hk(v)_0 + hk(g) dot t
  $,
)

=== Freier Fall
Der Freie Fall ist ein Speziallfall des Schiefen Wurfs. Das Teilchen bewegt sich dabei ausschliesslich nach oben/unten
#hinweis[(2D: $y$-Achse, 3D: $z$-Achse)], weswegen auch eindimensional #hinweis[(ohne Vektoren)] gerechnet werden kann.

#definition(
  grid(
    align: horizon,
    $ h(t) = h_0 + v_0 dot t + 1/2g dot t^2 $,
    [
      _$bold(h_0)$:_ Anfangshöhe\
      _$bold(v_0)$:_ Anfangsgeschwindigkeit\
      _$bold(t)$:_ Vergangene Zeit\
      _$bold(g)$:_ Schwerkraft
    ],
  ),
)

=== Waagrechter Wurf
Der Waagrechte Wurf ist ein weiterer Spezialfall des schiefen Wurfs. Dabei wird ein Körper nicht nach oben, sondern nur
nach vorne geworfen. Ohne Reibung sind $x$ und $y$-Position voneinander unabhängig: $x$ ist eine gleichförmige Bewegung,
$y$ ein freier Fall.

#grid(
  columns: (1fr, auto),
  align: horizon,
  [
    #definition[
      $
        s_x = v_0 dot t, quad s_y = 1/2 dot g dot t^2 \
        h = 1/2 dot g dot (s_x/v_0)^2 \
        v = sqrt((s dot t)^2 + (g dot t)^2) = sqrt(v_0^2 + (g dot t)^2)
      $
    ]
  ],
  waagrechter-wurf(h: 5, v_0: 10, y: 10, scaling: 0.23),
)
#v(-0.5em)

*Beispiel: Ende einer Wasserrutsche*\
#example-block[
  _a) Am Ende einer Wasserrutsche soll der Nutzer nach $L = 4"m"$ ins Wasser fallen.
  Wie hoch muss das Rutschenende liegen, wenn der Nutzer mit $v = 8.64 "m"/"s"$ die Rutsche verlässt?_
  $
    h = 1/2 dot g dot (s_x/v_0)^2 = 1/2 dot 9.81 "m"/"s"^2 dot ((4"m")/(8.64 "m"/"s"))^2 = underline(1.05"m")
  $

  _b) Berechnen sie die vektorielle Geschwindigkeit $hk(v)_E$ des Benutzers beim Auftreffen ins Wasser und
  geben sie den Geschwindigkeitsbetrag $v_E = abs(hk(v)_E)$ sowie den Winkel $phi$ an, den die Geschwindigkeit $v_E$
  mit der Horizontalen einschliesst._

  #grid(
    columns: (1fr, auto),
    [
      Gesucht: $abs(v_E), phi$

      + Den waagrechten Wurf in eine $x$ und $y$-Komponente aufteilen.
        In $x$-Richtung bewegt sich der Nutzer mit $v$, in $y$ durch den Freien Fall.
      + Vektor $v_E$ bilden
      + Den Betrag mithilfe von Pythagoras bilden
      + Wir haben nun die Ankathete und Gegenkathete des Winkels $phi$. Dieser kann mit $arctan$ berechnet werden.
    ],
    $
      1) & space v_x = v = 8.64"m"/"s" \
         & space v_y = -g dot t = -g dot L/v = -9.81"m"/"s" dot (4"m")/(8.64"m"/"s") \
         & space v_y = -4.54 "m"/"s" \
      2) & space hk(v)_E = vec(8.64, -4.54) "m"/"s" \
      3) & space abs(v_E) = sqrt(8.64^2 + (-4.54)^2) = underline(9.76"m"/"s") \
      4) & space phi = arctan(g/a) space => space phi = arctan(-4.54/8.64) \
         & space underline(phi = -7.7°)
    $,
  )
]

== Bezugssystem <bezugssystem>
Wenn eine Person $Z$ in einem $200 "km"/"h"$ schnellen Zug einen Ball mit $20 "km"/"h"$ wirft, hat für diese Person der
Ball die Geschwindigkeit $20 "km"/"h"$. Für eine Person ausserhalb des Zuges $A$ hat der Ball aber eine Geschwindigkeit
von $220 "km"/"h"$. Die Geschwindigkeit des Balls ist also eine _Relativgeschwindigkeit_.

Um diese Unterschiede beschreiben zu können, definiert man ein _Bezugssystem_.
Ein Bezugssystem ist ein Koordinatensystem, das in der Perspektive eines bestimmten Betrachters seinen Ursprung hat.
Im obigen Beispiel haben wir das Bezugssystem der Person $A$ und der Person $Z$.
Alle Messungen in einem Bezugssystem finden aus dieser Perspektive statt.
Somit hat der Ball je nach Bezugssystem eine andere Geschwindigkeit.

Bei Rechnungen mit verschiedenen Bezugssystemen werden diese mit einem hochgestellten Index bezeichnet.
Es kann so auch der Ursprung des einen Bezugssystems durch das andere dargestellt werden.

#definition(
  grid(
    columns: (1fr, 1fr),
    align: horizon,
    $ hk(r)^((A)) = hk(r)_A^((B))(t) $,
    [
      _$bold(hk(r)^((A)))$:_ Ursprung des Bezugssystems $A$ \
      _$bold(hk(r)_A^((B))(t))$:_ Ursprung des Bezugssystems $A$\ aus der Sicht des Bezugssystems $B$ \
    ],
  ),
)

Ortskoordinaten können so vom einen ins andere Bezugssystem übersetzt werden.
#definition[$ hk(r)^((B))(t) = hk(r)_A^((B))(t) + hk(r)^((A))(t) $]

Die Geschwindigkeiten und Beschleunigungen für das Bezugssystem $B$ aus der Perspektive des Bezugssystems $A$
ergeben sich wie folgt.

#definition[
  $
    hk(v)^((B))(t) = hk(v)_A^((B))(t) + hk(v)^((A))(t)\
    hk(a)^((B))(t) = hk(a)_A^((B))(t) + hk(a)^((A))(t)
  $
]

Im Zugbeispiel oben nehmen die Beobachter _beide einen schiefen Wurf wahr_, aber mit einer _unterschiedlichen
Startposition und Anfangsgeschwindigkeit_.

#table(
  columns: (auto, 1fr),
  table.header([Bezugssystem], [Formel]),
  [Betrachter $Z$ \ #hinweis[(regulärer schiefer Wurf)]],
  $
    hk(r)^((Z))_("Ball")(t) = hk(r)^((Z))_(0, "Ball") + hk(v)^((Z))_(0, "Ball") dot t + 1/2 hk(g) dot t^2
  $,

  [Betrachter $A$ \ #hinweis[(schiefer Wurf mit \ Position des Zuges)]],
  $
    hk(r)^((A))_("Ball")(t) = hk(r)_"Zug" + hk(r)^("Zug")_"Ball"(t)\
    = overbracket(
      hk(r)_(0, "Zug") + t dot hk(v)_"Zug",
      "zurückgelegte Zugstrecke",
    )
    + overbracket(
      hk(r)^((Z))_(0, "Ball") + hk(v)^((Z))_(0, "Ball") dot t + 1/2 hk(g) dot t^2,
      "schiefer Wurf",
    )\
    = (hk(r)_(0, "Zug") + hk(r)^("Zug")_(0, "Ball")) + (hk(v)_"Zug" + hk(v)^(("Zug"))_(0, "Ball")) dot t + 1/2 dot hk(g) dot t^2
  $,
)

=== Inertialsysteme <inertialsystem>
In der Physik gibt es _vier fundamentale Kräfte:_
Gravitationskraft #hinweis[(Erdanziehungskraft)],
elektromagnetische Kraft #hinweis[(Magnete, elektrisch geladene Objekte)],
starke und schwache Kraft #hinweis[(bedeutend auf atomarer Ebene)].
Alle anderen Kräfte, die auf Objekte wirken sind _Scheinkräfte/Trägheitskräfte_, siehe @scheinkraft.\
*Beispiele für Scheinkräfte:* Fliehkräfte, Reibung.

In _Inertialsystemen_ wirken keine Scheinkräfte. Sie werden benötigt, um die echten Kräfte von den Scheinkräften zu separieren.
In allen Inertialsystemen gelten dieselben physikalischen Gesetze. Bewegt sich ein zweites Bezugssystem $B$ relativ
zum Inertialsystem $I$ geradlinig gleichförmig, ist es ebenfalls ein Inertialsystem.

#definition(
  grid(
    columns: (0.5fr, 1fr),
    align: horizon,
    $ hk(r)^((I))_B = hk(r)^((I))_(0, B) + hk(v)^((I))_(0, B) dot t $,
    [
      _$bold(hk(r)^((I))_(0,B))$:_ Ursprung des Bezugssystems $B$ aus der Sicht des Inertialsystems $I$ \
      _$bold(hk(v)^((I))_(0,B))$:_ Anfangsgeschwindigkeit des Bezugssystems $B$\ aus der Sicht des Inertialsystems $I$
    ],
  ),
)

Im Zugbeispiel im @bezugssystem ist der Zug, solange er nicht in eine Kurve fährt, ein Inertialsystem
#hinweis[(ansonsten wirken Fliehkräfte)]. Das Bezugssystem der Person im Zug, die den Ball wirft, ist damit auch ein
Inertialsystem.

Es ist häufig schwierig, ein "echtes" Inertialsystem zu finden.
Zum Beispiel ist auch ein fester Punkt auf der Erde durch die Erdrotation kein echtes Inertialsystem.

*Beispiel*\
#example-block[
  _Während ein Fahrstuhl steht, fällt eine Schraube von der Decke.
  Der Fahrstuhl ist $3"m"$ hoch und unmittelbar nachdem sich die Schraube gelöst hat, beginnt der Fahrstuhl mit einer
  Beschleunigung von $4"m"/"s"^2$ nach oben zu beschleunigen.
  Wie lange dauert es, bis die Schraube auf dem Boden des Fahrstuhls ankommt?_

  #table(
    columns: (auto, 1fr),
    table.header(
      [*Position Fahrstuhlboden\ #hinweis[(Bezugssystem ausserhalb)]*],
      [*Position Schraube\ #hinweis[(Bezugssystem ausserhalb)]*],
    ),
    $
      hk(r)^(("aussen"))_("Fahrstuhl") = 1/2 dot hk(a) dot t\
      "mit" a = mat(0, 0, 4"m"/"s"^2)
    $,
    $
      hk(r)^(("aussen"))_("Schraube") = hk(r)^(("aussen"))_(0, "Schraube") + 1/2 dot g dot t^2\
      "mit" hk(r)^(("aussen"))_(0, "Schraube") = mat(0, 0, 3"m"), quad g = mat(0, 0, -9.81 "m"/"s"^2)
    $,
  )

  #grid(
    columns: (1fr, auto),
    [
      + Die Bewegung ist beendet, wenn die beiden Positionen gleich sind.
      + Die Positionsformeln einsetzen
      + minus $1/2 dot g dot t^2$ rechnen
      + $1/2$ und $t^2$ ausklammern
      + Werte einsetzen. Da alle $x$ und $y$-Komponenten $0$ sind, fallen diese weg.
      + Nur die $z$-Komponente der Formel ist relevant, darum kann skalar weitergerechnet werden.
      + Nach $t$ umformen.
    ],
    $
      1) & space hk(r)^(("aussen"))_("Fahrstuhl") = hk(r)^(("aussen"))_("Schraube") \
      2) & space 1/2 dot hk(a) dot t^2 = hk(r)^(("aussen"))_(0, "Schraube") + 1/2 dot g dot t^2 \
      3) & space 1/2 dot hk(a) dot t^2 - 1/2 dot g dot t^2 = hk(r)^(("aussen"))_(0, "Schraube") \
      4) & space 1/2 dot (hk(a) - hk(g)) dot t^2 = hk(r)^(("aussen"))_(0, "Schraube") \
      5) & space 1/2 dot (vec(0, 0, 4"m"/"s"^2) - vec(0, 0, -9.81"m"/"s"^2)) dot t^2 = vec(0, 0, 3"m") \
      6) & space 1/2 dot (4 "m"/"s"^2 + 9.81 "m"/"s"^2) dot t^2 = 3"m" \
      7) & space t = sqrt((3"m")/(6.905 "m"/"s"^2)) = underline(0.66"s")
    $,
  )
]


= Die Newtonschen Gesetze
Die Newtonschen Gesetze beschreiben, welche _physikalischen Ursachen_ Einfluss auf die Bahn eines Teilchens haben.
Durch sie kommen zu den kinematischen Grössen die _Kraft_ #hinweis[(Einheit Newton)] und die _träge Masse_ hinzu.
Es gibt drei Newtonsche Gesetze: Das Trägheitsgesetz, das Aktionsprinzip und das Reaktionsprinzip.

*Einheiten der Newton'schen Mechanik*
#v(-0.75em)
#table(
  columns: (1fr, 1fr, 1fr, 1.2fr),
  align: center + horizon,
  table.header([Basisgrösse], [Variabel], [Masseinheit], [Basiswert]),
  [Masse], $m$, [Kilogramm], $1"kg"$,
  [Kraft], $hk(F)$, [Newton], $1"N" = 1 ("kg" dot "m")\/"s"^2$,
)

== Innere und äussere Kräfte <innere-äussere-kräfte>
_Äussere Kräfte_ wirken von der Umgebung auf das betrachtete System ein, z.B. Gewichtskraft, Gravitation oder
elektromagnetische Kraft. _Innere Kräfte_ wirken im Inneren des betrachteten Systems.

Ein Objekt kann mehrere Kräfte haben, die gleichzeitig auf es einwirken. Die Summe davon ist die äussere Kraft.
Die Kräfte sind nochmals weiter unterteilt, siehe folgende Tabelle.
Diese neuen Kräfte sind alles _echte Kräfte_, wirken also auch in einem Inertialsystem.


#colbreak()

#table(
  columns: (auto, auto, 1fr),
  align: (x, _) => if x == 0 { horizon } else { auto },
  table.header([], [Kraft], [Beschreibung]),

  table.cell(rowspan: 6, rotate(-90deg, reflow: true)[Äussere Kräfte]),
  [*Gravitations-\ kraft\ $hk(F)_"Gravitation"$*],
  [
    Die Gravitationskraft beschreibt die Anziehungskraft zweier Massen.
    Durch sie werden alle Objekte zueinander hingezogen, auch im Vakuum.
    Je weiter die Objekte voneinander entfernt sind, desto schwächer wird sie.
    Im Weltraum ist die Gravitationskonstante relevant, siehe @gravitationsgesetz
  ],

  [*Gewichtskraft\ $hk(F)_G$*],
  [
    Kraft, die ein Objekt auf einen Gegenstand wirkt, auf dem seine Masse aufliegt.
    Je grösser die Masse des Objekts, desto grösser die Gewichtskraft.
    Die Gewichtskraft ist eine Spezialform der Gravitationskraft, die nur wirkt, wenn Gravitation vorhanden ist.
  ],

  [*Normalkraft\ $hk(F)_N$*],
  [
    Liegt ein Objekt auf dem Boden, drückt die Normalkraft des Bodens gegen das Objekt und gleicht so die Gewichtskraft
    des Objekts aus. Die Kraft wirkt immer senkrecht auf die Kontaktfläche der beiden Objekte.
  ],

  [*Hangabtriebs-\ kraft\ $hk(F)_H$*],
  [
    Auf einer schiefen Ebene wird ein Gegenstand durch die Gravitation nach unten gezogen.
    Sie wird meistens in eine senkrechte und zur Ebene parallele Komponente aufgeteilt.
    Ersteres drückt den Gegenstand gegen die Ebene und wird von der Normalkraft kompensiert.
    Die parallele Komponente besteht aus der Gravitationskraft und zieht den Gegenstand die Ebene herab.
    Die Hangabtriebskraft ist die Summe aus Gravitationskraft und Normalkraft.
  ],

  [*Strömungs-\ widerstand\ $hk(F)_"ström"$*],
  [
    Tritt auf, wenn ein Körper durch Luftwiderstand abgebremst wird.
    Ebenfalls eine Reibungskraft, da der Wind aber meist nicht als Teil eines Systems betrachtet wird,
    gilt sie häufig als äussere Kraft.
  ],

  [*Rückstellkraft\ $hk(F)_R$*],
  [
    Spannt man eine Feder, wirkt eine Kraft, die die Feder beim Loslassen wieder in ihre Ruhelage bewegt
    -- die Rückstellkraft
  ],

  table.hline(stroke: 0.15em),
  table.cell(rowspan: 4, rotate(-90deg, reflow: true)[Innere Kräfte]),
  [*Reibungskräfte*],
  [
    Treten auf, wenn sich zwei Körper mit unterschiedlicher Geschwindigkeit berühren.
    Verlaufen entgegen der Bewegungsrichtung der Körper. Werden in verschiedene Arten unterteilt:
  ],

  [*Gleitreibung\ $hk(F)_"gleit"$*],
  [
    Tritt auf, wenn ein Körper auf einer Oberfläche rutscht. Der Körper wird dabei von der Gleitreibung abgebremst.
  ],

  [*Rollreibung\ $hk(F)_"roll"$*],
  [
    Tritt auf, wenn ein Körper mit Rädern auf einem anderen Körper platziert wird und damit über einen Körper rollt.
    Der Gleitreibung sehr ähnlich, aber meist quantitativ deutlich geringer.
  ],

  [*Haftreibung\ $hk(F)_"Haft"$*],
  [
    Um einen Körper, der auf einem anderen ruht, in Bewegung zu versetzten, braucht es eine gewisse Minimalkraft.
    Wirkt eine Kraft $<$ Haftreibungskraft ein, wird sie dadurch kompensiert und der Körper bewegt sich nicht.
    Sobald sich ein Körper bewegt, gibt es keine Haftreibungskräfte mehr.
  ],
)

Die _äussere Kraft_, die auf ein Teilchen einwirkt, kann von Zeit, Position und Geschwindigkeit des Teilchens abhängen.
Sie wird deshalb oft als Funktion definiert. Dies ist bei der Bewegungsgleichung relevant
#hinweis[(siehe @bewegungsgleichung)].

#definition[$ F_"äussere" (hk(r), hk(v), t) $]

=== Kraftvektoren
Kräfte werden als _Vektoren_ definiert und haben eine Richtung und eine Länge.
Das ist relevant, wenn ein Kraftvektor einen Winkel besitzt.
Ein solcher Vektor wird durch seine Länge $F$ und seine Richtung #box(inset: (y: -1em), $vec(cos alpha, sin alpha)$) definiert.
Kraftvektoren können auch in eine $x$ und $y$-Komponente aufgeteilt werden.

#definition(
  grid(
    columns: (1fr, auto),
    align: horizon,
    $
      hk(F) = F dot vec(cos alpha, sin alpha)\
      vec(delim: #none, "I", "II") space
      vec(
        delim: "|",
        F_x = F dot cos alpha,
        F_y = F dot sin alpha
      )
    $,
    [
      _$bold(hk(F))$:_ Resultierender Kraftvektor\
      _$bold(F)$:_ Kraft des Vektors ohne Richtung\
      _$bold(vec(cos alpha, sin alpha))$:_ Richtung des Vektors, basierend auf dem Winkel $alpha$\
      _$bold(F_x\, F_y)$:_ $x$- bzw. $y$-Komponente des Vektors
    ],
  ),
)

Der Nullpunkt des Koordinatensystems ist meist unten links im Schaubild.
In diesen Koordinatensystemen sind _alle Kräfte, die nach links oder unten zeigen, negativ_.

*Beispiel*\
#example-block[
  _An einem Lastarm $A$ wird eine Masse $m$ befestigt und mit einem Seil $S$ gemäss der rechts stehenden Skizze nach
  oben gezogen. Die Masse wird nicht beschleunigt, also ist $hk(F)_"äussere" = hk(0)$._

  #grid(
    align: horizon,
    $
      hk(F)_A = F_A dot vec(cos alpha, sin alpha)\
      hk(F)_S = F_S dot vec(-cos alpha, -sin alpha)\
      hk(F)_G = vec(0, m dot -g)\
      F_"äussere" = hk(0) = F_A + F_S + F_G\
      vec(delim: #none, "I", "II") space
      vec(
        delim: "|",
        hk(0) & = F_A dot cos alpha + F_S dot -cos alpha + hk(0),
        hk(0) & = F_A dot sin alpha + F_S dot -sin alpha + m dot -g
      )
    $,
    image("img/kraftvektoren.png"),
  )
]

== Statik
Während sich die Kinematik mit der Bewegung von Körpern befasst, beschäftigt sich die Statik mit Objekten
im ruhenden Zustand. Es kommt zum _Kräftegleichgewicht_, in welchem sich sämtliche auf ein Objekt wirkenden
Kräfte kompensieren.

In der Mechanik gibt es bis auf die Haftreibung keine anderen Reibungskräfte #hinweis[(siehe @innere-äussere-kräfte)].

#definition[
  $
    sum F_"äussere" = 0\
    hk(v)(t) = 0 vec("m"/"s", delim: "[") quad quad hk(a)(t) = 0 vec("m"/"s"^2, delim: "[")
  $
]

== 1. Newtonsches Gesetz: Trägheitsgesetz
#v(-1.25em)
#quote(attribution: "1. Newtonsches Gesetz (Trägheitsgesetz)")[
  In einem Inertialsystem bewegt sich ein Teilchen, auf das keine äussere Kraft wirkt, geradlinig gleichförmig.
  Das Teilchen verharrt entweder in Ruhe oder seine Bahn verläuft entlang einer Geraden mit konstanter Geschwindigkeit.
]
#v(-0.75em)

Wird ein Objekt in einem Inertialsystem in Bewegung gesetzt, bewegt es sich unendlich lange weiter, da keine äusseren
Kräfte wie Reibung auf das Objekt wirken.

#definition[$ hk(v) = "const", "wenn" hk(F) = 0 $]

=== Kraftaufhebung
Liegt ein Körper auf dem Boden, wirkt die Gewichtskraft #hinweis[(verursacht durch Gravitation)] des Körpers auf den
Boden.
#definition[$ F_G = m dot g $]

Damit sich der Körper nicht bewegt, muss die Normalkraft $F_N$ des Bodens die Gewichtskraft ausgleichen.

#definition[$ F_G = F_N = 0 quad => quad F_N = -F_G $]

#grid(
  columns: (1fr, 1fr),
  align: (x, _) => if x == 1 { horizon } else { auto },
  [
    Weil die Normalkraft immer senkrecht auf die Kontaktfläche mit der Ebene wirken muss, heben sich auf der
    _schiefen Ebene_ die Normalkraft und die Gewichtskraft _nicht mehr auf_. Auf einer Schiefen Ebene ohne Reibung ist
    $F_N > F_G$, darum wirkt die Hangabtriebskraft $F_H$, siehe @schiefe-ebene-ohne-reibung.
  ],
  image("img/schiefe_ebene.png"),
)
#v(-0.25em)

Gleitet ein Objekt über den Boden, gilt zusätzlich zur Gewichts- und Normalkraft die Gleitreibung $F_"gleit"$.
Die ersten beiden Kräfte heben sich allerdings gegenseitig auf. Die äussere Kraft berechnet sich also

$ F & = F_G + F_N + F_"gleit" space = space 0 + F_"gleit" = F_"gleit" $

== 2. Newtonsche Gesetz: Aktionsprinzip
#v(-1.25em)
#quote(attribution: "2. Newtonsches Gesetz (Aktionsprinzip)")[
  In einem Inertialsystem ist die Beschleunigung, die ein Körper erfährt, proportional zur auf ihn einwirkenden äusseren
  Kraft.
]
#v(-0.75em)

Es muss eine grössere Kraft aufgewendet werden, um einen schweren Körper genau so stark zu beschleunigen wie einen leichten.
Die _träge Masse $bold(m)$_ eines Körpers widersetzt sich der Beschleunigung.
Sie hat die _Einheit $bold("kg")$_. Je grösser die träge Masse eines Objekts ist, umso mehr Kraft muss man aufwenden,
um einen Körper auf ein gewisses Mass zu beschleunigen.

#definition[$ hk(F)_"äussere" = m dot hk(a) $]

Die träge Masse stellt eine Beziehung zwischen der auf einen Körper wirkende äussere Kraft und seiner Beschleunigung her.
Zusätzlich gibt es noch die _schwere Masse_, das Gewicht eines Körpers, welches auf der Waage abgelesen werden kann.
Die Relativitätstheorie beweist aber, dass träge und schwere Masse quasi äquivalent sind, und deswegen einfach von
_Masse_ gesprochen werden kann.

=== Bewegungsgleichung <bewegungsgleichung>
Die _Bewegungsgleichung_ beschreibt die Bahn eines Teilchens. Sie basiert auf dem zweiten Newtonschen Gesetz.
Hier wird $F_"äussere"$ definiert als Funktion, die von der Zeit~$t$ #hinweis[(z.B. eingeschalteter Elektromagnet)],
der Position $hk(r)$ und der Geschwindigkeit $hk(v)$ #hinweis[(z.B. bei Reibung)] abhängig ist.
Weil sich $hk(a)$ auch als $dot.double(hk(r))$ schreiben lässt, hängen beide Seiten von denselben Variablen $r$ und $t$ ab.

#definition[$ m dot dot.double(hk(r)) = hk(F)(hk(r), dot(hk(r)), t) $]

Hier erhalten wir eine _Differentialgleichung_ #hinweis[(genauer: Differentialgleichung 2. Ordnung)], eine Gleichung,
in welcher die Unbekannte keine Variable, sondern eine Funktion ist. In der Physik haben die Differentialgleichungen der
Bewegungsgleichung typischerweise eine _allgemeine Lösung_, die von _zwei Parametern_ abhängt.
Diese beiden Parameter sind die _Anfangswerte $bold(hk(r)_0\, hk(v)_0)$_ bzw. $hk(r)_0, dot(hk(r))_0$.
Werden diese als Parameter in der Differentialgleichung fixiert, erhält man die _spezielle Lösung der Differentialgleichung_.

=== In gleichmässig beschleunigten Bewegungen
Wenn auf einen Körper mit Masse $m$ eine konstante äussere Kraft $hk(F)$ einwirkt, erfährt der Körper eine konstante
Beschleunigung $hk(a)$.

#definition[$ hk(a) = hk(F)/m $]
#v(-0.25em)

*Beispiel*\
#example-block[
  _Sie werfen einen Stein mit der Masse $m_1 = 1"kg"$ und einen zweiten Stein mit Masse $m_2 = 1/2"kg"$. Startposition,
  Anfangsgeschwindigkeit und Wurfwinkel beider Würfe ist identisch._

  a) _Welcher Stein fliegt weiter, wenn der Luftwiderstand keine Rolle spielt?_
  #grid(
    columns: (1fr, auto),
    [
      Gesucht: Distanzen $r_1, r_2$
      + Beide Würfe folgen einem schiefen Wurf, die sich nur in der Beschleunigung $a_1, a_2$ unterscheiden
      + Nach 2. Newton umformen.\ Die Beschleunigung wird durch die Gewichtskraft $F_G = m dot g$ der Steine bestimmt

      Ohne Luftwiderstand hängt die Beschleunigung rein von der Gravitation ab. Beide Steine fliegen gleich weit.
      $
        hk(a)_1 = hk(a)_2 = hk(g) quad => quad r_1 = r_2
      $
    ],
    $
      1) & space r_1(t) = r_0 + v_0 dot t + 1/2 hk(a)_1 dot t^2 \
         & space r_2(t) = r_0 + v_0 dot t + 1/2 hk(a)_2 dot t^2 \
      2) & space hk(F)_(1, G) = m_1 dot hk(g) quad => quad hk(a)_1 = hk(F)_(1,G)/m_1 = (cancel(m_1) dot hk(g))/cancel(m_1) \
         & space hk(F)_(1, G)= hk(g) \
         & space hk(F)_(2, G) = m_2 dot hk(g) quad => quad hk(a)_2 = hk(F)_(2,G)/m_1 = (cancel(m_2) dot hk(g))/cancel(m_2) \
         & space hk(F)_(2, G) = hk(g)
    $,
  )

  b) _Welcher Stein fliegt weiter, wenn die Luftreibung eine Rolle spielt und die Form der Steine identisch ist?_
  #grid(
    columns: (1fr, auto),
    [
      + Wenn die Luftreibung eine Rolle spielt, besteht die äussere Kraft aus Gewichtskraft und Strömungswiderstand.
      + Damit kann die Beschleunigung bestimmt werden.
      + Unter der Annahme, dass sich $F_"ström"$ während des Wurfs nur unwesentlich verändert, kann die Distanzfunktion
        $r(t)$ aufgestellt werden.
    ],
    $
      1) & space hk(F) = hk(F)_G + hk(F)_"ström" = m dot hk(g) + hk(F)_"ström" \
      2) & space hk(a) = hk(F)/m = (hk(F)_G + hk(F)_"ström")/m = hk(g) + hk(F)_"ström"/m \
      3) & space hk(r)(t) = hk(r)_0 + v_0 dot t + 1/2 dot (g + hk(F)_"ström"/m) dot t^2 \
      4) & space hk(F)_"ström"/(m -> infinity) = 0 quad quad hk(F)_"ström"/(m -> 0) = infinity
    $
  )
  #v(-0.5em)

  4. Der Strömungswiderstand hängt nur von der Geschwindigkeit und der Form des Steins ab. Zur Verdeutlichung des
    Massenunterschieds kann für $m -> infinity$ und\ $m -> 0$ eingesetzt werden.

  Ein sehr schwerer Stein bewegt sich wie ein Stein ohne Luftreibung #hinweis[($hk(g) + 0$)].
  Bei einem sehr leichten Stein wird sie irgendwann sehr viel grösser als $hk(g)$ #hinweis[($hk(g) + infinity$)].
  Der Stein wird rasch auf $0"m"/"s"$ abgebremst und fällt zu Boden.
  Der sehr leichte Stein bewegt sich also nicht nach vorne, während der sehr schwere Stein die Luftreibung quasi ignoriert.
]

=== Auf schiefer Ebene ohne Reibung <schiefe-ebene-ohne-reibung>
#grid(
  align: horizon,
  [
    Auf der schiefen Ebene ohne Reibung setzt sich die äussere Kraft aus zwei Kräften zusammen:
    Der Gewichtskraft $hk(F)_G$ und der Normalkraft $hk(F)_N$.
    Da sich die beiden Kräfte nicht mehr ausgleichen, kommt zur äusseren Kraft die _Hangabtriebskraft_ hinzu.
    Sie ist die Summe der beiden Kräfte und somit gleich der totalen äusseren Kraft.
  ],
  image("img/schiefe_ebene_komponenten.png"),
)

#definition[
  $
    hk(F)_"äussere" = hk(F)_H & = hk(F)_G + hk(F)_N \
                              & = m dot hk(g) + F_N
  $
]

Die Gewichtskraft $hk(F)_G$ lässt sich in zwei Komponenten einteilen:
Die _Hangabtriebskraft $bold(hk(F)_H)$_, welche die Ebene herunterzeigt und die _negative Normalkraft $bold(-hk(F)_N)$_,
welche senkrecht von der schiefen Ebene weg weist.

#definition[$ hk(F)_G = -hk(F)_N + hk(F)_H $]

Nimmt man die Beträge der Vektoren, kann man die Elemente mit einem Gleichungssystem ausrechnen.
$
  vec(
    delim: "|",
    abs(F_H) & = abs(F_G) dot sin alpha = m dot g dot sin alpha,
    abs(F_N) & = abs(F_G) dot cos alpha = m dot g dot cos alpha
  )
$

Damit lässt sich die Hangabtriebskraft und die Normalkraft durch die Körpermasse, die Gravitation und den Winkel der
Schiefen Ebene definieren.

#definition[
  $
    F_H = m dot g dot sin alpha\
    F_G = m dot g dot cos alpha
  $
]

Wenn sich der Ursprung des Koordinatensystems am untersten Punkt der schiefen Ebene befindet, kann die Bewegung des
Körpers mit dieser Formel berechnet werden. Weil die Bewegung in Richtung des Ursprungs geht, ist diese negativ.

#definition(
  grid(
    align: horizon,
    $ r(t) = r_0 + v_0 dot t - g/2 sin alpha dot t^2 $,
    [
      _$bold(r_0)$:_ Startposition des Körpers\
      _$bold(v_0)$:_ Anfangsgeschwindigkeit des Körpers. Bewegt er sich nach unten, muss $v_0$ negativ sein\
      _$bold(alpha)$:_ Winkel der schiefen Ebene\
      _$bold(t)$:_ Zeit seit Beginn\
    ],
  ),
)

Die _Geschwindigkeit des Körpers_ auf der schiefen Ebene wird berechnet mit

#definition[$ v(t) = v_0 - g dot sin alpha dot t $]

Die _Beschleunigung des Körpers_ wird durch das 2. Newtonsche Gesetz definiert.

#definition[$ hk(a) = hk(F)_"äussere"/m = hk(F)_H /m = hk(g) + hk(F)_N / m $]

Damit kann die Bewegung des Körpers über die Beschleunigung statt der Geschwindigkeit definiert werden.

#definition[
  $
    r(t) = r_0 + 1/2 a dot t^2 space
    = space r_0 + hk(F)_H/(2m) dot t^2 space
    = space r_0 - (g dot sin alpha)/2 dot t^2
  $
]

Wird der Körper die schiefe Ebene hochgezogen, kann die Strecke so berechnet werden
#definition(
  grid(
    align: horizon,
    $ s = h / sin(alpha) $,
    [
      _$bold(s)$:_ Zurückgelegte Strecke\
      _$bold(h)$:_ Höhendifferenz\
      _$bold(alpha)$:_ Winkel der schiefen Ebene
    ],
  ),
)

*Aufgabe: Rolle und Seil auf schiefer Ebene ohne Reibung*\
#example-block[
  #grid(
    [
      _Zwei Körper mit Massen $m_1 = 1.5"kg"$ und $m_2 = 1"kg"$ sind reibungsfrei über eine Rolle mit einem Seil verbunden.
      $m_1$ liegt auf einer schiefen Ebene mit $alpha = 30°$.
      $m_2$ hat keinen Kontakt mit der schiefen Ebene.
      Bestimme die Beschleunigung von $m_1$. Bewegt er sich die Ebene hoch oder hinunter?_
    ],
    image("img/schiefe_ebene_rolle.png"),
  )

  Wichtig zu wissen ist, dass das gespannte Seil dieselbe Zugkraft $F_Z$ und damit auch dieselbe Beschleunigung $a$
  auf beide Körper auswirkt.

  #grid(
    columns: (1fr, auto),
    [
      + Bestimmen der äusseren Kräfte für $F_1, F_2$
      + Da $m_2$ mehr Kraft ausübt, *bewegt sich $m_1$ nach oben.*
      + Bewegungsgleichungen für beide Körper aufstellen.\
        $F_Z$ ist bei $m_2$ minus, da der Körper nach unten gezogen wird.
      + Kräfte auf beiden Seiten addieren und vereinfachen
      + Nach $a$ umformen und ausrechnen
    ],
    $
      1) & space F_1 = F_(G,1) + F_N + F_Z = F_H + F_Z \
         & space F_1 = m dot g dot sin(alpha) + F_Z \
         & space F_2 = m dot g + F_Z \
      2) & space 1.5"kg" dot 9.81 dot sin(30°) < 1"kg" dot 9.81 \
         & space 7.35"N" < 9.81"N" \
      3) & space m_1 dot a = -m_1 dot g dot sin(alpha) + F_Z \
         & space m_2 dot a = m_2 dot g - F_Z \
      4) & space m_1 a + m_2 a = -m_1 g sin(alpha) +cancel(F_Z) + m_2 g -cancel(F_Z) \
         & space a dot (m_1 + m_2) = -m_1 dot g sin(alpha) + m_2 dot g \
      5) & space a = (-m_1 dot sin(alpha) + m_2 dot g)/(m_1 + m_2) \
         & space a = (-1.5"kg" dot 9.81"m"/"s"^2 + 1"kg" dot 9.81"m"/"s"^2)/(1.5"kg"+1"kg") = underline(0.981"m"/"s"^2)
    $,
  )
]

*Übersicht schiefe Ebene ohne Reibung*
#v(-0.5em)
#table(
  columns: (auto, auto, auto),
  align: horizon,
  table.header([Äussere Kraft], [Bewegungsgleichung], [Allgemeine Lösung]),
  $
    hk(F)_"äussere" = hk(F)_H\
    = -m dot g dot sin(alpha) dot hat(r)_"Ebene"
  $,
  $ m dot dot.double(r) = -m dot g dot sin(alpha) $,
  $
    h(t) =\
    h_0 + v_0 dot t - 1/2 dot g dot sin(alpha) dot t^2\
    v(t) = v_0 - g dot sin(alpha) dot t
  $,
)

=== Auf schiefer Ebene mit Reibung
Schaut man die schiefe Ebene mit Reibung an, besteht die äussere Kraft zusätzlich zu $hk(F)_G, hk(F)_N, hk(F)_H$ auch
aus _Gleit- oder Rollreibungskraft_ $hk(F)_"gleit"$ oder $hk(F)_"roll"$, je nach dem ob der Körper Räder besitzt.
Die Reibungskraft ist immer _entgegen der Geschwindigkeit_ gerichtet und proportional zu $abs(hk(F)_N)$.

Die _Rollreibungskraft_ besteht aus dem _Reibungskoeffizienten $bold(mu)$_, der Normalkraft $hk(F)_N$ und in Bewegungen
in 2D/3D dem _Einheitsvektor der Geschwindigkeit $bold(hat(v))$_, wobei $abs(hat(v)) = 1$.

#grid(
  align: horizon,
  [
    #definition[
      Betragsformel für 1D-Bewegungen
      $ F_("gleit"\/"roll") = mu_("gleit"\/"roll") dot F_N $

      Vektor-Formel für 2D/3D-Bewegungen
      $
        F_("gleit"\/"roll") & = -mu_("gleit"\/"roll") dot abs(hk(F)_N) dot hat(v) \
                            & = -mu_("gleit"\/"roll") dot abs(hk(F)_N) dot v/abs(v) \
      $
    ]
  ],
  image("img/schiefe_ebene_reibung.png"),
)

Mit dem zweiten Newtonschen Gesetz gilt also
#definition(
  $
    cases(
      m dot hk(a) = hk(F)_H + hk(F)_"reib" "wenn sich der Körper nach unten bewegt",
      m dot hk(a) = hk(F)_H - hk(F)_"reib" "wenn sich der Körper nach oben bewegt",
    )
  $,
)

Die Bewegung und Geschwindigkeit können mit diesen Formeln ausgerechnet werden.

#definition[
  #grid(
    columns: (auto, 1fr),
    align: horizon,
    $
      r(t) = r_0 + v_0 dot t - g/2 dot (sin alpha minus.plus mu dot cos alpha) dot t^2\
      v(t) = v_0 - g dot (sin alpha minus.plus mu cos alpha) dot t\
      a = g dot sin alpha minus.plus mu dot g dot cos alpha
    $,
    [
      _$bold(minus.plus)$:_ Bewegt sich der Körper den Hang hinunter, ist das Vorzeichen $minus$.
      Bewegt er sich die schiefe Ebene hoch, ist es $plus$.
    ],
  )
]

Zusätzlich gibt es noch die Haftreibung. Sie beschreibt den _Widerstand_, bis sich ein Körper in Bewegung setzt.
Ist die Summe aller anderen Kräfte, die auf das Objekt wirken kleiner als die _maximale Haftreibung_, kompensiert sie die Kraft.
Ansonsten setzt sich das Objekt in Bewegung und die Haftreibung hat keinen Einfluss mehr auf das Objekt.

#definition(
  grid(
    columns: (1fr, auto),
    align: horizon,
    $ abs(F_("Haft", "max")) = mu_H dot abs(F_N) $,
    [
      _$bold(mu_H)$:_ Haftreibungskoeffizient der Oberfläche\
      _$bold(F_N)$:_ Normalkraft des Objekts
    ],
  ),
)

*Übersicht schiefe Ebene mit Reibung*
#v(-0.5em)
#table(
  columns: (auto, auto, auto),
  align: horizon,
  table.header([Äussere Kraft], [Bewegungsgleichung], [Allgemeine Lösung]),
  $
    hk(F)_"äussere" = hk(F)_H + F\
    = -m dot g dot sin(alpha) dot hat(r)_"Ebene"
  $,
  $ m dot dot.double(r) = -m dot g dot sin(alpha) $,
  $
    h(t) =\
    h_0 + v_0 dot t - 1/2 dot g dot sin(alpha) dot t^2\
    v(t) = v_0 - g dot sin(alpha) dot t
  $,
)

=== Federpendel mit Hooksches Gesetz (Feder-Kraft-Gesetz)
Bei einer Feder gilt die Rückstellkraft $F_R$. Sie ist abhängig von der Spannung der Feder~$s$, also gilt $F_R (s)$.
In Ruhelage herrscht ein Kräftegleichgewicht, also $F_R (0) = 0$. Um das Verhalten der Feder zu beschreiben, reicht die
_erste Ableitung der Federkraft $bold(F'_R (0))$_, diese wird als _Federkonstante $bold(D)$_ bezeichnet.
$D$ ist abhängig von dem Material und der Geometrie der Feder, darum sie wird meist experimentell bestimmt.
Die Rückstellkraft wirkt immer in die Gegenrichtung der Feder.
Da für die Federkonstante positive Zahlen angenehmer sind, lautet das _Hooksche Gesetz_:

#definition(
  grid(
    align: horizon,
    $ F_R (s) = -D dot s \ -D = F'_R (0) $,
    [
      _$bold(F_R)$:_ Rückstellkraft\
      _$bold(s)$:_ Auslenkung der Feder #hinweis[(0 = keine Spannung)]\
      _$bold(D)$:_ Federkonstante\
    ],
  ),
)

#grid(
  columns: (2fr, 1fr),
  align: horizon,
  [
    Weil die Position der Feder von der Zeit abhängig ist, ist das Aufstellen einer _Bewegungsgleichung_ und damit
    Differenzialgleichung nötig, siehe @bewegungsgleichung.

    Die Spannung der Feder $s$ ist wie die Beschleunigung $a$ von der Zeit $t$ abhängig;
    es gilt $a(t) = dot.double(s)(t)$.
  ],
  $
    m dot a = -D dot s\
    m dot dot.double(s) = -D dot s\
    dot.double(s) = - D/m dot s
  $,
)

Gesucht ist eine Funktion $s(t)$, deren 2. Ableitung genau das $-D/m$-fache dieser Funktion ist, welche die Position der
Feder bestimmt. Sie lässt sich mit Sinus und Cosinus #hinweis[(und Black Math-gic Fuckery)] bestimmen.

#definition(
  grid(
    columns: (auto,) * 2,
    grid.cell(colspan: 2, $ s(t) = s_0 dot cos(sqrt(D/m) dot t) + sqrt(m/D) dot v_0 dot sin(sqrt(D/m) dot t) $),
    [
      _$bold(s_0)$:_ Anfangsspannung der Feder\
      _$bold(v_0)$:_ Anfangsgeschwindigkeit der Feder\
    ],
    [
      _$bold(D)$:_ Federkonstante\
      _$bold(m)$:_ Masse des Objekts an der Feder\
    ],
  ),
)

Daraus ergibt sich auch die _Periodendauer $bold(T)$_ des Pendels.
Sie gibt an, wie lange es dauert, bis die Feder wieder an der Ausgangsposition angelangt ist.

#definition[$ T = 2pi dot sqrt(m/D) $]

Für die Beschleunigung der Feder gilt

#definition[$ v(t) = -s_0 dot sqrt(D/m) dot sin(sqrt(D/m) dot t) + v_0 dot cos(sqrt(D/m) dot t) $]

*Aufgabe*\
#example-block[
  _An einer Feder hängt ein $2"kg"$ schweres Gewicht auf der Höhe $h$. Unten am Gewicht ist eine zweite Feder befestigt.
  Nun ziehen sie zur Zeit $t = 0$ von unten an der Masse mit einer zusätzlichen Kraft $F$._

  _a) Welche äussere Kraft wirkt unmittelbar vor dem Start des Experiments auf die Masse?_

  Vor dem Experiment findet keine Bewegung statt, die äussere Kraft ist also $F_"äussere" = 0"N"$.

  _b) Aus welchen Bestandteilen setzt sich die äussere Kraft zusammen?_

  Die äussere Kraft besteht aus der Gewichtskraft der Masse $F_G = m dot g$ und der Rückstellkraft der Feder
  $F_R = D dot x_0$ #hinweis[($x_0$: Auslenkung der Feder)]

  _c) Welche äussere Kraft wirkt unmittelbar nach dem Start des Experiments auf die Masse? Wie stark ist demnach die
  Beschleunigung der Masse?_

  Beim Start des Experiments sind die Kräfte (noch) unverändert. Nun kommt die angewendete Kraft $F$ hinzu.
  Da die äussere Kraft vorher $0$ war, ist $F$ identisch mit der äusseren Kraft.
  Die Beschleunigung der Masse beträgt $a = F/m$ #hinweis[(Umstellung des 2. Newtonschen Gesetz)].

  _d) Stellen sie die Bewegungsgleichung für die Position $h(t)$ der Masse auf. Dabei ist $h(0) = 0"m"$ und die
  Koordinatenachse zeigt nach oben._

  Durch die Beschleunigung bewegt sich die Masse minimal nach unten: $a = -F/m$.
  Wird $h$ positiv, bewegt sich das Gewicht nach oben und die Rückstellkraft wird geringer. Dasselbe gilt umgekehrt.\
  Damit gilt $dot.double(h) = -F/m - D/m dot h$ #hinweis[(2. Newton für Gewicht, Hooksches Gesetz für Feder)]

  /*
  _f) Lösen sie die Bewegungsgleichung_

  #comment[Wenn de Bullshit ar Prüffig chunnt laufi use, das isch zu gottlos]

  _g) Welche Kraft wirkt damit zur Zeit $t$ auf die obere Feder?_

  #comment[Same here]
  */

  _e) Welche Anfangsbedingungen gelten für die Bewegungsgleichung von $h(t)$?_

  Es gilt $h(0) = 0$. Zusätzlich gilt $dot(h)(0) = 0$, weil sich die Masse zu Beginn nicht bewegt.

  _f) Welche Kraft wirkt auf die untere Feder?_

  Da mit der Kraft $F$ an ihr gezogen wird, wirkt die Kraft $F$.

  _g) Die Federn werden durch Fäden ersetzt. Nehmen sie an, dass die Fäden jeweils reissen, wenn auf ihnen eine Kraft
  grösser als $F_"reiss"$ angewendet wird. Welcher Faden reisst, wenn $F_"reiss" - m dot g < F < F_"reiss"$ und wenn
  $F > F_"reiss"$ ist?_

  Beim Ziehen an der Konstruktion muss der obere Faden $F + m dot g$ tragen, der untere Faden nur $F$.
  Der obere Faden kann also noch $F_"reiss" - m dot g$ tragen, bevor er reisst.

  Gilt $F > F_"reiss"$, reisst der untere Faden sofort.
  Da die Kraft einige Zeit benötigt, um den oberen Faden zu erreichen, können nicht beide Fäden gleichzeitig zerreissen.
  Auf den oberen Faden wirkt danach nur noch die Gewichtskraft der Masse.
  Ist der Faden noch nicht gerissen, kann er das auch nicht mehr.\
  Gilt $F_"reiss" - m dot g < F < F_"reiss"$ reisst der untere Faden nicht, weil $F < F_"reiss"$.
  Der obere Faden reisst aber, weil $F_"reiss" - m dot g < F$
]

*Übersicht Federpendel*
#v(-0.5em)
#table(
  columns: (auto, auto, auto),
  align: horizon,
  table.header([Äussere Kraft], [Bewegungsgleichung], [Allgemeine Lösung]),
  $
    hk(F)_"äussere" \
    = hk(F)_H -D dot s
  $,
  $ m dot dot.double(s) = -D dot s $,
  $
    h(t) = h_0 + v_0 dot t - 1/2 dot g dot sin(alpha) dot t^2\
    v(t) = v_0 - g dot sin(alpha) dot t
  $,
)

=== Fadenpendel
Wird eine Masse $m$ an einen Faden der Länge $l$ gehängt, können kleine Auslenkungen der Masse als _Spezialfall des
Federpendels_ angesehen werden. Hier lässt sich die Federkonstante mathematisch bestimmen.

#definition(
  grid(
    columns: (1fr, auto),
    align: horizon,
    $ D = (m dot g)/l $,
    [
      _$bold(D)$:_ Federkonstante des Fadenpendels \
      _$bold(m)$:_ Masse des Körpers, welcher am Faden hängt \
      _$bold(l)$:_ Länge des Fadens
    ],
  ),
)

Die_ maximale Höhe_, die das Pendel erreicht, berechnet sich mit
#definition[$ h = l - l dot cos(alpha) $]

== 3. Newtonsche Gesetz: Reaktionsprinzip / actio = reactio
#v(-1.25em)
#quote(attribution: "3. Newtonsche Gesetz (Reaktionsprinzip / actio = reactio)")[
  Ein Körper, der auf einen anderen Körper eine Kraft ausübt, erfährt vom anderen Körper dieselbe Kraft mit umgekehrtem
  Vorzeichen.
]
#v(-0.75em)

#definition[$ hk(F)_(1,2) = -hk(F)_(2,1) $]

Sitzt man in einem Ruderboot, drückt man mit einem Ruderschlag mit der Kraft $F_R$ das Wasser nach hinten.
Die Bewegung des Wassers drückt das Boot mit der Kraft $-F_R$ nach vorne.

Beim Seilziehen wird das Seil von Person 1 mit einer Kraft $F_1$ gezogen.
Auf der anderen Seite zieht Person 2 das Seil mit Kraft $F_2$.
Person 1 wird mit der Kraft $-F_2$ zur Person 2 hingezogen und umgekehrt.
Um die Kraft ausüben zu können, muss sich Person 1 mit der Kraft $-F_1$ gegen den Boden stemmen.
Damit Person 1 an Ort und Stelle bleibt, muss der Boden die Kraft $+F_1$ ausüben.

Stehen die beiden Seilzieher hingegen auf Wagen mit Rädern, kann der Boden die Kraft nicht mehr ausüben, und beide
Personen bewegen sich aufeinander zu. Das gilt auch, wenn nur eine der beiden Personen am Seil zieht.

*Beispiel*\
#example-block[
  _Eine Akrobatin mit Masse $m$ soll über ein Hochseil, das horizontal zwischen zwei Gebäuden gespannt ist, balancieren.
  Das Seil darf, wenn sie sich in der Mitte zwischen den Gebäuden befindet, um nicht mehr als $10°$ durchhängen. Wie
  gross muss der Betrag $F_z$ der Zugkraft $hk(F)_z$ im Seil mindestens sein?_

  Wenn sich die Akrobatin auf dem Seil steht, drückt sie mit $hk(F)_G$ das Seil nach unten.
  Das Seil verteilt diese Kraft mit $hk(F)_z$ und $hk(F)_z'$ auf die Gebäude links und rechts.
  Das Seil hängt am meisten durch, wenn die Akrobatin genau in der Mitte des Seils steht.

  #grid(
    columns: (1fr, auto),
    [
      + Die Summe der Kräfte muss $0$ sein.
      + Einsetzen der $x$- und $y$-Komponenten. Der $x$-Wert von $hk(F)_z$ ist Minus, um zu beschreiben, dass er in eine
        andere Richtung zeigt als der $x$-Wert von $hk(F)_z'$
      + In der Mitte des Seils verteilen sich $F_z$ und $F_z'$ gleichmässig.
      + In diesem Fall ist nur die $y$-Komponente relevant. Wir addieren $+m dot g$ und lösen nach $F_z$ auf.
    ],
    $
      1) & space hk(0) = hk(F)_G + hk(F)_z + hk(F)_z' \
      2) & space hk(0) = vec(0, -m dot g) + F_z dot vec(-cos(10°), sin(10°)) \
         & space + F_z' dot vec(cos(10°), sin(10°)) \
      3) & space F_z = F_z' \
      4) & space 0 = - m dot g dot 2 dot F_z dot sin(10°) \
         & space 2 dot F_z dot sin(10°) = m dot g \
         & space underline(F_z = (m dot g)/(2 dot sin(10°)))
    $,
  )
]

== Kreiskräfte
- _Zentrifugalkraft:_ Fliehkraft, drückt einen Körper auf einer Kreisbewegung nach aussen.
  Sie zeigt senkrecht vom Kreismittelpunkt weg.
- _Zentripetalkraft:_ Kraft, die einen Körper auf eine Kreisbahn zwingt.
  Sie zeigt gerade auf den Kreismittelpunkt und somit das genaue Gegenteil der Zentrifugalkraft.

#grid(
  columns: (1fr, 1.1fr),
  align: (x, _) => if x == 1 { center } else { auto },
  [
    Ein Objekt auf der Kreisbahn wird durch die _Zentripedalbeschleunigung $bold(a_Z)$_ und der
    _Tangentialbeschleunigung $bold(a_T)$_ beschleunigt. Erstere zeigt ins Zentrum, letztere tangential vom Kreis weg.

    #definition[
      $
        a_Z (t) = -(v^2(t))/r \
        a_T (t) = dot(v) = r dot dot.double(phi)(t) = r dot dot(omega)(t)\
        dot.double(phi) = - g/r dot cos phi
      $
    ]

    Durch das zweite Newtonsche Gesetz kann die Kraft immer in eine Zentripedalkraft $F_Z$ und tangentiale Komponente
    $F_T$ geteilt werden.
  ],
  kreiskraft(35deg, scaling: 1),
)

#definition[$ F_Z = m dot v^2/r quad quad quad F_T = m dot dot(v) $]

Herrscht auf einen Körper eine _Zentripetalkraft_ #hinweis[(z.B. Planetengravitation, Stein an Schnur wird durch die
  Luft gekreist)], muss die _Mindestgeschwindigkeit_ des Körpers mindestens so gross wie die untenstehende Formel sein,
damit der Körper auf der Kreisbahn bleibt.

#definition[$ v >= sqrt(r dot g) $]

*Beispiel*\
#example-block[
  _Ein Zug fährt auf ebener Strecken mit $v_0 = 180 "km"/"h" = 50 "m"/"s"$ in eine Kurve mit einem Kurvenradius von
  $1000"m"$ und beginnt dort mit einer Bremsverzögerung von $0.8"m"/"s"$ zu bremsen._

  _a) Um wie viel Grad ändert der Zug seine Fahrtrichtung, wenn er auf $v_1 = 72 "km"/"h" = 20 "m"/"s"$ abbremst?_
  #grid(
    columns: (1fr, auto),
    [
      + Die benötigte Zeit zum Bremsen kann mit der gleichförmigen Bewegung erhalten werden.
      + Nun kann die Strecke, die während dem Bremsen zurückgelegt wird, bestimmt werden.
      + Der Kurvenwinkel kann durch die Bogenlänge des Kreises bestimmt werden. Dieser ist im Bogenmass.
      + Bogenmass in Grad umwandeln
    ],
    $
      1) & space a = (v_1 - v_0)/t quad => quad t = (v_1 - v_0)/a = (20-50)/(-0.8) \
         & space t = 37.5"s" \
      2) & space s = v_0 dot t + 1/2 a dot t^2 = 50 dot 37.5 + 1/2 dot -0.8 dot 37.5^2 \
         & space s = 1312.5"m" \
      3) & space b = r dot alpha["rad"] quad => quad alpha["rad"] = b/r = (1312.5"m")/(1000"m") \
         & space alpha["rad"] = 1.3125 \
      4) & space alpha[deg] = (180 dot alpha["rad"])/pi = (180 dot 1.3125)/pi \
         & space alpha[deg] = underline(75.2°)
    $,
  )

  _b) Wie gross muss der Haftreibungskoeffizient eines im Zug auf einem Tisch liegenden Buches mit einem Gewicht von
  $250"g"$ mindestens sein, damit das Buch in der Kurve nicht vom Tisch fällt?_

  Zuerst muss die Gesamtkraft des Buches bestimmt werden, welche sich aus der Zentripetalkraft #hinweis[(Fliehkraft)] in
  der $x$-Achse und der Kraft der Bremsbeschleunigung in der $y$-Achse ergibt.
  Diese Kraft muss die Haftreibung $F_(H, min)$ mindestens kompensieren.

  Die Kraft $F_Z$ ist bei der grössten Geschwindigkeit $v_0$ am höchsten.
  Wir müssen also nur die Kraft während der Maximalgeschwindigkeit berechnen, tiefere Geschwindigkeiten sind hier nicht relevant.

  #grid(
    columns: (1fr, auto),
    [
      + Bestimmen der Zentripetalkraft $F_Z$
      + Bestimmen der Kraft der Bremsbeschleunigung mithilfe des 2. Newtonschen Gesetz
      + Gesamtkraft $F_"äussere"$ bestimmen. Weil sie jedoch in jeweils andere Achsen zeigen, müssen sie über Pythagoras
        verrechnet werden.
      + Bewegungsgleichung aufstellen. Die Haftreibung $F_(H, min)$ muss mindestens so gross sein wie $F_"äussere"$
      + Normalkraft des Buchs berechnen
      + Normalkraft in 4) einsetzen und nach $mu_"gleit"$ auflösen
    ],
    $
      1) & space F_Z = -m dot v^2/r = -0.25"kg" dot (50"m"/"s")^2/(1000"m") \
         & space quad space.thin = -0.625"N" \
      2) & space F_a = m dot a = 0.25"kg" dot -0.8 "m"/"s"^2 = -0.2"N" \
      3) & space F_"äussere" = sqrt(F_Z^2 + F_a^2) \
         & space quad quad quad = sqrt((-0.625"N")^2 + (-0.2"N")^2) \
         & space quad quad quad = 0.656"N" \
      4) & space F_"äussere" = F_(H, min) space => space F_"äussere" = mu_"gleit" dot F_N \
      5) & space F_N = m dot g = 0.25"kg" dot 9.81"m"/"s"^2 = 2.45"N" \
      6) & space mu_"gleit" = F_"äussere"/F_N = (0.656"N")/(2.45"N") = underline(0.27)
    $,
  )
]

== Das Newtonsche Gravitationsgesetz <gravitationsgesetz>
Die Gravitationskraft, die ein Teilchen $A$ der Masse $m_A$ von einem Teilchen $B$ mit Masse $m_B$ erfährt, wird mit der
untenstehenden Formel berechnet. Dabei wird angenommen, dass sich der Ursprung des Koordinatensystems im Zentrum des
schwereren Teilchens $B$ befindet und dass die Ausdehnung der Teilchen $A, B$ deutlich kleiner ist als $abs(hk(r)_A)$.
Die _Gravitationskonstante $bold(Gamma)$_ bildet die universell gültige Stärke der Gravitation ab.

#definition(
  grid(
    $
      hk(F)_(G, A) = -m_A dot Gamma dot m_B/(abs(hk(r)_A)^2) dot hat(hk(r))_A\
      Gamma = (6.67430 plus.minus 0.00015) dot 10^(-11) "Nm"^2/"kg"^2
    $,
    [
      _$bold(F_(G, A))$:_ Gewichtskraft des Teilchens $A$\
      _$bold(hk(r)_A)$:_ Radius des Teilchens $A$\
      _$bold(hat(hk(r))_A)$:_ Einheitsvektor des Teilchens $A$: $hk(r)/abs(hk(r))$\
      _$bold(m_A\, m_B)$:_ Masse des Teilchens $A, B$\
      _$bold(Gamma)$:_ Gravitationskonstante
    ],
  ),
)

=== Keplerschen Gesetze
#grid(
  columns: (1fr, 1fr),
  [
    + Die Umlaufbahnen aller Planeten sind ellipsen-förmig. Die Sonne steht in einem der Brennpunkte der Ellipse.
    + Die Verbindungslinie zwischen Sonne und Planet benötigt für die Überquerung der mit $Delta t$ markierten
      Ellipsenabschnitte dieselbe Zeit. Die grün markierten Flächen sind gleich gross.
    + Die Umlaufzeit $T$ eines Planeten ist proportional zur Hauptachse $h$ der Ellipse: $T^2 ~ h^3$
  ],
  image("img/kepler.png"),
)

=== Kosmische Kreisbahnen
In der Kosmologie ist die Kreisbahn durch die Zentripetalkraft der Gravitation der Himmelskörper vorgegeben.
Diese haben die Form
#definition(
  grid(
    align: horizon,
    $ hk(r)(t) = root(3, (Gamma dot M)/omega^2) dot vec(cos(omega dot t + phi_0), sin(omega dot t + phi_0)) $,
    [
      _$bold(Gamma)$:_ Gravitationskonstante\
      _$bold(M)$:_ Masse des Himmelskörpers\
      _$bold(omega)$:_ Winkelgeschwindigkeit/Kreisfrequenz\
      _$bold(phi_0)$:_ Winkel des Teilchens bei $t = 0$ (Phase)\
    ],
  ),
)

Bei einer vereinfachten Annahme, dass sich die Erde auf einer Kreisbahn um die Sonne bewegt, stimmt die Gravitation mit
der Zentripetalkraft überein.

#definition[$ F_G = F_Z quad => quad F(r) = -m_E dot omega^2 dot r $]


= Scheinkräfte <scheinkraft>
Scheinkräfte sind Kräfte, die nicht als fundamentale Kräfte gelten und somit in Inertialsystemen nicht vorkommen
#hinweis[(siehe @inertialsystem)]. Beobachter, welche sich nicht in einem Inertialsystem befinden, können Scheinkräfte
wie die Fliehkraft wahrnehmen.

#grid(
  [
    Im Bild haben wir diese Elemente:
    - _Inertialsystem $bold(I)$_ #hinweis[(orange)], in welchem das 2. Newtonsche Gesetz gilt.
    - _Bezugssystem $bold(B)$_ des Beobachters #hinweis[(grau)]. Kann ebenfalls ein Inertialsystem sein.
      Koordinatensystem zeigt in dieselbe Richtung wie $I$.
    - _Teilchen $bold(T)$_, wird aus $I$ & $B$ beobachtet.
  ],
  image("img/Bezugssystemwechsel.png"),
)

Auf das Teilchen $T$ wirkt die äussere Kraft $hk(F)^((I))_"äussere"$, welche sich aus den vier Grundkräften ergibt
#hinweis[(siehe @inertialsystem)].

Die Bahn des Teilchen kann auf zwei Arten beschrieben werden:

+ _Vom Ursprung des Inertialsystems aus gesehen: $bold(hk(r)^((I))_(T) (t))$_\
  Das Teilchen hat sich vom Ursprung von $I$ entlang $hk(r)^((I))_(T)$ zur aktuellen Position bewegt. Da im
  Inertialsystem das 2. Newtonsche Gesetz gilt, ist die Bewegungsgleichung aus dieser Perspektive
  _$bold(m dot.double(hk(r))^((I))_T = hk(F)^((I))_"äussere")$_.

+ _Aus der Sicht des Beobachters: $bold(hk(r)^((B))_T (t))$_\
  Das Teilchen hat sich vom Ursprung von $B$ entlang $hk(r)^((B))_T (t)$ zur aktuellen Position bewegt.
  Da sich der Beobachter $B$ nicht in einem Inertialsystem befinden muss, wissen wir #hinweis[(noch)] nicht, welche
  Bewegungsgleichung für $hk(r)^((B))_T (t)$ gilt. Es kann aber eine Beziehung zwischen $I$ und $B$ hergestellt werden,
  wenn die Position von $B$ relativ zu $I$ bekannt ist. Dazu nehmen wir an, dass der Beobachter sich zum Zeitpunkt $t$
  bei $hk(r)^((I))_B (t)$ befindet.
  #v(-0.5em)

  $ hk(r)^((B))_T (t) = hk(r)^((I))_T (t) - hk(r)^((I))_B (t) $

  Daraus folgt die Bewegungsgleichung für $B$. Da die Kraft des zweiten Teils der Bewegungsgleichung ausserhalb des
  Inertialsystems $I$ stattfindet, wird diese Kraft als _Scheinkraft_ oder _Trägheitskraft_ bezeichnet.
  #v(-0.5em)
  $
    m_T dot dot.double(hk(r))^((B))_T quad
    = quad m_T dot dot.double(hk(r))^((I))_T - m_T dot dot.double(hk(r))^((I))_B quad
    = quad hk(F)^((I))_"äussere" + hk(F)^((B))_"Schein"
  $

Die Scheinkraft hängt von der Masse des beobachteten Teilchens und der auf den Beobachter
#hinweis[(nicht das Teilchen!)] wirkendenden Beschleunigung ab.
Beschreibt der Beobachter also mehrere Teilchen, werden alle Teilchen um dieselbe Scheinkraft korrigiert,
wenn die Teilchen dieselbe Masse haben.

Die Scheinkraft kann auch als das _negative der auf den Beobachter wirkenden äusseren Kraft_ definiert werden.
Das klappt, weil die Bahn des Beobachters $hk(r)^((I))_B$ aus einem Inertialsystem beschrieben wurde und damit die
Newtonische Bewegungsgleichung $m_B dot dot.double(hk(r))^((I))_B = hk(F)^((I))_B$ erfüllt.
Damit wird also kompensiert, dass auf den Beobachter selbst Kräfte wirken.

#definition[
  $
    hk(F)^((B))_"Schein" & = - m_T dot.double(hk(r))^((I))_B quad quad quad
                           hk(F)^((B))_"Schein" & = - m_T / m_B hk(F)^((I))_B
  $
]

== Gravitation als Scheinkraft
Alle physikalischen Körper reagieren exakt auf dieselbe Weise auf die Gravitation.
Im Newtonschen Gravitationsgesetz ist die durch die Masse $M$ #hinweis[(z.B. Planet Erde)] auf einen Körper mit
Masse $m$ #hinweis[(Gegenstand)] ausgeübte Gravitationskraft proportional zu $m$ des Körpers.
Durch das zweite Newtonsche Gesetz $m dot.double(hk(r)) = hk(F)$ fällt die Masse $m$ weg.

#definition[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    $
      hk(F) = - Gamma (m dot M) / abs(hk(r))^3 dot hk(r)\
      dot.double(hk(r)) = - Gamma M / abs(hk(r))^3 dot hk(r)
    $,
    [
      _$bold(Gamma)$:_ Gravitationskonstante $~6.67430 dot 10^(-11) "Nm"^2/"kg"^2$\
      _$bold(m)$:_ Masse eines Körpers, auf die die Gravitation wirkt \
      _$bold(M)$:_ Masse des Gravitation ausübenden Körpers
    ],
  )
]

Die durch die _Masse $bold(M)$ bewirkte Beschleunigung_ anderer physikalischer Körper hängt also nur
von deren _relativer Position zu $M$_ und nicht von ihren individuellen Massen ab.

Ein Teilchen und ein Beobachter befinden sich im gleichen konstanten Gravitationsfeld $hk(g)$
#hinweis[(nach unten gerichtet)]. Zusätzlich wirkt auf das Teilchen eine Gesamtkraft $hk(F)$.
Der Beobachter selbst ist nur der Gravitation ausgesetzt.

#definition[
  #grid(
    align: horizon,
    $
      m_T dot.double(hk(r))^((I))_T & = hk(F)^((I)) + m_T hk(g)^((I)) \
      <=> dot.double(hk(r))^((I))_T & = hk(F)^((I)) / m_T + hk(g)^((I))
    $,
    $
      m_B dot.double(hk(r))^((I))_B & = m_B hk(g)^((I)) \
      <=> dot.double(hk(r))^((I))_B & = hk(g)^((I))
    $,
  )
]

Durch einen Bezugssystemwechsel kann die Gravitation zum Verschwinden gebracht werden.

== Corioliskraft
Durch die Corioliskraft wird ein Teilchen abgelenkt, wenn es sich in einem rotierenden System befindet
#hinweis[(drehende Scheibe, Planet)] und eine unterschiedliche Drehgeschwindigkeit als das System aufweist.

#grid(
  columns: (1.3fr, 1fr),
  align: horizon,
  [
    Die Scheibe dreht sich mit konstanter Winkelgeschwindigkeit $omega$. Ein Beobachter $B$ dreht sich mit der Scheibe.
    Das Teilchen $T$ bewegt sich mit gleichbleibender Geschwindigkeit $hk(v)^((B))_T$.
    Dabei erfährt es die äussere Kraft bestehend aus der _Zentripetalkraft $bold(hk(F)_Z)$_ und _Corioliskraft $bold(hk(F)_C)$_.

    #definition[
      $
        hk(F)_"äussere" = hk(F)_Z - hk(F)_C\
        hk(F)_Z = -m_T dot omega^2 dot hk(r)\
        hk(F)_C = -2 dot m_T dot vec(0, 0, omega) times vec(v^((B))_(T, x), v^((B))_(T, y), 0)
      $
    ]
  ],
  image("img/coriolis.png"),
)


= Energie und Arbeit
*Einheiten der Energie*
#v(-0.75em)
#table(
  columns: (1fr, 1fr, 1fr, 1.9fr),
  align: center,
  table.header([Basisgrösse], [Variable], [Masseinheit], [Basiswert]),
  [Energie], $E$, [Joule], $1"J" = 1"Nm" = 1 ("kg" dot "m"^2)\/"s"^2$,
  [Arbeit], $W$, [Joule], $1"J" = 1"Nm" = 1 ("kg" dot "m"^2)\/"s"^2$,
  [Leistung], $P = dot(W)$, [Watt], $1"W" = 1"J"\/"s"$,
)

== Energie
Energie hat die Einheit Joule. Sie kann sich in verschiedenen Arten zeigen.

_Potentielle Energie (Lageenergie):_ Ein Körper befindet sich durch seine Lage in einer Position, in welcher er Arbeit
verrichten könnte.\
*Beispiele:* Ball wird hochgehoben, Feder wird angespannt.
#definition[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    $ E_"pot" = m dot g dot h $,
    [
      _$bold(m)$:_ Masse des Körpers\
      _$bold(g)$:_ Beschleunigung durch Gravitation #hinweis[(Erde: $g = 9.81 m\/s^2$)]\
      _$bold(h)$:_ Höhendifferenz des Körpers vom Nullpunkt
    ],
  )
]

_Kinetische Energie:_ Durch Bewegung eines Körpers erzeugte Energie.\
*Beispiel:* Ball wird losgelassen
#definition[
  #grid(
    columns: (1fr, auto),
    align: horizon,
    $ E_"kin" = 1/2 dot m dot v^2 $,
    [
      _$bold(m)$:_ Masse des Körpers \
      _$bold(v)$:_ Geschwindigkeit, quadriert, damit Vorzeichen egal ist \
    ],
  )
]

_Wärmeenergie:_ Durch innere Kräfte erzeugte Energie wie Reibung oder Hitze.
Kann nur schlecht in potentielle oder kinetische Energie umgewandelt werden.

=== Energieerhaltungssatz
Die oben genannten Arten von Energien lassen sich ineinander umwandeln.
Dabei geht aber nie Energie verloren, es wird immer alle Energie in eine oder mehrere andere Energieformen umgewandelt.
Der _Energieerhaltungssatz_ sagt aus, dass die Summe der Energien _immer konstant bleibt_.
Er ist äquivalent zum 2. Newtonschen Gesetz.

Unten abgebildet ist der Energieerhaltungssatz _ohne Reibung._

#definition[
  $
          E_"kin" (t) & + E_"pot" (t) = "const" \
    1/2 dot m dot v^2 & + m dot g dot h = "const" \
  $
]

#colbreak()

Der Energieerhaltungssatz gilt in diesen Systemen, wenn Reibung ausgeblendet wird:
#v(-0.5em)
#table(
  columns: (1fr, auto, auto),
  align: horizon,
  table.header([System], [Potentielle Energie], [Totale Energie]),
  [Schiefer Wurf,\ freier Fall,\ schiefe Ebene,\ Fadenpendel],
  $ E_"pot" = m dot g dot h $,
  $ E = 1/2 dot m dot v^2 + m dot g dot h $,

  [Feder], $ E_"pot" = D/2 dot s^2 $, $ E = 1/2 dot m dot v^2 + D/2 dot s^2 $,

  [Gravitationsfeld],
  $ E_"pot" = (Gamma dot m_"Himmelsk." dot m_"Teilch.")/r $,
  $ E = 1/2 dot m_"T" dot v^2 - (Gamma dot m_"H" dot m_"T")/r $,
)

== Mehrteilchensysteme
In _nicht-wechselwirkenden Mehrteilchensystemen_ #hinweis[(Die Teilchen haben keinen Einfluss aufeinander)] gilt der
Energieerhaltungssatz für beide Teilchen zusammen.
$E_"pot"$ hängt von der Position $x$ der Teilchen ab und wird auch als _Potential $bold(V(x))$_ bezeichnet.

$ E_"tot" = E_"kin" + E_"pot" = sum_(i = 1)^2 1/2 m_i dot v_i^2 + sum_(i = 1)^2 V(x_i) $

In _wechselwirkenden Mehrteilchensystemen_ haben die einzelnen Teilchen _keine potenzielle Energie mehr_.
Nur für das Gesamtsystem kann ein Energieerhaltungssatz aufgestellt werden.
Die potentielle Energie "liegt im Feld" und wird durch die _Wechselwirkung $bold(U)$_ definiert.

#definition[
  $ E_"tot" = E_"kin" + E_"pot" = 1/2 m_1 dot dot(x)_1^2 + 1/2 dot m_2 dot dot(x)_2^2 + U(x_1 - x_2) $
]

Die Wechselwirkung $U$ hängt meist nur vom Abstand der Teilchen ab.
Für verschiedene Szenarien gibt es unterschiedliche Formeln.
Bei mehreren Teilchen muss immer das Teilchen mit den grösseren Koordinaten zuerst stehen.\
#hinweis[($l_0$: Länge der nicht-gespannten Feder, $M$: Masse der Sonne, $m$: Masse des Planets)]

#table(
  columns: (auto, 1fr),
  table.header([Szenario], [Formel $bold(U = E_"pot")$]),
  [Feder mit einem Teilchen], $ E_"pot" = 1/2 D dot (x - l_0) $,
  [Feder zwischen 2 Teilchen], $ E_"pot" = 1/2 D dot (x_2 - x_2 - l_0)^2 $,
  [Gravitation von 1 Teilchen\ #hinweis[(Sonne zu Planet)]], $ E_"pot" = -(Gamma dot M dot m)/abs(hk(r)) $,
  [Gravitation zw. 2 Teilchen\ #hinweis[(2 Planeten)]], $ E_"pot" = -(Gamma dot m_1 dot m_2)/(abs(hk(r)_1 - hk(r)_2)) $,
)

Da die Teilchen aufeinander wirken, sind auch die Bewegungsgleichungen der Teilchen von der Position beider Teilchen
abhängig.
$
  m_1 dot dot.double(x)_1 = F_1(x_1, x_2) quad quad quad
  m_2 dot dot.double(x)_2 = -F_1(x_1, x_2)
$

== Konservative Kräfte <konservative-kräfte>
Als konservative Kräfte gelten Kräfte, deren Kraft unabhängig von der erbrachten Arbeit ist.
Beispielsweise ist die Gravitationskraft konservativ, da sie immer dieselbe ist, egal wie viel Arbeit erbracht wird.
Das Gegenteil sind _dissipative Kräfte_, wie z.B. Reibung. Sie verrichten Arbeit proportional zum Weg.
Durch Luftreibung kehrt ein Bungee-Springer nicht mehr zur Ausgangshöhe zurück.

Eine dissipative Kraft scheint den Energieerhaltungssatz zu verletzten.
Die Energie, die z.B. durch Reibung "verloren" geht, wird aber auf atomarer Ebene in sogenannte _innere Energie_ umgewandelt.
Sie lässt sich in Form von Temperatur indirekt messen.

$ E_"kin" + E_"pot" + E_"innere" = "const" $

Eine konservative Kraft im 2D/3D-Raum erzeugt ein _konservatives Kraftfeld_.

=== Test für Konservative Kraft
Es gibt zwei Kriterien, die eine Kraft erfüllen muss, um als _konservativ_ zu gelten:
+ Die Kraft hängt nur von der Position $hk(r)$ des Teilchens ab. Die Kraft gilt dann auch als Kraftfeld.
+ Wenn die partielle Ableitung der Komponenten den Wert $-hk(F)$ ergibt.
  Diese Funktion ist der _Gradient $bold(nabla V(hk(r)))$_ #hinweis[(Nabla-Operator)]. Somit gilt

#definition[
  $
    nabla V(hk(r)) = vec(dif/(dif x) V(hk(r)), dif/(dif y) V(hk(r)), dif/(dif z) V(hk(r)))\
    hk(F)(hk(r)) = - nabla V(hk(r))
  $
]

*Beispiel: Innere Energie auf der schiefen Ebene*\
#example-block[
  _Auf einer schiefen Ebene steht ein Körper mit der Masse $m = 3"kg"$ auf der Höhe $h_0 = 3"m"$.
  Er rutscht die Ebene hinunter bis zum Punkt $h_1 = 2"m"$. Hier hat er eine Geschwindigkeit von $v_1 = 2"m"/"s"$.
  Wie viel innere Energie wird produziert?_

  #grid(
    columns: (1fr, auto),
    [
      + Energiebilanz für beide Positionen aufstellen
      + Wenn die Veränderung der Inneren Energie $Delta E_"innere"$ von $E_0$ zu $E_1$ dazugerechnet wird, sind die
        beiden Energien durch den Energieerhaltungssatz gleich.
      + Durch Umformen erhalten wir die Veränderung der Inneren Energie
    ],
    $
      1) & space E_0 = m dot g dot h_0 \
         & space E_1 = m dot g dot h_1 + 1/2 dot m dot v_1^2 \
      2) & space E_0 = E_1 + Delta E_"innere" \
      3) & space Delta E_"innere" = m dot g dot (h_0 - h_1) - 1/2 dot m dot v_1^2 \
         & space Delta E_"innere" = 3"kg" dot 9.81 "m"/"s"^2 dot 1"m" - 1/2 dot 3"kg" dot (4"m"/"s")^2 \
         & space Delta E_"innere" = underline(5.43"J")
    $,
  )
]

== Arbeit
Innerhalb eines _abgeschlossenen Systems_ findet kein Energieaustausch mit der Aussenwelt statt, es gilt also der
Energieerhaltungssatz. Fügt man einem System von aussen Energie zu, _verrichten wir Arbeit am System_.
Wird dem System Energie entzogen und der Aussenwelt hinzugefügt, _verrichtet das System Arbeit._
Die Arbeit hat die _Einheit Joule_ und das Zeichen _$bold(W)$_.

Die Arbeit wird anhand der _Energiebilanz_ gemessen.
#definition[$ W = E_"nachher" - E_"vorher" $]

Bei _Bewegungen_ wird die Arbeit anhand der geleisteten Kraft $F$ und der Strecke $s$ gemessen.

#definition[$ W = F dot s $]

#grid(
  columns: (1fr, 1fr),
  [
    Die verrichtete Arbeit hängt nur von der Anfangs- und Endposition eines Teilchens, aber nicht von seiner Bahn ab.
    Eine vollständige Kreisbewegung ist deswegen $W = 0$.

    Die an einer _schiefen Ebene ohne Reibung verrichtete Arbeit_ ist:
  ],
  image("img/schiefe_ebene_arbeit.png"),
)
#definition[$ W = m dot g dot sin(alpha) dot (r_0 - r_1) $]

*Beispiel: Arbeit, um Körper an der schiefen Ebene mit Reibung hochzuziehen*\
#example-block[
  _Welche Arbeit muss geleistet werden, um einen Körper mit der Masse $10"kg"$ auf einer schiefen Ebene mit der Neigung
  $alpha = 30°$ hinaufzuziehen, wenn die Höhendifferenz\ $h = 10"m"$ und der Gleitreibungskoeffizient $mu_G = 0.3$
  beträgt?_

  Die geleistete Arbeit $W$ ist die Kraft parallel zum Weg $F$ mal die gesamte Wegstrecke~$s$, also $W = F dot s$.
  #grid(
    columns: (1fr, auto),
    [
      + Auf der schiefen Ebene mit Reibung besteht die Kraft aus der Reibung und der Gewichtskomponente parallel zur
        schiefen Ebene
      + Die Normalkraft besteht aus der senkrechten Gewichtskomponente. Damit kann die Reibungskraft bestimmt werden.
      + Die Arbeitsformel aufstellen und $F$ mit $F_R$ und $F_G dot sin alpha$ ersetzen.
        $s$ kann ebenfalls mit $h/(sin alpha)$ ersetzt werden.
      + $sin alpha$ in die Klammer nehmen
      + $F_G = m dot g$ und Kotangens einsetzen und Werte einsetzen
    ],
    $
      1) & space F = F_R + F_G dot sin alpha \
      2) & space F_R = mu_G dot F_N = mu_G dot F_G dot cos alpha \
      3) & space W = (F_R + F_G dot sin alpha) dot s \
         & space quad space.hair = (mu_G dot F_G dot cos alpha + F_G dot sin alpha) dot s \
         & space quad space.hair = (mu_G dot cos alpha + sin alpha) dot F_G dot s \
         & space quad space.hair = (mu_G dot cos alpha + sin alpha) dot F_G dot h/(sin alpha) \
      4) & space W = (mu_G dot (cos alpha)/(sin alpha) + 1) dot F_G dot h \
      5) & space W = (mu_G dot cot alpha + 1) dot m dot g dot h \
         & space W = (0.3 dot cot 30° + 1) dot 10"kg" dot 9.81 "m"/"s"^2 dot 10"m" \
         & space quad space.hair = underline(1491"J")
    $,
  )
]

=== Leistung
Leistung ist Arbeit pro Zeit. Je höher die Leistung, desto mehr Energie wurde pro Zeiteinheit verrichtet.
Die Leistung ist eine Ableitung der Arbeit und wird in der Einheit _Watt_ gemessen, was $1 "J"/"s"$ entspricht.

#definition[$ P(t) = dif/(dif t) W(t) = dot(W)(t) quad quad P = dot(W) $]

Je schneller sich der Körper bewegt, desto grösser die Leistung, die auf den Körper einwirkt.
Das zeigt sich beispielsweise an der _Leistung an der schiefen Ebene_:

$ P = m dot g dot v dot sin(alpha) $

Für Aufgaben mit Kraft gilt

#definition[$ P = F dot v $]


= Kraft und Impuls
In einem _abgeschlossenen System_ wirken nur Kräfte, deren Ursachen innerhalb dieses Systems liegen.
Für ein abgeschlossenes System gilt: Die Summe aller äusseren Kräfte, die auf Teilchen in einem
abgeschlossenen System wirken, ist gleich Null.

#definition[$ F_"tot" = 0 $]

== Impuls
Der _Impuls $bold(hk(p))$_ beschreibt den Bewegungszustand eines Körpers, basierend auf seiner Masse und Geschwindigkeit.
Haben zwei Teilchen dieselbe Geschwindigkeit, aber unterschiedliche Massen, hat das Teilchen mit der
grösseren Masse den höheren Impuls. Er hat die Einheit _$bold(("kg" dot "m") / "s" = "Ns")$_.

#definition[$ hk(p) = m dot hk(v) $]

Der Impuls kann von einem Körper ganz oder teilweise auf einen anderen übertragen werden, z.B. wenn eine rollende Kugel
eine stillstehende trifft. Die stillstehende Kugel rollt dann weg, während die rollende Kugel nur noch kleine Bewegungen
durchführt.

Die _Schwerpunktgeschwindigkeit $bold(u)$_ eines Systems ist die Geschwindigkeit, die ein einzelnes Teilchen hätte,
wenn es den Impuls und die Masse aller Teilchen im System besitzen würde.

#definition(
  grid(
    align: horizon,
    $ u = (sum m_i dot v_i)/(sum m_i) $,
    [
      _$bold(m_i)$:_ Masse eines Teilchens \
      _$bold(v_i)$:_ Geschwindigkeit eines Teilchens \
    ],
  ),
)

Je nach Geschwindigkeit und Masse kann die Kraft, die beim Zusammenstoss zwischen den Körpern übertragen wird, variieren.
Die _mittlere übertragene Kraft $bold(dash(F))$_ ist die durchschnittliche Kraft, die beim Zusammenstoss
zwischen den Teilchen übertragen wird.

#definition(
  grid(
    align: horizon,
    $
      dash(F) = (Delta p)/(Delta t) \
      cases(Delta p = 2p ", wenn Teilchen abprallt")
    $,
    [
      _$bold(Delta p)$:_ Impulsunterschied der Teilchen \
      _$bold(Delta t)$:_ Zeit
    ],
  ),
)

=== Stossarten
Berühren sich zwei Teilchen, wird zwischen verschiedenen Stossarten unterschieden:
- _Elastischer Stoss:_ Die Summe der kinetischen Energien der Teilchen bleibt gleich, es geht keine kinetische Energie
  in innere Energie verloren.\
  *Beispiel:* Aneinanderstossende Kugeln, Ball prallt von Wand ab
- _Unelastischer Stoss:_ Nur der Impuls bleibt vorhanden, die Bewegungsenergie wird beim Stoss in Wärme oder Verformung
  umgewandelt.\
  *Beispiel:* Einschlag einer Gewehrkugel
- _Rückstoss:_ Die kinetische Energie ist vor dem Stoss grösser als vorher. Ausgelöst durch eine Vergrösserung der
  inneren Energie, z.B. durch chemische Reaktion.\
  *Beispiel:* Gewehrschuss

=== Impulserhaltungssatz
Analog zum Energieerhaltungssatz gibt es auch den _Impulserhaltungssatz_, der auch auf dem zweiten Newtonschen Gesetz
basiert. Er gilt auch für dissipative Kräfte, siehe @konservative-kräfte.

#definition[$ hk(F) = dot(hk(p)) $]

*Beispiel: Newtonpendel* \
#v(-0.75em)
#example-block[
  #grid(
    align: horizon,
    [
      _Zwei Kugeln werden nebeneinander an jeweils einer Schnur aufgehängt, so dass sie sich im Ruhezustand berühren.
      Beide Kugeln werden nun in entgegengesetzte Richtungen mit einem Winkel von $alpha = 40°$ ausgelenkt und
      anschliessend losgelassen. Die Kugeln prallen aneinander ab und erreichen beide wieder ihre Ausgangshöhe._
    ],
    image("img/pendel.png"),
  )
  #v(-0.75em)
  _Die Kugeln haben die Masse $m = 0.1"kg"$ und einen masselosen Faden mit der Länge $l = 0.2"m"$.
  Die Stossdauer wird mit $Delta t = 1 dot 10^(-4)"s"$ gemessen._

  _a) Bestimmen sie die Höhe $Delta h$, aus der die Kugeln losgelassen werden._

  Die Höhe kann mit Pythagoras berechnet werden.
  $
    cos(alpha) = (l - Delta h)/l quad => quad Delta h = l dot (1 - cos(alpha)) = 2"m" dot (1 - cos(40°)) = underline(0.047"m")
  $

  _b) Handelt es sich um einen elastischen oder inelastischen Stoss? Warum?_

  Elastisch, weil beide Kugeln wieder die Ausgangshöhe erreichen. Die Bewegungsenergie bleibt erhalten.

  _c) Bestimmen sie die Geschwindigkeit $v$, mit der sie sich treffen._

  Durch den Energieerhaltungssatz wird die potentielle Energie beim Loslassen in kinetische Energie umgewandelt.
  $
    E_"kin" = E_"pot" quad => quad
    1/2 dot m dot v^2 = m dot g dot Delta h quad => quad
    v = sqrt(2g dot Delta h) \
    v = sqrt(2 dot 9.81"m"/"s"^2 dot 0.047"m") = underline(0.96 "m"/"s")
  $

  _d) Bestimmen sie die Geschwindigkeit der Kugeln unmittelbar nach dem Zusammenstoss._

  Die Geschwindigkeit nach dem Stoss kann mit dem Energie- und Impulserhaltungssatz bestimmt werden.
  #grid(
    columns: (1fr, auto),
    [
      + Gleichsetzen der Impulse vor und nach dem Stoss
      + Da die Kugeln aus gleicher Höhe fallen gelassen werden, müssen sie auch dieselbe Geschwindigkeit haben.
        Sie bewegen sich aufeinander zu, deswegen muss ein Term negativ sein.
      + $-v_1$ für $v_2$ einsetzen, aber nicht für $v'_2$!
      + $m$ ausklammern. Die linke Seite ergibt dann 0
      + Mit $m$ erweitern, um $m$ wegzukürzen #hinweis[(fühlt sich illegal aa)], dann nach $v'_1$ auflösen
    ],
    $
      1) & space m dot v_1 + m dot v_2 = m dot v'_1 + m dot v'_2 \
      2) & space v_1 = -v_2 \
      3) & space m dot v_1 - m dot v_1 = m dot v'_1 - m dot v'_2 \
      4) & space m dot (v_1 - v_1) = m dot (v'_1 + v'_2) \
         & space 0 = m dot (v'_1 + v'_2) \
      5) & space 0/m = (cancel(m) dot (v'_1 + v'_2))/cancel(m) space => space 0 = v'_1 + v'_2 \
         & space v'_1 = -v'_2
    $,
  )

  Nach dem Stoss haben die Geschwindigkeiten denselben Betrag, aber entgegengesetzte Richtungen.
  Wir wissen, dass die Kugeln wieder ihre Ausgangshöhe erreichen. Damit gilt $v' = -v = -0.96 "m"/"s"$

  _e) Welche Kraft wurde während des Stosses von einer auf die andere Kugel im Mittel übertragen?_

  #grid(
    columns: (1fr, auto),
    [
      + Die Kugeln bremsen auf $0$ ab und beschleunigen in entgegengesetzter Richtung.
        Dafür ist der doppelte Impuls nötig.
      + Werte in Formel einsetzen. $t$ ist gegeben.
    ],
    $
      1) & space Delta p = 2 dot p = 2 dot m dot v \
      2) & space dash(F) = (2 dot m dot v)/(Delta t) = (2 dot 0.1"kg" dot 0.96"m"/"s")/(1 dot 10^(-4)"s") \
         & space dash(F) = underline(1920"N")
    $,
  )

  _f) Wie gross ist die Impulsänderung des Gesamtsystems bestehend aus beiden Pendeln?
  Ist der Gesamtimpuls des Systems enthalten?_
  #grid(
    columns: (1fr, auto),
    [
      + Die Änderung des Impulses des Gesamtsystems ist der Gesamtimpuls nach dem Stoss abzüglich dem Gesamtimpuls vor
        dem Stoss.
      + $p$ durch $m dot v$ ersetzen und $m$ ausklammern.
      + Es gilt: $v'_1 = -v_1$, $space v'_2 = -v_2$ und $space v_2 = -v_1$
    ],
    $
      1) & space Delta p_"ges" = p'_"ges" - p_"ges" \
         & space quad quad space = (p'_1 + p'_2) - (p_1 + p_2) \
      2) & space quad quad space = m dot v'_1 + m dot v'_2 - m dot v_1 - m dot v_2 \
         & space quad quad space = m dot (v'_1 + v'_2 - v_1 - v_2) \
      3) & space quad quad space = m dot (-v_1 - v_2 - v_1 - v_2) \
         & space quad quad space = m dot (v_2 - v_2 - v_1 + v_1) \
         & space Delta p_"ges" = m dot 0 = underline(0"Ns")
    $,
  )
]

/*
== Starrer Körper
- Ein starrer Körper kann sich nicht verformen. Er kann nur verschoben (Translation) oder Gedreht (Rotation) werden.
- Die Kräfte, die auf den Körper wirken, lassen sich in Totalkraft und Drehmoment (um einen Bezugspunkt) zusammenfassen.
  Für jede beliebige Kraftverteilung müssen wir nur diese beiden Grössen ausrechnen
- Gleichgewichtsbedingung des starren Körpers

#definition[
  $
    F_"tot" = sum_i F_i = 0 \
    M_"tot" = sum_i (r_i - r_c) dot F_i = 0
  $
]

*Beispiel:* Gesamtimpuls

#grid(
  $
    "geg:" p_A = m_A v_a quad , quad p_B = m_B v_B \
    d / (d t) p_A = F_A + F_(A B) quad , quad d / (d t) p_B = F_B + F_(B A) \
    F_(A B) = - F_(B A) \
    d / (d t) underbrace((p_A + p_B),"Gesamtimpuls") = F_A + F_B + (F_(A B) + F_(B A)) = underbrace(F_A + F_B, "externe Kräfte") \
    arrow.double "Die Bewegung des Gesamtsystem ist nur von externen Kräften abhängig" \
    hk(p) = hk(p_A) + hk(p_B) arrow.double "Der Gesamtimpuls eines Systems kann nur durch äussere Kräfte verändert werden." \
    d / (d t) P = 0 arrow.double "keine äussere Kräfte wirken"
  $,
  image("img/Gesamtimpuls.png")
)

*Beispiel:* Knall zweier Kugeln prallen aufeinander zu
$
  "geg:" m_1 = 139"g", space s_1 = 190"cm", space m_2 = 100"g", space s_2 = 285"cm" \
  "Gesamtimpuls: Vorher = Nachher" \
  m_1 v_1 + m_2 v_2 = m_1 v'_1 + m_2 v'_2 = 0 \
  arrow m_1 v'_1 = - m_2 v'_2 arrow v'_1 = - m_2 / m_1 v'_2 \
  s_1 = v'_1 t, space s_2 = v'2_2 t arrow v'_1 = s_1 / t, space v'_2 = s_2 / t \
  m_1 s_1 / t = - m_2 s_2 / t \
  arrow s_1 m_1 = - s_2 m_2 arrow m_1 / m_2 = abs(s_2 / s_1) \
  m_1 / m_2 = (139"g") / (100"g") = 1.39 \
  s_2 / s_1 = (285"cm") / (190"cm") = 1.5
$
*/
