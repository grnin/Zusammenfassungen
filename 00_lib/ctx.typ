#import "information-and-colors.typ": *
#import "./functions.typ": *
// #import "./overrides.typ": align, grid, pad, ta

// credits: https://github.com/omega-800/summaries-se-ost

#let deftbl(
  ..body,
  term: auto,
  definition: auto,
  did: none,
  tags: (),
) = context {
  let term = if term == auto { languages.at(text.lang).term } else { term }
  let definition = if definition == auto {
    languages.at(text.lang).definition
  } else { definition }
  table(
    columns: (auto, 1fr),
    table-header(term, definition),
    ..body,
  )
  // hmm should i use this
  // for t in body.pos().chunks(2) {
  //   terms(tight: false, t)
  // }
  if did != none {
    body
      .pos()
      .chunks(2)
      .map(((t, d)) => ta.add-note(deck: did, t, d, format: none, tags: tags))
      .join()
  }
}

// TODO: finish refactoring to use figure
#let contentbox(
  color: colors.black,
  title: none,
  titlesub: none,
  bodysub: none,
  kind: "content",
  lbl: none,
  body,
) = {
  let content = ()
  if bodysub != none {
    content.push(text(fill: color, style: "italic")[#bodysub :])
  }
  content.push(body)
  pad(
    x: if is-cs.get() { 0pt } else { 1em },
    block(
      stroke: color + 1.25pt,
      fill: color.lighten(95%),
      inset: if is-cs.get() { 2pt } else { 1em },
      width: 100%,
      radius: 3pt,
      [
        #show figure: set block(breakable: true)
        #show figure: set figure.caption(position: top)
        #show figure.caption: it => align(left, grid(
          columns: 2,
          align: horizon,
          [
            #text(fill: color, style: "italic", weight: "bold", it.supplement)
            #text(
              fill: color,
              style: "italic",
            )[#context it.counter.display(it.numbering):
            ]
          ],
          box(text(weight: "bold", it.body)),
        ))
        #figure(
          caption: if title == none { " " } else { title },
          supplement: titlesub,
          kind: kind,
          align(left, [
            #if not is-cs.get() {
              align(center, line(length: 100%, stroke: color))
            }
            #grid(
              columns: if content.len() > 1 { (auto, 1fr) } else { (1fr,) },
              ..content
            )
          ]),
        )
        #if lbl != none { label(lbl) }
      ],
    ),
  )
}

#let notbox(
  tags: (),
  lbl: none,
  // title,
  body,
) = context {
  contentbox(
    color: colors.comment.darken(40%),
    // title: title,
    titlesub: context languages.at(text.lang).note,
    kind: "note",
    lbl: lbl,
    body,
  )
}

#let propctr = counter("propositions")
#let propbox(
  did: none,
  tags: (),
  title: none,
  lbl: none,
  body,
) = context {
  contentbox(
    color: colors.red,
    title: title,
    titlesub: context languages.at(text.lang).proposition,
    kind: "proposition",
    lbl: lbl,
    body,
  )
  if did != none {
    ta.add-note(deck: did, title, body, format: none, tags: tags)
  }
}

#let defctr = counter("definitions")
#let defbox(
  // term: context languages.at(text.lang).term,
  // definition: context languages.at(text.lang).definition,
  term: context languages.at(text.lang).definition,
  did: none,
  tags: (),
  lbl: none,
  title,
  body,
) = context {
  contentbox(
    color: colors.purple,
    title: title,
    titlesub: term,
    kind: "definition",
    lbl: lbl,
    // bodysub: definition,
    body,
  )
  if did != none {
    ta.add-note(deck: did, title, body, format: none, tags: tags)
  }
}

#let exctr = counter("examples")
#let exbox(
  example: context languages.at(text.lang).example,
  title: none,
  did: none,
  tags: (),
  lbl: none,
  body,
) = context {
  contentbox(
    color: colors.darkblue,
    title: title,
    titlesub: example,
    kind: "example",
    lbl: lbl,
    body,
  )
  if did != none and title != none {
    ta.add-note(deck: did, title, body, format: none, tags: tags)
  }
}

#let obsctr = counter("observations")
#let obsbox(
  observations: context languages.at(text.lang).observations,
  title: none,
  lbl: none,
  ..body,
) = context {
  contentbox(
    color: colors.green,
    title: title,
    titlesub: observations,
    kind: "observation",
    lbl: lbl,
    if body.pos().len() == 1 { body.pos().join() } else {
      grid(columns: (auto, 1fr), ..body
          .pos()
          .enumerate(start: 1)
          .map(((i, b)) => (
            // [#n.#i.],
            [#i.],
            b,
          ))
          .join())
    },
  )
}

#let frame = (
  unit: "bit",
  with-tbl-unit: false,
  with-desc-unit: true,
  with-desc: true,
  did: none,
  ..body,
) => {
  let get-size = v => if type(v) == int { v } else { v.size }
  let get-unit = v => if (
    type(v) != int and "with-unit" in v and not v.with-unit
  ) {} else { " (" + str(get-size(v)) + " " + unit + ")" }
  let get-name = (k, v) => if type(v) == int or not "name" in v { k } else {
    v.name
  }
  let as-list = body.pos().map(r => r.pairs()).join()
  let defs = as-list.filter(((k, v)) => type(v) != int and "desc" in v)
  let size = body.pos().first().values().map(get-size).sum()

  {
    set text(font: code-font)
    set table(stroke: 0.07em)
    set table.cell(align: center)

    table(
      columns: range(0, size).map(_ => 1fr),
      table-header(table.cell(
        colspan: size,
        $stretch(size: #5em, <-)#h(1em)
        #(str(size)) #unit #h(1em)stretch(size: #5em, ->)$,
      )),
      ..as-list.map(
        ((k, v)) => table.cell(
          colspan: get-size(v),
          get-name(k, v) + if with-tbl-unit { get-unit(v) },
        ),
      )
    )
  }
  if with-desc and defs.len() != 0 {
    deftbl(
      term: "Field",
      ..defs
        .map(((k, v)) => (
          [#get-name(k, v) #{ if with-desc-unit { get-unit(v) } }],
          [#v.desc],
        ))
        .flatten(),
    )
  }
}
#let custom-frame = (..body) => {
  set text(font: code-font)
  set table(stroke: 0.07em)
  set table.cell(align: center)
  table(..body)
}

// ew - polyfilling reminds me too much of js

#let only-html = it => context if "html" in std and target() == "html" { it }
#let no-html = it => context if not ("html" in std and target() == "html") {
  it
}
#let only-tanki = it => context if (
  "html" in std
    and target() == "html"
    and "tanki" in sys.inputs
    and sys.inputs.tanki == "true"
) { it }
#let no-tanki = it => context if not (
  "tanki" in sys.inputs and sys.inputs.tanki == "true"
) { it }

#let prev-headings() = context {
  query(selector(heading).before(here()))
    .rev()
    .fold((:), (acc, cur) => if str(cur.level) in acc { acc } else {
      acc.insert(str(cur.level), cur.body)
      acc
    })
}

#let prev-heading() = context {
  query(selector(heading).before(here())).last().body
}

#let init-ctx = module => {
  module-name.update(module)
}

#let todo(body) = {
  no-tanki(pad(x: 1em, block(
    fill: colors.red.transparentize(80%),
    stroke: (top: colors.red),
    width: 100%,
    inset: 0.5em,
    [
      #text(fill: colors.red, weight: "bold", style: "italic")[TODO:\ ]
      #body
    ],
  )))
}
