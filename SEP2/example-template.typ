// #import "/src/main.typ" as ta
#import "@local/tanki:0.0.1" as ta

/*
Infos zur Nutzung im README.md
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
    "Example",
    // <div style="display:flex; justify-content:center;">
    //   <p>
    //   Hallo :) 
    //   Viel Erfolg beim Lernen, wenn du eine Karte nicht verstehst nutze die "Aufschieben" oder "Ausschliessen" Funktion.
    
    //   <strong>Empfehlung:</strong> alle Karten ausschliessen (suspend) und manuell nach jeder Vorlesung die Karten mit bekannten Themen wieder anzeigen lassen (toggle suspend). Zum filtern wurden Schlagwörter/Tags erstellt.
    
    //   Kontakt: <a href="https://jasmin-faessler.ch/" target="_blank">https://jasmin-faessler.ch/</a>
    //   </p>
    //   </div>
    "
      Hallo :) 
      Viel Erfolg beim Lernen, wenn du eine Karte nicht verstehst nutze die \"Aufschieben\" oder \"Ausschliessen\" Funktion.

      Empfehlung: alle Karten ausschliessen (suspend) und manuell nach jeder Vorlesung die Karten mit bekannten Themen wieder anzeigen lassen (toggle suspend). Zum filtern wurden Schlagwörter/Tags erstellt.

      Kontakt: www.jasmin-faessler.ch
    ",
    filename: "example-cards",
    id: 123457,
  ),
  ta.model(
    "normal",
    ("question", "answer", "more info"),
    (
      (
        "Card 1",
        "Ändere die Karte zu '022 Kartentyp eine Karte, Lösung mehr infos' {{question}}",
        "{{answer}} <br /> {{more info}}",
      ),
    ),
  ),
  ta.model(
    "eintippen",
    ("question", "answer", "more info"),
    (
      (
        "Card 1",
        "Ändere die Karte zu '022 Kartentyp eine Karte, Lösung mehr infos' {{question}}",
        "{{answer}} <br /> {{more info}}",
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
// /*

= Module-Name // will add anki tag Module-Name
== topic or week // will add anki tag Module-Name::topic-or-week

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
  "Beschreiben Sie, wie ein 51%-Angriff auf eine Kryptowährungsbörse ablaufen könnte.", // question
  "hier steht eine Beschreibung", // answer
  [
    #image("./assets/image.png");\
  ], // more info with image example
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