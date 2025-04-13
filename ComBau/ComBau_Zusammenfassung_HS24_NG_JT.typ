// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "ComBau",
  fach-long: "Compilerbau",
  semester: "HS24",
  tableofcontents: (enabled: true, depth: 2, columns: 2),
)

// Umfangreiche Zusammenfassung aller Folien
// Für eine Zusammenfassung für die Prüfung siehe
// ComBau_Spick_HS244_NG_JT.typ

#include "01_Laufzeitsystem.typ"
#include "02_EBNF-Syntax.typ"
#include "03_Lexikalische_Analyse.typ"
#include "04_Recursive_Descent_Parser.typ"
#include "05_Alternative_Parsing-Methoden.typ"
#include "06_Semantische_Analyse.typ"
#include "07_Code_Generierung.typ"
#include "08_Code-Optimierung.typ"
#include "09_Virtual_Machine.typ"
#include "10_Objekt-Orientierung.typ"
#include "11_Typ-Polymorphismus.typ"
#include "12_Garbage_Collection_Speicherfreigabe.typ"
#include "13_JIT_Compiler.typ"
