#import "../template_zusammenf.typ": *

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "WrStat",
  fach-long: "Wahrscheinlichkeit und Statistik",
  semester: "HS24",
)*/

#let write-line = box(width: 1fr, line(length: 100%, stroke: 0.5pt))
#let equation-cell(body) = table.cell(inset: (y: 1em), body)

= Beiblatt Kolmogorov-Smirnov-Test
#grid(
  columns: (1.5fr, 2fr),
  gutter: 1em,
  [*Name:* #write-line], [*Aufgabe:* #write-line],
)

$bold(F(x_j)) =$ #write-line

#table(
  columns: (auto, auto, 1fr, 1fr),
  table.header(
    equation-cell[*$j$*],
    equation-cell[*$x_j$*\ #hinweis[(Messwerte sortiert)]],
    equation-cell[*$display(j/n) - F(x_j)$*],
    equation-cell[*$F(x_j) - display((j-1)/n)$*],
  ),

  table.hline(stroke: 1.5pt + black),
  [1], [], [], [],
  [2], [], [], [],
  [3], [], [], [],
  [4], [], [], [],
  [5], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [6], [], [], [],
  [7], [], [], [],
  [8], [], [], [],
  [9], [], [], [],
  [10], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [11], [], [], [],
  [12], [], [], [],
  [13], [], [], [],
  [14], [], [], [],
  [15], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [], [],
  equation-cell[$"m1" = "max"(j / n - F(x_j)) =$],
  equation-cell[$"m2" = "max"(F(x_j) - (j-1) / n) =$],
  table.hline(stroke: 1.5pt + black),
  [], [],
  equation-cell[$K^+_n = sqrt(n) dot "m1" =$],
  equation-cell[$K^-_n = sqrt(n) dot "m2" =$],
  table.hline(stroke: 1.5pt + black),
)

#linebreak()

==== Nullhypothese
#for i in range(3) {
  v(0em)
  write-line
  linebreak()
}

#v(1em)

$
  alpha = "________________" quad "pValue" = 1 - alpha = "________________" quad
  "Tabellenzeilen "n = "________________" quad K_"krit" = "________________"
$

#linebreak()

==== Ist *$K^+_n > K_"krit"?$*
#{
  show list: set list(marker: [#sym.square])
  [
    - Ja $arrow.double$ Die Nullhypothese muss verworfen werden
    - Nein $arrow.double$ Die Nullhypothese kann nicht verworfen werden
  ]
}
