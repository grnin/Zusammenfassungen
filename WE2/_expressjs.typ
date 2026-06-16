#import "../template--additional-formatting-templates.typ": *

= ExpressJS
// #include "/WE2/_code-express-demo-todo.typ"

== Cookies und ExpressJS Session
- Um nach dem Login die Session auf der Website "abzusichern"
#image("/WE2/assets/express-js-1.png", height: 2cm)
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
#image("/WE2/assets/jwt.png", height: 2cm)

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
Statt ```js res.type('text/html'); res.write("<html>"); res.write("<p>..</p>"); ... ```. Template Engines nutzen die Daten und Template zu HTML kombinieren (Hbs, Jade, Pug) // ich denke es gibt auch eine JSX oder HTML Alternative statt handlebars
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
