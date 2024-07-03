// Helper functions
// (C) 2024, Nina Grässli, Jannis Tschan

#let number-format(n, chunks, num-suffix) = {
  box(
    str(n)
    .replace(regex("\s"), "")             // remove whitespace from string
    .codepoints()                         // get the individual digits
    .rev()                                // reverse digits so that the MSB gets put in the last chunk
    .chunks(chunks)                       // create groups of digits
    .map(it => $mono(#it.join().rev())$)  // join & format digits in chunk & reverse so the MSB within a chunk is in front
    .rev()                                // un-reverse so the MSB is in front again 
    .join($thin$) + sub[#num-suffix]      // join the groups together with a small space & add suffix
  )
}

#let bits(n, suffix: true) = {
  number-format(n, 4, if(suffix) { "b" } else { "" })
}

#let hex(n, suffix: true) = {
  number-format(n, 2, if(suffix) { "h" } else { "" })
}
