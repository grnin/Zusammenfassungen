
#import "@preview/wrap-it:0.1.1": wrap-content

// /*
// Compiled with Typst 0.13.1
#import "../template_cheatsheet.typ": *

#show: project.with(
    authors: ("Jasmin Fässler", "Nina Grässli", "Jannis Tschan"),
    fach: "Druck testen",
    fach-long: "Drucker",
    semester: "FS26",
    language: "en",
    column-count: 5,
    font-size: 4pt,
    landscape: true,
)

// #colbreak()
// #colbreak()
// #colbreak()
// #colbreak()
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


#let grid2(body1, body2) = [
    #grid(
        columns: (auto, auto),
        [
            #body1
        ],
        [
            #body2
        ],
    )
]
// ----------------------


#grid(
    columns: (auto, 70%),
    gutter: 0em,
    [
        *GUI Premise:*
        _No long operations_ in UI events, or else blocks UI.
        _No access to UI-elements by other threads_, or else incorrect
        #hinweis[(Exception in .NET & Android, Race Condition in Javas Swing)].
    ],
    [
        #image("img/gui.svg")
    ],
)


#colbreak()
#let dotnet-half-fence-content = {
    [
        // .Net Half Fence:
        #image("img/parprog_6.png"),
        #v(-2em)
    ]
}
#wrap-content(
    dotnet-half-fence-content,
    align: top + right,
    columns: (70%, 30%),
)[
    == .NET Memory Model
    Differences to JMM:
    _Atomicity_ #hinweis2[(long/double not atomic with volatile)],
    _Ordering and Visibility_ #hinweis2[(only half and full fences)].
    _Atomic Instructions_ with the `Interlocked` class

    ==== Half Fence (Volatile)
    Reordering in one direction still possible.
    _Volatile Write:_ Release semantics #hinweis[(Preceding memory accesses NOT moved below it, but later operations can be executed before write)].
]



= Problematisch:
#{
    [
        text zum Vergleich
        #v(-1em)
        #image("img/parprog_9.png", width: 90%)
        #v(-1em)


        // text zum Vergleich
        // #v(-1em)
        // // #image("img/roofline-model.svg", width: 130pt)
        // #image("img/roofline-model.svg", height: 65pt)
        // #v(-1em)
    ]
}
#colbreak()

#block(
    sticky: true,
    [
        / `MPI_Bcast`:
            #grid2(
                [
                    #v(-0.7em)
                    Efficient, because root node does _not send the signal individually_ to each node,
                    the _other nodes help_ spread the message to others.:
                    ```c MPI_Bcast(void * data, int count, MPI_Datatype datatype, int root, MPI_COMM_WORLD)```\
                ],
                [
                    #v(-1.7em)
                    #image("img/mpi_bcast.svg", width: 50pt)
                ],
            )
    ],
)
/*

/ 3D Grid:
    ```cpp dim3 gridS(3,2,1); dim3 blockS(4,3,1); VectorAddKernel<<<gridS, blockS>>>```\
    // ist gleich wie (3,2) und (4,3)
    #v(-0.8em)
    #image("img/3d-thread-hierarchy.svg")


#colbreak()


#wrap-content(
    image("img/matrices.svg"),
    align: top + right,
    columns: (50%, 50%),
)[
    ==== Calculation Examples
    ```cpp VectorAddKernel<<<dim3(8,4,2), dim3(16,16)>>>(d_A, d_B, d_C);```\
    _Amount of Blocks:_ $8 dot 4 dot 2 = 64$ \
    _Amount of threads per block:_ $16 dot 16 = 256$ \
    _Threads in total:_ $64 dot 256 = 16'384$

    // threadsPerBlock = blockSize
    If we have $1024$ threads in a block, how many blocks are needed to launch $N$ threads?\
    _`int blocksPerGrid = (N + blockSize - 1) / blockSize;`_ \
    #hinweis[Rounding up is necessary because for 1025 threads, 2 blocks are required]
]
#v(-2em)

#colbreak()
= Ok:

#image("/assets/image-9.png")


// /* // scharf:

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
        // SVG in Kurven umwandeln müssen, jetzt ist es scharf:
        #image("img/scheduler.svg")
        // #image("img/scheduler.png")
    ],
)

== Deadlocks (safety)
Happens when threads lock each other out, prohibiting both from running.
Programs with potential deadlock are not considered correct.
Threads can suddenly block each other.

#v(-0.5em)
#columns(2)[
    ```java
    // Thread 1
    synchronized(listA) {
      synchronized(listB) {
        listB.addAll(listA); }}
    ```
    #colbreak()
    ```java
    // Thread 2
    synchronized(listB) {
      synchronized(listA) {
        listA.addALl(listB); }}
    ```
]
#v(-0.25em)
Both threads in this scenario have _locked each other out_, the program cannot continue.\

/ Livelock:
    Threads have blocked each other permanently, but still execute wait instructions and therefore
    consume CPU during deadlock.
    #v(-0.5em)
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
/ Resource Graph:
    #v(-0.5em)
    #wrap-content(
        image("img/resource-graph-cycle.svg"),
        align: top + right,
        columns: (70%, 30%),
    )[
        #grid(
            columns: (1fr, 1fr),
            gutter: 3pt,
            [Thread T _waits for Lock_ \ of Resource R
                #v(-2pt)
                #image("img/resource-graph-1.svg", height: 10pt)],
            [Thread T _acquires Lock_  \ of Resource R\
                #v(-2pt)
                #image("img/resource-graph-2.svg", height: 10pt)
                #v(-3em)
            ],
        )
    ]
    #v(-2.8em)
    Deadlocks can be identified by _cycles in the resource graph_.
/ Deadlock Avoidance:
    Introduce _linear blocking order_, lock nested only in ascending order.  Or use _coarse granular locks_ #hinweis[(e.g. block the whole Bank to block all accounts)]

// */
