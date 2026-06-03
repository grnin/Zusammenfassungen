// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
  authors: ("Jasmin Fässler", ""),
  fach: "BuRe2",
  fach-long: "Business und Recht 2 Vorlesung",
  semester: "FS24",
  language: "en",
  font-size: 10pt,
  tableofcontents: (enabled: true, depth: 3, columns: 2),
)


#let link_box(content) = block(
  fill: rgb("#eef2ff"),
  inset: 10pt,
  radius: 8pt,
  spacing: 0.75em,
  content,
)

#let notiz(content) = block(
  color: rgb("#da05a1"),
  // fill: rgb("#eef2ff"),
  // inset: 10pt,
  // radius: 8pt,
  // spacing: 0.75em,
  content,
)


// Document-specific settings
#show grid: set par(justify: false, linebreaks: "optimized")

#include "01 Obligationenrecht Allgemeiner Teil.typ"

// #include "00_Diagramme.typ"
#include "01_OR.typ"
#include "02_ZGB-Einleitung.typ"

// TODO: export to typst with correct underlines
#import "@preview/cmarker:0.1.8"
#cmarker.render(read("03_IT-Verträge.md"))