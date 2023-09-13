# Import the dynamic library loading module
import dynlib

# Define a function to be called from the shared library
proc functionToBeCalledFromLibrary(x: int): int {.cdecl, exportc, dynlib.} =
  return x * 2

export functionToBeCalledFromLibrary

echo "I cal my self function: " & $functionToBeCalledFromLibrary(4)
echo "try to get sym of function"

# below is not work
#let sym = checkedSymAddr(nil, "functionFromLibrary")
#let sym_addr = cast[ptr int]((addr(sym))
#echo "it is " & $sym_addr


# Load the shared library
let lib = loadLib("./libmy_shared_library.so")

echo "finish load library"


if lib == nil:
  echo "fail to load lib"
else:
  echo "sucess load lib"


# Define the type of the function to be imported from the shared library
type
  FunctionFromLibrary = proc (): void {.cdecl.}

# Load the function from the shared library
let functionFromLibrary = cast[FunctionFromLibrary](lib.checkedSymAddr("functionFromLibrary"))

if functionFromLibrary == nil:
  echo "fail to load sym"
else:
  echo "success load sym"
  # Call the function from the shared library
  functionFromLibrary()

# Unload the shared library
echo "start unload "
unloadLib(lib)

