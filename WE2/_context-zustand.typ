#import "../template--additional-formatting-templates.typ": *

// /* zum testen:
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


// #import "@preview/cheq:0.3.1": checklist
// #show: checklist

#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]



= Context API
```tsx
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
#grid(
    columns: (auto, 55%),
    gutter: 0em,
    [
        ```tsx
        export const ContextDemo = () => {
        return ( <ThemeProvider>
            <h1>useContext Demo </h1>
            <ThemeTitle />
            <ThemeButton />
        </ThemeProvider> );
        ```
    ],
    [
        #v(-6.25em)
        // #align(right, [
        // #image("/WE2/assets/we2-1.png", height: 2cm)
        #image("/WE2/assets/themeprovider.svg")
        // ])
        // #v(-2em)
    ],
)






/ Warum die Unterteilung in zwei Files?:
    Fast refresh only works when a file only
    exports components. Use a new file to share
    constants or functions between components. \
    `eslint(react-refresh/only-export-components)`
    Der Grund ist, dass das Hot Module Reloading von Vite kaputtgeht, wenn man man in
    Komponentenfiles (.tsx) Funktionen exportiert.

Setup:
#v(-0.5em)
// };
```tsx
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
#v(-0.5em)
```tsx
// theme-context.ts
export const ThemeContext =
    createContext<ThemeContextValue | undefined>( undefined );
export const useTheme = () => {
    const context = useContext(ThemeContext);
    if (!context) {
        throw new Error('useTheme must be used within a ThemeProvider');
    }
    return context;
};
// theme-provider.tsx
export const ThemeProvider = ( { children }: { children: ReactNode } ) => {
    const [theme, setTheme] = useState<Theme>('light');
    const toggleTheme = () => {
        setTheme((prev) => (prev === 'light' ? 'dark' : 'light') );
    };
    return ( <ThemeContext.Provider value={{ theme, toggleTheme }} >
                {children}
            </ThemeContext.Provider> );
};
```


= Zustand / State Management
