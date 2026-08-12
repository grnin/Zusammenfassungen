
#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]

#let gekuerzt(body) = [
    // nicht anzeigen
]

#let print-image(body, replacement) = [
    // global variable: print-images and then show body or replacement
    // #replacement
    #body
]

#let hinweis(body) = [
    #set text(
        style: "italic",
    )
    #body
]

#let hinweis2(body) = [
    #set text(
        style: "italic",
    )
    #body
]

#let grid2(body1, body2) = [
    #grid(
        columns: (auto, auto),
        [
            #body1
        ],
        [
            #body2
        ],
    )
]

#let mt() = [
    #v(-0.5em)
]

#let mt1() = [
    #v(-1em)
]
