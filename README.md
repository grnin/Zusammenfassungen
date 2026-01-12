# Zusammenfassungen BSc Informatik an der OST
Die Zusammenfassungen in diesem Repository sind mit [CC BY-NC-SA 4.0](LICENSE) lizenziert, das heisst, du darfst sie unter folgenden Bedingungen beliebig überarbeiten, erweitern und teilen:
- **Namensnennung:** Bitte gib die Quelle an.
- **Nicht kommerziell:** Du darfst diese Zusammenfassungen oder eigene Zusammenfassungen, die auf diesem Material basieren, nicht *kostenpflichtig* verbreiten.
- **Weitergabe unter gleichen Bedingungen:** Bitte verwende die gleiche oder eine ähnliche Lizenz. 

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

## Zusammenfassungen
Dieses Repo beinhaltet Zusammenfassungen für folgende Fächer:
- [AIFo / AI Foundations](AIFo) 
- [AIAp / AI Applications](AIAp)
- [AlgDat / Algorithmen und Datenstrukturen](AlgDat)
- [AutoSpr / Automaten und Sprachen](AutoSpr)
- [Bsys1 / Betriebssysteme 1](Bsys1)
- [Bsys2 / Betriebssysteme 2](Bsys2)
- [CN1 / Computernetze 1](CN1)
- [ComBau / Compilerbau](ComBau)
- [CPl / C++](CPl)
- [CPlA / C++ Advanced](CPlA)
- [CySec / Cyber Security Foundations](CySec)
- [Dbs1 / Datenbanksysteme 1](DBS1)
- [DigCod / Digitale Codierungen](DigCod)
- [DMI / Diskrete Mathematik für Informatik](DMI)
- [Dsy / Distributed Systems](Dsy)
- [ExEv / Experimentieren und Evaluieren](ExEv)
- [MsTe / .NET Technologien](MsTe)
- [OOP1 / Objektorientierte Programmierung 1](OOP1)
- [OOP2 / Objektorientierte Programmierung 2](OOP2)
- [ParProg / Parallele Programmierung](ParProg)
- [UIP / UI Patterns and Frameworks](UIP)
- [VwlTg / Volkswirtschaft und Technikgeschichte](VWL-TG)
- [WrStat / Wahrscheinlichkeitsrechnung und Statistik](WrStat)