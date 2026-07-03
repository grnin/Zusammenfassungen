

#import "@preview/wrap-it:0.1.1": wrap-content

/*
// Compiled with Typst 0.13.1
#import "../template_cheatsheet.typ": *

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

#colbreak()
#colbreak()
#colbreak()
#colbreak()
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


#let hinweis2(body) = [
    #set text(
        style: "italic",
    )
    #body
]

// /*


// = Multi-Threading
= Concepts of Concurrency
/ Parallelism: Subprograms run simultaneously on multiple cores, goal: faster programs
/ Concurrency: interleaved execution of programs (time-slicing or parallel), goal: simpler programs + non blocking GUI

/ Process: _Program under Execution_, Heavyweight, own address space, OS needs process context
/ Thread: _Parallel sequence_ in process. Lightweight, same address space, separate stack and registers

== Thread Scheduling
#grid(
    // align: top + right,
    align: top + left,
    // columns: (65%, 35%),
    columns: (63%, 37%),
    [

        / core sharing: Run more threads than cores, On waiting: Release core for other ready threads. (Oversubscription)
        / scheduler: "threads are on mercy of scheduler"

        // // *Multi-threads:* Changes made by 1 thread to shared resources will be _seen_ by other threads.\
        / Context switch: _Synchronous_ Thread waiting for condition queues itself and gives core free voluntary \ _Asynchronous_ context switch  due to an external event (hardware or timer interrupt / time-slice, higher-priority thread), prevents thread from permanently occupying.


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
/ ```java t.start() == t.Start() ```: Start the thread (not run!)
/ ```java t.join() == t.Join() ```: wait till thread finished, timeout: `join(ms)`,
/ ```java t.sleep(ms) == t.Sleep(ms) ```: join+sleep #sym.arrow.r Timed-Waiting state,
/ ```java t.wait()  ```: gives processor+lock free, call in synchronized block.
/ ```java t.yield() ```: scheduler can release processor, to Ready state, does not release lock
/ ```java t.setDaemon(true) == isBackground = true ```:

/ ```java t.interrupt()```: for cooperative canceling, Use when Cancel-Policy of threads is known (know what thread does after it was interrupted)
/ ```java InterruptedException```: thrown on `interrupt()` while `sleep/wait/join`.
/ ```java t.interrupted() t.isInterrupted()```: check interrupted flag

/ ```java Thread.currentThread()```: static method that returns `Thread`, reference to current executing thread instance
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
Guarantees _memory consistency_, _happens-before relationship_ and _reentrancy_.
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

= Hazards and conditions of correctness

_DR + RC_ = Erroneous behaviour,
_No DR + RC_ = Erroneous behaviour,
_No RC + DR_ = Program works correctly, but formally incorrect, _No RC + No DR_ = Correct behaviour
==== Race Conditions
_Insufficiently synchronized access to shared resources._ The _order of events_ affects the
_correctness_ of the program. Leads to _non-deterministic behavior_.
Can occur without data race, but data race is often the cause.\
*Race Condition without data race:* critical section is not protected. Data Race is eliminated using synchronization, but there
is no synchronization over larger blocks, so race conditions are still possible
#hinweis[(i.e. non-atomic incrementing)].

==== Data Race
Two threads in a single process _access the same variable_ concurrently without synchronization,
at least one of them is a _write access_.

== Thread Safety
*Dispensable cases in synchronization:*
_Immutable Classes_ #hinweis[(Declaring all fields private and final and don't provide setters)],
_Read-only Objects_ #hinweis[(Read-only accesses are thread-safe)]\
*Confinement:*
Object belongs to only one thread at a time.
_Thread Confinement_ #hinweis[(Object belongs to only one thread)],
_Object Confinement_ #hinweis[(Object is encapsulated in other synchronized objects)]\
*Thread safe:*
A data type or method that behaves correctly when used from multiple threads as if it was
running in a single thread without any additional coordination
#hinweis[(Java concurrent collections)].\
*Thread Safety:*
Avoidance of Data Races. When no sharing is intended, give each thread a private copy of the
data. When sharing is important, provide explicit synchronization.

== Deadlocks
Happens when threads lock each other out, prohibiting both from running.
Programs with potential deadlock are not considered correct.
Threads can suddenly block each other.

#columns(2)[
    ```java
    // Thread 1
    synchronized(listA) {
      synchronized(listB) {
        listB.addAll(listA);
    }}
    ```
    #colbreak()
    ```java
    // Thread 2
    synchronized(listB) {
      synchronized(listA) {
        listA.addALl(listB);
    }}
    ```
]

Both threads in this scenario have _locked each other out_, the program cannot continue.\
*Livelock:*
Threads have blocked each other permanently, but still execute wait instructions and therefore
consume CPU during deadlock.

#columns(2)[
    ```java
    // Thread 1
    b = false; while(!a) { } ... b = true;
    ```
    #colbreak();
    ```java
    // Thread 2
    a = false; while(!b) { } ... a = true;
    ```
]

#wrap-content(
    // image("img/parprog_2.png"),
    image("img/resource-graph-cycle.svg"),
    align: top + right,
    columns: (70%, 30%),
)[
    === Resource Graph
    #grid(
        columns: (1fr, 1fr),
        gutter: 3pt,
        [Thread T _waits for Lock_ of Resource R
            #v(-2pt)
            // Text ist nicht mehr mittig :'( muss Grafik anpassen
            #image("img/resource-graph-1.svg", height: 11pt)],
        [Thread T _acquires Lock_ of Resource R\
            #v(-2pt)
            #image("img/resource-graph-2.svg", height: 11pt)],
    )
    Deadlocks can be identified by _cycles in the resource graph_.\
    / Deadlock Avoidance:
        Introduce _linear blocking order_, lock nested
    // fix umbruch
    #v(-1.5em)
    only in ascending order.
    Or use _coarse granular locks_ #hinweis[(e.g. block the whole Bank to block all accounts)]
]

== Starvation
A thread never gets chance to access a resource.
_Avoidance:_ Use fair synchronization constructs. #hinweis[(Aging, Enable fairness in previous
    synchronization constructs. Monitor and Thread priorities have a fairness problem.)]

== Parallelism Correctness Criteria
_Safety:_ No race conditions and no deadlocks, _Liveness:_ No starvation

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


// TODO check:
#block[
    == Semaphore
    Allocation of a limited number of free resources. Is in essence a _counter_.
    If a resource is _acquired_, `count--`, if a resource is _released_, `count++`.
    Can wait until resource becomes available.
    Can also acquire/release multiple permits at once atomically.
    #v(-0.5em)

    ```java
    public class Semaphore {
      private int value; public Semaphore(int initial) { value = initial; }
      public synchronized void acquire() throws InterruptedException {
        while (value <= 0) {
          wait(); } value--; }
      public synchronized void release() { value++; notify(); } }
    ```
    #v(-0.5em)
    *General Semaphore:*
    ```java new Semaphore(N)``` #hinweis[(Counts from 0 to $N$ for limited permits to access a resource)] \
    *Binary Semaphore:*
    ```java new Semaphore(1)``` #hinweis[(Counter 0 or 1 for mutual exclusion, open/locked)]\
    *Fair Semaphore:*
    ```java new Semaphore(N, true)``` #hinweis[(Uses FIFO Queue aging for fairness.
        Slower than non-fair variant.)] \
    Semaphores are _powerful_, any synchronization can be implemented. But relatively _low-level_.

    ```java
    class BoundedBuffer<T> {
      private Queue<T> queue = new LinkedList<>();
      private Semaphore upperLimit = new Semaphore(Capacity, true); // how many free?
      private Semaphore lowerLimit = new Semaphore(0, true); // how many full?
      public void put(T item) throws InterruptedException {
        upperLimit.acquire(); // free places - 1
        synchronized (queue) { queue.add(item);}
        lowerLimit.release(); } // full places + 1
      public T get() throws InterruptedException {
        T item;
        lowerLimit.acquire(); // full places - 1
        synchronized (queue) { item = queue.remove(); }
        upperLimit.release(); // free places + 1
        return item; }}
    ```

    == Lock & Condition
    Monitor with _multiple waiting lists_ and conditions. Independent from Monitor locks.\
    / Lock-Object: Lock for entry in the monitor #hinweis[(outer waiting room)]
    / Condition-Object: Wait & Signal for a specific condition #hinweis[(inner waiting room)].
    / ReentrantLock: Class in Java, _alternative to `synchronized`_. Allows multiple locking operations by the same thread and supports nested locking #hinweis[(Thread is able to re-enter the same lock)].
    / Condition: Factors out the Object monitor methods #hinweis[(`wait`, `notify` and `notifyAll`)] into distinct objects to give the effect of having multiple wait-sets per object, by combining them with the use of arbitrary `Lock` implementations. A _Condition replaces the use of the Object monitor methods_.
    / `condition.await()`: Throws an `InterruptedException` if the current thread has its interrupted status set on entry to this method or is interrupted while waiting #hinweis[(`finally` frees the lock in case of interrupt)]. #hinweis[`myThread.interrupt()`]

    ==== Buffer with Lock & Condition
    ```java
    class BoundedBuffer<T> {
      private Queue<T> queue = new LinkedList<>();
      private Lock monitor = new ReentrantLock(true); // fair queue
      private Condition nonFull = monitor.newCondition();
      private Condition nonEmpty = monitor.newCondition();
      ...
      public void put(T item) throws InterruptedException {
        monitor.lock(); // Lock queue
        try { while (queue.size() == Capacity) { nonFull.await(); }
          queue.add(item); nonEmpty.signal(); } finally { monitor.unlock(); }
      } // signalAll() if uniform waiters
      public T get() throws InterruptedException {
        monitor.lock(); // wait for queue to be filled & signal to other queue
        try { while (queue.size() == 0) { nonEmpty.await(); }
          T item = queue.remove(); nonFull.signal(); return item;
        } finally { monitor.unlock(); } // always release lock, even after Exception
    }}
    ```

    #let rw-lock-table = {
        table(
            columns: (1fr, 1fr, 1fr),
            [Parallel], [Read], [Write],
            [_Read_], [Yes], [No],
            [_Write_], [No], [No],
        )
    }

    #wrap-content(
        rw-lock-table,
        align: top + right,
        columns: (65%, 35%),
    )[
        == Read-Write Lock
        Mutual exclusion is _unnecessary for read-only_ threads.
        So one should allow parallel reading access, but implement mutual exclusion for write access.
    ]
    #v(-0.75em)
    ```java
    ReadWriteLock rwLock = new ReentrantReadWriteLock(true); // true for fairness
    rwLock.readLock().lock(); // shared Lock
    // read-only accesses here
    rwLock.readLock().unlock(); // release shared lock
    rwLock.writeLock().lock(); // exclusive Lock
    // write (and read) accesses here
    rwLock.writeLock().unlock(); // release exclusive lock
    ```

    == Count Down Latch
    Synchronization with a counter that can only _count down_. Threads can wait
    until counter $<= 0$, or they can count down. The Latches can only be used once.

    ```java
    var ready = new CountDownLatch(N);   var start = new CountDownLatch(1);
    ```
    #v(-0.5em)
    #grid(
        columns: (auto, auto),
        gutter: 0.3em,
        [
            ```java
            ready.countDown(); // wait for N cars ->
            start.await(); // await race start <----
            ```
        ],
        [
            ```java
            ready.await(); // wait 4 all cars ready
            start.countDown(); // start the race
            ```
        ],
    )

    == Cyclic Barrier
    Meeting point for fixed number of threads. Threads wait _until everyone arrives_.
    Is _reusable_, threads can synchronize in multiple rounds at the same barrier
    #hinweis[(Simplifies example above)].

    ```java
    var start = new CyclicBarrier(N); start.await(); // all cars race as they're here
    ```

    == Exchanger
    *Rendez-Vous:*
    Barrier with _information exchange_ for 2 parties.
    Without exchange: ```java new CyclicBarrier(2)```,
    with exchange: ```java Exchanger.exchange(something)```.
    The Exchanger blocks until another thread also calls `exchange()`,
    returns argument `x` of the other thread.

    ```java
    var exchanger = new Exchanger<Integer>();
    for (int count = 0; count < 2; count++) { // odd number of exch.: last one blocks
      new Thread(() -> {
        for (int in = 0; in < 5; in++) {
          try {
            int out = exchanger.exchange(in);
            System.out.println(Thread.currentThread().getName() + " got " + out);
          } catch (InterruptedException e) { }
        }
      }).start();
    }
    ```

]




= Thread Pools

==== Java and .NET
Wovon hängt die Anzahl Tasks bei beiden Verfahren ab?
/ .NET Parallel For: Anzahl freier Worker Threads
/ Java ForkJoinPool: Array-Länge und Threshold (bei RecursiveAction)

== Thread Pools Basics
Thread costs: performance + memory (stack per thread) #sym.arrow.r recycle threads for multiple tasks.\
/ Tasks: potentially parallel work packages. Passive objects describing the functionality.\
/ Thread Pool: Tasks queues. Smaller number of _working threads_ grab tasks from queue and execute them.
    A task must run to completion before worker thread can grab a new one #hinweis[except nested tasks/sub-tasks].\
// Any task must _complete execution_ before its worker thread is free to grab another task.
// Exception: nested tasks. \
/ Scalable Performance:
    #hinweis[(Rule of thumb: \# of Worker Threads = \# processors + 1 (Pending I/O Calls))]\
    Programs with tasks run _faster on parallel machines_ #sym.arrow.r allows exploitation of
    parallelism _without thread costs_. Number of threads can be _adapted_ to the system.
/ Advantages:
     // _Limited number of threads_ #hinweis[(Too many threads slow down the system or exceed available memory)],
    _Thread recycling_ #hinweis[(save thread creation and release)],
    _Higher level of abstraction_ #hinweis[(Disconnect task description from execution)],
    _Number of threads configurable_ on a per-system basis.\
/ Limitations:
    Task must not wait for each other #hinweis[(except sub-tasks)] would result in deadlock in Queue.
// #hinweis[(if one task $T_1$ is waiting for something the task $T_2$ behind him in the Queue
//     should provide, but $T_2$ waits for $T_1$ to finish, a deadlock occurs)]
/ LIFO Queue: per worker thread and stealing is *FIFO*, Automatic degree of parallelism #hinweis[(Default: As much worker threads as Processors)], Optimized for recursive.
/ Fire-and-forget:
    Tasks may not finish (tasks are started without retrieving results). Async: `submit()` without `get()`.  Task is run, but Exception will not get caught.
// / Fire and Forget: Task are started _without retrieving results_ later (`submit()` without `get()`).  Task is run, but Exceptions will not get caught.

== Java ForkJoinPool Thread Pool
/ ForkJoinPool: Thread Pool for recursive Tasks (Divide and Conquer), work stealing, Subclass of ExecutorService
/ `ForkJoinPool.commonPool()`: static global Pool, singleton, used by `CompletableFuture`
// - ForkJoinPool does not always use all processors :(

/ Create explicit thread pool: ```java var threadPool = new ForkJoinPool();``` \ ```java int result = threadPool.invoke(new CountTask(2, N));```
// / TODO: ```java int result = new CountTask(2, N).invoke();```

/ Work Stealing: Jobs get submitted into the _global queue_, which distributes the jobs to the _local queues_ of each worker thread. If one thread has no work left, it can _"steal" work from another threads_ local queue instead of the global queue. This _distributes_ the scheduling work over idle processors.
    Worker threads run as daemon threads (in TPL .NET too). // in java kann für einen eigenen "expliziten" ForkJoinPool auch eingestellt werden, dass die Threads nicht daemon threads sind. Aber das haben wir nicht angeschaut. Bei uns sind threads im ForkJoinPool immer daemon threads.

== Java ForkJoinPool
// tODO: kürzen?
/ _`invoke(task)`_: blocking
/ _`invokeAll(task1, task2)`_: blocking, creates fork and starts task
/ _`submit(task)`_: returns Future
/ _`execute(task)`_: async but does not return Future #hinweis[fire and forget]

/ _`future.get()`_: wait for result/exception #hinweis[prevent fire and forget by evaluating result], can throw CancellationException, ExecutionException, InterruptedException
/ _`task.fork()`_: schedule async subtask
/ _`result = task.join()`_: wait and get result

```java
// Task Launch, Async but without CompletableFuture
var threadPool = new ForkJoinPool();
Future<Integer> future = threadPool.submit(() -> { // submit task into pool, async
  int value = ...; /* long calculation */ return value;
});
T result = future.get(); // blocks until task terminated
```

==== Recursive Action/Task
```java
// Sequential:
int counter = 0; for (int n = 2; n < N; n++) { if (isPrime(n)) { counter++}};

// Parallel and Recursive with RecursiveTask class:
class CountTask extends RecursiveTask<Integer> { //RecursiveAction: void function
  private final int lower, upper;
  private static final int THRESHOLD = 1; // configurable
  public CountTask(int lower, int upper) {
    this.lower = lower;    this.upper = upper;
  }
  protected Integer compute() { // TRESHOLD = avoid over-parallelizing
    if (lower == upper) { return 0; }
    if (lower + 1 == upper) {  return isPrime(lower) ? 1 : 0;  }
    if (upper - lower > THRESHOLD) { // parallel count
      int middle = (lower + upper) / 2;
      var left = new CountTask(lower, middle);
      var right = new CountTask(middle, upper);

      // V1 mit explizitem fork, blockiert noch nicht
      left.fork(); right.fork(); // fork = new task
      // V2 invokeAll, join danach ist sofort fertig
      invokeAll(left, right);

      return right.join() + left.join(); // join = wait for all threads
    } else { // sequential count:
      int count = 0;
      for (int number = lower; number < upper; number++) {
        if (isPrime(number)) { count++; }
      }
      return count;
    }
} }  // .invoke is blocking:
int result = new CountTask(2, N).invoke(); // invokeAll() to start multiple tasks
```

/*
=== Pairwise sum (recursive)
```java
class PairwiseSum extends RecursiveAction {
  private final int[] array;
  private final int lower, upper;
  private static final int THRESHOLD = 1; // configurable
  public PairwiseSum(int[] array, int lower, int upper) {
    this.array = array; this.lower = lower; this.upper = upper;
  }
  protected void compute() {
    if (upper - lower > THRESHOLD) {
      int middle = (lower + upper) / 2;
      // ohne return Wert:
      invokeAll(
        new PairwiseSum(array, lower, middle),
        new PairwiseSum(array, middle, upper)
      );
    } else {
      for (int i = lower; i < upper; i++) {
        array[2*i] += array[2*i+1]; array[2*i+1] = 0;
}}}}
```
// #v(-0.5em)

// */





== Thread Pool with `Parallel For` (.NET)
// .NET Code API
// // TODO
// / `Parallel.Invoke()`:
// / `Parallel.For()`:
// TODO code von Vorlesungen?

#v(-1em)
=== .NET Task Parallel Library (TPL)
Preferred way to write multi-threaded and parallel code.
Provides public types and APIs in `System.Threading` and `System.Threading.Tasks` namespaces.
_Efficient default thread pool_ #hinweis[(tasks are queued to the ThreadPool, supports
    algorithms to provide load balancing, tasks are lightweight)], has _multiple abstraction
layers_ #hinweis[(Task Parallelization: use tasks explicitly, Data Parallelization: use
    parallel statements and queries using tasks implicitly)], Asynchronous Programming and PLINQ.

// === C\# Thread Pool Code
=== Parallel Statements in C\#
#columns(2)[
    Execute _independent_ statements _potentially in parallel_
    #hinweis[(Start all tasks, implicit barrier at the end)].
    ```cs
    Parallel.Invoke(
      () => MergeSort(l, m),
      () => MergeSort(m, r)
    );
    ```
    #colbreak()
    Execute _loop-bodies potentially in parallel_\
    #hinweis[(Queue a task for each item, implicit barrier at the end)].
    ```cs
    Parallel.ForEach(list,
      file => Convert(file));
    Parallel.For(0, array.Length,
      i => DoComputation(array[i]));
    ```
]

*Parallel Loop Partitioning:*
Loop with lots of quickly executing bodies, inefficient to execute each iteration as parallel task #sym.arrow.r TPL _automatically groups multiple bodies_ into a single task.


// // TODO
// Split according to available worker threads:
// - Range Partitioner with indexing (Parallel.For)
// - Chunk Partitioner with iteration (Parallel.ForEach)
// #image("/assets/image.png", height: 0.5cm)


=== PLINQ
*LINQ:*
Set of technologies based on the integration of SQL-like query capabilities directly into C\#.\
*PLINQ:*
Is a parallel implementation of LINQ. Benefits from _simplicity_ and _readability_ of LINQ with
the power of parallel programming by creating segments from its data. Analog to Java Stream API.

_`from`_ `book` _`in`_ `bookCollection.AsParallel()` _`where`_ `book.Title.Contains("Concurrency")` _`select`_ ```cs book.ISBN // Random Order```

_`from`_ `number` _`in`_ `inputList.AsParallel().AsOrdered()` _`select`_ `IsPrime(number)`\
```cs // Maintains order but is slower```


=== Thread Injection
TPL adds new worker threads _at runtime_ every time a work item completes or every 500ms.\
*Hill Climbing Algorithm:*
_Maximize throughput_ while using as _few threads_ as possible. Measures throughput & _varies_
number of worker threads. _Avoids deadlock_ with task-dependencies #hinweis[(but inefficiently
    since not designed for this. Deadlocks with `ThreadPool.SetMaxThreads()` are still possible).]
We should keep _parallel tasks short_ to better profit from this automatic performance improvement.


= Asynchronous programming
/ Unnecessary Synchrony:
    Blocking method calls are often used without need #hinweis[(Long running calculations, I/O
        calls, database or file accesses)]. With an _asynchronous call_, other work can continue while
    waiting on the result of the long operation.\
```cs var task = Task.Run(LongOperation); /* other work */ int result = task.Result;```\
/ Kinds of Asynchronisms:
    _Caller-centric_ #hinweis2[("pull", caller waits for the task end and gets the result, blocking call)],
    _Callee-Centric_ #hinweis2[("push", Task hands over the result directly to successor / follower task)]\
/ Task Continuations:
    Define task whose start is linked to the end of the predecessor task.

#grid(
    columns: (auto, auto),
    [
        ```cs
        // C# .NET
        Task
          .Run(task1)
          .ContinueWith(task2)
          .ContinueWith(task3);
        ```
    ],
    [
        ```java
        // Java (there can be multiple Apply/AcceptAsync calls)
        CompletableFuture
          .supplyAsync(() -> longOP) // runAsync for return void
          .thenApplyAsync(v -> 2 * v) // returns value
          .thenAcceptAsync(v -> ... .println(v)); // returns void
        ```
    ],
)

*Multi-Continuation:*
Continue when _all_ tasks are finished:\
```cs Task.WhenAll(task1, task2).ContinueWith(continuation);```\
Continue when _any_ of the tasks are finished
#hinweis[(other threads get lost after first thread is done)]:\
```cs Task.WhenAny(task1, task2).ContinueWith(continuation);```\
#hinweis[(Exceptions in fire & forget task get ignored,
    i.e. ```cs Task.Run(() => { ...; throw e; })```)]\
*Exception Handling:*
Synchronously _`Wait()`_ for the _whole task-chain_ at the end.
_Register for unobserved exceptions_ with _`TaskScheduler.UnobservedTaskException`_
#hinweis[(Receives unhandled exceptions from fire & forget tasks)].
This should be executed as soon as the task object is dead #hinweis[(Garbage Collector)].




== Java Async
/ Java `CompletableFuture`:
    _Modern asynchronous_ programming in Java. Also has _Multi-Continuation_ with
    ```java CompletableFuture.allOf(future1, future2)``` and ```java CompletableFuture.any(...)```
// / ```java future.get()```: can throw CancellationException, ExecutionException, InterruptedException

/ Java `invokeLater`:
    To be executed _asynchronously_ on the event dispatching thread.
    Should be used when an _application thread_ needs to _update the GUI_.\

=== `Future<T>`
Represents a _future result_ #hinweis[(asynchronous)], Proxy #hinweis[for the result that may be not available yet because the task has not finished.]
#v(-0.5em)
/ _`.submit()`_: submits task into pool and launches task
/ _`.get()`_: waits if necessary for computation to complete and then retrieves its result
/ _`.cancel()`_: Attempts to cancel execution of this task, removes it from queue Task ends when a unhandled exception occurs. It is included in the `ExecutionException` thrown by `get()`.
// #v(-0.5em)


== Non-Blocking GUI's
*Use case:*
If a UI is doing a long task, it should not freeze.\
*GUI Thread Model:*
Only _single-threading_ #hinweis[(Only a special UI-thread is allowed to access
    UI-components)]. The _UI thread_ loops to process the _event queue_.

// #image("img/parprog_5.png", width: 87%)
#image("img/parprog_5.png", height: 1.25cm)

*GUI Premise:*
_No long operations_ in UI events, or else blocks UI.
_No access to UI-elements by other threads_, or else incorrect
#hinweis[(Exception in .NET & Android, Race Condition in Javas Swing)].
#v(-0.5em)

=== Non-Blocking UI Implementation
#grid(
    columns: (0.65fr, 1fr),
    gutter: 0em,
    [
        ```cs
        // C# .NET
        void buttonClick(...) {
          var url = textBox.Text;
          Task.Run(() => {
            var text = Download(url);
            Dispatcher.InvokeAsync(
            () => {
              label.Content = text;
            });
          }); }
        ```
    ],
    [
        ```java
        // Java
        button.addActionListener(event ->
          var url = textField.getText();
          CompletableFuture.runAsync(() -> {
            var text = download(url); // to worker thread
            SwingUtilities.invokeLater(() -> {
              textArea.setText(text); // to UI thread
            });
          });
        )
        ```
    ],
)

== C\# Async/Await
More _readable_ than the "spaghetti code" in the chapter before.
This is the same code as before.

#grid(
    columns: (3fr, 4fr),
    [
        ```cs
        ...
        var url = textBox.Text;
        var text = await DownloadAsync(url);
        label.Context = text;
        ...
        ```
    ],
    [
        ```cs
        async Task<string> DownloadAsync(string url) {
          var web = new HttpClient();
          string result = await web.GetStringAsync(url);
          return result;
        }
        ```
    ],
)

_`async` for methods_: Caller may not be blocked during the entire execution of the async method.
_`await` for tasks_: "Non-blocking wait" on task-end / result.\
/ Execution Model:
    Async methods run partly _synchronous_ #hinweis[(as long as there is no blocking await)],\
    partly _asynchronous_ #hinweis[(until the awaited task is complete)].\
/ Mechanism:
    Compiler dissects method into _segments_ which are then executed completely synchronously or asynchronously.\
/ Different Execution Scenarios:
    _Case 1:_ Caller is a "normal" thread #hinweis[(Usual case, Continuation is executed by a TPL-Worker-Thread)],
    _Case 2:_ Caller is a UI-thread #hinweis[(Continuation is dispatched to the UI thread and processed by the UI-Thread as event)]\
/ Async Return Value Types:
    _`void`_ #hinweis[("fire-and-forget")],
    _`Task`_ #hinweis[(No return value, allows waiting for end)],\
    _`Task<T>`_ #hinweis[(For methods having return value of type T)].\
/ Async without await:
    Execute long running operation explicitly in task with ```cs await Task.Run()```.
    ```cs
    public async Task<bool> IsPrimeAsync(long number) {
      return await Task.Run(() => {
        for (long i = 2; i*i <= number; i++) {
          if (number % i == 0) { return false; }
        } return true;
      }); }
    ```















= Memory Models
/ Lock-Free Programming:
    _Correct_ concurrent interactions _without using locks_. Use guarantees of memory models.
    Goal is _efficient synchronization_.\
/ Problems:
    Memory accesses are seen in _different order_ by different threads, except when _synchronized_
    and at _memory barriers_ #hinweis[(weak consistency)]. Optimizations by compiler, runtime
    system and CPU. Instructions are reordered or eliminated by optimization.\
/ Memory model:
    Part of language semantics, there exist different models: _sequential consistency (SC)_
    #hinweis[(Order of execution cannot be changed. Too strong a consistency model)]
    and the _Java Memory Model_\ #hinweis[(a "weak" memory model)].



== Java Memory Model (JMM)
Interleaving-based semantics. Minimum warranties: _Atomicity, Visibility and Ordering_.

=== Atomicity
An _atomic_ action is one that happens _all at once_ #hinweis[(So no thread interference)].
Java guarantees that read/writes to primitive data types up to 32 Bit, Object-References
#hinweis[(strings etc.)] and long and double #hinweis[(with `volatile` keyword)] are atomic.
_A single read/write is atomic._ Atomicity does _not imply visibility_.

=== Visibility
Guaranteed visibility between threads.
_Lock Release & Acquire_ #hinweis[(Memory writes before release are visible after acquire)],
_`volatile` Variable_ #hinweis[(Memory writes up to and including the write to volatile
    variables are visible when reading the variable)],
_Thread/Task-Start and Join_ #hinweis[(Start: input to thread; Join: thread result)],
_Initialization of `final` variables_ #hinweis[(Visible after completion of the constructor)],
_`final` fields_.\

=== Java Ordering
*Java Happens Before:*
"Happens before" defines the _ordering and visibility guarantees_ between actions in a program.
It ensures that changes made by one thread become visible to others.
An _unlock_ of a monitor _happens-before_ every subsequent lock of that same monitor.\
*Java Ordering Guarantees:*
Writes before Unlock #sym.arrow reads after lock, `volatile` write #sym.arrow `volatile` read,
Partial Order. Synchronization operations are never reordered.
#hinweis[(Lock/Unlock, volatile-accesses, Thread-Start/Join.)].


// *Read after write dependency*.
// TODO

== Synchronization in Memory Model
*Rendez-Vous:*
Primitive attempt to synchronize threads.

#grid(
    columns: (auto, auto),
    gutter: 10pt,
    [
        ```java
        // Java
        volatile boolean a = false, b = false;
        // Thread 1
        a = true; while( !b ) { ... }
        // Thread 2
        b = true; while( !a ) { ... }
        ```
        No reordering because `a` and `b` are `volatile`.\
    ],
    [
        ```cs
        // C# .NET
        volatile bool a = false, b = false;
        // Thread 1
        a = true; Thread.MemoryBarrier();
        while (!b) { ... }
        // Thread 2
        b = true; Thread.MemoryBarrier();
        while (!a) { ... }
        ```
    ],
)


*Spin-Lock with atomic Operation:*
```java
public class SpinLock {
  private final AtomicBoolean locked = new AtomicBoolean(false); // unlocked
  public void acquire() { while( locked.getAndSet(true) ) {...} }
  public void release() { locked.set(false); }
}
```

*Java Atomic Classes:*
Classes for boolean, Integer, Long, References and Array-Elements.
Different kinds of atomic operations, _`addAndGet()`_, _`getAndAdd()`_ etc.\
*Operations on atomic data classes:*
```java boolean getAndSet(boolean newValue)```\
Atomically sets to the given value and returns the previous value.\
```java boolean compareAndSet(boolean expect, boolean update)```\
Sets `update` only when read value is equal to `expect`. Returns true when successful.\
*Optimistic Synchronization:*
#hinweis[(Read old value and then compare before writing if value is still the same. If not, retry)]
```java
do { oldV = v.get(); newV = result; } while(!v.compareAndSet(oldV, newV));
```

*Lambda-Variants:*
```java AtomicInteger s = new AtomicInteger(2); s.updateAndGet(x -> x * x);```

#wrap-content(
    image("img/parprog_6.png"),
    align: top + right,
    columns: (75%, 25%),
)[
    == .NET Memory Model
    Main differences to JMM:
    _Atomicity_ #hinweis[(long/double also not atomic with volatile)],
    _Ordering and Visibility_ #hinweis[(only half and full fences)].
    _Atomic Instructions_ with the `Interlocked` class

    === Half Fence (Volatile)
    Reordering in one direction still possible.
    _Volatile Write:_ Release semantics #hinweis[(Preceding memory accesses are not moved below
        it, but later operations can be executed before the write)].
    _Volatile Read:_ Acquire semantics #hinweis[(Subsequent memory accesses are not moved above
        it, but previous operations can be executed after the read)]
]

=== Full Fence (Memory Barrier)
Disallows reordering in both directions. ```cs Thread.MemoryBarrier();```

#pagebreak()
