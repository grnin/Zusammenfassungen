
// Compiled with Typst 0.13.1
#import "../../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
  authors: ("Jasmin Fässler",),
  fach: "VRLG",
  fach-long: "Vorlage",
  semester: "FS26",
  language: "de",
  column-count: 5,
  font-size: 4pt,
  landscape: true,
)


= Heading 1

/ text-bold: explanation of it
  and more
/ another item: explanation
  / text-bold: works inside typst element

/ Example: Data that has been processed in a way that gives it meaning and
  value



== Heading 2
Normal Text paragraph


=== Heading 3
+ numbered list
+ *text bold*: explanation
+ numbered list
+ numbered list


Pfeile $->$ #sym.arrow.r

=== Tests
Bild
#image("/WE2/assets/image.png")

doppelter Abstand:
\
\
A
bstand^

= Zum überprüfen:
Prüfe das die 2 Zeilen anders aussehen:
\
\
=== Heading 3 mit Aptos
\
#text(
  font: calibri-font,
  style: "normal",
  weight: "semibold",
  size: 5pt,
  "Heading 3 mit Calibri (sollte anders aussehen)",
)
\
== code font testing
#text(
  font: "JetBrainsMonoNL NF",
  weight: "bold",
  "Code if (test) 123 -> Hallo Test in richtiger Font äü ohne Ligaturen",
)\
#text(
  font: "JetBrains Mono",
  weight: "bold",
  "Code if (test) 123 -> Hallo Test in richtiger Font äü normal",
)\
#text(
  font: "DejaVu Sans Mono",
  weight: "bold",
  "Code if (test) 123 -> Hallo Test in falscher Font äü",
)
