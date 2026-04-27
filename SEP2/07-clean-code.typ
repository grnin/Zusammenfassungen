// #import "/src/main.typ" as ta
#import "@local/tanki:0.0.1" as ta

/*
Infos zur Nutzung:
- kopiere dieses template.typ
- behalte die Vorlagen und erstelle Karten gemäss der Vorlage unten

```shell
nix develop
# tanki-rs <path-to-typst-file> [typst-args]
tanki-rs example-template.typ
```

Credits: https://github.com/omega-800/tanki

more info:
```shell
nix flake update tanki

typst info
typst compile --format=html --features=html --input=tanki=true example-template.typ

# "No such file or directory":
# nix run github:omega-800/tanki#tanki-rs -- example-template.typ
```
*/

#let (
  deck,
  provide-deck,
  add-note-normal,
  add-note-eintippen,
  add-note-multipleChoice,
  add-note-lueckentext,
) = ta.deck-with-models(
  ta.deck(
    "10 Design Patterns",
    "Example Karten",
    filename: "example-cards",
    id: 123457,
  ),
  ta.model(
    "normal",
    ("Question", "Answer", "more info"),
    (
      (
        "Card 1",
        "Ändere die Karte zu '022 Kartentyp eine Karte, Lösung mehr infos' {{Question}}",
        "{{Answer}} <br /> {{more info}}",
      ),
    ),
  ),
  ta.model(
    "eintippen",
    ("Question", "Answer", "more info"),
    (
      (
        "Card 1",
        "Ändere die Karte zu '022 Kartentyp eine Karte, Lösung mehr infos' {{Question}}",
        "{{Answer}} <br /> {{more info}}",
      ),
    ),
  ),
  ta.model(
    "multipleChoice",
    ("question", "optionA", "optionB", "optionC", "optionD", "optionE", "optionF", "answer", "moreinfo"),
    (
      (
        "Card 1",
        "Ändere die Karte zu '040 multiple choice beautiful' {{question}} <br /> {{optionA}} {{optionB}} {{optionC}} {{optionD}} {{optionE}} {{optionF}}",
        "{{answer}} <br /> {{moreinfo}}",
      ),
    ),
  ),
  ta.model(
    "lueckentext",
    ("Content", "Hint", "Type", "Extra", "Cloze99"),
    // Lückentext so schreiben mit {{c1::hier ist ein Lückentext}}
    (
      (
        "Card 1",
        "Ändere die karte zu enhanced Lückentext {{Content}} <br /> {{Hint}}",
        "{{Cloze99}}",
      ),
    ),
  ),
)

#provide-deck

// Examples:
/*
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
// */

= sep2
== 07 clean code
=== solid-principles
// Vorwissen
#add-note-normal(
  "Explain the open-closed principle", // question
  "In object-oriented programming, the open-closed principle states \"software entities should be open for extension, but closed for modification\"; that is, such an entity can allow its behaviour to be extended without modifying its source code", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Explain the liskov's substitution principle", // question
  "Derived or child classes must be able to replace their base or parent classes", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Explain the interface segregation principle", // question
  "This principle applies to interfaces and is similar to the Single Responsibility Principle, focusing on keeping interfaces specific and well-defined. It states that clients should not be forced to depend on methods that are irrelevant to them, avoiding unnecessary dependencies. The goal is to prevent fat interfaces by using multiple small, client-specific interfaces, each with a clear and specific responsibility.", // answer
  "Example: Customers should receive a menu relevant to their needs (e.g., vegetarian only) instead of a general menu with unnecessary items.
  Splitting a common menu into smaller, specific ones reduces unnecessary dependencies and minimizes future changes.", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Explain the dependency inversion principle", // question
  "", // answer
  "Example: Customers should receive a menu relevant to their needs (e.g., vegetarian only) instead of a general menu with unnecessary items.
  Splitting a common menu into smaller, specific ones reduces unnecessary dependencies and minimizes future changes.", // more info
  format: ta.template-note,
)