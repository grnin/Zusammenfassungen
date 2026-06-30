#import "../template--additional-formatting-templates.typ": *

// Zusammenfassung mit mehr Inhalt als der Spick, der auf 2 Seiten beschränkt worden ist.

// /*
#import "../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
    authors: ("Jasmin Fässler",),
    fach: "WE2",
    fach-long: "Web Engineering 2",
    semester: "FS26",
    language: "de",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)
// */

#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]



= React Anwendungshilfe
=== Wie baut man UIs in React? (Thinking in React) / Wie komme ich von einer Skizze/Wireframe/... zu einer Anwendung?
//#todo[mehr Abstand hier zwischen Elementen:]
1. *Eine Idee haben, wie es aussehen soll (Skizze, Mockup, HTML/CSS)*
    Das kann ein Mockup (links) sein, ein (HTML-, Papier-, Figma-, ...)Prototyp, ein Datenmodell, eine JSON-API-Response
2. *Zerlegen in eine Komponentenhierarchie*
#image("/WE2/assets/SW01 Einführung React-2026-02-2.png")
#image("/WE2/assets/image-1.png")
3. *Eine statische Version in React implementieren*
    Statisches UI in React
    ```js
    const FilterableProductTable = ({ products }) => {
       // ...
     };
     const SearchBar = () => {
       // ...
     };
     const ProductTable = ({ products }) => {
       // ...
     };
     const ProductRow = (props) => {
       // ...
     };
    ```

4a. *Den minimalen, kompletten UI Zustand (State) finden*
Um die Anwendung interaktiv zu machen, müssen User das Datenmodell anpassen können.
Wir verwenden dafür State.
Der State (Zustand) der Anwendung sollte das kleinstmögliche Set von Daten sein, die sich 	ändern und die Anwendung sich merken soll.

Prinzip für die Struktur des State -> DRY (Don't repeat yourself)
"Make your state as simple as it can be — but no simpler."

4b. *Herausfinden, wo der State leben soll*
Jetzt kennen wir den State - Wo in der Anwendung kommt der hin? Grundsätzlich kann jede Komponente State
besitzen. Wir erinnern uns, Daten können durch Props immer nur von Parent zu Child weitergegeben werden.

Vorgehen für jedes Stück Zustand:
Alle Komponenten identifizieren, die etwas aufgrund dieses Stück Zustands darstellen.
Den nächsten gemeinsamen Parent in der Hierarchie finden.
Entscheiden, wo der Zustand leben soll
Häufig ist es der *gemeinsame Parent*
Machmal ist es eine höhere Komponente als der gemeinsame Parent
Wenn es keine Komponente gibt, wo die Platzierung des States Sinn ergibt, erstelle eine neue
Komponente und platziere sie in der Hierarchie überhalb des gemeinsamen Parents
#image("/WE2/assets/image-4.png")

- Nutze Eventhandler

5. Datenflow von Child zu Parent aufbauen


= JS und React Grundlagen
enthandler
Wir brauchen Funktionen, die Interaktionen im UI mit dem State verbinden -> Eventhandler.
`<button onClick={() => setCounter(counter+1)}>Click Me</button>`
Native HTML Elemente haben in React spezielle Attribute/Props, die Eventhandler aufnehmen.
Einige der häufig verwendeten:
- onClick für Buttons
- onChange für Inputfelder
- onFocus/onBlur
Diesen Attributen können wir Eventhandler-Funktionen übergeben.
Eventhandler-Funktionen bekommen ein Eventobjekt `e` , das analog zum Event in JS
funktioniert und Informationen zum Event enthält

Es gibt verschiedene Möglichkeiten, Eventhandler zu platzieren:
```js
// separat -> für längere Handler, oder mehrfach verwendete (Demo 1)
const clickHandler = () => { alert('submitted') }
return (
<button onClick={clickHandler}>Click Me</button>
)
// inline -> für kurze Handler
return ( <button onClick={() => alert("submitted")}>Click Me</button> )
```
Stolperfalle: Funktionen, die an Eventhandler Attribute übergeben werden, dürfen nicht
aufgerufen werden. Der Eventhandler ruft die Funktion auf. Beispiel, wie nicht:
```js
// Falsch
return ( <button onClick={clickHandler()}>Click Me</button> )
```

==== Eventhandlers als Props übergeben
Häufig, wie in der Demo, übergeben wir Eventhandler als Props an Komponenten, um State in
höhergelegenen Komponenten zu aktualisieren.
```js
<SearchInput
value={searchText}
onChange={(e) => setSearchText(e.target.value)}
/>
```
Üblicherweise werden diese Props analog der nativen Eventhandler-Props mit
onThingThatHappens benannt, wie onUpdateSearchText oder onCloseDialog

=== Expressions
Was sind Expressions? Das was als Wert eingegeben werden kann.
```js
9 // 9
"under the bridge" // "under the bridge"
(5 + 6) * 10 // 110
height * 10 // 1800
`you are ${height} cm tall` //'you are 180 cm tall'
"Red" + " " + "Roses" // 'Red Roses'
isPacked && "Du hast das gepackt" // false
isPacked ? "Du hast das gepackt" : "Das fehlt noch" // 'Das fehlt noch'
people.length // 3
x => x * x // ist expression
const height = 180 // keine Expression, sondern ein Statement (Deklaration)
const isPacked = false // keine Expression, sondern ein Statement
const people = ['tom', 'betty', 'van gogh'] // keine Expression
height = 180 // das ist aber eine Expression!!
```

React rendering Fehler:
```js
<p>{obj}</p> {/* Error "Objects are not valid as a React child" */}
<p>{fn}</p> {/* Error "Functions are not valid as a React child" */}
```

=== Arrays
immer keys dazuschreiben `key={..}`!
- Sobald die Liste umsortiert wird oder anderweitig dynamisch ist, braucht es einen Key, sonst
kann es Bugs geben
```js
// Liste filtern mit .filter
const people = [
	{name: 'Creola Katherine Johnson', profession:'mathematician',}
	{name: 'Percy Lavon Julian', profession:'chemist',}
];
const chemists = people.filter(person => person.profession === 'chemist');

// .map
<ul>{people.map(person => <li key={person}>{person}</li>)}</ul>

function MyCars() {
	const cars = [
	{id: 1001, brand: 'Ford'},
	{id: 1002, brand: 'BMW'},
	{id: 1003, brand: 'Audi'}
	];
	return (
	{cars.map((car) => <li key={car.id}>I am a { car.brand }</li>)}
	);
}
```

=== Operators
`? :` Ternary Operator (MDN) - Expression-Variante von if & else
```js
return <li className="item"> {name} {isInStock ? '✔' : 'x'} </li>;
isInStock ? name + '✔' : name
```

`&&`Logischer AND Operator (MDM) - Expression-Variante von if
- Wenn die Bedingung falsch ( false ) ist, sieht React das als kein Inhalt an, wie auch null
- && gibt ersten falschen Wert zurück oder letzter Wert wenn alle true. Bei React/JSX wir false einfach nicht gerenderet.
```js
return <li className="item">{name} {isInStock && ✔}</li>;
isInStock &&
//reads as
//if isInStock is true, then (&&) render the checkmark, otherwise, render nothing
oder undefined
```

```tsx
result = 0 && 2; // result is assigned 0 -> Falsy.
// Aber react rendert ein null, andere falsy werte nicht
result = "text" && ""; // result is assigned "" -> falsy.
// (empty string -> falsy)
result = "piep" && 4; // result is assigned 4 -> truthy
```
Ein false Wert in JSX wird einfach ignoriert! Genauso wie true, null.
Deshalb kann man mit && wenn etwas wahr ist, einen Wert ausgeben.
```tsx
function Paragraph({text}) {
  return <p>{false}{true}{null} {text} {isPacked && "gepackt"}</p>;
}
```

Beispiel:
```js
// Do
{item.isInStock && <ListItem item={item}>}
// Don't
if (isInStock) {
return null;
}
return <li className="item">{name}</li>;
```


= React

=== React ist
...eine von Facebook entwickelte Open-Source-JavaScript-Bibliothek zur Erstellung von Benutzeroberflächen für Webanwendungen \
... besonders für sogenannte Single-Page-Applications (SPA) gut
geeignet, da Interaktion ermöglicht wird, ohne dass ein Neuladen der
Seite nötig ist (anders als bei klassischen Webanwendungen).


=== React Komponente
Ganze Komponente ausblenden : in Parent und nicht in child selbst

```tsx
<ProductCategoryRow title="Spinach" />
```

```tsx
// Demo 1
function ProductCategoryRow({title}) {
  return (
    <section className="category">
      {title}
    </section>
  );
}
```

Als function oder als arrow function möglich
```js
// function definition
function Article({ title, content }) {
return (
<article> <h3>{title}</h3> <p>{content}</p> </article>
);
}
// const + Arrow Function
const Article = ({ title, content }) => {
return (
<article> <h3>{title}</h3> <p>{content}</p> </article>
);
};
```

==== In Komponenten steuern, was wann wie wo dargestellt werden soll
/ Expressions: Wie man Werte im JSX ausgeben kann u.v.m.
/ List Rendering: Eine Anzahl gleicher Komponenten darstellen, aber mit unterschiedlichen
Inhalten
/ Conditional Rendering: Das Layout anpassen


=== Props
sind Eingabewerte für Komponenten (Tatsächlich ist das Props Objekt der einzige akzeptierte Parameter)
==== Props (Properties) Regeln
- als Attribute übergeben und in Komponentenfunktion als Parameter auslesen
- Props können immer nur von Parent zum Child übergeben werden
- immutable
#image("/WE2/assets/image-3.png")
```js
// props als destructured object
const Article = ({ title, content }) => (..);
// benenntes props-Objekt
const Article = (props) => ( .. props.title );
```


==== Props Beispiel
```tsx
// Properties Übergabe an Komponente in Parent
function Newspaper() {
		return (
		<div id="page-1">
		<h2>Newspaper Page 1</h2>
		<Article
			title="Article 1"
			content="..."
		/>
		<Article
		title="Article 2"
		content="..."
		/>
		</div>
	);
};
```
```tsx
// Child Komponente (Demo 5), Props als destrukturiertes Objekt annehmen
function Article({ title, content }) {
	return (
		<article>
			<h3>{title}</h3>
			<p>{content}</p>
		</article>
	);
}
```
```tsx
// Child Komponente (Demo 5), Props als benenntes Props Objekt annehmen
function Article(props) {
	return (
		<article>
			<h3>{props.title}</h3>
			<p>{props.content}</p>
		</article>
	);
}
```


==== Datentypen von Props
Es können nicht nur Strings, sondern alle JS Datentypen als Props übergeben werden, auch
andere Komponenten, JSX-Fragmente, Objekte, Listen, oder Funktionen.
```tsx
function Avatar({ person, size }) {
return (
	<img
	className="avatar"
	src={person.img_url}
	alt={person.name}
	width={size}
	height={size}
	/>
);
}
```


=== Komponente schreiben
```tsx
// function definition
function Article({ title, content }) {
	return (
		<article> <h3>{title}</h3> <p>{content}</p> </article>
	);
}
// const + Arrow Function
const Article = ({ title, content }) => {
	return (
		<article> <h3>{title}</h3> <p>{content}</p> </article>
	);
};
```

==== Verbindung HTML `<->` React
```tsx
<!-- Im HTML -->
<div id="root">
</div>

// Im JSX (Demo 2)
function App() {
return (
	<p>Hi there!</p>
);
}
const rootElement = document.getElementById("root");
const root = ReactDOM.createRoot(rootElement);
root.render(<App />);
```

==== Component Thinking
React als Frontend-Framework teilt das Interface in Komponenten auf, die dann als Bauklötze dienen.
Beispiele: Buttons, Inputfelder, Menüs oder ganze Seiten.
Dies ermöglicht ein intuitives Verständnis für die Programmierung, und hohe
Wiederverwendbarkeit für manche Komponenten. (Bsp. Menüs oder Buttons)


==== React Fragment
```js
// Ausgeschrieben (Demo 4)
const Article = () => {
return (
  <React.Fragment>
    <h3>Titel</h3>
    <p>Ich bin ein Absatz</p>
    <p>Ich bin auch ein Absatz.</p>
  </React.Fragment>
  );
};
// Die regulär verwendete Kurzform
const Article = () => {
return (
<>
  <h3>Titel</h3>
  <p>Ich bin ein Absatz</p>
  <p>Ich bin auch ein Absatz.</p>
</>
);
};
```
- Es ist immer eine Designentscheidung, ob man ein Parent-Element verwendet oder ein
Fragment
- Das Fragment wird weggerendert, und hat auf die CSS Hierarchie damit keinen Einfluss


=== JSX
JSX ist die Syntax, die wir für React Komponenten verwenden. Dabei wird
JS und HTML miteinander verflochten

- JSX (JavaScript XML) und ist eine JavaScript Syntax Extension (Darum auch eine .jsx Datei statt .js)
- JSX erlaubt die Verwendung von HTML Notation in JS (und die Verwendung von JS in HTML)
- JSX ist an sich separat von React, heisst React könnte auch ohne JSX verwendet werden, aber das macht Niemand
- intuitiveres Programmieren als mit reinem JS (Vanilla JS)
- JSX übernimmt die Übersetzung von JSX-Code in JavaScript.

#image("/WE2/assets/image-2.png");

```js
<section className="category">
{title}
</section>
```


==== Vanilla JS vs JSX

```html
<!-- HTML + Vanilla JS -->
<button id="like-button">
<span id="counter">0</span>
</button>
<script>
  let count = 0;
  const button =
    document.querySelector("#like-button");
  button.addEventListener("click", () => {
    count += 1;
    const counter =
      document.querySelector("#counter");
    counter.textContent = count;
  });
</script>
```
```tsx
// React .jsx (Demo 3)
const LikeButton = () => {
  const [value, setValue] = React.useState(0);
  return (
    <button
      className="like-button"
      onClick={
        () => setValue(value + 1)
      }>
      {value}
    </button>
  );
};
```

=== Vanilla JS

===== Destructuring
```js
// example object
const person = { firstName: "John", lastName: "Doe", age: 50 };
// destructuring the object
const {lastName, firstName} = person;
console.log(firstName) // Output: John

// destructuring an array
const Point = [20,300]
const [x, y] = Point
console.log(x) // Output: 20
console.log(y) // Output: 300
```


=== Function Varianten
===== Function Declaration (MDN)

- Wird mit dem Schlüsselwort function definiert
- Kann vor ihrer Definition verwendet werden (Wird gehoistet)

```js
function greet() {
return "Hello";
}
greet(); // "Hello"
```

===== Function Expression
```js
// anonymous function expression
const greet = function () {
return "Hello";
};
greet(); // "Hello"
         //
// named function expression
const greet = function greetPerson() {...};

// named function expression in a map
people.map(function renderPerson(person) {
return <li>{person}</li>;
})
```

===== Arrow Function (Lambda) (MDN)
Ist eine kompaktere Form einer Function Expression
Man kann die geschweiften Klammern und return weglassen für den Function Body,
wenn der Rückgabewert nur eine Expression ist. (darf man bei der Function
Expression nicht)
```js

// Keine Parameter
const greet = () => "Hello";
greet(); // "Hello"
// 1 Parameter → Klammern optional
const square = x => x * x;
// Mehrere Parameter
const add = (a, b) => a + b;
const unnecessarilyLongSquare = (x) => {
const square = x * x;
return square;
};
const nums = [1, 2, 3];
const doubled = nums.map(n => n * 2);
// [2, 4, 6]
const evens = nums.filter(n => n % 2 === 0);
// [2]
```
















#include "/WE2/_firebase.typ"


#colbreak()
#include "/WE2/_react.typ"

#include "/WE2/_expressjs.typ"
#include "/WE2/_code-express-testat.typ"
#include "/WE2/_accessiblity-testing.typ"
#include "/WE2/_security.typ"
#include "/WE2/_pwa.typ"
