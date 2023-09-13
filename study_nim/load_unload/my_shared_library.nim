# Import the dynamic library loading module
import dynlib

# Define the type of the function to be imported from the main program
type
  FunctionToBeCalledFromLibrary = proc (x: int): int {.cdecl.}

# Load the function from the main program
let functionToBeCalledFromLibrary = cast[FunctionToBeCalledFromLibrary](loadLib().symAddr("functionToBeCalledFromLibrary"))

# Define a function to be exported from this shared library
proc functionFromLibrary() {.cdecl, exportc, dynlib.} =
  echo "start call functionToBeCalledFromLibrary"
  if functionToBeCalledFromLibrary == nil:
    echo "fail load sym functionToBeCalledFromLibrary"
  else:
    let result = functionToBeCalledFromLibrary(21)
    echo "Result from main program function: ", result

# Export the function
export functionFromLibrary

