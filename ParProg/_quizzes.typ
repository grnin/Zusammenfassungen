=== TODO
- wenn ich Zeit habe, hier alle Quizze aus der Vorlesung notieren

=== Java
Alive Thread State: Ready To Run, Running, Timed_Waiting or Waiting

Java Thread State after... :
- newThread(): created/new
- t.start(): Alive: Ready To Run > scheduler dispatch : Running (thread executes `run()`)
- run() terminates: Terminated
- more Thread States: Blocked, Runnable, Timed_Waiting
/ t.join: Alive: Waiting > After Time elapsed: Ready To Run...
/ t.sleep: Alive: Timed_Waiting
/ t.run: New ? (did not start thread)
/ t.yield: Alive: Ready To Run > after dispatch: Running


- currentThread().join(): runs forever

expected outcome?
```java
var t1 = new Thread(() -> multiPrint("A"));
var t2 = new Thread(() -> multiPrint("B"));
t1.setDaemon(true);
t2.setDaemon(true);
t1.start();
t2.start();
System.out.println("main finished");
```
no guarantee because daemon threads
A and B and main finished are printed but no required order
or only  main finished is printed

```java
var t1 = new Thread(() -> multiPrint("A"));
var t2 = new Thread(() -> multiPrint("B"));
t1.setDaemon(true);
t2.setDaemon(true);
t1.start();
t2.start();
t1.join();
t2.join();
System.out.println("main finished");
```
A and B or B and A (and maybe multiple time)
are printed before "main finished"
ohne join: daemon threads können villeicht gar nicht fertigwerden
ohne daemon und ohne join: threads werden sicher fertig ausgeführt, aber möglicherweise erst nach "main finished"
