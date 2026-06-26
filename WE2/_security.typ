#import "../template--additional-formatting-templates.typ": *


= security
<security>

== Security Mindset
- Vertraue niemals User-Input
- Alles vom Client kann manipuliert werden
- Der Server entscheidet
- Security braucht mehrere Schutzschichten
«Security bedeutet: nicht nur bauen — sondern hinterfragen.»

== kurzgefasst
/ XSS: → Wird User-Input zu Code? _Lösung_: Output immer escapen. React escaped automatisch — dangerouslySetInnerHTML vermeiden.
/ IDOR: → Wird jeder Zugriff serverseitig geprüft? _Lösung_: Authentication (wer bist du?) + Authorization (darfst du das?) — beide serverseitig.
/ CSRF: → Wer hat diesen Request wirklich ausgelöst? _Lösung_: CSRF-Token verwenden. Keine State Changes via GET

== XSS
#v(-1em)
==== Angriffs-Szenario
Setze user-input auf: `<script>document.body.insertAdjacentHTML('afterbegin','<p style="color:red">HACKED</p>')</script>`

==== XSS Schutz
1. *Output Escaping*: #strike[```js`${input}```], ```js ${xss(input)}```, ```js {input} ```, #strike[```js {{{input}}// hbs```],```js {{input}}// hbs```, #hinweis[Zeichen als Text rendern]
// React escaped automatisch
2. *Sanitizing* (Zeichen entfernen) *beim Speichern* ```js xss(input) ```
3. *Content Security Policy* (CSP): blockiert Script-Ausführung im Browser + Server sendet Info im Seiten-Header. Z.B. mit "Helmet" `app.use(helmet.contentSecurityPolicy({...}))`. CSP = wohin der Browser (Fetch)-Requests senden darf.
4. *HttpOnlyCookies*: Statt JWT im localStorage / sessionStorage
```js
res.cookie('session', token, {
    httpOnly: true, // nicht via document.cookie lesbar
    secure: true, // nur über HTTPS
    sameSite: 'lax' // CSRF-Schutz
});
```

== CORS
/ SOP: Same-Origin-Policy erlaubt XMLHttpRequest nur zur Origin.
/ CORS: (Cross Origin Resource Sharing) : Browser entscheidet ob Response für JS zugänglich ist, #hinweis[nutze Access-Control-Allow-Origin, steuere SOP]. // mit CORS fetch request zu gewissen domains erlaubt aber inhalt wird nicht gezeigt. standardmässig nur eigene domain erlaubt.
Nicht verwechseln mit CSP: Content Security Policy (CSP) begrenzt, was der Browser laden und ausführen darf → reduziert Schaden bei XSS (aber ersetzt kein Escaping) // z.B. ob inline js ausgeführt werden darf oder .js dateien von welchen domains erlaubt sind https://stackoverflow.com/questions/39488241/what-is-the-difference-between-cors-and-csps
/ Cross-Origin Resource Sharing: Mechanismus um Cross-Site-Requests zu ermöglichen, Der Ziel-Server kann dem Client den Zugriff erlauben, Wird vom Browser Enforced

==== Angriffs-Szenario
1. User nutzt app.example.com mit Daten von api.example.com.
2. Nutzer öffnet aus Versehen evil.com im Browser
3. evil.com Seite versucht request: `fetch("https://api.example.com/user", {credentials: "include"}) // Cookies mitgesendet`

== CSRF Cross-Site Request Forgery
#v(-1em)
==== Angriffs-Szenario
1. Nutzer ist eingeloggt (Session aktiv)
2. Nutzer besucht eine fremde Seite (Attacker)
3. Diese Seite sendet (Form-Submit oder fetch) eine Anfrage an unsere App ``
4. Browser sendet automatisch das Session-Cookie mit
5. Server führt die Aktion aus (denkt: legitimer Nutzer)
#sym.arrow.r Cookie und so gültig, da Nutzer es (unfreiwillig) ausführte

==== CSRF Schutz
*CSRF Token* Server prüft: kommt Request aus meiner App? und *Keine State Changes* via GET #sym.arrow.r besonders unsicher
```js
// Formular (Client)
<form method="POST" action="/change-email">
    <input name="email" />
    <input type="hidden" name="csrfToken" value="{{token}}" />
    <button>Save</button>
</form>
// Server (Express Form-Handling)
app.post('/change-email', (req, res) => {
    if (req.body.csrfToken !== session.csrfToken) {
        return res.status(403).send("Forbidden");
    }
    email = req.body.email;
    res.send("OK");
});
```

=== Cookies
ermöglichen Authentication nicht Autorisation
Wichtige Cookie Optionen
- httpOnly #sym.arrow.r Cookie nicht via JS zugreifbar
- secure #sym.arrow.r nur über https gesendet
- sameSite: Lax (default, gesendet bei same-site + top-level Navigation/GET); None (immer), [strict]
- maxAge / expires: Lebensdauer

== Login und Passwort Management
- UX: Re-Authentication (Passwort bestätigen) und Bestätigungs-Dialog vor irreversiblen Aktionen #hinweis[für Security und gutes Design]
- Login selber bauen fast immer schlechte Idee, nutze existierende Dienste (Auth0, Firebase Auth...) oder Passwortlos (Magic Link, Passkey).
- schlechte UX = Passwort-Reuse, Fehler #sym.arrow.r Frust #sym.arrow.r Workarounds.

==== Sign-up Form Best Practices
// https://web.dev/sign-in-form-best-practices/
/ Nutze den Browser: richtige HTML-Elemente #hinweis[`<form>, <label>, <button>`], "type, required, autocomplete" nutzen
/ Reduziere «Friction»: keine doppelte Eingabe (Email / Passwort), klare Fehlermeldungen, Passwortregeln klar anzeigen
/ Passwort UX richtig machen: Browser Password Manager nutzen, autocomplete="new-password"/"current-password", Show password anbieten
/ Mobile First & Accessibility: Grosse Inputs und Buttons, Jedes Feld mit `<label>`

== IDOR
#v(-1em)
==== Angriffs-Szenario
Der Angreifer loggt sich ein und manipuliert die URL der StockPortfolio Seite von
`www.retireEasy.com/stockportfolio/:attackerUID` zu `www.retireEasy.com/stockportfolio/:victimUID`.  Diese Seite wird angezeigt.

==== IDOR Schutz
```js
app.get('/api/documents/:id', async (req, res) => {
    const doc = await db.getDocument(req.params.id);
    if (!doc || doc.ownerId !== req.session.userId) {
            return res.status(404).json({}); // Enumeration verhindern
    }
    res.json(doc);
});
```
Object-level Authorization-Check: Gehört das Objekt dem aktuellen User?

/*
Middleware Funktion welche sicher stellt, dass Nutzer eingelogged sind (authentisiert und autorisiert)
function requireLogin(req, res, next) {
if (typeof(req.session.user_id) == "number") &&
user.isAuthorized(req.session.user_id, req.url) {
next();
} else {
res.send(404, 'not found'); // eigentlich 401 aber…
}
}
Middleware Route Definition für den geschützten Bereich
app.all("/api/*", requireLogin, function(req, res, next) {
next(); // if the middleware allowed us to get here, just move on
});
*/ */

== OWASP Top 10
/ A01-2025: Broken Access Control (_IDOR_, _CSRF_)
/ A02-2025: Security Misconfiguration
/ A03-2025: Software Supply Chain Failures (Vulnerabel & Outdated Components #sym.arrow.r NPM)
/ A04-2025: Cryptographic Failures (2017: Sensitive Data Exposure)
/ A05-2025: Injection: Cross-Site-Scripting (_XSS_), JS Code Injection, SQL Injection
/ A06-2025: Insecure Design (#sym.arrow.r Meine Impfungen: Nicht gesetzeskonforme und überwindbare Legitimationsprüfung (Brute-Force + _IDOR_ + _CSRF_ + _XSS_))


// #strong[OWASP Top 10:]
// #figure(
//     align(center)[#table(
//         columns: (50%, 50%),
//         align: (auto, auto),
//         table.header([Cross-Site-Scripting], [Replay Attack]),
//         table.hline(),
//         [Remote Code Execution], [Cryptographic Failures],
//         [Insecture Direct Object References],
//         [Identification &
//             Authentication Failure],
//         [Cross-Site Request Forgery], [],
//     )],
//     kind: table,
// )

==== Cross Site Scripting (XSS)
Website besitzt eine XSS-Verwundbarkeit, wenn es möglich ist den Server so zu manipulieren,
dass Schadcode (JavaScript) eines Angreifers an Nutzer ausgeliefert wird
und im Browser dieser Nutzer ausgeführt wird. Gegenmassnahme mit Input
Sanitation.

==== Remote Code Execution
Webserver besitzt eine Code Injection "Vulnerability" wenn ein Angreifer den Server dazu bringen kann vom
Angreifer eingeschleusten Code zum Ausführen zu bringen.

==== Broken Access Control
Beim behandeln von Formular-Submission-Requests (GET und POST) sollte überprüft werden,
dass dies von einem vom Server für den Nutzer «frisch» ausgelieferte
Formulare stammt.

==== Cryptographic Failures
Passwort oder Token wird nicht verschlüsselt übertragen. Unabhängig davon ob
Query-Body/Request-Parameter.

==== Identification & Authentication Failure
Bei Problemen bei der Authentisierung und dem Session Management können externe Angreifer oder
Angreifer mit einem validen Login auf Informationen zugreifen, welche
nicht für sie bestimmt sind

==== Sign-up Form Best Practice
- Use meaningful HTML elements: form, input, label and button
- Label each input with a label
- Use element attributes to access built-in browser features: type,
    name, autocomplete, required.
- Use autocomplete="new-password" and id="new-password" for the
    password input in a sign-up form, and for the new password in a
    reset-password form.
- Provide Show password functionality.
- Don't double-up inputs. Don't force users to enter emails or
    passwords twice.

==== Content Security Policy (CSP)
CSPs ermöglichen die Ausführung von bösartigem Code auf Webseiten zu verhindern. Quellen von Ressourcen
(Skripten, Bilder etc.) können eingeschränkt werden. CSPs werden im HTTP
Header definiert

==== Cross-Origin Resource Sharing (CORS)
CORS Header ermöglichen Ressourcen (wie z.B. Bilder, Skripte oder Daten) von einem anderen
Ursprungsort als der eigenen “Origin” zu laden.
