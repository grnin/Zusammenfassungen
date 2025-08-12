#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Heap Memory Management
Stack memory is _scarce_. The heap memory might also be needed for creating object structures #hinweis[(Tree structures)]
or for polymorphic factory function to class hierarchies. Example for the latter: If we have a function that creates
instances of class `Circle` and the result should be stored in a variable of base class `Shape`, we can't just return
a value, because the `Circle` part will just get "thrown away". Thus we need to return a pointer to the `Circle` instance.

_Always rely on library classes for managing heap memory!_
You will shoot yourself in the foot at some point when doing it manually.

#grid(
  [
    _Resource Acquisition is Initialization_ (RAII) Idiom
    - Allocation of memory in the constructor
    - Deallocation of memory in the destructor
    - Destructor will be called when the scope is exited\ #hinweis[(End of block with "`}`", `return` or exception)]
    - The RAII wrapper manages memory for you!
  ],
  [
    ```cpp
    struct RaiiWrapper {
      RaiiWrapper() { /* Allocate Resource */ }
      ~RaiiWrapper() { /* Deallocate Resource */ }
    }
    ```
  ],
)

#grid(
  [
    C++ allows _allocating_ objects on the heap _directly_, like in C.
    However, if done manually you are responsible for _deallocation_ and risk undefined behavior
    #hinweis[(Memory leaks, dangling pointers, double deletes)]!
    C++ performs no garbage collection, cleanup is performed manually. _Don't do this!_
  ],
  [
    ```cpp
    auto ptr = new int{}; // Allocate on heap
    std::cout << *ptr << '\n';
    delete ptr; // Deallocate on heap
    // Better: Use smart pointers (see below)
    // Even better: Store value locally
    // as value-type variable
    ```
  ],
)

C++ offers three types of _type safe smart pointers:_
- _`std::unique_ptr`:_  Allows just one handler
- _`std::shared_pointer`:_ Allows multiple handlers
- _`std::weak_pointer`:_ Prevents circular dependencies from creating memory leaks

With these smart pointers, a manual call to `delete ptr;` is no longer required.
But still: _always prefer storing a value locally._

== `std::unique_ptr<T>`
#hinweis[#cppr("memory/unique_ptr")[CPPReference: `std::unique_ptr`]]
#h(1fr) ```cpp #include <memory>```\
The unique pointer is used for _unshared heap memory_. Only a single owner exists.
A unique pointer cannot be copied, but it can be moved. This transfers ownership from one variable to another.

#grid(
  [
    A unique pointer #hinweis[(`std::unique_ptr<T>`)] is obtained with `std::make_unique<T>()`.
    `std::make_unique<T>()` and `std::make_shared<T>()` are _factory functions_.
  ],
  [
    ```cpp
    auto factory(int i) -> std::unique_ptr<X> {
      return std::make_unique<X>(i);
    }
    ```
  ],
)

`unique_ptr`s are _not suited_ for creating class hierarchies or data structures with multiple pointers
#hinweis[(i.e. double-linked-lists)].

=== Example
#grid(
  columns: (1fr, 1.4fr),
  [
    ```cpp
    #include <iostream>
    #include <memory>
    #include <utility>

    // transfer of ownership through
    // return by value
    auto create(int i)
      -> std::unique_ptr<int> {
      return std::make_unique<int>(i);
    }
    ```
  ],
  [
    ```cpp
    auto main() -> int {
      std::cout << std::boolalpha;
      auto pi = create(42);
      std::cout << "*pi = " << *pi << '\n'; // *pi = 42
      // bool is false if pi does not point to the int
      std::cout << "pi.valid? " << static_cast<bool>(pi)
        << '\n'; // pi.valid? true

      // explicit transfer of ownership from lvalue
      auto pj = std::move(pi);
      std::cout << "*pj = " << *pj << '\n'; // *pj = 42
      std::cout << "pi.valid? " << static_cast<bool>(pi)
        << '\n'; // pi.valid? false
    } // pj goes out of scope, gets deallocated on heap
      // (destructor is called)
    ```
  ],
)

When interfacing with C code, there may be functions that return pointers.
These must be deallocated manually by calling `free(ptr)`.
Wrapping these pointers in a `std::unique_ptr` ensures that they will be properly discarded.

=== Guidelines for `std::unique_ptr`
- _As a member variable:_ To keep a polymorphic reference instantiated by the class or passed in as `std::unique_ptr` and
  transferring ownership #hinweis[(i. e. a member variable that references a instance of `Cat` or `Dog` in base class `Animal`)]
- _As local variable:_ To implement RAII. Can provide custom deleter function as second template argument
  to type that is called on destruction #hinweis[(i.e. a function that closes a file or a connection)].
- _`std::unique_ptr<T> const p {new T{}};`:_ Const unique pointers cannot transfer ownership, cannot leak.
  But better use `std::make_unique<T>`.

== `std::shared_ptr<T>`
#hinweis[#cppr("memory/shared_ptr")[CPPReference: `std::shared_ptr`]]
#h(1fr) ```cpp #include <memory>``` #v(-0.5em)

#grid(
  [
    `std::unique_ptr` allows _only one_ owner and _cannot_ be copied, but is only returned by value.
    `std::shared_ptr` works more like Java's references: It can be _copied_ and _passed around_.
    The last variable holding the shared pointer going out of scope deletes the object.

    You can create `std::shared_ptr` and associated objects of type `T` using `std::make_shared<T>(...)`.
    It allows all `T`'s public constructor's parameters to be used.
  ],
  [
    ```cpp
    struct Article {
      Article(std::string title,
        std::string content);
      // ...
    };
    // Local variable stored on stack
    Article cppExam{"How to pass?", "You can't"};
    // Pointer to value stored on heap
    std::shared_ptr<Article> abcPtr =
      std::make_shared<Article>("Alphabet", "ABC");
    ```
  ],
)

Use `std::shared_ptr` if you really need...
- _heap-allocated objects_ #hinweis[(i.e. network graphs or trees)]
- to _support run-time polymorphic container contents_
  #hinweis[(i.e. a vector of `Animals` that can contain both `Cat` and `Dog`)],
- class members that _cannot_ be _passed as reference_ #hinweis[(i.e. members marked `static`)]
- factory functions returning a `std::shared_pointer` for heap allocated objects.

But first check if _alternatives_ are viable:
- (`const`) references as parameters or class members
- Regular member objects or containers with regular class instances.

Copying/destroying a `std::shared_ptr` is slow due to the atomic reference counter.

When the _last_ `std::shared_ptr` handle is _destroyed_ #hinweis[(by leaving the scope)] or is
_manually reset_ #hinweis[(by explicitly calling `reset()`)] the allocated object will be _deleted_.

#grid(
  columns: (1fr, 1.5fr),
  [
    ```cpp
    struct Light {
      Light() {
        std::cout << "Turn on\n";
      }
      ~Light() {
        std::cout << "Turn off\n";
      }
    };
    ```
  ],
  [
    ```cpp
    auto main() -> int {
      auto light = std::make_shared<Light>(); // Turn on
      auto same = light; // 2 references
      auto last = same;  // 3 references
      light.reset();     // 2 references
      same.reset();      // 1 reference
      last.reset();      // 0 references - Turn off
    }
    ```
  ],
)

This is problematic with _cyclic_ structures: When two objects reference each other, but there are no outside references,
the objects cannot be reached anymore and should be deleted. They cannot be deleted however, because of their mutual references.
A _memory leak_ is created.

#grid(
  columns: (1fr, 1.23fr),
  [
    ```cpp
    using P = std::shared_ptr<struct HalfElf>;
    struct HalfElf {
      explicit HalfElf(std::string name)
        : name{name}{}
      std::string name{};
      std::vector<P> siblings{};
    };
    ```
  ],
  [
    ```cpp
    void middleEarth() {
      auto elrond = std::make_shared<HalfElf>("Elrond");
      auto elros = std::make_shared<HalfElf>("Elros");
      elrond->siblings.push_back(elros);
      elros->siblings.push_back(elrond);
    } // Both object should be deleted here, but they
      // can't because they reference each other
    ```
  ],
)

=== Example
If you really need to keep something explicitly on the heap, use a factory.

#grid(
  columns: (2.3fr, 1fr),
  align: horizon,
  [
    ```cpp
    struct A {
      A(int a, std::string b, char c);
    };

    auto createA() -> std::shared_ptr<A> { // Factory function
      return std::make_shared<A>(5, "hi", 'a');
    }

    auto main() -> int {
      auto anA = createA();
      auto sameA = anA; // second pointer to the same object
      A copyA{*sameA}; // copy ctor
      auto another = std::make_shared<A>(copyA); // copy ctor on heap
    }
    ```
  ],
  image("img/cpl_15.png"),
)

=== Class Hierarchies
Use `std::ostream`, just as an example for a base class, and a very primitive factory function that creates an `ostream`
which either prints to the console or to a file. The concrete type is required as template argument for `make_shared`.

```cpp
auto os_factory(bool file) -> std::shared_ptr<std::ostream> {
  using namespace std;
  if (file) {
    return make_shared<ofstream>("hello.txt");
  } else {
    return make_shared<ostringstream>();
  }
}

auto main() -> int {
  auto consoleout = os_factory(false);
  if (consoleout) {
    (*consoleout) << "hello world\n"; // prints to console
  }
  auto fileout = os_factory(true);
  if (fileout) {
    (*fileout) << "Hello, world!\n";  // prints into file
  }
}
```

=== Things to keep in mind when working with `shared_ptr`
- When the _last_ `shared_ptr` handle is _destroyed,_ the allocated object will be _deleted._
- If subclasses are stored in variables of type `std::shared_ptr<Base>` but are always created by a `std::make_shared<Sub>()`,
  the destructor no longer needs to be virtual, meaning you don't need to overload the destructor of the base class.
- `std::shared_pointer` can create cycles that _cannot be cleared_, causing _memory leaks_.
  Can be addressed with `std::weak_pointer`

#pagebreak()

== `std::weak_ptr`
#hinweis[#cppr("memory/weak_ptr")[CPPReference: `std::weak_ptr`]]\
We create a class `Person`. Each `Person` knows its `mother`, `father` and `child`. Each person can be married.
This results in _cycles_ -- you cannot use values to store them, as that would mean copying `Person`s resulting
in an infinite recursion. This task has to be solved with pointers.

To break the cycles, we can use _`std::weak_ptr`_. They do not allow direct access to the object and do not count as
reference when determining if an object should be deleted. To acquire the object, _`lock()`_ can be called on the `weak_ptr`
to turn it into a `std::shared_ptr` temporarily. _`reset()`_ releases the ownership of the object, the object is deleted.

#grid(
  columns: (2fr, 1fr),
  [
    ```cpp
    struct Person { // Simplified Person class for demonstration
      std::shared_ptr<Person> child;
      std::weak_ptr<Person> parent;
    };
    auto main() -> int {
      auto anakin = std::make_shared<Person>();
      auto luke = std::make_shared<Person>();
      anakin->child = luke;
      luke->parent = anakin;
      // removes the ref in 'anakin' and the heap object is deleted
      anakin.reset();
    } // Because 'luke' has only a weak reference to 'anakin',
      // 'luke' is now deleted as well
    ```
  ],
  [
    #v(-1em)
    #image("img/cpl_17.png", width: 70%)
  ],
)

==== Checking liveness of locked pointer
A `weak_ptr` does not know whether the pointee is _still alive_.
`std::weak_ptr::lock()` returns a `std::shared_ptr` that either points to the alive pointee or is empty.
Before accessing, verify that the pointer is _valid._

#grid(
  columns: (2fr, 1fr),
  [
    ```cpp
    auto Person::acquireMoney() const -> void {
      auto locked = parent.lock();
      if (locked) { // object is alive (>= 1 shared references)
        begForMoney(*locked);
      } else { // object is dead (0 shared references)
        goToTheBank();
      } }
    ```
  ],
  image("img/cpl_18.png", width: 90%),
)

== Self-referencing Pointers: `_from_this()`
#grid(
  [
    #hinweis[#cppr("memory/enable_shared_from_this")[CPPReference: `std::enable_shared_from_this`]]\
    It would be nice if parents could spawn their own children #hinweis[(no, not like that (unfortunately))].\
    We need a `std::weak_ptr`/`std::shared_ptr<Person>` to the `this`-object to assign `child.parent`.
    By _publicly deriving_ from _`std::enable_shared_from_this<T>`_, the member functions _`weak_from_this()`_ and
    _`shared_from_this()`_ are provided. The returned object internally stores a `weak_ptr` to the `this` object.

    #hinweis[
      _Caution!_ When using `class`, make sure to publicly inherit, otherwise you will run into memory errors like
      "`segfault: bad_weak_ptr`"
    ]
  ],
  [
    ```cpp
    struct Person
      : std::enable_shared_from_this<Person> {
      std::shared_ptr<Person> child;
      std::weak_ptr<Person> parent;
    }

    auto spawn() -> std::shared_ptr {
      child = std::make_shared<Person>();
      child->parent = weak_from_this();
      return child;
    }
    class Car
      : public std::enable_shared_from_this<Car> {}
    ```
  ],
)

=== Having multiple children
#grid(
  columns: (0.8fr, 1fr),
  [
    Smart pointers can be stored in standard containers, like `std::vector`.
    An alias for a `Person` pointer that can be used in the type itself requires a _forward declaration_.
  ],
  [
    ```cpp
    using person_ptr = std::shared_ptr<struct Person>;
    struct Person {
      private:
      std::vector<PersonPtr> children;
      std::weak_ptr<Person> mother;
      std::weak_ptr<Person> father;
    };
    ```
  ],
)
