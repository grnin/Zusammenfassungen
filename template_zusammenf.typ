// Template Zusammenfassung
// (C) 2024, Nina Grässli, Jannis Tschan

// Global variables
#let color = (
  hellblau: rgb("#29769E"),
  grün: rgb("#8B9654"),
  gelb: rgb("#F2C12E"),
  rot: rgb("#A6460F"),
  orange: rgb("#D98825"),
  comment: rgb("#2d9428"),
)

#let languages = (
  de: (page: "Seite"),
  en: (page: "Page")
)

#let dateformat = "[day].[month].[year]"

#let project(
  authors: (),
  fach: "",
  fach_long: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  columns: 1,
  tableofcontents: false,
  tableofcontents_depth: none,
  language: "de",
  body,
) = {
  // PDF Metadata
  set document(
    author: authors,
    title: fach + " Zusammenfassung " + semester,
    date: date,
  )

  let font_defaults = (font: "Calibri", lang: language, region: "ch", size: 11pt)

  let font_special = (
    ..font_defaults,
    font: "JetBrains Mono",
    weight: "bold",
   fill: color.hellblau,
 )

  let footer = [
    #set text(font: "JetBrains Mono", size: 10pt)
    #fach | #semester | #authors.join(" & ")
    #h(1fr)
    #languages.at(language).page #counter(page).display()
  ]

  set page(
    paper: "din-d4",
    flipped: landscape,
    columns: columns,
    footer: footer,
    margin: (top: 2cm, left: 1.5cm, right: 1.5cm, bottom: 2cm),
  )

  // Default document font
  set text(..font_defaults)

  // Style built-in functions
  // Headings formatting
  set heading(numbering: "1.1.")
  show heading: hd => block({
    if hd.numbering != none and hd.level <= 3 {
      context counter(heading).display()
      h(15pt)
    }
    hd.body
  })

  show heading.where(level: 1): h => {
    set text(..font_special, top-edge: 2pt)
    line(length: 100%, stroke: 2pt + color.hellblau)
    upper(h)
    v(5pt)
  }

  show heading.where(level: 2): h => {
    set text(size: 12pt)
    upper(h)
  }

 // Table formatting
  set table(
    stroke: (x, y) => (left: if x > 0 { 1pt }, top: if y > 0 { 1pt }),
    inset: 6pt,
  )

  // Recommended workaround in Typst 0.11 until table.header is styleable
  show table.cell.where(y: 0): emph

  // Unordered list, use with "- " or #list[]
  show list: set list(marker: "-", body-indent: 5pt)

  // "Important" template, use with "_text_" or #emph[]
  show emph: set text(fill: font_special.fill, weight: font_special.weight)

  // Code, use with ```python print("Hello World")```
  show raw: set text(font: "JetBrains Mono", size: 9pt)

  // Quotes
  set quote(block: true, quotes: true)
  show quote: q => {
    set align(left)
    set text(style: "italic")
    q
  }

  // Table of contents, header level 1
 show outline.entry.where(level: 1): entry => {
    v(12pt, weak: true)
    strong(entry)
  }

  // Title page configuration
  let subtitle(subt) = [
    #set text(..font_special, size: 13pt)
    #pad(bottom: 15pt, subt)
  ]

  // title row
  align(left)[
    #text(..font_special, size: 20pt, fach_long + " | " + fach)
    #v(1em, weak: true)
    #subtitle[Zusammenfassung]
  ]

  if (tableofcontents) {
    //columns(2, outline())
    outline(depth: tableofcontents_depth)
    pagebreak()
  }

  // Main body
  set par(justify: true)
  body
}

// Additional formatting templates
// "Zusätzlicher Hinweis"-Vorlage
#let hinweis(t) = {
  set text(style: "italic", size: 9pt)
  show raw: set text(font: "JetBrains Mono", size: 8pt)
  t
}

// "Definition"-Vorlage
#let definition(t) = {
  rect(stroke: 1.5pt + color.hellblau, inset: 8pt, columns(1, t))
}

// Kommentar
#let comment(t) = {
  set text(style: "italic", weight: "bold", fill: color.comment)
  t
}

// Text added by Jannis
#let jannis(t) = {
  set text(weight: "bold", fill: color.orange)
  t
}
