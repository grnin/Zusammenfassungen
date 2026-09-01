// Compiled with Typst 0.14.2
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "AppArch",
  fach-long: "Application Architecture",
  semester: "HS25",
  language: "en",
  tableofcontents: (enabled: true, columns: 2, depth: 2),
)

#set table(columns: (1fr, 1fr))
#show table.cell: set par(justify: false)

//#let cell-tilde = table.cell(align: center, text(size: 1.6em, fill: color.yellow, weight: "bold", sym.tilde.basic))

= Requirements & Context
Software Architecture can be defined in different ways with different emphasis. The most concise definition is by _ISO
42010:_
#v(-1em)
#quote[
  The fundamental organization of a system is embodied in its _components_, their _relationships_ to each other, and to
  the environment, and the _principles_ guiding its design and evolution.
]
_Or in short:_ How different pieces work together and what principles for further developments are in place. Software
architecture is used to improve maintainability, scalability and collaborative work in a software project.

*Difference between IT-, Software- and Application Architecture:*
- _IT_ is the _most general_ #hinweis[(hardware and software)]
- _Software_ is the _high-level structure_ #hinweis[(independent of actual technologies, microservices vs. monoliths,
    NFRs, interoperability etc.)]
- _Application_ is the _logical design_ of a software #hinweis[(actual technologies, design patterns, UX,
    dependencies)].

Application architecture is a _subset_ of Software architecture. A _Software Architect_ needs to understand
requirements, acts as a mediator between stakeholders and must make technology decisions with foresight.


*Design Challenges on Enterprise Software Projects*
- _User and channel diversity:_ Different actors, data/request volumes, technologies
- _Process and resource integrity:_ Data and processes must be trustable
- _Integration needs due to heterogeny:_ Software must integrate in different systems with different data formats
- _Complex data/domain models and processing rules:_ Implement business rules in a maintainable way

*The 10 Keys to Success*\
Define what successful Architects should consider in their work.
#definition[
  + _Understand end-to-end development:_ Follow a repeatable process to get the output of a task
  + _Understand your role:_ Architects must review existing architecture, share knowledge with peers and communicate the
    value of their solutions
  + _Manage risk & change:_ Derive architectures iteratively via abstract-and-refine
  + _Communicate with stakeholders:_ Document architectures to capture design analysis and results, preserve the reasons
    behind decisions
  + _Reuse assets:_ Use different types of assets that already exist and apply them
  + _Right-size your involvement:_ Select relevant viewpoints, hide unnecessary details
  + _Influence the requirements:_ Ensure tradeoffs are negotiated, predict system behavior and time/cost of development
  + _Derive solutions from business needs:_ Design architectures based on the business you're building the application
    for
  + _Refine solutions based on technology:_ Specify technical designs and guide development
  + _Appreciate the broader context:_ Align your work with the bigger picture, document the system context

]


== Requirement modelling strategies
Good requirements for software projects _address the needs of the stakeholders_. The following models try to give you
guidance on how to formulate such requirements.

=== Architecturally significant requirement (ASRs) <asr>
Requirements that are architecturally significant have a _measurable effect_ on an architecture. They help to prioritize
technical issues or requirements quickly, so that architecturally significant issues are addressed at their most
responsible moments.\
To _determine_ if an issue might be _significant_, we can check if it addresses one of the following topics:
#v(-0.3em)
#grid(
  columns: (1fr,) * 3,
  [
    - Number of users
    - Availability
    - Lifetime
  ],
  [
    - Extendability
    - Regulations
    - Laws
  ],
  [
    - Safety
    - Security
  ],
)

A _more detailed approach_ is the _ASR Test_ #hinweis[(The points six and seven are very subjective)].

#definition[
  + *RC-1 -- High Business Value and/or Risk:* The requirement is _directly associated_ with it.
  + *RC-2 -- Stakeholder Concern:* The requirement is a concern of a particularly _important stakeholder_\
    #hinweis[(for instance, the project sponsor or an external compliance auditor)].
  + *RC-3 -- QoS:* The requirement has runtime _Quality-of-Service (QoS) characteristics_ #hinweis[(e.g., performance
      needs)] that _deviate_ from those already satisfied by the evolving architecture _substantially_.
  + *RC-4 -- External Dependencies:* The requirement causes _new_ or deals with one or more existing external
    _dependencies_ that have _unpredictable_, _unreliable_ and/or _uncontrollable_ behaviour.
  + *RC-5 -- Cross-Cutting:* The requirement has a cross-cutting nature and therefore _affects multiple parts of the
    system_ and their interactions; it may even have system-wide impact.
  + *RC-6 -- First-of-a-kind:* The requirement has a first-of-a-kind character: e.g., the team has _never built a
    component_ that _satisfies_ this particular requirement.
  + *RC-7 -- Past Problems:* The requirement has been _troublesome_ and _caused critical situations_, _budget overruns_
    or _client dissatisfaction_ in a previous project in a similar context.
]

==== Example of a ASR Test
The following paragraph gives an _example analysis_ of _requirements_ regarding their _architectural significance_. A
single requirement is mapped to the different points. Make sure to always _justify the answers_ in order to make them
understandable. The score is either Low #hinweis[(L)], Medium #hinweis[(M)] or High #hinweis[(H)].
/*#table(
  columns: (2fr, 1fr, 1fr, 5fr),
  table.header([Requirement], [Score], [Mapping], [Explanation]),
  [Autoscaling for Spinnaker microservices running on Kubernetes],
  [High (h)],
  [RC-2, RC-3, RC-4, (RC-7)],
  [
    - Auto scaling may have an impact on the billing, so external stakeholder are affected #hinweis[(cloud provider)]
    - Scalability is a key quality attribute
    - Dependency on 3rd party software
    - Autonomous system behavior has been reported to be hard to test and maintain due to number of external stimuli and time dependency
  ],
)*/

#table(
  columns: (1.7fr, auto, 1.5fr, 2fr),
  table.header([Requirement], [Score], [Mapping], [Explanation]),
  [
    *Dynamic and fair pricing engine*: #hinweis[The platform must provide a controllable but dynamic pricing system. It
      should suggest fair prices based on existing games and data (e.g. usage). However, it should be possible to
      respect the wishes of game developers and allow for dynamic and automated adjustments based on usage and demand.]
  ],
  [H],
  [
    - RC-1 #hinweis[(important part of business model and revenue)]
    - RC-2 #hinweis[(important for multiple stakeholders, namely the developers as well as the gamers)]
    - (RC-4) #hinweis[(might need external libraries, AI tools?, or data sources)]
  ],
  [
    Pricing influences business model and revenue; affects many components #hinweis[(checkout, listing,
      recommendation)]. External data dependencies and correctness requirements make it architecturally significant.
  ],

  [
    *Age & Payment Compliance:* #hinweis[The platform must ensure compliance with age restrictions and safe in-game
      purchase flows (no dark patterns, parental controls).]
  ],
  [H],
  [
    - RC-1 #hinweis[(legal/business stakeholders)]
    - RC-2 #hinweis[(user-visible)]
    - RC-4 #hinweis[(regulatory dependencies, 3rd-party payment providers)]
  ],
  [
    Legal/regulatory impact #hinweis[(age verification, payment compliance)] creates business risk and may block the
    service in jurisdictions — high priority.
  ],

  [
    *Discovery/Search & Recommendations:* #hinweis[Gamers must be able to discover games via search, filters and
      personalized recommendations within acceptable latency.]
  ],
  [M-H],
  [
    - RC-2 #hinweis[(user experience)]
    - RC-3 #hinweis[(performance / scale)]
  ],
  [
    Core to product value #hinweis[(finding games)]; quality affects retention. If personalization is central,
    architectural patterns #hinweis[(indexing, ML infra)] are required.
  ],

  [
    *Community Features:* #hinweis[The platform should allow gamers to write short public reviews and give star ratings
      for games.]
  ],
  [L-M],
  [
    - Maybe RC-1 #hinweis[(stakeholder concern)], but secondary
    - Partially RC-2 #hinweis[(user-visible behavior)], but doesn't affect critical flows
  ],
  [
    Reviews and ratings can enhance user engagement and discovery, but they are not mission-critical to the business
    model or compliance. They can be added incrementally, with well-known architectural solutions #hinweis[(e.g., simple
      CRUD + moderation pipeline)].
  ],
)

=== Architectural Significance of Decisions
The following questions can be used to classify _the architectural significance of decisions_ that justify whether and
how a requirement or other concern is met:

#definition[
  + Is the decision _hard to change_ later?
  + Is the decision _expensive_ to _implement/execute_ upon?
  + Are _demanding qualitative requirements_ stated? #hinweis[(e.g. high security level, high availability, high
      performance)]
  + Are requirements _difficult to map_ to existing solutions, experiences?
  + Is the _experience_ #hinweis[(of the team)] in the solution space _weak_?
]

=== ISO-25010 Software Product Quality <iso-25010>
Most management models base their quality attributes on ISO 25010. It has _nine characteristics_ with several
attributes. NFRs are usually built around these categories. Shown below is the 2023 version of the standard.
#align(image("img/iso-25010.png", width: 86%), center)

=== FURPS
FURPS provides a way to define requirements by non-functional stories, and also provides a good way to categorize such
needs. The requirements generated by FURPS are called _Architectural Significant Requirements (ASR)_ and are often
assigned an ID.
#definition[
  - *Functionality:* Represents the _main product features_ that are familiar within the business domain of the solution
    being developed. The functional requirements can also be very _technically oriented_. #hinweis[(FR)]
  - *Usability:* Includes looking at, capturing, and stating requirements based around _user interface issues_. Things
    such as _accessibility_, _interface aesthetics_, and _consistency_ within the user interface #hinweis[(NFR)]
  - *Reliability:* Includes aspects such as _availability_, _accuracy_, and _recoverability_. #hinweis[(NFR)]
  - *Performance:* Involves things such as _throughput of information_ through the system, _system response time_,
    _recovery time_, and _start-up time_. #hinweis[(NFR)]
  - *Supportability:* Here a number of other requirements can be specified, such as _testability_, _adaptability_,
    _maintainability_, _compatibility_, _configurability_, _installability_, _scalability_, _localizability_, and so on.
    #hinweis[(NFR)]

  _FURPS+_ also includes design constraints, implementation constraints, physical constraints and interface constraints.
]

But FURPS does have its problems, see Chapter @arc-viewpoints.

==== Example of FURPS+ <furps-example>
/*#table(
  columns: (auto, 1fr),
  table.header([Criteria], [Description]),
  [*Functionality*],
  [
    As a DevOps practitioner, I want to be able to configure, construct, and manage Continuous Delivery workflows for my company so that we can develop, test, and deliver software and release software changes with high velocity and confidence.
  ],

  [*Usability*],
  [
    The creation of a medium complex pipeline-and-stages setup for a CD workflow should not take more than 10 minutes on average for any user who has successfully completed the one-hour online tutorial.
  ],

  [*Reliability*],
  [
    As we perform nightly builds and release on weekends, the system must be available 24/7.
  ],

  [*Performance*],
  [
    The user interface that allows the configuration, construction, and management of Continuous Delivery workflows should respond in 3 to 5 seconds under normal conditions (network availability, etc.); in the remaining cases, user requests should still be processed correctly without data loss.
  ],

  [*Supportability*],
  [
    All components should be straightforward to change and replace.
  ],
)*/

#table(
  columns: (auto, 1fr),
  table.header([Criteria], [Description and Rationale]),
  [*Functionality\ (ASR-F1)*],
  [
    As a market operator, I want the platform to provide a pricing system that suggests fair prices based on game usage
    data, comparable market titles, and demand signals, while allowing developers to set their own preferred price
    ranges and apply manual corrections. The system shall combine automated adjustments #hinweis[(e.g., demand-driven)]
    with developer-defined constraints, so that developers can override or restrict automated changes, and buyers always
    see a consistent and transparent final price at checkout.\
    *Rationale / Significance:* Pricing is central to the business model and touches listing, checkout, analytics, and
    legal auditing.
  ],

  [*Usability\ (ASR-U1)*],
  [
    A new developer should be able to create a developer account, publish a game with pricing rules and see the first
    price suggestion in the dashboard within 15 minutes after completing the guided onboarding #hinweis[(including
      verification steps)]. The pricing UI must show a clear explanation of any dynamic adjustments #hinweis[(source,
      timestamp, confidence)] inline next to suggested prices.\
    *Rationale / Significance:* Low onboarding friction and transparent pricing are differentiators. UI + backend audit
    APIs must present explanatory metadata; this affects API design, audit logs, and front- end UX.
  ],

  [*Reliability\ (ASR-R1)*],
  [
    All purchase flows that require age verification or payment processing must succeed end-to-end 99.95% of the time
    measured monthly #hinweis[(excluding scheduled maintenance windows)]. Failures of those flows must not cause
    inconsistent financial states #hinweis[(no partial charge without final confirmation)] and must be recoverable
    within 1 hour #hinweis[(automated compensation or manual operator workflow)].\
    *Rationale / Significance:* Compliance and money flows are high-risk; correctness and recoverability strongly impact
    architecture #hinweis[(transaction management, distributed sagas, compensations, monitor- ing)].
  ],

  [*Performance\ (ASR-P1)*],
  [
    Under normal operation #hinweis[(up to 100k concurrent active sessions)], the search & recommendations service shall
    return results within 350 ms #hinweis[(95th percentile)] for typical queries; during promotional peaks #hinweis[(up
      to 1M concurrent active sessions)], tail latency #hinweis[(99th percentile)] should remain below 1.5 seconds for
    cached queries and below 3 seconds for cold queries.\
    *Rationale / Significance:* Discovery affects retention; sets constraints on caching, indexing, and autoscaling.
  ],

  [*Supportability\ (ASR-S1)*],
  [
    Each major backend service #hinweis[(Pricing, Search, Payment, User Management, Telemetry)] must expose standard
    health endpoints, structured logs (JSON), and traced spans #hinweis[(distributed tracing)]. Any such service must be
    independently deployable and replaceable without requiring coordinated downtime of other services
    #hinweis[(backward-compatible APIs for at least two major API versions)].\
    *Rationale / Significance:* Supportability requirements enable safe evolution, debugging, and operational
    resilience; they constrain API versioning and CI/CD strategies.
  ],
)
#pagebreak()
=== SMART NFRs
The _SMART criteria_ are frequently used in _project and people management_ but can also be applied to _Non-Functional
Requirement_ engineering. In this case, only _S_ and _M_ are used. The _A_, _R_ and _T_ are more likely the concern of
project management.

#definition[
  + *Specific:* Which _feature_ or part of the system #hinweis[(component or user story)] should _satisfy_ the
    requirement? Not all features need the same availability, not all quality properties are as cross-cutting as
    security.
  + *Measurable:* How can testers and other stakeholders _find out whether the requirement is met or not_? Is the
    requirement _quantified_? May include _monitoring_ the requirement throughout the project.
  + *Agreed upon:* The goal must be _realistic_, _achievable_ and have a _consent_ in the team.
  + *Relevant/Realistic:* One must be aware of _why_ this should be achieved.
  + *Time-Bound:* There should be a _clearly defined timeline_, including a starting date and a target date.
]

==== Example of a SMART Test
The ASRs from @furps-example are tested to check whether they are _Specific_ and _Measurable_.
/*#table(
  columns: (1fr, auto, auto),
  table.header([NFR], [S(pecific)], [M(easurable)]),
  [
    "Die Antwortzeit im Windows Rich Client der Anwendung darf 5 Sekunden nicht überschreiten in 90% aller Use Case Walkthroughs; in den verbleibenden 10% der Fälle erfolgt die Antwort innerhalb von 10 Sekunden."
  ],
  [Yes],
  [Yes],

  [
    "Auf hohe Wartbarkeit der Implementierung des Use Cases „Create Customer Claim“ (dt. Schadensmeldung durch Kunde) in der neuen Insurance Claim Management Anwendung legen wir als Entwicklungsteam grossen Wert."
  ],
  [Yes\ #hinweis[(Use case is named)]],
  [No],
)*/
#table(
  columns: (auto, auto, auto, 1fr, 1fr),
  table.header([ASR-ID], [S?], [M?], [Rationale], [Suggested Improvements]),
  [ASR-F1],
  cell-check,
  cell-check,
  [Defines scope #hinweis[(pricing system, developer control)] and includes a measurable target #hinweis[(5s)].],
  [Clarify override handling. #hinweis[(e.g., "Developer changes applied within 1 minute, with audit log.")]],

  [ASR-U1],
  cell-check,
  cell-cross,
  [Clear actor/task #hinweis[(developer publishes and sells)], but "soon after joining" is vague.],
  [Add time target #hinweis[(e.g., "First sale visible in dashboard within 15 minutes of onboarding completion.")]],

  [ASR-R1],
  cell-check,
  cell-check,
  [Very concrete: 99.95% success and 1h recovery],
  [Define monitoring method #hinweis[(which failures count, how recovery time is measured)]],

  [ASR-P1],
  cell-cross,
  cell-cross,
  [Vague: "return results quickly" gives no specific feature scope or measurable target.],
  [Add scope #hinweis[(search/recommendations)] and latency thresholds #hinweis[(e.g., "$<$350 ms for 95% of queries
      under 100k concurrent users")].],

  [ASR-S1],
  cell-check,
  cell-tilde,
  [Specific about observability #hinweis[(health endpoints/logs)] but "replaceable without downtime" is not well
    measurable.],
  [Define measurable deployment window\ #hinweis[(e.g., "Service replacement must complete in $<$15 min, with $<$5 min
      degraded functionality.")]],
)

=== Agile Landing Zones
Establish _three measurable values_ #hinweis[(M in SMART)] rather than a single measure that might not be realistic
#hinweis[(R)] and impossible to agree upon #hinweis[(A)]. Similar to _release criteria_ but allow for _tolerances_ in
acceptable values. Allows for some _flexibility_ in meeting goals without forcing you to accept unreasonable
compromises. Can be time bound #hinweis[(T)] individually.

_"Minimal"_ defines the worst acceptable time frame, _"target"_ the time frame to aim for and _"Outstanding"_ the best
possible case.

#table(
  columns: (1fr, auto, auto, auto),
  table.header(
    [Response Time per Business Activity S], [Minimal Goal (less than)], [Target (within)], [Outstanding (within)]
  ),
  [Order fully processed], [2 weeks], [24 hours], [3 hours],
  [Relocation processed], [3 weeks], [2 weeks], [1 week],
  [Technician appointment scheduled], [2 days], [1.5 days], [1 day],
  [Address validated], [10 seconds], [3 seconds], [1 second],
  [Billing system configured], [1 week], [3 days], [1 day],
)

#pagebreak()

=== Quality Attribute Scenarios (QAS) <qas>
A quality attribute scenario specifies a measurable quality goal for a particular context.


==== NFR Specification Template
#v(-1em)
#table(
  columns: (auto, auto, 1fr),
  table.header(
    table.cell(
      colspan: 3,
      align: center,
      [*Scenario for Requirement xy*],
    ),
  ),
  table.cell(colspan: 2, [_Scenario Synopsis_]),
  [Summarize the NFR being specified],

  table.cell(colspan: 2, [_Business Goals_]),
  [The business objectives supported by this quality requirement],

  table.cell(colspan: 2, [_Relevant Quality Attributes_]),
  [Key quality characteristics this scenario targets],

  table.cell(
    rowspan: 6,
    align: horizon,
    rotate(-90deg, reflow: true)[_Scenario Components_],
  ),

  [_Stimulus_], [The condition that affects the system],
  [_Stimulus Source_], [Person/system that triggered the stimulus],
  [_Environment_], [The condition the environment is in when the condition occurs],
  [_Artifact_], [The thing affected and observed in this scenario],
  [_Response_], [The desired system reaction to the stimulus],
  [_Response Measure_], [Quantified acceptance criteria that makes the response testable/validatable],

  table.cell(colspan: 2, [_Questions_]),
  [Open Points/assumptions to clarify with stakeholders],

  table.cell(colspan: 2, [_Issues_]),
  [Known risks, constrains, conflicts],
)

==== Example
#v(-1em)
#table(
  columns: (auto, auto, 1fr),
  table.header(
    table.cell(
      colspan: 3,
      align: center,
      [*Scenario for Requirement "Payment & Age-verified Purchase Availability (QAS-R1)"*],
    ),
  ),
  table.cell(colspan: 2, [_Scenario Synopsis_]),
  [
    All purchase flows that require age verification must succeed end-to-end 99.95% of the time measured monthly
    #hinweis[(excluding scheduled maintenance windows)]. Failures of those flows must not cause inconsistent states
    #hinweis[(no partial charge without final confirmation)] and must be recoverable within 1 hour #hinweis[(automated
      compensation or manual operator workflow)].
  ],

  table.cell(colspan: 2, [_Business Goals_]),
  [Age-verified purchases],

  table.cell(colspan: 2, [_Relevant Quality Attr._]),
  [Availability, Recoverability, Fault Tolerance],

  table.cell(
    rowspan: 6,
    align: horizon,
    rotate(-90deg, reflow: true)[
      _Scenario Components_
    ],
  ),

  [_Stimulus_], [A user attempts to complete an age-restricted purchase #hinweis[(checkout)]],
  [_Stimulus Source_],
  [External user #hinweis[(gamer)] or client app invoking purchase API; age verification provider callbacks],
  [_Environment_],
  [Production, normal operation and during marketing peaks #hinweis[(see landing zones below)]. Network links to
    external payment and age-verification providers are considered typical #hinweis[(subject to their own SLAs)].
    Scheduled maintenance windows are excluded and must be announced at least 24h in advance.],
  [_Artifact_],
  [The end-to-end purchase flow including frontend checkout module, backend Pricing service, and an Age verification
    service.],
  [_Response_],
  [The system either completes the purchase with confirmation and final accounting or fails gracefully by providing an
    explicit error and a consistent rollback/compensation action #hinweis[(no partial charges, no orphaned order
      records)]. Operator-visible alerts and automated rollback procedures must be triggered on failure.],
  [_Response Measure_],
  [
    - *Target:* 99.95% successful end-to-end completions per calendar month; mean time to detect (MTTD) $<$ 2 minutes;
      mean time to recover (MTTR) $<$ 1 hour. No partial charge occurrences ($>$0 per month).
    - *Acceptable:* 99% success per month; MTTD $<$ 5 minutes; MTTR $<$ 4 hours. Partial charge incidents $<=$ 1 per 10k
      transactions #hinweis[(must be compensated within 24 hours)].
    - *Unacceptable:* $<$ 98% success or any partial-charge incidents that are not compensated within 24 hours;
      immediate incident response escalation required.
  ],

  table.cell(colspan: 2, [_Questions_]),
  [],

  table.cell(colspan: 2, [_Issues_]),
  [],
)

== Quality Utility Trees <qas-tree>
A _tree structure_ that has a top-level taxonomy topic as its root node #hinweis[(usually based on @iso-25010)]. The
branches then split up into finer-grained quality attributes. The _leaves_ are QASs #hinweis[(see chapter @qas)],
prioritized by _Business Value_ and _technical risk_ #hinweis[(Low, Medium, High or no rating if not applicable)].

#image("img/qut.png")

#grid(
  columns: (1fr, 1fr),
  [
    == Twin Peaks Model
    The architecture and requirements should be seen as _two mountains_ that need to be worked on _from top to bottom_
    using an _iterative_ approach. The "peaks" of the mountain are the starting points and development takes place from
    top to bottom in mutual interplay.

    Start by formulating _general requirements_ and start _implementing_ them. The requirements can then be _reworked_
    in more detail depending on the experiences during implementation.
  ],
  image("img/twin-peaks.png"),
)

== Context Diagrams

=== System Context Diagram (SCD)
Represent _systems to be built_ as black boxes. Depicts its _interaction_ with _external entities_ #hinweis[(systems,
  end users)]. Identifies the _information and control flows_ between the system and external entities.

=== C4 Model for Architecture Visualization
The _Context, Container, Component and Classes Model for Architecture Visualization (C4)_ model consists of multiple
diagrams representing each of the four C's, visualizing the architecture in _different levels of detail_. The Class
level is usually left out or automatically generated by the code. Often, supplemental _system landscape_ #hinweis[(other
  system the software interacts with)], _dynamic_ #hinweis[(sequence diagram of a user story/feature)] and _deployment
diagrams_ #hinweis[(where and how the software is deployed)] are added, leading to the name _C4+3_.

*Resources:*
- _Person:_ User that interacts with the system. Can be in different roles #hinweis[(visitor, moderator, admin)]
- _Software System:_ External dependencies #hinweis[(external APIs, services)]
- _Container:_ Application or data store inside the application #hinweis[(Frontend, Backend, Database)]
- _Component:_ Modules inside the containers #hinweis[(APIs, Controllers, Services, logical structure within the
    programming language)]
- _Relationship:_ How elements interact. Can have information on what protocol is used for communication, if any


#image("img/c4.png")

==== Level 1: System Context
Shows the software system being built and how it _fits into its environment_. This includes the _people who use it_ and
any other software systems it _interacts_ with. It adds _little detail_ about the system itself.

==== Level 2: Container Diagram
Provides an _architecture overview_. It zooms in to the software system and shows the _containers_, which are
essentially separately deployable units that execute code or store data #hinweis[(applications, data stores,
  microservices, etc.)]. It illustrates _interface protocols_ and _technology decisions_ and typically gets created
during solution strategy.

==== Level 3: Component Diagram
Zooms into an _individual container_ to show the components inside it. These components should map to real abstractions
#hinweis[(e.g., a grouping of code)] in your codebase.

==== Level 4: Code
Finally, if you really want or need to, you can zoom into an _individual component_ to show how that component is
implemented. There nearly is _never the need to draw a Code diagram_, since it gives a very low level idea on how the
code is structured.

= Collaborative Modelling
A _domain model_ is a graphical overview over the subject area on which the application is intended to apply. It
incorporates both behavior and data. The most popular domain model is the _Unified Modelling Language (UML)_.

*Motivation for Domain Modelling:*
#v(-0.5em)
#grid(
  columns: (1fr, 1.5fr),
  [
    - Capture the _essence_ of the _problem domain_
    - Establish a _shared understanding_ #hinweis[(ubiquitous language)]
    - Align _mental models_ through _visualization_
  ],
  [
    - Align _language_ with _business_: Bridging technical and non-technical stakeholders
    - Find the right _abstractions_ and _simplifications_
    - Use domain knowledge as basis for _system design_ and _architecture_
  ],
)

There are often difficulties in communication between the _Business Domain Experts_ and the _Software Engineers_
implementing a solution in that domain. Projects within complex domains need _shared understanding_. Knowledge is
typically spread out across different persons #hinweis[(business experts, developers, designers, managers...)] and stays
within a certain organization. Models must serve as a _communication tool_ between stakeholders.

*Challenges of traditional modelling*\
Notations like UML are designed for clarity of the technical aspects, but aren't _accessible_ for non-technical
stakeholders #hinweis[(like your mum)]. Discussions about them often devolve into arguing about technical details.

== Why Collaborative Modelling?
Collaborative Modelling #hinweis[(CoMo)] is a _workshop-based technique_ for _technical_ and _non-technical
stakeholders_ to build a _shared understanding_ of the customer's problems and how to develop a solution for them. There
is little preparation needed from the participants, the moderator of the session does most of that.

The _benefits_ are inclusion, engagement, speed, shared language and discovery. It emphasizes people and interactions.

The two main methods used in a CoMo session are _Domain Storytelling_ and _Event Storming_. The moderator guides through
them.

== Domain Storytelling
A diagram containing workflows within the domain, with people carrying out tasks. The goal is to _tell a story of what
is done when by whom_ with terms used by the domain experts to understand the domain and align all stakeholders.

#grid(
  [
    *Elements*
    - _Actor:_ Person or System within the domain
    - _Work object:_ Thing an actor works at/with
    - _Activity:_ What an actor does with a work object.
    - _Sequence Number:_ Indicates in which order activities are executed.
    - _Annotations:_ Information about other cases, optional activities, possible errors or other noteworthy things
    - _Group:_ Outlines elements that belong together

    The elements are always labeled with a noun/verb from the domain language. Each sequence should form a sentence in
    the form _"\<Actor> does \<Activity> with \<Work object> (with \<other actor>)"_

    *Example*
    + Moviegoer buys ticket from Cashier
    + Moviegoer buys snacks and drinks from concession stand #hinweis[(optional)]
    + Moviegoer shows ticket to Usher #hinweis[(Türsteher)]
    + Usher checks ticket and grants entrance to Moviegoer
    + Projectionist starts movie for Moviegoer
    + Moviegoer watches movie
  ],
  image("img/domain-storytelling.png"),
)
#v(-1em)
*Best practices*\
- Start modelling the default case/_happy path first_. Only then discuss what else could happen.
- Use separate work objects for each sentence, _duplication increases readability_ in this case.
- Make work objects _explicit_, not a part of an activity\ #hinweis[(i.e. instead of "Cashier $-$looks for available
    seats in$->$ floor plan" use "Cashier $-$looks for$->$ available seats $-$in$->$ floor plan")]
- Name _every_ actor, activity and work object
- Use _separate icons_ for actors and work objects

== Event Storming
#let post-it-color(color, body) = {
  text(fill: color, weight: "bold", style: "italic", body)
}

#let POST-IT = (
  orange: color.orange,
  yellow: rgb("f0c91e"),
  pink: rgb("FF69B4"),
  neonpink: rgb("f4677a"),
  lilac: rgb("bb98cc"),
  red: color.red,
  green: rgb("97c324"),
  lightgreen: color.lime,
  blue: rgb("20acfd"),
)

In Event Storming, the domain is _modeled on a wall/white board_ with _differently colored post-its_ on a _timeline_.
The whole session is guided by a moderator.

*Common Concepts across all types (Color = Color of the Post-it)*
- #post-it-color(POST-IT.orange, "Domain Events:") An event that happened in the past and the business cares about
  #hinweis[(e.g. "Item added to cart")].
- #post-it-color(POST-IT.neonpink, "Hot Spot:") Things the stakeholders do not agree on or are unclear.
- #post-it-color(POST-IT.yellow, "Actor/Agent:") (Group of) people involved in a domain event.
- #post-it-color(POST-IT.pink, "System:") IT system used as a solution for a problem. Wide Post-it.
- #post-it-color(POST-IT.blue, "Command/Action:") Decision, actions or intent, either automated or manual

*The general procedure of a Event Storming workshop is:*
+ Storm out the business process by creating a series of Domain Events on sticky notes.
+ Create Commands that cause each Domain Event.
+ Associate the Entity/Aggregate on which the Command is executed and that produces the Domain Event outcome.
+ Draw boundaries and lines with arrows to show flow on your modeling surface.
+ Identify the various views that your users will need to carry out their actions, and important roles for various users



The original definition splits Event Storming into three types. Note that in the exercises we didn't make this
distinction.
#table(
  columns: (1.1fr, 1fr, 1.2fr),
  table.header(
    [Big Picture #hinweis[(less detailed)]], [Process Modelling], [Software Design #hinweis[(more detailed)]]
  ),
  [
    - Create a shared state of mind
    - Explore business/domain model
    - Identify Bounded Contexts
    *Used for:* Broad organizational storytelling
  ],
  [
    - Assess specific process
    - Find bottlenecks and identify parts of the system to decouple from existing software
    *Used for:* Detailed workflows
  ],
  [
    - Design clean and maintainable event-driven software
    - Derive shared language and domain model within a bounded context
    *Used for:* Implementation conversations
  ],
)

*Best Practices*
- _Clarify the purpose:_ The moderator should explain to the participants why the session is done
- _Start simple:_ Get the basic steps of the process on the timeline first without too much thought on where they belong
  on the timeline
- _Model different stories:_ Model different types of scenarios #hinweis[(e.g. for a game store, model the flow for
    developers and gamers)]
- _Match scale to scope:_ Choose the appropriate event storming type
- _Experiment and iterate:_ Move sticky notes around, there is no need to be correct or perfect at first
- _Lean on facilitation, not just technique:_ The moderator should clearly guide and split the session into different
  steps
- _Blend styles if needed:_ For some context, the group can switch to a different event storming type

=== Pivotal Events & Emerging Bounded Context
The most significant domain events get turned into _pivotal events_. #hinweis[(e.g. for a online shop: "Article Added to
  Catalogue", "Order Placed", "Order Shipped", "Payment Received" and "Order Delivered")]. These are then placed on a
long yellow tape called _Candidate system boundaries_ that separate different steps in the product.

#align(image("img/pivotal-events.png", width: 79%), center)


*Criteria for a pivotal event*
+ _Events that trigger significant downstream activity:_ The "So What?" test #hinweis[(Event causes lots of changes)].
+ _Events that represent key business decisions or policy enforcement:_ Decision points and policy application.
+ _Events that involve hand-overs to external parties:_ Boundary crossings and external triggers.
+ _Events that lead to lasting state changes:_ Significant data updates and process milestones.
+ _Events that indicate potential bottlenecks or failure points:_ Points of contention and exception handling.
+ _Compliance and regulatory significance:_ Events tied to legal or regulatory requirements.
+ _Change in resource allocation:_ Events causing significant shifts in personnel, time, or budget.
+ _Impact on multiple stakeholders:_ Events affecting various departments or stakeholders.
+ _High business value realization potential:_ Events that correlate with achieving key business objectives.

Within the candidate system boundaries, different post-its can be grouped together into _emerging bounded contexts_. See
@bounded-context.

#align(image("img/emerging-bounded-context.png", width: 75%), center)

=== Big Picture Event Storming
_Goal:_ Assess health of existing business or explore viability of new business.\

*Additional Concepts:*
- #post-it-color(POST-IT.green, "Opportunity:") Possible improvements to a hot spot
- #post-it-color(POST-IT.red, "Negative Value")/#post-it-color(POST-IT.lightgreen, "Positive Value:") Apply after
  timeline has been made consistent

#grid(
  columns: (1.1fr, 1fr),
  [
    === Process Modelling Event Storming
    _Goal:_ Assess the health of a specific process in the company.

    *Additional Concepts*
    - #post-it-color(POST-IT.lilac, "Policy:") "Whenever X happens, we do Y", automated or manual process. In between a
      Domain Event and a command/action.
    - #post-it-color(POST-IT.green, "Query Model/Information:") Information needed by an actor to make decisions. Also
      includes how information is presented to the actor, through UI/Forms.
  ],
  image("img/process-modelling-event-storming.png"),
)

=== Design Level Event Storming
_Goal:_ Design maintainable event-driven software

#grid(
  align: horizon,
  [

    *Additional Concept*\
    #post-it-color(POST-IT.yellow, "Constraint:") Previously called "aggregate". Depending on the Event Storming Style
    used it can mean:
    - _Objects of data_ on which commands are executed\
      #hinweis[(i.e. the actual data the application interacts with)]
    - A _restriction_ that has to be accounted for before a command/action can be performed. The basis of business
      rules.
  ],
  image("img/design-level-event-storming.png"),
)

#figure(
  supplement: none,
  caption: [
    #hinweis[*Note:* In the exercise session, we didn't differentiate and did a mixture of all three event storming
      types.\ It sits somewhere between Big Picture and Design Level Event Storming.]
  ],
  image("img/big-picture-event-storming.jpg"),
)


== Comparison of CoMo Practices
#table(
  columns: (auto, 1fr, 1fr, 1.1fr, 0.6fr),
  table.header([Practice], [Usage], [Strengths], [Weaknesses], [Space]),
  [*Big Picture\ Event Storming*],
  [Modelling/designing a enterprise, business or domain],
  table.cell(rowspan: 3, align: horizon)[Adaptable and quick to learn,\ Chaotic nature gives a lot of insight],
  [A lot of people in one room, requires experience of moderator, only works with a timeline],
  [Problem space],

  [*Process Modeling\ Event Storming*],
  [Modelling/designing a story, process or timeline],
  table.cell(rowspan: 2)[Difficult concepts to grasp, can feel like a high time investment, only works with a timeline],
  [Problem and solution space],

  [*Design Level\ Event Storming*],
  [Designing software for stakeholders needs],
  [Solution space],
  table.hline(stroke: 1.5pt),

  [*Domain\ Storytelling*],
  [Modelling one specific scenario, process or timeline],
  [No learning curve, instant documentation],
  [Structured approach to lower amount of discovery],
  [Problem and solution space],
)

*When should you choose...*\
Both focus on collaboration between domain experts and finding bounded contexts. Can also be combined.
#v(-0.5em)
#table(
  columns: (1fr, 1fr),
  table.header([Event Storming], [Domain Storytelling]),
  [
    - Discover existing structure
    - Storm new ideas, be creative
    - Model complex domains, where a story can't yet be put into words
    - Model processes with a strong time reference
    - Scales better with many people
    - Participants explore domain, less moderating
    Displays results on a timeline:\ *What happens when?*
  ],
  [
    - Documentation is required #hinweis[(use a modelling tool to have something "docs-ready")]
    - Collaboration/communication between actors must be modelled
    - Workshop needs to be recorded #hinweis[(i.e. remote meeting)]
    - Company culture prefers structured approach
    - Moderator channels inputs and does the modelling
    Displays collaboration between actors:\ *Who does what with whom?*
  ],
)

#pagebreak()
= Strategic DDD, Solution Strategy & Architectural Decisions
The requirements for the _development process_ often differ from NFRs. A _loosely coupled architecture and organization
structure_ is key to fulfilling them.

#grid(
  columns: (auto, 1fr),
  [
    - Release often, iteratively & quickly #hinweis[(continuos delivery)]
    - Release features fast #hinweis[(time to market)]
    - Update only part of a system #hinweis[(each system can deploy separately)]
  ],
  [
    - Scalable organization #hinweis[(split into multiple teams)]
    - Being able to respond to changes fast
  ],
)

== Strategic Domain-Driven Design (DDD) <strategic-ddd>
With _Strategic DDD_, a high-level overview over the business domain can be created and different parts can be bundled
within_ bounded contexts_. These are then placed in a _context map_ that showcases the relationships and integrations of
different bounded contexts, see Chapter @context-mapping. The process is often done iteratively during the development
of a project. _Tactical DDD_ focuses on the design of the model inside a bounded context, see @tactical-ddd.

=== Subdomains
Subdomains represent _the problems your customers have_ -- the _problem space_. They can be split into three types:
#table(
  columns: (1fr, 1fr, 1fr),
  table.header([Core Domain], [Supporting Domain], [Generic Subdomain]),
  [
    Represent the core concept of your business domain -- these are _your selling points_. Highly domain-specific
    knowledge. Mostly or fully created in-house.
  ],
  [
    Parts that support your business, but don't belong to your core competencies. Usually requires _some amount_ of
    domain knowledge. Use existing components with tweaks.
  ],
  [
    Needed parts, but don't capture or communicate core business knowledge. Little to _no domain knowledge_ is needed.
    Usually off-the-shelf solutions are used.
  ],
  table.cell(colspan: 3, align: center)[
    *Example:* A dentist has three problems:
  ],
  [
    *Fixing patient's teeth*\ The main work people pay for. Improvements in this area will win new customers.
  ],
  [
    *Making appointments for the patients*\ The appointment logic must follow domain specific rules
    #hinweis[(Appointment length depends on the type of procedure, availability of equipment and personnel,
      emergencies...)] Improving here may win new customers, but it is not the main thing they visit for.
  ],
  [
    *Billing* #hinweis[(Invoices, payments, taxes, ...)]\ Governed largely by external rules. Improvements in this area
    don't win new customers. Custom building a billing system would add little strategic value
  ],
)

// https://stackoverflow.com/a/73079017

=== Bounded Context <bounded-context>
DDD suggests to decompose systems into _Bounded Contexts_. They represent the _solution space_ and should implement
parts of one or multiple subdomains.

Bounded contexts establish _boundaries_ between domain models #hinweis[(e.g. the Sales Context vs. Support Context)].
The concepts within a Bounded Context have distinctive meanings in order to establish linguistic boundaries. Words can
have different meanings in different contexts. Usually, _one bounded context per team_ is created.

*Why bother defining bounded contexts?*
#v(-0.5em)
#grid(
  [
    - Same term, different meaning #hinweis[(homonym)]
    - Same concept, different use #hinweis[(polyseme)]
  ],
  [
    - External system differences #hinweis[(heterogeneity)]
    - Scaling up the organization #hinweis[(multiple teams)]
  ],
)

#pagebreak()
=== Subdomain Diagram
To begin with DDD, a diagram containing all relevant subdomains is created. This type of diagram doesn't have an
official name, but to avoid confusion it will be called _"Subdomain Diagram"_ in this document.

It shows the different subdomains of the client. Domain experts assist in drawing the basic relationships between the
subdomains. If any questions arise at this stage, a _design issue_ can be created. They address high level topics like

- Do we _implement_ this subdomain _ourselves_ or do we use a third-party-product?
- _Technologies_ that could be used for implementation
- Basic _architectural questions_ #hinweis[(new module, (multiple) microservices?)]
- _Integration_ into _existing systems_ necessary?

#grid(
  image("img/subdomain-diagram.png"),
  image("img/subdomain-diagram-bounded-contexts.png"),
)

The subdomains can be grouped into preliminary _bounded contexts_ #hinweis[(blue in the second image)]. "Bounded
Context" can be used interchangeably with "Composition Unit" in this stage.


#grid(
  columns: (1fr, 2fr),
  [
    *Overview of Subdomains &\ Bounded Contexts*\
    The diagram showcases _subdomains_ and _bounded context_ within a domain. It is not part of the DDD process, it just
    provides an _overview_ over both concepts. Relationships between subdomains and bounded contexts represent a "x
    implements y"-relationship.

    Bounded Contexts don't have to map 1:1 to a Subdomain and a Bounded context can overlap with multiple Subdomains.
  ],
  align(center, image("img/subdomain-bc-overview.png")),
)

#table(
  columns: (1fr, 1fr),
  table.header([Subdomains], [Bounded Contexts]),
  [Problem Space #hinweis[(Problems the customer wants solved)]\ Result of Object-oriented analysis #hinweis[(OAA)]],
  [Solution Space #hinweis[(Solutions that address these problems)]\ Result of Object-oriented Design #hinweis[(OOD)]],

  [Grouped by their business importance\ #hinweis[(Core, supporting, generic subdomain)]],
  [Grouped by their relationships with each other #hinweis[(Symmetric, asymmetric, upstream integration, downstream
      integration)]],

  [Should always be #hinweis[(partly)] covered by at least one bounded context],
  [Can implement one or multiple subdomains partly or fully],
)
#grid(
  columns: (0.5fr, 1fr),
  [
    == Context Mapping <context-mapping>
    DDD produces a _Context Map_ that defines _how_ bounded contexts _integrate_ -- it illustrates the information flow.
    We take the bounded contexts we discovered in the subdomain diagram and _label the relationships_ between the
    bounded contexts. A context map only showcases the design of the solution, so there are no subdomains, only bounded
    contexts.
  ],
  image("img/context-map.png"),
)

=== Relationships
Each relationship in a context map is either _symmetrical_ or _asymmetrical_. Each Upstream-Downstream _relationship_
usually has a Upstream/Downstream integration _pattern_ on each end.


#let category-cell(body) = table.cell(rowspan: 2, align: center + horizon, rotate(-90deg, reflow: true, body))
#table(
  align: horizon,
  columns: (auto, 0.35fr, 1fr),
  table.header([], [Type], [Description]),
  category-cell[*Symmetric\ Relationships*],
  [Shared Kernel\ #hinweis[(SK)]],
  [
    Two bounded contexts share a part of their domain models. The shared part is typically realized as a library
    maintained by both teams.
  ],

  [Partnership\ #hinweis[(P)]],
  [
    Two teams cooperate together and can only succeed or fail together #hinweis[(delivery failure of one leads to
      delivery failure of both)]. These teams may share CI/CD infrastructure and always release together.
  ],

  category-cell[*Asymmetric\ Relationships*],
  [Upstream -- Downstream\ #hinweis[(U $->$ D)]],
  [
    The actions of the upstream group affect the downstream group, but not vice versa. The upstream context exposes
    parts of its domain model to the downstream context. Each U-D-Relationship also has one U/D integration pattern on
    each end.
  ],

  [Customer -- Supplier\ #hinweis[(S $->$ C)]],
  [
    Upstream-downstream relationship where the Customer #hinweis[(downstream)] can highly influence the Supplier
    #hinweis[(upstream)]. The supplier respects customer's requirements and plans accordingly.
  ],

  category-cell[*Upstream\ Integration Pattern*],
  [Open Host Service\ #hinweis[(OHS)]],
  [
    Upstream context which provides a uniform API to multiple downstreams. If they have mostly the same requirements,
    implement a single API instead of integrating with each individually.
  ],

  [Published Language\ #hinweis[(PL)]],
  [
    Upstream context defines a common language used to translate between models -- e.g. JSON. Often combined with OHS.
  ],

  category-cell[*Downstream\ Integration Pattern*],
  [Anticorruption Layer\ #hinweis[(ACL)]],
  [
    Downstream context translates between domain models to protect its own model from upstream changes -- a
    _Isolation-/Translation-Layer_. The opposite of Conformist.
  ],

  [Conformist\ #hinweis[(CF)]],
  [
    Downstream decides to conform to the upstream model -- its changes have direct impact on downstream. Opposite of
    ACL.
  ],
)
#pagebreak()
*Example Context Map for Fair Game 3002:*\
The bounded contexts in this scenario are:
#grid(
  [
    - _Game Creation and Upload:_ This part of the system shall allow developers to create games, upload them, and later
      publish new releases/versions of the games.

    - _Review and Publishing:_ This context is all about the game review, compliance checks, pricing, and publishing of
      a game.

    - _Game Shopping:_ This context is the online shop for the gamers. It covers the game catalog (searching, filtering)
      as well as buying and downloading games.
  ],
  [
    - _Experience:_ This part of the system is all about the experience for the gamers and developers. It covers
      ratings, reviews, etc.

    - _Revenue:_ This part of the system must receive all kinds of information about games that have been sold; so that
      it can payout the developers via bank transfer.

    - _User Profiles:_ Manages the user profiles for game developers as well as gamers.
  ],
)

#grid(
  [
    *Solution:*
    - The _UserProfile_ context has been omitted as many contexts will potentially need profile information about the
      gamers and game developers $->$ Cross-cutting

    - The _GameCreationAndUpload_ #hinweis[(uploaded games)] will provide information that will be needed
      _ReviewAndPublishing_ #hinweis[(the reviewers and the publication process)].

    - The _GameShopping_ context will need information of the _ReviewAndPublishing_ context to add accepted games to the
      catalog.

    - The _DeveloperRevenue_ context will need information about the UserProfiles #hinweis[(Developers)], _GameShopping_
      #hinweis[(the sold games)], as well as _GameCreationAndUpload_ #hinweis[(game information such as the price; maybe
        that could also be provided by the GameShopping context)].
  ],
  image("img/context-map-fair-game.png", width: 90%),
)


== Service Decomposition
Service Decomposition is the umbrella term for architectural styles that allow us to _decompose_ a software system into
_subsystems_, (micro-)services and modules. Two main ways are _Service oriented architectural style (SOA)_
#hinweis[(serves as the basis for microservices)] and _Moduliths_.

=== Monolith, Modulith and Microservices
#grid(
  columns: (2.5fr, 1fr),
  [
    One of the biggest architectural decisions is whether to build a _monolith_ or _split_ the software up into
    _independent microservices_. However, starting your project as a microservice increases the _complexity_
    significantly without any immediate benefits, thus violating the _You ain't gonna need it (YAGNI) principle_.
    Additionally, microservices only work well if the _boundaries_ between the services are _stable_ -- which is highly
    unlikely when a project is just starting up. A _monolith_ allows you to explore the boundaries of the components and
    easily move stuff around. However, without proper planning, it will likely lead to some unmaintainable behemoth.

    A way to combine these two architectures would be to start building a _Modulith_: The components are split up into
    _different modules_ like in a microservice architecture, but they are always _deployed as a whole_. This keeps the
    code base "under one roof" and allows to see dependencies relatively quickly. Strong couplings between components
    can be spotted easier and reworked. If done correctly, a component should be able to be broken off the modulith
    without affecting other components.

  ],
  image("img/modulith.png"),
)

== Solution Strategy
The solution strategy is about the fundamental decisions that shape a system's architecture. These are the _big
decisions_ made during the in the beginning of the project -- i.e. the _Inception & Elaboration Phases_ in Rational
Unified Process (RUP).

+ _Technology decisions:_ Programming languages, Database type etc.
+ _Top-level decomposition:_ Architectural patterns, design patterns
+ _How to achieve key quality goals:_ Formulating (Non-)Functional Requirements
+ _Relevant organizational decisions:_ Select a development process, delegating tasks to third parties...

#definition[
  *What makes architectural decisions (ADs) big?*
  + _High architectural significance score_: High score in ASR test #hinweis[(see chapter @asr)], a "H/H" in QAS tree
    rankings #hinweis[(see @qas)]
  + _High financial investment and/or tough consequences:_ Software licenses, training, consultants, cloud operations,
    people impact...
  + _Long time to execute:_ Need for PoCs, training, recruiting...
  + _Many or still unclear outgoing dependencies:_ "One thing leads to another" -- other ADs depend on it
  + _Take a long time to pass Definition of Done:_ Many stakeholders, goal conflicts, hard to revise...
  + _High level of abstraction:_ Architectural style, composite patterns...
  + _Problem/solution space outside of team's comfort zone_
]


=== Layers and Tiers
An application can be split into layers and tiers. Each layer/tier only talks to its neighbors.
#table(
  columns: (1fr, 1fr),
  table.header([Layer], [Tier]),
  [Separate concerns\ #hinweis[(Presentation layer, business layer, data layer)]],
  [Distribute workflow\ #hinweis[(Client tier, Web app tier, Database tier)]],

  [Top-to-bottom flow], [Left-to-right flow],

  align(center, image("img/layers.png", width: 50%)), align(horizon, image("img/tiers.png")),
)


#grid(
  columns: (2.5fr, 1fr),
  [
    _Tiers_ are essentially just _layers applied twice_: in the _logical_ and _physical_ view. With tiers, we can define
    process/server boundaries #hinweis[(dashed lines)].
    - _End users and external systems_ only talk to the presentation layer to isolate them from the rest of the backend
    - _Presentation layer_ talks to the business logic to support multiple presentations of the same logic
    - _Business logic_ uses the database access layer to communicate with the database and other backend systems. The
      data access layer can be swapped in or out if a change in the other systems occurs

    Partitioning the application into server/client components with well-defined boundaries is known as _Distribution
    patterns_ or _Client/Server Cuts (CSCs)_.

    This separation allows us to move from a single logical layer that may or may not reside on the same machine into a
    _Two-Tiered-Architecture_ #hinweis[(Remote User Interface: Client-Server)] and a _Three-Tiered-Architecture_
    #hinweis[(Remote Database: Client-Server-Database)]
  ],
  image("img/layers-twice.png"),
)

#image("img/tier-architecture.png")

=== C4 and arc42 in Architecture Overview
The _C4 Container diagram_ provides an architectural overview _similar to Tiers_. Both describe layers, modules or
components of the system that are run and deployed independently. The container diagram is typically created during
solution strategy and refined iteratively and incrementally later as needed. It illustrates the Client-Server Cuts and
other big decisions like the interface protocols and implementation technologies.

The _arc42 model_ goes one step further: It provides a _whole template_ for documenting your solution strategy and how
to prioritize.

== Documenting Architectural Decisions (AD)
Architectural Decisions (AD) are design decisions that are costly to change. They should therefore be well-documented in
_Architecture Decision Records (ADR)_ in order to:
#grid(
  [
    - Make the rationale and _justification_ of ADs _explicit_
    - Avoid _unnecessary reconsideration_ of the same issues
    - _Preserve design integrity_ in function components
  ],
  [
    - Provide a _single place_ to find important decisions
    - _Reference_ of documented _decisions_ for new people
    - Ensure that the architecture is _extensible_ and _evolvable_
  ],
)

ADRs can also be embedded into code #hinweis[(comments, custom annotations)] or formatted with markdown and versioned.
Templates like _Markdown Architectural Decision Records (MADR)_ exist.

=== The Y-Template
The Y-Template is a _sentence structure_ that allows efficient notation of ADs. It emphasizes tradeoffs between
qualities #hinweis[(requirement vs commitment, pros vs. cons)]
#quote(quotes: false, [
  In the context of \<use case $"uc"$ and/or component $"co"$>... #h(1fr) ...facing \<non-functional concern $c$>,\
  #v(-0.5em)
  ...we decided for \<option $o_1$> #h(1fr) #text(size: 2em)[Y] #h(1fr) and neglected \<options $o_2$ to $o_n$>,\
  #h(1fr) ...to achieve \<quality $q$> #h(1fr)\
  #h(1fr) ...accepting downside \<consequence $c$>. #h(1fr)
])


/**Example 1:* \
Combine Messaging and Remote Procedure
- In the context of the order management scenario at Evil Inc.
- facing the need to process customer orders synchronously without losing any messages
- we decided to apply the messaging pattern and the RPC pattern
- and neglected File Transfer, Shared Database, no physical distribution #hinweis[(local calls)]
- to achieve guaranteed delivery and request buffering when dealing with unreliable data sources
- accepting that follow-on detailed design work has to be performed and that we need to select, install and configure a message-oriented middleware provider.*/

*Example 1: Combine Messaging and Remote Procedure* \
_In the context of_ the order management scenario at Evil Inc.,\
... _facing_ the need to process customer orders synchronously without losing any messages,\
... _we decided to_ apply the messaging pattern and the RPC pattern\
... _and neglected_ File Transfer, Shared Database and physical distribution #hinweis[(local calls)]\
... _to achieve_ guaranteed delivery and request buffering when dealing with unreliable data sources,\
... _accepting that_ follow-on detailed design work has to be performed and that we need to select, install and
configure a message-oriented middleware provider.


/**Example 2:*\
- In the context of the Fair Game 3002 platform,
- facing the need to handle high load and availability demands on shopping and payment flows #hinweis[(as captured in SMART NFRs such as 99.95% purchase availability and fast response under peak loads)],
- we decided to separate the GameShopping Bounded Context (BC) from the rest of the system into its own backend tier/microservice,
- and neglected a fully monolithic deployment of all bounded contexts together,
- to achieve higher availability, independent scalability, and fault isolation for the shopping flows,
- accepting that this comes with increased deployment and operational complexity, more inter-service communication, and potentially higher infrastructure cost.*/

*Example 2:*\
_In the context of_ the Fair Game 3002 platform,\
... _facing_ the need to handle high load and availability demands on shopping and payment flows #hinweis[(as captured
  in SMART NFRs such as 99.95% purchase availability and fast response under peak loads)], \
... _we decided to_ separate the GameShopping Bounded Context (BC) from the rest of the system into its own backend
tier/microservice\
... _and neglected_ a fully monolithic deployment of all bounded contexts together\
... _to achieve_ higher availability, independent scalability, and fault isolation for the shopping flows,\
... _accepting that_ this comes with increased deployment and operational complexity, more inter-service communication,
and potentially higher infrastructure cost.

= Rings, IoC, Architectural Viewpoints
One issue with the layer architecture is that technology/infrastructure exists at the top and bottom:
#grid(
  [- _Top:_ User interface, APIs...],
  [- _Bottom:_ Databases, file system...],
)
Therefore, it is harder to keep the business logic _clean and independent_ of technology and infrastructure
dependencies. During _tactical DDD_, we usually want to avoid dependencies from domain to infrastructure $->$ Separation
of concerns, technology vs. domain/business logic.\
The _Dependency Inversion Principle (DIP)_ helps us to achieve this with layers as well through _interfaces_.

#grid(
  align: center,
  [
    *Original Layer architecture*
    #image("img/layers-tech.png", width: 55%)
  ],
  [
    *Layers with DIP (Interfaces)*
    #image("img/layers-dip.png", width: 36%)
  ],
)

== Architectures with Rings
A _ring_ in software architecture is a _zone of responsibility_ within a software. Dependencies are only allowed to
point to inner rings, but never outer ones. _Inner rings_ represent the essential, business-focused and stable, while
_outer rings_ represent variable, infrastructural and replaceable things.


=== Onion Architecture

#grid(
  columns: (1fr, 1.5fr),
  [
    An alternative approach to layers is the _Onion Architecture_. The outer layers depend on the inner layers, but not
    vice-versa. Inner layers define interfaces, outer ones implement them.
    - _Domain model_ consists of business entities and core rules
    - _Domain services_ interact with and change the objects of the domain model.
    - _Application Services_ interact with external systems to persist objects, receive data from external systems
    - _Outside_ of the application core are things that change often: Connection to external systems and databases, user
      interfaces and integration tests.

  ],
  image("img/onion.png"),
)

==== Comparison with Clean Architecture
The onion architecture is similar to Clean Architecture by Robert C. Martin #hinweis[(aka Uncle Bob)]. Both feature
inward dependencies and have similar elements in their respective layers. There are some differences, however.

#table(
  columns: (auto, 1fr, 1fr),
  table.header([], [Onion Architecture], [Clean Architecture]),

  [*Layering and\ Dependencies*],
  [Enforces strict layering, where each layer depends only on the layer directly inside it],
  [More flexible with layering; you can skip layers and still keep the core logic independent],

  [*Domain Focus*],
  [Very domain-driven. All about keeping the domain model central.],
  [Focuses more on framework independence and flexibility with use cases driving the logic],

  [*Use Cases and\ Adaptability*],
  [Focuses on the domain and business rules],
  [Introduces uses cases or interactors to handle application-specific rules, making it adaptable to changing system
    needs.],
)

=== Hexagonal Architecture/Ports and Adapters
_Hexagonal Architecture or Ports and Adapters_ expands Onion Architecture by dividing the outer layer into two parts:
- _User Interface (left/green):_ Everything that turns information into any kind of user interface
- _Infrastructure (right/orange):_ Code that connects the application core to tools like a DB or 3rd party API

For _interaction_ between the application core and the outer layer, hexagonal architecture proposes _two items_:
- _Ports:_ Specification of how a tool can use the core or how it is used by the core. Usually a single interface, but
  it can also be multiple interfaces and data transfer object (DTOs).
- _Adapters:_ Wrap around a Port and use it to tell the application core what to do

#image("img/hex-arch.png")

== Important architectural styles & patterns
=== Pipes and Filters
#grid(
  columns: (1.1fr, 1fr),
  [
    Simple architecture to _transfer data_ and _apply filtering logic_.

    *When to use:*
    - Results are produced through a _chain_ of processing steps
    - Individual data records can be processed _independently_ of each other
    - Data format on the pipes remains _stable_

    *Advantages*
    - _Loose coupling_ and _low dependencies_ between filters
    - Filters can be easily _replaced_ with alternative implementations
  ],
  image("img/pipes-filters.png"),
)

=== Batch Pattern
Processes input data through a _sequence of transformations_, usually strictly _sequential_. Data is sent in "batches"
from one processing step to the next. Still widely used in _offline data processing_ #hinweis[(banks, insurance)], now
often enhanced with DBs, error handling, and orchestration.

#image("img/batch.png")

#grid(
  columns: (1.4fr, 1fr),
  [
    *When to use:*
    - Results produced through a _fixed chain_ of _processing steps_.
    - Intermediate results can be stored in a _common format_ #hinweis[(e.g. files)].
    - Steps may _depend_ on multiple or all input data\ #hinweis[(aggregations, cross-references)].
  ],
  [
    *Advantages:*
    - Simple, functional _decomposition_ of the system.
    - Interfaces are usually _straightforward_\ #hinweis[(e.g., input/output files)].
  ],
)

=== Command Query Responsibility Segregation (CQRS)
_Separates_ _query_ #hinweis[(read)] and _write_ #hinweis[(command)] responsibilities at the system level. Enables
_parallelism_ and _scalability_ -- queries can run independently and be optimized for performance. _Commands trigger
events_ that update the query side #hinweis[(via messaging or queues)]. Commands and queries can used different models
or databases -- CQRS supports _eventual consistency_. Fits scenarios with _few complex writes, but many frequents
reads_.\
*Trade-off:* Higher complexity and data synchronization effort.
#grid(
  align: center + horizon,
  image("img/cqrs.png"),
  image("img/cqrs-code.png", width: 89%),
)

When applying tactic DDD, only the command side will use the domain model/aggregate. Queries are usually handled with
their own "query model"/"read model".

=== Event-driven architectures
#grid(
  [
    The system consists of _Event Sources_ and _Event Sinks_, communicating via events, not direct calls. Enables _loose
    coupling_ and _asynchronous communication_ #hinweis[(implicit invocation)]. Offers _high decoupling_ and
    _scalability_, but _increased complexity_ and _operational overhead_.\
    *Common variants:*
    - _Publish-Subscribe:_ Sources broadcast events, subscribers react selectively
    - _Message/Event Queues:_ Events buffered and delivered asynchronously #hinweis[(fire-and-forget)]
    *When to use:*
    - _No immediate response_ needed
    - _Integration_ of heterogeneous systems
    - Producers send messages _faster_ than consumers can process them.
  ],
  [
    #image("img/event-arch-pub-sub.png")
    #image("img/event-arch-queue.png")
  ],
)

== Architectural Best Practices
#grid(
  [
    - Use _existing architectures_ as guidance, not dogma
    - _Adapt patterns_ to fit your team, domain and constraints
    - _Combine elements_ that solve your specific problem
    - _Avoid over-engineering_ for purity's sake
  ],
  [
    - The best architecture is the _one that works for you_
    - *But:* Stay disciplined -- _don't break your own architectural boundaries_ or introduce unwanted dependencies
  ],
)

*It is best to accept that architecture usually evolves iteratively:*
- Requirements, constraints, and influencing factors _change over time_.
- The _final solution_ often _differs_ from the _initial concept_: development targets move continuously
  #hinweis[("moving targets")].
- _Iterative_ and incremental _development_ helps solutions and goals _converge_ over successive iterations.
- Software architectures typically _evolve_ through cycles and iterations.
- _Design decisions_ and their implementation can _influence_ organizational processes and trigger new requirements.

To ensure your rings, layers or modules are _actually enforced_, use _Architecturally Evident Code_ with tools like
ArchUnit that creates unit tests that check whether your code actually respects your architecture.

== Inversion of Control (IoC)
_Inversion of Control_, or the _Hollywood Principle_, is the idea that the framework, not the application controls the
program flow: *"Don't call us, we call you"*. The code is called vie _callbacks_, _hooks_ and _event handlers_ of the
framework. You insert behavior into a framework and it orchestrates sequencing and calls. This distinguishes it from a
library, where you call the code. _Dependency Injection_ is a part of Inversion of Control.

=== What is a framework?
A framework promotes _consistent approaches to solving problems_. It applies rules and policies to...
- _reduce_ tedious and error prone programming _work_ *$->$ better code*
- _raise the level of abstraction_ and convenience by viewpoint / by layer *$->$ less code*

*A framework should be considered in the following places:*
- _Routine work_ that has to be done in many places #hinweis[(not domain-specific, e.g. logging, testing,
    configuration...)]
- _Risky activities_ #hinweis[(e.g. embedded system development facing real-time requirements like guaranteed response
    times)]
- Need for _Dependency Injection_, to hide specifics
- _Labor-intensive system parts_ #hinweis[(e.g. UI patterns, web, configuration management, deployment)]
- Dealing with _feature variability_ and change

A framework can be _opinionated_, i.e. the framework has certain patterns that you are almost required to use and if you
don't, you're gonna have a bad time.


== Architectural Viewpoints <arc-viewpoints>
FURPS+ requirements can yield many design issues:
- _Functionality:_ Might need multiple steps across layers and tiers #hinweis[(e.g. authentication across multiple
    layers)]
- _Reliability:_ Might call for load balancers ore hot/cold standby modes
- _Performance:_ Hard to judge when only looking at the static structure #hinweis[(Workload patterns? Single point of
    failiure? Reaction to error situations?)]
- _Supportability_ is eased if interactions are easy to understand, test and monitor

Hence, architecture is _not only about structure_, but also _behavior_ #hinweis[(peak/unusual load, error cases)].
Compare to the "Environment" entry in @qas.

=== Component Interaction Diagram (CID)
The arc42 documentation template has a _"Runtime View"_. It describes _concrete behavior_ of the system's building
blocks -- i.e. their interactions in the following areas:
- _Important use cases or features:_ how do building blocks execute them?
- _Interactions at critical external interfaces:_ how do building blocks cooperate with users and neighbouring systems?
- _Operation and administration:_ launch, start-up, stop
- _Error_ and exception scenarios
These points can be notated as an UML diagram, C4 dynamic diagram or a simple list of steps. Often, it can be generated
from other artifacts #hinweis[(i.e. network monitoring)].

A _Component Interaction Diagram (CID)_ allows us to reason about miscellaneous qualities, workloads and volume metrics
#hinweis[(i.e. Should access to customer DB be isolated/cached due to frequency? What happens if a network response
  doesn't arrive on time?)]

#image("img/cid.png")

#pagebreak()
=== The 4 Views on Software Architecture
- _Context:_ View the system as a whole and its integration with neighboring systems #hinweis[(C4 context/system
    landscape diagrams)]
- _Building Block View:_ View the static structure of modules and relationships #hinweis[(C4 component diagram)]
- _Runtime View:_ How do the individual modules work together? #hinweis[(C4 dynamic diagram)]
- _Deployment View:_ In what environment is the system running? #hinweis[(C4 container/deployment diagram)]


=== The 4+1 Architectural View Model
4+1 uses similar concepts as the 4 views above, but adapts them to fit with the "+1": Scenarios
#grid(
  [
    - _Logical View:_ Functionality the system provides to end users #hinweis[(C4 context diagram, DDD context map)]
    - _Process View:_ Dynamic aspects of the system, system processes and their communication, runtime behavior of the
      system #hinweis[(C4 dynamic diagram, CID)]
    - _Development View:_ System from the programmer's perspective, the software management #hinweis[(C4 components &
        classes diagram)]
    - _Physical view:_ System from the system engineer's perspective, the topology of the components on the physical
      layer and their connections with each other
    - _Scenarios:_ Describe interactions between objects and processes #hinweis[(User stories)]
  ],
  image("img/4+1.png"),
)


= Component Identification, PoEAA, Tactical DDD
== Component Identification
We are currently just operating on the Container/Bounded context level. Everything below is still not organized yet. To
carve out responsibilities and create appropriate subcomponents #hinweis[(modules, projects etc.)], we use _Component
Identification_.

#grid(
  [
    *Recommended methods:*
    - Story mapping & splitting
    - Business process modelling or Collaborative Modelling
    - Object-Oriented Analysis and Design (OOAD) patterns
    - Derive from use cases/user stories
  ],
  [
    *Still okay methods, but can lead to anti-patterns:*
    - Use structures of existing structures
    - Implement existing industry standard
    - Structures suggested by frameworks
  ],
)

== Story splitting <story-splitting>
Used to create, split and prioritize user stories. Closely related to story mapping, see chapter @story-mapping. A good
user story should represent a _vertical slice_ #hinweis[(a single story should make changes to each layer to deliver an
  increment of value)] and meet _INVEST_ properties:

#definition[
  - _Independent:_ Stories should not overlap and be schedulable and implementable in any order
  - _Negotiable:_ Not everything is set in stone, the details can be changed during development
  - _Valuable:_ Present to the stakeholders why it should be implemented
  - _Estimable:_ Good approximation of the time/budget possible
  - _Small:_ Should fit within a single iteration #hinweis[(e.g. Sprint)]
  - _Testable:_ In principle, even if the test doesn't exist yet
]

Best done _after Domain Storytelling/Event Storming_. They create common understanding about the domain and a structured
backlog. With user story mapping/splitting, this backlog can then be partitioned into appropriate stories.

=== The Five Story-Splitting Patterns
#definition[
  + _Split by workflow steps:_ A workflow usually consists of multiple steps that can be split up\
    #hinweis[("publish a news story" becomes "publish a story directly to the website", "publish a news story with
      editor review", "view a news story on a staging site" and "publish a news story from staging to production")]
    #v(-0.3em)

  + _Split by operation:_ The word "manage" usually involves multiple actions that can be split up\
    #hinweis[("manage my account" becomes "sign up for an account", "edit my account settings" and "cancel my account")]
    #v(-0.3em)

  + _Split by business rules:_ A story may have different business rules hidden inside\
    #hinweis[("search a flight with flexible dates" becomes "in N days between X and Y", "on a weekend in December" and
      "in $plus.minus$ N days of X and Y")]
    #v(-0.3em)

  + _Split by variations in data:_ Different variations of a action might need different data\
    #hinweis[("find a route from A to B" is split into "...by car", "...by public transport", "...on foot")]
    #v(-0.3em)

  + _Split by interface variations:_ Complexity may hide in the interface. Build a simple variant, add fancy later
    #hinweis[("search for flights in a date range" is split into "...using simple date input" and "...with a fancy
      calender UI")]
]

*Example of using the Story-Splitting Patterns:*\
/*#table(
  columns: (0.4fr, 1fr),
  table.header([Original story], [Split stories]),
  [As a gamer, I want to discover, buy play and rate games],
  [
    - As a gamer over 18, I want to discover, buy, play and rate adult games #emoji.square #emoji.square.orange
    - As a social gamer, I want to discover, buy, play and rate multiplayer games so that I can invite my friends to play with me.
  ],

  [As a content reviewer, I want to review game info drafts so that our game advertising and sharing policies are enforced],
  [
    - As a content reviewer, I want to view game info drafts  so that our game advertising and sharing policies are enforced
    - As a content reviewer, I want to accept/reject game info and justify the decision to transparently inform game developers
  ]
)*/
At the start, we have these three Epics. Split them into smaller ones using the Story-Splitting Patterns.
+ *Create Game:* As a developer, I want to create a new game entry so that I can later upload versions and publish it.
+ *Upload Version:* As a developer, I want to upload a new version of my game so that it can be reviewed and published.
+ *Track Status:* As a developer, I want to view the status of my uploaded versions so that I know which ones are under
  review.

#v(-0.5em)

Each split suggests concrete controllers, application services, aggregates/repositories, adapters, and domain events.
#hinweis[(e.g., upload validation $->$ validator service; cross-context publication $->$ event publisher)]

#table(
  columns: (auto, 1.0fr, auto, 1.1fr),
  table.header([Epic], [Split Story], [Pattern used], [Impact on Architecture]),
  [*Create Game*],
  [
    Create game with title & description only, saved as draft, add other details later
  ],
  [Workflow\ step],
  [
    GameController + GameApplication + GameRepository. Supporting both workflow steps, game aggregate #hinweis[(state
      draft)]
  ],

  [*Create Game*],
  [
    Add additional data like category, tags, artwork. Depending on category, different details might be needed.
  ],
  [Data\ variation],
  [
    Extend Game aggregate, Media Metadata value object, StorageAdapter for artwork
  ],

  [*Create Game*],
  [Validate title uniqueness],
  [Business\ rule],
  [Some kind of validation service, maybe domain service?],

  [*Upload Version*],
  [Upload binary package + version number + changelog],
  [Operation],
  [VersionController $->$ VersionApplication-Service $->$ GameVersionRepository. GameVersion Aggregate],

  [*Upload Version*],
  [Pre-validate package format/signature before persisting],
  [Business\ rule],
  [GamePackageValidator (domain/service); error events],

  [*Upload Version*],
  [Trigger Publication/Review request event after successful upload],
  [Interface /\ Cross-context],
  [EventPublisher $->$ message bus, domain event PublicationRequest],

  [*Track Status*],
  [Show list of versions with states #hinweis[(Draft, Uploaded, Publication requested)]],
  [Workflow\ step],
  [Version read model or query end point, add status field to GameVersion],

  [*Track Status*],
  [Notify dev on state change #hinweis[(email/webhook)]],
  [Interface],
  [NotificationAdapter, subscribe to state-change events],

  [*Track Status*], [Filter by game or state], [Data\ variation], [Query parameters, indexes on GameID, Status],
)

Additionally, there's also this _monster_ of a graph. We hope we don't need this in the exam. Placed here for reference.
#image("img/story-splitting.png")


== Story mapping <story-mapping>
//https://jpattonassociates.com/the-new-backlog/
Closely related with story splitting. Stories should be able to be placed on two axes: _time_ and _level of detail_. On
the top are the _activities/epics_, below the _tasks_ and _subtasks_. The epics are the _backbone_ of your project, the
_essential capabilities the system needs to have_ for end to end functionality. The backbone should not be prioritized
-- it just "is". Only prioritize the stories hanging down from the backbone. The higher they are, the more necessary
they are. The task placed the highest therefore represent your MVP, the _walking skeleton_. Let's call him Gary. Hi
Gary!

#grid(
  align: horizon,
  image("img/story-mapping.png"),
  image("img/story-mapping-mr-bones-wild-ride.png"),
)

#pagebreak()
*Example story map:*\
The _increment line_ represents what task are planned in this iteration and the already finished tasks. It should move
from the top left to the bottom right during a project.
#image("img/story-mapping-example.png")


== Patterns of Enterprise Application Architecture (PoEAA)
Patterns of Enterprise Application Architecture (PoEAA) is a book from 2003 that contains many important patterns that
are still used today:
- _Domain Model:_ Covered with DDD
- _Service Layer:_ Covered with Onion/Clean/Hexagonal architectures
- _Data Mapper:_ Mapping between domain-/data-/API models
- _Controllers:_ Often seen in Frameworks like Spring
- _Data Transfer Object (DTO):_ Separate data model for APIs and communication with the outside worlds

While the patterns are still valid, many alternatives have popped up since the book's release #hinweis[(MVVM, Remote
  User Interface CSC)]. The business logic layer patterns are rather simplistic and better served with DDD. The Data
access layer pattens are mostly implemented within O/R mappers.

#pagebreak()
== Tactical Domain-Driven Design <tactical-ddd>
_Tactical DDD_ focuses on the design of the model inside a bounded context -- the design of a component, unlike
_Strategic DDD_ which emphasizes the bigger picture, see @strategic-ddd.

#table(
  columns: (auto, 1fr),
  table.header([Term], [Description]),
  [*Entity*],
  [
    _Mutable data object_, able to change state. Has an identifier and a lifecycle.\
    #hinweis[(*Example:* Cargo to be delivered, has fields that change during delivery)]
  ],

  [*Value\ Object*],
  [
    _Immutable data object_. Has no identifier, is defined by its values. All operations must be side-effect free.
    #hinweis[(*Example:* ZIP code, doesn't need a separate ID)]
  ],

  [*Aggregate*],
  [
    _Collection of entities and value objects._ Smallest unit with functional consistency #hinweis[(enforces
      invariants)]. All objects of an aggregate are persisted as a whole, creating a _transaction boundary_. Defines a
    root entity which is the only thing that external entities should reference.\
    #hinweis[(*Example:* "Customer" aggregate, containing "Address" entity and "Social Security Number" Entity)]
  ],

  [*Domain\ Event*],
  [
    A _representation_ of _something that happened_ in the domain. Activity is represented as a series of events.
    Immutable, as we can't change the past. #hinweis[(*Example*: "Cargo loaded", when? where? what route?)]
  ],

  [*Domain\ Service*],
  [
    _Domain logic_ that _crosses_ aggregate boundaries. Contains logic that can't be assigned to a domain object
    naturally. Is stateless. Two types: _Domain services_ #hinweis[(core domain logic)] and _Application services_
    #hinweis[(don't belong to the domain model, connects infrastructure and domain model)]\
    #hinweis[(*Example:* Routing service for the cargo.)]
  ],

  [*Repository*],
  [
    Handles _persistence of aggregates_. One repository per aggregate. Doesn't contain business logic. Only the
    interface belongs to the domain model, the implementation is replaceable and belongs to the infrastructure layer.
    #hinweis[(*Example:* CargoRepository that searches for a specific cargo by Tracking ID)]
  ],

  [*Factory*],
  [
    The Factory GoF pattern, responsible for _creation of complex domain objects_/aggregates. Aggregates should be
    created in one piece #emoji.skull.bones to enforce variants.
  ],
)


=== Aggregates
*Problem:* A single object graph may closely relate to the real domain, but may be a bad model. Always treating all
information of an object at the same time for different purposes can lead to conflict on unrelated changes. \ *Example:*
Asking a question while someone is trying to make a bid.\
*Solution:* Break large objects into smaller ones #hinweis[(Aggregates)] that are based around invariants/business
rules. This ensures operations only get the information they need to perform their function -- setting _transaction
boundaries_.

#grid(
  columns: (1.46fr, 1fr),
  align: horizon,
  image("img/aggregate-problem.png"), image("img/aggregate-solution.png"),
)

*Best practices:*
#v(-0.5em)
#grid(
  columns: (1.4fr, 1fr),
  [
    - Use asynchronous communication between aggregates #hinweis[(e.g. events)]
    - The root entity should enforce invariants
    - Use the same boundaries for transactions

  ],
  [
    - Design small aggregates
    - Reference other aggregates by identity
    - Use eventual consistency #hinweis[(outside the boundary)]
  ],
)


=== Invariants
Some examples of invariants as Aggregate/Service cutting criteria are:
- _Physical containment relationship:_ No "order item" without "order", "order" with "item x" can't contain "item Y",
  adding "item X" to "order", lets "item Y" get a 10% discount
- _Number calculations/value ranges:_ Total sum of X must not exceed value Y, VAT calculation must match product type,
  sum of all account transfers must always be 0)

=== Example Domain Model
#image("img/tactical-ddd-example.png")


=== Example: Applying Tactical DDD to Fair Game 3002
On the left is an _UML diagram_ for creating/uploading games to Fair Game 3002. Refactor it into a tactical DDD model.
#v(-0.5em)
*Observations:*
- The initial model mixes static metadata #hinweis[(`Game`)] with version-specific data #hinweis[(`GameVersion`)]. These
  have different lifecycles and should likely become separate aggregates.
- The Developer entity belongs to another bounded context #hinweis[(`User Profiles`)]. In this context, it should be
  referenced only via a `DeveloperId` Value Object.
- There are no clear transactional boundaries #hinweis[(Aggregates)] or domain events.

#grid(
  columns: (0.3fr, 1fr),
  [
    *Initial Architecture*
    #image("img/tactical-ddd-fairgame-initial.png")
  ],
  [
    *Solution* #hinweis[(References between aggregates only use IDs)]
    #image("img/tactical-ddd-fairgame-solution.png")
  ],
)

#pagebreak()
== Documenting components
Documentation of components should be done with C4, UML or other component diagrams. A popular tool is _PlantUML_, a
language for creating UML diagrams. Because it is text-based, it is more version-control-friendly than purely graphical
solutions. It is highly configurable, i.e. to produce C4 diagrams.

*These diagrams should usually include:*
- _Controllers:_ Act as entry points for external requests
- _Application Services:_ Orchestrate use cases #hinweis[(Depend on domain aggregates and coordinate cross-aggregate
    operations. Each service typically owns one transaction boundary)]
- _Domain layer components:_ Aggregates and domain layer services #hinweis[(Persisted through repositories, though these
    are usually not shown explicitly)]
- _Adapters:_ Import, storage, security scanning, event publishing...


=== Components, Responsibilities, Collaborator (CRC) Cards
Components, Responsibilities, Collaborator (CRC) Cards are a tool to document the purpose of components. It was
originally designed for OOP Classes, but it can be repurposed on the architectural level. Each component gets its own
card where the _Responsibilities_, _Collaborators_ and the_ possible implementation technologies_ are listed.

The text should be keywords and sentence fragments. It can be added to models if written in Markdown etc.
#v(-0.5em)
#table(
  columns: (1fr, 1fr),
  table.cell(colspan: 2)[Component: \<Name> ],
  [
    _Responsibilities:_
    - What is this component capable of doing?\ #hinweis[(provided services)]
    - Which data does it deal with?
    - How does it do its jobs in terms of key system qualities?
  ],
  [
    _Collaborators #hinweis[(Interfaces to/from)]:_
    - Who invokes this component #hinweis[(service consumers)]?
    - Who does this component call to fulfil its responsibilities #hinweis[(service providers)]?
    - Any external active/passive connections?
  ],
  table.cell(colspan: 2)[
    _Candidate implementation technologies #hinweis[(and known uses)]_
    - Which technologies, products #hinweis[(commercial, open source)], and internal assets can realize the outlined
      component functionality #hinweis[(responsibilities)]?
  ],
)

*Example:*
#v(-0.5em)
#table(
  columns: (1.5fr, 1fr),
  table.cell(colspan: 2)[Component: `VersionApplicationService` ],
  [
    _Responsibilities:_
    - Coordinate upload workflow for a new game version.
    - Validate metadata and binary file before persistence.
    - Interact with the `BinaryStorageAdapter` to store uploaded binaries.
    - Trigger asynchronous malware scan through `SecurityScanner`.
    - Maintain transactional consistency within the `GameVersion` aggregate.
  ],
  [
    _Collaborators #hinweis[(Interfaces to/from)]:_
    - `GameVersion` Aggregate #hinweis[(domain logic and invariants)]
    - `BinaryStorageAdapter` #hinweis[(binary storage)]
    - `SecurityScanner` #hinweis[(virus scan trigger)]
  ],
  table.cell(colspan: 2)[
    _Candidate implementation technologies #hinweis[(and known uses)]_
    - Annotated with \@Service in a typical Spring Boot application.
    - Transactions wrap the aggregate modification and event publication to guarantee atomicity.
  ],
)

#pagebreak()
= The Hard Parts
#grid(
  columns: (1fr, 2fr),
  align: horizon,
  [
    _Tradeoff Analysis_ is finding out _what parts_ are coupled together, _how_ they are coupled and how to _assess
    tradeoffs_ by determining the impact of change to interdependent systems.
  ],
  align(image("img/hardparts1.png", width: 80%), center),
)

== Communication
Communication can be _synchronous_ or _asynchronous_. Synchronous leads to _dynamic entanglement_: The caller waits for
a response and blocks everything else. Asynchronous leads to _loose coupling_, the caller receives response
asynchronously and does not block anything.

#table(
  table.header(
    [Synchronous communication],
    [Asynchronous communication],
  ),
  [
    #plus-list[
      + Easy to model transactional behavior
      + Mimics non-distributed method calls
      + Easier to implement
    ]
    #minus-list[
      + Performance impact on highly interactive systems
      + Creates dynamic entanglements #hinweis[(wait for return)]
      + Creates limitations in distributed architectures
    ]
  ],
  [
    #plus-list[
      + Allows highly decoupled systems
      + Common performance tuning technique
      + High performance and scale
    ]
    #minus-list[
      + Complex to build and debug
      + Presents difficulties for transactional behaviors
      + Error handling needs to cover more cases
    ]
  ],
)

== Coordination
Should I use _orchestration_ or _choreography_? Things to consider: _Workflow optimization_ #hinweis[(what fits the use
  case better)], _error handling_, _state management_.

#table(
  table.header(
    [Orchestration],
    [Choreography],
  ),
  [
    An orchestrator _handles the user input_ and _the calls_ to the respective services. The services _don't know
    anything_ about each other, they just _communicate with the orchestrator_. The orchestrator _stores the state_ of
    the entire workflow.
  ],
  [
    Each service _communicates with its neighboring_ service. But in the _failure case_, a service may have to _contact
    another service_ out of line, adding _additional communication points_. It is also unclear where the _state_ of the
    workflow is stored.
  ],
  [
    #plus-list[
      + *Centralized workflow:* Observability and auditing
      + *Error handling:* Orchestrator handles error states
      + *Recoverability:* Snapshots and replays possible
      + *State management:* Single point of truth
    ]
    #minus-list[
      + *Responsiveness:* Orchestrator becomes bottleneck
      + *Fault tolerance:* Single point of failure
      + *Scalability:* Orchestrator hard to scale out
      + *Service Coupling:* Orchestrator knows all services
    ]
    #align(image("img/orchestration.png", width: 80%), center)
  ],
  [

    #plus-list[
      + *Responsiveness:* No central bottleneck
      + *Fault tolerance:* No single point of failure
      + *Scalability:* Services scale independently
      + *Service decoupling:* Only neighbor interactions #hinweis[(Happy path only)]
    ]
    #minus-list[
      + *Distributed workflow:* Hard to test and monitor
      + *State management:* State spread across services
      + *Error handling:* Implemented in many places
      + *Recoverability:* Each service restores its state
    ]
    #image("img/choreography.png", width: 100%)
  ],
)
#pagebreak()
== Consistency
Describes whether the workflow communication requires _atomicity_ or can utilize _eventual consistency_.

- _Atomicity:_ Guarantees that each transaction is treated as a single unit which either succeeds completely or fails
  completely.
- _Eventual Consistency:_ Informally guarantees that, if no new updates are made to the given data item, eventually all
  accesses to that item will return the last updated value #hinweis[(eventual = schlussendlich, nicht eventuell!)].

*All-or-nothing transaction* is one of the _most difficult problems_ to model in distributed architecture. Avoid
cross-service transactions.

== Service Granularity
Choosing the right _granularity_ #hinweis[(the size of a service)] is one of the hardest parts in software architecture.
It's not _defined_ by classes or lines of code, but _by what the service is responsible for_ #hinweis[(what the service
  does)].

=== Granularity Disintegrators
Provide guidance and justification for when to _break a service into smaller pieces_.

- _Service scope and function:_ Is the service doing too many unrelated things?
- _Code volatility:_ Does only one part of the service change frequently while the rest rarely does?
- _Scalability and throughput:_ Do parts of the service need to scale differently?
- _Fault tolerance:_ Are there errors that cause critical functions to fail within the service?
- _Security:_ Do some parts of the service need higher security levels than others?
- _Extensibility:_ Is the service always expanding to add new contexts?

=== Granularity Integrators
Provide guidance and justification for _putting services back together_ or not breaking them apart in the first place.

- _Database transactions:_ Is an ACID transaction required between separate services?\ #hinweis[(ACID = atomicity,
    consistency, isolation, durability)]
- _Workflow and choreography:_ Do services need to talk to one another?
- _Shared code:_ Do services need to share code among one another
- _Database relationships:_ Although a service can be broken apart, can the data it uses be broken apart as well?

= Web Architecture
== Simple HTML
Early web architecture consisted of _static HTML pages_ served from web servers. _No dynamic content_, simple
request-response only.

*Simple Example with Docker and Caddy:*
```sh
# Mount /tmp/web as volume on /usr/share/caddy and redirect connections from port 8080 to 80
docker run -p 8080:80 -v /tmp/web:/usr/share/caddy caddy:latest
```

=== CGI-BIN
The introduction of CGI #hinweis[(Common Gateway Interface)] in 1993 led to the first _dynamic server-side content
generation_ with Perl/C scripts to generate HTML, spawning a _new process per request_.

CGI is an interface specification that enables web servers to _execute an external program_ to process HTTP user
requests. Due to the expensive process launch for each request, it has bad performance.

*FastCGI:* Variation of CGI with the aim to _reduce the overhead_ related to interfacing between web server and CGI
programs. It has persistent processes and _reuses_ resources #hinweis[(database connections, caches)] used in e.g.
PHP-FPM #hinweis[(fastCGI process manager)] for applications like Nextcloud.

== Server Side Rendering (SSR)
The server generates HTML/JS/CSS _dynamically_ and sends the assets in real-time to the browser. PHP, ASP
#hinweis[(Active Server Pages, from Microsoft)] and JSP #hinweis[(Jakarta/Java Server Pages)] emerged in the mid-1990s
and featured better integration than CGI.


=== Architecture for SSR
SSR uses the _MVC model_, created in 1979 at Xerox for desktop GUIs:

*View / Observer:* Renders the _representation_, _responds_ to _changes_ in the model.\
*Controller:* Responds to _user input_, _receives_ and _validates_ input, initiates manipulation of the model.\
*Model / Subject:* Manages _data_ and _state_ of the application.

Early web MVC used _"thin client"_ approach -- nearly all Model, View and Controller _logic ran on the server_ which
generated complete HTML pages and sent them to the browser.

==== Advantages of MVC
- _Avoids spaghetti code:_ Prevents mixing database/HTML/logic
- _Separation of Concern:_ Clear responsibilities per component
- _Model independence:_ Build/test separately from UI
- _Parallel development:_ Teams work on different layers simultaneously
- _Easier Testing:_ Straightforward unit tests per component


==== Well known MVC SSR frameworks
#grid(
  [
    - NeXT WebObjects, 1996 #hinweis[(first big one, controlled by Apple)]
    - Java EE, 1999 #hinweis[(complex)]
    - Spring, 2002 #hinweis[(Java EE alternative, dominant Java Framework)]
    - Spring Boot, 2014 #hinweis[(Autoconfig for Spring)]
  ],
  [
    - Ruby on Rails, 2004 #hinweis[(convention over configuration)]
    - Django, 2005 #hinweis[(Python's Model-Template-View)]
    - ASP.NET MVC, 2009 #hinweis[(Microsoft copying Rails)]
    - PHP: Symphony (2005) & Laravel (2011)
  ],
)



=== Classic SSR Request Flow
#definition[`Request -> Router -> Controller -> Service -> Model (DB query) -> View Template -> HTML Response`]
+ _User requests URL from Browser:_ Browser sends GET request, TCP connection established, DNS resolves domain
+ _Server processes request and renders HTML:_ Router receives request and forwards it to the responsible controller.
  Controller receives it and calls service layer which queries database via repository. Template Engine merges data with
  HTML template. The complete HTML is generated.
+ _Complete page is sent to client:_ Server sends full HTML document in response. Separate requests needed for
  CSS/JS/Images.
+ _Browser displays final result:_ Parses HTML, builds DOM, applies CSS, calculates layout, renders page and runs JS.

#table(
  columns: (1fr, 1fr),
  table.header([Advantages of classic SSR], [Disadvantages of classic SSR]),
  [
    - *Fast initial page load:* HTML arrives fully rendered
    - *Better SEO:* SE can directly parse the complete HTML
    - *Works without JS enabled:* supports older browsers
    - *Simple mental model:* clear request/response cycles
  ],
  [
    - *Full page reload for navigation:* causing screen flashes and losing client-side state
    - *Server does all rendering work:* Requires more CPU/memory resources per request
    - *Higher server load with traffic*
    - *Slower interactions after initial load:* Each click involves a full round-trip to the server
  ],
)

== Client Side Rendering (CSR)
Interactions occur within a single web page, there is no visible "page change" like on regular websites. Client page
_dynamically updates_ as the user interacts with it, providing a smooth, _app-like experience_. Relies on _JavaScript_
#hinweis[(or WebAssembly)] to update the UI.

=== AJAX (Asynchronous JS and XML)
AJAX allows partial page updates without reload. Start of modern web applications. The server sends minimal HTML shell
with JavaScript, Browser executes JS to render UI. Single Page Applications #hinweis[(SPAs)] enable interaction without
page reloads #hinweis[(e.g. Gmail, Google Maps)].

=== Architecture for CSR
CSR uses component-based _MVVM_ on the frontend and _MVC_ on the backend. Views now return _JSON_ instead of rendered
HTML, clear separation enables _independent scaling_ and _technology choices_ for each layer.\
*3-Tier:* Presentation Tier #hinweis[(Client-Side)], Application Tier #hinweis[(API Server)], Data Tier
#hinweis[(Server)].

*Frontend -- Component-based with MVVM:*
Model #hinweis[(data)], View #hinweis[(UI)], ViewModel #hinweis[(two-way data binding)]. Client-Side routing and state
management, API client layer for backend communication.

*Backend -- MVC Pattern:*
Model #hinweis[(data)], View #hinweis[(JSON)], Controller #hinweis[(handlers)]. RESTful/GraphQL API endpoints serve JSON
data. Stateless authentication with JWT tokens.

=== CSR Request Flow
+ _User requests URL from Browser:_ Browser sends GET request, TCP connection established, DNS resolves domain
+ _Server sends minimal response:_ Returns empty HTML shell #hinweis[(no content)], includes JS bundle reference
+ _Browser downloads and executes JS:_ Downloads #hinweis[(often large)] JS bundle, parses and executes framework code,
  framework initializes
+ _JS fetches Data:_ Makes separate API call, API queries DB and returns JSON
+ _Browser renders UI:_ JS manipulates DOM to build interface, Page becomes visible and interactive #hinweis[(TTI)]

#table(
  columns: (0.45fr, 1fr),
  table.header([Advantages of classic CSR], [Disadvantages of classic CSR]),
  [
    - *Fast interactions after load:* Feels like a desktop app
    - *Lower server rendering load:* Only servers JSON
    - *Clear frontend/backend separation*
  ],
  [
    - *Bundle Size Problem:* Large JS files, slow parsing/execution, mobile struggling
    - *Slow initial load:* White screen until JS executes
    - *SEO Problem:* Crawlers see empty HTML, content only after JS execution
    - *Requires JS to be enabled*
  ],
)
=== CSR Improvements

- _Code Splitting:_ Split JS into smaller chunks, load code only when needed #hinweis[(1 bundle per route)]. Reduces
  initial bundle size.
- _Lazy Loading:_ Defer loading non-critical resources, load images on demand. Improves initial page load time.


=== History of JS Frameworks
#grid(
  [
    - jQuery, 2006 #hinweis[(simplifies DOM manipulation)]
    - Backbone.js, 2010 #hinweis[(introduces Structure)]
    - AngularJS, 2010
  ],
  [
    - React, 2013
    - Vue, 2014
    - A million different JS frameworks since then...
  ],
)




== Hybrid Approach: Hydration
_Combines SSR and CSR benefits._ Server renders the initial HTML, client hydrates and takes over.

*Hydration Process:* Server sends _pre-rendered HTML_, Browser displays content _immediately_. JavaScript _loads_ and
_attaches_ event handlers -- Application becomes _interactive_.\
*Problems:* JS re-executes on client -- _duplicated work_, large hydration _cost delays interactivity_ #hinweis[(Server
  Components like in React reduce bundle size sent to client)]. _Uncanny Valley:_ looks ready but is not yet
interactive.

==== Solution Strategies
- _Server components (React):_ Components render only on server, no JS sent to client
- _Island Architecture:_ Static HTML with interactive "islands", only islands ship JS #hinweis[(Astro)]
- _Streaming SSR:_ Send HTML in chunks as ready, Browser renders earlier -- improves perceived performance
  #hinweis[(Qwik)]
- _Edge Rendering:_ Render closer to user geographically at CDN edge locations -- lower latency than origin server


== Comparing SSR, CSR & Hybrid
#definition[*Performance Metrics:* _TTFB_ #hinweis[(Time to first byte)], _FCP_ #hinweis[(First Contentful Paint)],
  _TTI_ #hinweis[(Time to interactive)].]
#table(
  columns: (auto,) * 2,
  table.header([Server Side Rendering], [Client Side Rendering]),
  [
    - _Excels at FCP and TTI_ #hinweis[(Visible and interactive immediately)]
    - Content immediately visible & interactive on load
    - Page reloads needed for navigation
    - No #hinweis[(built-in)] Separation of Concerns
    - No independent scaling
  ],
  [
    - Requires full JS execution, bad for FCP and TTI
    - Must download, parse & execute JS on load
    - _No page reloads_ needed for navigation
    - _Clean Architecture:_ Frontend / Backend separation\ #hinweis[(Static assets on frontend, backend as dedicated API
        endpoints)]
    - _Independent_ scaling and technology choices
  ],
)

==== When to use what:
#table(
  columns: (auto,) * 3,
  table.header([Server Side Rendering], [Client Side Rendering], [Hybrid]),
  [
    - SEO important
    - Fast initial page load needed
    - Content changes frequently
    - Public-facing marketing sites
  ],
  [
    - Application behind authentication
    - Rich interactions more important than initial load
    - Admin panels, Dashboards
  ],
  [
    - Need both: SEO + rich interactivity
    - E-commerce, social platforms
    - Willing to accept deployment complexity
  ],
)

==== Takeaways
- _No single approach fits all:_ Only more/less false. Understand the trade-offs of your requirements.
- _Your architecture has a huge impact on performance:_ Initial load vs. subsequent interaction, server vs. client load,
  SEO vs. interactivity
- _Use common standards and naming:_ Architecture can evolve as requirements become clear. Consistency is more important
  than perfection #hinweis[(Easier to understand for others, LLMs and you in 3 months)].

= Example Architectures
== Dependency Injection
_Dependency injection (DI)_ is a programming technique that makes a class _independent_ of its dependencies. It achieves
that by decoupling the usage of an object from its creation: The _dependency_ is _not instantiated within the class_,
but passed to it as a _parameter_ or via a _Dependency Injection container_. This helps to follow SOLID’s dependency
inversion and single responsibility principles.

Dependency injection follows the _Inversion of Control principle_. The goal is _loose coupling_ -- the component doesn't
care how a dependency implements its features, it just calls the interface.

=== Different Levels of DI in Spring
#table(
  columns: (auto, 1fr, auto),
  table.header([Type], [Description], [Example]),
  [*Without\ DI*],
  [
    Instantiation is hard coded, tight coupling, can't swap implementations or test easily
  ],
  [
    ```java
    public UserController() {
      this.emailService = new EmailService();
    }
    ```
  ],

  [*Manual\ Wiring*],
  [
    Controlled creation of dependencies, explicit wiring in Config-Class, full control but verbose
  ],
  [
    ```cs
    class AppConfig {
      public ES() { return new EmailService(); }
      public UC() { return new UserController(ES()); }
    }
    class UserController {
      public UserController(EmailService e) {
         this.emailService = e;
    } }
    ```
  ],

  [*Auto-\ Wiring*],
  [
    `@Service` and `@Autowired`/`final` #hinweis[(if the constructor is declared `final`, the `@Autowired` annotation is
      not needed)]. Spring manages dependencies with constructor injection.
  ],
  [
    ```cs
    @Service
    class EmailService { /*...*/ }
    class UserController {
      private final EmailService e;
      public UserController(EmailService e)
    }
    ```
  ],

  [*Interface-\ based*],
  [
    Depend on interface, not concrete class. Swap service by changing annotation #hinweis[(like in the example)]. Loose
    coupling with zero controller changes needed.
  ],
  [
    ```java
    interface NotificationService { /* ... */ }
    @Service
    EmailService implements NotificationService {}
    // @Service
    SmsService implements NotificationService {}
    class UserController {
      private final NotificationService ns;
    }
    ```
  ],

  [*Profiles*],
  [
    Different profiles for different environments. Set in Spring config: `spring.profiles.active=email`
  ],
  [
    ```java
    @Service
    @Profile("email")
    class EmailService { /* ... */ }
    ```
  ],

  [*Qualifiers*],
  [
    Explicit selection to change between multiple implementation. Fine grained control.
  ],
  [
    ```java
    @Service("email")
    class EmailService { /* ... */ }
    class UserController {
      public UserController(
        @Qualifier("email") NotificationService ns)
      {} }
    ```
  ],
)


=== When to use DI
#table(
  columns: (1.2fr, 1fr),
  table.header([Pros], [Cons]),
  [
    #plus-list[
      + *Loose coupling:* easy to swap implementations
      + *Testability:* inject mocks for unit testing
      + *Separation of Concerns:* Components focus on business logic
      + *Centralized Configuration:* Manage dependencies in one place
      + *Reusability:* Components can be used in different contexts
    ]
  ],
  [
    #minus-list[
      + *Complexity:* Additional Framework Overhead
      + *Learning Curve:* Understanding IoC #hinweis[(Inversion of Control)] containers takes time
      + *Runtime errors:* Missing dependencies only fail at runtime
      + *Debugging:* harder to trace object creation flow
      + *Overkill* for simple applications
    ]
  ],
)

Architecture decisions _depend_ on the _Framework_. Each Framework has it's own philosophy and best practices. _Do not
fight against your Framework!_ This creates unnecessary complexity. Use best practices recommended by framework:

- _Spring Boot:_ use JPA and DI
- _Go:_ Avoid ORMs and DI frameworks, they are not idiomatic. Instead, use interface-based design.
- _Middleground:_ Squirrel, Jet, jOOQ

== Database Abstraction
Spring Data JPA #hinweis[(Jakarta Persistence API)] is a Data Layer framework to simplify hooking up your code with your
database #hinweis[(similar to .NET Entity Framework)]

_Spring_ is easier for DDD implementation. Spring Data JPA implements the Repository pattern directly, see chapter
@tactical-ddd.

In _golang_ DDD is possible, but decoupling Go doesn't always provide benefits because you rarely swap databases.

#table(
  columns: (1fr, 1fr),
  table.header([Reasons to use JPA], [Reasons not to use JPA]),
  [
    - *Abstraction & Portability:* Switch databases, keep data access code. Standard API #hinweis[(Hibernate,
        EclipseLink)], reduced boilerplate compared to raw JDBC #hinweis[(Java Database Connectivity)].
    - *Domain-Driven Design:* Behavioral domain models with entities as first-class objects, not just DTOs
      #hinweis[(Data Transfer Objects)]. Object-oriented query language #hinweis[(JPQL -- Jakarta Persistence Query
        Language)] instead of table-centric SQL
    - *Productivity:* Auto-generated basic CRUD operations, management of transactions and connection pooling

  ],
  [
    - *Problem "entities + N":* Multiplying DB calls #hinweis[(for a single request, like fetching Users, additional
        requests for each User to get their information are needed)]. Often the case with Lazy Loading. Requires
      acquiring knowledge to detect and fix.
    - *Loss of Control:* Generated SQL may not be optimized. But you can use raw JDBC.
    - *Complexity & Learning Curve:* Requires understanding of database internals, SQL, and behaviors like flush
      ordering. Increases dependencies.
  ],
)

== Transaction Management
Ensures that _multiple database_ operations execute _atomically_. Prevents _partial_ updates that corrupt data
consistency. Critical for _maintaining data integrity_ when business logic spans multiple table modifications or when
concurrent users access shared data.

#table(
  columns: (1fr, 1fr),
  table.header([Spring Boot], [Golang]),
  [
    - *`@Transactional`* annotation magic / rollback rules
    - *Proxy-based gotchas:* Self-invocation doesn't start transactions, must be `public` methods, only works when
      called externally.
  ],
  [
    - Explicit `begin()`, `commit()`, `rollback()`
    - `defer` statement for cleanup
    - Context-based transaction passing
    - Manual transaction boundaries
  ],

  [
    *Convenience:* Harder to trace, but rarely issues when implemented correctly. Best practices: `@Transactional` on
    service layer, not DAO #hinweis[(Data Access Object)].
  ],
  [
    *Explicitness:* Easy to trace, best practice: manual transaction passing.
  ],
)

== Database Migration
With multiple developers and multiple environments, _versioning_ of database schema becomes important for traceability
#hinweis[(Who added that column? When? Why?)]. Dev, Staging and Production environments must _stay in sync_. _Manual_
SQL executions across environments cause _inconsistencies_ and _errors_. CI/CD pipelines need _automated_ database
updates alongside code.

There is need to be able to _undo_ changes when deployments fail. Databases must support _backward compatibility_ during
version transitions.

Only use database migration if you have a team and a prod environment, else skip it. It _adds complexity_ and _requires
discipline_.

#table(
  columns: (1fr, 1fr),
  table.header([Spring Boot with flyway], [Golang with golang-migrate]),
  [
    - *Zero config setup*
    - Spring Boot calls `Flyway.migrate()` *automatically* during application setup. Has built-in locking mechanisms
    - Undo only in commercial pro version
  ],
  [
    - *Idempotent:* less error prone / may hide errors
    - *Workflow:* Create a table, use timestamp prefixes
    - *Best practices:* Test locally first, store in version control with code, avoid rollbacks by preferring
      backward-compatible changes, run via CLI in CI/CD not on app startup.
  ],
)

#pagebreak()

== Testing
Catch Bugs _early_ before production, cheaper to fix in development than after deployment. Enable _confident
refactoring:_ Tests act as safety net when changing code structure. _Document_ expected behavior, tests serve as
executable specifications. _Prevent Regression:_ automated tests catch when new changes break existing functionality.
_Test pyramid:_ many unit tests, fewer integration tests, minimal end-to-end tests. Aim for _high coverage_ of _critical
business logic_, not 100% coverage everywhere.

- _Unit tests:_ isolated component testing with mocked dependencies
- _Integration tests:_ test multiple components together with real database/services

= Messaging
Before 2000, only _direct point-to-point communication_ was widely used, leading to _tight coupling_ and _scaling
problems_. In the early 2000s, proprietary messagings formats #hinweis[(IBM MQ, MSMQ)] were released, but they were
expensive and complex. The open source _RabbitMQ_ was released in 2007, built in the highly distributed Erlang language.
_Apache Kafka_ #hinweis[(2011)] is optimized for high-throughput streaming. Most cloud hosters also have their own
messaging service. RabbitMQ, Kafka and the cloud-native solutions coexist for their specific purposes.


*Useful for:*
#v(-0.5em)
#grid(
  [
    - _Decoupling:_ Services don't know about each other.\ #hinweis[*Trade-off:* Harder to debug distributed flows.]

    - _Asynchronous processing:_ Non-blocking operations.\ #hinweis[*Trade-off:* No immediate feedback on
        success/failure.]

    - _Load leveling:_ Handle traffic spikes.\ #hinweis[*Trade-off:* Delayed processing during spikes.]
  ],
  [
    - _Reliability:_ Guaranteed delivery, retry mechanisms.\ #hinweis[*Trade-off:* Need to handle duplicate messages /
        idempotency.]

    - _Scalability:_ Horizontal scaling of consumers.\ #hinweis[*Trade-off:* More complex deployment and coordination --
        More costs]

    - _Integration:_ Polyglot systems communication\ #hinweis[*Trade-off:* Serialization overhead, schema evolution
        challenges]
  ],
)

When _not_ to use messaging: Simple CRUD, low traffic, single monolithic application. Choose based on _throughput_,
_ordering_ and _replay needs_. There is no perfect solution. Always start simple, scale when needed.


== Message Broker Patterns

#v(0.5em)

#grid(
  align: horizon,
  columns: (2fr, 1fr),
  [
    ==== Point-to-Point / Queue
    _One producer, one consumer._ Good for Work Queues.\
    *Example:* Payment services sends order to fulfillment service.
  ],
  image("img/p2p.png"),
)
#v(1em)
#grid(
  align: horizon,
  columns: (2fr, 1fr),
  [
    ==== Publish / Subscribe
    _One producer, many consumers._ Good for Event Broadcasting.\
    *Example:* Order is created, notify inventory, shipping, analytics, email service. FairGame: User finished game,
    need to update multiple systems #hinweis[(Leaderboard, Achievements, Statistics, Analytics)]
  ],
  image("img/publish-subscribe.png"),
)

#grid(
  align: horizon,
  columns: (2fr, 1fr),
  [
    ==== Request / Reply
    Synchronous-like behavior over async messaging. Like RPC, but more reliable. Good for internal microservices\
    *Example:* Service A asks Service B for data, waits for response.
  ],
  image("img/request_reply.png"),
)

#grid(
  align: horizon,
  columns: (2fr, 1fr),
  [
    ==== Work Queue (Competing Consumers)
    Multiple workers competing for tasks from same queue. No order guarantees. Tasks must never be deposited twice into
    the queue! \
    *Example:* 5 video encoding workers pulling from encoding queue.
  ],
  image("img/work_queue.png"),
)

#pagebreak()
== Push vs. Pull Models
- *Push:* Broker _actively delivers_ messages to consumers. Consumer registers callback, broker pushes when message
  arrives. Consumer needs to be ready at all times. *Examples:* RabbitMQ, AWS SQS.
- *Pull:* Consumer _actively request_ messages from broker. Consumer controls when and how many messages to fetch
  #hinweis[(Batches)]. Higher Latency. Use for e.g. video encoding. *Examples:* Kafka, Amazon Kinesis.

== Message Delivery Guarantees
- *At-Most-Once:* Fire and Forget. Message delivered _0 or 1 times_, never duplicated. Producer sends message, doesn't
  wait for `ACK`s. _Use case:_ Monitoring metrics, telemetry, loss acceptable.
- *At-Least-Once:* Messages not lost but may be delivered _multiple times_. Producer waits for broker acknowledgment,
  broker persists message before `ACK`, consumer must explicitly acknowledge processing. Majority of production
  messaging systems. Requires _idempotent_ consumers. *Examples:* RabbitMQ, SQS default.
- *Exactly-Once:* Expensive Illusion. True exactly-once delivery is _theoretically impossible_ due to network
  partitions, crashes, and timing issues. *Reality:* _At-least-once delivery + idempotent operations_ is effectively
  "exactly-once". _Use case:_ Financial transactions, payments.

#v(-0.4em)
=== Idempotency
Same message can arrive multiple times. The same message processed repeatedly must _produce same result_, this is called
idempotency. Track processed message IDs in the database, use natural keys #hinweis[(e.g. order_id + user_id +
  timestamp)]. Design your operations to be inherently idempotent.

#v(-0.7em)

#table(
  columns: (1fr, auto, 1fr),
  table.header([Code], [Idempotent?], [Explanation]),
  [```java balance = balance - amount;```], cell-cross, [Run twice $->$ double deduction],

  [```sql UPDATE SET balance = 100 WHERE id = X```], cell-check, [Run twice $->$ same result],

  [```sql INSERT ... ON CONFLICT DO NOTHING```], cell-check, [Upsert with unique constraint],
)
#v(-0.9em)

=== Error Handling & Retry Strategies
- _Transient Errors:_ Temporary, Self-healing. Retry with exponential backoff + jitter #hinweis[(random variation
    between retries)]
- _Non-transient Errors:_ No retry will fix these.

*Dead Letter Queue (DLQ):* Special queue for messages that _can't be processed_ after multiple retries. Messages go to
this message heaven if they exceed max retry attempts, if the message TTL expired or when deserialization errors or
validation failures occur. Store the message in the DLQ with the error and number of retries. _Flow:_ Main Queue $->$
fail $->$ Retry Queue #hinweis[(with delay)] $->$ fail $->$ DLQ

== Message Ordering
Most distributed messaging systems do _not_ guarantee global message order by default. Message order is difficult to
keep because of _concurrency_, _network delays_ and _retries_. But most systems don't need strict ordering. _DLQ queue_
is inherently _out of order_.

=== Ordering Guarantees
- _No Ordering:_ Messages may arrive in any order. Default in most systems.
- _Per-key/Partition Ordering:_ Messages that share a key are delivered in the same order as they were produced.
- _Single Consumer Ordering:_ Single consumer reading a stream processes messages one-by-one in read order.
- _Sequence Numbers:_ Each message carries a number so receivers can detect gaps and restore the order.

=== Common Anti-Patterns
- _Don't ignore failed messages:_ Use DLQ to prevent them from disappearing
- _Infinite retries:_ Set a max retry limit to avoid blocking the queue forever
- _Synchronous processing:_ Defeats the purpose of async messaging
- _Large messages:_ Slow serialization, memory pressure, network congestion. Use references/pointer instead
- _No monitoring:_ Track queue depth, processing time, error rates
- _Assuming order:_ Design for unordered unless explicitly guaranteed
- _No idempotency:_ At-least-once requires idempotent consumers
- _No message schema/versioning:_ Allows for easier handling of schema changes


== Comparison Message Brokers
#table(
  columns: (auto,) * 5,
  table.header([Feature], [RabbitMQ], [Kafka], [ZeroMQ], [PostgreSQL]),
  [*Architecture*],
  [Traditional broker #hinweis[(Erlang)]],
  [Distributed log\ #hinweis[(Java/Scala)]],
  [Brokerless library],
  [Database-based queue],

  [*Throughput*], [Medium], [High], [High], [Low],
  [*Latency*], [Low], [Medium], [Lowest], [Medium],
  [*Durability*],
  [Memory + Disk],
  [Disk\ #hinweis[(configurable retention)]],
  [None],
  [Disk #hinweis[(ACID -- Atomicity, Consistency, Isolation, and Durability)]],

  [*Message Replay*], [No], [Yes\ #hinweis[(consumer controls offset)]], [No], [Possible],
  [*Routing*],
  [Advanced\ #hinweis[(exchanges, topics)]],
  [Simple\ #hinweis[(partitions by key)]],
  [Manual\ #hinweis[(App-level)]],
  [None],

  [*Ordering*], [Per-queue], [Per-partition #hinweis[(strong)]], [No], [No],
  [*Ops Complexity*], [Medium], [High], [Low], [Low #hinweis[(Already using PG)]],
  [*Use Case*],
  [Task queues, microservices, RPC],
  [Event streaming, analytics, logs],
  [Low-latency, embedded],
  [Simple queues, low volume],
)

=== Key Differentiators
#table(
  columns: (1fr,) * 4,
  table.header([Rabbit MQ], [Kafka], [ZeroMQ], [PostgreSQL]),
  [
    - Push Model: broker delivers to consumers
    - Written in Erlang
    - AMQP protocol, flexible exchanges
  ],
  [
    - Pull model: consumers fetch messages
    - Append-only log architecture
    - Messages persist, enable replay
    - Built for LinkedIn's scale
  ],
  [
    - No broker = no single point of failure
    - "Sockets on steroids": just a library
    - Microsecond latency, but no guarantees
  ],
  [
    - `SKIP LOCKED` prevents duplicate consumption
    - Visibility timeout + retry logic
    - Leverages existing ACID guarantees
    - Disk I/O bottleneck
  ],
)

= Microservices & REST
Before REST, there was _monolithic architecture_. This led to tightly coupled architecture. If you wanted to deploy /
scape one thing, you hade to deploy / scale everything. Very _inefficient_.

_RPC, CORBA_ #hinweis[(Common Object Request Broker Architecture)], _SOAP/WS-\*_ #hinweis[(Simple Object Access Protocol
  Web Services)] tried to fix this, but they pretended the network didn't exist; they ran remote functions like local
ones. _Difficult to debug_, distributed computing fallacies applied. _CORBA:_ high complexity, inconsistent
implementations, poor interoperability. Solutions got _more complex_ than necessary.

*Context for REST:* The Web thrived with simple HTTP while enterprise systems had high complexity.

#pagebreak()
== REST Foundations
Rest is an _architectural style_, not a protocol or standard.

=== 6 constraints of REST
- *Client-Server:* _Separation of concerns_. Client handles presentation, server handles business logic. _Independent
  evolution_ possible.
- *Stateless:* Each request contains all needed info. Server _doesn't store client state_, each request must bring
  everything with it. _Easy scaling_, no session sharing.
- *Cacheable:* Responses must define themselves as (non-)cacheable. _Reduces network traffic_, _optimizes performance_.
- *Layered system:* Client can't tell if connected directly to end server. Proxies may be located between the client and
  server, client doesn't need to be aware of this. This simplifies _scaling_ and _security_.
- *Uniform interface:* Resources identified in request URL, _self-descriptive_ messages.
- *Code-on-demand:* Servers can optionally _extend client functionality_ by sending executable code to it.

=== HATEOAS
Hypermedia As The Engine Of Application State is a _self-describing API_ that directly outputs links to additional
related resources #hinweis[(e.g. a User object contains links to its orders, friends etc.)]. Not widely used, but
interesting concept. Complex.

== Common Misconceptions
- _JSON `!=` REST:_ JSON is just one representation, REST is format-agnostic.
- _HTTP `!=` REST:_ HTTP is an implementation of REST, but REST is an architectural style independent of protocol.
- _HTTP + JSON `!=` RESTful:_ You need to adhere to the constrains for your software to be RESTful #hinweis[(i.e.
    statelessness)].

/*== Modern REST CRUD examples
```
GET        /users/42     -> Retrieve user, is idempotent and safe (no server changes)
POST       /users        -> Create new user, not idempotent/safe, needs to return "201 created"
PUT        /users/42     -> Replace user completely, idempotent
PATCH      /users/42     -> Change user partially, depends on implementation if idempotent
DELETE     /users/42     -> Delete user, idempotent
```*/

== RESTful HTTP
Most HTTP APIs are only REST-like; they don't follow all REST principles.
=== HTTP methods
An HTTP method is _safe_ if it doesn't alter the state of the server and _idempotent_ if the intended effect on the
server of making a single request is the same as the effect of making several identical requests. A _cacheable response_
is an HTTP response that can be cached, that is stored to be retrieved and used later, saving a new request to the
server.
#table(
  columns: (auto,) * 4 + (1fr,),
  table.header([Method], [Safe], [Idempotent], [Cacheable], [Description]),
  [`GET`], cell-check, cell-check, cell-check, [Requests a resource],
  [`HEAD`], cell-check, cell-check, cell-check, [Same as `GET`, but without response body],
  [`OPTIONS`], cell-check, cell-check, cell-cross, [Describes communication options for target resource],
  [`TRACE`], cell-check, cell-check, cell-cross, [Performs message loop-back test],
  [`PUT`], cell-cross, cell-check, cell-cross, [Replaces target with the request content],
  [`DELETE`], cell-cross, cell-check, cell-cross, [Deletes the specified resource],
  [`POST`],
  cell-cross,
  cell-cross,
  cell-tilde,
  [Submits an entity to the specified resource #hinweis[(Side effects on server)]],

  [`PATCH`], cell-cross, cell-cross, cell-tilde, [Applies partial modifications to the resource],
  [`CONNECT`], cell-cross, cell-cross, cell-cross, [Establishes a tunnel to the server],
)
#v(-0.1em)
=== Status Codes
HTTP response status codes _indicate_ whether a specific HTTP request has been _successfully_ completed.
#grid(
  columns: (1.2fr, 1fr, 1fr),
  [
    *Classes:*
    - _100 - 100:_ Informational responses
    - _200 - 299:_ Successful responses
    - _300 - 399:_ Redirection messages
    - _400 - 499:_ Client error responses
    - _500 - 599:_ Server error responses

  ],
  [
    *Examples:*
    - _200_ OK
    - _201_ Created #hinweis[(with Location header)]
    - _301_ Moved Permanently
    - _400_ Bad Request
    - _401_ Unauthenticated
  ],
  [
    #v(1.3em)
    - _403_ Forbidden
    - _404_ Not Found
    - _418_ I'm a teapot #text(top-edge: "bounds", emoji.teapot)
    - _500_ Internal Error
    - _503_ Service Unavailable
  ],
)

=== HTTP headers
Let the client and the server pass _additional information_ with a message in a request or response.

#table(
  columns: (1fr, 2fr, 2fr),
  table.header([*Header(s)*], [*Purpose*], [*Example(s)*]),
  [
    *Content-Type / Accept*
  ],
  [
    Used for content negotiation. _Content-Type_ indicates the media type of the resource, _Accept_ informs the server
    about the types of data that can be sent back.
  ],
  [
    `Content-Type: text/html; charset=utf-8` \
    `Accept: <media-type>/<MIME_subtype>`
  ],

  [
    *ETag / If-None-Match*
  ],
  [
    ETag is a _unique string_ identifying the version of the resource. Conditional requests using If-Match and
    If-None-Match use this to change the behavior of the request. _Used to update caches._
  ],
  [
    `ETag: W/"<etag_value>"` \
    `If-None-Match: "<etag_value>"`
  ],

  [
    *Cache-Control*
  ],
  [
    _Directives_ for _caching mechanisms_ in both requests and responses.
  ],
  [
    `Cache-Control: max-age=180,`\ `no-cache, ...`
  ],

  [
    *Retry-After*
  ],
  [
    Indicates _how long_ the user agent should _wait_ before making a follow-up request. Usually sent with 429/503
    status code.
  ],
  [
    `Retry-After: <http-date>` \
    `Retry-After: <delay-seconds>`
  ],

  [
    *X-RateLimit-\**
  ],
  [
    Headers for rate limiting.
  ],
  [
    `X-RateLimit-Limit: ...` \
    `X-RateLimit-Remaining: ...` \
    `X-RateLimit-Reset: ...`
  ],
)


=== API Versioning
There are several common ways to version an API:

- _URL-based versioning:_ E.g. `/v1/...` Pragmatic, widely used because it's simple, explicit, easy to route and test.
  But not fully REST because the URL should identify the resource, not the API version.
- _Header-based versioning:_ E.g. `X-API-Version: 1`. Aligns better with REST principles because the resource URL stays
  stable. But less visible and more difficult to test.
- _Content negotiation:_ E.g. `Accept: application/api.v1+json`. The most RESTful approach, but also the most complex.
  Not widely used.

=== API Documentation
Good documentation is essential so users can understand and adopt the API correctly. _OpenAPI_ is the standard for
describing REST APIs. Error cases should also be documented! There are two approaches:

- _Design-first approach:_ Write the specification before writing the code. Results in a single source of truth, but
  code and specification can drift apart.
- _Code-first approach:_ Write code with annotations, generate the specification automatically. Documentation always in
  sync with code. OpenAPI/Swagger generates documentation for your API consumers.

=== Authentication / Authorization
_Authentication_ is the identification of the user while _authorization_ determines which resources an authenticated
user is permitted to access.
- *Basic Auth:* Transmits the credentials in the `Authorization` HTTP header with `username:password` in base64
  encoding. Does _not provide encryption for credentials_, only formatting for HTTP Header. Should _only be used with
  HTTPS_, otherwise login credentials are transmitted in the open. Used for internal tools, admin interfaces, content
  that is not public.
- *JWT (JSON Web Token):* Stateless, self-contained, signed token with claims. _Issued at login_ and _sent with every
  request_. Scales well, but is hard to revoke: _Token is valid until it expires_, which is problematic if it gets
  stolen.
- *OAuth2:* Grants access _without_ giving out _passwords_. Uses short-lived access tokens and optionally long-lived
  refresh tokens. Standard for modern APIs. Can use JWT or Basic Auth. Simpler than OAuth1.

=== Rate Limiting
Limits the number of requests per time window to prevent API abuse. If the limit is exceeded, the server returns _HTTP
429 (Too Many Requests)_. Common response headers are:

#table(
  columns: (1fr, 1.5fr),
  table.header(
    [Non standard header\ #hinweis[(widely used, but differing implementations)]],
    [Standard headers\ #hinweis[(currently being standardized)]],
  ),
  [
    - _`X-RateLimit-Limit`:_ Max requests
    - _`X-RateLimit-Remaining`:_ Requests left
    - _`X-RateLimit-Reset`:_ When the limit resets
    - _`Retry-After`:_ When the client should retry

  ],
  [
    - _`RateLimit-Limit`:_ Requests quota in the time window.
    - _`RateLimit-Remaining`:_ Remaining requests quota in the current window.
    - _`RateLimit-Reset`:_ Time remaining in seconds in the current window
    - _`RateLimit-Policy`:_ Contains a quota policy, defined by the server, that clients can use to control their own
      amount of requests to the server. Contains name of the policy, the limit and the window size.
  ],
)

_Browsers don't automatically obey Retry-After, but API clients should._

=== Best Practices for API Design
Use _nouns_, not verbs #hinweis[(`/users` not `/getUsers`)], _Plural_ for collections, _Hierarchies_ for relationships
#hinweis[(`/users/42/orders`)], _Meaningful error messages _in body, _test_ with _real_ HTTP clients.

== REST / Microservices
_REST's simplicity enabled Microservices._ Now we can use HTTP + JSON instead of CORBA/SOAP/WDSL which are very complex.
No special libraries, IDL #hinweis[(interface definition language)] compilers, or ORBs #hinweis[(Object Request Broker)]
needed. _Every_ language/framework can make HTTP requests.

REST is the _communication enabler_. Made it practical to break systems into many small services. Service-to-service
_communication_ became _simple_ because of REST.

REST and Microservices have a _symbiotic relationship_. REST provided the _communication protocol_ for Microservices.
But beware: _Easy communication does not automatically mean easy architecture._ Communication is solved, but everything
else gets more complex.

=== Microservices Challenges
- _Distributed system problems:_ Network latency, partial failures, CAP theorem #hinweis[(Distributed data cannot
    simultaneously be consistent, available and partition tolerant)], everything covered in our DSy Zusammenfassung
  #emoji.face.wink
- _Data Consistency:_ Accept eventual consistency #hinweis[(Data will be consistent eventually)], Saga pattern with
  compensating transactions #hinweis[(Sequence of local transactions, on failure compensating transactions get run to
    undo changes)], Idempotency through transaction ID for retries, 2PC #hinweis[(two-phase commit)] is slow and blocks
  resources.
- _Service discovery, load balancing:_ More complex, services need to be found #hinweis[(via
    Traefik/caddy/nginx/HAproxy)]
- _Observability:_ Logging, tracing and metrics needs to be collected from all microservices #hinweis[(three pillars)]
- _Deployment complexity:_ Container orchestration, Blue-green deployments #hinweis[(Two environments, current prod and
    current prod with new release. Test, then switch)], canary releases #hinweis[(Release new version to a small group
    of users first)].
- _Testing complexity:_ Integration testing across services are complex
- _API Gateway Pattern:_ Single entry point #hinweis[(Client only communicates with gateway)], cross-cutting concerns
  are implemented on gateway #hinweis[(auth, logging, rate limiting need to be implemented on every client)]. Gateway is
  single point of failure.
- _Circuit Breaker Pattern:_ Preventing cascading failures by stopping calls to an unhealthy dependency after repeated
  errors, returning a fallback and periodically retrying to see if the service has recovered. Often already included.
- _Operational overhead:_ More things to monitor, deploy, secure. Increased infrastructure costs, need for DevOps/SRE
  expertise.

== Modern landscape & Alternatives
Modern system architectures are diverse: _GraphQL_ fits data-driven apps, _gRPC_ is used for high-performance
service-to-service communication, _event-driven designs_ enable loose coupling, and _monolith-first_ / Modular Monolith
often works best for small projects.

_There is no one-size-fits-all:_ The right choice depends on the use case, team size, scaling needs, and acceptable
complexity. The key is to understand the trade-offs, choose deliberately, and be ready to evolve the architecture as
requirements change.

#table(
  columns: (2fr, 1fr),
  table.header([Alternatives to REST], [Alternatives to microservices]),
  [
    - _GraphQL:_ Solves the over/under-fetching problem #hinweis[(REST returns everything associated to an endpoint or
        needs multiple requests for getting the content)]. But N+1 Problem, every query can return different content.
    - _gRPC:_ When REST isn't enough. Has better performance, is binary. Good for service-to-service communication.
    - _Event-driven architectures_ via message queues. Decoupled, but more complex.
    - _WebSockets / Server-Sent Events (SSE):_ Real-time communication, bidirectional.
    - _tRPC:_ End-to-end type safety for TypeScript. Needs monorepository or sharing of types via npm packages,
      TypeScript only.
  ],
  [
    - _Monolith-first approach:_ Start simple, extract services later when needed.
    - _Modular monolith:_ Well-defined boundaries, can extract to services later if needed.
    - _Serverless / FaaS:_ Functions as a Services, function runs on server on event, only pay when function is run
      #hinweis[(AWS Lambda, Azure Functions)]
  ],
)

= Protocols
== Custom Protocols
Designing a custom protocol needs _more time_ to develop and test, but it can be _more efficient_
#hinweis[(space/performance)]. There are existing _protocol generators_ like Thrift, Avro, ProtoBuf. They work with an
_IDL_ #hinweis[(Interface description language)] to generate code. They are _standardized_, but have _more overhead_.

#grid(
  [
    == Serialization formats
    With _custom encoding/decoding_ you can control _every aspect_. But this needs time to develop, test and maintain.

    Little-endian and big-endian describe the sequential order in which bytes are converted into numbers.

    - _Little-endian:_ Most CPU Arches e.g. x86, ARM, RISC-V.
    - _Big-Endian:_ Networking, e.g. TCP headers

    _1:1 copy formats_ like Flatbuffers or Cap'n Proto use the same endianness on the wire and network.
  ],
  image("img/little-big-endian.png"),
)

#pagebreak()

== Protocol Examples
#table(
  columns: (auto, 1fr, 1fr, 1fr),
  table.header([], [ASN1], [Avro], [Protocol Buffers #hinweis[(ProtoBuf)]]),
  [*Description*],
  [Standard IDL for defining data structures that can be serialized/deserialized.],
  [Data serialization system, RPC framework],
  [Data serialization system from Google #hinweis[(designed to be smaller/faster than XML)].],

  [*Used in*],
  [e.g. X.509 #hinweis[(TLS certificates)]],
  [e.g. Hadoop #hinweis[(big-data framework)]],
  [Nearly all inter-machine communication at Google],

  [*Data format*],
  [Generic binary protocol],
  [Message defined in JSON or IDL -- no code generation],
  [Integers to identify fields, Contain only numbers, not field names],

  [*Example payload\ size* #hinweis[(compared to\ 48 bytes in XML)]],
  [21 bytes],
  [16 bytes #hinweis[(assuming both have the same IDL)]],
  [18 bytes],
)

== JSON Example
_JSON + REST/HTTP:_ Human readable text to transmit data. Often used for web apps. _More bytes _than gRPC / Trift
because field names are transmitted as text, but there is no schema required at wire level as it has a self-describing
format.

#grid(
  [
    #plus-list[
      + Universal support, easy debugging
      + No code generation required
    ]
  ],
  [
    #minus-list[
      + Larger size, slower parsing
      + No compile-time type safety
    ]
  ],
)


== RPC Examples

#table(
  columns: (auto, 1fr, 1fr),
  table.header([], [gRPC], [Thrift]),

  [*Description*],
  [
    RPC framework using HTTP/2 transport and Protocol Buffers.
  ],
  [
    RPC framework from Facebook using an IDL and a binary protocol.
  ],

  [*Features*],
  [
    Authentication, bidirectional streaming + flow control, blocking or nonblocking bindings, cancellation + timeouts,
    many languages.
  ],
  [
    Cross-platform support across many languages
  ],

  [*Example size*],
  [171 / 124 bytes #hinweis[(Wireshark measurement)]],
  [49 bytes transferred #hinweis[(Thrift encodes which function to call, larger size)]],
)

#pagebreak()

= Cloud Native Architecture
Generally a _trade-off_ between _flexibility_ and _complexity_.
#v(-0.5em)
#table(
  table.header(
    [Traditional Architecture],
    [Cloud native Architecture],
  ),
  [
    - Monolithic applications
    - Single database instance
    - Vertical scaling #hinweis[(bigger servers)]
    - Static infrastructure
  ],
  [
    - Distributed microservices
    - Multiple specialized data stores
    - Horizontal scaling #hinweis[(More instances)]
    - Automated CI/CD pipelines
    - Dynamic infrastructure #hinweis[(containers, orchestration)]
    - Rapid releases #hinweis[(hours/days)]
  ],
)
#v(-0.5em)

== Cloud native core principles
The _12-Factor app methodology_ from 2011 is still relatively correct. But adapt it to your use!
#grid(
  [
    + _Codebase:_ One codebase per service in version control
    + _Dependencies:_ Explicitly declare and isolate dependencies
    + _Config:_ Stored in environment variables
    + _Backing services:_ Treat backing services as attached resources
    + _Separation:_ Strictly separate build and run stages
    + _Stateless processes:_ Execute the app as one or more stateless processes #hinweis[(No data in the container
        itself)]
  ],
  [
    7. _Port binding:_ Export services with port binding
    + _Scaling:_ Scale out with the process model
    + _Robustness:_ Maximize robustness with fast startup and graceful shutdown
    + _Parity:_ Keep development, staging, and production as similar as possible
    + _Logs:_ Treat logs as event streams
    + _Admin tasks:_ Run admin and management tasks as one-off processes
  ],
)

- _Containerization:_ Docker/OCI containers is standard in many cases. Immutable artifacts, consistent environments.
- _Orchestration:_ Kubernetes for container management, auto-scaling based on load, self-healing #hinweis[(automatic
    restarts)], service discovery


== Self hosting -- traditional aproach
*On-prem infrastructure:* _Physical_ servers in data centers, _manual_ hardware provisioning. _Fixed capacity_ -- you
need to _over-provision_ for peak load. Direct control over hardware.\
*Operational reality:* 24/7 hardware _maintenance_, _manual_ OS patching and updates, backup/recovery _complexity_.
Often _underutilized_ resources #hinweis[(typical 10-30% utilization)].\
*Costs:* _High CapEx_ #hinweis[(Upfront investment in long-term assets)] , _Predictable OpEx_ #hinweis[(Ongoing running
  costs to operate and maintain systems)], _Staff overhead_ #hinweis[(sysadmins, network engineers)]

== Self hosting -- Cloud native approach
*Kubernetes on bare metal:* Container orchestration on your hardware, _software-defined infrastructure_. This still
requires _hardware_ management. _Hybrid model:_ self-hosted control plane #hinweis[(Cloud orchestration software)],
cloud workers.\
*Why self-host cloud native:* _Data sovereignty/compliance_ requirements. _Cost savings_ at scale #hinweis[(>100
  servers)]. Existing infrastructure investment, specific hardware needs #hinweis[(GPUs, specialized storage)]\
*Reality Check:* Kubernetes _complexity_ is real, requires specialized expertise. Updates and _security patching_ is
still _manual_. _Not_ always _cheaper_ than cloud #hinweis[(Consider total cost)].

== Cloud native data management patterns

- _Database per Service:_ Each _microservice_ owns its data. _Independent_ schema evolution, technology fit for purpose
  #hinweis[(e.g. SQL, NoSQL, graph)]. But: How to query across services?
- _Event Sourcing:_ Store events, not current state. Append-only log of changes. _Rebuild_ state by _replaying_ events.
  _Use case:_ Audit trails, temporal queries.
- _CQRS:_ Command Query Responsibility Segregation. _Separate_ write model from read model and optimize each
  independently. _Example:_ Write to normalized DB, read from denormalized cache.
- _Eventual Consistency_: _Accept_ temporary _inconsistency_. Systems converge to consistent state over time.
  _Trade-off:_ Complexity vs. availability.

== Trade-offs and Considerations
#table(
  columns: (1fr, 2fr),
  table.header([Traditional], [Cloud Native]),
  [
    #plus-list[
      + Lower complexity
    ]
    #minus-list[
      + Less flexibility
    ]

    *Use for:*
    - _Small applications_ with predictable load
    - _Small_ development team
    - _Simple_ data models
    - _Low_ deployment frequency acceptable
  ],
  [
    #plus-list[
      + Better scaling and flexibility
    ]
    #minus-list[
      + Adds operational complexity
      + Operational overhead: monitoring, tracing, logging
      + More services = more failure modes
      + Cost: Cloud bills can be high, idle containers still cost money, self-hosting requires expertise.
    ]

    *Use for:*
    - Need to scale specific services _independently_
    - _Unpredictable_ load patterns
    - _Large_ distributed teams
    - _Frequent_ deployments #hinweis[(multiple times per day)]

    *Rule of thumb: Cloud native pays off at scale.*
  ],
)

= API Design
== Error Report Pattern
Use a _standardized error format_ #hinweis[(e.g. JSON or XML)] across _all endpoints_ so clients can implement _one
consistent error-handling_ approach. A _universal schema_ reduces parsing effort and enables _automatic_ monitoring and
alerting.

==== Machine-readable vs. human-readable
Provide both, but keep them separate.

- _Error codes for client logic:_ Differentiated retry logic, specific UI reactions. Should be consistent, stable and
  documented.
- _Messages for Users:_ Should be clear and understandable, safe to show to end users.

==== Error codes vs. HTTP status codes
Use _HTTP status codes_ for transport/protocol-level #hinweis[(e.g. 400, 404, 500)] and _App codes_ for business logic
#hinweis[(e.g. insufficient funds, user not verified)]. This separation improves error diagnosis.

The _RFC 7807 Problem Details format_ is a _standard structure_ for error responses. It defines _common fields_ like
`type`, `title`, `status`, `detail` and `instance`. It is a _machine-readable_ structure for _automated error handling_,
but sadly not very often used.

==== Field-level validation errors
Validation errors should be _mapped_ to the _specific input fields_ that failed, so the API clearly states _which field
caused which error_. Used with serialization / deserialization.

- _Backend validation:_ Mandatory as the only reliable security layer
- _Frontend validation:_ Is optional, used for UX. Should always be consistent with the backend validation.

==== Actionable error messages for clients
Errors should explain _what went wrong_ and _how to fix it_. Generic messages like "500 error" are useless, messages
that _explain_ the error #hinweis[(e.g. "Gateway timeout -- retry after 30 seconds")] or machine-actionable responses
#hinweis[(`Retry-After` header)] are far more _useful_.

==== Error correlation IDs for tracing
Always include a _unique ID_ per request for log correlation. This is _essential for debugging_ distributed systems and
enables end-to-end _request tracking_ when users report an issue.

== Error Logging
Error logging is the foundation for operations and debugging. _Always log_, and include enough context to reconstruct
what happened.

_Handle_ and _test_ error logging for requests, database, business logic, network, disk, ...\
_For each scenario:_ add specific error code, clear messages, sufficient context. Systematically test the error handling
#hinweis[(not only the happy path)].

==== Log levels
- _`INFO`:_ normal operational events #hinweis[(e.g. successful requests)]
- _`WARN`:_ unusual conditions that could become errors #hinweis[(e.g. slow DB, degraded state)]
- _`ERROR`:_ failed operations #hinweis[(e.g. failed requests, external API failures)]
- _`FATAL`:_ critical failures threatening system availability #hinweis[(e.g. lost DB connection, loss of critical
    resources)]

Set the log level per environment. The _DEV environment_ can run in the level _DEBUG_, the _LOCAL environment_ in the
level _TRACE_ #hinweis[(max detail)], while _TEST/STAGE and PROD_ should run with the level _INFO_. Try to _balance_
signal-to-noise-ratio, performance and diagnosability.

==== Good logging practices
- _Use meaningful messages:_ Write what exactly went wrong and how to fix it.
- _Never log sensitive data outside local/dev:_ Passwords, API keys, personal data, pictures of your mum. Assume that
  logs can be read by every employee.
- _Include all relevant data:_ correlation ID #hinweis[(in distributed systems)], timestamp, HTTP status code / error
  code, request path / method, client IP / user ID #hinweis[(if available)], detailed error message or stack trace
  #hinweis[(but don't return stack trace to user)].

*Structured logging:*
_Prefer structured logs in JSON for larger Projects._ There are _tools_ for this which enable _search_, _analysis_ and
_alerting_, but this is _overkill_ for most small projects.

== Rate Limiting
Rate limiting _protects_ services from _overload_ and _abuse_. A _single faulty client_ mustn't degrade availability for
_all_.

==== Algorithms
- _Token Bucket / Leaky Bucket:_ Steady outflow, allows traffic bursts as long as the average rate stays within limits.
- _Sliding Window:_ More accurate rate enforcement, continuous counting instead of fixed intervals.

Return _`HTTP 429 Too Many Requests`_ when the limit is exceeded so clients can react. This is required for compliance
with HTTP semantics.

*Standard Headers:* `X-RateLimit-Limit`, `X-RateLimit-Remaining` #hinweis[(How many requests are left)],
`X-RateLimit-Resest` #hinweis[(How long until the limit resets, mainly used with window-based limits)]. This enables
_intelligent retry scheduling_.

==== Graceful degradation
Fallback responses or reduced functionality, _maintain partial service during overload_. Prioritize _critical_ endpoints
#hinweis[(e.g. login)] _before low-priority_ read-only endpoints #hinweis[(e.g. analytics dashboard)]. Return
reduced/summary data if needed.

#grid(
  columns: (1.5fr, 1fr),
  [
    ==== Monitoring and Alerting
    _Track_ sustained rate limit breaches to _detect abuse_ or _buggy clients_ early. Trigger _incident response
    workflows_ if necessary #hinweis[(alerts, automatic blacklisting, contact customer regarding legitimate misuse)].

    Rate limit can be implemented in different layers:
    - _Application-level:_ Middleware or directly in the service/backend. More flexible for business rules, but requires
      code changes.
    - _Infrastructure-level:_ Reverse Proxy, API Gateway Tools. Centralized interface before backend. No code changes,
      but less flexible for business logic.

    _Best practices is a combination:_ Rough limitations on the gateway, fine-grained rules in the service.
  ],
  [
    ```
    {
      auto_https off
    }
    :8080 {
      rate_limit {
        zone api_zone {
          key {remote_host}
          events 100
          window 1m //window rate limiter
        }
      }
      file_server
      root * /srv
    }
    ```
  ],
)

== Pagination
Pagination is essential for large APIs. Without it, clients might need to download _millions_ of records at once,
causing _poor performance_ and _bad UX_ on the client side and high unnecessary resource use on the server side.

==== Offset vs. Cursor
Both solve paging, but differ in performance, reliability and complexity. In most cases, cursor pagination is better.

- *Offset pagination:* Client sends `offset + limit` #hinweis[(e.g. fetch rows 101-110)]. This leads to _performance
  issues_, because the DB needs to load, scan and skip the first 100 entries which has a performance of $O(n)$. There
  are also _consistency issues_ with dynamic data because inserts/deletes can cause duplicates or missing records
  between pages.
- *Cursor pagination:* Client sends a custom marker #hinweis[(e.g. composite index from id and timestamp)], DB uses
  `WHERE` clause to jump _directly_ to the correct position. This has _way better performance_ and scales consistently
  with dataset size. It is also _stable under changes_ because it follows a logical record and not a numeric position.
  But the marker needs to have a DB index to actually improve performance.

==== Implementation requirements
- _Opaque tokens:_ hide internal structure, prevent tampering #hinweis[(don't use your primary key)]
- _Composite index_ on sort fields #hinweis[(often `created_at` + `id`)]
- _Stable sort order:_ must be deterministic/unique
- _Cursor expiration:_ prevent stale state exploitation

*GraphQL:* has a built-in cursor pagination via Relay Connection spec. Uses edges, pageInfo, first/after/last/before.

#grid(
  columns: (1.5fr, 1fr),
  [
    ==== Critical pitfalls
    - _Missing/wrong index:_ Fallback to full table scan with $O(n)$ queries
    - _Non-unique sort keys:_ Leads to inconsistent ordering/results
    - _Poor index design:_ Can be worse than no index
  ],
  [
    ==== Tradeoffs
    - Cannot _jump_ to _arbitrary_ pages
    - Higher implementation _complexity_
    - _Multiple indexes_ for multiple sort options
  ],
)
For _small/static datasets_, internal tools where _simplicity_ matters or if you need _page numbers_ or _random access_,
_offset_ is the _better choice_. The need for random access can be minimized by providing ample filter criteria.

== Request Bundle / Batch Operations
Batching combines _multiple operations_ into a _single HTTP call_ to _reduce_ network roundtrips, latency, and
connection overhead. This is especially valuable for _mobile clients_ with high latency or unstable connections.

==== Execution Models
- *Atomic batch:* Behaves like a transaction. If _one_ operation _fails_, _everything_ is _rolled back_. This _ensures
  consistency_ but requires _transactional backend support_.
- *Non-atomic batch:* Each operation is _independent_. Return per-operation status in the response body. Use
  `207 Multi-Status` for mixed outcomes #hinweis[(exact failures in body)], `400` for a malformed batch input.

==== Critical constraints
- *Size limits:* Enforce max operations per batch to _prevent DoS_. _Document_ limits and require clients to split large
  batches.
- *Complexity limits:* Keep batches flat if possible, _avoid nested/recursive dependencies_ to _conserve_ server
  resources. Ensures _bounded execution_.
- *Transaction boundaries:* Avoid cross-resource batches that span databases, _limit scope_ to a single data store.
  _Prevents_ distributed transaction _complexity_.

==== Error handling
Return _structured aggregated_ errors as an _array_ of _per-operation errors_ instead of generic 500s. This enables
_client-side recovery logic_ and aligns with RFC 7807 error patterns.

#pagebreak()

== Long Running Requests & Event-Driven API
Important concept for operations that take _longer than a few seconds_. Should not block HTTP connections, instead
_return a `202 Accepted` immediately_ and then _process_ the request _asynchronously_.

Return a job ID in the response body and in the location header so the client can poll the job status or cancel it
#hinweis[(e.g. `GET /jobs/{id}` with status: pending/processing/succeeded/failed)]. A poll response may include a
percentage and estimated time remaining to use for example in progress bars.


*Polling* is _simpler_ to implement than push, no firewall/NAT issues. Client controls request timing, no server
infrastructure for webhooks needed. _Disadvantage:_ Adds constant overhead because of repeated requests.\
*Push* reduces polling overhead. There are three options:
- _Webhooks:_ Efficient for real-time events. Server pushes updates immediately, but requires openly accessible endpoint
  #hinweis[(Not possible with a firewall)]
- _WebSockets:_ Bidirectional real-time communication, long-lived connections. Best for frequent bidirectional updates,
  but needs more complex infrastructure.
- _Server-Sent Events (SSE):_ Simpler than WebSockets for server `->` client push #hinweis[(but no support for client
    `->` server)]. Uses standard HTTP, easier to implement than WebSockets.

==== Webhook delivery (push model)
- _Registration:_ Done by client. `POST /webhooks` with url, `event_types`, `secret` #hinweis[(string for HMAC key)].
- _Verification:_ Done by server. Server calculates HMAC-SHA256 signature in `X-Signature` header. Client needs to
  validate signature before processing.

*Retry policy:* Exponential backoff #hinweis[(1s, 2s, 4s, 8s, 15m, 30m)]. After repeated failures disable webhook and
notify client.

*Result & completion:* Webhook push with signed payload for real-time notification. Ensures delivery despite client
downtime.

*Result retrieval:* With `GET /jobs/{id}/result`. Expires after 24–72h #hinweis[(TTL enforced)]. This limits storage
cost. Cancellation is idempotent #hinweis[(`POST /jobs/{id}/cancel`)].

*Developer experience:* You should provide a `/webhooks/test` endpoint with sample payload and signature.

== Backend for Frontend (BFF)
Create _client-specific adapter:_ Tailor API response for mobile, web or TV -- _no overfetching_. Optimizes payload for
device constraints, reduces bandwidth and parsing cost.

*Aggregation layer:* _Merge_ data from _3+ microservices_ into a _single response_. This _reduces_ client _roundtrips_,
_minimizes_ network calls and _improves_ perceived performance.

*Client-specific optimizations:* Minimize payload size for mobile, prefetch related data, support offline caching.
_Essential for low-bandwidth environment._

- _GraphQL BFF:_ Expose different schema per client. This allows field selection and avoids versioning churn.\
- _REST BFF:_ Version endpoints via `/v2/mobile/users`, avoid breaking existing clients.

*Multi-Platform management:* Isolate BFF per platform for versioning. Enables _independent release cycles._

*Security:* BFF is a _trusted client_ -- authentication happens in BFF, calls from then on happen with service accounts.

#pagebreak()
== API Lifecycle Management
Ensures that APIs can be systematically _updated without affecting_ existing clients.

There are multiple ways to introduce new changes:
- _Feature flags:_ Enable new behavior for internal/test clients before public release. Gradual rollout.
- _Experimental endpoints:_ Mark with `/v1/experimental/` -- no SLA, subject to removal. This clearly identifies
  unstable endpoints.
- _Beta/Alpha labeling:_ Use `/v1/beta/users` or `Accept:application/vnd.myapi.v1+beta`. Also clearly identifies
  unstable endpoints.

==== Deprecation Process
_Announce deprecation_ via email, dashboard and sunset header
#hinweis[(`Sunset: Wed, 31 Dec 2025 23:59:59 GMT; rel="deprecation"`)] at least 90 days in advance. _Monitor_ usage of
deprecated endpoints and alert when more than 1% of the traffic remains.

*Enforcement:* Block access to sunset endpoints using TTL -- return a `410 Gone`.

There is always _risk of poor management:_ People ignore deprecation which leads to sudden outages, compliance risks,
customer churn.




