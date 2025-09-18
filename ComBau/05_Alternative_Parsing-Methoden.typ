#import "../template_zusammenf.typ": *

= Alternative Parsing-Methoden
#grid(
  columns: (1.5fr, 1fr),
  gutter: 2em,
  [
    == Syntaxgesteuerte Übersetzung
    - _Annotationen_ zu den Syntaxregeln: Attribute zu den Symbolen, Semantische Regeln pro Syntax-Regel,
      Semantische Aktionen innerhalb von Syntax-Regeln.
    - _Zweck:_ Zusätzliche Aktionen beim Parsen
      #hinweis[(Type Checks, Syntaxbaum erzeugen, Code-Generierung, Direkte Auswertung von konstanten Expressions)]
    - Wird oft in _Parser-Generatoren_ verwendet #hinweis[(z.B. yacc, bison)]

    #hinweis[*Beispiel:* Bei Erkennung des Syntaxteils wird das entsprechende Zeichen ausgegeben]
  ],
  image("img/combau_11.png"),
)

#grid(
  columns: (1.5fr, 1fr),
  gutter: 2em,
  [
    === Vorteile / Nachteile
    - _Vision:_ Alles in der Grammatik beschrieben. Ganzer Compiler von A bis Z generieren, quasi ein "Compiler-Compiler".
    - _Praxis:_ Unübersichtlich und kompliziert #hinweis[(Seiteneffekte im Parser, Verteilte Code-Snippets in der Regeln,
      Syntax & Semantik gemischt, meist nur für Syntaxbaum-Erzeugung genutzt)]

    #hinweis[*Beispiel:* Weise Symbole Attribute zu und verwende sie in semantischen Regeln (hier als Type Checks)]
  ],
  image("img/combau_19.png"),
)

#grid(
  columns: (1.2fr, 1fr),
  gutter: 1.5em,
  [
    == Bottom-Up Parser
    Lese Token im Text _ohne fixes Ziel_. Prüfe nach _jedem Schritt_, ob gelesene Folge einer _EBNF-Regel_ entspricht.
    - _Wenn ja:_ Reduziere auf Nichtterminal-Symbol (`REDUCE`)
    - _Wenn nein:_ Lese weiteres Token im Input (`SHIFT`)
    Am Schluss bleibt _Startsymbol_ übrig, ansonsten war ein\ _Syntaxfehler_ vorhanden.

    === Vereinfachte Parsing-Strategie
    Lässt sich mit einer Tabelle abbilden. _Probleme:_ Performance, keine Zustandsabhängigkeit.
  ],
  image("img/combau_12.png"),
)

== LR-Parser
Ein LR-Parser ist _mächtiger_ als ein LL-Parser, weil er z.B. _Linksrekursion_ behandeln kann #hinweis[(z.B. `E = [E] "x"`)].
- _`LR(0)`:_ Parse-Tabelle ohne Lookahead erstellen. Aktueller Parse-Table-Zustand reicht, um zu entscheiden.
- _`SLR(k)`:_ Simple `LR`. Lookahead bei `REDUCE`-Schritten, um Konflikt zu lösen. Keine neuen Zustände.
- _`LALR(k)`:_ Look-Ahead `LR`. Analysiert Sprache auf `LR(0)`-Konflikte. Benutzt Lookahead bei Konfliktstellen
  und fügt dann neue Zustände in der Parse Table ein.
- _`LR(k)`:_ Pro Grammatikschritt + Lookahead ein Zustand. Nicht praxistauglich, da zu viele Zustände.

In der Praxis genügt meist ein _`LL(k)`-Parser_, die Grammatik kann oft dahingehend angepasst werden. C++, Java und
C\# haben handgeschriebene LL-Parser, obwohl ihre Grammatik nicht für LL entworfen wurde. Die Grammatik wurde stellenweise
angepasst oder es werden längere Lookaheads verwendet. Bei _Parser-Generatoren_ sind `LARL(k)` und `LL(k)` verbreitet.

=== Details
- _Parser-Bauteile:_ Input-Symbol-Stream mit Lookahead,
  Zustandsmaschine #hinweis[(um nach einer Reduktion in einen neuen Zustand zu gelangen)],
  Ableitungs-Stack #hinweis[(speichert die erkannten Symbole und aktuellen Zustände)] und
  Parse-Tabelle #hinweis[(Aktionen pro Zustand & nächster Input)].
- _4 mögliche Aktionen_ beim Analysieren jedes Symbols:
  - `SHIFT` #hinweis[(lesen und pushen des nächsten Symbols auf den Stack)]
  - `REDUCE` #hinweis[(den Stack auf die linke Seite einer Produktion reduzieren)]
  - `ACCEPT` #hinweis[(Syntaktische Analyse erfolgreich)]
  - `ERROR` #hinweis[(Syntaktischer Fehler aufgetreten)]

=== Konstruktion
+ _Grammatik anpassen:_ Umformulierung in BNF #hinweis[(Dediziertes Startsymbol einführen,
  EBNF-Wiederholung durch Rekursion ersetzen, EBNF-Optionen eliminieren, indem sie in mehrere Produktionen aufgeteilt werden)]
+ _Zustandsmaschine berechnen:_
  - _Item:_ #hinweis[(Produktion mit Kennzeichnung, wie weit der Parser bereits analysiert hat
    -- in den Folien-Beispielen ein "#sym.circle.filled")]
  - _Handle:_ #hinweis[(Item, das Kennzeichnung am Schluss hat. Bedeutet, dass Produktion reduziert werden kann)]
  - _Closure:_ #hinweis[(Enthält alle equivalenten Produktionen eines Item, d.h. befindet sich die Kennzeichnung bei einem
    nicht-Terminalsymbol wird dieses aufgelöst, bis alle mögliche Varianten dieser Produktion gefunden wurden)]
  - _Goto:_ #hinweis[(Set eines Terminalsymbols, dass alle BNF-Regeln mit diesem Symbol darin enthält.
    Goto-Sets werden so lange aufgelöst, bis daraus ein vollständiges Zustandsdiagramm erstellt werden kann)]
+ _Parse-Tabelle bauen:_ `FOLLOW(X)`-Set
  #hinweis[(Menge aller Terminalsymbole, die auf das Nicht-Terminalsymbol `X` folgen können)]

=== Parser-Tabelle
Der Parser muss wissen, was er als _nächsten Schritt_ tun muss. Diese möglichen Schritte werden in einer _Parser-Tabelle_
abgespeichert. Die Erzeugung ist _kompliziert_, _Entscheidungskonflikte_ sind möglich.\
- _Shift-Reduce-Konflikte_ #hinweis[(Es sind sowohl `Shift` als auch `Reduce` möglich)]
- _Reduce-Reduce-Konflikte_ #hinweis[(Es gibt mehrere mögliche Produktionen, auf welche reduziert werden kann)]

Um diese aufzulösen, gibt es verschiedene Vorgehensweisen:
_Zusätzliche Regeln_ im Parser zur Konfliktbehebung, _Anpassung der Grammatik_ oder _grösserer Lookahead_.
