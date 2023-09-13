# Define a function to be exported from this shared library
proc myFunction() {.cdecl, exportc, dynlib.} =
  echo "Hello from the shared library!"

# Export the function
export myFunction

