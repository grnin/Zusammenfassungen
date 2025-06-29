// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Jannis Tschan", "Matteo Gmür"),
  fach: "TeGesch",
  fach-long: [Technikgeschichte und Technikfolgen-\ abschätzung],
  semester: "FS25",
  language: "de",
  tableofcontents: (enabled: true, depth: 3, columns: 2),
)

// Disable justification ("Blocksatz") inside tables
#show table: set par(justify: false)

= Aufbau Quellenkritik
Eine Quellenkritik besteht aus drei Teilen. Die _Erschliessung_ und _Analyse_ können mit den untenstehenden Fragen
beantwortet werden, bei der _Interpretation_ soll frei geschrieben werden. Dazu können die Hilfestellungen aus der
Aufgabenstellung verwendet werden. Es müssen nicht alle diese Fragen beantwortet werden, nur die passenden.

#{
  set par(justify: false)
  [
    == Erschliessung
    #columns(2)[
      *Um was für eine Quelle handelt es sich?*\
      #hinweis[Text, Bild, Ding... etc.]

      *Wie lässt sich die Quelle näher bestimmen?*\
      #hinweis[Artikel, Kommentar, Brief, Tagebuch, Erzählung ...]

      *Was sind die Merkmale der Quelle?*\
      #hinweis[Grösse, Zustand, Aussehen...]

      *Handelt es sich um ein Original, Kopie oder Fälschung?*\
      #hinweis[z.B. Teilkopie von Zeitschrift mit Titelblatt, Verzeichnis und Artikel]

      *Wann und wo ist die Quelle entstanden?*\
      #hinweis[z.B. Verlag XY in Zürich im Juni 1989]

      #colbreak()

      *Was weiss man über die Überlieferungsgeschichte?*\
      #hinweis[z.B. Fundorte- und Umstände, Aufbewahrung und Archivierung, spätere Veränderungen & Ergänzungen bei neueren Ausgaben]

      *Wer gilt als Produzent der Quelle? Welche weiteren Personen waren in der Produktion involviert?*\
      #hinweis[z.B. Autor/Herausgeberfirma, Personen im Impressum. Evtl. Autor näher beschreiben. Achtung: Möglicher Bias!]

      *An wen richtete sich die Quelle und was war ihr Verwendungszweck?*\
      #hinweis[z.B. Informieren von Hardware-Enthusiasten]
    ]

    #v(1em)
    == Analyse
    #columns(2)[
      *Was ist das Thema der Quelle?*\
      #hinweis[Kurze Zusammenfassung des Texts aufschreiben]

      *Wie ist sie aufgebaut?*\
      #hinweis[Inhalt des Textes in verschiedene Teile gliedern und diese Teile benennen]

      *Was ist die Bedeutung einzelner Elemente und in welchem Verhältnis stehen sie zueinander?*\
      #hinweis[Zitate aus dem Text verwenden mit Seitenangabe]

      *Gibt es Mehrdeutigkeiten und Leerstellen in der Quelle?*\
      #hinweis[Widerspricht sich die Quelle oder lässt sie andere Ansichten weg?]

      *Gibt es relevante Schlüsselbegriffe, Metaphern?*\
      #hinweis[z.B. "ehrliche Kunden" beim Migros-Artikel]

      *Wer spricht mit welchen Motiven und Wertungen?*\
      #hinweis[Entweder der Autor selbst oder andere Personen. Beweggründe des Autors erklären]

      *Gibt es explizite oder implizite Bezüge auf andere Texte oder Bilder?*\
      #hinweis[z.B. Erwähnung eines Zeitungsartikel oder Zitat einer Quelle]

      *Gibt es Anleitungen zum Gebrauch in der Quelle selbst?*\
      #hinweis[z.B. Vorwort]

      #colbreak()

      *In welchem gesellschaftlichen/institutionellem Umfeld entstand die Quelle?*\
      #hinweis[Autor aus Arbeitermilieu oder Akademiker?]

      *Was waren die Anschlussmöglichkeiten der Quelle?*\
      #hinweis[Weitere Texte, mit denen sich das Thema vertiefen lässt]

      *Klinkte sie sich in eine Zeitgenössische Diskussion ein?*\
      #hinweis[Politische und Soziale Umstände zum Zeitpunkt des Verfassens der Quelle beachten.]

      *Lässt sie sich in eine Serie ähnlicher Quellen einordnen?*\
      #hinweis[z.B. Bücherreihe, monatlich erscheinenden Rubrik, Briefwechsel]

      *Wie wirkte die Quelle in ihrer Entstehungszeit und später?*\
      #hinweis[Hatte der Text eine Auswirkung auf seine Leser?]

      *Wie wurde die Quelle verbreitet, ihre Nutzung beschränkt?*\
      #hinweis[z.B. Preis, eventuelle Zensur]
    ]
  ]
}

#v(1em)
== Interpretation
Freier Text, in welchem Zusammenhänge, welche bereits in der Analyse angeschnitten wurden, verfeinert werden.
Meistens gibt es Hinweise in der Aufgabenstellung, diese stellen aber nur das absolute Minimum dar.
Es sollte also mehr Text verfasst werden. Interpretationen mit _Textzitaten_ untermauern.

#pagebreak()


= Was ist Technikgeschichte?
#v(-1.5em)
#quote(attribution: [David Gugerli, Historisches Lexikon der Schweiz])[
  Technikgeschichte untersucht _Angebote technischer Entwicklungen_, welche in bestimmten historischen Kontexten
  entstanden sind und von sozialen Gruppen oder ganzen Gesellschaften als _Möglichkeit sozialen Wandels_ wahrgenommen,
  ausgehandelt und schliesslich genutzt oder vergessen worden sind. Die Problemstellungen der Technikgeschichte
  entwickeln sich aus dem je _gegenwärtigen Orientierungsbedarf einer Gesellschaft_, ihre Verfahren entsprechen
  den aktuellen geschichtswissenschaftlichen Methoden.
]

Gesellschaft und Technik sind nicht voneinander zu trennen. Aussagen über Technik werden von einem bestimmten
Ort aus gemacht, sind mit Interessen der Sprechenden verknüpft. Sie stehen in Konkurrenz zueinander und sind Teil
eines Aushandlungsprozesses, an dessen Ende das für eine gewisse Zeit Akzeptable steht
#hinweis[(nicht das Richtige, Wahre, Beste, Billigste oder Effizienteste)]. Der Konsens dafür muss erarbeitet werden
und ist immer brüchig. Die Konsensbildung wird durch Pfadabhängigkeiten und Anschlussfähigkeiten eingeschränkt.

#grid(
  columns: (0.8fr, 1fr),
  gutter: 1em,
  align: horizon,
  [
    == Bild vom Potsdamer Platz 1919
    Auf dem Bild finden sich alle Arten von Menschen in Bewegung: Angestellte, Geschäftsleute, Arbeitslose, Paare,
    Alte, Junge, Kinder und Flaneure. Menschen mit unterschiedlichen Zielen und einem minimalen, gemeinsamen Interesse,
    dass der Verkehr nicht zum Erliegen kommt. Die Menschen sind inmitten der Technik: Fortbewegungsmittel sind Fahrräder,
    Droschken, Automobile, Pferdeomnibusse, aber keine Strassenbahnen und Busse, da diese Fahrer im Streik sind.

    Balance zwischen individueller Koordinationsleistung #hinweis[(jede Person bahnt ihren eigenen Weg)],
    behördlicher Kontrollanspruch #hinweis[(Verkehrsflusskontrolle)] und
    soziotechnische Organisation #hinweis[(Hierarchie zwischen Schienen, Strassen und Wegen)].
  ],
  figure(
    caption: [Willy Römer, Verkehrsstreik. Blick auf den\ Potsdamer Platz, 01.07.1919],
    image("img/tg/Potsdamer-Platz.png"),
  ),
)


Die Lösung dieses Chaos ist die 1924 eingeführte Verkehrsampel. Ein Polizist steuert diese von oben im Turm manuell.\
Gesellschaftliche Regelung der Technik entsteht aus gesellschaftlichen Krisenmomenten: Die Ampel war wegen starkem
Anstieg an Autos nötig. Einschreibung von gesetzlichen Normen durch Technik soll Ordnung schaffen.

== Die Oligarchen-Intellektuellen im Silicon Valley
#hinweis[Text "Die Oligarchen-Intellektuellen im Silicon Valley" von Evgeny Morozov aus der FAS, 11.04.2025]

+ *Was wissen wir über den Autor?*\
  Publizist #hinweis[(Analytiker des Zeitgeschehens, kommentiert parteiisch)] über technisch-soziale Auswirkungen.
  Internetkritiker, Netz sollte ein machtfreier Raum sein.
+ *Wo und wann wurde der Text publiziert? Wer ist die Leserschaft des Textes?*\
  Sonntagsausgabe der Frankfurter Allgemeine Zeitung (FAZ), die FAS, welche eher längere, reflektierende Artikel enthält.
  Leser sind typischerweise gut gebildet und an Gesellschaft & Politik interessiert.
+ *Um welche Textsorte handelt es sich?*\
  Prolemisch, spekulativ, reisserisch. Schwieriger Text mit viel Namedropping

*Ausgangspunkt:* Tech-Mogule als neue Intellektuelle mit politischer Macht. Technologische Visionen werden zu
politischen Agenden. Platformbesitz #hinweis[(Facebook, Twitter)] als neue Form gesellschaftlicher Steuerung.

Tech-Eliten werden vom Spezialisten zum "Philosophenkönig" und haben eine Kombination aus ökonomischer Macht,
intellektueller Deutungshoheit und Medienkontrolle inne. Öffentliche Debatten werden auf private Plattformen verlagert.
Das Silicon Valley hatte seine Ursprünge in Gegenkultur #hinweis[(Hippie-Bewegung)] und Ingenieursidealismus.
Dadurch stieg eine "technische Intelligenzija" mit kritischem Potenzial auf, sich zu einem oligarchischem Machtblock
mit autoritären Tendenzen zu transformieren.

Wokeness sollte nicht als politisches Werkzeug verwendet werden. Interner Machtkonflikt zwischen progressiven Angestellten
und konservativen Bossen. Diversität und soziale Gerechtigkeit werden strategisch dämonisiert im Versuch,
die Tech-Arbeiter zu disziplinieren und politisch zu kontrollieren.

*Gegenargumente zur Morozov-These:* Zu verallgemeinert? Nicht alle Tech-Gründer sind ideologische Akteure.
Text neigt zu Sozialdeterminismus? #hinweis[(Mensch wird fast ausschliesslich durch soziale & kulturelle Einflüsse gelenkt)].
Existenz pluraler Gegenöffentlichkeit #hinweis[(alternative Plattformen, Bot-Farmen)] wird unterschätzt?
Ist Morozovs Stil Analyse oder Polemik?

=== Verhältnis von Technik und Politik
*Nach Morozov:* Technik ist nicht neutral, sondern hochgradig ideologisch aufgeladen.
Technologisches Zukunftsentwürfe ersetzen politische Debatten.
Politik wird durch Investitionen, Medienmacht und Propaganda ersetzt.

Treffen Technik und Politik aufeinander wird entweder _neutrale Technik politisiert_ #hinweis[(Ampel wird zum politischen Streitpunkt)]
oder _intressengeleitete Politik wird technisiert, um die Möglichkeiten zu steigern_.
Politische Ziele werden dadurch in Technologie übersetzt, um eine Technokratie oder Überwachungsstaat zu kreieren.
Gegen beide Formen kann aber protestiert werden.


= Energetische Weltbilder
Energie ist die Fähigkeit eines Systems, Arbeit zu leisten, wobei die Arbeit unterschiedliche Formen annehmen kann:
Primärenergie #hinweis[(fossile Energieträger wie Kohle, Erdöl, Erdgas, erneuerbare Energieträger wie Wasserkraft, Holz,
  Biogas, Wind, Sonnenenergie, Erdwärme sowie Kernenergie wie Uran)],
Sekundärenergieträger #hinweis[(Koks, Benzin, Heizöl, Strom, Stadtgas...)]
und Nutzenergie #hinweis[(Wärme, Licht, Kraft, chemisch gebundene Energie)].

Die Geschichte der Energie kann auf unterschiedliche Arten erzählt werden:
- Als _Fortschritts und Innovationsgeschichte_ mit Chronologie von Energiearten und Technologien ihrer Produktion
  #hinweis[(Biomasse, fossile Brennstoffe wie Kohle, Erdgas oder Öl)]
- Als Geschichte eines steigenden nationalen und globalen _Energieverbrauchs_
- Als Zukunftsszenario einer kommenden und notwendigen _grünen Energietransformation_ angesichts des Klimawandels

Diese funktionieren nur mit historischem Kontext, auf welchem dann Entscheidungen für die Zukunft getroffen werden.
Diese Geschichten müssen aber nicht immer übereinstimmen.

== Energieutopien
Die Elektrifizierung galt als sozialistisches Zukunftsprojekt. Lenins Leitidee:
$ "Kommunismus" = "Sovietmacht" + "Elektrifizierung" $
Der GOELRO-Plan war das erste zentrale Energieprogramm der Sowjetunion mit dem Ziel ganz Russland zu elektrifizieren
als Symbol für Fortschritt und sozialistische Modernisierung. Marx & Engels waren ebenfalls begeistert von
technischen Entwicklungen, v.a. der Elektrizität. Sie galt als Schlüssel zur Herrschaft des Menschen über die Natur.
Technik wurde zum Mittel, um eine neue, sozialistische Gesellschaft zu erhalten.

Die Wasserkraft diente unter "weisse Kohle" als Fortschrittsmetapher. Die Sowjetunion inszenierte sich als
_technischer Sieger über die Natur_ -- "Krieg mit dem Fluss", die Technik als Dompteur wilder Naturgewalten.
Doch die Zaristische Wirtschaft scheiterte an der Nutzung grosser Flüsse.

Das Dnepr-Kraftwerk bei Saporschje (1932) war das damals grösste Flusskraftwerk Europas und galt unter Stalin
als Symbol für den "Sozialismus in Aktion". Technik galt als Instrument der Geschichtsgestaltung:
Bewässerung, Industrie, Landwirtschaft, Landschaftsumbau durch Stauseen & Kanäle und das Verschwinden alter Symbole
#hinweis[(Kirchen, Dörfer)] galt als Zeichen des Fortschritts. Propagandaposter stellen die Nation und einzelne Menschen
anstatt das Volk in den Vordergrund.

== Technik als Wunschmaschine
Technik ist immer auch eine Wunschmaschine, die Fiktionen produziert und zementiert
#hinweis[(Erfinder haben Ideen, Wünsche, Vorstellungen der Zukunft)]. Die richtige Technik kann so Probleme von
Vergangenheit & Gegenwart überwinden und eine bessere Zukunft schaffen -- z.B. eine unerschöpfliche Energieversorgung
in einer "neuen Gesellschaft". Energie bringt stets auch neue Wünsche und Lebensbilder hervor.
Diese verkörpern die Sehnsüchte und Selbstverständlichkeiten einer Epoche und stellen den materiellen Ausdruck
einer kulturellen Epoche dar.

Geschichte ist nicht nur das, was "wirklich" ereignete und sich realisieren liess, sondern auch das, was nicht geschah
oder umsetzen liess und deswegen nur in der Vorstellung als Traum oder Alptraum existierte.
z.B. Idee durch Technikumgestaltung der Nation in der Sowjetunion.

== Atlantropa
Atlantropa war die Utopie eines gemeinsamen Subkontinents:
$ "Europa" + "Afrika" = "Atlantropa" $
Entwickelt wurde der Plan vom Münchner Architekt Herman Sörgel ab 1927. Es war eine Antwort auf die Krisen nach
dem ersten Weltkrieg: Arbeitslosigkeit, Ressourcenknappheit und Kriegsgefahr.

Die Ziele des Projekts waren:
- Senkung des Mittelmeers bis zu 200m durch Staudämme
- Neulandgewinnung auf den abgesenkten Mittelmeer #hinweis[(ca. 660'000 km#super[2], grösser als Frankreich & BeNeLux)]
- Energieproduktion durch Wasserkraft #hinweis[(z.B. am Gibraltar-Staudamm 50'00 MW)]
- Bewässerung Afrikas #hinweis[(Sahara & Kongo-Becken)]

#grid(
  columns: (1.1fr, 1fr),
  gutter: 1em,
  align: bottom,
  [
    *Wichtige Bauwerke*
    - Gibraltar-Staudamm #hinweis[(14.2km lang, 300m hoch, 2.5km Fundamentbreite)]
    - Sizilien-Tunesien-Damm zur Verbindung der Kontinente
    - Atlantropa-Turm #hinweis[(400m hohes Symbolbauwerk bei Gibraltar)]
    - Neue Häfen, Städte & Verkehrssysteme

    *Stadtplanung auf dem Neuland*
    - Kooperation mit Stararchitekten
    - Neues Genua, Unterhafen Port Said, Binnenstadt Venedig

    Atlantropa hatte den politischen Anspruch, ein friedenstiftendes Projekt zu sein. Der technische Fortschritt sollte
    die _politische Einheit Europas und Afrikas_ aufzeigen. Jedoch hatte es einige Widersprüche: Zwar visionär, war es
    aber eurozentrisch und kolonial geprägt. Afrika sollte "kultiviert" werden, ohne Mitsprache der afrikanischen Bevölkerung.

    Unterstützt wurde das Projekt durch Prominente #hinweis[(z.B. Albert Einstein, John Knittel)], wurde aber von den
    Nationalsozialisten abgelehnt #hinweis[(u.a. 1936 Propagandafilm "Ein Meer versinkt")]. In der Nachkriegszeit lebte
    das Projekt kurz wieder auf, wurde aber durch Atomenergie verdrängt.
  ],
  figure(caption: [Übersicht über Altlantropa-Pläne], image("img/tg/Atlantropa.png")),
)

=== Was bleibt von Atlantropa?
Grössenwahnsinninges, aber faszinierendes Megaprojekt. Wurde über Jahrzehnte intensiv ausgearbeitet durch Filme,
Zeitschriften, Ausstellungen. Heute ist es ein Symbol für die Technikgläubigkeit der Moderne und ein Beispiel für
geo-ingenieurstechnische Utopien und grenzenlose Planungsideen. Die Technik wurde als politisches Mittel eingesetzt.
Ein anderes Europa ist möglich!

#pagebreak()


= Als die Kassen laufen lernten
== Quellenkritik-Grundlagen
In der Geschichtswissenschaft wird immer mit Quellen gearbeitet. Die _Quellenkritik_ analysiert die formalen
#hinweis[(äusseren und stilistischen)] und inneren Merkmale einer Quelle, die _Quelleninterpretation_ ordnet sie dann
in den historischen Kontext ein und wertet sie im Sinne der Fragestellung aus.

#table(
  columns: (0.8fr, 1fr),
  table.header([Fragestellung], [Quellen]),
  [
    Beziehungen von technischem und sozialem Wandel und deren Probleme und Problematisierungen.
  ],
  [
    Texte und Gegenstände, aus denen Kenntnis der Vergangenheit gewonnen werden kann.
    #hinweis[(Beispiele: Gerichtsakten, Fotoalben, Strassenschilder, Telefonbücher, Nahrungsmittel...)]
  ],
)

Es wird bei der Recherche weder deduktiv #hinweis[(zuerst Fragestellung, dann Auswertung)],
noch induktiv #hinweis[(zuerst Quellen, dann Fragestellung)] vorgegangen. Stattdessen findet eine Parallelität statt:
Ständiges Wechselspiel zwischen Fragestellung und Quellenkritik/-analyse.
Es braucht Fragestellungen, um mit Quellenbeständen umgehen zu können #hinweis[(nicht Frage auf eine Quelle beschränken)]
und es braucht Kenntnis über die Quellenbestände, um Fragen formulieren zu können #hinweis[(Quellen kritisch hinterfragen)].

== Quellenkritik: Die Kunden tippen weiterhin selber
#hinweis[Text "Die Kunden tippen weiterhin selber. Eine Stellungnahme des Migros-Genossenschafts-Bundes",
  in: Selbstbedienung und Supermarkt. Zeitschrift des Instituts für Selbstbedienung, Nr. 1, Januar 1967, S. 9]

#definition[
  *Forschungsfrage:* Was wollte die Migros durch die Einführung von Selbsttipp-Kassen erreichen und welche Probleme
  traten beim Experiment in Zürich Wollishofen auf?
]
*Wer spricht mit welchen Motiven und Wertungen?*\
Der Migros Genossenschaftsbund #hinweis[(Management des Gesamtkonzerns, nicht geschrieben von Genossenschaftsbunds Zürich)]
wollte das Experiment der selbsttippenden Kunden weiterführen. Das Konzept der Selbstbedienung hatte negative Effekte
#hinweis[(Wachstumsprobleme, das Management passte nicht mehr zu der Grösse)]. Die Vorteile der Selbstbedienung wurden
durch Stau an der Kasse zunichte gemacht.

*Was ist das Thema der Quelle?*\
Stellungnahme des Migros-Genossenschafts-Bunds: Experiment geriet unter öffentlichen Druck (1966);
Presse vermeldete Auflösung; Verteidigung des Experiments und Verkündung der Einführung von Kontrollen;
Von der Presse kritisierters international verfolgtes Projekt; Ruf der Migros als Rationalisierungsweltmeister im
Detailhandel steht auf dem Spiel

*Wie ist die Quelle aufgebaut?*\
Problembeschreibung; Beschreibung des Tests und der eingeführten Kontrollen aus Sicht der MGB;
Betonung der Vorteile von selbsttippenden Kunden; Diskussion des Problems "Ladendiebstahl";
Einführung von Kontrollen beim Experiment; Abschlussformel mit Historisierung des Experiments
#hinweis[(Kassen sind entscheidend für den Erfolg des "Supermarkt"-Konzepts, Selbstbedienung wird auch erfolgreich)]

*Bedeutung und Semantik:* Managementdiskurs, Rationalisierung, Statistiken; moralische #hinweis[("ehrliche Kunden")]
und betriebswirtschaftliche Aussagen zusammen.

Die Kasse gilt als Scharnier zwischen Massenproduktion und Massenkonsum: rasch & effizient möglichst reibungslose
Transaktion von Waren und Geld im Massenformat. Doch die Staus an der Kasse stellten ein Problem der
innerbetrieblichen Rationalisierung dar. Die Migros unternahm verschiedene Ansätze, um eine Lösung zu finden:

- _Einkaufsverhalten ändern (1959):_ Es gab sogenannte "Gratistage", an denen der Kassenzettel bis zu
  15 Fr. in Bar auszahlte. War werbewirksam, erzielte aber wenige Einsparungen
- _Schnellkassen, Blindtippen, Arbeitsteilung (1953ff.):_ Die Kassen hatten nur Franken und 50 Rp. Tasten,
  Kassierer wurden im Tippen geschult und es gab 3 Personen pro Kasse: Auspacker, Kassierer, Einpacker. War wenig effektiv.
- _Mechanisierung des Wechselgelds (1960):_ Kasse gab Münzen automatisch aus. Wenig effizient.
- _Einführung des Fliessbandes (1957):_ Waren waren dadurch schon ausgepackt. Recht effektiv.
- _Einkaufsbetrag erhöhen:_ Die Kunden durch grössere Körbe und Parkplätze motivieren, mehr einzukaufen
- _Selbstbedienung an der Kasse durch den Kunden (1965):_ Siehe Experiment

*Geschichte des Selbstbedienungskassen-Experiments*
- Start des Experiments im Oktober 1965, keine Diebstahlkontrollen unter dem Motto "Vertrauen gegen Vertrauen".
  Standort Wollishofen wird gewählt wegen hohem Bevölkerungswachstum #hinweis[(jung, reich, wenig Zeit)]
- War organisatorischer Erfolg #hinweis[(200 statt 80 Kunden pro Stunde)], aber ökonomischer Verlust
  #hinweis[(Zu viel wurde nicht getippt)]
- Ende 1966 Presseberichte #hinweis[(u.a. Blick "Mini-Diebe killen nobles Experiment")], sei schlechte Idee,
  Migros habe falsches Kundenbild
- Migros Genossenschaftsbund wollte weitermachen, Migros Genossenschaft Zürich abbrechen.
  MGB setzt sich durch mit Einführung von Kontrollen
- 1969 Abbruch des Experiments wegen ca. 200'000 Fr. Verlust in der Filiale

*Zielpublikum*\
Quelle richtet sich an Management mit Entscheidungsmacht im Detailhandel. Es geht um Managementprobleme,
nicht um Kundenprobleme. Kunden im Text stehen im Mittelpunkt #hinweis[("an geräumigen Tischen ... viel Zeit")].
Experiment funktioniert nicht, Kunden sind aber nicht das Problem und nicht "kriminell" #hinweis[("ehrliche Kunden")].
Ehrlichkeit der Kunden steht im Mittelpunkt, obwohl sie für Fehlbeträge verantwortlich sind.

Migros setzt auf Rationalisierung und der Stau an der Kasse ist der letzte Punkt der Rationalisierungs-Strategie.
Entzieht sich noch dem Konzept der Selbstbedienung in Supermärkten. Internationale Mitbewerber beobachteten Experiment.
Kunden machen nicht mit und müssen für den Ruf trotzdem verteidigt werden. Spannungsverhältnis zwischen dem moralischen Anspruch
#hinweis[("Vertrauen gegen Vertrauen")] und dem betriebswirtschaftlichen Gedanken mit dem Zwang der Rationalisierung.
Migros muss das Experiment durchhalten, weil es die grosse Innovation der Stunde ist.

*Analyse*\
Die Kasse ist ein_ soziotechnisches System_: Um das Problem des Staus an der Kasse im Selbstbedienungskonzept
der Migros zu lösen, verbanden sich technischer Wandel #hinweis[(Registrierkasse anstatt Metallschachtel)],
organisatorischer Wandel #hinweis[(Selbstbedienung)] und Verhaltensanpassung #hinweis[(Arbeitskraft)].
Die Problem machten dieses soziotechnische Netzwerk sichtbar. Ebenfalls bringt der Artikel Technik und Geschlecht zusammen:
"Viele Hausfrauen haben es bei der Bedienung zu grosser Routine gebracht", Hausfrauen kaufen ein.

=== Geschichte der Migros
Die Migros wurde von Anfang an betriebswirtschaftlich geführt. Seit der Gründung 1925 wurden Lebensmittel durch
rationelle Organisation gesenkt #hinweis[(nur so viel Waren einkaufen, wie auch wieder verkauft werden können, zunächst keine Lagerräume)].
Andere Genossenschaften reagierten langsam, da ineffizient. Migros hatte geringe Fixkosten, da sie Produkte
zu Grosshandelspreisen kauften und die Ware mit raschem Umschlag zu tiefstmöglichsten Kosten und
bescheidener Gewinnmarge verkauften. Prinzip: _Geringe Marge, hoher Umsatz_.

Das Unternehmensmodell verlangte einen hohen Rationalisierungsdruck: Vorverpackte Waren und runde Preise.
Die Kritik am Konzept war die _"Amerikanisierung"_: Zu viel Business, die Kunden werden einfach abgefertigt,
man kann sich nicht mehr Zeit fürs Einkaufen nehmen.

1945 wurde das seit 1933 bestehende Filialverbot aufgehoben. Bis anhin durften keine neue Läden eröffnet
oder bestehende erweitert werden. Dadurch sollten die neuen Supermärkte keine bestehenden Genossenschaften verdrängen;
das Gesetz war leicht antisemitisch.

In den 1950ern herrsche Hochkonjunktur: Durchschnittlich 3% Wachstumsrate auf das Pro-Kopf-Einkommen,
die Reallöhne stiegen zwischen 1950 und 1960 um durchschnittlich 20%, steigende Nachfrage nach einer immer grösseren Vielfalt an Produkten.
Der Jahresumsatzwachstum der Migros stieg rasch: 1945: 85 Mio CHF, 1955: 426 Mio. CHF, 1961: >1 Mrd. CHF

Aufgrund Mitarbeitermangels für bediente Läden eröffnete die Migros immer mehr Selbstbedienungsläden:
Von 5 in 1948 zu 870 in 1956 #hinweis[(davon mehr als 50% in Städten)].
Selbstbedienung wurde als _Wachstumsperspektive_ gesehen. Die Läden wurden grösser, Migros erweiterte ihr Sortiment
von 5 Produkte in 1925 #hinweis[(nur Lebensmittel)] auf 550 in 1950 #hinweis[(auch viele nicht-Lebensmittel)].
Migros galt mit diesem Konzept als Vorreiter in Europa.


= Atomenergie und die gespaltene Gesellschaft
#v(-1.5em)
#quote(attribution: [Jakob Tanner, Geschichte der Schweiz im 20. Jahrhundert])[
  Die ausgehenden 1960er Jahre lassen sich auch als _gesellschaftliche Orientierungskrise_ begreifen, in der die
  vormalige strukturelle Stabilität des Institutionengefüges zusammen mit dem _Regelvertrauen_ abnahm. ...
  Gesellschaftsübergreifend zeigte sich eine Krise der Fortschrittsperspektive und des Planungsglaubens.
  Bürgerliche Reformer, linke Revolutionäre und wissenschaftliche Technokraten bekamen gleichermassen Probleme
  mit ihren früheren _Selbstgewissheiten_.
]

Aufgrund Krisen und anderen Instabilitäten vertraute die Bevölkerung in den 1970ern den staatlichen und
privaten Institutionen weniger. Der Glaube an unendliches Wirtschaftswachstum und an einfache Planung von
Grossprojekten nimmt ab. Verschiedene Gruppen mit verschiedenen Erwartungen #hinweis[(Konservative, Kommunisten, Technokraten etc.)]
werden in ihren "Glaubenssätzen" erschüttert, die Lage der Dinge wird nicht mehr verstanden.

*Globale Ereignisse der 1970er*
- _Ölkrisen (1973 & 1979):_ Energiekrisen und wirtschaftlicher Abschwung, Neubewertung von Energiepolitik
- _Ende des Bretton-Woods-Systems (1971):_ Flexibilisierung der Wechselkurse, volatilere & dynamischere Weltökonomie
- _Vietnamkrieg-Ende (1975):_ Kommunistische Machtübernahme
- _Militärputsche in Lateinamerika:_ Chile (1973), Argentinien (1976)
- _Entspannungspolitik:_ Helsinki-Abkommen (1975) #hinweis[(Zusammenarbeit Europäischer Staaten)],
  ABM-Vertrag (1972) #hinweis[(Begrenzung von Raketenabwehrsystemen in USA & Sowjetunion)]
- _Technologische Innovationen:_ Gründung von Apple (1976) & Microsoft (1975)

*Kritik & Zukunftsvisionen der kommenden Gesellschaft*\
Diese häufen sich in schwierigen Zeiten. Die 1970er generierten eine "Ordnungskrise",
"selbstverständliche Dinge" werden neu ausgehandelt.

- _Postindustrielle Gesellschaft (Daniel Bell):_ Übergang zur Dienstleistungsgesellschaft von Industriegesellschaft
- _Wachstumskritik (Club of Rome):_ Grenzen des Wachstums und Nachhaltigkeit, erste Klimawandelkritik
- _Feministische Gesellschaftskritik:_ Gleichberechtigung und Selbstbestimmung
- _Linker Marxismus und Kritische Theorie:_ Klassenkampf und kulturelle Befreiung
- _Neokonservative Gegenbewegung:_ Rückbesinnung auf traditionelle Werte #hinweis[(gegen Feminismus und Linke)]

*Umwelt- und Protestbewegungen in der Schweiz:* Umweltschutzartikel (1971) #hinweis[(Schutz der Umwelt in Verfassung)],
Frauenstimmrecht (1971), Anti-AKW-Bewegung: Kaiseraugst (1975), Gründung von Umweltorganisationen #hinweis[(SES 1977)]

== Das Versprechen der zivilen Atomkraftnutzung
Weg vom kriegerischen Einsatz, hin zu unbegrenzter, sauberer & billiger Energieversorgung. Technologischer Fortschritt
verspricht Modernität und Wohlstand. Atomkraft galt als _politisches Instrument für Frieden und Kooperation_
#hinweis[(Atoms for Peace)]. Fortschritt im Alltag durch "Kitchen of Tomorrow", Automatisierung und Entlastung.

In der Schweiz gab es in der Nachkriegszeit einen Wirtschaftsboom und damit einen Energiehunger.
Die Wasserkraft stiess an ihre Grenzen. 1959 wurde ein Atomgesetz zur zivilen Nutzung verabschiedet.
Erste AKWs 1969 in Betznau und 1972 in Mühleberg. Atomkraft regte die Erwartung nach billiger, sicherer und unabhängiger Energie.

== Anti-AKW-Proteste in Kaisersaugst (1975)
Die Standortwahl wurde durch die Schweizer Firma Motor-Columbus 1964 getroffen. Pläne für ein AKW in Kaisersaugst
wurden zuerst von der Bevölkerung begrüsst, eine Abstimmung für das 500 MW-AKW wurde 1966 angenommen.
Gekühlt würde es durch den Rhein. 1969 kamen durch einen Expertenbericht über mögliche Erwärmung des Rheins Umweltbedenken auf.
Vor allem die Basler flussabwärts wehrten sich. 1970 wurde das _Aktionskommitee gegen das AKW Kaiseraugst_ gegründet,
1971 erliess der Bund ein Verbot zur AKW-Kühlung mit Flusswasser. 1972 wurde das Konsortium Kernkraftwerk Kaiseraugst AG gegründet.

Die Protestursachen waren vielschichtig und kamen aus verschiedensten politischen Lagern. Umweltschützer waren zuerst
Pro-Atom, da es für die Umwelt weniger schädlich als Gas oder Kohle sei. Dies kippte aber allmählich in den 1970ern
und Sorgen über die Risiken für Mensch, Natur und Wasser kamen auf. Andere Gruppen hegten ein Misstrauen in
Technik & Staat #hinweis[(v.a. den Bund)]. Es wurde demokratische Mitsprache gefordert und internationale Strahlensorgen
machten sich breit.

=== Besetzung des Bauplatzes
Am 18. April 1975 begann die Besetzung des Bauplatzes mit über 15'000 Teilnehmern, organisiert durch die
Gewaltfreie Aktion Kaiseraugst (GAK). Die Aktion verlief friedlich, war gut organisiert mit Infrastruktur
#hinweis[(Küche, Sanität, Plenum)] und genoss breite gesellschaftliche Unterstützung. Der Kanton Aargau verzichtete auf Räumung.

Es gab verschiedene Gruppen im Protest: Die GAK stellte die lokale Initiative, während die NWA
#hinweis[("Nie wieder Atomkraft", damals noch "Nordwestschweizer Aktionskomitee gegen das Atomkraftwerk Kaiseraugst" NAK)]
ein regionales Aktionskomitee bot. Unterstützung erhielten sie durch Vereine und Parteien wie die Schweizerische Energie-Stiftung (SES),
WWF, die SP und der Mitte-Links-Partei Landesring der Unabhängigen (LdU). Auch lose Subkulturen aus dem linken und rechten Flügel,
sowohl jung als alt, unterstützten die Aktion. _Sie alle hatten ein gemeinsames Ziel, aber auch Konflikte._

Der Alltag im Camp war ein Experimentierfeld für Formen des Zusammenlebens und geprägt durch
_basisdemokratische Organisation_ #hinweis[(alle Personen durften 1x täglich vortragen)].
Die Versorgung lief über Spenden. Das Camp hatten ein breites Kulturprogramm mit Theater, Musik und Vorträge.
Allerdings gab es auch interne Konflikte durch Alkohol, Hierarchien und die Frage, ob mit Gewalt vorgegangen werden durfte.

==== Reaktion von Politik & Wirtschaft
Der AKW-Betreiber KWK AG hatte diverse PR-Kampagnen und Gutachten erstellt, um zu zeigen, dass man auch auf
Notsituationen gut vorbereitet sei. Die Medien wirkten polarisierend mit dafür und dagegen.
Die Polizei war deeskalierend unterwegs, wodurch Kaiseraugst zum Grossereignis wurde.
Erst bei anderen Protesten zeigten sie Härte. In einem Brief forderte Bundespräsident Graber, dass andere Kantone den
Kanton Aargau mit Polizeikräften unterstützen sollten.

==== Projektabbruch
Nach 11 Wochen wurde am 14. Juni 1975 das Gelände _freiwillig geräumt_, da der Bundesrat einen vorläufigen Baustopp beschloss.
Danach entstand ein Rechtsstreit und neue Pläne wurden ausgearbeitet. Die Tschernobyl-Katastrophe 1986 regte erneut Widerstand.
1988 beschloss der Bundesrat denn Abbruch, die KWK AG _verzichtete auf den Bau_ und erhielt dafür 350 Mio. Fr. Entschädigung.
Zum Jahresende wurde die Planung offiziell eingestellt. Durch zivilgesellschaftlichen Widerstand konnte eine pragmatische Lösungssuche gestartet werden.

=== Energietechnik & sozialer Protest
Technikakzeptanz in der Gesellschaft ist verhandelbar. Der Protest diente als Lernprozess in der Gesellschaft, dass als
Gruppierung gegen solche Projekte vorgegangen werden kann. Die Machtverhältnisse innerhalb und ausserhalb der Gruppe wurden
in der Technikplanung sicher. Die diskursive Macht wurde in Gegenöffentlichkeiten sichtbar: Es gab mehrere Erzählungen,
vor und nach dem Ereignis. Heute sind Grossprojekte ohne gesellschaftliche Technikakzeptanz nicht mehr vorstellbar
und Teil demokratischer Entscheidungsfindung.

== Quellenkritik: Einige Erinnerungen
#hinweis[Florianne Koechlin: Einige Erinnerungen, in: Ungekühlt! Ansichten zur Besetzung von Kaiseraugst.
  Begleitbroschüre zur Ausstellung, 13. September bis 17. Oktober 2001, Annex-Gebäude Hyperwerk, Basel]
#definition[
  *Forschungsfrage*: Wie verhielt sich das Risiko der Protestbewegung, das Florianne Koechlin in ihrer Erinnerung beschreibt,
  zum Risiko der Atomkraft?
]
*Um was für eine Quelle handelt es sich? Wie lässt sich die Quelle näher bestimmen?*\
Text in einer Begleitbroschüre zu einer Ausstellung, Erzählung, Egodokument

*Wann und wo ist die Quelle entstanden?*\
In 2001, 26 Jahre nach der Besetzung

*Wer gilt als Produzent der Quelle? Welche weiteren Personen waren in der Produktion involviert?*\
Florianne Köchlin, eine der Anführerin des Protests in der "Kerngruppe", Biologin, Gentechnikkritikerin

*An wen richtete sich die Quelle und was war ihr Verwendungszweck?*\
Interessierte an der Besetzung. Begleitmaterial zu der dazugehörigen Ausstellung

*Was ist das Thema der Quelle?*\
In der Ich-Perspektive wird über das Campleben bei der Besetzung des AKW Kaisersaugst erzählt.
Es ist ein kritischer Rückblick auf die Besetzung einer Teilnehmerin der "Kerngruppe" der ersten Stunde 26 Jahre später.
Die Form der Erzählung hat dabei verschiedene Vor- und Nachteile

#table(
  columns: (1fr, 1fr),
  table.header([Vorteile], [Nachteile]),
  [
    - Eigene Gefühlslage wird dargelegt
    - Leser fühlt sich näher am Geschehen
    - Reflexion auf das Ereignis, Einordnung
    - Bestimmte Perspektive nähergebracht
  ],
  [
    - Eventuell falsche Erinnerungen
    - Vorhandene Wertung
    - Nur eine Sichtweise
  ],
)

*Gibt es Mehrdeutigkeiten und Leerstellen in der Quelle?*\
Es wird nur über das Lagerleben berichtet, das AKW selbst sowie Daten dazu bleiben im Hintergrund.
Der Fokus liegt weniger auf das Ziel des Baustopps selbst, als auf der Erhaltung des Lagerlebens.

*Gibt es relevante Schlüsselbegriffe, Metaphern?*\
Grösse & Dynamik des Protest, ein gewisses Tempo wird vermittelt. _"Wir greifen in die Geschichte ein"_.
Aus dem Protest wurde eine eigene soziale Bewegung, welche von der Kerngruppe nicht mehr kontrolliert werden konnte.
Sie wurden von den Leuten überrannt, vieles ist eingetreten, mit dem nicht gerechnet wurde.
Es wird ein kritischer Rückblick auf die Selbstdynamisierung geworfen, die als _überraschend
und überfordernd_ wahrgenommen wurde.

*Interpretation*\
Mit der Besetzung gingen sie ein Risiko ein, von der Polizei und der Armee mit Gewalt vertrieben zu werden.
Die Besetzung wird _als Risiko, nicht als Revolution_ beschrieben. Es musste eine ständige Abwägung getroffen werden:
Bleiben, um den Druck auf den Betreiber zu erhöhen, aber eine Räumung und Sympathieverlust riskieren oder
gehen und riskieren, als reiner Publicity-Stunt gesehen zu werden. Es müssen mit dieser Grösse organisatorische Strukturen
eingerichtet werden. Durch die vielen Gruppierungen entstehen auch breitere Protesthorizonte: Erfahrungen von Personen,
welche von Vietnam-Protesten kamen, durch den AKW-Protest gegen den Kapitalismus im allgemeinen protestieren.

Durch das Campleben konnten _neue Regeln des Miteinanders_ ausprobiert werden, miteinander sprechen in dieser
allgemeinen Orientierungskrise der 1970er. Das führt auch zu Disputen und Krisen; Protest ist anstrengend.
Dadurch kann aber wieder neues Vertrauen, ein neues Regelsystem aufbauen. Reflektierend wird aber auch aus
diesem Protest viel gelernt: Dass _als Masse etwas verändert werden kann_, man in die Geschichte eingehen kann;
neue Orientierungssicherheit "Wir können in die Geschichte eingreifen". Grosstechnische Projekte können durch
gesellschaftlichen Protest verhindert werden.


= Die Eisenbahn der Zukunft
Die ersten Eisenbahnlinien Mitte des 19. Jahrhunderts waren föderalistisch aufgelegt, jeder Kanton baute sein
eigenes Netz mit unterschiedlicher Technik. Das limitierte die Anschlussmöglichkeiten im In- und Ausland.
1898 wurde eine Volksabstimmung über das Rückkaufsgesetz durchgeführt, eine Entscheidung über die
_Verstaatlichung_ der grossen Privatbahnen #hinweis[(Kostenersparnis, Eisenbahn ist sehr teuer in der Wartung)].
1902-13 wurden bedeutende Bahngesellschaften in die 1902 gegründete SBB integriert
#hinweis[(Schweizerische Centralbahn SCB, Nordostbahn NOB, Vereinigte Schweizerbahnen VSB, Jura-Simplon-Bahn JS und Gotthardbahn)].
Im ersten Weltkrieg 1914-18 wurde ein Kriegsfahrplan eingeführt; Herausforderungen durch Kohlemangel und
wirtschaftliche Belastungen. 1919-44 wurde die Verwaltung zentralisiert, das Netz elektrifiziert und
die Infrastruktur modernisiert.

Die SBB stand unter Druck: Die Passagierzahlen waren Mitte der Sechziger auf dem Höhepunkt, fielen aber in den
nächsten 10 Jahren um _fast 50 Millionen_. Ebenfalls stiegen die Kosten; die SBB geriet in finanzielle Schieflage.
Trotz Netzausbaus wollten viele nicht mit dem Zug fahren. Das lag daran, dass die _Züge nur unregelmässig fuhren_,
man musste für jeden Zug einzeln ein Billet kaufen, _lange Wartezeiten_ in Wartesälen an Bahnhöfen, kein Überblick
über den gesamtschweizerischen Fahrplan. Der Zugverkehr war auf die _Wirtschaftlichkeit der einzelnen Bahngesellschaften_,
nicht auf die Fahrgäste ausgerichtet. Zwischen den Bahngesellschaften wurde die teure Infrastruktur nicht optimal genutzt.

Ein weiterer Grund dafür war unter anderem die _Förderung des Strassenverkehrs_, welcher 5x mehr staatliche Förderung erhielt.
1958 fiel der Volksentscheid für eine Nationalstrassennetz #hinweis[(Autobahnen)], 1960 wurde dann das Bundesgesetz
über die Nationalstrassen verabschiedet. Die erste Nationalstrasse wurde 1962 eröffnet. 1965 gab es in der Schweiz
bereits 800'000 Autos und 200'000 Motorräder.

Um das zu bekämpfen gab es Bestrebungen, den Schienenverkehr als nationales Netz anzusehen.
Die Bestrebungen der SBB selbst verliefen aber im Sand. Eine Gruppe wollte dies aber nicht so hinnehmen.

== Der Spinnerclub
Der Spinnerclub wurde 1970 von jungen SBB-Akademikern gegründet, angeführt von Jean-Pierre Berthouzoz.
Die Idee entstand aus einem Marketingkurs, in dem von "Spinnerclubs" in Unternehmen berichtet wurde --
Netzwerke für kreative und unkonventionelle Ideen zum Lösen organisatorischer Probleme.
Das Ziel war _Ideenaustausch_ und _Entwicklung unkonventioneller Konzepte_ abseits formaler Strukturen.
Die Mitglieder waren junge Akademiker, die sich ausserhalb der strikten Hierarchie der SBB vernetzen wollten.
Organisatorisch war der Spinnerclub lose strukturiert, aber an die "Gesellschaft der Ingenieure" der SBB angegliedert.

=== Mitglieder des Spinnerclubs
- _Samuel Stähli:_ Ingenieur bei der SBB, Hauptinitiator des Taktfahrplans, bekannt für seine analytische Denkweise
- _Hans Meiner:_ Naturwissenschaftler, promovierter Physiker, bekannt für interdisziplinäre Ansätze
  und technische Innovationsideen
- _Jean-Pierre Berthouzuoz:_ Staatswirtschaftler, Marketingexperte, brachte die Idee des Spinnerclubs
  aus einem Weiterbildungskurs ein

=== Tätigkeiten und Erfolge des Spinnerclubs
Der Spinnerclub arbeitete an Konzepten zur Effizienzverbesserung des Bahnverkehrs, insbesondere am Taktfahrplan.
Dieser wurde als wichtiges Element für die Wettbewerbsfähigkeit der SBB identifiziert. Die Treffen fanden informell statt,
meist am Rand der Arbeitszeit, um keine offiziellen Vorgaben zu verletzen. Die Vorschläge zur Einführung
des Taktfahrplans fanden später Einzug in die offizielle SBB-Planung. Es kam noch zu diversen Verschiebungen,
unter anderem wegen der Erdölkrise #hinweis[(damit verbunden ein starker Rückgang des Güterverkehrs)],
doch _1982_ wurde der Taktfahrplan mit einer grossen Marketingkampagne eingeführt.

=== Idee des Taktfahrplans
Züge sollen sich am gleichen Ort immer wieder begegnen, Anschlüsse sollen auf der Hin- und Rückfahrt funktionieren.
Es gibt Knoten-/Umsteigebahnhöfe, an welchen mit maximal 15 Minuten Wartezeit auf einen Anschlusszug gewechselt werden kann.
Vom Betriebswirtschaftsgedanken wurde also auf den Nutzergedanken gewechselt.

#table(
  columns: (1fr, 1fr),
  table.header([Vorteile], [Nachteile]),
  [
    *Einheitliche Fahrplangestaltung:* Klare Struktur nach Regional-, Schnell- und Intercity-Zügen
  ],
  [
    *Erhöhte Arbeitsintensität:* Mehr Kilometerleistung, physische & psychische Überbeanspruchung
  ],

  [
    *Verbesserung des Angebots:* 22% mehr gefahrene Kilometer, Gleichbehandlung ländlicher Gebiete
  ],
  [
    *Starre Strukturen:* Wenig betriebliche Flexibilität, Unregelmässige Schicht- & Essenszeiten
  ],

  [
    *Langfristige Nutzerfreundlichkeit:* Verlässlichkeit & Stabilität schaffen Vertrauen
  ],
  [
    *Mangelnde Akzeptanz beim Personal:* Wahrnehmung als "Diktat des Uhrzeigers"
  ],

  [
    *Stärkung des ÖVs:* Kontrast zur zunehmenden Motorisierung, Potenziale im Regionalverkehr
  ],
  [
    *Unfallgefahr durch Zeitdruck:* Verbindung zwischen Taktzwang und Unfallhäufung
  ],
)

=== Vergleich mit dem Intercity-System in Deutschland
Intercity war die erste überregionale Zuggattung in Deutschland, welche konsistent grössere Städte miteinander verband.
Die Strecken hatten unterwegs viele Stopps. Schnellere Routen zwischen den Grossstädten wurden erst mit den
Intercity Express realisiert. Auch sie hatten ähnliche Probleme wie bei der SBB.

- _1971:_ Einführung des Intercity-Systems mit ausschliesslich 1. Klasse im Zweistundentakt
- _1979:_ Einführung des zweiklassigen Systems "IC 79" mit dem Slogan "Jede Stunde, jede Klasse"
- _1985:_ Erweiterung des Netzes auf fünf Linien und Einführung von Hochgeschwindigkeitsstrecken
- _1991:_ Einführung des Intercity Express (ICE) als neues Premiumprodukt, Intercity übernimmt vermehrt
  Verbindungen in der Fläche
- _Ab 2015:_ Modernisierung und Ausbau des Intercity-Netzes mit neuen Doppelstockzügen und verbesserten Taktverbindungen

== Wie entstehen Innovationen?
_Formale Organisationen_ #hinweis[(Konzerne)], sind ein soziales System, das durch Entscheidungen strukturiert ist
und seine eigene Identität durch formale Regeln und Verfahren aufrecht erhält. Die formale Organisation dieser
ermöglicht die_ gezielte Verarbeitung_ von Unsicherheiten und Komplexität durch _feste Strukturen_ und Entscheidungsprozesse.
Man kann nur Arbeit für eine formale Organisation verrichten, wenn man Mitglied dieser ist #hinweis[(Mitarbeiter)].

Doch formale Organisationen sind träge und wollen sich nicht verändern. Gleichzeitig müssen sie das aber immer wieder,
um mit veränderten Konditionen klarzukommen. Sie müssen sich anpassen können, um ihren Untergang zu vermeiden.
Wie kann man also so ein System verändern?

Durch formale Organisation und _"brauchbare Illegalität"_: Bewusstes Verhalten oder Handeln von Mitgliedern einer
Organisation, das gegen die formalen Erwartungen der Organisation verstösst #hinweis[(z.B. Personen treffen sich über
  Teamgrenzen hinweg ausserhalb der regulären Zeiten, um an Ideen zu tüfteln, die der Arbeitgeber nicht erlaubt)].
Solche Personen, die gegen die Linie des Unternehmens arbeiten, fördern die Anpassungsfähigkeit.
Diese Netzwerke ermöglichen Innovationen trotz Regelverletzungen. Innovationen entstehen oft in kollektiven Kontexten,
nicht durch Einzelpersonen.

== Quellenkritik: Die genialen Ideen aus dem Spinnerclub
#hinweis[
  Die genialen Ideen aus dem "Spinnerclub". Hans Meiner erinnert sich im Gespräch mit dem InfoForum an die
  Entstehung und Einführung des Taktfahrplans im Jahr 1982, in: InfoForum, Nr. 3, 2014, S. 4.
]

#definition[
  *Forschungsfrage:* Welche Rolle bei der Erfindung des Taktfahrplans schreibt Hans Meiner dem "Spinnerclub" zu?
  Wie charakterisiert er die "brauchbare Illegalität" des "Spinnerclubs" innerhalb der SBB?
]


*Interpretation*\
Der Spinnerclub gilt als _Beispiel für "brauchbare Illegalität"_, da er formale Vorgaben unterlief, aber letztlich
zur Innovation beitrug. Sie war eine subversive Untergruppe von Akademikern innerhalb der Untergruppe
"Gesellschaft der Ingenieure". Der Spinnerclub hatte "keinen Auftrag", sondern traf sich nach der Arbeit und testete
durch Gruppendenken neue Ideen. Die Leistung der Teilnehmer wird herausgehoben, da alle Fahrpläne noch von Hand
erstellt werden mussten. Ebenfalls gibt es die _Abgrenzung gegen "die Alten" und die "mittlere Ebene"_:
Die, die nichts verändern wollen gegen die, die das System verbessern wollen.\
Die SBB-Führung tolerierte die Aktivitäten, da sie langfristig die Modernisierung förderten und das alte System verbesserten.
Die Generaldirektion der SBB habe das Potential "sofort erkannt" und sich für eine Weiterführung des Konzepts eingesetzt,
während sich das mittlerer Management lange dagegen sträubten. Heute wird der Spinnerclub als kreativer Think Tank angesehen,
der die Modernisierung des Schweizer Bahnverkehrs massgeblich beeinflusste.

#pagebreak()


= Zugunfälle in der Risikogesellschaft
Ende der 70er Jahre war die SBB in der Krise: Sinkende Fahrgastzahlen und steigende Kosten machten dem Unternehmen
zu schaffen. Um die Bahn attraktiver zu machen führte die SBB verschiedene Massnahmen durch: Eine _Preissegmentierung_
mit unterschiedlichen Preise für Renter, Kinder, Gruppenreisen, Frühbucher etc., das _Altershalbtaxabo_ für Rentner
ab 1968 und _Verkaufsförderungskurse_ für den Verkauf, Marketing und Management. Das war aber nur Symptombekämpfung.

Im "Bericht 1977" wurde eine umfassende Unternehmensanalyse durchgeführt, in welcher die Schwächen,
aber auch potenzielle Lösungen diskutiert: Privatisierung einzelner Linien, Schnellzüge,
Vergleiche mit anderen europäischen Bahnunternehmen.

== Quellenkritik: Taktfahrplan-Karikatur
#hinweis[Hans Moser, Illustration, in: Nebelspalter. Das Humor- und Satiremagazin, 23/108, 1982, S. 41]

#grid(
  columns: (1.7fr, 1fr),
  align: horizon,
  gutter: 1em,
  [
    *Um was für eine Quelle handelt es sich?*\
    Eine Schwarzweiss-Karikatur aus dem Satiremagazin "Nebelspalter" vom Autor Hans Moser

    *Wann ist die Quelle erschienen?*\
    Die 23. Ausgabe aus 1982, im selben Jahr wie der Taktfahrplan.

    *Was sieht man und was ist das Thema der Quelle?*\
    Es ist ein Kommentar zur Einführung des Taktfahrplans. Man sieht das innere eines SBB-Zugs,
    links ein sitzender Fahrgast mit Zeitung, der Platz neben ihm ist leer.
    Rechts steht ein müde aussehender SBB-Angestellter mit übervollem Essenswagen, welcher zum Reisender
    "Kaffee, Bier, Gipfeli und alle Billete ab Landquart bitte!" sagt. Die Neuheiten wirken für beide Seiten ungewohnt.
    Darunter steht ein beissender Kommentar zu den Mehrleistungen des sowieso schon überlasteten Personals.

    *Interpretieren Sie diese Quelle hinsichtlich der Frage, was die Einführung des Taktfahrplans im
    Mai 1982 für das Zugpersonal der SBB bedeutete?*\
    Dargestellt wird eine idealtypische Szene: Nur ein Sitzplatz ist belegt, und der Kontrolleur schiebt
    einen Essenswagen herum, was eigentlich nicht zu seinen Uraufgaben gehört.
  ],
  figure(image("img/tg/Taktfahrplan.png"), caption: [Taktfahrplankarikatur, Hans Moser]),
)

Der Kontrolleur hat mit dem Essenswagen zusätzliche Aufgaben bekommen, was seine ursprüngliche Aufgabe als
letztes erscheinen lässt. Es ist eine Kritik am Taktfahrplan, welche vor allem die sowieso schon
ausgelasteten Kontrollpersonal Mehraufgaben verschafft, doch auch für die Kunden schwierig ist, da sie sich
durch den Verkaufsdrang des Personals bedrängt fühlen könnten.

== Quellenkritik: Der Taktfahrplan in Basel
#hinweis[SRF, Der Taktfahrplan in Basel, CH-Magazin vom 25.5.1982]

*Was bedeutete der Taktfahrplan für die Mitarbeiter:innen der SBB?*\
Es gab einen _bedeutenden Mehraufwand für das Personal_ durch das höhere Zugsaufkommen. Der Bericht erzählt indirekt,
dass nicht viel neues Personal eingestellt wurde, sondern das Bestehende mit diesen Änderungen und Aufgaben
klar kommen musste. Die Umstellung von Arbeitsroutinen, die fehlenden Erfahrungswerte und der Leistungsdruck,
dass diese Umstellung auch den Ansprüchen gerecht wird. Erhöhte Abstimmungsschwierigkeiten mit
beispielsweise Anschlusszügen, Verpflegung im Zug und Baustellen. Die Fahrdienstleiter stehen ebenfalls vor
einem komplett neuen System und können weniger auf Erfahrung vertrauen.\
Wie bei vielen technischen Innovationen wird der Taktfahrplan _nicht nur von den Erfindern getragen_,
sondern auch von denjenigen, die _diese Arbeit tatsächlich ausführen_ und sich dadurch deren Rollen wandeln können.

*Welche Berufsgruppen sind betroffen?*\
Die Kondukteure, die Zugputzequippe, die Bordköche, die Fahrdienstleiter, aber auch die Gleisarbeiter im Tunnelbau
müssen häufiger ihre Arbeit unterbrechen, weil mehr Züge ihre Baustelle passieren. Hauptsächlich also diejenigen,
die körperliche Arbeit verrichten und weniger Lohn verdienen. Die _"Autorität" des Kontrolleurs_, welchem man beweisen muss,
dass man mit diesem Zug fahren darf, wird durch den Snackverkauf aufgeweicht.

*Was ist die Kritik am Taktfahrplan?*\
Die Taktfahrpläne der Schweiz und Deutschland stimmen nicht überein, was am Bahnhof Basel zu suboptimalen Anschlüssen führt.
Auch wurden aus Mitarbeitersicht _nur Nach- aber keine Vorteile genannt_: Es führe nur zu Mehrarbeit ohne grosse Vorteile.
Ebenfalls gab es kurz kritische Stimmen der Kundschaft. Die in der Theorie gute Innovation hatte sich zwar durchgesetzt,
aber in der Ausführung kritisch beachtet worden. Auch wenn sich eine Innovation durchsetzt, kann sie von der Gesellschaft
_trotzdem kritisch betrachtet_ werden.

== Die Zugunfälle von 1982
Das Jahr 1982 ebnete der SBB mit dem Taktfahrplan den Weg in die Zukunft, wurde aber durch _drei schwerwiegende
Zugunfälle_ nach der Taktfahrplaneinführung überschattet. Der vielkritisierte Taktfahrplan litt an Kinderkrankheiten
und die Zugunfälle liessen die Diskussionen aufflammen.

=== Der Unfall von Othmarsingen
In der Nacht vom 18. Juli 1982 stiess ein Güterzug mit einem Nachtschnellzug von Dortmund nach Rimini zusammen.
Dabei starben 6 Menschen, 100 wurden verletzt. Der Unfall ereignete sich in der Nähe des Bahnhofs Othmarsingen
im Kanton Aargau. Der mit 500 Reisenden besetzte Nachtzug stiess frontal mit dem Güterzug zusammen.
Damals war dieser Streckenabschnitt nur einspurig. Das Zugsignal zur Befahrung dieses Abschnitts zeigte für
den Güterzug Halt an, doch zu der Zeit konnte der Zug trotz dieses Signals noch weiterfahren.
Auch gab es weder direkte Kommunikation mit dem Lokführer, noch eine "Schutzweiche", mit welcher auf dem
Streckenabschnitt nochmals ausgewichen werden konnte. Der Güterzug fuhr ihm deshalb in die Flanke.
Die sieben Personenwagen am Schluss des Schnellzugs wurden dabei vom vorderen Zugteil getrennt, entgleisten und
wurden aus den Schienen geworfen. Drei vollbesetzte Wagen stürzten um, zwei weitere wurden seitlich aufgeschlitzt.\
Die darauffolgende Diskussion entbrannte, ob es sich um menschliches oder technisches Versagen handelte.

=== Der Unfall von Pfäffikon ZH
Ein Reisebus eines deutschen Sportvereins fuhr am 12. September 1982 auf einen Bahnübergang, dessen Schranken
vorzeitig geöffnet wurden. Ein Regionalzug erfasste den Reisebus und von den 41 Insassen überlebten nur 2.
Die Schranken wurden damals noch manuell gesteuert und die verantwortliche Bahnwärterin drückte den falschen Knopf,
was die Schranke öffnen liess. Sie wurde wegen fahrlässigem Verhalten verurteilt, doch durch ihre Aussage,
dass die Knöpfe zum Verwechseln ähnlich seien, wurde das Strafmass gemildert. Die Anteilnahme der Bevölkerung an diesem Unfall war riesig.\
Es wurde danach diskutiert, ob ein so essentiell wichtiger Job für die Verkehrssicherheit von menschlicher Wahrnehmung
abhängen sollte und dass dieser monotone Job schlecht bezahlt wurde.

=== Der Unfall von Bümpliz
Der Zugführer eines Schnellzugs von Olten nach Genf wollte eine Verspätung wiedergutmachen und fuhr bei der Ausfahrt
aus dem Bahnhof Bern mit 120 statt 40 km/h über eine Weiche und entgleiste. Es gab 15 Verletzte.
Die Gleise, auf denen eigentlich 140 km/h gefahren werden durfte, waren wegen Bauarbeiten gesperrt.

=== Wer hatte Schuld an den Unfällen?
Die Unfälle lösten in Fachkreisen, aber auch in der Gesellschaft die _Diskussion der Schuldfrage_ aus:
Handelte es sich um menschliches Versagen? Die Bahnwärterin drückte den Öffnen- anstatt Schliessen-Knopf.
Oder hatte das 50 Jahre alte System der Zugsicherung Schuld, welches unzureichend war?
Wie löst man das Problem der Zugunfälle? Durch Fernsteuerung und technische Überwachung oder durch persönliche Selbstkontrolle?

#pagebreak()

== Quellenkritik: Kritische Anmerkungen zur Lage der SBB
#hinweis[
  Paul Keller, Kritische Anmerkungen zur Lage der SBB. Ist ein Neubeginn möglich?, in: Rote Revue
  (Herausgegeben von der Sozialdemokratischen Partei der Schweiz), Heft Nr. 10, Band 63 (1984), S. 15-17.
]

#definition[
  *Forschungsfrage:* Untersuchen Sie, worin der Lokomotivführer Paul Keller die Ursachen für die Unfälle im Zugverkehr sieht.
  Was sind seine Kritikpunkte? Beachten Sie auch von welcher Position der Autor spricht und welche Sprache und Formulierungen
  er dafür wählte.
]

*Wer spricht mit welchen Motiven und Wertungen?*\
Die Position des Autors ist zweideutig: Einerseits kritisiert er die SBB, auf der anderen Seite arbeitet er für sie und
stellt seinen Arbeitgeber mit diesem Text bloss. Der Text ist _sehr ambivalent geschrieben_, Fehler werden eingesehen,
aber die Gründe sind immer vielschichtig.

Der Druck auf die Lokomotivführer wird so gross gewesen sein, dass er sich zu einer Stellungnahme veranlasst gefühlt hat.
Lokführer sind eine sehr professionalisierte Berufsgruppe mit viel Berufsstolz und gewerkschaftlich gut organisiert.
Die Lokführer argumentieren also aus einer Position der Stärke heraus, weil ohne sie fährt nichts.
Sie sind von "ihrem Produkt" überzeugt, aber die Umsetzung der SBB um mehr Passagiere zu gewinnen ist seiner Meinung nach mangelhaft.

Die Ursachen für die Probleme sind vielschichtig: Die Abwägung von zu viel gegen zu wenig Warnungen,
die Mehrbelastung des Personals, teils veraltete Technik. Ebenfalls wird eine Verzerrung in den Medien genannt,
bei den relativ seltenen Zugunfällen gibt es ein Medienspektakel, die täglich vorkommenden Autounfälle
sind aber nur eine Fussnote.

Die Beantwortung der Schuldfrage ist uneindeutig: Obwohl teils Menschen dafür verantwortlich waren, wie z.B.
der falsche Knopfdruck der Bahnwärterin, kann argumentiert werden, dass diese Unfälle nur zustandekamen,
weil das System das zuliess. Es gibt keine befriedigende Lösung für das Problem, weil es sehr viele Faktoren gibt.
Die Sicht des Management auf den Taktfahrplan ist _oft konträr_ zu der Sicht der Arbeiter:
Zukunftsreif vs. Mehrbelastung des Personals.

== Technische Unfälle & Risiken
Mit Technik gibt es immer auch Unfälle. Mit der Verbreitung von vernetzten Maschinen und gekoppelten Infrastrukturen
wird der Alltag von diesen abhängig. Unfälle werden unvermeidbar und somit zur Normalität.
Damit entstehen Unfälle nicht mehr nur aus menschlichem Versagen, sondern sind auch eine logische Folge der Systemarchitektur.
Viele Dinge können nicht direkt beeinflusst werden.

=== Komplexität & Kopplung
- _Komplexität:_ Viele miteinander verknüpfte Komponenten
- _Enge Kopplung:_ Schnelle und unvorhersehbare Ausbreitung von Fehlern. Dadurch Gefahr, dass keine Zeit für
  manuelle Eingriffe oder Korrekturen vorhanden ist
- _Automatisierung:_ Verstärkt die Problematik, da Systeme weniger transparent sind
- _Fehlerketten:_ Kleine Fehler, die sich summieren und zu Unfällen führen
- _Menschliches Versagen:_ Häufig nicht die Hauptursache, sondern eine Reaktion auf Systemfehler #hinweis[(z.B. Monotonie)]
- _Unvorhersehbarkeit:_ Nicht-lineare Interaktion zwischen Komponenten

Die Welt wandelt sich von einer Industriegesellschaft zu einer Risikogesellschaft.
Die Industriegesellschaft produzierte Wohlstand und Ungleichheit war eher ein politisches Problem.
Menschliche Not wie Armut oder Ungleichheit lassen sich ausblenden.
Jetzt produziert unsere Gesellschaft _systemische Risiken_, die alle betreffen:
Atomkraft, Umweltverschmutzung, Mikroplastik, Gentechnik, Corona.

#pagebreak()

=== Systemische Risiken & reflexive Modernisierung
- _Systemische Risiken:_ Global, unsichtbar, schwer kalkulierbar
- _Reflexive Modernisierung:_ Gesellschaft wird sich ihrer Risiken bewusst.
  Daraus folgert die Erosion traditioneller Autoritäten wie Politik oder Wissenschaft
- _Individualisierung:_ Menschen tragen persönliche Verantwortung für systemische Risiken
- _Demokratisierung:_ Bürger fordern Mitsprache bei risikoreichen Entscheidungen,
  z.B. Protestbewegungen gegen Atomenergie oder Klimawandel

Wissenschaft ist nicht nur ein Produzent von Wissen, sondern auch Unwissen.
Das Paradox der Modernisierung ist, dass mehr technischer Fortschritt auch zu neuen Unsicherheiten führt
#hinweis[(Mehr Züge, mehr Unfälle)]. Die Gesellschaft hinterfragt die Sicherheit wissenschaftlicher Erkenntnisse.

Nichtwissen kann auf verschiedene Arten produziert werden:

- _Ungewissheit:_ Die Zukunft kann nur schätzungsweise vorhergesagt werden
- _Ignoranz:_ Ignorieren von Erkenntnissen
- _Nicht-Erkenntnis:_ Dinge, die (noch) nicht wissenschaftlich erforscht sind und deshalb kein sicheres Wissen
  darüber existiert #hinweis[(Langzeitfolgen von neuen Medikamenten, Virusverbreitung, Verhalten bei einem Blackout)]
- _Wissenskonflikte:_ Verschiedene konkurrierende Themen

Risiken sind nicht nur technische, sondern auch politische und gesellschaftliche Fragen.
Durch _Politisierung_ werden Risiken öffentlich diskutiert und verhandelt. Wer trägt also die Verantwortung über die Risiken?


= Digitale Staatlichkeit
Die Firma IBM stellte in den 1930ern Büromaschinen wie Schreibmaschinen und Kopierer her, und war dann mit
ihren Computern und Servern der erste "Tech-Gigant". Damit wurde sie auch symbolisch für die Technikangst
in der Gesellschaft typisiert. In der Schweiz wollte sich IBM auch in der staatlichen Verwaltung einbringen.

== Quellenkritik: IBM-Werbung
#hinweis[
  IBM Werbung "Sich keinen Computer anzuschaffen..." aus "Verwaltungspraxis. Monatsschrift für die Verwaltung", Heft 12 (1966), S. 324\
  IBM Werbung "AHV-Nr. 671.70.140" aus "Neue Zürcher Zeitung", 9. Februar 1970, Morgenausgabe Nr. 64, S. 20\
  IBM Werbung "Wissen verpflichtet" aus "Verwaltungspraxis. Monatsschrift für die Verwaltung", Heft 6/7 (1971), S. 217
]
#definition[*Forschungsfrage:* Wie würden Sie die Werbestrategie der IBM Schweiz beschreiben? Was ist besonders auffällig?]

*Wie lässt sich die Quelle näher bestimmen?*\
Werbung, also nicht neutraler Text, aufmerksamkeitshaschend

*Sich keinen Computer anzuschaffen, muss gar nicht so dumm sein (1966)*\
Grosse Freifläche, wo man ein Bild erwarten würde; Überraschungseffekt. Kritische Punkte, welche sich die Bevölkerung
über Computer stellt, werden angesprochen. Einsatz des Wortes "dumm" (Umgangssprache) auf Unternehmensentscheidungen,
unerwartet von "seriöser" Firma. Einführung in Zeitmieten in einem IBM-Rechenzentrum, welche es erlaubt,
langwierige Berechnungen #hinweis[(Kostenvoranschläge, Abrechnungen, Kontrollen, Statistiken)] durchzuführen,
ohne sich eigene Hardware anschaffen zu müssen #hinweis[(kein eigenes Personal nötig, kein Informieren über geeignete Hardware, kostengünstiger)].
Nachteile wären Datenschutzprobleme und eventuelles Anpassen der Daten/Workflows an die von IBM vorgegebenen Prozesse.

*AHV-Nummer (1970)*\
IBM vergleicht ihr System mit der AHV. Ein Baby wird gross abgedruckt mit viel Freiraum, darunter seine AHV-Nummer.
Die Welt wird komplizierter, dystopischer in der Zukunft. Dem entgegengestellt wird ein Bild von Freiheit des Bürgers,
welcher in einer solchen Welt nicht mehr Zeit mit Verwaltung von sich selbst verbringen möchte.
Diese Arbeit soll der Staat im Hintergrund erledigen. Durch das Wegfallen dieser Arbeit kann von "geisttötender"
zu "schöpferischer" Arbeit gewechselt werden. Der Mensch soll kein passiver, sondern ein aktiver Teil der Gesellschaft sein.
Er sorgt durch die Einzahlung in die AHV für die Gesellschaft und die Gesellschaft sorgt sich dafür um ihn --
_Sozialstaatliches Prinzip_.

Der Sinn der elektronischen Datenverarbeitung sei Freiheit. Damit dieses Mehr an Personen und Daten durch den Staat verarbeitet,
entschieden und verwaltet werden kann, müssen Daten effizient verarbeiten können. Das Digitale schafft Freiheit und Ordnung
in der Gesellschaft. IBM entgegnet der Kritik, dass Technik unmenschlich sei, mit dem Argument, dass sie mithelfen, dass die AHV funktioniert.

*Wissen verpflichtet (1971)*\
Grosses Bild von spielenden Kinder auf einem geräumigem Spielplatz mit Bäumen, naturnah, wenig Geräte. Keine Eltern, Strassen
oder Häuser; Dynamisch. Kein "normales" Bild für ein Technikunternehmen. Verbindung von Zukunft der Gesellschaft und Technik.
Adressierung des Vorwurfs einer "unmenschlichen Technik": Die Technik arbeitet für die Verwaltung und die Verwaltung soll
(wieder mehr) dem Bürger dienen. IBM will dem Staat die Voraussetzungen liefern, um für die Chancengleichheit, Bildung, Wohlstand
und Rechte der Bürger (besser) sorgen zu können. Der Staat muss voraussehen können um die Zukunft unserer Kinder gestalten können.
Der Wachstum an Aufgaben muss bewältigt werden können, dafür muss sich aufs Nötige besinnt werden.
IBM will den Staat bei den wachsenden Aufgaben unterstützen.
Es geht nicht um die Funktion des Computers, sondern um die Funktion, die er in der Gesellschaft bzw. dem Staat einnehmen kann.

Sowohl Kantone als auch Gemeinden nutzen diese Computer und können damit zusammenarbeiten. Sie können nicht nur rechnen,
sondern auch Kontrollieren und Planen. Vor allem durch die Erwähnung durch Umweltschutz #hinweis[(1971 Volksabstimmung zum Umweltschutz angenommen)].
Die Verwaltung sorgt für den Bürger und der Bürger sorgt für die Verwaltung, wieder Sozialstaatgedanke.

*Gemeinsamkeiten der Werbungen*\
- _Disruptive Kommunikation_, Strategien der Erwartungsüberraschung visuell und textuell
  #hinweis[(Keine Fakten, Zahlen sondern interessensweckende Werbung)]
- _Visuelle Abwesenheit der Computer_ und Anwesenheit der zukünftigen Gesellschaft
  #hinweis[(Kinder, man sorgt sich um die zukünftige Generation)]
- _Kontraintuitive Slogans_ #hinweis[("Sich keinen Computer anzuschaffen, muss gar nicht so dumm sein")]
- Der Computer als flexible Zukunfts- und liberale Ordnungsmaschine #hinweis[("Ohne elektronische Datenverarbeitung ist
    auch dieser zukünftige Erdenbürger im Wust der zukünftigen Tatsachen verloren und ihnen ausgeliefert.")]
- Der Computer als _Datenverarbeitungstechnologie_ für Behörden
  #hinweis[(nicht als Instrument wissenschaftlichen Rechnens)]
- Der Computer als _technische Verwaltungsreform_
  #hinweis[(Reform der AHV 1972; sachliche und problembezogene Kooperation von Kantonen und Gemeinden)]
- _Sharing-Kultur_: Rechenzeit kann gemietet werden oder auf dem Computer der Kantone mitrechnen

== Computer in der Schweiz
1965 gab es in der Schweizer Verwaltung insgesamt 265 Computeranlagen, davon 135 gemietet. IBM ist klarer Marktführer,
dahinter Remmington-Rand #hinweis[(USA)], Bull #hinweis[(FR)] und ICT #hinweis[(UK)]. Die Stadtkantone haben deutlich
mehr Computer als die Landkantone. In der Wirtschaft war die Textilbranche (64), Maschinenindustrie (56) & Baugewerbe (32)
führend, abgeschlagen war die Banken & Versicherungen (8) und öffentliche Verwaltung (3).

1974 ist die Maschinenindustrie immer noch führend in der Anzahl Computer mit 384, doch auf den nächsten Plätzen finden
sich die Banken (383) und die öffentliche Verwaltung (313). IBM weiter Marktführer.

Es gibt keine Schweizer Computerhersteller, da es kein Investorenmilleu oder staatliche Forderung für solche Firmen existierten.
Erst Mitte der 80er gab es staatliches Interesse, die Informatikbranche zu fördern.

== Die Helvetische Malaise
In den 1960ern breitete sich eine allgemeine Unzufriedenheit in der Bevölkerung aus. Die traditionellen Verfahren wie
direkte Demokratie passten nicht mehr in die Zeit: Geringe Abstimmungsqoten, langsame Verwaltung, Reformstau.
Das Vertrauen bröckelte. Diesen Zustand der "Anti-Reform" fasste der Schriftsteller Max Imboden mit dem Begriff
_"Helvetische Malaise"_ zusammen. Irgendwas scheint nicht mehr zu stimmen, es lässt sich aber nicht genau sagen was.

Es gab ein starkes Aufgabenwachstum und gesteigerte Aufgabenverflechtung zwischen Gemeinden, Kantonen und Bund
#hinweis[(Sozialstaat, Nationalstrassen, Umwelt- & Gewässerschutz)]. Ein Verlust der Gemeindeautonomie wurde befürchtet.
275 kleinere Gemeinden hatten keinen festen Angestellten.

== Computer in der Schweizer Verwaltung
Ende der 60er begannen die Schweizer Verwaltungen damit, die Aufgaben und Verfahren in den digitalen Raum zu verschieben.
Die Computerhersteller greifen mit ihrer Marketingstrategie genau da an, wo die Helvetische Malaise stattfindet.
Doch zunächst wurde der Verwaltungsprozess nicht einfacher, sondern komplexer. Der Betrieb von Rechnern erzeugte
Handlungszwänge und Probleme, die in den Versprechungen der Computerhersteller nicht einkalkuliert waren.
Im Verlauf dieses Prozesses veränderten sich die Staatlichkeit und die digitale Wirklichkeit.

Es gab zwei Abstimmungen bezüglich Rechenzentren in der Schweiz: 1964 im Kanton Wallis und 1972 im Kanton Schaffhausen.
Die Computerkultur entwickelte sich heterogen, daher waren _pro Stadt verschiedene Projekte_ und Modelle möglich

=== Computer in der Stadt St. Gallen
Durch die Hochschule und Textilindustrie stieg die Stadt St. Gallen früh in den Computermarkt ein.
1963 kaufte die Stadt ihren ersten IBM 1410. Bereits davor wurde eine eigene Automationsabteilung gegründet,
die hierarchisch organisiert war. Man stellte eigene Programmierer ein und arbeitete mit der lokalen Industrie zusammen.
Die Einsparungen wurden genau protokolliert. Es wurden immer mehr und mehr Aufgaben in den Rechner verlegt, um diesen optimal auszulasten.

10 Jahre später musste eine Nachfolgerechner angeschafft werden. Um Budgetierungsfragen auszuweichen, gründete die
Stadt zusammen mit dem Kanton die Verwaltungsrechenzentrum AG St. Gallen. Die ganze Computerabteilung der Stadt zog
in diese Aktiengesellschaft. Dadurch konnte Rechenleistung für andere Gemeinden im Kanton vermietet werden.
Die Gemeinden wurden zu Aktionären und es waren keine Abstimmungen in den Gemeinden nötig, ob teuer Computer angeschafft
werden sollten.

=== Computer in Chur
Die Einwohnerkontrolle ist die _zentrale Schaltstelle_ jeder Gemeindeverwaltung. Sie erfasst und verwaltet
personenbezogene Daten #hinweis[(Name, Adresse, Beruf, Religion)]. Ebenfalls ist sie die Schnittstelle für Meldungen
von Geburten, Todesfälle, Umzüge, Heiraten & Scheidungen. Sie stellt Ausweise, Stimmmaterial und Statistiken bereit.
Andere Verwaltungsbereiche sind teils stark von ihnen abhängig.

Chur hatte in den 60er 4 Mitarbeiter: 3 Datenverarbeiterinnen und einen Stadtschreiber. Alle Informationen wurden auf
Karteikarten geschrieben. Durch die Landflucht und die Tourismusbranche gab es unverhältnismässig viele An- und Abmeldungen
in der Gemeinde, bis zu 3'500 Anfragen täglich. Die Daten waren redundant und verstreut in mehreren Abteilungen.
Der Lagerplatz für die Karteikarten wurde knapp und es gab ein hohes Fehleraufkommen durch manuelle Prozesse.

Also prüften sie drei Optionen:
- _Einen eigenen Computer anschaffen_: Kein Geld und keine Programmierer dafür
- _Mit dem Kanton/anderen Gemeinden kooperieren_: Autonomie und "Stolz" liessen das nicht zu
- _Rechenzeit mieten_: Die Lösung, für die sich entschieden wurde

Chur griff auf das kommerzielle Rechenzentrum von IBM zurück und wollte Rechenzeit mieten. IBM hatte ihr Geschäftsmodell
angepasst und Chur erhielt Terminals (neue Erfindung von IBM, um Einspeisung der Daten auf Kunden zu verschieben).
Mutationen in der Datenbank wurden im Rechenzentrum zwischengespeichert. Um das Zwischenspeichern so kostengünstig
wie möglich zu halten, kauften sie bei Kodak Mikrofilm. Diese Mikrofilme konnten dann in Chur ausgelesen werden.
Alle 14 Tage wurde die Daten aktualisiert und von Chur zum Rechenzentrum in Zürich gesendet.
Diese wurde dann von Zürich an Kodak gesendet, wobei die Daten im Rechenzentrum gelöscht wurden.
Kodak wandelte diese Daten dann in Mikrofilm um und sendete sie zurück nach Chur.

Die Daten wurden also in der ganzen Schweiz umhergeschickt, weil die digitale Speicherung zu teuer war.
Datenschutz war damals noch kein Thema. Dieser Mittelweg zeigt auf, welche Unterschiede es in den Schweizer Gemeinden
bei der Digitalisierung gab. Es erlaubte es Kodak und IBM auch anderen Gemeinden in der Schweiz aufzuzeigen, dass es
billigere Wege für die Digitalisierung gab und erzeugte eine grosse mediale Aufmerksamkeit, weil ein spezielles
Model entwickelt wurde.

#pagebreak()

== Die Datenbank als Reforminstrument
Das Ziel: Die zentrale, konsistente Speicherung aller Einwohnerdaten. Einführung einer Einwohnerdatenbank, in der
die Daten nur noch einmalig erfasst werden müssen. Andere Abteilungen erhalten selektiv benötigte Informationen.
Die Effekte waren Abbau von Doppelspurigkeit und Übertragungsfehlern, Integration von Verwaltung und Technik und
ein _Modell für föderale Kooperation_. St. Gallen und Basel-Stadt nutzen beispielsweise eine gemeinsame Datenbasis
trotz getrennter Zuständigkeiten. Jedoch beteiligten sich nicht alle Kantone/Gemeinden daran und die Gemeindeautonomie
setzt juristische und politische Grenzen.


= Supercomputing im Tessin
Im Tessin steht der ALPS Supercomputer im _Swiss National Supercomputing Centre/Centro svizzero di calcolo scientifico (CSCS)_.
Dieser ist auf der Aussenseite mit Alpenmotiven verziert. Diese Marketingtaktik soll die sonst "verborgenen" Supercomputer
sichtbar machen und ausserdem auf einen Hauptzweck dieses Supercomputers hinweisen: Wettervorhersage.
Ebenfalls ist ein Relief der Alpen ohne Landesgrenzen sichtbar, was die internationale Kooperation symbolisieren soll.

== Was sind Supercomputer?
Supercomputer sind Computer, die die leistungsfähigsten wissenschaftlichen Computer dieser Zeit darstellen.
Ihre Leistung übersteigt die der kommerziell verfügbaren Computer um Längen. Grossflächige Simulationen wenden
Algorithmen auf Datensets an, um ein Problem an der Grenze zur Berechenbarkeit zu lösen. Die Definition von
Supercomputer wandelt sich also mit der Leistungsfähigkeit von Computern allgemein.
Doch nicht nur das: Mit den ersten Supercomputern musste die Problemstellung #hinweis[(z.B. Wettersimulation)]
mit jedem neuen Hardwareupgrade wieder komplett neu konfiguriert werden.

Supercomputer sind aber nie ein rein technisches Projekt, sondern ein vielschichtiges: Aufgrund der Massstäbe sind
an einem Supercomputer meist _Staat, Universitäten und Wirtschaft_ daran interessiert -- High Performance Computing-Rechenzentren
#hinweis[(HPC)] gelten als Knotenpunkt dieser drei Akteure. Die Organisation, Finanzierung und Nutzerpolitik sind
ebenfalls wichtige Aspekte. Supercomputer sind auch oft Symbole politischer Entscheidungsmacht
#hinweis[(nationale Überlegenheit oder internationale Kooperation)]. Durch HPC entstand auch die neue Disziplin
_Computational Science_, welche grossflächige Simulationen in der Wetter- und Klimaforschung und AI ermöglicht.

*Top 500 Ranking*\
Seit 1993 wird eine Liste der 500 schnellsten Supercomputer veröffentlicht. Gegründet wurde sie von den vier
Informatikern Hans Meurer, Erich Strohmaier, Horst Simon und Jack Dongarra. Das Ziel war, einen Überblick über
die leistungsstärksten Supercomputer weltweit zu erhalten, um Vergleichbarkeit und Transparenz im HPC-Umfeld
bieten zu können. Sie wird halbjährlich im Juni und November veröffentlicht.

Diese basieren auf dem LINPACK-Benchmark, welcher ein festes Problem darstellt, welches auf jedem Supercomputer
laufen gelassen wird. Basierend auf der Anzahl Rechenoperationen #hinweis[(FLOPS: Floating Point Operations per Second,
  Anzahl Kommazahlenberechnungen pro Sekunde)], welche in diesem Benchmark erzielt werden wird der Computer in die
Liste eingeordnet.

In den ersten Jahren war diese Liste _stark amerikanisch und japanisch geprägt_, in den Folgejahren kamen auch
Computer aus Europa und Asien dazu. Die Regierungen realisierten, dass das Auftauchen in so einer Liste ein
guter Marketingeffekt ist; man strahlt damit aus, dass man im Informationszeitalter bei wissenschaftlichen Problemen
vorne mitspielt. Supercomputing ist also auch eine Frage des _globalen Wettbewerbs_ und der _nationalen Wettbewerbsfähigkeit_.

*Top Green 500*\
Analog zum Top 500 gibt es auch eine Green 500, bei der nicht reine Rechenleistung zählt, sondern die Energieeffizienz
gemessen wird. Die erste Top Green 500 wurde 2007 von Wu-chun Feng und Kirk Cameron veröffentlicht und misst die FLOPS pro Watt,
meist auch über den LINPACK-Benchmark. Die Motivation hinter der Liste war der wachsende Energieverbrauch der Supercomputer.
Durch die Veröffentlichung einer solchen Liste wollte man die Gestaltung _energieeffizienterer Systeme_ fördern,
u.a. durch Paralellisierung, was durch Grafikkarten ermöglicht wird.

Im Juni 2014 schaffte es das CSCS als erstes Rechenzentrum, sich gleichzeitig in den ersten Zehn der Top 500 und
der Top Green 500 zu platzieren.

Im Laufe der Zeit haben immer mehr Länder wie Russland und China ihre Supercomputer gar nicht mehr für die Liste eingereicht,
da damit Informationen über die Kapazitäten, Hardwarekonfiguration und Standort preisgegeben werden.
Die Listen repräsentieren also heutzutage nicht mehr die allerschnellsten Supercomputer und die Listen rutschte in die Bedeutungslosigkeit.

== Das Centro Svizzero di Calcolo Scientifico
1980 identifizierte der Bundesrat einen Mangel an gut ausgebildeten Informatikern in der Schweiz.
1985 wurde ein _Massnahmenpaket zur Förderung_ der Schweizer Informatikbranche beschlossen.
Innerhalb von 5 Jahren sollte unter anderem für 40 Millionen Franken ein High Performance Computing-Rechenzentrum
eingerichtet werden und für 15 Millionen Franken ein Netzwerk #hinweis[(SWITCH EU-ID)] eingerichtet werden,
welches die Rechenleistung des Zentrums den Universitäten zur Verfügung stellt.

Die Standortwahl in Lugano war aussergewöhnlich, denn eigentlich befanden sich alle Nutzer eines Supercomputers
in der Nord- und Westschweiz. Die grossen Universitäten und Branchen hatten alle schon ihre eigenen Supercomputer und
grundsätzlich gar _keinen Bedarf an einem neuen Rechenzentrum_. Durch Standortpolitik fiel die Wahl dann auf Lugano, um auch eine
wissenschaftliche Institution im wirtschaftlich schwachen Tessin anzusieden. Doch niemand in Lugano wollte dieses Rechenzentrum:
Sie hatten keine Universität, also keine lokalen Forschungsprojekte und Fachkräfte, die dieses Zentrum bedienen konnten.
Die einheimischen Talente wollten nicht ins Tessin ziehen und ausländische Fachkräfte konnten mangels eines nahe
gelegenen Flughafens auch nicht leicht eingeflogen werden.

Auch gab es politischen Widerstand: Die rechtspopulistische Partei Lega de Ticinesi klagte gegen den Bau.
Der Standort sei intransparent gewählt worden, wieso genau dieses von der SBB abgekaufte Gelände in Manno auserkoren wurde.
Somit verzögerte sich der Bau, wurde aber schlussendlich doch durchgeführt, ansonsten wäre die Laufzeit des Massnahmenpakets
ausgelaufen und das Geld wäre verpufft. 1990 wurde mit dem Bau begonnen und _1992 wurde das CSCS offiziell eröffnet_.

Die Eröffnung lief bescheiden: Wenige Personen von der ETH und EPFL waren bei der Zeremonie anwesend und es wurde
lange nach einem Leiter für das Rechenzentrum gesucht. Schlussendlich landete man bei Alfred Scheidegger,
ein Biochemiker und -physiker der ETH. Er war bekannt für seine Fähigkeiten, aus ETH-Projekten Startups kreieren zu können,
hatte aber mit Supercomputern wenig Erfahrung.

=== Der erste Jahresbericht
Da das CSCS eine staatliche Institution ist, musste sie Ende 1992 einen Jahresbericht über ihre Aktivitäten veröffentlichen.
Die Berichtsschreiber hatten also die Aufgabe, dieses Rechenzentrum, das niemand wollte, gut verkaufen zu können und
Nutzer dazu motivieren, nach Lugano zu kommen.

#grid(
  columns: (1.30fr, 1fr),
  gutter: 1em,
  [
    Im Vorwort beschrieben sie, dass bei ihnen interdisziplinäre wissenschaftliche Probleme gelöst würden und dass bei
    ihnen viele Fachkräfte ihre Ausbildung erhielten. Auch Nutzer der Industrie seien herzlich willkommen.
    Im weiteren Bericht wurden alle Referenten und Besucher aufgelistet, darunter sogar ein Student, welcher das
    CSCS für sein C++ Raytracing-Projekt besuchte.

    Interessanterweise stand der Supercomputer beim offiziellen Organigramm gar nicht im Mittelpunkt.
    Der NEC SX-3 wurde nur dann verwendet, wenn diese Rechenleistung wirklich benötigt wurde.
    Ansonsten liefen die Simulationen auf schwächeren Computer.

    Zukünftige Erweiterungen waren ebenfalls schon eingezeichnet.
    Ebenfalls sieht man die beiden schnellen Netzwerkverbindungen zur ETH und EPFL.
  ],
  figure(caption: [Organigramm CSCS 1992], image("img/tg/cscs.png")),
)
