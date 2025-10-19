#import "../template_zusammenf.typ": *

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "WrStat",
  fach-long: "Wahrscheinlichkeit und Statistik",
  semester: "HS24",
)*/

#let write-line = box(width: 1fr, line(length: 100%, stroke: 0.5pt))
#let equation-cell(body) = table.cell(inset: (y: 1em), body)

= Beiblatt T-Test
#grid(
  columns: (1.5fr, 2fr),
  gutter: 1em,
  [*Name:* #write-line], [*Aufgabe:* #write-line],
)

#hinweis[Oberer Teil der Tabelle bleibt leer, falls Stichprobengrösse, Mittelwert und Varianz gegeben sind.]
#table(
  columns: (auto, 1fr, 1fr),
  align: (x, y) => { if (x == 0) { right } else { auto } },
  table.header([*$ i $*], [*$ x $*], [*$ y $*]),
  table.hline(stroke: 1.5pt + black),
  [1], [], [],
  [2], [], [],
  [3], [], [],
  [4], [], [],
  [5], [], [],
  table.hline(stroke: 1.5pt + black),
  [6], [], [],
  [7], [], [],
  [8], [], [],
  [9], [], [],
  [10], [], [],
  table.hline(stroke: 1.5pt + black),
  [11], [], [],
  [12], [], [],
  [13], [], [],
  [14], [], [],
  [15], [], [],
  table.hline(stroke: 1.5pt + black),
  [], [$n =$], [$m =$],
  table.hline(stroke: 1.5pt + black),
  [], table.cell(colspan: 2, align: horizon + center, [*Geschätzter Erwartungswert:*]), [],
  equation-cell[$dash(X) = 1 / n sum^n_(i=1) X_i =$],
  equation-cell[$dash(Y) = 1 / m sum^m_(i=1) Y_i =$],
  table.hline(stroke: 1.5pt + black),
  [], table.cell(colspan: 2, align: horizon + center, [*Geschätzte Varianz:*]),
  [],
  equation-cell[$sigma_x^2 = 1 / (n-1) sum^n_(i=1) (X_i - dash(X))^2=$],
  equation-cell[$sigma_y^2 = 1 / (m-1) sum^m_(i=1) (Y_i - dash(Y))^2=$],
  [],
  equation-cell[$sigma_x = sqrt(sigma^2_x) =$],
  equation-cell[$sigma_y = sqrt(sigma^2_y) =$],
  table.hline(stroke: 1.5pt + black),
)

#v(0em)

==== Teststatistik
$
  T = (dash(X) - dash(Y)) / sqrt((n-1) dot sigma^2_x + (m-1) dot sigma^2_y) dot sqrt((n dot m dot (n + m - 2))/(n + m))
  = "__________________________________"
$

==== Nullhypothese
#for i in range(2) {
  v(0.2em)
  write-line
  linebreak()
}

#v(0.5em)

$alpha =$ #write-line
$"p-Value" = 1 - alpha =$ #write-line #hinweis[(Kann auch $1-alpha\/2$ sein, wenn Abweichung beidseitig sein kann)]
#v(0.2em)
$"Freiheitsgrade "k = m + n -2 =$ #write-line
$T_"krit" =$ #write-line

#v(1em)

==== Ist *$abs(T) > T_"krit"?$*
#{
  show list: set list(marker: [#sym.square])
  [
    - Ja $=>$ Die Nullhypothese muss verworfen werden
    - Nein $=>$ Die Nullhypothese kann nicht verworfen werden
  ]
}
