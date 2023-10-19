{.emit: """
int square(int x) {
  return x * x;
}
""".}

proc square(x: cint): cint {.importc, cdecl.}

echo square(5)  # Output should be 25


