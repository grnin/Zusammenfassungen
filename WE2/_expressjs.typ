#import "../template--additional-formatting-templates.typ": *

/* zum testen:
#import "../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
    authors: ("Nina Grässli", "Jannis Tschan"),
    fach: "ParProg",
    fach-long: "Parallel Programming",
    semester: "FS24",
    language: "en",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)
// */

#let ascii-art(body) = text(
    font: ("Fira Code", "Fira Mono", "Comic Sans MS", "JetBrains Mono", "JetBrains Mono NL"),
    ligatures: true,
    size: 3.7pt,
    par(
        justify: false,
        body,
    ),
);


= ExpressJS
// #include "/WE2/_code-express-demo-todo.typ"

== Express Architektur und Grundlagen
// • Erklären Sie in eigenen Worten die Patterns von Express.js: MVC, Front-Controller und Middleware
/ MVC Pattern: Model (DB) View (hbs) und Controller (index.js, app.js) getrennt
/ Front-Controller Pattern:
     // https://martinfowler.com/eaaCatalog/frontController.html
    // #image("/assets/image-3.png", height: 1.25cm, width: auto)
    Bild: Request -> Front Controller -> Controller (können verschiedene Controller sein) -> controller zu Model für Daten, zu View für Rendering und Response.
    // TODO svg
    // #image("/WE2/assets/front-controller.svg", height: 1cm)
    #image("/WE2/assets/front-controller.png", height: 1cm)
/ Middleware Pattern:
    Verkettung von Middlewares pro Request, gemäss "Chain of Responsibility" Pattern. Express verwendet Middleware im Front Controller und Routing. Beispiel wenn nicht angemeldet, kann Auth. Middleware direkt Fehler Response senden und es wird nicht weitergegeben.
/ jede Middlware: ist für genau eine Aufgabe verantwortlich, kann eine Aufgabe ausführen, muss den Request beenden oder weitergeben
/ Chain of Responsibility:
    is a behavioral design pattern that lets you pass requests along a chain
    of handlers. Upon receiving a request, each handler decides either to process the request or to
    pass it to the next handler in the chain.


/ Was ist CSR?: Client Side Rendering, rendert im Browser, bei Client, React
/ Vor- und Nachteile CSR?: schnellere Reaktion, weniger Arbeit auf Server, interaktiv. _Nachteile_: SEO, benötigt JS, Content Seiten die selten ändern rendern neu.
/ typische Websiten CSR?: Games, Social Media, Google Earth
#v(-0.2em)
/ Was ist SSR?: fertige statische Website von Server geliefert an Client, ExpressJS
/ typische Websiten SSR?: Blogs, statische Webseiten, News Portal
/ Vor- und Nachteile SSR?: Performance, SEO, einfach, nicht mehrfach die gleiche Seite rendern. #hinweis[siehe Vorteile CSR]
#v(-0.2em)
Vorteil beim _Redirect von POST /random nach GET /random?from=…_ gegenüber der direkten Darstellung der Daten in der POST-Route?
> Formulardarstellung nur 1 mal programmieren, einheitlich, DRY
> URL kann weitergegeben werden von GET, Lesezeichen kann erstellt werden.
> Mit F5 (neuladen) werden bei POST die Daten nochmals abgesendet (mit Warnung Popup vom Browser). Bei GET wird nur die Seite neu geladen.

== Cookies und ExpressJS Session
- Um nach dem Login die Session auf der Website "abzusichern"

// #image("/WE2/assets/express-js-1.png", height: 2cm)
#ascii-art(
    "Client                                             Server
 |  POST /login                                       |
 | -------------------------------------------------> |
 | <------------------------------------------------- |
 |                set-cookie: session-id:1234         |
 |                                                    |
 |  GET /addToCard?id=12  cookie: session-id:1234     |
 | -------------------------------------------------> |
 |                                                    |
 |   GET /submitCard  cookie: session-id:1234         |
 | -------------------------------------------------> |
 |                                                    |
",
)

Server: `set-cookie:name=value;Expires=Wed, 09 Jun 2029 10:18:14 GMT`
Client: `cookie:name=value; name2=value2`

- Cookies für "ExpresJS Session": ```js app.use(session({ secret: ,'1234567', resave: false, saveUninitialized: true})); ```

// import express from 'express';
// import cookieParser from 'cookie-parser';
```js
const app = express();
app.use(cookieParser("secret"));

app.get("/cookieDemo/{*splat}", function (req, res) {
    console.log(JSON.stringify(req.cookies));
    console.log(JSON.stringify(req.signedCookies));
    res.cookie("url", req.url);
    res.cookie("signedUrl", req.url, {signed: true});

    if (req.cookies.url) {
        res.end(`das war dein letzter Besuch:
Cookie: ${req.cookies.url}
SignedCookie: ${req.signedCookies.signedUrl || "---"}`);
    } else { res.end("erster Besuch?!") }
});

app.listen(3000, function () {
    console.log('listening on http://localhost:3000');
});
```


== JSON Web Token (JWT) JSON-based open standard (RFC 7519).
- um eine API abzusichern (REST)
/ HTTP-Header: `Authorization: Bearer <token>`
/ Inhalt: Header, Payload (Claims), Signatur
/ HTTPS: Token nur über eine sichere Verbindung versenden
/ speichern: Token kann auch im Cookie abgelegt werden #hinweis[mit `httpOnly, secure, SameSite, Lebensdauer` und Achtung CSRF]


// #image("/WE2/assets/jwt.png", height: 2cm)

// +-----------+                                  +-----------+
// |  Browser  |                                  |  Server   |
// +-----------+                                  +-----------+
#ascii-art(
    "Browser                                     Server
 |  1. POST /users/login (username, pw)  ->   |
 | -----------------------------------------> |
 |                                            | 2. Creates JWT
 |   3. Returns the JWT to Browser  <-        |
 | <----------------------------------------- |
 |                                            |
 |   4. Sends JWT on Authorization Header ->  |
 | ------------------------------------------>|
 |                                            | 5. Check JWT signature
 |   6. Sends response to the client  <-      | Get user info from JWT
 | <----------------------------------------- |
 |                                            |
",
)

== AJAX mit fetch Repetition
```js
fetch(url, {
    method: method,
    headers: { 'Content-Type': 'application/json'},
    body: JSON.stringify(data),
    credentials: 'include', // cookies mitsenden
}).then(x => {
    return x.json();
// statt json() -> arrayBuffer(), blob(), formData(), text()
});

// Hilfsklasse für Request von Fetch API
const myHeaders = new Headers();
myHeaders.append('Content-Type', 'text/plain');
    const myInit = {
    method: 'GET',
    headers: myHeaders,
    cache: 'default'
};
const myRequest = new Request('/example', myInit);
fetch(myRequest) /*…*/
```

== Middlewares
#v(-1.25em)
=== Routing
Middleware befindet sich auf dem Express Objekt
```js
import express from 'express'; const router = express.Router();
```
Wichtige Methoden
```js
// Wird unabhängig vom der HTTP-Methode aufgerufen
router.all(path, [callback, ...] callback)
```

Wird aufgerufen, falls die jeweilige HTTP-Methode verwendet wurde\
*METHOD* = .all, .get\
*path* = `/*, /{*} (optional), /:id (wird in req.params.id gespeichert)`
```js
router.METHOD(path, [callback, ...] callback)
router.get('/', function(req, res){ res.send('hello world'); });
```
// − Express.js verwendet path-to-regexp

Es können mehrere Callbacks als Chain übergeben werden
```js
router.get("/admin", ensureAdmin, renderAdmin);
router.get("/profile/:id", ensureUser, renderProfile)
```

=== Static-Middleware
Statische Files ausliefern (Es sind mehrere static-routes möglich)
```js
app.use(express.static('public'))
```

=== Custom-Middleware
==== 3 Parameter (request, response, next)
- `next` zeigt auf die nächste Middleware im Stack, kann aufgerufen werden, um die nächste Middleware aufzurufen.
// • Dies kann auch unterlassen werden. In diesem Falle sollte die Anfrage beantwortet werden.
```js
function myDummyLoggerMiddleware(options = {}) {
    options = {timestamp: true, ...options};
    return function myInnerDummyLogger(req, res, next) {
        const timestamp = options.timestamp ? new Date().toISOString() + " " : "";
        console.log(`${timestamp}${req.method} ${req.url}`)
    next();
}   }
```

==== Error-Middleware
- muss 4 Parameter haben, die letzte (Error) Middleware muss die Anfrage beenden
- aufgerufen bei: `next(new Error("…"));`, `Promise.reject(new Error("..."))`, `throw new Error("...")`
```js
app.use(function(err, req, res, next) {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});
```

== View mit Template Engine - Handlebars
Statt ```js res.type('text/html'); res.write("<html>"); res.write("<p>..</p>"); ... ```. Template Engines nutzen die Daten und Template zu HTML kombinieren (Hbs, Pug) // pug hiess früher Jade
*Begriffe*: Layouts (Definieren wiederverwendbare Grundstrukturen), Partials/Components (Wiederverwendbare Template-Bausteine), Helpers (Hilfsfunktionen, Erweiterung der Template-Sprache)
// / Layouts: Definieren wiederverwendbare Grundstrukturen
// / Partials/Components: Wiederverwendbare Template-Bausteine
// / Helpers: Hilfsfunktionen, Erweiterung der Template-Sprache

===== Beispiel Template:
```js
render("template", {pizzaName: "Hawaii", _id: 3, state: "OK"});
```
```html
<p>Order-Infos</p>
{{#if pizzaName}}
    <p>Ordered Pizza: {{pizzaName}}</p>
    {{#if_eq state "OK"}}
        <form action='/orders/{{_id}}' method='post'><input type='hidden' name='_method' value='delete'><input type='submit' value='Delete order'>
        </form>
    {{/if_eq}}
{{/if}}
```

```js render("template", {description: "List of some Movies", items: songs}); ```
```html
<figure><ul>
    {{#each items}}// title == this.title = bezieht sich auf items
        <li><h3>{{title}}</h3><p>{{this.artist}}</p></li>
    {{/each}}
    </ul><figcaption><p>{{description}}</p></figcaption>
</figure>
```


// ```js render("template", {description: "List of some Movies", items: songs}); ```
// ```html
// <figure>
// <ul>
// {{#each items}}
// // ist title und artist hier das gleiche wie this.title und this.artist?
// <li><h3>{{title}}</h3><p>{{artist}}</p></li>
// {{/each}}
// </ul>
// <figcaption>
// <p>{{description}}</p>
// </figcaption>
// </figure>
// ```



===== Beispiel Layout - Trennung View und Controller
```js
export class IndexController {
    index(req, res) { res.render("index", {data: "Hello World", dark: true}); };
}
```
```html
// Layout.hbs:
<!doctype html><html lang="en"><head>
<meta charset="UTF-8"><title>Pizza</title>{{#if dark}}<style>body {background: black; color: white; }</style>{{/if}}
</head>
<body>{{{body}}}</body>
</html>
```

// /*
===== Beispiel als Express View
```js
// 1. import express-handlebars
import exphbs from 'express-handlebars';
const app = express();
// 2. configure
const hbs = exphbs.create({
    extname: '.hbs',
    defaultLayout: "default",
    helpers: { ...helpers }
});
// 3. set engine and global values
app.engine('hbs', hbs.engine);
app.set('view engine', 'hbs');
// 4. path to views
app.set('views', path.resolve('views'));
```
// // express macht: app.render(view, [locals], callback)
// createPizza = async (req, res) => {
//     res.render("succeeded", [DATA]);
// };
// */


== Model = Service
/ Möglichkeiten, um Daten zu speichern: In Memory: Array, JSON, NoSQL-Datenbanken = Dokumentorientierte Datenbanken (nedb), SQL-Datenbanken

==== nedb NoSQL
```js
// Datenbank laden
import Datastore from '@seald-io/nedb';
const db = new Datastore({filename: './data/order.db', autoload: true});

// Einfügen - Feld _id wird gesetzt: eindeutige ID von der Datenbank
const order = new Order(pizzaName, orderedBy); const newOrder = await db.insertAsync(order);
console.log(newOrder._id) // eM3RIO9MTAPaYTIS

// Suchen - find oder findOne
const order = db.findOneAsync({_id: id});

// Updaten -  z.B. Einzelne Werte ändern, Array von einem «document» anpassen, ganzes Objekt ersetzen
await db.updateAsync({_id: id}, {$set: {"state": OrderState.DELETED}});
```
