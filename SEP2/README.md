## SE Practices 2

András Tarlós, Jasmin Fässler | FS 2026

## TODOs
- Kanban Bild bei 12-agile.. wirft Fehler beim Export, eventuell ist die Datei zu gross?
- html <b></b> funktioniert nicht
- automatisch den korrekten Kartentyp mit Styling
- "Multiple choice beautiful" Kartentyp mit JS
- Zeilenumbruch mit \ soll funktionieren 


## Anki Karten

Die meisten Karten sind nur als .akpkg verfügbar.
Die Karten zu Woche 10 Design Patterns wurden mit Typst erstellt.

## Typst Karten

### Infos zur Nutzung und Beispiele

- kopiere das template.typ
- behalte die Vorlagen und erstelle Karten gemäss den Beispielen:
- Es gibt .vscode Snippets für alle Karten

```typ
// Examples:
#add-note-multipleChoice(
  "Was besagt Moore's Law (Moores Gesetz)?", // question
  "Die Anzahl der Transistoren auf einem Mikrochip verdoppelt sich alle 18 Jahre", // A
  "Die Anzahl der Transistoren auf einem Mikrochip verdoppelt sich etwa alle zwei Jahre.", // B
  "Die Kosten für die Herstellung von Transistoren verdoppeln sich alle 24 Monate.", // C
  "Die Leistung von Computerprozessoren verdoppelt sich alle 18 Monate.", // D
  "", // E
  "", // F
  "B", // correct answers, example "A" or multiple "ABC"
  "", // moreinfo
  format: ta.template-note,
)

#add-note-normal(
  "Beschreiben Sie, wie ein 51%-Angriff auf eine Kryptowährungsbörse ablaufen könnte.", // Question
  "hier steht eine Beschreibung", // Answer
  "", // more info
  format: ta.template-note,
)

#add-note-lueckentext(
  "Nennen Sie 4 Transparenzprinzipien in verteilten Systemen, und beschreiben Sie in einem Satz was es ist.

  1. Zugriffstransparenz: {{c1::Systemverborgene Details sind für Nutzer unsichtbar.}}

  2. Fehlertoleranztransparenz: {{c1::Fehler werden vor Nutzern verborgen. }}

  3. Skalierungstransparenz: {{c1::Nutzer merken Skalierung nicht. }}

  4. Parallelitätstransparenz: {{c1::Parallelverarbeitung ist für Nutzer unsichtbar.}}",
  "", // Hint
  "", // Type
  "", // Extra
  "", // Cloze99
  format: ta.template-note,
)
```

### Export

(das initiale Installieren von tanki-rs dependencies dauert möglicherweise eine Weile)

```shell
nix develop
# tanki-rs <path-to-typst-file> [typst-args]
tanki-rs example-template.typ
```

Credits: https://github.com/omega-800/tanki

### Weitere Informationen

```shell
nix flake update tanki

typst info
typst compile --format=html --features=html --input=tanki=true example-template.typ

# "No such file or directory":
# nix run github:omega-800/tanki#tanki-rs -- example-template.typ
```
