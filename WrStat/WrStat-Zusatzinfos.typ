// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Jasmin Fässler", "-"),
  fach: "WrStat",
  fach-long: "Wahrscheinlichkeit und Statistik",
  semester: "HS25",
  // tableofcontents: (enabled: true, depth: 3, columns: 2),
)

// Global configuration
// Grid size defaults
#set grid(columns: (1fr, 1fr), gutter: 1em)

// Icon for the "Construct" button on the TI n-spire
#let tr-constructs-button = box(
  stroke: 0.75pt,
  inset: (x: 0.2em),
  outset: (y: 0.25em, bottom: 0.55em),
  radius: 0.25em,
  $script(abs(ballot) cases(ballot, ballot))$,
)

// Styling for example exercises
#let example-block(body) = {
  set enum(numbering: "a)")
  show emph: set text(fill: black, weight: "regular")
  body
}


== WrStat Formeln

=== Varianz Rechenregeln
#image("img/varianz.png")

// === Hypergeometrische Verteilung
// ...

== TInspire TR Tipps
\
#grid(
  columns: (1.2fr, 1fr),
  gutter: 2em,
  [
      ==== Navigieren
      - zum Anfang: ctrl + 7 \
      - zum Ende: ctrl + 1
      - Rückgängig: ctrl + esc
      - Tab z.B. in Matrix oder bei Integral
      - ) packt Inhalt links in Klammern ein


      === Eingabe

      _*_Matrix_*_ 
      - mit ctrl + [ ] 
        - #sym.arrow.l.hook (bei Buchstaben unten) für neue Zeile (unten)
        - shift + #sym.arrow.l.hook (Enter-Taste) für neue Spalte (rechts) 
      - #hinweis[(menu 7-11 oder bei Symbolen auswählen)]

      _*_Spezielle Zeichen_*_
      - ! bei [?!>] 2x drücken
      - ^ für Hoch Zahl
      - e (eulersche Zahl) mit $e^1$ oder unter #sym.pi #sym.triangle.filled.r

      _*_Integral_*_
      - [shift] + [+]

      _*_Variable speichern_*_
      - ctrl + c und danach ctrl + v
      - mit [shift halten] + Pfeiltasten den Bereich auswählen
      - sto#[#sym.arrow]yy #h(10pt) (sto ist bei ctrl + var)
      
      _*_Variable löschen_*_
      - nicht löschen und statt x einfach xx schreiben
      - delVar [Variable] : Menu-1-3

  ],
  [
    _*_Formeln WrStat_*_
    - $"invNorm"(x,0,1)$ #sym.arrow Menu-5-5-3
    
    - $"normCdf"(a,b, mu, sigma)$ #sym.arrow Menu-5-5-2
    - $"nCr"(n, k)$ (Binomial Kombinationen) #sym.arrow menu-5-3
    - $"binomPdf"(n, p, k)$ Binomialverteilung #sym.arrow menu-5-5-A
    
    _*_Wichtig_*_
    - immer das Multiplikationszeichen schreiben, weil $"ax" != a dot x$
    
    
    
    _*_Ergebnis anders anzeigen_*_
    - Bruch mit ctrl + #sym.div
      - menu-2-2
    - Ergebnis als Bruch/Dezimal mit ctrl + enter
    \
    _*_solve_*_
    - menu 3-1   #h(10pt) z.B. solve$(a dot x + b = x, x)$
    \

    //  $script(abs(ballot) cases(ballot, ballot))$
    
    // #image("img/image-3.png")
  ]
)

// === Probleme lösen
// implizierte Multiplikation = schreibe das Mal $dot$ aus.

// === Einstellungen
// - Bogenmass
// - Calculator Seiten hinzufügen
// - Page > Widget>Stopwatch

#pagebreak()
=== Binomialverteilung - Standardisierung mit Korrektur

Formeln mit $sigma$ und $mu$\ 
#grid(
  columns: (1.2fr, 1fr),
  gutter: 2em,
  [
    $
      Rho(a fxcolor("grün", <) X fxcolor("orange", <=) b)
      = Phi((b fxcolor("orange", + 1/2) - mu)/sigma) - Phi((a fxcolor("grün", + 1/2) - mu)/sigma)
      \ \
      Rho(a fxcolor("grün", <=) X fxcolor("orange", <=) b)
      = Phi((b fxcolor("orange", + 1/2) - mu)/sigma) - Phi((a fxcolor("grün", - 1/2) - mu)/sigma)
    $
  ],
  // image("img/wrstat_11.png"),
)
\

$
  "Beispiel (bei b Wert einfügen) :"\
  Rho(X fxcolor("orange", <=) b)
  = P((X - mu)/sigma <= (b - mu)/sigma)
  = P(Z <= (b + 1/2 - mu)/sigma)
  = Phi((b fxcolor("orange", + 1/2) - mu)/sigma) \
  = #hinweis[(Menu-5-5-2)] "normCdf"((b fxcolor("orange", + 1/2) - mu)/sigma) = "gesuchte Wahrscheinlichkeit " P(Z <= ..)
$
\
#sym.ballot Nicht vergessen: 1 - $P(Z <= ..)$ zu rechnen!
\