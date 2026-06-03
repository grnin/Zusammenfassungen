// Vorlesungsfolien als Typst, Notizen in eigener Typst Box
// pdf hat 25 im name, schauen ob es aktuell ist

#let link_box(content) = block(fill: rgb("#eef2ff"), inset: 10pt, radius: 8pt, spacing: 0.75em, content)

#let notiz(content) = text(
    // text: rgb("#da05a1"),
    fill: rgb("#e007a6"),
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

= Gesetzliche Bestimmungen

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

        OR 404 = bei Täuschung

    ],
)

= Theorie: OR AT & BT
#image("/assets/image-5.png")


= Formvorschriften

== Gründe für Formvorschriften

1. Beweissicherung
2. Schutz vor übereiltem Vertragsschluss
3. Rechtssicherheit
4. Schutz der schwächeren Partei

== Vertragsformen

=== Formfreiheit (Art. 11 OR)
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

=== Einfache Schriftlichkeit (Art. 13 – 15 OR)
Ist die einfache Schriftlichkeit vorgesehen, muss der
Vertrag die eigenhändige Unterschrift oder eine
qualifizierte elektronische Signatur aller beteiligten
Personen aufweisen.

- Schenkungsversprechen
- Lehrvertrag
- Versicherungsvertrag
- Konkurrenzverbot im Arbeitsvertrag

=== Qualifizierte Schriftlichkeit
Die qualifizierte Schriftlichkeit verlangt nicht nur die
Unterschrift der Verpflichteten, sondern die
handschriftliche Angabe gewisser Elemente in der
Urkunde.

- Bürgschaft
- Testament

=== Öffentliche Beurkundung
Bei der öffentlichen Beurkundung erfolgt der
Vertragsschluss unter Mitwirkung einer
Urkundsperson (z.B. Notar). Die Urkundsperson
bestätigt die Richtigkeit des Inhaltes der Urkunde.

- Grundstückkaufvertrag
- Vorvertrag über ein Grundstück mit Kaufpreis
- Bürgschaft natürlicher Personen, wenn die Haftungssumme über Fr. 2'000.– liegt
- Ehe- und Erbvertrag

= Vertragstypen
#pruefung[Vertragstypen nur nice to know, einfach kennen, Thema IT Vertrag]
// Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 101.

**Auch**

**Innominatverträge**

**:**

**Gemischte Verträge oder Verträge eigener**

**Art (Neuschöpfungen der Vertragspraxis**

= Rechtssubjekte

![](media/image4.jpg){width="12.322222222222223in"
height="4.7820833333333335in"}

Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 268.

= Stellvertretung mit Ermächtigung

**Voraussetzungen:**

\-

**Vertretungsmacht**

**Vertreter**

**Dritter**

**Vertretener**

Vertragsabschluss

Vertragswirkung

Grundverhältnis

(

bspw. Auftrag mit Vollmachtserteilung

)

> **- Handeln in fremdem Namen**
>
> **Merke:** Die Erklärung des Vertreters, in fremdem Namen zu handeln
> kann entweder ausdrücklich oder stillschweigend erfolgen, gemäss Art.
> 32 Abs. 2 OR genügt es, dass der Dritte aus den Umständen auf das
>
> Vertretungsverhältnis schliessen muss (Z. Bsp. Angestellter in einem
> Einkaufsgeschäft)

= Stellvertretung ohne Ermächtigung

→

**vgl. Art. 38**

**-**

**39**

**OR oder auch 419 ff. OR**

**«Vertreter»**

**Dritter**

**«Vertretener»**

Vertragsabschluss

Vertragswirkung nur mit

Genehmigung (Art. 38 Abs. 1 OR

)

Fehlende Vollmacht

**Arten von Vollmachten:** Spezialvollmacht, Generalvollmacht und
Gattungsvollmacht, Einzel- und

Kollektivvollmacht

**Sog. Unechte Stellvertretung:** Handeln für fremde Rechnung, aber in
eigenem Namen, siehe Art. 32 Abs. 3 OR

= Vertragsschluss

> ![](media/image9.jpg){width="11.234027777777778in"
> height="5.239861111111111in"}

Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 16.

= Vertragsschluss

> ![](media/image10.jpg){width="11.0in" height="4.761527777777777in"}

Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 17.

= Antrag

- Der Antrag ist ein einseitiges Rechtsgeschäft, der auf den Abschluss
    eines Vertrages gerichtet ist.

- Begrifflichkeiten:

- Empfangsbedürftigkeit

- Unterscheidung verbindlicher -- und unverbindlicher Antrag (vgl. Art.
    7 OR)

- Antrag unter Anwesenden resp. Abwesenden (vgl. Art. 4 und 5 OR)

- Widerruf (Art. 9 OR)

= Annahme

- Die Annahme ist ein einseitiges Rechtsgeschäft.

- Begrifflichkeiten:

- Einverständnis in den wesentlichen Punkten («essentialia negotii»)

- Empfangsbedürftigkeit

- Stillschweigende Annahme (Art. 6 OR)

- Widerruf (Art. 9 OR)

- Widerruf beim Haustürgeschäft (Art. 40a ff. OR)

= Allgemeine Geschäftsbedingungen (AGB's)

+-----------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------+
| ----------------------------------------------------------------------- | +-----------------------------------------------------------------------+ |
| Begriff | | - generell vorformulierte Bestimmungen, die Inhalt des Vertrages | |
| ----------------------------------------------------------------------- | | werden | |
| | | | |
| ----------------------------------------------------------------------- | | - gelten für eine Vielzahl von Verträgen | |
| | | | |
| | | - Abweichungen vom dispositiven Recht | |
| | +=======================================================================+ |
+===========================+=======================================================+=======================================+=========================================================+
| ----------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Geltung | nur verbindlich, wenn von den Parteien übernommen, d.h. keine |
| ----------------------------------------------------------------------- | allgemeine Verbindlichkeit |
| | ----------------------------------------------------------------------- |
| ----------------------------------------------------------------------- | |
| | ----------------------------------------------------------------------- |
+-----------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------+
| ----------------------------------------------------------------------- | +-----------------------------------------------------------------------+ |
| keine Geltung, trotz Übernahme | | - Verstoss gegen zwingendes Recht | |
| ----------------------------------------------------------------------- | | | |
| | | - abweichende individuelle Regelung | |
| ----------------------------------------------------------------------- | | | |
| | | - keine Möglichkeit, sich vom Inhalt Kenntnis zu verschaffen | |
| | | | |
| | | - ungewöhnliche Klausel | |
| | | | |
| | | - missbräuchlicher Inhalt (Art. 8 UWG) | |
| | +=======================================================================+ |
+---------------------------+-------------------------------------------------------+---------------------------------------+---------------------------------------------------------+
| Auslegung | | > bei Unklarheiten gegen den | |
| | | > Verfasser | |
+---------------------------+-------------------------------------------------------+---------------------------------------+---------------------------------------------------------+

= Erfüllung der Obligation

> **Erfüllen einer Obligation heisst:**
>
> richtige (mängelfreie) und rechtzeitige Erfüllung
>
> **Wichtige Einzelpunkte der Erfüllung: -** Person des Erfüllenden
> (vgl. OR 68, 321, 364 II, 398 III

- Gegenstand (vgl. OR 2 I)

- Ort der Erfüllung (vgl. OR 74, 189 I)

- Zeit der Erfüllung (vgl. OR 75, 213 I, 257c, 318, 323 I, 372 I

> **Die meisten Erfüllungsregeln des Allgemeinen Teils des OR gelten
> nur:**
>
> wenn die Parteien keine abweichenden Vereinbarungen getroffen haben
>
> wenn die Vorschriften des Besonderen Teils des OR keine abweichenden
> Regelungen enthalten (Grundsatz: spezielles Recht vor allgemeinem
> Recht)

= Modalitäten der Leistungserbringung

> **Ort der Erfüllung**

Im Vertrag geregelt?

Art. 74 Abs. 1 OR

(

)

Art. 74 Abs. 2 OR

Geldschulden

Bringschulden

Wohnsitz des

Gläubigers

Speziessachen

Gattungssachen

Ort, an dem sich Sache

befand (falls Kenntnis

der Parteien)

Dienstleistungen

Holschulden

Holschulden

Holschulden

Nein

Wohnsitz des

Schuldners

Wohnsitz des

Schuldners

---------

= Erfüllungsstörungen

> **Übersicht:**

+----------------------------------------------------------------------------------------------+
| **Auf Seiten des Schuldners Auf Seiten des Gläubigers** |
+========================================================+=====================================+
| > Nichterfüllung (Art. 97 ff. OR) | > Gläubigerverzug (Art. 91 ff. OR) |
| | > |
| | > → Unterlassung von |
| | > Mitwirkungshandlungen |
+--------------------------------------------------------+-------------------------------------+
| Positive Vertragsverletzung (Art. 97 ff. OR) | |
| | |
| → | |
| | |
| Verletzung von Nebenpflichten oder | |
| | |
| Schlechterfüllung | |
+--------------------------------------------------------+-------------------------------------+
| > Schuldnerverzug (Art. 102 ff. OR) | |
+--------------------------------------------------------+-------------------------------------+

> **Merke:** Für den Schuldner besteht Erfüllungszwang. Art. 98 OR gibt
> dem Gläubiger die Möglichkeit, sich vom Richter zur ersatzweisen
> Vornahme der ausgebliebenen Leistung ermächtigen zu lassen. Der
> Gläubiger kann natürlich auch auf Erfüllung klagen.

= Abgrenzung Nicht-/Schlechterfüllung beim Kauf

Speziessache

inkl. individualisierte

(

Gattungssache)

Gattungssache

Sache wird nicht

geliefert

Sache wird

geliefert

Sache wird nicht

geliefert

Nichterfüllung

Schlechterfüllung

)

(

falls Mangel

Sache wird geliefert,

aber weist

**nicht alle**

**vereinbarten**

**Merkmale**

auf

Sache wird geliefert

und weist alle

vereinbarten

Merkmale auf

Schlechterfüllung

(

falls Mangel

)

---------

= Schlechterfüllung anhand des Kaufvertrages

> ![](media/image12.jpg){width="11.349166666666667in"
> height="5.159722222222222in"}

= Schlechterfüllung anhand des Kaufvertrages

> ![](media/image13.jpg){width="11.784722222222221in"
> height="5.196111111111111in"}

= Schuldnerverzug anhand des Kaufvertrages

**fällige Forderung**

**Verzugsfolgen**

**Verzug**

Ausnahme: OR 102 II

Normalfall:

**Mahnung**

+-----------------------------------------------------------------------+
| **verschuldens[un]{.underline}abhängig** |
| |
| - Geldschulden: Zins |
| |
| - Bei zweiseitigen Verträgen: Rücktritt und Rückforderung bereits |
| erbrachter Leistungen |
+=======================================================================+
| **verschuldensabhängig** |
| |
| → Schadenersatzpflichten: |
| |
| - Verzugsschaden und Zufallshaftung (Art. 103 OR) |
| |
| - Bei Verzicht auf Leistung (Art. 107 Abs. 2 OR) |
| |
| - Bei Rücktritt (Art. 109 Abs. 2 OR) |
+-----------------------------------------------------------------------+

**Voraussetzungen Verzug**

- Nichtleistung trotz Fälligkeit

- Fälligkeit der Forderung

- Mahnung / Verfalltag

- Fehlen verzugshindernder Gründe

= Erfüllungszeit

> ![](media/image17.jpg){width="11.406944444444445in"
> height="5.500416666666666in"}

Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 59.

= Zusammenfassung zum Verzug

> ![](media/image18.jpg){width="11.133333333333333in"
> height="5.111527777777778in"}

Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 68.

= Übersicht Inhalts-/Willensmängel

![](media/image19.jpg){width="11.637777777777778in"
height="5.706666666666667in"}

Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 27.

= Wesentlicher Irrtum

> ![](media/image20.jpg){width="11.5in" height="5.0in"}

Quelle: Reichle/Kobler, Recht lernen einfach gemacht, S. 30.

= Verjährung

+----------------+-----------------------------------------------------------+
| > **Begriff:** | > Untergang der Durchsetzbarkeit einer Obligation durch |
| | > Zeitablauf |
+================+===========================================================+
| | |
+----------------+-----------------------------------------------------------+
| > **Fristen:** | - Grundsatz: OR 127 |
| | |
| | - Ausnahmen: OR 128, OR 128a, OR 60, OR 67 etc. |
+----------------+-----------------------------------------------------------+

> Merke: Gesetzliche Verjährungsfristen können vertraglich nicht
> abgeändert werden, aber es besteht die Möglichkeit, auf die
> Verjährungseinrede zu verzichten.
>
> Beginn mit Fälligkeit der Forderung (vgl. OR 130; jedoch OR 60/67)
>
> **Unterbrechung = Neubeginn der Verjährung** durch Schuldner: -
> Anerkennung
>
> durch Gläubiger: - Betreibung

- Klage

- Eingabe im Konkurs

> Merke: Verjährung wird nicht von Amtes wegen berücksichtigt, sondern
> **nur auf Einrede**

= Beispiele

= Erlöschen der Obligation

Erfüllung **= Normalfall**

Verrechnung **OR 120-126**

+-----------------------------------------------------------------------+
| **Erlöschen heisst:** |
| |
| - Schuldner hat Leistung erbracht oder muss nicht mehr erfüllen |
| |
| - Gläubiger kann Leistung nicht mehr verlangen oder durchsetzen |
+=======================================================================+

Verjährung **OR 127-142**

Aufhebung **OR 115**

Neuerung **OR 116-117**

Vereinigung **OR 118**

> Nachträgliche **OR 119**
>
> Unmöglichkeit

= Übungen

1) Petra gefällt beim Einkaufsbummel in einem grossen Möbelhaus eine
grosse, farbige Blumenvase. Da der Wagen schon voll ist, nimmt Petra
die Vase unter den

> Arm und macht sich auf den Weg an die Kasse. Auf der Rolltreppe fällt
> Petra die Vase zu Boden und zerbricht in 1000 Stücke. Gestützt auf
> welche Rechtsgrundlage(n) könnte Ikea einen Anspruch geltend machen?

2) Hans interessiert sich in einem Fachgeschäft für ein bestimmtes
Mobiltelefon, das aber vor Ort nicht erhältlich ist. Auf Wunsch von
Hans bestellt die Verkäuferin das gewünschte Gerät und sagt zu Hans,
dass die Lieferfrist ca. 2 -- 3 Tage beträgt und Hans ein Mail
erhalte, wenn er es abholen könne. Hans verspricht, dies zu tun.

> Beim Herumschlendern in der Stadt sieht Hans das gewünschte Telefon
> beim Konkurrenz-Unternehmen und kauft es sofort. Als er die Nachricht
> erhält, dass er das Telefon abholen könne, meldet er sich einfach
> nicht mehr. Wie ist die Rechtslage?

= Übungen

> 3\) X bringt sein Auto in die Garage Z zur Reparatur. Z offeriert X
> die Reparatur zu einem Preis von CHF 1725.80. Gemäss der detaillierten
> Aufstellung auf der Offerte setzt sich die Reparatur zusammen aus der
> Arbeit (10h à CHF 130.\--) sowie dem Ersatzmaterial für CHF 525.80. X
> findet das Angebot gut und nimmt es an. Wie viel schuldet X nach der
> Reparatur dem Z?

= Übungen

> 4\) Franz hat sich gegenüber verschiedenen Gläubigern massiv
> verschuldet, es drohen Betreibungen, wenn er nicht demnächst die
> Ausstände von CHF 20'000.-- begleichen kann. Franz kann sich aus
> beruflichen Gründen keine Betreibungen leisten. Ein Bekannter namens
> Bert aus dem gleichen Dorf hat Kenntnis dieser Umstände. Bert ist wie
> Franz begeistert von seltenen Kakteen und bietet Franz an, einen Teil
> seiner umfangreichen, exotischen Kakteensammlung für CHF 22'000.\--
> abzukaufen. Bei sorgfältiger Planung des Verkaufs der zahlreichen
> seltenen Pflanzen würde man auf dem Markt ohne Weiteres mindestens den
> zwei- bis dreifachen Preis erzielen. Franz nimmt das Angebot
> widerwillig an und unterschreibt den ihm von Bert unterbreiteten
> Vertrag. Wenig später kommt Franz aufgrund guter Börsenspekulationen
> zu viel Geld, mit dem er alle seine finanziellen Probleme lösen kann.
> Bert drängt auf Aushändigung der Pflanzensammlung und weist auf den
> Vertrag hin. Kann Franz etwas tun?

= Übungen

> 5\) Hans kaufte am 5.7.2023 von seinem Kollegen Willy, der als
> Sachbearbeiter in einem Büro arbeitet, einen Occasions-Sportwagen.
> Willy hatte seinerseits das Auto kurz zuvor von Thomas abgekauft.
> Thomas hat den Kilometerstand manipuliert, wovon Hans und Willy nichts
> wussten. Der manipulierte Kilometerstand wurde am 7.1.2024 vom
> Fahrzeugexperten beim Strassenverkehrsamt bemerkt und Hans
> gleichentags mitgeteilt. Wie ist die Rechtslage?
>
> **Variante 1:** Wie wäre der Fall zu beurteilen, wenn Willy den
> Kilometerstand selbst manipuliert hätte?
>
> **Variante 2:** Hans ist beruflich sehr eingespannt und schiebt das
> Problem mit dem manipulierten Kilometerstand auf die lange Bank. Im
> Herbst 2024 wird Hans von einem Familienangehörigen darauf
> hingewiesen, dass er sich aus rechtlichen Gründen besser um das
> Problem kümmern sollte. Was könnte hier allenfalls das Problem sein?

= Übungen

6) Peter kauft beim Juwelier eine Halskette als Geburtstagsgeschenk für
seine Frau. Leider gefällt seiner Frau die Halskette überhaupt nicht
und er möchte sie dem Juwelier zurück geben. Ist das möglich?

7) Die Inhaberin eines Uhrengeschäfts verwechselt in der Auslage bei
zwei Uhren die Preisschilder. Sie versieht die Rolex mit dem
Preisschild der Swatch für CHF 129.-- und bei der günstigen Swatch
wurde der Preis der Rolex von CHF 9'890.-- angebracht. Was kann Sie
tun, wenn ein Käufer die Rolex für CHF 129.-- kaufen möchte?
