// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *
#import "@preview/codelst:2.0.2": sourcecode

#show: project.with(
  // authors: ("Nina Grässli", "Jannis Tschan", "Jasmin Fässler"),
  // fach: "MsTe",
  // fach-long: ".NET Technologien",
  // semester: "HS25",
  // language: "de",
  // tableofcontents: (enabled: true, depth: 2, columns: 2),
  font-size: 10pt,
  // appendix: none,
  // authors: none,
  // display-title-footer: false,
  // display-title-header: false,
)


// Global configuration
#set grid(columns: (1fr, 1fr), gutter: 1em)
#show grid: set par(justify: false, linebreaks: "optimized")
#set figure(supplement: none)

// Set styles for the gRPC example code blocks
#let code-example(body) = {
  // sourcecode uses a table internally, the template styles the first row with emph, disable here
  show emph: set text(fill: black, style: "italic", weight: "regular")
  set text(size: 0.88em, 
    top-edge: 0.98em
  )
  
  // line-height heisst einfach top-edge in typst und es verzerrt den Text?.. typst ist mühsam.
  // set block(spacing: 5em)
  // set par(leading: 15em, spacing: 21em)
  

  sourcecode(lang: "cs", body, frame: none)
}





=== Beispiel: LINQ von Nath
Alle Bücher und Pages aus Tabelle Books laden
*Library Context*
#v(-0.5em)
```cs
  public class LibraryContext : DbContext {
    // ctor
    // ...
    public virtual DbSet<Book> Books{ get; set; } // virtual wichtig für lazy loading
    public virtual DbSet<Page> Pages{ get; set; }
  }
  // In Entities Collection Property: public virtual ICollection<Page> Pages { get; set; }
```

*Version 1*
\
#v(-0.5em)
```cs
List<Book> buecher = new ();
await using (LibraryContext context = new()) {
  buecher = await context.Books
  .Include(b => b.Pages)   // Eager Loading
  .ToListAsync(); 
}  // Verbindung wird getrennt
```

#grid(
  [
    \
    *Mit LINQ*
    #v(-0.5em)
    ```cs
  await using (LibraryContext context = new()) {
    var q1 = from b in context.Books
    where b.Author == "Nath"
    orderby b.Name
    select new { b.Name, b.Preis };
  }
    ```
    // // ForEachAsync nicht gelernt, besser mit foreach loop
    // await q1.ForEachAsync(b => Console.WriteLine(b));
    // // Alternative, nicht gelernt
    // await foreach (var b in q1.AsAsyncEnumerable())
    // {
    //   Console.WriteLine($"{b.Name} - {b.Preis}");
    // }
  ],
  [
    \ \
    #v(-0.5em)
    ```cs
  await using (LibraryContext context = new()) {
    var q2 = from b in context.Books
      where b.Length > 600
      join p in context.Pages on b.Id equals p.BookId
      group p by p.PageNumber
        into g
        select new { Num = g.Key, g.Count() };
  }
    ```
  ],

)


==== Add und Delete mit Lazy Loading
```cs
await using (LibraryContext context = new()) {
  var badBooks = context.Books.Where(b => b.Rating <= 3); // noch kein Zugriff auf DB
  foreach (Book b in badBooks) {  // DB-Zugriff
    foreach (Page p in b.Pages) { // DB-Zugriff
      // V1 als "zum löschen" markiert, Referenzen können in C# noch vorhanden sein.
      context.Entry(p).State = EntityState.Deleted; 
    }

    b.Pages.Clear(); // V2 nur C# Collection Property, nicht DB ausser bei cascading evt.

    b.Pages.Add(new Page{ content = "lol", PageNumber=0});

    // alle Pages löschen (1+N Query Problem) :
    context.Pages.RemoveRange(b.Pages);  
  } 
  await context.SaveChangesAsync(); // DB-Zugriff
}
```


==== Alle Pages löschen mit Eager Loading
```cs
var pagesToDelete =
  from b in context.Books
  where b.Rating <= 3
  from p in b.Pages
  select p;

context.Pages.RemoveRange(pagesToDelete);
```
\


#pagebreak()
#grid(
  [
  ==== refl. code für s. 73
  ```cs
    var bfType = typeof(BugfixAttribute);
    if (method.IsDefined(bfType)) {
      BugfixAttribute b = (BugfixAttribute)method
        .GetCustomAttributes(bfType)
        .Single();
      return b.BugId;
    }
    return 0
  
  // Gemäss Internet gibt es eine besser Variante
  var bugfix = method.GetCustomAttribute<BugfixAttribute>();
  return bugfix?.BugId ?? 0;
  // mit Vererbung: 
  // ..GetCustomAttribute<..>(inherit: true);
  ```
  \
  ],
)