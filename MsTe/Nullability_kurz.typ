// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *
#import "@preview/codelst:2.0.2": sourcecode


#grid(
  columns: (1fr, 0pt, 1fr),
  [
    _Reference Types_ \
    Generic Reference Type mit `is null / is not null` prüfen, da == Operator überschrieben werden kann. \
    
    *Nullable Reference Types*
    ```cs
    string s1; // Non-nullable
    string? s2; // Nullable
    ```
    
    _Warnungen_
    ```cs
    // Activate Compiler "null" Warnings
      #nullable enable 
    // Deactivate Compiler "null" Warnings
      #nullable disable
    // Restore project default
      #nullable restore 
    ```
    ```cs
    // Null-forgiving Operator ! : keine null Warnung bei non nullable Typ = null!
    string s3 = null!;
    ```
  
  ],
  grid.vline(stroke: 0.5pt),
  block(),
  [
    _Value Types_
    Normalen (not nullable) Value Type mit `is null` zu prüfen gibt immer false (Compilerfehler wenn `T : struct`).
    
    
    _Nullable Value Types_ \
    // Grosser Unterschied zu Nullable Reference Types!\
    Mit *T? Syntax* Value Types null zuweisen, im Hintergrund `System.Nullable<T>` Klasse. Check `is null` möglich.
    ```cs
    int? x = 123;
    int? n = null;
    
    // Klassisches lesen
    int x1 = n.HasValue ? n.Value : default;
    // Via Methode die in C# immer vorhanden ist
    int x2 = n.GetValueOrDefault();
    // Via Methode & eigenem Default
    int x3 = n.GetValueOrDefault(-1);
    // mit null-coalescing operator
    int x3 = n ?? -1;
    ```
  ],
)

\

#grid(
  [
    _Default Operator_ \
    speichert null bei Reference Type und default Wert bei Value Type.
    ```cs
    public void NullExamples<T>() {
      T x3 = default(T); // OK, default operator
      T x4 = default;    // OK, default literal
    }
    ```
  ],
  [
    
    _? null-coalescing Operatoren_\
    Anstelle von -1 könnte auch eine throw Anweisung stehen.
    - ?? null-coalescing operator
    - ??= null-coalescing assignment operator
    - ?. null-conditional operator
    ```cs
      int? n = null;
      int i = n ?? -1; // output : -1
    
      // null-coalescing assignment operator
      int? i = null;
      i ??= -1
    
      // null-conditional
      object o = null;
      Action a = null;
      string s = o?.ToString();
      a?.Invoke(); // gesehen bei Delegates 
    ```
  ],
)



#pagebreak()

== Record Types Kurz
// siehe @record-types\

#grid(
  [
    *Record* \
    Um in einer Klasse nur Daten zu speichern "Datenrepräsentationsklasse".
    - immutable
      - mit "with" einfach leicht modifizierte Kopien erzeugen
    - readonly (initialisieren).
    - vererbbar
    
  
  ],
  [
    *Generierte Members*
    - Konstruktor
    - Properties (immutable, init only)
    - Value equality
      - \== und p1.Equals(p2)
      - kein Reference-Vergleich
      - auch Basisklassen-Properties werden beachtet)
    - Darstellung (ToString-Methode, etc.)
    - Vererbung wird berücksichtigt (z.B. Equality)
  
  ],
)

\
\
\

#grid(
  [
    
    *positional Syntax (mit Parametern)*
    ```cs
    public record [class|struct] Person (
      int Id, 
      string Name
    );
    ```
    \
    *Anwendungsbeispiel*
    ```cs
    Person p1 = new();
    Person p2 = new(1, "Mary");
    
    Person p3 = p1 with { Id = 3 };
    bool eq2 = p1 == p3; // false
    Person p4 = p1 with { };
    bool eq3 = p1 == p4; // true
    ```
  ],
  [
    *manuelle Deklaration (nicht empfohlen)*
    ```cs
    public record Person
    {
      // muss dann manuell den Konstruktor erstellen
      public Person() : this(0, "") { }
      public Person(int id, string name)
      {
        Id = id;
        Name = name;
      }
    
      public int Id { get; init; }
      // mutable wäre theoretisch möglich?
      public string Name { get; set; }
    };
    ```
  
  ],
)


#grid(
  [
    
    *Vererbung*
    ```cs
    public abstract record Person(int Id);
    public record SpecialPerson(
      int Id,
      string Name
    ) : Person(Id);
    
    // Anwendungsbeispiel
    SpecialPerson p1 = new(1 , "Mary");
    Person p2 = p1;
    ```
  ],
  [
    *Mixed Deklaration*
    ```cs
    public record Person(int Id)
    {
      public string Name { get; init; } 
      public void DoSomething() { }
    } // non-nullable Warnung
    
    Person p1 = new(0);
    p1.Name = ""; // Compilerfehler
    Person p2 = new(0) { Name = "Hallo"}; // Ok
    ```
  ],
)