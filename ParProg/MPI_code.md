From lecture SW8


### Single Commands
```c
MPI_Init(&argc, &argv); // init, send parameters to all proccessors

// ...

MPI_Finalize(); // end of mpi
```

```c
int rank, size;
MPI_Comm_rank(MPI_COMM_WORLD, &rank); // individual rank
MPI_Comm_size(MPI_COMM_WORLD, &size); // number of processes
```

Makros von MPI:
```c
MPI_COMM_WORLD
```

```c
MPI_Barrier(MPI_COMM_WORLD)
```

### Examples

#### Direct Communication
```c
MPI_Send( void* data, int count, MPI_Datatype datatype, int destination, int tag, MPI_Comm communicator);
MPI_Recv( void* data, int count, MPI_Datatype datatype, int source, int tag, MPI_Comm communicator, MPI_Status* status);
// MPI_Comm: gib Makro MPI_COMM_WORLD ein
```

Template direct communication

- Here sending/receiving an int value (int value)
- tag: freely selectable number for message type (>= 0)
- count = 1, for one value
- status: error information (ignored here)

```c
// Send
MPI_Send(&value, 1, MPI_INT, receiverRank, tag, MPI_COMM_WORLD);
// Receive
MPI_Recv(&value, 1, MPI_INT, senderRank, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
```

Example: Send and Receive
<!-- print wird von MPI gesammelt und korrekt angezeigt -->
One process (with rank 0) will be the sender and all other processers will act as receivers.

```c
int rank, size;
MPI_Comm_rank(MPI_COMM_WORLD, &rank);
MPI_Comm_size(MPI_COMM_WORLD, &size);
if (rank == 0) {
    int value = rand(); int to;
    for (to = 1; to < size; to++) {
        MPI_Send(&value, 1, MPI_INT, to, 0, MPI_COMM_WORLD);
    }
} else {
    int value;
    MPI_Recv(&value, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    printf("%i received by %i", value, rank);
}
```

#### Array send over MPI

Send with Array
```c
int array[LENGTH];
MPI_Send(array, LENGTH, MPI_INT, receiverRank, tag, MPI_COMM_WORLD);
```

```c
// #define LENGTH 100 ??

int array[LENGTH];
// Send
MPI_Send(array, LENGTH, MPI_INT, receiverRank   );
// Receive
MPI_Recv(array, LENGTH, MPI_INT, senderRank, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
```

#### MPI Barrier
Blocks until all processes in the communicator have reached the barrier

```c
MPI_Barrier(MPI_COMM_WORLD)
```
#### Broadcast
Broadcast with MPI_Bcast.
```c
MPI_Bcast( void* data, int count, MPI_Datatype datatype, int root, MPI_Comm_World communicator)
```

#### Scatter & Gather
[website](https://mpitutorial.com/tutorials/mpi-scatter-gather-and-allgather/)
Sende an verschiedene Nodes verschiedene Daten gleichzeitig.

```c
// root = rank of sender
// send_data = welche Daten sender schickt, z.B. ein Array
// recv_data = wo receiver die Daten speichern, z.B. wenn es ein int ist gib die Adresse zur int variable ein
MPI_Scatter( void* send_data, int send_count, MPI_Datatype send_datatype, void* recv_data, int recv_count, MPI_Datatype recv_datatype, int root, MPI_Comm communicator)

MPI_Gather( void* send_data, int send_count, MPI_Datatype send_datatype, void* recv_data, int recv_count, MPI_Datatype recv_datatype, int root, MPI_Comm communicator)
```

#### Reduce
```c
int receiverRank = 0;
MPI_Reduce(&value, &total, 1, MPI_INT, MPI_SUM, receiverRank,MPI_COMM_WORLD)

// all nodes receive the final number, less efficient
MPI_Allreduce( void* send_data, void* recv_data, int count, MPI_Datatype datatype, MPI_Op op, MPI_Comm comm)

```
The reduction operations defined by MPI include
- MPI_MAX - Returns the maximum element.
- MPI_MIN - Returns the minimum element.
- MPI_SUM - Sums the elements.
- MPI_PROD - Multiplies all elements.
- MPI_LAND - Performs a logical and across the elements.
- MPI_LOR - Performs a logical or across the elements.
- MPI_BAND - Performs a bitwise and across the bits of the elements.
- MPI_BOR - Performs a bitwise or across the bits of the elements.
- MPI_MAXLOC - Returns the maximum value and the rank of the process that owns it.
- MPI_MINLOC - Returns the minimum value and the rank of the process that owns it

#### MPI-Datatypes

MPI Datatype | C Datatype
--- | ----
MPI_CHAR | signed char
MPI_SHORT | short
MPI_INT | int
MPI_LONG | long
MPI_LONG_LONG | long long
MPI_UNSIGNED | unsigned int
MPI_FLOAT | float
MPI_DOUBLE | double
