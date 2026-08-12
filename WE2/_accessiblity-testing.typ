/* zum testen:
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

#import "/WE2/helpers.typ": *

#import "../template--additional-formatting-templates.typ": *

= accessibility
<accessibility>
/ Zielgruppen: Tastaturbenutzer, Screenreader (nicht UI sondern Acc.Tree), Sehschwächen, SEO+KI

/ Automatisiert prüfbar: _fehlende Attribute_ (alt, label, lang), _leere Links / Buttons_ (z.B. nur Icon dann nutze `aria-label="Zur Startseite"`), _Kontrastwerte_ (Farbkontrast), _input mit placeholder_ statt label. #hinweis[z.B. mit Linter, Storybook Addon]
/ manuell prüfen: schlechte UX / Interaktion, unklare Inhalte ("click here") sollten klar verständlich sein, schlechte Screen Reader Experience, Keyboard-Navigation im Kontext (Tabs), Button ist div statt `<button type="button">..`
/ Weitere typische Probleme: _Alt-Text vorhanden_ → aber inhaltlich nutzlos ("image.jpg"), _Label vorhanden_ → aber falsch verknüpft, _Lighthouse Score hoch_ → trotzdem nicht nutzbar, _Drag & Drop_ ohne Alternative
/ Accessibility wird oft falsch gemessen: Tools prüfen, was einfach messbar ist aber Nutzer erleben etwas anderes

=== 3 goldenen Regeln
// kurz so:
// / die 3 goldenen Regeln: Semantik vor Styling (HTML native Elemente), Bedienbarkeit sicherstellen (Tastatur), Verständliche Benennung

/ Semantik vor Styling:
    Verwende native HTML-Elemente wie button, a und label.
    Vermeide Custom Controls, wenn ein passendes Standard-Element existiert.
/ Bedienbarkeit sicherstellen:
    Alle Funktionen müssen mit der Tastatur bedienbar sein.
    Der Fokus muss sichtbar und die Navigationsreihenfolge logisch sein.
/ Verständliche Benennung:
    Interaktive Elemente benötigen klare, verständliche Namen.
    Formularfelder müssen eindeutig beschriftet sein.

=== Fixed Page (korrektes HTML)
```html
<main class="page">  <h1>Fixed Demo</h1>
  <nav class="card"> // semantic nav
    <h2>Navigation</h2> // text for link v
    <a class="icon-link home-icon" href="index.html" aria-label="Zur Startseite"></a>
  </nav>
  <div class="card">
    <h2 id="search-heading">Suche</h2>
    <form class="search-row" role="search" aria-labelledby="search-heading">
      <label for="search" class="visually-hidden">Suchbegriff</label>
      <input type="search"> // has a label ^
      <button class="icon-btn search-icon" type="button" aria-label="Suche starten">
      </button>
  </form> </div>
  <div class="card">
    <h2 id="form-heading">Formular</h2>
    <form class="form" aria-labelledby="form-heading">
      <label for="name">Name</label>
      <input id="name" type="text">
      …
      <button class="submit-btn" onclick="submit()">Absenden</button>
    </form> …
```



= testing
<testing>

1. Vier Test-Ebenen: Static, Unit, Integration, E2E -- jede deckt andere Fehler ab.
2. Testbarkeit = Architekturqualität (kleine, reine Funktionen, Dependency Injection).
3. Static Checks (TS, ESLint, jsx-a11y) sind günstig und schnell -- immer einschalten.
4. AI macht automatische Guardrails wichtiger, nicht überflüssig


/ Warum: Änderungen erzeugen neue Fehler (Regressionen), moderne Webprojekte bestehen aus vielen Teilen, AI generiert schneller neuen Code, manuelles Prüfen skaliert schlecht, automatisierte Checks geben schnelles Feedback.
// Typfehler führen häufig zu Laufzeitfehlern oder falschem Verhalten. TypeScript verhindert, dass inkonsistente Datenstrukturen unbemerkt weiterverwendet werden.
// nicht `eslint-disable` nutzen: entfernt nur die Warnung, nicht das eigentliche Problem. Wenn solche Warnungen routinemässig ignoriert werden, verlieren Quality Checks ihren Wert als Guardrails.
// accessibility linting: Screen Reader und Tastatur-Nutzende sind auf semantisch korrekte Elemente angewiesen. Ein `<button>` bringt Rolle, Fokus und Tastaturbedienung automatisch mit.
/ Gute Tests prüfen Grenzfälle: 0, negativ, sehr gross, leer, null, falscher Typ und unerwartete Eingaben.
/ Test-Smells: Flaky Tests #hinweis[Abhängig von Zeit, Netzwerk, Reihenfolge], Implementation Detail Testing #hinweis[z.B. jeder 2. funktioniert], übermässiges Mocking #hinweis[dann refactor, Architektur prüfen]

==== API Tests, Unit Tests, gute Testbarkeit
/ API Tests: liegen zwischen Unit Tests und E2E Tests. Sie prüfen das Zusammenspiel von Routing, Request-Verarbeitung und Response-Format. #hinweis[nicht produktive DB, Frontend Darstellung, UX]
// / (API Tests): ist Unit- oder Integration Test, z.B. request mit Supertest durchführen und testen mit vitest, damit routes testen
/ (Unit Tests) Arrange-Act-Assert: Was war vorbereitet? Was wurde getan? Was ist herausgekommen?
/ Gut testbar = gute Architektur: kleine Funktionen, Funktionen ohne Nebeneffekte (pure), klare Schnittstellen, lose Kopplung, Dependency Injection (statt direkte Abhängigkeiten), Zustände nicht global

=== Arten von Checks
/ tsconfig.json mit "Compiler Regeln": ```json "compilerOptions": { "strict": true,..}```: strengere Typprüfung (NullChecks, kein implizites `any` oder `this`), ungenutzte Variablen erkennen, `use strict` überall, unknown und null unterscheiden

/ eslint.config.js mit `rules: { "no-unused-vars": "error", "jsx-a11y/alt-text": "warn"..`: Coding Standards, Accessibility-Regeln, Qualitätsregeln für React
/ "Typenkorrektheit": Typescript
/ Static Checks (Qualität): erkennen potenzielle Probleme, prüfen Typen, prüfen Regeln, prüfen Accessibility, helfen Fehler vermeiden. _Erkennen: falschen Typ, unbenutzter Code, fehlendes Label, fehlendes Accessibility-label, falsche HTML Struktur, ungültige Props_. TypeScript #hinweis[Typen und Schnittstellen], ESLint #hinweis[Code-Regeln und problematische Patterns], Accessibility-Linting #hinweis[semantische UI-Probleme]
/ Prettier (Lesbarkeit): formatiert Code automatisch, keine Qualitätsprüfung, keine Typprüfung, keine fachlichen Regeln


=== Testebenen - bei React als Test Trophäe
/ Static Checks: prüft Struktur (TypeScript), soviel wie möglich, #hinweis[siehe oben]
/ Unit Tests: prüft einzelne Funktionen (`calculateFee()`), viele machen, schnell, isoliert, #hinweis[falsche Berechnung, Business Logik]
// unit tests bei Funktionen die klein, pure und unabhängig von UI und Backend sind
/ Integration Tests: prüft Zusammenspiel (API + Daten), (z.B. für Frontend mit Playwright, React Testing Lib, MSV), #hinweis[Unit Tests + falsche API Antwort, Login]
/ E2E Tests: prüft User Flows (Login), mit Playwright/React Testing Lib, langsam, #hinweis[Integr. Tests + fehlendes Label wie Static checks]


==== Test Coverage
/ Statement Coverage: Wurden alle Anweisungen ausgeführt?
/ Branch Coverage: Wurden alle if/else-Zweige getestet? 80% Branch wertvoller als 95% Lines.
/ Function Coverage: Wurden alle Funktionen aufgerufen?
/ Line Coverage: Wurden alle Codezeilen ausgeführt? 70–80%
/ weitere Zahlen: Kritische Pfade = 100% (Auth, Geld, Datenverlust) und UI = 50-60%, E2E für Rest.

==== Mocking, z.B. Test Doubles:
/ Mock: Wie Spy, aber mit Verhaltens-Erwartungen, `vi.fn().mockReturnValue(42)`
/ Spy: Echte Funktion + Aufrufe werden mitprotokolliert, `vi.spyOn(obj, "method")`
/ Dummy: Nur als Platzhalter - wird nie wirklich benutzt, z.B. null als Logger-Argument
/ Stub: Liefert vorgegebene Antworten, `getCurrentHour = () => 19`
/ Fake: Funktionierende, z.B. vereinfachte Implementierung In-Memory DB statt Postgres

==== E2E Test mit Playwright
_`getByRole`_ nutzt semantische Rolle z.B. `h3` ist heading und `type="checkbox"` ist Rolle checkbox. _`getByLabel`_ nutzt zugänglichen Namen. Diese entsprechen der Sicht von Screen Readern und sind weniger abhängig von CSS, IDs und Layoutänderungen.
```js
test("user can log in", async ({ page }) => { // page von playwright
  await page.goto("/");
  // getByLabel nutzt sichtbare Labels und fördert dadurch zugängliche Forms.
  await page.getByLabel("Passwort").fill("secret");
  // getByRole = semantischer und robuster als CSS oder generische Selektoren.
  await page.getByRole("button", { name: "Login" }).click(); // <button>
  await expect(page.getByRole("status")).toHaveText("erfolg"); // role="status"
});
```
// Playwrights `getByRole` und `getByLabel` nutzen ähnliche Informationen wie Assistive Technologies:
// - Rolle
// - Name
// - Label
// Test Selektoren sollen sich an Bedeutung und zugängliche Namen orientieren und nicht an Styling

==== Unit + API Test mit Vitest und request von Supertest
```js
describe('AccountService, calculations, ..', () => {
  let ownerToken: string; // global variable
  beforeEach(async () => { // (gibt auch afterEach)
        // before every test in this "describe group"
        (userService as any).db = new Datastore(); // cleanup
        const ownerResult = await userService.register(ownerUser);
        ownerToken = ownerResult.token; // create token
  };
  // it() ist gleich wie test()
  it('create an account with a valid account number', async () => {
      expect((await accountService.create(crypto.randomUUID())).accountNr)
      .toEqual(1000002);
      expect((await accountService.create(crypto.randomUUID())).accountNr)
      .toEqual(1000003);
  });
  test("calculates ...", () => {
    const getCurrentHour = () => 10; // Arrange
    expect(calc(1000, getCurrentHour)).toBe(10); // Act and Assert
    expect(() => calc(0, false)).toThrow();
}); });  // describe gruppe für UI und um zusammen auszuführen
```

===== Was testen wenn Backend/DB noch nicht existiert
Endpunkte, Methoden, Request-Body, Response-Body, Statuscodes, Fehlerformate
