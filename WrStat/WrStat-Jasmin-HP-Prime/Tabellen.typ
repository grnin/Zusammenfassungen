#import "../template_zusammenf.typ": *

/*#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "WrStat",
  fach-long: "Wahrscheinlichkeit und Statistik",
  semester: "HS24",
)*/

#set figure(supplement: "Tabelle")
#show heading.where(level: 2): set heading(outlined: false, bookmarked: true)

= Verteilungstabellen
== Normalverteilung
#align(center)[
  #figure(
    image("img/wrstat_normalvert_tabelle.png", height: 65%),
    caption: [Verteilungsfunktion der Normalverteilung],
  )
]

#align(center)[
  #figure(
    image("img/wrstat_normalvert_quantiltabelle.png", height: 20%),
    caption: [Quantilen der Normalverteilung],
  )
]

== $chi^2$-Verteilung
#align(center)[
  #figure(
    image("img/wrstat_chiquad_tabelle.png"),
    caption: [Quantilen der $chi^2$-Verteilung],
  )
]

== Komolgorov-Smirnov-Test
#align(center)[
  #figure(
    image("img/wrstat_smirnov_tabelle.png"),
    caption: [Quantilen für den Komolgorov-Smirnov-Test],
  )
]

== t-Verteilung
#align(center)[
  #figure(
    image("img/wrstat_tVerteilung_tabelle.png", height: 80%),
    caption: [Quantilen der t-Verteilung],
  )
]
