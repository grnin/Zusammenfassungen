#import "../template--additional-formatting-templates.typ": *

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


// #import "@preview/cheq:0.3.1": checklist
// #show: checklist

#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]

= PWA (für progressive enhancement)
Progressive web apps use modern web APIs along with traditional progressive enhancement strategy to create _cross-platform web applications_. These apps work everywhere and provide several features that give them the same user experience advantages as _native apps_.

== Native App
/ Vorteile: Native UX, Performance, Hardware Zugriff, iOS: PWA haben zusätzliche Einschränkungen.
/ Nachteile: Nicht jeder möchte eine App installieren, App ersetzt keine schlechte Website

== PWA Vorteile / Eigenschaften
// PWAs should be discoverable, installable, linkable, network independent, progressive, re-engageable, responsive, and safe.

/ Safe:
    Die neuen Features wie Push-API sind nur über HTTPS möglich.
/ Responsive:
    Das UI soll für alle Grössen passen. _Media Queries_ Desktop, Tablet, Smartphone, (Brillen, Uhren)
/ Progressive:
    Die neuen API’s nutzen um die bestmögliche UX zu erreichen,… … ohne die älteren Browser zu ignorieren
/ Linkable:
    Teilen von Inhalten ohne das der Sharing-Partner eine App installieren muss
/ Discoverable:
    Die Webseite soll über Suchmaschinen auffindbar sein ( SEO )
/ Installable:
    Die Web Applikation mit Icon auf den Startbildschirm speichern. _Web App Manifest_
/ Network independent:
    Die App soll auch mit schlechter, langsamer oder sogar gar keiner Verbindung funktionieren.\
    _Einfach:_ Nutzer über Status informieren (eigene Seite für fehlendes Internet). \ _Schwieriger:_ Website funktioniert komplett Offline: Daten im Browser speichern (LocalStorage, IndexedDB) und Synchronisation Workflow.
/ Re-engageable:
    Es soll möglich sein das die Verbindung zum Benutzer der Seite wieder aufgenommen werden, obwohl der Benutzer die Seite nicht geöffnet hat. _Service Workers, Push-API_.\
    Permissions sind nötig, nur eine Chance.\
    _Flussdiagramm Elemente_: User (add item to list) > React App > Firestore > Cloud Function (fcmSend) > Firebase Cloud Messaging > Service Worker > OS > (Push Benachrichtigung an) User
// #image("/WE2/assets/pwa-1.png") // Seite 688

== PWA Infos und Begriffe
/ Service Worker:
    Proxy (wie Middleware) zwischen User und Website, läuft auf Browser von User und hat Seite im Cache. Führt fetch aus zur aktuellen Website, wenn der User online ist.
//   #image("/WE2/assets/pwa-2.png")
/ Web App Manifest: definiert die Meta-Informationen der PWA. App-Name & Kurzname, Icons, Anzeige-Modus (z. B. fullscreen, standalone). ```html <link rel="manifest" href="/manifest.webmanifest">```
/ Installation: _JS-API_: Android/Edge/Chrome, _komplex, Anleitung nötig_: iOS/Safari
/ VitePWA: definiert Manifest mit `vite.config.ts`, cached automatisch alles, konfiguriert Offline-Modus `services/index.ts`, ermöglicht re-engageable `user-notification.tsx` und `fcmSend`

==== Service Worker und Manifest Code
```js
if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('./service-worker.js')
        .then(registration => {console.log('registriert', registration);})
    .catch(error => {console.error('Fehler', error); });
}
```
#v(-0.5em)
// /*
// kein Platz:
// ==== Manifest.json Beispiel
#grid(
    columns: (auto, auto),
    gutter: 0em,
    [
        ```json
        {
          "name": "ShoppingCard",
          "short_name": "ShoppingCard",
          "start_url": "./",
          "display": "standalone",
          "background_color": "#fafafa",
          "theme_color": "#1976d2",
          "lang": "en",
        ```
    ],
    [
        ```json
          "screenshots": [{
              "src": "img/screenshot-wide.png",
        ```
        //   "sizes": "1280x720",
        //   "type": "image/png",
        //   "form_factor": "wide"
        ```json
                /*...*/
            }, /*...*/ ],
        ```
        ```json
            "icons": [
            {
                "src": "icons/icon-192x192.png",
                "sizes": "192x192",
                "type": "image/png"
            },
            /*...*/
        ]}
        ```
    ],
)
// */
