// Vorlesungsfolien als Typst, Notizen in eigener Typst Box
// pdf hat 25 im name, schauen ob es aktuell ist

#let link_box(content) = block(
    fill: rgb("#eef2ff"),
    inset: 10pt,
    radius: 8pt,
    spacing: 0.75em,
    content,
)

#let notiz(content) = block(
    fill: rgb("#da05a1"),
    content,
)

#notiz([
    Themen:
    @
])

// **Recht für Ingenieure**
// 2026 11. März
// Business und Recht II
// Stefan Herzog, M.A. HSG in Rechtswissenschaften
// Institut für Kommunikation und Interkulturelle Kompetenz

// regex zum []{.underline} in typst umzuwandeln
// \[(.*?)\]\{\.underline\}
// #underline([$1])

#image("./assets/image.png")

= Grundsätzliches zum Vertragsrecht (kurzes Warm up)

**Art. 19 OR**

1 Der **Inhalt des Vertrages** kann innerhalb der Schranken des
Gesetzes beliebig festgestellt werden. \
2 Von den gesetzlichen
Vorschriften abweichende Vereinbarungen sind nur zulässig, wo das
Gesetz nicht eine unabänderliche Vorschrift aufstellt oder die
Abweichung nicht einen Verstoss gegen die öffentliche Ordnung, gegen
die guten Sitten oder gegen das Recht der Persönlichkeit in sich
schliesst.
- Grundsatz der #underline([Vertragsfreiheit]) und der
    #underline([Privatautonomie]) aber Einschränkung der Vertragsfreiheit durch #underline[zwingende Normen]
- #underline([])
- #underline([Lückenfüllung durch dispositive Bestimmungen])

**Art. 1 OR**
1. Zum Abschlusse eines Vertrages ist die **übereinstimmende
    gegenseitige** Willensäusserung der Parteien erforderlich.

2. Sie kann eine ausdrückliche oder stillschweigende sein.

    - Natürlicher Konsens = Einigkeit betreffend essentialia negotii
        (unentbehrliche Vertragspunkte)

    - Normativer Konsens = Kein übereinstimmender Wille, jedoch
        übereinstimmende Willenserklärungen nach dem Vertrauensprinzip
        (versteckter Dissens)

    - Objektiv wesentliche Vertragspunkte = unentbehrliche
        Vertragspunkte

    - Subjektiv wesentliche Vertragspunkte = betreffen Vertragspunkte,
        ohne die eine Vertragspartei keinen Vertrag eingehen würde.

= Grundsätzliches zum Vertragsrecht (kurzes Warm up)

**Art. 2 OR**
>
1 Haben sich die Parteien über **alle wesentlichen Punkte** geeinigt,
so wird vermutet, dass der Vorbehalt von Nebenpunkten die
Verbindlichkeit des Vertrages nicht hindern solle.

- Beim Kaufvertrag: Kaufsache, Name der Parteien, Preis,

- Bei der Miete: Mietgegenstand, Höhe der Miete, Mietparteien

- Bei Innominatverträgen: Die wesentlichen Punkte müssen soweit
    vorhanden sein, dass der Sinn des Vertrages festgestellt werden kann.

**Art. 11 OR**
>
1 Verträge bedürfen zu ihrer Gültigkeit nur dann einer besonderen
Form, wenn das Gesetz eine solche vorschreibt.
>
• Keine Formvorschriften bei IT-Verträgen

= IT-Verträge (Eigenschaften)

- **IT-Verträge** gehören zum betrieblichen Alltag. Sie zählen zu den
    Innominatverträgen und enthalten oftmals Elemente des Auftrags
    und/oder des Werkvertrages oder auch von anderen Vertragstypen, wie
    bspw. der Miete, Hinterlegung, Pacht oder dem Kauf.

- Die Abgrenzung ist oft schwierig und muss einzelfallspezifisch
    vorgenommen werden. **Umso wichtiger** ist es, im Vorfeld den Vertrag
    genau auf die Absichten der Parteien hin zu formulieren und
    auszulegen.

= IT-Verträge (Eigenschaften)

- Die Bestimmungen des OR kommen analog zur Anwendung. Umso wichtiger
    ist es, die einzelnen Elemente des Vertrages richtig zu subsumieren
    (Mängelrechte, Verjährung, Haftungsausschlüsse, Rügeobliegenheit
    etc.).

- Entwicklung einer App, Erstellung einer Website oder Entwicklung einer
    Individualsoftware, Installations- und Reparaturarbeiten = Erfolg ist
    i.d.R. geschuldet, daher überwiegend **Werkvertrag**

- Nutzungsrechte bei Cloudverträgen = Können Elemente der **Miete**
    enthalten

- Selbstständige Planung, Beratung und Projektmanagementleistungen = Das
    sorgfältige Tätigwerden ist im Vordergrund, daher überwiegend
    **Auftrag**

- Erwerb einer Standardsoftware: Die Regelungen betreffend den
    **Kaufvertrag** kommen analog zur Anwendung. Individuell konzipierte
    IT-Produkte haben aber **werkvertraglichen Charakter**.

- Wo die Bestimmungen des OR BT nicht oder nur beschränkt angewendet
    werden können, kommen die OR AT-Bestimmungen (z.B. Folgen der
    Nichterfüllung OR 97ff. oder Verjährung OR 127ff.) zum Tragen.

= IT-Verträge (Erscheinungsformen)

Einige **wichtige IT-Verträge**:

- #underline([Software-Lizenzvertrag:]) Einräumung von Rechten zum
    Gebrauch von Applikationen während längerer Dauer, gegen die
    Entrichtung von Benützungsgebühren. Bspw. unbefristete Lizenzierung,
    Abonnement-basierte Lizenzierung (Spotify, Adobe, Netflix),
    Netzwerklizenzen, Cloudbasierte Lizenzierung

- #underline([Wartungsvertrag:]) Vertragsgegenstand ist der
    Erhalt/Verbesserung und/oder die Wiederherstellung der
    Betriebsbereitschaft der Software oder die Aktualisierung, Beratung
    sowie Pflege der Software.

- Dienstleistungsvertrag für Planung und Beratung

- #underline([Lieferung von integrierten Informatiksystemen])

- Systemintegrationsvertrag: Planung, Einrichtung und Aufbau von
    IT-Systemen. Prüfung von Kompatibilität von Hardware- und
    Softwarekomponenten

- IT-Werkvertrag: Es ist ein bestimmbares oder bestimmtes Ergebnis
    geschuldet. Das Werk muss genau, auch für Dritte nachvollziehbar,
    umschrieben und definiert werden.

- IT-Dienstleistungsvertrag: Der Beauftragte verpflichtet sich, für den
    Kunden in fachgerechter Sorgfalt tätig zu werden, nicht aber zur
    Realisierung eines bestimmten Erfolges.

= IT-Verträge (Erscheinungsformen)

- Outsourcingvertrag: **Out**side Re**source** Us**ing,** Auslagerung
    von IT-Systemen oder Prozessen

- #underline([Software Escrow Agreement:]) Entwickler hinterlegt den
    Source Code von Software bei einem neutralen Dritten. Der Escrow-Agent
    bewahrt den Source Code sicher auf. Erst wenn eine der vordefinierten
    Voraussetzungen eintritt, gibt der Escrow-Agent dem Kunden den Source
    Code heraus.

- Cloud Services:

− Infrastructure as a Service (IaaS) = Bereitstellung von Speicher,
Netzwerk, Servern und Virtualisierung
>
(Bspw. IBM Cloud, Google Compute Engine, Amazon Web Services und
Microsoft Azure)
>
− Software as a Service (SaaS) = Lizenz- und Vertriebsmodell, mit dem
Software-Anwendungen über das Internet, d.h. als Service, angeboten
werden. Die Nutzung erfolgt in der Regel auf Abonnementbasis. SaaS
wird auf Remote-Servern betrieben und vom Anbieter verwaltet,
aktualisiert und gewartet. (Bspw. Dropbox, Microsoft Office oder
Google Apps)
>
− Platform as a Service (PaaS) = Plattform kann über das Internet
genutzt werden und bietet Nutzern sowohl ein Framework als auch
passsende Tools, um Applikationen und Software zu entwickeln. (Bspw.
Windows Azure, SAP Cloud oder Google App Engine)

= IT-Verträge (Erscheinungsformen)

- #underline([Hardwareverkaufsvertrag])

- #underline([Softwareentwicklungsvertrag:]) Entwickler erstellt eine
    Software-Applikation nach den konkreten Vorgaben des Bestellers

- Roamingverträge: Nutzung des mobilen Endgerätes in einem ausländischen
    Netz für Telefonate, Nachrichten und mobile Daten

- Software-Distributionsvertrag: Hersteller oder Lieferant beauftragt
    einen Vertreiber mit dem Verkauf seiner Produkte

- Erbringung von Hosting-Dienstleistungen: Überlassung von Speicherplatz
    auf der Serverinfrastruktur des Anbieters für die Website oder
    Applikation des Kunden sowie die Erbringung dazugehöriger
    Dienstleistungen.

- #underline([Konzeption und Realisierung einer Web-Applikation:])
    Softwareprogramm, das auf einem Webserver ausgeführt wird. Im

Gegensatz zu Desktop-Anwendungen, die lokal auf einem Computer
installiert werden, muss auf Webanwendungen über einen Webbrowser
zugegriffen werden. Bspw. Webshop oder Internet-BankingProgramme,
Evernote, Google Apps, Pocket. • #underline([Erstellen einer Website])

**Versuchen Sie die unterstrichenen Verträge einem möglichst passenden
Nominatvertrag zuzuordnen.**

= Leistungsstörungen im Zusammenhang mit IT-Verträgen

•

Das IT

\-

System funktioniert nicht wie erwartet/zugesichert.

•

Softwarefehler führen zu Systemausfällen und Datenverlusten

•

Anfälligkeit des Systems auf Hackerangriffe

•

Systemzugriffe sind nicht möglich

•

Prozesse laufen nicht wie vorgesehen ab

Mögliche Leistungsstörungen sind:

•

Produktionsausfälle (Einnahmenverlust, Schadenersatzansprüche von
Vertragspartnern, weitere mittelbare Schäden)

•

Personenschäden bei Systemausfällen/Fehlsteuerung von
sicherheitsrelevanter Software

•

Reputationsschäden

•

Persönlichkeits

\-

und Datenschutzverletzungen

Konsequenzen können sein:

•

Ausservertragliche Haftungsansprüche (z.B. Delikt

\-

(

OR 41), Geschäftsherren

\-

(

OR 55) und Produktehaftung

(

PrHG

))

•

Vertragliche Haftungsansprüche (z.B. Arbeitsrechtliche Ansprüche (OR
321e), Gewährleistungs

\-

und Haftungsansprüche (z.B.

OR 97))

•

Verantwortlichkeitsansprüche

Mögliche Haftungsansprüche:

= IT-Verträge (Mängelrechte)

Bei Mängeln ist jeweils darauf zu achten, welche rechtlichen
Grundlagen am ehesten zur Anwendung kommen, sofern die Parteien
diesbezüglich nichts vereinbart haben:

- Mängel und Verzug bei:

- **kaufvertraglichen** Eigenschaften s. Art. 97ff. OR und die
    besonderen Bestimmungen zum Kaufvertrag insb. Art. 197ff. OR
    (Wandelung, Minderung oder Ersatzlieferung)

- **werkvertraglichen** Eigenschaften s. Art. 97ff. OR und die
    besonderen

Bestimmungen zum Werkvertrag Art. 363ff. OR (Wandelung, Minderung oder
Nachbesserung)

- **auftragsrechtlichen** Eigenschaften s. Art. 97ff. OR und die
    besonderen Bestimmungen zum Auftrag Art. 394ff. OR (Schadenersatz)

= Risiken/Probleme im Zusammenhang mit IT-Verträgen

Uneinigkeit betreffend der zu erbringenden Leistung
>
Mangelhafte Vertragserfüllung (Nichterfüllung/Schlechterfüllung)
>
Haftung
>
Datenschutzverletzungen
>
Sich verändernde Bedürfnisse des Leistungsnachfragers
>
Höhere Kosten als erwartet/veranschlagt
>
Ausstehende Zahlungen
>
Vorzeitige Vertragsauflösung

= IT-Verträge (Regelungspunkte in den Verträgen)

Folgende Punkte sind i.d.R. in IT-Verträgen relevant und sollten
geregelt werden:

- **Genaue Umschreibung der vertraglichen Leistung**: Je präziser desto
    weniger Schwierigkeiten gibt es bei der Auslegung (Pflichtenheft,
    Termine und Mitwirkungspflichten der Parteien, usw.).

- Sind alle Vertragsleistungen vollständig und klar festgehalten?

- **Preis:** Es ist sinnvoll den Preis und die darunterfallenden
    Leistungen möglichst klar zu definieren.

- Preis definiert oder ohne Weiteres berechenbar (Stück, Stunde,
    Pauschale)? Preis für zusätzliche Leistungen resp.
    Preisanpassungsmechanismus auch bei ausserordentlichen Umständen
    (fehlende Vorhersehbarkeit und klares Missverhältnis von Leistung und
    Gegenleistung) festgelegt?

- **Nutzungsrechte**: Wenn bspw. die Nutzung von einem Dritten zur
    Verfügung gestellt wird (z.B. Microsoft365). Nutzungsrechte sind
    zeitlich limitiert und können nach Vertragsende nicht mehr
    weitergenutzt werden. Allfällige damit verbundene Migrationen können
    daher zu hohen Zusatzkosten führen.

- **Lizenzverträge** (Innominatverträge sui generis): Inhaber eines
    Immaterialgüterrechts gewährt Nutzung gegen Entgelt.

- Sind eigene Lizenzverträge oder von Dritten zu beachten?

= IT-Verträge (Regelungspunkte in den Verträgen)

- **Regelungen den Datenschutz und die Informationssicherheit
    betreffend**: Werden bspw. Personendaten bearbeitet? Welchen
    Sicherheitsstandard hat der Provider?

- **Geheimhaltung:** Der Dienstleistungserbringer hat nicht selten
    Einblick in wichtige und geheim zu haltenden Geschäftsinformationen.

- **Gewährleistungsrecht und Haftung**: Für welche Leistung muss wer,
    wie einstehen?

- Als Mangel wird in der Technik generell eine Abweichung von Vorgaben
    angesehen, während im rechtlichen Sinne ein Mangel ursächlich für eine
    **Beeinträchtigung der vertraglich geschuldeten Leistung**
    (subjektive- und objektive Wesentlichkeit) sein muss.

− Mängel können sein: Schlechte Kostenschätzung oder Kostenkontrolle,
mangelnde
>
Benutzerfreundlichkeit, rechtliche Mängel (fehlende Lizenzen),
notwendige Funktionen fehlen, Viren in der Software, keine
ausreichende Performance, Drittkomponenten sind nicht kompatibel oder
ganz allgemein, das Fehlen von zugesicherten Eigenschaften

- Sind die Mangelanmeldeprozesse eindeutig definiert? Ist definiert, was
    Mangelbehebung und was ein kostenpflichtiger Support ist? Wer haftet
    und wie (beschränkt oder unbeschränkt)?

- **Vertragsauflösung**: Ordentliche- und ausserordentliche Auflösung

= Mögliche Vertragsklauseln

• **7. Gewährleistung und Abnahme der Leistungen**

== • 7.1 Gewährleistung

- **7.1.1. Grundsatz:** Optiwork erbringt ihre Leistungen mit grösster
    Sorgfalt und nach bestem Wissen und Gewissen. Sie gewährleistet das
    zwischen den Parteien vereinbarte Funktionieren der Produkte und
    Dienstleistungen. Kleinere, die Tauglichkeit zum vorausgesetzten
    Gebrauch nicht erheblich mindernde oder aufhebende Fehler können
    allerdings nicht mit Sicherheit vermieden werden.

- **7.1.2. Für eigene Software:** Es gelten die Bestimmungen des
    Softwarelizenzvertrages DOMUS.

- **7.1.3 Für Hardware und Fremdsoftware**: Es gelten die
    Garantiebestimmungen des Drittlieferanten.

- **7.2 Abnahme:** Die Abnahme erfolgt nach erbrachter Leistung. Ein
    Abnahmeprotokoll ist nur aufgrund einer speziellen, gegenseitigen
    Vereinbarung vorgesehen.

- **7.3 Nach erfolgter Abnahme:** Für die Zeit nach der Abnahme
    schliessen die Vertragsparteien einen Wartungsvertrag ab.

- **7.4 Mängelrüge**: Eine detaillierte Mängelrüge ist vom Kunden
    schriftlich während eines laufenden Projektes oder spätestens 30 Tage
    nach Erhalt einer Teil- oder Schlussrechnung an Optiwork zuzustellen.

Als Mängel verstehen die Vertragsparteien wesentliche Abweichungen von
der Spezifikation gemäss Auftragsbestätigung, Vertrag oder des
Programmbeschriebes, die den Wert oder die Tauglichkeit für den im
Vertrag oder Auftrag vorgesehenen Gebrauch aufheben oder erheblich
mindern.

- **7.5 Kostenlose Mängelbehebung:** Optiwork behebt gerügte und von
    Optiwork anerkannte Mängel ohne Kostenfolge für den Kunden.
    Aufwendungen der Kunden werden nicht von BRZ übernommen.

- **7.6 Kostenpflichtige Mängelbehebung:** Stellt sich nach gemeinsamer
    Prüfung durch beide Parteien heraus, dass ein gerügter Mangel
    nachweislich nicht durch Optiwork zu vertreten ist, so ist der Kunde
    verpflichtet, der Optiwork die entstandenen Aufwendungen nach den
    jeweils gültigen Preisen und Bedingungen zu vergüten.

- **7.7 Weitergehende Ansprüche:** Andere Rechtsbehelfe als die
    Nachbesserung werden, vorbehältlich von Schadenersatz im Falle von
    grober Fahrlässigkeit oder Vorsatz, ausdrücklich ausgeschlossen.
    Insbesondere ist der Kunde nicht berechtigt, die Nachbesserung selber
    vorzunehmen oder durch Dritte vornehmen zu lassen und die
    entsprechenden Kosten gegenüber Optiwork geltend zu machen.

**Beurteilen Sie diese Klausel aus der Sicht des Bestellers. Was würden
Sie ändern?**

= Mögliche Vertragsklauseln

8. **Haftung**

    1. **Voraussetzungen:** Bei Vertragsverletzungen oder unerlaubten
        Handlungen, welche von Optiwork oder deren Mitarbeitenden zu
        verantworten sind, haftet Optiwork nur, soweit die
        Vertragsverletzung oder eine unerlaubte Handlung durch
        rechtswidrige Absicht oder grobe Fahrlässigkeit verursacht
        wurde.

    2. **Begrenzung der Haftung:** Sofern in den einzelnen Verträgen
        keine weitergehende Begrenzung der Haftung und der

Schadenersatzpflicht vereinbart ist, wird die Höchstsumme des
Schadenersatzes in jedem Fall auf die seitens des Kunden unter dem
entsprechenden Einzelvertrag bereits geleisteten jährlichen Zahlungen
oder geschuldeten Entgelte beschränkt. Dies gilt auch für
Schadenersatzansprüche des Kunden im Fall der Kündigung des Vertrages
oder des Rücktrittes vom Vertrag durch den Kunden.

3. **Folgeschäden:** Optiwork haftet auf keinen Fall für
    Mangelfolgeschäden, mittelbare Schäden, entgangenen Gewinn,
    Frustrationsschäden oder Ansprüche Dritter, die an den Kunden
    gestellt werden.

4. **Ausschluss von Gewährleistungs- und Haftungsansprüchen:**
    Sämtliche Haftungs- und Gewährleistungsansprüche werden
    ausgeschlossen, wenn Dritte ohne ausdrückliche Einwilligung von
    Optiwork Eingriffe an deren Produkten vornehmen oder wenn der Kunde
    ohne ausdrückliche Zustimmung von Optiwork Änderungen an der
    Hardware-Charakteristika, Installationen, Betriebssoftware oder
    anderer mit der Leistung von Optiwork im Zusammenhang stehenden
    Software vornimmt oder vornehmen lässt.

5. **Unzureichende Mitwirkung des Kunden:** Wenn der Mangel auf der vom
    Kunden gegebenen Aufgabenstellung oder der fehlerhaften und/oder
    unzureichenden Mitwirkung des Kunden beruht, werden alle Haftungs-
    und Gewährleistungsansprüche ausgeschlossen.

6. **Verhinderung der Leistungserbringung:** Wird Optiwork aus Gründen,
    welche sie nicht zu vertreten hat, an der zeitgerechten oder
    sachgemässen Erfüllung der Verpflichtungen aus dem Vertrag
    gehindert, so entsteht ebenfalls kein Haftungsanspruch.

**Beurteilen Sie diese Klausel aus der Sicht des Bestellers. Was würden
Sie ändern?**

= IT-Verträge (Erscheinungsformen)

- **Schauen Sie sich einmal #underline([eine]) der nachstehenden
    Vertragsgrundlagen in Ruhe an:**

- Allgemeine Nutzungsbedingungen Spotify: [[Allgemeine
    Nutzungsbedingungen](https://www.spotify.com/de/legal/end-user-agreement/#13-gew%C3%A4hrleistung)
    --
    [Spotify](https://www.spotify.com/de/legal/end-user-agreement/#13-gew%C3%A4hrleistung)]{.underline}

- Allgemeine Nutzungsbedingungen Netflix:
    [[https://help.netflix.com/legal/termsofuse]{.underline}](https://help.netflix.com/legal/termsofuse)

- Allgemeine Geschäftsbeziehungen SAP AG: [[General Terms and Conditions
    \| Agreements \| SAP Trust]{.underline}
    [Center]{.underline}](https://www.sap.com/swiss/about/trust-center/agreements/on-premise/general-terms-and-conditions.html?sort=latest_desc&tag=language:german&pdf-asset=bed99d91-647e-0010-bca6-c68f7e60039b&page=1)

- **und beurteilen Sie insbesondere die folgenden Punkte:**

- Haftung

- Gerichtsstand

- Gewährleistung

- Datenschutz

- Preisänderungen und Änderungen beim Leistungsumfang

- Das Leistungsspektrum kann sehr breit und verschiedenartig sein. Als
    Folge davon kann der OutsourcingVertrag oftmals nicht unter einen der
    gesetzlich geregelten Vertragstypen subsumiert werden. Es handelt sich
    bei diesem Vertrag um einen **Innominatvertrag**. Er stellt nicht
    selten einen **gemischten Vertrag** dar, der Elemente verschiedener
    Vertragstypen enthält (Bspw. Miete, Pacht, Werkvertrag oder Auftrag).
    (Quelle: [[01_04.fm
    (swlegal.com)]{.underline}](https://www.swlegal.com/media/filer_public/69/1b/691bd572-74ff-4257-a370-101f986bb15b/140801_roland-mathys_it-outsourcing-vertrag.pdf))

- Erscheinungsformen (Quelle: [[01_04.fm
    (swlegal.ch)](https://www.swlegal.ch/media/filer_public/69/1b/691bd572-74ff-4257-a370-101f986bb15b/140801_roland-mathys_it-outsourcing-vertrag.pdf)]{.underline}
    ):

- Das Outsourcing kann darauf beschränkt sein, eine bestimmte
    IT-Infrastruktur zur Verfügung zu stellen, auf der der Nutzer seine
    Aufgaben selbst vollzieht (**Systems Management**).

- Beim **Application Management** übernimmt der Outsourcing-Provider die
    Aufgabe, eine Softwareanwendung zu betreuen.

- Der Outsourcing-Provider kann neben dem Betrieb der IT-Infrastruktur
    weitere Funktionen wie die Abwicklung von Geschäftsvorgängen des
    Outsourcing-Bezügers übernehmen. Dann spricht man von einem **Business
    Process Outsourcing**.

= IT-Verträge (Outsourcing-Vertrag)

Vorteile des Outsourcings:

- Kosteneinsparung (Anbieter stehen im Wettbewerb und Know-how der
    Anbieter kann genutzt werden)

- Effizienzgewinn (Anbieter ist daran interessiert, die optimale Lösung
    anzubieten und es ist sein Kerngeschäft)

- klare Kostenstruktur

- Straffung der eigenen Organisation

- Fokus auf eigenes Kerngeschäft

Nachteile des Outsourcings:

- Bei einem Outsourcing gliedert man oftmals **betriebskritische
    Systeme** und/oder **Prozesse** auf einen Dritten aus und ist davon
    abhängig, dass der Outsourcing-Provider über einen längeren Zeitraum
    die vereinbarten Dienstleistungen zu den vereinbarten Service Levels
    und Preisen erbringt.

- Leistungsstörungen während des Betriebes können sich gravierend auf
    das Geschäft des Kunden auswirken.

- Nutzer gibt einen Teil der Kontrolle über seine Daten ab.

- Der Outsourcingvertrag kann unterschiedlich aufgebaut sein.

- Es kommt vor, dass **ein bestimmter Vertrag** für eine oder mehrere
    Dienstleistungen ausgefertigt wird.

- Oder es wird ein **Rahmenvertrag** abgeschlossen, der für eine
    Mehrzahl von Dienstleistungen [die grundlegenden vertraglichen
    Bestimmungen]{.underline} festlegt. Aufbauend auf diesem Vertrag
    werden für jede einzelne Dienstleistung sogenannte **Einzelverträge**
    abgeschlossen, die die Spezifika der betreffenden Dienstleistung
    festlegen.

- Ergänzt werden solche Rahmenverträge und Einzelverträge oftmals durch
    **Service Level Agreements (SLAs)**, welche genauer die
    Leistungsmerkmale für gewisse Dienstleistungen definieren. (Quelle:
    [[Home](https://www.nkf.ch/) - [Niederer Kraft Frey
    (nkf.ch)](https://www.nkf.ch/)]{.underline})

- Service Level Agreement: SLAs dienen der detaillierten Beschreibung
    von Art, Quantität und Qualität vereinbarter Outsourcing-Services,
    wodurch Dienstleistungen messbar gemacht werden. Während technische
    und operative Bestimmungen auf Stufe SLA festzuschreiben sind, müssen
    die **zentralen strategischen und kommerziellen Punkte** im
    Outsourcing-Vertrag selbst Berücksichtigung finden. Andernfalls
    besteht die Gefahr, dass durch nachträgliche Ergänzung oder Änderung
    von SLAs der Sinn eines Outsourcing-Vertrages ausgehöhlt wird.

(Quelle: [[01_04.fm
(swlegal.com)]{.underline}](https://www.swlegal.com/media/filer_public/69/1b/691bd572-74ff-4257-a370-101f986bb15b/140801_roland-mathys_it-outsourcing-vertrag.pdf))

Bildquelle:

[[Mustervertrag
(sa]{.underline}](https://digital.sav-fsa.ch/documents/1060627/1169162/Mustervertrag_f%C3%BCr_Cloudanbieter_mit_Auslandsbezug.pdf/07aff9f5-f762-df77-d458-2aef72675f6e?t=1614777409987)

[[v]{.underline}](https://digital.sav-fsa.ch/documents/1060627/1169162/Mustervertrag_f%C3%BCr_Cloudanbieter_mit_Auslandsbezug.pdf/07aff9f5-f762-df77-d458-2aef72675f6e?t=1614777409987)

[-]{.underline}

[[fsa.ch]{.underline}](https://digital.sav-fsa.ch/documents/1060627/1169162/Mustervertrag_f%C3%BCr_Cloudanbieter_mit_Auslandsbezug.pdf/07aff9f5-f762-df77-d458-2aef72675f6e?t=1614777409987)

[[)]{.underline}](https://digital.sav-fsa.ch/documents/1060627/1169162/Mustervertrag_f%C3%BCr_Cloudanbieter_mit_Auslandsbezug.pdf/07aff9f5-f762-df77-d458-2aef72675f6e?t=1614777409987)

- Beim Outsourcing-Vertrag ist die Frage der **Vertragsqualifikation**
    relevant. Käme Auftragsrecht zum Tragen, wäre der Vertrag jederzeit
    kündbar, das kann aber nicht im Sinne der Parteien sein.

- Vielmehr dürften aufgrund der **konkret feststell- und messbaren
    Leistungspflicht** des

Dienstleistungserbringers eher werkvertragsähnliche Elemente
überwiegen. Werden dem Kunden auch Systemkapazität zur Verfügung
gestellt, hat der Outsourcing-Vertrag auch mietvertragsähnlichen
Elemente.

- Untergeordnete auftragsrechtliche Elemente können bei reinen
    Beratungsleistungen oder bei einem Tätigwerden für den Kunden, bei
    welchem keine konkret messbare Leistungspflicht verbunden ist,
    auftreten. (Quelle: [[Home](https://www.nkf.ch/) - [Niederer Kraft
    Frey (nkf.ch)](https://www.nkf.ch/)]{.underline})

- Wichtige **Phasen des Outsourcings** sind:

- die Auslagerung der IT-Infrastruktur

- der anschliessende Betrieb

- und die Rückübertragung

- Über diese Phasen sollte der Vertrag Auskunft geben können.

= IT-Verträge (Outsourcing-Vertrag)

Beispiele zur vertragstypologischen Einordnung:

- Bei der **Entwicklung** und **Einführung einer neuen
    IT-Systemumgebung**, unterliegt die vertragliche Beziehung primär dem
    **Werkvertragsrecht**. Hinzu können **auftragsrechtliche Elemente**
    treten.

- Bei der **Übernahme einer bestehenden IT-Infrastruktur** stehen
    **kauf-, miet- und lizenzvertragliche Elemente** im Vordergrund, wobei
    die unterschiedlichen Bestimmungen betreffend die Übertragung von
    Infrastrukturkomponenten jeweils besonders zu berücksichtigen sind.

- Werden auch **Personalressourcen** ausgelagert, sind zudem
    **arbeitsrechtliche Bestimmungen** massgeblich.

- Der **eigentliche Betrieb der ausgelagerten Systeme, Anwendungen oder
    Prozesse** hat primär **werkvertraglichen Charakter**, falls vom
    Outsourcing-Provider eine Erfolgsgarantie übernommen wird, was beim
    Einsatz von Service Level Agreements die Regel darstellt.

- Der Dauerschuldcharakter des IT-Outsourcing bildet dabei ein
    atypisches Vertragselement. Beschränkt sich das

Outsourcing auf das **reine Bereithalten von Rechnerkapazität ohne
Erbringung zusätzlicher**
>
**Datenverarbeitungsleistungen**, rückt das Outsourcing in die Nähe
eines **Miet- oder Pachtvertrages**. Oft können auch Merkmale des
**Auftrages (z.B. Schulung/Support**) oder des
**Hinterlegungsvertrages (bei der Datenauslagerung)** vorgefunden
werden.

Quelle: [[01_04.fm
(swlegal.com)]{.underline}](https://www.swlegal.com/media/filer_public/69/1b/691bd572-74ff-4257-a370-101f986bb15b/140801_roland-mathys_it-outsourcing-vertrag.pdf)

= Wichtige Regelungspunkte in einem Outsourcing-Vertrag

Checkliste: (Quelle:
[Straub-Checkliste-Cloud-Computing-jusletter-14.07.2014-DE.pdf]{.underline})

- **Rahmenbedingungen:** Informationen zum Provider (insbesondere
    Domizil) und zum Auftraggeber

- **Konkreter Inhalt der Leistung:** Kriterien wie Rechner- oder
    Speicherkapazität, Anzahl Transaktionen pro Zeiteinheit, Antwortzeit,
    Verfügbarkeit oder Reaktionszeit. Ob der Provider die Leistungen
    vertragsgemäss erbracht hat, beurteilt sich nach den in SLAs
    festgeschriebenen Grenzwerten bzw. Toleranzen.

- Z.B. Mindestverfügbarkeiten, Übertragungsbandbreiten,
    Systemantwortzeiten, Support Levels,

Recovery Time Objectives (wie lange darf ein Geschäftsprozess oder ein
System ausfallen?),

Recovery Point Objectives (wie viel Datenverlust kann in Kauf genommen
werden?) und Kundenzufriedenheit durch Key Performance Indicators

- **Vergütung:** Pauschalpreis, Nutzungsabhängige Gebühren (z.B. nach
    Datenvolumen / zeitlicher Be‐ anspruchung von Rechenleistung und
    Applikationen, aufwandsabhängige Leistungen, Auslagen, Spesen und
    Gebühren, Mengenrabatte etc.), Anpassungsmöglichkeiten von Vergütungen

= Wichtige Regelungspunkte in einem Outsourcing-Vertrag

- **Messung des Leistungsbezugs**

- Fälligkeitstermine, Abrechnungs‐ und Zahlungsmodalitäten

- Verzug und Lösung von Differenzen über Zahlungsverpflichtungen

- **Informationssicherheit und Datenschutz**

- **Gewährleistung und Haftung** (Quelle: [[01_04.fm
    (swlegal.com)]{.underline}](https://www.swlegal.com/media/filer_public/69/1b/691bd572-74ff-4257-a370-101f986bb15b/140801_roland-mathys_it-outsourcing-vertrag.pdf))

- Beim IT-Outsourcing treten überwiegend mittelbare Vermögensschäden
    (z.B. als Folge von Betriebsunterbrüchen oder in Form entgangenen
    Gewinns) auf, deren Nachweis und Quantifizierung naturgemäss schwer
    fällt und für welche die Haftung meist ausgeschlossen oder beschränkt
    wird.

- Deshalb werden in Outsourcing-Verträgen meist alternative Formen der
    geldwerten Ersatzleistung vorgesehen, wobei **zwei
    Erscheinungsformen** im Vordergrund stehen:

- Zunächst kann für den Fall der Nichterreichung von Service Levels eine
    **Konventionalstrafe** im Sinne von Art. 160 ff. OR vereinbart werden.
    Die Abrede einer Konventionalstrafe hat für den Outsourcing-Bezüger
    den Vorteil, dass kein konkret entstandener Schaden nachgewiesen
    werden muss. Aus Sicht des Providers erscheint eine Konventionalstrafe
    aber häufig als einseitig und undifferenziert.

- Stattdessen können anstelle von Konventionalstrafen
    **Bonus-Malus-Systeme** eingesetzt werden, bei denen nach dem Grad der
    Zielerreichung abgestufte Gutschriften bzw. Belastungen ausgelöst und
    meist über die Vergütung abgerechnet werden.

= Wichtige Regelungspunkte in einem Outsourcing-Vertrag

- **Vertragsdauer und Beendigung**

- Ordentliche- oder ausserordentliche Kündigung, Folgen der
    Vertragsauflösung (z.B. Backsourcing)

- **Weitere Bestimmungen**

- Anwendbares Recht und Gerichtsstand

- Rechtsnachfolge, Formerfordernisse bei Anpassungen und Unterschriften

= IT-Verträge (Mängelrechte)

Bei Mängeln ist jeweils darauf zu achten, welche rechtlichen Grundlagen
am ehesten zur Anwendung kommen, z.B.:

- Bei Mängeln und Verzug bei kaufvertraglichen Eigenschaften s. Art.
    97ff. OR und die besonderen Bestimmungen zum Kaufvertrag insb. Art.
    197ff. OR (Wandelung, Minderung oder Ersatzlieferung)

- Bei Mängeln und Verzug bei werkvertraglichen Eigenschaften s. Art.
    97ff. OR und die besonderen Bestimmungen zum Werkvertrag Art. 363ff.
    OR (Wandelung, Minderung oder Nachbesserung)

- Bei Mängeln und Verzug bei auftragsrechtlichen Eigenschaften s. Art.
    97ff. OR und die besonderen Bestimmungen zum Auftrag Art. 394ff. OR
    (Schadenersatz)

= Weiterführende Links

- Gewährleistung und Haftung aus IT-Verträgen:
    [Straub-Gewaehrleistung-und-Haftung-aus-ITVertraegen-Bern-2009
    (1).pdf]{.underline}

- IT-Verträge:
    [Straub-Kostenueberschreitungen-in-IT-Vertraegen-Bern-2007.pdf]{.underline}

- Cloud Computing -- Checkliste zum vertraglichen Regelungsbedarf:
    [Straub-Checkliste-CloudComputing-jusletter-14.07.2014-DE.pdf]{.underline}

- IT-Outsourcing-Vertrag: [[01_04.fm
    (swlegal.com)]{.underline}](https://www.swlegal.com/media/filer_public/69/1b/691bd572-74ff-4257-a370-101f986bb15b/140801_roland-mathys_it-outsourcing-vertrag.pdf)

- Diverse Musterverträge: [[Nutzung von
    Cloud](https://digital.sav-fsa.ch/digitale-kanzlei-nutzung-von-clouddiensten)-[Diensten](https://digital.sav-fsa.ch/digitale-kanzlei-nutzung-von-clouddiensten) -
    [Digitalisierung](https://digital.sav-fsa.ch/digitale-kanzlei-nutzung-von-clouddiensten) -
    [SAV
    (sav](https://digital.sav-fsa.ch/digitale-kanzlei-nutzung-von-clouddiensten)-[fsa.ch)](https://digital.sav-fsa.ch/digitale-kanzlei-nutzung-von-clouddiensten)]{.underline}

- Unter anderem eine Liste von Cloudanbietern und eine
    Musterrahmenvertrag zu Cloud-Services (mit und ohne Auslandsbezug)

- SAV-Wegleitung für IT-Outsourcing und Cloud-Computing:
    [[SAV-Wegleitung_für_IT-]{.underline}](https://digital.sav-fsa.ch/documents/1060627/1169162/SAV-Wegleitung_f%C3%BCr_IT-Outsourcing_und_Cloud-Computing.pdf)

[[Outsourcing_und_Cloud](https://digital.sav-fsa.ch/documents/1060627/1169162/SAV-Wegleitung_f%C3%BCr_IT-Outsourcing_und_Cloud-Computing.pdf)-[Computing.pdf
(sav](https://digital.sav-fsa.ch/documents/1060627/1169162/SAV-Wegleitung_f%C3%BCr_IT-Outsourcing_und_Cloud-Computing.pdf)-[fsa.ch)](https://digital.sav-fsa.ch/documents/1060627/1169162/SAV-Wegleitung_f%C3%BCr_IT-Outsourcing_und_Cloud-Computing.pdf)]{.underline}
