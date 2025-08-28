// Template Zusammenfassung
// (C) 2025 Nina Grässli, Jannis Tschan
#import "helpers.typ": *

// Global variables
#let colors = (
  hellblau: rgb("#29769E"),
  dunkelblau: rgb("#1A4E69"),
  grün: rgb("#8B9654"),
  hellgrün: rgb("#BFBC8A"),
  gelb: rgb("#F2C12E"),
  rot: rgb("#A6460F"),
  orange: rgb("#D98825"),
  comment: rgb("#2D9428"),
)

#let languages = (
  de: (page: "Seite", chapter: "Kapitel", toc: "Inhaltsverzeichnis"),
  en: (page: "Page", chapter: "Chapter", toc: "Contents"),
)

#let dateformat = "[day].[month].[year]"

// Main template
#let project(
  authors: (),
  fach: "",
  fach-long: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  column-count: 1,
  tableofcontents: (enabled: false, depth: "", columns: ""), // (depth: none, columns: 1)
  language: "de",
  font-size: 11pt,
  display-title-footer: true,
  heading-page-number-in-ref: true,
  appendix: (), // specifiy path to .typ file to add appendix documents
  body,
) = {
  // == Document Configuration ==
  // PDF Metadata
  set document(
    author: authors,
    title: fach + " Zusammenfassung " + semester,
    date: date,
  )

  let font-default = (font: "Calibri", lang: language, region: "ch", size: font-size)

  let font-special = (
    ..font-default,
    font: "JetBrains Mono",
    weight: "bold",
    fill: colors.hellblau,
  )

  let footer = context [
    #set text(font: font-special.font, size: 0.9em)
    #let separator = if (authors.len() > 2) { ", " } else { " & " } 
    #fach | #semester | #authors.join(separator)
    #h(1fr)
    #languages.at(language).page #counter(page).display()
  ]

  set page(
    flipped: landscape,
    columns: column-count,
    footer: if (display-title-footer) { footer },
    margin: if (column-count < 2) {
      (top: 2cm, left: 1.5cm, right: 1.5cm, bottom: 2cm)
    } else {
      0.5cm
    },
  )

  set columns(column-count, gutter: 2em)

  // Default document font
  set text(..font-default)

  // Style built-in functions
  // Headings formatting
  set heading(numbering: "1.1.1.", supplement: languages.at(language).chapter)
  show heading: hd => block({
    if hd.numbering != none and hd.level <= 3 {
      context counter(heading).display()
      h(1.3em)
    }
    hd.body
  })

  show heading.where(level: 1): h => {
    set text(..font-special, top-edge: 0.18em)
    set par(leading: 1.3em, hanging-indent: 2.5em)
    line(length: 100%, stroke: 0.18em + colors.hellblau)
    upper(h)
    v(0.45em)
  }

  show heading.where(level: 2): h => {
    set text(size: 0.9em)
    upper(h)
  }

  // Remove space above H4, fixes spacing between H3 & H4
  show heading.where(level: 4): h => {
    v(-0.4em)
    h
  }

  // Table formatting
  set table(
    stroke: (x, y) => (
      left: if x > 0 { 0.07em },
      top: if y > 0 { 0.07em },
    ),
    inset: 0.5em,
  )

  // Recommended workaround in Typst 0.11 until table.header is styleable
  show table.cell.where(y: 0): emph

  // Unordered list, use with "- " or #list[]
  show list: set list(marker: "–", body-indent: 0.45em)

  // "Important" template, use with "_text_" or #emph[]
  show emph: set text(fill: font-special.fill, weight: font-special.weight)

  // Code, use with ```python print("Hello World")```
  show raw: set text(font: font-special.font, size: 1em)

  // Quotes
  set quote(block: true, quotes: true)
  show quote: q => {
    set align(left)
    set text(style: "italic")
    q
  }

  // Reference, show heading name & page number
  show ref: ref => if ref.element.func() != heading {
    ref
  } else {
    let label = ref.target
    let header = ref.element
    if heading-page-number-in-ref {
      // "Heading Name" (Page X)
      link(label, ["#header.body" (#languages.at(language).page #header.location().page())])
    } else {
      // Chapter 1.1.1 "Heading Name"
      let chapter-numbering = counter(heading).at(header.label)
      link(label, [#header.supplement #numbering(header.numbering, ..chapter-numbering) "#header.body"])
    }
  }

  // Table of contents
  set outline(indent: 0em)

  // Table of contents, header level 1
  show outline.entry.where(level: 1): entry => {
    v(1.1em, weak: true)
    strong(entry)
  }

  // Title page configuration
  let subtitle(subt) = [
    #set text(..font-special, size: 1.2em)
    #pad(bottom: 1.3em, subt)
  ]

  // == Page Content ==
  // title row
  if (display-title-footer) {
    align(left)[
      #text(..font-special, size: 1.8em, fach-long + " | " + fach)
      #v(1em, weak: true)
      #subtitle[Zusammenfassung]
    ]
  }

  // Table of contents
  if (tableofcontents.enabled) {
    // Generate language-specific ToC header spanning the whole page
    heading(outlined: false, numbering: none, languages.at(language).toc)
    columns(
      // Set number of columns for ToC
      tableofcontents.at("columns", default: 1),
      outline(
        depth: tableofcontents.at("depth", default: none),
        title: none,
      ),
    )
    pagebreak()
  }

  // Main body
  set par(justify: true)
  body

  // Appendix Documents
  counter(heading).update(0)
  set heading(numbering: "I.I")
  for document in appendix {
    pagebreak()
    include document
  }
}

// Additional formatting templates
// "Zusätzlicher Hinweis"-Vorlage
#let hinweis(style: "italic", t) = {
  set text(style: style, size: 0.8em)
  show raw: set text(font: "JetBrains Mono", size: 1.05em)
  t
}

// "Definition"-Vorlage
#let definition(t) = {
  rect(stroke: 0.13em + colors.hellblau, inset: 0.73em, columns(1, t), width: 100%)
}

// Kommentar
#let comment(t) = {
  set text(style: "italic", weight: "bold", fill: colors.comment)
  t
}

// Small text, #hinweis without italic
#let small(t) = {
  hinweis(style: "normal", t)
}

// Text added by Jannis
#let jannis(t) = {
  set text(fill: colors.orange)
  t
}

// Text added by Nina
#let nina(t) = {
  set text(weight: "bold", fill: colors.rot)
  t
}

// Set a text color from the color dict for a math formula
#let fxcolor(subcolor, x) = {
  text(fill: colors.at(subcolor), $bold(#x)$)
}

// Set a text color from the color dict for regular text
#let tcolor(subcolor, x) = {
  text(fill: colors.at(subcolor), style: "italic", strong(x))
}

// Table cells with a cross/checkmark
#let cell-check = table.cell(align: center, text(fill: colors.grün, weight: "bold", sym.checkmark))
#let cell-cross = table.cell(align: center, text(fill: colors.rot, weight: "bold", sym.crossmark))

// Plus/minus signs
#let plus = text(fill: colors.grün, weight: "bold", sym.plus)
#let minus = text(fill: colors.rot, weight: "bold", sym.minus)

// List with plus/minus signs
#let plus-list(content) = {
  set enum(numbering: x => plus)
  content
}

#let minus-list(content) = {
  set enum(numbering: x => minus)
  content
}
