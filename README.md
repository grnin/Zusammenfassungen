# Zusammenfassungen BSc Informatik an der OST
Die Zusammenfassungen in diesem Repository sind mit [CC BY-NC-SA 4.0](LICENSE) lizenziert, das heisst, du darfst sie unter folgenden Bedingungen beliebig überarbeiten, erweitern und teilen:

- **Namensnennung:** Bitte gib die Quelle an.
- **Nicht kommerziell:** Du darfst diese Zusammenfassungen oder eigene Zusammenfassungen, die auf diesem Material basieren, nicht *kostenpflichtig* verbreiten.
- **Weitergabe unter gleichen Bedingungen:** Bitte verwende die gleiche oder eine ähnliche Lizenz. 
Credits: Nina Grässli und Jannis Tschan und Jasmin Fässler (je nach Modul)

### Zusammenfassungen erstellt/bearbeitet von mir (Jasmin)

3. Semester

- [WE1](WE1) neu erstellt
- [MsTe / .NET Technologien](MsTe) beachte auch zusätzliche PDFs zum ausdrucken
- [AlgDat / Algorithmen und Datenstrukturen](AlgDat) Grafiken angepasst, Rechtschreibkorrektur, Inhalt geändert (für mich angepasst)
- [Bsys1 / Betriebssysteme 1](Bsys1) neu strukturiert, Inhalt wenig geändert, bisschen ergänzt
- [WrStat / Wahrscheinlichkeitsrechnung und Statistik](WrStat) kleine Anpassungen/Verbesserungen. Die andere Version für [HP-Prime](WrStat/WrStat-Jasmin-HP-Prime) ist nicht vollständig.
- [CPl / C++](CPl) minimal angepasst

2. Semester

- [OOP2 / Objektorientierte Programmierung 2](OOP2)
- [AutoSpr / Automaten und Sprachen](AutoSpr) ich habe die von NG wenig angepasst
- neu von mir: [Data Engineering](DatEng)

1. Semester

- [OOP1 / Objektorientierte Programmierung 1](OOP1) meine eigene Version und die von NG
- [Dbs1 / Datenbanksysteme 1](DBS1) meine eigene Version und die von NG

Anki Karten (ergänzend zu Vorlesungen) befinden sich im anderen Repo für Zusammenfassungen [Anki Karten](https://github.com/jasmin-f/Studium-Informatik)

Ich habe das Typst Template angepasst, neu gibt es einen Header/Kopfzeile auf jeder Seite.

## Zusammenfassungen Übersicht alle
Dieses Repo beinhaltet Zusammenfassungen für folgende Fächer.

Weitere

- [AIFo / AI Foundations](AIFo)  
- [AIAp / AI Applications](AIAp)

\1.-2. Semester

- [AutoSpr / Automaten und Sprachen](AutoSpr)
- [CN1 / Computernetze 1](CN1)
- [CySec / Cyber Security Foundations](CySec)
- [Dbs1 / Datenbanksysteme 1](DBS1)
- [DigCod / Digitale Codierungen](DigCod)
- [DMI / Diskrete Mathematik für Informatik](DMI)
- [OOP1 / Objektorientierte Programmierung 1](OOP1)
- [OOP2 / Objektorientierte Programmierung 2](OOP2)
- neu: [Data Engineering](DatEng)


\3. Semester

- [AlgDat / Algorithmen und Datenstrukturen](AlgDat)
- [Bsys1 / Betriebssysteme 1](Bsys1)
- [CPl / C++](CPl)
- [MsTe / .NET Technologien](MsTe)
- [WrStat / Wahrscheinlichkeitsrechnung und Statistik](WrStat)
- [ExEv / Experimentieren und Evaluieren](ExEv)
- neu: [WE1 Web Engineering 1](WE1)


\ab 4. Semester

- [ParProg / Parallele Programmierung](ParProg)
- [VwlTg / Volkswirtschaft und Technikgeschichte](VWL-TG)
- [CPlA / C++ Advanced](CPlA)
- [Dsy / Distributed Systems](Dsy)
- [Bsys2 / Betriebssysteme 2](Bsys2)
- [ComBau / Compilerbau](ComBau)




## Einrichtung
Bitte versichere dich, dass du die nötigen Schriften installiert hast:
- [JetBrains Mono](https://www.jetbrains.com/de-de/lp/mono/)
- Calibri (Linux & MacOS-User können den Calibri-Klon [Carlito](https://fonts.google.com/specimen/Carlito) verwenden)

Die Zusammenfassungen aus den Semestern 1-3 wurden mit Word erstellt, die restlichen mit Typst.

Du kannst Typst entweder via die Web App [typst.app](https://typst.app/) verwenden oder lokal mit Plugins im Visual Studio Code
(z.B. [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)).

Solltest du die Web App verwenden, musst du den Ordner des Moduls, die `.typ`-Dateien im Root des Repos und
die oben genannten Schriftarten aus `C:\Windows\Fonts` in dein Typst Projekt hochladen.
Diese werden dann automatisch gefunden.

Da das Repository ziemlich gross ist, und du wahrscheinlich nicht alle Module benötigst, empfiehlt sich ein Sparse Checkout

```sh
# Repo mit ausschliesslich Dateien im Rootverzeichnis klonen (Download kann trotzdem etwas dauern)
git clone --sparse https://github.com/grnin/Zusammenfassungen.git
cd Zusammenfassungen
git sparse-checkout set "ComBau"
# Der entsprechende Ordner ist nun auf deinem Dateisystem! :)
```
