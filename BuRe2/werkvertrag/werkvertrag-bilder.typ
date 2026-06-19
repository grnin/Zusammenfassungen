// /*
#import "../../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content
#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "BuRe2",
    fach-long: "Werkvertrag und andere",
    semester: "FS26",
    language: "de",
    font-size: 10pt,
    tableofcontents: (enabled: false, depth: 3, columns: 2),
    // display-title-header: false,
)
// */


#show heading.where(level: 3): h => {
    block(
        above: 2em,
        // below: 0.2em,
        text(
            font: aptos-font,
            style: "normal",
            weight: "bold",
            // size: 1.4em,
            fill: colors.bg-dark-blue,
            h.body,
        ),
    )
}


// #let notiz(content) = text(
//     fill: rgb("#7e005c"),
//     content,
// )
#let notiz(body) = [
    #block(
        stroke: (
            thickness: 1pt,
            paint: rgb("#7e005c"),
        ),
        inset: 0.8em,
        body,
    )
]


// #set page("a4", flipped: false)

= Werkvertrag
#image("assets/image.png")
#notiz[
    _Erfolg geschuldet_ :     Wie ist nicht relevant.
    Dagegen im Arbeitsvertrag geht es um die sorgfältige Arbeit.
    // In Prüfung Verträge unterscheiden können (Werkvertrag, Auftrag).
]
// #image("assets/image-1.png")
#image("assets/image-19.png")
#image("assets/image-2.png")
#image("assets/image-3.png")
#image("assets/image-4.png")
#image("assets/image-5.png")
#image("assets/image-6.png")
#image("assets/image-7.png")
#image("assets/image-8.png")
#image("assets/image-9.png")
#image("assets/image-10.png")
#image("assets/image-11.png")
#image("assets/image-12.png")
#pagebreak()
= Auftrag
#image("assets/image-13.png")
#image("assets/image-14.png")
#image("assets/image-15.png")

#image("assets/image-16.png")
Schneider,Anwalt.. erhält Auftrag, wenn er nicht antwortet hat er Auftrag angenommen und muss sonst absagen.
Er muss reagieren!
\
=== Artikel 97 : Schlecht und Nichterfüllung.
#notiz[
    Bei Auftragsrecht kein besondere Bestimmung bei Vertragsverletzung (Fehler von treuhänder steuererklärung, arzt termin verpasst...).
    Da keine besondere Bestimmung gilt Artikel 87

    Anwalt darf Fristen nicht verpassen, Anwalt kann auch sagen im voraus, wenn er etwas nicht machen kann
]
#image("assets/image-17.png")

#notiz[
    _Treuepflicht_ gehört auch zur sorgfaltspflicht rein.
    Wenn Pflichten nicht erfüllt: Haftungsthema, z.B. Schadenersatz oder Genuugtung (Verletzung selisch),
    Geheimhaltung (Bankgeheimnis, Arzt) bis zu Gefängnisstrafe

    _Rechenschaft ablegen_ = auch Datenschutz: kann arzt nach Unterlagen über sich fragen
]
*Art. 404 OR*\

1. Der Auftrag kann von jedem Teile jederzeit widerrufen oder gekündigt werden.
2. Erfolgt dies jedoch zur Unzeit, so ist der zurücktretende Teil zum Ersatze des dem anderen verursachten Schadens verpflichtet.
- Zwingendes Kündigungsrecht
- Eine Vertragsauflösung zur Unzeit liegt gemäss bundesgerichtlicher Rechtsprechung vor, wenn der Zeitpunkt der Kündigung besonders ungünstig ist und für den Vertragspartner besondere Nachteile mit sich bringt.

#notiz[bei allem was unter Auftragsrecht fällt, ist es zwingendes Recht, deshalb keine Kündigungsfrist möglich.]
