
#let code-block(body) = {
    block(
        fill: rgb("#f9fbff"),
        stroke: (paint: rgb("#a8a1d1"), thickness: 0.5pt),
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

#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]

#let ascii-art(body) = text(
    font: ("Fira Code", "Fira Mono", "Comic Sans MS", "JetBrains Mono", "JetBrains Mono NL"),
    ligatures: true,
    size: 3.7pt,
    par(
        justify: false,
        body,
    ),
);
