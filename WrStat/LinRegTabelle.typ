#import "../template_zusammenf.typ": *
/*
#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "WrStat",
  fach-long: "Wahrscheinlichkeit und Statistik",
  semester: "HS24",
)*/

#let write-line = box(width: 1fr, line(length: 100%, stroke: 0.5pt))

= Beiblatt Lineare Regression
#grid(
  columns: (1.5fr, 2fr),
  gutter: 1em,
  [*Name:* #write-line], [*Aufgabe:* #write-line],
)

#table(
  columns: (1fr, auto, auto, 1fr, 1fr, 1fr),
  table.header(
    [*$i$*],
    [*$x$* #hinweis[(Punkt auf x-Achse)]],
    [*$y$* #hinweis[(Punkt auf y-Achse)]],
    [*$x^2$*],
    [*$y^2$*],
    [*$x dot y$*],
  ),
  table.hline(stroke: 1.5pt + black),
  [1], [], [], [], [], [],
  [2], [], [], [], [], [],
  [3], [], [], [], [], [],
  [4], [], [], [], [], [],
  [5], [], [], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [6], [], [], [], [], [],
  [7], [], [], [], [], [],
  [8], [], [], [], [], [],
  [9], [], [], [], [], [],
  [10], [], [], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [11], [], [], [], [], [],
  [12], [], [], [], [], [],
  [13], [], [], [], [], [],
  [14], [], [], [], [], [],
  [15], [], [], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [$ sum $], [], [], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [Erwartungs-wert $ = sum / "Anzahl" $ ],
  [$E(X) =$],
  [$E(Y) =$],
  [$E(X^2) =$],
  [$E(Y^2) =$],
  [$E(X dot Y) =$],
  table.hline(stroke: 1.5pt + black),
)

#linebreak()

$
  bold("cov"(X,Y)) &= E(X dot Y) - E(X) dot E(Y) &= "_____________________________"\
  bold("var"(X)) &= E(X^2) - E(X)^2 &= "_____________________________"\
  bold("var"(Y)) &= E(Y^2) - E(Y)^2 &= "_____________________________"\
  bold(a) &= ("cov"(X,Y)) / "var"(X) &= "_____________________________"\
  bold(b) &= E(Y) - a dot E(X) &= "_____________________________"
$

*linearisiert:* $display(y(x) = a dot x + b)$

==== Qualität prüfen
$
  r = "cov"(X, Y) / sqrt("var"(X) dot "var"(Y)) = "_____________________________" quad
  arrow quad r^2 = "_____________________________"
$
Qualität der linearisierten Funktion ist besser, je näher $r^2$ zu $1$ ist.

==== Modell gut?
#{
  show list: set list(marker: [#sym.square])
  [
    - Ja, da $r^2$ nahe an 1 ist $=>$ Modell ist gut
    - Nein, da $r^2$ nicht nahe bei $1$ ist. $=>$ Modell ist schlecht.
  ]
}
