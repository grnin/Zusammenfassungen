// Set this to true to enable access to the offline copy of CPP Reference
// within the CAMPLA exam environment. MS Edge and Adobe Acrobat can open "file:" links in PDF
#let EXAM_MODE = false
#let CPPR_ROOT = if EXAM_MODE { "file://C:/cppreference/reference/en/cpp/" } else { "https://en.cppreference.com/w/cpp/" }

#let cppr(url, body) = {
  return underline(link(CPPR_ROOT + url + ".html", body))
}
