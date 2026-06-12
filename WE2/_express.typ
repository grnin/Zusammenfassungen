

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

#image("/assets/image-6.png")


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

Request -> Middlewares -> Response
// #figure(
//     align(center)[#table(
//         columns: (19.74%, 13.36%, 33.07%, 13.4%, 20.42%),
//         align: (auto, auto, auto, auto, auto),
//         table.header([], [], [Middleware 1], [], []),
//         table.hline(),
//         [Request], [], [Middleware 2], [], [Response],
//         [], [], [Middleware 3], [], [],
//     )],
//     kind: table,
// )

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

#image("/assets/image-5.png")
// #box(image("media/image2.png", height: 0.75in, width: 2.047222222222222in))

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

```tsx
interface IPoint {
readonly y?: number;
}
class Item {
constructor(public description: string) {}
}
class POI extends Item implements IPoint {
constructor(public x: number,
public y: number,
description: string,
public likes?: number) {
super(description);
}
}
```


#strong[Typen vs Interface:] Vielfach lassen sich stukturierte Typen
sowohl als Interface als auch als Type definieren. Aber nur ein
«Interface» kann unter gleichen Namen erweitert werden und nur ein
«Type» kann Werte spezifizieren.

#strong[Type Assertion:] Type Assertion erlauben Spezialisierung und
Generalisierung des Typs, aber kein Casting auf einen inkompatiblen Typ.
Mit keyof lässt sich ein Ty paus einem anderen Typen ableiten
```tsx
const myCanvas = document.getElementById(\"ina\") as HTMLCanvasElement;

const x = \"hello\" as number; #emph[\\/\/ nicht erlaubt]

type Point = { x: number; y: number }; \
type PK = keyof Point;

#strong[Template Literal Types:] Mit Template Literal Types lassen sich
«literal» Types aus anderen Typen ableiten.

type Shipper = \'UPS\' | \'FEDEX\' | \'DHL\'; \
type Type = \'Overnight\' | \'Priority\' | \'Economy\'; \
type PostMethod = \`\${Shipper}-\${TrackingType}\`;
```

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




