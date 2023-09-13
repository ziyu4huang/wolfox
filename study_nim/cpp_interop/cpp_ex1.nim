{.emit: """
#include <iostream>

class MyClass {
public:
  MyClass() {
    std::cout << "MyClass constructor called" << std::endl;
  }

  void myFunction(int x) {
    std::cout << "myFunction called with " << x << std::endl;
  }
};
""".}

type
  MyClass {.importcpp: "MyClass".} = object

proc constructor(): ptr MyClass {.importcpp: "new MyClass(@)".}
proc myFunction(this: ptr MyClass, x: cint) {.importcpp: "#.myFunction(@)".}

# Usage
let obj = constructor()
obj.myFunction(42)

