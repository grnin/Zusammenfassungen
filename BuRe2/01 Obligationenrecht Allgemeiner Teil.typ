// Vorlesungsfolien als Typst, Notizen in eigener Typst Box
// pdf hat 25 im name, schauen ob es aktuell ist

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

#notiz([
    Themen:
    @obligation
    @vertragsfreiheit
    @vertragsgueltigkeit
])

// Es würde genügen einfach die Folien zu haben an der Prüfung, aber die sind nicht "schön" formatiert und einige meiner Notizen habe ich als Kommentar, werden also nicht automatisch ausgedruckt.
// Ziel von Zusammenfassung: Inhalt aus Folien ist vorhanden und einfach auffindbar + eigene Notizen eher klein daneben und gut erkennbar als eigene Notizen
// Prüfung ist multiple cohoice
// wichtigste, prüfungsrelevante themen separat? Oder einfach Lesezeichen machen
//
// Ideen:
// Mindmap/concept map? Vielleicht mit den titeln / verschiedenen Arten von ..., Begriffe
// aufteilen links und rechts, links original und rechts meine Notizen
// TODOS:
// Titel level 3 ohne Zahl, mit fetter schrift, level 4 auch erstellen

= Entstehung der Obligation <obligation>
#grid(
    [
        Wie entsteht eine Obligation?
        \
        #link_box[*Vertrag* (Art. 1 - 40 ff. OR)]
        #link_box[*unerlaubte Handlungen* (Art. 41-61 OR)]
        #link_box[ungerechtfertigte Bereicherung (Art. 62-67 OR)]
        #link_box[andere Rechtsgründe (unten)]

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

= Vertrag
== [Grundsatz]{.underline} der Vertragsfreiheit <vertragsfreiheit>

Verschiedene Aspekte der Vertragsfreiheit:

- Abschlussfreiheit
- Partnerwahlfreiheit
- Inhaltsfreiheit
- Aufhebungsfreiheit
- Formfreiheit

Ob ein Vertrag aber tatsächlich gültig ist, hängt von verschiedenen Voraussetzungen ab.

== Ist Vertrag gültig?
==== Voraussetzungen der Vertragsgültigkeit <vertragsgueltigkeit>

// TODO: wichtig, hervorheben, grössere  Abstände oder so!!
//
- (Beschränkte) Handlungsfähigkeit der Parteien
- Konsens beim Vertragsabschluss
- Formgültigkeit
- Kein Inhaltsmangel: nicht unmöglich, nicht rechtswidrig (z.B. Verstoss der AGB gegen UWG 8), nicht unsittlich #notiz[unmöglich: Verträge nicht erfüllt worden bei Corona, weil nachträglich unmöglich] #notiz[z.B. einem Stern einen Namen geben geht in de Schweiz nicht, Mond kaufen.
        so ein Vertrag ist nichtig = wie wenn nie abgeschlossen. unsichtlich : unanständig]
- Keine Übervorteilung (führt zur Anfechtbarkeit)
- Kein Willensmangel (führt zur Anfechtbarkeit)
- Gültige Stellvertretung

== Gesetzliche Bestimmungen

#pruefung[unterscheiden und erkennen, was ist was]
#grid(
    [
        - Dispositive Gesetzesbestimmungen:
            - Sofern der Vertrag Aspekte nicht regelt, kommen die dispositiven Gesetzesbestimmungen zum Zuge. Die meisten Bestimmungen im OR AT und im OR BT sind dispositiv und finden bloss Anwendung, wenn die Parteien nichts anderes vereinbart haben.

            - Zwingende Gesetzesbestimmungen:
                - Die zwingenden Gesetzesnormen gehen den vertraglichen Bestimmungen immer vor.
                    Beispiele: OR 100 I, OR 199, OR 210 IV, OR 404, UWG 8 -- sodann zahlreiche Normen des Miet- und Arbeitsrechts.

    ],
    [
        meiste Verträge privat: dispositiv
        kann Gewährleistung bei dispositivem Recht wegbedingen, keine Garantie=Gewährleistung mehr
        kann nur noch anfechten
        \
        \
        \
        \
        \

        öffentliches Recht, Arbeitsrecht : nicht zugunsten des Arbeitsnehmer abgeändert werden

        OR 404 == bei Täuschung

    ],
)

== Theorie: OR AT & BT
#image("./assets/image-5.png")


== Formvorschriften

=== Gründe für Formvorschriften

1. Beweissicherung
2. Schutz vor übereiltem Vertragsschluss
3. Rechtssicherheit
4. Schutz der schwächeren Partei

=== *Vertragsformen*
#pruefung[alle Formverschriften werden angeschaut!]

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

== Vertragstypen
#pruefung[Vertragstypen nur nice to know, einfach kennen, Thema IT Vertrag]
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 101.
#image("./diagrams/vertragstypen.svg")

== Rechtssubjekte

#image("./diagrams/rechtssubjekte.svg")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 268.



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

==== Vertragsschluss
#pruefung[weiss nicht ob wichtig]
#image("./assets/vertragsschlus.png")\
#image("./assets/vertragsschluss-2.png")


== Antrag
#pruefung[Begrifflichkeiten sollen wir anschauen]

- Der Antrag ist ein einseitiges Rechtsgeschäft, der auf den Abschluss eines Vertrages gerichtet ist.

- Begrifflichkeiten:
    - Empfangsbedürftigkeit
    - Unterscheidung verbindlicher -- und unverbindlicher Antrag (vgl. Art.
        7 OR)
    - Antrag unter Anwesenden resp. Abwesenden (vgl. Art. 4 und 5 OR)
    - Widerruf (Art. 9 OR)



== Annahme

- Die Annahme ist ein einseitiges Rechtsgeschäft.

- Begrifflichkeiten:

    - Einverständnis in den wesentlichen Punkten («essentialia negotii»)
    - Empfangsbedürftigkeit
    - Stillschweigende Annahme (Art. 6 OR)
    - Widerruf (Art. 9 OR)
    - Widerruf beim Haustürgeschäft (Art. 40a ff. OR)


= Allgemeine Geschäftsbedingungen (AGB's)
#pruefung[
    wann ist AGB verbindlich
    - unkklarheitklausel
    - ungewöhnliche klausel
]

#image("./assets/image-10.png")


= Ort der **Erfüllung**


== Erfüllung der Obligation

> **Erfüllen einer Obligation heisst:**

#color_box[richtige (mängelfreie) und rechtzeitige Erfüllung]

**Wichtige Einzelpunkte der Erfüllung**
- Person des Erfüllenden (vgl. OR 68, 321, 364 II, 398 III
- Gegenstand (vgl. OR 2 I)
- *Ort der Erfüllung* (vgl. OR 74, 189 I)
- Zeit der Erfüllung (vgl. OR 75, 213 I, 257c, 318, 323 I, 372 I

*Die meisten Erfüllungsregeln des Allgemeinen Teils des OR gelten nur:*\
- wenn die Parteien keine abweichenden Vereinbarungen getroffen haben

- wenn die Vorschriften des Besonderen Teils des OR keine abweichenden
    Regelungen enthalten (Grundsatz: spezielles Recht vor allgemeinem
    Recht)



== Ort der Erfüllung
"Modalitäten der Leistungserbringung"
#pruefung[die 4 Punkte: Geldschulden Bringschulden Wohnsitz des Gläubigers Speziessachen Gattungssachen]

#image("./assets/image-11.png")

#notiz[*Holschulden*:
    in Praxis sind holschulden meistens
    bei privaten Fällen. z.B. occasion etwas
    kaufen, wer muss es holen/bringen.

    *Dienstleistungen*
    bei Dienstleistungen ist häufig schon
    definiert, z.B. man geht zum Anwalt
    und bei IT wird es dann meistens schon im Vertrag geregelt
]

#notiz[
    aus Internet:
    // https://law.ch/lawinfo/vertrag-vertragsrecht/erfuellung-der-obligation/erfuellungsort/

    *Unterscheidung vom Erfüllungsort OR74*\
    Holschuld
    - Gläubiger muss Leistung selber abholen
    Bringschuld
    - Leistung ist am Ort des Gläubigers zu erbringen
    - Schuldner muss das Geld am Wohnsitz / Sitz des Gläubigers übergeben
    Schickschuld
    - Schuldner muss Ware dem Gläubiger zusenden

    Wo nichts anderes bestimmt ist, gelten folgende Grundsätze:

    1.
        Geldschulden sind an dem Orte zu zahlen, wo der Gläubiger zur Zeit der Erfüllung seinen Wohnsitz hat;
    2.
        wird eine bestimmte Sache geschuldet, so ist diese da zu übergeben, wo sie sich zur Zeit des Vertragsabschlusses befand;
    3.
        andere Verbindlichkeiten sind an dem Orte zu erfüllen, wo der Schuldner zur Zeit ihrer Entstehung seinen Wohnsitz hatte.

]



== Erfüllungsstörungen (Nicht-/Schlechterfüllung)

**Übersicht:**
#image("./assets/image-12.png")
#notiz[Schuldnerverzug ?? oder Gläubigerverzug? Beispiel TODO: > lieferant hat Problem, weil käufer nicht anwesend ist Zuhause an vereinbartem Ort.]
#notiz[Unterscheiden: Nichterfüllung und Schlechterfüllung beim Kaufvertrag]


**Merke:** Für den Schuldner besteht Erfüllungszwang. Art. 98 OR gibt
dem Gläubiger die Möglichkeit, sich vom Richter zur ersatzweisen
Vornahme der ausgebliebenen Leistung ermächtigen zu lassen. Der
Gläubiger kann natürlich auch auf Erfüllung klagen.

=== Abgrenzung Nicht-/Schlechterfüllung beim Kauf
#pruefung[ganz prüfungsrelevant!]

TODO: Schuldnververzug = Nichterfüllung??

#image("./assets/image-13.png")

=== Schlechterfüllung anhand des Kaufvertrages

1. Ist der Vertrag gültig?
2. Wurde der Vertrag (richtig) erfüllt? #notiz[z.B.nicht dreckig oder kaputt]
3. Sind Gewährleistungsrechte / Schadenersatzansprüche noch möglich?
4. (Beim Kaufvertrag zusätzlich noch:) Ist der Vertrag anfechtbar?

// TODO diagramm:
#image("./assets/image-14.png")


=== Schuldnerverzug anhand des Kaufvertrages
#image("./assets/image-15.png")

=== Erfüllungszeit
// TODO ist zu unscharf
#image("./assets/image-16.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 59.

=== Zusammenfassung zum Verzug
// TODO auch verbessern?
#image("./assets/image-17.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 68.

= Übersicht Inhalts-/Willensmängel

// TODO:
#image("./assets/image-18.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 27.

== Wesentlicher Irrtum
Grundlagenirrtum oder Erklärungsirrtum
#image("./assets/image-19.png")
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 30.

= Verjährung
#notiz[
    ab OR 125, wichtiges in 127

    (or 128)
    allgemein 10 Jahre
    speziell bei 5 Jahren
    - Hotel auch , die 2 speziellen begriffe nicht
    - 20 jahre personenschaden (tod, körperverletzung) in zusammenhang mit vertragsverletzung:
    absolute verjährungsfrist ovn .. jahren
]

#image("./assets/image-20.png")



*Merke*: Verjährung wird nicht von Amtes wegen berücksichtigt, sondern
*nur auf Einrede* #notiz[Käufer muss sagen, dass es verjährt ist. Verkäufer macht Verjährung aktiv geltend.

    käufer kann verjährung unterbrechen OR 135 / stoppen]

#pruefung[verjährungsfristen kennen (wann, welche), aber nicht berechnen können.]

= Beispiele

= Erlöschen der Obligation

#image("./assets/image-22.png")

**Erlöschen heisst:**
- Schuldner hat Leistung erbracht oder muss nicht mehr erfüllen
- Gläubiger kann Leistung nicht mehr verlangen oder durchsetzen
