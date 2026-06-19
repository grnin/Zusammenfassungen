

#let link_box(content) = block(fill: rgb("#eef2ff"), inset: 10pt, radius: 8pt, spacing: 0.75em, content)


#let color_box(content) = block(fill: rgb("#eef2ff"), inset: 10pt, radius: 8pt, spacing: 0.75em, content)

#let notiz(content) = text(
    // text: rgb("#da05a1"),
    fill: rgb("#e007a6"),
    content,
)

#let unwichtig(content) = text(
    content,
)

#let pruefung(content) = text(
    // text: font-size: 5pt,
    fill: rgb("#ffbbed"),
    content,
)

#set heading(numbering: "1.")
