
// #import cntopo: fletcher-shapes, icons, to-fletcher-shapes

// #let tmodel = ta.model(
//   id: 69420,
//   name: "summaries",
//   fields: ("Question", "Answer"),
//   templates: (
//     ("With tags", "{{Question}} ({{Tags}})", "{{Answer}}"),
//     // ("Without tags", "{{Question}}", "{{Answer}}"),
//   ),
// )

// // TODO: incorporate this everywhere
// // WARN: wait for omega-800 to slightly refactor tanki api
// // NOTE: oh wait that's me
// // FIXME: slice and spread rest of fields
// #let note = ta.add-note.with(
//   //   anki-format: n => (
//   //   ..n,
//   //   fields: ([#n.fields.at(0) (#n.tags.join([, ]))], n.fields.at(1)),
//   // )
//   model: tmodel,
// )


// #let start-note = ta.start-note.with(model: tmodel, anki-format: n => (
//   ..n,
//   fields: n.fields.map(f => [#set heading(numbering: none); #f]),
// ))



// #let deck = ta.deck.with(filename: "deck")
// #let add-deck = ta.add-deck.with(filename: "deck")



// // TODO: PR: only element functions can be used in set rules

// #let diagram = (..args) => html.frame(fletcher.diagram(
//   node-stroke: 1pt + colors.fg,
//   edge-stroke: 1pt + colors.fg,
//   mark-scale: 60%,
//   spacing: (1em, 1em),
//   node-shape: rect,
//   ..args,
// ))
// #let diagram3d = (..args) => html.frame(pt3d.diagram(
//   width: 8.5cm,
//   height: 6cm,
//   cycle: color-cycle,
//   ..args,
// ))
// #let pt = pt3d

// // TODO: bring all html polyfills into one place
// // FIXME: this is so cursed
// #let grid = if "x-target" in sys.inputs or "tanki" in sys.inputs {
//   std.table
// } else { std.grid }
// // yoinked from https://github.com/Glomzzz/typsite-template/blob/2ddb71ff90abffadfb69ea1a6f6e87904fb96304/root/lib/html.typ#L137-L150
// // TODO:
// // #let align(alignment, content) = context {
// //   if target() != "html" {
// //     return std.align(alignment, content)
// //   }
// //   if alignment == none {
// //     return content
// //   }
// //   let horizontally = if alignment == none { "left" } else if (
// //     alignment == center
// //   ) { "center" } else if (
// //     alignment == left
// //   ) { "left" } else if alignment == right { "right" } else if (
// //     alignment.x == center
// //   ) { "center" } else if (
// //     alignment.x == right
// //   ) { "right" } else { "left" }
// //   html.div(style: "text-align: " + horizontally + ";", content)
// // }
// #let v = if (
//   "x-target" in sys.inputs or "tanki" in sys.inputs
// ) { (..) => none } else { std.v }
// #let h = if (
//   "x-target" in sys.inputs or "tanki" in sys.inputs
// ) { (..) => none } else { std.h }
// #let line = if (
//   "x-target" in sys.inputs or "tanki" in sys.inputs
// ) { (..) => none } else { std.line }



// #let align(alignment, content) = if (
//   "x-target" in sys.inputs or "tanki" in sys.inputs
// ) {
//   // FIXME: wtf shiroa
//   // content
//   std.align(alignment, content)
// } else {
//   std.align(alignment, content)
// }


// #let pad(
//   body,
//   bottom: 0% + 0pt,
//   left: 0% + 0pt,
//   rest: 0% + 0pt,
//   right: 0% + 0pt,
//   top: 0% + 0pt,
//   x: 0% + 0pt,
//   y: 0% + 0pt,
// ) = context {
//   if target() == "html" {
//     // TODO:
//     body
//   } else {
//     std.pad(
//       body,
//       bottom: bottom,
//       left: left,
//       rest: rest,
//       right: right,
//       top: top,
//       x: x,
//       y: y,
//     )
//   }
// }
// // #let place() ...
// // #let columns(..args) = if "x-target" in sys.inputs {
// //   stack(..args.pos())
// // } else { columns(..args) }




// #let diagram2d = (..args) => {
//   show: lq.theme.schoolbook
//   html.frame(lq.diagram(
//     yaxis: (position: 0),
//     xaxis: (position: 0),
//     ..args,
//     ..(
//       if ("tanki" in sys.inputs or "x-target" in sys.inputs)
//         and "width" in args.named() {
//         (
//           width: 10cm,
//         )
//       } else { (:) }
//     ),
//   ))
// }
// #let canvas = (..args) => html.frame(cetz.canvas(..args))
// #let seqdiag = (..args) => html.frame(chronos.diagram(..args))

// #let edge = fletcher.edge.with(label-side: center)
// #let _par = chronos._par.with(color: colors-l.darkblue, show-bottom: false)
// #let _seq = chronos._seq.with(
//   slant: 5,
//   comment-align: "center",
//   color: colors.fg,
// )
// #let _sep = chronos._sep.with()
// #let _note = chronos._note.with(shape: "rect", color: colors-l.darkblue)
// #let _lnote = _note.with("left")

// #let cnargs = (
//   stroke: colors.darkblue.lighten(30%) + 1.5pt,
//   fill: colors.darkblue,
//   fill-inner: colors.white,
//   stroke-inner: colors.white,
// )

// #let i = icons(..cnargs, flat: false)
// #let (
//   i-monitor,
//   i-router,
//   i-switch,
//   i-l3-switch,
//   i-server,
//   i-cloud,
//   i-key,
// ) = (
//   i.pairs().map(((k, v)) => ("i-" + k, v)).to-dict()
// )
// #let (
//   monitor,
//   router,
//   switch,
//   l3-switch,
//   server,
//   cloud,
//   key,
// ) = to-fletcher-shapes(i)
// #let cloud = cloud.with(override-color: true)

// #let abr = router.with(detail: "ABR")
// #let asbr = router.with(detail: "ASBR")
// #let br = router.with(detail: "BR")
// #let ir = router.with(detail: "IR")
// #let dr = router.with(detail: "DR")
// #let bdr = router.with(detail: "BDR")
// #let l1 = router.with(detail: "L1")
// #let l1l2 = router.with(detail: "L1-L2")
// #let l2 = router.with(detail: "L2")
// #let isr = router.with(detail: "IS")
// #let dis = router.with(detail: "DIS")
// #let drother = router.with(detail: text(size: .75em)[DROTHER])
// #let mrce = router.with(detail: "CE")
// #let mrpe = router.with(detail: "PE")
// #let mrp = router.with(detail: "P")
// #let xor-shape = (node, extrude, ..) => {
//   import "@preview/cetz:0.3.4": draw
//   let (w, h) = node.size.map(i => i / 2 + extrude)
//   draw.circle((0, 0), radius: (w, h), stroke: node.stroke, fill: node.fill)
//   draw.line((0, -h), (0, h), stroke: node.stroke)
//   draw.line((-w, 0), (w, 0), stroke: node.stroke)
// }

// #let automaton = (..args) => {
//   let transitions = (:)
//   let states = (:)
//   let nodes = args.pos().at(0)
//   let n-no-style = ()
//   let t-no-style = ()
//   let seen = ()
//   let style = args.named().at("style", default: (:))
//   for (k, v) in nodes.pairs() {
//     if not k in style or not "stroke" in style.at(k) { n-no-style.push(k) }
//     if (
//       v.len() == 0
//         and (not k in style or not "stroke" in style.at(k))
//         and nodes.pairs().all(((_, vv)) => not k in vv)
//     ) {
//       states.insert(k, (stroke: colors.comment))
//     }
//     if type(v) != dictionary { continue }

//     for (to, _) in v.pairs() {
//       let ft = k + "-" + to
//       if not ft in style or not "stroke" in style.at(ft) { t-no-style.push(ft) }
//       let tf = to + "-" + k
//       if not to in nodes { continue }
//       if (
//         not k in nodes.at(to)
//           and (not ft in style or not "curve" in style.at(ft))
//       ) {
//         transitions.insert(ft, (curve: 0))
//       }
//       if (
//         k in nodes.at(to)
//           and not k in seen
//           and (not tf in style or not "curve" in style.at(tf))
//       ) {
//         transitions.insert(tf, (curve: 0))
//         // TODO:
//         seen.push(to)
//       }
//       // TODO:
//       // seen.push(to)
//     }
//   }
//   let cond-stroke = (ns, c) => if c {
//     ns.map(k => (k, (stroke: colors.fg))).to-dict()
//   } else { (:) }
//   html.frame(finite.automaton(
//     ..args.pos(),
//     // ..args.named(),
//     ..merge-deep(
//       args.named(),
//       (
//         state-format: label => {
//           let m = label.match(regex(`^(s)?(_)?(\D+)((\d+,?)+)?$`.text))
//           // panic("q1,2,3".match(regex(`^(s)?(_)?(\D+)((\d+,?)+)?$`.text)))
//           if m != none {
//             let is-set = m.captures.at(0) != none
//             let is-neg = m.captures.at(1) != none
//             let is-all = m.captures.at(2) == "Q"
//             let is-eps = m.captures.at(2) == "e"
//             let n = m.captures.at(3)
//             let ns = (n,)
//             if n != none and "," in n {
//               ns = n.split(",")
//             }

//             let name = $#if is-eps { $epsilon$ } else if is-all { $Q$ } else { $italic(#m.captures.at(2))$ }$
//             let char = ns
//               .map(d => if d == none { $#name$ } else { $#{ name } _#d$ })
//               .join($,$)
//             if is-set and not is-all {
//               if is-eps { $emptyset$ } else {
//                 let s = ${#char}$
//                 if is-neg { $overline(#s)$ } else { $#s$ }
//               }
//             } else { $#char$ }
//           } else {
//             $#label$
//           }
//         },
//         input-format: inputs => {
//           if type(inputs) != array { return inputs }
//           inputs
//             .map(i => if i == "\S" { $S$ } else if i == "\e" { $e$ } else if i
//               == "S" { $Sigma$ } else if i == "e" {
//               $epsilon$
//             } else {
//               $#i$
//             })
//             .join($,$)
//         },
//         style: (:
//           ..merge-deep(
//             (
//               transition: (
//                 label: (angle: 0deg, stroke: colors.fg),
//                 curve: .75,
//               ),
//               state: (
//                 stroke: colors.fg,
//                 label: (stroke: colors.fg),
//                 radius: 1.25em,
//               ),
//             ),
//             merge-deep(
//               (:..transitions, ..states),
//               (:
//                 ..cond-stroke(
//                   t-no-style,
//                   not "transition" in style or not "stroke" in style.transition,
//                 ),
//                 ..cond-stroke(
//                   n-no-style,
//                   not "state" in style or not "stroke" in style.state,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ))
// }