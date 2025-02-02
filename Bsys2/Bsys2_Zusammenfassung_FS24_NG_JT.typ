// Compiled with Typst 0.12
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "BSys2",
  fach-long: "Betriebssysteme 2",
  semester: "FS24",
  tableofcontents: (enabled: true, columns: 2, depth: 2),
  language: "de",
)

// Umfangreiche Zusammenfassung aller Folien
// Für eine Zusammenfassung für die Prüfung siehe
// Bsys2_Spick_FS24_NG_JT.typ

#include "01_Betriebssystem_API.typ"
#include "02_Dateisystem_API.typ"
#include "03_Prozesse.typ"
#include "04_Programme_Bibliotheken.typ"
#include "05_Threads.typ"
#include "06_Scheduling.typ"
#include "07_Mutexe_Semaphore.typ"
#include "08_Signale_Pipes_Sockets.typ"
#include "09_Message_Passing.typ"
#include "10_Ext2_Unicode.typ"
#include "11_Ext4.typ"
#include "12_X_Window_System.typ"
#include "13_Meltdown.typ"
