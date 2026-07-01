// Compiled with Typst 0.13.1
#import "../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
    authors: ("Nina Grässli", "Jannis Tschan"),
    fach: "ParProg",
    fach-long: "Parallel Programming",
    semester: "FS24",
    language: "en",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)


/ Motivation: Word (GUI), Moore's Law end #sym.arrow.r Multi-Core Era, scale horizontal
/ Multi-core: a processor chip containing multiple cores (processing units)
/ Caches: L1: inside core, L2: inside core, sometimes shared between some cores, L3: on CPU chip, shared between all cores


#include "_multi-threading.typ"
#include "_massive-parallelism.typ"
