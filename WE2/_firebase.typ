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

= Firebase

/ Firebase hat drei Datenbankprodukte: Realtime Database und Cloud Firestore / Enterprise
/ NoSQL: document-oriented database
    • Datenbank besteht aus mehreren Collections mit Documents
    • Document ist ein JSON-Objekt
    • Document kann wiederum Collections beinhalten, etc.


== Daten erstellen und schreiben
Auf Collections und Dokumente wird per Referenz zugegriffen:
```js
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

const collectionRef = collection(db, "todos");
const documentRef = doc(collectionRef, "9bnh…");

// Über die collectionRef können Dokumente erstellt werden:
addDoc(collectionRef, ({ text: "Learn Firebase" }));

// Über die documentRef können Dokument bearbeitet werden:
updateDoc(documentRef, { text: "Learn Firestore" })
```

== Daten abfragen
Collection- und Dokument-Referenzen müssen nicht zwingend existieren
Abfragen sind immer asynchron und können auch fehlschlagen:
```js
try {
  const document = await getDoc(doc(collectionRef, "9bnh…"))
  if (!document.exists) {
    console.log("No such document!");
  } else {
    console.log("Document data:", document.data());
  }
}
catch (error) {
  console.log("Error getting document", error);
}
```

Collections erlauben SQL-ähnliche Queries mit Filter und Sortierung
```js
const q = query(collectionRef, where("checked", "==", true));
const querySnapshot = await getDocs(q);
querySnapshot.forEach((doc) => {
  console.log(doc.id, " => ", doc.data());
});
```
Bei Abfragen erhalten wir die _id_ und _data_ = den Dokumentinhalt als Snapshot.


== Realtime Updates
Clients werden über Updates der Collections benachrichtigt:
```js
// change in document
onSnapshot(documentRef, (doc) => {
  const source = doc.metadata.hasPendingWrites ? "Local" : "Server";
  console.log(source, " data: ", doc.data());
});
// change in query
onSnapshot(q, (querySnapshot) => {
  const todos = [];
  querySnapshot.forEach((doc) => {
    todos.push(doc.data().title);
  });
  console.log("Current finished todos: ", todos.join(", "));
});
```

== Indexes
Firebase erstellt automatische Indizes für einzelne Datenfelder
- Sortierung: Ascending und Descending
- <, <=, ==, >=, und > Abfragen
Erfolgt eine Abfrage über mehrere Felder, *muss* ein Index erstellt werden:
```js
query(collectionRef, where("checked", "==", true), orderBy("date", "desc"), limit(3));
```

== NoSQL
/ One-To-Many:
    Wenn Collection immer über Parent abgefragt wird, dann diese in Collection einbetten, ansonsten eigene Collection, oder wenn klein, Subcollection erstellen.
/ Many-To-Many:
    Wie in relationaler Datenbank mit Assoziationstabelle lösen oder Daten kopieren und einbetten.

== CRUD
CRUD ist Standardmässig deaktiviert:
• Zugriff erlauben:
// • https://firebase.google.com/docs/firestore/security/get-started
```js
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
service cloud.firestore {
  match /databases/{database}/documents {
    match /todos/{document=**} {
      allow read, update, delete: if request.auth.uid == resource.data.userId;
      allow create: if request.auth.uid != null;
    }
  }
}
```

== Security Beispiel
```js
function isConnectedCoach(profileUid, toCheckUid) {
  return isCoach() && get(/databases/$(database)/documents/profiles/$(profileUid)).data.tokens[toCheckUid] == true;
}
function isAuth(){
  return request.auth != null;
}
function isUser() {
  return isAuth() && "user" in request.auth.token && request.auth.token.user == true;
}
function isCoach() {
  return isAuth() && "coach" in request.auth.token && request.auth.token.coach == true;
}
function isUserValid() {
  return isAuth() && "user-valid" in request.auth.token && request.auth.token["user-valid"] == true;
}
function isUid(uid){
  return isAuth() && uid == request.auth.uid;
}
match /{document=**} {
  allow read, write: if false;
}
// can be read by itself and has to be a coach
match /coaches/{uid} {
  allow read: if isUid(uid) && isCoach();
}
match /history/{uid}/entries/{entryId} {
  allow read: if isUid(uid) && isUser();
  allow read: if isConnectedCoach(uid, request.auth.uid);
  allow write: if isUid(uid) && isUserValid();
}
```


== Firebase Cloud Functions
onRequest: HTTPS-Request
```js
export const helloWorldRequest = onRequest((req, res) => {
  res.send('Hello, World!');
});
// http://127.0.0.1:5001/my-app/us-central1/helloWorldRequest
```
onCall: HTTPS-Request mit Firebase Informationen z.B. Auth
```js
export const helloWorldCall = onCall((request) => {
  if (request.auth?.token.email_verified) {
    return { valid: true };
  }
  return { valid: false };
});
// http://127.0.0.1:5001/my-app/us-central1/helloWorldCall
```
Triggers: z.B. onCreate / onUpdate / …
```js
export const onCreateUser = auth.user().onCreate(async (user) => {
  if (user.email) {
    const roles = await admin.firestore().collection("roles").doc(user.email).get();
    // DO SOMETHING
  }
});
onDocumentCreated("item/{itemId}", async (event) => {
  const data = event.data.data();
  // DO SOMETHING
});
```

== Testing
- Security Testing: https://firebase.google.com/docs/firestore/security/test-rules-emulator
- Firebase Function Testing: https://firebase.google.com/docs/functions/unit-testing
- E2E Test mit Simulator

== Alternativen
- Supabase \
    - Functions: https://supabase.com/docs/guides/functions
    - AUTH: https://supabase.com/docs/guides/auth
    - DB: https://supabase.com/docs/guides/database PostgreSQL
    - Emulator: https://supabase.com/docs/guides/cli/local-development
    - Kein Static Hosting: https://github.com/orgs/supabase/discussions/991
- AWS
- MongoDB Cloud
- Azure

== Firebase PWA - Demo Fragen
/ Frage 1: Wie kommt der aktuelle User in den Store?
    \ -> Firebase Lib kennt den aktuellen User und kann asynchron abgefragt werden.
    \ -> Szenario: Synchronisation einer asynchronen Datenquelle in den Store
/ Frage 2: Wie werden die Listen vom User geladen?
    \ -> Szenario: Trigger (ändern vom aktuellen User) startet die Synchronisation der Daten
/ Frage 3: Wie wird der Store aktualisiert wenn eine neue Liste dazukommt
    \ -> Szenario: Trigger (Firebase Live Query) führt zu einer Synchronisation
