// #import "/src/main.typ" as ta
#import "@local/tanki:0.0.1" as ta

/*
Infos zur Nutzung:
- kopiere dieses template.typ
- behalte die Vorlagen und erstelle Karten gemäss der Vorlage unten
- ändere Kartentyp/notetype in Anki

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

Image sources:
- lecture slides (Gang of Four Design Patterns, Head First Design Patterns)
- cheatsheet design patterns cards (dpc) : https://mcdonaldland.info/2007/11/28/40/

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
    "SEP2 Design Patterns Cards",
    filename: "sep2-design-patterns-cards-typst",
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

= sep2, knowledge-assessment
== 10-design-patterns
=== Fundamentals
#add-note-normal(
  "What is a Design Pattern?", // question
  "A design pattern is a typical solution to a common problem in programming. Independent of programming languages but some are limited to programming paradigms, e.g. OOP.", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "Is it possible to apply Design Patterns out-of-the-box?", // question
  "No, design patterns are not ready-to-use. ", // answer
  "But some programming languages support for example the Observer Pattern out of the box.", // more info
  format: ta.template-note
)

#add-note-normal(
  "What are the differences between Design Patterns and a Design Principles?", // question
  "Design patterns are examples based on the advice by design principles.", // answer
  "Design Patterns : Examples of how to build software with good OO-qualities, taking the design principles into consideration. (efficient vocabulary, generic solutions, clear/honest but not the solution for every problem)
  Design Principles: Advice and best practices on how to build reusable, extensible and maintainable OO-software. For example SOLID principles.", // more info
  format: ta.template-note
)

#add-note-eintippen(
  "What are the GoF-Design Patterns?", // question
  "", // answer
  "", // more info
  format: ta.template-note
)

=== Behavioral Patterns
// Observer, State, Strategy and Template Method
// more: Chain of Responsibility, Command, Interpreter, Iterator, Mediator, Memento, Visitor
// Observer, Publisher Subscriber

#add-note-normal(
  "Observer Pattern: Can you give an example what it is used for?", // question
  "Weather Station, sensor API to different UI's", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Observer Pattern:  Can you draw a diagram and explain the main components and its interactions?", // question
  // ADD IMAGES
  // "", // answer 
  [
    #image("assets/dpc-observer.png")
    #image("/assets/image.png");\
    #image("./assets/observer.png");\
    #image("./assets/image.png");\
  ],
  "", // more info
  format: ta.template-note,
)

#add-note-normal(
  "State Pattern: Can you give an example what it is used for?", // question
  "Managing states of a class, example Partner Simulator", // answer
  "Differences to a State Machine: it focuses on behaviour while being in a state but the state machine focuses on the action during a transition", // more info
  format: ta.template-note
)
#add-note-normal(
  "State Pattern:  Can you draw a diagram and explain the main components and its interactions?", // question
  // ADD IMAGES
  // "", // answer 
  [
    #image("assets/dpc-state.png")\
    #image("./assets/image-1.png")\
  ],
  "", // more info
  format: ta.template-note,
)

#add-note-normal(
  "Strategy Pattern: Can you give an example what it is used for?", // question
  "Define different Behaviours for different ducks", // answer
  "Similar but not equal to Template Method and State Pattern.", // more info
  format: ta.template-note
)
  
#add-note-normal(
  "What is the problem with the original duck pond game, not complied to which design principles?", // question
  // ADD IMAGE
  "Liskov's Substitution Principle, Encapsulate what varies (with SRP and OCP), Favor Composition over Inheritance (FCoI) (because inheritance has more coupling, composition makes unit testing easier + adoption at runtime)", // answer
  [
  #image("./assets/image-2.png");\
  ],
  // "", // more info
  format: ta.template-note
)

#add-note-normal(
  "Strategy Pattern:  Can you draw a diagram and explain the main components and its interactions?", // question
  // "", // answer 
  // ADD IMAGE
  [
  #image("assets/dpc-strategy.png")\
  #image("./assets/image-3.png");\
  #image("./assets/image-4.png");\
  ],
  "", // more info
  format: ta.template-note,
)

#add-note-normal(
  "Template Method Pattern: Can you give an example what it is used for?", // question
  "For example when you have two classes (algorithms) that do almost exactly the same thing. Quicksort and Bubblesort class.", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Template Method Pattern:  Can you draw a diagram and explain the main components and its interactions?", // question
  // "", // answer 
  // ADD IMAGE
  [
  #image("assets/dpc-template-method.png")\
  #image("./assets/image-6.png");\
  #image("./assets/image-7.png");\
  ],
  "", // more info
  format: ta.template-note,
)


=== Creational Patterns
#add-note-normal(
  "Abstract Factory : Can you give an example what it is used for?", // question
  "", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Abstract Factory : Can you draw a diagram and explain the main components and its interactions?", // question
  "", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Factory Method : Can you give an example what it is used for?", // question
  "", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Factory Method : Can you draw a diagram and explain the main components and its interactions?", // question
  "", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Singleton : Can you give an example what it is used for?", // question
  "", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Singleton : Can you draw a diagram and explain the main components and its interactions?", // question
  "", // answer
  "", // more info
  format: ta.template-note
)

=== Structural Patterns

#add-note-normal(
  "Adapter : Can you give an example what it is used for?", // question
  "", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Adapter : Can you draw a diagram and explain the main components and its interactions?", // question
  "", // answer
  [
    #image("assets/dpc-adapter.png")
  ], // more info
  format: ta.template-note,
)

#add-note-normal(
  "Decorator : Can you give an example what it is used for?", // question
  "", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Decorator : Can you draw a diagram and explain the main components and its interactions?", // question
  "", // answer
  "", // more info
  format: ta.template-note,
)

#add-note-normal(
  "Facade : Can you give an example what it is used for?", // question
  "", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Facade : Can you draw a diagram and explain the main components and its interactions?", // question
  "", // answer
  "", // more info
  format: ta.template-note,
)

#add-note-normal(
  "Proxy : Can you give an example what it is used for?", // question
  "", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Proxy : Can you draw a diagram and explain the main components and its interactions?", // question
  [
    #image("assets/dpc-proxy.png")
  ], // answer
  "", // more info
  format: ta.template-note,
)

// === -
// Match the Pattern to their category
// Behavioral Patterns : Observer, State, Strategy and Template Method,   Chain of Responsibility, Command, Interpreter, Iterator, Mediator, Memento, Visitor
//  not in GOF: 
      // Null Object 
      // Dependency Injection (Depend on abstractions, not concretions (DIP – Dependency Inversion Principle))
        // #image("./assets/image-5.png")
        // Inner Rings: Interface and Client
        // • Outer Rings: Service and Injector 
        // häufig genutzt in frameworks für libraries
// Creational : Abstract Factory, Factory Method, Singleton,    Builder, Prototype
// Structural : Adapter, Decorator, Facade, Proxy,    Bridge, Composite, Flyweight