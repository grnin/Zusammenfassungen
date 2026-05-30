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
    "SEP2 Design Patterns Anki Karten mit Typst erstellt in Zusammenfassungen.",
    filename: "sep2-design-patterns-cards-typst",
    id: 1234579,
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
  "<b>4 Behavioral Patterns</b> 
  Observer, State, Strategy and Template Method \
  <b>3 Creational Patterns</b>
  Factory Method, Abstract Factory and Singleton \
  <b>4 Structural Patterns</b>
  Adapter, Facade, Decorator and Proxy", // answer
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
  [
    #image("./assets/dpc-observer.png");\
    #image("./assets/observer.png");\
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
  [
    #image("./assets/dpc-state.png")\
  ],
  [
    #image("./assets/code-state.png")\
  ], // more info
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
  "Liskov's Substitution Principle, Encapsulate what varies (with SRP and OCP), Favor Composition over Inheritance (FCoI) (because inheritance has more coupling, composition makes unit testing easier + adoption at runtime)", // answer
  [
    #image("./assets/strategy-ducks-bad.png");\
  ],
  format: ta.template-note
)

#add-note-normal(
  "Strategy Pattern:  Can you draw a diagram and explain the main components and its interactions?", // question
  [
  #image("./assets/dpc-strategy.png")\
  #image("./assets/strategy.png");\
  #image("./assets/code-strategy.png");\
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
  [
  #image("./assets/dpc-template-method.png")\
  #image("./assets/template-method-grafik.png");\
  #image("./assets/template-method.png");\
  ],
  "", // more info
  format: ta.template-note,
)


=== Creational Patterns
#add-note-normal(
  "Abstract Factory : Can you give an example what it is used for?", // question
  "It's a strategy for creating objects: 
  - with hardcoded values
  - with read from a database
  - with read from a webservice", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Abstract Factory : Can you draw a diagram and explain the main components and its interactions?", // question
  [
    #image("./assets/dpc-abstract-factory.png")
  ], // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Factory Method : Can you give an example what it is used for?", // question
  "Dice Game: instead of new Dice() create Dice with CreateDice() Factory Method.", // answer
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Factory Method : Can you draw a diagram and explain the main components and its interactions?", // question
  [
    #image("./assets/factory-method.png")
  ], // answer
  
  "", // more info
  format: ta.template-note
)
#add-note-normal(
  "Singleton : Can you give an example what it is used for?", // question
  "No example, replace it with another alternative design pattern.", // answer
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
  "Duck and Turkey class or Power Adapter from Switzerland to United States", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Adapter : Can you draw a diagram and explain the main components and its interactions?", // question
  "", // answer
  [
    #image("./assets/dpc-adapter.png")
  ], // more info
  format: ta.template-note,
)

#add-note-normal(
  "Decorator : Can you give an example what it is used for?", // question
  "For debugging, add additonal responsibilites to an object dynamically.", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Decorator : Can you draw a diagram and explain the main components and its interactions?", // question
  [
    #image("./assets/decorator.png")
  ], // answer
  "", // more info
  format: ta.template-note,
)

#add-note-normal(
  "Facade : Can you give an example what it is used for?", // question
  "Solve the problem of using a legacy library. Example with Hotel Receptionist. Facade defines a higher-level interface that makes the subsystem easier to use.", // answer
  "", // more info
  format: ta.template-note,
)
#add-note-normal(
  "Facade : Can you draw a diagram and explain the main components and its interactions?", // question
  [
   #image("/assets/facade.png")
   #image("/assets/dpc-facade.png") 
  ], // answer
  "", // more info
  format: ta.template-note,
)

#add-note-normal(
  "Proxy : Can you give an example what it is used for?", // question
  "Example: Feed reader with Feeds, Loading and Finished.
  A surrogate or placeholder object to control access to it.", // answer
  "Different types of proxy: Caching Proxy, Remote Proxy, Virtual Proxy, Protection Proxy and more.", // more info
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



=== Important Non-GoF Patterns
#add-note-normal(
  "What is \"Dependency Injection\"?", // question
  "Get rid of all inheritance and inject the full behavior using the construct (is constructor injection).", // answer
  [
    #image("/assets/dependency-injection-simple.png") \
    #image("/assets/dependency-injection.png") \
  ], // more info
  format: ta.template-note
)

#add-note-normal(
  "Why is Dependency Injection important for decoupling code?", // question
  "Depend on abstractions, not concretions", // answer
  "(DIP - Dependency Inversion Principle). Often combined with Strategy Pattern.", // more info
  format: ta.template-note
)

#add-note-normal(
  "What can a Null Object be used for?", // question
  "Useful to get rid of null-checks and the risk of NullPointerException", // answer
  "Classes implementing an interface with empty methods are called Null Objects. 
  In the Duck Pond Game 2.0 from Strategy, we had two of them: Mute and NoneFlying.", // more info
  format: ta.template-note
)

#add-note-normal(
  "With what Design Pattern(s) is the \"Null Object\" typically combined with?", // question
  "Useful for strategy pattern, so no conditionals are required if behaviour is not implemented.", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "What is the difference between the \"Simple Factory\" and the \"Abstract Factory\"?", // question
  "Abstract Factory is GoF Design Pattern, it's a scaled-up factory which creates multiple related Objects. \
  Simple Factory is not from GoF, it is the \"normal\" factory. A strategy for creating objects.", // answer
  "", // more info
  format: ta.template-note
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

=== self-made questions

#add-note-normal(
  [What Design Pattern(s) is this using?],
  "",
  "",
  format: ta.template-note
)