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
    "12 Agile Methodologies continued",
    "SEP2 \"Agile Methodologies continued\" Anki Karten mit Typst erstellt in Zusammenfassungen.",
    filename: "12-sep2-agile-methodologies-typst",
    id: 1234578,
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
== 12-agile-methodologies-continued
#add-note-normal(
  "Can you name three missing parts in Scrum?",
  "Engineering practices, Project Management, Scaling", // more info
  format: ta.template-note
);


#add-note-normal(
  "Can you name at least four PM-tasks in a software development project?", // question
  "- Time Tracking / Time Analysis
  - Cost Tracking / Cost Analysis
  - Monitoring Progress
  - Monitoring Quality
  - Risk Management
  - Negotiation with 3rd party teams
  - Reporting to Management
  - Writing meeting minutes", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "Who is responsible for these PM-Tasks in Scrum?", // question
  "Not defined", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "How can developers support their PM?", // question
  "Define a First officer in the team, translates information to be easily understandable.
  Make the invisible visible: not just numbers but context, use Dashboards", // answer
  "Ideas for making the invisible visible
  - Scrum Board
  - Burndown Charts
  - Velocity Charts
  - Activity in Git (Commits, Pull Requests, …)
  - Build Status
  - Test Status (Amount, Failed, …)
  - Engineering Metrics
  - Analytics and Diagnostics
  - Installations and User Rating (App Stores)", // more info
  format: ta.template-note
)

#add-note-normal(
  "What is an easy way to scale Scrum?", // question
  "Self-made scaling \"Scrum of Scrums\": 3 Project managers instead of 1.
  ", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "Can you name at least two scaling frameworks?", // question
  "- Scrum+ : uses RUP to define phases for Scrum.
  - LeSS (by Craig Larman & Bas Vodde)
  - Nexus (by Ken Schwaber)
  - SAFe
  - Scrum@Scale (by Jeff Sutherland)
  ", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "Can you name at least two principles in Kanban?", // question
  " Principles
    - <b>Start with what you do now</b>
    - <b>Agree to pursue incremental, evolutionary change</b>
    - Respect the current process, roles, responsibilities & titles
    - Encourage acts of leadership at all levels in your organization", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "Can you name at least two practices in Kanban?", // question
  "Practices
    - <b>Visualize</b>
    - <b>Limit WIP</b>
    - Manage Flow
    - Make Process Explicit
    - Implement Feedback Loops
    - Improve Collaboratively, evolve experimentally (using models & the scientific method)", // answer
  "", // more info
  format: ta.template-note
)

#add-note-normal(
  "How is Kanban different from Scrum?", // question
  "
  Scrum
  - <b>Contains roles and artifacts</b>
  - <b>Has iterations of equal length</b>
  - Uses Velocity for planning & improvement
  - Indirect WIP limits (capacity of a sprint)
  - Cross-functional teams required
  - Prioritization done in the Product Backlog
  - Estimates are required
  - Tasks must fit within a single sprint
  - Single process on the task board
  - Board is cleared after every iteration
  
  Kanban
  - <b>No roles and no artifacts</b>
  - <b>Has no iterations</b>
  - Uses Cycle Time for planning & improvement
  - Direct WIP limits (capacity for phases on the board)
  - Cross-functional teams optional
  - Prioritization done by putting into the input-queue
  - Estimates are optional
  - No limits for the size of a task
  - Multiple processes possible on the task board
  - Board only cleared when stopping the project
  ", // answer
  [
    #image("/assets/scrum-kanban.png")
  ], // more info
  format: ta.template-note
)
