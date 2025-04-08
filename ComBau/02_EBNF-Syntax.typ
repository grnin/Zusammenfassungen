#import "../template_zusammenf.typ": *

= EBNF-Syntax
Die EBNF-Syntax #hinweis[(Extended Backus-Naur Form)] kann _kontextfreie Grammatiken_ darstellen.
#table(
  columns: (1fr,) * 3,
  table.header([Begriff], [Beispiel], [Sätze]),
  [Konkatenation], [`"A" "B"`], ["`AB`"],
  [Alternative], [`"A" | "B"`], ["`A`" oder "`B`"],
  [Option], [`["A"]`], [leer oder "`A`" #hinweis[(gleich wie `"A" | ""`)]],
  [Wiederholung], [`{"A"}`], [leer, "`A`", "`AA`", "`AAA`", etc.],
)
Für stärkere Bindung können runde Klammern verwendet werden. Ein "|" bindet schwächer als andere Konstrukte.

Mit der EBNF-Syntax kann das Rekursionsbeispiel von oben anderst dargestellt werden.\
Aus `Expression = "(" ")" | "(" Expression ")"` wird so `Expression = "(" [Expression] ")"`.

== Beispiel $bold(a*b+c)$
#grid(
  columns: (3fr, 0.5fr, 0.7fr),
  gutter: 1em,
  [
    #tcolor("grün", `Expression`) `=` #tcolor("orange", `Term`) `|` #tcolor("grün", `Expression`) `"+"` #tcolor("orange", `Term`).
    #hinweis[(`*` bindet stärker als `+`)]\
    #tcolor("orange", `Term`) `=` #tcolor("rot", `Variable`) `|` #tcolor("orange", `Term`) `"*"` #tcolor("rot", `Variable`).\
    #tcolor("rot", `Variable`) `= "a" | "b" | "c" | "d"`.
  ],
  [
    #image("img/combau_03.png")
  ],
  [
    #image("img/combau_04.png")
  ],
)

== Mehrdeutigkeit
#grid(
  columns: (2.5fr, 1fr),
  gutter: 1em,
  [
    Der Syntax des EBNF darf nicht _mehrdeutig_ sein.\
    _Problematisches Beispiel:_\
    #tcolor("grün", `Expression`) `=` #tcolor("rot", `Number`) `|` #tcolor("grün", `Expression`) `"-"` #tcolor("grün", `Expression`).\
    #tcolor("rot", `Number`) `= "1" | "2" | "3"`.
  ],
  [
    #image("img/combau_05.png")
  ],
)

Mit der Formel $1-2-3$ können aufgrund der Rekursion von #tcolor("grün", `Expression`)
verschiedene Syntaxbäume gebildet werden, was die Syntax _unbrauchbar_ macht.
_Behoben_ werden kann dies durch die _Erzwingung der Linksassozivität_:

#tcolor("grün", `Expression`) `=` #tcolor("orange", `Term`) `{ "-"` #tcolor("orange", `Term`) `}`.\
#tcolor("orange", `Term`) `=` #tcolor("rot", `Number`).

== Spezialfälle
- _`"""`_ ist ein Anführungszeichen (`"`) als Terminalsymbol
- _`"A" | .. | "Z"`:_ ist ein Zeichen zwischen A und Z
- _Whitespaces:_ Werden nicht in der Syntax erfasst, ausser wenn relevant #hinweis[(z.B. in Python)]
- _Kommentare:_ Werden nicht in der Syntax erfasst
