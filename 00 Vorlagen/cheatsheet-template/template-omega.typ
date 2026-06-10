#import "../../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)
#set enum(numbering: "1)1)")


= Heading 1

/ text-bold: explanation of it
  and more
/ another item: explanation
/ colored text: #tr[red], #td[darkblue], #tg[green]
#tr[
  / text-bold: works inside typst element
]

/ Example: Data that has been processed in a way that gives it meaning and
  value



== Heading 2
Normal Text paragraph


#todo[notes 12]



=== Heading 3
+ numbered list
+ *text bold*: explanation
+ numbered list
+ numbered list


Pfeile $->$ #sym.arrow.r

=== Tests
Bild
#image("/assets/image.png")

doppelter Abstand:
\
\
A
bstand^