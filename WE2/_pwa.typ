#import "../template--additional-formatting-templates.typ": *

// /* zum testen:
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
// */


// #import "@preview/cheq:0.3.1": checklist
// #show: checklist

#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]
