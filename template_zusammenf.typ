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


// Main template
#let project(
  authors: (),
  fach: "",
  fach_long: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  column_count: 1,
  tableofcontents: false,
  tableofcontents_depth: none,
  language: "de",
  font_size: 11pt,
  body,
) = {
  // PDF Metadata
  set document(
    author: authors,
    title: fach + " Zusammenfassung " + semester,
    date: date,
  )

  let footer = [
    #set text(font: "JetBrains Mono", size: 0.9em)
    #fach | #semester | #authors.join(" & ")
    #h(1fr)
    #languages.at(language).page #counter(page).display()
  ]
  


  let font_defaults = (font: "Calibri", lang: language, region: "ch", size: font_size)
  
  let font_special = (
    ..font_defaults,
    font: "JetBrains Mono",
    weight: "bold",
    fill: color.hellblau,
 )

  set page(
    paper: "din-d4",
    flipped: landscape,
    columns: column_count,
    footer: footer,
    margin: if (column_count < 2) {
      (top: 2cm, left: 1.5cm, right: 1.5cm, bottom: 2cm)
    } else {
      (top: 0.5cm, left: 0.5cm, right: 0.5cm, bottom: 0.5cm)
    }
  )

  set columns(column_count, gutter: 2em)

  // Default document font
  set text(..font_defaults)

  // Style built-in functions
  // Headings formatting
  set heading(numbering: "1.1.")
  show heading: hd => block({
    if hd.numbering != none and hd.level <= 3 {
      context counter(heading).display()
      h(1.3em)
    }
    hd.body
  })

  show heading.where(level: 1): h => {
    set text(..font_special, top-edge: 0.18em)
    line(length: 100%, stroke: 0.18em + color.hellblau)
    upper(h)
    v(0.45em)
  }

  show heading.where(level: 2): h => {
    set text(size: 0.9em)
    upper(h)
  }

 // Table formatting
  set table(
    stroke: (x, y) => (left: if x > 0 { 0.07em }, top: if y > 0 { 0.07em }),
    inset: 0.5em,
  )

  // Recommended workaround in Typst 0.11 until table.header is styleable
  show table.cell.where(y: 0): emph

  // Unordered list, use with "- " or #list[]
  show list: set list(marker: "-", body-indent: 0.45em)

  // "Important" template, use with "_text_" or #emph[]
  show emph: set text(fill: font_special.fill, weight: font_special.weight)

  // Code, use with ```python print("Hello World")```
  show raw: set text(font: "JetBrains Mono", size: 1em)

  // Quotes
  set quote(block: true, quotes: true)
  show quote: q => {
    set align(left)
    set text(style: "italic")
    q
  }

  // Table of contents, header level 1
 show outline.entry.where(level: 1): entry => {
    v(1.1em, weak: true)
    strong(entry)
  }

  // Title page configuration
  let subtitle(subt) = [
    #set text(..font_special, size: 1.2em)
    #pad(bottom: 1.3em, subt)
  ]

  // title row
  align(left)[
    #text(..font_special, size: 1.8em, fach_long + " | " + fach)
    #v(1em, weak: true)
    #subtitle[Zusammenfassung]
  ]

  if (tableofcontents) {
    outline(depth: tableofcontents_depth)
    pagebreak()
  }

  // Main body
  set par(justify: true)
  body
}

// Additional formatting templates

// "Zusätzlicher Hinweis"-Vorlage
#let hinweis(t) = context {
  set text(style: "italic", size: 0.8em)
  show raw: set text(font: "JetBrains Mono", size: 1.1em)
  t
}

// "Definition"-Vorlage
#let definition(t) = {
  rect(stroke: 0.13em + color.hellblau, inset: 0.73em, columns(1, t))
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
