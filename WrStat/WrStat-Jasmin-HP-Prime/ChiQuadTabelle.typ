#import "../template_zusammenf.typ": *

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "WrStat",
  fach-long: "Wahrscheinlichkeit und Statistik",
  semester: "HS24",
)*/

#let write-line = box(width: 1fr, line(length: 100%, stroke: 0.5pt))

= Beiblatt $chi^2$-Test
#grid(
  columns: (1.5fr, 2fr),
  gutter: 1em,
  [*Name:* #write-line], [*Aufgabe:* #write-line],
)

#table(
  columns: (1fr, auto, auto, 1fr, 1.2fr),
  table.header(
    [*Kategorie $i$* \ #hinweis[Beschreibung ergänzen]],
    [*$p_i$* \ #hinweis[W'keit für Kategorie]],
    [*$n_i$* \ #hinweis[Anzahl in Kategorie]],
    [*$n dot p_i$*],
    [*$(n_i - n dot p_i)^2\/(n dot p_i)$* \ #hinweis[Diskrepanz Summanden]],
  ),
  table.hline(stroke: 1.5pt + black),
  [1], [], [], [], [],
  [2], [], [], [], [],
  [3], [], [], [], [],
  [4], [], [], [], [],
  [5], [], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [6], [], [], [], [],
  [7], [], [], [], [],
  [8], [], [], [], [],
  [9], [], [], [], [],
  [10], [], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [11], [], [], [], [],
  [12], [], [], [], [],
  [13], [], [], [], [],
  [14], [], [], [], [],
  [15], [], [], [], [],
  table.hline(stroke: 1.5pt + black),
  [$ sum $ #v(1em) ], [$p =$], [$n =$], [], [$D$ #hinweis[(Diskrepanz)] $=$],
  table.hline(stroke: 1.5pt + black),
)

#linebreak()

==== Nullhypothese
#v(0.5em)
#for i in range(3) {
  v(0em)
  write-line
  linebreak()
}

#v(1em)

$alpha =$ #write-line $"p-Value" = 1 - alpha =$ #write-line
$k =$ #write-line $D_"krit" =$ #write-line

#linebreak()

==== Ist *$D > D_"krit"$*?
#{
  show list: set list(marker: [#sym.square])
  [
    - Ja $=>$ Die Nullhypothese muss verworfen werden
    - Nein $=>$ Die Nullhypothese kann nicht verworfen werden.
  ]
}
