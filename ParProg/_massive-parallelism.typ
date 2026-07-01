
#import "../template--fonts-colors.typ": *
#import "../template--additional-formatting-templates.typ": *
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
// */

#import "../helpers.typ"

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

// = Massive Parallelism

= GPU (Graphics Processing Unit)
*End of Moores Law:*
We can no longer gain performance by "growing" sequential processors. Instead, we _improve
performance_ by running code in _parallel_ on _multi-core (CPUs)_ #hinweis[(Low Latency)] and
many-core or _massively parallel co-processors (GPUs)_ #hinweis[(high throughput)].\
*GPU's*
are specialized electronic circuits designed to accelerate the computation of _computer graphics_.
They are faster than CPUs for suitable algorithms on large datasets. _Useful_ for
calculations which consist of _multiple independent sub-calculations_, not very useful for
calculations where the results rely on the previous results #hinweis[(like Fibonacci)].\
*High Parallelization:*
A _CPU_ offers few cores #hinweis[(4, 8, 16, 64)] and is very fast. Programming is easier.
A _GPU_ offers a very large number of cores #hinweis[(512, 1024, 3584, 5760)] and has very
specific slower processors. It is optimized for throughput. Programming is more difficult.\
*GPU Structure:*
A GPU consists of multiple _Streaming Multiprocessors (SM)_ which in turn consist of multiple
_Streaming Processors (SP)_ #hinweis[(e.g. 1-30 SM, 8-192 SPs per SM)].\

*SIMD:*
Single Instruction Multiple Data. The _same instruction_ is executed simultaneously on
_multiple cores_ working on _different data elements_ #hinweis[(Vector parallelism)].
Saves fetch & decode instructions.\
*SISD:*
Single Instruction Single Data. Purely _sequential_ calculations.\
*SIMT:*
Single Instruction Multiple Threads. The same instruction is executed in different threads over different data.
#image("img/parprog_7.png")


== Latency vs. Throughput
*Latency:*
_Elapsed time_ of an event
#hinweis[(Walking from point A to B takes one minute, the latency is one minute)].\
*Throughput:*
_The number of events_ that can be executed per unit of time #hinweis[(Bandwidth)]\
There is a _tradeoff_ between latency and throughput. Increasing throughput by pipelined
processing, latency most often also increases. All pipeline stages must operate in _lockstep_.
The _rate of processing_ is determined by the _slowest step_.\
*Pipelining:*
Run processes in an overlapping manner.\
*Example:*
A program consists of two operations:
Transfer data from CPU memory to GPU memory ($T_1$ units = #tcolor("grün", "20ms")),
Execute computation on the device ($T_2$ units = #tcolor("orange", "60ms")). \
What is the _latency_ (non-pipelined)? $fxcolor("grün", 20) + fxcolor("orange", 60) = underline(80"ms")$.\
What is the _throughput_ (pipelined)? Every #tcolor("orange", "60ms") an operation is finished.\
Throughput = $1\/60$ operations/ms.

== CPU vs GPU
#table(
    columns: (39%, auto),
    table.header[CPUs][GPUs],
    [
        - _Low latency_
        - Few but _optimized cores_
        - _General purpose_
        - Architecture and Compiler help to run any code fast
    ],
    [
        - Can execute _highly parallel data_ operations
        - Simple but a _lot of cores_ with cache per core
        - very useful for problems which consist of a _lot of independent data elements_
        - Efficiency must be achieved by _optimizing_ the program
    ],

    [
        *Aim:* low latency per thread
    ],
    [
        *Aim:* high throughput
    ],
)

== NUMA Model
NUMA stands for _Non-Uniform Memory Access_. CPUs on host and GPU devices each have local
memories. There is _no  main memory_ between the two, so _explicit transfer_ between CPU
and GPU is needed. There is also _no garbage collector_ on the GPU.

== CUDA
Computer Unified Device Architecture. Is a _parallel computing platform and an API_ for Nvidia
GPU that allows the host program to use GPUs for general purpose processing.

==== CUDA Execution steps
#grid(
    columns: (auto, 1fr),
    gutter: 3pt,
    [
        + _`cudaMalloc`:_ GPU memory allocate
        + _`cudaMemcpy`:_ Data transfer to GPU #hinweis[(HostToDevice)]
        + _`Kernel<<<1, N>>>`:_ Kernel execution
    ],
    [
        4. _`cudaMemcpy`:_ Transfer results from GPU to CPU #hinweis[(DeviceToHost)]
        + _`cudaFree`:_ Deallocate GPU memory
    ],
)

==== Example: Array addition
```cpp
for (int i = 0; i < N; i++) { C[i] = A[i] + B[i]; } // sequential
(i = 0 .. N-1): C[i] = A[i] + B[i]; // parallel using n threads
```

==== CUDA Kernel
A kernel is a function that is executed $n$ times in parallel by $m$ different CUDA threads.
```cpp
// kernel definition on GPU
__global__
void VectorAddKernel(float *A, float *B, float *C) {
  int i = threadIdx.x; C[i] = A[i] + B[i];
}
// kernel invocation on CPU
VectorAddKernel<<<1, N>>>(A, B, C); // N is amount of threads
```
Only the GPU knows when the task is finished.

==== Boilerplate Orchestration Code
```cpp
void CudaVectorAdd(float* h_A, float* h_B, float* h_C, int N) {
  size_t size = N * sizeof(float);
  float *d_A, *d_B, *d_C; // data on GPU
  cudaMalloc(&d_A, size); cudaMalloc(&d_B, size); cudaMalloc(&d_C, size);
  cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);
  VectorAddKernel<<<1, N>>>(d_A, d_B, d_C, N);
  cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);
  cudaFree(d_A); cudaFree(d_B); cudaFree(d_C);
}
```

#wrap-content(
    image("img/parprog_8.png"),
    align: top + right,
    columns: (68%, 32%),
)[
    == Performance Metrics
    The performance is either limited by _memory bandwidth_ or _computation_.
    *Compute Bound:*
    Throughput is limited by calculation #hinweis[(Cores are at the limit, but the memory bus
        could transfer more data)].\ _This is better and reached if AI Kernel > AI GPU_.\
    *Memory Bound:*
    Throughput is limited by data transfer #hinweis[(Memory bus bandwidth is at its limit, but
        cores could process more data)].\
    *Arithmetic intensity:*
    Defined as FLOPS #hinweis[(Floating Point Operations per Second)] per Byte.
    The higher, the better.\
    #box($ "Number of operations" / "Number of transferred bytes" = "FLOPS" / "Bytes" $)

    *Example:*
    ```cpp for(i=0; i<N, i++) { z[i] = x[i] + y[i] * x[i]; }```\
    Read `x` and `y` from memory, write `z` to memory.
    That's 2 reads and 1 write #hinweis[(`x` is used twice but read only once)].
    In case `x`, `y` and `z` are `int`s, we have #fxcolor("grün", "12") #hinweis($(3 dot 4)$) bytes
    transferred and $#fxcolor("orange", "2")$ arithmetic ops ($+$, $*$).
    The arithmetic intensity is therefore $#fxcolor("orange", "2") / #fxcolor("grün", "12") =
    #fxcolor("orange", "1") / #fxcolor("grün", "6")$.
]

=== Roofline model
Provides performance estimates of a kernel running on differently sized architectures.
Has three parameters: Peak performance, peak bandwidth vs. arithmetic intensity.\
_Peak performance_ is derived from benchmarking FLOPS or GFLOPS #hinweis[(Giga-FLOPS , $10^9$
    FLOPS)]. The _peak bandwidth_ from manuals of the memory subsystem. The _ridge point_ is where
the horizontal and diagonal lines meet = minimum AI required to achieve the peak performance.

#image("img/parprog_9.png", width: 90%)

= GPU Architecture
Because there are so _many cores_ on GPUs, it is possible to run many threads in parallel
_without context switches_. This allows better parallelism without a performance penalty.

== Compilation
*Just-in-time Compilation:*
The _NVCC compiler_ compiles the non-CUDA code with the host C compiler and translates code
written in CUDA into _PTX instructions_ #hinweis[(assembly language represented as ASCII
    text)]. The graphics driver compiles the PTX into _executable binary code_.
The assembly of PTX code is _postponed until application runtime_, at which time the target
GPU is known. The _disadvantage_ of this is the _increased application startup delay_.
However, thanks to cache this only happens once #hinweis[(warmup)].\
*Programming Interface:*
_Runtime_ #hinweis[(The `cudart` library provides functions that execute on the host to
    (de-)allocate device memory, transfer data etc.)] or _driver API_ #hinweis[(The CUDA driver API
    is implemented in the `cuda.dll` or `cuda.so` which is copied on the system during installation
    of the driver. This provides an additional level of control by exposing lower-level concepts
    such as CUDA contexts. Often overkill)]. \
*Asynchronous Execution:*
The command pipeline in CUDA works asynchronous, commands and data can be transferred from/to
the GPU at the same time.

== CUDA SIMT Execution Model
Single instruction, multiple Threads. The kernel is executed $N$ times in parallel by $N$
different CUDA threads.\
*Blocks:*
Threads are _grouped_ in blocks. The host can define how many threads each block has
#hinweis[(up to 1024)]. Threads in one block can _interact_ with each other but not with
threads in other blocks. \
*Execution Model:*
_One thread_ runs on _one virtual scalar processor_ #hinweis[(one GPU core)].
_One block_ runs on _one virtual multi-processor_ #hinweis[(one GPU Streaming Multiprocessor)].
Blocks must be _independent_.\
*Thread Pool Abstraction:*
The compiled CUDA program has e.g. 8 CUDA blocks. The _runtime_ can _choose how to allocate_
these blocks to multiprocessors. For a larger GPU with 8 SMs, each SM gets one CUDA block.
This enables performance scalability without code changes.\
*Guarantees:*
CUDA guarantees that _all threads in a block_ run on the _same SM_ at the _same time_ and that
the blocks in a kernel _finish before_ any block from a new, _dependent kernel_ is _started_.\
*Mapping:*
One SM can run several _concurrent_ blocks depending on the resources needed. Each _kernel_ is
executed _on one device_. CUDA supports running _multiple kernels on a device_ at one time.

== CUDA Kernel specification
*Specifying Kernel:*
```cpp VectorAddKernel<<<GRID_dimension, BLOCK_dimension>>>(A,B,C)```\
Dimensions can be 1D, 2D or 3D and specified via `dim3` which is a structure designed for
storing block and grid dimensions: ```cpp struct dim3{x; y; z}```.\
```cpp dim3 dimGrid(2) == dim3 dimGrid(2,1,1)``` #hinweis[(Unassigned components are set to 1)]\
```cpp VectorAddKernel<<<dimGrid, dimBlock>>>(A,B,C);```\
_Number of blocks in a grid:_ ```cpp dimGrid.x * dimGrid.y * dimGrid.z ```\
_Number of threads in a block:_ ```cpp dimBlock.x * dimBlock.y * dimBlock.z```\
*1D Grid:*
We can simply use integers. ```cpp VectorAddKernel<<<1, N>>>``` creates 1 Block with N Threads.\
*2D Grid:*
```cpp dim3 gridS(3,3); dim3 blockS(3,3); VectorAddKernel<<<gridS, blockS>>>```\
*3D Grid:*
```cpp dim3 gridS(3,2,1); dim3 blockS(4,3,1); VectorAddKernel<<<gridS, blockS>>>```\
*Device Limits:*
_Max threads per block:_ 1024,
_Max thread dimensions per block:_ (1024, 1024, 64)
_Max grid size:_ (2'147'483'647, 65'535, 65'535)

#wrap-content(
    image("img/matrices.svg"),
    align: top + right,
    columns: (60%, 40%),
)[
    ==== Calculation Examples
    ```cpp VectorAddKernel<<<dim3(8,4,2), dim3(16,16)>>>(d_A, d_B, d_C);```\
    _Amount of Blocks:_ $8 dot 4 dot 2 = 64$ \
    _Amount of threads per block:_ $16 dot 16 = 256$ \
    _Threads in total:_ $64 dot 256 = 16'384$

    If we have $1024$ threads in a block, how many blocks are needed to launch $N$ threads?\
    _`int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;`_ \
    #hinweis[Rounding up is necessary because for 1025 threads, 2 blocks are required]
]
#v(-0.75em)

== Data Partitioning within threads
*Data Access:*
Each kernel decides which data to work on. The programmers decide data partitioning scheme.
`threadId.x/y/z` #hinweis[(Thread no. in block)],
`blockId.x` #hinweis[(Block no.)],
`blockDim.x` #hinweis[(Block size)]\
*Partitioning in Blocks:*
```cpp
__global__
void VectorAddKernel(float *A, float *B, float *C) {
  int i = blockIdx.x * blockDim.x + threadIdx.x; //index based on (blockID, threadID)
  if (i < N) {
    C[i] = A[i] + B[i]; // without this if, some threads will be idle
  } }
// kernel invocation
N = 4097; int blockSize = 1024; int gridSize = (N + blockSize - 1) / blockSize;
VectorAddKernel<<<gridSize, blockSize>>>(A, B, C);
```

*Boundary Check:*
More threads than necessary work on the data. If $N = 4097$, 5 Blocks with 1024 Threads are
needed which results in _1023 unused threads_. Threads with $i >= N$ must _not be allowed_
to write to array $C$ because they might _corrupt the working memory_ of some other thread.

== Error Handling
Some functions have return type `cudaError`. Need to check for `cudaSuccess`. It's best to
write your own helper function and wrap _every line_ in it. E.g. `handleCudaError()`
which prints the error and exits the program.

== Unified Memory
Unified memory allows automatic transfer from CPU to GPU and vice versa.
No explicit Memory Copy needed, but other new rules.

```cpp
cudaMallocManaged(&A, size); // ... same for &B and &C ...
A[0] = 8; ... // initialize A and B assuming they reside on the host
// A and B are automatically transferred to the device
VectorAddKernel<<<..,..>>>(A,B,C,N);
cudaDeviceSynchronize(); // wait for the GPU to finish
// C is transferred automatically to the host and can be read directly
std::cout << C[0]; ...
cudaFree(A); cudaFree(B); cudaFree(C);
```


= GPU Performance Optimizations
*Hardware:*
A scalable array of multithreaded _Streaming Multiprocessors_ (SMs),
the _threads_ of a thread block execute _concurrently_ on one multiprocessor,
multiple _thread blocks_ can execute _concurrently_ on one multiprocessor.
When thread blocks _terminate_, new blocks are launched on the free multiprocessors.

== Matrix Addition
```cpp
__global__
void MatrixAddKernel(float *A, float *B, float *C) {
  int column = blockIdx.x * blockDim.x + threadIdx.x;
  int row = blockIdx.y * blockDim.y + threadIdx.y;
  if (row < A_ROWS && col < A_COLS) { // boundary checking
    C[row * A_COLS + col] = A[row * A_COLS + col] + B[row * A_COLS + col];
  }
}
const int A_COLS, B_COLS, C_COLS = 6;
const int A_ROWS, B_ROWS, C_ROWS = 4;
dim3 block = (2,2); dim3 grid = (3,2); // (3,2) == (3,2,0)
MatrixAddKernel<<<grid,block>>>(A,B,C);
```

== Matrix Multiplication
*Parallelization:*
Every thread computes one element of the result matrix $C$.
Can be parallelized because results do not depend on each other.
```cpp
__global__
void MatrixMultiply(float *A, float *B, float *C) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int j = blockIdx.y * blockDim.y + threadIdx.y;
  if (i < N && j < M) { // boundary checking
    float sum = 0;
    for (int k = 0; k < K; k++) {
      sum += A[i * K + k] * B[k * M + j];
    }
    C[i * M + j] = sum;
  }
}
```

== Mapping Threads / Blocks to GPU Warps
*Warps:*
Blocks are split into _warps_ #hinweis[(1 Warp = 32 Threads)] and all threads within execute
the same code. If there aren't enough threads to fill a warp, "empty" threads are launched.
A number of warps constitutes a _thread block_. A number of _thread blocks_ are assigned to a
_Streaming Multiprocessor_. The whole GPU consists of several SM.\
Thread blocks are scheduled in _parallel_ or _sequentially_. Once a thread block is _launched_
on a SM, _all of its warps are resident_ until their execution finishes. Therefore, a _new
block on a SM_ is _not launched until_ there is a _sufficient number_ of free registers and
shared memory for _all warps_ of the new block.\
*Warp Execution:*
All threads in a warp execute the same instruction #hinweis[(SIMD)]. A SM can accommodate all
warps of a block, but only _a subset_ is _running in parallel_ at the same time
#hinweis[(1 to 24)].\
*Divergence:*
_Not_ all threads of a warp may _branch the same way_.
The branches do _not run simultaneously_, so the other threads need to _wait_ until one branch
is finished. So branches within one warp should be _avoided_ because of _performance problems_
#hinweis[(Branches are born at `if` / `switch` / ...)] \

#grid(
    columns: (1.75fr, 2fr),
    gutter: 1em,
    [
        ```cpp
        // bad case, divergence in same wrap
        if (threadIdx.x > 1) { } else {  }
        ```
    ],
    [
        ```cpp
        // good case, all t in warp in same branch
        if (threadIdx.x / 32 > 1) { } else { }
        ```
    ],
)

/ DRAM (Dynamic Random Access Memory): _Global memory of a CUDA device_ is implemented with DRAMs. If a GPU kernel accesses data from _consecutive locations_, the DRAMs can supply the data at a much _higher rate_ than if a random sequence of locations were accessed.
/ Memory Coalescing: Thread _access patterns_ are critical for performance. If the threads in a *warp* _simultaneously_ access _consecutive memory locations_, their reads can be combined into a single access _(burst)_. Otherwise there are _expensive individual accesses_.
/ Coalesced Accesses: Read/Write the burst in one transaction per warp burst section, swapped read/write within the same burst, only individual elements in the burst accessed.
/ Not Coalesced Accesses: Read/Write in different warp bursts, one action that spans multiple bursts. _Inperformant, avoid!_
/ Use Coalescing access as follows: _`data[(Expression without threadId.x) + threadId.x]`_
/ Coalescing with Matrices: Matrices get linearized to a 1D array. The row of the matrix should be the longer side so that there are as many coalescing accesses as possible.

== Memory Model
All threads have the access to the same _global memory_. Each thread block has _shared memory_
visible to all threads of the block and with the same lifetime as the block
#hinweis[(Has higher bandwidth and lower latency than local or global memory but longer latency
    and lower bandwidth than registers which are private to a thread)].
Each thread has _private local memory_ #hinweis[(in device memory, high latency and low
    bandwidth, same as global)]. Constant, texture and surface memory also reside in device memory.\
/ Memory Hierarchy:
    _Shared Memory_ #hinweis[(per SM, fast, shared between threads in 1 block, a few KB, `__shared__ float x`)],
    _Global Memory_ #hinweis[("Main Memory" in GPU Device, slow, accessible to all threads, in GB, `cudaMalloc()`)]
_Registers_ #hinweis[(private to a thread, fastest but very limited storage)]\
/ Constant memory:
    Constant variables are stored in the _global memory_ but are _cached_.\
/ Shared Memory Declaration:
    With keyword `__shared__`. A _static array size_ is necessary. Limited memory, around 48KB.
    Multidimensionality is allowed.\
/ Fast Matrix Multiplication:
    By _reducing global memory traffic_. Partition data into subsets called tiles which fit into
    shared memory #hinweis[(the row & column that should be multiplied and the result cell)].
    The kernel computation on these tiles must be able to run _independently_ of each other.
    Because the shared memory is _limited_, load the tiles in _several steps_ and calculate the
    _intermediate result_ from this.

```cpp
__global__ void MatrixMulKernel(float* d_M, float* d_N, float* d_P, int Width) {
  __shared__ float Mds[TILE_WIDTH][TILE_WIDTH];
  __shared__ float Nds[TILE_WIDTH][TILE_WIDTH];
  int bx = blockIdx.x; int by = blockIdx.y;
  int tx = threadIdx.x; int ty = threadIdx.y;
  // identify row and column of the d_P element to work on
  int Row = by * TILE_WIDTH + ty;
  int Col = bx * TILE_WIDTH + tx;
  float Pvalue = 0;
  // loop over d_M and d_N tiles required to compute d_P element
  for (int m = 0; m < Width/TILE_WIDTH; ++m) {
    // collaborative loading of d_M and d_N tiles into shared memory
    Mds[ty][tx] = d_M[Row*Width + m*TILE_WIDTH + tx];
    Nds[ty][tx] = d_N][(m*TILE_WIDTH + ty)*Width + Col];
    __syncthreads(); // CUDA equivalent to wait()
    for (int k = 0; k < TILE_WIDTH; ++k) {
      Pvalue += Mds[ty][k] * Nds[k][tx];
    }
    __syncthreads();
  }
  d_P[Row*Width + Col] = Pvalue;
}
```
#hinweis[
    ```cpp __syncThreads()``` is only allowed in `if`/`else` if all threads of a block
    choose the same branch, otherwise undefined behavior.
]


= High Performance Computing (HPC) Cluster Paralleliz.
Cluster programming is the _highest possible parallel acceleration_ #hinweis[(Factor 100 and
    more)]. Used for _general purpose programming_, lots of CPU cores. Combination of CPUs and GPUs possible. \
/ Computer Cluster:
    Network of _powerful_ computing nodes, firmly connected at one location.\
    Very _fast interconnect_ #hinweis[(like 100GBit/s)], used for big simulations #hinweis[(Fluids, Weather, Traffic, etc.)]\
/ SPMD:
    This is the most ly used programming model, "high level".\
    _Single Program_ #hinweis[(All tasks execute their copy of the same program simultaneously)],
    _Multiple Data_ #hinweis[(all tasks may use different data)].
    The MPI program is started in several processes. All processes start and terminate
synchronously. Synchronization is done with barriers.\
/ MPMD:
    Also a "high level" programming model.
    _Multiple Program_ #hinweis[(Tasks may execute different programs simultaneously)],
    _Multiple Data_ #hinweis[(all tasks may use different data)].\
/ Hybrid Memory Model:
    All processors in a machine can _share_ the memory. They also can _request_ data from other
    computers. #hinweis[(non-uniform memory access: not all accesses take the same time)]\
/ Message Passing Interface (MPI):
    Distributed programming model. Is a  choice for Parallelization on a cluster,
    Industry-Standard libraries for multiple programming languages.\
/ MPI Model:
    Notion of processes #hinweis[(Process is the running program plus its data)], parallelism is
    achieved by running _multiple processes_, co-operating on the _same_ task. Each process has
    _direct access_ only to its _own data_ #hinweis[(variables are private)].
    Inter-Process-Communication by sending and receiving messages.\
/ SPMD in MPI:
    All processes run their _own local copy_ of the program & data. Each process has a _unique
    identifier_, processes can take _different paths_ through the program depending on their IDs.
    Usually, _one process per core_ is used #hinweis[(to maximize the benefit of parallelization)].\
/ Formalizing Message:
    A message transfers a number of data items from the memory of one process to the memory of
    another process #hinweis[(Typically contains ID of sender and receiver, data type to be sent,
        number of data items, data itself, message type identifier)].\
/ Communication modes:
    _Point to Point_ #hinweis[(very simple, one sender and one receiver. Relies on matching send and receive calls)] and
    _Collective communications_ #hinweis[(between groups of processes.
        _Broadcast_: one to all,
        _Scatter_: Split data and send each chunk to different node,
        _Gather_: Collect the chunks back at the originating node)].\

== MPI Boilerplate Code
```c
int main(int argc, char * argv[]) {
  MPI_Init(&argc, &argv); // MPI Initialization
  int rank; int len;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank); // Process Identification
  char name[MPI_MAX_PROCESSOR_NAME];
  MPI_Get_processor_name(name, &len);
  printf("MPI process %i on %s\n", rank, name);
  MPI_Finalize(); // MPI Finalization
  return 0; }
```

/ `MPI_Init`:
    Must be the _first_ MPI call. Allows the `mpi_init` to broadcast to all the processes.
    Does _not_ create processes, they are only created at launch time.
    All MPI _global and internal variables are constructed_.
    A _communicator_ is formed around all the processes that were spawned and _unique ranks_
    #hinweis[(IDs)] are assigned to each process.
_`MPI_COMM_WORLD`_ encloses all processes in the job.\
/ Communicator:
    Group of MPI processes, allows inter-process-communication.\
/ `MPI_Comm_rank`:
    _Returns the rank_ of a process in a communicator. Used for sender/receiver IDs.\
/ `MPI_Comm_size`:
    _Returns the total number_ of processes in a communicator.\
/ `MPI_Finalize`:
    Is used to _clean up_ the environment. No more MPI calls after that.\
/ `MPI_Barrier`:
    Blocks until all processes in the communicator have reached the barrier.\
/ Compilation & Execution: ```sh mpicc HelloCluster.c && mpiexec -c 24 a.out && sbatch -hi.sub```
/ Process Identification:
    _Rank_ = number within a group, incremental numbering from 0.\
    _Unique Identification_ = (Rank, Communicator)

```c MPI_Send(void * data, int count, MPI_Datatype datatype, int destination, int tag, MPI_Comm communicator) // tag: freely selectable number for msg type (>= 0)```\
```c MPI_Recv(void * data, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm communicator, MPI_Status* status) // status: error information```

Each _send_ should have a matching _receive_.\
/ Example direct communication: \
```c MPI_Send(&value, 1, MPI_INT, receiverRank, tag, MPI_COMM_WORLD);```\
```c MPI_Recv(&value, 1, MPI_INT, senderRank, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);```\
/ Array send: ```c int array[LENGTH];``` \
    ```c MPI_Send(array, LENGTH, MPI_INT, receiverRank, tag, MPI_COMM_WORLD);``` \
    ```c MPI_Recv(array, LENGTH, MPI_INT, senderRank, tag, MPI_COMM_WORLD, MPI_STATUS_IGN);```

/ `MPI_Bcast`:
    Is _efficient_, because the root node does _not send the signal individually_ to each node,
    the _other nodes help_ spread the message to others.:
    ```c MPI_Bcast(void * data, int count, MPI_Datatype datatype, int root, MPI_Comm_World communicator)```\
    #image("/assets/image-1.png")
/ `MPI_Reduce`:
    Reduction is a classic concept: reducing a set of numbers into a smaller set of numbers via a
    function #hinweis[(e.g. `[1,2,3,4,5] => sum => 15`)]. Each process contains one integer,
    `MPI_Reduce` is called with a root process of 0 and using `MPI_SUM` as the reduction operation.
    The four numbers are added and stored on the root process.
    Job is done in a _distributed manner_.\
    ```c MPI_Reduce(void* send_data, void* recv_data, int count, MPI_Datatype datatype, MPI_Op op, int root, MPI_Comm comm)```
    #hinweis[
        (_`send_data`_: array of elements of type `datatype` to reduce from each process,
        _`recv_data`_: relevant on the root process. contains the reduced result and has a size of `sizeof(datatype) * count`.
        _`op`_: the operation you wish to apply to your data: `MPI_MAX`, `MPI_MIN`, `MPI_SUM`,
        `MPI_PROD`: multiplies all, `MPI_BAND`/`MPI_LAND`: Bitwise/Logical AND, `MPI_LOR`: Logical OR,
        `MPI_MAXLOC`: Same as max plus rank of process that owns it)
    ]\
/ `MPI_AllReduce`:
    Many parallel applications require accessing the reduced results _across all processes_.
    This function reduces the values and distributes the result to all processes.
    Does not need a root node. This is an _implicit broadcast_ to all processes.\
    ```c MPI_Allreduce(void* send_data, void* recv_data, int count, MPI_Datatype datatype, MPI_Op op, MPI_COMM comm)```\
/ `MPI_Gather`:
    Gather together multiple values from different processors.\
    ```c MPI_Gather(&input_value, 1, MPI_INT, &output_array, 1, MPI_INT, 0, MPI_COMM_WORLD)```

    /*
        Hoffentlich im Anhang vorhanden:
        The reduction operations defined by MPI include
        MPI_MAX - Returns the maximum element.
        MPI_MIN - Returns the minimum element.
        MPI_SUM - Sums the elements.
        MPI_PROD - Multiplies all elements.
        MPI_LAND - Performs a logical and across the elements.
        MPI_LOR - Performs a logical or across the elements.
        MPI_BAND - Performs a bitwise and across the bits of the elements.
    MPI_BOR - Performs a bitwise or across the bits of the elements.
    MPI_MAXLOC - Returns the maximum value and the rank of the process
    that owns it.
    MPI_MINLOC - Returns the minimum value and the rank of the process
    that owns it.
    */

    // #grid(
    //     columns: (auto, auto),
    //     [
    == Approximation of $bold(pi)$ via Monte Carlo Simulation <pi-approx>
    Draw a circle inside of a square and randomly place dots in the square. The ratio of dots
    inside the circle to the total number of dots will approximately equal $pi \/ 4$.
    // ],
    // [


    #v(-0.5em)
    #grid(
        columns: (auto, auto),
        [
            ```c
            // Sequential
            long count_hits(long trials) { long hits = 0, i;
            for (i = 0; i < trials; i++) {
                double x = (double)rand()/RAND_MAX;
                double y = (double)rand()/RAND_MAX;
                // distance to center bigger than radius=1 :
                if (x * x + y * y <= 1) { hits++;}
              }
            return hits; }
            ```
        ],
        [
            ```c
            // Parallel, the trials are split across different nodes
            int rank, size;
            MPI_Comm_rank(MPI_COMM_WORLD, &rank);
            MPI_Comm_size(MPI_COMM_WORLD, &size);
            srand(rank * 4711); // each process receives a different seed
            // Each process computes a subtask:
            long hits = count_hits(TRIALS / size);
            long total;
            MPI_Reduce(&hits, &total, 1, MPI_LONG, MPI_SUM, 0, MPI_COMM_WORLD);
            if (rank == 0) { double pi = 4 * ((double)total / TRIALS); }
            ```
        ],
    )
= OpenMP
*Node:*
A standalone _"computer in a box"_. Usually comprised of multiple CPU/processors/cores, memory,
network interfaces etc. Nodes are _networked together_ to comprise a _supercomputer_.
Each node consists of 20 cores. The processes do _not share memory_, they must use messages.\
*Threads:*
Default are 24 on a single Node in OST cluster. Can be set with `omp_set_num_threads()` or with
the `OMP_NUM_THREADS` environment variable. Threads range from 0 #hinweis[(master thread)] to N-1.\
*HPC Hybrid memory model:*
Run a program on multiple nodes. No Shared Memory #hinweis[(NUMA)] between Nodes.
Shared Memory #hinweis[(SMP)] for Cores inside a Node.\
*OpenMP:*
Is a programming model for different languages.
_Allows to run multiple threads_, distribute work using synchronization and reduction constructs.
_Shared Memory_ #hinweis[(shared memory process consists of multiple threads)],
_Explicit Parallelism_ #hinweis[(Programmer has full control over parallelization)] and
_Compiler Directives_ #hinweis[(Most OpenMP parallelism is specified through the use of compiler
    directives (`pragmas`) in the source code)].\

==== Fork and Join
```c
#include <stdio.h>
#include <omp.h>
int main(int argc, char* argv[]) {
  const int np = omp_get_max_threads(); // executed by initial thread
  printf("OpenMP with threads %d\n", np); // executed by initial thread
  #pragma omp parallel // pragma spawns multiple threads (fork)
  {
    const int np = omp_get_num_threads(); // executed in parallel
    printf("Hello from thread %d\n", omp_get_thread_num()); // executed in paral.
  } // thread order not fixed. after execution, threads synchronize & terminate
  return 0; }
```

==== For loops
```c
#pragma omp parallel for
  for (i=0; i<n; i++) { ... }
```

Each thread processes _one loop-iteration_ at a time. Execution returns to the initial threads.
_Oversubscription_ #hinweis[(too many threads for a problem)] is handled by OpenMP.
The iteration variable #hinweis[(i.e. `i`)] is implicitly made private for the duration of the loop.

==== Memory Model
```c
int A, B, C // automatically global because outside of pragma
#pragma omp parallel for private (A) shared (B) firstprivate (C)
  for(...)
```

Each thread has a _private copy of `A`_ and use the _same memory location for `B`_.
`C` is also private, but gets its initial value from the global variable. After the loop is
over, threads die and both `A` and `B` will be cleared/removed from memory.

```c
#pragma omp parallel
  int A = 0 // automatically private because inside of pragma
#pragma omp for ...
```

==== Avoiding Race conditions: Mutex
```c
int sum = 0;
#pragma omp parallel for
  for (int i = 0; i < n; i++)
#pragma omp critical { sum += i; } // only one thread at a time
```

This is _extremely slow_ due to serialization, slower than single threading. Critical section
is _overkill_ for this code, with a heavy weight mutex the performance overhead is large.

==== Lightweight mutex: Atomic
```c
int sum = 0; int i;
#pragma omp parallel for
  for (i = 0; i < n; i++)
  #pragma omp atomic { sum += i }
```

==== Reduction across threads
When using `reduction(operator: variable)`, a _copy_ of the reduction variable per thread is created,
initialized to the identity of the reduction operator #hinweis[($+ = 0$, $* = 1$)].
Each thread will then _reduce_ into its local variable. At the end of the `parallel` region, the local
results are _combined into the global variable_. Only associative operators allowed
#hinweis[($+, *$ not $-, div$)].

```c
// Code using the reduction clause
int sum = 0;
#pragma omp parallel for reduction(+: sum)
  for (int i = 0; i < n; i++) { sum += i; }

// The same code without the reduction clause
int sum = 0;
#pragma omp parallel {
  int intermediate_sum = 0; // private
  #pragma omp for
    for (int i = 0; i < n; i++) { intermediate_sum += i; } // thread partial sum
  #pragma omp atomic // reduction is protected with atomic
    final_sum += intermediate_sum; }
```

==== Hybrid: OpenMP + MPI
```c
int numprocs, rank; int iam = 0, np = 1;
MPI_Init(&argc, &argv);
MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
MPI_Comm_rank(MPI_COMM_WORLD, &rank);
#pragma omp parallel default(shared) private(iam, np) {
  np = omp_get_num_threads();
  iam = omp_get_thread_num();
  printf("I am T %d out of %d from P %d out of %d\n", iam, np, rank, numprocs);
} MPI_Finalize();
```

==== Sequential `count_hits` to approximate $pi$ with Monte Carlo Simulation in OpenMP
```c
long count_hits(long trials) {
  long hits = 0; long i; double x,y;
  #pragma omp parallel {
    #pragma omp for reduction(+:hits) private(x,y)
      for (i = 0; i < trials; i++) {
        double x = random_double(); double y = random_double();
        if (x * x + y * y <= 1) { hits +; }
      }
    }
  return hits;
}
```

= Performance Scaling
*Difficulties with parallel programs*:
Finding parallelism, granularity of a parallel task, moving data is expensive, load balancing,
coordination & synchronization, performance debugging.\
*Scalability:*
The ability of hard- and software to deliver _greater computational power_ when the number of
_resources is increased_.\
*Scalability Testing:*
Primary challenge of parallel computing is _deciding how best to break up a problem_ into
individual pieces that can be computed separately.
It is _impractical_ to develop and test large applications using the _full problem size_.
The problem and number of processors are _scaled down_ at first.
_Scalability testing:_ measuring the ability of an application to perform well or better with
varying problem sizes and numbers of processors. It does _not_ test the applications _general
functionality_ or correctness.

== Strong scaling
_The number of processors is increased while the problem size remains constant_.
Results in a reduced workload per processor. Mostly used for long running CPU bound applications.\
*Amdahls Law:*
The speedup is _limited by the fraction of the serial part_ of the software that is not
amenable to parallelization. Sweet spot needs to be found. It is reasonable to use _small
amounts of resources for small problems_ and _larger quantities of resources for big problems._\
$T =$ total time, $p =$ part of the program that can be parallelized., $N =$ amount of processors\
$T = (1-p)T + T_p = T_s + T_p$\
$T_N = T_p \/ N + (1-p)T$, Speedup $<= 1\/(s + p \/ N)$, Efficiency = $T\/(N dot T_N)$\
Amdahls law _ignores the parallel overhead_. Because of that, it is _the upper limit_ of
speedup for a problem of fixed size. This seems to be a _bottleneck_ for parallel computing.\
*Examples:*
$90%$ of the computation can run parallel, what is the max speedup with $8$ processors?
$1 \/ (0.1 + 0.9\/8) approx underline(4.7)$ \
25% of the computation must be serial. What is the max speedup with $infinity$ Processors? \
$1\/ (0.25 + 0.75\/infinity) approx 1 \/0.25 = 4$ \
To gain a $500 times$ speedup on $1000$ processors,
Amdahls law requires that the proportion of serial part cannot exceed what?\
$500 = 1\/(s + (1-s) / 1000) => s + (1-s) / 1000 = 1 / 500
=> 1000s + (1-s) = 2 => 999s = 1 => s = 1 / 999 approx underline(0.1%)$

== Weak scaling
_The number of processors and the problem size is increased_. Mostly used for large
_memory-bound_ applications where the required memory cannot be satisfied by a single node.\
*Gustafson's law:*
Based on the approximations that the _parallel part scales linearly_ with the amount of
resources, and that the _serial part_ does _not increase_ with respect to the size of the problem.
_Speedup_ $= s + p dot N = s + (1-s) dot N$\
In this case, the problem size assigned to each processing element stays _constant_ and
_additional elements_ are used to solve a _larger total problem_. Therefore, this type of
measurement is justification for programs that take a lot of memory or other system resources.\
*Example:*
$64$ Processors. $5%$ of the program is serial, What is the scaled weak speedup?\
$0.05 + 0.95 dot 64 = underline(60.85)$
