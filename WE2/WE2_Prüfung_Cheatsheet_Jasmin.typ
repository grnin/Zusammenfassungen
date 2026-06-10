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

#set heading(
    numbering: none,
    // hanging-indent: 30pt,
    // inset: (left: 20cm)
    // offset: -100,
);

= React
== React Regeln (Komponente, HTML, JSX)
- [ ] Nur ein Rückgabewert: 1 parent element (Root Element) oder React.Fragment `<></>`
// - Nur ein einziges Root Element zurückgeben (`->` Siehe React Fragment)
- [ ] Naming der Komponente
    - UpperCamelCase
    - treffende Beschreibung der Komponente
        - Beispiele: LinkButton , InfoTooltip , DraftEditor
- [ ] HTML Attribute in JSX mit camelCase
    // TODO durchstreichen
    - __`class`__ `->` `className`
    - __`for`__ in Formularfeldern `->` `htmlFor`
    - __`stroke-width`__ `->` `strokeWidth`
    - ausser `aria-*` und `data-*`
- [ ] HTML Elemente geschlossen, z.B. `<img />` ,`<input />`
- [ ] Syntax wie in JS: Wert in `{title}`


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




#include "./_code-to-add-react.typ"

#include "./_code-to-add-express.typ"







