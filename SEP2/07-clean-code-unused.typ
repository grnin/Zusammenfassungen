// #import "/src/main.typ" as ta
#import "@local/tanki:0.0.1" as ta

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
    "SEP2 Clean Code Anki Karten mit Typst erstellt in Zusammenfassungen.",
    filename: "sep2-clean-code-cards-typst",
    id: 1234576,
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

= sep2
== 07 clean code
=== solid-principles

// Karten bereits in Anki manuell erstellt und deshalb hier doppelt:

// // Vorwissen
// #add-note-normal(
//   "Explain the open-closed principle", // question
//   "In object-oriented programming, the open-closed principle states <b>\"software entities should be open for extension, but closed for modification\"</b> that is, such an entity can allow its behaviour to be extended without modifying its source code", // answer
//   "", // more info
//   format: ta.template-note,
// )
// #add-note-normal(
//   "Explain the liskov's substitution principle", // question
//   "Derived or child classes must be able to replace their base or parent classes", // answer
//   "", // more info
//   format: ta.template-note,
// )
// #add-note-normal(
//   "Explain the interface segregation principle", // question
//   "This principle applies to interfaces and is similar to the Single Responsibility Principle, focusing on keeping interfaces specific and well-defined. It states that clients should not be forced to depend on methods that are irrelevant to them, avoiding unnecessary dependencies. The goal is to prevent fat interfaces by using multiple small, client-specific interfaces, each with a clear and specific responsibility.", // answer
//   "Example: Customers should receive a menu relevant to their needs (e.g., vegetarian only) instead of a general menu with unnecessary items.
//   Splitting a common menu into smaller, specific ones reduces unnecessary dependencies and minimizes future changes.", // more info
//   format: ta.template-note,
// )
// #add-note-normal(
//   "Explain the dependency inversion principle", // question
//   "Classes should not depend on concrete details but on interfaces (abstractions).", // answer
//   "This way, details can be replaced, which is very beneficial for testing. 
//   The principle has strong synergies with OCP. 
//   Example: Would you solder a lamp directly to the electrical wiring in a wall?", // more info
//   format: ta.template-note,
// )