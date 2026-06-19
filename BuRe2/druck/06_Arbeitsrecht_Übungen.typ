// /*
#import "../../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content
#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "BuRe2",
    fach-long: "Arbeitsrecht Übungen",
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

=== Fragen und Fälle
1. Wie kann ein unbefristeter Arbeitsvertrag beendet werden?\
    #notiz[Kündigung des unbefristeten Einzelarbeitsvertrags (Art. 335 ff. OR)
        // #block[
        //     Beendigungsmöglichkeiten beim Einzelarbeitsvertrag
        //     - Kündigung des unbefristeten Einzelarbeitsvertrags (Art. 335 ff. OR)
        //     - Zeitablauf beim befristeten Einzelarbeitsvertrag (Art. 334 OR)
        //     - Aufhebungsvertrag (Art. 115 OR)
        //     - Fristlose Kündigung (Art. 337 ff. OR)
        //     - Tod des Arbeitnehmers (Art. 338 OR)
        //     - Beachte: Nicht der Konkurs des Arbeitsgebers
        // ]
    ]

2.
    Ein leitender Angestellter der Firma Protec AG hat aufgrund des Ausfalls eines Mitarbeiters in seinem
    Team erheblich mehr Arbeit, die auf sein Team entfällt. Da das Team relativ gross ist, kann die anfallende
    Mehrarbeit gut auf die einzelnen Teammitglieder verteilt werden. Allerdings muss auch der Chef selbst
    mehr arbeiten. Kann er für die geleistete Mehrarbeit Überstundenentschädigung geltend machen, auch
    wenn er dazu keine Regelung in seinem Arbeitsvertrag vorfindet?\
    #notiz[
        > Ja, Überstunden durch Freizeit kompensieren 1:1 oder ausgezahlt mit 25% Aufschlag vom Lohn. \
        > aber für Überzeit, sobald es über gesetzliche Höchstarbeitszeit hinausgeht, erhält er nichts. Bei Überzeit: "Leitende Arbeitnehmer sind dem Arbeitsgesetz nach Art. 3 lit. d ArG nicht unterstellt"

        // >  Mitarbeiter kann ausfallen wegen eines von diesen Gründen, dann wird Lohn weiter gezahl: Krankheit, Arztverordnungen, Militär, Zivil- dienst, Arztbesuch, Umzug, Heirat, temporäre Angehörigenpflege. Anspruch auf bezahlte Freizeit je nach Arbeitspensum (Art. 329 Abs. 3 OR) \
        // > bei diesen Gründen muss kein Lohn bezahlt werden: Keine Lohnfortzahlung bei Naturkatastrophen, Flugverbot, Verkehrsprobleme, Pandemie


    ]

3. Welche Arbeitnehmer- und Arbeitgeberpflichten ergeben sich aus dem OR?\
    #notiz[siehe Zusammenfassung]
4.
    Peter Meier arbeitet seit 25 Jahren bei der X. AG als Finanzexperte. Aufgrund eines Burnouts muss er
    sich für 2 Monate in eine Klinik begeben. Als er nach diesem Klinikaufenthalt die Arbeit bei der X. AG
    wieder aufnehmen möchte, teilt ihm sein Vorgesetzter mit, dass sein Ferienanspruch um einen Sechstel
    gekürzt wird. Ist das zulässig? Peter Meier findet das eine Frechheit und droht seinem Arbeitgeber, dass
    er sich an den Kassensturz wenden werde. Daraufhin warnt ihn sein Vorgesetzter vor den Konsequenzen
    eines solchen Vorgehens und weist ihn auf die zivil- und strafrechtliche Geheimnispflicht des
    Arbeitnehmers hin. Was bedeutet die Geheimnispflicht im Arbeitsrecht?
    #notiz[
        \
        Geheimnispflicht gilt nur für "weder offenkundig, noch allgemein zugänglich
        sind, der Arbeitgeber an der Geheimhaltung ein berechtigtes Interesse hat und das
        Geheimnis einen Bezug zum Unternehmen aufweist, das das Geschäftsergebnis be-
        einflusst." > es beeinflusst das Geschäftsergebnis nicht.
        \
        // bei unbefristetem Arbeitsvertrag wird während Ausfall Lohn weiter bezahlt für mindestens 3 Monate.
        // Der Vorgesetzte kann nicht einfach den Ferienanspruch ändern ohne das Arbeitnehmer einverstanden ist, die Forderung ist unzulässig "Unzulässig: Einschränkungen der vertraglich festgelegten Stellung, Eingriffe in das
        // Persönlichkeitsrecht, willkürliche oder schikanöse Weisungen."
        // \
    ]
5. Was hat eine gerechtfertigte fristlose Kündigung für Konsequenzen?
#notiz[
    - Folgen bei gerechtfertigter fristloser Kündigung (Art. 337 OR)\
        1. Liegt der wichtige Grund zur fristlosen Auflösung des Arbeitsverhältnisses im vertragswidrigen Verhalten einer Vertragspartei, so hat diese vollen Schadenersatz zu leisten, unter Berücksichtigung aller aus dem Arbeitsverhältnis entstehenden Forderungen.\
        2. In den andern Fällen bestimmt der Richter die vermögensrechtlichen Folgen der fristlosen Auflösung unter Würdigung aller Umstände nach seinem Ermessen
    - Liegt der Grund der fristlosen Kündigung bei einem Vertragsbruch, somit muss diese Partei den VOLLEN Schadensersatz bezahlen
    - Es gibt keinen Kündigungsschutz "Keine Anwendung findet der Kündigungsschutz bei befristeten Arbeitsverhältnissen, Aufhebungsverträgen und bei fristlosen Entlassungen (zumindest bei gerechtfertigten)."
]
6.
    Maria Meister ist die neue HR-Chefin in der Firma Z. AG. Nach einer längeren Analyse der Personalkosten
    entscheidet sie zusammen mit dem CEO, dass den Mitarbeitern neuerdings bei Krankheit nicht mehr Lohn
    während 4 Monaten ausbezahlt werden soll, sondern dass man nur noch das gesetzlich zulässige Minimum
    bezahlen möchte. Wie können die Arbeitsverträge geändert werden?\
    #notiz[
        // - Es benötigt eine Einigung zwischen Arbeitgeber und Arbeitnehmer bezüglich dem Lohn
        - Arbeitvertrag > Lohn darf nur zugunsten des Arbeitnehmers abgeändert werden
    ]


    #or-block[
        B. Unabänderlichkeit zuungunsten des Arbeitnehmers\
        *Art. 362*

        1 Durch Abrede, Normalarbeitsvertrag oder Gesamtarbeitsvertrag darf von den folgenden Vorschriften nicht zuungunsten der Arbeitnehmerin oder des Arbeitnehmers abgewichen werden:

        _zusammengefasst_: Lohn (inkl. Provision, Akkordlohn, Lohn bei Verhinderung und Lohnabrechnung), Auslagenersatz, Haftung, Schutz der Persönlichkeit und Daten, Ferien und verschiedene Urlaube, Arbeitszeugnis und Vorsorge, Kündigungsschutz sowie Beendigung des Arbeitsverhältnisses und Konkurrenzverbot und mehr.
    ]


7.
    Klara Kleiner arbeitet als Sachbearbeiterin Buchhaltung im Jobsharing mit einer Kollegin zu 50% auf
    einem Treuhandbüro. Irgendwann fallen dem Inhaber des Treuhandbüros verschiedene fehlerhafte
    Buchungen auf und Gelder wurden auf ein Privatkonto überwiesen. Der Inhaber verdächtigt Klara und
    kündigt ihr fristlos. Es stellt sich kurze Zeit später heraus, dass die Buchungen von der Arbeitskollegin von
    Klara Kleiner vorgenommen wurden. Wie kann Klara Kleiner gegen die fristlose Kündigung vorgehen?\
    #notiz[
        #or-block[
            #image("../assets/arbeitsrecht-1.png")
        ]
    ]
8.
#grid(
    columns: (auto, auto),
    [ a. Was sind wichtige Gründe für eine fristlose Kündigung?\
        #notiz[
            _Arbeitgeber sollte Beweise haben, sonst kann Arbeitnehmer sagen, ihm wird etwas unterstellt_\
            Beispiele für wichtige Gründe auf Arbeitgeberseite:
            - Wegen Veruntreuung am Arbeitsplatz wird ein Buchhalter fristlos entlassen.
            - Annahme von Schmiergeldern
            - Unwahre Angaben bei der Anstellung
            - Eigenmächtiger Ferienbezug
            - Verrat von Geschäftsgeheimnissen
            - Grobe Missachtung von Weisung
            - Weniger schwerwiegende Verfehlungen, aber nach erfolgter Abmahnung (heikel):
            - Übermässiges privates Telefonieren
            - Ungepflegtes Erscheinen in repräsentativen Berufen
            - Grössere Verspätungen
            - Verstoss gegen Weisungen (beharrliche oder wiederholte Nichtbeachten von berechtigten Weisungen)
        ]],
    [b. Was sind Beispiele einer missbräuchlichen Kündigung?\
        #notiz[
            Szenarien: Kündigung vor Pension, «Rachekündigung», Kündigung aufgrund Leis-
            tungsforderung (Bezahlung von Lohn, Bonus etc, Forderung von zumutbaren Arbeitsumfeld etc.)
            Vereitelung, (Kündigung vor einem grossen Bonus etc.), Kündigung durch spezielle Gesundheitsbe-
            dürfnisse (Allergien etc.) Ausüben von Rechten (Meinungsfreiheit, sofern Treu und Glauben nicht verletzt)
        ]],
)


9.
    Mitarbeiter B kann seine Arbeitszeit grundsätzlich frei einteilen und es ist ihm auch freigestellt, wann er
    Ferien machen will. In der monatlichen Lohnabrechnung steht, dass mit der Lohnzahlung allfällige
    Ferienansprüche abgegolten sind. Ist das zulässig?
    \
    #notiz[
        Nein, "Grundsätzlich gilt ein gesetzlicher Anspruch auf die erforderliche Freizeit (Art. 329 Abs. 3 OR) für wichtige persönliche
        oder familiäre Angelegenheiten, soweit sie in die Arbeitszeit fallen. \
        Die Bezahlung der Freizeit durch den Arbeitgeber
        richtet sich nach dem Anstellungsverhältnis: Bei Angestellten im Monatslohn ist die Absenz in aller Regel bezahlt.""
    ]
10.
    Fritz Müller hat seinen Job auf Ende Januar gekündigt, um während 4 Monaten eine grössere Reise zu
    machen. Kurz vor Antritt der Reise unterschreibt er bereits einen neuen Arbeitsvertrag für ein unbefristetes
    Arbeitsverhältnis ab 1. Juni. Auf seinem Roadtrip durch Europa wird er anfangs Mai mit seinem Motorrad in
    einen Unfall verwickelt, der ihn für 2 Monate arbeitsunfähig macht. Er kann seinen neuen Job erst anfangs
    Juli antreten. Ist der neue Arbeitgeber gesetzlich verpflichtet, Fritz Müller trotzdem Lohn zu bezahlen?
#notiz[
    Nein, weil er noch nicht 3 Monate gearbeitet hat oder ein befristetes Verhältnis Arb.verh. für mindestens 3 Monate hat. \
    nicht relevant:
    - Verkehrsunfälle zählen als "ohne Verschulden".
    - Er ist noch in der Probezeit
]
#or-block[
    III. Lohn bei Verhinderung an der Arbeitsleistung\
    // 1\. bei Annahmeverzug des Arbeitgebers\
    // Art. 324

    // 1 Kann die Arbeit infolge Verschuldens des Arbeitgebers nicht geleistet werden oder kommt er aus anderen Gründen mit der Annahme der Arbeitsleistung in Verzug, so bleibt er zur Entrichtung des Lohnes verpflichtet, ohne dass der Arbeitnehmer zur Nachleistung verpflichtet ist.

    // 2 Der Arbeitnehmer muss sich auf den Lohn anrechnen lassen, was er wegen Verhinderung an der Arbeitsleistung erspart oder durch anderweitige Arbeit erworben oder zu erwerben absichtlich unterlassen hat.
    2\. bei Verhinderung des Arbeitnehmers a. Grundsatz
    \ *Art. 324a*

    1. Wird der Arbeitnehmer aus Gründen, die in seiner Person liegen, wie Krankheit, Unfall, Erfüllung gesetzlicher Pflichten oder Ausübung eines öffentlichen Amtes, ohne sein Verschulden an der Arbeitsleistung verhindert, so hat ihm der Arbeitgeber für eine beschränkte Zeit den darauf entfallenden Lohn zu entrichten, samt einer angemessenen Vergütung für ausfallenden Naturallohn, _sofern das Arbeitsverhältnis mehr als drei Monate gedauert hat oder für mehr als drei Monate eingegangen ist_.
    2. Sind durch Abrede, Normalarbeitsvertrag oder Gesamtarbeitsvertrag nicht längere Zeitabschnitte bestimmt, so hat der Arbeitgeber im ersten Dienstjahr den Lohn für drei Wochen und nachher für eine angemessene längere Zeit zu entrichten, je nach der Dauer des Arbeitsverhältnisses und den besonderen Umständen.
    3. Bei Schwangerschaft der Arbeitnehmerin hat der Arbeitgeber den Lohn im gleichen Umfang zu entrichten.
    4. Durch schriftliche Abrede, Normalarbeitsvertrag oder Gesamtarbeitsvertrag kann eine von den vorstehenden Bestimmungen abweichende Regelung getroffen werden, wenn sie für den Arbeitnehmer mindestens gleichwertig ist.
]
