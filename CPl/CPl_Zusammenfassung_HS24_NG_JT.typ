// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "CPl",
  fach-long: "C++",
  semester: "HS24",
  language: "en",
  tableofcontents: (enabled: true, depth: 2, columns: 2),
)

// Compile this file to get the full PDF.
// In "00_CPPR_Settings.typ", you can enable the exam mode
// to use the CPPR Links in the CAMPLA exam environment

// Document-specific settings
#show grid: set par(justify: false, linebreaks: "optimized")

#include "01_Introduction.typ"
#include "02_Values_and_Streams.typ"
#include "03_Sequences_and_Iterators.typ"
#include "04_Functions_and_Exceptions.typ"
#include "05_Classes_and_Operators.typ"
#include "06_Namespaces_and_Enums.typ"
#include "07_Standard_Containers_and_Iterators.typ"
#include "08_STL_Algorithms.typ"
#include "09_Function_Templates.typ"
#include "10_Class_Templates.typ"
#include "11_Heap_Memory_Management.typ"
#include "12_Dynamic_Polymorphism.typ"
#include "13_Initialization_and_Aggregates.typ"
#include "14_Template_Parameter_Constraints.typ"
