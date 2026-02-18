// Compiled with Typst 0.13.1
#import "../template_zusammenf.typ": *

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "DSy",
  fach-long: "Distributed Systems",
  semester: "FS25",
  language: "en",
  tableofcontents: (enabled: true, columns: 2, depth: 2),
)

// Document-specific settings
#set table(columns: (1fr, 1fr))
#show table: set par(justify: false, linebreaks: "optimized")


= What are Distributed Systems?
A distributed system in its simplest definition is a _group of computers_ working together as to
_appear as a single computer_ to the user.

== Categorization
- _Tightly coupled_ #hinweis[(The processing elements have access to a common memory)] vs.
  _loosely coupled_ #hinweis[(No shared memory)]
- _Homogeneous_ #hinweis[(all processors are of the same type)] vs.
  _heterogeneous_ #hinweis[(contains processors of different types, more common)]
- _Small-scale system_ #hinweis[(Web app + database on the same system)] vs.
  _large-scale system_ #hinweis[(with more than 2 machines)]
- _Decentralized_ #hinweis[(e.g. Blockchain, distributed in the technical sense, but not owned by one actor)] vs.
  _distributed_ #hinweis[(owned by one actor)]

=== CAP theorem
States that a distributed data store _cannot simultaneously be consistent, available and partition tolerant_.
- _#underline[C]onsistency:_ Every node has the same consistent state & data
- _#underline[A]vailability:_ Every non-failing node always returns a response
- _#underline[P]artition tolerant:_ The system continues to be consistent even when network partitions\
  #hinweis[(not all nodes reachable due to network outages)]

You can only have two.
Since _network partition_ needs to be a given with distributed system, you need to choose between availability and consistency.
Is a system _AP_ or _CP_?

- _Eventual Consistency:_ Consistency is eventually restored when the partition ends #hinweis[(e.g. DNS server)]
  #plus-list[
    + Explicitly allows data partitions on different nodes
    + Allows high availability and high performance, because nodes can confirm operations locally and
      don't need to wait for synchronization with other nodes.
    #v(-0.5em)
  ]
  #minus-list[
    + Developers need to account for partitions
  ]

- _Strong Consistency:_ Every node is consistent all the time, everything gets run as if it was only executed on one machine.
  #plus-list[
    + Easiest mental model
    #v(-0.5em)
  ]
  #minus-list[
    + Expensive in terms of performance and latency
    + Can hinder availability during network partitions
  ]

- _Casual Consistency:_ Mix of eventual and strong consistency. Guarantees that operations that depend on each other
  #hinweis[(reading and incrementing a value)] will be seen in the correct order, but independent operations can be seen
  in different orders.

The CAP theorem is often criticized for being _too simplistic_, as most of the time there isn't an "either-or"
between consistency and availability, there are many levels in between. But it offers a _good conceptual framing_.

=== Other Categorizations
There are more classifications.
- _Classifications based on architecture:_ Client-server, peer-to-peer #hinweis[(P2P)], hybrid and more
- _Classifications based on software architecture:_ Layered, object-based, microservices, event-based, data-centric
- _Classifications based on communication model:_ Synchronous or asynchronous
- _Other Classification:_ Degree of transparency #hinweis[(The degree to which the distribution is concealed from the user)],
  fault tolerance, scalability, degree of consistency, data replication #hinweis[(how and where data copies are stored)],
  data partitioning, heterogeneity.

#pagebreak()

There is _no universally applicable categorization_ of distributed systems.

#table(
  table.header(["Controlled" distributed systems], ["Fully" decentralized systems],),
  [1 responsible organization],
  [N responsible organizations],

  [low churn #hinweis[(low fluctuation of the participating nodes, planned)]],
  [high churn #hinweis[(high fluctuation)]],

  [*Examples:* Amazon DynamoDB, Client/server],
  [*Examples:* BitTorrent, Blockchain, E-Mail],

  [Secure environment #hinweis[(operator has control)]],
  [Hostile environment #hinweis[(some users are probably malicious)]],

  [High availability #hinweis[(predictable)]],
  [Unpredictable availability #hinweis[(depends on the behavior of many)]],

  [Can be homogeneous or heterogeneous],
  [Is heterogeneous],

  [*Mechanisms that work well:* Consistent hashing, master nodes, central coordinator],
  [*Mechanisms that work well:* Consistent hashing with distributed hash tables, flooding / broadcasting],

  [Network is under control or client/server -- no NAT issues],
  [NAT and direct connectivity is a huge problem because of different network environments],

  [
    *Consistency:* Leader election
    #hinweis[(leader is responsible for the sequence of state changes and must therefore always be available.)]
  ],
  [
    *Consistency:* Weak consistency #hinweis[(DHTs have little consistency over order)], Nakamoto consensus
    #hinweis[(proof of work)], proof of stake -- leader election, PBFT protocols
    #hinweis[(Practical Byzantine Fault Tolerance)]
  ],
  table.cell(
    colspan: 2,
    align: center,
    [
      *Replication principles:* More replicas: higher availability, higher reliability, higher performance,
      better scalability, but: requires maintaining consistency in replicas
    ],
  ),
  table.cell(colspan: 2, align: center, [*Transparency principles:* apply]),
)

== Transparency in distributed systems
Distributed systems should _hide_ their distributed nature.
- _Location transparency:_ Users should not be aware of physical location
- _Access transparency:_ Users should access resources in a single, uniform way
- _Migration/relocation transparency:_ Users should not be aware that resources have moved
- _Replication transparency:_ Users should not be aware about replicas, it should appear as a single resource
- _Concurrent transparency:_ Users should not be aware of other users
  #hinweis[(For concurrent access, users should not accidentally modify data of another user --
  it should seem as if everyone has exclusive access. Exceptions: Online Status on Messengers)]
- _Failure transparency:_ Users should not be aware of recovery mechanisms
- _Security transparency:_ Users should be minimally aware of security mechanisms #hinweis[(only e.g. login at the beginning)]

== Fallacies of distributed computing
- _The network is reliable:_ Submarine cables break a lot
- _Latency is zero:_ Ping to Australia is \~ 300ms
- _Bandwidth is infinite:_ 1 GBit/s means that 1TB needs 2h and 16minutes to transfer
- _The network is secure:_ Assume someone is listening.
- _Topology doesn't change:_ Request can take different route than reply
- _There is one administrator:_ Sometimes your route goes from one company to another rival company #hinweis[(UPC, Init7)]
- _Transport cost is zero:_ Someone builds and maintains the network
- _The network is homogeneous:_ From fiber to WiFi cable, server, desktop, mobile -- extremely heterogeneous

#pagebreak()

= Advantages of Distributed Systems
Distribution _adds complexity_ which should generally be _avoided_. But sometimes, it is necessary.
+ _Scaling_ #hinweis[(if one machine is not enough)]
+ _Location_ #hinweis[(to move closer to the user)]
+ _Fault-tolerance_ #hinweis[(Hardware will fail eventually)]

== Scaling
There are two different ways of scaling:

=== Vertical Scaling: Better Hardware
Vertical scaling is the process of _increasing the power of a single machine_ by buying better hardware
#hinweis[(Scale one machine up)].

#table(
  table.header([Advantages], [Disadvantages],),
  [
    #plus-list[
      + Lower cost with small scale
      + No adaption of software required
      + Less complexity
      + Faster machine for the same price as the machine from some years ago
    ]
  ],
  [
    #minus-list[
      + Higher cost with massive scale\
        #hinweis[(Slightly better hardware costs a lot more in the upper tiers)]
      + Hardware limits for scaling
      + Risk of hardware failure causing outage
      + More difficult to add fault-tolerance
    ]
  ],
)

==== Vertical Scaling Performance
#definition[
  *Moore's Law* is the observation that the number of transistors in an integrated circuit (IC) doubles about every two years
  #hinweis[(Other predictions: doubling chip performance every 18 months)].
]

Moore's law is based on observation of historical trends which cannot continue forever, because we are bound by the
size of atoms. It might be dead already in 2025.

#definition[
  *Nielsen's Law* states that high end Users' bandwidth grows by 50% per year.
  In other words, the amount of available bandwidth to individual users roughly doubles every 1.5 years.
]

The bandwidth grows slower than computer power because telecoms companies are conservative and most users are reluctant
to spend much money on bandwidth because current connections are fast enough for them.
Therefore, you should _optimize for bandwidth, not for CPU_.

#definition[
  *Kryder's Law* states that the density of information on hard drives doubles every 13 months
  or in other words increases by a factor of 1,000 every 10.5 years.
]

User behavior changed in the time of SSDs, _speed is more important_ than raw storage size.
Hardware today is already very fast. For small and simple applications, vertical scaling is the way to go.
There is also less demand for local storage due to cloud storage.

#definition[
  *Wirth's Law* states that software is getting slower more rapidly than hardware is becoming faster.
]

Software _complexity and resource demands_ grow faster than the hardware speed.
As a result, software often _feels slower_ despite running on much faster hardware.
_Example:_ Modern webpages often utilize more resources than the original DOOM from 1993.

==== Example: Let's Encrypt
Let's Encrypt, the service providing free TLS certificate for HTTPS connections _runs all requests against a single MariaDB
to minimize complexity_. Although some read operations are delegated to mirrors, write operations are executed by the main
database. After _upgrading their main server_, it runs at 25% CPU utilization compared to the previous 90%.

=== Horizontal Scaling: More machines
Horizontal Scaling is the process of _adding more machines_ to a resource pool in a system to distribute the workload
#hinweis[(Scale out to multiple machines)].

#table(
  table.header([Advantages], [Disadvantages]),
  [
    #plus-list[
      + Lower cost with massive scale
      + Easier to add fault-tolerance #hinweis[(e.g. no server failure)]
      + Higher availability
    ]
  ],
  [
    #minus-list[
      + Higher initial cost #hinweis[(due to initial synchronization effort)]
      + Adaption of software required #hinweis[(state synchronization)]
      + More complex system, more components involved
    ]
  ],
)

_Machine Learning_ at the moment uses _horizontal scaling_, because vertical scaling is not yet feasible due to
_hardware limitations_ #hinweis[(Mainboards don't support the amount of RAM needed in a single machine)].

== Location <location>
*Latency* is the time a signal needs to travel from source to destination and back, the _round-trip-time_ #hinweis[(RTT)].
Everything gets faster, but latency stays because nothing is faster than the speed of light #hinweis[($~300'000 "km/s"$)].

In a _perfect_, direct vacuum light tube to Sydney, the RTT would be:

$
  overbracket(16'540 "km", "distance")/underbracket(300'000 "km/s", "speed of light") #h(1em) dot overbracket(2, "both ways")
  = 0.110"s" = 110"ms"
$

In practice, it is more like $~298 "ms"$.

With _Starlink_, under perfect conditions, optimal location, no processing delay, no handoff between satellites,
the theoretical latency is around $7.3"ms"$. In practice, it is around $20-60"ms"$.

There are two main factors that reduce the speed from the calculated perfect time.
- _No direct path:_ The cables are not laid out in a straight line. The distance to Sydney via cable is around $24'000"km"$.
- _Signal is slower than speed of light:_ In fiber glass, the signals travel about $2\/3$ of the speed of light
  ($200’000"km/s"$).
- _Other reasons:_ Non-optimal routing, queuing delays, routing delays, traffic inspection, signal repeating and
  protocol overhead.

$
  overbracket(24'000 "km", "distance")/underbracket(200'000 "km/s", "speed of signal") dot overbracket(2, "both ways")
  = 0.240"s" = 240"ms" underbracket(+ ~50-60"ms", "other reasons for delay") = 298"ms"
$

=== Transmission Modes
#grid(
  [
    *Multimode fibers* transmit _multiple rays of light_ simultaneously.
    They are used to transmit data over _short to medium ranges_ and have a high bandwidth for short distances.
    Multimode fibers are _cheap and easy to install_ but _perform badly over long distances_.

    *Singlemode fibers* provide lower latency than multimode fibers because they have a _far smaller core size_.
    This _reduces signal loss_ by reducing bouncing of the signal. They are _more expensive_ than multimode fibers,
    but have a much _larger transmission distance_ #hinweis[(up to 100km without signal regeneration)].
    They are often used in undersea and data center communication and other _critical infrastructure_.
  ],
  image("img/dsy_01.png"),
)

*Hollow-Core fibers* combine _low latency_, _high bandwidth_ and _low loss_.
Light travels $50%$ faster than in solid core fibers because it travels through air instead of solid glass and
is guided and restricted by a reflective cladding.

*Copper* propagates _faster than fiber_, but not much. It is also _not usable_ over long distances.

*Satellites* have _direct connection_ and signal travels _almost at speed of light_.
But the distance is often bigger and _weather conditions_ affect the signal strength.
There is also _protocol overhead_, _network processing_, _encoding/decoding_ and _queuing_ which also add to the latency.
Geostationary satellites with a higher altitude than Starlink uses have a latency of about $477"ms"$.

*Wi-Fi* could _in theory have the lowest latency_ due to the same advantages of satellites.
But it also has a _lot of delays_: CSMA/CA #hinweis[(collision avoidance)], wait times before transmission,
acknowledgement packages, retransmissions, signal processing at receiver and transmitter, MAC layer procession,
protocol stack traversal, DCF backoff, channel busy waiting... In the end, it adds up to _additional $5"ms"$ of latency_.

#table(
  columns: (auto, auto, 1fr),
  align: (x, y) => if (x == 1 and y > 0) { right } else { auto },
  table.header([Media], [Velocity Factor], [Description]),
  [Vacuum], [$100%$], [Vacuum or free space],
  [Thick coaxial cable], [$77%$], [Originally used for ethernet, referred to as "thicknet"],
  [Optical fiber], [$67%$], [Silica waveguide used to transport optical energy],
  [Thin coaxial cable], [$65%$], [Referred to as ethernet "thinnet" or "cheapernet"],
  [Unshielded twisted pair], [$59%$], [Multipaired copper cabling used for LAN and telecom applications],
  [Microstrip], [$57%$], [PCB trace on FR4 dielectric, $mu r = 3.046$ #hinweis[(PCB = Printed Circuit Board)]],
  [Stripline], [$47%$], [PCB trace in FR4 dielectric, $mu r = 4.6$],
)

=== Importance of Latency
_If a website is slower, less people visit._ Google for example measured a $20%$ drop in traffic after the latency was
$500"ms"$ higher. In gaming, if a game lags $300"ms"$, it is unplayable.
Even a $50"ms"$ latency reduces the performance noticeably. Human reaction time is around 200ms.
Depending on the device, the time from the key press to display can be $70"ms"-150"ms"$.
Keyboards have a delay of $15-60"ms"$ due to key travel time and USB polling adding $~8"ms"$ #hinweis[(although gaming
keyboards can reach $1"ms"$ polling)]. A standard monitor with 60hz display rate also has a delay of $8"ms"$.
The input lag for tablet pens is around $20-80"ms"$. To reduce these factors, competitive gamers often use a low latency
keyboard and mouse and a monitor with 240hz.

=== Reducing Latency
With a distributed system, the latency can be reduced by _placing services closer to the users_.
This also _increases the bandwidth_ #hinweis[(local networks are often better developed)] and _improves reliability_ and
_availability_ #hinweis[(less hops)]. The downside is that data replication and caching are _more complicated_ to coordinate.

An example for this is _CDN_ #hinweis[(Content delivery network)]. Places your images, sites and scripts close to your users.

=== Bandwidth
Another important factor is bandwidth, or _how much data can be transmitted per second over a certain medium_.
The current world record belongs to an experimental fiber optic cable that can transmit $~23"Pb/s"$.
NASA also experimented with transmitting data via laser into space and reached $~200"Gb/s"$,
while Starlink can exchange $~100"Gb/s"$ between its satellites with multiroute.

#pagebreak()

== Fault Tolerance
Any hardware will crash eventually. Failures are not a question of "if", but "when".

=== Random Bit Flips
There are _random bit flips_ due to bad pin connections, incorrect RAM timings, clock issues, design flaws or cosmic rays
#hinweis[(A bit flip added 4096 votes to a candidate in a Belgian election. The candidate had more votes than were possible)].

_Influencing Factors_ are the _sensitivity_ of each transistor, _number_ of transistors on the microchip, _altitude_, ...
#hinweis[(The Cassini mars rover has 280 bitflips daily, during a solar proton storm even up to 890 on its 300MB TMR RAM)]

_Error-correcting code memory_ #hinweis[(ECC)] uses _TMR_ #hinweis[(Triple modular redundancy - every memory operation is
triple validated)] or _Hamming Code_ to detect or additionally correct bitflips.
Hamming Code can only correct one bitflip and detect two. If there are more, the error correction fails.
Bitflips are more likely than you may think: The Jaguar supercomputer with 360TB ECC RAM had a double bitflip every 24 hours
#hinweis[(can be detected, but not corrected)]. Uncorrected bitflips can lead to `SEGFAULT`s or even OS crashes.\
ECC is currently used mostly _for servers, not for customer products_, although the current DDR5 RAM standard has ECC built in.

HDDs can break and SSDs wear out with time. An SSD consists of _NAND cells_
#hinweis[(Flash memory that can store data without using power)] with a _limited lifetime_.
It has _spare_ NAND that are used when cells break.

There are different kinds of NAND-Types:

#table(
  columns: (auto,) + (1fr,) * 4,
  align: (x, y) => if (x > 0 and y > 0) { right } else { auto },
  table.header(
    [],
    [SLC #hinweis[(single level cell)]],
    [MLC #hinweis[(multi level cell)]],
    [TLC #hinweis[(triple level cell)]],
    [QLC #hinweis[(quad level cell)]],
  ),
  [*Bits per cell*], [$1$], [$2$], [$3$], [$4$],
  [*P/E-Cycles* #hinweis[(Program-Erase Cycles)]], [$100'000$], [$10'000$], [$3'000$], [$1'000$],
)

_SLC_ has the highest lifetime, but limited capacity and costs the most. It is therefore often used for _caching_
files / cells that are frequently accessed. Rarely used data should be stored on MLC/TLC/QLC drives for cost efficiency.

==== Wear Leveling
Distribute write and erase operations across all memory cells. This technique is used to prolong the life of memory.

==== Bitsquatting
Specific type of _DNS Hijacking._ If a user wants to visit `example.com` and a bitflip occurs, he might land on `uxample.com`.
Some malicious user could register a domain with a single bit error and hope that somebody lands on it by accident.

=== Network Outages
There is also always the possibility of network outages #hinweis[(i.e. damaged undersea cables or a ISP messing up BGP again)].
If your system is distributed, the likelihood of this affecting you strongly is much smaller.

=== Conclusion
It is not a question of "if" hardware will fail, but "when". Multiple machines provide _redundancy_.
When one machine fails, others can take over.
The _load_ can be _redistributed_ among the remaining machines and systems can _continue_ to function despite individual failures.

But distributed systems also _add complexity_, this strategy is therefore a _tradeoff_.
Use only when benefits outweigh the added complexity.

#pagebreak()

= Containers and VMs
#v(-0.75em)
== Virtual Machine
_Virtualization_ is the act of creating a virtual machine that _acts like a real computer_ with an operating system.

- _Host Machine:_ The machine the virtualization software runs on
- _Guest Machine:_ The virtual machine itself

==== Hypervisor
Software that runs the virtual machine. There are two types:
- _Type 1:_ bare-metal, hypervisor acts as the operating system running on the machine #hinweis[(e.g. Xen, Proxmox)]
- _Type 2:_ Hosted, the hypervisor runs as a regular program on an operating system #hinweis[(e.g. VirtualBox)]

On newer processors, unmodified OS can run as guests with virtualization extensions like Intel VT-X or AMD-V enabled.
If these are not present or disabled, a guest OS can be modified to communicate with the hypervisor instead of
the hardware directly; it runs _paravirtualized_. But _VMs should not access memory directly_, only through the hypervisor.
Otherwise this would be considered a sandbox escape, because the guest could modify unrelated files on the host.

The guest machine needs to have the _same architecture_ as the host, else an _emulator_ is needed
#hinweis[(i.e. game consoles or desktop OS for ARM/RISC-V processors)].
There are hardware-specific #hinweis[(Snes9x, Dolphin, PCSX2)] and generic emulators #hinweis[(QEMU)].

Virtual Machines can be _expensive_. New providers tend to be cheap at first, but become more expensive over time.
_Switching_ to a different provider can be very _complicated_.
This is why it is important to _compare_ all providers carefully before making a decision.

==== MicroVM
Alternative to normal VMs, purpose-built for _serverless workloads_. Since everything else is removed, this results in a
_lightweight_ virtual machine with near-instant startup times and low resource consumption. Examples are Firecracker or microvm.

==== Virtual Desktop Infrastructure (VDI)
VDI _provides virtual machines over the network_.
Users can access them from any endpoint and all processing is done on the server hosting the VDI.
The client only _sends input commands_ and receives the image of the virtual machine,
not unlike the terminal systems in the 1970ies.

=== Pricing types on cloud providers
- _On-Demand:_ Pay per machine, used network traffic and IP address. Billing is done per started hour of usage.
- _Reserved:_ Pay to use VM for a certain time frame #hinweis[(i.e. one year)]
- _Spot Instances:_ Runs on unused instances of the cloud provider.
  Cheaper than on-demand, but can be taken back by the provider if other customers need the capacity

Comparing different cloud providers is _difficult_, as they offer slightly different services.
It also may be difficult to move vendors if you depend heavily on the specific features a provider offers.

== Container
Containers are _isolated_ user-space instances.
The OS needs to provide support for them, because they share the kernel of the host provides resources -- there is no guest OS.

There are a lot of different container softwares. The most well known is Docker, but there are also others:
- _LXC:_ Lower abstraction level and direct use of Linux kernel features
- _systemd-nspawn:_ Part of the systemd project, minimalist container manager
- _Solaris Zones:_ Oracle/Sun-specific container technology
- _Linux-VServer:_ Kernel patch for Linux, older virtualization technology
- _OpenVz:_ Operating system-level virtualization, popular hosting tool
- _rkt:_ CoreOS developed alternative to Docker, focus on security
- _Podman:_ Has a daemon-less architecture and rootless containers. Since the aim of podman is to be a replacement for Docker,
  it is compatible with Docker compose files and uses similar workflows and commands.

There are also _application-level containers_ that sandbox on the application level.
These are often more geared towards graphical applications instead of the CLI/Service applications of container.
The most widely used is _Bubblewrap_, powering sandboxed _Flatpak_ applications on Linux.
Others are syd, Firejail, GVisor and minijail.

== Comparison
#image("img/dsy_02.png")

#table(
  table.header([Container], [Virtual Machine]),
  [
    #plus-list[
      + Reduced size of snapshots #hinweis[(2MB vs 45MB)]
      + Quicker spinning up of apps
      + Available memory is shared #hinweis[(efficient resource usage)]
      + Process-based isolation #hinweis[(share same kernel, reducing overhead)]
    ]
    #minus-list[
      + Available memory is shared\ #hinweis[(Containers can affect others with high RAM usage)]
      + Process-based isolation #hinweis[(less secure isolation than VMs)]
    ]

    *Use case:* complex application setup, with container less complex configuration
  ],
  [
    #plus-list[
      + App can access all OS resources
      + Live migrations #hinweis[(move VM to another host without interruption)]
      + Pre-allocates memory #hinweis[(offers planning security)]
      + Full isolation #hinweis[(better security)]
    ]
    #minus-list[
      + Pre-allocates memory #hinweis[(inefficient resource usage)]
      + Full isolation #hinweis[(more complex setup for certain scenarios)]
      + Relatively long startup time
    ]

    *Use case:* better hardware utilization / resource sharing
  ],
)

_Using both at the same time:_ Complete isolation in VMs, but still profit from the efficiency of containers.

#pagebreak()

= Docker
Docker is a _containerization platform_ which packages software into containers.
These _"images"_ can be viewed on Docker Hub.
The containers are _isolated_ from each other and communicate over well-defined channels.

The apps running inside the containers need to be compatible with the host OS.

*Docker Commands*
- _`docker run <image-name>`_ fetches the specified image from Docker Hub #hinweis[(container image repository)].
  If no version is provided, it uses the latest available version.
- _`docker save <image-name> -o image.tar`:_ Save image as a `tar` file
- _`tar xf image.tar`:_ Extract `tar`
- _`docker images`:_ See installed images
- _`docker rmi <image-name-or-id>`:_ Delete image
- _`docker ps -a`:_ List all running and exited docker Containers
- _`docker rm <container-name-or-id>`:_ Delete container
- _`docker build . -t <image-name>`:_ Create and build image on basis of `./dockerfile`
- _`docker system prune -a`:_ Remove everything
- _`docker exec -it <container-name-or-id> sh`:_ Run shell in container

Docker can also be used over a GUI like Docker Desktop.

== Underlying Components
Docker itself is built on preexisting Linux components, this is why Docker itself can be implemented in
just around 100 lines of Bash, as shown in the "Bocker" project.\
This chapter explains these concepts, but _Docker handles the configuration_ of these tools itself,
so you don't need to manually fiddle with them.

=== OverlayFS
OverlayFS is a virtual file system that combines multiple Linux mount points into one and creates a
_"Union Mount Point"_ to make it seem like contents from different file systems are actually in one directory.
It does this by _layering_ the file systems on top of each other.
OverlayFS is the basis for Dockers _container isolation_.

When working with it, the first layer is usually referred to as _"upper"_ and normally _writable_.
The next layer, referred to as _"lower"_ is _read-only_ most of the time #hinweis[(or another overlay)].
The _workdir_ is used to prepare files as they are switched between the layers.

#table(
  columns: (0.5fr, 0.5fr, 1fr),
  table.header([File access], [upper #hinweis[(writable)]], [lower #hinweis[(read-only)]]),
  [*Read file*], [Accessed first], [Accessed if file doesn't exist in upper],
  [*Write file*], [As normal], [Copy is created in the overlay and modified there],
  [*Delete file*], [As normal], [Marked as deleted in overlay, still exists in lower],
)

#grid(
  columns: (1.9fr, 1fr),
  [
    *Example:* The _lower directory_ can be _read-only_ or could be an overlay itself.
    The _upper directory_ is normally _writable_.
    The _workdir_ is used to prepare files as they are switched between the layers.

    ```sh
    cd /tmp
    mkdir lower upper workdir overlay
    sudo mount -t overlay -o \
    lowerdir=/tmp/lower, upperdir=/tmp/upper, \
    workdir=/tmp/workdir/ none /tmp/overlay
    # The source device is "none", because the FS doesn't
    # originate from a block device like /dev/sda
    ```
  ],
  image("img/dsy_06.jpg"),
)

=== Cgroups
Cgroups are _control groups_. They define limits, isolation, prioritization of CPU, memory, disk I/0, network.
They can be used for processes or for docker containers. Docker uses cgroups behind the scenes.
Windows and MacOS don't support cgroups, but Docker just uses a lightweight Linux VM to run its containers on these OS.

*Example:* Create a group to limit CPU usage to 20%.

#grid(
  columns: (1.6fr, 1fr),
  [
    ```sh
    # cgroups with regular processes
    sudo cgcreate -g cpu:red # Create group for CPU controller
    echo -n "20" > /sys/fs/cgroup/red/cpu.weight
    cgexec -g cpu:red bash # Start bash with group
    # In newly created bash shell
    taskset -0 sha256sum /dev/urandom # Runs on core 0
    ```
  ],
  [
    ```sh
    # cgroups with Docker
    docker run \
      --name="low prio" \
      --cpu-shares="20" \
      --cpuset-cpus="0" \
      alpine sha256sum /dev/urandom
    ```
  ],
)

If another group with 80% would be created and ran on the same core, the usage will be around the specified limit.

=== Linux Network Namespaces
Provides _isolation_ on the system resources associated with networking.
Docker uses it so each container can run its own network _without conflicts_.
Management works via the regular OS networking tools.
Network namespaces can _create virtual Ethernet connections_, _configure their networks_ and _run programs in isolated networks_.
Per default, Docker containers on the same network _can communicate_ with each other.
For communication _outside_ of the internal network, further configuration is required by setting up routes in the
hosts routing table and enabling NAT forwarding to the virtual address.

```sh
ip netns add testnet # Create new namespace
ip link add veth0 type veth peer name veth1 netns testnet # Create new adapter in NS & link them
ip addr add 10.1.1.1/24 dev veth0 # Set IP on host adapter
ip netns exec testnet ip addr add 10.1.1.2/24 dev veth1 # Set IP on guest adapter
ip link set dev veth0 up # Start host adapter
ip netns exec testnet ip link set dev veth1 up # Start guest adapter

echo 1 > /proc/sys/net/ipv4/ip_forward # Enable IPv4 forwarding on the host
ip netns exec testnet ip route add default via 10.1.1.1 dev veth1 # Create new route
iptables -t nat -A POSTROUTING -s 10.1.1.0/24 -o <real-network-dev> -j MASQUERADE # Setup NAT
ip netns exec testnet nc -l -p 8000 # Run netcat inside the namespace
```

*Hole punching*\
Hole punching is a technique for _establishing a direct connection_ between two parties in which one or both
are _behind firewalls_ or routers with _NAT_.

This is done by connecting to an _unrestricted rendezvous server_ which temporarily stores external and internal address
and port information for each client and relays that data to each of the clients, so they can establish a direct connection.
All further traffic can then be sent without the rendezvous server.

== Docker Concepts
#v(-0.5em)
=== Layers
A _new layer_ is added for _each instruction_ in the Dockerfile.
The layers are _cached_ and will not be recreated unless the input changes.
Usually when you create a new Docker image, you will start from a _base layer_ that provides the OS for your container,
like the `alpine` image and start creating new layers from there.

=== Dockerfile
#grid(
  columns: (1.5fr, 1fr),
  [
    Build your binary or create your own image with a _dockerfile_.\
    The most _basic workflow_ consists of...
    - picking a base image with _`FROM`_,
    - setting the working directory with _`WORKDIR`_,
    - using _`COPY`_ to copying your application and configurations to that working directory
    - setting the _`ENTRYPOINT`_ to start that application.
  ],
  [
    ```Dockerfile
    FROM alpine
    WORKDIR /scripts
    COPY hello.sh .
    ENTRYPOINT ["sh", "hello.sh"]
    ```
    *hello.sh*
    #v(-0.75em)
    ```sh
    #!/bin/sh
    echo "Hello"
    ```
  ],
)

You can also create _additional containers_ just for building the application you want to dockerize.
The Docker image can then be built with _`docker build`_ and ran with _`docker run`_. The images should be kept _small_.
You can use multi-stage builds #hinweis[(use `FROM` to split your dockerfile into different stages)] and then copy
the required files from one stage to the next. This fixes problems with Dockers aggressive caching.

=== Docker Compose
With a Docker Compose file, you can more easily _deploy multiple containers_
#hinweis[(i.e. your service, load balancer, DB etc.)].
You can specify the dockerfile(s) to be built and started and configure additional things like networking or
specify dependencies between containers #hinweis[(i.e. start backend only after DB is running)].
It is also possible to override settings from the dockerfiles.
The compose file is written in `yml` syntax and serves as _lightweight_ orchestration for Docker.

#grid(
  columns: (1.6fr, 1fr),
  [
    ```yml
    # docker-compose.yml
    services:
      server1: # The server container
        build: . # Dockerfile for server is in build directory
        ports:
          - "80:25565"

      client: # The client container
        image: alpine
        entrypoint: sh -c "echo hallo"
    ```
  ],
  [
    ```Dockerfile
    # Dockerfile - compile server
    FROM golang:alpine AS builder
    WORKDIR /build
    COPY server.go .
    RUN go build server.go
    # Run the compiled server
    FROM alpine
    WORKDIR /app
    COPY --from=builder /build/server .
    ENTRYPOINT ["./server"]
    ```
  ],
)

For _services_, it is often necessary to _allow certain ports to connect_ to your Docker container.
The allowed ports can be _different_ from _inside_ and _outside_ the container.
In the example above, the host can make a request to port 80 and the program in the container will receive it on port 25565.
Specifying ports like this is only necessary to either _avoid port conflicts_ on the host or for _outside connections_:
Containers in the same network can communicate among themselves over all ports by default
#hinweis[(The `client` container could directly send a request to port 25565 without this rule, but the host could not)].

== Security
- Keep images _small_ and _up to date_. This reduces attack surface.
- Use _tiny runtimes_ like alpine or even go distroless. Avoid big images like Ubuntu / Arch / Debian.
- _Check_ your image for _vulnerabilities_ #hinweis[(e.g. with `snyk` or `trivy`)]
- Do _not expose_ the Docker daemon socket even to the containers, as it allows wide reaching permissions
- _Set a user_, do not run as `root` #hinweis[(Reduces risk in case container is compromised)]
- _Limit capabilities_ #hinweis[(grant only specific capabilities needed by a container)]
- _Disable inter-container communication_ if not specifically required in production
- _Limit resources_ #hinweis[(memory, CPU, file descriptors, processes, restarts)]
- Set filesystem and volumes to _read-only_ #hinweis[(Limits malicious or accidental changes to critical files)]
- _Lint the Dockerfile_ at build time #hinweis[(i.e. with an IDE to check for insecure configurations)]
- Run Docker in _root-less mode_ #hinweis[(Podman is better at this)]

=== Logging
- Set the logging level to _at least INFO_ and set the log level per environment. #hinweis[(There is
    TRACE -- only use during development,
    DEBUG -- logs about anything that happens in the program,
    INFO -- log all actions that are user-driven or system specific,
    NOTICE -- should be used in production,
    WARN -- logs everything that could become an error,
    ERROR -- logs errors,
    FATAL -- doomsday)]
- Use _logging libraries_
- Use _meaningful_ messages
- Log in _JSON_ -- structured logging. Keep the log structure consistent. #hinweis[(allows automated analysis of logs)]
- Avoid logging _sensitive information_
- _Secret Management:_ Use SaaS solutions like GitHub Secrets or AWS Secrets.

== Debugging
- _What is my base image?_ Has consequences on resource usage and configuration.
  Larger base images are usually more convenient to configure, but have a larger attack surface
- _What is my C STD Library? _Tools compiled against `glibc` don't work on systems with only `musl` installed
- Alpine has _tools for debugging_ like the `busybox` or `toybox` tool suites
- _Remove everything_ and do a clean start with `docker system prune -a`
- _What is going on in my container?_ Connect to it with `docker exec -it <id> sh` or use `nc` to connect to ports
  or `wget` to request HTTP resources if your container serves those
- Try to _ping_ another container with `ping containername`
- _Is my service bound to `localhost`?_ Then it cannot be accessed outside Docker
  #hinweis[(check with `netstat -lnt` on the container)]
- Check _logfiles_ and `docker stats` #hinweis[(shows resource usage)]
- Is Docker application _Docker aware_?
  #hinweis[(Docker memory limits are not hard limits, if over limit, the application restarts)]
- To _reduce performance impacts_, use multi-stage dockerfiles and `.dockerignore` to exclude files not needed
  inside the container #hinweis[(i.e. `node_modules`)]

=== Pitfalls / Supply chain attacks
Docker uses _aggressive caching_, i.e. files downloaded with `wget` in Dockerfiles are cached.
Use links with _version numbers instead of `latest`_ #hinweis[(ie. https://example.com/package-1.2.0.zip)].
Even better: use the `ADD` keyword in your dockerfile to download resources instead of `wget`.

_Supply chain attacks happen often._ One of your dependencies could be modified to include malicious code.
Because of dependency hell, you could be affected without using a unsafe library directly yourself #hinweis[(nested dependencies)].
_Mitigation Strategies_ are dependency scanning tools, or not executing dependencies on your own machine but in a container.


= Monorepos / Polyrepos
_General Rules_ about Project Setup:

#grid(
  columns: (1fr, 2fr),
  gutter: 1.5em,
  [
    + Be consistent
    + Other projects always prefer other structures
  ],
  [
    3. A perfect structure does not exist
    + Try to follow best practices for your project, but deviate where it makes sense.
  ],
)

#table(
  columns: (1fr, 1.75fr, 2fr),
  table.header([Monolith], [Polyrepo], [Monorepo]),
  [
    Only one code base which is managed by only one Git repo.

    #plus-list[
      + Easy to handle
    ]
    #minus-list[
      + Bad usability in big projects
    ]
  ],
  [
    Multiple repositories for a project. Sync via git submodules or via bash script. Also called manyrepo or multirepo.
    Creates loose coupling of projects.

    #plus-list[
      + Flexible, scalable, reliable, loose coupling, fine grained access control
      + Encourages code sharing across organizations
    ]
    #minus-list[
      + Hard to share resources
      + Complex to work with
    ]
  ],
  [
    One repository to rule them all. 1 sub-directory with frontend, 1 sub-directory with backend.
    Creates tight coupling of projects.

    #plus-list[
      + easy to share resources, common dependencies only need to be installed once, independent and flexible
      + Encourages code sharing within organization
    ]
    #minus-list[
      + slow to pull, tight coupling, hard to grant limited access
    ]
  ],
)

#align(center, image("img/dsy_03.png", width: 46%))

In bigger projects, _split up_ backend and frontend into separate repositories. In smaller projects, use a monorepo.


= Load Balancing
#grid(
  columns: (2fr, 1fr),
  [
    A load balancer _distributes workloads_ #hinweis[(requests)] across _multiple computing resources_ #hinweis[(machines)].
    This is an example of _horizontal scaling_.
    It ensures high _availability_ and _reliability_ by sending requests only to servers that are online.
    It also _provides the flexibility_ to add or subtract servers as demand dictates.
  ],
  [
    #v(-1em)
    #image("img/dsy_04.png")
  ],
)

There are three types of load balancers:
- _Hardware load balancer:_ A metal box with specialized processors and often uses proprietary software.
  This is less generic, but has better performance. Only usable if you control your own datacenter
  #hinweis[(Examples: loadbalancer.org, Cisco)].
- _Software load balancer:_  There are different load balancers that function on different levels of the OSI model.
  Seesaw runs on Layer 2/3 #hinweis[(data link / network layer)] , LoadMaster, HAProxy, ZEVENET, Neutrino, Nginx, Gobetween
  and Traefik run on Layer 4 #hinweis[(transport layer)] and Layer 7 #hinweis[(application layer)].
- _Cloud-based load balancers:_ Pay for use. They often also provide predictive analytics and depending on the product
  also operate on different OSI layers #hinweis[(Examples are AWS, Google Cloud, Cloudflare, DigitalOcean and Azure)]

A layer 7 load balancer is _more resource intensive_ than a layer 4 because they need to terminate HTTP and TLS,
analyze the packets and then create new connections to the destination based on the packets data.

== Software based load balancing
#v(-0.5em)
=== Load Balancing Algorithms
- _Round robin:_ Distribute all available server addresses equally by looping sequentially.
  This is a very simple algorithm, often the default. It might drop requests on congested nodes
  #hinweis[(use only with stateless services)].
- _Weighted round robin:_ More powerful machines get more work. But high variance in server load may drop requests.
- _Least connections:_ The machine with the fewest requests gets the new request. Needs to keep track of outstanding requests.
  Not the best for latency.
- _Peak exponentially weighted moving average:_ Considers latency, complexity increases.
- _Others:_ ip_hash, least_time, random, uri_hash, cookie

*Stateless and Stateful*\
_Don't store_ anything in the service that can only be accessed on that server -- this is a stateful service.
If you do, you need a _sticky session_ that always sends a user to the same machine.
Makes fault tolerance more complex and it makes scaling near impossible.

If you have to store something about the user #hinweis[(i.e. contents of shopping basket)],
either store it in a database accessible from every service or store the information on the user-side via cookie or similar.
The user then has to provide that cookie with every request.
This service is _stateless_ because the service itself does not store that information and the user can request the same
information from every other instance of that service.

*Health Check*\
Tell your load balancer if you are running low on resources. There are two methods to do this:
- _Active Health Check:_ Sending _active probes_ #hinweis[(e.g. request status every 3s)].
  This method is also called _inline_ or _out-of-band_ (OOB) because it uses a different API to verify the status.
  Can be used to get more information about a service #hinweis[(i.e. connection to DB may be okay, but the state isn't)].

- _Passive Health Check:_ Each sent request gets examined if a server is still alive.
  The disadvantages of passive checks are that there are only checks when a request happens and there is no option to get
  more information about a service like with active checks.\
  There are two subtypes of passive health checks:
  - The server_ caches the request_ and _sends it to another server_ if it fails #hinweis[(default of Nginx)]
  - The server _doesn't cache_ the request and _sends an error_ to the user #hinweis[(default of Caddy)]

=== DNS Load balancing
DNS Load balancing runs on Layer 7. Has different modes of balancing:
- _Round Robin:_ On the DNS, a domain name is mapped to multiple IP addresses. On a request, the DNS returns all of these
  and the client can pick one of them. Basic & simple load balancing, but IPs are static, client can choose suboptimal address,
  and updating IPs can be slow due to caching.
- _Split Horizon DNS:_ Provide different sets of DNS information selected by the source address of the DNS request
  #hinweis[(i.e. a European server for Swiss IP address)].

Very easy to setup. Caching with no fast changes. Requires stateless services.
Offers reduced downtime, scalability and redundancy, but has a negative caching impact.

=== Layer 3 Load balancing
Via Anycast, returns IP address with the _lowest latency_.
You need your own AS #hinweis[(Autonomous System)] for that, this is _difficult_ and time consuming.
Usually only used on the ISP or _big datacenter level_.

== Traefik
Traefik is a layer 4 & 7 load balancer.
It works by defining _entrypoints_ #hinweis[(i.e. all incoming traffic on a specific port)] that correspond to _routers_
that can filter traffic based on path prefixes #hinweis[(i.e. a router that handles all requests to `/api`)].
The routers then forward traffic to _services_ defined inside Traefik #hinweis[(i.e. frontend, backend, DB...)]
which then distribute it to the machines registered for that service.

Configuration can be done via TOML files for Traefik or directly inside a Docker compose with labels\
#hinweis[(i.e. ```yml labels: - traefik.http.routers.dashboard.rule=PathPrefix('/dashboard')```)]

#table(
  columns: (auto,) + (1fr,) * 3,
  table.header([], [Traefik], [Caddy], [Nginx]),
  [*Description*],
  [Open source, software based load balancer with dashboard],
  [Open source, software based reverse proxy with dynamic configuration],
  [Has a free and a commercial version, very versatile],

  [*Initial setup effort*], [easy], [difficult], [medium],
  [*Proxy setup effort*], [easy], [medium-difficult], [difficult],
  [*Overall simplicity*], [easy], [difficult], [difficult],
)


= Web Architecture
#v(-0.5em)
== Server-side rendering (SSR)
"Classic" approach: the server generates HTML/JS/CSS _dynamically_ and sends the assets in real-time to the browser.
Works with these steps:
+ _User request:_ Browser sends a request to the web server #hinweis[(server-side routing)].
+ _Server processing:_ Server processes request by running server-side code like PHP, C\# or Java,
  fetch required data from a database or other resources and generates HTML #hinweis[(i.e. via a HTML template engine)].
+ _Response:_ Generate the appropriate HTML, CSS and JS for the requested page.
  The browser receives the response and renders the page.

_Advantage:_ Search engine web crawlers receive the full page, which leads to better SEO, but needs server rendering
for every request.

== Static site generation (SSG)
HTML/CSS/JS is _pre-rendered_ since it is the same for every user. Done only once, respectively only if the content changes.
Can also include _DB access_.

*Example:* Page content is written in Markdown and gets converted to HTML when the Markdown file changes.

== Single page application (SPA)
Also called _client site rendering_ #hinweis[(CSR)].
Interactions occur within a single web page, there is no visible "page change" like on regular websites.
Client page _dynamically updates_ as the user interacts with it, providing a smooth, _app-like experience_.
Relies on _JavaScript_ to update the UI.

*Steps to render a page:*
+ _Initial request:_ Browser sends a request to receive initial HTML/CSS/JS
+ _Initial response:_ server returns a single #hinweis[(placeholder)] HTML file with CSS and JS.
  JS files contain the applications logic.
+ _Browser rendering:_ Shows HTML file, typically a spinner #hinweis[(loading animation)], then executes JavaScript.
+ _User Interactions:_ JS manages the UI updates. Application does not require full page reloads.
  When you click a link in an SPA, instead of making a traditional HTTP request:
  + The JS intercepts the click event
  + Prevents the default browser navigation
  + Updates the URL using the History API
  + Renders new content without requesting new HTML documents
+ _API communication:_ When the SPA needs to send or fetch data, it does this by communicates through APIs.

This can be done by using a framework like React, Angular or Vue.
_SEO_ only works if JS is executed at the search engine's crawler. Has _good separation:_ UI in HTML/CSS/JS, backend in `/api`.
The navigation is done via _client-side-routing_ without intervention of the server.
Requests directly to the server usually get redirected to the default `index.html` that contains the
client-side-routing information.

== Hydration
"State-of-the-art". Initial HTML not with a "spinner", but already has the first content in HTML like with SSR,
and further access with API like with SPA. Essentially a _combination of SSR & SPA_.

This is _best of both worlds_, but _adds complexity_ and needs JavaScript in the backend.

== Web rendering overview
#image("img/dsy_05.png")

== CORS
CORS stands for _Cross-Origin Resource Sharing_.
For security reasons, browsers _restrict_ cross-origin HTTP requests #hinweis[(Requests to resources not on the same domain,
port or scheme)] initiated from scripts #hinweis[(i.e. JS)].
CORS is a HTTP header based mechanism to indicate browsers from which other origins the site is allowed to load assets from.

*Solution* \
Use _reverse proxy_ with built-in webserver, e.g. nginx or user reverse proxy with external webserver.
The client only sees the same origin for the API and the frontend assets.
Alternatively, CORS header can be set to specify which domains can be fetched from

```js
w.Header().Set("Access-Control-Allow-Origin", "https://lost.university");
w.Header().Set("Access-Control-Allow-Origin", "*"); // use only for dev
```

CORS can also cause problems with _Preflight Requests:_ When connecting to a new domain, browsers often perform a
preflight request with a HTTP `OPTION` request with headers that indicate what kind of request it is about to make
to verify if the server will respond successfully.
Single Page Applications need to be correctly configured to handle preflight requests to work correctly.
A reverse proxy avoids the need to do this, as preflight requests will only be sent on new domains.


= Authentication
#v(-0.75em)
== Key Concepts
==== CIA Triad
The CIA triad is a trade-off between three concepts. You can't achieve all three simultaneously:
- _Confidentiality:_ Confidentiality protects transmitted data against eavesdroppers #hinweis[(Through encryption)]
- _Integrity:_ Provides protection against the modification of a message #hinweis[(Through hashing or digital signatures)]
- _Availability:_ Data needs to be available when needed #hinweis[(Through redundancy, load distribution)]

==== Goals of access control
- _Non-Repudiation:_ Provides that neither the sender nor the receiver can deny that a communication has taken place
- _Identification:_ E.g. with a username "alice", you are claiming to be Alice
- _Authentication:_ Verifying a claim of identity. E.g. Alice shows passport, so another person can authenticate her
  Different authentication types are:
  - _Something you know:_ Things such as a PIN or a password
  - _Something you have:_ A key or a swipe card
  - _Something you are:_ Biometrics like palm or fingerprint
- _Authorization:_ Determines which resources an authenticated user is permitted to access

=== Authentication Basics
Can be split into two different categories:
- _Single-factor_ #hinweis[(only uses one type of authentication, usually password. Simple to implement, but limited protection)]
- _Multi-factor (2FA)_ #hinweis[(uses multiple factors, usually password & one-time-pin. Token via SMS are considered insecure)]

When choosing a password, it should _not contain the following_: Names of persons #hinweis[(or pets)] close to you,
anniversary or birth dates, name of a favorite holiday, favorite sports team or the word password.
But it is better anyway if you use a _password manager_ and generate a password that way, which also solves the problem of
password reuse. In general, the length of the password matters most: The _longer_ it is, the longer it takes to crack it.
You also should not enter login credentials on unencrypted websites #hinweis[(HTTP-only)].

Passwords on a web service should be _stored in encrypted form_.
To prevent the creation of _rainbow tables_ #hinweis[(pre-calculated tables that map hashes to the plaintext passwords,
because identical passwords lead to identical hashes)], a _salt_ should be applied to the password.
A salt is a _random value_ for each user that gets added to the password before it is hashed.

#pagebreak()

There are multiple hash algorithms that are recommended for passwords:
- _Argon2id_: Most current algorithm, recommended, prevents brute-force attacks with CPU and time-based side channel attacks.
- _scrypt:_ Memory intense, designed to slow down hardware attacks by utilizing big amounts of memory
- _bcrypt:_ Older, but still considered secure. Relatively slow, which slows down brute force attacks.
  Scales good with better hardware
- _PBKDF2:_ Older, but still considered secure. Less protections against hardware attacks

Argon2id, scrypt and bcrypt utilize _salts_ by default.
Slow algorithms are better, because attackers cannot test as many passwords in a short time frame.
With the newer algorithms, the time it takes to hash a password can be set.
Even if it is just a few milliseconds, it will slow down attackers massively.

=== Software Token: Time-based One-time password (TOTP)
Often used as a second factor, based on hash-based message authentication code #hinweis[(HMAC)].
Authentication should happen either in a service, e.g. in your HTTP server
#hinweis[(Fine-grained per-service access, but with a lot of redundancy)] or in the load balancer, e.g. traefik
#hinweis[(central authentication, easier)].

#definition[
  #grid(
    columns: (1.5fr, 1fr),
    align: horizon,
    [
      $ "TOTP"(K, T) = overbracket("Truncate", "first 6 chars")("HMAC-SHA-256"(K , T)) $
    ],
    [
      $K$: shared secret\
      $T$: current Unix timestamp / 30 sec
    ],
  )
]

The server _generates a key_ that is usually presented to the user as a _QR code or a link_
#hinweis[(which can contain additional metadata)]. The user then _inputs the key_ into their authenticator and now
both the server and authenticator can _generate the same token at the same time_.
After entering the password and the current TOTP token, the server also generates the same token and compares the two.
If they match, _access is granted_.
Because of _timing deviations_, a server may also accept a token from the next or previous time window.

== Basic Auth
Basic auth transmits the credentials in the `Authorization` HTTP header with base64 encoding.
- On an unauthenticated request, the _server will reply with the header:_` WWW-Authenticate: Basic realm=` `"restricted area"`.
  The browser will display a authentication dialog together with the `realm` information to indicate what area the user
  is logging into.
- The _client will provide the authorization_ by setting the `Authorization: Basic <base64>` HTTP header.
  `<base64>` contains `username:password` in base64 encoding. The credentials could also be _encoded in URL_
  #hinweis[(e.g. https://username:password@dsl.i.ost.ch)]. This can be a security risk if the URL gets saved or passed on.

Does _not provide encryption for credentials_, only formatting for HTTP Header.
Should _only be used with HTTPS_, otherwise login credentials are transmitted in the open.
State would need to be managed by the services #hinweis[(i.e. with a list of users)]. Very easy to implement in a load balancer.

_Suboptimal when logging off: _There is no standardization, the client must enter incorrect login data in order to
receive a new authentication request, resulting in inconsistent behavior.

== Digest Auth
A little better than basic auth. Has a hash and a nonce which helps against replay attacks.
+ Client sends _request_
+ Server sends a 401 with HTTP header `WWW-Authenticate: Digest` that contains a _nonce_
+ Client _sends response:_
  `Authorization: Digest username="Alice", realm="testrealm@host.com", nonce="...", uri="../index.html", ... , response="..."`.
  The response is a hash which is calculated from the password amongst other things.
+ Server _calculates hash_ as well
+ If the hashes match, the user gets _access_

#pagebreak()

*Advantages:*\
Password is _not sent in clear text_ and gets _only used once_ for the calculation of the response.
Multiple encryption algorithms are available, with _`sess` variants_ that support session keys, where the _nonce changes_
with every new session. If a hash gets compromised, the attacker can only use it while the session is valid.

*Disadvantages:*\
Uses the _UX of the browser_ and _cannot use scrypt or bcrypt_ to store passwords.

== Public / Private Key Auth
The _client provides a certificate_ signed by the server to authenticate. Usually used between load balancer and services.
Better than Digest Auth.
+ _Generate a SSL CA_ #hinweis[(Certificate Authority)] on the server and configure proxy or service to require
  a client certificate
+ _Create CSR_ #hinweis[(certificate signing request)], sign with CA and install certificate on client in browser
+ The browser sends the signed certificate to the server when prompted

== Let's Encrypt
_Free, automated, open certification authority._ Has automated certificate creation and renewal.
Certificates are valid for 90 days. It is integrated in modern web servers.\
There are two main ways to get a certificate from Let's Encrypt:
#table(
  columns: (1fr, 1fr),
  table.header([HTTP challenge verification], [DNS challenge verification]),
  [
    - Server must be _publicly accessible_ #hinweis[(no VPN or internal-only)]
    - A _token_ generated by Let's Encrypt is placed under \ `/.well-known/acme-challenge/`
    - Let's Encrypt verifies the token _via HTTP request_
  ],
  [
    - Server does _not have to be publicly accessible_
    - Enables _wildcard certificates_ #hinweis[(\*.ost.ch)]
    - Token is placed as a _TXT entry in DNS_
    - Let's Encrypt _checks the DNS entry_
  ],
)

== Session-based Authentication
After a _successful login_, the server creates a session and sends the user a _session ID_ to authenticate with.
Usually stored in a Cookie. _Stateful, needs sticky session_ because authentication is done in the service which
then has an authenticated session for the client -- meaning when accessing another service
#hinweis[(or the load balancer selects another server)], _re-authentication_ is required.
The load balancer avoids this with a _sticky session_: Sending the same user to the same service every time.
Example for this is spring-boot.

== JSON Web Token (JWT)
_Stateless_, all server instances know a secret token / public key. When the user _logs in_, the server sends back a token.
The User Token gets saved in local storage. The client then sends the `Authorization: Bearer <token>` header with every request
to authenticate.

#grid(
  columns: (1.3fr, 1fr),
  [
    A JWT consists of _three parts_:
    - _Header:_ Contains token type #hinweis[(`typ`)], encryption algorithm #hinweis[(`alg`)]
    - _Payload:_ Usual fields are subject #hinweis[(`sub`)], user role #hinweis[(`role`)],
      issued at in Unix time #hinweis[(`iat`)], token expiry date in Unix time #hinweis[(`exp`)]. Can also contain custom fields
    - _Signature:_ generated from the header and payload together with a secret

    To generate a JWT, these three parts are _individually encoded with Base64Url_
    #hinweis[(a modification of Base64 that replaces all special URL characters)] and concatenated with dots,
    so they can be easily processed. JWTs can also contain _sensitive/private information_, due to only the server
    holding the decryption keys #hinweis[(Server can detect user modification of the JWT)].
    Can be useful to avoid looking up user related information in the database.
  ],
  [
    #small[
      ```json
      { // Header
        "alg": "HS256",
        "typ": "JWT"
      }
      { // Payload
        "sub": "133769420",
        "name": "Nina",
        "role": "admin",
        "iat": 1750239022,
        "exp": 1800000000
      }
      ```
    ]

    *Secret for the Signature:*\
    #small[`a-string-secret-at-least-256-bits-long`]

    *Generated JWT Token:*
    #v(-0.5em)
    #small[
      ```
      eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.
      eyJzdWIiOiIxMzM3Njk0MjAiLCJuYW1lIjoiTmluYSIsInJvbGUiOiJ
      hZG1pbiIsImlhdCI6MTUxNjIzOTAyMiwiZXhwIjoxODAwMDAwMDAwfQ.
      nSL0D5Dm4j5wTYYA7wq19kxX7rNKKUzHM9v981u68qg
      ```
    ]
  ],
)


== OAuth
#grid(
  [
    Protocol for authorization of 3rd party integration. Grant access on other websites without giving them the passwords.
    Often implemented with JWT.

    _Access Tokens_ should only have a _short lifetime_ #hinweis[(e.g. 5 minutes)].
    If the public key / secret is known, the content in the token can be trusted.

    _Refresh Token_ can have a _longer lifetime_ #hinweis[(e.g. 6 months)]. A refresh token is used to get a new access token.
    IAM service #hinweis[(Identity & Access management)] or a Auth server creates access tokens.
  ],
  image("img/dsy_07.png"),
)

*Why are both access and refresh token needed?*
- _Only access token:_ If a user credential is revoked, how can every service be informed?
- _Only refresh token:_ Tightly coupled service & auth: For every request to the service auth needs to be involved
- _Access + Refresh token:_ If a user credential is revoked, user has a maximum of 10 minutes remaining to access the service.
  The Auth is only involved if access token is expired -- a pragmatic middle way.


= Protocols
#v(-0.5em)
== Layer abstraction
#table(
  columns: (auto, auto, 1fr, auto),
  table.header([Internet Model], [OSI Model], [Description], [Header]),
  table.cell(rowspan: 3, [Application]),
  [Application],
  [Provides the _interface between applications_ used to communicate and the underlying network.],
  [`Data`],

  [Presentation], [Formats, compresses and encrypts data], [`Data`],

  [Session], [Handles the _exchange of information_, restarts sessions], [`Data`],

  [Transport], [Transport], [Logical _end-to-end connection_. #hinweis[Ports]], [`TCP Header, Data`],

  [Internet],
  [Network],
  [Responsible for _delivering the IP packets_ from source to destination. #hinweis[IP addresses]],
  [`IP Header,` \ `TCP Header, Data`],

  [Link\ #comment[#sym.space #sym.triangle.filled.t #v(-1.3em) #h(0.07em)#sym.triangle.filled.t #sym.triangle.filled.t]],
  [Data link],
  [Responsible for _delivering data link frames_ on the same network. Error detection mechanisms. #hinweis[MAC Addresses]],
  [`Ethernet Header, ` \ `IP Header,` \ `TCP Header, Data`],

  [--], [Physical], [The medium the data travels through #hinweis[(copper, fibre, air...)]], [--],
)

Historically, every vendor had its own non-cross-compatible networking solution.
The goal of the OSI layer definition is _interoperability_.
There are a lot of different designations for the layers, everyone calls stuff differently.

_Important to know:_ Each layer takes on a _specific part_ of the communication task and communicates with
the _corresponding layer_ on the other side. This means that the layers are modular and protocols can be replaced.

Protocols enable an entity/instance to interact with an entity/instance at the same layer in another host.
Layers don't need to worry about the ones below it, as that has already been taken care of.
_Service definitions:_ provide functionality to an ($N$)-layer by an ($N-1$)-layer
#hinweis[(every layer offers a specific service to the layer above it)].

Each _Protocol Data Unit_ #hinweis[(PDU)] contains a protocol header and a payload, the _Service Data Unit_ #hinweis[(SDU)].

*Advantage of the layer model* \
Individual layers can be _exchanged_ without changing other layers.

== TCP
#grid(
  align: horizon,
  [
    TCP #hinweis[(Transmission Control Protocol)] allows applications to send data _reliably_ without worrying about
    network layer issues.
    - Reliable
    - Packets arrive in the order they have been sent
    - The window is the capacity of receiver\
      #hinweis[(transmitter adapts to sender)]
    - Checksum: 16 bits
    - TCP Overhead: 20 bytes

    TCP tries to _correct errors_: If a packet is missing or corrupt, it initializes a retransmission of that packet.
  ],
  image("img/dsy_08.png"),
)

#grid(
  align: bottom,
  [
    The connection establishment is done over a _three-way handshake_. Two things need to be exchanged:
    The initial sequence numbers (ISN) and exchange parameters.
    TCP needs 3 handshakes to establish the connection.
    - The client sends a _`SYN`_ message with a sequence number
    - The server replies with an _`SYN/ACK`_ message. The SYN contains a differing sequence number than the client.
    - The client responds with an _`ACK`_ message
  ],
  image("img/dsy_09.png"),
)

- *Initialization of TCP session:* _`SYN, SYN-ACK, ACK`_ #hinweis[(left image)]\
  The initial sequence number is more or less random to prevent TCP Sequence Prediction Attacks.
- *Connection Termination* _`FIN, ACK + FIN, ACK`_  #hinweis[(right image)]\
  3 or 4-way. Prevents semi-open connections where one side thinks the connection is still open and keeps transmitting data.

*Sequences and ACKs*\
Identification of each byte of data. The order of bytes can be reconstructed. There are two main ways to _detect lost data_:
- _RTO_ #hinweis[(Retransmission Timeout)]: Normally set to twice the measured roundtrip time.
  If a packet has not been acknowledged by then, it is resent
- _DupACK_ #hinweis[(Duplicate ACK)]: A duplicate acknowledgment is sent when a receiver receives out-of-order packets.
  After 3 ACKs, the sender retransmits the missing packages

=== TCP window size adjustment and flow control
When the server receives data from the client, it places it into the _buffer_.
The server must then do two things with this data:

+ _Acknowledgment:_ The server must send an ACK back to the client to indicate that the data was received.
+ _Transfer:_ The server must process the data, transferring it to the destination application process.

In the basic _sliding window system_, data is acknowledged when received, but _not necessarily immediately
transferred out of the buffer_. It is possible for the buffer _to fill up with received data faster than the receiving TCP
can empty it_. When this occurs, the receiving device may need to _adjust the window size_ to prevent the buffer from
being overloaded. A device that reduces its receive window to zero is said to have _closed the window_.

#pagebreak()

=== TCP Congestion handling and congestion avoidance algorithms
When _congestion increases_ on the network, _segments would be delayed_ or dropped, which would cause them to be retransmitted.
This would _increase the amount of traffic_ on the network between client and server.

#grid(
  columns: (1.3fr, 1fr),
  [
    This can lead to a _vicious circle_, resulting in a condition called _congestion collapse_.
    Because of this, the TCP slow start and congestion avoidance states are needed.

    - _Slow Start:_ Slow start state is entered at the beginning of the connection or after timeout.
      Congestion window #hinweis[(`cwnd`)] starts with initial `cwnd` size and increases by one or more MSS
      #hinweis[(Maximum segment size)] for each ACK received.

    - _Congestion avoidance:_ Congestion avoidance state is entered when `cwnd` reaches slow start threshold
      #hinweis[(ssthresh)]. `cwnd` increases by one MSS for each RTT #hinweis[(if no duplicate ACK arrives)]

    There are _different algorithms_ for congestion control.
  ],
  image("img/dsy_10.png"),
)

*Difference Flow Control/Congestion Control:*\
Flow Control manages the capacity of a single client, Congestion Control of the entire network.

=== TCP Considerations
The TCP handshake is _not_ flexible: You need 1 roundtrip for the TCP handshake.
It only ensures that both sides are ready to transmit data and nothing else.
There is _no mechanism to cannot exchange public / private keys via TCP_, you need another security layer for the exchange,
but this _adds at least another roundtrip_.
Additional roundtrips for DNS or old security protocols may be necessary. There is a _big overhead_.

== Transport Layer Security (TLS)
Security and encryption for most applications #hinweis[(i.e. HTTPS)] is provided by TLS.
It runs after the initial TCP handshake.

*TLS session establishment*
+ _"client hello"_ lists cryptographic information, TLS version and supported ciphers/keys by the client
+ _"server hello"_ sends chosen cipher, session ID, random bytes, digital certificate #hinweis[(gets verified by client)]
  and optionally a "client certificate request" #hinweis[(Client is required to send their own certificate for authentication)]
+ _key exchange_ using random bytes sent by server, now server and client can calculate the secret key
+ _"finished" message_, encrypted with the secret key

This process needs 3 RTTs to send first byte #hinweis[(1x TCP handshake, 2x TLS handshake)] and 4RTTs to receive the first
data byte. When connecting to Australia, 3 RTTs mean a latency of \~900ms.

To decrease the amounts of RTTs, _TLS 1.3_ was released in 2018. It _decreases_ the TLS RTTs from 2 to 1.
+ Together with the "Client Hello", a _"key share"_ is sent. It assumes the cipher the server is going to pick.
+ "_Server Hello"_, server _key share_, certificate verification and the _"finish"_ are also condensed into one message.

On reconnect, even _0 RTTs_ are possible if the cryptographic data is already known.

== QUIC and HTTP/3 <quic-http3>
QUIC #hinweis[(Quick UDP Internet Connections)] was developed by Google and was adopted as the basis of the HTTP/3 standard.
QUIC _only requires one handshake_ for the _connection_ and _security setup_. Known connections can also be resumed with _0 RTTs_.
QUIC is based on _UDP_ and implements _TCP-like reliability mechanisms_ itself, but remains _more flexible & efficient_
than those. QUIC has encryption already built-in, there is _no un-encrypted_ variant of it #hinweis[(unlike HTTP/2)].

Some devices that perform NAT can have _problems with assessing the status of HTTP/3 connections_.
Because the connection handshake packets containing `SYN`, `ACK` & `FIN` are already encrypted, these devices don't know when a
connection ends, leading to the need to _keep these entries in the routing table for longer_ and thus _higher resource usage_.
HTTP/3 also offers _HTTP header compression_ and can reference previously transmitted headers, leading to _greater complexity_
in implementations.

=== Multiplexing & Head-of-line blocking
_Multiplexing_ was already introduced in HTTP/2. It allows to _fetch multiple resources_ from a server with only
_one TCP connection_ instead of creating a new connection for every resource #hinweis[(reduces number of required handshakes)].

But in HTTP/2, multiplexing has a problem called _head-of-line blocking:_ TCP guarantees the order of all packages.
If a packet gets dropped, it can impact all other resources in that connection.
+ Client _requests resources_ $A$ and $B$ in a _multiplexed connection_.
+ Server sends $A$ and $B$, but one packet containing part of resource $B$ _gets lost_
+ Due to the _ordering guarantee_, the TCP stack on the client _can't deliver resource $A$_, even though it has been
  fully transmitted. Only when the missing packet from $B$ has been received, both resources can be processed further.

QUIC solves this by introducing _streams_. Every requests gets its own stream.
A _packet loss in one stream doesn't impact all other streams_ in the same connection.

== UDP
#grid(
  columns: (1.1fr, 1fr),
  [
    UDP #hinweis[(User Datagram Protocol)] is a _simple connection-less communication model_ without any guarantees regarding
    _delivery_ #hinweis[(you don't know if package has been received)], _ordering_ #hinweis[(packets may appear in any order)]
    or _duplicate protection_ #hinweis[(client needs to handle receiving the same packet twice)].
    Its main use is for _DNS_ and _audio/video streaming_.
  ],
  image("img/dsy_11.png"),
)

== SCTP
SCTP #hinweis[(Stream Control Transmission Protocol)] is _message-based_ #hinweis[(unlike TCP & UDP, which are byte-based)],
which allows data to be _divided into multiple streams_. It uses a _four-way handshake_ with a signed "SYN-cookie" and
it supports _multi-homing_ by allowing devices to have multiple IP addresses.
It is _not widely supported_, the router firmware OpenWRT doesn't enable it by default and the UFW firewall doesn't support it
at all. Despite this, it is _used by WebRTC_ #hinweis[(see chapter @webrtc)], but it gets _tunneled over UDP_.

== DDoS Amplification Attack
Badly designed UDP implementations can be used to perform a DDoS amplification attack, in which the client makes a
_small request_ #hinweis[(i.e. 10 bytes)], to which the server delivers a _much larger response_ #hinweis[(i.e. 100 bytes)].
If the client performs _IP spoofing to redirect the response towards a victim_, for every byte the attacker sends,
the victim receives _10 times the amount of traffic._

Most modern programming languages don't allow changing the sender address in UDP packages, but lower level tools like `hping3`
can do that. To prevent amplification attacks, set up a _network filtering system_ that monitors for spoofed packages
#hinweis[(egress filtering)].

== Protocol Overview
#table(
  columns: (1fr,) * 5,
  align: horizon,
  table.header([], [UDP], [TCP], [SCTP], [QUIC]),

  [*Layer*],
  table.cell(colspan: 4, align: center)[Transport layer],

  [*Connection*],
  [Connection-less],
  table.cell(colspan: 3, align: center)[Connection-oriented],

  [*Transfer safety*],
  [Unreliable],
  table.cell(colspan: 3, align: center)[Reliable],

  [*Data transmission*],
  [Messages],
  [Streams],
  [Messages],
  [Multistream],

  [*Ordering*],
  [Unordered],
  [Guaranteed],
  [User can choose],
  [Guaranteed],

  [*Usage*],
  [DNS, HTTP/3, other],
  [HTTP/1 & 2, other],
  [WebRTC],
  [HTTP/3],

  [*Overhead*],
  [Light],
  table.cell(colspan: 3, align: center)[Heavy],

  [*Fault tolerance*],
  [Error checking,\ no recovery],
  table.cell(colspan: 2, align: center + horizon)[Error checking & recovery],
  [Error & Integrity check, recovery],

  [*Flow & congestion control*],
  cell-cross,
  cell-check,
  cell-check,
  cell-check,
)


= Application Protocols
#grid(
  columns: (1.5fr, 1fr),
  gutter: 2em,
  [
    For some applications, it can be worthwhile to develop a _custom protocol_.
    They can be _more efficent_ #hinweis[(space/performance)], but _more time and effort_ is needed to develop and
    test the new protocol. Alternatively, there are _protocol generators_ to do the heavy lifting for you
    #hinweis[(i.e. Thrift, Avro, Protobuf)]. These produce a standardized _IDL_ #hinweis[(interface definition language)]
    that can _generate code_ in various programming languages.
    They can _ease interoperability_ by delegating (de-)serialization and communication to the generated code.
    But using these generators comes at the cost of _higher overhead_.
  ],
  [
    #small[
      ```
      // Avro IDL
      @namespace("ch.ost.i.dsl")
      protocol MyProtocol {
        record AMessage {
          string request;
          int code;
        }
        record BMessage {
          string reply;
        }
        BMessage GetMessage(AMessage msg);
      }
      ```
    ]
  ],
)

*Implementing custom encoding/decoding*\
If you implement your own custom en- and decoding, you _control every aspect of it_.
But that also means you have to spend more time _testing_ it.

An important aspect is the _byte order_/_endianness_ of your protocol.\
Networking protocols often use _Big-endian_ #hinweis[(higher-order byte is stored first -- #hex("0A0B0C0D") gets stored
as #hex("0A0B0C0D"))] while most processor architectures use _Little-endian_ #hinweis[(lower-order byte is stored first --
#hex("0A0B0C0D") gets stored as #hex("0D0C0B0A"))].
When _transferring data_ between these two types, you have to make sure that the bytes are _interpreted correctly_.
Explicitly specify the endianness and provide converting functions.

== Different IDLs <idl>
We want to encode a message containing the string `"Anybody there?"` and the code `5` #hinweis[(15 bytes total)]
as efficiently as possible. Encoding it in XML would look like this: ```xml <code>5</code><message>Anybody there?</message>```
#hinweis[(48 bytes)].\

=== ASN.1
ASN.1 #hinweis[(Abstract Syntax Notation One)] is a IDL released in 1984 used for serializing data in X.509 certificates
#hinweis[(the certificates behind TLS/SSL)]. It encodes data in _binary_. The example would be encoded in _21 bytes_.

=== Avro
Avro is a data serialization system that can perform _remote procedure calls_ #hinweis[(RPC)].
It is used inside Apache Hadoop, a big-data-framework. It doesn't require any code generation, all schemas are defined in JSON.
The example message would be _16 bytes_ long in Avro.

=== Protobuf
Developed by Google with the goal of being _more compact than XML_.
Google uses it for nearly all inter-machine communication internally. The example message would have _18 bytes_.

=== Thrift
RPC framework from Facebook. Example message would have _49 bytes_ with Thrift's RPC overhead.

== RPC
Remote Procedure Call #hinweis[(RPC)] lets programs _execute code on remote machines as if it were a call on a local machine_.
It _abstracts_ the networking part and _eases the development_ for distributed systems.
The most widely used implementation is _gRPC_ which adds RPC functionality around Protobuf.
Its features are _authentication_, _bidirectional streaming_/_flow control_, _blocking_/_non-blocking bindings_,
_cancellation_ and _timeouts_.

With the RPC overhead, the example from @idl requires 171 bytes in the request and 124 bytes in the reply.

*Is transmitting JSON to a REST API also RPC?*\
While similar, there are differences:
- _REST_ is ideally _stateless_, while RPC can be stateful
- _REST_ responses _contain all metadata_, while RPC depends on interface definitions
- _JSON_ is _usually slower_, because it needs to be parsed

== HTTP
The Hypertext Transfer Protocol #hinweis[(HTTP)] is the _foundation for data communication_ in the World Wide Web.
It was started in 1989 by Tim Berners-Lee. _HTTP/1.1_, released in 1997, added _reusable connections_.
_HTTP/2_ from 2015 added _header compression_, _multiplexing_ and was in general more _efficient_.
For _HTTP/3_, see chapter @quic-http3.

HTTP is a _text based protocol_, HTTP communication can be directly _observed_.
It is also considered a _stateless protocol_ because a web server doesn't directly maintain state.
If state is required, the application needs to implement it themselves.

HTTP works through the _request/response-principle_ by requesting resources from a server, which then responds with
the corresponding resource. Every resource is identified with a _URL_ #hinweis[(Uniform Resource Locator)].

#align(center)[
  ```
  http://tbocek:password@dsl.i.ost.ch:443/lect/fs25?id=1234&lang=de#topj
  |___|  |_____________| |__________| |_||________| |_____________||___|
    |           |             |        |     |             |         |
  Scheme    User info        Host    Port   Path         Query    Fragment
  ```
]

Every HTTP request contains a _request method_ #hinweis[(also called "verb")] that indicates to the server what it wants to to.
The interpretation of a verb is mostly up to the server #hinweis[(but it should conform to expectations)].
When a browser makes a request, it usually adds various HTTP headers to it.
A HTTP response contains a _status code_ and the requested content, if any.

#v(-0.5em)
#table(
  columns: (1.5fr, 1fr),
  table.header([HTTP request methods], [HTTP status codes]),
  [
    `GET` #hinweis[(Fetch data)],
    `HEAD` #hinweis[(Only headers from GET)],
    `POST` #hinweis[(Send data to server)],
    `PUT` #hinweis[(Create or update resource)],
    `DELETE` #hinweis[(Delete resource)],
    `TRACE` #hinweis[(Sends back the request, useful for debugging)],
    `OPTIONS` #hinweis[(lists supported methods)],
    `CONNECT` #hinweis[(establish TLS connection via a proxy)],
    `PATCH` #hinweis[(Partially replace resource)]
  ],
  [
    `1xx` #hinweis[(Informational)],
    `2xx` #hinweis[(Success)],
    `3xx` #hinweis[(Redirection)],
    `4xx` #hinweis[(Client Error)],
    `5xx` #hinweis[(Server Error)]

    *Most common:*\
    `200` #hinweis[(OK)], `403` #hinweis[(Forbidden)], `404` #hinweis[(Not found)]
  ],
)
#v(-0.5em)
== WebSockets
The REST model only offers _one-directional communication_ #hinweis[(request, then response)].
How can the server notify the browser #hinweis[(client)] when it wants to send updates?

=== Polling
Classified into two types: _Short polling_, where the client sends a request every few seconds to ask the server for updates,
and _Long polling_, that opens a `keep-alive` connection that is open until the server responds or a timeout occurs.
Both of these methods are _simple_, but _inefficient_.

WebSockets offer _full-duplex_ #hinweis[(bi-directional)] communication over TCP.
A client can create a WebSocket with a compatible server by setting the two headers:
_`Connection: Upgrade`_ and _`Upgrade: websocket`_ to notify a protocol change from HTTP to WebSocket.
The server then responds with a HTTP `101 Switching Protocol`.
After successful connection, binary and text data can be transmitted from/to both sides.
The URL schema changes to `ws://` #hinweis[(unencrypted)] or `wss://` #hinweis[(TLS-encrypted)].

Some proxies and load balancers may need _special configuration_ for WebSockets due to the protocol switch.

== Server-Sent Events (SSE)
Server-Sent Events are a _one-way communication from server to browsers_.
They are _more limited_ compared to WebSockets, but _easier_ to set up.

_They use standard HTTP communication:_ The client sends a HTTP request with the `Accept: text/event-stream` header.
The server keeps the connection open and can now push data to the client.
When setting up SSEs in JavaScript, the `EventSource` API can be used to simplify SSE handling.
Every message is terminated through a double new line.

SSEs offer different "channels" to group messages by. If the connection gets lost, SSEs will _automatically try to reconnect_.
There is a maximum number of concurrent connections to the same domain #hinweis[(6 for most browsers)].

Use cases are _news feeds_, _status updates_ and _real-time notifications_.

== Serialization Formats
_Bencode_ is a serialization format that is most commonly used in the _BitTorrent protocol_.
It encodes integers #hinweis[(`i42e`)] and strings together with their length #hinweis[(`4:test`)].
Lists are similarly delimited like integers #hinweis[(`l4:testi42ee`)],
as are maps/dictionaries #hinweis[(`d4:name4:nina5:hobby8:sleeping`)]

Other serialization formats include _UBJSON_ #hinweis[(binary formatted JSON)],
_Cap'n Proto_, Flatbuffers #hinweis[(both not serialization formats, they just copy data in little-endian)] and
_Apache Arrow_ #hinweis[(fast data serialization for data in tables)].

== WebRTC <webrtc>
Web Real-Time Communication #hinweis[(WebRTC)] is a protocol released in 2011 by Google that offers
_browser-to-browser communication_. Its main usage is _audio/video calls_ inside the browser.
It communicates mostly over Peer-to-Peer. Before WebRTC, users had to either install plugins like Adobe Flash or
install a native program; now most calls inside the browser #hinweis[(WhatsApp Web, Facebook Messenger)] use WebRTC.

Until the WebRTC specification was _completely standardized in 2021_, there were a lot of implementation differences
between browsers. Now, WebRTC works well across most browsers.
To guarantee compatibility, all WebRTC implementations _must support the VP8 and H264 codecs_.

=== WebRTC and NAT
#grid(
  columns: (3fr, 1fr),
  gutter: 2em,
  [
    An advantage of WebRTC is that developers _don't need to care about NAT_.
    It implements _STUN_ #hinweis[(Session Traversal Utilities for NAT)] that detects what kind of NAT the client is using
    by connecting to STUN servers. It is not a NAT traversal solution by itself, but a building block.

    If STUN doesn't suffice, WebRTC uses _TURN_ #hinweis[(Traversal using relays around NAT)].
    It routes the traffic over a _relay server_ to make connections in network environments where peer-to-peer would
    not work correctly #hinweis[(i.e. symmetrical NAT)]. The communication with the TURN servers happens over _UDP_,
    but can also be sent over TCP, in case firewalls block UDP traffic.
    _TURN works guaranteed_, but it is _less efficient_ and the communication _no longer peer-to-peer_.

    In theory, TURN could be avoided by implementing _NAT-PMP_ #hinweis[(NAT Port Mapping Protocol)] that automatically
    opens ports inside the NAT, similar to UPnP. But implementation of it into browsers has been stalled for a long time.
  ],
  [
    #image("img/dsy_12.jpg")
    #image("img/dsy_13.jpg")
  ],
)

_ICE_ #hinweis[(Interactive Connectivity Establishment)] is a different protocol for NAT traversal.
It works by exchanging multiple IPs/Ports that are tested for peer-to-peer connectivity --
first checking for direct connection and then falling back on STUN and TURN if necessary.

=== Architecture
#grid(
  columns: (1fr, 1fr),
  [
    WebRTC uses the _triangle architecture_. To establish a connection, the clients must first exchange connection information
    #hinweis[(Session description, ICE candidates)]. They exchange that information through a _signaling server_.
    The communication to it is not specified, but often, _WebSockets_ are used.
    When a direct connection is possible, they then connect directly, otherwise a STUN/TURN server is used.

    Since the signalling itself can be implemented freely, there even exists a protocol to exchange that information
    _over sound waves_ captured by microphones on the devices.
  ],
  image("img/dsy_14.png"),
)

#pagebreak()

*Detailed connection establishment*
+ _Peer 1 sends a `createOffer`_ with its local session description to the signalling server, server relays it to Peer 2
+ _Peer 2 sets the local session description_ from Peer 1 as its remote session description
+ _Peer 2 sends a `createAnswer`_ to Peer 1 with its local session description over signalling server
+ _Peer 1 sets the local session description_ from Peer 2 as its remote session description
+ _Peers exchange their ICE candidates_ and a direct/STUN/TURN connection is established based on the results
+ _Peers can send messages_ with `dataChannel.send()` and get notified about incoming messages with `dataChannel.onmessage`

=== Criticism
There are a few points of _criticism_ about WebRTC:
- Its inclusion into browsers was criticized as _bloating them up_ and hogging even more resources
- The _complexity_ of the WebRTC API was also called into question, many developers wished for a more simplified API
  #hinweis[(PeerJS is a simplified wrapper library)]. The protocol itself is also quite complex with _SCTP over DTLS over UDP_;
  necessary to guarantee security, but hard to debug.
- Early versions also had _security concerns_: it was possible to leak your public and private IP address to others,
  even behind a VPN or the TOR network -- this has been fixed. On the flip side, WebRTC does not allow unencrypted connections
  and even encrypts the media itself #hinweis[(with SRTP & DTLS)].

== DNS
_DNS translates human readable domain names to IP adresses._
It works hierarchical, with the authority over subdomains transferred to the owners of these:
The root servers have authority over TLDs #hinweis[(.com, .ch, etc.)], TLDs over sub-level domains.
DNS uses _UDP port 53_ for communication. It was designed in 1983 with no encryption or verification mechanism.
Before DNS, the `host.txt` containing all IP-domain mappings needed to be distributed -- not scalable!

While domain names only allow ASCII characters, _Punycode_ can be used to "translate" non-ASCII characters\
#hinweis[(i.e. bücher.ch $->$ xn-\-bcher-kva.ch)]

=== DNS Setup
Typically, there are _primary_ and _secondary_ DNS servers for redundancy in case of failure.
The secondary servers get its data from the primary through _zone transfer_ that copies the entries to the secondary.

To make DNS queries more efficient, different DNS server types exist:
- _Caching/Forwarding DNS:_ Cache DNS queries, so name lookups don't need to be repeated. Usually on routers in the LAN.
- _Recursive servers:_ Execute the actual name resolution for the client. Ask the authoritative servers and return the result.
  Usually on the ISP.
- _Authoritative server:_ Provide the definitive answer to a name resolution. At the root and each TLD and SLD.

_In essence:_ Authoritative servers allow others to find your domain, recursive servers allow you to find other domains.

=== Root servers
The root servers were originally limited to 13 due to the maximum DNS packet limit of 512 bytes, but with _Anycast_
#hinweis[(One address represents multiple servers)], these 13 servers now _correspond to over a 1000 servers worldwide_.
For example, `l.root-servers.net` has one IP, but is mirrored in 138 locations.

The control over these root zones lies with the _United States Departement of Commerce_ and they are operated by _ICANN_
#hinweis[(Internet Corporation for Assigned Names and Numbers)].

In 2015, a _DDoS attack_ against DNS root servers with 5 million requests per second was committed.
The root servers as a whole could _withstand the attack_, but some mirrors did not.

#pagebreak()

=== DNS resource records
#grid(
  columns: (1.5fr, 1fr),
  [
    A DNS resource record can have various types:
    - _SOA:_ Start of Authority, serial number #hinweis[(version number of this DNS record)] and the default caching times
    - _NS:_ Name Server Record, sets the authoritative/primary server for this zone.
      If there are multiple, round robin is used, but split horizon can also be configured
    - _MX:_ Name and relative preference of mail servers
    - _A/AAAA:_ IPv4/IPv6 address record
    - _TXT:_ arbitrary and unformatted text #hinweis[(used by SPF, TKIM, Let's Encrypt)]
    - _PTR:_ opposite of address record #hinweis[(reverse DNS lookup)]

    _TTL_ defines the duration in seconds that the record may be cached by any resolver. "0" means no cache.
  ],
  [
    ```
    $TTL 3D
    $ORIGIN tomp2p.net.
    @ SOA ns.nope.ch. root.nope.ch. (2018030404 8H 2H 4W 3H)
              NS        ns.nope.ch.
              NS        ns.jos.li.
              MX   10   mail.nope.ch.
              A         188.40.119.115
              TXT       "v=spf1 mx-all"
    www       A         188.40.119.115
    bootstrap A         188.40.119.115
    $INCLUDE "/etc/opendkim/keys/mail.txt“
    $INCLUDE "/etc/bind/dmarc.txt
    ```
  ],
)

=== DynDNS
Dynamic DNS is a method of _automatically updating a name server in the DNS_, without having complete access to a DNS server.
It verifies access through TSIG #hinweis[(Transaction Signatures)] that works through a shared secret and cryptographic hashing.
The two main use cases are _allowing customers of a hosting service to change DNS entries_ without giving them
complete access to the DNS server and _setting up a domain on a home network without a static IP_.


=== DNSSEC
DNSSEC is a _security extension_ for DNS that _guarantees authentication_ and _data integrity_, but _not confidentiality_
#hinweis[(no data encryption)]. It is the basis for other security measures like certificates, SSH fingerprints and
IPSec public keys.

DNSSEC uses two types of keys: _Zone Signing Keys (ZSK)_ to sign records and _Key Signing Keys (KSK)_ to sign ZSKs.
ZSKs are rotated frequently, unlike KSKs.

It also introduces new record types:
- _RRSIG:_ Resource Record Signature, contains the signature of a resource record that was signed by a ZSK
- _DNSKEY:_ Contains the public key for the DNSSEC validation, signed by the KSK
- _DS:_ Delegation Signer, points to the KSK in the parent zone

With DNSSEC, all DNS queries are now verified and cannot be modified, but they are still unencrypted.

=== DNS over TLS/HTTPS
_DoT_ #hinweis[(DNS over TLS)] and _DoH_ #hinweis[(DNS over HTTPS)] are two different methods to _encrypt DNS queries_ and
thus provide confidentiality of lookups in transit. In both cases, only the connection from the user to the recursive server
is encrypted, the connections from the recursive to the authoritative servers aren't.

#table(
  columns: (auto, 1fr, 1fr),
  table.header([], [DoH (DNS over HTTPS)], [DoT (DNS over TLS)]),
  [*Functionality*],
  [
    DoH-capable applications send queries over the HTTPS port 443 to a DoH capable resolver #hinweis[(i.e. Cloudflare)].
    This hides DNS traffic, which makes it harder to filter.
  ],
  [Sends DNS queries over TLS with port 853, meaning this traffic can be easily blocked or prioritized.],

  [*Support*],
  [Trivially deployed, DNS response are served like simple web pages],
  [Widely supported by DNS servers and public resolvers],

  [*Performance*],
  [TCP + TLS handshake: 2/3 RTTs #hinweis[(but Cloudflare is close to you)]],
  [TCP + TLS handshake: 2/3 RTTs #hinweis[(but ISP is close to you)]],

  [*Installation*],
  [Needs to be set up per application and the application needs to support DoH. All other programs on the system use regular DNS.],
  [System wide: Clients can test if their resolver supports it by checking port 853, otherwise fall back to regular DNS],
)


= Deployment
Back in the old days, there were two main strategies for deployment:
- _OTS:_ "Off-the-shelf software" -- ready-made Packages which could be easily installed with package managers.
- _Custom Software:_ More complicated, you had to upload Java Web Archive files #hinweis[(`.war`)] to the application server,
  which in turn extracted and installed the software.

*Problems:*
"It runs on my machine", Who installs Java in the right version?, What happens on crashes?, Scaling, Hardware Defects,
Misconfiguration #hinweis[(Security risks if configuration wrong)]

_VMs / Containers_ help a lot to combat these problems. They don't give the programs access to the complete PC,
can scale, can more easily be moved to another machine and can pre-install the right Java version.

== Deployment Strategies
There are a lot of different strategies to deploy containers.
#grid(
  [
    - *Rolling Deployment / Ramped Deployment:*
      The new version is _gradually deployed_ to replace the old version - _without taking the entire system down_ at once.
      #plus-list[+ Minimal downtime, low risk]
      #v(-0.5em)
      #minus-list[+ Complexity, longer deployment times]

    - *Blue-Green Deployment:*
      _2 environments_, current prod #hinweis[(blue)] and current prod with new release #hinweis[(green)]. _Test, then switch_.
      #plus-list[+ Instant rollback, Zero downtime]
      #v(-0.5em)
      #minus-list[+ 2 prod environments, keeping data in sync is trickier]

    - *Canary Releases:*
      Release new version to a _small group of users or servers first_, if all goes well, release to more users.
      #plus-list[+ Risk reduction, user feedback]
      #v(-0.5em)
      #minus-list[+ Complexity, inconsistencies]
  ],
  [
    - *Feature Toggle:*
      Fine grained canary, _set feature for specific users_.
      #plus-list[+ More risk reduction, specific user feedback]
      #v(-0.5em)
      #minus-list[+ Increase complexity of codebase, config management necessary]

    - *Big Bang:* Deploy _everything at once_.
      #plus-list[+ Simple]
      #v(-0.5em)
      #minus-list[+ High risk, limited rollback]

      *There are other strategies:*
      - _Shadow Deployment:_ New version is deployed alongside existing one, a copy of the incoming request is
        sent to the shadow version for testing
      - _A/B testing:_ Version B is released to a subset of users under specific conditions.
  ],
)

Which strategy to choose _depends on the environment and the product_.

== Practical Deployment
The base for the deployment is the _containerization_. There are a lot of _different tools_ for deployment.
Most of these are _Orchestration tools_, which coordinate automated tasks over multiple machines in overarching workflows.

=== Ansible
Ansible is a configuration tool which connects _via SSH_ to the server.
Not originally built to work with containers, but can still be used with them.
Can also be used with other tools like Progress Chef or Puppet.
The Ansible workflow is designed around _playbooks_ that define the state a server is meant to be in.
In a list of SSH hosts, the server it should administer are entered. Ansible then connects to them and executes the playbook.
The host should run the same OS as the Ansible host to avoid conflicts.

Ansible has _no agents running_ unlike Progress Chef or puppet. Very good for _structured deployment_.

Run it with `ansible-playbook playbook.yml`

#pagebreak()

=== Docker
Simplest solution, no orchestrating tools necessary.
Docker can set up a _context_ with which Docker commands can be executed on remote machines.
You can deploy as easily as this:

```sh
export DOCKER_HOST="ssh//xyz@192.168.1.2"
docker compose up -d --build
```

The build is done on the remote server.
Copying files into the image works, as Docker sends this file from the local machine to the remote.
This does _not work with volumes_, however.

With the policy _`restart: unless-stopped`_ in the Docker Compose file you can ensure that the container will
automatically restart if something goes wrong, unless it was explicitly stopped.

#v(-0.25em)
#plus-list[+ very simple]
#v(-0.5em)
#minus-list[+ no scaling, no logging, no resource monitoring]

=== Podman
Podman is daemonless.
Instead it _directly interacts_ with image registry, container, and image storage through the _runC container runtime process_.

With tools like _Quadlet_ #hinweis[(Docker Compose-like system)] you can...
- run container under `systemd` in a declarative way
- use another container config file to create a `systemd` config file which gets installed in the OS as service / daemon
- use another project to create a container config from a podman command
- run _seamless_ image upgrades

#plus-list[+ Simpler]
#v(-0.5em)
#minus-list[+ Deployment needs more work]

=== Docker Swarm
Docker Swarm is an _integrated orchestrating tool for Docker_ which is built into Docker and can be directly used
within Docker Compose files. The most important Swarm commands are:
- _docker swarm:_ Manage swarm #hinweis[(Group of servers)]
- _docker stack:_ Manage deployments #hinweis[(Deploy programs from docker compose into the swarm)]
- _docker node:_ Manage nodes #hinweis[(server in swarm)]

The _scheduler_ is responsible for placement of containers to nodes, it automatically deploys them based on criteria you set.
Setup is easy #hinweis[(but you need to do it yourself)]. The big cloud providers don't offer automatic set up,
but it can be configured manually.

Docker Swarm has already _lost the battle against Kubernetes_ for supremacy in the container orchestration space
because Kubernetes can do more than Docker Swarm and supports more complex requirements.

=== Kubernetes (K8s)
Kubernetes _automates deployment, scaling, and management of containerized applications._
Started by Google in 2014, now it's in the hands of the CNCF #hinweis[(Cloud Native Compute Foundation)].
Has become the industry standard. All big cloud providers support Kubernetes. But they often have a difficult pricing scheme.

Kubernetes simplifies _application deployment_ and management by automatically determining how and where to deploy
applications. It ensures _high availability_ and _fault tolerance and supports _auto-scaling_ based on demand._
Kubernetes facilitates _rolling updates and rollbacks_, which is nice because rollbacks are hard, especially with state.
It provides a powerful ecosystem of tools and services.

==== Design Principles
- _Configuration is declarative:_ Declare the state with YAML/JSON. Specify the goal, not the way to get there.
- _Immutable Containers:_ A container is created once and then stays the same.
  If changes need to be made, a new container is created and the existing one is replaced.
  _Don't store state in a container._
  If a health check fails, Kubernetes removes the container and starts a new one.
  _Rollback_ is done by replacing the new container with the old one.
  If there were changes made on the schema, this needs to be rolled back as well.

==== Architecture
#table(
  columns: (1fr, 1fr),
  table.header([Master Node], [Worker Node]),
  [
    Controls the overall state of the cluster.
    - _API Server_ manages communication within the cluster
    - _etcd_ stores configuration data for the cluster
    - _Controller manager_ ensures the desired state of the cluster #hinweis[(Health checks)]
    - _Scheduler_ assigns workloads to worker nodes.
  ],
  [
    Runs application containers.
    - _Kubelet_ communicates with the master node and manages containers
    - _kube-proxy_ handles network routing and load balancing
    - _Container runtime_ executes containers #hinweis[(containerd, CRI-0, etc.)]
  ],
)

==== Key Concepts
- _Pod:_ Smallest deployable unit, contains one or more containers which run on the same server.
  They are ephemeral, meaning they are created anew each time the server starts.
- _Service:_ Stable network endpoint to expose a set of Pods #hinweis[(Makes Pods visible to the outside network)]
- _Deployment:_ Manages the desired state of an application, defines scale, hardware limits, updates.
- _ConfigMap:_ Stores non-sensitive configuration data for an application #hinweis[(e.g. environment variables)]
- _Secret:_ Stores sensitive configuration data like passwords and API keys.
- _Volume:_ Persistent storage for data generated by a container. Kubernetes supports multiple types of volumes.
- _Namespaces:_ run multiple projects on one cluster, separate them with namespaces.

== Ideal Deployment Strategy
Ideally, you should only have to _change a single line_ to deploy your application with _another provider_.
This is often not the case, however.

_Terraform_ is a Infrastructure as a Service Tool to describe your infrastructure in terraform files.
Terraform can then recreate the infrastructure on another cloud provider, which should result in better platform independence.

=== Best practices
- _Automate the deployment as much as possible:_ The more automated something is, the less likely it is to go wrong.
- _Infrastructure as code:_ With terraform or other tools. Leads to independence of specific providers.
- _Immutable Infrastructure:_ Always deploy new version with changes, don't update the current version.
- _Health Checks / Monitoring_
- _Rollbacks:_ Always plan for rollbacks if you deploy.


= Performance
While hardware has made great performance leaps, network _latency_ stays the same #hinweis[(as seen in chapter @location)].

Processors can _predict the outcomes of branches_ #hinweis[(if-statements)].
If you loop over an array of numbers and have a\ `if (number < n)`, a sorted array will be processed much faster than
a unsorted one, because the branch prediction can predict the `true`'s when `n` has not been reached and vice-versa.
When a prediction is wrong, it needs to be thrown out -- a _branch miss_.

A _L1 cache reference_ needs around 1ns, a branch miss around 3ns.

#table(
  columns: (auto,) + (1fr,) * 3,
  table.header([], [NVMe], [SATA SSD], [HDD]),
  [*Description*],
  [
    Non Volatile Memory Express achieves ultra-low latency by using parallelism and Queues, PCIe Interface and
    direct CPU communication. Used for DBs.
  ],
  [
    Solid State Drives use integrated circuits to store data persistently.
    They have no moving parts which makes them faster than HDDs.
  ],
  [Hard Disk Drives are electro-mechanical storages with rotating platters coated with magnetic material.],

  [*Read latency*], [$~20 mu s$], [$~100 mu s$], [$2-5 m s$],
  [*Write latency*], [$~30 mu s$], [$~200 mu s$], [$5-10 m s$],
)

== Throughput vs. Latency
_Latency_ is the delay in network communication and shows the time that data takes to transfer across the network or
_how long it takes to open a file_.
_Throughput_ refers to the average volume of data that can pass through the network over a specific time or
_how many files can be processed in a time frame_.

The two metrics are often _contradictory_, a system with low latency often has low throughput and vice versa.
Both metrics need to be considered.

_Cost_ is also a factor that needs to be considered, faster is more expensive.

== Compression Ratios
There is a _trade-off to be made between CPU usage and network usage:_
Compression requires CPU resources, but reduces the amount of data transferred.

The compression ratio for _HTML_ is around _2–3x_, and for _source code_ it is around _2–4x_.
_Text_ can be compressed relatively well. If you have _more read than write accesses_, then compression is very useful.

==== HTTP Compression Algorithms
- _gzip:_ General compression tool. Most widely used option for web content.
- _Brotli:_ optimized for web content because of included dictionary for web keywords
  #hinweis[(HTML tags, HTTP headers, CSS properties, JavaScript keywords, URL fragments etc.)]
- _zstd:_ General purpose, better than gzip, because it is faster and has a better compression ratio

*Best practice:* Enable compression with default settings, only tweak if necessary\
*Image compression:*
Choose the right tool for the job: JPEG #hinweis[(try different encoders)], JPEG XL #hinweis[(GOATed format)],
avif, WebP, PNG, GIF... Use SVG for vector graphics, can be very efficient for simple graphics like logos.

== Benchmarking
- _Benchmark via Tool like Artillery:_ The client's CPU can become the bottleneck
- _Benchmark via WiFi:_ Tests the WiFi bottleneck
- _Benchmark via new connection:_ Tests the TCP slow start
- _Benchmark via login page:_ Tests the computational complexity of used password hash algorithm

*Conclusion:*
When benchmarking, it is always important to understand _what the limiting factor is_, because this is what is being tested.

==== Benchmark example with `ab`
`ab` is an Apache HTTP server benchmarking tool. The following command tests the site http://localhost/info with 5000 requests,
50 requests at a time, with keep-alive and with a custom header.

```sh
ab -n 5000 -c 50 -k -H "Connection: keep-alive" http://localhost/info
```

=== Best practice
- Make it _work_, then make it _correct_, then make it _fast_
- _Premature optimization_ is the root of all evil #hinweis[(Only optimize after performance testing where performance is bad)]
- Only measure and optimize _your use-case_ #hinweis[(Benchmarks may not reflect your use case)].

#pagebreak()

= Bitcoin / Blockchain
Bitcoin is an experimental _digital currency_. It is fully peer-2-peer and therefore has no central entity.
The first bitcoin was issued on January 3, 2009. The smallest possible unit is 0.00000001 BTC, it is called 1 satoshi.

== Key characteristics
There is a _maximum of around 21 million BTCs_ because the initial subsidy has 33 bits.
The reward for Bitcoin mining halves with every 210'000 blocks mined.
This is called a halving and takes place around every 4 years.
After the 33rd halving, the reward is practically 0, which means that no more new bitcoins can be generated.
This moment will occur at around the year 2140.

_Every transaction broadcasts to all peers._ Every peer knows all transactions, their total size is around 660 GB as of today.

_Validation_ is done by _proof-of-work_ by calculating partial hash collisions.
This is difficult to fake and makes sure that there is _no double-spending_ #hinweis[(using the same Bitcoins twice)].

_The initiator is unknown so far._ We know only the pseudonym Satoshi Nakamoto. There are rumors, but so far nobody has
found out who the person or organization is and why the bitcoins which Satoshi has #hinweis[(around 1mio BTC)] were never moved.

The first Bitcoin boom #hinweis[(and crash!)] was in 2013 and another one in 2014. The trend is upwards.
At the moment, the price of 1 BTC is around 104'000 USD. After every halving, the price tends to go up.

Bitcoins have evolved in the public interest from an obscure currency to an _integral part of the financial infrastructure_.

Bitcoin does not rely on trust #hinweis[(like a currency with a central entity would)], but on _strong cryptography_.
Because there is no central bank, Bitcoin is "governed" by its development community.
If there are disagreements, forks of Bitcoin can be created.

There is only _weak anonymity_ #hinweis[(pseudonymity)] because all peers know all transactions.
This complete transparency makes it possible to trace the _history of every single Bitcoin_.
Techniques such as _clustering_ can be used to determine which addresses presumably belong to the same wallet,
which further minimizes pseudonymity.

_BIPs_ #hinweis[(Bitcoin Improvement Proposals)] are a standardized way to propose changes and features to Bitcoin.
All BIPs are published on GitHub where they can be discussed by the community.

Bitcoins can be _exchanged for "real" currencies_. US and Switzerland are considered Bitcoin friendly,
China not that much #hinweis[(mainly because of energy consumption)].

== Numbers
At the moment there are a total of 20 Million BTC mined, which results in a market capitalization of 2 Trillion USD.

=== Fake Volumes
There is evidence that some markets report fake trading volumes to appear more attractive than they actually are.
If a volume has a _high spread_ #hinweis[(Difference between buying and selling price, should be around 0.01USD)]
it is an indicator that it is fake.
_Regular trading patterns_, _sudden spikes in volume_ and _unnatural distribution of trading sizes_ also indicate that the
reported figures do not reflect actual market activity.

=== Statistics
- There are around _3-11 transactions per second_, which is a relatively small number compared to e.g. Visa.
- _Transaction fees_ can be quite high, depending on the network utilization #hinweis[(currently 80 million USD)].
- The _blockchain_ is around _660GB_ at the moment.
- The _Network Hashrate_ is a measure of the combined computing power of all miners in the Bitcoin network.
  It is currently around 1000 Exahashes per second #hinweis[(1000 with 18 zeros)].
  One single hash corresponds to around 12'700 floating point operations per second.
  So approximately 12.7 YottaFLOPS of computing power are needed in 2025.
- The _difficulty of the calculations is adjusted_ circa every 14 days to keep the mining time at around _10 minutes_.

== Mechanism
A wallet has public-private keys.
- The _public key_ is created using ECDS 256bit #hinweis[(Elliptic Curve Digital Signature Algorithm)] and
  is used for the Bitcoin Address that can receive Bitcoins.
- The _address_ is created using the _SHA256_ function, followed by _RIPEMD160_ and then encoded in _Base58_.
  This results in an address looking like this: `1GCeaKuhDYnNLNR6LGmBtKhPqEJD4KeEtF`.
  $ "base58"("RIPEMD160"("Sha256"("ecdsa public key"))) $
- The _private key_ is used for signing transactions. If you lose your key, you lose your bitcoins.

=== Transaction
+ Peer A wants to _send BTC_ to peer B. To do this, he creates a _transaction message_
+ Transaction message contains _inputs and outputs_ #hinweis[(where the BTC came from and where it goes)]
+ Peer A _broadcasts_ the transaction to all the peers in the network
+ Transactions are _stored in blocks_. A new block is _created / verified_ every 10 minutes, this process is called _mining_.

The system is designed to be both _secure_ and _transparent_, as all transactions are stored _publicly_ in the blockchain.
The blockchain technology ensures that _every transaction is validated by the entire network_ before it is considered valid,
creating a _high level of security_ and trust without the need for centralized authority.

=== Key Bitcoin Operations
_Private key_ authorizes the transaction. If keys are stolen, the thief may use your coins.
If the keys are lost, the coins are lost. There is no way to restore or reset them.

In Bitcoin, the _UTXO system_ #hinweis[(unspent transaction output)] is used.
A UTXO is an output of a past transaction that has not yet been spent -- Bitcoins that are currently in your wallet.

*Example:* \
User A wants to _send 10 BTC_ to User B.
In his wallet, User A has multiple UTXOs, including one with _4.4_ and one with _5.6_ Bitcoins.
Together, this _results in 10 Bitcoins._ The UTXOs _cannot be split_.
If you cannot pay the exact amount with your UTXOs, the output of a transaction consists of the amount you want to send
and the "change", which you have to send back to yourself.

User B _generates a new address_ in his wallet to which the Bitcoins are to be sent.
User A then _creates a transaction_ that refers to these two UTXOs and specifies that 10 Bitcoins are to be sent to
this address of User B. The transaction is _signed with A's private key_.

This signed transaction is then _distributed_ in the network.
The miners _verify_ that A actually has access to the UTXOs and the transaction is then _confirmed by inclusion in a block_.
After confirmation, user B can _access the 10 bitcoins_ by using the corresponding private key for the address.
This means that he makes a transaction and _proves with his signature_ that he can access this key.

The UTXOs in the wallet of user A are then _changed to STXO_ #hinweis[(spent transaction output)] and cannot be spent anymore.
This mechanism makes sure that _every bitcoin can only be spent once_.

#align(center, image("img/dsy_15.png", width: 80%))

== Blockchain
Transactions are _collected_ in blocks. A new block is created approximately every 10 minutes.

#grid(
  [
    Every block contains solved crypto puzzles in the form of _partial hash collisions_.

    A block has 3 elements:
    _the previous block hash value_ #hinweis[(pointer to previous block)],
    the _transaction data_
    and the _nonce value_.

    The nonce value is the _solution to the puzzle_.
    You need to find a nonce value that, with the other elements, generates a hash value that starts with _multiple zeroes_.
    Finding this nonce value is called _mining_. It uses a lot of computing power.
  ],
  image("img/dsy_16.png"),
)

*Example:* Nonce gets incremented until the hash value starts with 4 zeroes.
#image("img/dsy_17.png")

If you _change_ something _in the chain_, all the _pointers_ behind this block in the chain are _no longer correct_ and
would also have to be _recalculated_, which is very computationally intensive.

If you solve the puzzle, you get a _reward in form of Bitcoins_. At the moment, miners get 3.125 BTC per creation.
After the next halving, the reward will be at 1.5625 BTC. The _difficulty_ gets _adapted_ every _10 minutes_.

Today, miners need _specific hardware_ like _Application Specific Integrated Circuits_ #hinweis[(ASIC)],
which are only optimized for calculation of SHA256 hashes.

== Mining
If you have a _small miner at home_, you end up _paying much more for the electricity_ you use _than you earn in rewards_.
You would need to join a _mining pool_.

This problematic leads to the _formation of large mining farms_ that are located in regions with _favorable electricity prices_
or can _negotiate favorable conditions_.
This raises questions about _decentralization_ because the farms are concentrated in certain places.

The _longest chain_, so the chain with the highest cumulative difficulty is considered the _valid chain_.

There are _different levels of confirmation_, normally around _3-6 blocks_ confirmation is considered secure
#hinweis[(Probability of a reversal of the transaction is negligible)]

#pagebreak()

== 51% Attack
A 51% attack is a potential threat to blockchain networks where a _group of miners may control more than 50% of
the networks mining hash rate_ which allows them to _prevent new transactions_, _halt payments_ and even _reverse transactions_.

Larger networks are less likely to fall victim to a 51% attack, _smaller networks are more vulnerable_.

==== Example
An online shop for clothes accepts payments in Bitcoins. What are the 4 steps of a 51% attack on this online shop?

+ Order clothes with a _regular transaction_.
  Simultaneously _start a new chain_ with _more than 50% computing power_ that does not include that transaction.
+ The clothes shop _confirms the transaction_ and _despatches the ordered clothes_.
+ _Publish the secret, longer chain._ Because the chain is now the longest in the Bitcoin network, it is now considered the
  correct chain and the chain with the payment made to the online shop is _discarded_.
  The Bitcoins were therefore _never spent_.
+ _Profit_.

== Coins and Mechanisms
All electronic coins are backed by scarce resources to avoid double spending.
- _Bitcoin:_ SHA256 partial hash collision, time, ASIC, electricity #hinweis[(proof of work)]
- _Ethereum:_ Opcodes in Bitcoin, smart contracts -- miners need to deposit Ethereum Coins to be able to mine;
  the more, the more likely one can become a validator #hinweis[(proof of stake)]. This is more energy efficient.
- _Litecoin:_ scrypt partial hash collision: Time, GPU, memory, electricity
- _Ripple XRP:_ Unique node list, web of trust #hinweis[(Participants need to trust each other)]

== Discussion
#table(
  table.header([Disadvantages],[Advantages],),
  [
    #minus-list[
      + Power consumption #hinweis[(ecological footprint is terrible)]
      + Not scalable #hinweis[(Poor throughput of transactions)]
      + Anonymity #hinweis[(can be used for illegal activities)]
      + Volatile exchange rate
      + Central elements like core developers
    ]
  ],
  [
    #plus-list[
      + Low #hinweis[(fixed)] transaction fees, around 30 cents
      + Scalable #hinweis[(Hardware / storage gets faster)]
      + Anonymity #hinweis[(preserving privacy)]
      + No major "crashes" #hinweis[(of the tech itself)]
      + Decentralized
      + There are many other blockchain use cases
    ]
  ],
)
