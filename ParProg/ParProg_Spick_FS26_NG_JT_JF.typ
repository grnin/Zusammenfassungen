// Compiled with Typst 0.13.1
#import "../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
    authors: ("Jasmin Fässler", "Nina Grässli", "Jannis Tschan"), // Version von Nina und Jannis genommen und für mich (Jasmin) angepasst
    fach: "ParProg",
    fach-long: "Parallel Programming",
    semester: "FS26",
    language: "en",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)

#include "01_multi-threading.typ"
#include "02_massive-parallelism.typ"
