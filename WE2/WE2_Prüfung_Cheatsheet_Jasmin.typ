// Compiled with Typst 0.13.1
#import "../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "WE2",
    fach-long: "Web Engineering 2",
    semester: "FS26",
    language: "de",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)

#import "./helpers.typ": *

// TODO es überschreibt meine ascii-art
// #show "->": sym.arrow.r;





// TODO:
//  expressjs prüfen ob alles von _code-exp..todo vorhanden, sonst von dort noch Inhalt übernehmen
//  express middleware konzept genug erklärt?

// weggelassen:
// CSS infos
// js das ich logisch finde
// custom react hooks und bisschen react code weggekürzt

#include "/WE2/_react.typ"

#include "/WE2/_expressjs.typ"
#include "/WE2/_code-express-testat.typ"
#include "/WE2/_accessiblity-testing.typ"
#include "/WE2/_security.typ"

