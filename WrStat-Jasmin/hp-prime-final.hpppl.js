// abspeichern in eine Funktion bei (Shift + 1) und mit CAS Modus. (ohne diese zeile!). Funktionen einzeln hinzufügen, wenn es sonst Fehler gibt.
EXPORT linRegrTabelle()
BEGIN

    C1^2▶C3;
    C2^2▶C4;
    //PRINT("(Werte geschrieben in Spalten C3 and C4)");
    C1*C2▶C5;
    //PRINT("(x*y geschrieben in C5)");
    PRINT("Tabelle: x^2=C3, y^2=C3, x*y= C4");


    PRINT("-------------------------");
    PRINT(" Unterste Zeile der Tabelle");
    PRINT("-------------------------");
    PRINT("---------- Summen: ---------------");

    PRINT("Σ(x) = " + ΣX); 
    PRINT("Σ(y) = " + ΣY); 

    PRINT(" ");

    PRINT("Σ(x^2) = " + ΣX2);
    PRINT("Σ(y^2) = " + ΣY2);

    PRINT(" ");

    PRINT("Σ(x*y) = " + ΣXY);


    PRINT("---------- Erwartungswerte: ------");

    PRINT("E(X) = " + MeanX); // MeanX manuell berechnen: mean(C1)
    PRINT("E(Y) = " + MeanY); 
    PRINT(" ");

    PRINT("E(X^2) = " + mean(C3));
    PRINT("E(Y^2) = " + mean(C4));

    PRINT(" ");


    PRINT("E(X*Y) = " + mean(C5));

    PRINT("-------------------------");


    PRINT(" -------- Ende -------- ");


    RETURN;
END;

EXPORT linearRegressionFormelnCov()
BEGIN
    PRINT("-------------------------");
    PRINT("  Cov und so  ");
    PRINT("-------------------------");

    PRINT("cov(X,Y) = E(XY) - E(X)*E(Y)");
    PRINT("= " + (ΣXY/SIZE(C1) - MeanX*MeanY));

    PRINT(" ");
    PRINT("var(X) = E(X^2) - E(X)^2");
    PRINT("= " + (ΣX2/SIZE(C1) - MeanX^2));
    //PRINT("= " + ΣX2 - MeanX^2);

    PRINT(" ");
    PRINT("var(Y) = E(Y^2) - E(Y)^2");
    PRINT("= " + (ΣY2/SIZE(C1) - MeanY^2));
    //PRINT("= " + (ΣY2 - MeanY^2));

    PRINT(" ");

    PRINT("-------------------------");
    PRINT(" Parameter a und b: ");

    PRINT("beachte das E^-2 und rechne es um!");

    PRINT("a = cov(X,Y) / var(X)");
    PRINT("= " + ((ΣXY/SIZE(C1) - MeanX*MeanY) / (ΣX2/SIZE(C1) - MeanX^2)));



    PRINT(" ");
    PRINT("b = E(Y) - a*E(X)");
    PRINT("= " + (MeanY - ((ΣXY/SIZE(C1) - MeanX*MeanY) / (ΣX2/SIZE(C1) - MeanX^2)) * MeanX));
    //PRINT("= " + (MeanY - ((ΣXY/C1 - MeanX*MeanY) / (ΣX2/C1 - MeanX^2)) * MeanX));


    PRINT(" ");
    PRINT("y(x) = a*x + b");
    PRINT(" ");

    PRINT(" ");
    PRINT("Zur Beurteilung der Qualität muss man den Regressionskoeffizienten r berechnen");
    PRINT(" ");

    PRINT("r = cov(X,Y) / sqrt(var(X)*var(Y))");
    PRINT("= " + ((ΣXY/SIZE(C1) - MeanX*MeanY) / sqrt((ΣX2/SIZE(C1) - MeanX^2) * (ΣY2/SIZE(C1) - MeanY^2))));


    // PRINT(" ");
    // PRINT("r^2 = " + (((ΣXY/SIZE(C1) - MeanX*MeanY) / sqrt((ΣX2/SIZE(C1) - MeanX^2) * (ΣY2/SIZE(C1) - MeanY^2)))^2));

    PRINT(" -------- Ende -------- ");
    

 RETURN;
END;




// TODO:
EXPORT wahrscheinlichkeitsdichte(fx)
BEGIN

    // // 1. Save the current display setting
    // LOCAL oldFormat:= HFormat;
    // // 2. Set format to Fraction (Value 3)
    // HFormat:= 3;


    f(x):=piecewise(x<-1,0,x<0,(x+1)^2,x<=1,1-x^2,0);

    PRINT(1);
    PRINT(f(x));
    f(x) := piecewise(x<-1,0,x<0,(x+1)^2,x<=1,1-x^2,0);
    ex2 := int(x ^ 2 * f(x), x, -1, 1);
    ex:= int(x * f(x), x, -1, 1);
    PRINT("Normierung:     " + int(f(x), x, -1, 1));   

    PRINT("Erwartungswert E(X): " + int(x*f(x), x, -1, 1) );
    PRINT(" E(X2):           "+int(x^2*f(x), x, -1, 1) );
    PRINT("Varianz:          "+ int(x^2*f(x), x, -1, 1) - ans(1)^2 );


    PRINT("Normierung:     " + int(f(x), x, -1, 1));


    PRINT("Erwartungswert E(X): " + ex );
    PRINT(" E(X^2):           "+ ex2 );
    PRINT(" (E(x))^2:           "+ (ex)^2 );
    PRINT("Varianz:          " + ex2 - ex^2 );
    // PRINT("Varianz:          " + int(x^2*f(x), x, -1, 1) - ans(1)^2 );

    PRINT(" -------- Ende -------- ");


    // // 3. Restore the original setting before the program ends
    // HFormat:= oldFormat;

    RETURN;
END;

