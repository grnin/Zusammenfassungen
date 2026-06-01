https://github.com/takotori/StudentenportalSpick/blob/main/WE2%20Spick.docx

= nodejs
<nodejs>
#strong[Web Server:] HTTP Anfragen/Anfragen annehmen/absenden, Actions
ausführen basierend auf URL (z.B Statische Inhalte ausliefern,
Dynamische Inhalte rendern)

#box(image("media/image1.png", height: 0.9730982064741908in, width: 2.0802701224846896in))

#strong[Wieso NodeJS:] Client/Server in JS, Ideal für
Datenschnittstellen wie REST, Läuft überall, einfach zu deployen, Sehr
schnelle Entwicklung möglich, Sehr modularer Aufbau

== nodejs grundlagen
<nodejs-grundlagen>
#strong[Asynchrone Programmierung:] Funktionen können als Parameter
übergeben und später aufgerufen werden

function myFunc(a, b, fn) { \
#emph[setTimeout];(function () { \
fn(a + b); \
}, 1000); \
} \
myFunc(2, 4, console.log); \
myFunc(10, 3, console.error);

#strong[Callback-Hell:] Verschachtelte asynchrone Funktionen. Lässt sich
mit Promises oder async/await lösen.

#strong[Event:] Callbacks sind 1 : 1 Verbindungen. Events sind 1 : \*
Verbindungen

#strong[I/O Modules:] HTTP/HTTPS, URL, File System, Console, UDP/Net,
Crypto

== Module
<module>
Ein Modul kann Funktionalität und Werte anderen Modulen zu Verfügung
stellen. Ein Modul kann von anderen Modulen exportierte Funktionalität
und Werte nutzen. NodeJS verwendet 2 Module Systeme (CommonJS und ESM)

#strong[NPM:] Node verwendet für die Module Verwaltung npm.

#strong[Export:] Wird nur einmal durchlaufen. Das Module wird
«ge-cached» und bei jeder Nachfrage wieder zurückgegeben.

export default {count: add, get: get}; \
function add() { return ++counter; }

#strong[Import:]

import counterA from \'./counter.mjs\'; #emph[\\/\/ Named \
];import {add, get} from \'./counter.mjs\';

#strong[Resolve-Reihenfolge:]

+ Core Module z.B import fs from \'fs\';

+ Falls der mit «.\\», «..\\» oder «\\» startet z.B from
  \'./counter.mjs';

+ Falls ein «Filename» angeben wurde z.B from \'counter\';

#strong[Package.json:] Beinhaltet die Information zum Projekt. Wird
benötigt um ein Modul zu installieren/publishen.

#strong[Package-lock.json:] Beschreibt den exakten Abhängigkeitsgraph
vom Projekt. Garantiert, dass immer die gleichen Abhängigkeiten
installiert werden. Beschleunigt die Installation.

= express
<express>
== controller
<controller>
#strong[Beispiel:]

import express from \'express\'; \
const app = #emph[express];(); \
app.listen(3000, function () { \
console.log(\'Example app on port 3000!\'); \
});

#strong[Middleware:] Express nutzt Middleware für die Request
Bearbeitung. Middleware ist ein Stack von Anweisungen welche für ein
Request ausgeführt wird.

#figure(
  align(center)[#table(
    columns: (19.74%, 13.36%, 33.07%, 13.4%, 20.42%),
    align: (auto,auto,auto,auto,auto,),
    table.header([], [], [Middleware 1], [], [],),
    table.hline(),
    [Request], [], [Middleware 2], [], [Response],
    [], [], [Middleware 3], [], [],
  )]
  , kind: table
  )

#strong[Middleware registrieren:] Mit app.use(…) wird eine neue
Middleware registriert. Die Reihenfolge der Registrierung bestimmt die
Ausführungsreihenfolge.

import express from \'express\'; \
import #emph[bp] from \'body-parser\'; \
const app = #emph[express];(); \
const router = #emph[express];.#emph[Router];(); \
app.use(#emph[express];.static(\_\_dirname + \'/public\')); \
app.use(bp.urlencoded({extended: false})); \
app.use(router);

#strong[Middleware-Sammlung Connect:] Connect definiert die Middleware
Logik und eine Sammlung von Middlewares (z.B body-parser, cookie-parser)

#strong[Router-Middleware:] Middleware befindet sich auf dem Express
Objekt.

- #strong[router.all(path, \[callback, ...\] callback)]

  - Wird unabhängig vom der HTTP Methode aufgerufen. Dynamische Werte
    möglich (/order/:id/)

- #strong[router.METHOD(path, \[callback, ...\] callback)]

  - Wird aufgerufen, falls die jeweilige HTTP Methode verwendet wurde

router.get(\'/\', function (req, res) { \
res.send(\'hello world\'); \
});

- #strong[router.route(path)]

  - Kann benutzt werden um für einen Path verschiedene Methoden zu
    gruppieren

app.route(\'/book\').get(function (req, res) { \
res.send(\'Get a random book\'); \
}).post(function (req, res) { \
res.send(\'Add a book\'); \
})

#strong[Static-Middleware:] Statische Files ausliefern. Mehrere
static-routes möglich

#strong[Custom-Middleware:] Hat 3 Parameter request, response und next.
Next kann aufgerufen werden, um die nächste Middleware aufzurufen.

function myLogger(options) { \
options = options ? options : {}; \
return function #emph[myInLogger];(req, res, next) { \
console.log(req.method + \":\" + req.url); \
next(); \
} \
}

#strong[Error-Middleware:] Bearbeitet Errors, welche von den Middlewares
generiert wurden. Muss 4 Parameter haben und als letztes registriert
werden. Wird aufgerufen, falls ein Error-Objekt dem Next-Callback
übergeben wird.

app.use(function (err, req, res, next) { \
console.error(err.stack); \
res.status(500).send(\'Something broke!\'); \
});

== model
<model>
#strong[Ziel:] Die Daten sollten in einem Modul verwaltet und
abgespeichert werden. (Z.b mit Array, JSON, NoSQL oder SQL-Db).

#strong[NoSQL DB mit nedb:] NoSQL Datenbanken sind Dokumenten-basierend.
Jedes Dokument beinhaltet alle Daten, welche notwendig sind. Relationen
können über «keys» manuell erstellt werden.

#strong[Beispiel:]

import Datastore from \'\@seald-io/nedb\'; \
const db = new Datastore({ \
filename: \'./data/order.db\', \
autoload: true });

db.insert(order, function (err, newDoc) { \
console.log(\" insert\"); \
if (callback) { \
callback(err, newDoc); \
} });

db.find({}, function (err, docs) { \
callback(err, docs); });

db.update({\_id: id}, \
{\$set: {\"state\": \"DELETED\"}}, \
{returnUpdatedDocs: true}, \
function (err, numDocs, doc) { \
callback(err, doc); });

== view
<view>
Mit Template Engines kann HTML-Code generiert werden. «Einfache» Sprache
um (komplexere) Templates zu unterstützen. Single Page Frameworks und
Web-Frameworks nutzen Template Engines um Templates zu rendern. Trennt
Controller und View.

#strong[Beispiel:]

res.render(\"template\", { \
description: \"List of some Movies\", \
items: songs});

\<figure\> \
\<ul\> \
{{\#each items}} \
\<li\> \
\<h3\>{{title}}\</h3\> \
\<p\>{{artist}}\</p\> \
\</li\> \
{{/each}} \
\</ul\> \
\<figcaption\> \
\<p\>{{description}}\</p\> \
\</figcaption\> \
\</figure\>

== session
<session>
#strong[Cookie:] Ein Cookie repräsentiert ein kleines Stück Information.
Der Server schreibt ein Cookie auf einen Client (set-cookie: …). Client
schickt alle Cookies für aktuelle Seite zurück and Server (cookie: …).

#box(image("media/image2.png", height: 0.75in, width: 2.047222222222222in))

#strong[Session:] HTTP-Stateless umgehen. Daten werden Server-seitig
einem Benutzer zugeordnet.

#strong[Authentifizierung:] Wer bin ich? (Passwort, Handy, Biometrie)

#strong[Autorisierung:] Was darf ich?

#strong[Token:] Ziel ist ein Stateless Server. Bei jeder REST Anfrage
muss ein Token mitgegeben werden (Signatur, Ausstell-/Ablaufdatum).
Vorteil ist dass jede Anfrage zu einem beliebigen Server gesendet werden
kann. Nachteil ist dass Token geklaut werden kann.

#strong[Token Generierung:] Bei einer Route müssen die persönlichen
Daten angegeben werden. Falls korrekt, wird ein Token generiert und an
den Client geschickt. Verschiedene Libraries wie OAuth, Express-JWT,
etc.

== ajax
<ajax>
#strong[Motivation:] User Experience verbessern mit Auto-Complete in
Formularen. Nachträgliches Laden von Daten und Updaten von Website.

#strong[Nachteile:] State der Applikation ist nicht bekannt.
Undo/Redo-Stack (History) wird oft vergessen.

#strong[Fetch:] Neue Variante von XMLHttpRequest. Fetch Response bietet
Methoden an um die Daten vom Body zu interpretieren. Cookies werden
nicht automatisch mitgesendet.

#emph[fetch];(\'/login\', { \
method: \'POST\', \
headers: {\'Content-Type\':\'application/json\'}, \
body: JSON.stringify({ \
email: \"admin\@admin.ch\", \
pwd: \"123456\"}) \
}).then(function (res) { \
console.log(res); \
})

#strong[SOP/CORS:] Same-Origin-Policy erlaubt XMLHttpRequest nur zur
Origin. Cross-Origin Resource Sharing ist ein Mechanismus, um
Cross-Site-Requests zu ermöglichen. Der Ziel-Server kann dem Client den
Zugriff erlauben.

#box(image("media/image3.png", height: 0.914666447944007in, width: 1.4831889763779527in))

= typescript (TS)
<typescript-ts>
#strong[Motivation:] TS hilft mittels «statischer Analyse», entdeckt
Typos, erlaubt Spezifikation von Typen für Variablen/Parameter etc.

#strong[Typ-Inferenz:] boolean, number, string, null, undefined und any.
Any kann beliebigen Wert annehmen und kann einer beliebig anderen
Variable zugewiesen werden.

#strong[Strict Mode:] Keine untypisierten Variablen, null und undefined
ist nicht mehr Teil der Basistypen und können auch nicht mehr zugewiesen
werden.

#strong[Variablendeklarationen:] Globale Variablen aus nicht TS-Files
können mit dem Keyword declare deklariert werden. Variablen können als
unknown deklariert werden, dessen Typ später definiert wird.

declare let myMagicVar: string;

Auf Tupeln wird keine Typen-Inferenz angewendet, bei Enums wird es.
Bessere Alternative zu Enums sind String Literal Union Type.

let myInferredNumArray = \[1, 2, 3\]; \
let myNotInferredTupel = \[1, \"abcd\"\];

enum StrColor {#emph[Red] = \"red\", #emph[Green] = \"green\"}; \
let c: Color = StrColor.#emph[Green];; \
type StrLitColor = \"red\" | \"green\"; \
let c3: StrLitColor = \"green\";

#strong[Union Type:]

type StringOrNumberType = string | number; \
let myVar2: StringOrNumberType;

#strong[Funktionen:] Function Overloading erlaubt. Parameter können
Default Value und optional sein

function f(sn: number | string = \"\", ns?: number): string { \
return #emph[String];(sn) + #emph[String];(ns || \"\"); \
}

#emph[\\/\/ Funktion als Parameter \
];function f2(numArray: number\[\], \
numFun: (prev: number, \
curr: number) =\> number): number { \
return numArray.reduce(numFun); \
}

#strong[Klassen:] Properties der Instanzen und der Klasse (static)
werden im Kontext der Klasse definiert. Methoden und Properties können
mit den Zusätzen \"private\" und \"readonly\" versehen werden.

class SportsCar { \
constructor( \
public make: string, \
public color: SportsCarColor) \
{ #emph[\\/\/kein code nötig } \
];}

#strong[Interfaces:] Interfaces (Typen) können in Deklaration von
Klassen genutzt werden und darf mehr als ein Interface implementieren.
Readonly Variablen können nicht verändert werden und «?» bedeutet
optional.

interface IPoint { \
readonly y?: number; \
} \
class Item { \
constructor(public description: string) {} \
} \
class POI extends Item implements IPoint { \
constructor(public x: number, \
public y: number, \
description: string, \
public likes?: number) { \
super(description); \
} \
}

#strong[Typen vs Interface:] Vielfach lassen sich stukturierte Typen
sowohl als Interface als auch als Type definieren. Aber nur ein
«Interface» kann unter gleichen Namen erweitert werden und nur ein
«Type» kann Werte spezifizieren.

#strong[Type Assertion:] Type Assertion erlauben Spezialisierung und
Generalisierung des Typs, aber kein Casting auf einen inkompatiblen Typ.
Mit keyof lässt sich ein Ty paus einem anderen Typen ableiten

const myCanvas = document.getElementById(\"ina\") as HTMLCanvasElement;

const x = \"hello\" as number; #emph[\\/\/ nicht erlaubt]

type Point = { x: number; y: number }; \
type PK = keyof Point;

#strong[Template Literal Types:] Mit Template Literal Types lassen sich
«literal» Types aus anderen Typen ableiten.

type Shipper = \'UPS\' | \'FEDEX\' | \'DHL\'; \
type Type = \'Overnight\' | \'Priority\' | \'Economy\'; \
type PostMethod = \`\${Shipper}-\${TrackingType}\`;

#strong[Generics:] Mit Generics lassen sich Funktionen und Strukturen
beschreiben die Wiederverwendung mittels ‘Composition' ermöglichen.

interface PointList\<ItemType\> { \
itemList: ItemType\[\]; \
} \
\
function filteredPointList\<ItemType\>( \
pList: PointList\<ItemType\>, \
inclPred: (item: ItemType) =\> boolean): ItemType\[\] { \
return pList.itemList.filter(inclPred); \
}

= responsive layout
<responsive-layout>
#strong[Definition:] Web-Seiten mit responsivem Layout sind sowohl
flexibel, als auch adaptiv

- Flexibel: Zusätzlicher Platz wird durch Verbreiterung der Elemente
  ausgefüllt. Dynamisches (grössenadaptives) Layout welches sich ohne
  Media-Queries umsetzen lassen

- Responsive: Zusätzlich Platz wird durch Umordnung und zusätzliche
  Elemente ausgefüllt. Dynamisches Layout welches für unterschiedliche
  Geräte, Display-Grössen und Medien separates m Layouts definiert.
  Umsetzung mit Media Queries.

#box(image("media/image4.png", height: 0.46875in, width: 2.047222222222222in))

#strong[Vorgehensmodell für Responsive Layout:]

- Graceful Degradation bedeutet, dass eine Anwendung mit einem
  Grundgerüst voller Funktionalität in modernen Browsern erstellt wird
  und dann die Layers zu entfernen, um sicherzustellen, dass sie mit
  älteren Browsern funktioniert

- Progressive Enhancement ist das Gegenteil von Graceful Degradation.
  Anstatt alle Funktionen von Anfang an zu entwickeln, wird eine
  Webseite auf der Grundlage der von allen Browsern (und
  Browserversionen) unterstützten Funktionen erstellt. Dann werden
  fortgeschrittene Funktionen wie Ebenen hinzugefügt.

#box(image("media/image5.png", height: 0.895003280839895in, width: 1.4192946194225722in))

== responsive layout
<responsive-layout-1>
Spezifisches CSS für verschiedene Medien definieren.

#strong[Typen:]

\@media screen { ... } \
\@media print { ... }

#strong[Dimensionen:]

\@media (\[width|min-width|max-width\]: 375px){...} \
\@media (\[height|min-height|max-height\]: 7px){...}

#strong[Mobile First:] Zuerst Layout für alle Screens und den kleinsten
Screen (ohne Media-Query), dann nacheinander mit aufsteigenden \@media
CSS für die (Layout)-Anpassungen mit mehr Bildschirmbreite

\@media screen and (min-width: 30em #emph[\/\*480px\*/];) { \
body:before { \
content: \"480px+\"; \
} \
.fourEighty {…} \
} \
\@media screen and (min-width: 600px) { \
body:before {…} \
.sixHundred {…} \
} \
\@media screen and (min-width: 700px) {…}

#strong[Media/Feature Queries:]

\@media (orientation: landscape) { ... } \
\@supports not (display: grid) { \
div {float: right;} \
}

#strong[Media Operatoren:] Kombinierbar mit and, or, not und only.

\@media (min-width: 20em) and (max-width: 30em){…}

#strong[Mobile Geräte:] Anweisung ist wichtig, um die “Intelligenz“
mobiler Browser zu unterbinden. Nicht angemessen für responsive Sites

\<meta name=\"viewport\"
content=\"width=device-width,initial-scale=1\"\>

#box(image("media/image6.png", height: 1.2368055555555555in, width: 2.047222222222222in))

#strong[Custom Properties:] In CSS können ‘nicht-standard' Properties
definiert werden. Starten mit 2 Minuszeichen. Custom Properties können
anstatt konstanter Werte mit var(…) genutzt werden (auch in calc())

#strong[Beispiel:]

.demo-root { \
\--color-1: red; \
\--color-2: blue; \
#emph[\/\*Werte Definition im Vorfahren\*/ \
];--bg: linear-gradient(to right,

var(--color-1),

var(--color-2)); \
} \
.box { \
width: 200px; \
height: 70px; \
#emph[\/\*Werte Nutzung im Nachfahren\*/ \
];background: var(--bg); \
color: white; \
} \
.variant { \
#emph[\/\*Anpassung Formel Werte im Nachfahren\*/ \
];--color-1: blue; \
\--color-2: red; \
}

#strong[Custom Properties JS:] Custom Properties können mit JS
ausgelesen und verändert werden wie CSS Property-Werte.

const styles = #emph[getComputedStyle];(document.documentElement); \
const red = #emph[String];(styles.getPropertyValue(\'--red\')).trim();

#strong[Style Switching mit Data-Attribute:] Custom Properties können
unter anderem zum Style-Switching genutzt werden. Die Kombination mit
html-Data-Attribut und Regeln mit Attriut-Selektor vereinfachen das JS

:root { \
#emph[\/\*colors\*/ \
];--color-light-red: \#ffeaea; \
\--color-dark-violet: \#47027e; \
} \
\
body\[data-style=\'light\'\] { \
\--color: var(--color-dark-violet); \
\--bg-color: var(--color-light-red); \
} \
\
#emph[\/\*variables / switching\*/ \
];body\[data-style=\'dark\'\] { \
\--color: var(--color-light-red); \
\
\--bg-color: var(--color-dark-violet); \
} \
\
#emph[\/\*applying variables\*/ \
];body { \
color: var(--color); \
background-color: var(--bg-color); \
}

document.querySelector(\'fieldset\') \
.addEventListener(\'change\', (event) =\> { \
const style = event.target.value; \
document.body.setAttribute(\'data-style\', style); \
});

= accessibility
<accessibility>
#strong[Farbkontrast:] Wichtig für Personen über 50

#box(image("media/image7.png", height: 0.9048611111111111in, width: 2.047222222222222in))

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
    align: (auto,auto,),
    table.header([Cross-Site-Scripting], [Replay Attack],),
    table.hline(),
    [Remote Code Execution], [Cryptographic Failures],
    [Insecture Direct Object References], [Identification &
    Authentication Failure],
    [Cross-Site Request Forgery], [],
  )]
  , kind: table
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
