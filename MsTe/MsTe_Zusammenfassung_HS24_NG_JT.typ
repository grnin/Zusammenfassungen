// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *
#import "@preview/codelst:2.0.2": sourcecode

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "MsTe",
  fach-long: ".NET Technologien",
  semester: "HS24",
  tableofcontents: (enabled: true, depth: 2, columns: 2),
  font-size: 10pt,
)

// Global configuration
#set grid(columns: (1fr, 1fr), gutter: 1em)
#show grid: set par(justify: false, linebreaks: "optimized")
#set figure(supplement: none)

// Set styles for the gRPC example code blocks
#let code-example(body) = {
  // sourcecode uses a table internally, the template styles the first row with emph, disable here
  show emph: set text(fill: black, style: "italic", weight: "regular")
  set text(size: 0.88em)
  sourcecode(lang: "cs", body)
}


= Überblick & Architektur
== Vergleich .NET, .NET Core und .NET Framework
#table(
  columns: (1fr,) * 3,
  table.header([.NET Framework (2002-2019)], [.NET Core (2016-2019)], [.NET (ab 2020)]),
  [
    Für Windows entwickelt & eng mit OS verzahnt, letzte Version 4.8 erhält nur noch Security-Updates
    #hinweis[(kein End-of-Life)]
  ],
  [
    Cross-Platform-Implementation welche neben .NET FW entwickelt wurde, limitierte Anzahl Features
    im Vergleich zu .NET FW, keine Updates mehr
  ],
  [
    Vereint .NET Framework & .NET Core-Features, jedes Jahr eine neue Version #hinweis[(18 Monate Support)],
    jedes zweite Jahr eine LTS-Version #hinweis[(3 Jahre Support)]
  ],
)

== .NET Plattform Grundstruktur
- _Common Language Runtime (CLR):_ Mächtige Laufzeitumgebung für verschiedene Sprachen, ähnlich Java Virtual Machine.
  - *Common Type System (CTS):* Gemeinsames Typensystem für alle .NET-Sprachen.
  - *Common Language Specification (CLS):* Gemeinsame Sprach-Eigenschaften für alle .NET-Sprachen.
- _.NET Base Class Library (BCL):_ Basis-Klassen für alle .NET-Sprachen
  - *ADO.NET / Entity Framework Core:* Klassen für DB-Zugriff
  - *ASP.NET Core:* Web-Programmierung
  - Umfangreiche Klassen für XML, JSON, Zugriff auf Dateisystem
  - *Windows Presentation Foundation (WPF) / Windows Forms:* Klassen für Windows-GUIs

== Common Language Runtime (CLR)
#grid(
  columns: (1.1fr, 1fr),
  [
    _Laufzeitumgebung_ für .NET-Code #hinweis[("managed code")]. Umfasst:
    - JIT-Compiler #hinweis[(Intermediate Language Code zu Maschinencode)]
    - Class Loader #hinweis[(für das Laden von Klassen-Code zur Laufzeit)]
    - Speicherverwaltung / Garbage Collection
    - Sprachübergreifendes Debugging
    - Exception Handling
    - Type Checking
    - IL Code Verification
    - Thread Management
    - Base Class Library
  ],
  [#image("img/dotnet_01.png")],
)

=== Common Intermediate Language (CIL)
Ist eine _vorkompilierte Zwischensprache_. Prozessor-unabhängig, Assembler-ähnlich, Sprach-unabhängig.
CLS-kompatible Bibliotheken können von allen .NET-Sprachen verwendet werden.\
_Umfang:_ Virtuelle Stack-Maschine ohne Register, Vererbung / Polymorphie und Common Type System (CTS) für komplexe
Datentypen / Objekte und Boxing / Unboxing. Früher Microsoft Intermediate Language (MSIL) genannt.

#grid(
  [
    *Vorteile*\
    - _Portabilität_ #hinweis[(auf andere OS und Prozessorarchitekturen)]
    - _Typsicherheit_ #hinweis[(Beim Laden des Codes können Security-Checks durchgeführt werden)]
  ],
  [
    *Nachteile*\
    - _Laufzeiteffizienzverlust_ #hinweis[(Kann durch JIT-Compiler oder direkte
      Übersetzung auf eine Plattform wettgemacht werden]
  ],
)

_Build-Prozess:_\
Hauptsprache-Sourcecode #hinweis[(z.B. C\#)] #sym.arrow Hauptsprache-Compiler #sym.arrow IL-Code
#sym.arrow JIT-Compiler #sym.arrow Native Code\
Erst ab dem _Programm-Start_, das heisst zwischen dem IL-Code und dem JIT-Compiler, wird das Programm _Plattform-abhängig_.

Build produziert ein _Assembly_ #hinweis[(\*.dll oder \*.exe)] und ein _Symbol-File_
#hinweis[(\*.pdb - Programm Database für Debugging-Zwecke)] pro Projekt.

==== Cross-Language Development
Objekt-Modell und Bibliotheken sind in Plattform integriert. Die _Sprachwahl ist sekundär_, _Konzepte sind allgemeingültig_.
Die _Common Language Specification (CLS)_ bietet allgemeine _Regeln_ für Cross-Language Development.
Debugging wird von allen Sprachen unterstützt, auch Cross-Language Debugging möglich.
Aktuell umfasst .NET ca. 30 Sprachen #hinweis[(C\#, F\#, VB.NET, C++, J\#, IronPython, IronRuby, ...)].

=== Kompilierung
Der _Source Code_ wird während der Design Time #hinweis[(Build-Prozess)] mit dem _Language Compiler_ in den _IL-Code_
umgewandet. Dieser wird dann mit dem _JIT-Compiler_ während der Runtime in _Native Code_ #hinweis[(Assembler-Code der Platform)]
übersetzt. Alternativ kann der Source Code auch _direkt via Native AOT_ #hinweis[(Ahead-of-time compilation)] in Native Code
übersetzt werden.

==== Just-in-Time (JIT) Kompilierung
Nach der Kompilierung #hinweis[(ohne Native AOT)] liegen die Methoden im Assembly als IL-Code vor.
Beim Aufruf einer Methode wird erkannt, dass dieser Code noch nicht ersetzt wurde und der JIT-Compiler ersetzt diese Methode
an dieser physischen Stelle im RAM den IL- durch Assembler-Code. Der nächste Aufruf erfolgt direkt auf
den #hinweis[(gecachten)] Assembler-Code.

=== Assemblies
Die _Kompilation_ erzeugt Assemblies. Diese entsprechen ungefähr einem JAR-File in Java.\
#hinweis[(Assembly = selbstbeschreibende Komponente mit definierter Schnittstelle.)]

#grid(
  [
    - Deployment- und Ausführungs-Einheit
    - Executable oder Library #hinweis[(\*.exe bzw. \*.dll)]
    - Dynamisch ladbar
    - Selbstbeschreibende Software-Komponente\ #hinweis[(enthält Metadaten)]
  ],
  [
    - Definiert Typ-Scope #hinweis[(Sichtbarkeit)]
    - Kleinste versionierte Einheit
    - Einheit für Security-Überprüfung\ #hinweis[(Code Access Security / Role-Based Security)]
  ],
)

Ein _Assembly_ besteht aus dem _Manifest_ #hinweis[(Header-Informationen wie Referenzen auf alle Dateien des Assemblies,
Referenzen auf andere Assemblies, Metadaten wie Name & Versionsnummer etc.)],
_*$0-n$* Modulen_ und _*$0-n$* Ressourcen_ #hinweis[(Bilder, Übersetzungsdateien etc.)].
Ein _Modul_ enthält $0-n$ Typen #hinweis[(Klassen, Interfaces etc.)], die wiederum aus _CIL-Code und ihren Metadaten_
bestehen #hinweis[(Informationen der Signatur wie z.B. Sichtbarkeit, Abstrakt, Statisch etc.)]

==== Modules & Metadata
Kompilation erzeugt ein Modul mit _CIL-Code und Metadaten_.
Die _Metadaten_ beschreiben verschiedene _Attribute_ des Codes #hinweis[(Sichtbarkeit, Typ, Name, Funktionen, Parameter etc.)].
Die _Programmlogik_ steckt im _CIL-Code_ #hinweis[(Klassen-Definitionen, Methoden-Definitionen, Feld-Definitionen usw)].
Die Metadaten lassen sich über _.NET Reflection_ abfragen (siehe @reflection).

== Common Type System (CTS)
CLR hat ein integriertes, einheitliches Typen-System. Diese Typen sind im _Laufzeitsystem definiert_, nicht in Programmiersprache.
Das Typensystem ist _single-rooted_, d.h. alle Typen sind von _`System.Object`_ abgeleitet.
Es gibt 2 Kategorien, _Reference- und Value-Typen_. Auch wird _Boxing/Unboxing_ unterstützt.

_Reflection:_ Programmatisches Abfragen des Typensystems. Ist für alle Typen verfügbar
#hinweis[(ausser Security-Einschränkungen vorhanden)], erweiterbar über "Custom Attributes" (siehe @custom-attribute).

=== Reference- & Value Types
#table(
  columns: (1fr,) * 3,
  table.header([], [Reference (`class`, Objekte)], [Value (`struct`, Primitive Typen)]),
  [_Speicherort_], [Heap], [Stack],
  [_Variable enthält_], [Objekt-Referenz], [Wert],
  [_Nullwerte_], [Möglich], [Nie],
  [_Default value_], [`null`], [`0 | false | '\0'`],
  [_Zuweisung / Methodenaufruf_], [Kopiert Referenz], [Kopiert Wert],
  [_Ableitung möglich_ #hinweis[(Vererbbarkeit)]], [Ja], [Nein #hinweis[(sealed)]],
  [_Garbage Collected_], [Ja], [Nicht benötigt],
)

#grid(
  [
    ==== Reference Types
    #hinweis[Zuweisung: Objekt-Referenz wird kopiert]
    #image("img/dotnet_02.png", width: 75%)
    #small[
      ```cs
      class PointRef { public int X, Y; }
      PointRef a = new PointRef();
      a.X = 12; a.Y = 24;
      PointRef b = a;
      b.X = 9;
      Console.WriteLine(a.X); // Prints 9
      Console.WriteLine(b.X); // Prints 9
      ```
    ]
  ],
  [
    ==== Value Types
    #hinweis[Zuweisung: Wert wird kopiert]
    #image("img/dotnet_03.png", width: 34%)
    #small[
      ```cs
      struct PointVal { public int X, Y; }
      PointVal a = new PointVal();
      a.X = 12; a.Y = 24;
      PointVal b = a;
      b.X = 9;
      Console.WriteLine(a.X); // Prints 12
      Console.WriteLine(b.X); // Prints 9
      ```
    ]
  ],
)

#grid(
  columns: (1fr, 1fr),
  [
    === Boxing / Unboxing <boxing-unboxing>
    Polymorphe Behandlung von Value- und Reference-Types. Üblicherweise mit `object` als "Box" durchgeführt.
    - _Boxing:_ Kopiert Value Type in einen Reference Type. Der dazugehörige Value Type wird mit in den
      Reference Type gespeichert #hinweis[(implizite Konvertierung, upcast)].
    - _Unboxing:_ Kopiert Reference Type in einen Value Type #hinweis[(explizite Konversion, downcast)].
  ],
  [
    ```cs
    System.Int32 i1 = 123;
    System.Object obj = i1; // Boxing
    System.Int32 i2 = (System.Int32)obj; // Unboxing
    ```
    #image("img/dotnet_04.png", width: 60%)
  ],
)

== Command Line Interface CLI
Komplexe Command Line Tool-Chain "`dotnet.exe`". Ist Teil des .NET (Core) SDK, Basis für high-level Tools.\
_Command-Struktur:_ `dotnet[.exe] <Verb> <argument> --<option> <param>`
- _`<verb>`:_ Auszuführende Aktion #hinweis[(build, run, etc.)]
- _`<arg>`:_ Argument für vorangehendes Verb
- _`<option>`:_ Option / Switch Parameter. Mehrere Optionen möglich
- _`<param>`:_ Parameter zur Option. Nicht zwingend.

_Beispiele:_ `dotnet publish my_app.csproj` oder `dotnet build --output /build_output`

== Projekte & Referenzen
#v(-0.5em)
=== Projekt-Dateien
Im XML Format mit `.csproj` Endung. _Build-Engines:_ Microsoft Build Engine "MSBuild" oder .NET Core CLI (`dotnet build`).
Einfache, dynamische Grobstruktur #hinweis[(Property\*: Projekteinstellungen, Item\*: Zu kompilierende Items,
Target\*: Sequenz auszuführender Schritte)]

=== Referenzen
- _Vorkompiliertes Assembly_ #hinweis[(Im File System, Debugging nicht verfügbar, Navigation nur auf Metadaten-Ebene)]
- _SDK-Referenz_ #hinweis[(z.B. verwendete .NET-Version, Zwingend)]
- _NuGet Package_ #hinweis[(Externe Dependency, Debugging nicht verfügbar, Navigation nur auf Metadaten-Ebene)]
- _Visual Studio Projekt:_ #hinweis[(In gleicher Solution vorhanden, Debugging und Navigation verfügbar)]

== Packages & NuGet
NuGet ist der neue Standard für Packaging. .NET wird neu in _kleineren Packages_ geliefert.
_Vorteile:_ Erlaubt Release-Zyklen unabhängig von .NET/Sprachreleases, Erhöht Kompatibilität durch Kapselung, kleinere Deployment-Einheiten.

- _Entwicklungsprozess:_ Create Project, Create Manifest, Compile Project, Create Package, Publish Package, Consume Package
- _Deployment:_ Lokales NuGet Repository auf Entwicklungsrechner, Self-hosted NuGet Repository oder Hosted NuGet Repository.

= C\# Grundlagen
==== Naming Guidelines
#table(
  columns: (auto, 1fr, 1fr),
  table.header([Element], [Casing], [Beispiel]),
  [Namespace \ Klasse / Struct \ Interface \ Enum \ Delegates],
  [PascalCase #hinweis[(erster Buchstabe gross)] \ Substantive],
  [`System.Collections.Generic` \ `BackColor` \ `IComparable` \ `Color` \ `Action / Func`],

  [Methoden], [PascalCase, Aktiv-Verben / Substantive], [`GetDataRow`, `UpdateOrder`],
  [Felder #hinweis[(mit Underscore Prefix)] \ Lokale Variablen \ Parameter],
  [CamelCase #hinweis[(erster Buchstabe klein)]],
  [`_name` \ `orderId` \ `orderId`],

  [Properties \ Events], [PascalCase], [`OrderId` \ `MouseClick`],
)

#pagebreak()

== Sichtbarkeitsattribute
#small[
  #table(
    columns: (auto, 1fr),
    table.header([Attribut], [Beschreibung]),
    [`public`], [Überall sichtbar],
    [`private`], [Innerhalb des jeweiligen Typen sichtbar],
    [`protected`], [Innerhalb des jeweiligen Typen oder abgeleiteter Klasse sichtbar],
    [`internal`], [Innerhalb des jeweiligen Assemblies sichtbar],
    [`protected internal`],
    [Innerhalb des jeweiligen Typen, der abgeleiteter Klasse oder des jeweiligen Assemblies sichtbar],
    [`private protected`],
    [Innerhalb des jeweiligen Typen oder abgeleiteter Klasse sichtbar, wenn diese im gleichen Assembly ist],
  )

  #grid(
    [
      #table(
        columns: (auto, auto, 1fr),
        table.header([Typ], [Standard], [Zulässig #hinweis[(Top-Level)]]),
        [`class`], [`internal`], [`public` / `internal` \ ` ` \ ` ` \ ` ` \ ` ` \ ` `],
        [`struct`], [`internal`], [`public` / `internal` \ ` ` \ ` `],
        [`enum`], [`internal`], [`public` / `internal`],
        [`interface`], [`internal`], [`public` / `internal`],
        [`delegate`], [`internal`], [`public` / `internal`],
      )
    ],
    [
      #table(
        columns: (auto, 1fr),
        table.header([Standard für Members], [Zulässig für Members]),
        [`private`], [`public` \ `protected` \ `internal` \ `private` \ `protected internal` \ `private protected`],
        [`private`], [`public` \ `internal` \ `private`],
        [`public`], [`-`],
        [`public`], [`-`],
        [`-`], [`-`],
      )
    ]
  )
]

== Namespaces
Entspricht in Java dem "Package". Adressiert via "Classpath". _Strukturiert_ den Quellcode.
Ist _hierarchisch_ aufgebaut und _nicht_ an physikalische Strukturen gebunden #hinweis[(wie z.B. Ordnerstruktur)].\
Beinhaltet andere Namespaces, Klassen, Interfaces, Structs, Enums und Delegates.

Es sind _mehrere_ Namespaces in einem File möglich und ein Namespace kann in _mehreren_ Files definiert sein.
Namespace und Ordnerstruktur können sich _unterscheiden_.

```cs
namespace A { class C {} }
namespace B {}
```

Namespaces werden in andere Namespaces _importiert_ mit ```cs using System```.\
Es sind auch Alias-Namen möglich: ```cs using F = System.Windows.Forms ... F.Button b;```

=== File-Scoped Namespaces
Erlaubt das Entfernen von `{}` nach Deklaration des Namespaces. Reduziert _Einrückung_ des Codes.
Dann ist aber nur _ein Namespace pro File_ erlaubt.

#grid(
  [
    ```cs
    // File1.cs "Klassisch"
    namespace OstDemo
    {
      class X {}
    }
    ```
  ],
  [
    ```cs
    // File1.cs "File-Scoped Namespace"
    namespace OstDemo;
    class X {}
    namespace OstDemo2 {} // Compiler-Fehler
    ```
  ],
)

=== Global `using` directives
Erlaubt "globale" Deklaration von usings. Gelten für das _ganze_ Projekt, verkleinert Boilerplate Code im Header.
Das `using`-Statement in den einzelnen Files kann dann weggelassen werden.

*Deklarationsmöglichkeiten:*
- C\# Direktive, meist in Datei `GlobalUsings.cs`, z.B. ```cs global using Azure.Core;```
- MSBuild `/*.csproj` Datei z.B. ```xml <ItemGroup><Using Include="Azure.Core" /></ItemGroup>```

==== Implicit global using directives
Vordefinierte Liste globaler "usings", bei Projektgenerierung vom Compiler erstellt.
Muss im `.csproj` mit ```xml <ImplicitUsings>enable</ImplicitUsings>``` aktiviert werden.
Welche Usings verwendet werden, ist abhängig von gewählten SDK.

#pagebreak()

== Main-Methode
Ist der _Einstiegspunkt_ eines Programms. Ist zwingend für Executables und klassischerweise genau 1x erlaubt.
Das Programm _beginnt_ mit der ersten Anweisung in der Main-Methode und _endet_ mit der letzten Anweisung in der Main-Methode.
Befindet sich meist in der Datei `Program.cs`.

=== Anforderungen
#grid(
  columns: (1.2fr, 1fr),
  [
    - _Sichtbarkeit_ der Methode und beinhaltender Klasse _nicht relevant_
    - Die Main-Methode muss _`static`_ sein, beinhaltende Klasse nicht
    - _Gültige Rückgabetypen:_ ```cs void, int, Task, Task<int>```
    - _Gültige Parametertypen:_ Keine Parameter oder ```cs string[]```
  ],
  [
    ```cs // Examples (some missing for brevity)``` \
    ```cs static void Main() { }``` \
    ```cs static void Main(string[] args) { }``` \
    ```cs static int Main(string[] args) { }``` \
    ```cs static async Task<int> Main() { }``` \
  ],
)

=== Argumente
#grid(
  columns: (1.2fr, 1fr),
  [
    - Diverse Möglichkeiten für Zugriff
      - Über einen `string[]`-Parameter
      - Ohne `string[]`-Parameter über statische Methode: ```cs System.Environment.GetCommandLineArgs();```
    - Können beim Aufruf mit Space getrennt angegeben werden
    - Parsen mit NuGet Package `System.CommandLine` empfohlen
  ],
  [
    ```cs
    class ProgramArgs {
      static void Main(string[] args) {
        for (int i = 0; i < args.Length; i++) {
          Console.WriteLine(
            $"Arg {i} = {args[i]}"); }
    ```
    `> MyApp.exe alpha beta gamma
    Arg 0 = alpha
    Arg 1 = beta
    Arg 2 = gamma`
  ],
)

=== Top-level Statements
#grid(
  columns: (1fr, 1fr),
  [
    - Erlaubt _Weglassen der Main-Methode_ als Entry Point.
    - _Regeln:_ Nur 1x pro Assembly erlaubt, Argumente heissen fix `args`, Exit Codes sind erlaubt, _vor_ den top-level Statements
    können `using`s definiert werden, _nach_ den top-level Statements können Typen/Klassen definiert werden.
  ],
  [
    ```cs
    using System; // main() code start
    for (int i = 0; i < args.Length, i++) {
      ConsoleWriter.Write(args, i);
    } // main() code end
    class ConsoleWriter {
      public static void Write(string[] args, int i) {
        console.WriteLine($"Arg {i} = {args[i]}");
      }
    }
    ```
  ],
)

== Enumerationstypes: enum
Liste _vordefinierter Konstanten_ inklusive Wert. Ist standardmässig `int`, kann aber mit jedem Integertyp ersetzt werden,
um Wertebereich/Speichernutzung anzupassen #hinweis[(byte, sbyte, short, ushort, uint, long, ulong)]. Index beginnt bei 0.

*Deklaration*\
```cs enum Days { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday };``` \
```cs enum Days { Sunday = 10, Monday, Tuesday, Wednesday, Thursday, Friday = 9, Saturday };
/* Indexe: 10, 11, 12, 13, 14, 9, 10 */
```

Duplikate in den Werten sind erlaubt. Bei Cast in ein Enum wird aber immer die erste Definition verwendet.
Im Beispiel oben ist also ```cs (Days)10``` immer `Sunday`, nie `Saturday`.

*Verwendung*\
```cs Days today = Days.Monday; if (today == Days.Monday) { /* ... */ }```

*Werte auslesen*\
#v(-0.5em)
```cs
int sundayValue = (int)Days.Sunday; Console.WriteLine("{0} / #{1}", Days.Sunday, sundayValue);
// Output: Sunday / #10
foreach (string name in Enum.GetNames(typeof(Days))) { Console.WriteLine(name); }
// Output: Monday\nTuesday\nWednesday ...
```

*String zu Enum parsen*\
```cs Days day1 = (Days)Enum.Parse(typeof(Days), "Monday") // Non-Generic, Exception on failure```\
```cs
Days day2;
bool success2 = Enum.TryParse("Monday", out day2); // Generic, variable already defined
bool success3 = Enum.TryParse("Monday", out Days day3) // Generic, initializes new variable
```

#pagebreak()

== Object
_Basisklasse aller Typen._ Einer `object`-Variable kann jeder Typ zugewiesen werden, siehe @boxing-unboxing.
Methoden mit `object`-Parameter können ebenfalls alle Typen annehmen, erlaubt dynamische Methoden.
```cs
public class Object {
  public Object() { };
  // Compares references of the objects, can be overridden to compare values
  public virtual bool Equals(object obj);
  public static bool Equals(object objA, object objB);
  public virtual int GetHashCode();
  public Type GetType();
  // Creates a shallow copy of the current Object, references in the object stay the same
  protected object MemberwiseClone();
  // Compares references of the objects, can't be overridden
  public static bool ReferenceEquals(object objA, object objB);
  public virtual string ToString();
}
```

== Strings
```cs string s1 = "Test";```

Ein `string` ist ein _reference type_ und _nicht modifizierbar_ #hinweis[(Modifizierung wird in einen Aufruf
von `System.String.Concat(...)` umgewandelt, ein neuer `string` wird kreiert)]. Eine _Verkettung_ ist mit dem `+` Operator
möglich und ein _Wertevergleich_ mit `==` oder `equals()`. Ein C\# `string` ist _nicht_ mit `\0` terminiert.
_Indexierung_ ist möglich, Die Länge wird mit dem `.Length`-Property ermittelt.

=== String Interpolation
Mit einem `$` vor dem String können Werte und Expressions innerhalb von `{...}` direkt in einen String evaluiert und eingefügt werden.\
```cs string s2 = $"{DateTime.Now}: {(DateTime.Now.Hour < 18 ? "Hello" : "Good Evening")}";```

=== Raw String Literals
#grid(
  columns: (1.1fr, 1fr),
  [
    Mehrzeilige Strings ohne spezielle Behandlung des Inhalts\
    #hinweis[(keine Escape-Sequences, alle Characters sind "normaler Text")]
    - Deklariert mit _mindestens 3 Double Quotes_ #hinweis[(erlaubt mehrere aufeinanderfolgende Double Quotes im Raw String,
      muss immer mit 1 Double Quote mehr initialisiert werden, als im String beinhaltet)]
    - _Einrückung:_ Die Position der "closing quote" definiert das\ 0-te Level #hinweis[(linker Rand)] des Raw Strings.
    - _Verwendung:_ Einbetten von strukturierten Text-Daten #hinweis[(JSON, XML)], Text bei welchem Whitespace-Formatierung relevant ist.
  ],
  [
    ```cs
    string s3 =
    """
    {
      "Name": "Nina",
      "Profession": "WordPress Web Dev"
    }
    "" \ \\ ' ''
    """;
    ```
  ],
)

=== Verbatim String Literals
#grid(
  columns: (1.1fr, 1fr),
  [
    Simplere Variante des Raw Strings.
    - Deklariert mit _`@"[string]"`_
    - Double Quotes müssen mit einem zweiten Double Quote escaped werden
    - _Verwendung:_ Simple (Multiline-)Strings mit Escape-Chars, z.B. Windows-Dateipfade
  ],
  [
    ```cs
    string str;
    // file "C:\sample.txt"
    str = "file \"C:\\sample.txt\"";
    str = "file \x0022C:\u005csample.txt\x0022";
    str = @"file
    ""C:\sample.txt""";
    // newline inside verbatim string is ignored
    ```
  ],
)

=== Vergleiche
Bei C\# wird mit #no-ligature(`==`), #no-ligature(`!=`) und `Equals()` der _Inhalt_ der Strings verglichen.

```cs
string s1 = "Test"; string s2 = "Test";
bool result1 = s1.Equals(s2);                  // True
bool result2 = string.Equals(s1, s2);          // True
bool result3 = s1 == s2                        // True
```

Strings werden intern _wiederverwendet_. Erst ```cs string.Copy(...)``` erzeugt eine echte Kopie.

```cs
bool result4 = string.ReferenceEquals(s1, s2); // True
string s3 = string.Copy(s1);
bool result5 = string.Equals(s1, s3);          // True
bool result6 = string.ReferenceEquals(s1, s3); // False
```

== Arrays
Einfachste Datenstruktur für _Listen_. Können _eindimensional_, _mehrdimensional_ und _rechteckig_ oder _ausgefranst/jagged_ sein.
Die Länge _aller Dimensionen_ ist bei der Instanzierung bekannt. _Alle Werte_ sind nach der Instanzierung initialisiert
#hinweis[(`false, 0, null,` etc.)]. Arrays sind _zero-based_ und immer auf dem _Heap_.

=== Eindimensionale Arrays
```cs
int[] array1 = new int[5];                  // Deklaration (Value Type) mit Länge 5
int[] array2 = new int[] { 1, 3, 5, 7, 9 }; // Deklaration & Wertedefinition
int[] array3 = int[] { 1, 2, 3, 4, 5, 6 };  // Vereinfachter Syntax ohne new
int[] array4 = { 1, 2, 3, 4, 5, 6 };        // Vereinfachter Syntax ohne new / Typ
object[] array5 = new object[5];            // Deklaration (Reference Type)
```
- _Value Types:_ ```cs int[] a = { 1, 3, 5 } // speichert Wert```
- _Reference Types:_ ```cs object[] a = new object[3]; a[1] = new object(); a[2] = 5; // speichert Referenz```

==== Length & Indexzugriff
```cs
int length = array2.Length; // returns 5
int value1 = array2[4]; // returns 9
int value2 = array2[5]; // System.IndexOutOfRangeException
```

==== Vereinfachter Syntax
```cs
int[] array5 = { 1, 2, 3, 4, 5, 6 }     // Deklaration ohne new
array5 = new int[] { 1, 2, 3, 4, 5, 6 } // Zuweisung mit new type[] OK
array5 = new [] { 1, 2, 3, 4, 5, 6 }    // Zuweisung mit new[] OK
array5 = { 1, 2, 3, 4, 5, 6 };          // Compilerfehler, Zuweisung ohne new unzulässig
```

=== Mehrdimensionale Arrays (rechteckig)
#grid(
  columns: (2fr, 1fr),
  [
    ```cs
    int[,] a = new int[2,3];           // Deklaration
    a[0, 1] = 9;                       // Schreiben
    int x = a[0, 1];                   // Lesen - returns 9
    int[,] b = { { 1, 2 }, { 4, 5 } }; // Deklaration & Wertedefinition
    ```
  ],
  image("img/dotnet_05.png"),
)

==== Length
```cs
int length = a.Length;        // returns 6
int length0 = a.GetLength(0); // returns 2 - Länge der 0. Dimension
int length1 = a.GetLength(1); // returns 3 - Länge der 1. Dimension
```

#grid(
  columns: (2fr, 1fr),
  [
    === Mehrdimensionale Arrays (jagged)
    ```cs
    int[][] a = new int[2][];  // Deklaration - "Liste" von Arrays
    a[0] = new int[2];         // Wertedefinition
    a[1] = new int[1];         // Wertedefinition
    a[0][1] = 9;               // Schreiben
    int x = a[0][1];           // Lesen - returns 9
    ```
  ],
  image("img/dotnet_06.png"),
)

==== Length
```cs
int length = a.Length;     // returns 2 - Länge der 0. Dimension
int length0 = a[0].Length; // returns 2 - Länge des ersten Array
int length1 = a[1].Length; // returns 1 - Länge des zweiten Arrays
```

=== Vorteile von Blockmatrizen
- _Speicherplatz-Effizienz:_ Verbraucht weniger Speicher, da weniger Referenzen verwaltet werden müssen
- _Schnelleres Allozieren:_ Speicher kann als gesamter Block alloziert werden, bei jagged Arrays sind
  Dimension $2 - n$ manuell zu allozieren
- _Schnellere Garbage Collection:_ Weniger Verwaltungsaufwand weil nur 1 Array statt $n + 1$

Der _Zugriff_ ist jedoch _nicht schneller_, weil der _Boundary-Check_ nur bei 1-dimensionalen Arrays optimiert wird.


== Symbole
#v(-0.5em)
=== Identifiers
Sind _Case-sensitive_, Unicode kann verwendet werden. Wenn ein _Schlüsselwort_ als Identifier verwendet werden soll,
muss ein `@` vor das Schlüsselwort gestellt werden.\
_Syntax:_ `(letter | '_' | '@' ){ letter | digit | '_' }`\
```cs string someName; int sum_of3; int _10percent; int @while; double 🍆; double \u03c0; int f\u0061ck;```

=== Schlüsselwörter
Im Vergleich zu anderen Sprachen hat C\# relativ viele Schlüsselwörter. Viele sind aber kontextabhängig und werden beim
Schreiben von "normalem" Code wenig verwendet. 
#small[
  ```
  abstract         as               base              bool                    break                    byte
  case             catch            char              checked                 class                    const
  continue         decimal          default           delegate                do                       double
  else             enum             event             explicit                extern                   false
  finally          fixed            float             for                     foreach                  goto
  if               implicit         in                in (generic modifier)   int                      interface
  internal         is               lock              long                    namespace                new
  null             object           operator          out                     out (generic modifier)   override
  params           private          protected         public                  readonly                 ref
  return           sbyte            sealed            short                   sizeof                   stackalloc
  static           string           struct            switch                  this                     throw
  true             try              typeof            uint                    ulong                    unchecked
  unsafe           ushort           using             virtual                 void                     volatile
  while
  ```
]

=== Kommentare
- _Single-Line:_ ```cs // ...```
- _Multi-Line:_ ```cs /* ... */```
- _Dokumentation von Methoden, Feldern, Properties:_
  ```cs /// <summary>...</summary> <returns>...</returns>```

== Primitivtypen
#v(-0.5em)
=== Ganzzahlen
#grid(
  columns: (1.5fr, 1fr),
  [
    - _Ohne Suffix:_ Kleinster Typ aus `int | uint | long | ulong`
    - _Suffix `u | U`:_ Kleinster Typ aus `uint | ulong`
    - _Suffix `l | L`:_ Kleinster Typ aus `long | ulong`\
    *Syntax*
    - _Regulär:_ `digit{digit}{Suffix}`
    - _Hexadezimal:_ `"0x" hexDigit{hexDigit}{Suffix}`
    - _Binär:_ `"0b" [0|1]{[0|1]}{Suffix}`
  ],
  [
    ```cs
    object number;
    number = 17;         // int
    number = 9876543210; // long
    number = 17L;        // long
    number = 17u;        // uint
    number = 0x3e;       // int
    number = 0x3eL;      // long
    number = 0b11101011; // int
    ```
  ],
)

=== Fliesskommazahlen
#grid(
  columns: (1.5fr, 1fr),
  [
    - _Ohne Suffix oder `d | D`:_ `double`
    - _Suffix `f | F`:_ `float`
    - _Suffix `m | M`:_ `decimal` \
    *Syntax* \
    `[Digits] ["." [Digits]] [Exp] [Suffix]`\
    *`Digits:`* `digit {digit}` \
    *`Exp:`* `("e" | "E") ["+" | "-"] [Digits]` \
    *`Suffix:`* `"f" | "F" | "d" | "D" | "m" | "M"`
  ],
  [
    ```cs
    object number;
    number = 3.14; // double
    number = 1E-2; // double
    number = .1;   // double
    number = 10f;  // float

    ```
  ],
)

==== Lesbarkeit von numerischen Werten
#grid(
  columns: (3fr, 2fr),
  [
    _`"_"`_ für _bessere optische Strukturierung_. Hat keine eigentliche Funktion, funktioniert mit allen numerischen Werten.
    Ist überall erlaubt, ausser am Anfang oder Ende einer Zahl. Wird vom Compiler einfach entfernt.

    *Escape-Sequenzen*
    - `\'`, `\"`, `\\`: für den jeweiligen Char
    - `\n`: newline
    - `\t`, `\v`: horizontal/vertical tab
  ],
  [
    ```cs
    object number;
    number = 9_876_543_210; // 987654321§
    number = 0x1000_0000;   // 0x10000000
    number = 0b1110_1011;   // 0b11101011
    number = 1_23_456789_0; // 1234567890
    number = 10__0E-2_2     // 100E-22
    ```
  ],
)

=== Zeichen / Zeichenketten
#grid(
  columns: (3fr, 2fr),
  [
    - _String:_ `"{char}"` #hinweis[(Nicht erlaubt: `"`, `|end-of-line|` und `\`)]
    - _Char:_ `'char'` #hinweis[(Nicht erlaubt: `'`, `|end-of-line|` und `\`)]
  ],
  [
    ```cs
    string str;
    // file "C:\sample.txt"
    str = "file \"C:\\sample.txt\"";
    ```
  ],
)

=== Typkompatibilität
#figure(
  image("img/dotnet_07.png"),
  caption: [#hinweis[Typen mit validem Pfad werden implizit konvertiert, bei anderen ist ein expliziter Type Cast nötig]],
)

Übersicht einiger Beispiel-Casts. Links: Typ der Zielvariable, Rechts: Typ des Quellvariable
#table(
  columns: (1fr, 1fr),
  table.header([Erlaubt], [Nicht erlaubt ohne Cast]),
  [
    ```
    int = short;       decimal = (decimal)double;
    float = char;      byte = (byte)long;
    decimal = long;    uint = (uint)int;
    double = byte;     decimal = char; (!)
    ```
  ],
  [
    ```
    short = int;
    char = int;
    char = float;
    decimal = float;
    ```
  ],
)

== Statements
#v(-0.5em)
=== Switch case
#grid(
  columns: (1.1fr, 1fr),
  [
    Möglich mit Ganzzahlen #hinweis[(`[s]byte`, `[u]short`, ` [u]int` `[u]long`)], `char`, `string` und `enum`.
    Die Cases sind _fall-through_, ist ein Case also nicht mit `break`, `throw`, `return` oder `goto` abgeschlossen,
    wird der Code im nächsten Case ausgeführt, ohne dass die Case-Kondition nocheinmal geprüft wird.

    Der `default`-Case ist optional und wird ausgeführt, wenn kein anderer Case zutrifft. `null`-case ist erlaubt.
  ],
  [
    ```cs
    string country = "Germany"; string lang;
    switch (country) {
      case "Germany":
      case "Switzerland":
        lang = "German"; break;
      case null:
        Console.WriteLine("Country null"); break;
      default: Console.WriteLine("Error"); break;
    }
    ```
  ],
)

=== Jumps
#grid(
  columns: (1fr,) * 2,
  [
    - _`break`:_ Aktuellen Loop beenden
    - _`continue`:_ Zur nächsten Loop-Iteration #hinweis[(z.B. nächstes Item in `foreach`)]
  ],
  [
    - _`goto` case:_ Sprung zu Case innerhalb eines `switch`
    - _`goto` label:_ Sprung zum Label #hinweis[(Keine Sprünge in Methoden hinein oder aus `finally`-Block heraus)]
  ]
)


= Klassen & Structs
#v(-0.5em)
== Structs
#grid(
  [
    Structs sind _Value Types_, d.h. sie sind auf dem _Stack_ angelegt
    #hinweis[(oder "in-line" in einem Objekt auf dem Heap $->$ alle Struct-Objekte werden innerhalb vom enthaltenen
    Objekt angelegt und gespeichert)]

    === Vererbung
    Ableiten von der Basisklasse ist _nicht_ möglich, Verwendung als Basisklasse ebenfalls _nicht_.
    Structs können aber Interfaces implementieren.
  ],
  [
    ```cs
    struct Point {
      int _x = 0;
      int _y = 0;

      public Point(int x, int y) { /* ... */ }
      public void MoveX(int x) { /* ... */ }
      public void MoveY(int y) { /* ... */ }
    }
    ```
  ]
)

#grid(
  [
    === Verwendung von Structs
    Ein Struct sollte nur verwendet werden, wenn:
    - Repräsentiert _einzelnen Wert_ #hinweis[(Keine Instanzen)]
    - Instanzgrösse ist _kleiner_ als 16 Byte
    - Ist _immutable_ #hinweis[(Kann nicht verändert werden)]
    - Wird _nicht_ häufig _geboxt_
    - Ist entweder _kurzlebig_ oder wird in andere Objekte _eingebettet_.
    In allen anderen Fällen sollte eine Klasse verwendet werden.
  ],
  [
    === Instanzierung von Klassen/Structs
    Erzeugt aus Klasse/Struct ein Object. Dabei wird:
    + Speicherplatz im RAM alloziert
    + Speicher initialisiert #hinweis[(`default` oder mitgegebene Werte)]

    ```cs
    Point p1 = new Point(0, 1); // Klassisch
    Point p2 = new(1, 1);       // Target typed new
    ```
  ],
)

#pagebreak()

== Klassen
#grid(
  [
    Klassen sind _reference Types_, d.h. sie werden auf dem _Heap_ angelegt.

    === Vererbung
    Ableiten von der Basisklasse ist möglich, Verwendung als Basisklasse ebenfalls.
    Klassen können auch Interfaces implementieren.
  ],
  [
    ```cs
    class Stack {
      int[] _values; // reference type
      int _top = 0;
      public Stack(int size) { /* ... */ }
      public void Push(int x) { /* ... */ }
      public int Pop() { /* ... */ }
    }
    ```
    ```cs Stack s = new Stack(10); // Instanzierung```
  ],
)

=== Felder
#grid(
  [
    Ein Feld ist eine Variable eines beliebigen Typs, die in einer Klasse oder einem Struct deklariert wird.

    - _Feld:_ Initialisierung in Deklaration optional, Initialisierung darf nicht auf (andere) Felder und Methoden zugreifen.
    - _`readonly` Feld:_ In Deklaration oder Konstruktor initialisiert, muss _nicht_ zur Compilezeit berechenbar sein.
      Wert darf danach nicht mehr geändert werden.
    - _Konstante `const`:_ Muss einen Initialisierungswert haben, dieser muss zur Compilezeit berechenbar sein
      #hinweis[(keine Objektinitialisierung mit `new`!)].
  ],
  [
    ```cs
    class MyClass {
      int _value = 9; // standardmässig private
      const long Size = int.MaxValue / 3 + 1234;
      readonly DateTime _date1 = DateTime.Now;
      readonly DateTime _date2;
      public MyClass() {
        _date2 = DateTime.Now();
      }
      public void DoSomething() {
        _value = 10;
        _date2 = DateTime.Now; // Compilerfehler
      }
    }
    ```
  ],
)

=== Nested Types
#grid(
  [
    Werden für _spezifische Hilfsklassen_ gebraucht.

    *Regeln:* \
    - Die _äussere Klasse_ hat Zugriff auf die innere Klasse \
      #hinweis[(Nur auf "Public Members")]
    - Die _innere Klasse_ hat Zugriff auf die äussere Klasse \
      #hinweis[(Auch auf "Private Members")]
    - _Fremde Klassen_ erhalten Zugriff auf innere Klasse, wenn diese _"public"_ ist
    - _Erlaubte Nested Types sind:_ Klassen, Interfaces, Structs, Enums, Delegates
  ],
  [
    ```cs
    public class OuterClass {
      private int _outerValue;
      InnerC _innerInstance = new();
      public void OuterMethod() {
        _innerInstance.InnerMethod(this);
      }
      public class InnerClass {
        public void InnerMethod(OuterClass outerClass) {
          outerClass._outerValue = 123;
    } } }
    ```

    *Anwendung*
    #v(-0.5em)
    ```cs
    OuterClass outer = new(); outer.OuterMethod();
    OuterClass.InnerClass i = new(); i.InnerMethod();
    ```
  ],
)

=== Statische Klassen
#grid(
  [
    *Regeln:* Nur _statische Member_ erlaubt, kann _nicht instanziert_ werden, sind "sealed".\
    *Zweck:* _Sammlung_ von Standard-Werten oder Funktionalitäten, Definition von Erweiterungsmethoden.
  ],
  [
    ```cs
    static class MyMath {
      public const double Pi = 3.14159;
      public static double Sin(double x) { ... }
      public static double Cos(double x) { ... }
    }
    ```
  ],
)

=== Statische Usings
#grid(
  [
    _Verkürzt Quellcodes_ bei Verwendung von statischen Klassen.

    *Regeln:*
    - Nur _statische Klassen_ sowie Enums erlaubt
    - Importiert _alle statischen Members_ und _statischen Nested Types_
    - Bei _Namenskonflikten_ gelten die Auflösungsregeln wie bei überladenen Methoden.
    - Bei _identischen Signaturen_ muss der Klassenname vorangestellt werden.
  ],
  [
    ```cs
    using static System.Console;
    using static System.Math;
    using static System.DayOfWeek;

    class ExamplesStaticUsing {
      static void Test() {
        WriteLine(Sqrt(3 * 3 + 4 * 4));
        WriteLine(Friday - Monday);
      }
    }
    ```
  ],
)

== Memory Modell
#v(-0.5em)
=== Beispiel Klasse (Call by Reference)
#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  image("img/dotnet_12.png", width: 60%),
  [
    ```cs
    class Coordinate {
      public double X { get; set; }
      public double Y { get; set; }
    }
    class Vector {
      public Coordinate C1 { get; set; }
      public Coordinate C2 { get; set; }
    }

    Vector v = new();
    v.C1.X = 1.5;
    v.C1.Y = 2.0;
    ```
  ],
)

=== Beispiel Struct (Call by Value)
#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  image("img/dotnet_13.png", width: 60%),
  [
    ```cs
    struct Coordinate {
      public double X { get; set; }
      public double Y { get; set; }
    }
    class Vector {
      public Coordinate C1 { get; set; }
      public Coordinate C2 { get; set; }
    }

    Vector v = new();
    v.C1.X = 1.5;
    v.C1.Y = 2.0;
    ```
  ],
)

== Methoden
In anderen Sprachen _"Funktionen"_ genannt.

=== Statische Methoden
#grid(
  [
    Es gibt Methoden _mit Rückgabewert_ #hinweis[(Funktionen)] und _ohne Rückgabewert_ #hinweis[(Prozedur / Aktion)].

    ==== Verwendung innerhalb `MyClass`:
    ```cs
    Print();
    int value1 = GetValue();
    PrintStatic();
    int value2 = GetValueStatic();
    ```

    ==== Verwendung ausserhalb `MyClass`:
    ```cs
    MyClass mc = new();
    mc.Print();
    int value1 = mc.GetValue();
    MyClass.PrintStatic();
    int value2 = MyClass.GetValueStatic();
    ```
  ],
  [
    ```cs
    class MyClass {
      // Prozedur / Aktion
      public void Print() { }

      // Funktion
      public int GetValue() { return 0; }

      // Statische Prozedur / Aktion
      public static void PrintStatic() { }

      // Statische Funktion
      public static int GetValueStatic()
        { return 0; }
    }
    ```
  ],
)

=== Parameter
#grid(
  [
    - _Value-Parameter:_ Kopie des Stack-Inhaltes wird übergeben #hinweis[(Call by Value)].
      Modifiziert nur diese Kopie, Original-Variabel im Aufrufer bleibt unberührt.
    - _Ref-Parameter:_ Adresse der Variable wird übergeben, Variable muss initialisiert sein #hinweis[(Call by reference)].
      Modifiziert Original-Variable im Aufrufer. In der Signatur und beim Methodenaufruf mit ```cs ref``` gekennzeichnet.
    - _out-Parameter:_ Wie Ref-Parameter, aber zur Initialisierung von Werten gedacht.
      Ist zuerst leer, muss in Methode _zwingend initialisiert_ werden.\
      *Anwendung:* Variablen können direkt im Methodenaufruf deklariert werden, nicht benötigte out-Parameter können
      mit Underscore ```cs out _``` ignoriert werden.
  ],
  [
    ```cs
    void IncVal(int x) { x = x + 1; }
    void TestIncVal() {
      int value = 3; IncVal(value); // value == 3
    }

    void IncRef(ref int x) { x = x + 1; }
    void TestIncRef() {
      int value = 3; IncRef(ref value); // value == 4
    }

    void Init(out int a, out int b) { a = 1; b = 2; }
    void TestInit() {
      Init(out int a1, out int b1); // a1 == 1, b1 == 2
      Init(out int a3, out _); // a3 == 1, b weggeworfen
    }
    ```
  ],
)

==== Parameter Array
#grid(
  [
    Erlaubt _beliebig viele Parameter_, muss am Schluss der Deklaration stehen. Nur eines pro Methode erlaubt,
    keine Kombination mit ```cs out``` oder ```cs ref```. Ab C\# 13 auch mit ```cs IEnumerable``` und Subklassen möglich
    #hinweis[(z.B. ```cs List<>```)].
  ],
  [
    ```cs
    void Sum(out int sum, params int[] values) { ... }
    Sum(out int sum1, 1, 2, 3);
    void Sum(params List<int> values) { ... }
    Sum(new List<int> { 1, 2, 3 });
    ```
  ],
)

==== Optionale Parameter
#grid(
  [
    Erlaubt _Zuweisung eines Default-Values_, Deklaration muss _hinter_ erforderlichen Parametern erfolgen.
    Weglassen ist nur am Ende erlaubt. Muss zur Compiletime berechenbar sein
    #hinweis[(Konstanter Ausdruck oder Struct/Enum-Initialisierung)]. ```cs default``` erlaubt.
  ],
  [
    ```cs
    void Sort(int[] arr, int from = 0, int to = -1){...}
    Sort(a); Sort(a, 0); // beides erlaubt
    Sort(a, , 3);        // Weglassen nicht erlaubt
    void Bad(object x = new()) { ... } // nicht erlaubt
    void Ok(int x = default) { ... }   // erlaubt
    ```
  ],
)

==== Named Parameter
#grid(
  [
    Erlaubt Identifikation _anhand Namen_ anstelle anhand der Position. Weglassen beliebiger optionaler Parameter erlaubt.
    Positionsparameter #hinweis[(im Beispiel `a`)] immer noch davor. Können aber auch mit Namen angegeben werden,
    dann ist die Reihenfolge egal.
  ],
  [
    ```cs
    void Sort(int[] arr, int from = 0, int to = -1){...}
    Sort(a);
    Sort(a, from: 0); // a muss zuerst stehen
    Sort(a, to: 10);  // a muss zuerst stehen
    Sort(from: 2, to: 5, arr: a); // a darf hinten sein
    ```
  ],
)


=== Überladung / Overloading
#grid(
  [
    _Mehrere Methoden_ mit _gleichem Namen_ möglich.\
    _Voraussetzung:_
    - Unterschiedliche Anzahl Parameter *oder*
    - Unterschiedliche Parametertypen *oder*
    - Unterschiedliche Parameterarten #hinweis[(`ref/out`)].
    #v(-0.25em)
    Der _Rückgabetyp_ spielt bei der Unterscheidung keine Rolle.
  ],
  [
    ```cs
    void Test(int x, long y) { ... }
    void Test(long x, int y) { ... }
    int i; long l; short s;
    Test(i, l); Test(l, i); // klappen wie erwartet
    Test(i, s); Test(i, i); // Fehler: Mehrdeutig
    ```
  ],
)

#grid(
  [
    #v(0.5em)
    ==== Konflikte
    - _Rückgabetyp_ ist _kein_ Unterscheidungsmerkmal
    - _params-Array_ wird als _normales Array_ interpretiert
    - _Default-Parameter: kein_ Unterscheidungsmerkmal
    - Methoden _ohne optionale Parameter_ haben Vorrang
  ],
  [
    ```cs
    // Compilerfehler: Identisch trotz return type
    void Test() { ... } bool Test() { ... }
    // Compilerfehler: Identisch trotz params array
    int A(int[] x){...} int A(params int[] x){...}
    // A(3); nimmt Overload ohne optionale Params
    int A(int x){...} int A(int x, int y = 0){...}
    ```
  ]
)

== Properties
#grid(
  [
    Ersatz für Java-style _Getter-/Setter-Methoden_. Reines Compiler-Konstrukt, verhält sich wie "Public Field".

    *Nutzen:*
    - Benutzersicht/Implementation können unterschiedlich sein
    - Validierung beim Zugriff
    - Ersatz für "Public Fields" auf Interfaces
    - Über Reflection als Property identifizierbar

    *Regeln:*
    - Read- und/oder Write-Only möglich #hinweis[(nur `get` oder `set`)]
    - Schlüsselwort `value` für Zugriff auf Wert in Setter
    - Sichtbarkeiten können verändert werden\ #hinweis[(z.B. ```cs private set { _length = value }```)]
  ],
  [
    ```cs
    class MyClass {
      // Backing-Field, nur bei eigenem get/set nötig
      private int _length;
      // Property
      public int Length {
        // Standard-Implementation bei {get; set;}
        get { return _length; }
        set { _length = value; }
      }
    }
    // Verwendung
    MyClass mc = new();
    mc.Length = 12;
    int length = mc.Length;
    ```
  ],
)

=== Auto-implemented Properties
#grid(
  [
    Syntaktische Vereinfachung, Backing Field & Getter/Setter werden automatisch generiert.
    Bei Initialisierung direkt hinter Property darf der Setter weggelassen werden.
  ],
  [
    ```cs
    public int LengthAuto { get; set; }
    // nur zuweisbar hinter Property und im Konstruktor
    public int LengthInit { get; } = 5;
    ```
  ],
)

=== Objekt-Initialisierung
#grid(
  [
    Properties können direkt initialisiert werden.
  ],
  [
    ```cs MyClass mc = new() { Length = 1; Width = 2; }```
  ],
)

=== Init-only setters
#grid(
  [
    Property muss während Initialisierung gesetzt werden, danach readonly. Ebenfalls custom `init`-Logik möglich.
  ],
  [
    ```cs
    public int LengthInitOnly { get; init; }
    MyClass mc = new() { var LengthInitOnly = 1 };
    mc.LengthInitOnly = 2; // Compilerfehler
    ```
  ],
)

== Expression-Bodied Members
#grid(
  [
    Methoden #hinweis[(und Operatoren, Konstruktoren, Properties)] mit genau einem Statement.
    Wird mit #no-ligature[```cs =>```] hinter Methode gekennzeichnet #hinweis[(Klammern & `return` entfallen dadurch)].\
    Get/Set und reine Set-Properties brauchen einen Statement-Block #hinweis[(`{...}`)].
  ],
  [
    ```cs
    public MyClass(int v) => _value = v;
    int Sum(int x, int y) => x + y;
    void Print() => Console.WriteLine("Hoi!");
    int Four => Sum(2, 2);
    int x { get => _value; set => _value = value; }
    ```
  ]
)


== Konstruktoren
#grid(
  [
    Bei jedem Erzeugen einer Klasse / eines Structs verwendet #hinweis[(Aufruf von "`new()`")].
    Default-Konstruktor #hinweis[(ohne Parameter)] wird generiert, falls keiner definiert.
    _Private Konstruktoren_ können nur intern verwendet werden.
    Es wird _kein_ Default-Konstruktor erzeugt, wenn ein privater Konstruktor existiert.
  ],
  [
    ```cs
    class MyClass {
      private int _x, _y;
      public MyClass() : this(0, 0) { } // Default Ctor
      public MyClass(int x) : this(x, 0) { }
      public MyClass(int x, int y){_y = y; _x = x;}
    }
    ```
  ],
)

*Regeln*\
Konstruktoren können _überladen_ werden. Aufruf anderer Konstruktoren mittels ```cs this```
#hinweis[(damit Verkettung möglich, siehe Beispiel oben)], Aufruf auf Basis-Klassen-Konstruktor mittels ```cs base```.

#grid(
  [
    === Primary Constructors
    Vereinfachung / Verkürzung der Konstruktorlogik. Die Werte für die Konstruktoren werden der Klasse selbst
    als Parameter mitgegeben, der reguläre Konstruktor fällt weg.

    *Regeln:*
    - Klassenparameter #hinweis[(im Beispiel `x,y`)] sind innerhalb der ganzen Klasse verfügbar
    - Können zur Initialisierung verwendet werden
    - Können verändert werden, ist aber bad practice
  ],
  [
    ```cs
    class Point(int x, int y) {
      // Property Initialisierung
      public int X { get; } = x;
      public int Y { get; } = y;
      public void Print() {
        // Auch in Funktionen verwendbar
        Console.WriteLine($"Point: {x}/{y}");
      }
    }
    Point p = new(1, 2); // Anwendung
    ```
  ],
)

=== Default Constructor
Ein Default Constructor hat keine Parameter. Er hat in Klassen und Structs andere Eigenschaften.
#table(
  columns: (1fr, 1fr),
  table.header([Klasse], [Struct]),
  [
    - Parameterloser Konstruktor
    - _Nicht_ zwingend vorhanden
    - Automatisch generiert, wenn nicht vorhanden
    - _Nicht_ automatisch generiert, wenn anderer Konstruktor vorhanden
    - Initialisiert Felder mit "`default`" Wert
    - Konstruktor kann beliebig viele Felder initialisieren
  ],
  [
    - Parameterloser Konstruktor
    - _Immer_ vorhanden
    - Automatisch generiert, wenn nicht vorhanden
    - Automatisch generiert, wenn anderer Konstruktor vorhanden
    - Initialisiert Felder mit "default" Wert
    - Konstruktor muss _alle_ Felder initialisieren
    - "`default`" Literal verwendet diesen Default-Konstruktor
  ],
)

=== Statische Konstruktoren
#grid(
  [
    Werden für statische _Initialisierungsarbeiten_ verwendet. Identisch bei Klasse & Struct.
    
    *Regeln*\
    Zwingend Parameterlos, Sichtbarkeit darf nicht angegeben werden. Es ist nur _ein_ statischer Konstruktor erlaubt.
    Wird genau _einmal_ ausgeführt: Entweder bei erster Instanzierung des Typen oder bei erstem Zugriff auf
    statisches Member des Typen. Kann _nicht_ explizit aufgerufen werden.
  ],
  [
    ```cs
    class MyClass {
      static MyClass() {
        /* ... */
      }
    }
    struct MyStruct {
      static MyStruct() {
        /* ... */
      }
    }
    ```
  ],
)

#grid(
  [
    === Initialisierungsreihenfolge ohne Vererbung
    Statische Klassenvariablen $->$ Statische Konstruktoren\ $->$ normale Klassenvariablen $->$ normaler Konstruktor.

    Beim _zweiten Aufruf_ der Klasse wird der _statische Teil weggelassen_.
  ],
  [
    ```cs
    class Base { // Zahl = Aufruf-Reihenfolge
      private static int _baseStaticValue = 0; // 1.
      private int _baseValue = 0;              // 3.
      static Base() {}                         // 2.
      public Base() {}                         // 4.
    }
    ```
  ]
)
=== Initalisierungsreihenfolge mit Vererbung
#grid(
  [
    _Zuerst in Subklasse:_ Statische Klassenvariablen $->$ Statische Konstruktoren $->$ normale Klassenvariablen,
    dann Reihenfolge in _Basisklasse_ wie ohne Vererbung, zuletzt _normaler Konstruktor_ von _Subklasse_.

    Beim _zweiten Aufruf_ der Subklasse wird der _statische Teil_ in Sub und Base _weggelassen_.
  ],
  [
    ```cs
    class Sub : Base { // Sub-Aufruf / Base-Aufruf
      private static int _subStaticValue = 0; // 1. / 4.
      private int _subValue = 0;              // 3. / 6.
      static Sub() {}                         // 2. / 5.
      public Sub() {}                         // 8. / 7.
    }
    ```
  ]
)

=== Konstruktoren in Base- und Subklasse
#table(
  columns: (1fr,) * 4,
  table.header(table.cell(colspan: 3)[Impliziter Aufruf des Basisklassenkonstruktors], [Expliziter Aufruf]),
  [
    ```cs
    class Base {
    // Default Constructor
    }
    class Sub : Base {
      public Sub(int x) {}
    }
    ```
  ],
  [
    ```cs
    class Base {
      public Base() {}
    }
    class Sub : Base {
      public Sub(int x) {}
    }
    ```
  ],
  [
    ```cs
    class Base {
      public Base(int x) {}
    }
    class Sub : Base {
      public Sub(int x) {}
    }
    ```
  ],
  [
    ```cs
    class Base {
      public Base(int x) {}
    }
    class Sub : Base {
      public Sub(int x)
        : base(x) {}
    }
    ```
  ],
  table.cell(colspan: 4, align: center)[```cs Sub s = new Sub(1);```],
  [
    Konstruktoraufrufe OK
    - ```cs Base()```
    - ```cs Sub(int x)```
  ],
  [
    Konstruktoraufrufe OK
    - ```cs Base()```
    - ```cs Sub(int x)```
  ],
  [
    _Compilerfehler!_\
    Default-Konstruktor für `Base` nicht mehr automatisch erzeugt
  ],
  [
    Konstruktoraufrufe OK
    - ```cs Base(int x)```
    - ```cs Sub(int x)```
  ],
)

=== Destruktoren / Finalizer
#grid(
  [
    Finalizer ermöglichten _Abschlussarbeiten_ beim Abbau eines Objekts. Nur bei _Klassen_.
    Zwingend _parameterlos_ und ohne Visibility. Nur _1 Finalizer_ pro Klasse erlaubt.
    
     Wird nicht-deterministisch vom Garbage Collector aufgerufen,
    _kein expliziter Aufruf_ möglich. Danach Aufruf von Finalizer der Basisklasse.
    Vergleiche Kapitel @deterministic-finalization.
  ],
  [
    ```cs
    class MyClass {
      ~MyClass() {
        /* Freigabe von File-Handles,
        Netzwerk-Streams etc. */
      } }
    // ~ Operator (Finalizer) wird vom Compiler
    // in diesen Code umgewandelt
    override void Finalize() { try {/*Code in Finalizer*/} finally { base.Finalize(); } }
    ```
  ]
)

== Operatoren
#grid(
  [
    Bausteine für _Verknüpfung von Werten_ #hinweis[(Addition, Zuweisung, Methodenaufrufe, Type Casts, ...)]\
    *Speziell:*
    - Logische Operatoren #hinweis[(`||`, `&&`, `!`)] sind _short-circuit_, d.h. wenn die linke Kondition
      für das Endresultat genügt, wird die rechte nicht mehr evaluiert.
    - Bit-Operatoren #hinweis[(`&`, `|`, `~`)] verarbeiten Ganzzahlen, Chars, Enums & Bools auf Bitebene.
    - Expliziter _Overflow-Check_ mit ```cs checked(x * x)```.
    - ```cs typeof(int)``` liefert Typ von Klasse/Element für Vergleiche
    - ```cs sizeof(int)``` liefert Datengrösse von Value Types in Bytes.
  ],
  [
    #no-ligature[
      *Unäre:* #small[```cs +x```, ```cs -x```, ```cs ~x```, ```cs !x```, ```cs x++```, ```cs x--```, ```cs ++x```, ```cs --x```, ```cs true```, ```cs false```]\
      *Binäre:* #small[```cs x + y```, ```cs x - y```, ```cs x * y```, ```cs x / y```, ```cs x % y```, ```cs x & y```, ```cs x | y```, ```cs x ^ y```,\ ```cs x << y```,
        ```cs x >> y```, ```cs x == y```, ```cs  x != y```, ```cs x < y```, ```cs x > y```, ```cs x <= y```, ```cs x >= y```]
      *Conditional:* #small[```cs x && y```, ```cs x || y```]\
      *Index:* #small[```cs a[i]```, ```cs a?[i]```]\
      *Type Cast:* #small[```cs (T)x```]\
      *Kombinierte Zuweisung:* #small[```cs +=```, ```cs -=```, ```cs *=```, ```cs /=```, ```cs %=```, ```cs &=```, ```cs |=```, ```cs ^=```, ```cs <<=```, ```cs >>=```]
      *Diverse:* #small[```cs ^x```, ```cs x = y```, ```cs x.y```, ```cs x?.y```, ```cs c ? t : f```, ```cs x ?? y```, ```cs x ??= y```, ```cs x..y```, ```cs =>```,
        ```cs f(x)```, ```cs as```, ```cs await```, ```cs checked```, ```cs unchecked```, ```cs default```, ```cs delegate```, ```cs is```, ```cs name```,
        ```cs nameof```, ```cs new```, ```cs sizeof```, ```cs stackalloc```, ```cs switch```, ```cs typeof```]
    ]
  ]
)

=== Operator Overloading
#grid(
  [
    Die _Funktionsweise von einem Operator_ kann für eine Klasse _definiert/geändert_ werden, indem er overloaded wird.
    Somit können Funktionen wie das Vergleichen oder das "Addieren" von zwei Objekten einer Klasse realisiert werden.

    Ein Operator kann "alles" machen, man sollte sie aber nur dann implementieren, wenn Resultat eines Operators
    für den Anwender "natürlich" wirkt.
    #quote(block: false)[When in doubt, do as the `int`s do]
  ],
  [
    ```cs
    class Point {
      private int _x, _y;
      public Point(int y, int y)
        { _x = x; _y = y; }
      // returns negated points
      public static Point operator ~(Point a)
        => new(a._x * -1, a._y * -1);
      // adds a points with another point
      public static Point operator +(Point a, Point b)
        => new(a._x + b._x, a._y + b._y); }
    ```
  ],
)

*Regeln*\
Methode muss `static` sein, Schlüsselwort `operator` gefolgt von z.B. `+`, Unäre Operatoren haben 1 Parameter, Binäre 2 Parameter,
Rückgabetyp ist frei wählbar, mindestens 1 Parameter muss vom Typ der enthaltenden Klasse sein,
müssen teilweise als Paar überladen werden #hinweis[(`== !=`, `< >`, `<= >=`, `true false`)].
Es können nur Unäre und Binäre Operatoren überladen werden, Index- und Type Cast-Operator verfügen aber über Alternativen
#hinweis[(Indexer, user-defined conversion operators)].

== Indexer
#grid(
  [
    Für eine Klasse können _Aufrufe über einen Index_ definiert werden. Da der Index-Operator "`[]`" nicht überladen werden kann,
    gibt es Indexer. Die Klasse verhält sich dann wie ein Array.

    Der Typ des Indexers kann frei bestimmt werden. Häufige Beispiele sind für `int` #hinweis[(Array-like)],
    `string` #hinweis[(Dictionary-like)] oder\ 2-Dimensionale Indexer #hinweis[(Mehrdimensionale Arrays)]

    *Regeln:* `get` und `set` möglich, `this` definiert Indexer, `value` für Wert im Setter, Overloading möglich.
  ],
  [
    ```cs
    class SimpleDictionary {
      private string[] _arr = new string[10];
      public int this[string search] {
        get {
          for (int i = 0; i < _arr.Length; i++) {
            if (_arr[i] == search) return i;
          }
          return -1;
        } }
      // 2-Dimensionaler Indexer, hier so wenig sinnvoll
      public string this[int i1, int i2] { ... } }
    string location = words["Hello There"];
    ```
  ]
)

== Partielle Klassen & Methoden
#v(-0.5em)
=== Partielle Klassen
#grid(
  [
    Definition eines Typen über mehrere Dateien. Member können ganz normal aufgerufen werden.
    Funktioniert mit Klassen, Structs und Interfaces.

    _Verwendung:_ Aufsplitten grosser Dateien, Trennen von (teilweise) Generator-erzeugtem Code
  ],
  [
    ```cs
    // File1.cs
    partial class MyClass
      { public void Test1() {} }
    // File2.cs
    partial class MyClass
      { public void Test2() {} }
    ```
  ]
)

*Regeln*\
`partial` muss bei allen Definitionen der Klasse angemerkt sein. Alle Definitionen müssen dieselbe Visibility haben,
Class Modifier müssen überall angegeben werden #hinweis[(Basisklasse, implementierte Interfaces, `sealed` etc.)],
alle Teile müssen zusammen die Voraussetzungen der implementierten Interfaces erfüllen.

=== Partielle Methoden
#grid(
  [
    Trennung von Deklaration und Implementation einer Methode. Ermöglicht _"Hooks"_ in Code
    #hinweis[(vgl. Event-Registrierung in JavaScript)]. Funktioniert in `partial` Klassen & Structs.
    _Kann, muss aber nicht implementiert sein._ Wenn implementiert, wird Methode normal aufgerufen.
    Wenn nicht, wird der Methodenaufruf einfach ignoriert.

    *Regeln:* Immer `void` und `private`, kann `static` sein.
  ],
  [
    ```cs
    partial class NiceGUI { // File1.cs
      public void MainWindow() {
        OnClick(); // ausgeführt, wenn implement.
      }
      partial void OnClick();
      partial void OnHover();
    }
    partial class NiceGUI { // File2.cs
      partial void OnClick() { ... }
    }
    ```
  ]
)


= Vererbung & Deterministic Finalization
== Vererbung und Type Checks
Konstruktoren werden nicht vererbt. Nur eine Basisklasse, aber beliebig viele Interfaces erlaubt.
Structs haben nur Vererbung via Interfaces. Klassen sind (in)direkt von `System.Object` abgeleitet und
können mit dieser Klasse Boxing/Unboxing betreiben.

=== Zuweisungen
#grid(
  [
    - _Statischer Typ:_ Typ der Variable
    - _Dynamischer Typ:_ Referenziertes Heap-Objekt

    *Regeln:*\
    - Eine Zuweisung ist _immer möglich, wenn_\ Statischer Typ `==` Dynamischer Typ oder
      Statischer Typ eine Basisklasse von Dynamischer Typ ist.
    - Zuweisung _verboten, wenn_ Statischer Typ Subklasse von Dynamischer Typ oder
      nicht in derselben Vererbungshierarchie wie Dynamischer Typ ist.
  ],
  [
    ```cs
    class Base {}
    class Sub : Base {}
    class SubSub : Sub {}

    public static void Test() {
      Base b = new Base(); // DynType == StaticType
      b = new Sub();       // Dyn Type: Sub
      b = new SubSub();    // Dyn Type: SubSub
      Sub s = new Base();  // Compilerfehler
    }
    ```
  ]
)

=== Type Check: ```cs obj is T```
#grid(
  [
    Prüft, ob Objekt mit einem Typen _kompatibel_ ist.\
    ```cs true```, wenn Objekt identisch wie `T` oder Subklasse davon.
    ```cs false```, wenn Objekt Basisklasse von `T`, nicht in derselben Vererbungshierarchie wie `T` oder `null` ist.
  ],
  [
    ```cs
    SubSub a = new SubSub();
    if (a is SubSub) {...} // true
    if (a is Sub) {...}    // true
    if (a is Base) {...}   // true
    a = null; if (a is SubSub) {...} // false
    ```
  ]
)

=== Type Casts: ```cs (T)obj```
#grid(
  [
    Explizite Typumwandlung. `null` kann auch gecastet werden. Compilerfehler, wenn Type Cast nicht zulässig oder
    `null` in einen Value Type gecastet wird. `InvalidCastException` bei Laufzeit-Fehler.
  ],
  [
    ```cs
    Base b = new SubSub();  Sub s = (Sub)b;
    SubSub ss1 = (SubSub)b; SubSub ss2 = (SubSub)null;
    int i = (int)null; // Compilerfehler
    string str = (string)s // Compilerfehler
    object o = "Hi"; b = (Base)o; //InvalidCastException
    ```
  ]
)
=== Type Casts mit `as` Operator
#grid(
  [
    _Syntactic Sugar für Casting_, macht `null`-Check vor Cast:\
    ```cs obj is T ? (T)obj : (T)null```

    Anstatt Laufzeitfehler hat man bei ungültigen Casts `null`.
  ],
  [
    ```cs
    Base b = new SubSub(); Sub s = b as Sub;
    int i = null as int; // Compilerfehler
    string str = s as string // Compilerfehler
    object o = "Hi"; b = o as Base; // o = null
    ```
  ]
)

=== Type Check mit Type Cast: ```cs obj is T result```
#grid(
  [
    _Syntactic Sugar für Type Check_, returnt der `is`-Type Check `true`, wird das Objekt in die `result`-Variable gecasted.
    Arbeitet nicht mit nullable Types, im Gegensatz zu `as`.\ Da das ganze Konstrukt `bool` returnt, kann es z.B.
    in `if`-Statements verwendet werden.
  ],
  [
    ```cs
    Base a = new SubSub()
    if (a is SubSub casted) {
      Console.WriteLine(casted);
    }
    ```
  ]
)

== Vererbung in Methoden
#v(-0.5em)
=== Methoden überschreiben
#grid(
  [
    Subklasse kann Member #hinweis[(Methoden, Properties, Indexer)] der Basisklasse überschreiben.\
    - _`virtual`:_ In Basisklasse, um Methode überschreibbar zu machen
    - _`override`:_ In Subklasse um Basismethode zu überschreiben
  ],
  [
    ```cs
    class Base {
      public virtual void G() { ... } }
    class Sub : Base {
      public override void G() { ... } }
    class SubSub : Sub {
      public override void G() { ... } }
    ```
  ]
)
==== Regeln
- Members sind _per Default weder `virtual` noch `override`_, auch dann nicht, wenn Basis-Member `virtual` ist.
- _Identische Signatur_ #hinweis[(Gleiche Anzahl Parameter, gleiche Parametertypen und -arten (`ref`/`out`),
  gleiche Sichtbarkeit und gleicher Return Type)]
- `virtual` verboten mit: `static`, `abstract` #hinweis[(impliziert `virtual`)], `private` #hinweis[(unsichtbar für Subklasse)],
  `override` #hinweis[(implizit `virtual`)]

== Dynamic Binding
#grid(
  [
    Methode des _dynamischen Typs_ wird aufgerufen.\
    Falls dynamischer Typ #hinweis[(`SubSub`)] konkreter als statischer Typ #hinweis[(`Base`)] und Funktion
    #hinweis[(```cs G()```)] als `virtual` markiert, wird von oben nach unten in der Hierarchie nach
    konkretester Methode ```cs G()``` mit `override` gesucht.
  ],
  [
    ```cs
    Base b = new SubSub();
    b.G(); // SubSub.G()
    Sub s = new SubSub();
    s.G(); // SubSub.G();
    ```
  ]
)

=== Methoden überdecken
#grid(
  [
    _Unterbricht Dynamic Binding!_ Durch Weglassen von `override` kann eine Subklasse Member der Basisklasse überdecken.
    Kann durch bewusstes Übersteuern des Basismembers oder durch versehentliche Wahl derselben Signatur passieren.\

    Compilerwarnung bei Aufruf von ```cs SubSub.G()```:
    ```
    'SubSub.H()' hides inherited member 'Sub.H()'.
    To make the current member override that
    implementation, add the override keyword.
    Otherwise add the new keyword.
    ```
  ],
  [
    ```cs
    class Base {
      public virtual void G() { ... }
    }
    class Sub : Base {
      public override void G() { ... }
    }
    class SubSub : Sub {
      public void G() { ... } // kein Override!
    }
    ```
  ]
)

#pagebreak()

=== Methoden überdecken mit `new`
#grid(
  [
    Obige Compilerwarnung kann mit `new` vermieden werden. Sagt Compiler, dass Member bewusst überdeckt wurde.
    Kann nicht zusammen mit `override` verwendet werden, mit `virtual` aber schon.\
    Compilerwarnung bei ```cs SubSub.G2()```: `new` soll nicht verwendet werden, wenn es keinen Member überdeckt.
  ],
  [
    ```cs
    class Base {
      public virtual void G() { ... } }
    class Sub : Base {
      public override void G() { ... } }
    class SubSub : Sub {
      public new void G() {...} // bewusst überdeckt
      public new void G2() { ... } } // Compilerwarnung
    ```
  ]
)

=== Komplexes Beispiel
#grid(
  gutter: 0.3em,
  [
    *`J()`*
    #v(-0.5em)
    ```cs
    Base b1 = new SubSub();    b1.J();  // Base.J()
    Sub s1 = new SubSub();     s1.J();  // Sub.J()
    SubSub ss1 = new SubSub(); ss1.J(); // SubSub.J()
    Base b2 = new Sub();       b2.J();  // Base.J()
    Sub s = new SubSub();      s.J();   // Sub.J()
    ```
    *`K()`*
    #v(-0.5em)
    ```cs
    Base b1 = new SubSub();    b1.K();  // Sub.K()
    Sub s1 = new SubSub();     s1.K();  // Sub.K()
    SubSub ss1 = new SubSub(); ss1.K(); // SubSub.K()
    Base b2 = new Sub();       b2.K();  // Sub.K()
    Sub s = new SubSub();      s.K();   // Sub.K()
    ```
    *`L()`*
    #v(-0.5em)
    ```cs
    Base b1 = new SubSub();    b1.L();  // Base.L()
    Sub s1 = new SubSub();     s1.L();  // SubSub.L()
    SubSub ss1 = new SubSub(); ss1.L(); // SubSub.L()
    Base b2 = new Sub();       b2.L();  // Base.L()
    Sub s = new SubSub();      s.L();   // SubSub.L()
    ```
  ],
  [
    ```cs
    class Base {
      public virtual void J() { ... }
      public virtual void K() { ... }
      public virtual void L() { ... }
    }
    class Sub : Base {
      public new void J() { ... }
      public override void K() { ... }
      public new virtual void L() { ... }
    }
    class SubSub : Sub {
      public new void J() { ... }
      public new void K() { ... }
      public override void L() { ... }
    }
    ```
    #v(-0.5em)
    *Eselsbrücke:*\
    _`virtual`:_ Kette starten, _`override`:_ Kette fortführen,\ _`new`:_ Kette beenden, _`new virtual`:_ Neue Kette starten
  ]
)

== Abstrakte Klassen
#grid(
  [
    _Mischung aus Klasse und Interface, muss überschrieben werden._ Im Gegensatz zu `virtual` ist aber keine
    Implementation in der Basisklasse möglich. Mit `abstract` deklariert. Für alle Klassenmember-Arten möglich

    *Regeln:* Keine direkte Instanzierung, beliebig viele Interfaces implementierbar, von abstrakten Klassen 
    abgeleitete Klassen _müssen_ alle abstrakten Member implementieren, abstrakte Member nur innerhalb abstrakter Klassen,
    Klasse darf nicht `sealed` sein, Methoden nicht `static` oder `virtual` #hinweis[(Methoden sind selbst implizit `virtual`)].
  ],
  [
    ```cs
    abstract class Sequence {
      public abstract void Add(int i);
      public abstract string Name { get; }
      public abstract object this[int i] { get; set; }
      public override string ToString() { return name; }
    }

    class List : Sequence {
      public override void Add(int x) { ... }
      public override string Name { get { ... } }
      public override object this[int i] { ... }
    /* ToString muss nicht implementiert werden */ }
    ```
  ]
)

== Interfaces
#grid(
  [
    _Ähnlich wie abstrakte Klasse._ Darf keine Sichtbarkeit vorgeben, kann andere Interfaces erweitern.
    Keine Instanzierung. Member sind implizit `abstract virtual` und dürfen nicht `static` sein. Name beginnt mit `I`.

    *Implementation:* Klassen dürfen beliebig viele Interfaces implementieren #hinweis[(```cs class A : I1, I2 { ... }```)].
    Alle Interface-Member #hinweis[(direkt oder von Basisklasse geerbt)] müssen in Klasse vorhanden und `public` sein,
    `static` Member verboten. `override` nicht nötig, ausser Basisklasse definiert gleichen Member.
    Kombination mit `abstract` & `virtual` erlaubt.
  ],
  [
    ```cs
    interface ISequence {
      void Add(object x);
      string Name { get; }
      object this[int i] { get; set; }
      event EventHandler OnAdd;
    }
    class List : ISequence {
      public void Add(object x) { ... }
      public string Name { get { ... } }
      public object this[int i] { get {...} set {...} }
      public event EventHandler OnAdd;
    }
    ```
  ]
)

=== Verwendung
#grid(
  [
    Klassen mit implementiertem Interface können wie bei normaler Basisklasse zugewiesen, umgewandelt und
    auf Vererbung geprüft werden.
  ],
  [
    ```cs
    List list1 = new List(); list1.Add("Nina");
    ISequence list2 = new List(); list2.Add("Jannis");
    list1 = (List)list2;
    list1 = list2 as List;
    list2 = list1;
    if (list1 is ISequence) { ... }
    ```
  ],
)

#pagebreak()

=== Naming Clashes in Interfaces
Mehrere Interfaces können gleiche Member definieren, was zu Kollisionen führt.\
*Szenarien:*
+ Beide ```cs Add()``` haben _dieselbe Funktionalität_. Logik für beide lässt sich in einer Methode abbilden \
  _$->$ Methode regulär implementieren_
+ Beide ```cs Add()``` haben eine _andere Funktionalität_. Logik ist für beide unterschiedlich \
  _$->$ Methoden explizit implementieren_
+ Wie 2., es gibt aber ein _"Default-Verhalten"_. Identische Signatur, aber unterschiedliche Logik.
  Eine Methode soll als Standard aufgerufen werden.\
  _$->$ Methoden regulär & explizit implementieren_
+ Beide ```cs Add()``` haben einen _anderen Rückgabewert_ und es gibt ein "Default-Verhalten".\
  _$->$ Methoden regulär & explizit implementieren_

#grid(
  columns: (1.4fr, 1fr),
  [
    ```cs
    interface ISequence { void Add(object x); }
    interface IShoppingCart {
      void Add(object x);
      int Add(object x);
    }

    class ShoppingCart : ISequence, IShoppingCart {
      // Welches Add() wird aufgerufen?

      // Szenario 1: Gleiche Funktionalität
      public void Add(object x) { ... }

      // Szenario 2: Andere Funktionalität
      void ISequence.Add(object x) { ... }
      void IShoppingCart.Add(object x) { ... }

      // Szenario 3: wie 2. mit Default-Verhalten
      public void Add(object x) { ... } // Eigene Methode
      // void ISequence.Add() existiert nicht
      void IShoppingCart.Add() { ... } // Interface-Methode

      // Szenario 4: Andere Rückgabetypen
      public void Add(object x) {...}
      void ISequence.Add(object x) { ... }
      int IShoppingCart.Add(object x) { ... }
    }
    ```
  ],
  [
    *Anwendung*
    #v(-0.5em)
    ```cs
    ShoppingCart sc = new ShoppingCart();
    ISequence isq = new ShoppingCart();
    IShoppingCart isc = new ShoppingCart();

    // Szenario 1
    sc.Add("Hello");  // ShoppingCart.Add
    isq.Add("Hello"); // ShoppingCart.Add
    isc.Add("Hello"); // ShoppingCart.Add

    // Szenario 2
    sc.Add("Hello");  // Compilerfehler
    isq.Add("Hello"); // ISequence.Add
    isc.Add("Hello"); // IShoppingCart.Add

    // Szenario 3
    sc.Add("Hello");  // ShoppingCart.Add
    isq.Add("Hello"); // ShoppingCart.Add
    isc.Add("Hello"); // IShoppingCart.Add
    ((IShoppingCart)sc).Add("Hello");
    //IShoppingCart.Add

    // Szenario 4
    sc.Add("Hello");  // ShoppingCart.Add
    isq.Add("Hello"); // ISequence.Add
    isc.Add("Hello"); // IShoppingCart.Add
    ```
  ],
)


=== Default Interface Methods
#grid(
  [
    _Formulieren von Logik auf Interfaces._ Führen "quasi-Mehrfachvererbung" ein.
    Zusätzlich zu normalen Interface-Membern auch für Operatoren möglich.\
    *Motivation*\
    _Interface wird mehrfach implementiert,_ damit muss Logik basierend auf Interface ausgelagert/kopiert werden.\
    Im Beispiel müsste ohne Default Interface Methods `FullName` und `Print()` in `Person1` und `Person2` implementiert werden
    _$->$ Duplizierter Code_\
    *Regeln*\
    Hat Zugriff auf alle (vererbten) Member, `virtual` / `static` möglich, Anwender muss Variable in Interface casten.

  ],
  [
    ```cs
    interface IPerson {
      string FirstName { get; }
      string LastName { get; }
      string FullName => $"{FirstName} {LastName}";
      void Print() => Console.WriteLine(FullName);
    }
    public class Person1 : IPerson {
      public string FirstName { get; }
      public string LastName { get; }
      // Implementation von FullName und Print entfällt
    }
    public class Person2 : IPerson { ... }
    // Anwendung
    Person p1 = new(); p1.Print(); // Compilerfehler
    IPerson p2 = p1;   p2.Print(); // Funktioniert
    ```
  ]
)

== Sealed Klassen
#grid(
  [
    Verhindert das Ableiten von Klassen, wie `final` in Java.\
    *Einsatzzweck:* Verhindert versehentliches Erweitern, Methoden können statisch gebunden werden $->$ Performancegewinn.
  ],
  [
    ```cs
    sealed class Sequence {
      // ...
    }
    class List : Sequence { ... } // Compilerfehler
    ```
  ]
)
#pagebreak()
#grid(
  [
    === Sealed Member
    Verhindert das _weitere Überschreiben_ eines bestimmten überschreibbaren Members.
    Muss in Verbindung mit `override` angewendet werden.
    Kombination auf einem `sealed` Member mit `new` / `virtual` ist nicht erlaubt.

    Erbt eine Klasse einen `sealed` Member, ist jedoch Überdecken mit `new` als auch `virtual` wieder erlaubt.
  ],
  [
    ```cs
    abstract class Sequence {
      public virtual void Add(object x) {}
      public sealed void X() } // Compilerfehler
    class List : Sequence {
      public override sealed void Add(object x){} }
    class MyList : Sequence {
      public override void Add(object x) {} // Error
      public new virtual void Add(object x) {} // OK
    }
    ```
  ]
)

== Deterministic Finalization: Dispose() <deterministic-finalization>
#grid(
  [
    Beim Entfernen eines Objekt vom Heap sollen deren _unmananged Ressourcen_
    #hinweis[(nicht von .NET Runtime verwaltet, z.B. File Handles, DB-Verbindungen etc.)] _manuell freigegeben_ werden,
    es muss also nicht wie beim Finalizer das ganze Objekt gelöscht werden.
    Dafür kann das _Interface `IDisposable` implementiert_ werden. In der ```cs Dispose()```-Methode können diese
    spezifiziert werden #hinweis[(z.B. offene File Handles/Verbindungen schliessen)].
    In der Standard-Variante muss aber ```cs Dispose()``` jedes Mal manuell aufgerufen werden und es gibt kein Exception Handling.\
    $->$ Fehleranfällig!
  ],
  [
    ```cs
    public class DataAccess : IDisposable {
      private DBConnection _con;
      public DBAccess()
        { _conn = new SqlConnection(); }
      // Finalizer, aufräumen beim Löschen durch GC
      ~DataAccess() => _con?.Dispose();
      public void Dispose() { // Manuelles Löschen
        _con?.Dispose();
        // GC muss Finalizer nicht erneut aufrufen
        GC.SuppressFinalize(this);
      } }
    // Verwendung, bad practice, besser mit `using`
    var da = new DataAccess(); ...; da.Dispose();
    ```
  ]
)

=== Was sollte ein Dispose erledigen?
#grid(
  [
    - Aufräumen von Unmanaged Ressourcen
    - Fehlerfreie Ausführung #hinweis[(keine Exceptions)]
    - Sicherstellung einmalige Ausführung
    - Sicherstellung vollständiger Cleanup
  ],
  [
    - Aufräumen von Managed Ressourcen
    - Vererbung, Ressourcen in Basisklassen
    - Synchrone/Asynchrone Ausführung
    - Unterscheidung Finalizer vs. Deterministic Finalization
  ]
)

=== `using`-Statement
#grid(
  [
    Syntactic Sugar für Finalization, stellt _Aufruf von ```cs Dispose()``` sicher_. Kann mehrere Ressourcen gleichzeitig disposen.
    Kann als Scope-Block oder als einzelne Ressource definiert werden, welche bis Methodenende gültig ist.
    Auch als `async`-Variante möglich.
  ],
  [
    ```cs
    using DataAccess da1 = new(); // einzelne Resource
    using (DataAccess da2 = new()) { // Scope-Block
      da1.Fetch(); da2.Fetch();
    } // `da2` hier disposed
    da1.Fetch();// Methodenende, `da1` danach disposed
    ```
  ]
)

=== Dispose Pattern
#grid(
  columns: (0.8fr, 1fr),
  [
    Aus Performancegründen sollte unterschieden werden, ob ein ```cs Dispose()``` aus einem Finalizer
    #hinweis[(also vom Garbage Collector)] oder von einem manuellen ```cs Dispose()```-Aufruf stammt.\
    Der Code rechts erweitert die oben definierte Klasse `DataAccess` um ein einfaches Beispiel eines Dispose-Patterns:
    Wird manuell disposed, macht der GC dies nicht nocheinmal. Mehrmaliges manuelles Disposen wird ebenfalls verhindert.
    Die neue ```cs Dispose(bool)```-Methode kann von Subklassen überschrieben werden.
  ],
  [
    ```cs
    private bool _disposed; // Dispose() bereits gecallt?
    ~DataAccess() => Dispose(false); // Finalizer-Aufruf
    public void Dispose() { // Manueller Dispose-Aufruf
      Dispose(true);
      GC.SuppressFinalize(this); //Finalizer nicht mehr nötig
    }
    protected virtual void Dispose(bool disposing) {
      if (_disposed) { return; } // bereits Disposed
      // GC disposed `_con` selber, nur bei manuellem nötig
      if (disposing) { _con?.Dispose(); }
      _disposed = true;
    }
    ```

  ],
)


#table(
  columns: (1fr, 1fr),
  table.header([Destructor & Finalizer], [Deterministic Finalization]),
  [
    #grid(
      columns: (1.2fr, 1fr),
      gutter: 0em,
      [
        Kann nur bei Entfernen eines Objekts vom Garbage Collector aufgerufen werden. Nur für unmanaged Ressourcen.
        GC entfernt Ressourcen in zufälliger Reihenfolge, Abhängigkeiten werden nicht berücksichtigt.
      ],
      image("img/dotnet_08.png"),
    )
  ],
  [
    #grid(
      columns: (1.1fr, 1fr),
      gutter: 0em,
      [
        Kann manuell auch vor Entfernen eines Objekts aufgerufen werden. Auch geeignet für Managed Ressourcen.
        Jede Methode räumt ihre Ressourcen in festgelegter Reihenfolge auf.
      ],
      image("img/dotnet_09.png"),
    )
  ],
)

= Delegates & Events
== Delegates
#grid(
  [
    Ein Delegate ist ein Typ, welcher _Referenzen auf $0$ bis $n$ Methoden_ enthält. Die Typsicherheit wird vom Compiler garantiert.
    _Vereinfacht gesagt ist ein Delegate ein Interface mit einer Methode, ohne das Interface aussen herum._
    Delagates werden auf Namespace-Ebene definiert #hinweis[(ausserhalb von Klassen/Interfaces)].
    Sie verwenden intern eine Linked List, um die Referenzen zu speichern.\
    *Verwendung:* _Methoden als Parameter übergeben_, Definition von Callback-Methoden.

    Einer _Delegate-Variable_ kann _jede Methode mit passender Signatur_ zugewiesen werden. Zuweisung von `null` ist erlaubt.
    Der Aufruf der Funktion passiert direkt über die Delegate-Variable. Exception, wenn diese `null` ist.
  ],
  [
    ```cs
    // Definition des Delegates
    public delegate void Notifier(string sender);

    class DelegateExample {
      public static void Main() {
        Notifier greeter; //Deklaration Delegate-Variab.
        // Zuweisen einer Methode
        greeter = new Notifier(SayHi);
        greeter = SayHi; // Kurzform
        greeter("Nina"); // Aufruf von SayHi()
      }
      private static void SayHi(string sender){
        Console.WriteLine($"Hi {sender}");
      } }
    // Der Notifier als Interface sähe so aus:
    public interface INotifier
      { void Notifier(string sender); }
    List<INotifier> greeter; // Liste der Funktionen
    ```
  ]
)

#table(
  columns: (1fr, 1fr),
  table.header([Delegate mit statischer Funktion], [Delegate mit Instanzfunktion]),
  image("img/dotnet_10.png"), image("img/dotnet_11.png"),
)

*Delegate-Zuweisung:*
```cs DelegateType delegateVar = obj.Method```\
Speichert Methode #hinweis[(`Method`)] und Empfängerobjekt #hinweis[(`obj`, oft implizit durch `this`)].

Eine `Method`, welche einem Delegate zugwiesen wird...
- muss von der Signatur mit `DelegateType` übereinstimmen
- kann `static` sein #hinweis[(dann mit Klassenname anstatt `obj`)],
- darf weder `abstract`, `virtual`, `override` noch `new` sein

*Delegate-Aufruf:*
```cs object result = delegateVar[.Invoke](params)``` \
Kann entweder direkt oder über `.Invoke()` ausgeführt werden. Parameter können wie gewohnt übergeben werden,
genau wie die Handhabung des Rückgabewerts. `delegateVar` sollte vor dem Aufruf auf `null` geprüft werden:
```cs delegateVar?.Invoke(params);```

== Multicast Delegates <multicast-delegates>
#grid(
  [
    Multicast Delegates können _mehrere Methoden_ gleichzeitig referenzieren. Jeder Delegate ist bereits ein Multicast Delegate.
    Mit `+=` können einer Delegate-Variable Methoden hinzugefügt, mit `-=` wieder entfernt werden.

    Wird eine _Delegate-Variable aufgerufen_, werden die Methoden in _Hinzufügungsreihenfolge_ ausgeführt.
    Beim _Entfernen_ wird die zuletzt hinzugefügte Instanz dieser Methode entfernt.
    Der Rückgabewert eines Multicast Delegates entspricht dem letzten Funktionsaufruf
    #hinweis[(Gilt auch für `out`/`ref` Parameter)].

    Delegates können mit dem `+` Operator auch _kombiniert_ werden.
  ],
  [
    ```cs
    public static void Main() {
      Notifier greeter;
      greeter = SayHi;
      greeter += SayCiao; greeter += SayHi;
      greeter -= SayHi; // entfernt hinterstes SayHi()
      greeter("Nina"); // SayHi(), dann SayCiao()
      Notifier a = SayHi; Notifier b = SayCiao;
      Notifier ab = a + b;
    }
    private static void SayHi(string sender) {
      Console.WriteLine($"Hi {sender}");
    }
    private static void SayCiao(string sender) {
      Console.WriteLine($"Bye {sender}");
    }
    ```
  ]
)

=== Beispiel: Funktionsparameter <funktionsparams-delegates>
#grid(
  [
    Methode für das Ausführen einer beliebigen Funktion auf jedem Element eines Arrays.
    Es wird eine Funktion `ForAll()` mit einem `int`-Array und einem Delegate `Action` als Parameter erstellt.
    In `MyClass` befinden sich Funktionen, welche als Delegate `ForAll()` übergeben werden können.

    *Test-Code*
    #v(-0.5em)
    ```cs
    int[] array = { 1, 5, 8, 14, 22 };
    Action v1 = MyClass.PrintValues;
    ForAll(array, v1);
    MyClass c = new();
    Action v2 = c.SumValues;
    ForAll(array, v2); Console.WriteLine(c.Sum);
    ```
  ],
  [
    ```cs
    public delegate void Action(int i);
    public class MyClass {
      public static void PrintValues(int i)
       { Console.WriteLine($"Value {i}"); }
      public void SumValues(int i) { Sum += i; }
      public int Sum { get; private set; }
    }
    public class FunctionParameter {
      static void ForAll(int[] arr, Action action) {
        Console.WriteLine("ForAll called");
        if (action == null) { return; }
        foreach (int t in arr) {
          action(t);
    } } }
    ```
  ]
)

=== Beispiel: Callback mit Delegates
#grid(
  columns: (0.8fr, 1fr),
  [
    Tickende Uhr mit _dynamisch wählbarem Intervall_. Bei _jedem Tick_ wird eine Benachrichtigung ausgegeben
    und _Instanzen_ #hinweis[(hier `ClockObserver`)] können sich _registrieren_, um eine Funktion jeden Tick laufen zu lassen.
    Diese _Subscriber_ werden im `EventTickHandler` registriert und bei jedem Tick werden alle Funktionen in
    diesem _Delegate_ aufgeführt #hinweis[(Code in `Tick()`)].
    Im Beispiel unten registrieren wir die Funktion `OnTickEvent` des `ClockObserver`, welche alle 1'000 bzw. 300ms aufgerufen wird.\
    *Aufruf der Uhr*
    #v(-0.6em)
    ```cs
    public static void Test() {
      Clock c1 = new Clock(1000);
      Clock c2 = new Clock(300);
      ClockObserver t1 = new("Observer 1");
      ClockObserver t2 = new("Observer 2");
      c1.add_OnTickEvent(t1.OnTickEvent);
      c2.add_OnTickEvent(t2.OnTickEvent);
      // Do Stuff here...
      c1.remove_OnTickEvent(t1.OnTickEvent);
      c2.remove_OnTickEvent(t2.OnTickEvent);
    }
    ```
  ],
  [
    ```cs
    public delegate void TickEventHandler
      (int ticks, int interval);

    public class Clock(int interval) {
      private int _interval = interval; // Anzahl Aufrufe
      private int _ticks; // Anzahl vergangene Ticks
      private TickEventHandler OnTickEvent;
      public void add_OnTickEvent(TickEventHandler h)
       { OnTickEvent += h; }
      public void remove_OnTickEvent(TickEventHandler h)
       { OnTickEvent -= h; }
      private void Tick(object sender, EventArgs e) {
        _ticks++;
        onTickEvent?.Invoke(ticks, interval);
      }
    }

    public class ClockObserver(string name) {
      private string _name = name;
      public void OnTickEvent(int ticks, int i) {
        Console.WriteLine($"Observer {_name}: Clock mit Interval {ticks} hat zum {i}. Mal getickt.");
      }
    }
    ```
  ],
)

== Events
#grid(
  [
    Events sind _Syntactic Sugar für Delegates_. Das Event generiert innerhalb der Klasse einen `private` Delegate
    und `private` Subscribe/Unsubscribe-Logik. Auf diese kann von aussen über `+=`/`-=` zugegriffen werden.\
    Angewendet auf das zweite Delegate-Beispiel sieht der Code so aus:\
    *Angepasster Aufruf der Uhr*
    #v(-0.6em)
    ```cs
      c1.OnTickEvent += t1.OnTickEvent;
      c2.OnTickEvent += t2.OnTickEvent;
      // Do Stuff here...
      c1.OnTickEvent -= t1.OnTickEvent;
      c2.OnTickEvent -= t2.OnTickEvent;
    ```
  ],
  [
    ```cs
    public delegate void TickEventHandler
      (int ticks, int interval);

    public class Clock(int interval) {
      private int _interval = interval; // Anz. Aufrufe
      private int _ticks; // Anzahl vergangene Ticks
      private event TickEventHandler OnTickEvent;
      private void Tick(object sender, EventArgs e) {
        _ticks++;
        onTickEvent?.Invoke(ticks, interval);
      }
    }
    // Code für ClockObserver bleibt unverändert
    ```
  ]
)
=== Event Syntax
```cs public delegate void AnyHandler(object sender, AnyEventArgs e)```;\
Events haben immer den _Rückgabetyp `void`_. Der _erste Parameter_ ist der Sender des Events, der Absender übergibt
beim Aufruf des Events immer implizit `this`. Der _zweite Parameter_ ist eine beliebige Subklasse von `EventArgs`.
Diese _enthält Informationen zum Event_ #hinweis[(z.B. linke/rechte Maustaste bei Klick)] und kann um
eigene Parameter für das Event ergänzt werden. Dies hat den _Vorteil_, dass bei Änderungen an den Parametern
der Aufruf des Clients auf das Event nicht angepasst werden muss.

=== Event Handling
#grid(
  [
    Einem Event können _mehrere Parameter_ mitgegeben werden. Dazu erstellt man zusätzlich zum Event eine weitere Klasse,
    welche von `EventArgs` abgeleitet ist und alle Properties für das Event enthält. Möchte man nun ein weiteres Property
    `MousePosition` hinzufügen, kann dies einfach zu den `ClickEventArgs` hinzugefügt werden.
    Der Aufruf von `OnClick()` ändert sich nicht.

    Im Normalfall hat die `EventArgs`-Klasse einen _Konstruktor_, welche alle Properties entgegen nimmt.
    Bei manuellen Aufrufen durch `.Invoke()` können so mit `new ClickEventArgs(...)` alle Parameter übergeben werden.
  ],
  [
    ```cs
    public delegate void ClickEventHandler
      (object sender, ClickEventArgs e);

    public class ClickEventArgs : EventArgs {
      public string MouseButton { get; set; }
      public string MousePosition { get; set; }
    }

    public class Button {
      public event ClickEventHandler OnClick;
    }
    // Anwendung
    public class Usage {
      public void Test() {
        Button b = new();
        b.OnClick += OnClick();
      }
      private void OnClick
        (object sender, ClickEventArgs clickEventArgs) {
          /* Das passiert beim Buttonklick */
      }
    }
    ```
  ]
)

== Lambda Expressions
#grid(
  [
    Methoden, welche als Parameter übergeben wurden, mussten bisher _einer Variable zugewiesen_ und benannt werden,
    auch wenn sie nur einmal verwendet werden. Ein weiterer Nachteil ist, dass diese Funktionen nur auf _globale Variablen_
    zugreifen können.\ Abhilfe schaffen _Lambda-Expressions_: Der Code wird in-place angegeben, es ist keine Deklaration
    einer Methode nötig und Lambda Expressions können ebenfalls auf lokale Variablen zugreifen.
  ],
  [
    ```cs
    class LambdaExample {
      // Auskommentierter Code nicht mehr nötig
      //int _sum = 0;
      //void SumUp(int i) { _sum += i; }
      //void Print(int i) { Console.WriteLine(i); }
      void Test() {
        List<int> list = new();
        list.ForEach(/* Print */
          i => Console.WriteLine(i));
        list.ForEach(/* SumUp */ i => sum += 1); } }
    ```
  ]
)

=== Syntax
#grid(
  [
    - _Expression Lambda:_ #hinweis[`(parameters) => expression`]\
      Ohne Klammern, genau ein Statement erlaubt\ #hinweis[(auch Funktionen & Actions mit Rückgabetypen)]
    - _Statement Lambda:_ #hinweis[`(parameters) => {statements;}`]\
      Block mit geschweiften Klammern, beliebig viele Statements erlaubt, mit/ohne Rückgabewert

    Der _Lambda Operator #no-ligature[`=>`]_ ist kein "grösser gleich", sondern ein Trennzeichen.
    Ausgesprochen als "goes to" oder "geht über in".
  ],
  [
    ```cs
    // Expression Lambda
    Func<int, bool> fe = i => i % 2 == 0;
    Func<int, int, int> e = (a, b) => Multiply(a, b);
    // void type Lambdas sind Actions
    Action<int> e2 = i => Console.WriteLine(i);

    // Statement Lambda
    Func<int, bool> fs = i => {
      int rest = % 2;
      return rest == 0;
    }
    ```
  ]
)
=== Parameter & Type Inference
#grid(
  [
    _Lambdas_ können $0$ bis $n$ Parameter haben. Sie können als _`Func`_ oder _`Action`_ definiert sein
    #hinweis[(mit/ohne Rückgabetyp)]
    
    *Regeln:*
    Klammern um Parameter #hinweis[(ausser bei genau einem Parameter oder wenn Parametertyp aus Delegate abgeleitet werden kann)],
    `ref` / `out` sind erlaubt. Jeder Parameter muss implizit in jeweiligen Delegate-Parameter konvertierbar sein.

    _Typen_ sind meist redundant definiert: In der Deklaration werden hier die Typen schon angegeben und
    müssen in der Parameterliste nicht wiederholt werden.
  ],
  [
    ```cs
    Func<bool> p1; // 0 Parameter, returnt bool
    Func<int, bool> p2; // 1 int Parameter, returnt bool
    Func<int, int, bool> p3;
    p1 = () => true;
    p2 = a => true; // Ausnahme mit Klammern
    p2 = (a) => true;
    p3 = (a, b) => true;
    // mit Angabe des Parametertyps
    p2 = int a => true; // Compilerfehler
    p2 = (int a) => true;
    p3 = (int a, int b) => true;
    ```
  ]
)

#pagebreak()

=== Closures
#grid(
  [
    Verwendet eine Methode eines Delegates _lokale Variablen_, würde dies normalerweise zu Problemen führen,
    da die Runtime diese _nach einem Aufruf der Funktion vernichten würde_. Um dies zu verhindern, gibt es Closures.\
    In einem Closure können Funktionen _von aussen_ auf _lokale Variablen innerhalb_ einer Delegate-Funktion zugreifen.
    Dazu wird die Variable vom Compiler in ein Hilfsobjekt ausgelagert.
    #hinweis[(eigene Klasse, welche die Logik und die Variablen des Delegates speichert)].
    Die _Lebenszeit_ des Hilfsobjekt ist gleich lang wie die des Delegate-Objekts.

    Im _Beispiel_ wird in der Funktion `CreateAdder()` ein Delegate returnt, in welchem die lokale Variable `x`
    inkrementiert wird #hinweis[(`++x`)]. Adder ist also ein Closure. Dann wird zwei Mal `add()` aufgerufen.
    Es wird nur beim ersten Mal `x = 0` initialisiert.
  ],
  [
    ```cs
    public delegate int Adder();

    class ClosureExample {
      static void Test() {
        Adder add = CreateAdder();
        Console.WriteLine(add()); // Output: "1"
        Console.WriteLine(add()); // Output: "2"
      }

      static Adder CreateAdder() {
        int x = 0; // nur bei 1. Aufruf initialisiert
        return () => ++x; // wird jedes Mal inkrement.
      }
    }
    ```
  ]
)

== Zusammenfassung Delegates & Lambda
#v(1em)
#grid(
  [
    ```cs
    public delegate void MyDel(string sender);
    public class Summary {
      void Print(string sender)
        => Console.WriteLine(sender);
      static void PrintStatic(string sender)
        => Console.WriteLine(sender);
      void Test(){
        MyDel x1;
        /* Aufrufe siehe rechts */
      }
    }
    ```
  ],
  [
    ```cs
    // Standard (Instanzmethode)
    x1 = new MyDel(this.Print);
    x1 = this.Print;
    // Standard (Statisch)
    x1 = new MyDel(Summary.PrintStatic);
    x1 = Examples.PrintStatic;
    // Expression Lambda
    x1 = sender => Console.WriteLine(sender);
    // Statement Lambda
    x1 = sender => { Console.WriteLine(sender); }
    ```
  ]
)

= Generics, Nullability & Records
== Generics
#grid(
  [
    Generics erlauben _typsichere Datenstrukturen_ ohne Festlegung auf einen bestimmten Typen. Erlaubt die Implementation
    von Strukturen ohne die Verwendung von `object`. Stattdessen wird _`T` #hinweis[(generischer Typparameter)]_ verwendet.
    `T` wird dabei beim Aufruf einer Klasse/Funktion festgelegt. Innerhalb einer generischen Klasse ist
    _`T` immer derselbe deklarierte Typ_ #hinweis[(z.B. `string`)].\
    *Vorteile:* Hohe Wiederverwendbarkeit, Typsicherheit #hinweis[(bei `object` können sämtliche Typen übergeben werden)],
    Performance #hinweis[(Kein Boxing/Casting nötig)]. Hauptanwendungsfall sind Collections.
  ],
  [
    ```cs
    public class Buffer<T>
    {
      T[] _items;

      public void Put(T item) { ... }
      public T Get() { ... }
    }
    // Verwendung
    Buffer<int> buffer = new();
    buffer.Put(1);
    int i = buffer.Get();
    ```
  ]
)
=== Regeln für Generics
#grid(
  [
    `T` kann intern wie _normaler Typ_ verwendet werden. _Generisch sein können:_ Klasse, Struct, Interface, Delegates,
    Events, einzelne Methoden #hinweis[(auch wenn Klasse nicht generisch)]. Deklaration immer nach Name des Elements
    in spitzen Klammern. `Class` und `Class<T>` sind voneinander _unabhängig_ und darum nicht direkt ineinander castbar.

    Beliebige Anzahl generische Typparameter erlaubt: ```cs Buffer<T1, T2, TElement>```
    #hinweis[(Bei mehreren wird empfohlen, aussagekräftige Namen, welche mit `T` beginnen, zu verwenden)]

  ],
  [
    ```cs
    public class Buffer<TElement, TPriority>
    {
      TElement[] _items;
      TPriority[] _priorities;
      public void Put(TElement item, TPriority prio)
      { ... }
    }
    // Verwendung
    Buffer<string, float> b = new();
    b.Put("Hello", 0.3f);
    b.Put("World", 0.2f);
    ```
  ]
)

#pagebreak()

=== Generic Type Inference
#grid(
  [
    _Redundante Typparameter_ können bei Methoden _weggelassen_ werden, der Compiler fügt sie automatisch ein.
    Dies funktioniert aber nur, wenn `T` ein _Parameter_ ist. Wenn `T` nur Return Type oder nicht in Signatur vorhanden ist,
    muss der Typ zwingend angegeben werden.
  ],
  [
    ```cs
    public void Print<T>(T t) { ... }
    public T Get<T>() { ... }
    public void TypeInference() {
      Print<int>(12); Print(12); // beides OK
      int i1 = Get<int>(); // OK
      int i2 = Get(); /* Compilerfehler */ }
    ```
  ]
)

=== Type Constraints
#grid(
  [
    Bei Generics können alle Member von `object` als `T` übergeben werden. Möchte man dies einschränken,
    kann ein _Type Constraint_ verwendet werden. Dies wird bei der Anwendung vom Compiler überprüft.\
    Beispielsweise kann mit\ ```cs where TPriority : IComparable```\ spezifiziert werden,
    dass `TPriority` das `IComparable` Interface implementieren muss.
    Dadurch hat `TPriority` im Generic Zugriff auf die Methoden von `IComparable` #hinweis[(`Equals()`, `CompareTo()`, ...)]
  ],
  [
    ```cs
    class OrderedBuffer<TElement, TPriority>
      where TPriority : IComparable {
      TElement[] _data;
      TPriority[] _prio;
      int _lastElem;
      public void Put(TElement x, TPriority p) {
        int i = _lastELem;
        while (i >= 0 && p.CompareTo(_prio[i]) > 0) {
          _data[i + 1] = _data[i];
          _prio[i + 1] = _prio[i]; i--;
        }
        data[i + 1] = x; _prio[i + 1] = p;
    } }
    ```
  ]
)
#table(
  columns: (auto, 1fr),
  table.header([Constraint], [Beschreibung]),
  [```cs where T : struct```],
  [
    `T` muss ein _Value Type_ sein\
    #hinweis[(`T` muss auf Stack oder inline in Objekt liegen, `T` kann nie `null` sein, `null`-Check nicht erlaubt)]
  ],

  [```cs where T : class```],
  [
    `T` muss ein _Reference Type_ #hinweis[(Klasse, Interface, Delegate)] sein
    #hinweis[(`T` liegt auf Heap, `T` kann `null` sein)]
  ],

  [```cs where T : new()```],
  [
    `T` muss _parameterlosen `public` Konstruktor_ haben. #hinweis[(`T` muss instanzierbar sein)]\
    #hinweis[(Dieser Constraint muss zuletzt aufgeführt werden)]
  ],

  [```cs where T : Name```],
  [
    `T` muss von Klasse `Name` ableiten oder Interface `Name` implementieren\
    #hinweis[(`T` hat Zugriff auf alle Member. Es sollte meistens auf ein Interface anstatt auf eine Klasse eingeschränkt werden,
    da es dem Caller mehr Freiheiten bietet)]
  ],

  [```cs where T : TOther```],
  [
    `T` muss mit `TOther` identisch sein bzw. davon ableiten
    #hinweis[(auch _Naked Type Constraint_ genannt, nur sehr spezifische Anwendungen, siehe Kapitel @extension-methods)]
  ],

  [```cs where T : class?```],
  [
    `T` muss ein Nullable Reference Type sein #hinweis[(Klasse, Interface, Delegate)]\
    #hinweis[(siehe @nullable-reference-types)]
  ],

  [```cs where T : not null```],
  [`T` muss ein Non-Nullable Value/Reference Type sein],
)

==== Kombination von Type Constraints
#grid(
  [
    Sollen _mehrere Type Constraints_ verwendet werden, muss für jeden Parameter eine eigene `where`-Klausel geschrieben werden.
    Mehrere `where` für einen Typparameter sind nicht erlaubt. Allfälliger `new`-Constraint muss am Ende der `where`-Klausel stehen.
  ],
  [
    ```cs
    class MultiConstraints<T1, T2>
      where T1 : struct
      where T2 : Buffer, IEnumerable<T1>, new()
      {
        /* ... */
      }
    ```
  ],
)

=== Generics Behind the Scenes
#table(
  columns: (1fr, 1fr),
  table.header([Konkretisierung mit Value Types], [Konkretisierung mit Reference Types]),
  [
    ```cs Buffer<int> a = new();```\
    + CLR erzeugt zur Laufzeit `Buffer<int>`
    + `T` wird durch `int` ersetzt

    ```cs Buffer<int> b = new();```\
    3. Wiederverwendung von `Buffer<int>`;

    ```cs Buffer<float> c = new();```\
    4. CLR erzeugt zur Laufzeit `Buffer<float>`
    + `T` wird durch `float` ersetzt
  ],
  [
    ```cs Buffer<string> a = new();```\
    + CLR erzeugt zur Laufzeit `Buffer<object>`
    + Wird für alle Reference Types wiederverwendet, da nur Referenzen gespeichert werden

    ```cs Buffer<string> b = new();```\
    3. Wiederverwendung von `Buffer<object>`

    ```cs Buffer<Node> c = new();```\
    4. Wiederverwendung von `Buffer<object>`
  ],
)


== Vererbung bei Generics
Generische Klassen könne von anderen generischen Klassen erben. Es gibt folgenden Möglichkeiten für Basistypen:
- _Normale Klassen:_ ```cs class MyList<T> : List { }```\
  Die Zuweisung an eine Variable eines nicht-generischen Basistyp ist immer möglich.
- _Weitergabe des Typparameters an generische Basisklasse:_ ```cs class MyList<T> : List<T> { }```\
  Die Zuweisung an eine Variable ist nur möglich, wenn Typparameter kompatibel sind.
- _Konkretisierte generische Basisklasse:_ ```cs class MyIntList : List<int> {}```\
- _Mischform:_ ```cs MyIntKeyDict<T> : Dictionary<int, T> { }```

_Typparameter_ werden nicht vererbt: ```cs class MyList : List<T> { } // Compilerfehler```\
Hier ist `T` dem Compiler nicht bekannt. Entweder muss `T` durch einen konkreten Typen ersetzt werden,
oder die Basisklasse generisch gemacht und der Parameter `T` an sie weitergegeben werden.

_Type Checks und Casts_ funktionieren gleich wie bei normalen Typen. Reflection unterstützt Abfrage von konkretisierten
und nicht konkretisierten Typparametern.

=== Methoden überschreiben
#grid(
  columns: (1fr,) * 3,
  [
    *Generische Basisklasse*\
    #hinweis[`T` wird allen Overrides übergeben]
    ```cs
    class Buffer<T>
    {
      public virtual void Put(T x)
        { ... }
    }
    ```
  ],
  [
    *Konkretisierte Basisklasse*\
    #hinweis[`T` wird durch `int` ersetzt]
    ```cs
    class MyIntBuffer : Buffer<int>
    {
      public override void Put(int x)
        { ... }
    }
    ```
  ],
  [
    *Generische Vererbung*\
    #hinweis[`T` bleibt generisch]
    ```cs
    class MyBuffer<T> : Buffer<T>
    {
      public override void Put(T x)
        { ... }
    }
    ```
  ],
)

== Generische Delegates
#grid(
  columns: (0.9fr, 1fr),
  [
    Der Code aus @funktionsparams-delegates kann generisch gemacht werden.
    Das Delegate, die `ForAll()`-Methode und die `PrintValues`-Action können nun mit sämtlichen Typen umgehen:

    *Test-Code*
    #v(-0.5em)
    ```cs
    int[] a1 = { 1, 5, 8, 14, 22 };
    string[] a2 = { "a", "b", "c" };
    ForAll(a1, MyClass.PrintValues);
    ForAll(a2, MyClass.PrintValues);
    ```
  ],
  [
    ```cs
    public delegate void Action<T>(T i);
    public class MyClass {
      public static void PrintValues<T>(T i)
       { Console.WriteLine($"Value {i}"); }
    }
    public class FunctionParameter {
      static void ForAll<T>(T[] arr, Action<T> action) {
        Console.WriteLine("ForAll called");
        if (action == null) { return; }
        foreach (T t in arr) {
          action(t);
    } } }
    ```
  ],
)
=== Delegate-Typen
#{
  show table.cell: c => {
    if c.x == 3 and c.y > 0 {
      return text(size: 9.5pt, c)
    }
    return c
  }
  table(
    columns: (auto, auto, auto, 1fr),
    table.header([Delegate], [Parameter], [Return Type], [Signatur]),
    [Aktion],
    [$0$ bis $n$],
    [`void`],
    [
      ```cs
      public delegate void Action();
      public delegate void Action<in T1, ... , in T16>
        (T1 obj1, ..., T16 obj16);
      ```
    ],

    [Funktion],
    [$0$ bis $n$],
    [non-`void`],
    [
      ```cs
      public delegate TResult Func<out TResult>();
      public delegate TResult Func<in T1, ..., in T16, out TResult>
        (T1 obj1, ..., T16 obj16);
      ```
    ],

    [Prädikat],
    [1],
    [`bool`],
    [
      ```cs
      public delegate bool Predicate<in T>(T obj);
      ```
    ],

    [EventHandler],
    [`object sender`,\ `TEventArgs e`],
    [`void`],
    [
      ```cs
      public delegate void EventHandler<TEventArgs>
        (object sender, TEventArgs e);
      public delegate void EventHandler(object sender, EventArgs e);
      ```
    ],
  )
}

== Generische Collections
Collections sind Typen, welche _mehrere Elemente eines Typs_ enthalten. Alle Collections leiten von _`ICollection<T>`_ ab,
welches Methoden zur Collection-Manipulation zur Verfügung stellt #hinweis[(`Add(T)`, `Remove(T)`, `Contains(T)` etc.)].\
`ICollection<T>` implementiert wiederum `IEnumerable<T>`, was Iteration per `foreach`-Loop ermöglicht, siehe Kapitel @iteratoren\
Die meisten Klassen und Interfaces aus `System.Collections` haben eine _generische_ und eine _nicht-generische Variante_.
Häufig verwendet man auch nur die generischen Varianten.\
*Häufig verwendet:* `List<T>`, `SortedList<T>`, `Dictionary<TKey, TValue>` #hinweis[(Hashtable)], `SortedDictionary<T>`,
`LinkedList<T>`, `Stack<T>`, `Queue<T>`, `IEnumerable<T>`, `ICollection`


== Nullability
Es gibt spezielle Typen, welche `null` als eine Art _"unbekannter"_ bzw. "nicht existenter" _Wert_ zulassen.
Diese Typen werden _Nullable Types_ gennant.

=== `default` Operator
#grid(
  [
    Der Default Operator liefert den Default-Wert für den angegebenen Typen
    #hinweis[(Referenz-Typen: `null`, Zahlentypen: `0`, Bool: `false`, Enum: `0` zu Enum gecastet)].
    Dies ist vor allem _für Generics nützlich_, da so für jeden Typ automatisch der entsprechende Default-Typ gefunden werden kann.
  ],
  [
    ```cs
    public void NullExamples<T>() {
      T x1 = null;       // 2x Compilerfehler, er weiss
      T x2 = 0;          // nicht, ob Typ kompatibel ist
      T x3 = default(T); // OK
      T x4 = default;    // OK
    }
    ```
  ]
)

== Nullable Value Types (Structs)
#grid(
  [
    _Value Types_ kann dank Generics _`null` zugewiesen werden_. Dazu kann der Typ in die Wrapper-Klasse `System.Nullable<T>`
    gepackt werden. Diese besitzt ein _Property `value`_, welches den tatsächlichen Wert enthält und _`HasNull`_, welches angibt,
    ob der Wert `null` ist. Ist der Wert `null`, ist der Wert in `value` undefiniert.\
    Wird im Status `null` auf `Value` zugegriffen, erhält man eine `InvalidOperationException`.
  ],
  [
    ```cs
    public struct Nullable<T>
      where T : struct
    {
      public Nullable(T value);

      public bool HasValue { get; }
      public T Value { get; }
    }
    ```
  ]
)

=== `T?` Syntax
#grid(
  [
    Syntactic Sugar, um die Lesbarkeit von Nullable Types zu erhöhen. Direkte Zuweisung von `null` möglich.
  ],
  [
    ```cs
    int? x = 123;  // new System.Nullable<int>(123);
    int? y = null; // new System.Nullable<int>();
    ```
  ]
)

=== Sicheres Lesen & Type Casts von Value Types
#v(0.1em)
#grid(
  [
    *Lesen*
    #v(-0.5em)
    ```cs
    int? x = null;
    // Klassisch
    int x1 = x.HasValue ? x.Value : default;
    // Via Methode
    int x2 = x.GetValueOrDefault();
    // Via Methode & eigenem Default
    int x3 = x.GetValueOrDefault(-1);
    ```
  ],
  [
    *Type Casts*
    #v(-0.5em)
    ```cs
    int i = 123;
    int? x = i;
    int j = (int)x;
    // Compiler-Output der obigen Statements:
    int i = 123;
    int? x = i;      // Kein Problem
    int j = x.Value; // Schlecht, wenn x null ist
    ```
  ]
)
#grid(
  [
    === Nullability und Operatoren
    ```cs
    int x = 1;
    int? y = 2;
    int? z = null;
    ```
    #hinweis[Ist `int?` eine Zahl, verhält sich der Typ wie `int`.\
    `">"` und `"<"` funktionieren nur bei Typen, die diese Operatoren implementiert haben, also z.B. bei `int`.]
  ],
  [
    #table(
      columns: (1fr, 1fr, 1fr),
      [Expression], [Ausdruckstyp], [Resultat],
      [`x + z`], [`int?`], [`null`],
      [`x + null`], [`int?`], [`null`],
      [`x + null < y`], [`bool`], [`false`],
      [`x + null == z`], [`bool`], [`true`],
      [`x + null >= z`], [`bool`], [`false`],
    )
  ]
)


== Nullable Reference Types (Klassen) <nullable-reference-types>
Die _"null-state analysis"_ ist ein reines Compilerfeature, welches auf _"static flow analysis"_ basiert
#hinweis[(Kann Objekt `null` sein?)]. Die Implementation _unterscheidet sich_ massiv von den _Nullable Value Types_.
Generiert Compilerwarnungen, wenn in der `*.csproj` oder dem Präprozessor mit ```cs #nullable enable``` aktiviert.
Sanfter Ansatz, da nicht alle .NET Libraries direkt umgestellt werden können.

Die Analyse nimmt an, dass _jede Referenz `null` sein könnte_, ausser sie stammt aus einem Assembly,
welches bereits mit null-state analysis geprüft wurde oder die Referenz wurde in der eigenen Codebase _schon auf `null` geprüft_.

#grid(
  [
    Der _Typ einer Reference Variable_ kann wie bei den Value Types mit einem _Fragezeichen_ versehen werden: _`string?`_.\
    Ebenfalls möglich ist der _Null-forgiving Operator `!`_ hinter einem Wert oder einer Variable, welche explizit erlaubt,
    eine non-nullable Variable auf `null` zu setzen. _Extrem gefährlich_, sollte nur mit Bedacht eingesetzt werden,
    da damit Compiletime und Runtime inkonsistent werden.

  ],
  [
    ```cs
    string? nameNull = null;
    string name = nameNull; // Warning

    if (nameNull is null) { // oder `nameNull == null`
      name = nameNull;      // Warning
      name = nameNull!;     // OK, but wrong
    } else {
      name = nameNull;      // OK
    }
    ```
  ],
)


== Nullable Syntactic Sugar
Um den Umgang mit Nullable Types zu erleichtern, gibt es _eigene Operatoren_ für die `null`-Handhabung.

=== `is null` / `is not null` <is-null-operator>
#grid(
  [
    Mit den ```cs is null``` / ```cs is not null``` Operatoren kann auf `null` überprüft werden.
    _Bei Value Types_ wird `HasValue` abgefragt, _bei Reference Types_ #hinweis[(auch ohne `?`)]
    mit `ReferenceEquals()`, ob es sich um eine Null-Referenz handelt.
    _`obj is null`_ ist _`obj == null`_ vorzuziehen, da #no-ligature[`==`] manuell überschrieben worden sein könnte und
    dadurch evtl. abweichende Logik besitzt.
  ],
  [
    ```cs
    int? x = null; string s = null;
    bool b1a = x is null; bool b1b = x is not null;
    bool b2a = s is null; bool b2b = s is not null;
    // Compiler Output:
    bool b1a = x.HasValue; bool b1a = !x.HasValue;
    bool b2a = object.ReferenceEquals(x, null);
    bool b2b = !object.ReferenceEquals(x, null);
    ```
  ]
)

=== Null-coalescing operator: `??`
#grid(
  [
    Binärer Operator, welcher den _linken Teil zurückgibt_, wenn dieser _nicht `null`_ ist.
    _Ansonsten_ wird der _rechte Teil_ zurückgegeben. Kann z.B. dazu verwendet werden, bei `null` Exceptions zu werfen
    oder einen Default-Wert zu spezifizieren.
  ],
  [
    ```cs
    int? x = null;
    int i = x ?? -1; // x wenn null, sonst -1
    // Compiler Output:
    int i = x is not null
      ? x.GetValueOrDefault()
      : -1;
    ```
  ]
)

=== Null-coalescing assignment operator: `??=`
#grid(
  [
    Unärer Operator, welcher der _Variable links_ den _Wert rechts zuweist_, wenn die Variable `null` ist.
    Hat dasselbe Verhalten wie die anderen Assignment-Operatoren.
  ],
  [
    ```cs
    int? i = null; i ??= -1;
    // Compiler Output:
    if (i is null) { i = -1; }
    ```
  ]
)

=== Null-conditional operator: `?.`
#grid(
  [
    Führt den _rechten Teil_ aus, sofern der _linke Teil nicht `null`_ ist. Ansonsten wird ein Default-Wert generiert.
    Funktioniert auch mit Delegates via `.Invoke()`. Nützlich, um auf Member eines Objekts zuzugreifen, welches `null` sein könnte.
  ],
  [
    ```cs
    object o = null; Action a = null;
    string s = o?.ToString();
    a?.Invoke();
    // Compiler Output:
    string s = o is not null ? o.ToString() : default;
    if (a is not null) { a(); }
    ```
  ]
)

== Record Types
```cs public record [class|struct] Person(int Id, string Name);```\
Ein Record ist eine reine _Datenrepräsentationsklasse_, welche nur initialisierbar ist #hinweis[(immutable)].
Vereinfacht Arbeit mit nullable Reference Types. _Compiler generiert eigene Klasse mit diversen Member_
#hinweis[(Konstruktor, read-only Properties, `Equals` und `==, !=` Operatoren, `ToString()`)].
Ein Record kann nur initialisiert werden, wenn alle Properties angegeben werden. Vererbungen werden berücksichtigt.\
*Verwendungszweck:* Klassen ohne Methoden, z. B. für Werte aus DBs, oder Werte, die nur im Programm hin und hergeschoben werden.

=== Manuelle Deklaration
#grid(
  [
    Kann wie _normale Klasse_ deklariert werden. Der Nutzen ist so aber beschränkt, es werden so nur die Value Equality
    und `ToString()` generiert. Dafür ist es möglich, eigene Konstruktoren zu erstellen.
    Grundsätzlich aber besser den Positional Syntax verwenden.

    *Anwendung*\
    #v(-0.5em)
    ```cs
    Person p1 = new();
    Person p2 = new(1, "Nina");
    ```
  ],
  [
    ```cs
    public record Person {
      // Eigener Default Konstruktor
      public Person() : this(0, "") { ... }
      public Person(int id, string name) {
        Id = id;
        Name = name;
      }
      public int Id { get; init; }
      public string Name { get; init; }
    }
    ```
  ]
)

=== Gemischte Deklaration mit Positional Syntax
#grid(
  [
    Die vom Record generierten Properties werden als _init-only-setter_ erstellt.
    Positionale Deklaration kann zusätzlich zu benötigten Properties ergänzt werden, hier `Name` und `DoSomething()`.

    Zu beachten gilt, dass `Name` _non-nullable_ ist und eine Compilerwarnung generiert, wenn nicht gesetzt.
  ],
  [
    ```cs
    public record Person(int Id) {
      // Id implizit durch Constructor deklariert
      public string Name { get; init; }
      public void DoSomething() { }
    }
    Person p1 = new(0);  // OK, aber Compilerwarnung
    p1.Id; p1.Name = ""; // 2x Compilerfehler
    Person p2 = new(0) { Name = "" }; // OK
    ```
  ]
)

=== Deklaration mit Vererbung
#grid(
  [
    _Records unterstützen Vererbung_, dazu muss die Basisklasse ebenfalls ein Record sein.
    Der zu aufrufende Konstruktor der Basisklasse wird hinter dem Record-Header angegeben.
    Subklassen können Basisklassen zugewiesen werden.
  ],
  [
    ```cs
    public abstract record Person(int Id);
    public record SpecialPerson
      (int Id, string Name) : Person(Id);
    SpecialPerson p1 = new(1, "Nina");
    Person p2 = p1;
    ```
  ]
)

=== Value Equality
#grid(
  [
    Code zur Value Equality wird vom _Record automatisch generiert_. Vergleicht sämtliche Werte der Properties,
    also keine Reference Equality. Auch Properties allfälliger Basisklassen werden verglichen.
    Soll unterschieden werden, ob es zwei unterschiedliche Instanzen sind, kann _`ReferenceEquals()`_ verwendet werden.
  ],
  [
    ```cs
    public record Person(int Id, string Name);
    Person p1 = new(0, "Nina");
    Person p2 = new(0, "Nina");

    bool eq1 = p1 == p2; // true, false bei !=
    bool eq2 = p1.Equals(p2); // true
    bool eq3 = ReferenceEquals(p2); // false
    ```
  ]
)

== Verändern von Records
#grid(
  [
    Records können zwar _nicht verändert werden_, aber beim Zuweisen an eine neue Variable kann _nondestructive mutation_
    durchgeführt werden. Mit dem Keyword _`with`_ können einzelne Properties angepasst werden, was das Erzeugen leicht
    veränderter Records erleichtert.
  ],
  [
    ```cs
    public record Person(int Id, string Name);
    Person p1 = new(0, "Nina");
    person p2 = p1 with { Id = 1 }; // neue Id
    bool eq1 = p1 == p2; // false
    Person p3 = p1 with { }; // exakte Kopie
    bool eq3 = p1 == p3; // true
    ```
  ]
)


= Exceptions & Iteratoren
== Exceptions
Exceptions behandeln _unerwartete Programmzustände_ oder _Ausnahmeverhalten_ zur Laufzeit.
Im Gegensatz zu Java muss der Aufrufer einer Methode Exceptions dieser nicht unbedingt behandeln (sogenannte _"Unchecked Exceptions"_).
Auch muss nicht an der Signatur angegeben werden, welche Art von Exceptions eine Methode wirft.
Dies ist zwar kürzer und bequemer, aber auch weniger sicher und robust.

*Best Practices:*
- Exceptions sollten _Ausnahmen_ sein und nicht für den "normalen" Programmfluss verwendet werden
- Wenn möglich sollten _Vorbedingungen geprüft_ werden, um Exceptions zu _vermeiden_
- Exceptions sind _"Fehlercodes" vorzuziehen_ #hinweis[(z.B. bei Fehler `-1` returnen)]
- _Konkrete Fehlerbeschreibung_ #hinweis[(Möglichst konkrete Exception-Klasse verwenden, detaillierte Exception Message)]
- _Nie_ Fehler über _Web-Schnittstelle_ übermitteln #hinweis[(offenbart Internas & erhöht Verletzbarkeit des Systems)]
- _Aufräumen_ bei Exceptions #hinweis[(Sockets, File Handles, Transaktionen schliessen/beenden)]

#grid(
  [
    Exception Handling basiert auf _folgenden Keywords:_
    - _`try`:_ Anweisungsblock, welcher Exception verursachen kann
    - _`catch`:_ Anweisungsblock, welcher eine bestimmte Exception behandelt
    - _`finally`:_ Anweisungsblock, welcher nach `try` und nach `catch` garantiert einmalig ausgeführt wird
    - _`throw`:_ Statement löst Exception aus #hinweis[(im Gegensatz zu Java nicht zusätzlich bei Methodensignatur nötig)]
    `try-catch`-Blöcke sind relativ _performanceintensiv_.
  ],
  [
    ```cs
    FileStream s = null;
    try {
      s = new(@"C:\urMom.mp4", FileMode.Open); ...;
    } catch (FileNotFoundException e) {
      Console.WriteLine($"{e.FileName} not found");
    } catch (IOException) {
      Console.WriteLine("I/O exception occurred");
    } catch {
      Console.WriteLine("Unknown Exception occurred");
    } finally {
      if (s != null) { s.Close(); }
    }
    ```
  ]
)

*Regeln*\
- Es wird _sequenziell_ nach einem passenden `catch`-Block gesucht #hinweis[(von oben nach unten)]
- Der _Name_ des Exception-Objekts darf _weggelassen_ werden, wenn nicht verwendet
- _Eigene Exceptions_ müssen von `System.Exception` abgeleitet werden
- `finally`-Block wird _immer_ ausgeführt, wenn vorhanden

#pagebreak()

=== Klasse `System.Exception`
#grid(
  [
    _Basisklasse für alle Exceptions._ Hat Konstruktoren für Fehlerbeschreibung und allfällige Inner Exceptions.\
    *Properties & Methoden:*
    - _`InnerException`:_ Verschachtelte Exceptions
    - _`Message`:_ Menschenlesbare Fehlerbeschreibung
    - _`Source`:_ Name des Objekts, Frameworks etc., welches den Fehler verursachte
    - _`StackTrace`:_ Aktueller Call Stack als String
    - _`TargetSite`:_ Ausgeführter Code-Teil, der Fehler verursacht
    - _`ToString()`:_ Fehlermeldung & Stack Trace als String
  ],
  [
    ```cs
    public class Exception : ISerializable, ... {
      public Exception() { ... }
      public Exception(string message) { ... }
      public Exception(string message,
        Exception innerException){ ... }
      public Exception InnerException { get; }
      public virtual string Message { get; }
      public virtual string Source { get; set; }
      public virtual string StackTrace {get; set; }
      public MethodBase TargetSite { get; }
      public override string ToString();
    }
    ```
  ]
)

=== `throw` Keyword
#grid(
  [
    Kann _implizit_ aufgerufen werden, wenn ungültige Operation durchgeführt wird oder Methode aufgerufen wird,
    welche eine _unbehandelte Exception_ wirft.

    _Explizite Aufrufe_ können in _eigenen Methoden_ implementiert werden.
  ],
  [
    ```cs
    // Division durch 0
    int i = 0; int x1 = 12 / i;
    // ungültiger Indexzugriff
    int[] arr = new int[5]; int x2 = arr[12];
    // null-Zugriff
    object o = null; string x3 = o.ToString();
    throw new Exception("An Error occured");
    ```
  ]
)

=== Exception Filters
#grid(
  [
    _`catch`-Block_ kann mit dem _`when`-Keyword_ nur unter definierter Bedingung ausgeführt werden.
    Die Bedingung muss _`bool`_ zurückgeben. Innerhalb der Bedingung ist der Zugriff auf das Exception-Objekt möglich.
  ],
  [
    ```cs
    try { ... }
    catch (Exception e)
      when (DateTime.Now.Hour < 18) { ... }
    catch (Exception e)
      when (DateTime.Now.Hour >= 18) { ... }
    ```
  ]
)

=== `catch`-`throw`-Block
#table(
  columns: (1fr, 1fr),
  table.header([Klassisch mit `throw e`], [Rethrowing mit `throw`]),
  [
    Neuer Stack Trace wird begonnen
    ```cs
    try {
      throw new Exception("Blöd gloffe");
    } catch (Exception e) {
      throw e; // mit Weitergabe von e
    }
    ```
  ],
  [
    Stack Trace bleibt erhalten
    ```cs
    try {
      throw new Exception("Blöd gloffe");
    } catch (Exception e) {
      throw; // ohne Weitergabe von e
    }
    ```
  ],
)

== Suche nach catch-Klausel
#grid(
  [
    Call Stack wird _rückwärts_ nach passender `catch`-Klausel durchsucht.
    Programm wird mit Fehlermeldung und Stack Trace _abgebrochen_, falls keine gefunden.

    Das selbe Prinzip gilt auch für _Delegates:_ Sie werden wie normale Methoden behandelt.
    Etwas komplizierter wird das Finden bei Multicast Delegates.
  ],
  [
    #v(-1em)
    #image("img/dotnet_14.png")
    #v(-1em)
    #image("img/dotnet_15.png")
  ]
)

=== `catch` mit Multicast Delegates
#grid(
  align: horizon,
  [
    *Szenario 1:*
    - `Exc1` wird in `G()` ausgelöst
    - `catch` für `Exc1` in `F1()` behandelt Ausnahme
    - `F2()` wird aufgerufen #hinweis[(nächste Delegate-Methode)]
    #v(-0.5em)
    *Szenario 2:*
    - `Exc2` wird in `G()` ausgelöst
    - Kein `catch` für `Exc2` gefunden
    - `catch` für `Exc2` in `Main()` behandelt\ #hinweis[(Delegate-Ausführung beendet)]
  ],
  image("img/dotnet_16.png")
)

=== Beispiel: Argumente prüfen
#grid(
  columns: (0.5fr, 1fr),
  [
    Zwei verschiedene Exception-Typen
    - _ArgumentNullException_\ bei `null`-Werten
    - _ArgumentOutOfRangeException_\ bei ungültigen Wertebereichen
    `nameof` wird zum Auslesen des Parameternamens verwendet und ist _Refactoring-stabil._\
    #hinweis[(Namensänderungen werden "übernommen")]
  ],
  [
    ```cs
    string Replicate(string s, int nTimes) {
      if (s is null) {
        throw new ArgumentNullException(nameof(s));
      } if (s.Length == 0) {
        throw new ArgumentOutOfRangeException(nameof(s));
      } if (nTimes <= 1) {
        throw new ArgumentOutOfRangeException(nameof(nTimes));
      }
      return new StringBuilder().Insert(0, s, nTimes).ToString();
    }
    ```
  ],
)

== Iteratoren <iteratoren>
=== `foreach` Loop
#grid(
  [
    Wird für das _Iterieren über Collections_ verwendet. Mit ```cs continue``` wird zur nächsten Iteration fortgefahren,
    mit ```cs break``` wird der gesamte Loop beendet.

    *Syntax:*
    #v(-0.5em)
    ```cs foreach (ElementType elem in collection) {
     /* statements */
    }
    ```
    _Als Collection gilt,_ wenn ein Typ `IEnumerable` / `IEnumerable<T>` implementiert oder einer Implementation davon ähnelt
    #hinweis[(Typ hat Methode `GetEnumerator()` mit Return Type `e`, `e` hat eine Methode `MoveNext()` mit
    Return Type `bool`, `e` hat ein Property `current`)].\
    Ein `foreach`-Loop ist nur _Syntactic Sugar_ für einen Iterator.
  ],
  [
    ```cs
    List<int> list = new() { 1, 2, 3, 4, 5, 6 };
    foreach (int i in list) {
      if (i == 3) continue;
      if (i == 5) break;
      Console.WriteLine(i);
    } // Compiler Output:
    IEnumerator enumerator = list.GetEnumerator():
    try {
      while (enumerator.MoveNext()) {
        /* Statements aus foreach-Loop */
      }
    }
    finally {
      IDisposable disp = enumerator as IDisposable;
      if (disp != null) disp.Dispose();
    }
    ```
  ]
)
=== Iteratoren-Interface
#table(
  columns: (1fr, 1fr),
  table.header([Non-generic #hinweis[(eher nicht verwenden)]], [Generic #hinweis[(Best Practice)]]),
  [
    #small[
      ```cs
      public interface IEnumerable {
        IEnumerator GetEnumerator();
      }

      public interface IEnumerator {
        object Current { get; } // Aktuelles Objekt
        bool MoveNext();        // Hole nächstes Element
        void Reset();           // zum Ausgangsstand zurück
      }
      ```
    ]
  ],
  [
    #small[
      ```cs
      public interface IEnumerable<out T> : IEnumerable {
        IEnumerator<T> GetEnumerator();
      }

      public interface IEnumerator<out T>
        : IDisposable, IEnumerator {
          T current { get; }
          // Member von IEnumerator geerbt
        }
      ```
    ]
  ],
)

=== Iteratoren-Zugriff
Es sind mehrere aktive Iteratoren auf denselben Objekt erlaubt. Das Enumerator-Objekt muss den Zustand
der zu iterierenden Collection vollständig kapseln, ansonsten passieren unerwünschte Seiteneffekte.
_Implikation: Collection darf während Iteration nicht verändert werden._
Soll das geschehen, muss eine zweite Collection angelegt werden.

== yield
#grid(
  [
    Da eine "rohe" Implementation sowohl eines generischen als auch nicht-generischen Iterators _sehr aufwendig_ ist,
    gibt es das ```cs yield``` Keyword, um dessen Implementation zu vereinfachen, da es die entsprechenden `Enumerators`
    für uns generiert.

    - _`yield return`:_ Gibt den nächsten Wert für die nächste Iteration zurück. Beim nächsten Aufruf des Iterators wird von dieser Stelle an fortgefahren.
    - _`yield break`:_ Terminiert die Iteration
  ],
  [
    ```cs
    class MyIntList {
      public IEnumerator<int> GetEnumerator() {
        yield return 1;
        yield return 3;
        yield break;
        yield return 6;
      } // sehr simples Demonstrationsbeispiel
    }   // mit hardcodierten Werten
    // Returnt bei mehrmaligem Aufruf: 1 3
    // (ohne 6, wegen `yield break`)
    ```
  ]
)

Nun muss nur noch die `GetEnumerator()`-Methode #hinweis[(generisch oder nicht-generisch)] implementiert werden,
welche mindestens ein `yield return` beinhaltet. Die Implementation von `IEnumerable` ist optional, aber empfohlen.

== Spezifische Iteratoren
#grid(
  [
    *Standard Iterator*\
    Hier wird `yield return` erstmals in einem Loop verwendet und gibt jedes Element der Liste einmal zurück.
    Damit können Instanzen von `MyIntList` als Collection in einem `foreach`-Loop verwendet werden.
    ```cs MyIntList l = new();```\ ```cs foreach(int e in l) { ... }```

    *Spezifische Iterator-Methode*\
    Mit der _`Range`-Methode_ kann über einen Teil der Collection iteriert werden.
    Der Return Type ändert sich von `IEnumerator<T>` zu `IEnumerable<T>`.
    Um diesen Iterator im `foreach` zu erhalten, muss die spezifische Methode aufgerufen werden.\
    ```cs foreach (int e in l.Range(2, 7)) { ... }```

    *Spezifisches Iterator-Property*\
    Funktioniert ähnlich wie Methode, Property muss ebenfalls spezifisch aufgerufen werden. Eher selten verwendet.\
    ```cs foreach (int e in l.Reverse) { ... }```
  ],
  [
    ```cs
    class MyIntList {
      private int[] _x = new int[10];
      // Standard Iterator
      public IEnumerator<int> GetEnumerator() {
        for (int i = 0; i < _x.Length, i++) {
          yield return _x[i];
        } // yield break ist implizit
      }
      // Spezifische Iterator-Methode
      public IEnumerable<int> Range(int from, int to) {
        for (int i = from, i < to, i++) {
          yield return _x[i];
        }
      }
      // Spezifisches Iterator-Property
      public IEnumerable<int> Reverse {
        get {
          for (int i = _x.Length - 1; i >= 0; i--)
          {
            yield return _x[i];
          } } } }
    ```
  ]
)
=== Anleitung: Normale Methode zu Iterator Methode umschreiben
+ Verwendeter Collection-Typ in Signatur zu _`IEnumerable`_ umändern
+ Variable der Liste und _`return`-Statements_ entfernen, stattdessen überall, wo `Add()` o.ä. verwendet wird,
  durch ein _`yield return`_ ersetzen.

== Extension Methods <extension-methods>
#grid(
  [
    Extension Methods erlauben das _Erweitern bestehender Klassen_. Die Signatur der Klasse wird dadurch nicht verändert.
    Der Aufruf sieht jedoch so aus, als wäre es eine Methode der Klasse, der Compiler wandelt ihn in einen
    normalen statischen Methodenaufruf um. Typsicherheit ist gewährleistet.
    _Importieren der Klasse in Verwendungsort mit `using <classname>`._\
    *Deklaration:*
    - Muss in _statischer Klasse_ deklariert sein
    - Die Methode muss selbst _`static`_ sein
    - Der _erste Parameter_ muss angeben, auf welcher Klasse die Methode verwendbar ist und das _`this`-Keyword_ muss davorstehen.
  ],
  [
    ```cs
    public static class ExtensionMethods {
      static string ToStringSafe(this object obj) {
        return obj == null
          ? string.Empty : obj.ToString();
      }

      public static void TestExtensions() {
        int i = 0;
        i.ToString(); i.ToStringSafe(); // Beide OK
        object nullObj = null;
        nullObj.ToString();     // Runtime Error
        nullObj.ToStringSafe(); // OK
      }
    }
    ```
  ]
)
*Regeln:*
_Kein Zugriff auf interne Member_ aus Extension Method heraus,
Extension Method ist _nur sichtbar_, wenn der _Namespace importiert_ wird, in welcher die Methode definiert wurde #hinweis[(hier `ExtensionMethods`)].
Bei _Namenskonflikten_ gewinnt immer die Non-Extension-Methode.
Erlaubt auf Klassen, Structs, Interfaces, Delegates, Enumeratoren und Arrays.

== Deferred Evaluation
Ein Aufruf von `GetEnumerator()` oder `Range()` führt die Iterator-Methode noch nicht aus.
Erst der Aufruf von ```cs IEnumerator<T>.MoveNext()``` tut dies. Im `foreach`-Loop wird sie implizit aufgerufen.
#grid(
  [
    ```cs
    MyIntList list = new();
    // Keine Ausführung
    IEnumerator<int> er1 = list.GetEnumerator();
    IEnumerable<int> range = list.Range(4, 8);
    IEnumerator<int> er2 = range.GetEnumerator();

    er1.MoveNext(); // Ausführung
    int i1 = er1.Current;
    er2.MoveNext(); // Ausführung
    int i2 = range.GetEnumerator().Current;
    foreach (int i in range) { ... } // Ausführung
    ```
  ],
  [
    ```cs
    class MyIntList {
      public IEnumerator<int> GetEnumerator() {
        for (int i = 0; i < _x.Length, i++) {
          yield return i;
        }
      }

      public IEnumerable<int> Range(int from, int to) {
        for (int i = from, i < to, i++) {
          yield return i;
      } }
    ```
  ]
)
#pagebreak()
=== Extension Methods und Iteratoren <query-operator>
Der ganze bisherige Stoff dieses Kapitels zielt darauf ab, für _Collections neue Query-Operatoren_ schaffen zu können.
Diese werden als Extension Method auf `IEnumerable` erstellt. Damit lassen sich alle Collections, die davon ableiten,
um beispielweise _Filter- oder Gruppierungsmethoden_ erweitern. _Query-Methoden_ sollten immer einen `IEnumerable` zurückgeben,
damit mehrere davon mit dem "`.`"-Operator aneinandergehängt werden können. Sie werden ebenfalls "deferred" evaluiert.
#grid(
  [
    ```cs
    public static void Test() {
      object[] list { 4, 3.5, "abc", 3, 6 };

      // Hier noch keine Ausführung auf dem Array
      IEnumerable<int> res = list
        .QueryOfType<int>()
        .QueryWhere(k => k % 2 == 0);

      // Erst hier wird tatsächlich iteriert
      foreach (int i in res) { ... }

      // Schreibweise ohne Erweiterungssyntax
      // Verschachtelt, schlecht lesbar
      res = QueryWhere(
        QueryOfType<int>(list), k => k % 2 == 0));
      )
    }
    ```
  ],
  [
    ```cs
    static class QueryExtensions {
      // Filtert Collection nach mitgegebener Funktion
      public static IEnumerable<T> QueryWhere<T>(
        this IEnumerable<T> source,
        Predicate<T> pred)
      {
        foreach (T item in source) {
          if (predicate(item)) { yield return item; }
        }
      }
      // Filtert Collection nach mitgegebenem Typ
      public static IEnumerable<T> QueryOfType<T>(
        this IEnumerable source)
      {
        foreach (object in source) {
          if (item is T) { yield return (T)item; }
    } } }
    ```
  ]
)

#align(center)[#image("img/dotnet_17.png", width: 50%, fit: "contain")]

= LINQ (Language Integrated Query)
Mit LINQ können von beliebigen Datenstrukturen mit SQL-ähnlichen Queries Daten _typsicher bearbeitet_ werden.
LINQ erlaubt es _Funktional_ #hinweis[(durch Lambda Expressions)] und
_Deklarativ_ #hinweis[(durch Anonymous Types und Object Initializers)] zu arbeiten und verbessert
_Type Inference_ #hinweis[(Weglassen von redundanten Typ-Informationen)].

LINQ ist die _Schnittstelle_ zwischen den _.NET-Sprachen_ und _Datenquellen_. Die Architektur basiert auf dem Provider-Modell,
das heisst, für jeden Datentyp gibt es einen eigenen LINQ-Provider #hinweis[(LINQ to Objects, to Entities, to SQL, to XML etc.)].

==== Beispiel Provider: LINQ to Objects
#grid(
  [
    Im LINQ to Objects-Provider werden _Abfragen auf die Objektstruktur_ durchgeführt. Es können mehrere Abfragen
    aneinandergekettet werden, es muss aber am Ende eine Immediate-Evaluation-Query stehen, um die Daten zu erhalten
    #hinweis[(siehe Kapitel @immediate-evaluation)].\

    _Query 1_ ist die simpelst mögliche LINQ-Abfrage: Es werden alle Elemente im Objekt ausgewählt und wieder zurückgegeben.

    In _Query 2_ wird zuerst nach Namen gefiltert, welche mit "B" beginnen, diese dann sortiert und zurückgegeben.
  ],
  [
    ```cs
    string[] cities = { "Bern", "Basel", "Zürich", "Rapperswil", "Genf" };
    // q = query expression, l = extension method
    // Query 1: Reine Selektion
    IEnumerable<string> q1 =
      from c in cities select c;
    IEnumerable<string> l1 = cities.Select(c => c);

    // Query 2: Alle Namen mit B sortieren
    IEnumerable<string> q2 =
      from c in cities
      where c.StartsWith("b")
      orderby c
      select c;
    IEnumerable<string> l2 = cities
      .Where(c => c.StartsWith("B"))
      .OrderBy(c => c).Select(c => c);
    ```
  ]
)

== LINQ Extension Methods
#grid(
  [
    LINQ _definiert_ eine _Vielzahl an Query Operatoren_, welche wie in Kapitel @query-operator `IEnumerable<T>` implementieren und
    sind vom Aufbau her diesen sehr ähnlich.

    Query Operatoren sind ebenfalls mit _`yield return`_ implementiert, unterstützen also deferred evaluation.
    Queries können _beliebig oft_ ausgeführt werden und die Resultate können sich aufgrund veränderter Daten auch _unterscheiden_.
  ],
  [
    ```cs
    string[] cities = { "Bern", "Basel", "Zürich", "Rapperswil", "Genf" };
    IEnumerable<string> citiesB = cities
      .Where(c => c.StartsWith("B"));

    // Run 1: iteriert durch 2 Städte (Bern, Basel)
    foreach (string c in citiesB) { ... }

    cities[0] = "Luzern";
    // Run 2: iteriert nur durch 1 Stadt (Basel)
    foreach (string c in citiesB) { ... }
    ```
  ]
)

=== Immediate Evaluation <immediate-evaluation>
#grid(
  [
    Einige Methoden führen die gesamte Kette an Queries direkt aus. Queries mit _Immediate Evaluation_ haben einen Return Type,
    welcher nicht `IEnumerable` ist.\

    *Beispiele:* `ToList()`, `ToArray()`, `Count()`, `First()`, `Last()`, `Sum()`, `Average()`\

    Die _Resultate_ dieser Queries werden direkt in die _Variable gespeichert_.
  ],
  [
    ```cs
    string[] cities = { "Bern", "Basel", "Zürich", "Rapperswil", "Genf" };
    
    List<string> citiesB = cities
      .Where(c => c.StartsWith("B"))
      .ToList(); // Ausführung
    
    int citiesEndLCount = cities
      .Where(c => c.EndsWith("l"))
      .Count(); // Ausführung
    ```
  ]
)

=== Wichtigste Query Operatoren
#small[
  #table(
    columns: (1fr, 1fr, 1fr),
    table.header([Standard], [Positionelle Operatoren], [Set Operationen]),
    [`Select()`],
    [`First()`, `FirstOrDefault()`\ #hinweis[Erstes passendes Element für Prädikat]],
    [`Distinct()`\ #hinweis[Nur einzigartige Elemente]],

    [`Where()`],
    [`Single()`, `SingleOrDefault()`\ #hinweis[Wie `First`, throwt wenn nicht genau 1 Element]],
    [`Union()`\ #hinweis[Einzigartige Elemente zweier Mengen]],

    [`OrderBy()`, `OrderByDescending()`],
    [`ElementAt()`\ #hinweis[Element an angegebenem Index]],
    [`Intersection()`\ #hinweis[Überschneidende Elemente zweier Mengen]],

    [`ThenBy()`, `ThenByDescending()`],
    [`Skip()`, `Take()`, \ #hinweis[Die nächsten $n$ Elemente skippen/returnen]],
    [`Except()`\ #hinweis[Elemente aus Menge A, welche in B fehlen]],

    [`GroupBy()`],
    [`SkipWhile()`, `TakeWhile()` \ #hinweis[Elemente skippen/returnen bei passendem Prädikat]],
    [`Repeat()`\ #hinweis[$n$-fache Kopie der Liste]],

    [`Join()`, `GroupJoin()`], [`Reverse()`\ #hinweis[Alle Elemente in umgekehrter Reihenfolge]], [],
    [`Count()`, `Sum()`, `Min()`, `Max()`, `Average()`], [], [],
  )
]

== Object Initializers
#grid(
  [
    Hat man _verschachtelte Objekte_, ist es sehr mühsam, diese zu initialisieren und die gewünschten Werte zu setzen.
    Um dies zu vereinfachen, gibt es die _Object Initializers_. Sie erlauben das Instanzieren und Initialisieren einer Klasse
    in einem Statement, auch ohne passenden Konstruktor.

    *Syntax*\
    - _Default Constructor_\
      ```cs new class { member = value, ... }```
    - _Spezieller Konstruktor_\
      ```cs new class(args) { member = value, ... }```

    Die Initializer werden vom Compiler in simple Member Assignments umgewandelt.

    Object Initializers werden vor allem in _Lambda Expressions_ häufig verwendet, meistens in Kombination mit
    der Extension-Methode `Select()`.
  ],
  [
    ```cs
    class Student {
      public string Name;
      public int Id;
      public string Subject { get; set; }
      public Student() { ... }
      public Student(string name) { Name = name }
    }
    Student s1 = new("Nina") {
      Id = 69420,
      Subject = "Multimedia Production"
    }
    Student s2 = new() {
      Id = 30035
      Name = "Jannis"
      Subject = "Master of Desaster"
    }
    // Generiert aus IDs 'Student' objects
    int[] ids = { 404, 666, 2048 };
    IEnumerable<Student> students = ids
      .Select(n => new Student { Id = n });
    ```
  ]
)

== Collection Initializers
#grid(
  [
    Mit einer ähnlichen Syntax ist es auch möglich, _Collections_ und _Dictionaries_ zu _initialisieren_.
    Dictionaries haben zwei verschiedene Syntaxen: regulär und via Indexer. Die resultierenden Dictionaries sind aber gleich.

    ==== Syntax
    _Collections_\
    ```cs new collection { elem1, ..., elemN }```\
    _Dictionaries_\ #v(-0.6em)
    ```cs
    new dictionary {
      { key1, val1 }, ..., { keyN, valN } };
    ```
    ```cs
    new dictionary {
      { [key1], val1 }, ..., { [keyN], valN } };
    ```
  ],
  [
    ```cs
    List<int> l1 = new() { 1, 2, 3, 4 }
    double[2, 2] a = {
      [0, 0] = 1.2, [0, 1] = 5.9,
      [1, 0] = 7.5, [1, 1] = 0.9
    };

    Dictionary<int, string> d = new() { // Regulär
      { 1, "a" },
      { 2, "b" },
      { 3, "c" }
    };
    Dictionary<int, string> d2 = new() { // via Index
      [1] = "a",
      [2] = "b",
      [3] = "c"
    };
    ```
  ]
)

== Type Inference
#grid(
  columns: (3.25fr, 1fr),
  [
    Mit Type Inference kann der _statische Typ_ einer Variable _vom Compiler_ selbst bestimmt werden.
    Anstelle des Typen wird das _Keyword `var`_ verwendet. Dazu müssen aber Deklaration und Initialisierung
    im gleichen Statement sein, da der _Typ_ aus dieser _initialen Zuweisung abgeleitet_ wird.
    Der Compiler ersetzt dann _`var`_ durch den eigentlichen Typen. `var` kann nur für lokale Variablen, nicht aber
    für Parameter, Return Types, Klassenvariablen, Properties etc. verwendet werden.
  ],
  [
    ```cs
    // Entspricht string v
    var v = "Hello";
    // 2x Compilerfehler
    v = 42;
    var w;
    ```
  ],
)
*Vorteile:* Bessere Lesbarkeit des Codes #hinweis[(lange Typen wie ```cs Dictionary<string, IComparable<object>>```
können bei der Deklaration wegfallen)], erlaubt anonyme Typen.

== Anonymous Types
_Zwischenresultate_ in Abfragen müssen irgendwie _gespeichert_ werden, gelten aber meistens nur für diese Abfrage.
Es macht keinen Sinn, dafür eine eigene Klasse bzw. Typ zu erstellen, aber es muss dennoch ein konkreter Typ dafür existieren.

#grid(
  [
    Hier kommen Anonymous Types ins Spiel: Damit können strukturierte Werte _erzeugt_ werden, ohne dafür einen eigenen Typ
    definieren zu müssen. Die _Propertynamen_ können dabei _Explizit_ #hinweis[(Variable `a`)] oder
    _implizit_ #hinweis[(Variable `b`)] sein.

    Die anonymen Typen von `a` und `b` sind _identisch_, können also wiederverwendet werden.
  ],
  [
    ```cs
    var a = new { Id = 1, Name = "Nina" };
    var b = new { a.Id, a.Name };
    var query = studentList
      .GroupBy(s => s.Subject)
      .Select(grp => new {  // Neuer Anonymer Typ
        Subject = grp.Key,  // Subject-Name
        Count = grp.Count() // Anzahl
      });
    ```
  ]
)

*Regeln:*
Die generierten Properties #hinweis[(hier `Id`, `Name`)] sind _read-only_,
Implizite/Explizite Propertynamen können gemischt werden,
Anonymer Typ direkt von `System.Object` abgeleitet #hinweis[(hat deswegen `Equals()`, `GetHashCode()`, `ToString()`)],
kann nur einer Variable vom Typ `var` zugewiesen werden.

== Query Expressions
#grid(
  [
    Neben den Extension Method gibt es noch eine zweite Syntax, um LINQ Queries zu schreiben:
    Die von SQL inspirierten Query Expressions. Es gibt folgende Query-Keywords:
    - _`from`:_ Definiert Range-Variable & Datenquelle
    - _`select`:_ Rückgabe durch Projektion auf Elementtypen
    - _`where`:_ Filter nach Kriterium
    - _`orderby`:_ Sortieren
    - _`group ... by ... [into]`:_\ Zusammenfassen von Elementen in Gruppen
    - _`join ... on`:_ Verknüpfung zweier Datenquellen
    - _`let`:_ Definition von Hilfsvariablen
  ],
  [
    ```cs
    int[] numbers = { 0, 1, 2, 3 };
    var numQuery = from num in numbers
                   where (num % 2) == 0
                   select num;

    var q1 = from s in students
             where s.Subject = "Informatik"
             orderby s.Name
             select new { s.Id, s.Name };
    // wird vom Compiler umgewandelt in
    var q1 = students
        .Where(s => s.Subject == "Informatik")
        .OrderBy(s => s.Name)
        .Select(s => new { s.Id, s.Name });
    ```
  ]
)

Eine Query _beginnt_ immer mit _`from`_ und _endet_ mit _`select`_ oder _`group`_.
Die Query Expressions werden vom Compiler wieder in die Extension Method Syntax umgewandelt.\
*Return Type bei `new{}`:* ```cs IEnumerable<AnonymousType{ /* return elements */ }>```


=== Range Variablen
#grid(
  [
    Bei `from`, `join` und `into` werden _Resultate_ in _Range Variablen_ gespeichert. Diese sind _read-only_.
    Sie dürfen nicht denselben Namen wie äussere lokale Variablen haben.
    Range Variablen sind innerhalb der Expression bis zur nächsten `into`-Klausel sichtbar.
  ],
  [
    ```cs
    // Range Variablen in Query: s, m, g
    var q = from s in students
    join m in Markings on s.Id equals m.StudentId
    group s by s.Subject into g
    select g;
    ```
  ]
)

#v(-0.25em)
=== Gruppierung
#grid(
  [
    Besteht aus `group`, `by` und optional `into`-Keywords.\
    Die Werte werden zu _Key/Value Pairs_ in ein _`IGrouping<TKey, TElement>`_ #hinweis[(Subklasse von `IEnumerable`)]
    zusammengefasst. Der Key ist der Wert nach dem `by`, die Values nach dem `group`.
    Im Beispiel wäre der Key `Subject` und die Values `Name`.

    _`into`_ speichert das Resultat in eine Variable `g`.
    _`s`_ ist dann _nicht mehr sichtbar_, `g` kann als Gruppe weiterverwendet werden.\
    Es ist also nicht möglich, im anonymen Typen von `select` Werte hinzuzufügen, welche nicht im
    `group by`-Statement und damit in `g` gespeichert sind #hinweis[(Keine Werte aus `s`)].
  ],
  [
    ```cs
    var q1 = from s in students
             group s.Name by s.Subject;
    foreach (var group in q1) {
      Console.WriteLine(group.Key);
      foreach (var name in group) {
        Console.WriteLine($"- {name}"); } }

    var q2 = from s in students
             group s.Name by s.Subject into g
             select new
             { Field = g.Key, N = g.Count() };
    foreach (var in q2)
      { Console.WriteLine($"{x.Field}: {x.N}") }
    ```
  ]
)
#v(-0.5em)
=== Explizite Inner Joins
#grid(
  [
    _Verknüpft zwei Mengen_ über einen Key mit den _`join`_ und _`on`_-Keywords.
    Verknüpfung muss zwingend über `equals` und nicht #no-ligature[`==`] erfolgen.
  ],
  [
    ```cs
    var q = from s in students
            join m in Markings
              on s.Id equals m.StudentId
            select s.Name + ", " + m.Course
                          + ", " + m.Mark;
    ```
  ]
)

#v(-1.25em)
=== Implizite Inner Joins
#grid(
  [
    _Verknüpft zwei Mengen_ über einen Key mit den _`from`_ und _`where`_-Keywords.
    Es kann sowohl `equals` als auch #no-ligature[`==`] verwendet werden. Weniger effizient, da Kreuzprodukt gebildet wird.
  ],
  [
    ```cs
    var q = from s in students
            from m in Markings
              where s.Id equals m.StudentId
            select s.Name + ", " + m.Course
                          + ", " + m.Mark;
    ```
  ]
)

#v(-0.5em)
=== Group Joins
#grid(
  [
    _Pro Student_ wird eine _Liste aller Markings_ erstellt.
    Die Range Variable `s` bleibt sichtbar, im Gegensatz zum `group-by-into`-Ansatz.
  ],
  [
    ```cs
    var q = from s in students
            join m in Markings
              on s.Id equals m.StudentId
              into list
            select new { Name = s.Name, Marks = list };
    ```
  ],
)

#v(-1.5em)
=== Left Outer Joins
#grid(
  [
    _Verknüpft zwei Mengen_ über einen Key. Wenn kein rechtes Element gefunden wurde,
    verbleibt linkes Element trotzdem in der Liste.

    Der Join basiert auf dem Group Join mit anschliessender `from`-Klausel.
    Hier wird mit ```cs DefaultIfEmpty()``` ein möglicher `null` Zugriff verhindert.
  ],
  [
    ```cs
    var q = from s in students
            join m in markings
              on s.Id equals m.StudentId
              into list
            from sm in list.DefaultIfEmpty()
            select s.Name + ", " + (sm == null
              ? "?"
              : sm.Course + ", " + sm.Mark);
    ```
  ],
)

#v(-1em)
=== `let`-Klausel
#grid(
  [
    Erlaubt das _Definieren von Hilfsvariablen_. Nützlich, um Zwischenresultate abzuspeichern.
    Kein direktes Equivalent in der Expression Syntax.
  ],
  [
    ```cs
    var q = from s in students
            let year = s.Id / 1000
            where year == 1996
            select s.Name + " " + year.ToString();
    ```
  ],
)

#v(-1em)
=== Select Many
#grid(
  [
    _Erleichtert das Zusammenfassen verschachtelter Listen._ Führt für jedes Listenelement auf oberster Stufe den Selector aus
    #hinweis[(im Beispiel pro Zeile)]. Diese liefert selbst eine (Teil-)Liste. Teillisten werden untereinander gehängt.

    *Anwendung:*
    #v(-0.5em)
    ```cs
    foreach (string line in q1)
      { Console.Write($"{line}.") }
    // Output: a.b.c.1.2.3.ä.ö.ü.
    ```
  ],
  [
    ```cs
    List<List<string>> list = new() {
      new() { "a", "b", "c" },
      new() { "1", "2", "3" },
      new() { "ä", "ö", "ü" }
    };
    var q1 = list.SelectMany(s => s);
    // Equivalent zu:
    var q2 = from segment in list
             from token in segment
             select token;
    ```
  ],
)

= Tasks & Async/Await
== Tasks
#grid(
  [
    Ein Task ist ein _Platzhalter_ für ein Ergebnis, das noch nicht bekannt ist. Repräsentiert eine _asynchrone_ Operation.
    Ist ein _first-class citizen_.\
    *Anwendungsfälle:*
    Waiting, Returning Results, Cancellation, Pause / Resume, Composition of tasks, Processing errors, Debugging, ...
  ],
  [
    ```cs
    Task task = Task
      .Run(() => { /* some workload */ } )
      .ContinueWith(t => 1234);

    task.Wait();
    ```
  ]
)

#table(
  columns: (1fr, 1fr),
  table.header([Task], [Thread]),
  [
    - Hat Rückgabewert
    - Unterstützt "Cancellation" via Token
    - Mehrere parallele Operationen in einem Task
    - Vereinfachter Programmfluss
    - eher ein "high level" Konstrukt
  ],
  [
    - Hat keinen Rückgabewert
    - Keine "Cancellation"
    - Nur eine Operation in einem Thread
    - Keine Unterstützung für async / await
    - eher ein "low level" Konstrukt
  ],
)

=== Task API
#grid(
  [
    *Starten eines Tasks:*
    Via Factory #hinweis[(`t1`, bietet weitere Optionen)] oder direkt via Task mit Default-Values #hinweis[(`t2`)].

    *Resultat abwarten:*
    Busy Wait, Expliziter `Wait()` #hinweis[(Unterstützt auch Timeouts)] oder via Awaiter #hinweis[(Optimiertes Exception Handling)]

    *Achtung:*
    Synchrone Waits sind gefährlich, weil sie den aktuellen Thread blockieren #hinweis[(z.B. den UI Thread in GUI Applikationen)].\
    
    _Blockierende Task-APIs:_ `Task.Result`, `Task.Wait()``, Task.WaitAll(),` etc.
  ],
  [
    ```cs
    Task<int> t1 = Task.Factory.StartNew(
      () => { Thread.Sleep(2000); return 1; }
    );
    Task<int> t2 = Task.Run(
      () => { Thread.Sleep(2000); return 1; }
    );
    // Busy wait for result (bad idea!)
    while (!t1.IsCompleted) { /* Do other stuff */ }
    int result1 = t1.Result;
    // Explicit wait
    t1.Wait(); int result2 = t1.Result;
    // Using awaiter
    int result3 = t1.GetAwaiter().GetResult();
    ```
  ]
)

=== Synchrone waits vs. Continuations
#v(0.5em)
#grid(
  [
    *Synchrone Waits (blockierend)*
    #v(-0.5em)
    ```cs
    Task<int> t1 = GetSomeCustomerIdAsync();
    // Blockiert aktuellen Thread
    int id = t1.Result;

    Task<string> t2 = GetOrdersAsync(id);
    // Blockiert aktuellen Thread
    Console.WriteLine(t2.Result);
    ```
  ],
  [
    *Continuations (nicht blockierend)*
    #v(-0.5em)
    ```cs
    Task<int> t1 = GetSomeCustomerIdAsync();
    t1.ContinueWith(id => {
      // Resultat schon vorhanden, nicht blockierend
      Task<string> t2 = GetOrdersAsync(id.Result);
      t2.ContinueWith(order =>
        // Resultat schon vorhanden, nicht blockierend
        Console.WriteLine(order.Result)
      );
    });
    ```
  ]
)

== Async / Await
#table(
  columns: (1fr, 1fr),
  table.header([Synchrone Operation], [Asynchrone Operation]),
  [
    Durchläuft die gesamte Logik und returnt anschliessend aus der Methode. Blockiert den Aufrufer, bis diese fertig gelaufen ist.
  ],
  [
    Ruft eine Methode auf, ohne auf das Resultat zu warten. Möglichkeit zur Benachrichtigung bei Fertigstellung oder
    Rückgabe eines "Task"-Objekts, auf welchem Status abgefragt werden kann.
  ],
)

=== Async
Markiert die Methode als "asynchron". Hat _eingeschränkte Rückgabewerte:_ `Task` #hinweis[(ohne Rückgabewert)],
`Task<T>` #hinweis[(Rückgabewert `T`)] und
`void` #hinweis[(Fire and Forget, sollte vermieden werden, da Erfolg des Tasks nicht überprüft werden kann)]

=== Await
Alles nach `"await"` wird vom Compiler zu einer "Continuation" umgewandelt. _Nur in "async" Methoden erlaubt._

=== Beispiel: Auslesen von Files
Liest zwei Dateien parallel aus, wartet nicht blockierend, verwendet Resultate.
```cs
Task<string> t1 = File.ReadAllTextAsync(@"C:\DotNetPrüfungLösungen.txt");
Task<string> t2 = File.ReadAllTextAsync(@"C:\BreathOfTheWildStrats.txt");
// do other stuff...
string[] allResults = await Task.WhenAll(t1, t2); // Blockiert aktuellen Thread nicht
// Resultate auslesen
Console.WriteLine(t1.Result); Console.WriteLine(t2.Result); // Zugriff wäre auch via `allResults` möglich
```

=== async / await vs. Continuation
#v(0.25em)
#grid(
  [
    *async / await (nicht blockierend)*
    #v(-0.5em)
    ```cs
    int id = await GetSomeCustomerIdAsync();
    // Resultate direkt im Zugriff
    string t2 = await GetOrdersAsync(id);
    Console.WriteLine(t2);
    ```
    Der Compiler generiert aus `async`/`await` im Hintergrund Continuations.
  ],
  [
    *Continuations (nicht blockierend)*
    #v(-0.5em)
    ```cs 
    Task<int> t1 = GetSomeCustomerIdAsync();
    t1.ContinueWith(id => {
      // Resultat schon vorhanden, nicht blockierend
      Task<string> t2 = GetOrdersAsync(id.Result);
      t2.ContinueWith(order =>
        // Resultat schon vorhanden, nicht blockierend
        Console.WriteLine(order.Result)
      ); });
      ```
  ]
)

=== Beurteilung
#table(
  columns: (1fr, 1fr),
  table.header([Vorteile], [Nachteile]),
  [
    - Code sieht immer noch synchron aus
    - Keine Continuations nötig
    - Ersetzt Multithreading für asynchrone Ausführungen
  ],
  [
    - Overhead ist relativ gross
    - Lohnt sich daher erst bei "längeren" Operationen
    - `await` nicht erlaubt in lock-Statements und in älteren Versionen von `catch`- und `finally`-Blöcken
  ],
)

== Cancellation Support
#grid(
  [
    Ein _Cancellation Token_ ist ein integriertes Programmiermodell für das Abbrechen von Programmlogik.
    Verwendet die Klasse _`CancellationToken`_. Muss durch die gesamte Aufrufkette durchgereicht werden,
    letzter Parameter jeder asynchronen Methode.

    ==== Manueller Abbruch
    Überprüfung, ob ein Abbruch angefordert wurde, geht via _`IsCancellationRequested` Property_ oder
    via _`ThrowIfCancellationRequested()` Methode_, welche eine `OperationCanceledException` wirft.
  ],
  [
    ```cs
    static async Task PauseAsync(CancellationToken ct) {
        // kann durch `ct` abgebrochen werden
        await Task.Delay(10_000, ct);
    }
    static void ManualCancellation(CancellationToken ct) {
      for (int i = 0; i < 100; i++) { /* ... */
        // Property-Variante
        if (ct.IsCancellationRequested) { /* ... */ }
        // Methoden-Variante
        ct.ThrowIfCancellationRequested(); // Exception
      } }
    ```
  ]
)

=== Cancellation Token Source
Klasse zur Erstellung und Steuerung von Cancellation Tokens. Kann beliebig viele Tokens emittieren, diese sind dann
an diese Source gebunden. Beim Auslösen des Abbruchs an einer Source wird für alle Tokens dieser Source ein Abbruch angefordert.
Es sollte ein Token pro "Unit of Work" generiert werden #hinweis[(alles was zusammenhängt)]

#grid(
  columns: (2.6fr, 1fr),
  [
    ```cs
    CancellationTokenSource cts = new();   // Emittierende Source
    CancellationToken ct = cts.Token;      // Neuer Token generieren
    Task t1 = LongRunning(1_000, ct);      // 1s tied to `cts`
    Task t2 = LongRunning(3_000, ct);      // 3s tied to `cts`
    Task t3 = LongRunning(3_001, default); // 3s independent / not cancellable

    await Task.Delay(2_000, ct);

    Console.WriteLine("Cancelling");       // Abbruch von `t1` & `t2` 
    cts.Cancel();                          // aber `t1` ist schon fertig,
    Console.WriteLine("Canceled");         // darum wird nur `t2` abgebrochen

    async Task LongRunning(int ms, CancellationToken ct) {
      Console.WriteLine($"{ms}ms Task started.");
      await Task.Delay(ms, ct);
      Console.WriteLine($"{ms}ms Task completed.");
    };
    ```
  ],
  [
    ```
    Console
    ----------------------------
    1000ms Task started.
    3000ms Task started.
    3001ms Task started.
    1000ms Task completed.
    Cancelling
    Canceled
    3001ms Task completed.
    ```
  ],
)


= Entity Framework
Das Entity Framework #hinweis[(bzw. EF Core)] ist ein _O/R Mapping Framework_.
Es verbindet _Objektorientiertes_ #hinweis[(Domain Model)] mit _Rationalem_ #hinweis[(Relational Model)].
Das EF hat diverse _Basis-Funktionalitäten:_ Mapping von Entitäten, CRUD Operationen #hinweis[(Create, Read, Update, Delete)],
Key-Generierung, Caching, Change Tracking, Optimistic Concurrency, Transactions und eine eigene CLI.

Wie LINQ ist das Entity Framework _providerbasiert._ Es sind für die allermeisten relationalen SQL-DBs Provider auf NuGet verfügbar.

== OR-Mapping
Das OR-Mapping mappt .NET-Objekte auf relationale Tabellen in DBs. Dabei stellt eine .NET-Klasse einen _Entity Type_ und
die Tabelle #hinweis[(oder anderes relationales Modell)] eine _Storage Entity_ dar. Das Mapping sorgt für die Konvertierung.

- _Entität:_ Strukturierter Datensatz mit einem Key, Instanz eines "Entity Type", gruppiert in "Entity Sets",
  kann von anderen Entitäten erben.
- _Relationship/Association:_ Definiert Beziehung zwischen zwei Entity Types, zwei Enden mit Kardinalitäten.
  Abgebildet durch Navigation Properties #hinweis[(Association Sets)] und Foreign Keys.

#table(
  columns: (auto, 1fr, 1fr),
  table.header([], [Entity Type], [Storage Entity]),
  [*Ausprägungen*], [Klasse], [Table, View, Stored Procedures, Graph, Collection],

  [*Inhalte*],
  [Properties, Entity Keys, Alternate Keys, Relationships/Associations, Foreign Keys],
  [Columns, Primary Key, Unique Key Constraints, Foreign Keys],
)

Das Entity Framework bietet drei Ansätze, um mit dem Mapping zu starten:
- _Database First:_ Der Datensatz besteht schon, aus dieser Struktur wird passender Code generiert
- _Model First:_ Es wird zuerst ein Model erstellt, aus welchem DB und Code generiert werden. Veraltet.
- _Code First:_ Aus bestehenden Codestrukturen wird die Datenbankstruktur generiert

== OR-Model
Beim _Kreieren des Models_ für das Mapping gibt es _keine Vorgaben_ bezüglich Basisklassen, zu implementierenden Interfaces,
Konstruktoren etc. Auf die Werte wird via Properties zugegriffen.

Es gibt drei verschiedene Ansätze für das Mapping. Es muss jeweils nur einer verwendet worden, in den Beispielen
werden jedoch alle drei aufgezeigt.
- _Mapping By Convention_ #hinweis[(automatisches Mapping ohne explizite Konfiguration)]
- _Mapping By Attributes/Data Annotations_ #hinweis[(Durch Attribute direkt an Klassen/Properties)],
- _Mapping By Fluent API_ #hinweis[(Model Builder mit LINQ-Extension-Method ähnlichen Queries
  und überschreiben von `OnModelCreating()`)]

Folgende Elemente werden gemapped:
#v(-0.5em)
#grid(
  [
    - Entity Type $<=>$ Storage Type
    - Property $<=>$ Column
  ],
  [
    - Entity Key $<=>$ Primary Key
    - Relationship $<=>$ Foreign Key
  ]
)

=== Include/Exclude von Entities
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    _Alle Klassen werden gemapped_, wenn ein `DbSet`-Property im Context vorhanden ist.
    Indirekt werden Klassen auch via Navigation Properties gemapped #hinweis[(Relationships, hier `Products` und `Metadata`)].

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>()``` bzw. ```cs Ignore<T>()```.

    *`(3)` Data Annotations*\
    Es werden alle Entities gemapped, ausschliessen durch ```cs [NotMapped]``` Annotation an Klasse.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; } // (1)
      protected override void OnModelCreating(
         ModelBuilder modelBuilder) {
        modelBuilder.Entity<AuditEntry>(); // (2)
        modelBuilder.Ignore<Metadata>(); // (2)
      }
    }
    public class Category {
      public int Id { get; set; }
      public string Name { get; set; }
      public ICollection<Product> Products { get; set; } //(1)
      public ICollection<Metadata> Metadata { get; set; } //(1)
    }
    public class Product { ... }
    public class AuditEntry { ... }
    [NotMapped] // (3)
    public class Metadata { ... }
    ```
  ],
)

#pagebreak()

=== Include/Exclude von Properties
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Alle `public` Properties mit Getter und Setter werden gemapped.

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>().Property()``` bzw. ```cs Entity<T>().Ignore()```.

    *`(3)` Data Annotations*\
    Es werden alle Properties gemapped, durch ```cs [NotMapped]``` Annotation an Property
    können bestimmte Properties ausgeschlossen werden.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .Property(b => b.Name); // (2)
        modelBuilder.Ignore<Metadata>()
         .Ignore(b => b.LoadedFromDatabase); // (2)
      }
    }
    public class Category {
      public int Id { get; set; } // (1)
      public string Name { get; set; } // (1)
      [NotMapped] //(3)
      public DateTime LoadedFromDatabase { get; set; }
    }
    ```
  ],
)
#v(-0.5em)
=== Keys
#grid(
  columns: (0.75fr, 1fr),
  [
    Für Primary Keys siehe @ef-primary-key\
    *`(1)` Convention*\
    Property mit Namen "[Entity]Id"\ #hinweis[(z.B. `Category.Id` oder `Category.CategoryId`)]

    *`(2)` Fluent API* \
    In ```cs OnModelCreating()``` durch \ ```cs Entity<T>().HasKey()```. Einzige Möglichkeit für Composite Primary Keys.

    *`(3)` Data Annotations*\
    ```cs [Key]``` Annotation an Property.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .HasKey(e => e.Id); // (2)
    } }
    public class Category {
      [Key] // (3)
      public int Id { get; set; } // (1)
      public string Name { get; set; }
      [NotMapped] // (3)
      public DateTime LoadedFromDatabase { get; set; }
    }
    ```
  ],
)
#v(-0.5em)
=== Required, Optional, Nullability
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Nullable Types sind ```sql NOT NULL```, non-nullable ```sql NULL```.
    Ausnahme: Wenn nullable Reference Types deaktiviert sind, sind sämtliche Reference Types ```sql NULL```.

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>().Property().IsRequired([true|false])```.

    *`(3)` Data Annotations*\
    ```cs [Required]``` oder ```cs [Required(false)]``` Annotation an Property.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .Property(e => e.Name)
         .IsRequired(); // (2)
        modelBuilder.Entity<Category>()
         .Property(e => e.Description)
         .IsRequired(false); // (2)
    } }
    public class Category {
      public int Id { get; set; }
      [Required] // (3)
      public string Name { get; set; }
      [Required(false)] // (3)
      public string? Description { get; set; } }
    ```
  ],
)
#v(-0.5em)
=== Maximum Length
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Keine Restriktion, bzw. nur durch DB selbst: ```sql NVARCHAR(MAX)```. Bei Keys Limit von 450 Zeichen.

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>().Property()```\ ```cs .HasMaxLength(int)```.

    *`(3)` Data Annotations*\
    ```cs [MaxLength(int)]``` Annotation an Property.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .Property(e => e.Name)
         .HasMaxLength(500); // (2)
      } }
    public class Category {
      public int Id { get; set; }
      [MaxLength(500)] // (3)
      public string Name { get; set; }
    }
    ```
  ],
)

=== Unicode
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Strings sind immer Unicode durch ```sql NVARCHAR```.

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>().Property()```\ ```cs .IsUnicode([true|false])```.

    *`(3)` Data Annotations*\
    ```cs [Unicode]``` oder ```cs [Unicode(false)]``` Annotation an Property.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .Property(e => e.Name)
         .IsUnicode(false); //(2)
      }
    }
    public class Category {
      public int Id { get; set; }
      [Unicode(false)] //(3)
      public string Name { get; set; }
    }
    ```
  ],
)

=== Precision
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Pro Datentyp im Provider festgelegt.\
    #hinweis[(Precision: Anzahl Digits total, Scale: Anzahl Nachkommastellen)]

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch\ ```cs Entity<T>().Property()```\ ```cs .HasPrecision(precision, scale)```\
    oder ```cs .HasPrecision(precision)```.

    *`(3)` Data Annotations*\
    ```cs [Precision(precision, scale)]``` oder ```cs [Precision(precision)]``` Annotation an Property.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .Property(e => e.Price)
         .HasPrecision(10, 2); // HasPrecision(10); (2)
      }
    }
    public class Category {
      public int Id { get; set; }
      [Precision(10, 2)] // [Precision(10)] (3)
      public decimal Price { get; set; }
    }
    ```
  ],
)

=== Indexes

#grid(
  columns: (0.75fr, 1fr),
  [
    Es gibt drei verschiedene Indextypen:
    - _Non-unique Index_ #hinweis[(z.B. Kategorien)]
    - _Unique Index_ #hinweis[(z.B. Keys)]
    - _Multi-Column-Index_ #hinweis[(besteht aus mehreren Spalten)]

    *`(1)` Convention*\
    Werden bei Foreign Keys automatisch erstellt.

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch\ ```cs Entity<T>().HasIndex()``` #hinweis[(Non-unique)]\
    ```cs .HasIndex().IsUnique()``` #hinweis[(Unique)]\
    ```cs .HasIndex(x => new { ... })``` #hinweis[(Multi-Column)]

    *`(3)` Data Annotations*\
    ```cs [Precision(name)]``` #hinweis[(Non-Unique)]\
    ```cs [Precision(name, IsUnique = true)]``` #hinweis[(Unique)]\
    ```cs [Precision(name1, name2,...)]``` #hinweis[(Multi-Column)]
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .HasIndex(b => b.Name); // (2)
        modelBuilder.Entity<Category>()
         .HasIndex(b => b.Name)
         .IsUnique(); // (2)
        modelBuilder.Entity<Category>()
         .HasIndex(b => new { b.Name, b.IsActive }); // (2)
      }
    }
    [Index(nameof(Name))] // (3)
    [Index(nameof(Name), IsUnique = true)] // (3)
    [Index(nameof(Name), nameof(IsActive))] // (3)
    public class Category {
      public int Id { get; set; }
      public string Name { get; set; }
      public bool? IsActive { get; set; }
    }
    ```
  ],
)

=== Entity Type Configuration
#grid(
  [
    Die Nachteile der Fluent API sind, dass sie viel Text beinhaltet und unstrukturiert ist.
    Mit der Entity Type Configuration kann die Konfiguration im ```cs OnModelCreating()```
    in eigene Klassen und damit Dateien ausgelagert werden.

    Dazu muss eine Klasse von `IEntityTypeConfiguration<T>` ableiten und ```cs Configure()``` überschreiben.
    Die Syntax ist mit ```cs OnModelCreating()``` identisch.

    Anschliessend muss die Konfiguration in der entsprechenden ```cs OnModelCreating()``` registriert werden.
    Alternativ auch mit ```cs [EntityTypeConfiguration]``` Annotation.
  ],
  [
    ```cs
    internal class CategoryTypeConfig
      : IEntityTypeConfiguration<Category> {
      
      public void Configure(
        EntityTypeBuilder<Category> builder)
      {
        builder.Property(p => p.Timestamp)
          .IsRowVersion();
    } }
    public class ShopContext : DbContext {
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.ApplyConfiguration(
          new CategoryTypeConfig()
        ); } }
    ```
  ],
)

== Relationale Datenbanken
Bisher waren alle Mappings _unabhängig vom Provider_. Die nachfolgenden Beispiele beziehen sich auf _Microsoft SQL Server_.
Im Model Builder bzw. der Fluent API gibt es zusätzliche Extension Methods nur für relationale Provider.

=== Tabellen
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Tabellenname = `dbo.DbSet`-Name\ #hinweis[(z.B. `dbo.Categories`)]

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>()```\ ```cs .ToTable(table, schema: schema)```\
    Tabellename zwingend, Schema optional.

    *`(3)` Data Annotations*\
    ```cs [Table(name, Schema = schema)]``` Annotation an Klasse.\
    Tabellenname zwingend, Schema optional.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; } // (1)
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .ToTable("Category", schema: "dbo"); // (2)
      }
    }

    [Table("Category", Schema = "dbo")] // (3)
    public class Category {
      public int Id { get; set; }
      public string Name { get; set; }
    }
    ```
  ],
)

=== Spalten
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Spaltenname = Property-Name #hinweis[(z.B. `Name`)]\ Die `Order` #hinweis[(Reihenfolge der Spalte in DB)]
    ist nach der Reihenfolge der Properties im Code gegeben.

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>().Property()```\ ```cs .HasColumnName(name, order: order)```.

    *`(3)` Data Annotations*\
    ```cs [Column(name, Order = order)]``` \ Annotation an Property.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .Property(e => e.Name)
         .HasColumnName("CategoryName", order: 1); // (2)
      }
    }

    public class Category {
      public int Id { get; set; }
      [Column("CategoryName", Order = 1)] // (3)
      public string Name { get; set; }
    }
    ```
  ],
)

=== Datentypen & Default Values
#grid(
  columns: (0.75fr, 1fr),
  [
    *`(1)` Convention*\
    Je nach Provider unterschiedlich.\
    Keine Default Values.

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch ```cs Entity<T>().Property().HasColumnName()```\
    ```cs .HasColumnType()``` #hinweis[(Datentypname der Ziel-DB)]\
    ```cs .HasDefaultValue()``` #hinweis[(Wert / Gültige SQL Expression)].

    *`(3)` Data Annotations*\
    ```cs [Column(name, TypeName = type)]``` Annotation an Property.\
    Default Values nicht unterstützt.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Category>()
         .Property(e => e.Name)
         .HasColumnName("CategoryName")
         .HasColumnType("NVARCHAR(500)")
         .HasDefaultValue("---"); // (2)
      }
    }

    public class Category {
      public int Id { get; set; }
      [Column("CategoryName", TypeName = "NVARCHAR(500)")]//(3)
      public string Name { get; set; }
    }
    ```
  ],
)

=== Primary Keys, Default Schema & Computed Columns <ef-primary-key>
#grid(
  [
    _Primary Keys_\
    *Convention*\
    `PK_<Klassenname>`

    *Fluent API*
    #v(-0.5em)
    ```cs
    modelBuilder.Entity<Category>()
      .HasKey(e => e.Id)
      .HasName("PrimaryKey_Category");
    ```
  ],
  [
    _Default Schema_\
    *Convention*\
    Microsoft SQL Server verwendet "dbo", SQLite kennt keine Schemas

    *Fluent API*\
    ```cs modelBuilder.HasDefaultSchema("sales");```
  ],
  [
    _Computed Columns_\
    *Fluent API*
    #v(-0.5em)
    ```cs
    modelBuilder.Entity<Category>()
      .Property(e => e.DisplayName)
      .HasComputedColumnSql(
        "[Id] + ' ' + [Name]");
    ```
  ]
)


== Relationships
Bildet Beziehungen zwischen _zwei Entitäten_ ab. Sie werden im Modell durch _Navigation Properties_ und
_Foreign Keys_ dargestellt. In den Beispielen wird eine _Produkt-zu-Kategorie-Beziehung_ gezeigt.

- _Collection Navigation Property_: Enthält alle Elemente der N-Beziehung in einer `ICollection`.\
  Damit kann vom 1-Ende zum N-Ende navigiert werden #hinweis[(Kategorie $->$ Produkt)].
- _Reference Navigation Property_: Die Referenz zum 1-Ende. Hat denselben Typ wie das 1-Ende.\
  Damit kann vom N-Ende zum 1-Ende navigiert werden #hinweis[(Produkt $->$ Kategorie)].
- _Foreign Key Property_: Foreign Key auf dem N-Ende. Wird als eigene Property implementiert.

=== one-to-many / Fully Defined
Eine one-to-many Relationship ist eine _1-zu-N-Beziehung_. Im Entity Framework gibt es mehrere "Ausbaustufen",
je nachdem welche Art von Zugriff von beiden Enden gewünscht ist.

#grid(
  columns: (0.75fr, 1fr),
  [
    In einer _Fully Defined one-to-many Beziehung_ sind alle Beziehungs-Elemente vorhanden.

    *`(1)` Convention*\
    #sym.checkmark _Collection Navigation Property_ #hinweis[(das 1-Ende)]\
    #sym.checkmark _Reference Navigation Property_ #hinweis[(das N-Ende)]\
    #sym.checkmark _Foreign Key Property_

    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch\ ```cs Entity<T>().Property()``` entweder\
    ```cs .HasOne().WithMany()``` #hinweis[(von 1 zu N)] oder\
    ```cs .HasMany().WithOne()``` #hinweis[(von N zu 1)]\
    #hinweis[(je nachdem welches Ende `T` ist)]\
    ```cs .HasForeignKey()```\
    ```cs .HasConstraintName("FK_<TableName>_<KeyName>")```

    *`(3)` Data Annotations*\
    ```cs [ForeignKey(name)]``` Annotation an Navigation Property.
    Das Property, welches die ID enthält muss davor deklariert werden.
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Product>() // 1-Ende
         .HasOne(p => p.Category)
         .WithMany(b => b.Products) // (2)
         .HasForeignKey(p => p.CategoryId)
         .HasConstraintName("FK_Product_CategoryId");
      }
    }
    public class Category {
      public int Id { get; set; }
      public ICollection<Product> Products { get; set; }
    }
    public class Product {
      public int Id { get; set; }
      public int CategoryId { get; set; }
      [ForeignKey(nameof(CategoryId))] // (3)
      public Category Category { get; set; }
    }
    ```
  ],
)

=== one-to-many / Shadow Foreign Key
#grid(
  columns: (0.75fr, 1fr),
  [
    In einer _Shadow Foreign Key one-to-many Beziehung_ wird der Foreign Key weggelassen.

    *`(1)` Convention*\
    #sym.checkmark _Collection Navigation Property_ #hinweis[(das 1-Ende)]\
    #sym.checkmark _Reference Navigation Property_ #hinweis[(das N-Ende)]\
    #sym.crossmark _Foreign Key Property_
    \ \ \
    *`(2)` Fluent API*\
    In ```cs OnModelCreating()``` durch\ ```cs Entity<T>().Property()``` entweder\
    ```cs .HasOne().WithMany()``` #hinweis[(von 1 zu N)] oder\
    ```cs .HasMany().WithOne()``` #hinweis[(von N zu 1)]\
    #hinweis[(je nachdem welches Ende `T` ist)]\
    ```cs .HasConstraintName("FK_<TableName>_<KeyName>")``` #hinweis[(ohne Foreign Key)]

    *`(3)` Data Annotations*\
    Die Foreign-Key-Annotation wird weggelassen
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Product>() // 1-Ende
         .HasOne(p => p.Category)
         .WithMany(b => b.Products) // (2)
         //.HasForeignKey(p => p.CategoryId)
         .HasConstraintName("FK_Product_CategoryId");
      } }
    public class Category {
      public int Id { get; set; }
      public ICollection<Product> Products { get; set; }
    }
    public class Product {
      public int Id { get; set; }
      //public int CategoryId { get; set; }
      //[ForeignKey(nameof(CategoryId))] (3)
      public Category Category { get; set; }
    }
    ```
  ],
)

=== one-to-many / Single Navigation Property
#grid(
  columns: (0.75fr, 1fr),
  [
    In einer _Single Navigation Property one-to-many Beziehung_ ist es nicht mehr möglich, vom N-Ende zum 1-Ende zu kommen,
    da das Reference Navigation Property wegfällt.

    *`(1)` Convention*\
    #sym.checkmark _Collection Navigation Property_ #hinweis[(das 1-Ende)]\
    #sym.crossmark _Reference Navigation Property_ #hinweis[(das N-Ende)]\
    #sym.crossmark _Foreign Key Property_

    *`(2)` Fluent API*\
    ```cs HasOne()``` bzw. ```cs WithOne()``` enthält nicht mehr ein Lambda zum 1-Ende, sondern nur noch den Typ dessen als `T`.

    *`(3)` Data Annotations*\
    Das Navigation Property wird ebenfalls weggelassen
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Product>() // 1-Ende
         .HasOne<Category>() // Nur noch Verweis auf Typ
         .WithMany(b => b.Products) // (2)
         //.HasForeignKey(p => p.CategoryId)
         .HasConstraintName("FK_Product_CategoryId");
      }
    }
    public class Category {
      public int Id { get; set; }
      public ICollection<Product> Products { get; set; }
    }
    public class Product {
      public int Id { get; set; }
      //public int CategoryId { get; set; }
      //[ForeignKey(nameof(CategoryId))] (3)
      //public Category Category { get; set; }
    }
    ```
  ],
)

=== one-to-many / Foreign Key only
#grid(
  columns: (0.75fr, 1fr),
  [
    In einer _Foreign Key only one-to-many Beziehung_ ist nur noch der Foreign Key auf dem N-Ende vorhanden.

    *`(1)` Convention*\
    #sym.crossmark _Collection Navigation Property_ #hinweis[(das 1-Ende)]\
    #sym.crossmark _Reference Navigation Property_ #hinweis[(das N-Ende)]\
    #sym.checkmark _Foreign Key Property_

    *`(2)` Fluent API*\
    ```cs HasOne()``` bzw. ```cs WithOne()``` enthält nicht mehr ein Lambda zum 1-Ende, sondern nur noch den Typ dessen als `T`.\
    ```cs WithMany()``` bzw. ```cs HasMany()``` hat ebenfalls kein Lambda mehr, ist aber nicht generisch.

    *`(3)` Data Annotations*\
    Keine
  ],
  [
    ```cs
    public class ShopContext : DbContext {
      public DBSet<Category> Categories { get; set; }
      protected override void OnModelCreating(
        ModelBuilder modelBuilder) {
        modelBuilder.Entity<Product>() // 1-Ende
         .HasOne<Category>()  // Nur noch Verweis auf Typ
         .WithMany()          // Kein Lambda mehr (2)
         .HasForeignKey(p => p.CategoryId)
         .HasConstraintName("FK_Product_CategoryId");
      }
    }
    public class Category {
      public int Id { get; set; }
      //public ICollection<Product> Products { get; set; }
    }
    public class Product {
      public int Id { get; set; }
      public int CategoryId { get; set; }
      //[ForeignKey(nameof(CategoryId))] (3)
      //public Category Category { get; set; }
    }
    ```
  ],
)
#pagebreak()
== Database Context
Der Database Context ist der _wichtigste Teil des Entity Frameworks_. Zur _Design-Time_ definiert er das Model/OR Mapping,
die Konfiguration und stellt _Database Migrations_ bereit. Während der Runtime verwaltet er den Connection Pool,
führt CRUD Operationen aus, stellt Change Tracking bereit, cachet Daten und verwaltet Transaktionen.

_`DbContext`-Instanzen_ sollten nicht zu lange leben. Es gibt eine _limitierte Anzahl Connections_ im Client Connection Pool
und das _Change Tracking_ wird über die Zeit _ineffizient_. Auch sollten `DbContext`-Instanzen nicht geteilt werden,
da sie nicht Thread-safe sind und eine Exception die Instanz unbrauchbar machen kann.
_Fehleranfälligkeit_, weil Objekte nur an einem Kontext attached.

*Empfehlungen:* `DbContext` in einem `using`-Statement verwenden, Web-Applikationen sollten eine Instanz pro Request
instanzieren, GUI-Applikationen eine pro Formular. Generell ausgedrückt: Eine Instanz pro "Unit of Work"\
```cs await using ShopContext context = new();```

=== LINQ to Entities
Das _Entity Framework_ führt selbst keine Queries aus, es _generiert_ nur Queries, welche die DB dann ausführt.
Der SQL-Output ist je nach Formulierung der LINQ-Queries unterschiedlich. LINQ-to-Entities-Queries werden zu
_Expression Trees_ kompiliert, welche dann zur Laufzeit _geparst_ werden und _SQL-Statements_ generieren.
Dies impliziert aber, dass nicht alle .NET Expressions auf DB-Syntax übersetzt werden können --
der Provider muss Funktionen bereits kennen, um deren SQL generieren zu können.

```cs
await context.Categories.SingleAsync(c => Name.ToLower() == "Büsis"); // Funktioniert
// Funktion dem Provider unbekannt, funktioniert nicht
await context.Categories.SingleAsync(c => MyHelper.DoSomeShitWithThis(c.Name) == "Büsis");
```

=== Ablauf
#grid(
  [
    + `DbContext` instanzieren\
      #hinweis[(DB-Verbindung öffnen oder offene Verbindung aus Connection Pool holen, Cache & Change Tracker initialisieren)]
    + Abfrage mit LINQ
    + Daten ändern/speichern\
      #hinweis[(Change Tracker erkennt Änderung & bereitet SQL-Statement vor)]
    + Deferred Abfrage mit LINQ\
      #hinweis[(In Abfragesprache übersetzen & Abfrage ausführen)]
    + `DbContext` schliessen\
      #hinweis[(Cache invalidieren & DB-Verbindung zurück in Connection Pool)]
  ],
  [
    ```cs
    await using ShopContext context = new(); // 1.
    Category category = await context        // 2.
      .Categories
      .SingleAsync(c => c.Id == 1);
    category.Name = $"{category.Name} changed";

    await context.SaveChangesAsync();        // 3.
    var categories = context.Categories;     // 4.
    foreach (Category c in categories)
      { Console.WriteLine(c.Name); }
    // 5. End of Method
    ```
  ]
)

=== CUD-Operationen
Der _`DbContext`_ agiert nach dem _"Unit of Work"-Pattern_: Beim Laden eines Objektes aus der DB wird ein neuer UoW registriert.
Die Änderungen werden _aufgezeichnet_ und beim Speichern werden alle in einer _einzigen Transaktionen geschrieben_.

*Entities haben einen von fünf States:*
- _Added:_ Das Entity wird vom `DbContext` getracked, existiert aber in der DB noch nicht
- _Unchanged:_ Entity wird getracked, existiert in der DB, und ihre Properties haben sich gegenüber DB nicht verändert.
- _Modified_: Entity wird getracked, existiert in der DB, und mindestens ein Property-Wert wurde verändert.
- _Deleted:_ Entity wird getracked, existiert in der DB, wurde zum Löschen markiert.
  Wird deshalb gelöscht, wenn `SaveChanges()` zum nächsten Mal ausgeführt wird
- _Detatched:_ Entity wird nicht vom `DbContext` getracked


#grid(
  [
    *Insert*\
    Es gibt 3 verschiedene Möglichkeiten, ein Objekt der DB hinzuzufügen. Davon muss nur eine verwendet werden.
    ```cs
    await using ShopContext context = new();
    Category cat = new() { Name = "Notebook" };

    // (1) Nur Kategorie-Objekt ohne Referenzen inserten
    context.Entry(cat).State = EntityState.Added;
    // Alle Objektreferenzen von Kategorie auch inserten
    context.Add(cat); // (2) generisch
    context.Categories.Add(cat); // (3) nur für Category

    // SQL generieren & ausführen
    await context.SaveChangesAsync();
    // Neu generierten Primary Key erhalten
    int catId = cat.Id;
    ```
  ],
  [
    *Delete*
    #v(-0.5em)
    ```cs
    await using ShopContext context = new();
    Category cat = await context
      .Categories
      .FirstAsync(c => c.Name == "Kinderartikel");

    // Nur Kategorie-Objekt ohne Referenzen löschen
    context.Entry(cat).State = EntityState.Deleted;
    // Alle Objektreferenzen von Kategorie auch löschen
    context.Remove(cat); // generisch
    context.Categories.Remove(cat); // nur für Category

    // SQL generieren & ausführen
    await context.SaveChangesAsync();
    ```
  ],
  [
    *Update*
    #v(-0.5em)
    ```cs
    await using ShopContext context = new();

    // Gewünschte Kategorie laden
    Category cat await context
      .Categories
      .FirstAsync(c => c.Name == "Tastaturen");

    // Änderungen an Objekten durchführen
    cat.Name = "Mechanische Tastaturen";

    // SQL generieren & ausführen
    await context.SaveChangesAsync();
    ```
  ],
  [
    *Mehrere Operationen (Unit of Work)*\
    Durch UoW können mehrere Operationen vor `SaveChanges` durchgeführt werden.
    ```cs
    await using ShopContext context = new();
    Category c1 = new() { Name = "Notebooks" };
    context.Add(c1);
    Category c1 = new() { Name = "Ultrawides" };
    context.Add(c2);
    Category c3 = await context
      .Categories
      .SingleAsync(c => c.Id == 42);
    c3.Name = "Gaming Chairs";
    await context.SaveChangesAsync();
    ```
  ]
)

==== Batch-Operationen
#grid(
  [
    *Delete*
    #v(-0.5em)
    ```cs
    await using ShopContext context = new();
    // Alle Spalten in Categories löschen
    await context
      .Categories
      .ExecuteDeleteAsync();
    // Löschen mit Filter
    await context
      .Categories
      .Where(c => c.Name == "Billigbier")
      .ExecuteDeleteAsync();
    ```
  ],
  [
    *Update*
    #v(-0.5em)
    ```cs
    await using ShopContext context = new();
    Category cat await context
      .Categories
      // Filter, wenn gewünscht
      .Where(c => c.Name == "Hundespielzeug")
      .ExecuteUpdateAsync(c =>
        c.SetProperty(
          p => p.Name,
          "Büsi-Spielzeug"
        ) );
    ```
  ],
)

=== CUD von Assoziationen
Beziehungen können auf mehrere Arten angepasst werden:
- _Anpassen des Navigation Properties:_ ```cs order.Customer = customer;```
- _Hinzufügen/Entfernen in Collection Navigation Properties:_ ```cs customerOrders.Add(order);``` bzw. ```cs .Remove(order);```
- _Setzen des Foreign Keys:_ ```cs order.CustomerId = 1;```

#grid(
  [
    *Gesamten Objekt-Graph inserten*
    #v(-0.5em)
    ```cs
    await using ShopContext context = new();
    Customer c = new() {
      Name = "Jannis"
      Orders = new List<Order> {
        new() { ... }
        new() { ... }
      } };
    context.Add(c);
    await context.SaveChangesAsync();
    ```
  ],
  [
    *Beziehung für bestehendes Objekt hinzufügen*
    #v(-0.5em)
    ```cs
    await using ShopContext context = new();
    Customer c = await context
      .Customers
      .Include(c => c.Orders) // Bestehende laden
      .FirstAsync();


    c.Orders.Add(new Order());
    await context.SaveChangesAsync();
    ```
  ],
  [
    *Beziehung via Navigation Property ändern*\
    Indirekte Foreign Key-Änderung
    ```cs
    await using ShopContext context = new();
    Order order = await context
      .Orders
      .FirstAsync();
    order.Customer = await context
      .Customers
      .FirstAsync(c => c.Name == "Jannis");
    await context.SaveChangesAsync();
    ```
  ],
  [
    *Beziehung via Foreign Key ändern*\
    Direkte Foreign Key-Änderung
    ```cs
    await using ShopContext context = new();
    Order order = await context
      .Orders
      .FirstAsync();


    order.CustomerId = 2;
    await context.SaveChangesAsync();
    ```
  ],
)

== Change Tracking
Der Change Tracker _registriert alle Änderungen an getrackten Entities._ Er aktualisiert den Entity State und
agiert komplett _ohne_ die DB zu überprüfen. Der Change Tracker hat für das _Setzen_ von jedem State eine _Methode_.
Es gibt immer mindestens 3 Varianten mit dem gleichen Effekt.
- _`context.Add()`, `.Remove()` etc.:_ Berücksichtigen den ganzen Objektgraphen, können sämtliche Entities entgegennehmen.
- _`context.[...].Add()`, `.Remove()` etc.:_ Berücksichtigen den ganzen Objektgraphen, können nur diese bestimmten Entities entgegennehmen.
- _`Entry(...).State`:_ Berücksichtigt nur dieses Entity, ohne Referenzen

=== State Entries
#grid(
  [
    Können über ```cs DbContext.Entry<T>(object)``` abgerufen werden.\
    *Inhalt*
    - Informationen über _Status_ des Objekts
    - Status jedes Properties #hinweis[(Geändert?, originaler Wert, aktueller Wert)]
    - Entity-spezifische _Ladefunktionen_
    - Funktion, um Werte neu von DB zu laden
    - Funktion, um referenzierte Entities zu laden #hinweis[(Lazy Loading)]
  ],
  [
    ```cs
    Category cat = await context
      .Categories
      .FirstAsync();
    cat.Name = "Nirvana"; // Entity ändern
    EntityEntry<Category> entry = context
      .Entry(cat);
    Console.WriteLine(entry.State); // Output: Modified
    PropertyEntry<Category, string> en = entry
      .Property(c => c.Name);
    Console.WriteLine(en.IsModified); // true
    Console.WriteLine(en.OriginalValue); // Nickelback
    Console.WriteLine(en.CurrentValue);  // Nirvana
    ```
  ]
)
==== Beispiel State Transition
```cs
// New Record
Category cat = new() { Name = "Glüehwii" };           // EntityState.Detached (wie untracked file in Git)
context.Add(cat);                                     // EntityState.Added
await context.SaveChangesAsync();                     // EntityState.Unchanged
cat.Name = "Drü Manne Kebab";                         // EntityState.Modified
await context.SaveChangesAsync();                     // EntityState.Unchanged
context.Remove(cat);                                  // EntityState.Deleted
await context.SaveChangesAsync();                     // EntityState.Unchanged (Objekt bleibt im Speicher)
// Load from Database (tracked)
Category catLoaded1 = await context                   // EntityState.Unchanged
  .Categories
  .FirstAsync(c => Name == "Schoggigipfel");
// Load from Database (untracked)
Category catLoaded2 = await context                   // EntityState.Detached
  .Categories
  .AsNoTracking() // Deaktiviert Change Tracking
  .FirstAsync(c => Name == "El Töni Mate" );
```

== Laden von Object Graphs
Object Graphs sind ein Set von _eigenständigen_, aber _verbundenen Objekten_, die zusammen eine _logische Einheit_ bilden.
Diese können auf verschiedene Arten geladen werden.

- _Eager Loading:_ Assoziationen werden nicht geladen, können aber mit `Include()` einzeln hinzugefügt werden.
  Geschieht in der SQL-Abfrage via Join. Ist der Default.
- _Explicit Loading:_ Assoziationen werden explizit nachgeladen, Collections werden komplett geladen.
  Geschieht in separater SQL-Abfrage
- _Lazy Loading:_ Assoziationen werden bei Property-Zugriff automatisch nachgeladen.
  Collections werden komplett geladen, aber Filtern ist möglich. Geschieht in separater SQL-Abfrage.

#table(
  columns: (auto, auto, 1fr),
  table.header([Kein Laden von Referenzen], [Eager Loading], [Explicit Loading]),
  [
    ```cs
    Order order = await context
      .Orders
      .FirstAsync(); // DB-Access

    var customer = order.Customer;
    // customer is null
    var items = order.Items
    // items is null
    ```
  ],
  [
    ```cs
    Order order = await context
      .Orders
      .Include(o => o.Customer)
      .Include(o => o.Items)
        .ThenInclude(oi => oi.Product)
      .FirstAsync(); // DB-Access

    var customer = order.Customer;
    // customer is not null
    var items = order.Items
    // items is not null
    ```
  ],
  [
    ```cs
    Order order = await context
      .Orders
      .FirstAsync(); // DB-Access
    await context
      .Entry(order)
      .Reference(o => o.Customer)
      .LoadAsync(); // DB-Access
    await context
      .Entry(order)
      .Collection(o => o.Items)
      .Query().Where(oi => Ordered > 1)
      .LoadAsync(); // DB-Access
    var customer = order.Customer;
    // customer is not null
    var items = order.Items
    // items is not null
    ```
  ],
)

*Datenbankzugriffe:* Immer wenn etwas geholt, gespeichert oder über Daten aus der DB iteriert wird.
Bei Lazy Loading zusätzlich, wenn auf Referenzen / andere Entities zugegriffen wird.

=== Lazy Loading
#grid(
  [
    Modell-Klassen verwenden meist _Auto-Properties_\ #hinweis[(`{ get; set; }`)].
    Wie kann beim Zugriff _zusätzliche Ladelogik_ ausgeführt werden?
    + _Manuell:_ Auf Auto-Properties verzichten und Logik selbst implementieren
    + _Proxies:_ Durch Dynamic Binding mit `virtual` auf Navigation Properties.
    EF generiert selbst abgeleitete Proxy-Klassen, welche ca. die Logik von Variante 1 beinhalten.
    Wird die _DB-Verbindung_ bei Lazy-Loading _unterbrochen_, kann sie _nicht_ wiederhergestellt werden.
  ],
  [
    ```cs
    public class Order {
      public int Id { get; set; }
      public Customer Customer { get; set; } }
    // Variante 1
    public class Order {
      public int Id { get; set; }
      public Customer Customer { ... } }
    // Variante 2
    public class Order {
      public int Id { get; set; }
      public virtual Customer Customer { get; set; } }
    public class OrderProxy : Order {
      public override Customer Customer { ... } }
    ```
  ]
)

== Optimistic Concurrency
_Annahme:_ Zwischen Laden und Speichern eines Records wird dieser nicht verändert. Erst beim Speichern wird überprüft,
ob mittlerweile veränderte Werte auf der DB liegen. Für die Konflikterkennung gibt es _zwei Varianten_.

#table(
  columns: (1fr, 1fr),
  table.header([Timestamp], [Concurrency Tokens #hinweis[(Daten-Versionen)]]),
  [
    Pro Record wird ein Timestamp bzw. eine "Row Version" gespeichert. Dieser ist Teil des Datenobjekts.
    Sie werden bei einer Änderung am Property automatisch aktualisiert.
  ],
  [
    Beim Ändern der Daten verbleiben die Originaldaten im Objekt. Diese werden beim Speichern mitgegeben und überprüft,
    ob die Originalwerte dem aktuellen DB-Zustand entsprechen.
  ],

  [
    `DB-Timestamp == Objekt-Timestamp?`
    - _Ja:_ Speichern & Timestamp erhöhen
    - _Nein:_ Versionskonflikt
  ],
  [
    `DB-Daten == Originale Objektdaten?`
    - _Ja:_ Speichern
    - _Nein:_ Versionskonflikt
  ],

  [
    *Fluent API*\
    In ```cs OnModelCreating()``` auf ```cs modelBuilder.Entity<T>()```\ ```cs .Property(p => p.property).IsRowVersion();```

    *Data Annotations*\
    ```cs [Timestamp]``` Annotation an Property
  ],
  [
    *Fluent API*\
    In ```cs OnModelCreating()``` auf ```cs modelBuilder.Entity<T>()```\ ```cs .Property(p => p.property).IsConcurrencyToken();```

    *Data Annotations*\
    ```cs [ConcurrencyCheck]``` Annotation an Property
  ],
)

=== Konfliktbehebung
#grid(
  [
    Die _`DbUpdateConcurrencyException`_ beinhaltet fehlerhafte Entries
    #hinweis[(Aktuelle Werte, Originale Werte, Werte von DB)].

    *Varianten zur Behandlung*
    + Fehler ignorieren
    + Benutzer fragen
    + Autokorrektur
      + Exception fangen
      + Fehlerhafte Werte analysieren
      + Objekt korrigieren
      + Concurrency Tokens / Timestamps aktualisieren
      + Speichern
  ],
  [
    ```cs
    // Code aus Platzgründen nicht asynchron
    using ShopContext context1 = new();
    using ShopContext context2 = new();
    // Client 1
    Category p1 = context1.Categories.First();
    p1.Name = "Nina";
    // Client 2
    Category p2 = context2.Categories.First();
    p2.Name = "Jannis";

    context1.SaveChanges(); // OK
    context2.SaveChanges(); // Fails
    // DbUpdateConcurrencyException
    ```
  ]
)

== Database Migration
Sollen Spalten oder Tabellen _angepasst_ werden, kann es zu verschiedenen Problemen kommen, vor allem wenn
_vorhandene Daten abgeändert_ werden müssen. Mit den Database Migrations von EF werden diese vereinfacht.
#grid(
  [
    _Während der Entwicklung_
    + Modell anpassen #hinweis[(Klassen, Properties erstellen/ändern/löschen)]
    + Migration erstellen #hinweis[(Als C\#-Klasse, logischer Code für Up-/Down-Migration)]
    + Migration reviewen und evtl. korrigieren
    + Code der Migration kann zu Git hinzugefügt werden
  ],
  [
    _Deployment_
    + Änderungen gemäss Migrations-Reihenfolge auf DB deployen
    + Rollback auf älteren Stand via Down-Migration möglich
  ]
)

Jede Migration wird anhand ihres Namens und ihres Erstellungs-Timestamps identifiziert.

#grid(
  [
    *Migrationsdateien im C\# Projekt*
    - _`<timestamp>_<MigrationName>.cs`_\ #hinweis[Die eigentliche Migration]
    - _`<timestamp>_<MigrationName>.Designer.cs`_\ #hinweis[Metadaten für Entity Framework]
    - _`<DbContextClassName>ModelSnapshot.cs`_\ #hinweis[Snapshot, welcher als Basis für nächste Migration gilt.]

  ],
  [
    *Migrationstabellen auf der DB*\
    _`dbo._EFMigrationsHistory`_\ #hinweis[Liste aller auf die DB angewendeten Migrationen]
  ]
)

*Workflow einer Migration*
+ _Erste Migration erstellen:_ `dotnet ef migrations add InitialMigration`
  #hinweis[(erstellt Migration mit ihren Dateien in Projekt)]
+ _Datenbank updaten:_ `dotnet ef database update`
  #hinweis[(erstellt `_EFMigrationsHistory` mit `InitialMigration` und führt diese aus)]
+ Weitere Migration erstellen, usw.

=== Migrations-API
#grid(
  [
    Migrations können innerhalb des Codes automatisiert werden.
    - _Delete / Create:_
      - `EnsureDeleted()` löscht DB
      - `EnsureCreated()` erstellt DB, wenn nicht vorhanden
    - _Migrate:_ DB auf aktuellste Migration migrieren
    - Abfrage vorhandener Migrations #hinweis[(Alle, Pending, Applied)]
    - Explizite Migration auf spezifische Version
  ],
  [
    ```cs
    await using ShopContext context = new();
    DatabaseFacade database = context.Database;
    await database.EnsureDeletedAsync();
    await database.EnsureCreatedAsync();
    await database.MigrateAsync();
    IEnumerable<string> list = database.GetMigrations();
    list = await database.GetPendingMigrationsAsync();
    list = await database.GetAppliedMigrationsAsync();
    IMigrator m = context.GetService<Migrator>();
    await m.MigrateAsync("MigrationName");
    ```
  ]
)

= gRPC - Google Remote Procedure Call
gRPC ist die neue _Standard-Technologie_ für _Backend-Kommunikation_ in .NET. Ist eine Erweiterung von RPC (Remote Procedure Call).
Erlaubt _Client / Server Kommunikation_, wird aber primär für _Server-to-Server_ Kommunikation eingesetzt.
_Hohe Performance_ von zentraler Bedeutung, _nicht als Frontend-API_ gedacht.
Löst Probleme wie Security, Synchronisierung, Data Flow Handling etc.
#v(0.5em)
#grid(
  [
    ==== Grundprinzipien
    Einfache Service-Definition, Sprach-unabhängigkeit, Problemlose Skalierbarkeit, Bi-direktionales Streaming,
    Integrierte Authentisierungsmechanismen.

    Verwendet _HTTP/2_ als Kommunikationsprotokoll #hinweis[(Unterstützt Multiplexing und bidirektionales Streaming,
    HTTPS und Header Compression, weniger Overhead weil ACK nicht mehr pro Request sondern einmalig für alle Ressourcen)] und
    _Google Protocol Buffers_ #hinweis[(Protobuf)] als Interface Definition Language #hinweis[(IDL)].
  ],
  [
    ==== Developer Workflow
    #image("img/dotnet_18.png")
  ],
)

== Architektur
gRPC ist ein _Software Development Kit_. Es ist plattformneutral und eine Visual Studio (Code) Integration existiert.

=== Aufbau
#grid(
  columns: (1fr, 1.3fr),
  figure(image("img/dotnet_19.png"), caption: [Ohne Kommunikation]),
  figure(image("img/dotnet_20.png"), caption: [Mit Kommunikation])
)

=== Beispiel: Service
#v(0.5em)
#grid(
  [
    ==== Interface Definition Language (Protobuf) <protobuf-example>
    ```proto
    syntax = "proto3";
    option csharp_namespace = "BasicExample";
    package Greet;

    // Service Definition
    service Greeter {
      // Specify Request-Message
      rpc SayHello(HelloRequest)
        // Service Method with Response Message
        returns (HelloReply);
    }
    // Request message containing the user's name
    message HelloRequest {
      // Message Type, "name" is only for humans
      string name = 1;
    }
    // Response message containing the greetings
    message HelloReply {
      // 1 = Unique field ID, Order of encoding
      string message = 1;
    }
    ```
  ],
  [
    ==== Implementation
    Ein gRPC-Service returnt immer einen _`Task.FromResult()`_ mit dem entsprechenden Message Type-Objekt.
    ```cs
    public class GreeterService : Greeter.GreeterBase {
    // GreeterBase = Generierte Basisklasse

      // T ist Name einer Message
      public override Task<HelloReply> SayHello(
        HelloRequest request,
        ServerCallContext context
      ) =>
        Task.FromResult(
          new HelloReply {
            Message = "Hello " + request.Name
          }
        );
    }
    ```
  ]
)

=== Beispiel: Client
```cs
// The Port number (5001) must match the port of the gRPC server.
GrpcChannel channel = GrpcChannel.ForAddress("https://localhost:5001");
Greeter.GreeterClient client = new(channel); // Generated Client Stub

// Remote Procedure Call
try {
  HelloReply reply = await client.SayHelloAsync(new HelloRequest { Name = "GreeterClient" });
  Console.WriteLine($"Greeting: {reply.Message}");
} catch ( ... ) { ... }
```

=== Vergleich gRPC / REST
#table(
  columns: (auto, 1fr, 1fr),
  table.header([Feature], [gRPC], [REST]),
  [*Contract*], [Required], [Optional (OpenAPI)],
  [*Transport*], [HTTP/2], [HTTP/1.1],
  [*Payload*], [Protobuf #hinweis[(small / binary)]], [JSON #hinweis[(larger / human readable)]],
  [*Formalisierung*], [Strikte Spezifikation], [Keine oder OpenAPI Specification],
  [*Streaming*], [Client / Server / Bidirektional], [Client / Server],
  [*Browser Support*], [Nein #hinweis[(benötigt grpc-web)]], [Ja],
  [*Security*], [Transport / HTTPS #hinweis[(zwingend)]], [Transport / HTTPS #hinweis[(optional)]],
  [*Client Generierung*], [Ja], [Third-party Tooling],
)

== Protocol Buffers
#v(-0.5em)
=== Umfang
- _Interface Definition Language (IDL):_ Eine Subform der Domain Specific Language (DSL).
  Beschreibt ein Service Interface plattform- und sprach-neutral.
- _Data-Model:_ Beschreibt Messages #hinweis[(respektive Request- und Response-Objekte)]
- _Wire Format:_ Beschreibt das Binärformat zur Übertragung
- _Serialisierungs- / Deserialisierungs-Mechanismen_
- _Service-Versionierung_

#pagebreak()

=== Proto Files
Der Code im Kapitel @protobuf-example ist in einem _Proto-File_ #hinweis[(Datei-Endung \*.proto)] gespeichert.
Ein Proto-File besteht aus folgenden _Abschnitten:_
- _Header:_ Allgemeine Definitionen #hinweis[(Syntax, option, etc)]
- _Services:_ 0 oder mehr Services, 1 oder mehr Service-Methoden pro Service
- _Message Types:_ 0 oder mehr Fields, Field definiert sich aus Type, Unique Name und Unique Field Number.

_Service-Methoden_ haben immer genau 1 Parameter und 1 Rückgabewert.
_Null-Werte_ können mit `import "google/protobuf/empty.proto"; ... google.protobuf.Empty` verwendet werden.

=== Messages / Fields
#grid(
  [
    - Angabe des _Feldtypen_ #hinweis[(Skalarer Werttyp, anderer Message Type oder Enumeration)],
    - _Unique Field Name_ #hinweis[(Wird für Generatoren verwendet, in Lower Snake Case)]
    - _Unique Field Number_ #hinweis[(Identifikation für das Binärformat)].
  ],
  [
    ```proto
    message SearchRequest {
      string query = 1;
      int32 page_number = 2;
      int32 result_per_page = 3;
    }
    ```
  ],
)

=== Fields / Repeated Fields
#grid(
  [
    Es gibt zwei Arten von Fields, `singular` und `repeated`. `singular` ist ein skalarer Wert und der Default.
    `repeated` ist eine Liste von Werten als Strings.
  ],
  [
    ```proto
    message SearchResponse {
      repeated string results = 1;
    }
    ```
  ],
)

=== Enumerations
#grid(
  [
    Analog zu `enum` in .NET, _Definition_ innerhalb einer Message oder im Proto-File Root.
    Enum-Member mit dem _Wert 0 muss zwingend existieren_ #hinweis[(Default-Wert)].
    Schlüsselwort _`reserved`_ kann auch für Enumerations verwendet werden.
  ],
  [
    ```proto
    message SearchRequest {
      Color searchColor = 1;
      enum Color {
        RED = 0; // 0 must exist
        GREEN = 1; } }
    ```
  ],
)

=== Message Type Composition & Imports
#grid(
  [
    Message Types können ebenfalls als Field verwendet werden. _Import_ eines \*.proto Files über das `import`-Schlüsselwort.
    Damit können z.B. Enum-Definitionen ausgelagert werden.
  ],
  [
    ```proto
    // File: example.proto
    import "protos/_base.proto";
    message Search {
      LogicalOperator operator = 2;
    }
    // File: _base.proto
    enum LogicalOperator{ ... }

    ```
  ],
)

=== Reserved Fields
#grid(
  [
    Für _Versionierung_ gedacht. Wiederverwendung wird vom Protocol Buffer Compiler verhindert.
    Schlüsselwort `reserved` _verfügbar für Unique Field Name und Unique Field Number_
    #hinweis[(Falls in einer neuen Version ein Feld entfernt wird, wird zukünftige Überschreibung so verhindert und
    somit Rückwärtskompabilität garantiert)].

    Ranges können mit `"to"` reserviert werden:\
    ```proto reserved 1 to 3```
  ],
  [
    ```proto
    message SearchRequest {
      reserved 1, 3, 20 to 30;
      reserved "page_number", "result_per_page";

      string query = 1; // Compilerfehler
      int32 page_number = 2; // Compilerfehler
      int32 result_per_page = 3; // Compilerfehler
    }
    ```
  ],
)

== gRPC C\# API
#v(-0.5em)
=== Protocol Buffers Compiler
Der Protobuf Compiler wird automatisch in die Build-Pipeline vor dem C\# Compiler eingebunden.
In Visual Studio kann angegeben werden ob Client & Server, nur eines von beiden oder gar nichts generiert werden soll.

*Verantwortlichkeiten:* Parsen / Validieren von Proto-Files, Auflösen von Includes, Generieren von C\# Source Files.

=== Aufbau Client / Server
#table(
  columns: (0.8fr, 1fr),
  table.header([Server-Projekt], [Client-Projekt]),
  [ASP.NET Core Projekt], [Beliebiges Projekt],
  [Proto-File als Kopie / Link einbinden], [Proto-File als Kopie / Link einbinden],
  [*NuGet Packages:* Grpc.AspNetCore], [*NuGet Packages:* Grpc.Net.Client, Google.Protobuf, Grpc.Tools],
)

#image("img/dotnet_21.png")

=== Generierter Code
- _Namespace:_ Proto-Code "```proto option csharp_namespace = "ProtoExample"```" wird zu C\# "```cs namespace ProtoExample```"
- _Abstrakte Basisklasse:_ Wird pro Service erzeugt.\
  "```proto service MyService { /* ... */ }```" wird zu "```cs public static partial class MyService { /* ... */ }```"

Services müssen beim Startup _registriert_ sein, Generierte Methoden aus abstrakter Basisklasse müssen _implementiert_ werden,
ansonsten gibt es in beiden Fällen Exceptions vom Protobuf-Compiler.

=== Startup C\# API
```cs
WebApplicationBuilder builder = WebApplication.CreateBuilder(args);
// Add services to the container (Registration of the gRPC Types via Dependency Injection)
builder.Services.AddGrpc();

WebApplication app = builder.Build();

// Configure the HTTP request pipeline (Definition of the endpoints, once per service)
app.MapGrpcService<GreeterService>();
app.Run();
```

=== Beispiel Customer Service
*Architektur-Übersicht*\
#v(-0.5em)
#grid(
  [
    _CustomerService_
    - RPC `GetCustomers`
      - Input: Keiner
      - Output: Kunden-Liste ohne Bestellungen
    - RPC `GetCustomer`
      - Input: ID und `IncludeOrders` bool
      - Output: Kunde mit/ohne Bestellungen
  ],
  [
    _OrderService_
    - RPC `GetOrders`
      - Input: Customer ID
      - Output: Liste der Bestellungen des Kunden
  ]
)

== Streams
Streams unterstützen _drei Modi:_
- Server Streaming Call #hinweis[(Server $->$ Client)],
- Client Streaming Call #hinweis[(Client $->$ Server)]
- Bi-direktional.

Garantiert sowohl _Auslieferung_ als auch _Reihenfolge_ der Auslieferung.\
*Anwendungen:* Messaging, Games, Live-Resultate, Smart Home Devices etc.

- _Synchrones Lesen:_ Resultat wird vom Server erst returnt, wenn alles gelesen wurde.
- _Asynchrones Lesen:_ Server returnt jede gelesene Zeile direkt.

#pagebreak()
=== Protocol Buffers
#grid(
  [
    Schlüsselwort `"stream"` vor Typbezeichnung. Payload ist eine normale Message.
    - _ReadFiles:_ Server Streaming Call #hinweis[(`stream` bei `returns`)]
    - _SendFiles:_ Client Streaming Call #hinweis[(`stream` bei Parameter)]
    - _RoundtripFiles:_ Bi-Direktionaler Streaming Call #hinweis[(`stream` bei beiden)]
  ],
  [
    ```proto
    service FileStreamingService {
      rpc ReadFiles (google.protobuf.Empty)
        returns (stream FileDto);
      rpc SendFiles (stream FileDto)
        returns (google.protobuf.Empty);
      rpc RoundtripFiles (stream FileDto)
        returns (stream FileDto);
    }
    message FileDto {
      string file_name = 1;
      int32 line = 2;
      string content = 3;
    }
    ```
  ],
)
=== Beispiel: File Streaming Service
==== Client (`Program.cs`)
#code-example(
  ```cs
  using AsyncClientStreamingCall<FileDto, Empty> call = client.SendFiles();

  // The port number(5001) must match the port of the gRPC server.
  GrpcChannel channel = GrpcChannel.ForAddress("https://localhost:5001");
  StreamingService.StreamingClient client = new(channel); // Client that every function uses

  // Run all streaming functions
  await TestServerStreaming(client); await TestClientStreaming(client); await TestBiDirectionalStreaming(client);
  WriteLine("Press any key to exit..."); ReadKey();

  // Stream files from server
  static async Task TestServerStreaming(StreamingService.StreamingClient client) {
      WriteLine(nameof(TestServerStreaming));
      using AsyncServerStreamingCall<FileDto> call = client.ReadFiles(new()); // Call object without Parameter
      await foreach (FileDto message in call.ResponseStream.ReadAllAsync()) { // Read last written chunk
          WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
      }
  }

  // Stream files to server
  static async Task TestClientStreaming(StreamingService.StreamingClient client) {
    WriteLine(nameof(TestClientStreaming));
    string[] files = Directory.GetFiles(@"Files"); // Get all files in folder
    foreach (string file in files) { // Open every file
        string content; int line = 0; using StreamReader reader = File.OpenText(file);
        while ((content = await reader.ReadLineAsync()) != null) {
            line++; // Read every line
            FileDto reply = new() { FileName = file, Line = line, Content = content, }; // Write into Protobuf
            await call.RequestStream.WriteAsync(reply); // Write protobuf to stream
        }
    }
    // Closing the stream is required
    await call.RequestStream.CompleteAsync(); // No more messages to come (server exits foreach-Loop)
    Empty result = await call; // Wait until service method is terminated / Get the result
  }

  // Send and receive files at the same time
  static async Task TestBiDirectionalStreaming(StreamingService.StreamingClient client) {
    WriteLine(nameof(TestBiDirectionalStreaming));
    using AsyncDuplexStreamingCall<FileDto, FileDto> call = client.RoundtripFiles();
    // Read
    Task readTask = Task.Run(async () => {
        await foreach (FileDto message in call.ResponseStream.ReadAllAsync()) {
            WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
        }
    });
    // Write
    string[] files = Directory.GetFiles(@"Files");
    foreach (string file in files) {
        string content; int line = 0; using StreamReader reader = File.OpenText(file);
        while ((content = await reader.ReadLineAsync()) != null) {
            line++;
            FileDto reply = new() { FileName = file, Line = line, Content = content, };
            await call.RequestStream.WriteAsync(reply);
        }
    }
    // Required
    await call.RequestStream.CompleteAsync(); // No more messages to come (server exits foreach-Loop)
    await readTask; // Wait until service method is terminated / all messages are received by client
  }
  ```
)

#pagebreak()

==== Server
#code-example(
  ```cs
  public class StreamingService : FileStreamingService.FileStreamingServiceBase {
      // Read files from disk and send to the client
      public override async Task ReadFiles(
        Empty request, // No parameters
        IServerStreamWriter<FileDto> responseStream,
        ServerCallContext context)
      {
        Empty request, // No parameters
        IServerStreamWriter<FileDto> responseStream,
        ServerCallContext context)
      {
          WriteLine(nameof(ReadFiles));
          string[] files = Directory.GetFiles(@"..\11_FileStreamingFiles");

          foreach (string file in files) {
              string content; int line = 0;
              using StreamReader reader = File.OpenText(file);

              // Read until End of File
              while ((content = await reader.ReadLineAsync()) != null) {
                  line++;
                  FileDto reply = new() { FileName = file, Line = line, Content = content, };
                  await responseStream.WriteAsync(reply);
              }
          }
      }

      // Recieve files that the client sends
      public override async Task<Empty> SendFiles(
        IAsyncStreamReader<FileDto> requestStream,
        ServerCallContext context)
      {
          WriteLine(nameof(SendFiles));
          await foreach (FileDto message in requestStream.ReadAllAsync()) { // Read last written chunk
              WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
          }
          return new Empty(); // Empty result, nothing to return
      }

      // Send files back to the client
      public override async Task RoundtripFiles(
        IAsyncStreamReader<FileDto> requestStream,
        IServerStreamWriter<FileDto> responseStream,
        ServerCallContext context)
      {
          WriteLine(nameof(RoundtripFiles));
          await foreach (FileDto message in requestStream.ReadAllAsync()) {
              await responseStream.WriteAsync(message);
              WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
          }
      }
  }
  ```
)

==== Proto
#code-example(
  ```proto
  syntax = "proto3";
  import "google/protobuf/empty.proto";
  option csharp_namespace = "FileStreaming";
  package FileStreaming;

  service StreamingService {
    rpc ReadFiles (google.protobuf.Empty) returns (stream FileDto);
    rpc SendFiles (stream FileDto) returns (google.protobuf.Empty);
    rpc RoundtripFiles (stream FileDto) returns (stream FileDto);
  }

  message FileDto {
    string file_name = 1;
    int32 line = 2;
    string content = 3;
  }
  ```
)

#pagebreak()

== Exception Handling
Grundsätzlich immer via _RpcException_. Basierned auf StatusCodes, Details über "Trailers" möglich.\
_Status Codes:_ `OK`, `Cancelled`, `Unknown`, `InvalidArgument`, `DeadlineExceeded`, `NotFound`, `AlreadyExists`,
`PermissionDenied`, `Unauthenticated`, `ResourceExhausted`, `FailedPrecondition`, `Aborted`, `OutOfRange`, `Unimplemented`,
`Internal`, `Unavailable`, `DataLoss`.

#grid(
  [
    ==== Unbehandelte Exceptions
    Exception wird auf Server nicht sauber behandelt. Server Runtime fängt Exception, wirft `RpcException` mit
    Status Code "`Unknown`".

    ==== Behandelte Exceptions mit Trailer
    Exception wird auf Server sauber behandelt und korrekt verpackt.

    Für die Trailers wird die `Metadata`-Klasse verwendet. Die Informationen werden als Key-Value-Pair-Liste gespeichert.
  ],
  [
    ```cs
    public override Task<Empty> Unhandled(
    Empty request, ServerCallContext context) => throw new Exception("Unhandled Exception");

    // behandelt
    public override Task<Empty> NotFound(
    Empty request, ServerCallContext context) => throw new RpcException(new Status(
      StatusCode.NotFound, "not found"), new Metadata {
        { "error-details", "The server dislikes you" } }
    );
    ```
  ],
)

=== Client Side Exception Handling
#grid(
  [
    Analog zur Serverseite: `RpcException`. Kann optional mit `when`-Klausel auf verschiedene Catch-Blöcke verteilt werden.

    RpcException umfassen auch alle Fehlersituationen bezüglich _Kommunikation_
    #hinweis[(Endpoint antwortet nicht, Verbindung bricht ab, etc.)].

    Weitere Exceptions #hinweis[(other stuff)] sind rein _client-seitige Probleme_ #hinweis[(Channel-Variable ist null, etc)].

    Häufige Fehler sind `Unimplemented` #hinweis[(Service nicht in Startup registriert oder Service-Methode nicht überschrieben)]
    oder `Unknown` #hinweis[(Fehlender Catch-Block für aufgetretenen Fehler)]
  ],
  [
    ```cs
    try { /* gRPC calls */ }
    catch (RpcException e)
      when (e.StatusCode == StatusCode.Unavailable) {}
    catch (RpcException e)
      when (e.StatusCode == StatusCode.NotFound) {}
    catch (RpcException e)
      when (e.StatusCode == StatusCode.Aborted) {}
    catch (RpcException e) {}
    catch (Exception) {} // Other stuff
    ```
  ],
)

== Special Types
=== Well Known Types
- _Empty:_ Platzhalter für Null-Werte
  ```proto
  import "google/protobuf/empty.proto";
  service EmptyService { rpc Dummy (google.protobuf.Empty) returns (google.protobuf.Empty); }
  ```
  ```cs Empty e = new();```

- _Timestamp:_ UTC Zeitstempel
  ```proto
  import "google/protobuf/timestamp.proto";
  message TimestampResponse { google.protobuf.Timestamp results = 1; }
  ```
  ```cs Timestamp ts = new() { Seconds = DateTime.UtcNow.Second };```

- _Bytes / ByteString:_ Binärer Datentyp
  ```proto
  message BinaryResponse { bytes results = 1; }
  ```
  ```cs ByteString bs = ByteString.Empty; bs = ByteString.CopyFromUtf8("X");```

- _Oneof:_ Lässt eine Auswahl von Typen zu. Beim Auslesen wird nur der zuletzt geschriebene Wert angezeigt, alle anderen sind `default`.
  Intern als Klasse und Enum #hinweis[(das aktuelle Property)] implementiert.
  ```proto
  message OneofResponse { oneof results { string image_url = 1; bytes image_data = 2; } }
  ```
  ```cs
  OneofResponse response = new() { ImageUrl = "https://..." }
  var rc = response.ResultsCase; // Momentan aktiv: ImageUrl
  string s = response.ImageUrl; // https://...
  ByteString bs = response.ImageData; // default

  response.ImageData = ByteString.CopyFromUtf8("PicOfUrMom"); // neue Response setzen
  rc = response.ResultsCase; // Momentan aktiv: ImageData
  s = response.ImageUrl; // default
  bs = response.ImageData; // PicOfUrMom
  ```

#pagebreak()

- _Any:_ Repräsentiert einen beliebigen Wert.
  ```proto import "google/protobuf/any.proto";
  message AnyResponse { google.protobuf.Any results = 1; }
  ```
  ```cs
  AnyResponse response = new();
  response.Results = Any.Pack(new CustomerResponse()); // Create Pack
  bool isCust = response.Results.Is(CustomerResponse.Descriptor); // Type check
  bool success = response.Results.TryUnpack(out CustomerResponse parsed); // Safe unpack
  ```

=== Collections
- _Repeated Fields:_ Generiert ein Repeated Field Property. Ist read-only. Etwa equivalent zu `IList`.
  ```proto
  message RepeatedResponse { repeated string results = 1;}
  ```
  ```cs
  RepeatedResponse response = new();
  response.Results.Add("Hello"); string[] arr = {"A", "B"}; response.Results.AddRange(arr);
  ```

- _Map Fields:_ Generiert ein Map Field Property. Ist read-only. Etwa equivalent zu `IDictionary`.
  ```proto
  message MapResponse { map<int32, string> results = 1; }
  ```
  ```cs MapResponse response = new(); response.Results.Add(1, "Hello");
  bool exists = response.Results.ContainsKey(1); string result = response.Results[1];
  ```


== Konfiguration & Logging
#v(-0.5em)
=== Server-side
#table(
  columns: (auto, auto, 1fr),
  table.header([Option], [Default], [Beschreibung]),
  [`MaxSendMessageSize`], [`null`], [Maximale Message-Grösse beim Senden #hinweis[(Exception wenn grösser)]],
  [`MaxReceiveMessageSize`], [4 MB], [Maximale Message-Grösse beim Empfangen #hinweis[(Exception wenn grösser)]],
  [`EnableDetailedErrors`], [`false`], [Wenn `true` werden Exception-Details an Client übermittelt #hinweis[(Mögliches Sicherheitsrisko!)]],
  [`CompressionProviders`], [gzip], [Kompressions-Algorithmus für Messages]
)

#grid(
  columns: (2.5fr, 1fr),
  [
    *Konfiguration*
    ```cs
    .Services
      .AddGrpc(options => // Globale Konfiguration
      {
        options.MaxSendMessageSize = 5 * 1024 * 1024; // 5 MB
        options.MaxReceiveMessageSize = 2 * 1024 * 1024; // 2 MB
        options.EnableDetailedErrors = true;
        options.CompressionProviders = new List<ICompressionProviders>
        {
          new GzipCompressionProvider(CompressionLevel.Optimal)
        }
      })
      .AddServiceOptions<AdvancedService>(options => // Spezifischer Service
      {
        options.MaxSendMessageSize = 1 * 1024 * 1024; // 1 MB
      })
    ```
  ],
  [
    *Logging aktivieren in `Program.cs`*
    ```cs
    builder.Logging.AddFilter(
      "Grpc", LogLevel.Debug
    );
    ```
    *...oder in `appsettings.json`*
    ```json
    {
      "Logging": {
        "LogLevel": {
          "Default": "Warning",
          "Grpc": "Debug"
        }
      },
      "AllowedHosts": "*",
    }
    ```
  ]
)

=== Client-side
#table(
  columns: (auto, auto, 1fr),
  table.header([Option], [Default], [Beschreibung]),
  [`HttpClient`], [Objekt], [HttpClient für gRPC-Verbindung. Kann verändert werden um z.B. weitere HTTP Header zu senden],
  [`DisposeHttpClient`], [`false`], [Wenn `true` und Verwendung eines eigenen `HttpClient` wird der Client mit dem gRPC-Channel disposed],
  [`LoggerFactory`], [`null`], [Logging-Schnittstelle für gRPC Calls],
  [`Credentials`], [`null`], [Authentifizierungs-Credentials am Server],
)

```cs
GrpcChannel channel = GrpcChannel.ForAddress(
  "https://localhost:5001",
  new GrpcChannelOptions { MaxSendMessageSize = 2 * 1024 * 1024  }
);
```

== Deadlines & Cancellation
#grid(
  [
    Anstatt Timeouts gibt es in gRPC _Deadlines_. Dabei wird ein Timestamp mitgegeben und bei jeder Stelle überprüft, ob dieser
    bereits überschritten wurde.

    Sie können direkt beim Aufruf mitgegeben werden, entweder über `CallOptions`
    oder Direkt. Die Deadline muss UTC sein. Bei Überschreiten wird eine `RpcException` ausgelöst.
    Es kann server-seitig über `ServerCallContext` darauf zugegriffen werden.

    _Cancellation_ wird ähnlich gehandhabt: Mit `tokenSource.CancelAfter(1111)` das Timeout setzen, dann als Parameter mitgeben.
  ],
  [
    ```cs
    // Variante 1: Als callOption
    CallOptions callOptions = new(
      deadline: DateTime.UtcNow.AddMilliseconds(200));
    await client.DummyAsync(new Empty(), callOptions);
    // Variante 2: Direkt als Parameter
    await client.DummyAsync(new Empty(),
      deadline: DateTime.UtcNow.AddMilliseconds(200));
    // Zugriff auf Deadline server-seitig
    public override Task<Empty> Dummy(
      Empty request, ServerCallContext context) {
        Console.WriteLine(context.Deadline.ToString("O")
      );
    }
    ```
  ],
)

#table(
  columns: (1fr, 1fr),
  table.header([Deadlines], [Cancellation]),
  [
    Erwartet, evtl. planbar, quantifizierbar, Schutz vor zu langen Wartezeiten
  ],
  [
    Unvorhersehbar, Zufällig, Durch unberechenbaren Interrupt ausgelöst
    #hinweis[(Abbruch durch User, nicht mehr an Resultat interessiert)]
  ]
)


= Reflection & Attributes
#v(-0.5em)
== Reflection <reflection>
Reflections ermöglichen es, _Informationen über geladene Assemblies_ und die darin definierten Typen zur erhalten.
Auch können mit Reflections _Typinstanzen zur Laufzeit_ erstellt werden.\
*Anwendung:*
- Type Discovery #hinweis[(Suchen und Instanzieren von Typen, Zugriff auf dynamische Datenstrukturen -- z.B. JavaScript-Objekte)]
- Late Binding von Methoden/Properties #hinweis[(Aufruf von Methoden/Properties nach der Type Discovery)]
- Reflection Code-Emittierung #hinweis[(Erstellen von Typen & Members zur Laufzeit)]

=== Klasse `System.Type`
Alle Typen in der Common Language Runtime CLR sind _selbst-definierend_. Die Klasse `System.Type` ist der _Einstiegspunkt_
aller Reflection-Operationen. _Repräsentiert_ einen _Typen_ mit all seinen Eigenschaften. Ist eine _abstrakte Basisklasse_.
Alle Objekte sind Instanzen von Typen. Bildet auch Vererbungshierarchien ab.

==== `typeof` / `GetType()`
Ermitteln von `System.Type`. Mit ```cs typeof()``` erhält man `System.Type` durch Angabe des Typen selbst
#hinweis[(```cs typeof(int)```, ```cs typeof(List<string>)```)], durch ```cs .GetType()``` den eines Objekts oder Property
zur _Laufzeit_ #hinweis[(```cs int i; i.GetType();```)]. `System.Type` beschreibt sich selbst ebenfalls als `System.Type`-Objekt.

==== Member-Informationen / Typ-Hierarchie
Jeder Klassen-Member hat einen _eigenen Reflection-Typen_. "`System.Runtime.MemberInfo`" ist abstrakte Basisklasse für Members.
Bei der Suche nach Members ist es möglich zu filtern, z.B. nach der Sichtbarkeit #hinweis[(z.B. `public`)] oder
nach bestimmter Memberart #hinweis[(z.B. Properties)]. Nicht zugreifbare Members wie private Felder sind auch einsehbar.
Klassen befinden sich im Assembly "`mscorlib`" im Namespace "`System.Reflection`".

=== Beispiel Metadaten
==== Type-Discovery
#grid(
  [
    _Suche aller Typen in einem Assembly._\
    *Ausgabe:*
    ```
    ...
    System.Int32
      Method Int32 CompareTo(System.Object)
      Method Int32 CompareTo(Int32)
      Method Boolean Equals(System.Object)
      Method Boolean Equals(Int32)
      Method Int32 GetHashCode()
      Method System.String ToString()
    ...
    ```
  ],
  [
    ```cs
    Assembly a01 = Assembly.Load("mscorlib");

    Type[] t01 = a01.GetTypes();
    foreach (Type type in t01) {
      Console.WriteLine(type);

      MemberInfo[] mInfos = type.GetMembers();
      foreach (MemberInfo mi in mInfos) {
        Console.WriteLine(
          $"\t{mi.MemberType}\t{mi}");
      }
    }
    ```
  ],
)

==== Alle Members auslesen
#grid(
  [
    _Suche aller Members eines Typen._\
    *Ausgabe:*
    ```
    ...
    Int32 get_CountValue() is a Method
    Void set_CountValue(int32) is a Method
    Void Increment() is a Method
    ...
    ----------
    Int32 CountValue is a Property
    ...
    ```
  ],
  [
    ```cs
    Type type = typeof(Counter);
    MemberInfo[] miAll = type.GetMembers();
    foreach (MemberInfo mi in miAll) {
      Console.WriteLine($"{mi} is a {mi.MemberType}");
    }
    Console.WriteLine("----------");
    PropertyInfo[] piAll = type.GetProperties();
    foreach (PropertyInfo pi in piAll) {
      Console.WriteLine($"{pi} is a {pi.PropertyType}")
    }
    ```
  ],
)

==== Dynamisches auslesen von Members
#grid(
  [
    _Suche spezieller Members eines Typen._\
    *Ausgabe:*
    ```
    Assembly GetAssembly(Type) is a Method
    Int32 GetHashCode() is a Method
    Type GetType_Compat(String, String) is a Method
    Assembly GetExecutingAssembly() is a Method
    Assembly GetCallingAssembly() is a Method
    Assembly GetEntryAssembly() is a Method
    ...
    ```
  ],
  [
    ```cs
    Type type = typeof(Assembly);
    BindingFlags bf =
      BindingFlags.Public |
      BindingFlags.Static |
      BindingFlags.NonPublic |
      BindingFlags.Instance |
      BindingFlags.DeclaredOnly;
    MemberInfo[] miFound = type.FindMembers(
      MemberTypes.Method, bf, Type.FilterName, "Get*"
    ); // Hier: Filter nach Name einer Methode
    ```
  ],
)

=== Member Information
#v(1em)
#grid(
  [
    ==== Field Info
    Beschreibt ein _Feld auf einer Klasse_ #hinweis[(Name, Typ, Sichtbarkeit, etc.)]. Erlaubt lesen / schreiben eines Feldes.

    ```cs
    object GetValue(object obj);
    public void SetValue(object obj, object value);
    ```
  ],
  [
    ```cs
    Type type = typeof(Counter); Counter c = new(1);
    // All Fields
    FieldInfo[] fiAll = type.GetFields(
      BindingFlags.Instance | BindingFlags.NonPublic);
    // Specific Field
    FieldInfo fi = type.GetField("_countValue", BindingFlags.Instance | BindingFlags.NonPublic);
    int val01 = (int) fi.GetValue(c); c.Increment();
    int val02 = (int) fi.GetValue(c);
    fi.SetValue(c, -999);
    ```
  ],
)

#grid(
  [
    ==== Property Info
    Beschreibt ein _Property auf einer Klasse_ #hinweis[(Name, Typ, Sichtbarkeit, Informationen zu Get / Set, etc.)].
    Erlaubt lesen / schreiben eines Properties.

    ```cs
    object GetValue(object obj);
    public void SetValue( object obj, object value);
    ```
  ],
  [
    ```cs
    Type type = typeof(Counter); Counter c = new(1);
    // All Properties
    PropertyInfo[] piAll = type.GetProperties();
    // Specific Property
    PropertyInfo pi = type.GetProperty("CountValue");
    int val01 = (int) pi.GetValue(c); c.Increment();
    int val02 = (int) pi.GetValue(c);
    if (pi.CanWrite) { pi.SetValue(c, -999); }
    ```
  ],
)

==== Method Info
#grid(
  [
    Beschreibt eine _Methode_ auf einer Klasse #hinweis[(Name, Parameter / Rückgabewert, Sichtbarkeit, etc.)].
    Leitet von der _Klasse "`MethodBase`"_ ab #hinweis[(Basisklasse für `MethodInfo` und `ConstructorInfo`,
    Konstruktoren und Methoden sind aus Sicht der Metadaten recht ähnlich)]. Kann über `invoke`-Methode aufgerufen werden.
  ],
  [
    ```cs
    Type type = typeof(Counter); Counter c = new(1);
    // All methodes
    MethodInfo[] miAll = type.GetMethods();
    // Specific Method
    MethodInfo mi = type.GetMethod("Increment");
    mi.Invoke(c, null);

    // Mit Parametern
    Type type = typeof(System.Math);
    Type[] paramTypes = { typeof(int) };
    MethodInfo miA = type.GetMethod("Abs", paramTypes);
    object[] @params = { -1 }; // fill array with params
    object returnVal = miA.Invoke(type, @params);
    ```
  ],
)

==== Constructor Info
#grid(
  [
    Beschreibt einen _Konstruktoren_ einer Klasse #hinweis[(Name, Parameter, Sichtbarkeit, etc.)].
    Leitet von der _Klasse "`MethodBase`"_ ab. Kann über `invoke`-Methode aufgerufen werden.

    *Alternative via "Activator":*\
    #v(-0.5em)
    ```cs
    Counter c03 = (Counter)Activator.CreateInstance(
      typeof(Counter), 12 /*, ... */ );
    // Wenn Public Default Constructor existiert
    Counter c04 = Activator.CreateInstance<Counter>();
    ```
  ],
  [
    ```cs
    Type type = typeof(Counter);
    // All Constructors
    ConstructorInfo[] ciAll = type.GetConstructors();
    // Specific Constructor Overload 1:
    ConstructorInfo ci01 = type.GetConstructor(
      new[] { typeof(int)} );
    Counter c01 = (Counter)ci01.Invoke(
      new object[] { 12 });
    // Specific Constructor Overload 2:
    ConstructorInfo ci02 = type.GetConstructor(
      BindingFlags.Instance | BindingFlags.NonPublic,
      null, new Type[0], null);
    Counter c02 = (Counter)ci02.Invoke(null);


    ```
  ],
)


== Attributes
#grid(
  [
    Entsprechen _Java Annotations_. Erweitern bestehende Attribute wie "`public`", "`static`", "`abstract`" oder "`sealed`".
    Ermöglichen _spezifische Aspekte_ #hinweis[(Erweiterbare Elemente)].

    _Abfrage über Reflection möglich: _`ReflectionAttributes.Attributes.Auto`

    _Basisklasse: "`System.Attribute`"_
  ],
  [
    ```cs
    [DataContract, Serializable]
    [Obsolete] // Etc.
    public class Auto {
      [DataMember]
      public string Marke { get; set; }
      [DataMember]
      public string Type { get; set; }
    }
    ```
  ],
)

*Anwendungsfälle:*
Object-relational Mapping, Serialisierung, Security und Zugriffssteuerung, Dokumentation, etc. \
*Arten von Atributen:*
_"Intrinsic" Attribute_ #hinweis[(In CLR definiert und integriert, teilweise vom Compiler berücksichtigt, wie z.B. "obsolete")]
und _"Custom" Attribute_ #hinweis[(In Framework Class Library, Selbst definierte Attribute)]

=== Syntax
Es sind _beliebig viele_ Attribute möglich, Deklaration entweder _separat_ #hinweis[(`[DataContract][Serializable]`)] oder
_komma-separiert_ #hinweis[(`[DataContract, Serializable]`)]. Je nach Implementation eines Attributes kann es _mehrfach_
angewandt werden.

_Parameter / Werte_ müssen vom Compiler berechenbar sein:
```cs [Datacontract]```, ```cs [Datacontract(Name = "AutoClass")]```, ```cs [Obsolete("Alt!", true)]```,
```cs [Obsolete("Alt!", IsError = true)]```

=== Custom Attribute <custom-attribute>
Im Beispiel wird ein ```cs [BugfixAttribute]``` für Dokumentation implementiert. Die Klasse hat selbst das Attribut ```cs [AttributeUsage]```,
welches bestimmt, wo ein Attribut verwendet werden kann. Durch `AllowMultiple` kann es mehrfach am selben Member angebracht werden.

#grid(
  [
    ```cs
    // Deklaration
    [AttributeUsage(
        AttributeTargets.Class |
        AttributeTargets.Constructor |
        AttributeTargets.Field |
        AttributeTargets.Method |
        AttributeTargets.Property,
        AllowMultiple = true)]
    public class BugfixAttribute : Attribute {
      public BugfixAttribute(
        int bugId, string programmer, string date) {
        /* ... */
      }
      public int BugId { get; }
      public string Date { get; }
      public string Programmer { get; }
      public string Comment { get; set; }
    }
    ```
  ],
  [
    ```cs
    // Verwendung
    [Bugfix(121, "Nina Grässli", "16/01/2025")]
    [Bugfix(107, "Jannis Tschan", "17/01/2025",
      Comment = "Some major changes!")]
    public class myMath {
      [Bugfix(121, "Nina Grässli", "20/01/2025")]
      public int MyInt { get; set; }

      // Compilerfehler, weil event kein AttributeTarget
      [Bugfix(148, "Jannis Tschan", "23/01/2025")]
      public event Action CalculationDone;
      /* ... */
    }
    ```
  ],
)

==== Abfrage via Reflection
#grid(
  [
    Attribute können über Reflection abgefragt werden. Das `ICustomAttributeProvider`-Interface stellt
    ```cs IsDefined()``` #hinweis[(Prüft, ob ein bestimmtes Attribut vorhanden ist)] und
    ```cs GetCustomAttributes()``` #hinweis[(Liste aller Attribute)] zur Verfügung.

    Abfrage von Attribute-Information über Klasse "`Type`". "`true`" berücksichtigt auch vererbte Attribute.
  ],
  [
    ```cs
    Type type = typeof(MyMath);
    // All Class Attributes
    object[] aiAll = type.GetCustomAttributes(true);
    IEnumberable<Attribute> aiAllTyped =
      type.GetCustomAttributes(typeof(BugfixAttribute));
    // Check Definition
    bool aiDef =
      type.IsDefined(typeof(BugfixAttribute));
    ```
  ],
)
