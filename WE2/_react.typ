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


#import "@preview/cheq:0.3.1": checklist
#show: checklist


= JavaScript

=== JS + Functions + Expressions
/ Function Declaration: Schlüsselwort `function`, gehoistet #hinweis[Verwendung for Definition möglich], ```js function greet() {..}```
/ Function Expression: in JSX und überall wo eine Expression reinpasst nutzbar ()
/ Named Function Expr.: ```js const greet = function greetPerson() {...};```
/ Anonymous Function Expr.: ```js ... = function () {...}; ```
/ Arrow Function (Lambda): kompakte Form einer Function Expression, 1 Parameter: ```js ... = x => x * x; ```, mit Rückgabewert: ```js = () => "Hello";``` // ohne Rückgabewert=side effects und deshalb nicht gut: ```js = () => { .. } ```
/ Callback Function: (relevant in Express Middleware) TODO
/ Was sind Expressions?: Expressions sind Werte oder Kombinationen von Werten, Variablen und Operatoren, die ein Resultat ergeben. Alles was etwas zurück gibt.
/ Expressions: Wie man Werte im JSX ausgeben kann u.v.m.
/ keine Expressions: `const a = [1,2]`, statements wie `if` sind keine Expression // TODO
/ Spread Syntax: `...` kopiert Array und Objekt Inhalte. Nur 1 Level tief.

Arrays im State ändern:
add `[...arr]`, remove `filter` `slice`, replacing `map`, sorting `toReversed` `toSorted`

= React
== React Regeln (Komponente, HTML, JSX)
- [ ] Nur ein Rückgabewert: 1 parent element (Root Element) oder React.Fragment `<></>`
- [ ] Naming der Komponente
    - UpperCamelCase
    - treffende Beschreibung der Komponente
        - Beispiele: LinkButton , InfoTooltip , DraftEditor
- [ ] HTML Attribute in JSX mit camelCase (ausser `aria-*` und `data-*`)
    - #strike[class] -> `className`, #strike[for] in Formularfeldern -> `htmlFor`, #strike[stroke-width] -> `strokeWidth`
- [ ] HTML Elemente geschlossen, z.B. `<img />` ,`<input />`
- [ ] Syntax wie in JS: Wert in `{title}`
- [ ] Keys bei Wiederholungen, z.B. `map()`

==== React Code lesen und Lernziele Inhalt
/ wieso React?: SPA, interaktiv, JSX (intuitiver als JS für HTML)
/ Imperatives UI: beschreiben wie es geändert wird, *Deklaratives UI*: beschreiben wie es Aussehen soll
/ Pure Components: bei gleichen Props und gleichem State immer gleiche Resultate. React geht davon aus, dass Komponenten Pure sind.

// #show terms: set par(justify: false) // verhindere Blocksatz -> sobald das nötig ist, lohnt es sich keine terms-list zu nutzen sondern normalen Text!
/ Inline Style: ```js <div style={{ backgroundColor: "red" }}>Text</div>```

/* ```js
9 // 9
"under the bridge" // "under the bridge"
(5 + 6) * 10 // 110
const height = 180 // keine Expression, sondern ein Statement
height * 10 // 1800
`you are ${height} cm tall` //'you are 180 cm tall'
"Red" + " " + "Roses" // 'Red Roses'
const isPacked = false // keine Expression, sondern ein Statement
isPacked && "Du hast das gepackt" // false
isPacked ? "Du hast das gepackt" : "Das fehlt noch" // 'Das fehlt noch'
const people = ['tom', 'betty', 'van gogh'] // keine Expression
people.length // 3
``` */
/ JSX: ist die Syntax, die wir für React Komponenten verwenden. Dabei wird JS und HTML miteinander verflochten. Syntax für React Komponente. Wird übersetzt in JS, JavaScript XML

==== Rendering
/ Rendering: wenn sich state, props oder context von Komponente ändern.
/ sicheres State Update: weil in Eventhandler und Funktion wartet React bis ausgeführt worden, bevor State Updates verarbeitet werden. ```js setCount(prev => prev + 1); ```
// / useState: Beispiel mit hochzählen, mehrmals nacheinander in einer Funktion `setCount(count+1)` erhöht count erst nach Render und deshalb nur um 1.

React rendering Fehler:
```js
<p>{obj}</p> {/* Error "Objects are not valid as a React child" */}
<p>{fn}</p> {/* Error "Functions are not valid as a React child" */}
```

=== Persistence
Möglichkeiten für Persistence: localStorage, URL Parameter, sessionStorage, Cookies, indexedDB, externe DB/API.
Sensible Daten (z. B. Kreditkarteninfos) nur auf externer DB/API geeignet.
==== localStorage:
Speichert Daten dauerhaft im Browser + ist isoliert nach Seite, aber für mehrere Sessions (Tabs/Fensters) übergreifend verfügbar.
Daten bleiben erhalten nach Page Reload und Browser Neustart (kein Ablaufdatum).
Ist ein einfacher key/value Speicher mit Strings (Tipp: JSON.stringify() für Objekte).
5-10 MB Platz.
_Anwendung_: Warenkorb oder Einstellungen.
```js theme = localStorage.getItem("theme")```,  ```js localStorage.removeItem("theme")```, ```js localStorage.setItem("theme", "dark")```, ```js localStorage.clear();```
```js
// localStorage React useState:
const [theme, setTheme] = useState(
localStorage.getItem("theme") || "light"
);
// Beim Ändern speichern:
toggleTheme(() => {
    setTheme(!theme);
    localStorage.setItem("theme", !theme);
});
```
==== sessionStorage:
Daten existieren nur während der Browser Session #hinweis[Tab oder Browser geschlossen -> Daten gelöscht, Page Reload -> Daten noch da].
Isoliert nach einer Seite und eines Tabs/Fenster.
API gleich wie bei localStorage (`getItem, removeItem, setItem, clear`)

==== Cookies (siehe Security)
kleine Datenstücke, die es ermöglichen, Daten zu speichern und zwischen Server und Client
mitzugeben. \
// Cookies werden bei jedem HTTP Request an den Server mitgeschickt
// Datenschutz und Security sind wichtige Themen
// Wurden früher als Universal-Datenspeicher verwendet (weil es nichts anderes gab), heute nicht mehr dafür empfohlen
nur kleine Datenmenge, können Ablaufdatum haben, können serverseitig gelesen werden. _Anwendung_: Login Sessions, Tracking/Analytics
==== IndexedDB
In jedem Browser eingebaute NoSQL DB. Für grössere und strukturierte Datenmengen geeignet.\
Speichert Objekte, komplexere API, sehr grosse Datenmengen möglich (50-250MB), theoretisch unbegrenzte Lebenszeit. _Anwendung_: Offline Apps, PWA, grosse Datensätze im Browser

==== Externe Datenbank / API
Daten können auch ausserhalb des Browsers gespeichert werden, zbsp. in "Cloud" Datenbank
(DBaaS) oder Backend APIs.
_Vorteile_: Daten für viele User speicherbar, Mehr Logik und Datenverarbeitung möglich, Synchronisation zwischen Geräten, Kommunikation zwischen Nutzern

==== URL

/*
=== Async Promise
// code MovieSearch für Prüfungsvorbereitung enthält Promise.resolve(), aber wir müssen es nur lesen können.
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/resolve
```js
function mockSearch(query: string): Promise<string[]> {
    return new Promise((resolve) => {
        setTimeout(() => {
            if (query.trim() === '') {
                resolve(MOVIES);
                return;
            }
            const filtered = MOVIES.filter((item) => item.toLowerCase().includes(query.toLowerCase()),
            );
            resolve(filtered);
        }, 300);
    });
}
```
// */


==== JS Array map und filter + list und conditional rendering
/ List Rendering: Eine Anzahl gleicher Komponenten darstellen, aber mit unterschiedlichen
Inhalten `.map()`
/ Conditional Rendering: Das Layout anpassen `.filter()`
```js
arr2.map(x => 2*x);
arr2.filter(x => x == 'a');
const arr = [ 'a', 'b', 'c' ];
arr.push("d"); //['a','b','c','d']
arr.forEach((e, i) => console.log(i +":"+e));
arr.sort((a,b)=>a-b).map(e=>`<li>e</li>`).join('');
// list rendering:
{list.map((item) => (
    <PacklistItem key={item} item={item} />
))}
// conditional rendering:
{isInStock ? ' ja' : ' nä'} {isInStock && 'ja'}
```

== Komponenten, JSX, Props
==== Props (Properties)
Props sind Eingabewerte für Komponenten (Tatsächlich ist das Props Objekt der einzige akzeptierte Parameter)
- als Attribute übergeben und in Komponentenfunktion als Parameter auslesen
- Props können immer nur von Parent zum Child übergeben werden
- immutable
- Es können nicht nur Strings, sondern alle JS Datentypen als Props übergeben werden, auch andere Komponenten, JSX-Fragmente, Objekte, Listen, oder Funktionen.
== State/Zustand (useState), Eventhandler

// // Code zu unwichtig / auswendig
// ```js
// const [count, setCount] = useState(0);
// ```
//
=== Eventhandler
Wir brauchen Funktionen, die Interaktionen im UI mit dem State verbinden -> Eventhandler.
`<button onClick={() => setCounter(counter+1)}>Click Me</button>`
Native HTML Elemente haben in React spezielle Attribute/Props, die Eventhandler aufnehmen.
Einige der häufig verwendeten:
onClick für Buttons
onChange für Inputfelder
onFocus/onBlur
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


=== useState


#grid(
    // columns: (auto, auto),
    columns: (42%, auto),
    gutter: 0em,
    [
        ```tsx
        function ElternComp() {
          const [name, setName] =
        useState("Max");
          return (
            <KindComp name={name}
            onUpdate={setName}
            />
          );
        }
        ```
    ],
    [
        ```tsx
        function KindComp(props) {
          const { name, onUpdate } = props;
          return (<div>
            <h3>current Name: {name}</h3>
            <input value={name}
            onChange={(e) => onUpdate(e.target.value) }
            />
        </div>);
        }
        ```
    ],
)

==== weitere Hooks
*useRef*: um DOM-Nodes zu tracken und damit zum Beispiel _Fokus-Management_ zu betreiben. Änderung von Wert triggered nicht rerender.
/*  unwichtig TODO löschen wenn zuwenig Platz
```js
const UseRefDemo = () => {
    const inputRef = useRef<HTMLInputElement>(null);
    const focusInput = () => {
    if (inputRef.current) { inputRef.current.focus() }
};
return <>
        <input ref={inputRef} type="text" placeholder="Click the button to focus me" />
        <button onClick={focusInput}>Focus Input</button>
    </>
};
```
// */

==== useReducer
useReducer z.B. für Tennismatch-Scoring, komplexe Zustandslogik.
// Demo vl9
// import { useReducer } from 'react';
```tsx
type ReducerActionTypes = 'increment' | 'decrement';
const reducer = (
  state: { count: number }, // state ist Zahl von counter
  action: { type: ReducerActionTypes }, // + oder -
) => {
  switch (action.type) {
    case 'increment':
      return { count: state.count + 1 };
    case 'decrement':
      return { count: state.count - 1 };
    default:
      throw new Error('Unknown action type');
  }
};
```
```js
export const Counter = () => {
  // use reducer with useReducer hook
  const [state, dispatch] = useReducer(reducer, { count: 0 });
  return ( <div>
      <h3>useReducer</h3>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: 'decrement' })}>[ - ]</button>
    </div>);
};
```
// ```js
// export const StaticCounter = () => {
//   const actions: Record<'type', ReducerActionTypes>[] = [
//     { type: 'increment' }, { type: 'increment' }, { type: 'increment' }, { type: 'decrement' },
//   ];
//   // static use of the reducer
//   const finalState = actions.reduce(reducer, { count: 0 });
//   return <p>static reducer result: {finalState.count}</p>;
// };
// ```


== Controlled Forms

*Flow of a Controlled Component*
// TODO
#image("/assets/image-1.png", height: 1.7cm)
// #image("/WE2/assets/controlled-component.svg", height: 2cm)
```tsx
function Form() {
    const [formData, setFormData] = useState({
        firstName: "",
        lastName: "",
        email: "",
    });
// generalized changehandler
const handleChange = (e: React.SubmitEvent<HTMLFormElement>): void => {
    const { name, value } = e.target;
    setFormData((prevState) => ({ ...prevState, [name]: value }));
};
// oder mit typed eventhandler statt typed event ^:
// const handleChange: React.SubmitEventHandler<HTMLFormElement> = (e) => {
// ...
<label htmlFor="firstName">First Name:</label>
<input type="text" name="firstName" id="firstName"
    value={formData.firstName} onChange={handleChange}
/>
```

== TypeScript
Typisierung von Objekten, Props, Funktionen.
/ typeof: für Type narrowing ```js (typeof val === "string") ``` (und Typ Inferenz von Typescript), _mögliche Typen_: `string`, `number`, `bigint`, `boolean`, `symbol`, `undefined`, `object`, `function`
/ Array: ```js Array.isArray(data) ```,
/ Discriminated Union: ```js switch (shape.kind) { case "circle": ... } ```
/ weitere Typprüfungen: ```js instanceof(HttpError) ```, ```js if (var == null)```

// mit bitzli von finns zusammenfassung und angepasst :)
```ts
type Status = "idle" | "loading" | "success" | "error";
const [status, setStatus] = useState<Status>("idle");
// Type Alias als Component Name + Props
type ButtonProps = { label: string; onClick: () => void; };
// Using the Type Alias to type the props
export function Button({ label, onClick }: ButtonProps) {
return <button onClick={onClick}>{label}</button>;
```
*? (Optionales Property)* ist implizites “… | undefined”
```js
// Optional parameter (implicitly `string | undefined`)
function greet(name?: string) {
return `Hello, ${name || 'stranger'}`; }
```
Typescript prüft die *Struktur*, nicht die Benennung
```ts
type Ball = { diameter: number; }
type Sphere = { diameter: number; }
let ball: Ball = { diameter: 10 };
let sphere: Sphere = { diameter: 20 };
sphere = ball; ball = sphere; // korrekt
```

*Any* deaktiviert Typ-Checking
// TODO:  wegkürzen, weiss ich schon auswendig:
// ```ts
// const user: any = { name: "John", age: 30 };
// user.roles.push("admin");
// // Runtime error! But TS won't complain
// ```

*Unknown*
Kann alles sein und muss überprüft werden (mit typeof oder parse, etc).
Type Checking während Runtime nennt man Type Narrowing. // doppelt erwähnt aber egal
```ts
function printValue(value: string | number) {
    if (typeof value === "string") {
        console.log(value.toUpperCase()); // value : string
    } else {
        console.log(value.toFixed(2)); // value : number
}   }
```

*Never* Bedeutet der Wert soll nicht existieren. (z. B. Rückgabetyp bei Exceptions)
*Undefined* Eine Variable wurde deklariert, ihr aber nie ein Wert zugewiesen.
*Null* Expliziter Wert, der sagt, das ist kein Objekt oder Wert

// *Generics*
// function createPair<T>(v1: T, v2: T): [T, T] { return [v1, v2]; }

*Generics* : Platzhalter für Typen
// function createPair<T>(v1: T, v2: T): [T, T] { return [v1, v2]; }
```js
function identity<T>(x: T): T { return x; }
// Generics werden auch von useState und Array verwendet:
const [name, setName] = useState<string | null>('alice');
const names: string[] = []; // Kurzschreibweise
const names: Array<string> = []; // Langschreibweise
```
// ```js
// console.log(createPair('hellow', 'mellow')); // ["hellow", "mellow"]
// console.log(createPair(3, 4)); // [3, 4]
// console.log(createPair('hellow', 4)); // Argument of type 'number'
// // is not assignable to parameter of type 'string'.
// let [a, b] = [6, 8]
// console.log(createPair<number>(a, b))
// // in den <> kann man den Typ definieren, den die Funktion haben soll
// ```
//

== React Routing mit ReactRouter
Mit React Router: ```js <Route path="/" element={<Home />} /> ``` Kann: Mehrere Seiten darstellen #hinweis[es sieht dann aus wie eine "traditionelle" Webseite, inklusive änderung der URL, aber ohne Reloads (Client Side Routing)], URL parameter und Query Strings verwenden,
Browser History und Navigation verwenden.
```tsx
<BrowserRouter> <!-- BrowserRouter im Idealfall im main.tsx platzieren -->
    <Routes>
        // Index Routes: renders into <Outlet/> at parent's URL
        <Route index element={<Home />} /> // index equals path="/"
        <Route path="about" element={<About />} />
        // Nested Routes: use <Outlet /> in AuthLayout to render child
        // and Layout Routes: does not add segments to URL
        <Route element={<AuthLayout />} >
            <Route path="login" element={<Login />} />
            <Route path="register" element={<Register />} />
        </Route>
        // Route Prefixes: A <Route path> without element prop = path prefix to child routes, without parent layout.
        <Route path="concerts" >
            <Route index element={<ConcertsHome />} />
            // Dynamische Routes / Route Params: becomes dynamic segment
            <Route path=":city" element={<City />} /> // {city} = useParams();
            <Route path="trending" element={<Trending />} />
        </Route>
        // catch all/splat/star: ends with *
        <Route path="files/*" element={<File />} />
        // let params = useParams(); // params["*"] =remaining URL
        // let filePath = params["*"];
    </Routes>
</BrowserRouter>
```

== useEffect & API Calls
/ "direkt sofort nach dem ersten Rendern": useEffect hat noch nicht geladen, beachte auch timeouts im code

== Context API
*Einige Interessante Anwendungsfälle für useContext*: Automatische Heading-Einstufung, Informationen zum angemeldeten User, Globaler State für Clientside-only Anwendungen, Localization, App Settings, Light/Dark Theme (auch in reinem CSS lösbar


==== useContext zur Vermeidung von Prop-drilling?
Nicht immer: in typischen React Anwendungen gerne ein
Duzend Props pro Komponente
zusammenkommen, und dass es üblich ist,
Daten über einige Stufen zu übergeben. \ ein expliziter Datenfluss ist
an sich nichts schlechtes.

*Lösungsansätze für Prop-Drilling*
1. State näher an Nutzung verschieben
2. Komponentenstruktur verbessern (Refactoring) (siehe auch nächste Slide)
3. Intentional weiterhin Props verwenden
4. Context API verwenden
5. WebStorage (Session/Local) + Custom Hooks verwenden (mit/ohne Context)
6. Zusätzliche State Management Libraries (Zustand, Redux, ...)

#grid(
    columns: (auto, auto),
    gutter: 0em,
    [
        ```js
        // vorher
        const Layout = ({ posts }) => {
        return (
        <div className="layout">
        <Header />
        <Posts posts={posts} />
        </div>
        );
        }

        // --- Verwendung
        <Layout posts={posts} />
        ```

    ],
    [
        ```js
        // nachher
        const Layout = ({ children }) => {
        return (
        <div className="layout">
        <Header />
        {children}
        </div>
        );
        }
        // --- Verwendung
        <Layout>
        <Posts posts={posts} />
        </Layout>
        ```],
)

==== Context API
```js
// Erstellen des Context
const UserContext = createContext(initialValue)
// Bereitstellen des Kontexts im Komponenten-Tree
// Der Value kann zum Beispiel von einem Prop oder State kommen
<UserContext.Provider value={user}>
...
</UserContext.Provider>
// Verwenden des Kontexts
const context = useContext(UserContext);
```
==== ThemeProvider Context
// TODO
#grid(
    columns: (auto, auto),
    gutter: 0em,
    [
        #image("/assets/image-1.png", height: 2cm)
    ],
    [

        #image("/assets/image-2.png", height: 2cm)
    ],
)

```js
export const ContextDemo = () => {
return (
<ThemeProvider>
<h1>useContext Demo </h1>
<ThemeTitle />
<ThemeButton />
</ThemeProvider>
);
```


/ Warum die Unterteilung in zwei Files?:
    Fast refresh only works when a file only
    exports components. Use a new file to share
    constants or functions between components.
    eslint(react-refresh/only-export-components)
    Der Grund ist, dass das Hot Module Reloading von Vite kaputtgeht, wenn man man in
    Komponentenfiles (.tsx) Funktionen exportiert.

Setup:
```js
};
const ThemeTitle = () => {
    // Es müssen nicht alle Elemente
    // des Context verwendet werden:
    const { theme } = useTheme();
    return <h2>Current theme in title: {theme}</h2>;
};
const ThemeButton = () => {
    const { theme, toggleTheme } = useTheme();
    return (
    <button onClick={toggleTheme}>
    Current theme: {theme} (click to toggle)
    </button>
    );
};
```

Implementation Context
```js
// theme-context.ts
export const ThemeContext = createContext
<ThemeContextValue | undefined>(
undefined,
);
export const useTheme = () => {
    const context = useContext(ThemeContext);
    if (!context) {
    throw new Error('useTheme must be used
    within a ThemeProvider');
    }
    return context;
};
// theme-provider.tsx
export const ThemeProvider = (
{ children }:
{ children: ReactNode }
) => {
    const [theme, setTheme] = useState<Theme>('light');
    const toggleTheme = () => {
        setTheme((prev) =>
        (prev === 'light' ? 'dark' : 'light')
        );
    };
    return (
    <ThemeContext.Provider
    value={{ theme, toggleTheme }}
    >
    {children}
    </ThemeContext.Provider>
    );
};
```

== CSS
// von finns zusammenfassung
*Trennung von Page- und Komponentenlayouts*:
styles/base.css (resets, typography),
variables.css (tokens, colors),
layout.css (top-level page layout)
\
Cascades vermeiden, stattdessen Composition nutzen
```css
:root { --color-primary: #0070f3; } /* Definition in der variables.css */
/* Nutzung in einer anderen Datei: */
.button { background-color: var(--color-primary); /* Hier wird der Wert #0070f3 eingesetzt */}
```

#grid(
    columns: (auto, auto),
    gutter: 0em,
    [
        Composition via classname
        ```css
        .btn { padding: 10px; border-radius: 4px; }
        .btn-primary { background: var(--color-primary); }
        .btn-danger { background: red; }
        /* HTML Composition */
        <button class="btn btn-primary">Speichern</button>
        <button class="btn btn-danger">Löschen</button>
        ```


    ],
    [

        ```css
        .button {
        /* Basis-Styles */
        &.primary {
        /* Styles für Primär-Button */ }
        &.large {
        /* Styles für große Buttons */ } }
        <button class="button primary large">
        ```
    ],
)

/ CSS Nesting: Verschachtelung ist ok, muss aber "flach" gehalten werden (maximal 3 Ebenen tief).
/ Einheiten: Verwende konsequent rem anstelle von px, für Barrierefreiheit (Skalierbarkeit)
/ Gruppierung: Deklarationen innerhalb einer Regel sollten in einer logischen Reihenfolge stehen (z. B.erst Positionierung, dann Box-Modell wie Display/Padding, dann Farben/Text).
/ Shorthands vermeiden: Nutze keine unleserlichen Shorthands wie padding: 1.2rem 0.8rem 1rem;.
/ Margin vermeiden: Versuche, «margin» weitgehend zu vermeiden.
/ Gap & Padding: Nutze stattdessen Flexbox oder Grid in Kombination mit gap für Abstände zwischen Elementen und padding für Abstände innerhalb von Elementen.
