#import "information-and-colors.typ": *
#import "./functions.typ": *
#import "./tmTheme.typ": tm-theme
#import "./ctx.typ": *
// #import "./overrides.typ": *
// #import "./overrides.typ": add-uml-fletcher-marks
#import "./shiroa.typ": book-page

#let i18n-fonts = (language: "de", fsize: 11pt) => {
  let reg = (
    (lang: language) + (if language == "de" { (region: "ch") } else { (:) })
  )
  (
    font: (
      // font: "Arimo Nerd Font",
      font: "Fira Code",
      size: fsize,
      fill: colors.fg,
    )
      + reg,
    code-f: (font: code-font, weight: "bold", fill: colors.darkblue) + reg,
    math-f: (
      // font: "Fira Math",
      // font: "XITS Math",
      features: ("cv01",),
    )
      + reg,
  )
}

#let config-page(
  author,
  name,
  module,
  semester,
  date,
  landscape,
  columnsnr,
  language,
  fsize,
  body,
) = {
  let (font, code-f, math-f) = i18n-fonts(language: language, fsize: fsize)
  set document(author: author, title: name + " " + semester, date: date)
  set page(
    flipped: landscape,
    columns: columnsnr,
    footer: context [
      #set text(font: code-f.font, size: fsize - 1pt)
      #line(length: 100%, stroke: colors.fg + .75pt)
      #v(-.75em)
      #module | #semester
      #h(1fr)
      #languages.at(language).page #counter(page).display()
    ],
    header: context [
      #set text(font: code-f.font, size: fsize - 1pt)
      #author
      #h(1fr)
      #datetime.today().display(dateformat)
      #v(-.75em)
      #line(length: 100%, stroke: colors.fg + .75pt)
    ],
    fill: colors.bg,
  ) if not "x-target" in sys.inputs
  set columns(columnsnr, gutter: if (columnsnr < 2) { 2em } else { 1em })
  body
}

#let config-code-style(
  fsize,
  language,
  body,
) = {
  let (font, code-f, math-f) = i18n-fonts(language: language, fsize: fsize)
  show raw: set raw(theme: bytes(colors
    .pairs()
    .fold(tm-theme, (acc, (k, v)) => acc.replace(
      "{{" + k + "}}",
      "#"
        + v
          .components(alpha: false)
          .map(i => hex(int(255 * i / 100%), prefix: false))
          .join(),
    ))))
  show raw
    .where(lang: "loop")
    .or(raw.where(lang: "while"))
    .or(raw.where(lang: "goto")): it => {
    show regex("GOTO|WHILE|LOOP|DO|END|IF|THEN"): text.with(
      weight: "bold",
      fill: colors.darkblue,
    )
    // eh, hackiness is okay sometimes
    show regex("\s(P|y|x|c|>|<|\+|\d|=|M)(_(.))?"): line => {
      (
        " "
          + eval(
            repr(line).slice(1, -1),
            mode: "math",
          )
      )
    }
    it
  }
  // TODO: transfer to sublime syntax def
  show raw.where(lang: "cisco"): it => {
    show regex("(Router|Switch)(>|(\(config(-if|-router)?\))?#)"): line => {
      show regex("(>|(\(config(-if|-router)?\))?#)"): text.with(
        weight: "bold",
        fill: colors.darkblue,
      )
      show regex("(Router|Switch)"): text.with(weight: "bold")
      line
    }
    show regex("^#.*\n"): text.with(fill: colors.comment)
    it
  }
  let ebnf-syntax = it => {
    show regex("('|\").*?('|\")"): text.with(fill: colors.green.darken(20%))
    // TODO: include regex symbols for extended BNF syntax
    show regex("::?=|\[|\]|\{|\}|\||\(|\)"): text.with(weight: "bold") // why is my lsp stupid"
    show regex("<[0-9a-zA-Z_-]+?>"): emph
    show regex("#.*\n"): text.with(
      fill: colors.comment,
      style: "normal",
      weight: "medium",
    )
    it
  }
  show raw.where(lang: "bnf").or(raw.where(lang: "ebnf")): ebnf-syntax

  let small-ip = ip.with(size: fsize - 1pt)
  // mac
  show regex(
    range(6).map(_ => "[0-9a-fA-F]{2}").join("[:\-]"),
  ): /* why is my lsp stupid"*/ small-ip
  // ipv4
  let nx = "[0-9xX\?]{1,3}"
  show regex("(" + nx + "\\.){3}" + nx + "(/\\d{1,2})?"): small-ip
  // ipv6
  let anx = "[0-9A-Fa-fxX\?]{1,4}"
  let reg = ()
  for i in range(6) {
    reg.push(
      "("
        + anx
        + ":){1,"
        + str(i + 1)
        + "}((:"
        + anx
        + "){1,"
        + str(6 - i)
        + "}|:)",
    )
  }
  show regex(
    "((" + reg.join("|") + ")|::)(" + anx + ")?(/\\d{1,3})?",
  ): /* why is my lsp stupid"*/ small-ip
  body
}

#let config-style(fsize, language, did, body) = {
  let (font, code-f, math-f) = i18n-fonts(language: language, fsize: fsize)
  set text(..font)
  set enum(numbering: "1.a)")

  let lnkstyle = it => [
    #set text(weight: 500, fill: colors.darkblue)
    #underline(offset: 0.7mm, stroke: colors.blue, it)
  ]
  show link: lnkstyle
  show ref: lnkstyle
  set quote(block: true, quotes: true)
  show quote: q => {
    set std.align(left)
    set text(style: "italic")
    q
  }

  // show heading.where(level: 5).or(heading.where(level: 6)): h => {
  //   set text(size: fsize - 1pt)
  //   h
  // }

  // FIXME: remove this and check all docs
  set grid(gutter: 1em)
  set table(
    stroke: (x, y) => (
      left: if x > 0 { 0.07em + colors.fg },
      top: if y > 0 { 0.07em + colors.fg },
    ),
    inset: 0.5em,
  )
  set table.cell(breakable: false)
  // FIXME: table-header
  show table.cell.where(y: 0): emph

  show list: set list(marker: "–", body-indent: 0.45em)
  show emph: set text(fill: code-f.fill, weight: code-f.weight)

  // FIXME: stretching arrows doesn't work
  // TODO: test features
  show math.equation: set text(..math-f)
  // TODO: check if this affected any docs negatively
  show math.equation: set block(breakable: true)
  set math.equation(numbering: "(1)")

  // TODO: check if this breaks things
  show math.equation.where(block: false): set math.frac(style: "skewed")
  show math.equation: it => {
    if it.block and not it.has("label") [
      #counter(math.equation).update(v => if v > 0 { v - 1 } else { 0 })
      #math.equation(it.body, block: true, numbering: none)#label(
        // FIXME: this will definitely lead to tanki bugs
        "math-equation-without-numbering",
      )
    ] else {
      it
    }
  }

  show: lq.set-tick(inset: 2pt, outset: 2pt, pad: 0.4em)
  show: lq.set-diagram(
    cycle: color-cycle,
    // FIXME: remove this and check all docs
    width: 8.5cm,
  )
  set lq.style(
    stroke: 1.5pt, /*(paint: colors.darkblue/* , thickness: 1.5pt */)*/
  )
  show lq.selector(lq.diagram): set text(..math-f)

  show: config-code-style.with(fsize, language)
  body
}

#let config-headings(name, module, toc, show-title, fsize, language, body) = {
  let (font, code-f, math-f) = i18n-fonts(language: language, fsize: fsize)

  show ref: ref => if ref.element == none or ref.element.func() != heading {
    ref
  } else {
    let label = ref.target
    let header = ref.element
    link(
      label,
      ["#header.body" (#languages.at(language).page #header.location().page())],
    )
  }

  set outline(indent: 1em)

  show outline.entry.where(level: 1): entry => {
    v(1.1em, weak: true)
    text(fill: colors.purple, strong(entry))
  }

  show outline.entry.where(level: 2): entry => {
    strong(entry)
  }

  if show-title {
    let subtitle(subt) = [
      #set text(..code-f, size: fsize + 3pt)
      #pad(bottom: 1.3em, subt)
    ]

    align(left)[
      #text(..code-f, size: fsize + 5pt, name + " | " + module)
      #v(1em, weak: true)
      #subtitle[#languages.at(language).summary]
    ]
  }

  if toc.enabled {
    if not "x-target" in sys.inputs {
      heading(outlined: false, numbering: none, languages.at(language).toc)
    }
    columns(
      toc.at("columns", default: 1),
      outline(depth: toc.at("depth", default: none), title: none),
    )
    pagebreak()
  }
  body
}

#let general(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  columnsnr: 1,
  toc: (enabled: true, depth: 3, columnsnr: 1),
  language: "de",
  fsize: 11pt,
  show-title: true,
  body,
) = {
  let did = gen-id(module)
  // add-uml-fletcher-marks() removed
  init-ctx(module)

  show: config-page.with(
    author,
    name,
    module,
    semester,
    date,
    landscape,
    columnsnr,
    language,
    fsize,
  )
  show: config-style.with(fsize, language, did)
  show: config-headings.with(name, module, toc, show-title, fsize, language)

  set par(justify: true)

  if "x-target" in sys.inputs {
    // TODO: prefix links to apkg + pdfs and tag stuff because tags are cool
    // TODO: sorta polyfill align/pad etc?
    // TODO: change all the `if "x-target"` with fn
    book-page(body, title: name)
  } else {
    // ta.tanki-doc(
    //   deck: (
    //     ta.deck(module, name, did: did, filename: "deck")
    //   ),
    //   body,
    // )
    // 
    body
  }
}

#let project(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  columnsnr: 1,
  toc: (enabled: true, depth: 3, columnsnr: 1),
  language: "de",
  fsize: 11pt,
  show-title: true,
  body,
) = {
  let (font, code-f) = i18n-fonts(language: language, fsize: fsize)
  let did = gen-id(module)

  set page(
    margin: if (columnsnr < 2) {
      (top: 2cm, left: 1.5cm, right: 1.5cm, bottom: 2cm)
    } else {
      0.5cm
    },
  ) if not "x-target" in sys.inputs
  show table.cell: set text(size: fsize)

  let raw-text = (
    font: code-f.font,
    size: fsize,
  )
  show raw: set text(..raw-text)
  show lq.selector(lq.tick-label): set text(size: raw-text.size - 4pt)
  show lq.selector(lq.legend): set grid(gutter: .25em)

  set heading(
    numbering: "1.1.1.1.1.1.",
    supplement: languages.at(language).chapter,
  )
  show heading: hd => block({
    if hd.numbering != none and hd.level <= 6 {
      context counter(heading).display()
      h(1.3em)
    }
    hd.body
  })

  show heading.where(level: 1): h => {
    set text(..code-f, top-edge: 0.18em, fill: colors.purple)
    set par(leading: 1.3em, hanging-indent: 2.5em)
    line(length: 100%, stroke: 0.18em + colors.purple)
    upper(h)
    v(0.45em)
  }

  show heading.where(level: 2): h => {
    set text(..code-f, top-edge: 0.18em)
    line(length: 100%, stroke: 0.1em + colors.darkblue)
    upper(h)
    v(0.3em)
  }

  show heading.where(level: 3): h => {
    set text(..code-f)
    h
  }

  show heading.where(level: 4): h => {
    h
  }

  set terms(separator: [: ], hanging-indent: 3em)
  show terms: body => {
    body
      .children
      .map(it => pad(left: body.indent + body.hanging-indent, {
        box(inset: (left: -body.hanging-indent), emph(it.term))
        emph(body.separator)
        it.description
        // FIXME: doesn't add note due to show rules not implemented properly in
        // html export?
        // ta.add-note(deck: did, it.term, it.description, format: none)
      }))
      .join()
  }

  general(
    module: module,
    name: name,
    semester: semester,
    date: date,
    landscape: landscape,
    columnsnr: columnsnr,
    toc: toc,
    language: language,
    fsize: fsize,
    show-title: show-title,
    body,
  )
}

#let cheatsheet(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: true,
  columnsnr: 5,
  toc: (enabled: false, depth: 9, columnsnr: 1),
  show-title: false,
  language: "de",
  fsize: 6pt,
  body,
) = {
  let (font, code-f) = i18n-fonts(language: language, fsize: fsize)
  set page(margin: (x: 0.3cm, y: 0.5cm)) if not "x-target" in sys.inputs

  is-cs.update(true)

  show table.cell: set text(size: fsize - 1pt)
  let raw-text = (
    font: code-f.font,
    size: fsize - 1pt,
  )
  show raw: set text(..raw-text)

  show lq.selector(lq.tick-label): set text(size: raw-text.size)

  show lq.selector(lq.legend): set grid(gutter: 0pt)

  set terms(separator: [: ], hanging-indent: 1em, tight: true, spacing: .5em)
  set enum(tight: true, spacing: .5em)
  set list(tight: true, spacing: .5em)

  show heading: hd => {
    if hd.level > 3 {
      text(
        fill: colors.darkblue,
        size: fsize - 1pt,
        style: "italic",
      )[#hd.body]
    } else {
      hd.body
    }
  }

  show heading.where(level: 1): h => {
    set text(..code-f, fill: colors.bg, size: fsize)
    v(-.75em)
    block(width: 100%, inset: (x: 1em, y: .25em), fill: colors.purple, align(
      horizon,
      upper(h),
    ))
    // v(-.25em)
  }

  show heading.where(level: 2): h => {
    set text(..code-f, fill: colors.bg, size: fsize)
    v(-.75em)
    block(width: 100%, inset: (x: 1em, y: .25em), fill: colors.darkblue, align(
      horizon,
      upper(h),
    ))
    v(-.25em)
  }

  show heading.where(level: 3): h => {
    set text(
      ..code-f,
      fill: colors.fg,
      size: fsize - 1pt,
      style: "italic",
    )
    v(-.75em)
    block(
      width: 100%,
      inset: (x: 1em, y: .25em),
      fill: colors-l.darkblue,
      align(
        horizon,
        upper(h),
      ),
    )
    v(-.25em)
    
  }

  general(
    module: module,
    name: name,
    semester: semester,
    date: date,
    landscape: landscape,
    columnsnr: columnsnr,
    toc: toc,
    language: language,
    fsize: fsize,
    show-title: show-title,
    body,
  )

  // test
  body
  
}
