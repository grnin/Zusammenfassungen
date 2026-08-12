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

#set terms(
    separator: [: ],
    hanging-indent: 0.6em,
    tight: true,
    spacing: 0.6em,
)

#include "/WE2/_react.typ"
#include "/WE2/_context-zustand.typ"
#include "/WE2/_expressjs.typ"
#include "/WE2/_code-express-testat.typ"

#include "/WE2/_accessiblity-testing.typ"
#include "/WE2/_security.typ"
#include "/WE2/_pwa.typ"

