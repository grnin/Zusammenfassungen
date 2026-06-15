
#import "./template--fonts-colors.typ": *

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
    // display-title-header: true,
    // display-title-footer: true,
    // heading-page-number-in-ref: true,
    display-title-header: false,
    display-title-footer: true,
    heading-page-number-in-ref: false,
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

    let font-default = (
        font: calibri-font,
        lang: language,
        region: "ch",
        size: font-size,
    )

    let font-special = (
        ..font-default,
        font: code-font,
        weight: "bold",
        fill: colors.hellblau,
    )

    let footer = context [
        #set text(font: font-special.font, size: 0.9em, fill: colors.light-grey)
        #let separator = if (authors.len() > 2) { ", " } else { " & " }
        #fach | #semester | #authors.join(separator)
        #h(1fr)
        #set text(font: font-special.font, size: 0.9em, fill: colors.text)
        #languages.at(language).page #counter(page).display()
    ]

    let header = context [
        #set text(font: font-default.font, size: 0.9em, fill: colors.grey)
        #set align(right)
        // #h(1fr)
        #languages.at(language).page #counter(page).display()


        //  Zeige die Titel dieser Seite an
        #context {
            let current_page = here().page()

            let headings = query(heading).filter(it => it.level in (1, 2) and it.location().page() == current_page)

            if headings.len() > 0 {
                headings.map(it => it.body).join(", ")
            } else {
                let headingsLowerLevel = query(heading).filter(it => (
                    it.level == 3 and it.location().page() == current_page
                ))
                if (headingsLowerLevel.len() > 0) {
                    set text(font: font-default.font, size: 0.7em, fill: colors.grey)
                    headingsLowerLevel.map(it => it.body).join(", ")
                }
            }
        }
    ]

    set page(
        header: if (display-title-header) { header },
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


    // -------------------------------------------------
    // Headings formatting

    // import "template--cheatsheet-headings.typ": *
    set heading(
        numbering: none,
        hanging-indent: 30pt,
    )

    // H1
    show heading.where(level: 1): h => {
        block(
            fill: colors.stroke-blue,
            sticky: true,
            // margin:
            // above: 2pt,
            above: 4.5pt,
            below: 1pt,
            // padding:
            inset: (top: 3pt, right: 2pt, bottom: 3pt, left: 2pt),
            width: 100%,
            text(
                font: calibri-font,
                style: "normal",
                weight: "light",
                size: 7pt,
                tracking: 0.75pt,
                fill: white,
                upper(h.body),
            ),
        )
        v(0.45em)
    }

    // H2
    show heading.where(level: 2): h => {
        block(
            fill: colors.light-blue,
            sticky: true,
            // margin:
            // above: 2pt,
            above: 4.5pt,
            below: 1pt,
            // padding:
            inset: (top: 3pt, right: 2pt, bottom: 3pt, left: 2pt),
            width: 100%,
            text(
                font: calibri-font,
                style: "normal",
                weight: "light",
                size: 5.5pt,
                tracking: 0.75pt,
                // fill: white,
                upper(h.body),
            ),
        )
        v(0.45em)
    }

    // H3
    show heading.where(level: 3): h => {
        block(
            above: 5pt,
            below: 4pt,
            text(
                font: aptos-font,
                style: "normal",
                weight: "semibold",
                size: 5pt,
                h.body,
            ),
        )
    }

    show heading.where(level: 4): h => {
        block(
            above: 5pt,
            below: 3pt,
            text(
                // size: 1.1em,
                size: 1em,
                fill: colors.bg-dark-blue,
                // [#(h.body)     --- --- --- --- --- --- --- --- --- ---],
                [#(h.body)],
            ),
        )
    }

    show heading.where(level: 5): h => {
        block(
            above: 3pt,
            below: 2pt,
            // text(
            // ),
            h.body,
        )
    }


    // compact version, kompakt
    // /*
    // // H1
    show heading.where(level: 1): h => {
        block(
            fill: colors.stroke-blue,
            sticky: true,
            // margin:
            above: 4pt,
            below: 1pt,
            inset: (top: 2pt, right: 1pt, bottom: 2pt, left: 1pt),
            width: 100%,
            text(
                font: calibri-font,
                style: "normal",
                weight: "light",
                size: 5pt,
                tracking: 0.5pt,
                fill: white,
                upper(h.body),
            ),
        )
    }

    // H2
    show heading.where(level: 2): heading => {
        block(
            fill: colors.light-blue,
            sticky: true,
            // margin:
            above: 2.25pt,
            below: 0.25pt,
            inset: 1.5pt,
            width: 100%,
            text(
                font: calibri-font,
                style: "normal",
                weight: "light",
                size: 4.5pt,
                tracking: 0.5pt,
                // fill: white,
                // upper([#h(-3pt) #heading.body]),
                upper(heading.body),
            ),
        )
        v(0.45em)
    }

    // H3
    show heading.where(level: 3): h => {
        block(
            above: 4.5pt,
            below: 2.8pt,
            inset: (left: -1pt),
            text(
                font: aptos-font,
                style: "normal",
                weight: "semibold",
                // size: 4.25pt,
                size: 1em,
                h.body,
            ),
        )
    }


    show heading.where(level: 4): h => {
        block(
            // above: 4pt,
            below: 2pt,
            text(
                size: 1em,
                fill: colors.bg-dark-blue,
                // [#(h.body)     --- --- --- --- --- --- --- --- --- ---],
                [#(h.body)],
            ),
        )
    }
    // */
    // end compact version


    // Remove space above H4, fixes spacing between H3 & H4
    show heading.where(level: 4): h => {
        v(-0.4em)
        h
    }
    // -------------------------------------------------


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

    // Set default sizing of grid
    set grid(columns: (1fr, 1fr), gutter: 1em)

    // Unordered list, use with "- " or #list[]
    show list: set list(marker: "–", body-indent: 0.45em)

    // "Important" template, use with "_text_" or #emph[]
    show emph: it => {
        text(
            fill: font-special.fill,
            weight: font-special.weight,
            style: "normal",
            it.body,
        )
    }


    // more syntaxes compact
    set enum(tight: true, spacing: .5em)
    set list(tight: true, spacing: .5em)
    set terms(
        // separator: [#h(2pt)],
        separator: [: ],
        hanging-indent: 0.75em,
        tight: true,
        // tight: false,
        spacing: .5em,
    )
    // // terms with more spacing:
    // show terms: body => {
    //     body
    //         .children
    //         .map(it => pad(left: body.indent + body.hanging-indent, {
    //             box(inset: (left: -body.hanging-indent), emph(it.term))
    //             emph(body.separator)
    //             it.description
    //         }))
    //         .join()
    // }

    // Code, use with ```python print("Hello World")```
    show raw: set text(font: font-special.font, size: 1em)

    // Quotes
    set quote(block: true, quotes: true)
    show quote: q => {
        set text(style: "italic")
        q
    }

    // // Reference, show heading name & page number
    // show ref: ref => if ref.element.func() != heading {
    //     ref
    // } else {
    //     let label = ref.target
    //     let header = ref.element
    //     if heading-page-number-in-ref {
    //         // "Heading Name" (Page X)
    //         link(label, ["#header.body" (#languages.at(language).page #header.location().page())])
    //     } else {
    //         // Chapter 1.1.1 "Heading Name"
    //         let chapter-g = counter(heading).at(header.label)
    //         link(label, [#header.supplement #g(header.g, ..chapter-g) "#header.body"])
    //     }
    // }


    // // Table of contents
    // set outline(indent: 0em)

    // // Table of contents, header level 1
    // show outline.entry.where(level: 1): entry => {
    //     v(1.1em, weak: true)
    //     strong(entry)
    // }

    // // Title page configuration
    // let subtitle(subt) = {
    //     set text(..font-special, size: 0.7em)
    //     pad(bottom: 1.3em, subt)
    // }

    // // == Page Content ==
    // // The title header
    // if (display-title-footer) {
    //     title[
    //         #text(..font-special, size: 1.06em, fach-long + " | " + fach)
    //         #v(0.6em, weak: true)
    //         #subtitle[Zusammenfassung]
    //     ]
    // }

    // // Table of contents
    // if (tableofcontents.enabled) {
    //     // Generate language-specific ToC header spanning the whole page
    //     heading(outlined: false, g: none, languages.at(language).toc)
    //     columns(
    //         // Set number of columns for ToC
    //         tableofcontents.at("columns", default: 1),
    //         outline(
    //             depth: tableofcontents.at("depth", default: none),
    //             title: none,
    //         ),
    //     )
    //     pagebreak()
    // }

    // Main body
    set par(
        justify: true,
        // Use character-level justification with recommended values
        // https://typst.app/docs/reference/model/par/#parameters-justification-limits
        justification-limits: (tracking: (min: -0.01em, max: 0.02em)),
    )
    body

    // // Appendix Documents
    // counter(heading).update(0)
    // set heading(g: "I.I")
    // for document in appendix {
    //     pagebreak()
    //     include document
    // }
}
