// Compiled with Typst 0.15.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "ComGra",
  fach-long: "Computergrafik",
  semester: "HS25",
  language: "de",
  column-count: 6,
  font-size: 5pt,
  landscape: true,
  heading-page-number-in-ref: false,
)

// Decrease text size in code blocks
#show raw.where(block: true): set text(size: 0.75em)

// Render a SVG as image and source code
#let render-svg(svg, image-width: 100%) = {
  let code = raw(lang: "svg", block: true, svg)
  let image = image(format: "svg", width: image-width, bytes(svg))
  (image, code)
}

#v(-1.5em)

= Grundlagen
Das folgende Bild vergleicht ein Koordinatensystem in der Mathematik mit einem Koordinatensystem auf dem
Computerbildschirm. Die $y$-Achse zeigt auf dem Bildschirm nach unten.
#image("img/coordinates.png")

*Punkt:*
wird mit einer $x$- und einer $y$-Koordinate beschrieben: $P = (p_x, p_y)$\
*Vektor:*
Verbindung von zwei Punkten im Koordinatensystem. $arrow(p) = (p_x p_y)^T$ ist der Vektor, der von $0$ zu $P$ führt.\
*Polygon:*
Folge von Punkten, verbunden mit Linien, mit selbem Start- & Endpunkt.
_Konvex:_ Von jeder beliebigen Ecke des Polygons kann eine gerade Linie zu allen anderen Ecken gezogen werden.
_Konkav:_ Bei mindestens einer Ecke geht das nicht.


= Linien
Aus einem _Anfangs- und einem Endpunkt_ $P_1 = (x_1, y_1)$ und $P_2 = (x_2, y_2)$ einer Linie $l$ sind die
_rasterisierten Pixel_ zu berechnen.

== Bresenham-Algorithmus
Der Algorithmus funktioniert so, dass man in der _"schnellen" Richtung_, also die Richtung, in die die Linie eher geht,
_immer einen Pixel färbt_, und in die andere Richtung nur falls nötig.

#grid(
  [
    Dieser Algorithmus funktioniert nur für die Linien _im ersten Oktant_ #hinweis[(der mit der roten Linie rechts)].
    Für die restlichen 7 Oktanten müssen die Linien zuerst _gespiegelt_ oder die Endpunkte _vertauscht_ werden.
    + *Falls $x_2 < x_1$:*\ $x_1$ mit $x_2$ tauschen
    + *Falls $(y_2 - y_1) < 0:$*\ Punkte an $x$-Achse spiegeln
  ],
  image("img/bresenham_octants.png"),
)
#v(-0.5em)
3. *Falls $(y_2 - y_1) > (x_2 - x_1)$:* Steigung ist grösser als $45°$, Linie muss an $45°$ Achse gespiegelt werden.

```java
zeichneLinie(startX, startY, endX, endY)       // Bresenham Pseudocode
  deltaX = endX - startX; deltaY = endY - startY
  steigung = deltaY / deltaX
  x = startX; y = startY; fehler = 0

  while x <= endX
    setzePixel(x, y); x = x + 1
    fehler = fehler + steigung
    if fehler > 0.5
      y = y + 1; fehler = fehler - 1
```
#image("img/bresenham.png")

== Anti-Aliasing
Um keine _"Ecken"_ in der Linie zu haben, können die Pixel _prozentual_ zum Anteil der Linie im Pixel _gefärbt_ werden.
*Beispiel:* 60% Überlappung mit Ideallinie $->$ Pixel hat 60% Grauwert.

= 2D-Transformationen
Mithilfe von Transformationen ist es möglich, die _Position_, die _Orientierung_, die _Form_ und die _Grösse_ von
grafischen Objekten zu _manipulieren_. Transformationen eines Objekts werden durch die _Operationen auf den
Definitionspunkten_ realisiert. Durch 2 Punkte definierte Rechtecke müssen zunächst zu _Polygonen_ gemacht werden
#hinweis[(Rechteck wird in zwei Dreiecke aufgeteilt)].

== Translation
Eine _gradlinige Verschiebung_ um einen Translationsvektor $T$ ist definiert durch $T := (t_x, t_y)$,
d.h. wird zu jedem Punkt $P_i$ die Translation dazu gezählt: $P' = P + T$.
#align(image("img/2d_translation.png", width: 80%), center)

== Skalierung
Durch Skalierung wird jeder Punkt anhand eines _Fixpunktes $bold(s)$_ vergrössert bzw. verkleinert.
Im einfachsten Fall liegt der Fixpunkt im Ursprung $(0,0)$:
$(x', y') := (s_x dot x, s_y dot y)$

Wenn $s_x = s_y$ handelt es sich um eine _uniforme Skalierung_ #hinweis[(Proportionen bleiben erhalten)],
bei $s_x != s_y$ um eine _Verzerrung_. Damit das Objekt zweidimensional bleibt, muss $s_x, s_y != 0$ sein.

=== Beispiel
Folgendes Quadrat wird mit $s_x = 4, s_y = 2$ skaliert #hinweis[(Verzerrung)]:
#align(image("img/2d_scaling.png", width: 80%), center)

=== Skalierung mit Fixpunkt <scale-fixedpoint>
Bei Skalierung mit einem Fixpunkt $(Z_x, Z_y)$ für den Punkt $P$ müssen die folgenden drei Schritte abgearbeitet werden:

+ _Translation_ um $(-Z_x, -Z_y)$. Verschiebt $P$ zum Nullpunkt, dies ist nun $P_1$
  #hinweis[(Damit ist eine Skalierung ohne Verschiebung möglich)]
+ _Skalierung_ mit $(s_x, s_y)$ liefert $P_2$.
+ _Translation_ um $(Z_x, Z_y)$ liefert $P_3 eq P'$ #hinweis[(Zurück zum Startpunkt)].

Zusammengefasst ergibt das diese Formel für die Berechnung:
$ (x',y') := ((x-Z_x) dot s_x + Z_x, quad (y-Z_y) dot s_y + Z_y) $

==== Beispiel: Skalierung mit *$s_x = 3, space s_y = 2, space Z = (1, 3)$*
+ *Ausgangslage:* $P$ ist bei $x = 3$ und $y = 2$.
+ *Translation um $(-Z_x = -1, space -Z_y = -3)$:*\
  $P(3,2) + (-1, -3) = P_1(2,-1)$
+ *Skalierung mit $(s_x = 3, space s_y = 2)$:*\
  $P_1(2, -1) dot (3, 2) = P_2(6, -2)$
+ *Translation um $(Z_x, Z_y)$:*\
  $P_2(6, -2) + (1, 3) = P_3(7,1) = P'.$

#image("img/scaling_fixedpoint.png")

#v(-0.5em)
Oder eingesetzt in die Formel:
$ (x',y') colon.eq ((3-1) dot 3 + 1, quad (2-3) dot 2 + 3) = underline((7,1)) $

== Rotation
Die Drehung des Objekts anhand eines _Fixpunktes_ um einen Drehwinkel $beta$.
Wenn der Fixpunkt im _Ursprung_ liegt, gilt:
#grid(
  align: horizon,
  [
    $
      x' = L dot cos(alpha + beta) \
      y' = L dot sin(alpha + beta) \
      ... \
      x' = x dot cos(beta) - y dot sin(beta) \
      y' = x dot sin(beta) + y dot cos(beta)
    $
    Positive Werte für $beta$ bewirken eine _Rotation gegen_ #hinweis[(Koordinatensystem)] bzw. _mit dem Uhrzeigersinn_
    #hinweis[(Bildschirm)].
  ],
  image("img/2d_rotation.png"),
)
#hinweis[Siehe Bild in @koord-sys-wechsel für $cos$ / $sin$ Werte.]

=== Beliebiges Rotationszentrum
Bei Wahl eines beliebigen Rotationszentrums $(R_x, R_y)$ folgt für den Punkt $P$
#hinweis[(Analog zu @scale-fixedpoint)]:
+ _Translation_ um $(-R_x, - R_y)$ liefert $P_1$
+ _Rotation_ im Ursprung um Winkel $beta$ liefert $P_2$
+ _Translation_ um $(R_x, R_y)$ liefert $P_3 = P'$

== Matrixdarstellung
Kann mehrere Transformationen zu einer zusammensetzen, um Rundungsfehler zu vermindern.
So sieht eine _Skalierung_ in Matrixschreibweise aus:

$ mat(x'; y') = mat(s_x, 0; 0, s_y) dot mat(x; y) = mat(x dot s_x; y dot s_y) $

Und so sieht eine _Rotation_ in Matrixschreibweise aus:

$
  mat(x'; y') = mat(cos(beta), -sin(beta); sin(beta), cos(beta)) dot mat(x; y)
  = mat(x dot cos(beta) - y dot sin(beta); x dot sin(beta) + y dot cos(beta))
$

=== Homogene Koordinaten
Für eine _Translation mit Matrizen_ benötigen wir eine dritte Koordinate. Ein Punkt $P = (x,y)$
hat mit $w != 0$ #hinweis[($w$ ist meistens 1, falls nicht, können $x,y,w$ durch $w$ geteilt werden)]
folgende homogenen Koordinaten:
#v(-1em)
$ mat(x; y; w) $

==== Richtungsvektor
Der Richtungsvektor $arrow(r)$, der vom Ursprung zum Punkt $R = (x,y)$ führt, hat die _homogenen Koordinaten_
$mat(x, y, 0)^T$

== Allgemeine Transformationen <matrix-transformationen>
==== Translation
$ mat(x'; y'; 1) = mat(1, 0, t_x; 0, 1, t_y; 0, 0, 1) dot mat(x; y; 1) = mat(x + t_x; y + t_y; 1) $

==== Skalierung
$ mat(x'; y'; 1) = mat(s_x, 0, 0; 0, s_y, 0; 0, 0, 1) dot mat(x; y; 1) = mat(x dot s_x; y dot s_y; 1) $

==== Rotation
#v(0.5em)
#align(center)[
  $mat(x'; y'; 1) = mat(cos(beta), - sin(beta), 0; sin(beta), cos(beta), 0; 0, 0, 1) dot mat(x; y; 1)
  = mat(x dot cos(beta) - y dot sin(beta); x dot sin(beta) + y dot cos(beta); 1)$

]

*Beispiel:* Zusammengesetzte Transformation: 60° Rotation um $(-3, 5)$.
#hinweis[($A$: Translation Nullpunkt, $B$: Rotation, $C$: Rücktranslation)]
$
  A = mat(1, 0, -3; 0, 1, -5; 0, 0, 1), space
  B = mat(0.5, -0.866, 0; 0.866, 0.5, 0; 0, 0, 1), space
  C = mat(1, 0, 3; 0, 1, 5; 0, 0, 1)\
  D = C dot B dot A = mat(0.5, -0.866, 5.83; 0.866, 0.5, -0.098; 0, 0, 1)
$
==== Ist die Transformation kommutativ?
#table(
  columns: (1fr, auto, auto, auto),
  table.header([*$1. arrow.b, 2. arrow$*], [Translation], [Skalierung], [Rotation]),
  [_Translation_], cell-check, cell-cross, cell-cross,
  [_Skalierung_], cell-cross, cell-check, cell-tilde,
  [_Rotation_], cell-cross, cell-tilde, cell-check,
)
#hinweis[Skal. und Rot. sind nur kommutativ, wenn Skalierung in $x$ und $y$-Richtung gleich ist.]

Weitere Transformationen, die sich durch Matrizen darstellen lassen, sind:
_Spiegelung_ an einer beliebigen _Geraden_, _Spiegelung_ an einem _Punkt_ und _Scherung_.

==== Scherung
Bei einer Scherung in $x$-Richtung bleiben die $y$-Werte konstant, und die $x$-Werte werden proportional zu den $y$-Werten
horizontal verschoben, also $x' = x + "Sch"_y dot y$. Transformationsmatrix:

#grid(
  [
    *Scherung in $x$-Richtung*
    $ mat(1, "Sch"_x, 0; 0, 1, 0; 0, 0, 1) $
  ],
  [
    *Scherung in $y$-Richtung*
    $ mat(1, 0, 0; "Sch"_y, 1, 0; 0, 0, 1) $
  ],
)

*Beispiel: Finde die Transformationsmatrix*
#image("img/scherung.png")
+ Ein Punkt in Gleichung einsetzen, bspw. Punkt links unten:
  $
    mat(1, "Sch"_x, 0; 0, 1, 0; 0, 0, 1) dot
    mat(#fxcolor("rot", $1$) ; #fxcolor("grün", $1$) ; #fxcolor("gelb", $1$)) = mat(3; 1; 1)
  $
+ Dies ergibt folgende Gleichung, um $"Sch"_x$ herauszufinden:
  $
    1 dot #fxcolor("rot", $1$) + "Sch"_x dot #fxcolor("grün", $1$) + 0 dot #fxcolor("gelb", $1$) & = 3 \
                                                                                     1 + "Sch"_x & = 3 quad | -1 \
                                                                                         "Sch"_x & = 2
  $
+ Kontrolle mit anderem Punkt #hinweis[(hier Punkt rechts oben)]:
  $
    mat(1, bold(2), 0; 0, 1, 0; 0, 0, 1) dot mat(3; 3; 1) =
    mat(
      1 dot 3 + 2 dot 3 + 0 dot 1;
      0 dot 3 + 1 dot 3 + 0 dot 1;
      0 dot 3 + 0 dot 3 + 1 dot 1
    ) = mat(9; 3; 1) checkmark
  $


$"Sch"_x = 2$, da $y$ $2$-mal grösser ist als $x$. Kann auch aus direkt aus Bild herausgelesen werden
#hinweis[(auf $2x$ verschiebt sich Punkt um $4y$)].


= Clipping
#grid(
  align: horizon,
  [
    Clipping is das _Abschneiden von Objekten_ am Rand eines gewünschten Bildschirmausschnittes oder Fensters.
    Dafür werden für eine Menge von Linien jeweils _neue Anfangs- und Endpunkte_ bestimmt, welche innerhalb
    des Clip-Fensters liegen.
  ],
  image("img/clipping_2d.png"),
)

== Cohen-Sutherland Algorithmus <cohen-sutherland>
Teile Ebene anhand des Clip-Fensters in _9 Bereiche_ ein, beschrieben durch _4-Bit-Bereichscode_.
`0000` ist der sichtbare Bereich.

*Codierung:*
#v(-0.5em)
#grid(

  [
    - #tcolor("gelb", `XXX1:`, style: "normal") links vom Fenster #hinweis[(Bit 0)]
    - #tcolor("grün", `XX1X:`, style: "normal") rechts vom Fenster
  ],
  [
    - #tcolor("orange", `X1XX:`, style: "normal") unter dem Fenster
    - #tcolor("rot", `1XXX:`, style: "normal") über dem Fenster
  ],
)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0pt,
  align: center,
  inset: 0.6em,
  stroke: (x, y) => if (x == 1 and y == 1) { 0.25em + colors.hellblau } else { 0.1em },
  [#tcolor("rot", `1`, style: "normal")`0``0`#tcolor("gelb", `1`, style: "normal")],
  [#tcolor("rot", `1`, style: "normal")`000`],
  [#tcolor("rot", `1`, style: "normal")`0`#tcolor("grün", `1`, style: "normal")`0`],

  [`000`#tcolor("gelb", `1`, style: "normal")], [`0000`], [`00`#tcolor("grün", `1`, style: "normal")`0`],

  [`0`#tcolor("orange", `1`, style: "normal")`0`#tcolor("gelb", `1`, style: "normal")],
  [`0`#tcolor("orange", `1`, style: "normal")`00`],
  [`0`#tcolor("orange", `1`, style: "normal")#tcolor("grün", `1`, style: "normal")`0`],
)

Die Anfangs- und Endpunkte von Linien werden durch die Funktion _`Code(P)`_ mit dem Code des Bereichs versehen,
in welchem der Punkt liegt. Wenn _1 Bit_ von Anfang- und Endpunkt _gleich_ ist, ist die Linie _komplett ausserhalb_ des
Clipping-Fensters. Es wird im (Gegen-)uhrzeigersinn jeder Rand des Fensters geclippt.

#image("img/clipping_example.png")
=== Implementierung
*```java byte region_code(Point P)```:*
Setzt den Region Code pro\ Anfangs- und Endpunkt wie oben beschrieben.\
*```java void set_clip_window(Point P, Point delta)```:*
Setzt die Variablen `xmin`, `ymin` auf den Ursprung $P$ des Clip-Fensters und `xmax`, `ymax` auf die Breite/Höhe
$delta$.\
*```java boolean cohenSutherland(Point p1, Point p2, Point Q1, Point Q2)```:*
Liefert `true`, falls die Gerade $p 1-p 2$ sichtbar ist. Der sichtbare Teil $Q 1 - Q 2$ ist in Out-Parametern
`Q1` & `Q2`.


= 2D-Füllen
Es gibt _zwei Ansätze_ zum Füllen eines Objekts mit Farbe oder Muster: Universell und Scan-Line.

== Universelle Verfahren
Stützen sich auf die _Nachbarschaft_ eines Pixels. Sind _sehr einfach rekursiv_ umzusetzen. Ein Nachteil ist der _hohe
Speicherbedarf_, der durch die Rekursion benötigt wird. Zum _Starten_ wird eine Begrenzung und ein Punkt innerhalb
der Form benötigt.

- _4-way-stepping:_ überprüft in 4 Richtungen, ob der nächste Punkt ebenfalls innerhalb der Form ist.
- _8-way-stepping:_ überprüft in 8 Richtungen, ob der nächste Punkt ebenfalls innerhalb der Form ist.

Beide Varianten haben ihre Probleme mit der Erreichbarkeit der Pixel. 4-way-stepping reicht aber meist aus.

#image("img/stepping.png")

== Scan-Line-Verfahren
Bewegt eine _waagerechte Scan-Linie_ schrittweise von oben nach unten über das Polygon, und berechnet die Schnittpunkte
der Scan-Linie mit dem Polygon.

+ _Sortiert_ alle Kanten nach ihrem grössten $y$-Wert #hinweis[(hier Liste A-J)].
+ _Bewegt_ die Scan-Linie vom grössten bis zum kleinsten $y$-Wert.
+ Für _jede Position_ der Scan-Linie werden:
  - die _Liste_ der _aktiven Polygonkanten_ ermittelt #hinweis[(Kanten, welche die Scanline berührt)]
  - die _Schnittpunkte_ _berechnet_ und nach $x$-Werten _sortiert_
  - jene _Scan-Line-Segmente_, die im _Inneren_ des Polygons liegen, _angezeigt_

#align(image("img/scanline.png", width: 80%), center)

*Problematik:* Wenn die Scan-Line an einem Schnittpunkt zweier Kanten #hinweis[($and.big$-Kante)] ankommt, muss direkt
ein neues Segment begonnen werden.


= 2D Grafiken im Web (SVG)
_SVG_ #hinweis[(Scalable Vector Graphics)] ist ein offener Standard eines Vektorgrafikformates auf XML-Basis.

#plus-list[
  + Kann nach Text durchsucht werden
  + Erlaubt Textgestaltung
  + Kann Objekte zeitlich koordiniert bewegen
  + Enthält Event Handling
  + verfügt über photoshop-artige Filter-Effekte
  + ist sowohl unkomprimiert als auch komprimiert einsetzbar
]
#minus-list[
  + verlangt Rechenleistung auf der Clientseite
  + erfordert zum Abspielen ein Plugin #hinweis[(heute nicht mehr)]
]

==== Beispiel Kreis
#let svg-circle = "<!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN'
  'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>
<svg width='200' height='200'
  xmlns='http://www.w3.org/2000/svg'
  xmlns:xlink='http://www.w3.org/1999/xlink' >
  <circle cx='100' cy='100' r='90' />
</svg>"

#let (circle-image, circle-code) = render-svg(svg-circle)

#grid(
  columns: (4fr, 1fr),
  circle-code, circle-image,
)

== Grundelemente
#let svg-grundelemente = "<svg version='1.1' xmlns='http://www.w3.org/2000/svg'
  xmlns:xlink='http://www.w3.org/1999/xlink' >
<title>Gerade, Rechteck, Kreis, Ellipse, Polygon, Text</title>
<rect x='50' y='64' fill='#A6460F' width='332' height='127'/>
<circle fill='#BFBC8A' stroke='#8B9654' stroke-width='2' cx='52'
  cy='175' r='49'/>
<polygon fill='#29769E' stroke='#1A4E69' stroke-width='2'
  points='231,223  305,132  258,36  307,22  366,65  409,132 333,223'/>
<ellipse fill='#F2C12E' stroke='#D98825' stroke-width='2'
  cx='187' cy='117' rx='25' ry='95'/>
<line fill='none' stroke='#A6460F' stroke-width='8' x1='25'
  y1='267' x2='433' y2='267'/>
<text style='font-family:JetBrains Mono; font-size:30px;
  font-weight:bold' x='25' y='255'>Umrandung und Füllung</text></svg>"

#let (grundelemente-image, grundelemente-code) = render-svg(svg-grundelemente, image-width: 70%)

#grundelemente-code
#v(-1em)
#align(center, grundelemente-image)

== Gruppierung von Elementen
Mit dem _`<g>`-Element_ können mehrere Objekte zusammengefasst werden. Werden über das `xlink:href`-Element referenziert
#hinweis[(wie `id` in HTML)] und mit `transform` transformiert.

*Achtung:* Transformationen beziehen sich auf das Koordinatensystem des Objektes.\
`transform="translate (200,0) rotate(45)"` bedeutet zuerst eine Drehung im Uhrzeigersinn um 45° und dann eine
Verschiebung um 200 Pixel längs der Diagonalen nach rechts unten.

==== Beispiel
```xml
<svg width="400" height="100" viewBox="0 0 400 100" ... >
  <defs>
    <g id="vorlage">
      <rect x="-40" y="-20" width="80" height="40" fill="#A6460F" />
      <circle cx="0" cy ="0" r="36" fill="#8B9654" />
    </g>
  </defs>
  <use xlink:href="#vorlage" transform="translate(80 50)" />
  <use xlink:href="#vorlage"
    transform="translate(160 50) rotate(30)" fill-opacity="0.8"/>
  <use xlink:href="#vorlage"
    transform="translate(240 50) rotate(60)" fill-opacity="0.5"/>
  <use xlink:href="#vorlage"
    transform="matrix(0.0 1.0 -1.0 0.0 320 50)" fill-opacity="0.2"/>
</svg>
```
#image("img/svg_example.png")

Der `x` und `y`-Wert des `rect` definiert, wo die obere linke Ecke liegt. Mit `x="-40", y="-20"` und der ersten
Translation von `(80 50)` führt das dazu, dass die obere Ecke zuerst bei `x="40"` und `y="30"` liegt
#hinweis[(Ohne die Minuswerte wäre die Ecke im Kreismittelpunkt)].

==== Matrix-Transformation
Die Matrix-Transformation in SVG hat 6 Parameter.\
`matrix(`
#tcolor("orange", `a `, style: "normal")
#tcolor("grün", `b `, style: "normal")
#tcolor("gelb", `c `, style: "normal")
#tcolor("rot", `d `, style: "normal")
#tcolor("dunkelblau", `e `, style: "normal")
#tcolor("hellblau", `f`, style: "normal")
`)`
$= mat(
  fxcolor("orange", a),
  fxcolor("gelb", c),
  fxcolor("dunkelblau", e);
  fxcolor("grün", b),
  fxcolor("rot", d),
  fxcolor("hellblau", f);
  0, 0, 1
)
= mat(0.0, -1.0, 320; 1.0, 0.0, 50; 0, 0, 1)$

Nun kann man die einzelnen Ecken mit einer Matrix Transformation umrechnen und erhält so die neuen Werte
#hinweis[(siehe @matrix-transformationen)].

*Im Beispiel wird der Punkt $(40,30)$ wie folgt umgewandelt:*

$
  mat(x_1; y_2; 1) = mat(0, -1, 320; 1, 0, 50; 0, 0, 1) dot mat(-40; -20; 1)
  = mat(-20 + 320; 40 + 50; 1) = mat(340; 10; 1)
$

== Pfade
`path`-Elemente zeichnen Kurven. Der Pfad ist im Attribut `d` definiert: `<path d="...">`.
Im Attribut können sich unter anderem folgende Kommandos befinden:
- _`M`:_ moveto #hinweis[(von einem Punkt zum nächsten bewegen)]
- _`A`:_ arcs #hinweis[(Erstellt einen Kreisbogen)]
- _`C`:_ curveto #hinweis[(Erstellt eine Kurve)]
- _`S`:_ smooth curveto #hinweis[(Erstellt eine glatte Kurve)]
- _`L`:_ lineto #hinweis[(Zeichnet gerade Linie zu x und y Koordinaten)]

==== Kreisbögen
```xml
<!-- Argumente für SVG Arcs -->
d="A rx ry x-axis-rotation large-arc-flag sweep-flag x y"
```

```xml
<path fill="none" stroke="red" d="
  M 300 100 <!-- starting point at (300,100) -->
  A 100 50  <!-- make an arc, x-Radius = 100, y-Radius = 50 -->
  0         <!-- x-axis-rotation in degrees  -->
  0         <!-- large-arc-flag: 0 short way, 1 long way -->
  0         <!-- sweep-flag: 0 counter-clockwise, 1 clockwise -->
  200 150   <!-- end at (200,160) -->
" />
```
#align(image("img/kreisbogen.png", width: 56%), center)


= Farben
Nur ein _Teil_ des elektromagnetischen Spektrums wird vom _Auge_ wahrgenommen:
Eine Wellenlänge von ca. $780$ - $380$ nm bzw. einer Frequenz von $3.8 dot 10^14$ bis $7.8 dot 10^14$ Hertz.

$"Wellenlänge" dot "Frequenz" = "Lichtgeschw." tilde.equiv 2.998 dot 10^8 "m"\/"s"$

_Spektralfarben_ bestehen aus Licht einer _einzigen Wellenlänge_. In der _Natur_ vorkommende Farben bestehen aus Licht,
das aus _verschiedenen Wellenlängen_ zusammengesetzt ist. Die Verteilung der Wellenlängen bezeichnet man als _Spektrum_.

== Charakterisierung
#grid(
  columns: (1.5fr, 1fr),
  [
    - _hue:_ Farbton, gegeben durch\ dominante Wellenlänge #hinweis[(hier $A$)]
    - _luminance:_ Helligkeit $A + B$
    - _saturation:_ Sättigung $A \/ (A + B)$
  ],
  image("img/characterization_colors.png"),
)

Der Mensch sieht 100 Farbtöne, 50 Helligkeitsstufen und 20 Sättigungsgrade.

#table(
  columns: (auto,) + (1fr,) * 3,
  table.header([], [Typ], [Anzahl], [Schwelle]),
  [_S/W_], [Stäbchen], [$125'000'000$], [$1$ Photon],
  [_Farbe_], [Zäpfchen], [$5'000'000$], [$100$ Photonen],
)
#align(image("img/farbrezeptoren.png", width: 70%), center)

== Grundfarben
#grid(
  [
    Durch Mischen von Farben entstehen neue Farben. Wähle _3 Grundfarben_, z.B, Rot, Grün und Blau. Bei einer
    _Normierung_ _*$R + G + B = 1$*_ lässt sich jede Kombination durch Angabe von _zwei Parametern_ beschreiben
    #hinweis[(der dritte lässt sich dann ausrechnen)].
  ],
  image("img/grundfarben.png"),
)
#v(-1em)

=== RGB Modell (additiv)
Ist _Licht-basiert_, geeignet für Bildschirme. Die drei RGB-Werte werden in $256$ Abstufungen als ganze Zahlen
angegeben, die in einem Byte kodiert werden. Die ganze Farbe kann also in drei Bytes definiert werden.

*Beispiel Farb-Addition:*
$(1,0,0) + (0,1,0) = (1,1,0)$
#align(image("img/rgb.png", width: 90%), center)

=== CMY-Modell (subtraktiv)
Beim _Farbdruck_ empfängt das Auge nur solche Anteile des weissen Lichtes, die _reflektiert_ werden. Ein CMY-Tripel
beschreibt, wie viel von den Grundfarben Cyan, Magenta und Yellow reflektiert bzw. von den Grundfarben Rot, Grün und
Blau absorbiert wird #hinweis[(Weiss reflektiert alles, für Farben muss Rot/Grün/Blau absorbiert werden)].

*Beispiele:*
- $(0,0,0)$ absorbiert nichts, ergibt Weiss
- $(0,0,1)$ absorbiert Blau, ergibt Gelb

*Beispiel Farb-Subtraktion:*
$(0,1,0) - (0,0,1) = (0,1,1)$

#align(image("img/cmy_modell.png", width: 90%), center)

==== Umrechnung
Die Umrechnung zwischen dem CMY-Modell und dem RGB-Modell erfolgt in _Vektorschreibweise_ über die Subtraktion.

$ mat(R; G; B) = mat(1; 1; 1) - mat(C; M; Y), quad mat(C; M; Y) = mat(1; 1; 1) - mat(R; G; B) $

=== CMYK-Modell
Verwendet zusätzlich _schwarze Farbe_, den _Key_. Wird beim Drucken verwendet.

*Umrechnungsnäherung mit Beispiel:*
#grid(
  $
     K & := min(C, M, Y) \
    C' & := C -K \
    M' & := M - K \
    Y' & := Y - K
  $,
  $
     K & = min(10, 15, 55) = 10 \
    C' & = 10 - 10 = 0 \
    M' & = 15 - 10 = 5 \
    Y' & = 55 - 10 = 45
  $,
)
Einer der Werte wird so immer $0$.

=== YUV-Modell
Wurde verwendet, um Fernsehbilder geräte-spezifisch entweder farbig oder S/W anzuzeigen. Ein Farbwert wird durch ein
YUV-Tripel beschrieben, wobei $Y$ die Helligkeit #hinweis[(Luminanz)] bezeichnet, und $U,V$ die Farbdifferenzen
#hinweis[(Chrominanz)].

=== HSV-Modell
Beschreibt jede Farbe durch das Tripel $H S V$.\
_Hue:_ Farbton, _Saturation:_ Sättigung, _Value:_ Helligkeit

#image("img/hsv-modell.png")


==== Umrechnung RGB nach HSV
// Creates a small box filled with the color in `fill`.
#let color-box(fill) = {
  box(height: 0.5em, width: 0.5em, stroke: 0.1em + black, rect(fill: fill))
}

$
  "rgb"(64, 128, 32) #color-box(rgb(64, 128, 32))
  &= overbracket((1\/4, space 1\/2, space 1\/8), #[RGB-Einheitswürfel\ n/256 ])\
  bold(v) = max(r, g, b) &= 1\/2 = 50%\
  "min" := min(r, g, b) &= 1\/8\
  bold(s) = (v - "min")/v &= (4\/8 - 1\/8)/(1\/2) = (3\/8)/(1\/2) = 3/4 = 75%\
  bold(h) = (1 + (v - r)/(v - "min")) dot 60° &= (1 + 2/3) dot 60° = 100°\
  "hsv" &= underline((100°, 75%, 50%) #color-box(color.hsv(100deg, 75%, 50%)))
$
_Dominante Grundfarbe:_ Grün, weil $v = g$.\
_Schwächste Farbe:_ Blau, weil $"min" = b ->$ Farbe ist gelb-grünlich.

==== Umrechnung HSV nach RGB
$
    max(r, g, b) & = v \
    min(r, g, b) & = v - s dot v \
  "mitte"(r,g,b) & = v - (h/(60°) -1) dot (v - "min")
$


= 3D-Transformationen
In 3D-Transformationen wird eine $4 times 4$-Matrize mit homogenen Koordinaten verwendet.

== Translation
Mit homogenen Koordinaten lässt sich der um den Translationsvektor $arrow(t) = display(mat(t_x, t_y, t_z)^T)$
verschobene Punkt $P = (x,y,z)$

$ (x', y', z') := (x + t_x, space y + t_y, space z + t_z) $
in der folgenden Form darstellen:
#v(-0.5em)
$
  mat(x'; y'; z'; 1) = overbracket(
    mat(1, 0, 0, t_x; 0, 1, 0, t_y; 0, 0, 1, t_z; 0, 0, 0, 1),
    display(T(t_x, t_y, t_z))
  ) dot mat(x; y; z; 1)
$

== Skalierung
Gegeben sind drei Skalierungsfaktoren $s_x, s_y, s_z != 0$.

*Der Fixpunkt der Skalierung liegt im Ursprung:*
$ (x',y',z') := (x dot s_x, space y dot s_y, space z dot s_z) $

Die daraus resultierende Transformationsmatrix lautet:
#v(-0.5em)

$ S(s_x, s_y, s_z) = mat(s_x, 0, 0, 0; 0, s_y, 0, 0; 0, 0, s_z, 0; 0, 0, 0, 1) $

*Fixpunkt liegt nicht im Ursprung, sondern bei $(Z_x, Z_y, Z_z)$:*

Zuerst Translation um $(-Z_x, -Z_y, -Z_z)$, dann Skalierung um $(s_x, s_y, s_z)$,
dann Rücktranslation um $(Z_x, Z_y, Z_z)$:
$ T(Z_x, Z_y, Z_z) dot S(s_x, s_y, s_z) dot T(-Z_x,-Z_y, -Z_z) $

== Rotation im Gegenuhrzeigersinn
#hinweis[(Für Uhrzeigersinn müssen die Vorzeichen des Sinus vertauscht werden)]
#v(-0.5em)
#table(
  columns: (1.2em, 1fr, 1.05fr),
  align: horizon,
  table.header([], [Rotation], [Transformationsmatrix]),
  table.cell(align: horizon, rotate(-90deg, reflow: true)[*Z-Achse*]),
  $
    x' & := x dot cos(delta) - y dot & sin(delta) \
    y' & := x dot sin(delta) + y dot & cos(delta) \
    z' & :=                          &          z
  $,
  $
    R_z (delta) = inline(
      mat(
        cos(delta), -sin(delta), 0, 0;
        sin(delta), cos(delta), 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1;
      )
    )
  $,
  table.cell(align: horizon, rotate(-90deg, reflow: true)[*X-Achse*]),
  $
    x' & :=                          &          x \
    y' & := y dot cos(delta) - z dot & sin(delta) \
    z' & := y dot sin(delta) + z dot & cos(delta)
  $,
  $
    R_x (delta) = inline(
      mat(
        1, 0, 0, 0;
        0, cos(delta), -sin(delta), 0;
        0, sin(delta), cos(delta), 0;
        0, 0, 0, 1;
      )
    )
  $,
  table.cell(align: horizon, rotate(-90deg, reflow: true)[*Y-Achse*]),
  $
    x' & := z dot sin(delta) + x dot & cos(delta) \
    y' & :=                          &          y \
    z' & := z dot cos(delta) - x dot & sin(delta) \
  $,
  $
    R_y (delta) = inline(
      mat(
        cos(delta), 0, sin(delta), 0;
        0, 1, 0, 0;
        -sin(delta), 0, cos(delta), 0;
        0, 0, 0, 1;
      )
    )
  $,
)
#v(-0.5em)

==== Rotation um beliebige Achse
#hinweis[Rotationsachse stimmt nicht mit einer der Koordinatenachsen überein]

#image("img/3d_rotation.png")

0. _Einheitsvektor_ $arrow(u)$ der Rotationsachse $arrow(v)$ #hinweis[(verläuft durch die Punkte $P_1, P_2$)]
  berechnen und in Komponenten $a, b, c$ zerlegen
  #v(-1em)
  $
    arrow(v) = P_2 - P_1 = mat(x_2 - x_1; y_2 - y_1; z_2 - z_1) \
    inline(|arrow(v)| = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2))\
    arrow(u) = (arrow(v))/(|arrow(v)|) = mat(a; b; c), quad
    a = (x_2 - x_1)/(|arrow(v)|), space
    b = (y_2 - y_1)/(|arrow(v)|), space
    c = (z_2 - z_1)/(|arrow(v)|)
  $
+ Translation von Rotationsachse und Objekt, sodass _Rotationsachse durch den Ursprung_ läuft:
  $
    arrow(v') = (P_1 ', P_2 ')\
    P_1 ' = (0, 0, 0), space P_2 ' = (x_2 - x_1, space y_2 - x_1, space z_2 - z_1)
  $

+ _Rotation_ der _Rotationsachse_ um die $x$-Achse in die $x z$-Ebene:
  $
    d = sqrt(b^2 + c^2), space cos(alpha) = c/d, space sin(alpha) = b/d
  $
+ _Rotation_ der _Rotationsachse_ um die $y$-Achse in die $z$-Achse
  $
    cos(beta) = cos(360° - beta) = d, space sin(beta) = -sin(360° - beta) = -a
  $
+ _Rotation_ des _Objekts_ um die $z$-Achse mit Winkel $delta$:
  $
    R_z (delta) = mat(cos(delta), -sin(delta), 0, 0; sin(delta), cos(delta), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)
  $
+ _Rücktransformation_ des gedrehten Objekts durch Anwendung der inversen Transformationen der Schritte 3, 2 und 1.

/*
*Operation als One-Liner*
$
  R(arrow(v), delta) = T(P_1) R_x^(-1)(alpha) dot R_y^(-1)(beta) dot R_z (delta)
  dot R_y (beta) dot R_x (alpha) dot T(-P_1)
$
*/

== Transformation der Normalenvektoren
Die Normalenvektoren müssen bei der Transformation von Objektpunkten ebenfalls abgebildet werden.
Wenn diese Transformation eine _nicht-uniforme Skalierung_ #hinweis[(Verzerrung)] ist, bleiben die _Winkel_ zwischen
einzelnen Flächen _nicht erhalten_.\
Damit der Normalenvektor $arrow(n)$ trotzdem weiterhin senkrecht zur Fläche steht, muss dieser mit der
_transponierten Inversen_ der Transformationsmatrix $M$ transformiert werden.
$ (M^(-1))^T dot arrow(n) = arrow(n') $


= Fraktale
Fraktale sind geometrische Formen, die sich durch _Selbstähnlichkeit_ auszeichnen: wenn man hineinzoomt, sieht das
_Teilstück_ _ähnlich_ oder _gleich_ wie das _gesamte Gebilde_ aus.

== Fraktale Dimensionen
Ein selbstähnliches Objekt hat _Dimension D_, falls es in _*$N$* identische Kopien_ unterteilt werden kann, die jeweils
_skaliert_ sind mit dem Faktor _*$r = 1\/N^(1\/D)$*_.

Die Dimension $D$ eines Fraktals lässt sich bestimmen, wenn $N$ und $r$ bekannt sind: $D = log(N)\/log(1/r)$.

== Koch'sche Schneeflocke
$R$ und $T$ dritteln die Kante $overline(P Q)$. $S$ ist eine 60°-Drehung des Knotens $T$ um das Zentrum $R$ gegen den
Uhrzeigersinn.
#image("img/snowflake.png")

Die Koch'sche Schneeflocke hat Dimension $D = log(4)/log(3) = 1.2618...$, denn jeder Kantenzug besteht aus $N = 4$
Kopien, jeweils skaliert um den Faktor $r = 1/3$.

== Lindenmayer-Systeme (L-Systeme)
_Nicht-grafische Beschreibung_ mancher Fraktale. \
*Alphabet:* $sum = r, u, l, d$ für right, up, left und down.

*Regelmenge:*
#v(-0.8em)
#{
  set math.mat(delim: "{")
  $
    f = mat(
      r & arrow.double, r, u, r, d, d, r, u, r;
      u & arrow.double, u, l, u, r, r, u, l, u;
      l & arrow.double, l, d, l, u, u, l, d, l;
      d & arrow.double, d, r, d, l, l, d, r, d
    )
  $
}

Ausgehend vom Startwort $w$ wird nun in jedem Iterationsschritt auf jedes Zeichen von $w$ eine Regel aus $f$ angewendet.

*Beispiel:*
Sei $w = r space u$, dann ist $f(w) = r u r d d r u r space u l u r r u l u$

#align(image("img/lindenmayer.png", width: 80%), center)

Die quadratische Koch-Kurve hat die Dimension $D = log(8)/log(4) = 1.5$, denn jeder Kantenzug besteht aus $N = 8$
Kopien, jeweils skaliert um den Faktor $r = 1/4$.

== Baumstrukturen
#grid(
  columns: (2.4fr, 1fr),
  [
    Ausgangspunkt siehe rechts. An den Kanten $B C$ und $C D$ können jeweils weitere "Äste" mit Faktor $0.75$/$0.47$
    eingesetzt werden.
    #image("img/wald.png")
  ],
  image("img/baum.png"),
)

== Mandelbrot-Menge
Besteht aus komplexen Zahlen $c$, die beim Startwert $z=0$ zu einer beschränkten Folge führen. Dann definiert man:

$
  "farbe"(c) = cases(
    "schwarz," space & "wenn Folge beschränkt bleibt",
    "weiss, " & "wenn Folge nicht beschränkt bleibt"
  )
$

== Iterierte Funktionensysteme
Sind in der Lage, mit _wenigen Regeln komplexe, natürlich aussehende Bilder_ zu erzeugen.\
Jede Transformation wird definiert durch eine $2 times 2$_-Deformationsmatrix_ *_$A$_*, einen _Translationsvektor_
*_$b$_* und eine _Anwendungswahrscheinlichkeit_ *_$w$_*. Dadurch wird ein Punkt $x$ auf\ $A dot x + b$ mit
Wahrscheinlichkeit $w$ abgebildet.

Beispiele hierfür sind der _Farn_ und das _Sierpinsky-Dreieck_:
#image("img/farn.png")
#image("img/sierpinsky.png")


= Morphologie
Morphologische Operationen _verändern die Form_ von Bildobjekten
#hinweis[(Dicke von Linien ändern, Vereinen/Trennen von Elementen, Unreinheiten eliminieren)].
- _*$lozenge$* Operator:_ Vereinigung, Differenz, Schnitt
- _*$f_s$*:_ Menge von Pixeln
- _*$s$*:_ Nachbarschaft, definiert durch Strukturelement

*Voraussetzungen für Basisoperationen:*
- Die Mengen $f_s$ entsprechen Objekten oder Mustern im Bild
- Das Bild ist ein Binär- oder Grauwertbild
- Das Strukturelement #hinweis[(Das Element, das über das Bild gelegt wird)] besteht aus 0 und 1, wobei die 1 die Pixel
  der Nachbarschaft definieren.

== Dilatation
Das Strukturelement wird über jeden Pixel des Originalbildes gelegt und es wird eine logische _oder-Verknüpfung_
zwischen dem Binärbild $f$ und dem Strukturelement $s$ durchgeführt:\ $g = f plus.o s$

==== Wirkung
Objekte werden _vergrössert_ und können _verschmelzen_. Löcher können _geschlossen_ werden, unregelmässige Objekte
werden von der _Form_ her _ausgeglichener_.

==== Beispiel
Das Strukturelement wird auf jeden Pixel angewendet. Da im Strukturelement alle Nachbarn 1 #hinweis[(weiss)] sind,
wird der Ursprung weiss eingefärbt, wenn einer der 8 Nachbarn bereits weiss ist.
#image("img/dilatation.png")

== Erosion
Das Strukturelement wird über jeden Pixel des Originalbildes gelegt und es wird eine logische _und-Verknüpfung_
zwischen dem Binärbild $f$ und dem Strukturelement $s$ durchgeführt: \ $g = f minus.o s$

==== Wirkung
Objekte werden _verkleinert_ und können _auseinanderfallen_. Löcher werden _grösser_, Objekte werden _gelöscht_, wenn
sie _kleiner_ als das Strukturelement sind.

==== Beispiel
Alle Pixel des Strukturelements müssen auf 1 #hinweis[(weiss)] gesetzt sein, damit der Ursprung weiss bleibt.
#image("img/erosion.png")

== Opening
_Erosion_ mit anschliessender _Dilatation_: $A bullet.stroked B = (A minus.o B) plus.o B$\
*Wirkung:*
_Rundet Kanten_, _entfernt dünne Verbindungen_ und dünne herausragende Strukturen.

== Closing
_Dilatation_ mit anschliessender _Erosion_: $A bullet.op B = (A plus.o B) minus.o B$\
*Wirkung:*
_Rundet Konturen_, _verbindet_ nahe _Objekte_, _füllt Löcher_ und Einbuchtungen, die _kleiner_ als das Strukturelement sind.

#image("img/open-closed.png")

== Objekte freistellen
*Zielsetzung:* _Objekte_ durch Erkennung eines Hintergrundes _freistellen_, _Hintergrund_ durch andere Bildquelle
_ersetzen_.

=== Hintergrundersetzung
*Probleme:* _Schatten_ verfälschen Farbtöne. _Störungen_ wie Rauschen oder Kompressionsartefakte sorgen für
Ungleichmässigkeiten. _Farbtöne_ und ihre Schattierungen sind in allen _RGB-Werten_ kodiert.

#v(-0.5em)
#image("img/shadow.png")

*Lösung:*
_Umwandlung_ in HSV, um Farbton, Intensität und Sättigung zu trennen.
Ermöglicht einfache Auswahl eines Farbtonbereiches _unbeeinflusst_ von Schattierungen.

#image("img/hsv.png")

==== Bereinigung der Selektionsmaske
Durch _Störungen_ und schlechte _Farbtonverteilung_ können _Fehler_, _Löcher_ oder unschöne Kanten entstehen.
Durch _Anwendung_ diverser _Filter_ oder _morphologischen Operationen_ können diese Effekte _minimiert_ werden.

==== Anwendungsschritte zur Hintergrundentfernung
+ _Konvertieren_ des Vordergrundes in _HSV_
+ _Erstellen_ der _Alpha-Maske_
+ _Erstellung_ der _Grauwertspreizung_ (optional)
+ _Zusammenführung_ des _V-Kanals_ mit dem Hintergrund
+ _Morphologische_ Bildverbesserung
+ _Vereinen_ von _Vorder- und Hintergrund_

```
Für jeden Pixel [i,j] in Bild A
  Falls Maske [i,j] == true
    Ersetze Pixel [i,j] in Bild A mit Pixel [i,j] aus Bild B
```


= Projektion in 3D
Das Abbilden von _dreidimensionalen Objekten_ auf einer _zweidimensionalen Fläche_ nennt sich _Projektion_.
Gegeben sind das zu_ projizierende Objekt_, die _Bildebene_ und das _Projektionszentrum_.

== Bildebene
#image("img/bildebene.png")

Ist der _Abstand_ des Projektionszentrums von der Bildebene _endlich_, handelt es sich um eine _perspektivische
Projektion_ #hinweis[(Zentralprojektion)], ansonsten um eine _Parallelprojektion_
#hinweis[(Die beiden Projektionsstrahlen treffen sich nie)].

== Perspektivische Projektion
Je nach Anzahl der geschnittenen Koordinatenachsen kann sie mit 1, 2 oder 3 _Fluchtpunkten *$F$*_ umgesetzt werden.

#grid(
  columns: (1.5fr, 1fr),
  image("img/projektion_1.png"), image("img/projektion_2.png"),
)

=== Anwendung der Strahlensätze
- _Bildebene:_ $x y$-Ebene
- _Projektionszentrum:_ neg. $z$-Achse im Punkt $Z = (0,0,-a)$
- _Gegeben:_ $P = (x,y,z)$
- _Gesucht:_ projizierter Bildpunkt $P' = (x', y', 0)$

#image("img/strahlensaetze.png")

Im Bild wird die Szene "von oben" und "von der Seite" betrachtet.
Aufgrund der _Strahlensätze_ erhält man die _Beziehung_

$
  x' = x / (1 + z\/a), space.quad
  y' = y / (1 + z\/a), space.quad
  z' = 0.
$

Die _homogenen Koordinaten_ des _projizierten Punktes_ lauten

$
  P' = (x/w, y/w, 0, 1) overbracket(=, dot w) (x,y,0,w) "mit" w = 1 + z\/a
$

Die _Transformationsmatrix_ der perspektivischen Projektion ist:

$ P_"persp"_(x y)(-a) = mat(1, 0, 0, 0; 0, 1, 0, 0 ; 0, 0, 0, 0; 0, 0, 1/a, 1) $

== Parallelprojektion
Stehen die Sehstrahlen im rechten Winkel zur Bildebene, liegt eine _orthogonale Projektion_ vor.
*Anwendung:* Grund-, An- und Seitenriss.
Die _Transformationsmatrix_ auf die $x y$-Ebene lautet #hinweis[($z$-Komponente wird weggelassen)]:

$ P_"ortho"_(x y) = mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 0, 0; 0, 0, 0, 1) $


= Viewing Pipeline
Die Abbildung dreidimensionaler Objekte auf dem Bildschirm wird in eine Reihe von Elementartransformationen zerlegt:
- _Modeling:_ Konstruktion von komplexen Szenen aus elementaren Objekten
- _View Orientation:_ Festlegen der Bildebene
- _View Mapping:_ Projektion auf ein normiertes Gerät
- _Device Mapping:_ Abbildung auf ein Ausgabegerät

== Die Synthetische Kamera <kamera>
Die _Kamera_ befindet sich im _PRP_ #hinweis[(auch _Normal Reference Point (NRP)_ genannt)] und zeigt auf den _VRP_.
Durch PRP und VRP verläuft der Normalenvektor _View Plane Normal *$N$*_.
Die _View Plane_ ist die Bildebene, auf die die Szene projiziert wird.
Der von der Kamera gesehene Teil der View Plane #hinweis[$(x_max, y_max), (x_min, y_min)$] ist das _View Window_.
Die Distanz PRP-VRP ist die _VPD #hinweis[(View Plane Distance)]_.

$U, V, N$ bilden das _VRC_ #hinweis[(View Reference Coordinate System)] mit VRP als Ursprung.
Der sichtbare Teil kann noch weiter eingeschränkt werden durch Angabe einer _Frontplane_ und einer _Backplane_;
alles davor und dahinter wird nicht gerendert.

#image("img/synthcam.png")

== Viewing Pipeline
Die Viewing Pipeline ist die _Sequenz_ von Transformationen, die nötig sind, um 3D-Objekte auf dem 2D-Bildschirm darzustellen.

*Erforderliche Informationen zur Darstellung*
- _Jedes Objekt_ wird durch _Modellkoordinaten beschrieben_\
  #hinweis[(z.B. Würfel ist beschrieben durch Mittelpunkt $(0,0,0)$ und Kantenlänge $1$.)]
- Die _Szene_ wird durch eine Menge von Objekten beschrieben, deren Lage und Grösse in Weltkoordinaten beschrieben sind.
- Die _Beleuchtung_ wird durch eine Menge von Lichtquellen beschrieben, deren Lage und Ausrichtung in Weltkoordinaten
  beschrieben sind.
- Die _synthetische Kamera_ wird beschrieben durch $U,V,N,$ $V P D,(x_max,y_max),(x_min,y_min)$ #hinweis[(siehe @kamera)].

#pagebreak()

*Schritte der Viewing Pipeline*
+ _Modeling #hinweis[(MC $->$ WC)]:_
  Beschreibe Polygonpunkte in Weltkoordinaten durch Translation, Rotation und Skalierung
+ _View Orientation #hinweis[(WC $->$ VRC)]:_
  Überführe Szene in Kameraperspektive durch Wechsel des Koordinatensystems.
  Dann ist $x z$-Ebene = Bildebene und das Auge liegt in $z = V R P$.
+ _View Mapping #hinweis[(VRC $->$ NPC)]:_
  Transformiere Szene in Einheitswürfel, damit Vorder-/Rückseite der Front-/Backplane entsprechen.
+ _Device Mapping #hinweis[(NPC $->$ DC)]:_
  Projiziere Szene auf Bildschirm. $x,y$ liefert Koordinaten, $z$ Tiefeninformation.

#image("img/viewing_your_pipeline.png")

== Koordinatensystemwechsel <koord-sys-wechsel>
Konvertierung von lokalem zu globalen Koordinatensystem.

#v(-0.5em)
#image("img/coordinate_change.png")

$
  mat(
    0.8, -0.6, 6.0;
    0.6, 0.8, 2.0;
    underbracket(0.0, "x-Achse"),
    underbracket(0.0, "y-Achse"),
    underbracket(1.0, "Ursprung Q");
  )
  dot
  mat(5.0; 5.0; underbracket(1.0, "P in rot");)
  =
  mat(7.0; 9.0; underbracket(1.0, "P in blau");)
$

=== Modeling
Das _Anordnen von Objekten_ aus dem _Modellkoordinatensystem_ zu einer Szene im _Weltkoordinatensystem_.
Die Objekte erhalten aus der "Grundform" ihre individuelle Grösse, Orientierung und Position durch _Translation_,
_Rotation_ und _Skalierung_.

#image("img/modeling.png")

=== View Orientation
Zur _Abbildung_ einer dreidimensionalen Szene aus den Weltkoordinaten auf dem Bildschirm muss eine _Betrachtersicht_
#hinweis[(View Orientation)] definiert werden. Diese besteht aus den Parametern:
- _PRP:_ Betrachterstandpunkt #hinweis[(Projection Reference Point)]
- _VRP:_ Blickrichtung #hinweis[(View Reference Point)]
- _VUV/VUP:_ vertikale Orientierung #hinweis[(View Up Vector/View Up Point])
- _Blickwinkel:_ Brennweite

Wenn die Achsen der Kamera mit $U - V - N$ und der Nullpunkt der Kamera mit $V R P$ bezeichnet wird
#hinweis[(Siehe Bild in @kamera)], ist die _Transformation von lokale in globale Koordinaten_ wie folgt definiert:
#v(-0.5em)
$
  M = mat(
    U_x, V_x, N_x, V R P_x;
    U_y, V_y, N_y, V R P_y;
    U_z, V_z, N_z, V R P_z;
    0, 0, 0, 1;
  )
$

Damit die global definierte Szene aus _Kamerasicht_ angeschaut wird #hinweis[(Wechsel von globalen zu lokalen
  Koordinaten – also umgekehrt zur obigen Rechnung.)], muss auf die Modellgeometrie die _inverse Transformation_
$T = M^(-1)$ angewendet werden.
#v(-0.5em)
$
  M^(-1) = mat(
    U_x, U_y, U_z, -(arrow(U) dot V R P);
    V_x, V_y, V_z, -(arrow(V) dot V R P);
    N_x, N_y, N_z, -(arrow(N) dot V R P);
    0, 0, 0, 1;
  )
$

==== Beispielaufgabe Kameratransformation
Kamera schaut von $p 1 = (2,2,0)$ auf $p 2 =$ #fxcolor("rot", $(1,1,0)$).
Die $x$-Achse sei parallel zur globalen $x y$ Ebene.
Die $z$-Achse der Kamera zeigt in Richtung Blickrichtung ($p 1 arrow p 2$).
Berechne die Transformationsmatrix der Kamera ($M$) und die Transformationsmatrix, mit der globale Koordinaten in das
Kamerakoordinatensystem transformiert werden ($M^(-1)$).


*Es gilt:*
$N = Z$-Achse der Kamera, $V = Y$-Achse der Kamera, $U = X$-Achse der Kamera. $P R P =$ Kamerapunkt,\
$V R P$ = Angeschauter Punkt.
#grid(
  columns: (1.1fr, 1fr),
  [
    $N, V, U$ kann von der Zeichnung _abgelesen_ werden. Zeigt Veränderung der globalen Koordinaten
    #hinweis[
      ($+1$ zeigt in die globale $+$-Richtung, $-1$ zeigt in globale $-$-Richtung).
      $ N = mat(1; 1; 0), quad V = mat(0; 0; 1), quad U = mat(-1; 1; 0) $
    ]
  ],
  image("img/kameratransformation.png"),
)

*Normalisieren mit $sqrt(x^2 + y^2 + z^2)$: $U$ zu $arrow(U)$*
$
  sqrt((-1)^2 + 1^2 + 0^2) = fxcolor("grün", sqrt(2)) arrow.double
  arrow(U) = mat(-1/fxcolor("grün", sqrt(2)); 1/fxcolor("grün", sqrt(2)); 0/fxcolor("grün", sqrt(2)))
$

*Inverse Werte von $M^(-1)$ berechnen:*
$
  -(arrow(U) dot V R P) = - mat(-1/sqrt(2); 1/sqrt(2); 0) dot mat(1; 1; 0) = mat(-1/sqrt(2) + 1/sqrt(2) + 0) = fxcolor("orange", 0)
$

*Normalisierte Werte in $M$ und $M^(-1)$ eintragen:*
$
  M = mat(
    -1/sqrt(2), 0, 1/sqrt(2), fxcolor("rot", 1);
    1/sqrt(2), 0, 1/sqrt(2), fxcolor("rot", 1);
    0, 1, 0, fxcolor("rot", 0);
    0, 0, 0, 1;
  ), quad
  M^(-1) = mat(
    -1/sqrt(2), 1/sqrt(2), 0, fxcolor("orange", 0);
    0, 0, 1, 0;
    1/sqrt(2), 1/sqrt(2), 0, -2/sqrt(2);
    0, 0, 0, 1;
  )
$

=== View Mapping
*View Volume:* Bildraum, der durch das View Window und die gewählte Projektion definiert wird.\
Das _Mapping_ des _View Volume_ auf den _Einheitswürfel_, dessen Vorder- und Rückseite die Front- bzw. die Backplane
darstellen, dient der _Effizienzsteigerung_ des Algorithmus in späteren Schritten und _erleichtert_ zudem die
_Projektion der Szene_ auf die _Bildebene_: Anstelle mehrerer unterschiedlicher Projektionen muss so nur noch die
orthogonale Parallelprojektion auf die Ebene $z = 0$ durchgeführt werden.

#align(center, image("img/viewmapping.png", width: 70%))

Dieses Mapping wird in einigen komplizierten mathematischen Schritten durchgeführt:
- _Verschiebung_ des PRPs in den Ursprung: $z colon.eq z - d$
- _Spiegelung_ an der $x y$-Ebene: $z colon.eq -z$
- _Überführung_ in Pyramidenstumpf\ #hinweis[(90° Winkel von PRP zu $y_max$ und $y_min$)]
- Die _regelmässige Pyramide_ #hinweis[(45°, 90°, 45°)] kann nun in den _Einheitswürfel_ transformiert werden.

=== Device Mapping
Die Abbildung muss nun die $x$- und $y$-Koordinaten aus dem NPC so in die _Bildschirmkoordinaten_ $D C$
#hinweis[(Device Coordinate System)] _transformieren_, dass eine anschliessende Rundung die _ganzzahligen Koordinaten
der Pixel_ ergibt.

#image("img/device_mapping.png")

Auch ist $D C$ oft ein _linkshändiges Koordinatensystem_ #hinweis[($y$-Achse zeigt nach unten, der Ursprung ist oben
  links)], dafür muss die Abbildung ebenfalls noch angepasst werden.

Die Transformationsmatrix entspricht einer Skalierung um den Vektor $("xsize", -"ysize", 1)$ konkateniert mit einer
Translation des Ursprungs in die linke untere Ecke des Bildschirms $(0, "ysize", 0)$.

$
  T_"NPC_DC" = mat(
    "xsize", 0, 0, 0;
    0, - "ysize", 0, "ysize";
    0, 0, 1, 0;
    0, 0, 0, 1;
  )
$

#colbreak()

=== Clipping
Jedes Polygon, dass die Viewing Pipeline durchläuft, kostet _Rechenaufwand_. Deshalb macht es Sinn, den _unsichtbaren
Teil_ einer Szene so früh wie möglich _loszuwerden_. Es gibt verschiedene Optionen dafür.

#grid(
  columns: (1.1fr, 1fr),
  [
    ==== Clipping im WC / NPC
    _Im *$W C$*_ muss an den sechs Flächen des Frustums #hinweis[(Kegelstumpf)] geclippt werden, während _im *$N P C$*_
    an den sechs "einfachen" Flächen des Einheitswürfels mit Cohen-Sutherland
  ],
  [
    #v(-1em)
    #image("img/clippingwc.png")
  ],
)
#v(-0.6em)
#hinweis[(@cohen-sutherland)] geclippt werden kann. Clipping im WC _spart eine Transformation aller Punkte_,
dafür ist im NPC das eigentliche Clipping und die Schnittpunktberechnung einfacher.

==== Umgebungsclipping
Bietet _Effizienzsteigerung_ des Clippings, indem ein _Cluster_ von mehreren, komplexen Objekten mit einem _grossen
Quader umgeben_ wird. Ergibt ein erster _Clipping-Test_, dass dieser Quader _ausserhalb_ des Frustums liegt, _erübrigen_
sich die Clipping-Abfragen seiner inneren Objekte.


= Objekte in 3D
Für 3-dimensionale Objekte gibt es mehrere Möglichkeiten der _Repräsentation_ #hinweis[(d.h. Definition des Objekts)]
und der _Darstellung_ #hinweis[(d.h. Projektion des Objekts auf den Bildschirm)].

#v(-0.25em)
*Repräsentation:*
- _Elementarobjekt_ mit _Definitionspunkten_
  #hinweis[(Mehrfachverwendung bestehender Geometrie durch Transformationen, veraltet)]
- _Drahtmodell_ #hinweis[(Liste von Kanten, skizziert Umrisse, veraltet)]
- _Flächenmodell_ mit Punkt- und Flächenliste und Normalen
- _CSC_ #hinweis[(constructive solid geometry)] mit mengentheoretischer Verknüpfung von Elementarobjekten
  #hinweis[(Ein Objekt besteht aus Addition/Subtraktion mehrerer Elemente, z.B. Rohr = Grosser Zylinder - kleiner Zylinder)].

#v(-0.25em)
*Darstellung:*
- _Punktmodell_ #hinweis[(zeigt nur Eckpunkte eines Objekts an)]
- _Drahtmodell_ mit sämtlichen Kanten #hinweis[(Punkte sind verbunden)]
- _Drahtmodell_ mit Entfernung verdeckter Kanten
- _Flächenmodell_ mit Einfärbung, ohne abgewandte Flächen
- _Flächenmodell_ mit Einfärbung, ohne verdeckte Teile von Flächen
- _Flächenmodell_ mit Einfärbung, ohne verdeckte Teile von Flächen, mit Beleuchtungsmodell
- _Körpermodell_ mit Berechnung von Schattenbildung, Spiegelungen und Brechungen.

== Flächenmodell
Objekte werden durch approximierte oder analytische Flächen, z.B. durch eine _Liste_ von konvexen Polygonen,
repräsentiert. Beim _Würfel_ verbinden die Kanten die Eckpunkte, bei einer _Kugel_ werden die Längen- und Breitenkreise
durch $n$-Ecke angenähert, wobei mit $n$ die Qualität der Approximation steigt.

*Beispiel Tetraeder:*
#v(-0.75em)
#grid(
  columns: (2fr, 1fr),
  table(
    columns: (1fr, 1fr),
    table.header([Punkteliste], [Flächenliste]),
    $P_1: (x_1, y_1, z_1)$, $F_1: p_1, p_2, p_4$,
    $P_2: (x_2, y_2, z_2)$, $F_2: p_1, p_4, p_3$,
    $P_3: (x_3, y_3, z_3)$, $F_3: p_1, p_2, p_3$,
    $P_4: (x_4, y_4, z_4)$, $F_4: p_4, p_2, p_3$,
  ),
  image("img/tetraeder.png"),
)
#v(-0.5em)

== Polyeder
Ein Polyeder ist ein _Körper_, dessen Oberfläche aus ebenen _Flächen_ besteht.
_Datenstruktur, um Polyeder zu beschreiben:_ Punkte, Kanten, Flächen, Normale, Farbe, Materialeigenschaften, Textur, BumpMap.

=== Zylinder
Ein Zylinder kann mit 4 Punkten komplett beschrieben werden.
#v(-0.5em)
#table(
  columns: (auto, 1fr, 1fr),
  table.header([\#], [Eckpunkt], [Normalenvektor]),
  [1], $(cos(phi.alt), sin(phi.alt), +1, 1)$, $(cos(phi.alt), sin(phi.alt), 0,0)$,
  [2], $(cos(phi.alt + alpha), sin(phi.alt + alpha), +1, 1)$, $(cos(phi.alt + alpha), sin(phi.alt + alpha), 0,0)$,
  [3], $(cos(phi.alt + alpha), sin(phi.alt + alpha), -1, 1)$, $(cos(phi.alt + alpha), sin(phi.alt + alpha), 0,0)$,
  [4], $(cos(phi.alt), sin(phi.alt), -1, 1)$, $(cos(phi.alt), sin(phi.alt), 0,0)$,
)
#align(image("img/zylinder.png", width: 60%), center)

=== Kugel
Die Oberfläche einer Kugel mit Radius $1$ kann beschrieben werden durch

$
  (sin(theta) dot cos(phi), space sin(theta) dot sin(phi), space cos(theta)),\
  0 <= phi < 2pi, quad 0 < theta < pi
$

Zur Approximation durch Flächen wird der Vollwinkel in $n$ Teile zerlegt:
$
  phi = (2pi)/n, quad n in NN "gerade"
$

#align(image("img/ball.png", width: 70%), center)

== Volumenmodelle
Volumenmodelle bilden _Oberfläche_ und _Inhalt_ eines dreidimensionalen Objekts ab und _beschreiben_ den
dreidimensionalen Körper _eindeutig_.

#image("img/volumenmodelle.png")

=== Volumetrische Modelle
In volumetrischen Modellen werden Objekte durch diskrete Volumenelemente repräsentiert.

#grid(
  [
    _Enumerationsmodelle:_ Alles wird mit identischen, aber verschieden skalierten geometrischen Elementen wie z.B. Würfel
    gefüllt. Beispiel: Octree\
    _Dekompositionsmodelle:_ Stellen ein Objekt als Zusammensetzung einzelner Zellen dar, die verschieden geformt sind.
    Werden hauptsächlich für FEM-Anwendungen verwendet #hinweis[(Finite Elemente Methode)].
  ],
  [
    #image("img/minecraft.png")
    #image("img/cells.png")
  ],
)

=== Octree
Eignet sich zur Verwaltung der räumlichen Anordnung von Objekten im dreidimensionalen Raum. Wenn ein Gebiet nicht
_komplett_ gefüllt ist, wird es geviertelt. Die Viertel werden im Uhrzeigersinn abgearbeitet, Start oben links.
#hinweis[(Zumindest in diesem Beispiel)]. _Grauer Knoten:_ Enthält teilweise Objekte.

#grid(
  columns: (1.1fr, 1fr),
  image("img/octree_square.png"), image("img/octree_tree.png"),
)

Das Konzept wird _Octree_ genannt, weil ein Würfel jeweils in _8 Teilstücke_ geteilt wird, und Nodes im Baum somit
jeweils _8 Child Nodes_ haben.

#image("img/octree_cube.png")

== CSG (constructive solid geometry)
Erzeugt durch regularisierte _Mengenoperationen_ mit anderen Objekten: $inter*$ Vereinigung, $union*$ Durchschnitt,
$\\*$ Differenz.\
Die _Wurzel_ repräsentiert das resultierende Objekt, welches aus den Blättern unter Anwendung der
Operationen konstruiert werden kann.

#image("img/csg.png")

== BREP (Boundary-Representation)
Wird in heutigen CAD-Systemen oft verwendet. Ein _Körper_ wird durch _Flächen_ beschrieben. Durch die Orientierung der
Normalvektoren kann eindeutig zwischen Objekt-innerem und Objekt-äusserem unterschieden werden. _Flächen_ werden wiederum
durch _Kanten_ und _Kanten_ durch _Punkte_ berandet.

Die Datenstruktur ist durch folgende Charakteristika gekennzeichnet:
- Topologie und Geometrie sind _getrennt_ dargestellt: Topologie in der Hierarchie und die Geometrie in den Knoten.
- Die _Topologie_ hat im einfachsten Fall nur _vier Hierarchiestufen_.

#image("img/brep_wuerfel.png")

=== Euler-Gleichung
Veränderungen des Graphen sind über Euler-Operatoren möglich. Diese trifft eine Aussage über die Anzahl von Ecken,
Kanten, etc. in einem physikalischen Objekt.

#table(
  columns: (auto, 1fr),
  table.header([Kürzel], [Objekt]),
  [$E$ / $V$], [Ecken / Vertices],
  [$K$ / $E$], [Kanten / Edges],
  [$S$ / $F$], [Seiten / Faces],
  [$I$ / $R$], [Innere Zyklen / Rings #hinweis[(Löcher innerhalb Flächen)]],
  [$Z$ / $S$], [Komponenten / Shells #hinweis[(Separate Körper, meist 1)]],
  [$G$ / $G$], [Löcher / Genus #hinweis[(Löcher durch ganzes 3D Objekt)]],
)

*Gleichung (deutsch):* $E - K + S - I = 2(Z - G)$\
*Gleichung (englisch):* $V - E + F - R = 2(S - G)$\

_Jedes Volumenmodell muss diese Gleichung erfüllen_. Zusätzlich zu der Euler-Gleichung müssen BREPs folgende Voraussetzungen
erfüllen:
- Jede _Kante_ trennt _genau zwei Flächen_ #hinweis[(evtl. auch gewölbte Fläche)]
- Um jede _Ecke_ existiert ein _geschlossener Ring von Flächen_
- _Flächen_ können sich nur an einer _gemeinsamen Ecke oder Kante_ schneiden

*Beispiel Zylinder:*\
Ein Zylinder kann wie folgt beschrieben werden:
#align(image("img/brep_zylinder.png", width: 70%), center)
Er hat also 2 Ecken $v$, 3 Kanten $e$, 3 Flächen $f$, 0 Innere Zyklen, 1 Komponente und 0 Löcher. Wenn wir diese Zahlen
in die Euler-Gleichung einfügen, erhalten wir folgende Gleichung:
$
  E & - K & + S & - I & = & 2(Z & - & G) \
  2 & - 3 & + 3 & - 0 & = & 2(1 & - & 0) space arrow.double space 2 = 2 space checkmark
$

*Achtung:* Bei halben Löchern muss keine separate Kante mehr verwendet werden, die Abbruchkanten des Halbkreises reichen.

#colbreak()

== Konstruieren mit BREP vs. CSG
Das gleiche Modell kann durch _Randflächen_ #hinweis[(BREP)] oder durch _Volumenprimitiva_ #hinweis[(CSG)] beschrieben
werden:
#image("img/werkstueckmodell.png")


= Culling
Culling ist das _Entfernen_ von unsichtbaren _Kanten_, _Flächen_ und _Objekten_. Es gibt zwei Arten von Culling:
- _Objektraum:_ Arbeitet mit Weltkoordinaten, vergleicht Objekte
- _Bildraum:_ Arbeitet mit Device-Koordinaten, vergleicht Pixel

== Back-Face Removal
Das Entfernen von Flächen, die dem Betrachter _abgewandt_ sind. Nützlich, weil diese nicht sichtbar sein sollten, aber
auch, weil sich die weitere benötigte Rechenleistung dadurch ca. halbiert.

=== Geradengleichung
Die Linie $y$ ist sichtbar vom Punkt $P$, wenn $arrow(p) dot arrow(n) + C >= 0$ und sichtbar von Punkt $Q$, falls $B >= 0$.\
*Beispiel:*
#grid(
  columns: (2fr, 1fr),
  align: horizon,
  [
    $
      overbracket(y, "Linie") = overbracket(-3/4 x, "Steigung") + overbracket(5, "Verschiebung")
    $
    Gleichung auf 0 setzen und vereinfachen
    $
                                                                                       3/4 x + y - 5 & = 0 | dot 4 \
                                                                                        3x + 4y - 20 & = 0 \
                                                                                       A x + B y + C & = 0 \
      => underbracket(arrow(n) = mat(A; B; C) = mat(3; 4; 0), "Normalenvektor von" y", C immer = 0")
    $
  ],
  image("img/geradengleichung.png"),
)

$
  arrow(p) = mat(2; 5; 1), quad
  arrow(n) = mat(3; 4; 0), quad
  arrow(p) dot arrow(n) = mat(2 dot 3; 5 dot 4; 1 dot 0) = mat(6; 20; 0)
$

*Sichtbar von $P$?* $6 + 20 + overbracket((-20), C) = 6 >= 0 space =>$ sichtbar.\
*Sichtbar von $Q$?* $B = 4 >= 0 space =>$ sichtbar.

=== Ebenengleichung
Ähnlich wie Geradengleichung, aber für 3D.
#grid(
  columns: (1.3fr, 1fr),
  [
    $
      A x + B y + C z + D = 0\
      arrow(p) = mat(x; y; z; 1), quad arrow(n) = mat(A; B; C; 0)
    $
    Sichtbar von $P$, falls $arrow(p) dot arrow(n) + D >= 0$\
    Sichtbar von $Q$, falls $C >= 0$
  ],
  image("img/ebenengleichung.png"),
)

Wenn _*$arrow(n)$*_ der _Normalenvektor_ der Fläche und _*$arrow(a)$*_ ein _Eckpunkt_ ist, dann kann die Gleichung der
Ebene, in der die Fläche liegt, in der _Hesseschen Normalform_ bestimmt werden.

$ arrow(p) dot arrow(n) - arrow(a) dot arrow(n) = e $

#grid(
  [
    Beim _Einsetzen_ verschiedener Punkte $arrow(p)$ ergeben sich unterschiedliche Werte für $e$.
    - _*$e = 0$*:_ $arrow(p)$ liegt in der Ebene
    - _*$e > 0$*:_ $arrow(p)$ befindet sich ausserhalb, d.h. ist die Fläche von $arrow(p)$ aus _sichtbar_.
    - *_$e < 0$_*: $arrow(p)$ befindet sich innerhalb, d.h. ist die Fläche von $arrow(p)$ aus _unsichtbar_.
  ],
  image("img/backface.png"),
)
#v(-1em)

=== Back Face Culling
Für jede Polygonfläche berechne die $z$-Komponente der Flächennormale im NPC. Falls #tcolor("orange", [Ergebnis])
$<= 0 arrow.double$ Face nicht sichtbar, Fläche kann vergessen werden.

$
  mat(
    circle.filled.tiny, circle.filled.tiny, circle.filled.tiny, circle.filled.tiny;
    circle.filled.tiny, circle.filled.tiny, circle.filled.tiny, circle.filled.tiny;
    fxcolor("grün", circle.filled.small), fxcolor("grün", circle.filled.small), fxcolor("grün", circle.filled.small), fxcolor("grün", circle.filled.small);
    circle.filled.tiny, circle.filled.tiny, circle.filled.tiny, circle.filled.tiny;
  )
  dot
  mat(
    fxcolor("grün", x);
    fxcolor("grün", y);
    fxcolor("grün", z);
    fxcolor("grün", 1)
  ) = fxcolor("orange", circle.filled.small)
$

== Hidden Surface removal (HSR)
Das _Entfernen_ von _nicht_ sichtbaren Flächen. Hierfür gibt es verschiedene Algorithmen.

=== Painter-Algorithm
_Ordnet_ die zu visualisierenden Flächen und zeichnet sie dann _von hinten nach vorne_.
Die weiter entfernten Flächen werden immer wieder _übermalt_.\
*Ablauf:*
+ _Ordne_ alle Polygone nach kleinstem $z$-Wert
+ Polygone mit überlappender $z$-Ausdehnung ggf. _umordnen_
+ _Ausgabe_ der Flächen von hinten nach vorne.

*Problem*: Überlappende Flächen werden nicht korrekt angezeigt, müssten zerschnitten werden.

#align(center, image("img/painter.png", width: 80%))

=== z-Buffer Algorithm
_Löst das Problem_ des Painter-Algorithmus. Benötigt _zwei 2-dimensionale Arrays_ als Buffer: Einmal den _z-Buffer_, der
für jedes Pixel den $z$-Wert des in diesem Punkt dem Betrachter am nächsten liegenden Objekt enthält
#hinweis[(grosser Z-Buffer $->$ näher am Betrachter)], und einmal den _Frame Buffer_, welcher den Farbwert jedes Pixels
speichert.

```
For each Area:
  Für each Pixel (x,y) on this area:
    calculate Color c and Depth z
    if z > depth[x,y]:
      Add color c at (x,y) in the Frame Buffer and set depth[x,y] to z
```

Wird vor diesem Algorithmus Back Face Culling durchgeführt, wird er _effizienter_. Das Ergebnis bleibt aber das Gleiche.

*Problem:* Nicht sehr effizient, weil er für jedes Pixel einer Scanline die z-Koordinate berechnen muss. Es kann auch
sein, dass ein bereits gesetztes Pixel später überschrieben wird.

=== Span-Buffer Algorithm
_Löst das Effizienz-Problem_ des z-Buffer Algorithmus. Eine Scanline durchläuft das Bild und zerfällt in Abschnitte
#hinweis[(Spans)]. Pro Span ist genau ein Polygon sichtbar.\
*Spans:* Nur Vorderflächen nach x-Koordinate sortieren, ggf. Flächen zerschneiden und vereinigen.

#image("img/spannerbuffer_1.png")
#image("img/spannerbuffer_2.png")

Ist _effizienter_, weil _kein Pixel mehrfach eingefärbt_ und die _Tiefe nicht überprüft_ werden muss, dafür muss
_zusätzliche Arbeit_ für die _Ermittlung_ der _Spans_ aufgewendet werden.

*Problem:* Gegenseitiges Durchdringen/Kreuzen wird nicht erkannt. Bei hoher Polygonanzahl weniger effizient als
Z-Buffer.

=== Binary Space Partition Tree
Analysiert die _Lage_ der _Objekte_ untereinander mithilfe einer _Baumstruktur_. Ist unabhängig von der Kamera, die
Root-Kante kann _beliebig_ gewählt werden. Sehr teuer in der Berechnung #hinweis[($O(n^2)$)], nur für statische Szenen
#hinweis[(z.B. Kamerafahrt in Cutscene)].

Der _BSP-Tree_ speichert die Objekt-Beziehungen. _Jeder innere Knoten_ repräsentiert eine _Polygonfläche F_, welche
die Szene aufteilt in

#grid(
  columns: (1.6fr, 1fr),
  [
    - _vorderen Teil:_ F ist hier sichtbar
    - _hinterer Teil:_ F ist hier nicht sichtbar
  ],
  [
    #v(-1em)
    #image("img/bspt.png")
  ],
)

#colbreak()

*Ablauf zur Berechnung eines BSP-Tree:*
+ Alle Kanten aller Objekte im Raum nummerieren #hinweis[(R1-R4, D1-D3)]
+ Entlang der ersten Kante des ersten Objektes _eine Linie ziehen_ #hinweis[(Linie $C_1$ entlang Kante $R_1$)].
  Markieren, welche Seite der Linie vor der Fläche ($+$) und welche dahinter ($-$) liegt.
+ Kante und Linie in Tree eintragen. Auf der äusseren Seite des Objektes ist der _sichtbare Teilbaum_,
  auf der anderen der _nicht sichtbare_. Wenn eine Seite gar keinen Inhalt hat, wird dies im Baum mit einem
  rechteckigen Feld markiert.
+ Mit der _zweiten Seite_ des ersten Objektes _fortfahren_ #hinweis[($R_2$)].
+ So lange wiederholen, bis _alle Kanten_ im Baum angegliedert sind und _alle Blätter_ ein _eckiges Feld_ sind.

#align(image("img/bsp_tree.png", width: 90%), center)

Im Bild sind die Flächen gelb markiert, die in _Richtung *$P$*_ zeigen - also diejenigen Kanten, deren _*$+$*-Seite_
dem Punkt $P$ zugewandt sind. In diesem Fall werden $R_2$ und $R_3$ jedoch von $D_2$ _überdeckt_ und sind deshalb
_trotzdem nicht sichtbar_.

_Flächen, die auf der selben Seite liegen wie der Augenpunkt..._
- können Flächen auf der anderen Seite _verdecken_
- können von Flächen auf der anderen Seite _nicht verdeckt werden_

*Achtung:* Wenn eine der Trennebenen #hinweis[(gezeichnete Linien)] durch eine andere Fläche durchgeht, muss die Fläche
am Schnittpunkt der Linie in zwei Hälften geteilt werden.

= Beleuchtung
Es gibt zwei Beleuchtungsmodelle: _lokal_ und _global_.\
Damit Beleuchtung auf Objekte angewendet werden kann, müssen diese zuerst _trianguliert_
#hinweis[(in Dreiecke umgewandelt)] werden. Diese eignen sich ausgezeichnet für _Scanline-Verfahren_, da für
jede Bildschirmzeile _maximal zwei Schnittpunkte_ mit den Dreieckskanten auftreten.
- _Konvexe Polygone:_ Von einem beliebigen Eckpunkt aus zu allen nicht benachbarten Eckpunkten Diagonalen ziehen.
- _Konkave Polygone:_ Etwas komplizierter, hierzu gibt es Libraries

In die _Berechnung der Farbe_ eines Pixels fliessen mehrere Faktoren ein: Materialeigenschaften des Objekts, Augenpunkt
des Betrachters, Normalenvektor des Objekts, Positionierung und Art der Lichtquellen.

== Lichtquellen
Es gibt verschiedene Arten von Lichtquellen:
- _Umgebungslicht / Ambient Light:_ Hat weder Position noch Richtung. Generiert keinen Schatten. Wird mit konstanter
  Intensität $I_a$ beschrieben #hinweis[(z.B. "Fullbright" in Source Engine)].
- _Gerichtetes Licht / Directed Light:_ Hat keine Position, aber eine Richtung. Wird mit Intensität $I_a$ und
  Lichtrichtung $L_g$ beschrieben #hinweis[(z.B. Sonnenlicht)].
- _Punktlicht / Point Light:_ Hat eine Position $P$, aber keine bevorzugte Richtung
  #hinweis[(Strahlt vom Punkt in alle Richtungen aus)]. Hat eine Anfangs-Intensität $I_0$, welche mit Entfernung abnimmt.
  $
    I(r) = I_0/(C_1 + C_2 dot r)\ \
    underbracket(r >= 0, "Abstand"\ "zur Lichtquelle") quad
    underbracket(C_2 >= 0, "Abschwächungs-"\ "koeffizient") quad
    underbracket(C_1 >= 1, "(verhindert"\ "zu kleinen Nenner)")
  $
- _Strahler / Spot Light:_ Hat Position $P$, Lichtrichtung $L$, Intensität $I_0$, Abschwächungskoeffizienten $C_1, C_2$,
  Abstrahlwinkel $alpha$ und einen Konzentrationsexponenten $c$. Die Intensität bei Richtung $r = cos(r, L)^c$, wobei
  $(r,L)$ der Zwischenwinkel zwischen $r$ und $L$ darstellt. Je grösser $c$, desto stärker ist die Intensität im Zentrum
  des Lichtkegels gebündelt #hinweis[(z.B. Nachttischlampe)].

=== Gesamtbeleuchtung pro Pixel
Setzt sich zusammen aus _ambientem Licht_ $overline(C_a)$ , _diffus reflektiertem gerichteten Licht_ $overline(C_d_i)$
und _spekular reflektiertem gerichtetem Licht_ $overline(C_s_i)$ #hinweis[($i$ = Lichtquelle)].

$ overline(C) = overline(C_a) + sum^n_(i=1) overline(C_d_i) + sum^n_(i=1) overline(C_s_i) $

Die Gesamtbeleuchtung muss für _jede Farbe einzeln berechnet_ werden.

== Reflexion
Das Reflexionsverhalten eines Körpers wird durch folgende Eigenschaften bestimmt:
- _*$k_a$*:_ ambienter Reflexionskoeffizient #hinweis[(wie stark reflektiert amb. Licht)]
- _*$k_d$*:_ diffuser Reflexionskoeffizient #hinweis[(wie stark reflektiert diffuses Licht)]
- _*$k_s$*:_ spekularer Reflexionskoeffizient #hinweis[(wie stark reflektiert Punktlicht)]
- _*$overline(O_d)$*:_ diffuse Objektfarbe #hinweis[(durch Spiegelung erzeugt)]
- _*$overline(O_s)$*:_ spekulare Objektfarbe #hinweis[(durch Spiegelung erzeugt)]
- _*$O_e$*:_ spekularer Exponent

=== Ambiente Reflexion
_Grundhelligkeit_ eines Objekts.
$
  overline(C_a) = underbracket(k_a, "ambienter"\ "Reflexionskoeffizient")
  dot underbracket(I_a, "Intensität des"\ "ambienten Lichts")
  dot underbracket(overline(O_d), "diffuse"\ "Objektfarbe")
$

=== Diffuse Reflexion
Vom Objekt diffus reflektiertes Licht #hinweis[(Lichtstreuung)], ist überall _gleichmässig sichtbar_.

#image("img/diffus_reflexion_all.png")

=== Spekulare Reflexion
Vom Objekt gespiegeltes Licht $R$, _nur in bestimmte Richtung sichtbar_.

#image("img/spekular_reflexion.png")

=== Materialeigenschaften
- _Objekte sollten nicht mehr abstrahlen als empfangen:_\
  #v(-0.5em)
  #grid(
    $ 0 <= k_a, k_d, k_s <= 1 $,
    $ k_a + k_d + k_s <= 1 $,
  )
  #v(-0.25em)
- _kontrastarm:_ Ambienter Teil ist am stärksten: $k_a >> k_d, k_s$
- _matt:_ Diffuser Teil ist viel grösser als Spekularteil: $k_d >> k_s$
- _spiegelnd:_ Spekularteil ist grösser als Diffusteil: $k_s > k_d$

== Schattierung (Shading)
#align(image("img/shading.png", width: 80%), center)

=== Flat Shading
_Pro Dreieck/Polygon eine Farbe._ Eckpunkte im WC beleuchten, Farb-Mittelwert $C_i$ der Eckpunkte berechnen, diese Farbe für
alle Pixel im Polygon verwenden. Kanten zwischen Polygonen sind mit dieser Variante sichtbar.

#image("img/flat_shading.png")

=== Gouraud Shading
_Interpolation_ der Farbwerte $C_i$. Die Farbwerte der _Eckpunkte_ $overline(C_A), overline(C_B), overline(C_C)$
werden _fix_ gesetzt und der Rest wird mit Interpolation gefüllt. $y = y$-Wert der Scanline.

#align(image("img/gourauad.png", width: 88%), center)

=== Phong Shading
_Aufwändigste Version._ Interpoliert _pro Scanline_ die Anfangs- und die Endnormale. Pro Pixel wird ebenfalls die
Normale interpoliert und daraus der Farbwert berechnet.\
Im Vergleich zu Gouraud Shading ist bei Phong wirklich _jeder Pixel unterschiedlich_.

== Schatten
Von der _Lichtquelle nicht sichtbare Pixel_. Um zu berechnen, ob ein Pixel im Schatten liegt oder nicht, kann ein
beliebiger _Hidden-Surface-Removal-Algorithmus_ verwendet werden.
- _Phase 1:_ Rendere Bild aus Position der Lichtquelle $L$ in einem Schattentiefenpuffer $s_"tiefe"$
- _Phase 2:_ Rendere Bild aus Position des Betrachters mit modifiziertem Z-Buffer-Algorithmus: falls Pixel $P(x,y,z)$
  sichtbar ist, transformiere $P$ in den Koordinatenraum von Phase 1 zu $P'(x',y',z')$.

Falls $z' < s_"tiefe" [x',y']$, dann ist $P$ im Schatten von $L$.\
Falls $z' >= s_"tiefe" [x',y']$, dann ist $P$ nicht im Schatten von $L$.

#align(center, image("img/shadows.png", width: 70%))


= Texturing
Verfahren, bei denen das _Aussehen_ einer _Fläche verändert_ wird. Zur realistischen Gestaltung verwendet man ein
_zweidimensionales Musterfeld_ #hinweis[(Texture Map)], bestehend aus _Texeln_ #hinweis[(Texturpixeln)], aus denen für
jedes Pixel die Farbe ermittelt werden kann. Die Textur wird _zuerst_ an die _Geometrie des Objekts angepasst_ und
anschliessend darauf gemappt.

== Phasen des Texture Mapping
- _Raumkoordinaten_ des Flächenpunktes berechnen $(x',y',z')$
- Zugehörige _Flächenkoordinaten_ berechnen $=> (x,y)$
- Abbildung in den _Parameterraum_ durchführen $=> (u,v)$
- _Texturkoordinaten_ berechnen #hinweis[(Korrespondenzfunkt. berücksichtigen)]
- _Texturwerte_ ermitteln
- _Erscheinungsbild_ mit dem Texturwert _modifizieren_.

#align(center, image("img/texture_mapping.png", width: 90%))

=== Korrespondenzfunktion
#align(center, image("img/creepy_face.png", width: 80%))

=== Sphärische Projektion
#image("img/sphaerisch.png")

== Textur-Artefakte / Mip Mapping
_multum in parvo mapping:_ Viel in wenig. Halte verschiedene bereits vorberechnete Textur-Auflösungen für verschiedene
Level of Detail #hinweis[(LOD)] bereit.

#image("img/lod.png")

== Algorithmen
*Arten der Texturanwendung:*
_statisch:_ Texture Map normal anwenden,
_mit Störungen:_ Veränderung der Textur durch Noise, sieht dann natürlicher aus,
_prozedural:_ Mit bestimmten Algorithmen können Muster wie Marmorierung erstellt werden.\
*Light Map:*
Pro Face die _Beleuchtung vorberechnen_ und in Light Map ablegen.\
*Shadow Map:*
Berechne _z-Buffer aus Sicht der Lichtquelle_ und lege in _Shadow Map_ ab. Moduliere Pixelfarbe mit Hilfe
der Shadow Map. _Artefakte_ können je nach Auflösung des z-Buffers entstehen. Oft zusammen mit Light Map generiert.\
*Alpha Mapping:*
Für _teilweise durchsichtige Elemente_ wie z.B. Laub an Baum. Textur enthält Alphawerte: $0 =$ durchsichtig,̣\
$0<x<255 =$ teilweise durchsichtig, $255 =$ undurchsichtig.\
_Achtung:_ Reihenfolge muss beachtet werden.\
*Environment Mapping:*
Textur enthält _Projektion der Umgebung_ #hinweis[(für spiegelnde Objekte)]. Dafür gibt es verschiedene Mapping-Arten
wie _Sphere Environment Mapping_ #hinweis[(Kugel, auf die die Umgebung gemappt wird. Sieht nur in kleinem Bereich
  um Kugel gut aus)] oder _Cube Environment Mapping_ #hinweis[(Speichere pro Objekt sechs Projektionen als Würfel,
  Zugriff abhängig vom Augenpunkt, an welchem der Lichtstrahl der Spiegelung den Würfel trifft]).\
*Bump Mapping:*
Durch Modifizierung der Normalenvektoren in Kombination mit Textur können Unebenheiten simuliert werden
#hinweis[(z.B. Backsteinmauer, bei Fugen weniger hoch)].
_Implementation:_ Benötigt Height Mapping #hinweis[(1 Wert, Grauwertmatrix, enthält Höhenänderungen)]
und Normal Mapping #hinweis[(3 Werte, Farbmatrix enthält Normalenrichtungsänderung)].
_Achtung:_ Suggerierte Höhendifferenzen sind von der Seite her nicht sichtbar und haben keine Auswirkung auf Physik.\
*Displacement Mapping:*
Textur enthält Angaben zur _Veränderung der Geometrie_. _Vorteile:_ Displacement Map + grobe Geometrie braucht
weniger Platz als feine Geometrie. Eine Geometrie ist mit mehreren Displacements #hinweis[(Skins)] nutzbar.
_Funktionsweise:_ Jede Fläche des Körpers wird anhand der Displacement Map in mehrere kleine Flächen unterteilt.
Die neuen Punkte können nur entlang der Flächennormalen verschoben werden. Sie werden also entweder aus der Fläche
herausgehoben oder hineingeschoben. Die Stärke der Verschiebung ist in der Displacement Map als Grauwert hinterlegt.
Eignet sich besonders gut, um Landschaften kompakt zu beschreiben.\
*Netzvereinfachung:*
Mit Displacement Map ist es auch möglich, die _Zahl der Polygone_ für ein Körper deutlich zu _reduzieren_ und
mittels einer Map wiederherzustellen. Ermöglicht einfache Generierung von LOD-Modellen.


= Augmented Reality
Unter erweiterter Realität / Augmented Reality versteht man die _computergestützte Erweiterung der Wahrnehmung_.
Kann alle menschlichen _Sinne_ ansprechen, häufig wird jedoch nur die _visuelle Darstellung von Informationen_ verstanden,
also die _Ergänzung_ von Bildern und Videos mit _computergenerierten Zusatzinformationen_ oder _virtuellen Objekten_
mittels _Einblendung/Überlagerung_ #hinweis[(XBOX Kinect, HUD)].


= Raytracing
#grid(
  [
    Strahlverfolgung eignet sich zur _Modellierung_ von _spiegelnden Reflexionen_ und von _Transparenz_ mit Brechung.
    Für jeden Pixel wird ausgehend von der Kamera ein Strahl gelegt und der Schnittpunkt mit dem ersten Objekt bestimmt.
  ],
  [
    #v(-1em)
    #image("img/raytracing.png")
  ],
)

Bei spiegelnden Objekten wird der Reflexionsstrahl berechnet und rekursiv weiter behandelt, bei Transparenz wird
zusätzlich der gebrochene Strahl weiter behandelt.\
*Effizienzsteigerung:*
Berechnung ist sehr aufwändig, durch Z-Buffer, Begrenzungsvolumen und Tree-Erstellung kann die Effizienz etwas
gesteigert werden.

#align(center, image("img/raytracing_kugel.png", width: 70%))

$
  x = (1-t) dot x_0 + t dot x_1, space "gleiche Formel auch für y und z"\
  (x - a)^2 + (y - b)^2 + (z - c)^2 = r^2
$

Einsetzen liefert quadratische Gleichung in $t$.
Resultat: 0 #hinweis[(nicht auf Kugel)], 1 #hinweis[(tangential auf Kugel)] oder 2 Schnittpunkte $(x,y,z)$


= Physikalische Simulationen
*Starre Körper #hinweis[(rigid body)]:*
Verformt sich nicht, hat Masse, Trägheitsmoment, momentaner Bewegungszustand und Kollisionsgeometrie.\
*Weiche Körper:*
Können sich verformen. Häufig kombiniert mit starren Körpern #hinweis[(z.B. Haare, Wasser, Boobies)]\
*Kollisionen:*
Einzelne Körper dürfen sich _nicht durchdringen_. Beim Kontakt werden die _Kontaktkräfte berechnet_ und
auf die Körper _angewendet_.\
*Physikalische Simulation:*
Aus dem momentanen _Bewegungszustand_ aller Körper wird mittels Simulation der _nächste Zustand_ abgeleitet.
Es gibt zwei Arten der Simulation: _Lagrange_ #hinweis[(mit und ohne reduzierte Koordinaten)] und _Impulsbasiert_.

== Constraints
Über Constraints #hinweis[(Joints)] können mehrere Körper miteinander verbunden werden.
Constraints sind _physikalische Zwangsbedingungen_ #hinweis[(Scharnier einer Türe, Kugellager, ...)].

#grid(
  columns: (auto, 1fr),
  align: (x, _) => if (x == 1) { center } else { auto },
  [
    - _Slider-Constraint:_ Führung
    - _Hinge-Constraint:_ Scharnier
    - _Point-To-Point Constraint:_ Joint
  ],
  [
    #v(-3em)
    #rotate(image("img/constraints.png", width: 50%), 90deg)
  ],
)
#v(-1.5em)
Kraftimpulse müssen so berechnet werden, dass Constraints gültig bleiben.


= Shaders
Shader sind _Programme_ zur _Beeinflussung der Darstellung_ von Objekten und Effekten in der _Grafikpipeline_.
Werden in _HLSL_ oder _GLSL_ geschrieben. Sie nutzen _parallele Berechnungen_ für hohe Effizienz und
_ermöglichen komplexe Effekte_ wie Licht, Schatten und Spiegelungen direkt auf der GPU.

== Arten von Shadern
Neben _Fragment-Shadern_ und _Vertex-Shadern_ gibt es auch noch _Geometry-Shader_
#hinweis[(Erzeugen zusätzliche Geometrie)] und _Tessellation-Shader_ #hinweis[(Verfeinern Oberflächen)].

=== Fragment-Shader / Pixel Shader
Berechnen Farbe und Eigenschaften _einzelner Pixel_ für realistische Darstellung in 3D-Rendering.
Steuern Licht, Farbe und Transparenz von Materialien und Oberflächen.
_Normierte UV-Koordinaten_ zwischen $0$ und $1$ ermöglichen flexible Texturzuordnung auf unterschiedlichen Auflösungen.
Fragment-Shader sind _zustandslos_ #hinweis[(da sonst Probleme mit Parallelisierung)].
Hohe Rechenleistung nötig.\
*Anwendungsbereiche:*
Visuelle Effekte, Komplexe Rendering-Techniken #hinweis[(HDR, Bloom, Lensflare)], Verzerrungs- und Umwelteffekte
#hinweis[(Wasser- & Hitzewellen)].

=== Vertex-Shader
_Verändern die Position von Punkten_ im dreidimensionalen Raum anhand ihrer Koordinaten zur Simulation von Bewegung und Tiefe.
Verwenden Funktionen wie _Skalierung_, _Rotation_ und _Verschiebung_. Sind die _erste Stufe_ der Rendering-Pipeline
und beeinflussen direkt die Objektgeometrie. Sie verarbeiten _grosse Datenmengen parallel_ und sind deshalb für
_Echtzeit-Grafikanwendungen_ ideal. Sind _zustandslos_.\
*Anwendungsbereiche:*
Animation von Wasserwelle oder bewegtem Gras, Terrain-Generierung #hinweis[(Höhen von Vertices mit Noise-Texturen)]\
*Besonderheiten:*
Komplexe Bewegungen müssen in anderen Teilen der Grafik-Engine umgesetzt werden

=== Gegenüberstellung
#image("img/shady_comparison.png")
