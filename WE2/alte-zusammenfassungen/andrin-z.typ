Web Engineering 2
https://github.com/aendi123/ost-bsc-it-summaries/tree/main
pdf: https://studentenportal.ch/dokumente/wed2/2715/

= Node.js
<node.js>
Callback: Funktion, die als Argument einer anderen Funktion übergeben
wird, wo sie aufgerufen wird

```js
function logger(msg) { console.log(msg); }
function fn(n1, n2, callback) {
let sum = n1 + n2; callback(sum); }
fn(1, 2, logger)
```

Promise: bildet asynchrone Abläufe besser ab, bei Erfolg wird
Fulfilled-Cb. aufgerufen, bei Fehler Reject-Cb.
```js
let prom = new Promise((resolve, reject) => {
setTimeout(() => { let success = true;
if (success) { resolve("good"); }
else { reject("bad"); } }, 2000); });
prom.then(msg => console.log(msg))
.catch(error => console.log(error));
```
Wichtige Node Packages (mehr Methoden vorhanden):
```js
const fs = require('node:fs/promises'); // oder node:fs
readFile(path[, options]); writeFile(file, data[, options]);
unlink(path); mkdir(path[, options]); rmdir(path[, options])
// vor Funktion jeweils "fs.", callback letztes Argument
const url = require('node:url');
const u = new URL("↓"); // z.B. u.href & u.search.query
```

// url image
// #box(image("Pictures/10000001000003700000009ADAEAB952.png", height: 0.3693in, width: 2.1138in))
CommonJS:
älter, verbreiteter, synchron, nur in Node, dynamische Imports at
Runtime, kein Tree Shaking, File Extensions .js/.ts/.cjs/.cts, use
strict muss explizit gesetzt werden, Import mit require, this=exports
```js
module.exports = // default
exports = // default read-only
module.exports.name = // named
exports.name = // named read-only
```
#emph[#strong[ESM];];: ab Node 14, asynchron, in Node & Browser,
statische Imports at parse time, File-Extensions .mjs/.mts, strict Mode
ist Default, this=undefined, #strong[Resolve-Reihenfolge];: 1. Core
Module (z.B. from \'fs\'), 2. Pfad mit /, ./, ../ am Anfang (z.B. from
\'./m.mjs\'), 3. Filename (z.B. from \'counter\', Modul wird in
node\_modules bis root gesucht)

#emph[#strong[package.json];];: beinhaltet Projekt-Infos, nötig für
Publishing & Installation, definiert Scripts, package-lock.json
beschreibt exakten Abhängigkeitsgraph
```js
{ "name": "test", "version": "1.0.0", "main": "index.js",
"scripts": { "test": "echo \"no tests\" && exit 1" },
"keywords": [], "author": "", "license": "ISC",
"description": "", "type": "commonjs/module" }
```

// ab hier habe ich den code nicht eingefügt
= Express.js
<express.js>
meistgenutztes, etwas veraltetes Web Framework

#box(image("Pictures/10000001000007400000033559150201.png", height: 0.9291in, width: 2.102in))#emph[#strong[Middlewares];];:
werden mit use() registriert, Registrierungsreihenfolge =
Ausführungsreihenfolge, next(); zeigt jeweils auf die nächste MW,
offizielle Middlewares: body-parser, compression, connect-timeout,
cookie-parser, cookie-session, csurf, errorhandler, express-session,
method-override, morgan, response-time, serve-favicon, serve-index,
serve-static, vhost

#emph[#strong[E];#strong[rror-Middleware];];: bearbeitet Errors, welche
von den MWs generiert wurden, sollte zuletzt registriert werden, mehrere
sind möglich, wenn next() mit einem Error-Objekt aufgerufen wird, werden
keine MWs mehr ausgeführt und stattdessen die Error-MWs ausgeführt, 4
Params:

Body-parser: parst Request-Bodies und stellt die Variablen unter
req.body zur Verfügung

Cookie-parser: Parst den Cookie Header und stellt die Cookies unter
req.cookies zur Verfügung

Express-session: req.session ist ein Objekt, das temporär Infos über
aktuelle User Sessions speichert

#emph[#strong[Error-handler];];: development-only, schickt error stack
traces zurück zum Client je nach Konfiguration

#emph[#strong[Csurf];];: verhindert Cross-Site Request Forgery (CSRF)
Angriffe durch CSRF Tokens in Cookies

#emph[#strong[express.static];];: Bereitstellung statischer Files wie
Bilder, CSS-/JS-Files, Beispiel am Anfang des Kapitels

express.router: Router fürs Request-Handling, Beispiel router const und
use(router) am Anfang des Kapitels

Request Parameter: Ressourcenidentifikation, Abbildung hierarchischer
Datenstrukturen

URL Query Parameter: Such-/Filter-Operationen, Steuerung Pagination,
Beispiel für \"/search?t1=a&t2=b\"

NEDB: dokumentorientierte, file-backed Datenbank

Cookies: im Browser, können persistent sein, automatisch bei jeder
Anfrage gesendet, für Sitzungsverwaltung, Personalisierung, Tracking und
Analyse

Session Objekte: auf dem Server, Lebensdauer bis Ablauf oder Logout, nur
innerhalb von Express verfügbar, für Sitzungsverwaltung und speichern
temporärer Infos über aktuelle User Sessions

REST: Verschiedene Paths für verschiedene Ressourcen, HTTP-Verben & JSON
korrekt verwenden, stateless: Session durch JWT Token im Header ersetzen

Neben json(): arrayBuffer(), blob(), formData() & text()

#emph[#strong[Web-Sockets];];: bidirektionale, dauerhafte
Kommunikationsverbindung zwischen Client & Server, geringe Latenz, wenig
Overhead, komplexe API (socket.io), für Echtzeit-Apps: Chat, Game,
Live-Ticker, Docs-Collab, Push-Nachrichten, interaktive Video- /
Audio-Streams

Handlebars.js: Template Engine, um auf der Server-Side HTML Code zu
generieren

Weitere Hbs Builtin Block Helpers: \#if, \#unless, \#with

= TypeScript
<typescript>
#emph[#strong[TypeScript-];#strong[ESLint];];: statische Analyse des
Codes zur Fehlerfindung, Installation: \"npm install --save-dev eslint
\@eslint/js \@types/eslint\_\_js typescript typescript-eslint\", Lint
ausführen: \"npx eslint .\", eslint.config.js:

#emph[#strong[Prettier];];: formatiert Code beim Speichern, setzt
konsistente Stilregeln durch, ESLint berücksichtigt auch Prettier
Regeln, VS Code Extension, .prettierrc:

#emph[#strong[Basis-Typen];];: boolean, number, string, null, undefined
(no value), any (don\'t care), unknown (don\'t know), void, never,
array, tuple, enum, union

Types/Interfaces: Interface verwenden, ausser man braucht Feature von
Type (union, intersection, primitive)

#emph[#strong[Strict Mode];] (\"strict\": true compilerOption in
tsconfig.json): noImplicitAny, noImplicitThis, alwaysStrict,
strictBindCallApply, strictNullChecks, strictFunctionTypes,
strictPropertyInitialization, useUnknownInCatchVariables

= Responsive Design
<responsive-design>
Flexible Layout: zusätzlicher Platz wird durch Verbreiterung der
Elemente ausgefüllt, lässt sich ohne Media-Queries umsetzen, dynamisch,
grössenadaptiv

Responsive Layout: zusätzlicher Platz wird durch Umordnung und
zusätzliche Elemente / Spalten ausgefüllt, braucht Media Queries,
dynamisch, optimiert für untersch. Geräte / Bereiche von
Display-Grössen, jedes der Layouts ist meist ein flexibles Layout

Graceful Degradation: App wird mit voller Funktionalität für moderne
Browser geschrieben, dann werden Layers entfernt, damit es auch auf
älteren Browsern funktioniert

Progressive Enhancement: App wird nur mit Funktionen geschrieben, die
alle Browser supporten, dann werden fortgeschrittenere Features
hinzugefügt wie Layers

Mobile First Layout: wie PE, technische Bedeutung: Base CSS ist für
Mobile, grössere Displays werden extra hinzugefügt, Design Bedeutung:
Wireframes für Mobile

CSS Reset: reduziert Inconsistencies zwischen Browsern, löscht Browser
Default CSS, viele Properties muss man danach erneut setzen, was den
Code aufbläst

CSS Normalization: Properties werden genormt über alle Browser, sie
verhalten sich also alle gleich, sinnvolle Voreinstellungen wie Abstände
bleiben erhalten

Media Queries: spezifisches CSS für untersch. Medien

Media Query Operatoren: \"and\", \",\", \"not\", \"only\"

Einheiten: px (Pixel, wird durch Zooming verändert), rem (font size des
root Elements), em (font size des parent element), % (relativ zur Grösse
des parent element)

Trigger Punkte: 480px / 30em (Smartphone), 768px / 48em (Tablet), 992px
\/ 62em (Desktop)

Container Query: eigene Breakpoints pro Komponente

Query Units (bezogen auf Container Query): cqw (width), cqh (height),
cqi (inline-size), cqb (block-size), cqmin (min(cqi, cqb)), cqmax
(max(cqi, cqb))

Viewport: unterbindet Intelligenz mobiler Browser, welche Seitengrösse
überdimensioniert für Sites ohne Tag

position relative, negative margin-top, position absolute

#box(image("Pictures/1000000100000CC1000002FA25AC1A21.png", height: 0.4929in, width: 2.1154in))#emph[#strong[Display];];:
inline (margin l/r, padding, top, bottom, width, height), block (margin,
padding, overflow: scroll/hidden/invisible), inline-block (margin,
padding, width, height, vertical-align: top)

#emph[#strong[Box sizing];];: calc(100vw-5em) min(500px,100vw-5em)
max(400px,100vw-5em) clamp(400px,10vw-5em,500px)

Flexbox: Kinder eines Flex containers können flexibel angeordnet und
ausgerichtet werden

Grid: 2-D Raster zur flexiblen Anordnung von Elementen

= Accessibility
<accessibility>
#strong[Rechtlich];: UNO-Behindertenrechtskonvention (UNO-BRK),
gleichberechtigte Möglichkeiten im Zugang & Benutzung von Informations-
& Kommunikationssystemen

Häufigste Fehler: Text zu wenig Kontrast, kein alt Text, leere
Links/Buttons/Doc-Sprache, fehlende Form Labels

Farbenblindheit: prüfen mit Dev-Tools (Rendering), Doppel-Codierung
notwendig (Farbe & Form/Icon/Text), kritische Informationen nicht nur
mit Text codieren, farbenblind-freundliche Farbpaletten wählen

Farbkontrast: prüfen mit Dev-Tools (Color Picker) & Lighthouse / Firefox
Report, Zielgruppe erweitern mit WCAG Kontrast Level AA (5.7:1, 50+),
AAA (15.9:1, 80+)

Zoombarkeit: Zoom nicht unterbinden, Falsch: user-scalable=0/no,
maximum-scale=1

Animationen: sollten abstellbar sein, Verringerung der Ablenkung bei
Konzentrationsstörung, Verhinderung der Auslösung von Epilepsie und
Migräne

Tastatur-Bedienbarkeit: alle wichtigen Input-Elemente sind in der
richtigen Reihenfolge fokussierbar, verboten: float, flex-direction:
\*-reverse, Standard Input Controls nutzen: a, button,
input\[type=\"…\"\], textarea, zusätzliche Elemente können mit
\"tabindex=0\" fokussierbar gemacht werden, Elemente jeder Seite können
mit \"autofocus\" versehen werden

Screenreader-Optimierung: keine Headings Level auslassen, semantische
Elemente richtig nutzen, Skip-Links am Anfang der Site, lang Attribut
korrekt setzen

ARIA Attribute: lösen Accessibility Issues, die nicht mit nativem HTML
gelöst werden können, heissen jeweils aria-\*, wichtigste: hidden,
label, expanded, current, labelledby, controls, haspopup, invalid, live,
required

Tabellen: Heading für Rows & Columns mit \<th\> ausstatten, alternativ
\<td role=\"columnheader/rowheader\"\>

Allgemeines: alt Tag bei Bildern, leer wenn dekorativ, logische
Reihenfolge auch ohne CSS, semantische Struktur, Multimedia: 2-Sinne
Prinzip, Anzeige-Art kann angepasst werden (Textgrösse, Animationen,
Zeitlimits), Überschriften/Form Labels/Linktexte sind verständlich, auf
Formatwechsel (z.B. PDF) wird hingewiesen, konsistente Navigation,
valides HTML, kompatibel mit versch. I/O Geräten, Hilfestellung bei
Interaktionen, PDFs auf PDF/UA Konformität validieren, keine Tabellen
für Layout

= Security
<security>
#emph[#strong[Stored XSS];];: Server kann so manipuliert werden, dass JS
Code an die Browser der Opfer ausgeliefert & ausgeführt wird,
#emph[Massnahmen];: User-Input muss beim Output encodet werden, z.B. mit
3x {} in Handlebars, oder User-Input wird sanitized, z.B. mit xss oder
dompurify Library

#emph[#strong[JS Injection];];: dem Server kann JS Code gesendet werden,
welcher ihn im Code mit eval()/setTimeout()/setInterval()/Function()
ausführt, #emph[Massnahmen];: stattdessen parseXXX()/JSON.parse()
verwenden, globale Scopes & Variablen reduzieren, rechen-intensive Tasks
mit childprocess.spawn auslagern, Node kein Root-Prozess

#emph[#strong[Insecure direct object references];];: durch Manipulation
der URL lassen sich sensible Daten ohne Authentifizierung oder
Autorisierung aufrufen, #emph[Massnahmen];: bei allen Sites mit
sensiblen Daten sicherstellen, dass der User eingeloggt und berechtigt
ist

#emph[#strong[Cross Site Request Forgery];];: Angreifer bringt Nutzer
mit gültiger Session dazu, auf einer Site ein gefälschtes Formular an
die richtige Site zu submitten, #emph[Massnahmen];:
Formular-Submission-Requests (GET/POST) müssen geprüft werden, ob sie
von einem vom Server frisch ausgelieferten Formular stammen (mit CSRF
Token)

#emph[#strong[Replay attacks];];: z.B. bei Quiz wird mit Formular
Aufgabe und User-Input-Lösung submitted, wenn richtig gibt es einen
Punkt, das kann replayed werden, sollte aber nicht gehen, da der User
dann unrechtmässig Punkte erhält, #emph[Massnahmen];: CSRF Token 1x
gülitg, bereits gelöste Aufgaben speichern, letzte Aufgabe in Session
speichern

#emph[#strong[Cryptographic failures];];: Crypto schlecht eingesetzt,
#emph[Massnahmen];: https nutzen, keine geheimen Infos in Query-Params
(Leaks in Server Logs oder Browser History), Authentication Service
nutzen

#emph[#strong[Identification & Authentication failures];];: z.B. ist
Session Timeout zu lang, User bleibt auf öffentlichem PC eingeloggt,
#emph[Massnahme];: Session Timeout sinnvoll setzen

#emph[#strong[CORS Header];];: ermöglicht Laden von Ressourcen (Bilder,
Scripts, usw.) von anderem Ursprungsort als eigener #emph[Origin];, man
beschränkt, welche Websites auf seine Ressourcen zugreifen dürfen

#emph[#strong[CSP ];#strong[Header];];: Content Security Policy,
Beispiel schränkt Kommunikation auf Source Domain/api.ch ein, externe &
Inline-Scripts sind verboten, aktivieren mit unsafe-inline

#emph[#strong[Weiteres];];: DNS Prefetching & Client Caching
deaktivieren, Public Key Pinning Headers, Strict-Transport-Security
Header (HSTS) setzen, X-XSS-Protection Header, Safe-Regex verwenden
(DDoS), Parameter pollution

#emph[#strong[Cookies];];: #emph[Secure] Attribut: Cookie wird nur über
HTTPS versendet, nicht HTTP (ausser localhost), #emph[HttpOnly]
Attribut: deaktiviert Zugriff auf Cookies aus JS

= #box(image("Pictures/1000000100000962000004A2B671702A.png", height: 1.0429in, width: 2.1138in))Testing
<testing>
#emph[#strong[Unit Test];];: einzelne Klassen/Module (meist ein File)
werden getestet, einfache Automation, #emph[Herausforderungen];: Units
isolieren, asynchrone Operationen, Testdaten-Generiung (z.B. Fuzzing)

#box(image("Pictures/100000010000072F00000369593545C2.png", height: 0.9646in, width: 2.0311in))#emph[#strong[Integration
Test];];: Zusammenspiel von 2 oder mehr Units wird getestet, Automation
meist möglich, #emph[Herausforderungen];: gleiche wie bei Unit Tests,
Simulation Browser & Benutzerinteraktion, Test mit Datenbank

#emph[#strong[End-to-End Test];];: Integration Test über alle Layer

#emph[#strong[Anderes];];: Smoke, Static (TypeScript), Regression, Load,
Performance, Endurance, Chaos, Security, Usability

Test-Runner: Rahmen, der Tests entgegennimmt, ausführt und Resultate
anzeigt, z.B. Mocha, Cypress

Assertion Library: gut lesbare Annahmen schreiben, die nicht verletzt
werden sollten, z.B. Assert, Chai

Mocking Library: Separierung von Units, Erstellung von Test-Doubles
insb. Mocks, z.B. Proxyquire, Sinon.js

Test Double Pattern: Bei Unit Tests hat man zum Teil ein Dependent On
Component (DOC) an der Unit, mit Sinon kann man einen vorbestimmten
Input (Stub/Fake) fürs SUT und überprüfbaren Output (Spy/Mock) liefern

Eigenschaften guter Unit Tests: Output statt Internes testen, jeder Test
hat voraussagbare & deklarative Struktur, nur eine Aktion und der Output
davon testen, keine Daten mit anderen Tests teilen, alles Nötige zum
Verstehen der Absicht muss im Test sein

Unit Test Smells: Hard-to-Test Code, viele Bugs bei formalem Testing &
Produktion, Tests failen wenn SUTs so verändert werden, dass die Tests
nicht beeinflusst werden sollten, Mal-so-mal-so Tests, Conditionals in
Tests, Test-Code Duplikate, langsame Tests, schwierig zu verstehende
Tests, Test-Logik im Prod-Code, schwer zu sagen welches Assert im Test
failed, keine Tests

= Internationalization
<internationalization>
Internationalisierung: Software-Entwicklungs-Methode, damit alle
Benutzerausgaben per Spracheinstellung austauschbar und nicht hard-coded
sind

Lokalisierung: Inhalt den sprachlichen & kulturellen Eigenheiten
bestimmter Zielkulturen/Länder anpassen

Übersetzung: Inhalt übersetzen, Arbeit der Übersetzer

Locale: String, der Region (Sprache & Land) bestimmt

Unterschiede Sprachregionen (nicht halbautomatisch anpassbar):
kulturelle Unterschiede (Bilder, Symbole, Farben), regulatorische
Anforderungen (Daten-/Verbraucherschutz), sprachliche Feinheiten
(Dialekte, Idiome, Redewendungen), UX und Usability (Navigation,
Benutzerführung, Leserichtung), Markt- & zielgruppenspezifische
Anpassungen (Produktangebote, Werbung, Marketing), kulturelle
Sensibilitäten (politische & soziale Themen, Feiertage), Titel &
Anreden, anderes Konzept als Vorname/Nachname, Schreibweise von Adressen
& Telefon-Nummern, Satzzeichen, Masseinheiten (Umrechnung), Kalender,
Sounds, Layout, Steuern

= Animation
<animation>
Most properties that accept a length, number, color, or the function
calc() can be animated. Most properties that take a keyword or other
discrete values, like url(), can't.

#box(image("Pictures/1000000100000DFD0000030540A19BB1.png", height: 0.4516in, width: 2.0882in))#emph[#strong[\@property];];:
Initialwert, Interpolation, Type Safety

#box(image("Pictures/1000000000000780000003207D0A55A7.png", height: 0.3945in, width: 2.1055in))

= User Experience
<user-experience>
#emph[#strong[Don\'t listen to users];];: Schauen was User machen, nicht
was sie sagen, Kunden fragen, User nicht, #strike[Umfragen]

Problem Space: User analysieren, beschreiben, haben Bedürfnisse und
Probleme

Solution Space: Designer, Vision, Storyboard, Prototyp

Problem / Future Scenario: User, Problem Beschreibung, Kontext, Trigger,
Schritte, Lösung / Fail

Gute UI Ausschilderung: Wo bin ich? (Titel, Breadcrums) Wo kann ich hin?
Was ist passiert? Kofferraum

Concept Model: Benutzer, Ressource und Beziehungen

Site Map: Seitenhierarchie (Baum) wie in der Navigation

Card Sort: Cards mit allen Seiten erstellen, Cars gruppieren & Gruppen
benennen (Open), Gruppennamen validieren (Closed), 1 Hierarchiestufe

#emph[#strong[Tree Testing];];: Site Map aufnehmen, Szenarios zur
Erreichung von Zielen stellen, #emph[#strong[W];#strong[ireframe];];:
Screen-Skizze

#emph[#strong[Screen Flow];];: Wireframe-Abfolge, zeigt User-Szenario

#emph[#strong[Gute Test-Szenarien];];: plausible Ziele, Kontext,
Trigger, Skills, keine Schritte sagen, neutrale Personen, Konzept nicht
Usability testen, Pre- & Post-Umfragen, think aloud

#emph[#strong[U];#strong[sability Kriterien Nielsen];];: Sichtbarkeit
des System-Status, enger Bezug zwischen System und realer Welt,
Nutzerkontrolle und Freiheit, Konsistenz & Konformität mit Standards,
Fehler-Vorbeugung, besser Sichtbarkeit als sich-erinnern-müssen,
Flexibilität und Nutzungseffizienz, Ästhetik und minimalistischer
Aufbau, Nutzern helfen, Fehler zu bemerken, zu diagnostizieren und zu
beheben, Hilfe und Dokumentation

Messen: Effektivität -- User können Ziele erreichen, Effizienz --
angemessener Aufwand zur Zielerreichung, Zufriedenheit: positive
Einstellung gegenüber System

= Web DevOps
<web-devops>
#emph[#strong[CSS Präprozessoren];];: SWE Prinzipien, weniger C&P,
Modularisierung, Funktionalitäten wiederverwenden

#emph[#strong[PostCSS];];: Framework zur CSS-Tool-Entwicklung,
Parser→API→Plugins→Stringifyer, z.B. AutoPrefixer für browser-specific
CSS, Minifier, Polyfill (modern→alt)

#emph[#strong[Frameworks];];: Bootstrap, Tailwind, Material UI

#strong[Build Tools];: komplexe grosse Projekte, häufige
Aktualisierungen, Teamarbeit, Minimierung, Transpilierung,
Modulbündelung, Automatisierung, Linting, Sourcemaps

#emph[#strong[Weitere ];#strong[K];#strong[ategorien];];: IDE, Package
Manager, Code Control, Code Formatodoter, Linter, (E2E) Testing Tool, CI
Service, SSR, DB, CMS, Logging, Cloud Service

= Undo
<undo>
#emph[#strong[Vorteil ggü. a];#strong[ktiven Notifikationsdialogen];];:
Fehler einfach korrigieren, unnötige Dialoge vermeiden, weniger Angst,
experimentieren geht, Redo ist auch wichtig

#emph[#strong[W];#strong[ichtige Design-Erwägungen];];: Kontext (App,
Dokument, Feld), Granularität (Buchstabe(nsequenz)), Operationen (Edit,
Select, Resize, Print?, Send?)
