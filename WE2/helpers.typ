
// // TODO: überall hinweis von additional-formatting nehmen
// #let hinweis(style: "italic", t) = {
//     set text(style: style, size: 0.8em)
//     show raw: set text(font: code-font, size: 1.05em)
//     t
// }



#let code-block(body) = {
    block(
        fill: rgb("#eaf2ff7d"),
        stroke: (paint: rgb("#0b033845"), thickness: 0.5pt),
        inset: 5pt,
        radius: 4pt,
        above: 0.5em,
        below: 1em,
        body,
    )
}

#set heading(
    numbering: none,
);
