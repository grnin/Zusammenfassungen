
finde ich zu unnötig, ich drucke hier einfach die Vorlesungsfolien aus

// /* test
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content
#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "BuRe2",
    fach-long: "Einleitungsartikel ZGB",
    semester: "FS26",
    language: "de",
    font-size: 10pt,
    tableofcontents: (enabled: true, depth: 3, columns: 2),
)
// */


// Typst Einstellungen

#import "helpers.typ": *
// #include "helpers.typ"


#let link_box(content) = block(
    fill: rgb("#eef2ff"),
    inset: 10pt,
    radius: 8pt,
    spacing: 0.75em,
    content,
)


// Document-specific settings
// #show grid: set par(justify: false, linebreaks: "optimized")§


#show heading.where(level: 1): h => {
    set text(
        //     // ..font-special,
        //     top-edge: 0.18em,
    )
    // set par(leading: 1.3em, hanging-indent: 2.5em)
    // line(
    //     length: 100%,
    //     stroke: 0.18em + colors.hellblau,
    // )
    // text(
    // size: 15pt,
    upper(h)
    // )
    v(0.45em)
}

#show heading.where(level: 2): h => {
    block(
        // above: 1.6em,
        above: 2em,
        below: 1.2em,
        text(
            font: aptos-font,
            style: "normal",
            weight: "bold",
            size: 1.5em,
            h.body,
        ),
    )
}

#show heading.where(level: 3): h => {
    block(
        above: 2.5em,
        below: 1.5em,
        text(
            font: aptos-font,
            style: "normal",
            weight: "bold",
            size: 1.4em,
            fill: colors.bg-dark-blue,
            h.body,
        ),
    )
}

#show heading.where(level: 4): h => {
    block(
        // above: 2em,
        // below: 4pt,
        text(
            font: aptos-font,
            style: "normal",
            weight: "bold",
            size: 1.2em,
            h.body,
        ),
    )
}

#let list-spacing(spacing, body) = [
    #show list: set list(spacing: spacing)
    #body
]


#let enum-spacing(spacing, body) = [
    #show enum: set enum(spacing: spacing)
    #body
]

// ----------

= Einleitungsartikel des ZGB

=== Anwendung des Rechts (Art.1 ZGB)

1. Das Gesetz findet auf alle Rechtsfragen Anwendung, für die es nach
    Wortlaut oder Auslegung eine Bestimmung enthält.

2. Kann dem Gesetz keine Vorschrift entnommen werden, so soll das
    Gericht nach Gewohnheitsrecht und, wo auch ein solches fehlt, nach
    der Regel entscheiden, die es als Gesetzgeber aufstellen würde.

3. Es folgt dabei bewährter Lehre und Überlieferung.


=== Inhalt der Rechtsverhältnisse (Art. 2 ZGB)
_Treu und Glauben_

1. *Jedermann hat in der Ausübung seiner Rechte und in der Erfüllung
    seiner Pflichten nach Treu und Glauben zu handeln.*

2. *Der offenbare Missbrauch eines Rechtes findet keinen Rechtsschutz
    (vgl. Art. 336 OR).* (Rechtsmissbrauchsverbot)

    - Der Grundsatz von Treu und Glauben gebietet ein *loyales und vertrauenswürdiges Verhalten im Rechtsverkehr*. Der Grundsatz von Treu und Glauben beinhaltet einerseits den #underline[Vertrauensschutz], andererseits das #underline[Verbot des widersprüchlichen Verhaltens] sowie das #underline[Verbot des Rechtsmissbrauchs].

    - Vertrauensschutz: Wer ein berechtigtes Vertrauen in die Redlichkeit des Gegenübers gesetzt hat, soll nicht enttäuscht werden.

_Beispiele für Handeln gegen Treu und Glauben_:
- Ein Hauseigentümer lehnt alle vom Makler vermittelten Interessenten als ungeeignet ab. Nach der Beendigung des Maklerverhältnisses setzt sich der Eigentümer dennoch mit einem vom Makler vermittelten Interessenten in Verbindung ab, um den Abschluss zu tätigen.

- Ein Aktionär, der einem Beschluss an der GV bereits zugestimmt hat, verhält sich treuwidrig, wenn er denselben im Nachhinein anfechtet.


- Es handelt sich beim Begriff «*Treu und Glauben*» um einen
    *unbestimmten Rechtsbegriff*. Begriffe in diesem Zusammenhang sind
    anständig, redlich, aufrichtig, zuverlässig, rücksichtsvoll usw.
    Dieses Verhalten wird auch vom Gegenüber erwartet.

- *Rechtsmissbrauchsverbot:* Ein formelles Beharren auf einem Recht,
    das offensichtlich missbräuchlich erscheint, wird vom Richter nicht
    geschützt. Erst ein krass stossendes Verhalten (Schadenfreude,
    Schikane oder Rache) ist jedoch rechtsmissbräuchlich.
