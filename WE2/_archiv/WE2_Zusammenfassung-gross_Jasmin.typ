#import "/lib.typ": *
#import "/WE2/info.typ": info

// #show: cheatsheet.with(..info)
#set enum(numbering: "1)1)")


Hier ist alles was nicht auf das Cheatsheet passte.

= React
=== React ist
...eine von Facebook entwickelte Open-Source-JavaScript-Bibliothek zur Erstellung von Benutzeroberflächen für Webanwendungen \
... besonders für sogenannte Single-Page-Applications (SPA) gut
geeignet, da Interaktion ermöglicht wird, ohne dass ein Neuladen der
Seite nötig ist (anders als bei klassischen Webanwendungen).


=== React Komponente
Ganze Komponente ausblenden : in Parent und nicht in child selbst

```jsx
<ProductCategoryRow title="Spinach" />
```

```jsx
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
```jsx
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
```jsx
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
```jsx
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
```jsx
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
```jsx
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
```jsx
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

```js
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

Destructuring
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
Function Declaration (MDN)

- Wird mit dem Schlüsselwort function definiert
- Kann vor ihrer Definition verwendet werden (Wird gehoistet)

```js
function greet() {
return "Hello";
}
greet(); // "Hello"
```

Function Expression
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

Arrow Function (Lambda) (MDN)
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
