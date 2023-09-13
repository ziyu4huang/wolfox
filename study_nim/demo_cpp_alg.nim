# Compile with C++ backend
{.compile: "cpp".}

# Include C++ <algorithm> header
{.header: "<algorithm>".}

# Define C++ array type
type
  CppArray {.importcpp: "int[5]", header: "<array>".} = object

# Import std::sort function from C++ STL
proc cppSort {.importcpp: "std::sort(@, @ + 5)", header: "<algorithm>".} (x: ptr CppArray)

# Nim main procedure
proc main() =
  var x: CppArray
  # Populate the array 'x'
  x[0] = 5
  x[1] = 1
  x[2] = 9
  x[3] = 3
  x[4] = 7

  echo "Before sorting: ", x

  # Sort the array using std::sort
  cppSort(addr x)

  echo "After sorting: ", x

# Run the main procedure
main()

