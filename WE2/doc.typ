#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)


// ----------------------------------
// TODO:
// #let (
//   add-note,
//   add-answer-note,
//   add-hd-note,
//   deftbl,
//   defbox,
//   exbox,
// ) = tanki-utils(gen-id(info.module))
// 



// Alternative replacements:
#let add-note(content) = block(
  stroke: 1pt + blue,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  content
)
#let add-answer-note(content) = block(
  stroke: 1pt + green,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  content
)
#let add-hd-note(title, content) = block(
  stroke: 1pt + purple,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  [ 
    #title
    #content
  ]
)
#let deftbl(..args) = block(
  stroke: 1pt + orange,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  table(
    ..args
  )
)
#let defbox(content) = block(
  stroke: 1pt + red,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  content
)
#let exbox(content) = block(
  stroke: 1pt + gray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  content
)
// ----------------------------------



= Information security

#deftbl(
  [Information],
  [An organization's data that has been processed, organized, or structured in a
    way that gives it meaning and value to an organization or individual.],
  [Information security],
  [Protection of the integrity, confidentiality and availability of information
    data whether in storage, transit or processing.],
  [non-repudiation],
  [prevents parties from denying actions they have performed.],
  [accountability],
  [ability to trace actions and decisions back to a specific person or system.],
  [authentication],
  [verifies the identity of a user or system.],
  [authorization <authorization>],
  [determines what actions an authenticated entity is allowed to perform.],
  [access control],
  [restricts access to resources based on defined rules.],
  [business continuity],
  [ensures critical operations continue during disruptions.],
  [security policy],
  [a rule or expectation for protecting information.],
  [compliance],
  [adherence to laws, regulations, and (security-)standards.],
  [asset],
  [
    any item of value belonging to an organization
    - For example: information, systems, people and processes
  ],
  [attack],
  [an act that intends to damage, steal or degrade an organizations assets],
  [vulnerability],
  [a flaw or weakness in a system that can be abused],
  [exploit],
  [a technique or method used to take advantage of a vulnerability],
  [threat],
  [an event or action with the potential to cause harm by exploiting a
    vulnerability],
  [risk],
  [the likelihood of a threat exploiting a vulnerability and the potential harm
    that could cause],
  [control],
  [
    a measure designed to reduce the potential risk of an attack
    - Can be achieved through training employees, enforcing policies or
      implementing technology
  ],
)

== Types of information


- Personal information
- Business information
- Financial information
- Intellectual property
  - Copyright
  - Trademarks
  - Patents
  - Trade secrets
- System information



== How can information be attacked

)
- In storage
  - Data that is stored on a server or in a database short-term or long-term.
- In transit
  - Data that is currently being transported from one place to another.
- In use
  - Data that is currently being processed by a service or another entity.



== Components of an Information System (IS)

)
- Software
- Hardware
- Data
- People
- Procedures
- Networks



== Balancing security and system usability

)
- Obtaining perfect information security is impossible.
- Security needs to protect the system without slowing people down.
- Too much security can lead to workarounds.
  - Example: If strong passwords are enforced, people might start writing them
    down on sticky notes.
- Too much convenience exposes the system to unnecessary risks.
- It's all about finding that sweet spot between security and usability.
  - Example Solution: Employees must use multi-factor authentication. This way,
    they are free to use a less secure password without compromising the overall
    security.
- An even better, continuously review policies and involve users to find the
  best solution.



== Implementation of information security

// )
// #align(center, diagram(
  // node-fill: colors.bg,
  // node((0, 0), shape: (node, extrude, ..) => cetz.draw.line(
  //   (0, 1),
  //   (-5, -7),
  //   (5, -7),
  //   close: true,
  // )),
  node((-1.75, -1), "Top-down approach"),
  edge((-1.75, 5.5), "->", stroke: 2pt),
  node((1.75, -1), "Bottom-up approach"),
  // edge((1.75, 5.5), "<-", stroke: 2pt),

  node((0, 0), "CEO", name: <ceo>),

  edge(<ceo>, <cfo>),
  edge(<ceo>, <cio>),
  edge(<ceo>, <coo>),

  node((-1, 1), "CFO", name: <cfo>),
  node((0, 1), "CIO", name: <cio>),
  node((1, 1), "COO", name: <coo>),

  edge(<cio>, <ciso>),
  edge(<cio>, <vp-sys>),
  edge(<cio>, <vp-net>),

  node((-1, 2), "CISO", name: <ciso>),
  node((0, 2), "VP-Systems", name: <vp-sys>),
  node((1, 2), "VP-Networks", name: <vp-net>),

  edge(<ciso>, <security-mgr>),
  edge(<vp-sys>, <systems-mgr>),
  edge(<vp-net>, <network-mgr>),

  node((-1, 3), [security\ mgr], name: <security-mgr>),
  node((0, 3), [systems\ mgr], name: <systems-mgr>),
  node((1, 3), [network\ mgr], name: <network-mgr>),

  edge(<security-mgr>, <security-admin>),
  edge(<systems-mgr>, <systems-admin>),
  edge(<network-mgr>, <network-admin>),

  node((-1, 4), [security\ admin], name: <security-admin>),
  node((0, 4), [systems\ admin], name: <systems-admin>),
  node((1, 4), [network\ admin], name: <network-admin>),

  edge(<security-admin>, <security-tech>),
  edge(<systems-admin>, <systems-tech>),
  edge(<network-admin>, <network-tech>),

  node((-1, 5), [security\ tech], name: <security-tech>),
  node((0, 5), [systems\ tech], name: <systems-tech>),
  node((1, 5), [network\ tech], name: <network-tech>),
))
#table(
  columns: (1fr, 1fr),
  table-header([Bottom-Up], [Top-Down]),
  [
    - Initiated by an organization’s technical staff (system engineers, admins,
      etc.).
    - Implementations happen before policies are defined.
    - Often lacks support from management, budget and consistency.
    - Generally less effective and not scalable in large organizations.
  ],

  [
    - Initiated and supported by an organization’s upper management.
    - Policies come first and provide guidance for implementations.
    - Ensures proper funding, authority and organization-wide enforcement.
    - Generally more effective and in-line with the business strategy
  ],
)

== Non-Repudiation and Accountability

)
Example of security controls through which non-repudiation can be established:
Digital certificates, session identifiers, transaction logs, etc.

>


=== Accountability

)
- Being responsible or obligated for actions and results.
- Non-Repudiation is an essential part of accountability. A suspect cannot be
  held accountable if they can repudiate the claim against them.



== STRIDE Model

)
A structured model developed by Microsoft used in cybersecurity to identify and
categorize threats to systems by looking at how they can be attacked.


#todo("Authenticity")
#deftbl(
  [S(poofing)],
  [Pretending to be someone else. (see #link(<confidentiality>, "Authenticity"))],
  [T(ampering)],
  [Unauthorized data modification or altering. (see #link(<integrity>, "Integrity"))],
  [R(epudiation)],
  [Denying actions without proof. (see #link(<non-repudiation>, "Non-Repudiation"))],
  [I(nformation disclosure)],
  [Exposing sensitive information. (see #link(<confidentiality>, "Confidentiality"))],
  [D(enial of service)],
  [Making systems or services unavailable. (see #link(<availability>, "Availability"))],
  [E(levation of privilege)],
  [Gaining unauthorized rights or
    privileges./* FIXME: wtf (see #link(<authorization>, "Authorization"))*/],
)


== McCumber Cube

)
#grid(
  columns: 2,
  [
    #tr([Y-Axis: Security Goals (C.I.A. Triad)])

    - Defines what needs to be protected.

    #td([X-Axis: Information States])

    - Describes where the information exists.

    #tg([Z-Axis: Safeguards / Controls])

    - Defines how protection is implemented.
  ],)



= Threat categorization

#deftbl(
  link(<social-engineering>, [Social Engineering]),
  [Manipulating people to reveal confidential information.],
  link(<software-attacks>, [Software Attacks]),
  [Exploiting vulnerabilities in software to gain access to a system or steal
    data.],
  link(<denial-of-service>, [Denial of Service]),
  [Overloading one or multiple systems to make it unavailable.],
  link(<webapp-attacks>, [Web Application Attacks]),
  [Exploiting vulnerabilities in websites or servers hosting websites.],
  link(<password-attacks>, [Password /\ Authentication Attacks]),
  [Attempting to bypass or compromise login systems to gain unauthorized
    access.],
  link(<physical-threats>, [Physical Attacks]),
  [Bypassing technical controls by accessing physical infrastructure directly.],
)
 
#deftbl(
  [Phishing],
  [Forged emails impersonating legitimate entities.],
  [Spear Phishing],
  [Targeted phishing against specific individuals.],
  [Vishing],
  [Voice-based phishing over phone or video calls.],
  [Smishing],
  [SMS / Text-based phishing.],
)
 
#deftbl(
  [Virus],
  [Malware that attaches to programs and spreads.],
  [Worms],
  [Self-replicating malware that spreads over a network.],
  [Trojan Horse],
  [Malicious software disguised as legitimate applications.],
  [Ransomware],
  [Malware that encrypts victim’s data and demands payment to restore access.],
  [Rootkits],
  [Stealthy tools that hide malicious activity and maintain privileged access.],
)
 
#deftbl(
  [DoS],
  [Single source denial of service attacks.],
  [DDoS],
  [Denial-of-service attacks performed by multiple attackers or attacking
    devices.],
  [Botnet],
  [A network of compromised computers and other devices controlled by an
    attacker and used to together to flood a target with excessive traffic.],
  [SYN-Flood Attack],
  [Sending many connection requests without completing them.],
  [Reflection Attack],
  [Attacker sends requests to a service and spoofs the victim’s IP making the
    service send (many) replies to the victim instead of back to the attacker.],
)

#deftbl(
  [SQL Injection],
  [An attacker inserts malicious SQL commands into an input to manipulate a
    database and access, modify, or delete data.],
  [Cross-Site Scripting (XSS)],
  [An attacker injects malicious scripts into a website that execute in other
    users’ browsers to steal sensitive data.],
  [Cross-Site Request\ Forgery (CSRF)],
  [An attacker tricks a logged-in user’s browser into sending unauthorized
    requests to a web application on their behalf.],
  [Broken Authentication],
  [Weak authentication mechanisms allow attackers to compromise passwords,
    sessions, or identities to gain unauthorized access.],
)
 
#deftbl(
  [Rainbow Table Attacks],
  [Attackers using precomputed hash lookup tables to reverse weakly hashed
    passwords back into plaintext.],
  [Password Spraying],
  [Attackers trying a few common password like “password” across many accounts
    to avoid lockouts or timeouts.],
  [Credential Stuffing],
  [Attackers using leaked usernames and passwords from previous breaches to
    attempt logins on other services.],
  [Brute Force Attack],
  [Attackers repeatedly try many username and password combinations until they
    successfully gain access to an account.],
)

#add-hd-note(
  "Physical threats",
  [Threats or attacks that affect the physical infrastructure supporting
    information systems, usually bypassing technical controls overall.],
) <physical-threats>

#deftbl(
  [Theft of devices],
  [Attackers physically steal hardware to gain direct access to stored data,
    credential, internal systems, or other sensitive data.],
  [Hardware tampering],
  [An attacker modifies or implants malicious components in physical equipment
    to intercept data, bypass security, or disrupt operations.],
  [Power disruption],
  [Attackers interrupt or manipulate power supply to shut down or destabilize
    critical systems or services impacting availability and business
    continuity.],
  [Environmental damage],
  [Natural or deliberate environmental events that damage infrastructure,
    causing data loss, downtime, or destruction of critical systems (e.g.,
    earthquake, fire).],
)

= Information Security Management


== Information Security Governance

)
The system by which an organization directs and controls its information
security strategy to ensure that it supports business objectives, manages risk
appropriately, and complies with legal and other regulatory requirements.



Strategic Direction
)
- Defining security objectives aligned with business goals.



Leadership and Accountability
)
- Having clear roles and responsibilities for security decisions.



Risk Management
)
- Defining risks and ensuring they are identified and addressed appropriately.



Regulatory Compliance
)
- Ensuring adherence to laws and regulations (e.g. NIS2, HIPAA, CRA)


#{
  let node = (p, t, ..args) => node(
    p,
    width: 26em,
    align(left, t),
    ..args.named(),
  )
  let n2 = (p, t, ..args) => node(
    p,
    width: 16em,
    align(left, t),
    ..args.named(),
  )
}

#todo("change <note> to <deftbl>")


== Information Security Management System (ISMS)

)
A structured framework used to systematically manage and protect an
organization’s assets through various policies, processes and controls

Security governance defines *what* an organization wants to achieve. An ISMS
defines *how* the organization wants to manage it.



Enterprise Information Security Policy (EISP)
)
- The information security policy that sets the strategic direction and scope
  for all an organization's security efforts.



Risk Management Process
)
- Definition of processes to identify assets, analyze threats and evaluate risk.



Security Awareness and Training
)
- Educational programs to ensure employees understand their security
  responsibilities.



Monitoring, Measurement and Audits
)
- Ongoing evaluation of control effectiveness and ISMS performance.



= Policy

)
A high-level, management-approved rule that defines mandatory organizational
behavior and translates external laws and regulations into enforceable internal
requirements.


#deftbl(
  [policy],
  [instructions that dictate certain behavior within an organization.],
  [guidelines],
  [non-mandatory recommendations employees may use as a reference.],
  [procedures],
  [step-by-step instructions designed to assist employees in following
    policies.],
  [practices],
  [examples of actions that illustrate compliance with policies.],
  [standard],
  [a detailed statement of what must be done to comply with a policy.],
  [de jure standard],
  [a standard that has been formally evaluated and approved by a formal
    standards organization],
  [de facto standard],
  [a standard that is widely adopted or accepted by a public group.],
)


_What does a policy do?_
)
Establishes authority, accountability, and responsibilities for protecting
information assets. Provides the foundation for standards, procedures and
guidelines.



_Who is responsible for policies?_
)
Policies are created and approved by senior management, ensuring organizational
commitment. Management is responsible for enforcement while employees and users
are responsible for compliance.



_How is a policy enforced?_
)
By clearly communicating it to all relevant parties, integrating it into
standards and procedures, monitoring compliance through audits and oversight,
and applying defined disciplinary measures when violations occur.



Cyber Resilience Act (EU)
)
- Requires secure-by-design digital products and vulnerability management
  (starting December 2027).



Health Insurance Portability and Accountability Act (U.S.)
)
- Requires administrative, technical, and physical safeguards for protecting
  patient health data from disclosure.



NIS2 Directive (EU)
)
- Mandates cybersecurity risk management and incident reporting for critical and
  important entities.



Local Laws
)
- Many regions have their own data protection or breach notification laws in
  additional to national or EU regulations.



== Designing effective policies

)
+ Development
  - Policies must align with organizational goals, business risks and legal
    requirements.
+ Distribution
  - Policies must be distributed to all affected entities in a timely manner.
+ Comprehension
  - Policies must be readable for, available to and read by all affected
    entities.
+ Compliance
  - Policies must be formally agreed to by act or affirmation.
+ Enforcement
  - Policies must be uniformly applied to all affected entities.
+ Review
  - Policies must be reviewed regularly in a changing environment.



== Enterprise Information Security Policy (EISP)

)
The high-level information security policy that sets the strategic direction,
scope and tone for all an organization's security efforts and policies.

- Guidance for the development, implementation and management of the security
  program.
- Sets the requirements that must be met by the information security blueprint.
- Defines the purpose, scope, constraints and applicability of the security
  program.
- Assigns responsibilities for the various areas of information security.
- Addresses legal compliance.



=== Elements of an EISP

)
Although the content of EISP documents varies among organizations, most EISP
documents should include the following elements.

- Statement of Purpose
  - Statement of intent that defines the scope, objectives, and purpose of the
    enterprise information security policy and establishes its role as the
    foundation for all supporting security documents.
- Information Security Elements
  - Definition of information security that outlines the core principles and
    concepts, including confidentiality, integrity, and availability, guiding
    the organization’s security efforts.
- Need for Information Security
  - Definition of the importance of information security within an organization
    and its legal and ethical responsibility to protect information about
    customers, employees, and markets.
- Information Security Responsibilities and Roles
  - Description of the organizational structure that supports information
    security, including defined roles and responsibilities for management,
    employees, and users, as well as responsibility for maintaining the policy
    itself.



== Issue-Specific Security Policy

)
An organizational policy that provides detailed, targeted guidance to instruct
members of an organization in the use of a specific resource.

- Supports the EISP by translating it into an issue-specific guidance.
- Establishes rules for access, monitoring, and protection of the resource.
- Defines acceptable and unacceptable use of the specified technology or
  resource.
- Assigns responsibilities and accountability to users, administrators, and
  management.



= Risk analysis

)
The process of identifying assets, threats, and vulnerabilities, and evaluating
the likelihood and impact of potential adverse events to determine the level of
risk.



== Identifying Assets

#deftbl(
  [Asset],
  [Any resource that has some kind of value to an organization and therefore
    requires protection.],
  [Information Assets],
  [Customer data, intellectual property, source code, etc.],
  [Technical Assets],
  [Services, applications, databases, networks, etc.],
  [Physical Assets],
  [Servers, devices, facilities, infrastructure, etc.],
  [Human Assets],
  [Employees, administrators, contractors, key personnel, etc.],
  [Business Process Assets],
  [Critical operational workflows],
)


== Classifying Assets

)
The process of assigning every asset to a class based on their value,
sensitivity and impact if compromised


#deftbl(
  [Public],
  [Information that can be shared without risk],
  [Internal],
  [Information for organization internal use only],
  [Confidential],
  [Sensitive information that could cause harm if disclosed],
  [Restricted],
  [Highly sensitive, strictly limited and strongly protected information],
)


== Identifying Threats

)
A potential event, actor, or action that could exploit a vulnerability and cause
harm to an asset.

Examples: Power outage, insider threat, vishing attack



== Security Controls

)
Measures to reduce risk by detecting, preventing, responding to, or mitigating
threats to organizational assets.

#todo("belongs into information security management")

=== Types

#deftbl(
  [Administrative /\ Management Controls],
  [Policies, procedures, security training, security governance, etc.],
  [Technical / Logical Controls],
  [Firewalls, encryption, access control systems, system hardening, etc.],
  [Physical Controls],
  [Physical locks, surveillance cameras, secure access badges, turnstiles,
    etc.],
)

=== By Function

#deftbl(
  [Preventive Controls],
  [Stop incidents before they occur.\ e.g., Firewalls, access control,
    encryption, etc.],
  [Detective Controls],
  [Identify incidents when they occur.\ e.g., Intrusion detection, log
    monitoring, SIEM, CCTV, etc.],
  [Corrective Controls],
  [Limit damage and restore systems after an incident.\ e.g., Backups, system
    restore, incident response, etc.],
  [Deterrent Controls],
  [Discourage malicious behavior.\ e.g., Warning banners, monitoring notices,
    disciplinary policies, etc.],
  [Compensating Controls],
  [Reduce risk when a primary control cannot be implemented.\ e.g., Network
    isolation, layered security, alternative safeguards, etc.],
)


== Business Continuity Management

)
Ensures that critical business functions can continue during and after incidents
or disruptions such as cyberattacks, system failures, or physical incidents.

Even with strong security controls in place, incidents can and will still occur
at some point. BCM prepares the organization to operate and recover during these
times.


=== Key Objectives


== Security and Awareness Training

)
A coordinated program designed to ensure that all members of an organization
understand their security responsibilities and have the knowledge and skills to
protect information assets.

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  table-header(
    [],
    [Awareness (Level 1)],
    [Training (Level 2)],
    [Education (Level 3)],
  ),
  [Objective],
  [
    Seeks to teach members of an organization *what* security is and what to do
    in certain situations
  ],
  [
    Seeks to train members of an organization *how* they should react and
    respond to certain situations
  ],

  [
    Seeks to educate members of an organization as to *why* the organization
    reacts the way it does
  ],

  [Complexity\ Level],
  [
    Offers *basic information* about threats and responses
  ],
  [
    Offers more *detailed knowledge* about detecting threats and teaches skills
    needed for effective reaction
  ],
  [
    Offers the background and *depth of knowledge* to gain insight into how
    processes are developed and enables ongoing improvement
  ],

  [Teaching\ Method],
  [
    - Videos
    - Newsletters
    - Posters
    - Informal Training
  ],
  [
    - Informal Training
    - Workshops
    - Hands-on Practice
  ],
  [
    - Theoretical Instruction
    - Discussions / Seminars
    - Background Reading
  ],

  [Impact\ timeframe], [Short-term], [Intermediate], [Long-term],
)



== Gap Analysis

)
The process of comparing an organization’s current security posture with a
required or desired target to identify missing or insufficient controls.

- Risk Analysis: What could go wrong?
- Gap Analysis: Where are we non-compliant or under-protected?
 

== Security Framework

)
A structured set of principles, processes, and controls that organizations use
to manage risks and protect their information systems, assets, and operations.



==== Value of a Safeguard

)
Net Value or Cost/Benefit of a safeguard:

- Negative value: not a responsible choice.
- Positive value: Then the value represents the yearly savings in cost that you
  CAN have (because the rate of occurrence is just an expected value).

Safety needs to be cost effective. Do not use more resources or money for the
protection of an asset as the value of the asset itself!



=== Risk Evaluation

)
The process of comparing an information asset's risk rating to the numerical
representation of the organization’s risk appetite or risk threshold to
determine if risk treatment is required.

Risk Evaluation: Compare the risk with the risk appetite of the organization.

- Can the company live with the analysed level of risk (From the CVSS, the
  quantitative risk analysis, qualitative risk analysis)?
- Levels: Expansionary, Conservative or Neutral

The Risk appetite from the RM Framework must be translated into a value so it
can be compared to each analysed risk.

- For the quantitative risk analysis, the risk appetite can be translated into a
  numerical value!

Goal: The risk must be smaller or equal as the risk appetite.

- Important Indicators for Business Impact:
  - Maximum Tolerable Downtime (MTD)
  - Recovery Point Objective (RPO)
  - Recovery Time Objective (RTO) & Work Recovery Time (WRT)



=== Risk Treatment

)
Mitigation risk treatment strategy: The risk treatment strategy that attempts to
eliminate or reduce any remaining uncontrolled risk through the application of
additional controls and safeguards in an effort to change the likelihood of a
successful attack on an information asset; also known as the defense strategy.

The company now has a list of information assets with unacceptable levels of
risk.

- The appropriate strategy must be selected and applied.

Four basic strategies to treat risk:
+ Mitigation: Apply safeguards that eliminate or reduce the remaining
  uncontrolled risk.
  - Example: Firewall, Training, ...
+ Transfer: Shift risks to other areas or outside entities.
  - Example: Outsourcing
+ Acceptance: Understand the consequences of choosing to leave an information
  assets vulnerability facing the current risk level (after formal evaluation).
+ Termination: Remove or discontinue the asset from the organization's operating
  environment.



==== Mitigation

)
- Fix vulnerabilities
- Applying controls (tools, processes, rules to mitigate risk)
  - Endpoint Hardening (preventive Control): Secure a "endpoint" (device:
    laptop, server, ...) by reducing its vulnerabilities and shut down potential
    threat vectors!
- Reduce final impact (If zero-day attacks, unknown vulnerabilities, or a taken
  risk happen)
  - EDR (Endpoint Detection and Response): Software that watches for suspicious
    behaviour and responds with certain measures.
  - XDR (Extended Detection and Response): Watching everywhere (not just on
    endpoints) and respond with certain measures (shut down infected laptop,
    ...)


=== Other RM Frameworks

- OCTAVE (Operationally Critical Threat, Asset and Vulnerability Evaluation) by
  the Carnegie Mellon University.
- FAIR (Factor Analysis of Information Risk) by Jack A. Jones.
- ISO Standards: ISO 27005 and ISO 31000: (explanation:
  https://en.wikipedia.org/wiki/ISO/IEC_27005).
- NIST Risk Management Framework (RMF): https://csrc.nist.gov/publications/sp



= Identity & Access Management (IAM)

)
IAM deals with provisioning and protecting digital identities and user access
permissions. Or in other words: The right people can access the right resources
for the right reasons at the right time. To ensure this we need Access Controls.



== Access Control

)
Any hardware, software, or administrative policy or procedure that controls
access to resources. The selective method by which systems specify who may use a
particular resource and how they may use it.

The goal is to:

- PROVIDE access to authorized subjects
- PREVENT access to unauthorized access attempts and unauthorized subjects


#deftbl(
  [Subject],
  [
    Active entity that accesses a passive object.

    - Anything that can access a resource can be a subject: users, programs,
      processes, services, computers,...
  ],
  [Object],
  [
    Passive entity that provides information to subjects
    - Anything that can provide resources: files, databases, computers,
      programs, processes, services, printers, ...
  ],
)
 
=== Control methods

#deftbl(
  [Physical controls],
  [
    Items that you can physically touch. Included are physical mechanisms
    deployed to prevent, monitor, or detect direct contact with systems or areas
    within a facility
    - Examples: guards, fences, motion detectors, locked doors, sealed windows,
      lights, cable protection, laptop locks, badges, swipe cards, guard dogs,
      video cameras, mantraps, and alarms
  ],
  [Technical or\ logical controls],
  [Hardware or software mechanisms used to manage access and to provide
    protection for resources and systems
    - Examples: authentication methods (username, passwords, biometrics,...),
      encryption, access control lists, protocols,...
  ],
  [Administrative\ controls],
  [Policies and procedures defined by an organization’s security policy or other
    regulations or requirements
    - Examples: policies, procedures, hiring practices, background checks, data
      classifications and labeling, security training,...
  ],
)
 
== Mechanisms
 
=== Identification

)
The subject is claiming an identity.

- Example: Typing a username, swiping a smartcard, waving a token device,
  speaking a phrase, or positioning your face, hand, or finger in front of a
  camera or in proximity to a scanning device

*Important*: All subjects must have unique identities

- IT systems track activity by identities, not by the subjects themselves
- A subject’s identity is typically labeled as, or considered to be, public
  information

A subject must provide an identity to a system to start the other processes
(authentication, authorization, and accountability)



=== Authentication

)
The process of verifying that the claimed identity (from identification) is
valid

- Example: password
- Identification and authentication are often used together as a single two-step
  process

Authentication information used to verify identity is private information and
needs to be protected

To authenticate the claimed identity it is common to use multiple factors These
factors are often categorized in three different categories:

+ Type 1
  - *Something you know*. Passwords, PINs, ...
+ Type 2
  - *Something you have*. Physical devices that a user possesses can help them
    provide authentication
+ Type 3
  - *Something you are or something you do*. It is a physical characteristic of
    a person identified with different types of biometrics



==== Authentication Schemes

)
+ Basic Authentication: Classical username / password pair transmitted in the
  clear
+ One Time Passwords: Transmitted in the clear but used only once
+ Challenge / Response: Response is a function of password and one-time
  challenge
+ Anonymous Key Exchange: Exchange credentials over unauthenticated secure
  channel
+ Zero-Knowledge Password Proofs: Does not permit offline-based password attacks
+ Server Certificates plus User Authentication: Transmit user password over
  unilaterally authenticated secure channel
+ Mutual Public Key Authentication: Bilateral use of public key signatures

_Attack vulnerability Matrix_
#align(center, table(
  columns: 8,
  table.header(align(left)[Attack], [1], [2], [3], [4], [5], [6], [7]),
  align(left)[Passive Password Sniffing], cr, [], [], [], [], [], [],
  align(left)[Offline Brute Force Password Attack], cr, [], cr, cr, [], [], [],

  align(left)[Active Man-in-the-Middle Attack], cr, cr, cr, cr, [], [], [],
  align(left)[Identity Theft on Server], cr, cr, cr, cr, cr, cr, [],
  align(left)[CA Compromise], [], [], [], [], [], cr, cr,
))



==== Type 1 Factor: Passwords

)
Passwords are typically static. They are the weakest form of authentication

- Users often choose passwords that are easy to remember and therefore easy to
  guess or crack
- Randomly generated passwords are hard to remember, and many users write them
  down
- Users often share their passwords, or forget them
- Passwords are rarely stored in plaintext.
  - A system will create a hash of a password using a hashing algorithm
- Best practices and policies
  - Enforce a minimum length
  - Complexity rules (uppercase/lowercase, non-alphanumeric, etc...)
  - Ageing and expiration
  - Reuse and history
- Password managers mitigate the risk of poor credential management



==== Type 2 Factor: Tokens

)
A token device, or hardware token, is a device that users can carry with them

- An authentication server stores the details of the token, so at any moment,
  the server knows what number is displayed on the user's token



Hard Authentication Tokens
)
- No transmission of the token itself e.g. Smartcards, Hardware OTP Token



Soft Authentication Tokens
)
- Software token transmitted to the user e.g. via Authenticator App, SMS, Email
  or phone



Dynamic Password Tokens
)
- Synchronous dynamic passwords are time-based and synchronized with an
  authentication server (TOTP)
- Asynchronous dynamic password is based on a Challenge-Response principle.
  Passwords are generated based on an algorithm and an incrementing counter,
  which remains valid until used (HOTP)



==== Type 2 Factor: Smartcard

)
A smartcard is a credit card–sized ID or badge and has an integrated circuit
chip embedded in it

- Smartcards store information about the authorized user that is used for
  identification and/or authentication purposes
- Implements certificate-based authentication (private key and sometimes a PIN
  to activate the card)
- Most current smartcards include a microprocessor and one or more certificates.
  The certificates are used for asymmetric cryptography such as encrypting data
  or digitally signing email
- Smartcards are tamper-resistant and provide users with an easy way to carry
  and use complex encryption keys



==== Type 2 Factor: One-Time Passwords

)
Onetime passwords are dynamic passwords that change every time they are used

- Onetime password generators are token devices that create passwords
- The PIN can be provided via a software application running on the user’s
  device (e.g., smartphone)



TOTP (Time-based One-Time Password)
)
- Uses a timestamp and remains valid for a certain timeframe, such as 30 seconds
- This is similar to the synchronous dynamic passwords used by tokens



HOTP (HMAC-based One-Time Password)
)
- Includes a hash function to create onetime passwords. It creates HOTP values
  of six to eight numbers
- This is similar to the asynchronous dynamic passwords created by tokens. The
  HOTP value remains valid until used



==== Type 3 Factor: Biometrics

)
Biometric authentication uses physiological characteristics to provide
authentication for a provided identification.



Biometrics make measurements and compare them with unique points of reference.
This may lead to these errors:

)
- False reject rate (FRR) (Type 1 Error): percentage of authorized users who are
  denied access
- False accept rate (FAR) (Type 2 Error): percentage of unauthorized users who
  are granted access
- Crossover error rate (CER): The point at which the rate of false rejections
  equals the rate of false acceptances



==== Multifactor Authentication

)
Multifactor authentication is any authentication using two or more factors

- For a positive authentication, elements from at least two, and preferably
  three factors should be verified
  - When two authentication methods of the same factor are used together, the
    strength of the authentication is no greater than it would be if just one
    method were used
  - Using more types or factors results in more secure authentication



==== Authentication factors

Numbered from weak to strong

)
+ Type 1: Something you know
+ Type 2: Something you have
+ Type 3: Something you are/ you do
+ Multi-Factor: 2 types
+ Multi-Factor: 3 types



==== Secondary Authentication Factors

)
In addition to the three primary authentication factors, there are some others

- Somewhere You Are
  - The somewhere-you-are factor identifies a subject's location based on a
    specific computer, a geographic location identified by an Internet Protocol
    (IP) address, or a phone number identified by caller ID
- Somewhere You Aren't
  - Many IAM systems use geolocation technologies to identify suspicious
    activity
  - For example, imagine that a user typically logs on with an IP address in
    Switzerland. If a user is trying to log on from a location in India, it can
    block the access even if the user has the correct username and password



==== Authentication Frameworks

)
- Kerberos: Create Authentication through a trusted third party.
- RADIUS: Provide centralized authentication, authorization, and accounting
  (AAA) for network access.




= Ethical Hacking

#deftbl(
  [Hacking],
  [
    - Exploiting vulnerabilities in systems and/or software to gain unauthorized
      access
    - Security control compromise
    - Produce behaviours outside of system/software's original intent
  ],
  [Ethical Hacking],
  [
    - Using tools and techniques to validate, audit and report on
      system/software vulnerabilities
    - Vulnerability existence reporting
  ],
)

== Taxonomy by Ethical intent

#deftbl(
  [Black Hat],
  [Malicious, destructive hacker that usually remains anonymous],
  [Grey Hat],
  [Those possessing Black hat skills who focus on both offense and defense],
  [White Hat],
  [Those possessing black hat skills who primarily focus on defense],
)

== Taxonomy by Skills, Motivation, Organizational Affiliation

#deftbl(
  [Script Kiddie],
  [Individuals that use tools without understanding what they are doing],
  [Cyber Terrorist],
  [Skilled attacker whose purpose it to further an ideology],
  [State Sponsored],
  [Hackers employed by the government for both offensive and defensive
    activities],
  [Hacktivist],
  [A person who breaks into a computer system in order to pursue a political or
    social aim],
)


== Independent Ethical Hacking


- #link("https://hackerone.com", [HackerOne]) is the leading global crowdsourced
  security platform.
- #link("https://bugcrowd.com/", [Bugcrowd]) is a major crowdsourced security
  platform combining global security researchers.
- #link("https://www.bugbounty.ch/programme/", [BugBounty]) is Switzerland’s
  leading AI-powered security testing platform


== Penetration testing vs Vulerability Scanning

#deftbl(
  [Penetration testing],
  [
    - Manual process
    - Cybersecurity professional tries to uncover weaknesses
      - find a way to break into your system
      - In-depth analysis
  ],
  [Vulnerability scanning],
  [
    - Automates process
    - Periodic scans
    - First step performed by penetration testers
      - determine the overall state of your systems
      - trigger in-depth manual reviews
  ],
)

=== PurpleSec risk rating

#todo[slides 18]


=== Contractual Framework for pentesting


- Pen Testing Contracts
- Statement of Work (SoW)
  - Activities to be performed
  - Pen testing timeline
  - Scope
  - Location of the work
  - SoW can be a standalone document or part of a Master service agreement (MSA)
- Non Disclosure agreement (NDA)
  - Types of NDAs include Unilateral, Bilateral, and Multilateral agreements


=== Frameworks and Methodologies


==== Penetration Testing Execution Standard (PTES)


- Community-driven industry standard
- End-to-End Penetration Testing Methodology
- https://pentest-standard.readthedocs.io/_/downloads/en/latest/pdf/


#todo[lifecycle (slides 20)]


==== NIST 800-115


- Technical Guide to Information Security Testing and Assessment
- Government-oriented testing guidance
- Technical guide to information security testing and assessment
- https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-115.pdf


#todo[diagram (slides 21)]


==== EC-Council


- The EC-Council is a global organization providing cybersecurity certifications
  such as the Certified Ethical Hacker
- https://www.eccouncil.org/


#todo[diagram (slides 22)]

=== Pentesting approaches based on knowledge level

#deftbl(
  [Black-box Testing],
  [
    - No internal knowledge
    - External attacker perspective
    - Simulates external threat actors
  ],

  [Gray-box Testing],
  [
    - Limited knowledge
    - Realistic authentication
    - Insider-based threat modeling
  ],
  [White-box Testing],
  [
    - Full internal knowledge
    - Deep analysis across all system components
    - Complete documentation access
  ],
)


= Malicious Code


Malicious code refers to software-based security threats that exploit weaknesses
in networks, operating systems, or applications to deliver harmful payloads to
targeted systems.
- User-Dependent Malware: Most computer viruses and Trojan horses rely on user
  interaction or unsafe behavior to propagate from one system to another.
- Self-Replication Threats: Worms, by contrast, are self-replicating and spread
  autonomously across vulnerable systems without requiring human involvement.



== Basic Functions of Computer Viruses


- As with biological viruses, computer viruses have two main functions,
  propagation and payload execution
- According to the AV-Test Institut, one of the major antivirus software
  vendors, >450,000 new malware variants appear on the internet every day!
- The propagation function defines how the virus will spread from system to
  system.
  - Viruses use new and innovative methods to escape detection and bypass
    increasingly sophisticated antivirus technology.
- The malicious impact is delivered by the virus’s payload, which executes the
  attacker’s intended malicious activity.
  - This could be anything that negatively impacts the confidentiality,
    integrity, or availability of systems or data
- Anyone with a minimal level of technical expertise can create a virus and
  unleash it upon the internet. #link(
    "https://dreadytofatroptsdj6io7l3xptbet6onoyno2yv7jicoxknyazubrad.onion/d/malware",
    "GO",
  ) #link(
    "http://hubooomjuva4f3nwwzq6xh5tttn56ta5kb2jcfyxpgwvqqz6pq7g4tqd.onion/category/malware",
    "CRAZY!!1!1",
  ) (#link(
    "http://5lxpubxvseldevorvqqeb4c3okepo4h5st333dh6pmmvcnnyy4vi6cad.onion/courses/malware-on-steroids/",
    "be sure to target winbloat only",
  ))



== Drive-by Downloads: Passive malware infection


- A drive-by download refers to the unintentional download of malicious code to
  your computer or mobile device that leaves you open to a cyberattack
  - You don't have to click the download button or open a malicious email
    attachment to become infected
  - A drive-by download can take advantage of an app, operating system, or web
    browser that contains security flaws due to unsuccessful updates or lack of
    updates.
- Unlike many other types of cyberattack, a drive-by doesn't rely on the user to
  do anything to actively enable the attack
  - Drive-by downloads may happen when visiting a website or clicking a link, or
    clicking on a pop-up window
- Example: #link("https://en.wikipedia.org/wiki/Lumma_Stealer", "Lumma Stealer")
  - It is Malware-as-a-Service (MaaS) that specializes in exfiltrating sensitive
    data such as login credentials, credit card information, and cryptocurrency
    wallet details from infected Windows systems



== Zero-Day Exploits and Unknown Vulnerabilities


- A Zero-day attack exploits a Zero-day vulnerabilities
  - Zero-day vulnerabilities are security flaws discovered by hackers that have
    not been thoroughly addressed by the security community
- A Zero-day exploit is not known to the software vendors
  - The delay between the discovery of a new type of malicious code and the
    issuance of patches and antivirus updates is known as the window of
    vulnerability
- Lots of system are long vulnerable to Zero-day attacks because of the slowness
  in applying updates on the part of system administrators



=== APT the Use of Zero-Day Exploits


- APTs are sophisticated adversaries with advanced technical skills and
  significant financial resources
  - These attackers are often military units, intelligence agencies, or shadowy
    groups that are likely affiliated with government agencies
- One of the key differences between APT attackers and other malware authors is
  that these malware developers often have access to zero-day exploits that are
  not known to software vendors
  - Because the vendor is not aware of the vulnerability, there is no patch, and
    the exploit is highly effective
  - Malware built by APTs is highly targeted, designed to impact only a small
    number of adversary systems and difficult to defeat.
  - Example: APT Case RUAG, Stuxnet



== Mechanisms of Viral Propagation


By definition, a virus must contain technology that enables it to spread from
system to system. Once the virus has “touched” a new system, they use one of
several propagation techniques to infect the new victim and expand their reach
- Traditional Propagation Techniques
  - Master Boot Record (MBR) infection
  - File infection
- Modern Propagation Techniques
  - Macro infection
  - Script-based infection
  - Process / Services injection
  - Fileless techniques



=== Master Boot Record Infection


- The Master Boot Record (MBR) viruses attack the portion of bootable media that
  the computer uses to load the operating system during the boot process (hard
  disk, USB)
- The MBR doesn't contain all the code required to implement the virus’s
  propagation and destructive functions
  - The MBR is extremely small (usually 512 bytes)
- MBR viruses store the majority of their code on another portion of the storage
  media
  - The system reads the infected MBR
  - The virus instructs it to read and execute the code stored in this alternate
    location
  - The system loads the entire virus into memory

#todo[diagram (slides 33)]


=== File Infection


- The file infector viruses infect executable files
- These viruses are often self-contained executable files that escape detection
  by using a filename similar to a legitimate operating system file (also called
  companion virus)
- Standard file infector viruses are often easily detected
  - by comparing file characteristics such as size and modification date before
    and after infection
  - by comparing hash values

#todo[diagram (slides 34)]


=== Service Injection


- The Service Injection viruses inject themselves into trusted runtime processes
  of the operating system, such as svchost.exe, winlogin.exe, and explorer.exe
- The malicious code is able to bypass detection by any antivirus software
  running on the host because those processes are trusted.

#todo[diagram (slides 35)]


=== Macro Infection


- A macro virus is a virus that is written in a macro language, a programming
  language which is embedded inside a software application word processors and
  spreadsheet applications
  - Macro programs are embedded in documents and the macros are run
    automatically when the document is opened
  - Macro viruses proliferate because of the ease of writing code in the
    scripting languages (such as VBA)
- Macro viruses first appeared on the scene in the mid-1990s to infect documents
  created in the popular Microsoft Word environment
  - In 1999, the Melissa virus spread through the use of a Word document that
    exploited a security vulnerability in Microsoft Outlook to replicate
  - The I Love You virus exploited similar vulnerabilities in early 2000
- Software developers made important changes to the macro development
  environment, restricting the ability of untrusted macros to run without
  explicit user permission
  - This resulted in a drastic reduction in the prevalence of macro viruses



=== Fileless Techniques


- Fileless Execution : Operates entirely within system memory, leaving no
  malicious code on disk. This makes it inherently resistant to traditional
  signature-based detection.
- Memory-Resident Execution: The malicious payload resides and operates
  exclusively in RAM.
- Living-off-the-Land (LotL): Abuse of built-in Windows tools like PowerShell or
  WMI, without using external binaries. Since these tools are trusted by the OS,
  their abuse often remains undetected.
- Registry-Based Persistence: Encoded shellcode or scripts are concealed within
  Windows Registry keys. Upon system startup, a native loader (e.g.
  regsvr32.exe) silently retrieves and executes the payload directly in memory.


== Malware Technologies


=== Multipartite Viruses


- Multipartite viruses use more than one propagation technique in an attempt to
  penetrate systems that defend against only one method or the other.
- Example: The Marzia virus
  - It infects the command.com system file qualifying it as a file infector
    virus
  - 2 hours after the first infection, it writes malicious code to the system’s
    master boot record qualifying it as a boot sector virus.



=== Stealth Viruses


- Stealth viruses hide themselves and tool antivirus packages into thinking that
  everything is functioning normally.
- Example: A stealth boot sector virus might overwrite the system’s MBR with
  malicious code and modify the operating system’s file access functionality.
  - When the antivirus package requests a copy of the MBR, the modified
    operating system code provides it with a clean version of the MBR free of
    any virus signatures. When the system boots, it reads the infected MBR and
    loads the virus into memory.



=== Polymorphic Viruses


- Polymorphic viruses modify their own code as they travel from system to
  system.
  - The propagation and destruction techniques of the virus remain the same
  - The signature of the virus is somewhat different each time it infects a new
    system
- This constantly changing signature will render signature-based antivirus
  packages useless
  - Antivirus vendors have “cracked the code” of many polymorphism techniques
    and are able to detect known polymorphic viruses
  - It takes vendors longer to generate the necessary signature files to stop a
    polymorphic virus



=== Encrypted Viruses


- Encrypted viruses use cryptographic techniques to avoid detection
- Encrypted viruses use a very short segment of code known as the virus
  decryption routine
  - It contains the cryptographic information necessary to load and decrypt the
    main virus code stored elsewhere on the disk
- Each infection utilizes a different cryptographic key, causing the main code
  to appear completely different on each system (polymorph)
  - The virus decryption routines often contain signatures that render them
    vulnerable to updated antivirus software packages



=== Logic Bombs


- Logic bombs are malicious code objects that infect a system and lie dormant
  until they are triggered by the occurrence of one or more conditions such as
  time, program launch, website logon
- Example: The Michelangelo virus
  - It infected a system’s MBR
  - It hid itself until March 6 – the birthday of the famous Italian sculptor
    Michelangelo
  - On that date, it reformatted the hard drives of infected systems and
    destroying all the data they contained
- Example: a logic bomb in South Korea in March 2013.
  - This malware infiltrated systems belonging to South Korean media companies
    and financial institutions and caused both system outages and the loss of
    data



=== Trojan Horses


- A Trojan horse is a software program that appears "kind" but carries a
  malicious, behind-the-scenes payload
- Example: a Rogue antivirus software
  - This software tricks the user into installing it by claiming to be an
    antivirus package (using a pop-up ad that mimics the look and feel of a
    security warning)
  - Once the user installs the software, it either steals personal information
    or prompts the user for payment to “update” the rogue antivirus
  - The “update” simply enables the Trojan!



=== Keystroke logging


- It is the action of recording (logging) the keys struck on a keyboard
  - The person using the keyboard is unaware that their actions are being
    monitored
- Data can then be retrieved by the person operating the logging program
  - A keylogger can be either software or hardware
  - Keyloggers are most often used for stealing passwords and other confidential
    information



=== Ransomware


- Ransomware infects a target machine and then uses encryption technology to
  encrypt files stored on the system with a key known only to the malware
  creator.
  - The user is unable to access their files and receives a pop-up message
    warning that the files will be permanently deleted unless a ransom is paid
    within a short period of time.
  - The user then often pays this ransom to regain access to their files.
- Examples: Cryptolocker, WannaCry, Petya, Nyetya, BABUK (2021)



=== Worms


- Worms are malicious code objects that propagate themselves without requiring
  any human intervention
- Example: Code Red Worm. Code Red performed three malicious actions on the
  systems it penetrated:
  - It seeks many new targets by randomly selected hundreds of Internet Protocol
    (IP) addresses and then probed those addresses to see whether they were used
    by hosts running a vulnerable version of IIS
  - It defaced HTML pages on the local web server
  - It planted a logic bomb that would initiate a denial-of-service attack
    against the IP address 198.137.240.91, which at that time belonged to the
    web server hosting the White House’s home page
- Example: Stuxnet
  - Stuxnet was searching for systems using a controller manufactured by Siemens
    and used in the production of material for nuclear weapons
    - When it found such a system, it executed a series of actions designed to
      destroy centrifuges attached to the Siemens controller
  - Stuxnet appeared to begin its spread in the Middle East, specifically on
    systems located in Iran in 2010.
    - It is alleged to have been designed by Western nations with the intent of
      disrupting an Iranian nuclear weapons program.
  - Stuxnet marks two major evolutions in the world of malicious code
    - the use of a worm to cause major physical damage to a facility
    - the use of malicious code in warfare between nations.
  - can you hear the sound of freedom eagles



=== Spyware & Adware


- Spyware monitors your actions and transmits important details to a remote
  system that spies on your activity
- Adware uses a variety of techniques to display advertisements on infected
  computers
  - The simplest forms of adware display pop-up ads on your screen while you
    surf the web
  - More advanced versions may monitor your shopping behavior and redirect you
    to competitor websites
- Adware often take advantage of third-party plug-ins to web browsers, to spread
  their malicious content
  - The original plug-in code is supplemented with malicious code that spreads
    malware, steals information, or performs other unwanted activity
- Example: Windows



== Antivirus & Endpoint Security


- An Antivirus software is a computer program used to prevent, detect, and
  remove malware
  - If possible, the antivirus package eradicates the virus, disinfects the
    affected files and restores the machine to a safe condition
  - If the software doesn’t know how to remove the virus, the files can be
    quarantined. A common strategy is to send the suspicious files to a sandbox
    where they are executed in an isolated but monitored environment
  - If the software doesn’t know how to remove the virus and cannot be
    quarantined, the infected files can be deleted in an attempt to preserve
    system integrity
- Antivirus solutions are not only protecting systems from viruses
  - These tools are often able to provide protection against worms, Trojan
    horses, logic bombs, rootkits, spyware,…



=== Antivirus Detection: Signature-based


- The vast majority of the antivirus packages utilize a method known as
  signature-based detection
  - An antivirus package maintains an extremely large database that contains the
    characteristics of all known viruses
  - The antivirus scans storage media periodically
- The signature-based antivirus package is only as effective as the virus
  definition file upon which it’s based
  - Your antivirus software will not be able to detect newly created viruses
  - An outdated definition file will quickly render your defenses ineffective



=== Antivirus Detection: Heuristic-based


- The antivirus analyze the behavior of software, looking for the signs of virus
  activity.
  - Such as attempts to elevate privilege level, coverage of electronic tracks,
    and alteration unrelated or operating system files
- If the software behaves suspiciously in that environment, it is added to
  blacklists throughout the organization, rapidly updating antivirus signatures



=== Antivirus Detection: Data integrity


- Data integrity antivirus functionality is designed to alert administrators to
  unauthorized file modifications
  - Unless a new software, application of an operating system patch has been
    installed, sudden changes in executable files may be a sign of malware
    infection
- These systems work by maintaining a database of hash values for all files
  stored on the system
  - These archived hash values are then compared to current computed values to
    detect any files that were modified between the two periods



=== Endpoint Security


- Deep Visibility & Continuous Monitoring
  - EDR tools capture all system events, including process executions, network
    connections, and registry changes.
- Behavioral Analysis
  - Detection of fileless threats and complex attack chains that bypass
    traditional signature-based antivirus software.
- Automated Response and Remediation
  - When anomalous behavior is detected, the infected machine is automatically
    isolated from the network to prevent lateral spread.
- Example: Microsoft Defender for Endpoint, CrowdStrike Falcon, SentinelOne



= OT and IT/OT


/ OT: Operational Technology, software and hardware for monitoring ...
/ IT: #todo[]

#table(
  columns: (1fr, 1fr, 1fr),
  [Comparison], [IT], [OT],
  [Lifecycle], [3-5 yrs], [15-20yrs],
  [Security], [Data and cyber security], [Operational and physical security],
  [Update-frequency], [Frequent software-patches], [Rarely],
  [Availability], [High but with maintenance-times], [Permanent],
)


== IT/OT Konvergenz

#todo[]

= The Future of Cybersecurity

== Trends


=== Social Engineering


The most attacks are still without any code. New shift: Vishing (rep: Voice + Phishing) seems to
be used more often.
- Attacks on IT-Helpdesks: Pretending to be a user and trying to reset Password + MFA
- Attackers pretend to be IT-Helptesk (often with multiple calls!)



=== Identity Theft


The Theft Resource Center states three trends in Identity Theft:
+ Artificial Intelligence (AI) technology makes it easier for thieves to coerce unsuspecting victims into giving away their identity credentials
+ Identity thieves are increasingly able to access a variety of existing accounts.
+ Individuals are becoming more curious about protecting their identity.



=== Geopolitical Tensions / Conflict


Due to geopolitical tensions, threat actors remained persistent and adaptive in 2025 and evolve
throughout 2026.



=== Expansion of Supply Chain Attacks


Supply Chain Attacks have doubled in 2025.
- ENSIA Foresight 2030: Supply Chain-Attacks are classified as the most critical threat
- EU NIS-2: Commits the operators of critical infrastructure to protect the whole supply chain


== Post-Quantum Cryptography


=== Quantum Computer


- Using qubits instead of classical bits
  - Superposition of states
- Can solve certain problems exponentially faster than classical computer
  - No generic speedup
  - Good in breaking Factoring and Discrete Logarithm, still bad in breaking
    Hashing
- Not practical (yet)
  - Current systems have a few qubits
  - E.g., Google Willow has 105 qubits
  - Challenge: Error correction



=== Affected Components


Vulnerable: Asymmetric Cryptography
- Signatures: RSA, ECDSA, EdDSA
- Key Exchange: Diffie-Hellman
Less Impacted: Symmetric Cryptography
- Block/Stream Cipher
- Hash functions (HMAC)
$->$ Double keys



=== New NIST Standards


- NIST defines cryptographic standards
- PQC NIST competition
  - 2017: 90 candidates submitted
  - 2024: 3 schemes standardized
- New Standards
  - Signatures
    - ML-DSA (CRYSTALS-Dilithium)
    - SLH-DSA (Sphincs+)
  - Key Encapsulation
    - ML-KEM (CRYSTALS-Kyber)



=== Transition to PQC


Until 2028:
- Define necessary policies/goals (regulations)
- Create a cryptographic inventory
- Build an initial plan for migration
Until 2031:
- High-priority PQC transitions complete
- Refine plan for remaining migration
Until 2035:
- Complete migration to PQC complete


== IoT Security


=== Elements of IoT


- Connectivity
  - Communications protocols, protocol stacks.
- Things += Microcontroller + SW + Sensors + Actuators
- Zero-Touch Provisioning
- Security
  - CIA, Authentication & Authorization


=== Growing Attack Surface


==== Explosive Device Growth


- Over 21 billion IoT devices worldwide (2025)
- Trend rising sharply
- Often insufficiently protected



==== Typical Vulnerabilities


- Default passwords
- Missing or inadequate encryption
- Outdated firmware
- Lack of update mechanisms



==== Attack Vectors


- Botnets
- Mirai (2016) is arguably the most famous IoT botnet
- Man-in-the-Middle
- Supply Chain Attacks



==== Cyber Resilience Act (CRA)


- CRA is being implemented in stages (until 2027)
- EU-wide regulation that establishes binding cybersecurity requirements for hardware and software products
- Outdated firmware
- Lack of update mechanisms



=== IoT security risks and design flaws


- IoT devices often lack security-by-design due to cost and time constraints.
- Weak authentication, insecure updates, and exposed interfaces are common.
- Complex dependencies between devices, networks, and cloud services increase risk.
- Design flaws can compromise entire IoT ecosystems, not just individual devices.


=== Threat examples


==== Service Disruption


- Description: IoT services or devices are rendered unavailable or unreliable.
- How it works:
  - Denial-of-Service (DoS/DDoS) against devices or gateways
  - Resource exhaustion on constrained devices (CPU, memory, battery)
  - Malicious firmware updates or protocol abuse
- Domains:
  - Smart household appliances
  - Industrial IoT systems
  - Safety-critical components (vehicle braking subsystems, medical devices)
- Impact: Loss of availability and reliability, economic damage



==== Unauthorized Control


- Description: Attackers gain active control over IoT devices or actuators and can issue malicious commands.
- How it works:
  - Exploitation of weak authentication (default credentials, missing mutual authentication)
  - Software/firmware vulnerabilities (buffer overflows, insecure update mechanisms)
  - Compromised communication channels (unencrypted or unauthenticated protocols)
- Domains:
  - Smart homes (locks, lighting, HVAC)
  - Connected vehicles (infotainment, driver assistance subsystems)
  - Medical devices (insulin pumps, implanted or external controllers)
- Impact: Loss of safety and physical integrity



=== Comparing IT, IoT, and OT Environments


#table(
  columns: 4,
  [Feature],
  [IT Security (Office/IT)],
  [IoT Security (Connected)],
  [OT Security (Industrial)],

  [CIA Priority], [C > I > A], [I > C > A], [A > I > C],
  [Primary Goal],
  [Confidentiality (Data Protection)],
  [Data Integrity & Device Safety],
  [Availability (Process Protection)],

  [Asset Focus],
  [Servers, Laptops, Databases],
  [Smart Devices, Trackers, Cameras],
  [PLC, Motors, Robots, Sensors],

  [OS Type],
  [Windows, Linux, MacOS (Standard)],
  [Embedded / Lightweight Linux],
  [Real-time (RTOS), Proprietary],

  [Lifecycle],
  [3–5 Years (Short-lived)],
  [2–7 Years (Fast-paced)],
  [15–30 Years (Legacy Systems)],

  [Patching],
  [Regular (e.g. "Patch Tuesday")],
  [OTA (Over-the-Air) targeted],
  [Rare (only during downtime)],

  [Failure Impact],
  [Data loss, Reputation damage],
  [Mass manipulation, Botnets],
  [Physical damage, Risk to life],
)



=== The Future of IoT Security: Strategies & Trends


- Security-by-Design
  - Integrate security starting from the development phase, rather than adding it as an afterthought.
- Zero Trust Architectures
  - No device is automatically trusted →continuous authentication is required.
- Automated Patch Management & Standardization
  - OTA (Over-the-Air) updates as a standard to close security vulnerabilities.
  - Use of open standards, such as Matter.
- Compliance with standards:
  - ETSI EN 303 645: The leading European standard for the cybersecurity of consumer IoT devices.
  - IEC 62443: A series of standards for the cybersecurity of industrial automation and control systems (IIoT).



== Cybersecurity and AI


AI Tools enable attackers to generate Phishing Mails, Malware Code, Deepfakes, etc. Also, companies integrate AI-Systems, which come with new vulnerabilities.



=== Claude Mythos


- Announced in April 2026 by Anthropic, the developers of Claude AI.
- A model that is strikingly good at cyber security tasks such as finding zero-day exploits.
- Project Glasswing aims to strengthen existing cybersecurity systems across 40 organizations, including Amazon, Apple, Google and Microsoft, with the help of Mythos.
- Can be used by defenders to strengthen their systems but also by attackers to more effortlessly and effectively write malware and abuse zero-day exploits.

