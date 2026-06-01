#import "./ctx.typ": *
#import "./mafs.typ": *
#import "./overrides.typ": *
// TODO: i18n

#let translations = (
  de: (
    associativity: [Assoziativität],
    distributivity: [Distributivität],
    commutativity: [Kommutativität],
    transposing: [Transponierung],
    identity_matrix: [Identitätsmatrix],
    inverting: [Invertierung],
    determinate: [Determinante],
    scalars: [Skalare],
  ),
  en: (
    associativity: [Associativity],
    distributivity: [Distributivity],
    commutativity: [Commutativity],
    transposing: [Transposing],
    identity_matrix: [Identity matrix],
    inverting: [Inverting],
    determinate: [Determinate],
    scalars: [Scalars],
  ),
)

#let trans = k => context translations.at(text.lang).at(k)

#let shared = (
  calc-rsa: context if text.lang == "de" [
    + Wähle zwei Primzahlen $p,q$
    + Berechne $n = p dot q$
    + Berechne $phi(n)=(p-1)(q-1)$
    + Wähle $a,b$ so, dass $a dot b equiv 1 mod phi(n)$
    + Vergesse $p,q,phi(p dot q)$. Brauchen wir nicht und riskieren nur, dass
      uns jemand hackt

    Public key ist nun $n,b$, Private key ist $n,a$ \

    - Verschlüsseln: $z = c^a mod n$ \
    - Entschlüsseln: $c = z^b mod n = c^a^b mod n$ \
  ] else [
    + Choose two prime numbers $p,q$
    + Calculate $n = p dot q$
    + Calculate $phi(n)=(p-1)(q-1)$
    + Choose $a,b$, so that $a dot b equiv 1 mod phi(n)$
    + Forget $p,q,phi(p dot q)$

    Public key is now $n,b$, private key is $n,a$ \

    - Encrypt: $z = c^a mod n$ \
    - Decrypt: $c = z^b mod n = c^a^b mod n$ \
  ],
  e-euklid: [
    Seien $a,b in NN, a != b, a != 0, b != 0$ \
    Initialisierung: Setze
    $x:=a,y:=b,q:=x div y,r:=x-q dot y,(u,s,v,t)=(1,0,0,1)$ (d.h. bestimme q und
    r so, dass $x=q dot y+r$ ist) \
    Wiederhole bis $r=0$ ist \
    Ergebnis: $y = "ggT"(a,b) = s dot a + t dot b$ \
    Wenn $"ggT"(a,b)=1$ ist, dann folgt: $t dot v equiv 1 mod a$

    #exbox(title: $"ggT"(99,79)$, [#table(
        columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
        table-header(
          [$i$],
          [$x = y_(-1)$],
          [$y = r_(-1)$],
          [$#tr($q$) = x div y$],
          [$r=x - #tr($q$) dot y$],
          [$u = #tb($s_(-1)$)$],
          [$#tb($s$) = u_(-1) - #tr($q_(-1)$) dot #tb($s_(-1)$)$],
          [$v = #tg($t_(-1)$)$],
          [$#tg($t$) = v_(-1) - #tr($q_(-1)$) dot #tg($t_(-1)$)$],
        ),

        [$i=0$], [$99$], [$79$], [$1$], [$20$], [$1$], [$0$], [$0$], [$1$],
        [$i=1$], [$79$], [$20$], [$3$], [$19$], [$0$], [$1$], [$1$], [$-1$],
        [$i=2$], [$20$], [$19$], [$1$], [$1$], [$1$], [$-3$], [$-1$], [$4$],
        [$i=3$],
        [$19$],
        [#tr($1$)],
        [$19$],
        [$0$],
        [$-3$],
        [#tr($4$)],
        [$4$],
        [#tr($-5$)],
      )
      Daraus folgend:
      - $"ggT"(99,79)=4 dot 99+(-5) dot 79 <=> 396-395=1$
      - $99 + (-5) = 94$ ist mult. Inv. von $79$ in $ZZ_99$
      - $79 + 4 = 83 equiv 4$ ist mult. Inv. von $99$ in $ZZ_79$
    ])
  ],
  euler: context if text.lang == "de" [
    Sei $n in NN without {0}$ und $z in ZZ$ mit $"ggT"(z,n)=1$. Dann ist
    $z^(phi(n)) equiv 1 mod n$.
  ] else [
    Let $n in NN without {0}$ and $z in ZZ$ with $"gcd"(z,n)=1$. Then
    $z^(phi(n)) equiv 1 mod n$.
  ],
  euler-phi: context if text.lang == "de" [
    Sei $n in NN without {0}$ und
    $ZZ_n^* = {x in ZZ_n mid(|) x "hat ein multiplikatives Inverses in " ZZ_n}$.
    \
    Dann heisst $phi(n)$:
    $
      phi(n) & = "Anz. Elemente in " ZZ_n "mit mult. Inversen" \
             & ="Anz. Zahlen" 1<=q<=n "mit ggt"(q,n)=1 \
             & =abs(ZZ_n^*)
    $

    _Rechenregeln_

    + Sei $n in NN$ eine Primzahl, dann $phi(n) = n - 1$
    + Sei $n in NN$ eine Primzahl und $p in NN without {0}$, dann
      $phi(n^p) = n^(p-1) dot (n-1)$
    + Seien $m,n in NN without {0}$ und $"ggT"(m,n) = 1$, dann
      $phi(n dot m) = phi(n) dot phi(m)$
  ] else [
    Let $n in NN without {0}$ and
    $ZZ_n^* = {x in ZZ_n mid(|) x "has a multiplicative inverse in " ZZ_n}$.
    \
    Then $phi(n)$ defines:
    $
      phi(n) & = "Nr. of elements in " ZZ_n "with mult. inv." \
             & ="Amount of Numbers " 1<=q<=n "with gcd"(q,n)=1 \
             & =abs(ZZ_n^*)
    $
    We also call those numbers _relatively prime with $n$_.

    _Rules_

    + Let $n in NN$ a prime number, then $phi(n) = n - 1$
    + Let $n in NN$ a prime number and $p in NN without {0}$, then
      $phi(n^p) = n^(p-1) dot (n-1)$
    + Let $m,n in NN without {0}$ and $"gcd"(m,n) = 1$, then
      $phi(n dot m) = phi(n) dot phi(m)$
  ],
  pred-rules: grid(
    columns: (1.5fr, 2fr, 2.5fr),
    $
      & (A => B) <=> (not B => not A) \
      & (A => B) <=> (not A or B) \
    $,
    $
      & (A <=> B) <=> (A and B) or (not A and not B) \
      & not (A => B) <=> A and not B \
    $,
    $
      & A or (not A and B) <=> A or B \
      & (A => B => C) <=> (A => B) and (B => C)
    $,
  ),
  pred-rules-tbl: deftbl(
    [Abtrennungsregel],
    [
      $(A and (A => B)) => B$
    ],
    [Kommutativität],
    [
      $(A and B) <=> (B and A)$ \
      $(A or B) <=> (B or A)$
    ],
    [Assoziativität],
    [
      $A and (B and C) <=> (A and B) and C$ \
      $A or (B or C) <=> (A or B) or C$
    ],
    [Distributivität],
    [
      $A and (B or C) <=> (A and B) or (A and C)$ \
      $A or (B and C) <=> (A or B) and (A or C)$
    ],
    [Absorption],
    [
      $A or (A and B) <=> A$ \
      $A and (A or B) <=> A$
    ],
    [Idempotenz],
    [
      $A or A = A$ \
      $A and A = A$
    ],
    [Doppelte Negation],
    [
      $not (not A) <=> not not A <=> A$
    ],
    [Konstanten],
    [
      $W= "wahr"$ \
      $F= "falsch"$
    ],
    [de Morgan],
    [
      $not (A and B) <=> not A or not B$ \
      $not (A or B) <=> not A and not B$
    ],
  ),
  mult-inv: [
    Für $a in ZZ_q$ ist $b in ZZ_q$ das _multiplikative inverse_ von a, wenn
    $a dot b equiv 1 mod q$
  ],
  rss-def: context $
    R S S = sum_(i=1)^N underbrace(
      (#td($y_i$) - #tp($f(x_i)$))^2, #if text.lang == "de" [Im Diagramm als
        #tr([rote\ Vierecke]) repräsentiert] else [Represented as #tr([red\
          squares]) in the example]
    ) \
    R S S(#tp($m,b$)) = sum_(i=1)^N (#td($y_i$) - #tp($(m x_i + b)$))^2 >= 0, R S S: RR^2 -> RR
  $,
  rss-ex: context exbox(
    title: if text.lang == "de" [Lineare regression von Gehältern nach
      Alter] else [Linear regression of salaries by age],
    [
      $
        RSS(#tp($m,b$)) = sum_(i=1)^N (#tp($(m x_i + b)$) - #td($y_i$))^2 >= 0, RSS: RR^2 -> RR
      $

      #let rng = suiji.gen-rng-f(42)
      #let xs = range(0, 10)
      #let (rng, ys1) = deviate-x(rng, xs)
      #let (rng, ys2) = deviate-x(rng, xs)
      #let (rng, ys3) = deviate-x(rng, xs)
      #let (rng, ys4) = deviate-x(rng, xs)
      #let ysall = ys1.zip(ys2, ys3, ys4).map(ys => ys.sum() / ys.len())
      #let (m, b) = linear-regression(xs, ysall)
      #let rss-rect = (ys, n) => {
        let y = m * xs.at(n) + b
        let w = ys4.at(n) - y
        (
          lq.rect(
            n,
            y,
            width: -w,
            height: w,
            stroke: colors.red,
            fill: colors.red.transparentize(80%),
            label: $RSS_#(n * 6 + 20)$,
          ),
          lq.line(
            (n, y),
            (n, ys4.at(n)),
            stroke: (
              paint: colors.darkblue,
              thickness: 2pt,
              cap: "round",
              dash: "dashed",
            ),
          ),
          lq.plot(
            (n, n),
            (ys4.at(n), ys4.at(n)),
            mark: mark => place(
              center + horizon,
              circle(
                fill: colors.darkblue,
                stroke: colors.darkblue,
                radius: 2pt,
              ),
            ),
            mark-color: colors.black,
            z-index: 99,
          ),
        )
      }

      #align(center, diagram2d(
        // title: $RSS = #rss(xs.map(t => t * 6 + 20), ysall.map(t => t * 10000 + 20000))$,
        yaxis: (
          lim: (-0.5, 11),
          label: if text.lang == "de" [Gehalt] else [Salary],
          format-ticks: (ticks, ..) => ticks.map(t => str(t * 10000 + 20000)),
        ),
        xaxis: (
          lim: (-0.5, 11),
          label: if text.lang == "de" [Alter] else [Age],
          format-ticks: (ticks, ..) => ticks.map(t => str(t * 6 + 20)),
        ),
        width: 10cm,
        height: 10cm,
        legend: (position: horizon + right),
        lq.scatter(xs, ys1, color: colors.darkblue),
        lq.scatter(xs, ys2, color: colors.darkblue),
        lq.scatter(xs, ys3, color: colors.darkblue),
        lq.scatter(xs, ys4, color: colors.darkblue),
        lq.plot(
          xs,
          xs.map(x => m * x + b),
          color: colors.purple,
          label: if text.lang == "de" [Lineare\ regression] else [Linear\
            regression],
        ),
        ..rss-rect(ys4, 6),
        ..rss-rect(ys4, 2),
      ))],
  ),
  vec-rules: $
    lambda ve(0) = ve(0) \
    ve(v) + ve(0) = ve(v) \
    -ve(v) = -1 dot ve(v) \
    -ve(v) + ve(v) = ve(0) \
    (lambda mu)ve(v) = lambda(mu ve(v)) = lambda mu ve(v) \
    lambda(ve(v)+ve(w)) = lambda ve(v) + lambda ve(w) \
    ve(v) + (ve(u)+ve(w)) = (ve(v) + ve(u))+ve(w) = ve(v) + ve(u)+ve(w) \
  $,
  mat-rules: context deftbl(
    definition: "Rules",
    trans("associativity"),
    $
      (A + B) + C = A + (B + C) = A + B + C \
      (A dot B) dot C = A dot (B dot C) = A dot B dot C \
    $,
    trans("distributivity"),
    $
      C dot (A + B) = C dot A + C dot B \
      (A + B) dot C = A dot C + B dot C
    $,
    trans("commutativity"),
    $
      A + B = B + A \
      A dot B != B dot A \
    $,
    trans("transposing"),
    $
      (A^T)^T = A \
      (A+B)^T = A^T + B^T \
      (lambda A)^T = lambda A^T \
      (A dot B)^T = B^T dot A^T \
      A_(i j) = A^T_(j i) \
    $,
    trans("identity_matrix"),
    $
      bb(1) dot A = A dot bb(1) = A "for" A in RR^(n times n) \
    $,
    trans("inverting"),
    $
      A dot A^(-1) = A^(-1) dot A = bb(1) \
    $,
    trans("determinate"),
    $
      det(lambda M) = lambda^n det(M), M in RR^(n times n) \
      det mat(A, *; 0, B) = det(A) dot det(B) \
      det(A dot B) = det(A) dot det(B) \
      det(A^(-1)) = 1/det(A) \
      det(A^T) = det(A)
    $,
    trans("scalars"),
    $
      (lambda + mu) A = lambda A + mu A \
      (lambda mu) A = lambda (mu A) \
      lambda (B + C) = lambda B + lambda C \
      lambda (B C) = (lambda B) C = B (lambda) C
    $,
  ),
)
