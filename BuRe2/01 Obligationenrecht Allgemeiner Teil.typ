// Vorlesungsfolien als Typst, Notizen in eigener Typst Box
// pdf hat 25 im name, schauen ob es aktuell ist


// /* test
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content
#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "BuRe2",
    fach-long: "Business und Recht 2 Vorlesung",
    semester: "FS24",
    language: "en",
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
        // below: 0.2em,
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
        above: 2em,
        // below: 0.2em,
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

// #pagebreak();
= Entstehung der Obligation <obligation>

#notiz([
    Themen:
    @obligation
    @vertragsfreiheit
    @vertragsgueltigkeit
])

#grid(
    columns: (auto, auto),
    [
        Wie entsteht eine Obligation?
        \
        #link_box[*Vertrag* (Art. 1 - 40 ff. OR)]
        #link_box[*unerlaubte Handlungen* (Art. 41-61 OR)]
        #link_box[ungerechtfertigte Bereicherung (Art. 62-67 OR)]
        #link_box[andere Rechtsgründe (unten)]
    ],
    [
        === Andere Rechtsgründe sind:
        - Geschäftsführung ohne Auftrag (Art. 419 ff. OR)
        - *Culpa in contrahendo*
        - Eigentumsfreiheitsklage (Art. 641 ZGB)
        - Besitzesrechtsklage (Art. 934 ff. ZGB)
        - *Persönlichkeitsverletzung* (Art. 28 ff. ZGB)
        - Verwandtenunterstützungspflicht (Art. 328 f. ZGB)
    ],
    // [Notizen hier:],
)

// #v(2em);
#pagebreak();
= Vertrag
#v(-1em)
=== #underline[Grundsatz] der Vertragsfreiheit <vertragsfreiheit>

Verschiedene Aspekte der Vertragsfreiheit:

- Abschlussfreiheit
- Partnerwahlfreiheit
- Inhaltsfreiheit
- Aufhebungsfreiheit
- Formfreiheit

Ob ein Vertrag aber tatsächlich gültig ist, hängt von verschiedenen Voraussetzungen ab.

== Ist Vertrag gültig?
==== Voraussetzungen der Vertragsgültigkeit <vertragsgueltigkeit>

#list-spacing(
    1.2em,
    [

        - (Beschränkte) Handlungsfähigkeit der Parteien
        - Konsens beim Vertragsabschluss
        - Formgültigkeit
        - Kein Inhaltsmangel: nicht unmöglich, nicht rechtswidrig (z.B. Verstoss der AGB gegen UWG 8), nicht unsittlich #notiz[unmöglich: Verträge nicht erfüllt worden bei Corona, weil nachträglich unmöglich] #notiz[z.B. einem Stern einen Namen geben geht in de Schweiz nicht, Mond kaufen.
                so ein Vertrag ist nichtig = wie wenn nie abgeschlossen. unsichtlich : unanständig]
        - Keine Übervorteilung (führt zur Anfechtbarkeit)
        - Kein Willensmangel (führt zur Anfechtbarkeit)
        - Gültige Stellvertretung

    ],
)
== Gesetzliche Bestimmungen

#pruefung[unterscheiden und erkennen, was ist was]
#grid(
    // TODO sticky
    columns: (60%, auto),
    [
        === Dispositive Gesetzesbestimmungen
        Sofern der Vertrag Aspekte nicht regelt, kommen die dispositiven Gesetzesbestimmungen zum Zuge. Die meisten Bestimmungen im OR AT und im OR BT sind dispositiv und finden bloss Anwendung, wenn die Parteien nichts anderes vereinbart haben. \

        === Zwingende Gesetzesbestimmungen
        - Die zwingenden Gesetzesnormen gehen den vertraglichen Bestimmungen immer vor.
        \
        Beispiele: OR 100 I, OR 199, OR 210 IV, OR 404, UWG 8 -- sodann zahlreiche Normen des Miet- und Arbeitsrechts.

    ],
    [
        ===== Notizen:
        meiste private Verträge: dispositiv\
        kann Gewährleistung bei dispositivem Recht wegbedingen, keine Garantie=Gewährleistung mehr
        kann nur noch anfechten
        \

        \
        \
        \

        öffentliches Recht, Arbeitsrecht : nicht zugunsten des Arbeitsnehmer abgeändert werden

        OR 404 == bei Täuschung

    ],
)

== Theorie: OR AT & BT
#image("./assets/image-5.png", height: 8cm)

#v(3em)
== Formvorschriften
// #v(-2em)
=== Gründe für Formvorschriften

1. Beweissicherung
2. Schutz vor übereiltem Vertragsschluss
3. Rechtssicherheit
4. Schutz der schwächeren Partei

=== *Vertragsformen*
#pruefung[alle Formverschriften werden angeschaut!]

#grid(
    [
        ==== Formfreiheit (Art. 11 OR)
        Das Obligationenrecht geht von dem Grundsatz der
        Formfreiheit aus. Darunter versteht man die Freiheit,
        Verträge in freier Form abzuschliessen, abzuändern
        oder aufzuheben. Eine besondere Form ist nur
        notwendig, wenn es das Gesetz oder Abrede eine
        solche vorschreibt.

        - Einzelarbeitsvertrag
        - Mietvertrag
        - Kaufvertrag
        - Darlehen

        ==== Einfache Schriftlichkeit (Art. 13 – 15 OR)
        Ist die einfache Schriftlichkeit vorgesehen, muss der
        Vertrag die eigenhändige Unterschrift oder eine
        qualifizierte elektronische Signatur aller beteiligten
        Personen aufweisen.

        - Schenkungsversprechen
        - Lehrvertrag
        - Versicherungsvertrag
        - Konkurrenzverbot im Arbeitsvertrag

    ],
    [

        ==== Qualifizierte Schriftlichkeit
        Die qualifizierte Schriftlichkeit verlangt nicht nur die
        Unterschrift der Verpflichteten, sondern die
        handschriftliche Angabe gewisser Elemente in der
        Urkunde.

        - Bürgschaft
        - Testament

        ==== Öffentliche Beurkundung
        Bei der öffentlichen Beurkundung erfolgt der
        Vertragsschluss unter Mitwirkung einer
        Urkundsperson (z.B. Notar). Die Urkundsperson
        bestätigt die Richtigkeit des Inhaltes der Urkunde.

        - Grundstückkaufvertrag
        - Vorvertrag über ein Grundstück mit Kaufpreis
        - Bürgschaft natürlicher Personen, wenn die Haftungssumme über Fr. 2'000.– liegt
        - Ehe- und Erbvertrag
    ],
)

\

== Vertragstypen
#pruefung[Vertragstypen nur nice to know, einfach kennen, Thema IT Vertrag]

// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 101.
// #image("./diagrams/vertragstypen.svg", height: 10cm)
#image("./diagrams/vertragstypen.png", height: 10cm)

== Rechtssubjekte
\

// #image("./diagrams/rechtssubjekte.svg", height: 6cm)
#image("./diagrams/rechtssubjekte.png", height: 6cm)
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 268.



#block(
    sticky: true,
    [

        ==== Stellvertretung mit und ohne Ermächtigung
        #pruefung[Stellvertretung ganz kurz, wenn Voraussetzungen gegeben dann Dritter..
            OR 38,39]

        #grid(
            [

                #image("./assets/image-7.png")
            ],
            [
                #image("./assets/image-9.png")
                $->$ vgl. Art. *38-39 OR* oder auch 419 ff. OR

                Arten von Vollmachten: Spezialvollmacht, Generalvollmacht und Gattungsvollmacht, Einzel- und Kollektivvollmacht \
                Sog. Unechte Stellvertretung: Handeln für fremde Rechnung, aber in eigenem Namen, siehe Art. 32 Abs. 3 OR
            ],
        )
    ],
)

#block(
    sticky: true,
    [

        ==== Vertragsschluss
        #pruefung[weiss nicht ob wichtig]
        #image("./assets/vertragsschlus.png", height: 7cm)\
        #image("./assets/vertragsschluss-2.png", height: 7cm)
    ],
)

#grid(
    [
        == Antrag
        #pruefung[Begrifflichkeiten sollen wir anschauen]

        - Der Antrag ist ein einseitiges Rechtsgeschäft, der auf den Abschluss eines Vertrages gerichtet ist.

        - Begrifflichkeiten:
            - Empfangsbedürftigkeit
            - Unterscheidung verbindlicher -- und unverbindlicher Antrag (vgl. Art.
                7 OR)
            - Antrag unter Anwesenden resp. Abwesenden (vgl. Art. 4 und 5 OR)
            - Widerruf (Art. 9 OR)


    ],
    [

        == Annahme

        - Die Annahme ist ein einseitiges Rechtsgeschäft.

        - Begrifflichkeiten:

            - Einverständnis in den wesentlichen Punkten («essentialia negotii»)
            - Empfangsbedürftigkeit
            - Stillschweigende Annahme (Art. 6 OR)
            - Widerruf (Art. 9 OR)
            - Widerruf beim Haustürgeschäft (Art. 40a ff. OR)


    ],
)


\
== Allgemeine Geschäftsbedingungen (AGB's)
#pruefung[
    wann ist AGB verbindlich
    - unkklarheitklausel
    - ungewöhnliche klausel
]

#image("./assets/image-10.png", height: 7cm)


== Erfüllung der Obligation
#notiz[Ort der Erfüllung:]

=== Erfüllen einer Obligation heisst
#color_box[richtige (mängelfreie) und rechtzeitige Erfüllung]

=== Wichtige Einzelpunkte der Erfüllung
#list-spacing(
    1.2em,
    [
        - Person des Erfüllenden (vgl. OR 68, 321, 364 II, 398 III
        - Gegenstand (vgl. OR 2 I)
        - *Ort der Erfüllung* (vgl. OR 74, 189 I)
        - Zeit der Erfüllung (vgl. OR 75, 213 I, 257c, 318, 323 I, 372 I
    ],
)

=== Wann Allgemeiner Teil des OR gilt
/ Die meisten Erfüllungsregeln des Allgemeinen Teils des OR gelten nur: \
    #sym.arrow.r wenn die Parteien keine abweichenden Vereinbarungen getroffen haben \
    #sym.arrow.r  wenn die Vorschriften des Besonderen Teils des OR keine abweichenden
    Regelungen enthalten (Grundsatz: spezielles Recht vor allgemeinem
    Recht)


#block(
    sticky: true,
    [
        \
        == Ort der Erfüllung
        \
        "Modalitäten der Leistungserbringung" \
        #pruefung[die 4 Punkte: Geldschulden Bringschulden Wohnsitz des Gläubigers Speziessachen Gattungssachen]

        #image("./assets/image-11.png", height: 8cm)




        #notiz[*Holschulden*:]
        in Praxis sind holschulden meistens
        bei privaten Fällen. z.B. occasion etwas
        kaufen, wer muss es holen/bringen.

        #notiz[*Dienstleistungen*]
        bei Dienstleistungen ist häufig schon
        definiert, z.B. man geht zum Anwalt
        und bei IT wird es dann meistens schon im Vertrag geregelt




        #notiz[
            // aus Internet:
            // https://law.ch/lawinfo/vertrag-vertragsrecht/erfuellung-der-obligation/erfuellungsort/

            _Gläubiger ist der, der die Leistung erhält. Gläubiger hat Anspruch auf Leistung und Schuldner muss vereinbarte Leistung erbringen_
            \
            *Unterscheidung vom Erfüllungsort OR74*] \
        Holschuld
        - Gläubiger muss Leistung selber abholen

        Bringschuld
        - Leistung ist am Ort des Gläubigers zu erbringen
        - Schuldner muss das Geld am Wohnsitz / Sitz des Gläubigers übergeben
        Schickschuld
        - Schuldner muss Ware dem Gläubiger zusenden

        Wo nichts anderes bestimmt ist, gelten folgende Grundsätze (siehe Grafik)
        1.
            Geldschulden sind an dem Orte zu zahlen, wo der Gläubiger zur Zeit der Erfüllung seinen Wohnsitz hat;
        2.
            wird eine bestimmte Sache geschuldet, so ist diese da zu übergeben, wo sie sich zur Zeit des Vertragsabschlusses befand;
        3.
            andere Verbindlichkeiten sind an dem Orte zu erfüllen, wo der Schuldner zur Zeit ihrer Entstehung seinen Wohnsitz hatte.
    ],
);

#pagebreak()

== Erfüllungsstörungen (Nicht-/Schlechterfüllung)
// #v(-2em)
=== Übersicht
// #notiz[sind das alles Formen von Nichterfüllung? also Verzug (Gläubigerverzug), Unmöglichkeit und Schlechterfüllung sind unterkategorien von Nichterfüllung??]
// #notiz[Schuldnerverzug ?? oder Gläubigerverzug?
//     Beispiel TODO: > lieferant hat Problem, weil käufer nicht anwesend ist Zuhause an vereinbartem Ort.]


#image("./assets/image-12.png", height: 5cm)

*Merke:* Für den Schuldner besteht Erfüllungszwang. Art. 98 OR gibt
dem Gläubiger die Möglichkeit, sich vom Richter zur ersatzweisen
Vornahme der ausgebliebenen Leistung ermächtigen zu lassen. Der
Gläubiger kann natürlich auch auf Erfüllung klagen.
\
\
#notiz[Unterscheiden: Nichterfüllung und Schlechterfüllung beim Kaufvertrag]

=== Abgrenzung Nicht-/Schlechterfüllung beim Kauf
#pruefung[ganz prüfungsrelevant!]

// TODO: Schuldnververzug = Nichterfüllung??


#image("./assets/image-13.png", height: 7cm)
Gattungssache = vom Gattungskauf, die Sache gibt es ganz viel Mal\
Speziessache = etwas ganz spezifisches, einzigartiges\

#v(0.5em);
=== Schlechterfüllung anhand des Kaufvertrages
#enum-spacing(
    1em,
    [
        1. Ist der Vertrag gültig?
        2. Wurde der Vertrag (richtig) erfüllt? #notiz[z.B.nicht dreckig oder kaputt]
        3. Sind Gewährleistungsrechte / Schadenersatzansprüche noch möglich?
        4. (Beim Kaufvertrag zusätzlich noch:) Ist der Vertrag anfechtbar?

    ],
)

// TODO diagramm:
#image("./assets/image-14.png", height: auto)


=== Schuldnerverzug anhand des Kaufvertrages
#image("./assets/image-15.png", height: 7cm)

=== Erfüllungszeit
// TODO ist zu unscharf
#image("./assets/image-16.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 59.

=== Zusammenfassung zum Verzug
// TODO auch verbessern?
#image("./assets/image-17.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 68.


#pagebreak();
= Übersicht Inhalts-/Willensmängel

// #image("./assets/image-18.png")
// #image("./diagrams/maengel.svg")
#image("./diagrams/maengel.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 27.

=== Wesentlicher Irrtum
Grundlagenirrtum oder Erklärungsirrtum
#image("./assets/image-19.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 30.
#pagebreak();
= Verjährung
#pruefung[verjährungsfristen kennen (wann, welche), aber nicht berechnen können.]
#notiz[Verjährung zusammengefasst]

=== Zusammenfassung Verjährungsfristen
// / OR 127: 10 Jahre
//     Allgemeine Verjährungsfrist für Forderungen, soweit das Gesetz nichts anderes bestimmt.
// / OR 128: 5 Jahre
//     Für periodische Leistungen (z. B. Mietzinsen, Zinsen) sowie Forderungen aus Kleinwarenverkauf, Handwerksarbeit usw.

// / Wo es steht: Grundsatz in OR 127, wichtige Ausnahmen in OR 128 (siehe unten in Grafik)
/ Allgemeine Verjährung: 10 Jahre _OR127_
/ Spezielle Verjährung: 5 Jahre _OR 128_ \
    - Hotel (Hotel und Gastwirtschaftsfoderungen)
    // - die 2 speziellen begriffe nicht (???)
    - Miet,- Pacht, Kapitalzinsforderungen + periodische Leistungen + Forderungen für Handwerksarbeit + Kleinverkauf von Waren + ärztliche, anwaltliche, handwerkliche Leistungen
/ Personenschaden: 20 Jahre (tod, körperverletzung)
    - relative Frist 3 Jahre ab Kenntnis von Schaden und Schädiger
    - absolute Frist 20 Jahre ab schädigendem Ereignis
/ in zusammenhang mit vertragsverletzung: (Schadenersatzansprüche aus Vertragsverletzung) grundsätzlich 10 Jahre, bei Persondenschäden aus Vertragsverletzung aber die 20 Jahre

/ Kaufvertrag: Gewährleistungsansprüche wegen Mängeln _OR 210_
    - Bewegliche Sachen: _2 Jahre_
    - Unbewegliche Sachen (Grundstücke/Bauten): _5 Jahre_
    - _Ausser bei Kulturgütern_
/ Werkvertrag: Gewährleistungsansprüche _OR 371_
    - Bewegliche Werke: _2 Jahre_
    - Bauwerke: _5 Jahre_
/ Beachten: Die kurzen Gewährleistungsfristen gelten nicht bei absichtlicher Täuschung durch den Verkäufer oder Unternehmer.

#image("./assets/image-20.png")
*Merke*: Verjährung wird nicht von Amtes wegen berücksichtigt, sondern
*nur auf Einrede* \
#notiz[Käufer muss sagen, dass es verjährt ist. Verkäufer macht Verjährung aktiv geltend.\
    Käufer kann verjährung unterbrechen OR 135 / stoppen. Es gibt eine *Verjährungseinredeverzichtserklärung*
]

#block(
    sticky: true,
    [
        \
        === Beispiele Verjährungsfristen
        \
        / a): Vertraglicher Schadenersatzanspruch aus OR 97 #sym.arrow.r	10 Jahre, OR 127
        / b): Ausstehende Kaufpreisforderung für Kauf von Kleinwaren #sym.arrow.r 5 Jahre, OR 128
        / c): Ausstehende Mietzinszahlungen #sym.arrow.r 5 Jahre, OR 128
        / d): Susis Gewährleistungsrechte für das gekaufte Elektrogerät #sym.arrow.r 2 Jahre, OR 210
        / e): Susis Gewährleistungsrechte für das erworbene Ferienhaus #sym.arrow.r 5 Jahre, (OR 210 unbewegliche Sachen Kaufvertrag)
        / f): Anita lässt durch Unternehmer Pablo eine Vreanda bauen.
            - Pablos Rechnung von CHF 3'000 #sym.arrow.r 10 Jahre, OR 127
            - Anitas Gewährleistungsrechte #sym.arrow.r 5 Jahre, OR 371

        #notiz[ Gewährleistungsrechte = Rechte bei Mängel von gekaufter Sache oder Werk ]

    ],
)
=== OR Verjährungsfristen
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
#or-block([
    *Art. 97* (von Beispielen) \
    1 Kann die Erfüllung der Verbindlichkeit überhaupt nicht oder nicht gehörig bewirkt werden, so hat der Schuldner für den daraus entstehenden Schaden Ersatz zu leisten, sofern er nicht beweist, dass ihm keinerlei Verschulden zur Last falle.
])

#or-block([
    *Art. 127* \
    Mit Ablauf von _zehn Jahren_ verjähren alle Forderungen, für die das Bundeszivilrecht nicht etwas anderes bestimmt.
])

#or-block(
    [
        *Art. 128*\
        Mit Ablauf von fünf Jahren verjähren die Forderungen:
        1.
            für Miet-, Pacht- und Kapitalzinse sowie für andere periodische Leistungen;
        2.
            aus Lieferung von Lebensmitteln, für Beköstigung und für Wirtsschulden;
        3.
            aus Handwerksarbeit, Kleinverkauf von Waren, ärztlicher Besorgung, Berufsarbeiten von Anwälten, Rechtsagenten, Prokuratoren und Notaren sowie aus dem Arbeitsverhältnis von Arbeitnehmern.

        *Art. 128a* \
        Forderungen auf Schadenersatz oder Genugtuung aus vertragswidriger Körperverletzung oder Tötung eines Menschen verjähren mit Ablauf von _drei Jahren_ vom Tage an gerechnet, an welchem der Geschädigte Kenntnis vom Schaden erlangt hat, jedenfalls aber mit Ablauf von _zwanzig Jahren_, vom Tage an gerechnet, an welchem das schädigende Verhalten erfolgte oder aufhörte.
    ],
)

// #or-block([
//     *Art. 210*
//     1. Die Klagen auf Gewährleistung wegen Mängel der Sache verjähren mit Ablauf von zwei Jahren nach deren Ablieferung an den Käufer, selbst wenn dieser die Mängel erst später entdeckt, es sei denn, dass der Verkäufer eine Haftung auf längere Zeit übernommen hat.
//     2. Die Frist beträgt fünf Jahre, soweit Mängel einer Sache, die bestimmungsgemäss in ein unbewegliches Werk integriert worden ist, die Mangelhaftigkeit des Werkes verursacht haben.
//     3. Für Kulturgüter im Sinne von Artikel 2 Absatz 1 des Kulturgütertransfergesetzes vom 20. Juni 200376 verjährt die Klage ein Jahr, nachdem der Käufer den Mangel entdeckt hat, in jedem Fall jedoch 30 Jahre nach dem Vertragsabschluss.
//     4. Eine Vereinbarung über die Verkürzung der Verjährungsfrist ist ungültig, wenn:

//         a.
//         sie die Verjährungsfrist auf weniger als zwei Jahre, bei gebrauchten Sachen auf weniger als ein Jahr verkürzt;
//         b.
//         die Sache für den persönlichen oder familiären Gebrauch des Käufers bestimmt ist; und
//         c.
//         der Verkäufer im Rahmen seiner beruflichen oder gewerblichen Tätigkeit handelt.

//     5. Die Einreden des Käufers wegen vorhandener Mängel bleiben bestehen, wenn innerhalb der Verjährungsfrist die vorgeschriebene Anzeige an den Verkäufer gemacht worden ist.

//     6. Der Verkäufer kann die Verjährung nicht geltend machen, wenn ihm eine absichtliche Täuschung des Käufers nachgewiesen wird. Dies gilt nicht für die 30-jährige Frist gemäss Absatz 3.
// ])

#pagebreak();
= Erlöschen der Obligation

#grid(
    columns: (auto, auto),
    [
        // #image("./assets/image-22.png", height: 7cm)
        #image("/assets/image-4.png", height: 8cm)
    ],
    [
        \
        Wenn eines dieser Punkte zutrifft, erlöscht die Obligation.
        \
        ==== Erlöschen heisst
        - Schuldner hat Leistung erbracht oder muss nicht mehr erfüllen
        - Gläubiger kann Leistung nicht mehr verlangen oder durchsetzen
    ],
)
