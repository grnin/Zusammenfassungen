// Compiled with Typst 0.12
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

/* #show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true),
  language: "de"
) */

= Unicode
== ASCII - American Standard Code for Information Interchange
Hat _128 definierte Zeichen_ #hinweis[(7 Bit, #hex("00") bis #hex("7F"))].
33 Kontrollzeichen, viele davon obsolet, 10 Ziffern, 33 Interpunktionszeichen,
26 Grossbuchstaben und 26 Kleinbuchstaben.
#hinweis[(erste Hexzahl = Zeile, zweite Hexzahl = Spalte, d.h. #hex("41") = `A`)]
#image("img/bsys_40.png")

=== Codepages
Codepages sind _unabhängige Erweiterungen_ auf 8 Bit. Es gibt viele verschiedene,
jede ist anders. Sie definieren jeweils 128 Zeichen von #hex("80") bis #hex("FF").
Die Codierung ist _nicht inhärent erkennbar_, Programme müssen wissen, welche Codepage
verwendet wird, sonst wird der Text unleserlich.

== Unicode
Unicode hat zum Ziel, einen eindeutigen Code für _jedes vorhandene Zeichen_ zu definieren.
Hat Platz für 1'112'064 Code-Points #hinweis[(21 bits)], davon 149'813 verwendet.
#hex("D8 00") bis #hex("DF FF") sind wegen UTF-16 keine gültigen Code-Points.

=== Verschiedene Encodings
Man unterscheidet _Code-Points_ #hinweis[(Nummer eines Zeichen - "welches Zeichen")] und
_Code-Units_ #hinweis[(Einheit, um Zeichen in einem Encoding darzustellen - bietet den
Speicherplatz für das Zeichen)].\
#hinweis[_$bold(P_i) =$_ $i$-tes Bit des unkodierten CPs,
  _$bold(U_i) =$_ $i$-tes Code-Unit des kodierten CPs,
  _$bold(B_i) =$_ $i$-tes Byte des kodierten CPs]

- #link(<utf-32>)[_UTF-32:_] Jede CU umfasst _32 Bit_, jeder CP kann mit _einer CU_
  dargestellt werden.
- #link(<utf-16>)[_UTF-16:_] Jede CU umfasst _16 Bit_, ein CP benötigt _1 oder 2 CUs_
- #link(<utf-8>)[_UTF-8:_] Jede CU umfasst _8 Bit_, ein CP benötigt _1 bis 4 CUs_

#wrap-content(
  image("img/bsys_43.png"),
  align: top + right,
  columns: (50%, 50%),
)[
  === UTF-32 <utf-32>
  Direkte Kopie der Bits in die CU bei Big Endian, bei Little Endian werden $P_0$ bis
  $P_7$ in $B_3$ kopiert usw. Wird häufig intern in Programmen verwendet.
  Wegen Limitierung auf 21 Bit werden die oberen 11 Bits oft "zweckentfremdet".
]

=== UTF-16 <utf-16>
Encoding muss Endianness berücksichtigen. Die 2 CUs werden Surrogate Pair genannt,
$U_0$: high surrogate, $U_1$: low surrogate.
- _UTF-16BE:_ Big Endian, CP mit 1 CU: $U_0 = B_1B_0$,
  CP mit 2 CUs: $U_1U_0 = B_3B_2B_1B_0$
- _UTF-16LE:_ Little Endian, CP mit 1 CU: $U_0 = B_0B_1$,
  CP mit 2 CUs: $U_1U_0 = B_2B_3B_0B_1$

Bei _2 Bytes_ #hinweis[(1 CU)] wird direkt gemappt und vorne mit Nullen aufgefüllt.

Bei _4 Bytes_, wenn CP in #hex("10000") bis #hex("10FFFF") sind
#hex("D800") bis #hex("DFFF") #hinweis[(Bits 17-21)] wegen dem Separator _ungültig_ und
müssen "umgerechnet" werden:
- $Q = P - #hex("10000")$, also ist $Q$ in #hex("0") bis #hex("FFFFF")
- $U_1 = bits("1101 10xx xxx") + hex("D800"),
    U_0 = bits("1101 11xx xxxx xxxx") + hex("DC00")$

#image("img/bsys_45.png")

==== Beispiel
Encoding von U+10'437 (\u{10437})
#hinweis[#fxcolor("grün", bits("00 0100 0001", suffix: false))
  #fxcolor("gelb", bits("00 0011 0111"))]:

1. Code-Point $P$ minus #hex("10000") rechnen und in Binär umwandlen\
  $P = hex("10437"), Q = hex("10437") - hex("10000") = hex("0437")
    = fxcolor("grün", #bits("00 0000 0001", suffix: false))
    fxcolor("gelb", bits("00 0011 0111"))$
2. Obere & untere 10 Bits in Hex umwandlen\
  $fxcolor("grün", #hex("0001", suffix: false)) fxcolor("gelb", hex("0137"))$\
3. Oberer Wert mit #hex("D800") und unterer Wert mit #hex("DC00") addieren,
  um Code-Units zu erhalten\
  $U_1 = fxcolor("grün", hex("0001")) + hex("D800") = fxcolor("orange", hex("D801")),
    U_2 = fxcolor("gelb", hex("0137")) + hex("DC00") = fxcolor("hellblau", hex("DD37"))$\
4. Zu BE/LE zusammensetzen\
  $"BE" = underline(fxcolor("orange", #hex("D801", suffix: false)) thin
    fxcolor("hellblau", hex("DD37"))), thick
    "LE" = underline(fxcolor("orange", #hex("01D8", suffix: false)) thin
    fxcolor("hellblau", hex("37DD")))$

#pagebreak()

=== UTF-8 <utf-8>
Encoding muss Endianness _nicht_ berücksichtigen. Standard für Webpages.
Echte Erweiterung von ASCII.

#let nextCU = bits("10xx xxxx")
#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header([Code-Point in], [$bold(U_3)$], [$bold(U_2)$], [$bold(U_1)$], [$bold(U_0)$], [signifikant]),
  [#hex("0") - #hex("7F")], [], [], [], [#bits("0xxx xxxx")], [7 bits],
  [#hex("80") - #hex("7FF")], [], [], [#bits("110x xxxx")], [#nextCU], [11 bits],
  [#hex("800") - #hex("FFFF")], [], [#bits("1110 xxxx")], [#nextCU], [#nextCU], [16 bits],
  [#hex("10000") - #hex("10FFFF")], [#bits("1111 0xxx")], [#nextCU], [#nextCU],[#nextCU], [21 bits],
)
Die most significant Bits einer CU werden als Delimiter verwendet:
#bits("0") = nur 1 CU,
#bits("10") = es folgt mindestens 1 CU,
#bits("110") = 2. und letzte CU,
#bits("1110") = 3. und letzte CU,
#bits("11110") = 4. und letzte CU.

In den CUs haben die Bytes #hex("0") - #hex("7F") #hinweis[(7 signifikante Bits)],
#hex("80") - #hex("7FF") #hinweis[(11 Bits)],
#hex("800") - #hex("FFFF") #hinweis[(16 bits)] bzw.
#hex("10000") - #hex("10FFFF") #hinweis[(21 bits)] Platz.

#image("img/bsys_44.png")

==== Beispiele
- _ä_: $P = hex("E4") = fxcolor("grün", #bits("00011", suffix: false)) thin
    fxcolor("gelb", bits("10 0110"))$\
  $=> P_10 ... P_6 = fxcolor("grün", bits("00011")) = fxcolor("rot", hex("03")),
    P_5 ... P_0 = fxcolor("gelb", bits("100100")) = fxcolor("orange", hex("24"))$\
  $=> U_1 = hex("C0") (= bits("11000000")) + fxcolor("rot", hex("03")) = hex("C3"),
    U_0 = hex("80") (= bits("10000000")) + fxcolor("orange", hex("24")) = hex("A4")$\
  $=> ä = underline(hex("C3 A4"))$
- _\u{1EB7}_: $P = hex("1EB7") = fxcolor("grün", #bits("0001", suffix: false)) thin
    fxcolor("gelb", #bits("111010", suffix: false)) thin
    fxcolor("hellblau", bits("110111"))$\
  $=> P_15 ... P_12 = fxcolor("grün", hex("01")),
    P_11 ... P_6 = fxcolor("gelb", hex("3A")),
    P_5 ... P_0 = fxcolor("hellblau", hex("37"))$\
  $=> U_2 = hex("E0") (= #bits("11100000")) + fxcolor("grün", hex("01")) = hex("E1"),
    U_1 = hex("80") + fxcolor("gelb", hex("3A")) = hex("BA"),
    U_0 = hex("80") + fxcolor("hellblau", hex("37")) = hex("B7")$\
  $=> ặ = underline(hex("E1 BA B7"))$

=== Encoding-Beispiele
#table(
  align: (_, y) => if(y == 0) { left } else { right },
  columns: (auto,) + (1fr,) * 6,
  table.header([Zeichen], [Code-Point], [UTF-32BE], [UTF-32LE], [UTF-8], [UTF-16BE], [UTF-16LE]),
  [A],[#hex("41")],[#hex("00 00 00 41")],[#hex("41 00 00 00")],[#hex("41")],[#hex("00 41")],[#hex("41 00")],
  [ä],[#hex("E4")],[#hex("00 00 00 E4")],[#hex("E4 00 00 00")],[#hex("C3 A4")],[#hex("00 E4")],[#hex("E4 00")],
  [\u{3B1}],[#hex("3 B1")],[#hex("00 00 03 B1")],[#hex("B1 03 00 00")],[#hex("CE B1")],[#hex("03 B1")],[#hex("B1 03")],
  [\u{1EB7}],[#hex("1E B7")],[#hex("00 00 1E B7")],[#hex("B7 1E 00 00")],[#hex("E1 BA B7")],[#hex("1E B7")],[#hex("B7 1E")],
  [\u{10330}],[#hex("1 03 30")],[#hex("00 01 03 30")],[#hex("30 03 01 00")],[#hex("F0 90 8C B0")],[#hex("D8 00 DF 30")],[#hex("00 D8 30 DF")],
)
#hinweis[Bei LE / BE werden nur die Zeichen _innerhalb_ eines Code-Points vertauscht,
  nicht die Code-Points an sich.]

#pagebreak()

= Ext2-Dateisystem
== Datenträger-Grundbegriffe
- _Partition:_ Ein Teil eines Datenträgers, wird selbst wie ein Datenträger behandelt.
- _Volume:_ Ein Datenträger oder eine Partition davon.
- _Sektor:_ Kleinste logische Untereinheit eines Volumes.
  Daten werden als Sektoren transferiert. Grösse ist von HW definiert
  #hinweis[(z.B. 512 Bytes oder 4KB)]. Enthält Header, Daten und Error-Correction-Codes.
- _Format:_ Layout der logischen Strukturen auf dem Datenträger, wird vom Dateisystem
  definiert.

== Block
#wrap-content(
  image("img/bsys_41.png"),
  align: top + right,
  columns: (85%, 15%),
)[
  Ein Block besteht aus _mehreren aufeinanderfolgenden Sektoren_ #hinweis[(1 KB, 2 KB oder
  4 KB (normal))]. Das gesamte Volume ist in _Blöcke aufgeteilt_ und Speicher wird
  _nur in Form von Blöcken_ alloziert. Ein Block enthält nur Daten einer _einzigen Datei_.
  - _Logische Blocknummer:_ Blocknummer vom Anfang der Datei aus gesehen, wenn Datei eine
    ununterbrochene Abfolge von Blöcken wäre #hinweis[(innerhalb Datei)]
  - _Physische Blocknummer:_ Tatsächliche Blocknummer auf dem Volume
    #hinweis[(auf dem Datenträger)]
]

== Inodes
Achtung: `!=` Index Node. Beschreibung einer Datei. Enthält _alle Metadaten_ über die Datei,
_ausser Namen oder Pfad_ #hinweis[(Grösse, Anzahl der verwendeten Blöcke, Erzeugungszeit,
Zugriffszeit, Modifikationszeit, Löschzeit, Owner-ID, Group-ID, Flags, Permission Bits)].
Hat eine _fixe Grösse_ je Volume: Zweierpotenz, mind. 128 Byte, max 1 Block.

Der Inode _verweist auf die Blöcke_, die _Daten für eine Datei_ enthalten.
Enthält ein Array _`i_block`_ mit 15 Einträgen zu je 32 Bit:
#wrap-content(
  image("img/bsys_42.png"),
  align: top + right,
  columns: (55%, 44%),
)[
  - 12 Blocknummern für die _ersten 12 Blöcke_ einer Datei
  - 1 Blocknummer des _indirekten Blocks_, der wiederum bei 1024 Byte Blockgrösse auf 256
    oder bei 4096 Byte auf 1024 Blöcke verweist.
  - 1 Blocknummer des _doppelt indirekten Blocks_, welcher Nummern von indirekten Blöcken
    enthält. Bei Blockgrösse 1024 auf $256 dot 256 = 65536$ Blöcke,
    bei 4096 auf $1024 dot 1024 = 1upright(M)$ Blöcke
  - 1 Blocknummer des _dreifach indirekten Blocks_\
    #hinweis[$256 dot 256 dot 256 = 16upright(M)$ bzw.
      $1024 dot 1024 dot 1024 = 1upright(G)$]
]
Jeder verwendete Block einer Datei hat einen direkten oder indirekten _Verweis_.

=== Lokalisierung
Alle Inodes aller Blockgruppen gelten als _eine grosse Tabelle_.
Zählung der Inodes startet mit 1.
- Blockgruppe $= ("Inode" - 1) / "Anzahl Inodes pro Gruppe"$
- Index des Inodes in Blockgruppe $ = ("Inode" - 1) %$ Anzahl Inodes pro Gruppe
- Sektor und Offset können anhand der Daten aus dem Superblock bestimmt werden.

=== Erzeugung
Neue Verzeichnisse werden bevorzugt in der Blockgruppe angelegt, die von allen
Blockgruppen mit _überdurchschnittlich vielen freien Inodes_ die _meisten Blöcke frei_ hat.
Dateien werden möglichst in der Blockgruppe des Verzeichnisses oder in nahen Gruppen angelegt.\
Bestimmung des ersten freien Inodes in der Gruppe anhand des _Inode-Usage-Bitmaps_.
Bit wird entsprechend auf 1 gesetzt und die Anzahl freier Inodes in Gruppendeskriptor und
Superblock angepasst.

=== File-Holes
Bereiche in der Datei, in der _nur Nullen_ stehen. Wird ein Eintrag auf einen Block auf 0
gesetzt, heisst das, dass der Block nur Nullen enthält. Ein solcher Block wird _nicht
alloziert_. Darum kann Grösse & Anzahl der verwendeten Blöcke voneinander abweichen.

== Blockgruppe
Ein Volume wird in _Blockgruppen_ unterteilt. Eine Blockgruppe besteht aus
_mehreren aufeinanderfolgenden Blöcken_ bis zu 8 mal der Anzahl Bytes in einem Block
#hinweis[(Bsp. Blockgrösse 4KB sind bis zu 32K Blöcke in einer Gruppe)].
Anzahl Blöcke je Gruppe ist gleich für alle Gruppen.

=== Lage der Blockgruppen
#wrap-content(
  image("img/bsys_46.png"),
  align: top + right,
  columns: (40%, 60%),
)[
  Die Lage der Blockgruppe 0 ist _abhängig von der Blockgrösse_.
  Blockgruppe 0 ist definiert als _die Gruppe, deren erster Block den Superblock enthält_.\
  _Blockgrösse $<=$ 1024:_ Block 0 kommt vor Blockgruppe 0 #sym.arrow Block 1 ist der erste
  Block und beinhaltet Superblock.\
  _Blockgrösse > 1024:_ Block 0 in Blockgruppe 0 #sym.arrow Superblock ist in Block 0.
]

=== Layout
- _Block 0:_ Kopie des Superblocks
- _Block $bold(1)$ bis $bold(n)$:_ Kopie der Gruppendeskriptorentabelle
- _Block $bold(n + 1)$:_ Block-Usage-Bitmap mit einem Bit je Block der Gruppe
  #hinweis[(Welche Blöcke werden gerade verwendet)]
- _Block $bold(n + 2)$:_ Inode-Usage-Bitmap mit einem Bit je Inode der Gruppe
  #hinweis[(Welche Inodes werden verwendet)]
- _Block $bold(n + 3)$ bis $bold(n + m + 2)$:_ Tabelle aller Inodes in dieser Gruppe
- _Block $bold(n + m + 3)$ bis Ende der Gruppe:_ Blöcke der eigentlichen Daten

=== Superblock
Startet immer an _Byte 1024_ #hinweis[(Wegen eventuellen Bootdaten im Bereich vorher)] und
enthält _alle Metadaten_ über das Volume:
- _Anzahlen:_ Inodes frei und gesamt, Blöcke frei und gesamt, reservierte Blöcke,
  Bytes je Block, Bytes je Inode, Blöcke je Gruppe, Inodes je Gruppe
- _Zeitpunkte:_ Mountzeit, Schreibzeit, Zeitpunkt des letzten Checks
- _Statusbits:_ Um Fehler zu erkennen
- _Erster Inode_, der von Applikationen verwendet werden kann
- _Feature-Flags:_ Zeigen an welche Features das Volume verwendet.

==== Sparse Superblocks
Feature, dass die _Anzahl der Superblocks_ stark _reduziert_. Wird über ein bestimmtes
Flag aktiviert. Wenn aktiv, dann werden Kopien des Superblocks nur noch in Blockgruppe 0 und 1
sowie allen reinen Potenzen von 3, 5 oder 7 gehalten #hinweis[(0, 1, 3, 5, 7, 9, 25,
27, 49, 81, 125, 243, 343, ...)]. Dadurch ist immer noch ein _sehr hoher
Wiederherstellungsgrad_ möglich, obwohl deutlich weniger Platz verwendet wird.

=== Gruppendeskriptor
32 Byte _Beschreibung einer Blockgruppe_. Beinhaltet:
- Blocknummer des _Block-Usage-Bitmaps_
- Blocknummer des _Inode-Usage-Bitmaps_
- Nummer des ersten Blocks der _Inode-Tabelle_
- Anzahl _freier Blöcke_ und _Inodes_ in der Gruppe
- Anzahl der _Verzeichnisse_ in der Gruppe

==== Gruppendeskriptortabelle
Eine _Tabelle mit $bold(n)$ Gruppendeskriptoren_ für alle $n$ Blockgruppen im Volume.
Benötigt selbst $32 dot n$ Anzahl Bytes; Anzahl Sektoren $= (32 dot n) / "Sektorgrösse"$.
Folgt _direkt_ auf Superblock. Kopie der Tabelle direkt nach jeder Kopie des Superblocks.

== Verzeichnisse
Ein Verzeichnis enthält die _Dateieinträge_ bzw. den Inode, dessen Datenbereich
Dateieinträge enthält. Es gibt _zwei automatisch angelegte_ Einträge:
`"."` ist der Dateieintrag mit eigenem Inode,
`".."` ist der Dateieintrag mit dem Inode des Elternverzeichnis.
Das _Wurzelverzeichnis_ ist der Inode Nummer 2.

Ein _Dateieintrag_ hat eine variable Länge von 8 - 263 Bytes:
- 4 Byte _Inode_
- 2 Byte _Länge_ des _Eintrags_
- 1 Byte _Länge_ des _Dateinamens_
- 1 Byte _Dateityp_ #hinweis[(1: Datei, 2: Verzeichnis, 7: Symbolischer Link)]
- 0 - 255 Byte _Dateiname_ #hinweis[(ASCII, nicht null-terminiert)]
- Länge wird aus Effizienzgründen immer auf 4 Byte aligned #hinweis[(Maschinenwort)]

== Links
- _Hard-Link:_ gleicher Inode, verschiedene Pfade
  #hinweis[(Inode wird von verschiedenen Dateieinträgen referenziert)]
- _Symbolischer Link:_ Wie eine Datei, Datei enthält Pfad anderer Datei.
  #hinweis[(Pfad $<$ 60 Zeichen: Wird in Blockreferenzen-Array gespeichert,
    Pfad $>=$ 60: Pfad wird in eigenem Block gespeichert)]

== Vergleich FAT, NTFS, Ext2
#table(
  columns: (auto, auto, auto),
  table.header([FAT], [Ext2], [NTFS]),
  [
    - Verzeichnis enthält alle Daten über die Datei
    - Datei ist in einem einzigen Verzeichnis
    - Keine Hard-Links möglich
  ],
  [
    - Dateien werden durch Inodes beschrieben
    - Kein Link von der Datei zurück zum Verzeischnis
    - Hard-Links möglich #hinweis[(Mehrere Links zum Inode möglich)]
  ],
  [
    - Dateien werden durch File-Records beschrieben
    - Verzeichnis enthält Namen und Link auf Datei
    - Link zum Verzeichnis und Name sind in einem Attribut
    - Hard-Links möglich #hinweis[(Attribut kann mehrfach vorkommen)]
  ],
)
