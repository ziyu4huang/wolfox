
{.emit: """/*TYPESECTION*/
struct CppStruct {
  CppStruct(int x, char* y): x(x), y(y){}
  int x;
  char* y;
};
""".}
type
  CppStruct {.importcpp, inheritable.} = object

proc makeCppStruct(a: cint = 5, b:cstring = "hello"): CppStruct {.importcpp: "CppStruct(@)", constructor.}

(proc (s: CppStruct) = echo "hello")(makeCppStruct())
# If one removes a default value from the constructor and passes it to the call explicitly, the C++ compiler will complain.

