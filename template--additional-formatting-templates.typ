#import "./template--fonts-colors.typ": *


#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]

// "Zusätzlicher Hinweis"-Vorlage
#let hinweis(style: "italic", t) = {
    set text(style: style, size: 0.8em)
    show raw: set text(font: code-font, size: 1.05em)
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
#let plus-green = text(fill: colors.grün, weight: "bold", sym.plus)
#let minus-red = text(fill: colors.rot, weight: "bold", sym.minus)

// List with plus/minus signs
#let plus-list(content) = {
    set enum(numbering: x => plus-green)
    content
}

#let minus-list(content) = {
    set enum(numbering: x => minus-red)
    content
}
