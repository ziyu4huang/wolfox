# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.


{.compile: "example.cpp".}
{.passC: "-std=c++11".}
{.passL: "-lstdc++".}

proc callFromNim() {.importc, cdecl.}




when isMainModule:
  echo("Hello, World!")
  # Call the C++ function
  callFromNim()
