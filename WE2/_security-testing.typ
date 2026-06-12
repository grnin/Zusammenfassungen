
= accessibility
<accessibility>
#strong[Farbkontrast:] Wichtig für Personen über 50

// #box(image("media/image7.png", height: 0.9048611111111111in, width: 2.047222222222222in))

#strong[Accessbility:]

- Bilder sollen immer einen Alt-Text haben

- Zoom sollte nicht unterbunden werden

- Animationen sollten abstellbar sein (Verringerung von Ablenkungen und
    Verhinderung von Epilepsie und Migräne)

- Alle wichtigen Input Elemente sind fokussierbar in der richtigen
    Reihenfolge mit Tastatur

- Screen Reader soll keine Heading Levels auslassen, Semantic Elements
    richtig nutzen, Skip-Links am Anfang der Seite und lang Attribut
    korrekt setzen

- Entwickler sollten die Verwendung des korrekten semantischen
    HTML-Elements der Verwendung von ARIA vorziehen

- Tabellen sollten mit Headings for Rows und Columns ausgestattet sein
    und Captions haben

= security
<security>
#strong[OWASP Top 10:]

#figure(
    align(center)[#table(
        columns: (50%, 50%),
        align: (auto, auto),
        table.header([Cross-Site-Scripting], [Replay Attack]),
        table.hline(),
        [Remote Code Execution], [Cryptographic Failures],
        [Insecture Direct Object References],
        [Identification &
            Authentication Failure],
        [Cross-Site Request Forgery], [],
    )],
    kind: table,
)

#strong[Cross Site Scripting (XSS):] Website besitzt eine
XSS-Verwundbarkeit, wenn es möglich ist den Server so zu manipulieren,
dass Schadcode (JavaScript) eines Angreifers an Nutzer ausgeliefert wird
und im Browser dieser Nutzer ausgeführt wird. Gegenmassnahme mit Input
Sanitation.

#strong[Remote Code Execution:] Webserver besitzt eine Code Injection
\"Vulnerability\" wenn ein Angreifer den Server dazu bringen kann vom
Angreifer eingeschleusten Code zum Ausführen zu bringen.

#strong[Broken Access Control:] Beim behandeln von
Formular-Submission-Requests (GET und POST) sollte überprüft werden,
dass dies von einem vom Server für den Nutzer «frisch» ausgelieferte
Formulare stammt.

#strong[Cryptographic Failures:] Passwort oder Token wird nicht
verschlüsselt übertragen. Unabhängig davon ob
Query-Body/Request-Parameter.

#strong[Identification & Authentication Failure:] Bei Problemen bei der
Authentisierung und dem Session Management können externe Angreifer oder
Angreifer mit einem validen Login auf Informationen zugreifen, welche
nicht für sie bestimmt sind

#strong[Sign-up Form Best Practices:]

- Use meaningful HTML elements: form, input, label and button

- Label each input with a label

- Use element attributes to access built-in browser features: type,
    name, autocomplete, required.

- Use autocomplete=\"new-password\" and id=\"new-password\" for the
    password input in a sign-up form, and for the new password in a
    reset-password form.

- Provide Show password functionality.

- Don\'t double-up inputs. Don't force users to enter emails or
    passwords twice.

#strong[Content Security Policy (CSP):] CSPs ermöglichen die Ausführung
von bösartigem Code auf Webseiten zu verhindern. Quellen von Ressourcen
(Skripten, Bilder etc.) können eingeschränkt werden. CSPs werden im HTTP
Header definiert

#strong[Cross-Origin Resource Sharing (CORS):] CORS Header ermöglichen
Ressourcen (wie z.B. Bilder, Skripte oder Daten) von einem anderen
Ursprungsort als der eigenen “Origin” zu laden.

= testing
<testing>
#strong[Unit Tests:] Getestet werden einzelne \"Units\" wie Klassen,
Module (meist ein File). Automation ist relativ einfach. Herausforderung
ist die Isolation der Units, asynchrone Operationen,
Testdatengenerierung (z.B. Fuzzing)

#strong[Integrationstests:] Getestet wird das Zusammenspiel 2 oder mehr
\"Units\". Automation meist möglich. Herausforderungen ist die Isolation
der Units, asynchrone Operationen, Simulation Browser &
Benutzerinteraktion, Test mit Datenbank, Testdatengenerierung (z.B.
Fuzzing)

#strong[Funktionstests:] Getestet wird ob sich das System entsprechend
spezifizierte funktionale Anforderungen (Use-Cases, User Stories, ...)
verhält. Automation möglich mit speziellen Tools

#strong[(Visuelle) Regressionstests:] Getestet wird ob Veränderungen im
Code zu (unerwarteten) Änderungen im Verhalten (oder UI) führen.
Automation möglich mit speziellen Tools

#strong[Funktionale Systemtests:] Getestet wird das Zusammenspiel aller
Systemkomponenten in der Zielumgebung Automation meist nur in Teilen
möglich. Herausforderungen: Realistische aber vorhersagbare Umgebung

== tools
<tools>
#strong[Test-Runner:] Ein Rahmen der Tests entgegennimmt, ausführt und
die Resultate anzeigt. Beispiele: Ava CLI, Jasmine, Jest, Mocha, Cypress

#strong[Assertion Library:] Code zur Ausführung einzelner Tests
(Unterstützung Testing Patterns) Beispiele: Assert, Ava Power-Assert,
Chai, Expect.js

#strong[Mocking Library:] Separierung von Units / Erstellung von Mocks
etc. Beispiele: Expect.js, Proxyquire, Sinon.js

#strong[DOM Handling :] Cypress, JSDom, Puppeteer (Headless),
Playwright, Storybook (Regression), Enzyme (React)

#strong[Mocha API:] Aufruf einer umfassenden Funktion describe() mit
zwei Argumenten.

describe(\'Array\', function () { #emph[\\/\/ Test Suite \
];describe(\'\#indexOf()\', function () { \
beforeEach(function () { \
this.testArray = \[1, 2, 3\]; /#emph[\/ Test Setup \
];});

#emph[\\/\/ Test Case] \
it(\'return -1 when value not here\', function () {

#emph[\\/\/ Assertion \
];expect(this.testArray.indexOf(4)).to.equal(-1); #emph[ \
];}); \
}); \
});

#strong[Unit Testing:] Alles testen das kaputt gehen könnte. Alles
testen das kaputt gegangen war. Neuer Code ist sus bis unschuldigTest
bewiesen.
