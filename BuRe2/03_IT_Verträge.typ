// /*
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content
#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "BuRe2",
    fach-long: "IT Verträge",
    semester: "FS26",
    language: "de",
    font-size: 10pt,
    tableofcontents: (enabled: false, depth: 3, columns: 2),
    // display-title-header: false,
)
// */
#show heading.where(level: 3): h => {
    block(
        above: -3em,
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

// IT-Verträge erkennen können
// - welcher nominatvertrag?
// 	- kaufvertrag..., werkvertrag, auftrag
// - dann gelten die besonderen bestimmungen zu ... vertrag
// - mietrecht muss dann nicht so genau angeschaut werden, nur erkennen aber nicht regeln davon sehen
//

=== Einige wichtige IT-Verträge:
*Software-Lizenzvertrag*:\
Einräumung von Rechten zum Gebrauch von Applikationen während
längerer Dauer, gegen die Entrichtung von Benützungsgebühren. Bspw. unbefristete Lizenzierung,
Abonnement-basierte Lizenzierung (Spotify, Adobe, Netflix), Netzwerklizenzen, Cloudbasierte
Lizenzierung
// - #strike[Gebrauchsleihe]
- _Miete oder Kauf_ ist richtig (Kauf = Eigentumsübertragung)
    - eigentlich ist Film online kaufen nicht richtig ausgedrückt (es ist kein "Kauf"), wenn man einen Film auf Amazon kauft ist es wie wenn der Verkäufer immer anwesend sein muss.
\
\
*Wartungsvertrag*: \
Vertragsgegenstand ist der Erhalt/Verbesserung und/oder die Wiederherstellung der Betriebsbereitschaft der Software oder die Aktualisierung, Beratung sowie Pflege der Software.
- _Auftrag_, kann nicht immer Erfolg garantieren
- _Dienstleistungsvertrag für Planung und Beratung_
\
\
*Lieferung von integrierten Informatiksystemen*\
// T~~ransport = Erfolg wichtig = Kaufvertrag~~
// ~~wenn temporär: Miete~~.
(es ist nicht der "Transport" als Lieferung gemeint).
- _Kaufvertrag oder Werkvertrag_ (wenn massgeschneidert)

- _Systemintegrationsvertrag_: Planung, Einrichtung und Aufbau von IT-Systemen. Prüfung von Kompatibilität von Hardware- und Softwarekomponenten
- _IT-Werkvertrag_: Es ist ein bestimmbares oder bestimmtes Ergebnis geschuldet. Das Werk muss genau, auch für Dritte nachvollziehbar, umschrieben und definiert werden.
- _IT-Dienstleistungsvertrag_: Der Beauftragte verpflichtet sich, für den Kunden in fachgerechter Sorgfalt tätig zu werden, nicht aber zur Realisierung eines bestimmten Erfolges.

- Outsourcingvertrag: "Outside Resource Using", Auslagerung von IT-Systemen oder Prozessen
\
\
*Software Escrow Agreement:*\
Entwickler hinterlegt den Source Code von Software bei einem neutralen Dritten. Der Escrow-Agent bewahrt den Source Code sicher auf. Erst wenn eine der vordefinierten Voraussetzungen eintritt, gibt der Escrow-Agent dem Kunden den Source Code
heraus.
// > ~~Miete~~
- _Hinterlegungsvertrag_, wie Bankschliessfach
    - wäre unter Nominatvertrag: Hinterlegungsvertrag
\
*Cloud Services*:\
Würde ich alle als _Mietvertrag_ einstufen, aber PaaS+SaaS könnten auch Mischvertrag (_Miete + Auftrag_) sein wegen Wartung, Support...
- *IaaS* Infrastructure as a Service  = Bereitstellung von Speicher, Netzwerk, Servern und Virtualisierung (Bspw. IBM Cloud, Google Compute Engine, Amazon Web Services und Microsoft Azure)
- *SaaS* Software as a Service  = Lizenz- und Vertriebsmodell, mit dem Software-Anwendungen über das Internet, d.h. als Service, angeboten werden. Die Nutzung erfolgt in der Regel auf Abonnementbasis. SaaS wird auf Remote-Servern betrieben und vom Anbieter verwaltet, aktualisiert und gewartet. (Bspw. Dropbox, Microsoft Office oder Google Apps)
- *PaaS* Platform as a Service  = Plattform kann über das Internet genutzt werden und bietet Nutzern sowohl ein Framework als auch passsende Tools, um Applikationen und Software zu entwickeln. (Bspw. Windows Azure, SAP Cloud oder Google App Engine

\
*Hardwareverkaufsvertrag*\
- _Kaufvertrag_, kein massgeschneidertes Produkt
\
*Softwareentwicklungsvertrag*: \
Entwickler erstellt eine Software-Applikation nach den konkreten Vorgaben des Bestellers: _Werkvertrag_

- Roamingverträge: Nutzung des mobilen Endgerätes in einem ausländischen Netz für Telefonate, Nachrichten und mobile Daten
- Software-Distributionsvertrag: Hersteller oder Lieferant beauftragt einen Vertreiber mit dem Verkauf seiner Produkte
- Erbringung von Hosting-Dienstleistungen: Überlassung von Speicherplatz auf der Serverinfrastruktur des Anbieters für die Website oder Applikation des Kunden sowie die Erbringung dazugehöriger Dienstleistungen.
\
\
*Konzeption und Realisierung einer Web-Applikation*: \
Softwareprogramm, das auf einem Webserver ausgeführt wird. Im Gegensatz zu Desktop-Anwendungen, die lokal auf einem Computer installiert werden, muss auf Webanwendungen über einen Webbrowser zugegriffen werden. Bspw. Webshop oder Internet-Banking-Programme, Evernote, Google Apps, Pocket.  speziell, da Konzeption auch _Dienstleistung_ enthält

- Erstellen einer Website, agile oder wasserfall?
    - agile=Auftrag
    - Wasserfall=werkvertrag
