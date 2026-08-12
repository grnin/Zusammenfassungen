// /*
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content
#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "BuRe2",
    fach-long: "ZGB Übungen",
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

#let notiz(content) = text(
    // text: rgb("#da05a1"),
    fill: rgb("#750056"),
    [

        #content
        \
    ],
)
#let or-block(body) = [
    #block(
        stroke: (
            thickness: 1pt,
            paint: colors.dunkelblau,
        ),
        inset: 1em,
        body,
    )
]


=== Welcher Einleitungsartikel des ZGB ist in den nachstehenden Sachverhalten relevant:

Roman kauft auf dem Parkplatz einer Raststätte von einer Privatperson drei Stangen Zigaretten zum halben Preis.
\ #notiz[
    Verkauf sowieso nicht erlaubt, Rechtsmissbrauchsverbot\
    ZGB 2 oder 3 Treu und Glaube oder Guter Glauben > richtig wäre eher Guter Glauben
]\

Roman wurde zu unrecht fristlos entlassen. Der Richter setzt nun eine Entschädigung zwischen einem und sechs Monatslöhnen fest.
\ #notiz[
    Gerichtliches Ermessen (Art. 4 ZGB)
]\

Peter kündigt seiner Mieterin formal korrekt, nur um sie zu ärgern, da er gar nicht beabsichtigt, die Wohnung selbst zu nutzen oder weiterzuvermieten.
\ #notiz[
    bösartiger Glauben\
    Bösgläubig ist, wer weiss, dass etwas Unrechtes vorliegt ~~(Art. 64 OR).	(vgl. Art. 24 Abs. 1 Ziff. 4 OR).~~
    Art. 2 Absatz 2 Guter Glauben: bösartig, nicht redlich
]\

Herr Müller verkauft seinem Nachbarn ein Stück Land. Im Kaufvertrag wird der Grenzverlauf ungenau eingezeichnet. Müller weiss, dass der Nachbar die Grenze missverstanden hat, schweigt aber bewusst.
\ #notiz[
    Bösgläubig ist, wer weiss, dass etwas Unrechtes vorliegt\
    Art 2 (Absatz nicht nötig)
]\

Maria behauptet, sie habe ihrem Freund Jonas 500 Franken geliehen. Jonas bestreitet dies.
\ #notiz[
    Beweisregel, Art 8
]\

Tom kauft in einem Second-Hand-Laden eine wertvolle Uhr. Der Preis ist zwar günstig, aber nicht völlig auffällig. Später stellt sich heraus, dass die Uhr gestohlen war.
\ #notiz[
    guter Glauben\
    Art. 2 \
    Hinweis: er empfiehlt immer bei second hand dokumente anfordern um zu wissen, dass es nicht gestohlen wurde.
]\

Eine Konsumentin kauft einen neuen Laptop. Nach zwei Monaten funktioniert er plötzlich nicht mehr.  Die Verkäuferin behauptet: „Der Laptop war bei der Übergabe in Ordnung, Sie müssen ihn unsachgemäss behandelt haben.
\ #notiz[
    Beweisregel 8\
    nicht Beweislastumkehr, ist keine Umkehr, sondern es ist Gewährleistung.
]\

Ein Schreiner verpflichtet sich vertraglich, für die Kundin Sophie bis zum 1. Mai einen Esstisch zu liefern.  Der Tisch wird nicht geliefert. Sophie verlangt Schadenersatz für die Kosten, die ihr durch die Miete eines Ersatzmöbels entstanden sind. Der Schreiner sagt: „Ich konnte den Tisch wegen einer plötzlichen Holzknappheit nicht rechtzeitig fertigstellen, daran bin ich nicht schuld.“
\ #notiz[
    Beweisregel\
    optional/allenfalls Beweislastumkehr
]\
