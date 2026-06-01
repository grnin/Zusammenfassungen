#import "information-and-colors.typ": *

// /*

#let rfc(num) = link(
  "https://www.rfc-editor.org/info/rfc" + str(num),
  text(font: code-font)[RFC #num],
)
// TODO: grey out if private & match subnet
#let ip = (it, size: 10pt) => text(font: code-font, size: size, it)
#let corr = it => text(fill: colors.red, weight: "bold")[#it]
#let comment = it => text(fill: colors.comment, style: "italic")[#it]
#let cr = table.cell(fill: colors-l.red, sym.crossmark)
#let cg = table.cell(fill: colors-l.green, sym.checkmark)
#let cb = table.cell(fill: colors-l.blue, sym.star)
#let table-header = (..args) => {
  table.header(
    // FIXME: fmap table.cell
    // ..args.pos().map(emph),
    ..args.pos(),
    ..args.named(),
  )
}
#let table-footer = (..args) => table.header(
  // FIXME: fmap table.cell
  // ..args.pos().map(comment),
  ..args.pos(),
  ..args.named(),
)
#let tp = it => text(fill: colors.purple)[#it]
#let tr = it => text(fill: colors.red)[#it]
#let tg = it => text(fill: colors.green)[#it]
#let tb = it => text(fill: colors.blue.darken(50%))[#it]
#let td = it => text(fill: colors.darkblue)[#it]
#let ty = it => text(fill: colors.yellow)[#it]
#let to = it => text(fill: colors.orange)[#it]

#let subst(term, s) = $lr(#term |)_#s$

#let ve = b => math.accent(b, math.arrow)
#let num(prefix: none, postfix: none, n) = {
  if prefix != none {
    set text(fill: colors.comment)
    "0"
    prefix
  }
  // set text(fill: colors.fg, weight: "bold")
  if postfix != none { $#{ n } _#postfix$ } else { n }
}

// TODO: negative and decimal? enc?
// TODO: pad param
#let fromdec(n, b, g: none, gpre: "0", d: " ") = {
  let res = ""
  let i = 0
  while n != 0 {
    let rem = calc.rem(n, b)
    res += if rem > 9 and b > 10 { str.from-unicode(55 + rem) } else {
      str(rem)
    }
    n = calc.floor(n / b)
    i += 1
    if g != none and calc.rem(i, g) == 0 and n > 0 {
      res += d
    }
  }
  if g != none and calc.rem(i, g) > 0 {
    res += gpre * (g - calc.rem(i, g))
  }
  res.rev()
}

#let oct(n, prefix: true, postfix: false) = {
  num(fromdec(n, 8, g: 3), prefix: if prefix { "o" }, postfix: if postfix { 8 })
}
#let hex(n, prefix: true, postfix: false) = {
  num(
    fromdec(n, 16, g: 2),
    prefix: if prefix { "x" },
    postfix: if postfix { 16 },
  )
}
#let bin(n, prefix: true, postfix: false) = {
  num(fromdec(n, 2, g: 4), prefix: if prefix { "b" }, postfix: if postfix { 2 })
}
#let dec(n, prefix: true, postfix: false) = {
  let i = 0
  let res = ""
  for d in str(n).rev() {
    res += d
    i += 1
    if calc.rem(i, 3) == 0 and i != str(n).len() {
      res += "'"
    }
  }
  num(res.rev(), prefix: if prefix { "d" }, postfix: if postfix { 10 })
}

#let no-ligature = text.with(features: (calt: 0))

// bruh lilaq has builtin circle, dumb me

#let lqcircle(s: 1, x: 0, y: 0, f: 0, n: 100) = {
  let p = i => i * 2 * calc.pi / n
  range(0, n).map(i => (calc.sin(p(i + f)) * s + x, calc.cos(p(i + f)) * s + y))
}

#let lqcut(points, (x1, y1), (x2, y2)) = {
  points.filter(((x, y)) => {
    x >= x1 and x <= x2 and y >= y1 and y <= y2
  })
}

#let merge-deep(a1, a2) = {
  if type(a1) == dictionary and type(a2) == dictionary {
    for (k, v) in a2.pairs() {
      a1.insert(k, if k in a1 { merge-deep(a1.at(k), v) } else { v })
    }
  }
  a1
}

#let merge-args = (a1, a2) => (
  (..a1.pos(), a2.pos()),
  merge-deep(a1.named(), a2.named()),
)

#let note-answer = note => note.fields.at(1)

#let gen-id(name) = repr(name).codepoints().map(str.to-unicode).sum()

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  } else if repr(it) == "linebreak()" {
    "\n"
  } else if repr(it) == "parbreak()" {
    "\n\n"
  } else {
    // TODO: handle more cases
    repr(it)
  }
}

#let procontra = (..args) => table(
  columns: (1fr, 1fr),
  table-header([Pro], [Contra]), ..args,
)

#let shade = (x: 10pt, y: 10pt, stroke: 1pt) => tiling(size: (x, y))[
  #place(line(
    start: (0%, 100%),
    end: (100%, 0%),
    stroke: stroke,
  ))
]

#let fora = (cond, pred) => $forall #cond . space (#pred)$
#let exis = (cond, pred) => $exists #cond . space (#pred)$

// */