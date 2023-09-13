import dynlib

# Define the type of the function to be imported from the shared library
type
  MyFunctionType = proc (): void {.cdecl.}

# Load the shared library
let lib = loadLib("./libmy_shared_library.so")

# Check if the library was loaded successfully
if lib == nil:
  echo "Failed to load the shared library."
else:
  echo "Successfully loaded the shared library."

  # Load the function from the shared library
  let myFunction = cast[MyFunctionType](lib.symAddr("myFunction"))

  # Check if the function was loaded successfully
  if myFunction == nil:
    echo "Failed to load the function from the shared library."
  else:
    echo "Successfully loaded the function from the shared library."

    # Call the function
    myFunction()

  # Unload the shared library
  unloadLib(lib)
  echo "Successfully unloaded the shared library."

