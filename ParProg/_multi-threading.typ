

// /*
// Compiled with Typst 0.13.1
#import "../template_cheatsheet.typ": *
#import "@preview/wrap-it:0.1.1": wrap-content

#show: project.with(
    authors: ("Nina Grässli", "Jannis Tschan"),
    fach: "ParProg",
    fach-long: "Parallel Programming",
    semester: "FS24",
    language: "en",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)
// */

#let terms-spacing(spacing, body) = [
    #show terms: set terms(spacing: spacing)
    #body
]

#let hinweis(body) = [
    #set text(
        style: "italic",
    )
    #body
]

#colbreak()
#colbreak()
#colbreak()
#colbreak()

// /*


// = Multi-Threading
= Concepts of Concurrency
/ Parallelism: Subprograms run simultaneously, goal: faster programs
/ Concurrency: interleaved execution of programs, goal: simpler programs

/ Process: _Program under Execution_, Heavyweight, own address space, OS needs process context
/ Thread: _Parallel sequence_ in process. Lightweight, same address space, separate stack and registers

== Thread Scheduling
#grid(
    // align: top + right,
    align: top + left,
    // columns: (65%, 35%),
    columns: (63%, 37%),
    [

        / core sharing: Run more threads than cores, On waiting: Release core for other ready threads
        / scheduler: "threads are on mercy of scheduler"

        // // *Multi-threads:* Changes made by 1 thread to shared resources will be _seen_ by other threads.\
        / Context switch: _Synchronous_ Thread waiting for condition queues itself and  gives core free \ _Asynchronous_ context switch  due to an external event (hardware or timer interrupt), prevents thread from permanently occupying.


        / Cooperative Multi-Tasking (scheduling):
            Threads must explicitly initiate context switches, scheduler can't interrupt.
    ],
    [
        #image("img/scheduler.svg")
        // #image("img/scheduler.png")
    ],
)
#v(-0.5em)
/ Preemptive Multi-Tasking: scheduler can asynchronously interrupt thread via timer interrupt
/ Time-Sliced Scheduling (preemptive): Each thread has the processor for maximum time interval

== JVM Thread Model
/ Java: single process system
/ Java Virtual Machine (JVM): is a process
/ threads: main thread which calls the main function, programmer can start more threads, Subsystems / Runtime System also start their own threads (e.g. RMI, AWT, Garbage Collector)
/ Termination: after all (not daemon) threads are finished or System.exit/Runtime.exit
/ Thread class: override the `run` method of the Runnable interface with the code to be executed in parallel.


#grid(
    columns: (auto, auto),
    gutter: 0.2em,
    [
        ==== create + start a thread
        ```java
        // explicit Runnable implementation
        class myRunnable implements Runnable {
          @Override
          public void run() {
            /* thread behavior */
        } }
        var myT = new Thread(new myRunnable());

        // named function
        var myT = new Thread(() -> namedFunction());

        // anonymous function (lambda)
        var myT = new Thread(() -> {
          /* thread behaviour */
        }); // C# lambda lambda with => arrow

        // start the thread (not run!)
        myT.start();
        ```
    ],
    [
        ==== Multi-Thread Examples Java
        // multiPrint() abekürzt
        ```java
        // no synchronization
        public static void main(String[] args) {
          var a = new Thread(() -> multiP("A"));
          var b = new Thread(() -> multiP("B"));
          a.start(); b.start(); System.out.println("main finished");
        } // varying result, non-deterministic scheduler
        ```

        ```java

        // with synchronization (a and b from above):
        System.out.println("Threads start");
        a.start(); b.start(); // ...
        a.join(); b.join(); System.out.println("Threads joined");
        ```
    ],
)



==== Thread Java &  .NET
/ ```java t.start() == t.Start() ```:
/ ```java t.join() == t.Join() ```: wait till thread finished, timeout: `join(ms)`,
/ ```java t.sleep(ms) == t.Sleep(ms) ```: join+sleep #sym.arrow.r Timed-Waiting state,
/ ```java t.wait()  ```: gives processor+lock free,
/ ```java t.yield() ```: scheduler can release processor, to Ready state, does not release lock
/ ```java t.setDaemon(true) == isBackground = true ```:

/ ```java t.interrupt()```: for cooperative canceling, Use when Cancel-Policy of threads is known (know what thread does after it was interrupted)
/ ```java InterruptedException```: thrown on `interrupt()` while `sleep/wait/join`.
/ ```java t.interrupted() t.isInterrupted()```: check interrupted flag

/ ```java currentThread()```: returns `Thread`, reference to current executing thread instance
// _`getId()`/`getName()`_ #hinweis[(Get thread ID/Name)],
// _`isAlive()`_ #hinweis[(Tests if thread is alive)],
// _`getState()`_ #hinweis[(Get thread state)]

*Java Thread States:*\
_`Blocked`_ #hinweis[(blocked and waiting for a monitor lock)],
_`New`_ #hinweis[(not yet started)],
_`Runnable`_ #hinweis[(Ready to run or running)],
_`Terminated`_,
_`Timed_Waiting`_ #hinweis[(waiting with a specified waiting time
    ```java Thread.sleep(ms)```/```java Thread.join(ms)```)],
_`Waiting`_ #hinweis[]\



// typst compiler ist zu langsam :( */


// = Correctness and dangers of multithreading
= Monitor Synchronization

#wrap-content(
    [```java
    class BankAccount {
      private int balance = 0;
      public void deposit(int amount){
        // enter critical section
        synchronized(this) {
          this.balance += amount;
        } // exit critical section
      }
    }


    ```],
    align: top + right,
    columns: (58%, 42%),
)[
    / Non-determinism: threads run interleaved or parallel //, JVM did not specify that `println` allows concurrency.
    // Threads run arbitrarily.
    / _Synchronization_ (=Restriction of concurrency): for deterministic behavior.
    / Communication between threads: Sharing access to fields and the objects they refer to. Efficient, but problems: _Thread interference_ and _memory consistency errors_.
    // *Critical Section*: code must be executed by only 1 thread at a time. Implementation with _mutual exclusion_.
    / Critical Section: code must be executed by only 1 thread at a time. Implementation with _mutual exclusion_.
]
#v(-1.25em)
/ happens-before relationship: result is same as if executed synchronously (visibility + threadsafe)

==== Java synchronized
*```java synchronized```:*
Body of method with the ```java synchronized``` keyword is a critical section.
Guarantees _memory consistency_ and a _happens-before relationship_ .
// Impossible for two invocations of a synchronized method on the same object to interleave.
Other threads are _blocked_ until the current thread is done with the object.
Every object has a _Lock_ #hinweis[(Monitor-Lock)]. Maximum 1 thread can acquire the lock.
Entry of a `synchronized` method acquires the lock of the object, the exit releases it.
```java public synchronized void deposit(int amount) { this.balance += amount; }```
synchronized can also be used within a method, the _object that should be locked_ must be specified.
```java synchronized(this) { this.balance += amount; }``` (unhandled exceptions exit sync. block)\
// *Exit synchronized block:*
// End of the block, `return`, unhandled exceptions

=== Monitor Lock
Monitor for _internal mutual exclusion_. Only one thread operates at a time in
Monitor,
// All non-private methods are synchronized.
// Threads can _wait in Monitor_ for condition to be fulfilled. Can be _inefficient_ with different waiting conditions,
has _fairness-problems_ and _no shared locks_.\


#terms-spacing(0.7em)[
    / Recursive Lock: thread can acquire same lock through recursive calls, free by last release
    / Busy Wait:
        is repeatedly checking a condition without giving CPU free
        ```java while (locked) { }``` (does not work)
    // `yield` or `sleep` in a loop, inefficient, not releasing lock. _`wait()`_: Temporarily release Monitor-Lock.
    // solution: wrap in while loop to check if wake up condition has been met.
    / Wakeup signal: Signalling a thread in Monitor (inner waiting room). `notify()` and `notiyAll`
    / _`notify()`_: signals any waiting thread. Turnstile
    / One-In/One-Out: change applies to only one thread, Only a single waiting thread can continue
    / Uniform Waiters: Only 1 semantic condition for every thread, condition interests every waiting Thread

    / _`notifyAll()`_: wakes up all threads (from inner waiting room to outer waiting room to wait for entry in monitor)
    // #hinweis[(i.e. one deposit can satisfy multiple withdraws, does not guarantee fairness)]. If a thread is woken up, it goes from the _inner waiting room_ #hinweis[(waiting on a condition)] into the _outer waiting room_ #hinweis[(Thread has not started yet)] where it waits for entry to the Monitor. There is no shortcut.

    / signal and continue: signaling (notifying) thread releases only after leaving synchronized, awakened thread comes to outer waiting room.
    / ```java IllegalMonitorStateException```: thrown if `notify/notifyAll/wait` used outside synchronized.
    / spurious Wakeup in Java: threads can wakeup from `wait` without a reason

]


#grid(
    columns: (1fr, 1fr),
    gutter: 0.2em,
    [
        ```java
        // Java
        class BankAccount {
          private int balance = 0;
          public synchronized void withdraw
              (int amount)
              throws InterruptedException {
            while (amount > balance) { // not if
              wait(); // wait on a condition
            }
            balance -= amount;
          } // release / leave monitor
          public synchronized void deposit
          (int amount) {
            balance += amount;
            notifyAll();
        } }
        ```
    ],
    [
        ```cs
        // C# .NET
        class BankAccount {
          private decimal balance;
          private object syncObject = new();
          public void Withdraw(decimal amount) {
            lock (syncObject) {
              while (amount > balance) {
                Monitor.Wait(syncObject);
              }
              balance -= amount;
          }}
          public void Deposit(decimal amount) {
            lock(syncObject) {
              balance += amount;
              Monitor.PulseAll(syncObject);
        } } }
        ```
    ],
)

== Hazards and conditions of correctness

= Specific synchronization primitives
#v(-0.75em)
== .NET Synchronization Primitives
#hinweis[C\# has no lock and condition and no fairness flag]
=== .NET Monitor
- use sync object: ```cs private object sync = new(); lock(sync){ ... }```.
- ```cs Monitor.Wait(sync)```, ```cs Monitor.PulseAll(sync)```, ```cs Monitor.Pulse(sync)```.
- Wait in Loop: without loop: overtaking problem (in signal and continue).
// - .NET has no spurious wakeup, so threads do not wakeup unless notified or interrupted,

Uses fair FIFO-Queue.
_Lacks:_ No fairness flag, no Lock & Condition.
_Additional:_ `ReadWriteLockSlim` for Upgradeable Read/Write, Semaphores can also be used at
OS level, Mutex. Collections are _not_ Thread-safe.



== Specific synchronization primitives


= Thread Pools
Wovon hängt die Anzahl Tasks bei beiden Verfahren ab?
o .NET Parallel For:
Anzahl freier Worker Threads
o Java ForkJoinPool:
Array-Länge und Threshold

== ParallelFor (.NET)
== ForkJoinPool (Java)

== Asynchronous programming
== Memory Models
