// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Jannis Tschan", "Matteo Gmür", "Marco Schnider"),
  fach: "VwlWp",
  fach-long: "Volkswirtschaft und Wirtschaftspolitik",
  semester: "FS25",
  language: "de",
  tableofcontents: (enabled: true, depth: 2, columns: 2),
)

// Document-specific settings
#show figure.caption: set text(hyphenate: false)

= Wohlstand
*Ziele der Wirtschaftspolitik*\
Die verschiedenen Ziele der Wirtschaftspolitik besitzen untereinander entweder Zielharmonie
#hinweis[(Profitieren voneinander, wenn erfüllt)], Zielneutralität #hinweis[(nicht voneinander abhängig)] oder
Zielkonflikte #hinweis[(Können nicht gleichzeitig erfüllt werden)].
- _Wirtschaftswachstum:_ Notwendig, damit es zukünftigen Generationen besser als den heutigen geht.
- _Vollbeschäftigung:_ Weniger Arbeitslose steigern den BIP und damit den Wohlstand
- _Sozialer Ausgleich:_ Umverteilung von Ressourcen zu sozial Schwachen
- _Umweltqualität:_ Sämtliches Handeln belastet die Umwelt in gewissem Masse
- _Aussenwirtschaftliches Gleichgewicht:_ $"Export" = "Import"$
- _Preisstabilität:_ Deflation und Inflation vermeiden

*Begriffe*
- _Wohlstand:_ Grad der Versorgung von Personen, privaten Haushalten oder der gesamten Gesellschaft mit Gütern
- _Volkswirtschaftslehre:_ Sie beschäftigt sich mit der Frage, wie eine Gesellschaft mit ihren knappen Ressourcen
  (Arbeit, Kapital, Technologie, Boden und natürliche Ressourcen) umgeht.
- _Mikroökonomie:_ Zunächst werden die Entscheidungen der einzelnen Wirtschaftseinheiten innerhalb des Landes,
  d.h. der Haushalte und der Unternehmen analysiert. Dazu kommen Staat und Ausland.
- _Makroökonomie:_ In einem nächsten Schritt wird untersucht, wie diese Vielzahl von Entscheidungen miteinander
  koordiniert werden und ob das Ergebnis aus gesamtwirtschaftlicher Sicht wünschenswert ist.
- _Wirtschaftspolitik:_ Schliesslich werden die sich daraus ergebenden wirtschaftspolitischen Massnahmen,
  insbesondere im Hinblick auf Innovation, Wachstum, Arbeitslosigkeit und Inflation untersucht.
- _Lohnquote:_ Anteil der Arbeitnehmerlöhne am gesamten Volkseinkommen
- _Staatsquote:_ Anteil des Staates am BIP
- _Abschreibungen:_ Wertminderung von Vermögensgegenständen eines Unternehmens #hinweis[(z.B. Maschinen, Firmenautos etc.)]
- _Produktionswert:_ Herstellungskosten aller während eines Zeitraums produzierten Güter

#grid(
  align: horizon,
  figure(
    caption: [Einfacher Wirtschaftskreislauf],
    image("img/vwl/wirtschaftskreislauf-einfach.png"),
  ),
  figure(
    caption: [Erweiterter Wirtschaftskreislauf mit volkswirtschaftlichen Akteuren],
    image("img/vwl/wirtschaftskreislauf-erweitert.png"),
  ),
)

== Bruttoinlandsprodukt (BIP)
Wohlstand wird in Form des _Bruttoinlandsprodukts (BIP)_ gemessen.
Es entspricht dem Wert aller nachgefragten Güter eines Landes während einem Jahr unter Abzug der _Vorleistungen_.
Dies entspricht dem Begriff der _Wertschöpfung_. Das BIP misst den Wohlstand nur anhand _bezahlter Güter_.
Damit werden alle Güter nicht berücksichtigt, welche von Personen für den Eigenverbrauch erstellt werden
#hinweis[(z.B. Hausarbeiten oder Anpflanzen von eigenem Gemüse)].
In einer _Subsistenzwirtschaft_ #hinweis[(Bürger decken ihren Bedarf durch Eigenproduktion oder Naturentnahme)] wird damit
das Mass des "wahren" Wohlstandes unterschätzt.

#definition[
  #grid(
    columns: (0.54fr, 1fr),
    align: horizon,
    [
      $ "Wohlstand" = "BIP" = "BPW" - "VL" $
    ],
    [
      _*$"BIP"$:*_ Bruttoinlandsprodukt, siehe unten\
      _*$"BPW"$:*_ Bruttoproduktionswert, Wert aller Güter eines Jahres\
      _*$"VL"$:*_ Vorleistung, Einkauf von Gütern zur Produktion von neuen Gütern eines Jahres
    ],
  )
]

Das BIP kann unterschiedlich berechnet werden:
- _Nominales BIP:_ Güter und Dienstleistungen eines Landes zu aktuellen Preisen
- _Reales BIP:_ Teuerungsbereinigt #hinweis[(ohne Inflation)], basierend auf Vergleich zu einem Indexjahr
  #hinweis[(z.B. Vergleich mit 2018)]. Zeigt damit die Teuerung auf
- _BIP pro Kopf:_ Durchschnittlicher Wohlstand eines Bürgers dieses Landes
- _Kaufkraftbereinigtes BIP (Purchase Power Parity PPP):_ Preisniveau wird für Ländervergleich standardisiert\
  #hinweis[(Wie viel kann ich für 100 Euro in Deutschland, Rumänien kaufen?)]

Das Ausland fliesst durch Nettoexporte in das BIP hinein.
#definition[$ "Nettoexporte" = "Exporte" - "Importe" $]

=== BIP in der Schweiz & international
#grid(
  columns: (1fr, 1.25fr),
  align: horizon,
  figure(caption: [Reales BIP der Schweiz], image("img/vwl/bip-schweiz.png")),
  figure(caption: [BIP pro Kopf in der Schweiz], image("img/vwl/bip-schweiz-tabelle.png")),
)

Das Schweizer BIP stieg in der Nachkriegszeit bis 1975 rasant an, diese Generationen erlebten ein "Wirtschaftswunder".
Danach stieg es verhältnismässig langsam an, meist nur um etwa 1%.

#grid(
  columns: (1fr, 1.1fr),
  align: horizon,
  figure(caption: [Nominales & Reales BIP international], image("img/vwl/bip-international.png")),
  figure(caption: [Nominales & Reales BIP pro Kopf international], image("img/vwl/bip-kopf-international.png")),
)

Aufgrund ihrer geringen Grösse ist die Schweiz beim realen und nominalen BIP-Vergleich relativ weit hinter
bevölkerungsreicheren Ländern, steht aber im pro-Kopf-Vergleich in den Top 5 mit Bankenländern Luxemburg und Singapur,
der Grosskonzern-Steueroase Irland und dem Ölländern Katar, VAE und Norwegen #hinweis[(viel Öl in Untersee)].

#pagebreak()

== Volkswirtschaftliche Produktionsfaktoren
Angebot und Nachfrage definieren die Wertschöpfung. Ressourcen auf der Entstehungsseite sind limitiert.

#grid(
  columns: (1fr, 1fr),
  align: horizon,
  figure(caption: [Gesamtwirtschaftliche Wertschöpfung], image("img/vwl/gesamtwirtschaft-angebot-nachfrage.png")),
  figure(
    caption: [Wertschöpfung der Volkswirtschaftlichen Gesamtrechnung (VGR)],
    image("img/vwl/vgr-wertschöpfung.png"),
  ),
)

Die volkswirtschaftlichen Aspekte können den BIP-Perspektiven zugeordnet werden:
- _Einkommensansatz:_ Lohnquote, Abschreibungen
- _Produktionsansatz:_ Vorleistungen, Produktionswert
- _Verwendungsansatz:_ Konsumausgaben der Haushalte, Exporte

Die VGR misst die Wertschöpfung nicht zuverlässig:
Nicht erfasste Tätigkeiten #hinweis[(Hausarbeit, Schwarzarbeit, Kriminalität)],
Probleme bei der Erfassungsgenauigkeit #hinweis[(Herausrechnen der Vorleistung)],
Fehlen von Marktpreisen #hinweis[(v.a. bei öffentlichen Gütern)]

=== Produktionsseite
#grid(
  align: horizon,
  figure(caption: [Produktionswerte Schweiz 2022], image("img/vwl/produktionswert-tabelle.png")),
  figure(caption: [Wertschöpfung nach Branchen], image("img/vwl/wertschöpfung-branchen.png", height: 27%)),
)

=== Verwendensseite
#grid(
  align: horizon,
  figure(caption: [Nachfrage nach Ausgaben in der Schweiz], image("img/vwl/verwenden-bip.png")),
  figure(caption: [Nachfrage nach Exportgüter international], image("img/vwl/exportgüter.png")),
)

=== Einkommensseite
In der Schweiz erhalten Arbeitnehmer $4/6$ des BIPs, Arbeitgeber $1/6$ und Abschreibungen $1/6$.

#grid(
  align: horizon,
  figure(caption: [Lohnquote international], image("img/vwl/lohnquote-international.png")),
  figure(caption: [Lohnquote Schweiz mit 1% Verdiener], image("img/vwl/lohnquote-1prozent.png")),
)

== Wohlstand und Lebensqualität
Der Social Progress Index (SPI) misst die soziale Entwicklung aufgrund von Ergebnissen.
Beispielsweise werden nicht die Investitionen in das Bildungssystem gemessen, sondern die Alphabetisierungswerte.
Der SPI hat 54 Unterkategorien, welche 12 Subkriterien haben, die alle zu 3 Teilindizes zusammengefasst werden:
_Basic Human Needs_, _Foundation of Wellbeing_, _Opportunity_.
*Beispiele:* Wohnen, Trinkwasser, medizinische Versorgung, Sicherheit, ökologische Nachhaltigkeit,
Freiheits- und Wahlrechte, Toleranz, Zugang zu Bildung

#grid(
  align: horizon,
  figure(caption: [Macht BIP glücklich?], image("img/vwl/bip-glücklich.png")),
  figure(caption: [Zusammenhang BIP & sozialer Fortschritt], image("img/vwl/bip-sozialer-fortschritt.png")),
)

BIP allein macht nicht glücklich. Bei Ländern mit tiefem BIP bringt eine BIP-Erhöhung viel Lebensqualität,
je höher der BIP schon ist, desto geringer wird der Zuwachs.
Arme Länder sind gezwungen, Wohlstandsentwicklung zu betreiben, um ihre Lebensqualität zu erhöhen.
Reiche Länder dagegen müssen in soziale Institutionen investieren, damit die Glücklichsein der Bevölkerung verbessert wird.

#pagebreak()

= Wachstum
Wenn Wohlstand einen kausalen positiven Zusammenhang mit Lebensqualität hat, stellt sich die Frage, wie dieser langfristig
weiter gesteigert werden kann. Der Konjunkturverlauf weist Schwankungen auf.
Deshalb kann die Wirtschaft kurzfristig z.B. stark unterausgelastet sein und es entsteht Arbeitslosigkeit.
Auf lange Sicht jedoch ist der _Wachstumstrend_ der entscheidende Faktor, der den Wohlstand eines Landes bestimmt.
Die Kennzahl für das Wohlstandswachstum ist die Entwicklung des BIP pro Kopf.

#grid(
  align: horizon,
  figure(caption: [Wachstumstrend & Konjunkturverlauf], image("img/vwl/wachstumstrend.png")),
  figure(caption: [Quellen des Wachstums], image("img/vwl/wachstumsquellen.png")),
)

#definition[$ "Arbeitsproduktivität" = "Reales BIP"/"Anzahl Arbeitsstunden der Volkswirtschaft" $]

Wachstum entschärft Verteilungsprobleme, welche bei der Verwirklichung von sozialer Gerechtigkeit entstehen.
Es ist einfacher, zusätzlich geschaffener Wohlstand umzuverteilen #hinweis[(Sozialversicherungen: AHV, IV etc.)],
als vorhandener Wohlstand jemandem wegzunehmen und einem anderen zu geben #hinweis[(Enteignung)].

== Instrumente der Wachstumspolitik
#table(
  columns: (1fr, 1.9fr),
  table.header([Erhöhung der Anzahl Arbeitsstunden], [Erhöhung der Arbeitsproduktivität]),
  [
    Arbeitsmarktpolitik, Erwerbstätigenquote erhöhen
  ],
  [
    Wettbewerbspolitik, Aussenwirtschaftspolitik, Bildungspolitik, Innovationspolitik, Realkapital,
    Technischer Fortschritt #hinweis[(die "unendliche Ressource")]
  ],
)

Der Produktivitätszuwachs in der Schweiz flachte seit den 1970ern auf durchschnittlich 1-2% ab.
Tiefer liegen nur noch Italien und Japan.

#grid(
  align: horizon,
  figure(caption: [Reales BIP/Kopf in der Schweiz zu Preisen von 2005], image("img/vwl/real-bip-schweiz.png")),
  figure(caption: [Entwicklung der Arbeitsproduktivität international], image("img/vwl/arbeitsproduktivität.png")),
)

#pagebreak()

=== Staatsquote
Der Anteil des Staatskonsums am BIP auf der Verwendensseite ist die _Staatsquote_.
#definition[$ "Staatsquote" = "öffentlicher Konsum" + "öffentliche Investitionen" $]

#grid(
  align: horizon,
  [
    Während die Schweiz in Vergleichen zu Wettbewerbsfähigkeit und Lebensqualität gut abschneidet, ist beim Wachstum der
    Arbeitsproduktivität das Gegenteil der Fall:
    Laut OECD durchschnittlich nur 1.2% #hinweis[(EU-Spitzenreiter Polen, Slowakei, Lettland, Litauen zwischen 3.8% - 4.7%)].
    Die Schweiz liegt zwar im Vergleich mit ähnlich entwickelten Volkswirtschaften nur um wenige Prozentpunkte zurück
    #hinweis[(DE & FR 0.1, AT 0.2, USA 0.6)], diese summieren sich aber wegen der Exponentialität der Werte.

    In der Ökonomie sind präzise Aussagen schwierig, weil man auf Schätzungen und Annäherung angewiesen ist.
    Die vermuteten Gründe für das Abflachen liegen im _Basiseffekt_ #hinweis[(Land mit hoher Arbeitsproduktivität hat Mühe,
    diese weiter zu steigern)] und die Entwicklung zu einer Dienstleistungsgesellschaft.
    Mit diesen Problemen kämpfen aber alle Industrieländer, nicht nur die Schweiz.
  ],
  figure(caption: [Wachstum der Staatsquoten in der Schweiz], image("img/vwl/wachstum-staatsquote-international.png")),
)

Bei der Schweiz scheint spezifisch das _hohe Wachstum der Beschäftigung_ in der _öffentlichen Verwaltung_ und staatsnahen
Bereichen #hinweis[(Erziehung, Gesundheit, Heime & Soziales, Energie- & Wasserversorgung)] sich _negativ auf das Wachstum_
der gesamtwirtschaftlichen Arbeitsproduktivität auszuwirken.\
Staatliche Beschäftigung seit 2009 in CH: +3.1 Prozentpunkte, OECD-Durchschnitt: +0.2 Prozentpunkte.

== Schweizer Wachstumspolitik
Als Reaktion auf die Jahrzehnte anhaltende Wachstumsflaute verabschiedete der Bundesrat _2004_ erstmals eine Schweizer
Wachstumspolitik. In dieser werden die Ursachen der Wachstumsflaute konkret benannt und entsprechende Zielsetzungen formuliert.

=== Schweizer Wachstumspolitik I (2004 - 2007)
#table(
  columns: (1fr, 1.65fr),
  table.header([Ursachen der Wachstumsflaute], [Zielsetzungen]),
  [
    - Problem der Schweizer Hochpreisinsel: Die Schweiz schottete ihren Binnenmarkt ab, um einheimische Produzenten
      #hinweis[(z.B. Bauern)] vor ausländischer Billigware zu schützen
    - Höheres Wachstum der Schweizer Staatsquote als andere OECD-Länder
  ],
  [
    - *Erhöhung des Wettbewerbs auf dem Schweizer Binnenmarkt*
      - Reformen im Gesundheitswesen, Landwirtschaft, Strommarkt
    - *Eindämmung des Wachstums der Staatsquote*
      - Einführung der Schuldenbremse
      - Eliminierung des strukturellen Budgetdefizits
    - *Effiziente Ausgestaltung staatlicher Tätigkeiten und Regulierungen*
      - Reform der Unternehmenssteuer, Mehrwertsteuer
      - Administrative Entlastung der Unternehmen
  ],
)

Der Fokus lag also auf einer Verringerung der Ausgaben durch die _Schuldenbremse_.
Sie verhindert aber nur die Staatsverschuldung, nicht aber den Ausbau der Staatsquote.

=== Schweizer Wachstumspolitik II (2008 - 2011)
Das erste Massnahmenpaket zeigte nicht die erhoffte Wirkung, darum wurde 2008 die Wachstumspolitik angepasst.

*Wachstumspaket mit 20 wirtschaftspolitischen Massnahmen*\
Senkung des hohen Kostenniveaus (Hochpreisinsel Schweiz), Attraktivitätssteigerung für Teilnahme am Erwerbsleben,
Aufwertung der Schweiz als Unternehmensstandort

=== Schweizer Wachstumspolitik III (2012 - 2015)
Auch das zweite Paket ändere nichts an der Lage. Vielleicht dieses Mal? Fokus: _Nachhaltigkeit der Wirtschaft_

*Sieben Handlungsfelder der Wachstumspolitik (13 Massnahmen)*:
- Die Belebung des Wettbewerbs im Binnenmarkt $->$ Ziel der Wettbewerbspolitik
- Die wirtschaftliche Öffnung nach aussen $->$ Ziel der Aussenwirtschaftspolitik
- Die Wahrung einer hohen Erwerbsbeteiligung $->$ Ziel der Arbeitsmarktpolitik
- Die Stärkung von Bildung, Forschung, Innovation (Humankapital) $->$ Ziel der Bildungs- und Arbeitsmarktpolitik
- Die Gewährleistung gesunder öffentlicher Finanzen $->$ Ziel der Finanzpolitik
- Die Schaffung eines rechtlichen Umfeldes, das der unternehmerischen Initiative förderlich ist
  $->$ ein spezifischer Gegenstand der Rechtsetzung
- Die Tragbarkeit der Umweltbeanspruchung gewährleisten $->$ Ziel der Umweltpolitik

=== Schweizer Wachstumspolitik IV (2016 - 2019)
Wieder ein Schuss in den Ofen #hinweis[(ist die Schweiz Team Rocket?)].
Ein weiterer Versuch mit Fokus auf _Digitalisierung der Wirtschaft_ wurde 2016 gestartet.

#table(
  columns: (1fr, 2.5fr),
  table.header([Die drei Säulen der Wachstumspolitik], [Die zehn Vorhaben der Wachstumspolitik]),
  [
    + Stärkung des Wachstums der Arbeitsproduktivität
    + Erhöhung der Widerstandsfähigkeit der Volkswirtschaft
    + Wachstum der Ressourcenproduktivität zur Milderung negativer Nebenwirkungen des Wirtschaftswachstums
  ],
  [
    + Erhalt und Weiterentwicklung des bilateralen Wegs mit der EU
    + Erweiterung des Marktzugangs für Schweizer Unternehmen
    + Entwicklung von geeigneten Rahmen- und Wettbewerbsbedingungen in der «Digitalen Wirtschaft»
    + Liberalisierung des Strommarktes und Regulierung des Gasmarktes
    + Administrative Entlastung und bessere Regulierung für Unternehmen
    + Stärkung des Wettbewerbs im Binnenmarkt durch Erleichterung der Importe
    + Agrarpolitik 2022-2025: Konsequente Weiterentwicklung der Agrarpolitik
    + Zweites Massnahmenpaket der Energiestrategie 2050
    + Klimagesetzgebung nach 2020
    + Effizientere Nutzung und zielgerichteter Ausbau der Verkehrsinfrastrukturen
  ],
)

Eine fünfte politische Initiative für eine Schweizer Wachstumspolitik 2020 - 2023 wurde nicht mehr formuliert\
#hinweis[(Das ständige Scheitern der Schweizer Politik wurde langsam peinlich, also liess man es einfach ganz bleiben)].


= Verteilung
Was heisst Umverteilung von Wohlstand? Erhöht man den Wohlstand einer Person, muss zuvor einer anderen Person ein Teil seines
Wohlstandes weggenommen werden.

_Pareto-Effizienz_: Eine wirtschaftspolitische Massnahme ist dann effizient, wenn sie die Situation eines Einzelnen verbessert,
ohne andere schlechter zu stellen. Es gilt also, den Wohlstand in einem ersten Schritt insgesamt zu vergrössern
#hinweis[("ein grosser Kuchen lässt sich einfacher verteilen als ein kleiner Kuchen")].

Die Einkommensverteilung hängt von der _Produktivität_ und _Arbeitszeit der Arbeitenden_ ab.
Weniger Leistungsfähige #hinweis[(Kinder, Alte, Kranke)] verdienen demnach weniger.
Will die Gesellschaft diese Konsequenz nicht akzeptieren, so muss _umverteilt_ werden.

== Problematik der Umverteilung
Es gibt einen _Zielkonflikt_ zwischen Effizienz und Verteilung: Wird zu viel umverteilt, gibt es weniger Anreize zu
persönlicher Leistung; wird zu wenig umverteilt, wird dies von der Gesellschaft als ungerecht empfunden.

Die Herausforderung besteht also darin, die sozialpolitischen Instrumente so zu konzipieren, dass die Verteilungsziele mit
möglichst geringen Anreizen zur Verschwendung von Ressourcen erreicht werden; eine Balance zwischen absoluter sozialer
Gerechtigkeit und absoluter Leistungsgerechtigkeit zu finden #hinweis[(z.B. Reiche so besteuern, dass sie nicht auswandern)].

== Messung der Verteilung
#grid(
  columns: (1fr, 1.5fr),
  [
    Die _Verteilung des Vermögens oder Einkommens_ innerhalb einer Bevölkerung wird durch den _Gini-Koeffizient_ gemessen.
    Dafür wird auf einem Graph das Verhältnis von Familien zu ihrem Einkommen/Vermögen eingetragen.
    Bei perfekter Gleichverteilung müsste sich eine Gerade ergeben. Dies ist aber nie der Fall, also ergibt sich eine
    _Lorenzkurve_: je "bauchiger" diese ist, desto ungleicher ist das Einkommen/Vermögen in einer Bevölkerung verteilt.

    Für Einkommen ist 55 ein hoher, 25 ein tiefer Gini-Koeffizient. Für Vermögen ist 80 hoch.
  ],
  figure(caption: [Gini-Koeffizient], image("img/vwl/gini-koeffizient.png")),
)

#definition[$ "Gini-Koeffizient" = "Fläche Lorenzkurve"/"Fläche Dreieck 0AB" dot 100 $]

#grid(
  columns: (1.25fr, 1fr),
  figure(caption: [Gini-Koeffizient international], image("img/vwl/gini-international.png")),
  figure(caption: [Vermögensverteilung international], image("img/vwl/vermögen-international.png")),
)

=== Vermögensverteilung in der Schweiz
Eine Studie der UNO-Universität (UNU 2010) verglich 165 Länder. Nur in Namibia #hinweis[(0.947)] und Singapur #hinweis[(0.893)]
waren die Vermögen noch ungleicher verteilt als in der Schweiz -- hierzulande betrug der Gini-Koeffizient 0.881.
Doch bei diesen Zahlen ist _Vorsicht_ geboten: Oft werden nur die Zahlen der Steuererklärungen genommen, dabei wird aber das
Geld in der BVG #hinweis[(Berufliche Vorsorge, 2. Säule)], der 3. Säule und die Immobilien zu Marktwerten nicht berücksichtigt.
Damit wäre der Anteil des reichsten Prozents in der Schweiz bei 25-28% anstatt 40%.

#grid(
  columns: (1.25fr, 1fr),
  figure(
    caption: [Vermögensberechnung in der Schweiz aufgrund von Steuererklärungen],
    image("img/vwl/vermögen-steuererklärung.png"),
  ),
  figure(
    caption: [Vermögensberechnung in der Schweiz mit Steuererklärung plus Anlagen],
    image("img/vwl/vermögen-mit-anlagen.png"),
  ),
)

== Instrumente der Umverteilung
#table(
  columns: (1fr, 2.6fr),
  table.header([Einkommensquellen], [Arten der Umverteilung]),
  [
    - Lohn
    - Erträge aus Vermögen
    - Staatliche Transfers\ #hinweis[(Sozialversicherungen, Subventionen etc.)]
  ],
  [
    Basierend auf Alter/Tod, Arbeitslosigkeit, Gesundheit, Kinder & Bedürftigkeit
    - Umverteilung über die Einnahmensseite
      - Progressives Steuersystem #hinweis[(Einkommens- & Vermögenssteuer)]
    - Umverteilung über die Ausgabensseite
      - Direkte Geldtransfers
      - Verbilligung von staatlichen Leistungen #hinweis[(z.B. Krankenkassenprämien)]
  ],
)

#grid(
  align: horizon,
  figure(
    caption: [Staatliche Transfers verschieben die Einkommensverteilung],
    image("img/vwl/staatliche-transfers.png"),
  ),
  [#figure(
    caption: [Umverteilung international],
    image("img/vwl/umverteilung-international.png"),
  ) <umverteilung-international>],
)

Wie in @umverteilung-international sichtbar, wird in der Schweiz im europäischen Vergleich relativ wenig Wohlstand umverteilt.
Das geschieht, weil der Gini-Koeffizient in der Schweiz relativ tief ist, die Einkommen sind also schon _eher gleich verteilt_.
Die Umverteilung, die durchgeführt wird, wird vor allem durch die Sozialwerke ausgelöst.
Der Anteil der Staatsausgaben, welche für Soziale Sicherheit ausgegeben wird, stieg von 30.6% in 1990 auf 39.6% in 2010.

#grid(
  columns: (1fr, 1fr),
  align: horizon,
  figure(
    caption: [Übersicht der Schweizer Sozialwerke und die dadurch adressierten Risiken],
    image("img/vwl/schweizer-sozialwerke.png"),
  ),
  figure(caption: [Verteilung der Schweizer Staatsausgaben], image("img/vwl/staatsausgaben-verteilung.png")),
)

#pagebreak()

=== Altersvorsorge durch die AHV
Die Altersvorsorge in der Schweiz wird über die drei Säulen AHV #hinweis[(40%)], Berufliche Vorsorge #hinweis[(40%)] und
Selbstvorsorge #hinweis[(20%)] geregelt.
Durch die alternde Bevölkerung gerät diese allerdings in Schieflage; das Medianalter ist 57 Jahre.
Die AHV zahlt schon seit Jahren mehr aus, als sie durch Besteuerung einnimmt -- sie ist also nicht kostendeckend.
Der Rest wird durch das AHV-Vermögen gedeckt.

#grid(
  columns: (1fr, 1.3fr),
  align: horizon,
  figure(caption: [Die drei Säulen der Altersvorsorge], image("img/vwl/altersvorsorge-schweiz.png")),
  figure(caption: [Alterspyramiden Schweiz], image("img/vwl/alterspyramide-schweiz.png")),
)

==== Lösungsansätze
#v(-0.25em)
#table(
  columns: (1fr, 1.05fr),
  table.header(
    [Wirtschaftspolitisch direkt beeinflussbare Parameter], [Wirtschaftspolitisch indirekt beeinflussbare Parameter]
  ),
  [
    - Höhe der AHV-Beiträge #hinweis[(Arbeiter zahlen mehr ein)]
    - Höhe der Renten #hinweis[(Rentner erhalten weniger)]
    - Höhe des Rentenalters #hinweis[(Pension beginnt später)]
  ],
  [
    - Immigration #hinweis[(verschiebt das Problem nur)]
    - Geburtenrate #hinweis[(verschiebt das Problem nur)]
    - Wirtschaftswachstum #hinweis[(höheres BIP pro Kopf)]
  ],
)

==== Die AHV-Vorlagen vom 3. März 2024
#v(-0.25em)
#table(
  columns: (1fr, 1fr),
  table.header(["Für ein besseres Leben im Alter"], ["Für eine sichere und nachhaltige Altersvorsorge"]),
  [
    - Einführung einer 13. AHV-Rente unter Wahrung von bestehenden Ersatzleistungsansprüchen
    - Finanzierung bleibt offen
    Angenommen mit 58.1% Ja
  ],
  [
    - Erhöhung des Rentenalters auf 66 Jahre bis 2033
    - Danach automatische Erhöhung des Rentenalters auf 80% der zusätzlichen Lebenserwartung
    Abgelehnt mit 25.2% Ja
  ],
)

Die "Pro-Rentner"-Vorlage wurde angenommen, die "Kontra-Rentner"-Vorlage nicht.
Wenig überraschend, da ältere Menschen eher abstimmen gehen als jüngere.

=== Altersvorsorge durch das BVG
Die BVG #hinweis[(Berufliche Vorsorge)] ist die zweite Säule der Schweizer Altersvorsorge.
Die Sparphase #hinweis[(Erhebung von Sparbeiträgen)] beginnt ab dem vollendeten 24. Lebensjahr, zusammen mit dem Erreichen
eines jährlichen Mindesteinkommens von CHF 22'050.
Im Obligatorium berücksichtigt sind die Lohnbestandteile bis maximal CHF 88'200 pro Jahr.
Der Koordinationsabzug beträgt fix CHF 25'725.
Die jährlichen _Sparbeiträge_ betragen abhängig vom Alter 7%, 10%, 15% oder 18% #hinweis[(je älter, desto mehr)].
Das Alterskapital wird mit dem geltenden Mindestzins verzinst #hinweis[(aktuell 1,25%)].

Der _Mindestzinssatz_ wird vom Bundesrat festgelegt.
Er bietet für die Versicherungsnehmer eine Sicherheit durch eine garantierte Verzinsung des Sparkapitals.
Bis Anfang der 2000er lag er konstant bei 4%, heute bei 1.25%.
Liegt eine Pensionskasse darüber, hat sie _Überdeckung_, ansonsten _Unterdeckung._

Der _Deckungsgrad_ sagt aus, wie gut eine Pensionskasse ihre Auszahlungen an die Rentner decken kann.
Sie stieg in den letzten Jahren rasant an und lag bei den meisten Pensionskassen zwischen 180%-200%.

Der _Umwandlungssatz_ legt fest, welcher Prozentsatz des angesparten Vermögens pro Jahr mindestens als _Rente ausbezahlt_
werden muss. Dieser wird vom Parlament beschlossen.
Der Umwandlungssatz bedeutet eine Vermögensumverteilung von wenig lang zu länger Lebenden.
2005 lag der Umwandlungssatz für das _obligatorische Altersguthaben_ noch bei 7.2%.
Bis 2014 wurde dieser schrittweise auf den heute gültigen Satz von 6.8% gesenkt.

Gegen eine vom Parlament geplante weitere Kürzung des Umwandlungssatzes auf 6.4% wurde 2010 erfolgreich das Referendum ergriffen
#hinweis[(mit über 70% der Stimmen)]. Auch die Senkung des Umwandlungssatzes auf 6.0%
#hinweis[(Abstimmung zur Vorlage «Altersvorsorge 2020»)] wurde durch das Volk 2017 abgelehnt.

Das _obligatorische Altersguthaben_ besteht aus Beiträgen für jährliche Lohnanteile von CHF 21'510 (2021) bis CHF 84'000.
Der überobligatorische Teil #hinweis[(für die Lohnanteile über CHF 84'000)] ist gesetzlich nicht vorgeschrieben.
Der Umwandlungssatz für den überobligatorischen Teil ist deutlich geringer und von Pensionskasse zu Pensionskasse unterschiedlich.

#grid(
  columns: (1.2fr, 1fr),
  align: horizon,
  figure(caption: [Finanzierung der 2. Säule], image("img/vwl/zweite-säule.png", width: 87%)),
  figure(caption: [Deckungsgrad nach Pensionskassen-Grösse], image("img/vwl/deckungsgrad.png", width: 86%)),
)

== Bedingungsloses Grundeinkommen
2012 war der Start der Unterschriftensammlung für ein BGE mit Unterstützung durch Syna, SP, PdA und weitere.
Die Volksinitiative war 2013 erfolgreich zustande gekommen. Abstimmung war am 5. Juni 2016, sie wurde mit 23.1% Ja abgelehnt.

#v(-0.5em)
#table(
  columns: (1fr, 1.3fr),
  table.header([Gesetzestext], [Vorstellungen des Initiativkomitees]),
  [
    *Art. 110a (neu) bedingungsloses Grundeinkommen*
    + Der Bund sorgt für die Einführung eines bedingungslosen Grundeinkommens.
    + Das Grundeinkommen soll der ganzen Bevölkerung ein menschenwürdiges Dasein und
      die Teilnahme am öffentlichen Leben ermöglichen.
    + Das Gesetz regelt insbesondere die Finanzierung und die Höhe des Grundeinkommens.
  ],
  [
    Jede rechtmässig in der Schweiz sich aufhaltende Person erhält ein bedingungsloses Grundeinkommen. Vorgeschlagen wird:\
    Erwachsene CHF 2'500, Kinder CHF 625 (zuerst CHF 800)\
    Das Grundeinkommen ersetzt dabei bestehende Einkommen, zum Beispiel:\
    - vorher: Lohn 6'000
    - nachher: Lohn 3'500 und Grundeinkommen 2'500

    Profitieren werden also nur Personen mit keinem oder kleinem Einkommen.
  ],
)

#grid(
  [
    Finanziert soll das BGE (Stand 4. März 2016) wie folgt werden:
    - _62 Mia.:_ Durch vollständiges Ersetzen von AHV, Sozialhilfe, Familienzulagen, Stipendien und
      teilweises Ersetzen von IV, EL, ALV
    - _5 Mia.:_ Streichen von Agrarsubventionen sowie Einsparungen bei der "Bürokratie"
    - _107 Mia.:_ Verrechnungen des BGE bei den Löhnen (100% ab 4'000.-)
    - _34 Mia.:_ Erhöhung der MWST um 10% und höhere Energiesteuern (10 Mia.), "Geschenk" der Pensionskassen (10 Mia.),
      weitere 14 Mia. noch unklar.
  ],
  figure(
    caption: [Ersetzte Sozialwerke durch Bedingungsloses Grundeinkommen],
    image("img/vwl/bedingungsloses-grundeinkommen.png"),
  ),
)

= Konjunktur
== Das makroökonomische Modell
#grid(
  columns: (1fr, 1fr),
  align: horizon,
  [
    Mit dem makroökonomischen Modell kann die Wirtschaftsleistung eines Landes betrachten werden.
    Unternehmen _erstellen_ dabei _Güter_, welche von Haushalten, Unternehmen, Staat und Ausland _nachgefragt_ werden.
    Dem Modell liegt der _Marktgedanke_ zu Grunde, bei welchem Angebot und Nachfrage das gesamtwirtschaftliche Preisniveau
    sowie die Höhe der inländischen Wertschöpfung definiert.
    Dieses Modell hilft uns unter anderem, die Auswirkungen von Konjunkturschwankungen zu verstehen.

    Dabei wird auf einem Graph das Verhältnis von Preisniveau zum realen BIP eingezeichnet.
    Es befinden sich drei Kurven in diesem Graph:
    Die aggregierte Nachfragekurve $"AN"$,
    die kurzfristige aggregierte Angebotskurve $"AA"_K$ und
    die langfristige aggregierte Angebotskurve $"AA"_L$.
  ],
  figure(caption: [Gleichgewicht im makroökonomischen Modell], image("img/vwl/makro-modell.png")),
)

#grid(
  figure(caption: [Die X-Achse des Modells], image("img/vwl/makro-xachse.png")),
  figure(caption: [Die Y-Achse des Modells], image("img/vwl/makro-yachse.png")),
  figure(caption: [Die aggregierte Nachfragekurve $"AN"$], image("img/vwl/makro-an.png")),
  figure(caption: [Die kurzfristig aggregierte Angebotskurve $"AA"_K$ ], image("img/vwl/makro-aak.png")),
  figure(caption: [Die langfristig aggregierte Angebotskurve $"AA"_L$ ], image("img/vwl/makro-aal.png")),
  figure(caption: [Das makroökonomische Gleichgewicht], image("img/vwl/makro-gleichgewicht.png")),
)

Das_ makroökonomische Gleichgewicht_ ist erreicht, wenn genau so viel produziert und gekauft wird,
wie es die Kapazitätsgrenze zulässt.

#definition[$ "makroök. Gleichgewicht" = "AA"_K = "AA"_L = "AN" $]

=== Landesindex für Konsumentenpreise
Als Ausgangspunkt für das Preisniveau dient der _Landesindex der Konsumentenpreise (LIK)_, welcher jedes Jahr neu berechnet
wird. Er teilt die Ausgaben eines durchschnittlichen Bürger in verschiedene Kategorien ein und gewichtet diese entsprechend.
Es gibt auch den _Produzentenpreisindizes_, welche die Ausgaben für Firmen darstellt.

#grid(
  align: horizon,
  figure(caption: [LIK-Warenkorb in 2022], image("img/vwl/lik.png")),
  figure(caption: [Güterkörbe für Produzentenpreisindizes], image("img/vwl/produzent-preisindex.png")),
)

#table(
  columns: (auto,) + (1fr,) * 6,
  align: (x, y) => if (y > 0 and x > 0) { right } else { auto },
  table.header([Allg. CH-Preisentwicklung in %], [2017], [2018], [2019], [2020], [2021], [2022]),
  [*Konsumentenpreise*], [0.5], [0.9], [0.4], [-0.7], [0.6], [2.8],
  [*Produzenten- und Importpreise*], [0.5], [0.4], [-1.0], [-1.2], [3.1], [2.6],
)

Ist der Produzentenpreis höher als der Konsumentenpreis, machen die Firmen Verlust.

#pagebreak()

== Konjunkturentwicklung
Die Konjunktur ist eine kurzfristige Wirtschaftsentwicklung und kann stark schwanken.
Eine _Rezession_ tritt ein, wenn das BIP während mindestens zwei aufeinanderfolgenden Quartalen abnimmt.

#grid(
  figure(caption: [Konjunktur-Modell], image("img/vwl/konjunktur.png")),
  figure(caption: [Konjunkturentwicklung in der Schweiz], image("img/vwl/konjunktur-schweiz.png")),
)

#table(
  columns: (1fr,) * 3,
  table.header([Vorauseilende Indikatoren], [Gleichlaufende Indikatoren], [Nachhinkende Indikatoren]),
  [
    - Konsumentenstimmung
    - Bestellungseingänge
    - Investitionsverhalten
    - Veränderung der Geldmenge
    - Wechselkursentwicklung
    - Konjunkturbarometer #hinweis[(KOF der ETH)]
  ],
  [
    - Konsumverlauf
    - Export- & Importentwicklung
    - Bruttoanlageinvestitionen
  ],
  [
    - Preisentwicklung #hinweis[(Inflation)]
    - Lohnentwicklung
    - Entwicklung der Arbeitslosigkeit
    - Zinsentwicklung
  ],
)

== Konjunkturschocks
Durch plötzliche Änderungen an der Wirtschaft können _Konjunkturschocks_ entstehen.
Dabei wird immer im Makroökonomischen Modell eine Kurve stark verschoben.
Es gibt 4 verschiedene Arten von Konjunkturschocks:

=== Negativer Nachfrageschock
Die Nachfragekurve $"AN"$ verschiebt sich nach links, weil Haushalte weniger konsumieren, Firmen weniger investieren,
der Staat weniger ausgibt, mehr Importe, weniger Exporte...
Das führt zu einem _geringeren Preisniveau_ #hinweis[(Deflation)] und zu einem _kleineren BIP_ #hinweis[(Rezession)],
was zu _Arbeitslosigkeit_ führt.

#grid(
  align: horizon,
  figure(caption: [Negativer Nachfrageschock], image("img/vwl/makro-neg-nachfr-1.png")),
  figure(caption: [Allgemeiner Nachfrageschock], image("img/vwl/makro-neg-nachfr-2.png")),
)

#pagebreak()

=== Positiver Nachfrageschock
Die Nachfragekurve $"AN"$ verschiebt sich nach rechts, weil Haushalte mehr konsumieren, Firmen mehr investieren,
der Staat mehr ausgibt, weniger Importe, erhöhte Geldmenge, Staatsverschuldung...
Dadurch _steigt das Preisniveau_ #hinweis[(Inflation)] sowie das BIP #hinweis[(mehr Arbeitsstellen)].

#grid(
  align: horizon,
  figure(caption: [Positiver Nachfrageschock], image("img/vwl/makro-pos-nachfr-1.png")),
  figure(caption: [Gesamtwirtschaftliches Angebot in der kurzen Frist], image("img/vwl/makro-pos-nachfr-2.png")),
)

=== Negativer Angebotsschock
#grid(
  [
    Die kurzfristig aggregierte Angebotskurve $"AA"_K$ verschiebt sich nach links durch Erhöhungen der Produktionskosten,
    höhere Löhne oder höhere Steuern. Dadurch _steigt das Preisniveau_ und das _BIP sinkt_.

    Eine _"Stagflation"_ entsteht: Die Wirtschaft stagniert und gleichzeitig herrscht eine Inflation.
    Die _Arbeitslosigkeit steigt_ und wird durch übliche wirtschaftspolitische Massnahmen wie Zinserhöhungen noch verstärkt.
  ],
  figure(caption: [Negativer Angebotsschock], image("img/vwl/makro-neg-angebot.png")),
)

=== Positiver Angebotsschock
#grid(
  [
    Die kurzfristig aggregierte Angebotskurve $"AA"_K$ verschiebt sich nach rechts durch
    Senkungen der Produktionskosten (Innovation), tiefere Löhne oder tiefere Steuern.
    Durch das sinkende Preisniveau wird eine _Deflation_ ausgelöst und das _BIP steigt_, was zu _mehr Arbeitsstellen_ und
    schlussendlich zu einem _höheren Wohlstand in der Allgemeinheit_ führt.

    Der positive Angebotsschock ist der einzige, welcher als _vorteilhaft für die Gesamtwirtschaft_ angesehen wird.
  ],
  figure(caption: [Positiver Angebotsschock], image("img/vwl/makro-pos-angebot.png")),
)

#pagebreak()

== Konjunkturzyklen
Die Angebotsschocks lassen sich jeweils einem Konjunkturzyklus zuordnen:
#v(-0.75em)
#table(
  columns: (1fr, auto),
  table.header([Angebotsschock], [führt zu]),
  [Positiver Nachfrageschock], [inflationärer Boom],
  [Positiver Angebotsschock], [deflationärer Boom],
  [Negativer Angebotsschock], [Stagflation],
  [Negativer Nachfrageschock], [Depression #hinweis[(das Schreiben dieser Zusammenfassung bei bestem Badewetter auch)]],
)

Die Depression ist besonders perfide: Ist man einmal drin, kommt man kaum wieder hinaus.
Japan geriet 1990 in eine Deflationsfalle und erholte sich erst nach über 20 Jahren wieder davon.

#grid(
  columns: (1fr, 1.3fr),
  align: horizon,
  figure(caption: [Konjunkturzyklen], image("img/vwl/konjunkturzyklen.png")),
  figure(caption: [Historische Konjunkturzyklen], image("img/vwl/konjunkturzyklen-international.png")),
)

== Konjunkturpolitik <beveridge-kurve>
#grid(
  columns: (2.5fr, 1fr),
  [
    Die _Beveridge-Kurve_ zeigt folgende Zusammenhänge auf: Ist die Anzahl der Arbeitssuchenden grösser als
    die Anzahl offener Stellen, spricht man von _Konjunktureller Arbeitslosigkeit_.
    Sie wird meist durch bestimmte Konjukturzyklen ausgelöst.

    Ist die Anzahl offener Stellen gleich gross oder grösser als die Anzahl Stellensuchender spricht man von _Sockelarbeitslosigkeit_.
    Dies kann zwei Gründe haben: _strukturelle Arbeitslosigkeit_ #hinweis[(z.B. Fachkräftemangel)] oder
    _friktionelle Arbeitslosigkeit_ #hinweis[(vorübergehend durch Stellenwechsel, wächst durch Ausbau der Leistungen
    der Arbeitslosenversicherung, da die Arbeitslosen dadurch weniger Zeitdruck beim Stellenwechsel haben)].

    Konjunkturelle Arbeitslosigkeit wird durch Konjunkturpolitik bekämpft.
    Konjunkturpolitik ist ein Synonym für Wachstumspolitik. Dabei werden drei verschiedene Ansätze beachtet:

  ],
  figure(caption: [Beveridge-Kurve], image("img/vwl/beveridge-kurve.png")),
)

=== Nichts tun
#grid(
  [
    _"Vertrauen in den Markt":_ Automatisches Wiederherstellen des langfristigen Gleichgewichts bei gleichem realen BIP,
    jedoch tieferem Preisniveau.

    Gemäss der mikroökonomischen Theorie sollten "funktionierende" Arbeitsmärkte kurz- bis mittelfristig von alleine wieder
    ins Gleichgewicht kommen. Die geschieht durch ein_ marktgerechtes Sinken des Lohnniveaus_.
    Durch das Sinken des Lohnniveaus entstehen _tiefere Lohnkosten_ für die Unternehmen.
    Mit den sinkenden Lohnkosten verschiebt sich die kurzfristige Angebotskurve $"AA"_K$ nach rechts.
    Ist theoretisch möglich, _praktisch sinken aber Löhne nicht (schnell genug)_.
  ],
  figure(caption: [Kurz- & langfristige Effekte des Nichtstun], image("img/vwl/konjunktur-nichtstun.png")),
)

_Kurzfristig_ wird die $"AN"$-Kurve nach links geschoben, womit das reale BIP und das Preisniveau sinken.
Die sinkende Nachfrage nach Arbeit führt zu sinkenden Nominallöhnen.
_Mittelfristig_ werden durch die geringeren Löhne die Produktionskosten gesenkt. Die $"AA"_K$-Kurve verschiebt sich nach rechts.

=== Keynesianismus
_"Vertrauen in den Staat":_ Positiver Schock auf der Nachfrageseite  ($"AN"$).
Der Staat fördert aktiv die gesamtwirtschaftliche Nachfrage durch die Fiskal- und Geldpolitik.
Die Korrektur durch "nichts tun" ist in der Praxis sehr langsam. Der Staat muss also eingreifen.

Grundsätzliches Ziel ist die _Erhöhung der aggregierten Nachfrage $"AN"$_.
#table(
  columns: (1fr, 1.5fr),
  table.header([Erhöhung der...], [...wird erreicht durch]),
  [
    + Konsumnachfrage der Haushalte\ #hinweis[(Leute sollen mehr kaufen)]
    + Investitionsnachfrage der Unternehmen
    + Konsum- und Investitionsnachfrage des Staates
    + Nettonachfrage des Auslandes #hinweis[(dies entweder durch höhere Exporte oder geringere Importe)]
  ],
  [
    *Fiskalpolitik*\
    - Stimulierung der Konsumentennachfrage durch tiefere Steuern
    - Erhöhung der Staatsausgaben (oft durch Verschuldung)

    *Geldpolitik* #hinweis[(erhöht die Geldmenge, SNB ist theoretisch unabhängig von Politik)]\
    - Stimulierung der Investitionsnachfrage durch tiefere Kreditzinsen
    - Erhöhung der Nettoexporte durch schwächere Währung
  ],
)

Eine Ausdehnung der Geldmenge führt zu _sinkenden Kreditzinsen_.
Sinkende Kreditzinsen führen zu einem _positiven Nachfrageschock_: Unternehmensinvestitionen erhöhen sich,
Haushalte sparen weniger und konsumieren dafür mehr. Der schwächere Franken erhöht die Nettoexporte.

Der Keynesianismus basiert auf den Ideen des Ökonomen John Maynard Keynes, der nach der Weltwirtschaftskrise 1929
Staatsinterventionen forderte, da seiner Ansicht nach die Arbeitsmärkte nicht wieder von alleine ins Gleichgewicht fanden.
Was nützt es den Arbeitssuchenden, wenn es ewig dauert, bis das Gleichgewicht wiederhergestellt ist.
"In the long run, we are all dead"

*Problematiken des Keynesianismus*\
Die Umsetzungen treten nur verzögert auf, sogenannte _"time lags"_:
Die Rezession wird verzögert _erkannt_, die _Implementierung_ dauert und die _Wirkungen_ treten auch erst später auf.
Die Konjunkturpolitik bekämpft oft erst dann die Rezession, während der wirtschaftliche Aufschwung
_bereits wieder voll eingesetzt_ hat.

#grid(
  align: horizon,
  figure(caption: [Aktive Konjunkturpolitik], image("img/vwl/konjunktur-keynes.png")),
  figure(caption: [Verschiebung von $"AN"$], image("img/vwl/konjunktur-verschiebung-an.png")),
)

=== Stabilisatoren
#grid(
  columns: (1fr, 1fr),
  [
    _"Vertrauen in Systeme":_ Staatliche Einnahmen und Ausgaben, die so ausgestaltet sind, dass bei einem Rückgang
    der gesamtwirtschaftlichen Nachfrage automatisch die Nachfrage stimuliert wird.
    Dadurch soll $"AN"$ automatisch wieder in die Richtung der ursprünglichen Position verschoben werden.

    *Beispiele:* _Steuern_ und die _Arbeitslosenversicherung_.
  ],
  figure(caption: [Konjunkturstabilisatoren], image("img/vwl/konjunktur-stabilisatoren.png")),
)

== Schweizerische Konjunkturpolitik
Die schweizerische Bundesverfassung gibt dem Staat einen klaren konjunkturpolitischen Auftrag (Art. 100).
Er muss Arbeitslosigkeit und Teuerung bekämpfen. Auch die Nationalbank hat eine entsprechende Verpflichtung und muss in
der Geldpolitik der Konjunktur Rechnung tragen (Nationalbankgesetz Art. 5).

In der Schweiz werden keynesianische Elemente in der Konjunkturpolitik kaum angewendet.
Ein Grund dafür ist das föderalistische Staatssystem #hinweis[(Bund, Kantone und Gemeinden)].
Die Schweizerische Konjunkturpolitik setzt vor allem auf die Anwendung von automatischen Stabilisatoren:
_Schuldenbremse_, _Arbeitslosenversicherung_, _Progressives Steuersystem_

Auch die Schweizerische Nationalbank SNB hat sich in der Vergangenheit durch eine vorsichtige Anwendung der Geldpolitik
im Rahmen der Konjunkturpolitik ausgezeichnet #hinweis[(diese Haltung hat sich allerdings in den letzten Jahren stark verändert)].

=== Schweizer Krisenbewältigung 2008 & 2020
In den wenigen Fällen, in denen die Schweiz eine aktive «keynesianische» Konjunkturpolitik betrieben hat, war die Bilanz
in der Vergangenheit eher schlecht. Kein vergleichbares Land hat die Konjunkturschwankungen fiskalpolitisch in solchem
Ausmass negativ verstärkt wie die Schweiz. Die Massnahmen von 2008-2010 auf die Finanzkrise 2008 sollten
_"timely, targeted, temporary"_ sein -- schnell den Betroffenen temporär unter die Arme greifen.

- _Erste Stufe 2009 (982 Mio. CHF):_ Aufhebung der Kreditsperren verschiedener Departements,
  Freigabe Arbeitsbeschaffungsreserven #hinweis[(freiwillige, unversteuerte Einzahlung von Unternehmensgewinnen)],
  Gebäudesanierungen Parlament
- _Zweite Stufe 2009 (710 Mio. CHF):_ Investitionen in Schiene, Strasse, Infrastruktur, Forschung und Erneuerbare Energien
- _Dritte Stufe 2010 (944 Mio. CHF):_ Kurzarbeit, Frühzeitige Rückverteilung der CO2-Abgaben an Krankenkassen

Diese obigen Massnahmen waren das Gegenteil .
Der Bund musste also feststellen, dass er nur wenige Investitionsmöglichkeiten hat, die sich als
Konjunkturstützungsmassnahmen eigenen.

*Corona-Krise*\
Die 60 Milliarden Franken teuren Massnahmen zur Corona-Krise teilten sich auf in
- _zurückzahlbare Kredite:_ Liquiditätshilfen für Unternehmen durch Kredite und Zahlungsaufschübe der Sozialversicherungen,
  Ausbau Kurzarbeit
- _nicht-zurückzahlbare Entschädigungen:_ Erwerbsausfälle bei Selbstständigen, Angestellten, Kultur- & Sportentschädigungen.

Diese Massnahmen sind viel zielgerichteter als noch 2008 und erfüllen die Anforderung von "timely, targeted, temporary".
Um die Betroffenen weiter zu entlasten sollen die Kredite über 12 Jahre statt ursprünglich 6 stattfinden.

Eins ist aber klar: _"Nach der Krise ist vor der Krise"_, die nächste Krise kommt bestimmt.

#pagebreak()

= Preisstabilität
Inflation bedeutet eine permanente Steigerung des Preisniveaus.
Auslöser einer Inflation ist eine einmalige Steigerung des Preisniveaus z.B.
durch einen _expansiven Nachfrageschock_ #hinweis[(z.B. Erhöhung der Geldmenge usw.)] oder
durch einen _negativen Angebotsschock_ #hinweis[(z.B. höhere Importpreise, höhere Unternehmenssteuern, höhere Lohnkosten usw.)].
Ob eine einmalige Preissteigerung zu einer Inflation führt, hängt von den _Inflationserwartungen der Haushalte und Unternehmen_
sowie von der Reaktion der Geldpolitik der Zentralbank ab #hinweis[(Bereitschaft zur Ausdehnung der Geldmenge)].

Der Staat finanziert sich auf drei Arten: _Steuern_, _Verschuldung_, _Inflation_

== Inflation
Bei der _nachfrageseitigen Inflation_ ist ein positiver Nachfrageschock der mögliche Inflationsauslöser
#hinweis[(z.B. höhere Staatsausgaben)].
Das Ergebnis ist eine _geringe Ausweitung des realen BIP_, aber eine _deutliche Erhöhung des Preisniveaus_.
Bei gut ausgelasteten Kapazitäten hat eine Nachfragestimulierung vor allem eine Wirkung auf das Preisniveau.
In @inflation-nachfrage wird ersichtlich, dass die Veränderung im Preisniveau viel markanter ausfällt als die Reaktion
des realen BIPs, da die Möglichkeiten zu Produktionsausweitung begrenzt sind.
Aus einer solchen Situation kann schliesslich eine Inflation entstehen.

Bei der _angebotsseitigen Inflation_ liegt ein negativer Angebotsschock zugrunde, z.B. ausgelöst durch einen starken
Erdöl-Preisanstieg. Er verschiebt die kurzfristige AA-Kurve nach links.
Die Verteuerung dieses wichtigen Inputfaktors bewirkt, dass bei jedem Preisniveau weniger produziert wird.
Das Unangenehme an einem Angebotsschock ist, dass gleichzeitig das Preisniveau ansteigt und das BIP zurückgeht.
Dieses Phänomen wird mit dem Begriff _Stagflation_ bezeichnet.

#grid(
  [#figure(caption: [Nachfrageseitige Inflation], image("img/vwl/inflation-nachfrage.png")) <inflation-nachfrage>],
  figure(caption: [Angebotsseitige Inflation], image("img/vwl/inflation-angebot.png")),
)

=== Permanenz durch Lohn-Preis-Spirale
Erhöhtes Preisniveau durch einmaligen Schock, dadurch ...
+ Sinkende Reallöhne der Haushalte
+ Diese fordern wegen Inflationserwartung eine Steigerung der Nominallöhne, welche die Erhöhung des\
  Preisniveaus überkompensieren #hinweis[(Falls die Haushalte keine Inflationserwartung haben, werden sie nur eine Steigerung
  der Nominallöhne auf das alte (Real-)Lohnniveau verlangen. Damit entsteht keine Inflation.)]
+ Damit ergibt sich eine Steigerung der Reallöhne
+ Dies bedeutet für die Unternehmen eine Kostensteigerung
+ Die Unternehmen werden deshalb höhere Güterpreise verlangen
+ Damit erhöht sich wieder das Preisniveau (Zweitrundeneffekt, zurück zu Punkt 1)

Befriedigt die Geldpolitik die erhöhte Nachfrage nach Geld (ausgelöst durch Erhöhung des allgemeinen Preisniveaus),
mit einem _erhöhten Geldangebot_ besteht die Gefahr, dass eine Lohn-Preis-Spirale in Gang gesetzt wird.

=== Inflationserwartung- und Wahrnehmung
#grid(
  align: horizon,
  [
    Eine Umfrage zur Inflationserwartung wird durch die SECO vierteljährlich durchgeführt.
    1200 Haushalte werden zu ihrer Einschätzung, wie sich die Inflation in nächste 12 Monaten entwickelt, befragt.
    Die auswählbaren Kategorien sind grob: "stark steigen", "nahezu unverändert", "deutlich zurück".
    Die Meinungsbildung ist abhängig von alltäglichen Erfahrungen, z.B. der Einkauf im Supermarkt.

    63 Prozent der befragten Schweizer Ökonomen zeigen sich zuversichtlich, dass es sich beim Inflationsdruck nach Corona
    um ein primär temporäres Phänomen handelt.
    Damit wäre die Inflation durch Anstieg der Rohstoffpreise & Preissteigerung in Waren, welche sich in Lieferengpässen
    befinden zu erklären.
  ],
  figure(caption: [Inflationswahrnehmung in der Schweiz], image("img/vwl/inflation-erwartung.png")),
)

Ein Drittel geht jedoch von einem dauerhaften Problem aus -- das wäre sie, wenn Zweitrundeneffekte wie Lohnsteigerungen
eintreten würden. Hinter dem Inflationsanstieg könnten entweder ein _"cost-push"_ der Unternehmen sein
#hinweis[(teurere Rohstoffe und knappere Arbeitskräfte -- angebotsseitige Inflation)] oder ein _"demand-pull"_ der Konsumenten
#hinweis[(gestiegene Kauflust nach Corona -- nachfrageseitige Inflation)].

=== Quantitätsgleichung <quantitätsgleichung>
Wie sieht der theoretische Zusammenhang zwischen der Geldpolitik der Zentralbanken und der Inflation aus?

#definition[
  #grid(
    columns: (1fr, 1.1fr),
    align: horizon,
    [$ P dot Q = M dot V $],
    [
      _$bold(P)$:_ Preisniveau\
      _$bold(Q)$:_ Reales BIP\
      _$bold(M)$:_ Geldmenge\
      _$bold(V)$:_ Geldumlaufgeschwindigkeit
      #hinweis[(Kann nicht gemessen werden, ergibt sich automatisch, wenn die anderen Grössen bekannt)]
    ],
  )
]

#grid(
  [
    Ist die volkswirtschaftliche Kapazität _nicht ausgelastet_ #hinweis[($"AN"$ links der Kapazitätsgrenze)] und
    die Geldmenge $M$ wird erhöht, steigen $P$ und $Q$ ebenfalls an, während $V$ gleich bleibt.
    Da $Delta P < Delta Q$ ist, steigt das reale BIP schneller als das Preisniveau an --
    die Bürger haben also mehr Geld, der Wohlstand steigt.

    Ist die volkswirtschaftliche Kapazität aber _voll ausgelastet_ #hinweis[($"AN"$ rechts der Kapazitätsgrenze)] und
    die Geldmenge $M$ wird erhöht, steigen $P$ und $Q$ ebenfalls an.
    Da aber $Delta P > Delta Q$ ist, werden die realen BIP-Erhöhungen durch die teureren Preise aufgefressen.
  ],
  figure(caption: [Geldmengenerhöhung], image("img/vwl/geldmengenerhöhung.png")),
)

=== Inflationsauslöser
#grid(
  [
    - _Transaktionskosten_: Viele kleinere Bankabhebungen #hinweis[(nur bei ausschliesslicher Barzahlung)]
    - _Kosten der Unsicherheit:_ (Zu) hohe Nominalzinsen auf Kredite #hinweis[(um Inflation zuvorzukommen)]
    - _Kosten aufgrund der kalten Progression der Steuern_: Höheres Nominaleinkommen führt zur Einstufung
      in höhere Steuerklassen
  ],
  [
    - _Kosten aufgrund der Verzerrung der relativen Preise_: Verwischung der Knappheitssignale, da sich
      Güterpreise unterschiedlich schnell anpassen #hinweis[(nicht klar, ob Preis gut)]
    - _Kosten für die Kreditgeber_: Inflation frisst Realzinsen bzw. Kapital der Haushalte auf
      #hinweis[(Staat kann so seine Schulden abbauen, durch Inflation werden reale Schulden kleiner)]
    - _Handelsdefizit_: Entweder sinkende Importe oder steigende Exporte
  ],
)

=== Inflationsbekämpfung
#grid(
  columns: (3fr, 1fr),
  [
    Die _Phillips-Kurve_ geht von einem _negativen Zusammenhang_ zwischen _Inflation und Arbeitslosigkeit_ aus.
    Ist die Wirtschaft stark ausgelastet, besteht eine Tendenz zu einer hohen Inflation,
    die Arbeitslosigkeit bewegt sich dann auf einem tiefen Niveau.

    Bei schwach ausgelasteter Wirtschaft ist die Arbeitslosigkeit hoch, jedoch der Inflationsdruck gering.
    Für die Wirtschaftspolitik spielt die Phillips-Kurve lange Zeit eine wichtige Rolle, da sie es der Politik scheinbar
    erlaubte, sich eine Kombination von Inflation und Arbeitslosigkeit auf der Kurve "auszusuchen".
  ],
  figure(caption: [Phillips-Kurve], image("img/vwl/phillips-kurve.png")),
)

#v(-0.5em)
== Deflation
Deflation bedeutet ein _permanenter Rückgang des Preisniveaus_.
Deflation ist dann schädlich, wenn diese auf einem Rückgang der aggregierten Nachfrage ($"AN"$) beruht.
Ein Preisrückgang aufgrund einer Ausweitung des aggregierten Angebots ($"AA"$) kann hingegen positiv beurteilt werden.

Bei einer _angebotsseitiger Deflation_ wird $"AA"$ nach rechts verschoben z.B. durch neue Technologien,
welche mehr Produktivität auf jedem Preisniveau ermöglichen.
Das Preisniveau sinkt, aber der reale BIP wird auch grösser. Der Wohlstand steigt also.

Bei _nachfrageseitiger Deflation_ wird der Preisrückgang durch weniger Konsum der Bevölkerung ausgelöst.
$"AN"$ verschiebt sich also nach links. Die Preise und das BIP sinken.
Die Konsumenten verstärken diesen Effekt, weil sie warten, bis die Produkte billiger werden.

#grid(
  figure(caption: [Angebotsseitge Deflation], image("img/vwl/deflation-angebot.png")),
  figure(caption: [Nachfrageseitige Deflation], image("img/vwl/deflation-nachfrage.png")),
)

=== Bekämpfung der Deflation
Folgende vier Effekte verursachen hartnäckige Probleme, welche mit Hilfe der konventionellen Geld- und Fiskalpolitik
kaum mehr zu lösen sind:
+ _Selbstverstärkende Wirkung_: Ausgelöst durch ausgeprägte Deflationserwartungen #hinweis[(Es wird mehr gespart)]
+ _Hohe Realzinsen:_ $"Realzins" = "Nominalzins (minimal 0%)" + "erwartete Deflation"$
+ _Steigende Reallöhne:_ Steigende Produktionskosten für Unternehmen
+ _Sinkende Bonität der Schuldner und Bankkrisen:_ Kreditgeber gewinnen #hinweis[(Haushalte)],
  Kreditnehmer verlieren #hinweis[(steigender Realwert der Schulden)]

#v(-0.5em)
#table(
  columns: (1.2fr, 1fr),
  table.header([Geldpolitik], [Fiskalpolitik]),
  [
    Die Geldpolitik versagt bei der Bekämpfung der Deflation, weil _Nominalzinsen nicht kleiner als 0%_ sein können.
    Eine weitere Ausdehnung der Geldmenge hat _keine Auswirkungen_ mehr auf den Zins und damit auf die Realwirtschaft.
  ],
  [
    Eine Bekämpfung der Deflation mittels Fiskalpolitik #hinweis[(Erhöhung der Staatsausgaben, Steuersenkungen)]
    führt in der Regel zu einer hohen Staatsverschuldung.
  ],
)

*Fazit:* Um eine Deflation im Vornherein zu vermeiden, wird in der Regel Preisstabilität nicht als Wert zwischen -1% und +1%
verstanden, sondern als Wert zwischen 0% und 2% (zur Verringerung der Gefahr einer Deflation)

=== Fall Japan: Immobilienblase & Deflationsfalle
1990 hatte der gesamte japanische Immobilienmarkt den _vierfachen Wert des US-Marktes_, obwohl das Land nicht einmal halb
so gross ist. Das Grundstück des japanischen Kaiserpalastes allein war mehr wert als alle Immobilien in Kalifornien oder Kanada.
Die Immobilien in Tokio machten _zwei Drittel des gesamten Immobilienwertes der Welt_ (!) aus.
Die Blase war um ein vielfaches grösser als die Immobilienblase der Finanzkrise 2008.

Im Jahr 1990 brach die "Japan AG" zusammen. Der Nikkei verlor binnen Jahresfrist über 40 Prozent und stürzten das Land
in eine der schlimmsten Krisen, von denen sich das Reich der aufgehenden Sonne sich erst in den letzten Jahren erholen konnte.

_Abenomics_ ist der radikale Versuch der japanischen Regierung unter der Führung von Ministerpräsident Shinzo Abe,
die Wirtschaft aus der jahrzehntelangen Lethargie zu reissen, die Deflationsfalle zu überwinden und letztlich einen
Staatsbankrott abzuwenden (Japan ist derzeit mit rund 250% seines BIP verschuldet).

Die Strategie basiert auf drei Säulen:
+ _Geldpolitik_: Geld drucken, um dadurch die Inflation über 2% zu bekommen.
+ _Fiskalpolitik_: weiter Defizite machen #hinweis[(zur Zeit ca. 10% vom BIP)]
+ _Strukturreformen_: mit Reformen das Wachstumspotential stärken #hinweis[(z.B. durch eine höhere Erwerbsquote von Frauen)]

Die Deflation konnte nach 30 Jahren abgewendet werden. Die Japaner müssen nun lernen, mit steigenden Preisen und Löhnen zu leben.
Das Inflationsziel von 2% ist erreicht. Firmen zeigen sich bereit, höhere Preise in Form von höheren Löhnen weiterzugeben.

= Markt und Preise
Transaktionen zwischen Haushalten und Unternehmen finden auf "Märkten" statt.
Ein Markt repräsentiert das _Zusammentreffen von Angebot und Nachfrage_.

#table(
  columns: (1fr,) * 3,
  table.header([Gütermarkt], [Arbeitsmarkt], [Kapitalmarkt]),
  [Auf dem Gütermarkt findet der Austausch von Gütern und Dienstleistungen statt.],
  [Auf dem Arbeitsmarkt findet der Austausch des Produktionsfaktors Arbeit statt.],
  [Auf dem Kapitalmarkt findet der Austausch von finanziellen Mitteln statt.],

  [
    *Anbieter:* Unternehmen\
    *Nachfrager:* Haushalte
  ],
  [
    *Anbieter:* Haushalte\
    *Nachfrager:* Unternehmen
  ],
  [
    *Anbieter:* Haushalte\
    *Nachfrager:* Unternehmen
  ],

  [
    *X-Achse:* Gütermenge\
    *Y-Achse:* Preis
  ],
  [
    *X-Achse:* Arbeitsmenge\
    *Y-Achse:* Lohn
  ],
  [
    *X-Achse:* Kreditmenge\
    *Y-Achse:* Zins
  ],
)

In Knappheitssituationen muss die _volkswirtschaftliche Ausgangslage_ #hinweis[(Unbeschränkten Bedürfnissen stehen knappe
Ressourcen gegenüber)] analysiert werden und eine _notwendige Entscheidung_ getroffen werden
#hinweis[(Wie wird das verfügbare Zeit-/Finanzbudget aufgeteilt?)].

Die Konsequenz: _Oppurtunitätskosten_ sind die Kosten, welche bei einer Entscheidung anfallen, dass die Vorteile einer
Alternative nicht realisiert werden können. Sie zeigen die _relative Knappheit der Güter_ in Form von Preisen an.
Der Preis eines Gutes, für das Sie sich entschieden haben, entspricht dem Verzicht auf etwas anderes, für das Sie sich
auch entscheiden hätten können.

Veränderungen von Opportunitätskosten bewirken vor allem_ "wie viel davon"-Entscheide_ #hinweis[(marginale Entscheide)],
also keine "Alles oder nichts"-Entscheide. Wird ein Gut knapp, steigt der Preis.
Wollen Sie gleich viel von diesem Gut konsumieren, können Sie sich weniger von anderen Gütern leisten.
Deshalb führt eine _Preiserhöhung in der Regel zu einem Konsumrückgang_ des entsprechenden Gutes.

#pagebreak()

== Markt- und Planwirtschaft
Es existieren zwei unterschiedliche Vorstellungen, wie eine Volkswirtschaft organisiert sein muss, damit die
knappen Ressourcen effizient genutzt werden können

#v(-0.5em)
#table(
  columns: (1fr, 1fr),
  table.header([Planwirtschaft], [Marktwirtschaft]),
  [
    - Ressourcen gehören dem Staat
    - Zentrale Planungsbehörde lenkt Ressourceneinsatz
  ],
  [
    - Ressourcen gehören Haushalten & Firmen
    - Diese entscheiden über Ressourceneinsatz
  ],
)

=== Die unsichtbare Hand des Marktes <unsichtbare-hand>
Die "unsichtbare Hand" ist eine Idee von Adam Smith (1776): Obwohl jeder Marktteilnehmer (Haushalte, Firmen)
die eigenen Interessen verfolgt, wird der _Wohlstand der gesamten Ökonomie maximiert_.
Voraussetzung sind Preise, welche zuverlässig die relative Knappheit von Gütern und Ressourcen anzeigen.
Die Preise bestimmen also in einer Marktwirtschaft die effiziente Allokation der Ressourcen.
Damit haben die Preise eine _Signalwirkung._

Bei steigendem Preis steigen die Opportunitätskosten für den Konsum des Gutes bei den Nachfragern
#hinweis[(damit wird der Konsum gesenkt)], für den Anbieter kann sich eine Ausweitung der Produktion für das Gut lohnen
#hinweis[(Voraussetzung sind gleich bleibende oder sinkende Produktionskosten)]

== Das mikroökonomische Grundmodell <mikroökonomisches-grundmodell>
#grid(
  columns: (3fr, 1fr),
  [
    Beim Grundmodell wird das _Modell der vollkommenen Konkurrenz_ vorausgesetzt:
    - Das Gut ist völlig homogen #hinweis[(Keine Unterschiede zwischen Anbietern)]
    - Es gibt eine grosse Anzahl von Anbietern & Nachfragern
    - Es gibt keine Marktzutrittshemmnisse #hinweis[(Gleiche Konditionen, Ortsunabhängig)]
    - Anbieter & Nachfrager sind über Mengen & Preise vollständig informiert

    Dieses simple Modell besteht aus den zwei Linien Angebot $A$ und Nachfrage $N$, diese stehen in einem inversen Verhältnis
    zueinander -- je höher der Preis, desto geringer ist die Nachfrage #hinweis[(Weniger Leute wollen das Gut kaufen)],
    aber auch desto höher ist das Angebot #hinweis[(Mehr Anbieter wollen das Gut verkaufen)].

    Das Modell trifft viele Annahmen und ist nicht praxistauglich.
  ],
  figure(caption: [Das mikroökonomische Grundmodell], image("img/vwl/mikro-grundmodell.png")),
)

=== Effizienz von Markttransaktionen
#grid(
  [
    Die Effizienz der Markttransaktionen kann am Grundmodell abgelesen werden.
    Auf der linken Seite des Schnittpunkts befinden sich Güter, welche zu einem tieferen Preis als dem Marktpreis verkauft werden
    und Nachfrager, welche bereit gewesen wären, mehr als den aktuellen Preis für das Gut zu bezahlen.

    - _Konsumentenrente ($"KR"$):_ Zahlungsbereitschaft des Käufers für ein Gut, abzüglich des Preises,
      den er tatsächlich dafür bezahlen muss
    - _Produzentenrente ($"PR"$):_ Erlös des Verkäufers für ein Gut, abzüglich der Kosten, die ihm für Erwerb oder
      Herstellung des Gutes entstanden sind
    - _Wohlfahrt:_ Gesamte Rente, welche auf dem Markt entsteht ($"KR" + "PR"$)
  ],
  figure(caption: [Markttransaktionen-Effizienz], image("img/vwl/markt-effizienz.png")),
)

#pagebreak()

=== Staatliche Preiseingriffe
Durch das Setzen eines _Mindestpreises_ entsteht ein Wohlfahrtsverlust der Konsumenten.
Zu dem künstlich hoch gehaltenen Preis entsteht ein Überschussangebot, das heisst, die angebotene ist grösser als die
nachgefragte Menge. _Gewinner: Produzenten, Verlierer: Konsumenten_

Durch das Setzen eines _Höchstpreises_ entsteht ein Wohlfahrtsverlust der Produzenten.
Zu dem künstlich zu tief gehaltenem Preis entsteht eine Überschussnachfrage, das heisst, die nachgefragte ist grösser
als die angebotene Menge: eine _Angebotslücke_ entsteht. _Gewinner: Konsumenten, Verlierer: Produzenten_

In beiden Fällen bleibt die gesamte Wohlfahrt aber gleich, sie wird nur umverteilt zu Lasten einer Seite.

#grid(
  columns: (1fr, 1.05fr),
  align: horizon,
  figure(caption: [Höchstpreise im Grundmodell], image("img/vwl/höchstpreis.png")),
  figure(caption: [Mindestpreise im Grundmodell], image("img/vwl/mindestpreis.png")),
)

== Elastizität
Mit der Elastizität wird die Grösse der Anpassung eines Faktors bei der Änderung eines anderen Faktors bezeichnet.
#hinweis[(z.B. wie stark wirkt sich eine 1%-ige Preiserhöhung auf die Nachfrage eines Produkts aus)].

=== Preiselastizität der Nachfrage
#table(
  columns: (1fr, 1fr),
  table.header([Unelastische Nachfrage], [Elastische Nachfrage]),
  [
    Bei einer sehr unelastischen Nachfrage passt sich die nachgefragte Menge nur _sehr wenig_ an, wenn sich
    der Preis verändert. Die Nachfragekurve verläuft somit sehr steil resp. beinahe vertikal.
    Es erfordert also eine grosse Änderung des Preises, um eine bestimmte Mengenreaktion auszulösen.
    *Beispiel:* Grundnahrungsmittel
  ],
  [
    Bei einer sehr elastischen Nachfrage verändert sich die nachgefragte Menge _stark_, wenn sich der Preis verändert.
    Die Nachfragekurve verläuft somit sehr flach resp. fast horizontal.
    Es erfordert nur eine kleine Änderung des Preises, um eine bestimmte Mengenreaktion auszulösen.
    *Beispiel:* Luxusgüter, Ferienreisen
  ],
)

#definition[
  $
    "Preiselastizität der Nachfrage" = "Veränderung der nachgefragten Menge (in %)"/"Veränderung des Preises (in %)"
  $
]

Die Preiselastizität der Nachfrage ist umso geringer (unelastisch), desto weniger Substitutionsmöglichkeiten es gibt,
desto wichtiger und lebensnotwendiger das Gut ist, geringer der Anteil der Ausgaben für dieses Gut ist und
kurzfristiger der Effekt betrachtet wird.

#figure(caption: [Effekte einer Angebotsänderung bei verschiedener Elastizität der Nachfrage], image(
  "img/vwl/markt-und-preise-preiselastizität.png",
  width: 60%,
))

=== Preiselastizität des Angebots
#definition[$
  "Preiselastizität des Angebots" = "Veränderung der angebotenen Menge (in %)"/"Veränderung des Preises (in %)"
$]

Die Preiselastizität des Angebots ist umso geringer (unelastischer), desto weniger haltbar und lagerfähig ein Gut ist,
desto weniger rasch das Gut in beliebiger Menge hergestellt werden kann und desto kurzfristiger der Effekt betrachtet wird.

=== Einkommenselastizität
#definition[$
  "Einkommenselastizität" = "Veränderung der nachgefragten Menge (in %)"/"Veränderung des Einkommens (in %)"
$]

#grid(
  [
    + Einkommenselastizität gleich null:\ _Neutrales Gut_ #hinweis[(Trinkwasser, Strom)]
    + Einkommenselastizität zwischen null und eins:\ _Schwach superiores Gut_ #hinweis[(Lebensmittel, Wohnung)]
  ],
  [
    3. Einkommenselastizität grösser als eins:\ _Stark superiores Gut_ #hinweis[(Luxusgüter)]
    + Einkommenselastizität kleiner als null:\ _Inferiores Gut_ #hinweis[("billige Lebensmittel", z.B. Fertiggerichte)]
  ],
)

Steigt das Einkommen einer Person an, nimmt die Nachfrage an inferioren Gütern ab und an superioren zu.

== Staat und Marktwirtschaft
- Bereitstellung eines _Rechtssystem_, das Eigentumsrechte und Vertragsrechte klar definiert und durchsetzt
  #hinweis[(z.B. durch Polizei und Gerichte)]
- _Korrigierender Eingriff des Staates bei Marktversagen_: Falls frei gebildete Preise falsche relative Knappheit anzeigen
  oder Akteure daran gehindert werden, auf Preissignale zu reagieren #hinweis[(Monopolmacht, externe Effekte, öffentliche Güter)]
- _Ausgestaltung politisch gewünschter Regulierungen ohne grössere Beeinträchtigung der wirtschaftlichen Effizienz_:
  Eingriffe in die Marktwirtschaft so gestalten, dass ein Ziel durch eine bestimmte Regulierung mit möglichst geringer
  Beeinträchtigung der Effizienz und damit des Wohlstandes erreicht werden kann #hinweis[(Regulierungsfolgeabschätzung)]

=== Regulierungsfolgenabschätzung
Kostenfolgen sollten sich prognostisch durch RFA abschätzen lassen.
Laut Eidgenössischer Finanzkontrolle erfüllt aber die Mehrheit der bundesrätlichen Botschaften die Anforderung bezüglich
Abschätzung ihrer Folgen nicht.
RFA hat nur selten und sehr begrenzt Einfluss auf Meinungsbildung und Entscheidung im Gesetzgebungsprozess.


= Arbeitsmarkt
Der Arbeitsmarkt lässt sich als mikroökonomisches Modell darstellen:
Die _Haushalte_ stellen ihre _Arbeitskraft_ zur Verfügung #hinweis[(Arbeitsangebot)].
Je höher der Lohn, desto mehr Haushaltsmitglieder sind interessiert, ihre Arbeitskraft zur Verfügung zu stellen bzw.
mehr zu arbeiten. Ab einer bestimmten Grenze gibt es keine verfügbaren Arbeitskräfte mehr ($A$).

Die_ Unternehmen suchen Arbeitskräfte_ #hinweis[(Arbeitsnachfrage)].
Je tiefer der Lohn, desto mehr Arbeitsstellen werden geschaffen, da sich z.B. eine Automatisierung nicht lohnt.
Es gibt in der Mikroökonomie nicht einen, sondern eine Vielzahl von Arbeitsmärkten, z.B. einen für HFW/HFM-Absolventen
im Grossraum Zürich.

Der Schnittpunkt von Arbeitsangebot und Arbeitsnachfrage definiert den Marktlohn ($L_1$).
Dieser wird weder von den Haushalten noch von den Unternehmen definiert, sondern ergibt sich automatisch durch die
beiden Marktkräfte #hinweis[(siehe @unsichtbare-hand)]. Damit ist auch die Anzahl der Arbeitsstellen $A_1$ definiert.


#grid(
  columns: (1fr, 1.1fr),
  align: horizon,
  figure(caption: [Arbeitslosenquote Schweiz], image("img/vwl/arbeitslosenquote-schweiz.png", width: 80%)),
  figure(caption: [Arbeitsmarktmodell], image("img/vwl/arbeitsmarkt.png")),
)

Das Arbeitsmarktmodell kann in vier verschiedene Sektoren aufgeteilt werden #hinweis[(siehe @arbeitsmarkt-sektoren)]:

+ Unternehmen, deren Nachfrage nach Arbeitskräften erfüllt wird #hinweis[(Sind bereit gewesen, einen höheren Lohn zu zahlen)]
+ Haushalte #hinweis[(bzw. Arbeitskräfte)], die keine Arbeitsangebote erhalten, weil sie nicht gewillt sind
  zum Marktlohn zu arbeiten. _Dies ist eine freiwillige Arbeitsverzichtung, diese Arbeitnehmer gelten nicht als arbeitslos!_
+ Haushalte #hinweis[(bzw. Arbeitskräfte)], die von den Unternehmen beschäftigt werden
  #hinweis[(würden auch für tieferen Lohn arbeiten)].
+ Unternehmen, die keine Arbeitskräfte erhalten, weil sie nicht gewillt sind, den Marktlohn zu bezahlen.

Ein Rückgang der Arbeitsnachfrage durch die Unternehmen führt zu einer Linksverschiebung der Arbeitsnachfrage
#hinweis[(durchbrochene Linie)]. Damit ergibt sich ein neuer Marktlohn $(L_2$) sowie eine geringere Anzahl von
Beschäftigten ($A_2$). _Arbeitslosigkeit entsteht hier nicht_.
Es gibt einfach mehr Haushalte, die nicht bereit sind, zu diesem tieferen Marktlohn zu arbeiten
(Erhöhung des freiwilligen Arbeitsverzichts um $V$).

#grid(
  [
    #figure(caption: [Die Sektoren des Arbeitsmarktmodells], image("img/vwl/arbeitsmarkt-sektoren.png"))
    <arbeitsmarkt-sektoren>
  ],
  figure(
    caption: [Arbeitsmarktmodell mit Rückgang der Anzahl offenen Stellen],
    image("img/vwl/arbeitsmarkt-stellenrückgang.png"),
  ),
)

#grid(
  columns: (2fr, 1fr),
  [
    Sollte der Staat diesen Lohnrückgang aus sozialen Gründen zu verhindern versuchen, kann er eine _staatliche Lohnuntergrenze
    (Mindestlohn)_ setzen. Wird der Lohn fixiert, z.B durch einen Mindestlohn in der Höhe des ursprünglichen Lohns, entsteht
    bei einem Rückgang der Nachfrage _unfreiwillige Arbeitslosigkeit_.

    Eigentlich möchte zu diesem Lohn die Anzahl Personen $q_1$ beschäftigt werden, die Unternehmen werden aber nur der
    Anzahl $q_3$ einen Arbeitsvertrag anbieten. Es entsteht somit Arbeitslosigkeit in der Höhe $q_1 - q_3$.

    Der neue Schnittpunkt $q_2$ ist, wo sich Marktlohn und die Lohnvorstellungen der Arbeitnehmer kreuzen.
    Dieser ist aber aufgrund des Mindestlohns irrelevant.
  ],
  figure(caption: [Arbeitsmarkt mit Mindestlohn], image("img/vwl/mindestlohn.png")),
)

== Arbeitslosigkeit
Die Bevölkerung lässt sich einteilen in _15 - 64-jährige_ #hinweis[(Arbeitsbevölkerung)] und
_Übrige_ #hinweis[(Schüler & Rentner können nicht arbeiten)].
Die Arbeitsbevölkerung lässt sich weiter unterteilen in _Erwerbsbevölkerung_ und
_Nichterwerbsbevölkerung_ #hinweis[(Könnten arbeiten, wollen aber nicht)].
Die Erwerbsbevölkerung teilt sich wieder weiter auf in _Beschäftigte_ #hinweis[(arbeiten)] und
_Arbeitslose_ #hinweis[(Können und wollen arbeiten)]. Die Quoten für diese Schichten berechnen sich wie folgt

#definition[
  $
      "Arbeitslosenquote" & = "Arbeitslose"/"Erwerbsbevölkerung" dot 100 \
           "Erwerbsquote" & = "Erwerbsbevölkerung"/"15 - 64-jährige" dot 100 \
    "Erwerbstätigenquote" & = "Beschäftigte"/"15 - 64-jährige" dot 100
  $
]

Die Arbeitslosenzahlen des SECO enthalten jene arbeitslose Personen, die Ende Monat beim RAV gemeldet sind --
egal ob diese ALV beziehen. Das Bundesamt für Statistik erhebt zusätzlich pro Quartal die Erwerbslosigkeit gemäss Vorgaben
der Internationalen Arbeitsorganisation. Erwerbslos ist, wer _nicht erwerbstätig_ ist, _aktiv auf Stellensuche_ und
_sofort verfügbar_ ist.

=== Sockelarbeitslosigkeit in der Schweiz
#grid(
  figure(
    caption: [Sockelarbeitslosigkeit auf der vereinfachten Beveridge-Kurve],
    image("img/vwl/sockelarbeitsl-beveridge.png"),
  ),
  figure(caption: [Arbeitslosigkeitsquoten in der Schweiz], image("img/vwl/arbeitslosigkeit-90er.png")),
)

Die Sockelarbeitslosigkeit #hinweis[(siehe @beveridge-kurve)] stieg in den den 1990ern stark an.
Der Arbeitsmarkt veränderte sich stark: _Verstärkte Einbindung der Frauen_ in den Arbeitsmarkt,
_mehr Ausländer_ mit langfristigen Aufenthaltsbewilligungen und _attraktivere Arbeitslosenversicherung_.
Gleichzeitig ging die aggregierte Nachfrage zurück: _Nachfragerückgang der öffentlichen Hand_ #hinweis[(Fiskalpolitik)],
_restriktivere Geldpolitik der SNB_ #hinweis[(Geldpolitik)], Höhere Sparneigung der Haushalte --
eine _Rezession_ erfasste die Schweiz.

#grid(
  columns: (1fr, 0.93fr),
  [
    Sockelarbeitslosigkeit teilt sich in zwei Kategorien auf:

    *Erklärungsfaktoren für strukturelle Arbeitslosigkeit*
    - Mindestlöhne
    - Zentralisierte Lohnverhandlungen
    - Regulierungen bezüglich Anstellungen und Entlassungen
    - Ausgestaltung der Arbeitslosenversicherung #hinweis[(Bezugshöhe)]
    - Regulierungen der Arbeitszeit
    *Erklärungsfaktoren für friktionelle Arbeitslosigkeit*
    - Ausgestaltung der Arbeitslosenversicherung #hinweis[(Bezugsdauer)]
    - Zeitspanne bis Finden einer neuen Stelle
  ],
  figure(caption: [Sockelarbeitslosigkeit in der Schweiz], image("img/vwl/sockelarbeitslosigkeit-schweiz.png")),
)

== Mindestlohn
#grid(
  columns: (1.5fr, 1fr),
  [
    Bei Einführung eines Mindestlohns gibt es ein _höheres Arbeitsangebot der Haushalte_, weil mehr Personen bereit sind,
    zu einem nun höheren Lohn zu arbeiten #hinweis[(damit ein Mindestlohn effektiv ist, muss er höher als der momentane
    Marktlohn sein)]. Gleichzeitig gibt es aber eine _tiefere Arbeitsnachfrage der Unternehmen_, weil sie nun den
    eingestellten Personen mehr bezahlen müssen. Um Kosten zu sparen werden weniger neue Personen eingestellt oder
    Personen entlassen -- die _Anzahl Beschäftigter sinkt_.

    Die Differenz zwischen den zwei neuen Schnittpunkten $Q 1$ und $Q 2$ stellt das Überschussangebot dar:
    Die _strukturelle Arbeitslosigkeit_.

    Das Gegenstück zum Mindestlohn ist der _Höchstlohn_, dieser liegt stets unter dem Marktlohn.
  ],
  figure(caption: [Einfluss eines Mindestlohns], image("img/vwl/mindestlohn-1.png")),
)

Mit der Mindestlohninitiative sollte der Mindestlohn auf 22 Fr/h festgelegt werden und dann laufend an die
Lohn- und Preisentwicklung angepasst werden.

Die linken Kräfte, welche sich für einen Mindestlohn eingesetzt haben, vertraten die Meinung, dass dieser kaum
eine Auswirkung auf die Beschäftigungszahlen haben würde #hinweis[(@mindestlohninitiative, links)].
Die bürgerlichen Kräfte warnten demgegenüber vor einer deutlichen Erhöhung der Arbeitslosigkeit
#hinweis[(@mindestlohninitiative, rechts)].
Beide untermauerten ihre Aussagen mit mikroökonomischen Modellen.

#figure(
  caption: [Arbeitslosen-Vorhersagen durch die Mindestlohninitiative von linken und rechten Parteien],
  image("img/vwl/mindestlohninitiative.png"),
) <mindestlohninitiative>

#pagebreak()

Die Mindestlohninitiative wurde am 18. Mai 2014 mit 76% Nein-Stimmen bei einer Stimmbeteiligung von 56% abgelehnt.

Im Vergleich zu den Nachbarländern ist der Arbeitsmarkt in der Schweiz wenig reguliert:

+ _Mindestlöhne:_ Schweiz kennt keine branchenübergreifende Mindestlöhne
+ _Zentralisierte Lohnverhandlungen:_ Schweiz kennt nur dezentralisierte Vereinbarungen auf Branchenebene
+ _Regulierungen bezüglich Anstellungen und Entlassungen:_ Schweiz kennt wenige rechtliche Restriktionen
+ _Ausgestaltung der Arbeitslosenversicherung:_ Schweiz betont Wiedereingliederung der Arbeitssuchenden
+ _Regulierung der Arbeitszeit:_ Schweiz kennt wenige rechtliche Restriktionen

Da die _konjunkturelle Arbeitslosigkeit_ mit der Wirtschaft zu tun hat, hat die Regulierungsdichte eines Landes also
keinen Einfluss auf diese.

== Internationaler Arbeitsmarkt-Vergleich
#v(-0.5em)
=== USA
Vordergründig sieht der amerikanische Arbeitsmarkt gut aus:
Seit der Rezession 2008 übertraf die Arbeitslosenquote die Erwartungen und fiel von 10% auf 5.5% in 2015.
Laufend werden der Wirtschaft neue Jobs hinzugefügt.
Doch das ist nicht das ganze Bild: Die _Nichterwerbsbevölkerung steigt stetig,_ darunter vor allem 25-54-jährige.
Daran Schuld ist vor allem die Opioid- und Fentanyl-Krise, welche vor allem Weisse getroffen hat.

=== Frankreich
Frankreich hat eine überdurchschnittliche Arbeitslosigkeit im Vergleich zu den OECD-Schnitt, bei den 20-24-jährigen über 22%.
Der französische Arbeitsmarkt leidet nicht nur unter einem _scharfen Kündigungsschutz_,
_überdurchschnittlich hohen Mindestlöhnen und Sozialabgaben_, sondern auch dass Tarifverhandlungen und die
Arbeitnehmervertretung sehr zentralistisch geregelt sind.

=== Deutschland
#grid(
  [
    Die Arbeitslosigkeit in Deutschland erhöhte sich zu Beginn des neuen Jahrtausend von 7% (2000) auf 12% (2005).
    Ein Grund dafür war der im internationalen Vergleich _stark regulierte Arbeitsmarkt_.
    Am 14. März 2003 kündigte Gerhard Schröder (SPD) einen Massnahmenplan zur Revitalisierung des Arbeitsmarktes unter dem
    Begriff «Agenda 2010» an.
    Dieser beinhaltete u.a. folgende Massnahmen:
    - Zusammenlegen der Arbeitslosen- und Sozialhilfe (Hartz IV)
    - Deregulierung der Temporär-Arbeit
    - Anreize zur Arbeitsaufnahme
    - Kürzung der Bezugsdauer der «normalen» Arbeitslosengelder
    - Darüber hinaus: Abweichung von Flächentarifverträgen (IG Metall)
  ],
  figure(caption: [Sockelarbeitslosigkeit in Deutschland], image("img/vwl/agenda-2010.png")),
)

Deutschland entwickelte sich in wenigen Jahren vom "kranken Mann Europas" zum europäischen Musterknaben.
Die Sockelarbeitslosigkeit sank deutlich. Der Vergleich der Kennzahlen von 2005 und 2013 zeigt:

- Die Arbeitslosenquote sank von 12% auf 7%. Davon werden 1.5% – 3% direkt auf die Umsetzung der «Agenda 2010» zurückgeführt.
- Rückgang der Anzahl der Hartz IV-Empfänger von 2.9% auf 2%.
- Marginale Zunahme des Niedriglohnsektors von 2.3 auf 2.4% (Beschäftigte mit weniger als 2/3 des Medianlohns).
- Kaum Zunahme der «atypischen» Beschäftigung wie Teilzeitarbeit (5 Mio.), befristete (2 Mio.) oder
  geringfügig (2 Mio.) Beschäftigte. Neu kommen aber die Zeitarbeitnehmer (ca. 0.9 Mio.) dazu.
- Rückgang des Gini-Koeffizienten (entspricht einer Abnahme der sozialen Ungleichheit).


= Geld
Geld wird benötigt, um Tauschaktionen, die sich aus Arbeitsteilung der Wirtschaft ergeben, zu erleichtern.
Es hat drei Funktionen:
- _Zahlungsmittel:_ Reduziert Transaktionskosten des Kaufprozesses,
- _Masseinheit:_ Vergleichbarkeit des relativen Wertes von Gütern
- _Wertaufbewahrungsmittel:_ "Lagerung" von Kaufkraft, Geld "verdirbt" nicht

Ein ebenfalls wichtiges Kriterium ist die _Akzeptanz_: Dritte müssen bereit$"M0"$ sein, das Zahlungsmittel entgegenzunehmen.

== Die Schweizerische Nationalbank
Der Bund hat das alleinige Recht zur Produktion von Münzen und Banknoten.
Die Schweizerische Nationalbank führt unabhängig eine Geld- & Währungspolitik, die dem Interesse des Landes dient --
sie wird aber unter Mitwirkung und Aufsicht des Bundes verwaltet.
Die SNB hat Währungsreserven in Fremdwährungen, Devisen und Gold.
Der Reingewinn der SNB geht zu mindestens $2/3$ an die Kantone. #hinweis[(Bundesverfassung Art. 99, Geld und Währungspolitik)]

#grid(
  columns: (1.5fr, 1fr),
  [
    Die Nationalbank hat in Bern und Zürich je einen Sitz.
    Daneben unterhält sie Vertretungen in Basel, Genf, Lausanne, Lugano, Luzern und St. Gallen.
    Dazu kommen 14 Agenturen, die von Kantonalbanken geführt werden und der Geldversorgung des Landes dienen.
    Die Nationalbank ist eine spezialgesetzliche Aktiengesellschaft des Bundesrechts.
    Sie wird unter _Mitwirkung und Aufsicht des Bundes_ nach den Vorschriften des Nationalbankgesetzes verwaltet.
    Die Aktien sind als Namenpapiere ausgestaltet und an der Börse kotiert.
    Das Aktienkapital beträgt 25 Millionen Franken und ist zu rund 55 Prozent im Besitz der öffentlichen Hand
    #hinweis[(Kantone, Kantonalbanken etc.)]. Die übrigen Aktien befinden sich grösstenteils im Besitz von Privatpersonen.
    Der Bund besitzt keine Aktien. Bei der Nationalbank arbeiten rund 600 Personen.
    Sie ist damit eine der kleinsten Zentralbanken in Europa. _Münzen & Noten liegen nicht in der Kompetenz der SNB_.
  ],
  figure(caption: [Besitzstruktur Nationalbanken], image("img/vwl/nationalbank-besitzer.png")),
)

Die SNB hat folgende Aufgaben:
- Sie versorgt den Schweizerfranken-Geldmarkt mit Liquidität #hinweis[(genügend Geld für Bürger)].
- Sie gewährleistet die Bargeldversorgung.
- Sie erleichtert und sichert das Funktionieren bargeldloser Zahlungssysteme
  #hinweis[(Bank-zu-Bank-Transaktionen laufen über die SNB-Tochtergesellschaft SIX)]
- Sie verwaltet die Währungsreserven.
- Sie trägt zur Stabilität des Finanzsystems bei.

== Geldschöpfung
Der Geldschöpfungsprozess funktioniert über die drei Akteure _Zentralbank_, _Geschäftsbanken_ und _Wirtschaft_
#hinweis[(Unternehmen, Haushalte, Staat)].
Das Geld im Umlauf wird in drei Kategorien eingeteilt, sogenannte _Geldmengenaggregate_:

- _$bold(M 0)$:_ Geld kreiert durch die Zentralbank für Austausch mit Geschäftsbanken. Theoretisch unbeschränkt.
- _$bold(M 1)$:_ Geld innerhalb der Wirtschaft: Bargeld, Sichteinlagen
  #hinweis[(auch Sichtguthaben genannt, kurzfristige Einlagen z.B. Geld auf Lohnkonto)] und
  Transaktionskonti #hinweis[(Konten für Geldaustausch, um z.B. Aktien zu kaufen)]
- _$bold(M 2)$:_ $"M1"$ plus Spareinlagen #hinweis[(ohne Vorsorgegeld in z.B. 3. Säule)]
- _$bold(M 3)$:_ $"M2"$ plus Termineinlagen #hinweis[(Investment mit Fälligkeitsdatum)]

#grid(
  columns: (1.5fr, 1fr),
  [
    Die SNB kreiert "aus der Luft" $"M0"$ und kauft damit bei den Geschäftsbanken ausländische Wertpapiere
    #hinweis[(Aktien, Staatsanleihen)]. Diese werfen Zinsen ab, welche die SNB behält. Die Geldmenge wird also vergrössert.

    Möchte die SNB die Geldmenge wieder verkleinern, verkauft sie die Wertpapiere wieder an die Geschäftsbanken.
    Diese sind verpflichtet, die Wertpapiere wieder zurückzunehmen, ein sogenanntes _Repogeschäft_.
    Das erhaltene Geld wird dann von der SNB "gelöscht". Dieser Kreislauf wird auch _Offenmarktpolitik_ genannt.
  ],
  figure(caption: [Überblick Geldschöpfung], image("img/vwl/geldschöpfung.png")),
)

Die Geschäftsbanken können dann das erhaltene $"M0"$ zu $"M3"$ multiplizieren:
Durch Kredite an Haushalte, Unternehmen oder Firmen fliesst durch $"M3"$ Geld in die Wirtschaft.
Diese Kredite landen dann schlussendlich wieder auf den Konten der Geschäftsbanken, welche dieses Geld erneut ausleihen können.
Dasselbe Geld wurde also _multipliziert_.

Die Geldschöpfung durch die Geschäftsbanken wird aber durch den _Mindestreservesatz_ begrenzt.
Er bestimmt, wie gross der Geldanteil jedes Kredits ist, den die Bank bei sich behalten muss.
Aktuell liegt er bei _4%_, damit liegt der maximale _Geldschöpfungsmultiplikator_ bei 25.
In den USA liegt der Mindestreservesatz bei 10%, China 20% und bei der Europäischen Zentralbank bei 1%.

=== Instrumente der Geldschöpfung
#table(
  columns: (1fr,) * 3,
  table.header([Sichtguthaben-Verzinsung bei SNB], [Offenmarktoperationen], [Stehende Fazilitäten]),
  [
    Geschäftsbanken können Sichtguthaben in einem Konto bei der SNB halten, welche sie dann verzinst.
    Damit beeinflusst die SNB das Zinsniveau am Geldmarkt.
  ],
  [
    Repogeschäfte, Emissionen, Devisengeschäfte, (Ver-)kauf eigener Schuldverschreibungen #hinweis[(sogenannte SNB Bills)]
    sind die Hauptinstrumente der SNB zur Lenkung des Schweizer Frankens.
  ],
  [
    Unter Tags stellt die SNB für Repogeschäfte zinslos Liquidität zur Verfügung, um die Abwicklung des Zahlungsverkehrs
    zu erleichtern. Muss am Ende des Tages zurückbezahlt werden.
  ],
)

Ab Mitte 2011 erhöhte die SNB $"M0"$ massiv, um den _Franken in der Eurokrise zu stabilisieren_.
Ende 2020 existierte etwa 600 Milliarden $"M0"$, verglichen mit etwa 30 Milliarden in 2011.
Diese Menge stabilisierte sich in den folgenden Jahren.

2021 waren etwa 50 Milliarden CHF in Form von Tausender-Noten im Umlauf.
Alle anderen Noten kamen einzeln alle auf etwa 18 Milliarden CHF.

=== Bilanz einer Zentralbank
#grid(
  [
    *Aktiva*
    - Gold #hinweis[(teuer in der Lagerung)]
    - Inländische Wertpapiere
    - Ausländische Wertpapiere #hinweis[(Devisen)]
    - Andere Aktiva
    *Passiva*
    - Notenumlauf
    - Girokonten der Geschäftsbanken
    - Reserven

    25 % der Anlagen der SNB sind in Aktien investiert, während 64 % in Staatsanleihen und 11 % in anderen Anleihen
    angelegt waren. Die Devisenreserven bestehen zu 39% aus USD, 37% EUR, 8% Yen und 6% britisches Pfund.
  ],
  figure(caption: [Bilanz der SNB 2023], image("img/vwl/snb-bilanz.png")),
)

=== Geldschöpfung durch die Geschäftsbanken
Geschäftsbanken können auf der Grundlage des Notenbankgeldes durch _Kreditvergabe_ Geld schöpfen.
Um das Vertrauen in die Landeswährung zu sichern, ergibt sich die Notwendigkeit einer Bankenregulierung:

- _Vertrauen_ in Zahlungsfähigkeit der Banken ist wichtig.
- Deshalb Einführung eines _Mindestreserve-Satzes_ ($"RS"$), welche das Geldschöpfungspotential der Geschäftsbanken
  maximal begrenzt.
- Der Geldschöpfungsmultiplikator ($"GM"$) berechnet sich durch $1/"RS"$.

Nationalbanken beeinflussen also die _Gesamtgeldmenge_ über die Notenbankgeldmenge ($"M0"$) und den Geldschöpfungsmultiplikator.

Welche Auswirkung hat die Erhöhung des Mindestreservesatzes der SNB im 2024 von 2.5% auf 4% Prozent?
Damit verkleinert sich derjenige Teil der Guthaben (Girokonten) der Geschäftsbanken bei der SNB, welcher von dieser
mit dem SNB-Leitzinssatz verzinst wird. Die Geschäftsbanken erzielen deshalb einen kleineren _risikolosen Zinsgewinn_.
_$"M3"$ kann damit besser kontrolliert werden._

== Geldpolitische Strategien
Die Nationalbanken können sich für eine dieser Strategien für ihre Währung entscheiden.

#table(
  columns: (0.9fr, 1fr, 0.5fr),
  table.header([Wechselkursziele], [Geldmengenziele], [Inflationsziele]),
  [
    Fixierung des Wechselkurses an eine internationale Leitwährung #hinweis[(USD, EUR, Yen)].
    Gefahr eines "Importes" von Inflation.
  ],
  [
    Monetaristischer Ansatz mit Quantitätsgleichung: $P dot Q = M dot V$.\ Funktioniert so lange, wie $V$ konstant bleibt.
  ],
  [
    Wahrung der Preisstabilität
  ],
)

=== Die Geldpolitik der SNB
- _1945 – 1973:_ Wechselkursziel (Anbindung an USD)
- _1973 – 1978:_ Monetaristische Geldpolitik (Quantitätsgleichung: $M = Q$)
- _1978 – 1980:_ Wechselkursziel (Anbindung an Deutsche Mark)
- _1980 – 1999:_ Monetaristische Geldpolitik (Quantitätsgleichung: $M = Q$)
- _1999 – heute:_ Preisstabilität (Inflationsprognose durch Grösse von $"M2"$ und $"M3"$)

=== Das Bretton-Woods-System
Die Schweiz nahm nach dem zweiten Weltkrieg am _Bretton-Woods-System_ teil (fixe Wechselkurse).
Der US-Dollar fungierte als internationale Leitwährung.
Dazu wurde die _Golddeckung_ des Dollars eingeführt mit 35 USD pro Unze, gesichert durch knapp 18.000 Tonnen gelagert in
Fort Knox, mehr als die Hälfte der gesamten globalen Bestände.
Die Finanzierung des Vietnamkriegs #hinweis[(grosse Ausweitung der US-Geldmenge)] führt zu importierter Inflation in
vielen Ländern. Die Golddeckung in den USA nimmt massiv ab, deshalb _Aufkündigung der Goldeinlösungspflicht_ durch die
US-Regierung #hinweis[(galt nur für Zentralbanken)].
Das führte zum Zusammenbruch des Bretton-Woods-Systems (Austritt der Mitgliedsstaaten).

=== 1974 – 1999: Orientierung an der Geldmenge
Ausrichtung am _Monetarismus_ (Ökonomische Theorie, dass Inflation immer durch ein Überangebot an Geld verursacht wird).
Am Ende 80er Jahre gab es viele Innovationen auf dem Finanzmarkt mit Einfluss auf die Umlaufgeschwindigkeit des Geldes.
Häufigeres Verfehlen der Geldmengenziele.

=== Seit 1999: Orientierung an Inflationsprognosen
Inflationsprognosen anhand der Geldmengen $"M2"$ und $"M3"$
#hinweis[(SNB kommuniziert diese Indikatoren im Gegensatz zur europäischen Zentralbank allerdings nicht)].
Umsetzung mit folgendem geldpolitischen Konzept:
- Definition der Preisstabilität (Ziel)
- Inflationsprognose (Entscheidungsgrundlage)
- Zielband für Dreimonats-Libor in CHF (operatives Ziel), ab 2019 SARON

== Vollgeld-Initiative
Die Vollgeldinitiative wollte die Geldschöpfung durch die Geschäftsbanken abschaffen und allein der SNB diese Macht übergeben
-- ein effektives Abschaffen von $"M0"$.
Die Initiativgründer hatten allesamt keine politische Erfahrungen und waren alle bereits im Ruhestand.
Um die Versorgung der Wirtschaft mit Geld sicherzustellen, sollte der Bund dabei vom Grundsatz der Wirtschaftsfreiheit
abweichen können. Gefährlich!

Die Initiative wurde am 10. Juni 2018 mit 24.3% Ja-Stimmen abgelehnt.

= Wechselkurse
Wechselkurse können ebenfalls im mikroökonomischen Modell dargestellt werden.
Die Nachfrage und das Angebot bestimmt sich anhand verschiedener Faktoren.
Fett markiert sind die aktuell wichtigsten Beeinflusser.

#table(
  columns: (1fr, 1fr),
  table.header([Nachfrage nach Franken], [Angebot an Franken]),
  [
    - *Exporte*
    - Arbeits-/Kapital-Erträge aus dem Ausland
    - Ausländische Portfolioinvestitionen in der Schweiz
    - Ausländische Direktinvestitionen in der Schweiz
    - Übriger Kapitalimport
    - Devisenverkäufe der SNB
  ],
  [
    - Importe Arbeits-/Kapitalerträge ans Ausland
    - Schweizerische Portfolioinvestitionen im Ausland
    - Schweizerische Direktinvestitionen im Ausland
    - Übriger Kapitalexport
    - *Devisenkäufe der SNB*
  ],
)

#grid(
  align: horizon,
  figure(caption: [Nachfrage nach Franken steigt oder Angebot an Franken sinkt], image("img/vwl/wechselkurs-hoch.png")),
  figure(caption: [Nachfrage nach Franken sinkt oder Angebot an Franken steigt], image("img/vwl/wechselkurs-tief.png")),
)

== Nominaler & realer Wechselkurs
Der nominale Wechselkurs ist das Verhältnis der inländischen Währung im Vergleich zur ausländischen.
Bei den _realen Wechselkursen_ werden zusätzlich die unterschiedlichen Preisniveaus im Inland und Ausland berücksichtigt.

#definition[
  #grid(
    columns: (1fr, 1.2fr),
    align: horizon,
    [
      $
        e = "inländische Währung"/"ausländische Währung"\
        r = (e dot p^*)/p
      $
    ],
    [
      - _$bold(e)$:_ Nominaler Wechselkurs
      - _$bold(r)$:_ Realer Wechselkurs
      - _$bold(p^*)$:_ Preis Güterkorb im Ausland in Ausländischer Währung
      - _$bold(p)$:_ Preis Güterkorb im Inland in Inländischer Währung
    ],
  )

]

Erhöht sich z.B. die inländische Geldmenge im Vergleich zur ausländischen Geldmenge, _steigt der nominale Wechselkurs_.
Dies ist einer Abwertung der inländischen Währung gleichzusetzen.

Beim realen Wechselkurs gibt es auch zwischen Ländern mit derselben Währung einen "Wechselkurs",
da z.B. EU-Länder alle unterschiedliche Güterkorbpreise haben.
Der reale Wechselkurs kann kurz- oder langfristig berechnet werden, weil sich die Preise kurzfristig (noch) nicht anpassen.


#pagebreak()

=== Effekte der Geldpolitik
Eine _Erhöhung der inländischen Geldmenge_ hat folgende Effekte: Nominale Abwertung der inländischen Währung ($e arrow.t$)
und Inländisches Preisniveau steigt ($p arrow.t$) #hinweis[(siehe @quantitätsgleichung)].

Beide Effekte reagieren aber mit unterschiedlichem Zeithorizont: Der nominale Wechselkurs $e$ reagiert sofort.
Das inländische Preisniveau $p$ reagiert mit Verzögerung von deutlich mehr als einem Jahr.

#table(
  columns: (1fr, 1fr),
  table.header([Kurzfristige Effekte], [Langfristige Effekte]),
  [
    Bei einer Ausweitung der inländischen Geldmenge reagiert der nominale Wechselkurs sofort, das inländische Preisniveau
    kurzfristig aber nicht. Der reale Wechselkurs reagiert sofort, damit wird die Exportindustrie wettbewerbsfähiger.

    $ r arrow.t = (e arrow.t dot p^*)/p $
  ],
  [
    Langfristig führt eine Ausweitung der inländischen Geldmenge zu keiner
    Veränderung des realen Wechselkurses $r$, da sich das inländische Preisniveau $p$
    anpasst

    $ r = (e arrow.t dot p^*)/(p arrow.t) $
  ],
)

#grid(
  figure(caption: [Nominaler und realer Frankenkurs], image("img/vwl/frankenkurs.png")),
  figure(caption: [Wechselkursentwicklung], image("img/vwl/devisenkurse.png")),
)

== Fixe Wechselkurse
Es gab zwei grosse fixe Wechselkurssysteme: _Bretton-Woods_ (1944-73) mit der Leitwährung USD und
das _Europäische Währungssystem (EWS)_ (1978-94) mit der Leitwährung Deutsche Mark.
Letzteres ging 1999 in eine _Währungsunion_ mit der _Einheitswährung_ Euro über.

Fixe Wechselkurse koppeln ihre eigene Währung an eine Fremdwährung an -- eine _Leitwährung_.
Die _Vorteile_ sind _Berechenbarkeit der Wechselkurse_ für die Export-/Importindustrie und _Anbindung der eigenen Geldpolitik_
an die stabilere Geldpolitik des Landes mit der Leitwährung.
Der _Nachteil_ ist, dass die eigenständige Geldpolitik zur Konjunktursteuerung _aufgegeben_ wird.

=== Beispiel EWS
Nach dem Zusammenbruch von Bretton-Woods entschlossen sich die EG-Länder zu einer monetären Integration zur
_Vereinfachung der Handelsbeziehungen_ und _Vermeidung eines "Währungskrieges"_ zur Unterstützung der nationalen Exportindustrien.
1979 wurde das EWS mit der D-Mark als Leitwährung eingeführt.
Man einigte sich darauf, die Wechselkurse nur innerhalb _enger, vorher vereinbarten Bandbreiten_ schwanken zu lassen.

Bei der Einführung des EWS bestanden grosse Inflationsunterschiede zwischen z.B. Italien und Deutschland.
Wird in einer solchen Situation der nominale Wechselkurs fixiert, hat dies massive Auswirkungen auf den realen Wechselkurs.
$r$ sinkt, damit wird die _inländische Währung aufgewertet_ und die inländische Exportindustrie leidet.

$ r arrow.b = (e dot p^* arrow.t)/(p arrow.t) $

#grid(
  columns: (1fr, 1.1fr),
  align: horizon,
  figure(caption: [Probleme eines Fixkurssystems Deutschland/England], image("img/vwl/fixer-wechselkurs.png")),
  [#figure(caption: [Inflationskonvergenz DM/Lira], image("img/vwl/inflationskonvergenz.png")) <inflation-lira>],
)

Fixe Wechselkurse führen zwangsläufig dazu, dass die Mitgliedsländer die _Geldpolitik des Leitwährungs-Landes imitieren_
müssen. Diese aufgezwungene Geldpolitik kann im _Widerspruch_ zur konjunkturellen Entwicklung eines Mitgliedlandes stehen.
Spekulanten "wetten" in solchen Situationen auf eine nominale Auf- oder Abwertung der entsprechenden Währungen.

Zwei Formen von Inkonsistenzen, welche Spekulanten nutzen können:
- _Inkonsistenz zwischen Konjunkturlage und Geldpolitik_ (Fall England: Restriktive Währungspolitik in Rezession).
- _Beeinträchtigung der Wettbewerbsfähigkeit_ bei grossen Inflationsunterschieden durch reale Aufwertung der inländischen
  Währung (Fall Italien).

Beide Fälle zeigen exemplarisch auf, dass "falsche Wechselkurse" langfristig nicht verteidigt werden können.

== Spekulationsattacken
Im Sommer 1992 wetteten Spekulanten darauf, dass die Bank of England ihre restriktive Geldpolitik nicht längerfristig halten
kann und England aus dem EWS austritt. Damit könnte sie durch expansive Geldpolitik das Pfund abwerten.
Sie _kauften also mit Pfund viele D-Mark_, welche sie nach der Pfundabwertung _wieder zum Kauf von Pfund_ nutzten.
Im Herbst 1992 verliess England den EWS und wertete das Pfund um 20% ab.
Investoren wie z.B. George Soros verdienten damit Milliardenbeträge.


Die italienische Lira wurde bis Ende der 1980er Jahre periodisch _nominal abgewertet_, um die reale Aufwertung dieser Währung
zu verhindern. Danach verzichtet man bewusst auf weitere Paritätsanpassungen, _siehe @inflation-lira _.
Die immer noch vorhanden leichten Inflationsdifferenzen führten zu einer_ schleichenden realen Aufwertung der Lira_ gegenüber
der D-Mark. Damit kam die italienische Exportindustrie immer stärker unter Druck.
Die Spekulanten wetteten nun auf eine_ baldige Abwertung der Lira_ und kauften mit (noch) überbewerteten Lira in grossen Mengen
D-Mark. Die Banca d'Italia wertete in der Folge die Lira ab.
Die Spekulanten kauften nun mit den D-Mark wieder die nun "billigen" Lira, ein risikoloses Geschäft.

== Währungsunion
In einem Fixkurssystem sind die Wechselkurse nicht für alle Zeiten fixiert.
Jedes Land kann aus dem System aussteigen und den Wechselkurs anpassen.
In einer Währungsunion sind die _nominalen Wechselkurse unwiderruflich_ fixiert.
Anstelle von nationalen Geldpolitiken tritt eine Zentralbank für die gesamte Währungsunion.

_Vorteile der Währungsunion:_ Vollständige _Elimination des Wechselkursrisikos_ wie auch der Transaktionskosten beim
Währungstausch sowie _Erhöhung der Preistransparenz_, da die Güterpreise in der Währungsunion direkt verglichen werden können.

Die in der Währungsunion zusammengeschlossenen Länder sollten in ihrer _konjunkturellen Entwicklung ähnlich_ sein.
Ansonsten drohen durch die Geldpolitik _"asymmetrische» Schocks"_.\
Sollten die Länder einer Währungsunion konjunkturell sehr unterschiedlich sein, können diese Unterschiede durch andere
Anpassungsmechanismen als die nationale Geldpolitik bis zu einem gewissen Grad aufgefangen werden:
_Flexible Löhne und Preise_, _Mobile Arbeitskräfte_, _Ausgleichende Fiskalströme_

=== Beispiel EWU
Der _Vertrag von Maastricht_ legte anfangs der 1990er-Jahre den Prozess der Weiterentwicklung der EG
#hinweis[(Europäischen Gemeinschaft)] zu einer Währungsunion #hinweis[(Einführung des Euro im Jahr 1999, Noten und Münzen 2001)]
fest.\ Für die Teilnahme am EWU wurden _Konvergenzkriterien_ festgelegt:

#table(
  columns: (1fr, 1fr),
  table.header([Geldpolitik], [Fiskalpolitik]),
  [
    - Zinssätze innerhalb eines engen Rahmens
    - Ein relativ stabiler Wechselkurs im Vorfeld des Beitritts
    - Eine ähnliche Inflationsrate wie die übrigen Mitgliedsländer
  ],
  [
    - Eine jährliche Neuverschuldung #hinweis[(Budgetdefizit)] von max. 3% des BIP
    - Eine Staatsverschuldung von unter 60% des BIP
  ],
)

*Frühe Kritik am Währungsraum der EWU*\
- Wenig flexible Löhne, stark regulierte Arbeitsmärkte
- Wenig mobile Arbeitskräfte, vor allem aus sprachlichen Gründen (im Vergleich zur USA)
- Geringe ausgleichende Fiskalströme, da das von Brüssel zentral verwaltete Budget nicht genügend gross ist
  (aktuell ca. 125 Mia. Euro jährlich)


== Eurokrise
Seit dem Frühjahr 2013 kämpft die Eurozone mit der schwersten Krise seit ihrer Gründung.
Ausgehend von der _massiven Überschuldung_ in Griechenland steigt die Besorgnis über die Staatsverschuldung europäischer
Staaten an. Die Finanzmärkte beginnen an der Rückzahlungsfähigkeit der PIGS-Staaten
#hinweis[(Portugal, Irland, Griechenland, Spanien)] zu zweifeln.

Die Ursachen dieser Eurokrise liegen letztlich in Konstruktionsfehlern der Währungsunion:
Vor der Einführung des Euros hatten die PIGS-Länder massiv höhere Zinssätze verglichen mit Deutschland
#hinweis[(Griechenland 1996: 9% mehr, Irland 1996: 1.75% mehr, Portugal & Spanien 1996: ca. 3.5% mehr)].
Alle diese Länder bekamen mit dem Euro _denselben Zinssatz wie Deutschland_, obwohl ihre Wirtschaft nicht vergleichbar war.

Die Anleger gingen davon aus, dass bei einer zentralen Geldpolitik das _Risiko von staatlichen Anleihen_ in allen
Mitgliedsländern gleich hoch ist. Dies bedeutete für die PIGS-Staaten neu die Möglichkeit einer "billigen" Staatsverschuldung.
In den ersten Jahren verzeichneten diese Länder einen eigentlichen Wirtschaftsboom.
Die tiefen Zinsen stimulierten die Investitionen der Unternehmen, den Konsum der Haushalte sowie des Staates.

Langfristig bauten sich aber zwei fatale Ungleichgewichte auf:
- Reduktion der Wettbewerbsfähigkeit der PIGS-Staaten (realer Wechselkurs sinkt)
- Ausufernde Staatsverschuldung

#grid(
  align: horizon,
  figure(caption: [Zinsentwicklung PIGS-Länder und Deutschland], image("img/vwl/zinsentwicklung-eu.png")),
  figure(caption: [Entstehung der Eurokrise], image("img/vwl/eurokrise-entstehung.png")),
)

= Staatsfinanzen
Es gibt drei Hauptformen von Staatseinnamen:

#table(
  columns: (1.5fr, 1fr, 1fr),
  table.header([Steuern], [Verschuldung], [Inflationssteuer]),
  [
    - _Direkte Steuern_ auf Einkommen/Gewinn oder Vermögen/Kapital #hinweis[(oft mit Umverteilung verbunden)]
    - _Indirekte Steuern_ auf Markttransaktionen #hinweis[(Mehrwertsteuer, Energiesteuer, Finanztransaktionen)]
  ],
  [
    Zur Deckung von Investitionen und des laufenden Staatsaufwandes #hinweis[(Staatskonsum)]
  ],
  [
    "Besteuerung" der Geldhaltung durch Ausweitung der Geldmenge -- Geld drucken
  ],
)

== Staatsverschuldung
Politisch-ökonomische Gründe für zunehmende Staatsverschuldung:
- Grössere Attraktivität einer Verschuldung gegenüber Steuererhöhungen #hinweis[(Sicherung der Wiederwahl)]
- Trennung von Ausgabenbeschluss und Einnahmenentscheid
  #hinweis[(keine Sicherung der Finanzierung von Ausgabenbeschlüssen, z.B. Initiativen ohne Finanzierungsplan)]
- Stimmentausch aka Korruption
  #hinweis[(gegenseitige Unterstützung von Parlamentarier, um Vorteile für die eigene Interessengruppe sicherzustellen)]

Die staatliche Verschuldung führt in der Regel zu einem Rückgang der gesamtwirtschaftlichen Nachfrage $"AN"$.
#table(
  columns: (1fr, 1.1fr),
  table.header([Verschuldung im Inland], [Verschuldung im Ausland]),
  [
    Rückgang der inländischen Investitionen der Unternehmen #hinweis[(Erhöhung der staatlichen Kreditnachfrage auf dem
    inländischen Kapitalmarkt $->$ steigende Kreditzinsen $->$ crowding- out der Unternehmensinvestitionen:
    Unternehmen erhalten keine Kredite mehr, weil Staat sich alle gönnt)]
  ],
  [
    Rückgang der Nettoexporte #hinweis[(Erhöhung der staatlichen Kreditnachfrage auf dem ausländischen Kapitalmarkt in
    ausländischer Währung $->$ zwingender Kauf von inländischer Währung für den Erwerb der inländischen Staatsanleihen
    $->$ erhöhte Nachfrage nach inländischer Währung $->$ führt zu deren Aufwertung $->$ deshalb sinkende Exporte)]
  ],
)

*Nachteile Staatsschulden:*
- _Verdrängung privater Investitionen:_ "crowding out" von effizienten Investitionen
  #hinweis[(Effizienz durch Wettbewerb, Konkursrisiko der Unternehmen im Gegensatz zum Staat)]
- _Verlust des Handlungsspielraumes im Budget:_ Zunehmende Staatsschulden führen zu höheren Zinssätzen für die Verschuldung
  #hinweis[(Zinslast als zunehmender Budgetposten)]
- _Verlockung zur Monetarisierung der Verschuldung:_ Zentralbank kauft Staatsanleihen mit «neuem» Geld.
  Erhöhung der Geldmenge_ treibt Inflation an_. Die _"Inflationssteuer"_ werden von allen, die Geld haben
  (Notenumlauf, Buchgeld) bezahlt. Auch liquide Bestandteile des BVG- und AHV-Vermögen nehmen real an Wert ab.

*Vorteile von Staatsschulden:*
- _Staatliche Investitionen:_ Finanzierung von langfristigen Innovationen durch die zukünftigen Generationen,
  _intertemporaler Finanzausgleich_ #hinweis[(Projekte, welche mehrere Generationen nutzen können werden zB. beim Bau
  zu $1/4$ durch Steuern und $3/4$ durch Schulden verschiedener Länge, welche spätere Generationen bezahlen müssen)]
- _Steuerglättung:_ Jährliche Anpassung der Steuersätze kaum vorstellbar, um jederzeit Budgeteinhaltungen zu garantieren --
  Schulden sind flexibler
- _Makroökonomische Verschiebung:_ Ausgleich von konjunkturellen Schwankungen durch Veränderungen der staatlichen Nachfrage,
  _keynesianische Konjunkturpolitik_ = _Fiskalpolitik_ #hinweis[(Staat vergibt Kredite, um Wirtschaft anzukurbeln)]

== Steuersystem Schweiz
Die Staatseinnahmen in der Schweiz werden zu _$bold(2/3)$ aus direkten Steuern_
#hinweis[(Einkommenssteuer der Haushalte, Vermögenssteuer der Haushalte, Kapitalsteuer der Unternehmen)] und
_$bold(1/3)$ aus indirekten Steuern_ #hinweis[(Mehrwertsteuer, Strassensteuer)] erhoben.
Von diesen Staatseinnahmen erhalten Kantone und Gemeinden _$bold(2/3)$_, weil die Steuern auch durch sie erhoben werden.

In der Schweiz herrscht _Finanzföderalismus_ in Form von _Steuerwettbewerb:_ Jede Gemeinde und Kanton hat ihren eigenen
Steuersatz, der jährlich neu definiert werden kann. Ebenfalls gibt es einen _Finanzausgleich_ zwischen dem Bund und den
Kantonen und zwischen finanzstarken und -schwachen Kantonen. Seit 2004 gibt es den Neuen Finanzausgleich NFA.

#grid(
  align: horizon,
  figure(caption: [Vom Bund erhobene Steuern, in gelb die wichtigsten], image("img/vwl/steuern-bund.png")),
  figure(caption: [Übersicht Steuern in der Schweiz], image("img/vwl/steuern-übersicht.png")),
)

Der Bund besteuert hauptsächlich _alles was Spass macht_ und _für den Krieg_.
Bei der Bundessteuern gibt es\ 6 Einkommensstufen, kategorisiert nach jährlichem Einkommen.
Die grösste Stufe bildet mit 38.1% aller Bürger ist Stufe 2 #hinweis[(30'000-60'700 CHF)].
Sie zahlen aber nur 5.5% aller Steuern.
Die beiden obersten Stufen 5 #hinweis[(121'700 - 607'800 CHF)] und 6 #hinweis[(über 607'000 CHF)] zahlen jeweils 53% und 19%
aller Steuern, obwohl sich nur 11.5% bzw. 0.3% aller Bürger in diesen Einkommensstufen befinden.


== Schweizer Staatsfinanzen
#grid(
  figure(caption: [Einnahmen auf Bundesebene], image("img/vwl/bund-einnahmen.png")),
  figure(caption: [Ausgaben auf Bundesebene], image("img/vwl/bund-ausgaben.png")),
)

*Begriffe:*
- _Staatsquote:_ Anteil der Wertschöpfung des Staates am realen BIP #hinweis[(2020: 36.4%)]
- _Fiskalquote:_ Anteil der Steuereinnahmen am realen BIP #hinweis[(2020: 27.9%)]
- _TAX-I:_ Anzahl Arbeitstage, bis alle Staatsabgaben beglichen sind #hinweis[(in der Schweiz ca. 100 Tage)]
- _Strukturelles Defizit:_ Neuverschuldung auch bei normaler Konjunkturlage
- _Konjunkturelles Defizit:_ Neuverschuldung während einer Rezession

#grid(
  columns: (1.1fr, 1fr),
  align: horizon,
  figure(caption: [Staats- & Fiskalquote Schweiz], image("img/vwl/fiskalquote-schweiz.png")),
  figure(caption: [Saldo der Bundesrechnung], image("img/vwl/bundessaldo.png")),
)

== Schuldenbremse
Die Schuldenbremse besagt, dass grundsätzlich nicht mehr ausgegeben als eingenommen werden darf.
Da man in der Regel eher vorsichtig budgetiert, fallen die Erträge in der Regel besser aus als budgetiert.
Die Ausgaben bleiben aber wie budgetiert limitiert.
Dies führt in der Regel zu Gewinnen, welche zur Schuldrückzahlung verwendet werden müssen.

#grid(
  [
    Vater der Schuldenbremse war _Bundesrat Kaspar Villiger (FDP)_ in seiner  Rolle als Finanzminister, welcher beunruhigt über
    die rasche und massive Staatsverschuldung der Schweiz in den 90er Jahren war.
    In einem ersten Schritt wurde am 7. Juni _1998_ der Bundesbeschluss über Massnahmen zum Haushaltsausgleich vom Volk mit
    über 70% Ja-Stimmen angenommen (teilweise Bereinigung des strukturellen Defizits).
    In einem zweiten Schritt hat am 2. Dezember 2001 85% des Volkes Ja gesagt zur _Festschreibung der Schuldenbremse_ in der
    schweizerischen Verfassung. 2003 trat diese in Kraft.
  ],
  figure(caption: [Schuldenbremse], image("img/vwl/schuldenbremse.png", width: 90%)),
)

Die Schuldenbremse ist in der Bundesverfassung Artikel 126 verankert.
_Grundsatz_: Der Bund hält seine Ausgaben und Einnahmen auf Dauer im Gleichgewicht.
_Ausgabenregel_: Der Höchstbetrag der im Voranschlag zu bewilligenden Gesamtausgaben richtet sich unter Berücksichtigung der
Wirtschaftslage nach den geschätzten Einnahmen.
_Ausnahme_: Bei ausserordentlichem Zahlungsbedarf kann der Höchstbetrag nach Absatz 2 angemessen erhöht werden.
_Sanktionen_: Überschreiten die in der Staatsrechnung ausgewiesenen Gesamtausgaben den Höchstbetrag nach Absatz 2 oder 3,
so sind die Mehrausgaben in den Folgejahren zu kompensieren.

#grid(
  [
    Der Kanton _St. Gallen_ hat seine "Schuldenbremse" als erster Schweizer Kanton _bereits 1929 eingeführt_ und diese ist
    vermutlich auch die _älteste der Welt_.
    Die aktuelle St. Galler Schuldenbremse ist seit 1994 im Staatsverwaltungsgesetz #hinweis[(Art. 61 und 64)] geregelt.
    Sie besagt, dass das budgetierte Defizit den _Ertrag von 3 Prozent_ der einfachen Steuer nicht übersteigen darf.
    Wird in einem Jahresabschluss effektiv ein Defizit ausgewiesen, so ist der Fehlbetrag (sofern er nicht durch Eigenkapital
    gedeckt werden kann) im Budget des übernächsten Jahres vollständig zu kompensieren.
  ],
  figure(caption: [Schuldenbremsen der Kantone], image("img/vwl/schuldenbremse-kantone.png", width: 90%)),
)

Die _Verschuldung_ des Bundes hat seit einführung der Schuldenbremse 2003 stark abgenommen:
Die Bruttoschuldquote sank bis 2024 von ca. 55% auf 30%, die Nettoschuldenquote von 30% auf 15%.
Die totale Verschuldung der Kantone blieb seit 2000 ungefähr stabil.
2016 lag die öffentliche _Gesamtverschuldung_ bei etwa _300 Milliarden CHF_, davon 130 Milliarden beim Bund,
80 Milliarden bei den Kantonen und 70 Milliarden bei den Gemeinden.

== Internationale Staatsverschuldung
#grid(
  figure(caption: [Internationale Staatsverschuldung], image("img/vwl/staatsverschuld-international.png")),
  figure(caption: [Vergleich öffentliche & private Verschuldung], image("img/vwl/aufteilung-schulden.png")),
)

=== Verschuldung USA
#grid(
  [
    Wird die US-Schuldengrenze erreicht, kommt es zu einem_ "Government Shutdown"_.
    Zwischen 98 Prozent (Wohnungsbauministerium) und vier Prozent (Veteranenangelegenheiten) der Belegschaft werden in den
    Zwangsurlaub geschickt - und werden dann auch _nicht mehr bezahlt_.
    Insgesamt muss rund die Hälfte aller Staatsbediensteten zu Hause bleiben, der Zwangsurlaub gilt für etwa 800.000 Menschen.
    Ein Experte von Standard & Poor's hat ausgerechnet, dass ein "Shutdown" die US-Wirtschaft pro Woche
    _etwa 6.5 Milliarden Dollar kostet_.
    Die meisten Bundesbediensteten, die während eines "Shutdown" weiterarbeiten, werden in dieser Zeit nicht oder nur
    verspätet bezahlt.

    _US-Staatsanleihen_ haben seit den 1970er immer mehr Rendite eingebüsst, sie sind also keine gute Wertanlage mehr.
    Dafür muss die Regierung aber immer mehr Zinsen auf diese zahlen.
  ],
  figure(caption: [Verschuldung USA], image("img/vwl/staatsverschuldung-usa.png")),
)

=== Verschuldung Europa
#grid(
  align: horizon,
  figure(caption: [Staatsverschuldung Frankreich], image("img/vwl/staatsverschuld-frankreich.png", width: 80%)),
  figure(caption: [Staatsverschuldung Europa], image("img/vwl/staatsversch-europa.png", width: 80%)),
)

== Implizite Verschuldung
Als _implizite Staatsschulden_ werden alle "versteckten" Staatsschulden bezeichnet.
Hierzu zählen insbesondere die Schulden, die eine in der Zukunft liegende Verpflichtung darstellen
(z.B. Pensionsverpflichtungen). Die amtliche Schuldenstatistik deckt die impliziten Staatsschulden nicht ab.
In der Schweiz ist vor allem _die AHV_ für die hohe implizite Staatsverschuldung verantwortlich.
Der AHV droht eine Finanzierungslücke im Volumen von 173.4% des Schweizer Bruttoinlandprodukts (BIP) oder 1'000 Mrd. Fr.


= Internationale Arbeitsteilung
#v(-0.5em)
== Prinzip des komparativen Kostenvorteils
Entwicklungsländer konkurrenzieren mit Industrieländer, indem sie _komparative Kostenvorteile_ ausnutzen.

#grid(
  [
    + Auf welches Gut spezialisiert sich Insel A, auf welches Insel B?
    + Wie funktionieren somit Handelsströme?
    + Berechne durch Handel entstehenden Wohlfahrtseffekt für beide Inseln.
    + Berechne die maximalen Transportkosten für Bananen bzw. Kokosnüsse
  ],
  figure(caption: [Prinzip des komparativen Kostenvorteils], image("img/vwl/prinzip-komparativer-kostenvorteil.png")),
)

+ Insel A: Kokosnüsse. Insel B: Bananen.
+ Für die Produktion einer Kokosnuss auf der Insel A könnte sie stattdessen 3.3 Bananen produzieren.
  Wird die Kokosnuss jedoch nach Insel B exportiert, kann sie 4 Bananen erhalten.
  Für Insel A ist es also profitabler, Kokosnüsse zu produzieren und diese zu exportieren.
  Insel B kann für eine Banane 0.25 Kokosnüsse produzieren, beim Bananen-Export aber 0.3 Kokosnüsse erhalten.
+ Zusätzlicher Wohlstand durch Handel der Inseln: Insel A: 0.7 Bananen, Insel B: 0.05 Kokosnüsse
+ Die Transportkosten müssen tiefer als der jeweilige zusätzliche Wohlstand sein.

Insel A und B stehen mit Handel beide am Ende besser da, obwohl Insel A eigentlich beides besser produzieren kann.
Insel A steht symbolisch für ein Industrieland, Insel B für ein Entwicklungsland.

== Internationale Arbeitsteilung & Wohlfahrt
Internationale Arbeitsteilung bringt positive Wohlfahrtseffekte, unabhängig ob der Weltmarktpreis höher oder tiefer als
der entsprechende Heimmarktpreis ist.

=== Wohlfahrt bei Autarkie
Der Markt der Autarkie kennt keine Importe oder Exporte und ist somit gleich dem regulären mikroökonomischen Modell
#hinweis[(siehe @mikroökonomisches-grundmodell)].

#figure(caption: [Effekte einer Angebotsänderung bei verschiedener Elastizität der Nachfrage], image(
  "img/vwl/arbeitsteilung-wohlfahrt-autarkie.png",
  width: 40%,
))

=== Wohlfahrt bei freiem Handel
==== Szenario: Weltmarktpreis für das Gut > Heimmarktpreis
#grid(
  [
    - Weltmarktpreis liegt über Gleichgewichtspreis bei Autarkie
    - Überschuss wird exportiert
    - Konsumentenrente (jetzt 1) sinkt
    - Produzentenrente (jetzt 2, 3, 4) steigt
    - Gesamtrente _ohne_ freiem Handel: 1, 2, 3
    - Gesamtrente _mit_ freiem Handel: 1, 2, 3, 4
    - Gesamter Wohlfahrt steigt
    - Höhere Preise für inländische Kunden
    - Mehr Lohn für Arbeiter
  ],
  figure(caption: [Wohlfahrt beim Freihandel mit höherem Weltmarktpreis], image("img/vwl/wohlfahrt-freihandel.png")),
)

==== Szenario: Weltmarktpreis für das Gut \< Heimmarktpreis
#grid(
  [
    - Weltmarktpreis liegt unterhalb vom Gleichgewichtspreis bei Autarkie
    - Inländischer Konsum übersteigt inländische Produktion, führt zu Importen
    - Konsumentenrente (jetzt 1, 3, 4) steigt
    - Produzentenrente (jetzt 2) sinkt
    - Gesamtrente _ohne_ freiem Handel: 1, 2, 3
    - Gesamtrente _mit_ freiem Handel: 1, 2, 3, 4
    - Gesamte Wohlfahrt steigt
  ],
  figure(
    caption: [Wohlfahrt beim Freihandel mit tieferem Weltmarktpreis],
    image("img/vwl/wohlfahrt-freihandel-szenario2.png"),
  ),
)

==== Effekt von Importzöllen
#grid(
  [
    - Umverteilung von Konsumentenrente zu Produzentenrente und Staatseinnahmen (Zoll)
    - Konsumentenrente _ohne_ Zölle: 1, 2, 4, 5, 6, 7
    - Konsumentenrente _mit_ Zölle: 1, 4
    - Konsumentenrente sinkt
    - Produzentenrente _ohne_ Zölle: 3
    - Produzentenrente _mit_ Zölle: 2, 3
    - Produzentenrente steigt
    - Staatsrente (Zolleinnahmen): 6
    - Gesamtrente _ohne_ Zölle: 1, 2, 3, 4, 5, 6, 7
    - Gesamtrente _mit_ Zölle: 1, 2, 3, 4, 6
    - Tatsächlicher Wohlfahrtsverlust: 5, 7
    - Der inländische Konsument zahlt die Zölle
  ],
  figure(caption: [Effekt von Importzöllen], image("img/vwl/effekt-importzölle.png")),
)

== Politische Ökonomie des Protektionismus
Freihandel bringt Umverteilung der Wohlfahrt zum Wohle der Konsumenten und Lasten der Produzenten.
Häufig können Produzenten protektionistische Regelungen gegen Interesse der Konsumenten durchsetzen.
Produzenten sicheren sich also eine künstliche Rente durch Staatseingriffe.

=== Moderne Formen des Protektionismus
Organisationen wie die WTO versucht Zölle weltweit abzubauen.
Länder weichen also immer mehr auf nicht-tärifäre Handelshemmnisse aus:
_Quoten_, _Technische Handelshemmnisse_, _Subventionen_, _Öffentliche Aufträge_ (Bevorzugung von Inländer)

=== Fallbeispiel Australische Autoindustrie
Australien hat ihre Autoindustrie nach Abschaffung der hohen Zöllen #hinweis[(bis zu 58%)] komplett verloren.
Grund dafür war, dass die Produktion im Vergleich zum Ausland zu teuer war.
Die australischen Gewerkschaften konnten aufgrund der hohen Gewinne unter den Zöllen hohe Mindestlöhne aushandeln und
haben nach dem Wegfall dieser keine Mindestlohnkürzungen akzeptiert.
Dies führte zur Schliessung sämtlicher Produktionsstätten nach jahrelangen Verlusten.

== Formen der Handelsliberalisierung
Es gibt drei Formen der internationalen Arbeitsteilung:
_Multilaterale Handelsliberalisierung_ #hinweis[(z.B. WTO)],
_Regionale Handelsliberalisierung_ #hinweis[(z.B. EU)],
_Bilaterale Handelsliberalisierung_ #hinweis[(Der Schweizer Weg)].

Regionale und Bilaterale Handelsliberalisierung _diskriminieren_ Drittstaaten, welche nicht Teil dieser sind.
Sie generieren zusätzlichen Handel zwischen beteiligten Staaten, verzerren diesen aber gleichzeitig auch.
Dadurch ergeben sich zwei Effekte: _Handelsschaffung_ und _Handelsumlenkung_.

=== Regionale Integrationsräume
#grid(
  [
    - Ware aus Land C wäre für Land A ohne Zölle billiger als die aus Land B.
      Da Land B jedoch ein Freihandelsabkommen mit Land A abgeschlossen hat, wird von dort importiert.
    - Land C wird diskriminiert
    - Handelsumlenkung von Land C zu Land B
    - Handelsschaffung von $q_C$ zu $q_B$
  ],
  figure(caption: [Regionale Integrationsräume], image("img/vwl/regionale-integrationsraum.png")),
)

==== Positive und negative Wohlfahrtseffekte von regionalen Wirtschaftsräumen
#grid(
  [
    - Konsumentenrente _ohne_ Freihandelsabkommen: 1, 2
    - Konsumentenrente _mit_ Freihandelsabkommen: 1, 2, 3, 4
    - Staatsrente _ohne_ Freihandelsabkommen: 3, 5
    - Gesamtrente _ohne_ Freihandelsabkommen: 1, 2, 3, 5
    - Gesamtrente _mit_ Freihandelsabkommen: 1, 2, 3, 4

    Es gibt keine Produzenten, also existiert auch keine Produzentenrente.

    Schweiz würde mit Land B nur ein Freihandelsabkommen unterschreiben, wenn Feld 4 grösser ist als Feld 5.
    Nur dann steigt die Gesamtwohlfahrt.
  ],
  figure(
    caption: [Positive und negative Wohlfahrtseffekte von regionalen Wirtschaftsräumen],
    image("img/vwl/regionale-integrationsraum-wohlfahrtseffekt.png"),
  ),
)


=== Formen der regionalen Integration
#table(
  columns: (0.97fr, 1fr, 0.8fr, 1fr, 0.8fr, 1.05fr),
  [],
  [Keine Zölle zwischen den Mitgliedern],
  [Gemeinsame Außenzölle],
  [Mobilität der Produktionsfaktoren],
  [Gemeinsame Währung],
  [Gemeinsame Wirtschaftspolitik],

  [Freihandelszone], cell-check, [], [], [], [],
  [Zollunion], cell-check, cell-check, [], [], [],
  [Binnenmarkt], cell-check, cell-check, cell-check, [], [],
  [Währungsunion], cell-check, cell-check, cell-check, cell-check, [],
  [Vollständige Wirtschaftsunion], cell-check, cell-check, cell-check, cell-check, cell-check,
)

== Internationale Wirtschaftsorganisationen
- Bretton-Woods-Institutionen: IWF (IMF), Weltbank (World Bank)
- Weitere Institutionen: WTO, OECD, UNCTAD, G7

=== Internationaler Währungsfond (IWF/IMF)
- Sonderorganisation der UNO mit Sitz in Washington DC, USA mit Ursprung im Bretton-Woods-System
- Hauptaufgabe: Kreditvergabe an Länder ohne ausreichende Währungsreserven mit Zahlungsschwierigkeiten
- Weitere Aufgaben: Internationale Zusammenarbeit in der Währungspolitik, Ausweitung des Welthandels,
  Stabilisierung von Wechselkursen, Überwachung der Geldpolitik, technische Hilfe
- Kreditvergabe an wirtschaftspolitische Auflagen geknüpft, Kredite müssen zurückbezahlt werden
- Rechnungseinheit der IWF ist _Sonderziehungsrecht_ (SZR), quasi Weltgeld im Zahlungsverkehr der Zentralbanken Recheneinheit:
  gewichtete Kurse von USD, Euro, chinesischer Renminbi, Yen und Pfund
- Jedes Land hat eine _Quote_ abhängig von wirtschaftlicher Leistungsfähigkeit
- Die Quote bestimmt Stimmrecht, Einzahlungsverpflichtung #hinweis[(Gold, Devisen, Landeswährung)],
  Inanspruchnahme eines Kredits #hinweis[(Land darf Devisen mit seinen SZR von einem vom IWF bestimmten Land kaufen)]
- Stand 2017: 189 Mitgliedsstaaten mit Stimmanteilen sind USA 17.43%, Japan 6.47%, China 6.4%, Deutschland 5.59%,
  Vereinigtes Königreich 4.23%, Frankreich 4.23%, Italien 3.16 %, Indien 2.75 %, Russland 2.71% und Brasilien 2.32 %.
  Die Schweiz hat 1.21 % Stimmenanteil.
- 85% Mehrheit nötig für Beschlüsse: USA & EU-Staaten haben praktisch Sperrminorität
- Industrieländer wie die USA oder Schweiz beteiligen sich aus Softpower- oder Entwicklungshilfsgründen

=== Weltbank
- Die in Washington DC angesiedelte Weltbankgruppe – multinationale Entwicklungsbank
- Ursprung: Wiederaufbau vom Zweiten Weltkrieg verwüsteten Staaten
- Besteht aus fünf Organisationen: International Bank for Reconstruction and Development,
  International Development Association, International Finance Corporation, Multilateral Investment Corporation,
  Multilateral Investment Guarantee Agency, International Centre for Settlement of Investment Disputes
- Kredite müssen nicht zurückbezahlt werden
- Stimmrechte nach Anteilseigentum verteilt
- USA (15.69 %), gefolgt von Japan (7.79 %), China (5.17 %), Deutschland (4.17 %), dem Vereinigten Königreich (3.81 %),
  Frankreich (3.81 %).

=== Welthandelsorganisation (WTO)
- Sitz in Genf für Regelung von Handels- und Wirtschaftsbeziehungen
- Gründung am 15. April 1994 aus General Agreement on Tariffs und Trade (GATT)
- Dachorganisation für GATT, GATS, TRIPS
- Ziel: Abbau von Handelshemmnissen, Liberalisierung des internationalen Handels durch Deregulierung und Privatisierung
  mit Endziel vom kompletten internationalen Freihandel
- 164 Mitglieder: seit 1995 USA, Japan, Brasilien, Indien, EU, ab 2001 China, ab 2012 Russland
- Mitglieder sind zur Einhaltung einiger Grundregeln bei Ausgestaltung ihrer Aussenhandelsbeziehungen verpflichtet:
  Diskriminierung im Handel beseitigen, Heben des allgemeinen Lebensstandards
- _Prinzip der Meistbegünstigung:_ Sämtliche Vorteile und Begünstigungen von einem Mitgliedsstaat sollen mit allen
  anderen Mitgliedern geteilt werden
- _Prinzip der Inländergleichbehandlung:_ Inländische und ausländische Produkte sollten gleichbehandelt werden
- _Doha-Entwicklungsagenda:_ Liberalisierung des Lebensmittelmarktes. Entwicklungsländer dafür #hinweis[(mehr Exporte)],
  Industrieländer dagegen #hinweis[(Protektionistische Landwirtschaft)]. 2001 gestartet, bisher kein Vertragsabschluss

#figure(caption: [Organigramm Welthandelsorganisation (WTO)], image("img/vwl/wto.png", width: 50%))

=== Organisation für wirtschaftliche Zusammenarbeit und Entwicklung (OECD)
- _Ziele:_ optimale Wirtschaftsentwicklung, hohe Beschäftigung, steigender Lebensstandard fördern, in Mitgliedstaaten und
  den Entwicklungsländern Wirtschaftswachstum fördern, Ausweitung des Welthandels auf multilateraler Basis
- Analysen & Empfehlungen sind orientiert an liberaler, marktwirtschaftlicher und effizienten Wirtschaftsordnung
- Internationale Organisation mit 35 Mitgliedsstaaten, die sich _Demokratie und Marktwirtschaft_ verpflichtet fühlen,
  hauptsächlich mit hohem Pro-Kopf-Einkommen. Russland und China sind keine Mitglieder.

=== Konferenz der Vereinten Nationen für Handel und Entwicklung (UNCTAD)
- _Ziel:_ Förderung des Handels zwischen Ländern mit unterschiedlichen Entwicklungsstand, Verständigung zwischen Süd- und
  Nordhalbkugel verbessern, Neue Weltwirtschaftsordnung (NWO) erarbeiten
- NWO ist ein Plan zur Reformierung internationaler Wirtschaftsbeziehungen zwischen Entwicklungsländern und Industrienationen
  zu Gunsten der Entwicklungsländer
- Jedes Land hat eine Stimme, Vorgehen wird also praktisch gesehen durch Entwicklungsländer bestimmt

=== G7
- Zusammenschluss zu ihrem Gründungszeitpunkt bedeutendsten Industrienationen der westlichen Welt mit regelmässigen Treffen
- _Ziel:_ Fragen der Weltwirtschaft zu erörtern
- Deutschland, Frankreich, Italien, Japan, Kanada, Vereinigtes Königreich, USA
- 1998 Erweiterung durch Russland (G8), 25.März 2024: Ausschluss Russland wegen Annexion der Krim

#pagebreak()

= Europäische Integration
#v(-0.5em)
== Beginn der Europäischen Integration
Neuordnung der Weltwirtschaft im Anschluss des 2. Weltkrieg (Bretton Woods-Konferenz, 1944):
Gründung des Internationaler Währungsfond (IWF) und der Weltbank (World Bank).
Auch in Europa bewegte sich etwas -- _Start der Europäischen Integration_ im Spannungsfeld zwischen _Vertiefung_
#hinweis[(Von der Zollunion hin zur Europäischen Verfassung)] und der _Erweiterung_
#hinweis[(Hinzufügen von osteuropäischen Ländern, Osterweiterung)].

Verhindern eines weiteren grossen Krieges in Europa mittels wirtschaftlicher Verknüpfung:
- _1951 (EGKS der 6):_ Belgien, Deutschland, Frankreich, Italien, Luxemburg, Niederlande
- _1973 (EG der 9):_ Dänemark, Irland, Vereinigtes Königreich
- _1981 (EG der 10):_ Griechenland
- _1986 (EG der 12):_ Portugal, Spanien
- _1995 (EU der 15):_ Finnland, Österreich, Schweden
- _2004 (EU der 25):_ Estland, Lettland, Litauen, Malta, Polen, Slowakei, Slowenien, Tschechien, Ungarn, Zypern
- _2007 (EU der 27):_ Bulgarien, Rumänien
- _2013 (EU der 28):_ Kroatien
- _2017 (EU der 27):_ Brexit (Vereinigtes Königreich)

Die nachfolgenden Länder befinden sich im Prozess der _Integration der EU-Rechtsvorschriften_ in nationales Recht:
Albanien #hinweis[(Korrupt)], Bosnien-Herzegowina #hinweis[(Korrupt)], Moldau #hinweis[(Besetzt von Russland)],
Montenegro #hinweis[(Korrupt)], Nordmazedonien #hinweis[(Korrupt)], Serbien #hinweis[(Autoritär)],
Türkei #hinweis[(Autoritär, viele Kriege)], Ukraine #hinweis[(im Krieg)]

Potentielle Beitrittskandidaten: Georgien #hinweis[(Stabilitätsprobleme)],
Kosovo #hinweis[(Fehlende internationale Anerkennung der Unabhängigkeit)]

== Kopenhagener Kriterien
1993 in Kopenhagen von der EU formulierte Kriterien, beschreiben Voraussetzungen um der EU beizutreten.

1. _Politisches Kriterium:_ Institutionelle Stabilität als Garantie für demokratische und rechtsstaatliche Ordnung,
  für die Wahrung der Menschenrechte sowie die Achtung und den Schutz von Minderheiten.
2. _Wirtschaftliches Kriterium:_ Eine funktionsfähige Marktwirtschaft sowie die Fähigkeit, dem Wettbewerbsdruck und
  den Marktkräften innerhalb der EU standzuhalten.
3. _Acquis-Kriterium:_ Die Fähigkeit, alle Pflichten der Mitgliedschaft – d. h. das gesamte Recht sowie die Politik der EU
  #hinweis[(den sogenannten "Acquis communautaire")] – zu übernehmen, sowie das Einverständnis mit den Zielen der
  Politischen Union und der Wirtschafts- und Währungsunion.
4. _Aufnahmefähigkeit der EU:_ Kann die EU die Aufnahme dieses Landes "verkraften"?
  Lange Zeit wurde es als das "vergessene Kriterium" von Kopenhagen bezeichnet.
  Dieser Bedingung, auf welche die Kandidatenländer wenig Einfluss haben, kommt mit jeder Erweiterungsrunde eine wachsende
  Bedeutung zu

== Vertiefung der Europäischen Integration
#grid(
  columns: (1.2fr, 1fr),
  align: horizon,
  figure(caption: [Vertiefung der EU], image("img/vwl/europa.png", width: 90%)),
  figure(caption: [Organe & Strukturen der EU], image("img/vwl/struktur-eu.png")),
)

=== EGKS, Zollunion (1951)
Die Europäische Gemeinschaft für Kohle und Stahl (EGKS) war eine Zollunion für Kohle und Stahl, sollte aber hintergründig auch
nach dem zweiten Weltkrieg helfen, den europäischen Kontinent wirtschaftlich wieder aufzubauen und einen dauerhaften Frieden
gewährleisten. Ursprünglich war die EKGS nur gedacht, um die deutsch-französische Stahl- & Kohleproduktion zusammenzuführen.
Diese Güter waren relevant für die Industrie, aber auch für die Kriegsführung auf dem Streitgebiet zwischen Deutschland und
Frankreich. Doch bei der Vertragsunterzeichnung waren auch Belgien, Italien, Luxemburg und Niederlande als
Gründungsmitglieder dabei.

Sorgte für freien Warenverkehr dieser Güter ohne Zölle, Abgaben und diskriminierende Massnahmen.

Die EGKS stiess 1954 mit dem gescheiterten Versuch, mittels der Europäischen Verteidigungsgemeinschaft (EVG) eine eigene
gemeinsame Armee zu schaffen, an ihre Grenzen.

=== EWG und Euroatom, Zollunion (1957)
Ausbau der Zollunion mit allen Gütern (Europäische Wirtschaftsgemeinschaft EWG) und die Schaffung einer
Europäischen Atomgemeinschaft (Euroatom).
Unterzeichnet in Rom, die "Römischen Verträge".
Die Errichtung der EWG und damit die Schaffung des freien Marktes verfolgte zwei Ziele:
_Umgestaltung der wirtschaftlichen Bedingungen des Handels und der Produktion_ auf dem Gebiet der Gemeinschaft und
als Beitrag zur funktionellen _Errichtung eines politischen Europas_ in Richtung einer umfassenderen europäischen Integration.

_Die 4 Freiheiten des EWG:_ Freie Verkehr von Waren, Personen, Dienstleistungen & Kapital

Stellen mit EGKS die 3 Gründungsverträge der EU dar.
Die früheren Zölle wurden durch einen gemeinsamen Zolltarif für Drittstaaten ersetzt.
Begleitet wird dies durch eine _gemeinsame Handelspolitik_

=== EFTA, Freihandelszone (1960)
Freihandelszone zwischen Ländern, die nicht Teil der EWG waren
#hinweis[(Schweiz, Dänemark, Grossbritannien, Norwegen, Österreich, Portugal, Schweden)].
Das Ziel war ein gemeinsames Auftreten der Mitgliedsstaaten gegenüber der EWG, um wirtschaftliche Nachteile zu vermeiden und
zu beweisen, dass Freihandelszonen in Europa funktionieren könnten.

=== EG (1967)
Bündelung der EGKS, Euratom und EWG in der Europäischen Gemeinschaft EG.
Unter der EG wurde mit den einzelnen EFTA-Staaten Freihandelsabkommen geschlossen.
Diese bildeten unter anderem den Grundstein für die Bilateralen I und II für den Export nach Europa der Schweiz.

=== EU, Wirtschaftsunion (1992)
Der Vertrag zur Europäischen Wirtschaftsgemeinschaft (EWG) war die Grundlage zur Schaffung von Zollunion und _Binnenmarkt_.
Die Verträge zur Gründung der EU, eine _Wirtschaftsunion_ und _Währungsunion_ beruht auf 3 Säulen:
- EG bleibt das tragende Element (erste Säule)
- Einstieg in eine "Gemeinsame Außen- und Sicherheitspolitik" (zweite Säule)
- "Zusammenarbeit der Justiz- und Innenminister" (dritte Säule, Innen- und Justizpolitik) erschloss neue,
  wichtige Handlungsbereiche

Die Botschaft des EU-Vertrags: Mehr als eine Wirtschaftsgemeinschaft, sondern die Politische Union Europas.
Vertrag keine auf Dauer angelegte europäische "Verfassung".
Die EU ist kein Staat oder Bundesstaat im traditionellen Sinne, sondern Staatenverbindung ganz eigener Art.

=== EWU, Währungsunion (1999)
Die Europäische Währungsunion stellt den Zusammenschluss von EU-Mitgliedsstaaten auf dem Gebiet der Geld- & Währungspolitik dar.
1999 mit elf Staaten #hinweis[(Belgien, Deutschland, Finnland, Frankreich, Irland, Italien, Luxemburg, Niederlande, Österreich,
Portugal & Spanien)]. Später kamen Griechenland, Slowenien, Malta, Zypern, Slowakei, Estland, Lettland und Litauen dazu.

EU-Staaten, welche den Euro nicht eingeführt haben, sind verpflichtet, der Währungsunion beizutreten, sobald Konvergenzkriterien
erfüllt sind. _Ausnahme: Dänemark & Grossbritannien (Opting-Out-Klausel)_.
Sie können selbst entscheiden, ob die der Währungsunion beitreten, wenn sie die Konvergenzkriterien erfüllen.

Die im EU-Vertrag festgelegten Konvergenzkriterien sind:
- _Preisstabilität:_ Inflationsrate ist nicht mehr als 1.5 Prozentpunkte über den drei preisstabilsten Mitgliedsländer der EU.
- _Höhe der langfristigen Zinsen:_ Langfristige Nominalzinssätze dürfen nicht mehr als 2 Prozentpunkte über Zinssätze der
  drei preisstabilsten Mitgliedsländer der EU sein
- _Haushaltsdisziplin:_ Das jährliche öffentliche Defizit sollte nicht mehr als 3% des BIP sein und der
  Öffentliche Schuldenstand nicht mehr als 60% des BIPs.
- _Wechselkursstabilität:_ Mindestens zwei Jahre Teilnahme am "Wechselkursmechanismus II".
  Dabei darf der Wechselkurs der eigenen Währung keinen starken Schwankungen gegenüber dem Euro ausgesetzt sein.

Beispiel: _Schweden_ verstösst regelmässig gegen die Wechselkurstabilität, um den Euro nicht übernehmen zu müssen.

=== EWR, Binnenmarkt (1994)
Der Europäische Wirtschaftsraum (EWR) ist ein _Binnenmarkt_ zwischen EU und EFTA.
Im Mai 1992 unterzeichneten alle 12 Mitgliedsstaaten der EU und die damaligen Mitglieder der EFTA den Vertrag.
_Ausnahme_: Die Schweiz entschied sich durch Referendum gegen den Beitritt.
Durch Bilaterale Verträge mit der EU hat sie dennoch Status eines "quasi-EWR-Mitglieds".

=== EU Verfassung (2004)
Diese Verfassung sollte das Gesamtgut der geschlossen Verträge ersetzen, mit Ausnahme des Euratom-Vertrags.
Zum ersten Mal in der Geschichte sollte Europa eine gemeinsame Verfassung erhalten.
Der Ratifizierungsprozess lief zwar in mehreren Ländern erfolgreich durch, _scheiterte_ aber in anderen bei Volksabstimmungen:
2005 lehnten Frankreich und die Niederlande diese ab.

Die Gründungsländer der EU konnten nie über einen Beitritt zu dieser abstimmen.
Die Volksabstimmungen zur EU-Verfassung waren Teil des Wahlkampfs in Frankreich und der Niederlande, es war eine freiwillige
Entscheidung durch die regierenden Parteien. Es war der erste Moment, in welchem das Volk über die EU entscheiden konnte.
Die EU als "Projekt Einheitsstaat" steht im direkten Widerspruch mit Nationalismus.
Mit dem Scheitern war die weitere Zukunft der EU-Verfassung unklar, nur wenn alle Staaten ratifizierten, konnte er in Kraft treten.

Der Vertrag von Lissabon (2009) wurde als Alternative zur Verfassung entwickelt.
Seitdem Stabilisierung von Krisen in der EU, keine grossen Energie für Weiterentwicklung.

== Die Schweiz und die EU
Der Bundespräsident René Felber reichte 1992 ein offizielles EU-Beitrittsgesuch der Schweizer Regierung ein.
Das Beitrittsgesuch wurde von_ 4 von 7 Bundesräten angenommen._ Dumm nur, dass ausser ihnen niemand davon etwas wusste.
Als dies bekannt wurde, heizte dies die Gemüter in der Bevölkerung an und löste eine Volksabstimmung aus.
50.3% stimmten gegen den Beitritt zur EWR.

Der Ständerat stimmte erst 2016 offiziell mit 27 zu 13 Stimmen zu, das 1992 eingereichte _Beitrittsgesuch offiziell zurückzuziehen_.
Der Nationalrat befürwortete dies mit 126 zu 46 Stimmen ebenfalls.
Der Bundesrat teilte der EU mit, das Gesuch seit "als zurückgezogen zu betrachten". Der Rückzug war reine Symbolpolitik.

#grid(
  align: horizon,
  figure(caption: [Abstimmungen zur EU], image("img/vwl/eu-abstimmungen.png")),
  figure(caption: [Wirtschaftliche Bedeutung der EU für die Schweiz], image("img/vwl/eu-ch-handel.png")),
)

Die Schweiz entwickelte darauf _bilaterale Verträge_ mit der EU: Die Bilateralen I (1999) und Bilateralen II (2004).
Darauf folgten weitere bilaterale Abkommen bis 2014.

#table(
  columns: (1fr, 1.05fr),
  table.header([Bilateralen I], [Bilateralen II]),
  [
    + Personenfreizügigkeit (FZA)
    + Technische Handelshemmnisse
    + Öffentliches Beschaffungswesen
    + Landwirtschaft
    + Forschung
    + Luftverkehr
    + Landverkehr
    _Bedeutung_: Erleichterter Zugang zu den Arbeits-, Waren- und Dienstleistungsmärkten
  ],
  [
    + Schengen/Dublin
    + Zinsbesteuerung
    + Betrugsbekämpfung
    + Landwirtschaftliche Verarbeitungsprodukte
    + MEDIA (Kreatives Europa)
    + Umwelt
    + Statistik
    + Ruhegehälter
    + Bildung, Berufsbildung, Jugend
    _Bedeutung_: Vertiefte Zusammenarbeit in weiteren Bereichen, verbesserte wirtschaftliche Rahmenbedingungen
  ],
)

Die institutionellen Rahmenabkommen sind seit 2014 politisches Dauerthema.
Durch die Annahme der _Masseneinwanderungsinitiative_ wurden die Bilateralen im Punkt Personenfreizügigkeit verletzt.
Die Schweiz sorgte zwar für eine schwache Implementierung der Masseneinwanderungsinitiative
#hinweis[(Inländervorrang bei Stellen)], um Verträge mit der EU nicht zu brechen. Dies war für die EU gerade noch so in Ordnung.
Dann leistete sich die Schweiz aber ihren grössten politischen Fauxpas im Umgang mit der EU: Kroatien trat neu der EU bei,
und bat die Schweiz ihnen auch die Bilateralen I & II anzubieten. _Die Schweiz verweigerte Kroatien aber die Bilateralen_.

Damit waren für die EU Schweizer Aktionen im europäischen Raum nicht mehr haltbar.
Die EU erlaubte der Schweiz nicht mehr mit EU-Ländern einzeln zu verhandeln, sondern nur noch mit der EU als Ganzes.
Die EU war nicht mehr bereit, weitere bilaterale Verträge mit der Schweiz abzuschliessen, bis nicht ein entsprechendes
_Rahmenabkommen_ abgeschlossen wird. Diese Verhandlungen hat der Bundesrat einseitig am 26. Mai 2021 abgebrochen.
Damit wurde die Schweizer Teilnahme an EU-Projekten wie Horizon #hinweis[(europäische Forschungsprojekte)] oder
Erasmus #hinweis[(europäischer Studentenaustausch)] gestrichen.

Die _Konfliktpunkte_: Unionsbürgerrichtlinie #hinweis[(Einwanderung auch ohne Arbeit)],
Übernahme heutiges und zukünftiges EU-Rechtes #hinweis[(vor allem die Auswirkungen auf die direkte Demokratie dadurch)],
Gefährdung der Schweizer Lohnschutz durch Arbeitsmigration, Streitigkeiten bezüglich Entscheide durch EFTA-Gericht,
Auslegung von EU-Regeln durch Europäischen Gerichtshof (EuGH) #hinweis[(Kampagne "Fremde Richter" der SVP)].

Neue Verhandlungen mit der EU wurden nach 3 Jahren wiederaufgenommen, im Herbst 2024 wurden lockere Gespräche geführt,
welche im Frühling 2025 in Vertragsverhandlungen mündeten.
Grundsätzliches Problem, der Schweiz ist, dass Entscheidungen des Parlaments durch das Volk überstimmt werden können.
Die Schweiz ist damit aus Sicht der EU keine seriöse Geschäftspartnerin und nicht relevant genug, um als gleichwertiger
Partner zu gelten.


= Zahlungsbilanz Schweiz
Die Schweiz ist ein stark in die Weltwirtschaft eingebundenes Land, dessen Wirtschaft sich durch eine ausgeprägte
_internationale Orientierung_ auszeichnet.
Unser Wohlstand hängt deshalb zu einem grossen Teil vom internationalen Handel von Gütern und Dienstleistungen sowie von der
grenzüberschreitenden Investitionstätigkeit ab

== Zahlungsbilanz
In der Zahlungsbilanz werden _Transaktionen_ #hinweis[(grenzüberschreitende Zahlungen)] zwischen Akteuren im Inland und
Akteuren im Ausland während eines Jahres ausgewiesen. Die Zahlungsbilanz _misst Veränderungen_, nicht Bestände.
Die Zahlungsbilanz ist eigentliche keine Bilanz #hinweis[("Blitzlicht-Aufnahme")], sondern entspricht eher einer _Kapitalflussrechnung_.

Die Zahlungsbilanz besteht aus:
- _Leistungsbilanz_: Erfasst alle Ausgaben und Einnahmen einer Volkswirtschaft
  #hinweis[(z.B. Exporte und Importe, Lohnzahlungen für Grenzgänger usw.)]
- _Bilanz der Vermögensübertragungen_: Erfasst alle unentgeltlichen Leistungen zwischen In- und Ausland mit einmaligen oder
  zumindest unregelmässigem Charakter #hinweis[(z.B. Erlass von Schulden, Schenkungen, Erbschaften usw.)]
- _Kapitalbilanz_: Erfasst Kapitalexporte und -importe sowie Veränderungen der Devisenreserven
  #hinweis[(z.B. Direktinvestitionen, Wertpapieranlagen, Währungsreserven usw.)]

Die Zahlungsbilanz besteht aus zwei Seiten. Die _Leistungsbilanz_, zu welcher die Bilanz der Vermögensübertragung dazu gehört
und die _Kapitalbilanz_. Diese hängen miteinander zusammen, sodass _die Zahlungsbilanz immer gleich null_ ist.

#figure(caption: [Zahlungsbilanz], image("img/vwl/zahlungsbilanz.png", width: 65%))

=== Leistungsbilanz
- _Handelsbilanz_: Exporte und Import von Gütern
  #hinweis[(Wenn die Schweiz Güter exportiert, fliesst Geld vom Ausland in die Schweiz $->$ Zahlungseingang)]
- _Dienstleistungsbilanz_: Dienstleistungen, welche aus dem Ausland eingekauft oder dem Ausland verkauft werden
  #hinweis[(Kauf von Spotify-Abos, Verkauf von Bankdienstleistungen, Tourismus)]
- _Erwerbsbilanz_: Lohn für Grenzgänger
- _Vermögensbilanz_: Dividenden #hinweis[(Dividenden von ausländischen Aktien sind Zahlungseingang,
  Dividenden an einen Ausländer einer Schweizer Aktie ist Zahlungsausgang)]
- _Laufende Übertragungen_: z.B Rimessen #hinweis[(Personen mit Niederlassungsbewilligung schicken Geld in die Heimat)]
- _Bilanz der Vermögensübertragungen_: Einmalige Zahlungen z.B. Erben, Lottogewinne
- _Primäreinkommen:_ Grenzüberschreitend gezahlte Löhne sowie grenzüberschreitend erwirtschaftete Einkommen aus Vermögensanlagen
  #hinweis[(Zins- und Dividendenzahlungen)].
- _Sekundäreinkommen:_ Regelmässige grenzüberschreitende Zahlungen, denen _keine unmittelbaren Leistungen_ des Auslands
  gegenüberstehen. Darunter entfallen u.a. Überweisungen der im Inland beschäftigten _ausländischen Arbeitnehmer in ihre
  Heimatländer_ sowie Zahlungen des Inlands an internationale Organisationen und Leistungen im Rahmen der Entwicklungszusammenarbeit.

Gemeine Frage: Ein Liechtensteiner mit Arbeitsstelle in Buchs SG; ist dessen Lohn ein Zahlungseingang oder Zahlungsausgang?
Weder noch, da sie auch den Schweizer Franken haben.

Ist _Zahlungseingang grösser als Zahlungsausgang_ handelt es sich um einen _Leistungsbilanzüberschuss_.
Ist _Zahlungseingang kleiner als Zahlungsausgang_ handelt es sich um eine _Leistungsbilanzdefizit_
#hinweis[(Länder leisten sich einen höheren Gegenwartskonsum als dies in der Zukunft möglich sein wird)].
Die Schweiz hat einen Überschuss.

Die Bilanz der Primäreinkommen schliesst in der Schweiz in der Regel positiv ab.
Die Arbeitseinkommen von Grenzgänger sind aber in der Regel defizitär.

#grid(
  align: horizon,
  figure(caption: [Leistungsbilanz der Schweiz], image("img/vwl/leistungsbilanz-schweiz.png")),
  figure(caption: [Leistungsbilanz international], image("img/vwl/leistungsbilanz-international.png", width: 90%)),
)

Die USA hat in der Handelsbilanz ein Defizit. Darum will Trump Zölle.
Sie haben jedoch einen Überschuss bei der Dienstleistungsbilanz. Trump müsste die gesamte Leistungsbilanz berücksichtigen.

#grid(
  align: horizon,
  figure(caption: [Leistungsbilanz der USA], image("img/vwl/leistungsbilanz-usa.png")),
  figure(caption: [Handelsbilanz Schweiz], image("img/vwl/handelsbilanz-schweiz.png")),
)

=== Kapitalbilanz
Erklärt, was mit dem Geld des Leistungsbilanzüberschusses gemacht wird.

- _Direktinvestition_: Mehr als 10% einer Firma im Ausland aufkaufen #hinweis[(Mitbestimmung bei Firmengeschäften)]
- _Portfolioinvestition_: Im Ausland Wertpapiere ohne Stimmrecht kaufen #hinweis[(zur Spekulation, nicht um Firmen zu übernehmen)]
- _Übriger Kapitalverkehr_: Im Ausland Kredite gewähren
- _Devisenbilanz_: Währungsreserven erhöhen

Die Schweizerische Nationalbank unterscheidet zwischen Direktinvestitionen und Portfolioinvestitionen.
Unter _Direktinvestitionen_ werden allgemein Kapitalanlagen verstanden, die ein Investor vornimmt, um die
_Geschäftstätigkeit eines Unternehmens_ im Ausland direkt und dauerhaft zu beeinflussen.
Statistisch als internationale Direktinvestitionen erfasst werden die _Gründung einer Tochtergesellschaft oder
Zweigniederlassung_ im Ausland sowie die_ Beteiligung eines Investors_ von mindestens 10% am stimmberechtigten Kapital einer
Unternehmung im Ausland. Internationale _Portfolioinvestitionen_ sind demgegenüber Kapitalbeteiligungen im Ausland,
die _ohne Absicht direkter Management-Beeinflussung_ vorgenommen werden, wie z.B. _Schuldtitel_
#hinweis[(Geldmarktpapiere, Obligationen)], _Dividendenpapiere_ #hinweis[(Aktien, Partizipationsscheine, Genussscheine)] und
_Anlagefondszertifikate_.

=== Fallbeispiel
Bei den Beträgen handelt es sich immer um Veränderungen, nicht um Bestände.

==== 2002 bis 2007
Leistungsbilanzüberschuss von 400. Mehr Geld ist in die Schweiz geflossen als ins Ausland.
Damit könnte man einen Kapitalexport von 400 finanzieren. Kapitalexport liegt jedoch bei 420.
Die 20 kommen von den Währungsreserven.

==== 2008 bis 2015
Leistungsbilanzüberschuss von 460. Kapitalflüsse bei -100. Heisst entweder hat die Schweiz 100 Direktinvestitionen oder
Portfolioinvestition aufgelöst oder das Ausland hat für 100 mehr Schweizer Unternehmen gekauft als die Schweiz im Ausland.
460 und 100 fliessen beide den Währungsreserven zu.

#figure(caption: [Fallbeispiel Zahlungsbilanz], image("img/vwl/zahlungsbilanz-fallbeispiel.png", width: 60%))

2016 hat die Schweizer Wirtschaft zwar erneut einen hohen Leistungsbilanzüberschuss erwirtschaftet, aber
_netto kaum Kapital exportiert_. Ohne Nationalbank wäre der Franken deshalb viel stärker.
Die Schweizer Wirtschaft nimmt im Verkehr mit dem Ausland traditionell _mehr ein, als sie ausgibt_.
Soll die so entstehende _Nachfrage nach Franken_ diesen nicht zu weiteren Höhenflügen antreiben, müssen Investoren das
überschüssige _Kapital ins Ausland exportieren_.
Die Schweiz hat im vergangenen Jahr einen _Leistungsbilanzüberschuss von 69.5 Mrd. Fr._ erwirtschaftet.
Das entspricht -- im internationalen Vergleich sehr hohen -- knapp 11% des Bruttoinlandsprodukts.
Dazu beigetragen haben sowohl der Waren- wie auch der Dienstleistungshandel, doch rund die Hälfte des Saldos steuerten alleine
schon die _Kapitaleinkommen_ aus den grossen Auslandsvermögen bei.

#grid(
  align: horizon,
  [
    Schweizer Unternehmen haben netto Kapital für Direktinvestitionen ins Ausland exportiert.
    Schweizer Anleger tätigten aber kaum Portfolioinvestitionen im Ausland, und interessanterweise sind auch Ausländer nicht in
    den Franken geflüchtet, sondern haben ihre Portfolioinvestitionen reduziert.
    Vor allem aber haben die übrigen Verpflichtungen gegenüber dem Ausland (besonders aus Bankkrediten) sehr stark zugenommen.
    In der Summe wäre deshalb der Saldo der Kapitalverkehrsbilanz nahe bei null zu stehen gekommen, wäre da nicht
    _die Nationalbank eingesprungen_. Ihr Kapitalexport durch Zukauf und Rendite ihrer Währungsreserven hat alleine praktisch
    den gesamten Überschuss der Leistungsbilanz gedeckt und so eine weitere Stärkung des Frankens verhindert.

  ],
  figure(caption: [Schweizerische Zahlungsbilanz], image("img/vwl/zahlungsbilanz-schweiz.png")),
)

=== Währungsmanipulation

Länder können mit einer bewussten Schwächung der inländischen Währung Exportvorteile schaffen.
Von einer Währungsmanipulation spricht die USA, wenn zwei von drei Kriterien aus einer Liste erfüllt werden:

+ ein _Handelsüberschuss mit den USA_ von mindestens 15 Milliarden Dollar
+ ein _Leistungsbilanzüberschuss_ von über drei Prozent des BIP
+ anhaltende, _einseitige Netto-Devisenkäufe_ #hinweis[(in der Regel mit "neuem" Zentralbankengeld)]

Im vergangenen Jahr 2023 habe offenbar kein bedeutender Handelspartner seine Währung manipuliert, hiess es im halbjährlichen
Bericht des US-Finanzministeriums. Auf der Beobachtungsliste stehen weiter Deutschland, China, Vietnam, Taiwan, Malaysia und
Singapur. Die Aufnahme erfolgt automatisch.

== Schweizer Freihandelsabkommen
#figure(caption: [Freihandelsabkommen der Schweiz], image("img/vwl/freihandelsabkommen-schweiz.png", width: 65%))

Die Schweiz verfügt - neben der EFTA-Konvention und dem Freihandelsabkommen mit der Europäischen Union (EU) - gegenwärtig über
ein Netz von 30 Freihandelsabkommen mit 40 Partnern. Die Abkommen werden normalerweise im Rahmen der
Europäischen Freihandelsassoziation (EFTA) abgeschlossen. Dennoch hat die Schweiz die Möglichkeit, Freihandelsabkommen auch
ausserhalb der EFTA abzuschliessen, wie beispielsweise im Fall Japans oder Chinas.

=== Freihandelsabkommen Mercosur - Schweiz (EFTA)
Freihandelsabkommen mit südamerikanischen Mercosur-Staaten #hinweis[(Argentinien, Bolivien, Brasilien, Paraguay, Uruguay, Venezuela)].
Dagegen sind Vertreter indigener Bevölkerungen wegen Angst vor Umweltschäden, Schweizer Bauern wegen Angst vor Konkurrenz
#hinweis[(laxere Standards bezüglich Tierhaltung, Nachhaltigkeit & Pflanzenschutz)] und auch linke Organisation wegen Sorgen
ums Arbeitsrecht usw. Das Abkommen wurde bereits unterzeichnet, ist aber noch nicht in Kraft getreten.

#pagebreak()
#columns(2)[
  #set text(size: 0.67em)
  #show outline.entry: entry => {
    v(-.3em)

    entry
  }
  #outline(target: figure, title: "Abbildungsverzeichnis")
]
