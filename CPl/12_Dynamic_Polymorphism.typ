#import "../template_zusammenf.typ": *
#import "00_CPPR_Settings.typ": cppr

= Dynamic Polymorphism <dynamic-polymorphism>
C++ default mechanisms support _value classes_ #hinweis[(no reference members in the class)] with _copying/moving_ and
_deterministic lifetime_. Operator and function overloading and templates allow _polymorphic behavior at compile-time_.\
This is often _more efficient_ and avoids indirection and overhead at run-time.

_Dynamic polymorphism_ needs _object references_ or _smart pointers_ to work. This results in _syntax overhead_.\
The base interface must be a _good abstraction_ and copying carries the danger of _slicing_
#hinweis[(Object is only copied partially)].

Implementing _design patterns_ for run-time flexibility: The client code uses an abstract interface and gets
parameterized / called with reference to a concrete instance #hinweis[(see image about the `std::ios` hierarchy below)].

But: if _run-time flexibility is not required_, templates can implement many patterns with compile-time flexibility as well.

=== Reasons for using Inheritance
- _Mix-in of functionality from empty base class:_ Often with own class as template argument, known as _CRTP_
  #hinweis[(Curiously Recurring Template Pattern)] i.e. `boost::equality_comparable<T>`.
  No inherited data members, only added functionality #hinweis[(Interface-like, similar to C\# constraints)]\
  #no-ligature[```cpp struct Date : boost::equality_comparable<Date> { /* ... */ } // Implements '==' for Date class```]

- _Adapting concrete classes:_ No additional own data members, convenient for inheriting member functions and constructors
  #v(-0.5em)
  ```cpp
  template<typename T, typename Compare>                   // Easy implementation of ctors and
  struct indexableSet : std::set<T, Compare> { /* ... */ } // members of std::set in own class
  ```

== Inheritance for Dynamic Binding
#grid(
  [
    Implementing a _design pattern_ with dynamic dispatch. _Provide_ a common _interface_ for a variety of dynamically
    changing or different _implementations_, exchange _functionality_ at run-time.
    #hinweis[(i.e. a `display()` method for Buttons, Text boxes etc. in a GUI library)]

    Base class/interface class provides a _common abstraction_ that is used by clients.

    For the inheritance Syntax, see @inheritance.
  ],
  image("img/cpl_16.png"),
)

With interface inheritance, the base class must be `public`. Private inheritance is possible, but only useful for
mix-in classes that provide a `friend` function. _Most often, private base classes with members are wrong design!_

=== Initializing multiple base classes
#grid(
  [
    Base constructors can be _explicitly called_ in the member initializer list.
    If a constructor of a base class is omitted, its default constructor is called.
    The _base class constructor_ should be _placed before the initialization_ of subclass members.
    The compiler enforces this rule, even though you can put the list of initializers in the wrong order.
  ],
  [
    ```cpp
    class DerivedWithCtor
      : public Base1, public Base2
    {
      int myvar;
    public:
      DerivedWithCtor(int i, int j)
        : Base1{i}, Base2{j}, myvar{j} {}
    };
    ```
  ],
)

#pagebreak()

== Shadowing member functions
If a function is reimplemented in a derived class, it _shadows_ its counterpart in the base class.
However, if _accessed through a declared base object_, the shadowing function is ignored.
#grid(
  [
    ```cpp
    struct Base {
      auto sayHello() const -> void {
        std::cout << "Hi, I'm Base\n";
      }
    };

    struct Derived : Base {
      auto sayHello() const -> void {
        std::cout << "Hi, I'm Derived\n";
      }
    };
    ```
  ],
  [
    ```cpp
    auto greet(Base const & base) -> void {
      base.sayHello();
    }
    auto greet_d(Derived const & derived) -> void {
      derived.sayHello();
    }

    auto main() -> int {
      Derived derived{};
      greet(derived);   // "Hi, I'm Base"
      greet_d(derived); // "Hi, I'm Derived"
    }
    ```
  ],
)

== Virtual Member functions
Dynamic polymorphism requires base classes with _`virtual`_ member functions.
`virtual` is _inherited_ and _can be omitted in the derived class_.
It is possible to mark an overriding function with _`override`_.
This does the same thing as `virtual`, except it _throws an error_ if the function does not exist in the base class.

To override a virtual function in the base class, the signature must be the same.
_Constness_ of the member function is _part of the signature_.

#grid(
  [
    ```cpp
    struct Base {
      virtual auto sayHello() const -> void {
        std::cout << "Hi, I'm Base\n";
      }
    };
    struct Derived : Base {
      // auto sayHello() const -> void override {
      virtual auto sayHello() const -> void {
        std::cout << "Hi, I'm Derived\n";
      }
    };
    ```
  ],
  [
    ```cpp
    auto greet(Base const & base) -> void {
      base.sayHello();
    }

    auto main() -> int {
      Derived derived{};
      greet(derived); // "Hi, I'm Derived"
    }
    ```
  ],
)

=== Calling `virtual` Member Functions
```cpp
struct Base { virtual auto sayHello() const -> void; };
struct Derived : Base { auto sayHello() const -> void; };
```
#v(0.5em)
#grid(
  row-gutter: 1.5em,
  [
    ==== Value Object
    Class type determines function, regardless of `virtual`. By passing as value, the inherited part gets left off.\
    Just the base part of the object gets copied, see @slicing.

    ```cpp
    auto greet(Base base) -> void {
      // always calls Base::sayHello
      base.sayHello();
    }
    ```
  ],
  [
    ==== Reference
    Virtual member of derived class called through base class reference.
    By passing as reference, all #hinweis[(child)] members are still there. The overridden methods can and will be used.

    ```cpp
    auto greet(Base const & base) -> void {
      // calls sayHello() of the actual type
      base.sayHello();
    }
    ```
  ],
  [
    ==== Smart Pointer
    Virtual member of derived class called through smart pointer to base class.
    ```cpp
    auto greet(std::unique_ptr<Base> base) {
      // calls sayHello() of the actual Type
      base->sayHello();
    }
    ```
  ],
  [
    ==== Dumb Pointer
    Virtual member of derived class called through base class pointer.
    ```cpp
    auto greet(Base const * base) -> void {
      // calls sayHello() of the actual type
      base->sayHello();
    }
    ```
  ],
)

=== Abstract Base Classes: Pure Virtual
#grid(
  [
    There are _no interfaces_ in C++. A pure virtual member function makes a class _abstract_.
    To mark a virtual member function as pure virtual, it has a _zero assigned_ after its signature.
    _No implementation_ needs to be provided for that function. Abstract classes cannot be instantiated.
  ],
  [
    ```cpp
    struct AbstractBase {
      // Pure virtual member function
      virtual void doitnow() = 0;
    };
    // cannot be instantiated:
    AbstractBase create() {
      return AbstractBase{}; // does not work
    }
    ```
  ],
)

== Destructors
#grid(
  [
    Classes with virtual members require a _virtual Destructor_.
    Otherwise when allocated on the heap with `std::make_unique<Derived>` and assigned to a `std::unique_ptr<Base>`,
    only the destructor of Base is called.

    *Output non-virtual:*\
    `put into trash` ```cpp // ~Fuel()```\
    ```cpp // ~Plutonium() is never called! Error prone!```

    *Output virtual:*\
    `store` ```cpp          // ~Plutonium()``` \
    `put into trash` ```cpp // ~Fuel()```

    _Alternative:_ `std::shared_ptr` can memorize the actual type and knows which destructor to call.
    Instead of using the keyword `virtual` on the base destructor, the call in the main function can be replaced with\
    ```cpp ... = std::make_shared<Plutonium>();```\
    This way, both destructors are called.
  ],
  [
    ```cpp
    struct Fuel {
      virtual auto burn() -> void = 0;
      // Option 1: non-virtual destructor (bad!)
      ~Fuel() { std::cout << "put into trash\n"; }
      // Option 2: virtual destructor (good)
      virtual ~Fuel() {
        std::cout << "put into trash\n";
      }
    };

    struct Plutonium : Fuel {
      auto burn() -> void {
        std::cout << "split core\n";
      }
      ~Plutonium() { std::cout << "store\n"; }
    };

    auto main() -> int {
      std::unique_ptr<Fuel> surprise =
        std::make_unique<Plutonium>();
      // Alternative:
      std::shared_ptr<Fuel> surprise =
        std::make_shared<Plutonium>();
    }
    ```
  ],
)

== Problems with Inheritance
Inheritance can be bad, because it _introduces a very strong coupling_ between subclasses and their base class
-- the base class can hardly be changed.
An API of base class must fit for all subclasses, which is _very hard to get right_.

Conceptual hierarchies are often used as examples but are usually _very bad software design_.

=== Inheritance and Pass-by-Value <slicing>
Assigning or passing by value a derived class value to a base class variable / parameter incurs _object slicing_.
Only base class member variables are transferred.

#grid(
  [
    ```cpp
    struct Base {
      int member;
      explicit Base(int init) : member{init}{};
      virtual ~Base() = default;
      auto print(std::ostream &out) -> void const;
      virtual auto modify() -> void { member++; }
    };

    struct Derived : Base {
      using Base::Base; // inherit ctors
      auto modify() -> void { member += 2; }
    };
    ```
  ],
  [
    ```cpp
    auto modifyAndPrint(Base base) -> void {
      base.modify();
      base.print(std::cout);
    }
    auto main() -> int {
      Derived derived{25};
      modifyAndPrint(derived);
    }
    // Output: 26
    // Not 27, as the Derived part is cut off in
    // "modifyAndPrint()" and Derived::modify()
    // gets never called
    ```
  ],
)

=== Problems with Member Hiding
Member functions in derived classes _hide_ base class member with the _same name_, even if different parameters are used.\
*Example:* ```cpp Derived::modify(int)``` hides ```cpp Base::modify()```.
By `"using"` the base class member the hidden name(s) become visible: ```cpp using Base::modify;```

#grid(
  columns: (1fr, 1.2fr, 0.8fr),
  [
    ```cpp
    struct Base {
      int member{};
      explicit Base(int initial);
      virtual ~Base = default;
      virtual void modify();
    }
    ```
  ],
  [
    ```cpp
    struct Derived : Base {
      using Base::Base;
      using Base::modify; // access Base
      void modify(int value) {
        member += value;
      } // hides base function
    }   // without using Base::modify
    ```
  ],
  [
    ```cpp
    auto main() -> int {
      Derived derived{25};
      derived.modify();
    }
    ```
  ],
)

=== Assignment through References
Assignment cannot be implemented properly for _virtual inheritance structures_.
When assigning to a reference variable of the base class, the base part of a derived object gets _overwritten._

#grid(
  [
    ```cpp
    struct Animal {
      virtual classIsNowAbstract() = 0;
    }
    struct Cat : Animal { /*...*/ }
    ```
  ],
  [
    ```cpp
    Cat elvis{};

    // only the 'animal' part gets copied
    Animal & animal = elvis;
    ```
  ],
)

To prevent object slicing in the base class, you can declare the copy-operations as deleted.\

==== Problematic Example
#small[
  #grid(
    [
      ```cpp
      using Page = int; // shortcut for demo purposes
      struct Book {
          explicit Book(std::vector<Page> p) : pages{p} {};
          virtual auto currentPage() const -> Page = 0;
          auto lastPage() const -> Page {
              return pages.size();
          }
      protected:
          std::vector<Page> pages;
      };

      struct Ebook : Book {
          using Book::Book;
          auto currentPage() const -> Page {
              return currentPageNumber;
          }
          auto openPage(size_t page) -> void {
              currentPageNumber = page;
          }
      private:
          size_t currentPageNumber{1};
      };

      auto readPage(Page page) {
         std::cout << "Page read: " << page << '\n';
      }
      auto createPages(size_t pageCount) {
         return std::vector<Page>(pageCount);
      }
      ```
    ],
    [
      ```cpp
      auto main() -> int {
        Ebook dune{createPages(869)};
        Ebook lordOfTheRings{createPages(1137)};
        lordOfTheRings.openPage(1000);
        Book &bookRef = lordOfTheRings;
        std::cout << "LotR pages to read: "
                  << bookRef.lastPage() << '\n';
        readPage(bookRef.currentPage());
        bookRef = dune; // only base part copied over!
        std::cout << "Dune pages to read: "
                  << bookRef.lastPage() << '\n';
        readPage(bookRef.currentPage());
      }
      ```
      *Output*
      ```
      LotR pages to read: 1137
      Page read: 1000
      Dune pages to read: 869
      Page read: 1000
      ```
      Only the _`Book` part_ of `dune` got _copied_ into `bookRef`, the _`Ebook` part_ _remained values_ from `lordOfTheRings`.
      `dune` now has an _invalid page number_. This can be prevented by _deleting copy operations_ in `book`:
      ```cpp
      struct Book {
        auto operator=(Book const &other) -> Book& = delete;
        Book(Book& const other) = delete;
      }
      ```
    ],
  )
]

== Guidelines
- You should only apply inheritance and virtual member functions _if you know what you do_
- Do _not_ create classes with _virtual_ members _by default_
- If you design base classes with polymorphic behavior, _understand the common abstraction_ that they represent
  #hinweis[(Do not provide too many members or too few, extract a base from existing classes after you see the
  commonality arise)]
- Follow the _Liskov Substitution Principle_ #hinweis[(If it looks like a duck and quacks like a duck but needs batteries,
  you probably have the wrong abstraction)]. The Base class states must be valid for subclasses, do not break invariants
  of the base class, don't change semantics unexpectedly.


=== Polymorphism Example
#small[
  #grid(
    [
      ```cpp
      struct Animal {
        auto makeSound() -> void { cout << "---, "; }
        virtual auto move() -> void { cout << "---, "; }
        Animal() { cout << "animal born, "; }
        ~Animal() { cout << "animal died\n"; }
      };

      struct Bird : Animal {
        virtual auto makeSound() -> void { cout<< "chirp, "; }
        auto move() -> void { cout << "fly, "; }
        Bird() { cout << "bird hatched, "; }
        ~Bird() { cout << "bird crashed, "; }
      };

      struct Hummingbird : Bird {
        auto makeSound() -> void { cout << "peep, "; }
        virtual auto move() -> void { cout << "hum, "; }
        Hummingbird() { cout << "hummingbird hatched, "; }
        ~Hummingbird() { cout << "hummingbird died, "; }
      };
      // Hints:
      // Constructors of base class get called first.
      // animal::makeSound is not virtual, no overriding.
      // Destructors of subclass get called first.
      // No destruction of 'animal', it's a reference
      ```
    ],
    [
      ```cpp
      auto main() -> int {
        cout << "\n(a)---------------\n";
          Hummingbird hummingbird;
          Bird bird = hummingbird; //New object with copy ctor
          Animal & animal = hummingbird; // Ref to animal part
        cout << "\n(b)---------------\n";
          hummingbird.makeSound();
          bird.makeSound();
          animal.makeSound(); // No overriding here
        cout << "\n(c)---------------\n";
          hummingbird.move();
          bird.move();
          animal.move();
        cout << "\n(d)---------------\n";
      }
      ```
      *Output:*
      ```
      (a)---------------
      animal born, bird hatched, hummingbird hatched,
      (b)---------------
      peep, chirp, ---,
      (c)---------------
      hum, fly, hum,
      (d)---------------
      bird crashed, animal died
      hummingbird died, bird crashed, animal died
      ```

    ],
  )
]
