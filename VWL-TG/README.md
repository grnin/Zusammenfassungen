# Komprimierung der VWL-Zusammenfassung

Das PDF der VWL-Zusammenfassung ist wegen seiner vielen Bilder zu gross für das Studentenportal. Mit dem folgenden GhostScript-Befehl
kann das PDF auf eine angemessene Dateigrösse komprimiert werden, ohne dass die Bilder sichtbare Qualitätseinbussen erleiden.
Damit passt es auch auf das Studentenportal. Das PDF in diesem Repository wurde _nicht_ komprimiert.

```sh
gs -sDEVICE=pdfwrite -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sOutputFile=VWL-TG/VwlWp_Zusammenfassung_FS25_JT_MG_MS.pdf VWL-TG/VwlWp_Zusammenfassung_FS25_JT_MG_MS.pdf
```
