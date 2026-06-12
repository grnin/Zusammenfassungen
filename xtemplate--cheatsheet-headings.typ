set heading(
numbering: none,
hanging-indent: 30pt,
)


// H1
show heading.where(level: 1): h => {
block(
fill: colors.stroke-blue,
sticky: true,
// margin:
// above: 2pt,
above: 4.5pt,
below: 1pt,
// padding:
inset: (top: 3pt, right: 2pt, bottom: 3pt, left: 2pt),
width: 100%,
text(
font: calibri-font,
style: "normal",
weight: "light",
size: 7pt,
tracking: 0.75pt,
fill: white,
// upper(h.body),
upper(h),
),
)
v(0.45em)
}

// H2
show heading.where(level: 2): h => {
block(
fill: colors.light-blue,
sticky: true,
// margin:
// above: 2pt,
above: 4.5pt,
below: 1pt,
// padding:
inset: (top: 3pt, right: 2pt, bottom: 3pt, left: 2pt),
width: 100%,
text(
font: calibri-font,
style: "normal",
weight: "light",
size: 5.5pt,
tracking: 0.75pt,
// fill: white,
upper(h.body),
),
)
v(0.45em)
}

// H3
show heading.where(level: 3): h => {
block(
above: 5pt,
below: 4pt,
text(
font: aptos-font,
style: "normal",
weight: "semibold",
size: 5pt,
h.body,
),
)
}

show heading.where(level: 4): h => {
block(
above: 7pt,
below: 3pt,
text(
// size: 1.1em,
size: 1em,
fill: colors.bg-dark-blue,
// [#(h.body)     --- --- --- --- --- --- --- --- --- ---],
// [#(h.body)],
[#(h)],
),
)
}

// compact version:
/*
// // H1
show heading.where(level: 1): h => {
    block(
        fill: colors.stroke-blue,
        sticky: true,
        // margin:
        above: 4pt,
        below: 1pt,
        inset: (top: 2pt, right: 1pt, bottom: 2pt, left: 1pt),
        width: 100%,
        text(
            font: calibri-font,
            style: "normal",
            weight: "light",
            size: 6pt,
            tracking: 0.75pt,
            fill: white,
            upper(h.body),
        ),
    )
}

// H2
show heading.where(level: 2): h => {
    block(
        fill: colors.light-blue,
        sticky: true,
        // margin:
        above: 2pt,
        below: 0.5pt,
        inset: 1pt,
        width: 100%,
        text(
            font: calibri-font,
            style: "normal",
            weight: "light",
            size: 5pt,
            tracking: 0.75pt,
            // fill: white,
            upper(h.body),
        ),
    )
    v(0.45em)
}

// H3
show heading.where(level: 3): h => {
    block(
        above: 4pt,
        below: 3pt,
        text(
            font: aptos-font,
            style: "normal",
            weight: "semibold",
            size: 5pt,
            h.body,
        ),
    )
}


show heading.where(level: 4): h => {
    block(
        above: 7pt,
        below: 3pt,
        text(
            size: 1em,
            fill: colors.bg-dark-blue,
            // [#(h.body)     --- --- --- --- --- --- --- --- --- ---],
            [#(h.body)],
        ),
    )
}
// */
// end compact version


// Remove space above H4, fixes spacing between H3 & H4
show heading.where(level: 4): h => {
v(-0.4em)
h
}
