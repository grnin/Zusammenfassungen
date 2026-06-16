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

#import "@preview/cheq:0.3.1": checklist
#show: checklist

#import "./helpers.typ": *

// #let \-\> = sym.arrow.r;
#show "->": sym.arrow.r;

= JavaScript

=== Functions
/ Function Declaration: Schlüsselwort `function`, gehoistet #hinweis[Verwendung for Definition möglich], ```js function greet() {..}```
/ Function Expression: in JSX und überall wo eine Expression reinpasst nutzbar ()
/ Named Function Expr.: ```js const greet = function greetPerson() {...};```
/ Anonymous Function Expr.: ```js ... = function () {...}; ```
/ Arrow Function (Lambda): kompakte Form einer Function Expression, 1 Parameter: ```js ... = x => x * x;
    ```, mit Rückgabewert: ```js = () => "Hello";``` // ohne Rückgabewert=side effects und deshalb nicht gut: ```js = () => { .. } ```
/ Callback Function: (relevant in Express Middleware)


// TODO Beispiel: inline stye beispiel

// Inhalt plan
//
// code:
// - useState?
// - useEffect
// - useReduce
//
// wieviel vom pizzashop? oder doch besser testat?
//

// TODO: expressjs


#include "/WE2/_react.typ"

#include "/WE2/_expressjs.typ"
#include "/WE2/_code-express-testat.typ"
#include "/WE2/_accessiblity-testing.typ"
#include "/WE2/_security.typ"

