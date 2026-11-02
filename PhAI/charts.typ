#import "../template_zusammenf.typ": colors
#import "@preview/cetz:0.5.2": angle, canvas, draw
#import "@preview/cetz-plot:0.1.4": plot

#let label(pos, anchor, body) = draw.content(pos, anchor: anchor, padding: 0.2, body)

// Creates a unit plot
#let unit-plot() = {
  import draw: *
  let text-size = 0.8em

  set-style(stroke: (paint: gray, thickness: 0.05em))

  // Draw x axis
  line((-1.5, 0), (1.5, 0), mark: (end: ">"))
  content((), padding: 0.1em, text(size: text-size)[$x$], anchor: "west")

  // Draw y axis
  line((0, -1.5), (0, 1.5), mark: (end: ">"))
  content((), padding: 0.1em, text(size: text-size)[$y$], anchor: "south")

  // Draw origin
  content((-0.05, -0.05), text(size: 0.8em)[0], anchor: "north-east")

  // Axis markings
  for v in (1, -1) {
    content((v + 0.1, -0.1), text(size: text-size)[#v], anchor: "north")
    content((-0.05, v + 0.1), text(size: text-size)[#v], anchor: "east")
  }
}

#let trigo() = {
  canvas(length: 2.5em, {
    import draw: *
    set-style(stroke: (thickness: 0.1em))

    line((0, 0), (2, 0), name: "Ankathete")
    label("Ankathete", "north", $a$)

    line((2, 0), (2, 2), name: "Gegenkathete")
    label("Gegenkathete", "west", $g$)

    line((0, 0), (2, 2), name: "Hypothenuse")
    label("Hypothenuse", "south", $h$)

    set-style(stroke: (paint: black))

    // Angle alpha
    angle.angle("Ankathete.start", "Ankathete.end", "Hypothenuse.end", radius: 50%, label: $alpha$)
    // Right angle
    angle.angle("Gegenkathete.start", "Gegenkathete.end", "Ankathete.start", label: $dot$)
  })
}

#let strahlensatz() = {
  canvas(length: 2em, {
    import draw: *

    set-style(stroke: (thickness: 0.1em))

    // Get a point on a line between 'start' and 'end'. 't' sets how far along the point is.
    let lerp(start, end, t) = (
      start.at(0) * (1 - t) + end.at(0) * t,
      start.at(1) * (1 - t) + end.at(1) * t,
    )

    let S = (0, 0)
    // Line end points to set the angle
    let r1 = (5, 2)
    let r2 = (5, -1)
    // Percentage of how far on the line the point sits
    let p = 0.4
    let q = 0.8
    // Set original and new points
    let Ap = lerp(S, r1, p)
    let A = lerp(S, r1, q)
    let Bp = lerp(S, r2, p)
    let B = lerp(S, r2, q)

    // Draw Lines
    line(S, A)
    line(S, B)
    line(lerp(S, r1, p), lerp(S, r2, p))
    line(lerp(S, r1, q), lerp(S, r2, q))

    // Draw Points
    fill(black)
    for pt in (S, A, Ap, B, Bp) { circle(pt, radius: 0.05) }

    // Draw labels
    label(S, "east", $S$)
    label(A, "south", $A$)
    label(Ap, "south", $A'$)
    label(B, "north", $B$)
    label(Bp, "north", $B'$)
  })
}

#let position-auf-kreis-sin-cos(angle, cos-angle, sin-angle, angle-str, length, text-size) = {
  canvas(length: length, {
    import draw: *

    set-style(stroke: (thickness: 0.15em), mark: (length: 0.7em, width: 0.4em))
    unit-plot()

    circle((0, 0), radius: 1)

    // Styling of the lines and point on the circle
    let west-line = (thickness: 0.1em, paint: colors.orange)
    let east-line = (thickness: 0.1em, paint: colors.dunkelblau)
    let west-point = (radius: 0.05, stroke: white + 0.1em, fill: colors.gelb)
    let east-point = (radius: 0.05, stroke: white + 0.1em, fill: colors.hellblau)

    // +sin, +cos
    arc((0, 1), start: 90deg, stop: 90deg - angle, stroke: east-line)
    circle((sin-angle, cos-angle), name: "1", ..east-point)
    label("1", "west", text(size: text-size, $vec(+sin(#angle-str°), +cos(#angle-str°))$))

    // -sin, +cos
    arc((0, 1), start: 90deg, stop: 90deg + angle, stroke: west-line)
    circle((-sin-angle, cos-angle), name: "2", ..west-point)
    label("2", "east", text(size: text-size, $vec(-sin(#angle-str°), +cos(#angle-str°))$))

    // -sin, -cos
    arc((0, -1), start: 270deg, stop: 270deg - angle, stroke: west-line)
    circle((-sin-angle, -cos-angle), name: "3", ..west-point)
    label("3", "east", text(size: text-size, $vec(-sin(#angle-str°), -cos(#angle-str°))$))

    // +sin, -cos
    arc((0, -1), start: 270deg, stop: 270deg + angle, stroke: east-line)
    circle((sin-angle, -cos-angle), name: "4", ..east-point)
    label("4", "west", text(size: text-size, $vec(+sin(#angle-str°), -cos(#angle-str°))$))
  })
}


#let position-auf-kreis-cos-sin(angle, cos-angle, sin-angle, angle-str, length, text-size) = {
  canvas(length: length, {
    import draw: *

    set-style(stroke: (thickness: 0.15em), mark: (length: 0.7em, width: 0.4em))
    unit-plot()

    circle((0, 0), radius: 1)

    // Styling of the lines and point on the circle
    let north-line = (thickness: 0.1em, paint: colors.dunkelblau)
    let south-line = (thickness: 0.1em, paint: colors.orange)
    let north-point = (radius: 0.05, stroke: white + 0.1em, fill: colors.hellblau)
    let south-point = (radius: 0.05, stroke: white + 0.1em, fill: colors.gelb)

    // +cos, +sin
    arc((1, 0), start: 0deg, stop: angle, stroke: north-line)
    circle((cos-angle, sin-angle), name: "1", ..north-point)
    label("1", "south", text(size: text-size, $vec(+cos(#angle-str°), +sin(#angle-str°))$))

    // -cos, +sin
    arc((-1, 0), start: 180deg, stop: 180deg - angle, stroke: north-line)
    circle((-cos-angle, sin-angle), name: "2", ..north-point)
    label("2", "south", text(size: text-size, $vec(-cos(#angle-str°), +sin(#angle-str°))$))

    // -cos, -sin
    arc((-1, 0), start: 180deg, stop: 180deg + angle, stroke: south-line)
    circle((-cos-angle, -sin-angle), name: "3", ..south-point)
    label("3", "north", text(size: text-size, $vec(-cos(#angle-str°), -sin(#angle-str°))$))

    // +cos, -sin
    arc((1, 0), start: 360deg, stop: 360deg - angle, stroke: south-line)
    circle((cos-angle, -sin-angle), name: "4", ..south-point)
    label("4", "north", text(size: text-size, $vec(+cos(#angle-str°), -sin(#angle-str°))$))
  })
}

#let position-auf-kreis(angle) = {
  let cos-angle = calc.cos(angle)
  let sin-angle = calc.sin(angle)
  let angle-str = calc.round(angle.deg())
  let length = 4.6em
  let text-size = 1.2em
  (
    position-auf-kreis-cos-sin(angle, cos-angle, sin-angle, angle-str, length, text-size),
    position-auf-kreis-sin-cos(angle, cos-angle, sin-angle, angle-str, length, text-size),
  )
}

#let bewegung-auf-kreis() = {
  canvas(length: 5.5em, {
    import draw: *

    set-style(stroke: (thickness: 0.2em), mark: (length: 0.8em, width: 0.5em))
    unit-plot()

    // Lower semi-circle: t = pi ... 2pi
    arc(
      (1, 0),
      start: 0deg,
      stop: -180deg,
      radius: 1,
      stroke: (paint: gray, thickness: 0.1em, dash: "dashed"),
    )

    // Upper semi-circle: t = 0 ... pi
    arc(
      (1, 0),
      start: 0deg,
      stop: 177deg,
      radius: 1,
      stroke: (paint: colors.hellblau),
      mark: (end: ">", fill: colors.hellblau),
    )

    // Verschiebungsvektor Delta r
    line(
      (1, 0),
      (-1 + 0.05, 0),
      mark: (end: ">", fill: colors.orange),
      stroke: (paint: colors.orange),
    )
    content(
      (0, 0.05),
      text(fill: colors.orange, weight: "bold")[$Delta bold(r) = vec(-2, 0), quad abs(Delta bold(r)) = 2$],
      anchor: "south",
    )

    // Origin point
    circle((1, 0), radius: 0.05, fill: colors.dunkelblau, stroke: white + 0.2em)
    content(
      (1 + 0.05, 0.3),
      text(fill: colors.dunkelblau, weight: "bold")[$t = 0$ \ $(1,0)$],
      anchor: "west",
    )

    // End point
    circle((-1, 0), radius: 0.05, fill: colors.rot, stroke: white + 0.2em)
    content(
      (-1 - 0.05, 0.3),
      text(fill: colors.rot, weight: "bold")[$t = pi$ \ $(-1,0)$],
      anchor: "east",
    )
  })
}

#let momentangeschwindigkeit-kreis() = {
  canvas(length: 3.7em, {
    import draw: *
    set-style(stroke: (thickness: 0.15em), mark: (length: 0.7em, width: 0.4em))
    unit-plot()

    circle((0, 0), radius: 1)

    // Semi-circle
    arc(
      (1, 0),
      start: 0deg,
      stop: 90deg,
      stroke: (paint: colors.hellblau, thickness: 0.2em),
    )
    // Arrow
    line(
      (0, 1),
      (-0.75, 1),
      stroke: (paint: colors.rot, thickness: 0.2em),
      mark: (end: ">", fill: colors.rot),
    )
    // Point
    circle((0, 1), radius: 0.08, fill: colors.rot, stroke: white + 0.15em)
  })
}

#let kreis-beschleunigung() = {
  canvas(length: 5.1em, {
    import draw: *

    set-style(stroke: (thickness: 0.15em), mark: (length: 0.7em, width: 0.4em))
    unit-plot()

    circle((0, 0), radius: 1)

    // Vector v
    line(
      (1, 0),
      (1, 1),
      stroke: (paint: colors.dunkelblau, thickness: 0.2em),
      mark: (end: ">", size: 0.25, fill: colors.dunkelblau),
    )
    label((1, 0.5), "west", text(size: 0.8em, fill: colors.dunkelblau)[$v(t)$])

    // Vector a
    line(
      (1, 0),
      (0, 0),
      stroke: (paint: colors.rot, thickness: 0.2em),
      mark: (end: ">", size: 0.25, fill: colors.rot),
    )
    label((0.5, 0), "south", text(size: 0.8em, fill: colors.rot)[$a(t)$])

    // Point
    circle((1, 0), radius: 0.05, fill: black)
  })
}

#let schiefer-wurf() = {
  canvas(length: 3.4em, {
    import draw: *
    let text-size = 0.8em

    set-style(stroke: (thickness: 0.1em), mark: (length: 0.7em, width: 0.4em))

    // x axis
    line((-0.5, 0), (3, 0), mark: (end: ">"))
    content((), padding: 0.1em, text(size: text-size)[$x$], anchor: "west")

    // y axis
    line((0, -0.5), (0, 2), mark: (end: ">"))
    content((), padding: 0.1em, text(size: text-size)[$y$], anchor: "south")

    // center
    content((-0.05, -0.05), text(size: 0.8em)[0], anchor: "north-east")

    // y_0
    label((0, 1), "east", text(size: text-size, [$y_0$]))

    // horizontal line
    line((0, 1), (1.5, 1), name: "diag", stroke: (paint: gray, dash: "dashed"))
    label((1, 2), "north", text(size: text-size)[$v_0$])

    // v_0
    line((0, 1), (1, 2), name: "curve", mark: (end: ">"))
    circle((0, 1), radius: 0.05, fill: gray)

    // alpha
    angle.angle("diag.start", "diag.end", "curve.end", label: $alpha$, radius: 50%)
  })
}

#let waagrechter-wurf(h: 2, v_0: 1, y: 1, scaling: 1) = {
  canvas({
    import draw: *
    import calc: pow

    let g = -9.81

    set-style(
      stroke: (thickness: 0.1em),
      mark: (length: 0.7em, width: 0.4em),
      axes: (tick: (stroke: 0.1em, length: 1.3em)),
    )

    scale(scaling)

    plot.plot(
      size: (7, 6),
      y-label: $h$,
      axis-style: "left",
      {
        plot.add(domain: (0, y + 0.1), x => 1 / 2 * g * pow(x / v_0, 2) + h)
      },
    )
  })
}

#let kreiskraft(phi, scaling: 1) = {
  canvas(length: 1cm * scaling, {
    import draw: *

    let R = 1

    // Helper point on the circle
    let P = (
      x: R * calc.cos(phi),
      y: R * calc.sin(phi),
    )

    // Unit vectors
    let ur = (
      x: calc.cos(phi),
      y: calc.sin(phi),
    )

    let ut = (
      x: -calc.sin(phi),
      y: calc.cos(phi),
    )

    set-style(mark: (length: 1em, width: 0.4em))

    unit-plot()

    // Background circle
    circle((0, 0))

    set-style(stroke: (black + 0.1em))

    // Radius
    line((0, 0), P, mark: (end: ">", fill: black), name: "r")

    // Velocity (tangent)
    let V = (
      x: P.x + ut.x * 0.7,
      y: P.y + ut.y * 0.7,
    )

    line(P, V, mark: (end: ">", fill: black), name: "v")

    label("v", "base-east", $v(t) = r dot dot(#sym.phi) (t)$)

    // Radial acceleration (toward center)
    let AZ = (
      x: P.x - ur.x * 0.4,
      y: P.y - ur.y * 0.4,
    )
    line(P, AZ, stroke: red, mark: (end: ">", fill: red), name: "a_Z")
    label("a_Z", "west", text(fill: red)[$a_Z(t) parallel r(t)$])

    // Tangential acceleration
    let AT = (
      x: P.x + ut.x * 0.4,
      y: P.y + ut.y * 0.4,
    )
    line(P, AT, stroke: red, mark: (end: ">", fill: red), name: "a_T")
    label("a_T", "mid-west", text(fill: red)[$a_T (t) parallel v(t)$])

    // Point on circle
    circle(P, radius: 0.03, fill: black, name: "P")

    // Radius label
    label("r", "mid-east", $r(t)$)

    // Angle arc
    angle.angle("r.start", (0.5, 0), "r.end", name: "angle")

    content((0.32, 0.1), $#sym.phi (t)$)
  })
}
